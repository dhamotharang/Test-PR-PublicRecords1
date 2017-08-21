import ut, crim_common, header_services, hygenics_crim;

inRec :=
RECORD
	STRING60 ssn;
	STRING1 lf;
END;

// Join PullSSN to Current Production crim_offender2_did file to extract the Offender keys from PullSSN.
//
PullSSN_Rec :=
record
	string60 offender_key;
	string1 lf;
end;

Out_Rec := record
string60 offender_key;
string1  lf;
end;

Layout_Old_Crim_Offender_new := record
	hygenics_crim.Layout_Common_Crim_Offender;
	string9 	ssn;
	string12 	did;
end;

//####################### Datasets ##########################
df_Crim_Old     := dataset('~thor_data400::base::crim_offender2_did_20120727_new', Layout_Old_Crim_Offender_new, Thor);
df_Crim         := dataset('~thor_data400::base::crim_offender2_did_20130305_new', hygenics_crim.Layout_Common_Crim_Offender_new, flat);
//hygenics_crim.Layout_Common_Crim_Offender_new
df_pullssn      := dataset('~thor_data400::in::pull_ssn', PullSSN_Rec, flat);

//################## Join to old Criminal data ##############
jPullssn_To_Crim_Offender_old := join(df_crim_old, df_pullssn, left.offender_key=right.offender_key, lookup);

dPullssn_To_Crim_Offender_old := dedup(sort(jPullssn_To_Crim_Offender_old, offender_key), offender_key);

//################## Join to New Hygenics Criminal data ##############
jPullssn_To_Crim_Offender_new := join(df_crim, df_pullssn, left.offender_key=right.offender_key, lookup);

dPullssn_To_Crim_Offender_new := dedup(sort(jPullssn_To_Crim_Offender_new, offender_key), offender_key);


 
Out_Rec off_key_Output_old(dPullssn_To_Crim_Offender_old input) := transform
self.offender_key := input.offender_key;
self.lf := '';
END;

outFinal_old := project(dPullssn_To_Crim_Offender_old, off_key_Output_old(left));

Out_Rec off_key_Output_new(dPullssn_To_Crim_Offender_new input) := transform
self.offender_key := input.offender_key;
self.lf := '';
END;


outFinal_new := project(dPullssn_To_Crim_Offender_new, off_key_Output_new(left));

outFinal_all := dedup(sort(outFinal_old + outFinal_new, offender_key), offender_key);

header_services.Supplemental_Data.mac_verify('pull_ssn',inRec,readit);
 
supplemental := readit();

export File_pullSSN_LE := dataset('~thor_data400::in::pull_ssn_le', inRec, flat) + outFinal_all + supplemental;

//need to change the file path and name. This is for testing purpose 20 records are selected from existing file