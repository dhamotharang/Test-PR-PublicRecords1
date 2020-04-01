//Constants

IMPORT std, _control, ut, doxie, Data_Services;

EXPORT Constants := MODULE 

	EXPORT FileSeparator := '/'; 
  EXPORT FieldSeparator := ',';
	EXPORT RecordTerminator := '/';
	EXPORT DefaultQuote := '\"';
	
	EXPORT DevLandingZone := _control.IPAddress.unixland;  //Alpha Dev LZ IP Address
	EXPORT ProdLandingZone := _control.IPAddress.prodlz;  //Alpha Prod LZ IP Address	
	EXPORT LandingZone := IF(_control.ThisEnvironment.Name <> 'Prod', DevLandingZone, ProdLandingZone);
	
	SHARED DataDirPrefix := '/data';	
	EXPORT NAccidentsInquiryFileType := '.csv';
	
  EXPORT DevProcessPath := DataDirPrefix + FileSeparator + 'orbittesting';  // Alpha Dev/QC ECL Processing Path for Ecrash Input Files
	EXPORT ProdProcessPath := DataDirPrefix + FileSeparator + 'orbitprod'; // Alpha Dev/QC ECL Processing Path for Ecrash Input Files
	EXPORT ProcessPath := IF(_control.ThisEnvironment.Name <> 'Prod', DevProcessPath, ProdProcessPath);
	
	SHARED NAccidentsInquiryExtractsSprayDirName := 'naccidentsinquiry';		
  EXPORT NAccidentsInquiryExtractsSprayDirPath := ProcessPath + FileSeparator + NAccidentsInquiryExtractsSprayDirName;

	EXPORT isCustomerTest := FALSE : STORED('CustomerTestEnv');    // boolean flag indicating if this is a customer test build. certain functionalities should be deactivated.


	//INPUT FILE VARIABLES
	EXPORT FileDate 					:=	(UNSIGNED4)Std.Date.Today() : STORED('BuildDate'), INDEPENDENT;                   // this is for versioning and can be different from the landingzone subfolder date
	EXPORT Directory 					:=	'/data/orbittesting/thor_training/process/[insert date]' : STORED('LZDirectory'); //default will fail, change to correct landingzone location
	EXPORT InputFileLocation	:=	MAP(Directory = '/data/orbittesting/thor_training/process/[insert date]' => FAIL(STRING, 'Landing zone directory must be updated using #Constant(\'LZDirectory\', [directory])'),
																		TRIM(Directory+'/'+(STRING)FileDate,LEFT,RIGHT));											 

	//SPRAY VARIABLES
	EXPORT TargetCluster								:= 'thor400_72' : STORED('TargetCluster');                 // added for flexibility when using on your own system
	EXPORT LandingZoneIPAddress 				:= _control.IPAddress.unixland : STORED('LZIPAddress');    //this is the place where our files land on 

	//LEXID
	//checks log file to see if we want to run lexid  -  returns true/false if the dataset has been updated since the last roxie release - set to true else false - takes what is in log file on roxie prod and it compares the date of the previous run to the current run 
	EXPORT UpdateLexID		:= Data_Services.IsNewEnvironmentVariable('thor_training_mw'                                                         //dataset   //updated in CODE REVIEW                                                
	                                                                ,                                                                          //header file version, id file version - package variable
	                                                                ,'http://'+_control.RoxieEnv.boca_stagingvip) : STORED('UpdateLexID'),     //log  file location on ROXIE  
																																	INDEPENDENT;                                                               //runs only once
																																	
	//updates the log file on ROXIE	- this is not being called anywhere																															
	EXPORT UpdateLexIDLog	:= IF(UpdateLexID,                                                   //if true update log file              
	                            Data_Services.EnvironmentVariable_Update('thor_training_mw'    //dataset  //updated in CODE REVIEW
	                            ,                                                              //header file version, id file version - package variable
	                            ,'http://'+_control.RoxieEnv.boca_stagingvip));                //log  file location on ROXIE

	//EMAIL VARIABLES
	EXPORT SuccessEmailList := 'michael.wittekiend@lexisnexisrisk.com' : STORED('EmailList');
	EXPORT SuccessEmailSubject := 'NtlCrash File Status' + filedate;
	EXPORT SuccessEmailBody := 'Please archive National Crash files on LZ /super_credit/flcrash/alpharetta/build/'+ filedate;
	
	EXPORT FailureEmailList := SuccessEmailList + ',michael.wittekiend@lexisnexisrisk.com'; //Add RIS-GLONOC@risk.lexisnexis.com to email list in real build processes -- nobody@lexisnexis.com
	EXPORT FailureEmailSubject := '***FAILURE: National Accident Base and Inquiry Build - ' + WORKUNIT;
	EXPORT FailureEmailBody := ' National Crash Spray failure' + FAILMESSAGE;
END;
