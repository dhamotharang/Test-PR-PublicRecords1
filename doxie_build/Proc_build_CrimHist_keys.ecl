import doxie_files, ut;

ut.MAC_SK_BuildProcess(doxie_files.Key_Crim_Append,'~thor_data400::key::CrimHist_Append_'+buildstate,'~thor_data400::key::CrimHist_Append_'+buildstate,one,2);
ut.mac_sk_buildprocess(doxie_files.key_crim_dob,'~thor_Data400::key::CrimHist_DOB_' + buildstate,'~thor_Data400::key::CrimHist_DOB_'+buildstate,one_b,2);
ut.mac_sk_buildprocess(doxie_files.key_crim_NUM,'~thor_Data400::key::CrimHist_NUM_' + buildstate,'~thor_Data400::key::CrimHist_NUM_'+buildstate,one_c,2);
ut.mac_sk_buildprocess(doxie_files.key_crim_SSN,'~thor_Data400::key::CrimHist_SSN_' + buildstate,'~thor_Data400::key::CrimHist_SSN_'+buildstate,one_d,2);
ut.mac_sk_buildprocess(doxie_files.key_crim_SMT,'~thor_Data400::key::CrimHist_SMT_' + buildstate,'~thor_Data400::key::CrimHist_SMT_'+buildstate,one_e,2);
ut.MAC_SK_BuildProcess(doxie_files.Key_Crim_Arrest,'~thor_data400::key::CrimHist_Arrests_'+buildstate,'~thor_data400::key::CrimHist_Arrests_'+buildstate,two,2);
ut.MAC_SK_BuildProcess(doxie_files.Key_Crim_DID,'~thor_data400::key::CrimHist_DID_'+buildstate,'~thor_data400::key::CrimHist_DID_'+buildstate,three,2);
ut.MAC_SK_BuildProcess(doxie_files.Key_Crim_Events,'~thor_data400::key::CrimHist_Events_'+buildstate,'~thor_data400::key::CrimHist_Events_'+buildstate,four,2);
ut.MAC_SK_BuildProcess(doxie_files.Key_Crim_Ident,'~thor_data400::key::CrimHist_Identity_'+buildstate,'~thor_data400::key::CrimHist_Identity_'+buildstate,five,2);
ut.MAC_SK_BuildProcess(doxie_files.Key_Crim_Judicial,'~thor_data400::key::CrimHist_Judicial_'+buildstate,'~thor_data400::key::CrimHist_Judicial_'+buildstate,six,2);

export Proc_build_CrimHist_keys := parallel(one,one_b,one_c,one_d,two,three,four,five,six);