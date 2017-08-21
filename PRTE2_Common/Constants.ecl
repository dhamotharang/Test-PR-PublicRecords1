IMPORT _Control, ut, Std, data_services;
// Oct 2016 - Added TodayString and TodayInt constants to begin to replace all ut.getdate

EXPORT Constants := MODULE

	// Work with Terri, Shannon and Gabriel, et.al to determine what everyone wants
	EXPORT string EDATA11 				:= _control.IPAddress.edata11;			// OLD LZ GOING AWAY SOON
	EXPORT bctlpedata10    				:= _control.IPAddress.bctlpedata10;
	EXPORT bctlpedata11    				:= _control.IPAddress.bctlpedata11;
	EXPORT bctlpedata12    				:= _control.IPAddress.bctlpedata12;
	EXPORT BocaLandingZone				:= EDATA11;													// Boca related LZ
	EXPORT InsLandingZone					:= bctlpedata12;										// Alpha related LZ
	
	EXPORT BocaLandingPathPrefix	:= '/load01/';
	EXPORT InsLandingPathPrefix		:= '/data/prct/infiles/insurance_ct/';
	string landingPort 						:= _control.PortAddress.esp_html;
	EXPORT thisEnvironmentName 		:= _control.ThisEnvironment.Name;
	EXPORT thisCurrentCluster 		:= ThorLib.Cluster();
	EXPORT is_running_in_prod 		:= thisEnvironmentName = 'Prod_Thor';		
	EXPORT TodayString 						:= (STRING8)Std.Date.Today();
	EXPORT TodayInt	 							:= Std.Date.Today();

	// DS Prod's useful only for CT Despray processes
	// ut.Foreign_prod includes a ~, so this will work in PROD as well, as a no-op.
	// Assumption built into this is that all files have a ~ in the name.
	//TODO - once all references to foreign prod are removed, remove foreign_prod
	EXPORT foreign_prod						:= IF(is_running_in_prod, '', data_services.foreign_prod);
	SHARED foreign_prod2					:= IF(is_running_in_prod, '~', data_services.foreign_prod);
	SHARED removeTildeFN(STRING fn2)				:= REGEXREPLACE('~',fn2,'', NOCASE);
	EXPORT Add_Foreign_prod(STRING fn) := foreign_prod2+removeTildeFN(fn);
	
	// 4/29 email saying do not replicate in Boca Dataland
	EXPORT boolean SPRAY_REPLICATE := is_running_in_prod;
	EXPORT boolean SPRAY_COMPRESS := TRUE;
		
	EXPORT boolean TRIAL_RUN_ONLY_NO_DOPS := TRUE;
	EXPORT boolean FULL_RUN_WITH_DOPS 		:= FALSE;

	EXPORT AvoidedUpdateMsg(STRING type)		:= 'No '+type+' update is being done, because flags indicated it should not happen';
	// Example: OUTPUT(AvoidedUpdateMsg('IDOPS'));  OR  OUTPUT(AvoidedUpdateMsg('ORBIT'));

	// =================== Remove this after all references are removed ==================
	EXPORT Running_in_production := is_running_in_prod;  // find and replace with "is" name

END;