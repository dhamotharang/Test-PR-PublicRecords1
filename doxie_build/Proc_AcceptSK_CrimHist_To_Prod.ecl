import ut;

ut.MAC_SK_Move('~thor_data400::key::CrimHist_Append_'+buildstate,'P',one);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_DOB_'+buildstate,'P',one2);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_Num_'+buildstate,'P',one3);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_SMT_'+buildstate,'P',one4);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_SSN_'+buildstate,'P',one5);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_Arrests_'+buildstate,'P',two);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_DID_'+buildstate,'P',three);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_Events_'+buildstate,'P',four);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_Identity_'+buildstate,'P',five);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_Judicial_'+buildstate,'P',six);

export Proc_AcceptSK_CrimHist_To_Prod := parallel(one,one2,one3,one4,one5,two,three,four,five,six);