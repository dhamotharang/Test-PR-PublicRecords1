IMPORT ut, RoxieKeyBuild, PRTE2_Email_Data, PRTE2_Common, PRTE2_X_DataCleanse, Address, PRTE2_Common, STD;

// mergedHeader := PRTE2_X_Ins_DataCleanse.Files_Alpha.Merged_Headers_SF_DS(addr_match_flag='OK');
Constants    := PRTE2_Email_Data.Constants;
Files        := PRTE2_Email_Data.Files;
Layouts      := PRTE2_Email_Data.Layouts;

//------------Step 0. Z_BWR_emailDataGenerate1: Generate Email Test Data From MHDR (Add Filter 47,324, All 49153)-------------------------
//------------Step 1. Z_BWR_NewEmailDataGenerate_Spray: spray required test data from Nancy(31 records) ----------------------------------
//------------Step 2. Add Required Test Data to CT test data------------------------------------------------------------------------------------

//Read 31 Required Test Data
emailTestData_Layout := RECORD
    string     ResultType ;
    string     First ;
    string     Middle ;
    string     Last ;
    string     SSN ;
    string     DOB ;
    string     SEX ;
    string     DLN ;
    string     DLState ;
    string     HouseNumber ;
    string     StreetName ;
    string     AptNumber ;
    string     City ;
    string     State ;
    string     Zip ;
    string     Email1 ;
    string     Email2 ;
    string     Email3 ;
    string     Email4 ;
    string     Email5 ;
    string     Phone1 ;
    string     Phone2 ;
    string     Phone3 ;
    string     Phone4 ;
    string     Phone5 ;
END;

