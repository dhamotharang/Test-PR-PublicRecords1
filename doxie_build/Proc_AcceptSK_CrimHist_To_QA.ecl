import ut;

ut.MAC_SK_Move('~thor_data400::key::CrimHist_Append_'+buildstate,'Q',one);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_DOB_'+buildstate,'Q',one2);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_Num_'+buildstate,'Q',one3);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_SMT_'+buildstate,'Q',one4);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_SSN_'+buildstate,'Q',one5);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_Arrests_'+buildstate,'Q',two);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_DID_'+buildstate,'Q',three);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_Events_'+buildstate,'Q',four);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_Identity_'+buildstate,'Q',five);
ut.MAC_SK_Move('~thor_data400::key::CrimHist_Judicial_'+buildstate,'Q',six);

export Proc_AcceptSK_CrimHist_To_QA := parallel(one,one2,one3,one4,one5,two,three,four,five,six);