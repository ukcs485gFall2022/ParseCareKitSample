//
//  InsightsViewController.swift
//  OCKSample
//
//  Created by Corey Baker on 12/5/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

/*
 You should notice this looks like CareView and MyContactView combined,
 but only shows charts instead.
*/

import UIKit
import CareKitStore
import CareKitUI
import CareKit
import ParseSwift
import ParseCareKit
import os.log

class InsightsViewController: OCKListViewController {

    /// The manager of the `Store` from which the `Contact` data is fetched.
    public let storeManager: OCKSynchronizedStoreManager

    /// Initialize using a store manager. All of the contacts in the store manager will be queried and dispalyed.
    ///
    /// - Parameters:
    ///   - storeManager: The store manager owning the store whose contacts should be displayed.
    public init(storeManager: OCKSynchronizedStoreManager) {
        self.storeManager = storeManager
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Insights"

        Task {
            await displayTasks(Date())
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        Task {
            await displayTasks(Date())
        }
    }

    override func appendViewController(_ viewController: UIViewController, animated: Bool) {
        super.appendViewController(viewController, animated: animated)

        // Make sure this contact card matches app style when possible
        if let carekitView = viewController.view as? OCKView {
            carekitView.customStyle = CustomStylerKey.defaultValue
        }
    }

    @MainActor
    func fetchTasks(on date: Date) async -> [OCKAnyTask] {
        /**
         TODO: How would you modify this to fetch all of your tasks?
         Hint - you should look at the same function in CareViewController. If you
         understand queries and filters, this will be straightforward.
         */
        var query = OCKTaskQuery(for: date)
        query.excludesTasksWithNoEvents = true
        do {
            let tasks = try await storeManager.store.fetchAnyTasks(query: query)
            let orderedTasks = TaskID.ordered.compactMap { orderedTaskID in
                tasks.first(where: { $0.id == orderedTaskID }) }
            return orderedTasks
        } catch {
            Logger.insights.error("\(error.localizedDescription, privacy: .public)")
            return []
        }
    }

    /*
     TODO: Plot all of your tasks in this method. Note that you can combine multiple
     tasks into one chart (like the Nausea/Doxlymine chart if they are related.
    */

    func taskViewController(for task: OCKAnyTask,
                            on date: Date) -> [UIViewController]? {
        switch task.id {
        case CheckIn().identifier():


            // dynamic gradient colors
            let checkInGradientStart = TintColorFlipKey.defaultValue
            let checkInGradientEnd = TintColorKey.defaultValue

            /*
             Note that that there's a small bug for the check in graph because
             it averages all of the "Pain + Sleep" hours. This okay for now. If
             you are collecting ResearchKit input that only collects 1 value per
             survey, you won't have this problem.
             */
            let checkInDataSeries = OCKDataSeriesConfiguration(
                taskID: CheckIn().identifier(),
                legendTitle: "Check In",
                gradientStartColor: checkInGradientStart,
                gradientEndColor: checkInGradientEnd,
                markerSize: 10,
                eventAggregator: .aggregatorMean())

            /*
             TODO: CareKit has 3 plotType's: .bar, .scatter, and .line.
             You should have a 3 types in your InsightView meaning you
             should have at least 3 charts. Remember that all of your
             tasks need to be graphed so you may have more. The solution
             for not this should not be to show all 3 plot types for a
             single task. Your code should be flexible enough to determine
             a graph type. Instead, you should look extend OCKTask and OCKAnyTask
             to add a "graph" property similar to "card". This means you probably
             should create a "GraphCard" enum similar to "CareKitCard" and allow
             the user to select the specific graph when adding a new task.
             Hint - you should look at the same function in CareViewController
             to determine how to switch graphs on an enum.
             */
            let insightsCard = OCKCartesianChartViewController(
                plotType: .bar,
                selectedDate: date,
                configurations: [checkInDataSeries],
                storeManager: self.storeManager)

            insightsCard.chartView.headerView.titleLabel.text = "Average Check In's"
            insightsCard.chartView.headerView.detailLabel.text = "This Week"
            insightsCard.chartView.headerView.accessibilityLabel = "Average Check In's, This Week"

            return [insightsCard]

        case TaskID.nausea:
            var cards = [UIViewController]()
            // dynamic gradient colors
            let nauseaGradientStart = TintColorFlipKey.defaultValue
            let nauseaGradientEnd = TintColorKey.defaultValue

            // Create a plot comparing nausea to medication adherence.
            let nauseaDataSeries = OCKDataSeriesConfiguration(
                taskID: TaskID.nausea,
                legendTitle: "Nausea",
                gradientStartColor: nauseaGradientStart,
                gradientEndColor: nauseaGradientEnd,
                markerSize: 10,
                eventAggregator: OCKEventAggregator.countOutcomeValues)

            let doxylamineDataSeries = OCKDataSeriesConfiguration(
                taskID: TaskID.doxylamine,
                legendTitle: "Doxylamine",
                gradientStartColor: .systemGray2,
                gradientEndColor: .systemGray,
                markerSize: 10,
                eventAggregator: OCKEventAggregator.countOutcomeValues)

            let insightsCard = OCKCartesianChartViewController(
                plotType: .bar,
                selectedDate: date,
                configurations: [nauseaDataSeries, doxylamineDataSeries],
                storeManager: self.storeManager)

            insightsCard.chartView.headerView.titleLabel.text = "Nausea & Doxylamine Intake"
            insightsCard.chartView.headerView.detailLabel.text = "This Week"
            insightsCard.chartView.headerView.accessibilityLabel = "Nausea & Doxylamine Intake, This Week"
            cards.append(insightsCard)

            return cards

        default:
            return nil
        }
    }

    @MainActor
    func displayTasks(_ date: Date) async {

        let tasks = await fetchTasks(on: date)
        self.clear() // Clear after pulling tasks from database
        tasks.compactMap {
            let cards = self.taskViewController(for: $0, on: date)
            cards?.forEach {
                if let carekitView = $0.view as? OCKView {
                    carekitView.customStyle = CustomStylerKey.defaultValue
                }
            }
            return cards
        }.forEach { (cards: [UIViewController]) in
            cards.forEach {
                self.appendViewController($0, animated: false)
            }
        }
    }
}
