<!--
Make Me Fit
-->
# MakeMeFit
![Swift](https://img.shields.io/badge/swift-5.5-brightgreen.svg) ![Xcode 13.2+](https://img.shields.io/badge/xcode-13.2%2B-blue.svg) ![iOS 15.0+](https://img.shields.io/badge/iOS-15.0%2B-blue.svg) ![watchOS 8.0+](https://img.shields.io/badge/watchOS-8.0%2B-blue.svg) ![CareKit 2.1+](https://img.shields.io/badge/CareKit-2.1%2B-red.svg) ![ci](https://github.com/netreconlab/CareKitSample-ParseCareKit/workflows/ci/badge.svg?branch=main)

## Description
<!--
MakeMeFit is a strength training app with the goal of making a beginners' path to becoming strong as easy as it can be. With the help of CareKit and ResearchKit, it is able to give detailed descriptions about exercises users should incorporate into their workout routine and helps plan their days out for them. Unique Careplans separate grouping of exercises into Legs, Chest and back, and Arms focused muscle groups. MakeMeFit also offers easy tracking and analysis of everyday progress.
-->
An example application of [CareKit](https://github.com/carekit-apple/CareKit)'s OCKSample synchronizing CareKit data to the Cloud via [ParseCareKit](https://github.com/netreconlab/ParseCareKit).

### Demo Video
<!--
Add the public link to your YouTube or video posted elsewhere.
-->
To learn more about this application, watch the video below:

<a href="http://www.youtube.com/watch?v=nJI_YXdpuME
" target="_blank"><img src="https://i9.ytimg.com/vi_webp/nJI_YXdpuME/mqdefault.webp?sqp=COCsyJMG&rs=AOn4CLCLnc1_gyCZyMLnqkdgNx33Lo7J3Q"
alt="Sample demo video" width="240" height="180" border="10" /></a>

### Designed for the following users
<!--
Describe the types of users your app is designed for and who will benefit from your app.
-->
Anyone looking to get into strength training as a beginner without much knowledge. It can be used to keep users on track as they start their journey. Not intended for the use of anyone under the age of 18.
<!--
In addition, you can drop screenshots directly into your README file to add them to your README. Take these from your presentations.
-->
<img width="444" alt="login_screen" src="https://user-images.githubusercontent.com/98491405/166628030-65261629-8d2c-4fe3-b1f2-4306260e1a5a.png">
<img width="444" alt="maintab" src="https://user-images.githubusercontent.com/98491405/166628054-3ead9cf7-4e4f-44f7-b8ea-5fd0b3864a9c.png">
<img width="444" alt="contactview" src="https://user-images.githubusercontent.com/98491405/166628072-b17d8fa4-7d49-498d-a716-adf339502a00.png">
<img width="444" alt="profileview" src="https://user-images.githubusercontent.com/98491405/166628076-ae44770b-269b-40d2-8b68-0099478cf2b1.png">
<img width="444" alt="contact_card" src="https://user-images.githubusercontent.com/98491405/166628081-44e19623-e633-4ec2-a1ad-d111519bcdda.png">
<img width="444" alt="tasks" src="https://user-images.githubusercontent.com/98491405/166628134-89af9edd-47e4-4552-b700-faeb71c45ade.png">
<img width="444" alt="insights" src="https://user-images.githubusercontent.com/98491405/166628145-520a0bcf-55de-4c33-a864-e0fb0771f87f.png">

<!--
List all of the members who developed the project and
link to each members respective GitHub profile
-->
Developed by: 
- [Corey Baker](https://github.com/cbaker6) - `STUDENTS_UNIVERSITY`, `MAJOR`
- [Kyle Heckler](https://github.com/KyleHeckler) 

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
There are 3 new OCKCarePlans detailing arm day, leg day, and chest day. The corresponding OCKTasks added for each of these days represent different exercises for each muscle group. An OCKHealthTask has been added to track the user's heartrate throughtout the day, as well as a step tracker. OCKSurveys give the user the ability to report their soreness and their weight to keep track of over time, although the graphs do not reflect weight vs time. There are also links to an article for progress and a YouTube video detailing good form. Contacts are now revitalized and give the user the ability to search for the doctor or specialist that they desire. With the new Insights tab, users can track their progress visually with graphs representing their usage of the app as well as their daily hydration. The Profiling tab has seen an improvement with more information for the user to input to aide in connectivity between them and their specialists through the app.

## Final Checklist
<!--
This is from the checkist from the final [Code](https://uk.instructure.com/courses/2030626/assignments/11151475). You should mark completed items with an x and leave non-completed items empty
-->
- [ X] Signup/Login screen tailored to app
- [ X] Signup/Login with email address
- [ X] Custom app logo
- [ X] Custom styling
- [ X] Add at least **5 new OCKTask/OCKHealthKitTasks** to your app
  - [X ] Have a minimum of 7 OCKTask/OCKHealthKitTasks in your app
  - [ X] 3/7 of OCKTasks should have different OCKSchedules than what's in the original app
- [ X] Use at least 5/7 card below in your app
  - [ X] InstructionsTaskView - typically used with a OCKTask
  - [ ] SimpleTaskView - typically used with a OCKTask
  - [ X] Checklist - typically used with a OCKTask
  - [X ] Button Log - typically used with a OCKTask
  - [ ] GridTaskView - typically used with a OCKTask
  - [ X] NumericProgressTaskView (SwiftUI) - typically used with a OCKHealthKitTask
  - [ X] LabeledValueTaskView (SwiftUI) - typically used with a OCKHealthKitTask
- [ X] Add the LinkView (SwiftUI) card to your app
- [ X] Replace the current TipView with a class with CustomFeaturedContentView that subclasses OCKFeaturedContentView. This card should have an initializer which takes any link
- [ X] Tailor the ResearchKit Onboarding to reflect your application
- [ X] Add tailored check-in ResearchKit survey to your app
- [X ] Add a new tab called "Insights" to MainTabView
- [X ] Replace current ContactView with Searchable contact view
- [X ] Change the ProfileView to use a Form view
- [ X] Add at least two OCKCarePlan's and tie them to their respective OCKTask's and OCContact's 

## Wishlist features
<!--
Describe at least 3 features you want to add in the future before releasing your app in the app-store
-->
1. More detailed insights page reflecting weight gain / loss. This could include body fat percentage data as well as maximum weights lifted at the gym.
2. Dieting procedures that include more links to eating healthier and tracking calorie intake for a comparison against calories burned using heartrate and steps data.
3. Connectivity among other patients or users to form groups and plan workout schedules together. Group planning could also lead to different exercises like sports being measured by the app.
4. More tasks/exercises over all, covering differing types of training like calisthenics. This could to lead to more diversity of exercises among same OCKCarePlan days week by week.

## Challenges faced while developing
<!--
Describe any challenges you faced with learning Swift, your baseline app, or adding features. You can describe how you overcame them.
-->
My biggest challenge developing MakeMeFit would be the time I could allocate to programming. The Concepts of Swift came somewhat naturally, although there were plenty moments of confusion. Adding OCKSurveys was a hurdle for example because I couldn't figure out how to actually grab the data the user was inputting and format it into numerical variables that I could use. The project documentation was daunting and often times difficult to understand. With the help of internet users, I was able to find some of the answers to my problems like that of the survey answer, but many I had to leave be for lack of time. I don't own a Mac, nor am I very familiar with macOS in general, so having to come to WhiteHall or King Library from off campus was often an issue because of my other classes and work. That being said, I am glad I learned what I did, and I value my new experience in Swift greatly.

## Setup Your Parse Server

### Heroku
The easiest way to setup your server is using the [one-button-click](https://github.com/netreconlab/parse-hipaa#heroku) deplyment method for [parse-hipaa](https://github.com/netreconlab/parse-hipaa).


## View your data in Parse Dashboard

### Heroku
The easiest way to setup your dashboard is using the [one-button-click](https://github.com/netreconlab/parse-hipaa-dashboard#heroku) deplyment method for [parse-hipaa-dashboard](https://github.com/netreconlab/parse-hipaa-dashboard).
