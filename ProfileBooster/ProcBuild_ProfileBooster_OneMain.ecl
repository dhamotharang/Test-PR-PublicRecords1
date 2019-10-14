IMPORT STD, ProfileBooster;

EXPORT ProcBuild_ProfileBooster_OneMain (string IPaddr, string AbsolutePath, string NotifyList) := FUNCTION;

 // NotifyList := '';
 // IPaddr := 'bctlpedata12';  //dev
//  IPaddr := 'bctlpedata10';  //prod
 // AbsolutePath := '/data/Builds/builds/OneMain/data/fulfillment/20191008';  // change the date to the date it's run on

sequential(
			ProfileBooster.bwr_ProfileBooster_OneMain_Step1(NotifyList ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step2_1( NotifyList ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step2_2 (NotifyList),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step2_3(NotifyList ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step2_4(NotifyList ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step3( IPaddr,  AbsolutePath,  NotifyList )
			);
			
	RETURN 'SUCCESSFULLY COMPLETED ONEMAIN PROCESS';

END;


