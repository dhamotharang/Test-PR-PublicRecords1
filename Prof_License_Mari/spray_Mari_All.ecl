export spray_Mari_All := MODULE

import Prof_License_Mari.Common_Prof_Lic_Mari;
import Prof_License_Mari.spray_MariFiles;

// AKS0376 //
export triger0376 :=
       Prof_License_Mari.spray_MariFiles.SprayTriggerFile('trigger_0376', 'AKS0376');

export SprayFiles0376 := 
		PARALLEL(
		Prof_License_Mari.spray_MariFiles.SprayFile('0376BUSLI.txt','AKS0376','0376BUSLI', 'tab','fix',661), 
		Prof_License_Mari.spray_MariFiles.SprayFile('0376OCCLI.txt','AKS0376','0376OCCLI', 'tab','fix',261));

END;