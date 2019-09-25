IMPORT STD, ProfileBooster;

EXPORT ProcBuild_ProfileBooster_OneMain (string IPaddr, string AbsolutePath, string NotifyList, boolean onThor = TRUE) := FUNCTION;

sequential(
			ProfileBooster.bwr_ProfileBooster_OneMain_Step1(NotifyList ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step2_1( NotifyList, onThor  ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step2_2 (NotifyList, onThor ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step2_3(NotifyList, onThor ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step2_4(NotifyList, onThor ),
			ProfileBooster.bwr_ProfileBooster_OneMain_Step3( IPaddr,  AbsolutePath,  NotifyList,  onThor )
			);
			
	RETURN 'SUCCESSFUL';

END;