SPRAYED_DS	:= DATASET('~prct::sprayed::ct::email_spreadsheet_testdata::W20150810-234049', emailTestData_Layout,  
	                     CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"'), MAXLENGTH(PRTE2_Email_Data.Constants.CSVMaxCount)));	
// OUTPUT(SPRAYED_DS,, '~prct::sprayed::ct::email_spreadsheet_testdata_31', OVERWRITE); 

//-----------------------------Find the Common PP to Substitute----------------------------------
// Add Sequence Number and Original Email to 31 Required Test Data
SPRAYED_DS_AddSeq_Layout := RECORD
  unsigned Seq;
	string orig_email;
	emailTestData_Layout;
END;

SPRAYED_DS_AddSeq_Layout xAddSeq(emailTestData_Layout L, INTEGER C):= TRANSFORM
  SELF.Seq := C;
	SELF.orig_email := IF(L.email1 != '', L.email1, '');
	SELF := L;
END;

SPRAYED_DS_AddSquence      := PROJECT(SPRAYED_DS, xAddSeq(LEFT, COUNTER));
EmailSprayData_Empty       := SPRAYED_DS_AddSquence(email1='');
EmailSprayData_Empty_list  := SET(EmailSprayData_Empty, Seq);

// Transform 31 Required Test Data
OutRec := RECORD
    unsigned   Seq;
	  string     orig_email;	
    string     ResultType ;
    string     First ;
    string     Middle ;
    string     Last ;
    string     SSN ;
    string     DOB ;
    string     SEX ;
    string     DLN ;
    string     DLState ;
    string     HouseNumber ;
    string     StreetName ;
    string     AptNumber ;
    string     City ;
    string     State ;
    string     Zip ;
    string     Email ;
END;

OutRec NormIt(SPRAYED_DS_AddSquence L, Integer C) := TRANSFORM
  SELF        := L;
	SELF.email  := CHOOSE(C, L.email1, L.email2, L.email3, L.email4, L.email5);
END;

EmailNormalize            := NORMALIZE(SPRAYED_DS_AddSquence, 5, NormIt(LEFT, COUNTER));
EmailSprayData_nonEmpty   := EmailNormalize(email <>'');

OutRec xGetEmpty(EmailSprayData_Empty L):= TRANSFORM
  SELF       := L;
	SELF.email := L.email1;
END;

EmailSprayData_Empty_DS    := PROJECT(EmailSprayData_Empty, xGetEmpty(LEFT));
EmailSprayData             := SORT(EmailSprayData_nonEmpty + EmailSprayData_Empty_DS, Seq); //82

//Find Common PP Between Required 31 Test Data and MHDR

mergedHeader    := PRTE2_X_Ins_DataCleanse.Files_Alpha.Merged_Headers_SF_DS;

CommonPPCheck_Layout := RECORD
    unsigned   did_list;
    OutRec;
		PRTE2_X_Ins_DataCleanse.Layouts.Layout_Merged_IHDR_BHDR;	
END;

CommonPPCheck_Layout xGetCommonPP(mergedHeader L, EmailSprayData R):= TRANSFORM
    SELF.did_list := L.did;
		SELF := R;
	  SELF := L;
END;

CommonPPCheck := JOIN(mergedHeader, EmailSprayData,  //76
                      LEFT.fname = RIGHT.first
                      AND LEFT.mname = RIGHT.middle
                      AND LEFT.lname = RIGHT.last
                      AND LEFT.fb_ssn = RIGHT.ssn
                      AND LEFT.fb_dob = RIGHT.dob
                      AND LEFT.fb_gender = RIGHT.sex
                      AND LEFT.fb_dln = RIGHT.dln
                      AND LEFT.fb_dlstate = RIGHT.dlstate
                      AND LEFT.fb_city = RIGHT.city
                      AND LEFT.fb_state = RIGHT.state
                      AND LEFT.fb_zip = RIGHT.zip
											, xGetCommonPP(LEFT, RIGHT));	
											
CommonPPCheck_Dedup        := DEDUP(SORT(CommonPPCheck,Seq), Seq); //29

CommonPP_SeqList           := SET(CommonPPCheck_Dedup, Seq); 
EmailSprayData_notInList   := EmailSprayData(Seq NOT IN CommonPP_SeqList); //29
EmailSprayData_InList      := SPRAYED_DS_AddSquence(Seq NOT IN CommonPP_SeqList); //2

//-------------------------- Manipulate 31 Required Test Data  ---------------------------------
emailResult     := DATASET( '~prte::ct::base::email_alpha_generated::email_data_newMHDR',PRTE2_Email_Data.layouts.base, THOR);
emailResult_ALL := DATASET( '~prte::ct::base::email_alpha_generated::email_data_newMHDR_All',PRTE2_Email_Data.layouts.base, THOR);

Request_Did_List         := SET(CommonPPCheck_Dedup, did); //29 request DID
EmailResult_NeedReplace  := emailResult(did IN Request_Did_List); //29 test cases, will be replaced by 76 test records.

//Manipulate 29 of 31 Required Test Data , with Common DID => 76 Records
EmailReult_NeedReplace_Layout := RECORD
  unsigned seq;
	unsigned did_list;
	string first;
	string middle;
	string last;
  PRTE2_Email_Data.layouts.base;
END;

EmailReult_NeedReplace_Layout xGetReplacedEmailData(CommonPPCheck L, EmailResult_NeedReplace R):= TRANSFORM
		SELF.clean_email := L.email;
		append_email_set           := STD.Str.SplitWords(L.email, '@');
		SELF.append_email_username := append_email_set[1];
		SELF.append_domain         := append_email_set[2];
		append_domain_set          := STD.Str.SplitWords(SELF.append_domain, '.');
		SELF.append_domain_root    := append_domain_set[1];
		SELF.append_domain_ext     := IF(append_domain_set[2]!='', '.' + append_domain_set[2], '');

		DomainList_ISP := ['AOL', 'ATT', 'COMCAST'];		
		SELF.append_domain_type    := IF(SELF.append_domain_root= '', '', IF(SELF.append_domain_root IN DomainList_ISP, 'ISP', 'FREE'));
		
		SELF.clean_address.zip         := L.zip;
		SELF.orig_zip                  := L.zip;
    SELF.best_ssn                  := L.ssn;
    SELF.best_dob                  := (INTEGER)L.dob;
    SELF.email_rec_key := hash64((data)L.email + 
                                 (data)L.prim_range+ 
                                 (data)L.prim_name +  
                                 (data)L.sec_range +  
                                 (data)L.zip + 
                                 (data)L.first +  
                                 (data)L.last);	
    SELF := L;
		SELF := R;
END;

EmailResult_Replacing := JOIN(CommonPPCheck,EmailResult_NeedReplace,
                              LEFT.DID_LIST = RIGHT.DID,
															xGetReplacedEmailData(LEFT, RIGHT));
															
COUNT(EmailResult_Replacing); //76
EmailResult_Replaced := PROJECT(EmailResult_Replacing, PRTE2_Email_Data.layouts.base);//29 records of 31 => 76 Test Data


//Manipulate 2 of 31 Required Test Data: assign Two DID from Require_bc = 'N' => 6 Records
// mergedHeader(fb_gender = 'F' and st = 'FL' and  fb_ssn <> '000000000' and fb_dln<>'');
// mergedHeader(fb_gender = 'M' and st = 'NY' and fb_city = 'NEW YORK' and fb_ssn <> '000000000' and fb_dln<>'');

EmailReplaceTwo := emailResult_ALL(did = 888809052440 or did = 888809053361); 

EmailReult_NeedReplace_Layout xGetReplace(EmailSprayData_notInList L, EmailReplaceTwo R) := TRANSFORM
	  SELF.did_list := R.did;
		SELF.clean_email := L.email;
		append_email_set           := STD.Str.SplitWords(L.email, '@');
		SELF.append_email_username := append_email_set[1];
		SELF.append_domain         := append_email_set[2];
		append_domain_set          := STD.Str.SplitWords(SELF.append_domain, '.');
		SELF.append_domain_root    := append_domain_set[1];
		SELF.append_domain_ext     := IF(append_domain_set[2]!='', '.' + append_domain_set[2], '');

		DomainList_ISP := ['AOL', 'ATT', 'COMCAST'];		
		SELF.append_domain_type    := IF(SELF.append_domain_root= '', '', IF(SELF.append_domain_root IN DomainList_ISP, 'ISP', 'FREE'));
    SELF.orig_first_name            := L.first;
    SELF.orig_last_name             := L.last;
		
    addresssline := TRIM(L.housenumber) + TRIM(L.streetname) + TRIM(L.aptnumber); 
    SELF.orig_address               := addresssline; 
    SELF.orig_city                  := L.city;
    SELF.orig_state                 := L.state;
    SELF.orig_zip                   := L.zip;
    SELF.orig_zip4                  := L.zip[6..9]; 
    SELF.clean_name.fname          := L.first;
    SELF.clean_name.mname          := L.middle;
    SELF.clean_name.lname          := L.last;
    SELF.clean_address.prim_range  := L.housenumber;
    SELF.clean_address.prim_name   := L.streetname;
    SELF.clean_address.addr_suffix := '';
    SELF.clean_address.postdir     := '';
    SELF.clean_address.unit_desig  := '';
    SELF.clean_address.sec_range   := '';
    SELF.clean_address.p_city_name := L.city;
    SELF.clean_address.v_city_name := L.city;
    SELF.clean_address.st          := L.state;
    SELF.clean_address.zip         := L.zip[1..5];
    SELF.clean_address.zip4        := L.zip[6..9];
    SELF.best_ssn                  := L.ssn;
		SELF.best_dob                  := (INTEGER)L.dob;

		SELF.email_rec_key := hash64((data)L.email + 
                                 (data)L.housenumber+ 
                                 (data)L.streetname +   
                                 (data)L.zip + 
                                 (data)L.first +  
                                 (data)L.last);	
		
		SELF := L;
    SELF := R;

END;
EmailReplacingTwo_Result := JOIN(EmailSprayData_notInList, EmailReplaceTwo, //6
                                 LEFT.State = RIGHT.orig_state,
                                 xGetReplace(LEFT, RIGHT));
																
EmailResult_ReplacedTwo := PROJECT(EmailReplacingTwo_Result, PRTE2_Email_Data.layouts.base);

//31 Required Test Data => 82 records
EmailRequestAllTestData :=  EmailResult_ReplacedTwo+EmailResult_Replaced;


// -----------------------------Append Required Test Data with Existed Email Test Data ------------------------------------
EmailResult_notInCommonList := emailResult(did NOT IN Request_Did_List); //47,295 = 47,324 - 29

EmailDataAll := SORT(EmailResult_notInCommonList + EmailRequestAllTestData, DID); //47377
OUTPUT(EmailDataAll,,'~prte::ct::base::email_alpha_generated::email_data_All_withTestData', OVERWRITE); 

/*Data Research
EmailDataAll_dedup_key := dedup(sort(EmailDataAll, email_rec_key), email_rec_key);
COUNT(EmailDataAll_dedup_key); //47377

EmailDataAll_dedup_email := dedup(sort(EmailDataAll, clean_email),  clean_email);
COUNT(EmailDataAll_dedup_email); //47370

EmailDataAll_dedup_email_check := table(EmailDataAll, {clean_email, unsigned cnt := count(group)}, clean_email);
EmailDataAll_dedup_email_check(cnt <>1); //8

EmailDataAll(clean_email = ''); //8
*/