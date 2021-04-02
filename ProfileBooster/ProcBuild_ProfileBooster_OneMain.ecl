IMPORT  ProfileBooster;

EXPORT ProcBuild_ProfileBooster_OneMain (string IPaddr, string AbsolutePath, string NotifyList) := FUNCTION;

 // NotifyList := '';
 // IPaddr := 'bctlpedata12';  //dev use this one
//  IPaddr := 'bctlpedata10';  //prod
 // AbsolutePath := '/data/Builds/builds/OneMain/data';  

sequential(
			ProfileBooster.bwr_ProfileBooster_OneMain_Step1(NotifyList ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step2_1( NotifyList ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step2_2 (NotifyList),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step2_3(NotifyList ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step2_4(NotifyList ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step3( IPaddr,  AbsolutePath,  NotifyList ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step4(NotifyList )
			);
			
	RETURN 'SUCCESSFULLY COMPLETED ONEMAIN PROCESS';

END;


