<!--
Name of your final project
-->
# iQuit
![Swift](https://img.shields.io/badge/swift-5.5-brightgreen.svg) ![Xcode 13.2+](https://img.shields.io/badge/xcode-13.2%2B-blue.svg) ![iOS 15.0+](https://img.shields.io/badge/iOS-15.0%2B-blue.svg) ![watchOS 8.0+](https://img.shields.io/badge/watchOS-8.0%2B-blue.svg) ![CareKit 2.1+](https://img.shields.io/badge/CareKit-2.1%2B-red.svg) ![ci](https://github.com/netreconlab/CareKitSample-ParseCareKit/workflows/ci/badge.svg?branch=main)

## Description
<!--
Give a short description on what your project accomplishes and what tools is uses. Basically, what problems does it solve and why it's different from other apps in the app store.
-->
A smoking cessation application which utilizes SwiftUI, CareKit, and ResearchKit to aid users in their decision to quit smoking. iQuit maintains minimalistic operations in order to keep the complex process of quitting a habit as simple as possible. Features include smoke quantity logging, journal entries, physical checkups, mental checkups, and more. iQuit differentiates itself from other cessation apps by prioritizing ease of use and simplistic tasks rather than requiring users to keep up with another time-consuming obligation. 

### Link to Demo (todo)
<!--
Add the public link to your YouTube or video posted elsewhere.
-->
- A demo of this can be found on [Youtube](https://youtu.be/xNWZvLQc8gI)

### Designed for the following users
<!--
Describe the types of users your app is designed for and who will benefit from your app.
-->
iQuit is designed for users who have decided to stop smoking and who would like to utilize tools which keep track of their progress as well encourage them to reflect on their actions. Users who wish to better their physical/mental health by quitting the habit will benefit from the application whether their motivation is for themselves, their family, or others. 

<!--
In addition, you can drop screenshots directly into your README file to add them to your README. Take these from your presentations.
-->
<img width="299" alt="Screen Shot 2022-05-03 at 7 23 04 PM" src="https://user-images.githubusercontent.com/63267827/166608094-e94fcc1a-b970-4ca4-a32a-a2d46a0ec8e4.png">
<img width="299" alt="Screen Shot 2022-05-03 at 7 23 14 PM" src="https://user-images.githubusercontent.com/63267827/166608107-d5275bef-7cbe-407c-960e-75cc0eccf8d7.png">
<img width="299" alt="Screen Shot 2022-05-03 at 7 23 21 PM" src="https://user-images.githubusercontent.com/63267827/166608112-d9216ae7-c4cb-4782-8503-ad5abca547da.png">
<img width="299" alt="Screen Shot 2022-05-03 at 7 23 25 PM" src="https://user-images.githubusercontent.com/63267827/166608117-594cf136-cb22-4770-a8ee-ecff3fa49a99.png">
<img width="299" alt="Screen Shot 2022-05-03 at 7 23 29 PM" src="https://user-images.githubusercontent.com/63267827/166608120-badc5628-08bd-4c89-9383-19d8156e8901.png">
<img width="299" alt="Screen Shot 2022-05-03 at 7 23 36 PM" src="https://user-images.githubusercontent.com/63267827/166608125-ac5313bd-4bae-4a69-971d-f02ce5645e64.png">
<img width="299" alt="Screen Shot 2022-05-03 at 7 23 40 PM" src="https://user-images.githubusercontent.com/63267827/166608131-d6c49085-45e9-406a-b175-d9c2e1dee2c0.png">
<img width="299" alt="Screen Shot 2022-05-03 at 7 23 43 PM" src="https://user-images.githubusercontent.com/63267827/166608140-fd72da55-2526-4105-b74c-9387769e1d58.png">
<img width="299" alt="Screen Shot 2022-05-03 at 7 23 47 PM" src="https://user-images.githubusercontent.com/63267827/166608145-01582acb-be1c-45bc-bb3f-5f2398d644bd.png">
<img width="299" alt="Screen Shot 2022-05-03 at 7 23 57 PM" src="https://user-images.githubusercontent.com/63267827/166608148-77b75f6e-c76b-48bf-816a-aac53b7b5204.png">
<img width="299" alt="Screen Shot 2022-05-03 at 7 24 03 PM" src="https://user-images.githubusercontent.com/63267827/166608151-d08df242-4127-4860-910b-420156d665d0.png">
<img width="299" alt="Screen Shot 2022-05-03 at 7 24 05 PM" src="https://user-images.githubusercontent.com/63267827/166608153-5ffb8d55-6130-449e-99a4-bf87763d9c3c.png">

<!--
List all of the members who developed the project and
link to each members respective GitHub profile
-->
Developed by: 
- [Chance Bennett](https://github.com/rChanceb) - 'University of Kentucky', 'Computer Science'

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
- Users can navigate directly to lung.org to learn more about why they should quit smoking by clicking the featured content at the top of the main view.
- Users can view a webmd article by tapping the Helpful Links card, and this article will be brought up from within the app.
- Users can conduct a checkin each day, sharing their stress level and desired cigarette limit.
- Users can log their smoking, simply tapping a log button each time they smoke a cigarette
- Users can log their instances of resisting the urge to smoke. With this feature, users are intended to tap the log button any time they feel the urge to smoke but choose to do something else such as chewing gum.
- Users can log their instancs of feeling nauseous as this is a common side effect associated with smoking cessation.
- Users can check their Chantix dosages off a daily list, helping keep track of the twice-per-day schedule the medication often requires.
- Users can track their water intake, being encouraged to drink 25 cups each day
- Users can track their step count, being encouraged to move a decent bit, taking 2000 steps each day
- Users are reminded to call someone once per week, updating the contact with their progress. This helps keep the user accountable.
- Users are reminded to record their progress and attitude towards it in a journal once every two weeks.
- Users are reminded to reward themselves once per month for sticking to the plan
- Users can keep track of all of the above tasks by navigating to the insights tab. This tab includes charts detailing their progress.
- Users can add contacts from their device to the app as well as search through them.
- Users can update their personal information within their profile as well as set a profile picture.
- Users can view their own personal contact card.

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
  - [ ] LabeledValueTaskView (SwiftUI) - typically used with a OCKHealthKitTask
- [x] Add the LinkView (SwiftUI) card to your app
- [x] Replace the current TipView with a class with CustomFeaturedContentView that subclasses OCKFeaturedContentView. This card should have an initializer which takes any link
- [x] Tailor the ResearchKit Onboarding to reflect your application
- [x] Add tailored check-in ResearchKit survey to your app
- [x] Add a new tab called "Insights" to MainTabView
- [x] Replace current ContactView with Searchable contact view
- [x] Change the ProfileView to use a Form view
- [x] Add at least two OCKCarePlan's and tie them to their respective OCKTask's and OCContact's 

## Wishlist features
<!--
Describe at least 3 features you want to add in the future before releasing your app in the app-store
-->
1. Before adding iQuit to the app store, I would like to add the ability for the user to customize the Chantix schedule frequency. The app currently asks users to take their dose twice per day as this is typical, but it would be better if they could customize this to their personal situation.
2. Before adding iQuit to the app store, I would like to add the ability for different users to post to forums from within the app. Sharing experiences with one another would help users feel validated and encourage them to keep working towards their goals.
3. Before adding iQuit to the app store, I would like to add a tab which kept users up to date on the progress of their body's healing. For example, your lungs' ability to clean themselves will have improved significantly by the end of a year without smoking, and letting users know this progress would be encouraging. 

## Challenges faced while developing
<!--
Describe any challenges you faced with learning Swift, your baseline app, or adding features. You can describe how you overcame them.
-->
The primary challenge I faced while adding features to my app was learning where components of the baseline app existed and how they worked. Since so much of the application was built on the foundation of CareKit, ResearchKit, and other packages, it was oftentimes difficult to figure out where exactly a certain aspect of the code existed or how the code was working.

## Setup Your Parse Server

### Heroku
The easiest way to setup your server is using the [one-button-click](https://github.com/netreconlab/parse-hipaa#heroku) deplyment method for [parse-hipaa](https://github.com/netreconlab/parse-hipaa).


## View your data in Parse Dashboard

### Heroku
The easiest way to setup your dashboard is using the [one-button-click](https://github.com/netreconlab/parse-hipaa-dashboard#heroku) deplyment method for [parse-hipaa-dashboard](https://github.com/netreconlab/parse-hipaa-dashboard).
