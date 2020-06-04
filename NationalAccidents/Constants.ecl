IMPORT _control, orbit;

EXPORT Constants := MODULE

EXPORT isCustomerTest := FALSE : STORED('CustomerTestEnv');    // boolean flag indicating if this is a customer test build. certain functionalities should be deactivated.

// ###########################################################################
//   Spray default Constants setting for Variable length Datasets   
// ###########################################################################
    EXPORT FileSeparator := '/'; 
    EXPORT FieldSeparator := ',';
    EXPORT RecordTerminator := '\n';
    EXPORT DefaultQuote := '\"';
					
// ###########################################################################
//   Insurance NAccidentsInquiry settings for Variable length Datasets   
// ###########################################################################
    EXPORT VehicleIncidentFieldSeparator := '~~';
	
// ###########################################################################
//            Insurance NAccidentsInquiry Input File Record Lengths   
// ###########################################################################
    EXPORT ClientRecordLength := 3000000;
    EXPORT IntOrderRecordLength  := 3000000;
    EXPORT OrderVersionRecordLength := 6000000;
    EXPORT VehiclePartyRecordLength := 400000;
    EXPORT VehicleIncidentRecordLength := 400000;
    EXPORT VehicleRecordLength := 400000;
    EXPORT ResultRecordLength := 400000;
    EXPORT VehicleInscrRecordLength := 400000;
    EXPORT MaxRecordLength := 10000;
    
// ###########################################################################
// File Type used in Spray process for file handshaking with JAVA server    
// ###########################################################################
    EXPORT NAccidentsInquiryFileType := '.csv';

// ###########################################################################
//           Insurance NAccidentsInquiry File Name Constants   
// ########################################################################### 
    EXPORT NAccidentsInquiryFileNameList  := [FileNames.CLIENT_FILE_NAME, 
																																														FileNames.INT_ORDER_FILE_NAME,
																																														FileNames.ORDER_VERSION_FILE_NAME,
																																														FileNames.VEHICLE_PARTY_FILE_NAME,
																																														FileNames.VEHICLE_INCIDENT_FILE_NAME,
																																														FileNames.VEHICLE_FILE_NAME,
																																														FileNames.RESULT_FILE_NAME,
																																														FileNames.VEHICLE_INSCR_FILE_NAME]; 
																						
// ###########################################################################
// Environment settings for the Build process
// DEVELOPMENT vs PRODUCTION  
// ###########################################################################
    EXPORT DevLandingZone := _control.IPAddress.unixland;  //Alpha Dev LZ IP Address
    EXPORT ProdLandingZone := _control.IPAddress.prodlz;  //Alpha Prod LZ IP Address	
    EXPORT LandingZone := IF(_control.ThisEnvironment.Name <> 'Prod', DevLandingZone, ProdLandingZone);
    
	  EXPORT DevTHOR := 'thor40_241'; //_Control.TargetQueue.Thor400_72_Dev;
    EXPORT ProdTHOR := 'thor400_44'; //_Control.TargetQueue.Prod_NonFCRA; 
    EXPORT THORDest := IF(_control.ThisEnvironment.Name <> 'Prod', DevTHOR, ProdTHOR);

    // EXPORT DevTargetCluster := _Control.TargetQueue.Thor400_72_Dev;   //Alpha Dev THOR Cluster
    // EXPORT ProdTargetCluster := _Control.TargetQueue.Prod_NonFCRA; //Alpha Prod NonFCRA THOR Cluster		
    // EXPORT TargetCluster := IF(_control.ThisEnvironment.Name <> 'Prod', DevTargetCluster, ProdTargetCluster);

    EXPORT DevLexIDAppendCluster := DevTHOR; // Alpha Dev Cluster used for LexID Append
    EXPORT ProdLexIDAppendCluster := ProdTHOR; // Alpha Prod THOR Cluster used for LexID Append
    EXPORT LexIDAppendCluster := IF(_control.ThisEnvironment.Name <> 'Prod', DevLexIDAppendCluster, ProdLexIDAppendCluster);

    EXPORT OrbitPathPrefix            := orbit.EnvironmentVariables.orbitpathprefix;  // Prefix for Orbit File Receving/Tracking Entry for NAccidentsInquiry
    EXPORT OrbitComponentPathPrefix   := orbit.EnvironmentVariables.orbitcomponentpathprefix; // Perfix for Receving Instancefor NAccidentsInquiry

    SHARED DataDirPrefix := '/data';	

    EXPORT DevProcessPath := DataDirPrefix + FileSeparator + 'orbittesting';  // Alpha Dev/QC ECL Processing Path for NAccidentsInquiry Input Files
    EXPORT ProdProcessPath := DataDirPrefix + FileSeparator + 'orbitprod'; // Alpha Dev/QC ECL Processing Path for NAccidentsInquiry Input Files
    EXPORT ProcessPath := IF(_control.ThisEnvironment.Name <> 'Prod', DevProcessPath, ProdProcessPath);
	
// ###########################################################################
//   Directory Name defined on Landing Zone for NAccidentsInquiry Spray Process
// ###########################################################################		
    SHARED NAccidentsInquiryExtractsSprayDirName := 'NationalAccidentsInquiry';		
    EXPORT NAccidentsInquiryExtractsSprayDirPath := ProcessPath + FileSeparator + NAccidentsInquiryExtractsSprayDirName;					
		
		  	
	   EXPORT  LowerCaseAlphabet := 'abcdefghijklmnopqrstuvwxyz';
		 
		 //Send email message
		 EXPORT Email_Msg := 'Insurance Ntl Accidents Inquiry :  ';
	
END;