import ut, header,doxie,RoxieKeybuild;

export proc_buildkeys(string filedate) := function

add_superfile := Header_SlimSort.add_Superfile_for_keybuild;

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(header_slimsort.Key_Household,'~thor_data400::key::hhid','~thor_data400::key::header::'+filedate+'::hhid',out_household);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(header_slimsort.key_ssn4_numerics,'~thor_data400::key::header::ssn4_zip_yob_fi','~thor_data400::key::header::'+filedate+'::ssn4_zip_yob_fi',out_ssn4_numerics);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::hhid','~thor_data400::key::header::'+filedate+'::hhid',mv_hhid);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header::ssn4_zip_yob_fi','~thor_data400::key::header::'+filedate+'::ssn4_zip_yob_fi',mv_ssn4_numerics);

ssn_did_keys_4 := header_slimsort.did_ssn_keys(filedate);



full_keys := 
	sequential(
						add_superfile
						,out_household,mv_hhid
						,ssn_did_keys_4
						,out_ssn4_numerics,mv_ssn4_numerics
						);

return full_keys;
end;