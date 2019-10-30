 Import Std, ProfileBooster;
 
 // additional people to receive email notifications follow ProfileBooster.Constants.ECL_Developers_Slim format 
 NotifyListtemp := ''; 
 // IPaddrTemp := '10.121.149.194';  //dev bctlpedata12 
 IPaddrTemp := '10.121.149.193';  //prod  bctlpedata11 

today := Std.Date.Today();

AbsolutePathtemp := '/data/Builds/builds/OneMain/data/fulfillment/' + today;  

ProfileBooster.ProcBuild_ProfileBooster_OneMain( IPaddr := IPaddrTemp,  AbsolutePath := AbsolutePathtemp,  NotifyList := NotifyListtemp);