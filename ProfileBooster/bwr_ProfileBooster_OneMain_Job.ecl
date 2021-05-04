IMPORT STD;
#workunit('priority','high'); 
#workunit('name','Profile Booster OneMain');

//Step 1 Check _Control.Environment  onThor := TRUE if not = TRUE sandbox to TRUE before running
//Step 2 Doxie.Version_SuperKey  needs to be sandboxed from 'qa' to 'pb'
//Step 3 dx_BestRecords.key_watchdog()  needs to be sandboxed replace  doxie.Version_SuperKey with 'qa'
//Step 4 after job finishes notify team that the OneMain is available on bctlpedata11
 
 NotifyListtemp := '';  //   add additional email addresses if needed, comma delimited similar ProfileBooster.Constants.ECL_Developers_Slim
 // IPaddrTemp := '10.121.149.194';  //dev bctlpedata12 
 IPaddrTemp := '10.121.149.193';  //prod  bctlpedata11 use this one for now


AbsolutePathtemp := '/data/Builds/builds/OneMain/data';  

OldSaltProfileNameTemp := ''; // should be formatted as the file name without ~

ProfileBooster.ProcBuild_ProfileBooster_OneMain( IPaddr := IPaddrTemp,  AbsolutePath := AbsolutePathtemp,  NotifyList := NotifyListtemp, OldSaltProfileName := OldSaltProfileNameTemp);