<!--
App Information
-->
# MindWalk
![Swift](https://img.shields.io/badge/swift-5.5-brightgreen.svg) ![Xcode 13.2+](https://img.shields.io/badge/xcode-13.2%2B-blue.svg) ![iOS 15.0+](https://img.shields.io/badge/iOS-15.0%2B-blue.svg) ![watchOS 8.0+](https://img.shields.io/badge/watchOS-8.0%2B-blue.svg) ![CareKit 2.1+](https://img.shields.io/badge/CareKit-2.1%2B-red.svg) ![ci](https://github.com/netreconlab/CareKitSample-ParseCareKit/workflows/ci/badge.svg?branch=main)

## Description
CareKit is an open-source framework that provides modules and customizations for developers to create apps that are easy, intuitive, and elegant to use. It provides an accessible way for developers to create their own health apps (but are not limited to just that category) by conforming to existing protocols. CareKit consists of three separately importable SPM packages: CareKit, CareKitUI, and CareKitStore. CareKit provides convenient view controllers that request and present data from a store, which are represented in forms of interactive cards that display charts, tasks, contacts, and more. These self-contained view controllers utilize Combine (another framework that handles events over time) to enable synchronization of data between the view and the store. CareKitUI provides the interactive cards mentioned before; these cards are what form a view and can be customized to fit any app specific needs. CareKitStore is used by CareKit to incorporate data to the UI. It allows developers to create methods that read, write, update, and delete data for their own databases if they conform to certain protocol for the store. When importing CareKit, CareKitUI and CareKitStore are imported automatically.

  ![image](https://user-images.githubusercontent.com/74862863/166831335-a1d022cc-bfb6-4861-9899-ff2ad6c5b83d.png)

CareKit is best taken advantage of when integrated with a hospital’s electronic health record (EHR) system. It provides seamless integration with existing patient data on record and on Apple devices (and Bluetooth device) that care providers can utilize by developing around the framework. The sample application currently provides card views that revolve around activities an individual can act on. Aside from user profile which displays basic user information such as log-in username and date of birth, the care view provides the user with daily tasks to be completed and logged that accumulate over time which can be displayed as charts, patterns, or various forms of graphics; while the contact view provides a convenient communication portal to relevant parties –namely care providers involved directly with a patient-- that can be used from within the application without having to navigate to external applications. It also provides navigation and contact information of each contact in the view that were automatically queried in the store –without requiring the patient to manually add them. Despite having such a wide-scale synchronization potential from patient to hospital EHR, the app is currently limited to pages that only display information to the user that can only be checked-off or viewed, and even those are limited to physical exercises. What I intend to do for my application named “Mind Walk” is to extend this further to include mental health.



<!--
Give a short description on what your project accomplishes and what tools is uses. Basically, what problems does it solve and why it's different from other apps in the app store.
-->
MindWalk attempts to combine mental and physical health activities together to promote both. Most applications in the app-store focus on one or the other, and neither tend to focus on the group of population, therapy patients, that this app does. The benefit of this application for those patients is that tasks and activities implemented here tend to promote the progress they have made. One concern among patients, especially those in therapy or psychiatry, is that lack of interaction with care provider may lead to regression of progress over time, and this app attempts to mitigate that by providing appropriate tasks, surveys, and reminders to patients of their activities, in an elegant manner by utilizing CareKit.

An example application of [CareKit](https://github.com/carekit-apple/CareKit)'s OCKSample synchronizing CareKit data to the Cloud via [ParseCareKit](https://github.com/netreconlab/ParseCareKit).

### Demo Video
<!--
Add the public link to your YouTube or video posted elsewhere.
-->
To learn more about this application, watch the video for MindWalk linked below: 
https://youtu.be/R0WdcpcelBQ

### Designed for the following users
<!--
Describe the types of users your app is designed for and who will benefit from your app.
-->

MindWalk is an application that attempts to help patients maintain physical and mental wellbeing. It does so by providing an efficient method of communication and engagement between patients and careproviders by taking advantage of CareKit's integration with hospital and patient data with the goal to modernize care that is provided by them. CareKit allows careproviders to cater to patient needs, and this fork of it attempts to implement tasks, surveys, and activities applicable to patients concerned about their mental and physical wellbeing. Tasks that are performed in the application by patient can be updated and changed by careproviders to appropriately reflect the patient's changing needs, which yields the benefit of the patient eing able to communicate with careproviders easily while careproviders are updated about their patients easily. 


While this application is made with a specific group in mind, tasks pretaining to reminders, physical activities, and more are useful to everyone. Physical and mental activities implemented are beneficial to all.
<!--
In addition, you can drop screenshots directly into your README file to add them to your README. Take these from your presentations.
-->
Here are some images from the final application:

![image](https://user-images.githubusercontent.com/74862863/166826193-15c041dc-288c-4366-9817-d3fe51160960.png)
![image](https://user-images.githubusercontent.com/74862863/166826118-3340003b-266c-4089-8a91-c6c139baefbb.png)
![image](https://user-images.githubusercontent.com/74862863/166826156-3ed31c5c-dbc5-4238-bcc7-2bd9b74a3c1b.png)
![image](https://user-images.githubusercontent.com/74862863/166826177-ce8ff5f2-0846-4637-a7a6-5e8cd79e8b0c.png)


<!--
List all of the members who developed the project and
link to each members respective GitHub profile
-->
Implementation of MindWalk done by me: 
- [Sandesh Gyawali](https://github.com/sandgy) - `Student at University of Kentucky`, `Computer Engineering`
- 
Source code and guidance provided by:
- [Corey Baker](https://github.com/cbaker6) - `Professor at University of Kentucky`, `Computer Science`

ParseCareKit synchronizes the following entities to Parse tables/classes using [Parse-Swift](https://github.com/parse-community/Parse-Swift):

- [x] OCKTask <-> Task
- [x] OCKHealthKitTask <-> HealthKitTask 
- [x] OCKOutcome <-> Outcome
- [x] OCKRevisionRecord.KnowledgeVector <-> Clock
- [x] OCKPatient <-> Patient
- [x] OCKCarePlan <-> CarePlan
- [x] OCKContact <-> Contact

**Use at your own risk. There is no promise that this is HIPAA compliant and we are not responsible for any mishandling of your data**

<!--
What features were added by you, this should be descriptions of features added from the [Code](https://uk.instructure.com/courses/2030626/assignments/11151475) and [Demo](https://uk.instructure.com/courses/2030626/assignments/11151413) parts of the final. Feel free to add any figures that may help describe a feature. Note that there should be information here about how the OCKTask/OCKHealthTask's and OCKCarePlan's you added pertain to your app.
-->
## Contributions/Features
- Synchronizing patient data between app and Parse Dashboard.
- New and different OCKTask, OCKHealthKitTasks, and ResearchKit surveys were implemented, and tasks were conformed to how each functioned.
- Compared to the sample app, additional views were also used to portray cards differently --or in different representations.
- Addition of FeaturedContentView, LinkView, Insights View, ViewModel, and ViewController.
- Changes to onboarding that reflect new sets of permissions required by the application.
- Conforming OCKCarePlans to OCKTasks and OCKContacts.
- Application was customized to implement both physical activities and cognitive activities using various OCKTask with different card views and data representations, OCKHealthTask, and OCKCarePlans
- Attempts to implement a crossword puzzle generator was made, but tossed away due to how different it looked compared to the overall application aesthetic.
- Attempt to incorporate a Reminders tab using RemindersView and RemindersViewController.
- Attempt to implement detailed EvaluationSurvey.


## Final Checklist
<!--
This is from the checkist from the final [Code](https://uk.instructure.com/courses/2030626/assignments/11151475). You should mark completed items with an x and leave non-completed items empty
-->
- [x] Signup/Login screen tailored to app
- [x] Signup/Login with email address
- [x] Custom app logo
- [x] Custom styling
- [x] Add at least **5 new OCKTask/OCKHealthKitTasks** to your app
  - [x] Have a minimum of 7 OCKTask/OCKHealthKitTasks in your app
  - [x] 3/7 of OCKTasks should have different OCKSchedules than what's in the original app
- [x] Use at least 5/7 card below in your app
  - [x] InstructionsTaskView - typically used with a OCKTask
  - [x] SimpleTaskView - typically used with a OCKTask
  - [x] Checklist - typically used with a OCKTask
  - [x] Button Log - typically used with a OCKTask
  - [ ] GridTaskView - typically used with a OCKTask
  - [x] NumericProgressTaskView (SwiftUI) - typically used with a OCKHealthKitTask
  - [x] LabeledValueTaskView (SwiftUI) - typically used with a OCKHealthKitTask
- [x] Add the LinkView (SwiftUI) card to your app
- [x] Replace the current TipView with a class with CustomFeaturedContentView that subclasses OCKFeaturedContentView. This card should have an initializer which takes any link
- [x] Tailor the ResearchKit Onboarding to reflect your application
- [ ] Add tailored check-in ResearchKit survey to your app
- [x] Add a new tab called "Insights" to MainTabView
- [x] Replace current ContactView with Searchable contact view
- [x] Change the ProfileView to use a Form view
- [x] Add at least two OCKCarePlan's and tie them to their respective OCKTask's and OCContact's 

## Wishlist features
<!--
Describe at least 3 features you want to add in the future before releasing your app in the app-store
-->
1. I had worked on a Reminders view, where patients could add and delete reminders from within the app, which was intended to be a feature for the final app, but errors related to data store were not resolved in time to submit as part of the app.

2. Complete the check-in survey to incorporate everything that is currently on the EvaluationSurvey inside Surveys+Checkin.swift file, which was intended to emulate conversation between patient and careproviders that could be iterated weekly or monthly in the app to keep careproviders updated about the patient's wellbeing.

3. Incorporate different forms of surveys that take advantage of grouped-forms, as well as surveys incorporating motion activities, like RangeOfMotion survey implemented currently.

## Challenges faced while developing
<!--
Describe any challenges you faced with learning Swift, your baseline app, or adding features. You can describe how you overcame them.
-->
This class was my first exposure to Swift, so much of the difficulty I faced were related to being new at the language. As for the application, it was overwhelming at first, but Dr. Baker's style of teaching made complex concepts easy to understand. Eventually, towards the end of the semester, I felt fairly comfortable about adding new implementations and features.

## Setup Your Parse Server

### Heroku
The easiest way to setup your server is using the [one-button-click](https://github.com/netreconlab/parse-hipaa#heroku) deplyment method for [parse-hipaa](https://github.com/netreconlab/parse-hipaa).


## View your data in Parse Dashboard

### Heroku
The easiest way to setup your dashboard is using the [one-button-click](https://github.com/netreconlab/parse-hipaa-dashboard#heroku) deplyment method for [parse-hipaa-dashboard](https://github.com/netreconlab/parse-hipaa-dashboard).

