#workunit('name','Profile Booster 1.1 OneMain');
#workunit('priority','high'); 
#OPTION('expandSelectCreateRow',true);
#OPTION('outputLimit',2000);
#OPTION('outputLimitMb', 1000);
#OPTION('splitterSpill', 1);
IMPORT ProfileBooster, std;
//Step 1 Check _Control.Environment  onThor := TRUE if not = TRUE sandbox to TRUE before running
//Step 2 Doxie.Version_SuperKey  needs to be sandboxed from 'qa' to 'pb'
//Step 3 Watchdog_V2.IDX_UniversalKey_File  needs to be sandboxed replace  doxie.Version_SuperKey with 'qa'
//Step 4 after job finishes notify team that the OneMain is available on bctlpedata11
 
 NotifyListtemp := '';  //   add additional email addresses if needed, comma delimited similar ProfileBooster.Constants.ECL_Developers_Slim
 // IPaddrTemp := '10.121.149.194';  //dev bctlpedata12 
 IPaddrTemp := '10.121.149.193';  //prod  bctlpedata11 

today := Std.Date.Today();

AbsolutePathtemp := '/data/Builds/builds/OneMain/data/fulfillment/' + today;  

ProfileBooster.ProcBuild_ProfileBooster11_OneMain( IPaddr := IPaddrTemp,  AbsolutePath := AbsolutePathtemp,  NotifyList := NotifyListtemp);