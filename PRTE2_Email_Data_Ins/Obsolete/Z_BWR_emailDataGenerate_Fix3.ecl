IMPORT PRTE2_Email_Data, PRTE2_X_DataCleanse; 

AfterFix_DS := DATASET('~prte::ct::base::email_alpha_generated::email_data_All_withTestData::20150929', PRTE2_Email_Data.Layouts.base,THOR); 
// AfterFix_DS(did = 888809027379 or did = 888809052440 or did = 888809052174 or did = 888809053361);
mergedHeader := PRTE2_X_Ins_DataCleanse.Files_Alpha.MHDR_Primary_Recs_DS; //47324 filter (required_bc='Y' AND addr_ind= '1')

//-------------------------- Enhance Addresses with APT but without # ---------------------------------
DID_LIST := [888809001090,	888809004563,	888809007734,	888809012551,	888809012704,	888809013223,	888809016807,	888809017894,	888809018429,	888809019278,	888809025275,	888809027380,	888809036764,	888809038337,	888809041063,	888809043987,	888809047806,	888809048217];
// AfterFix_DS(DID in DID_LIST);
// mergedHeader(DID in DID_LIST);

PRTE2_Email_Data.Layouts.base enhanceAddress(AfterFix_DS L , mergedHeader R):= TRANSFORM
  SELF.clean_address.unit_desig := R.fb_unit_name;
  SELF.clean_address.sec_range  := R.fb_unit_no;
	SELF := L;
END;

enhancedAddress_DS := JOIN(AfterFix_DS(DID in DID_LIST), mergedHeader(DID in DID_LIST)
                           , LEFT.DID = RIGHT.DID
													 , enhanceAddress(LEFT, RIGHT)
													 );

AfterEnhance_DS := AfterFix_DS(DID not in DID_LIST)+ enhancedAddress_DS;
// AfterEnhance_DS(DID in DID_LIST);

OUTPUT(AfterEnhance_DS,, '~prte::ct::base::email_alpha_generated::email_data_All_withTestData::20151001'); // enHanced Address 18 records
// AfterEnhance_DS(did = 888809027379 or did = 888809052440 or did = 888809052174 or did = 888809053361);
