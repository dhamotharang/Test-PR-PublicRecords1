EXPORT Files_Credentials := MODULE

  // ##################################################
  // For Development/QC Data Deployments to test Roxie 
  // Services deployments, follow the instructions below
  // to uncomment the appropriate UserCredentials
  // ##################################################

  // ##################################################
  //            Production Files Settings
  // ##################################################
  EXPORT Prod := '';
 
  // ##################################################
  //            Dev Files Settings
  //   Dev file settings are defaulted to DEV, 
  //   User can use any credentials, but make sure the
  //   :: is left intact as is, which is the standandard
  //   Directory structure used for Data Store on THOR
  //
  //   Examples: 
  //            EXPORT Dev := '::SK';
  //
  // ##################################################
  EXPORT Dev := '::DEV';
  
  // ##################################################
  //            QC Files Settings
  //   QC file settings are defaulted to QC.
  //
  //   User can use any credentials, but make sure the
  //   :: is left intact as is, which is the standandard
  //   Directory structure used for Data Store on THOR
  //
  //   Examples: 
  //            EXPORT QC := '::RG;
  //            EXPORT QC := '::SK;
  // ##################################################
  EXPORT QC := '::QC';
  
  // ##################################################
  //            CustomerTest Files Settings
  //   CustomerTest file settings are defaulted to CustTest,
  //
  //   Examples: 
  //            EXPORT CustTest := '_CustTest';
  //
  // ##################################################
  EXPORT CustTest := '_CustTest';
  
  // ##################################################
  //            Production Files Settings
  //   The setting should be enabled for Production
  //   and Dev and QC credentials commented
  // ##################################################
  EXPORT UserCredentials := Prod;
 
  // ##################################################
  //            QC File Settings
  //   The setting is used for QC team,  when this option
  //   is enabled,  please comment the following 
  //    1:  comment EXPORT UserCredentials := Prod;
  //    2:  comment EXPORT UserCredentials := Dev;
  //    3: comment EXPORT UserCredentials := CustTest;
	//
  //   Please note,  QC can choose any credentials for
  //   files by making changes to the following attribute
  //   EXPORT QC := '::QC';
  //  
  //   Examples: 
  //            EXPORT QC := '::RG';
  //            EXPORT QC := '::SK';
  // ##################################################	 
  // EXPORT UserCredentials := QC;
	 
  // ##################################################
  //            Production Files Settings
  //   The setting is used for Development team,  when this option
  //   is enabled,  please comment the following 
  //    1:  comment EXPORT UserCredentials := Prod;
  //    2:  comment EXPORT UserCredentials := QC;
  //    3:  comment EXPORT UserCredentials := CustTest;
  //
  //   Please note,  Dev can choose any credentials for
  //   files by making changes to the following attribute
  //   EXPORT DEV := '::DEV';
  //  
  //   Examples: 
  //            EXPORT DEV := '::SK';
  // ##################################################
  // EXPORT UserCredentials := Dev;
	
  // ##################################################
  //            Production Files Settings
  //   The setting is used for Development team,  when this option
  //   is enabled,  please comment the following 
  //    1:  comment EXPORT UserCredentials := Prod;
  //    2:  comment EXPORT UserCredentials := QC;
  //    3:  comment EXPORT UserCredentials := Dev;
  //
  //   Please use EXPORT CustTest := '_CustTest';
  //  
  // ##################################################
  // EXPORT UserCredentials := CustTest;
	
END;