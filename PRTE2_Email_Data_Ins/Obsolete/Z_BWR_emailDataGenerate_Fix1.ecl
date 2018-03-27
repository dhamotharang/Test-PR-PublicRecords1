IMPORT PRTE2_Email_Data_Ins; 

EmailDS := DATASET('~prte::ct::base::email_alpha_generated::email_data_All_withTestData', PRTE2_Email_Data_Ins.Layouts.base,THOR);    //47,377
DS_Orig_Email_Test := TABLE(EmailDS, {orig_email, unsigned cnt := count(group)}, orig_email);
// DS_Orig_Email_Test(cnt <> 1);

ProblemEmails_List := SET(DS_Orig_Email_Test(cnt <> 1 and orig_email <> ''), orig_email);
// EmailDS(orig_email in ProblemEmails_List);

DS_Orig_Email_Replace_List := SET(EmailDS(orig_email in ProblemEmails_List), email_rec_key);
EmailDS(email_rec_key in DS_Orig_Email_Replace_List);

//-------------------------- Fix 69 Orig_Email Equal to Clean_Email  ---------------------------------
PRTE2_Email_Data_Ins.Layouts.base xChageOrigEmail(EmailDS L) := TRANSFORM
  SELF.Orig_Email := L.clean_email;
	SELF := L;
END;
 
Result := PROJECT(EmailDS, xChageOrigEmail(LEFT));

//-------------------------- Fix JOHN AARDVARK  ---------------------------------
// Result(did = 888809052174 or did = 888809053361);
DS_Pre := DATASET('~prte::ct::base::email_alpha_generated::email_data_newMHDR', PRTE2_Email_Data_Ins.Layouts.base,THOR);
DS_Pre(did = 888809052174 or did = 888809053361);
NeedFix_List := SET(Result(did = 888809052174 or did = 888809053361), email_rec_key);

PRTE2_Email_Data_Ins.Layouts.base xFixEmail(DS_Pre L, DS_Pre R) := TRANSFORM
    SELF.clean_email:= L.clean_email     ;
    SELF.append_email_username:= L.append_email_username     ;
    SELF.append_domain	      := L.append_domain     ;
    SELF.append_domain_type	  := L.append_domain_type     ;
    SELF.append_domain_root	  := L.append_domain_root     ;
    SELF.append_domain_ext	  := L.append_domain_ext     ;
    SELF.email_rec_key        := L.email_rec_key    ;
    SELF.orig_email           := L.orig_email    ;
    SELF.orig_zip             := '12345'    ;
    SELF.clean_address.zip    := '12345'    ;
    SELF := R ;
		
END;

emailFixed := JOIN(Result(did = 888809053361), Result(did = 888809052174)
                   ,LEFT.orig_first_name = RIGHT.orig_first_name
									 ,xFixEmail(LEFT, RIGHT)
									 );

// emailFixed;
// COUNT(Result(email_rec_key not in NeedFix_List));
AfterFix_DS := Result(email_rec_key not in NeedFix_List) + emailFixed;
// COUNT(AfterFix_DS); //47376
// AfterFix_DS(email_rec_key in DS_Orig_Email_Replace_List);
OUTPUT(AfterFix_DS,,'~prte::ct::base::email_alpha_generated::email_data_All_withTestData::20150920', OVERWRITE); 
