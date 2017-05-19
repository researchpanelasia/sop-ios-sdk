# SOP iOS SDK (beta)

This library allows you to integrate surveyonPartners into your iOS app
 
## Requirements
- iOS 8.0+
- Swift 3
- You need to be a partner of surveyonPartners. If you have any interest, please [contact us](http://www.d8aspring.com/).
- Read [SOP v1.1 Documentations](https://console.partners.surveyon.com/docs/v1_1) and integrate your webservice with SOP.
- Make a endpoint for `research survey delivery notification` on your webservice and notify targeted members via medium of your choice, such as Push Notification. Making a endpoint for research survey delivery notification is mandatory to use SOP iOS SDK.

## Getting Started
### CocoaPods

Add the following lines to your Podfile

```
pod 'SurveyonPartners'
```


Run below command

```
$ pod install
```

## Usage
### Configuration

```
SurveyonPartners.setUp(appId: "your-app-id",
                       appMid: "user-app-mid",
                       secretKey: "your-secret-key")
```

### Show survey list page
If you want to to use predefined page to display surveys, call showSurveyList method.

```
SurveyonPartners.showSurveyList(vc: self, 
                                profilingPointRule: MyProfilingRule(), 
                                researchPointRule: MyResearchPointRule())
```

To call showSurveyList method, you need to create class which adopt ProfilingPointRule, and class which adopt ResearchPointRule and Parcelable.

```
class MyProfilingRule: ProfilingPointRule {
  
  func profilingPoint(profiling: Profiling) -> String {
    //Please return points of general profile questionnaire. 
    //Profile questionnaire are successive. It’s good to use word like “each”  
    return "2 each"
  }
  
  func googleAuthProfilingPoint(profiling: Profiling) -> String {
    //Please return points of profile questionnaire for registering Google account.     
    return "5"
  }
  
  func facebookAuthProfilingPoint(profiling: Profiling) -> String {
    //Please return points of profile questionnaire for registering Facebook account.
    return "4"
  }
  
  func cookieProfilingPoint(profiling: Profiling) -> String {
    //Please return points of profile questionnaire for registering cookie.
    return "6"
  } 
}


class MyResearchPointRule: ResearchPointRule {
  
  func researchPoint(research: Research) -> String {
    //Implement your domain logic to decide point for the research survey  
    let loi: Int = Int(research.loi)!
    var point = "0"
    if (0 <= loi && loi < 3) {
      point = "100";
    } else if (loi < 5) {
      point = "200";
    } else {
      point = "300";
    }
    
    return point
  }  
}
```

### Make own user interface to display surveys
If you want to make your own user interface to display surveys, call getSurveyList method to get surveys. Along with getting surveys, this method automatically register advertising id on SOP server.

```
SurveyonPartners.getSurveyList(completion: { (result) -> Void in
  switch result {
  case .success(let response):
    //success
  case .failed(let error):
    //failed
  }
})
```

### Calling SOP API directly
You can also request SOP API directly without SOP iOS SDK. See [SOP v1.1 Documentations](https://console.partners.surveyon.com/docs/v1_1). If you want to use SOP in mobile, please make sure that you need to implement below functions.

- Profile questionnaire with survey_id q000_cookie should be open in browser application, not WebView in your application. Because this survey gather cookie in browser application to delivery ad tracking surveys.
- Call Panelist Registration API to register advertising id.  
