IMPORT PRTE2_Email_Data; 

EmailDS := DATASET('~prte::ct::base::email_alpha_generated::email_data_All_withTestData::20150920', PRTE2_Email_Data.Layouts.base,THOR);    //47,376

//-------------------------- Fix KRISELLEN SMITHEY  ---------------------------------
EmailDS(did = 888809027379 or did = 888809052440);

NeedFix_List := SET(EmailDS(did = 888809027379 or did = 888809052440), email_rec_key);

PRTE2_Email_Data.Layouts.base xFixEmail(EmailDS L, EmailDS R) := TRANSFORM
    SELF.clean_email:= L.clean_email     ;
    SELF.append_email_username:= L.append_email_username     ;
    SELF.append_domain	      := L.append_domain     ;
    SELF.append_domain_type	  := L.append_domain_type     ;
    SELF.append_domain_root	  := L.append_domain_root     ;
    SELF.append_domain_ext	  := L.append_domain_ext     ;
    SELF.email_rec_key        := L.email_rec_key    ;
    SELF.orig_email           := L.orig_email    ;
    SELF := R ;
		
END;

emailFixed := JOIN(EmailDS(did = 888809052440), EmailDS(did = 888809027379)
                   ,LEFT.orig_first_name = RIGHT.orig_first_name
									 ,xFixEmail(LEFT, RIGHT)
									 );

// emailFixed;
// COUNT(Result(email_rec_key not in NeedFix_List));
AfterFix_DS := EmailDS(email_rec_key not in NeedFix_List) + emailFixed;
// COUNT(AfterFix_DS); //47375
// AfterFix_DS(did = 888809027379 or did = 888809052440);
OUTPUT(AfterFix_DS,,'~prte::ct::base::email_alpha_generated::email_data_All_withTestData::20150929'); 
// AfterFix_DS(did = 888809027379 or did = 888809052440 or did = 888809052174 or did = 888809053361);