IMPORT AccountMonitoring, lib_thorlib, Data_Services;

EXPORT constants := MODULE
	// The file cluster name
	EXPORT STRING SPRAY_GROUPNAME  := lib_thorlib.thorlib.cluster();
	EXPORT STRING DATA_LOCATION 	 := IF(SPRAY_GROUPNAME in ['thor400_30','thor400_20','thor400_44','thor400_198_a','thor400_198_eclcc'],
																			 '~', 							// thor400_30 and thor400_20
																			 Data_Services.foreign_prod); 	// thorwatch and thor_10_219 
	//EXPORT STRING FILENAME_CLUSTER := '~' + SPRAY_GROUPNAME  + '::';
	EXPORT STRING FILENAME_CLUSTER := '~' + IF(SPRAY_GROUPNAME in ['thor_10_219'], SPRAY_GROUPNAME, 'batchr3') + '::';	
	
	// Candidate record disposition.
	EXPORT UNSIGNED1 UNCHANGED  := 1;
	EXPORT UNSIGNED1 NEW        := 2;
	EXPORT UNSIGNED1 CHANGED    := 3;
	EXPORT UNSIGNED1 SKIPRECORD := 4;
	
	// Action codes.
	EXPORT ACTIONS := MODULE
	   EXPORT STRING1 MODIFY   := 'M'; // updates all information for pid/rid
	   EXPORT STRING1 PRODUCTS := 'P'; // changes the product mask to specified value
	   EXPORT STRING1 GO       := 'G'; // adds specified products if not already present
	   EXPORT STRING1 STOP     := 'S'; // removes specified products if present
	   EXPORT STRING1 DELETE   := 'D'; // deletes the pid/rid
	END;
	
	// Product_mask unique integer values for all the products to be monitored
	EXPORT UNSIGNED8 PM_BANKRUPTCY      := AccountMonitoring.types.productMask.bankruptcy;
	EXPORT UNSIGNED8 PM_DECEASED        := AccountMonitoring.types.productMask.deceased;
	EXPORT UNSIGNED8 PM_PHONE           := AccountMonitoring.types.productMask.phone;
	EXPORT UNSIGNED8 PM_ADDRESS         := AccountMonitoring.types.productMask.address;
	EXPORT UNSIGNED8 PM_PAW             := AccountMonitoring.types.productMask.paw;
	EXPORT UNSIGNED8 PM_PROPERTY        := AccountMonitoring.types.productMask.property;
	EXPORT UNSIGNED8 PM_LITIGIOUSDEBTOR := AccountMonitoring.types.productMask.litigiousdebtor;
	EXPORT UNSIGNED8 PM_LIENS           := AccountMonitoring.types.productMask.liens;
	EXPORT UNSIGNED8 PM_CRIMINAL        := AccountMonitoring.types.productMask.criminal;
	EXPORT UNSIGNED8 PM_PHONEFEEDBACK   := AccountMonitoring.types.productMask.phonefeedback;
	EXPORT UNSIGNED8 PM_FORECLOSURE     := AccountMonitoring.types.productMask.foreclosure;
	EXPORT UNSIGNED8 PM_WORKPLACE       := AccountMonitoring.types.productMask.workplace;
	EXPORT UNSIGNED8 PM_REVERSEADDRESS  := AccountMonitoring.types.productMask.reverseaddress;
	EXPORT UNSIGNED8 PM_DIDUPDATE       := AccountMonitoring.types.productMask.didupdate;
	EXPORT UNSIGNED8 PM_BDIDUPDATE     	:= AccountMonitoring.types.productMask.bdidupdate;
	EXPORT UNSIGNED8 PM_PHONEOWNERSHIP  := AccountMonitoring.types.productMask.phoneownership;
	EXPORT UNSIGNED8 PM_BIPBESTUPDATE	  := AccountMonitoring.types.productMask.bipbestupdate;
	EXPORT UNSIGNED8 PM_SBFE						:= AccountMonitoring.types.productMask.sbfe;
	EXPORT UNSIGNED8 PM_UCC							:= AccountMonitoring.types.productMask.ucc;
	EXPORT UNSIGNED8 PM_GOVTDEBARRED		:= AccountMonitoring.types.productMask.govtdebarred;
	EXPORT UNSIGNED8 PM_INQUIRY					:= AccountMonitoring.types.productMask.inquiry;
	EXPORT UNSIGNED8 PM_CORP						:= AccountMonitoring.types.productMask.corp;
	EXPORT UNSIGNED8 PM_MVR							:= AccountMonitoring.types.productMask.mvr;
	EXPORT UNSIGNED8 PM_AIRCRAFT				:= AccountMonitoring.types.productMask.aircraft;
	EXPORT UNSIGNED8 PM_WATERCRAFT			:= AccountMonitoring.types.productMask.watercraft;
	
	// This special value provides the user with a shortcut for utilities to say ALL.
	EXPORT UNSIGNED8 PM_ALL        := -1;
	
	// Constants for the various Account Monitoring pseudo-environment
	EXPORT PSEUDO := enum(UNSIGNED1,
		DEFAULT = 0,
		DEV,
		CERT,
		PROD,
		TEST1,
		TEST2);
	
	// Set of All pseudo-environments
	EXPORT ALL_PSEUDO := [
		PSEUDO.DEFAULT,
		PSEUDO.DEV,
		PSEUDO.CERT,
		PSEUDO.PROD,
		PSEUDO.TEST1,
		PSEUDO.TEST2];
	
	// Maps the currently used environment to the corresponding text for use within calls
	EXPORT STRING PSEUDO_EXT(UNSIGNED1 PSEUDO_ENVIRONMENT) := MAP(
		PSEUDO_ENVIRONMENT = PSEUDO.DEV   => 'DEV::',
		PSEUDO_ENVIRONMENT = PSEUDO.CERT  => 'CERT::',
		PSEUDO_ENVIRONMENT = PSEUDO.PROD  => 'PROD::',
		PSEUDO_ENVIRONMENT = PSEUDO.TEST1 => 'TEST1::',
		PSEUDO_ENVIRONMENT = PSEUDO.TEST2 => 'TEST2::',
		/* DEFAULT */                        '');
		
END;