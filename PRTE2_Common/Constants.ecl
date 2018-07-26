IMPORT _Control, ut, Std, data_services;
// Oct 2016 - Added TodayString and TodayInt constants to begin to replace all ut.getdate

EXPORT Constants := MODULE

	EXPORT bctlpedata10    			:= _control.IPAddress.bctlpedata10;
	EXPORT bctlpedata11    			:= _control.IPAddress.bctlpedata11;
	EXPORT bctlpedata12    			:= _control.IPAddress.bctlpedata12;
	EXPORT InsLandingZone			:= bctlpedata12;										// Alpha related LZ
	
	EXPORT InsLandingPathPrefix := '/data/prct/infiles/insurance_ct/';		// we cannot create sub-dirs, only this directory
	string landingPort				:= _control.PortAddress.esp_html;
	EXPORT thisEnvironmentName	:= _control.ThisEnvironment.Name;
	EXPORT thisCurrentCluster		:= ThorLib.Cluster();
	EXPORT is_running_in_prod		:= thisEnvironmentName = 'Prod_Thor';		
	EXPORT TodayInt					:= Std.Date.Today();
	EXPORT TodayString				:= (STRING8)TodayInt;

	//TODO - once all references to foreign prod are removed, move this to SHARED foreign_prod 
	// - as of today these are the remaining references
	// 				PRTE2_Common.Cross_Module_Files
	// 				PRTE2_WaterCraft._Files
	SHARED foreign_dataland				:= Data_Services.foreign_dataland;							// no IF needed 	
	EXPORT foreign_prod					:= IF(is_running_in_prod, '', data_services.foreign_prod);
	SHARED foreign_prod2					:= IF(is_running_in_prod, '~', data_services.foreign_prod);
	SHARED removeTildeFN(STRING fn2)	:= REGEXREPLACE('~',fn2,'', NOCASE);
	EXPORT Add_Foreign_prod(STRING fn) := foreign_prod2+removeTildeFN(fn);
	
	// 4/29 email saying do not replicate in Boca Dataland
	EXPORT boolean SPRAY_REPLICATE	:= TRUE;
	EXPORT boolean SPRAY_COMPRESS 	:= TRUE;
		
	EXPORT boolean TRIAL_RUN_ONLY_NO_DOPS	:= TRUE;
	EXPORT boolean FULL_RUN_WITH_DOPS 		:= FALSE;


	// =================== Remove this after all references are removed ==================
	EXPORT Running_in_production := is_running_in_prod;  // find and replace with "is" name

END;