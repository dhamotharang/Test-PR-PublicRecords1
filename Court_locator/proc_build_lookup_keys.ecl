import ut, RoxieKeyBuild;

export proc_build_lookup_keys(string filedate) := function

//build non autokeys
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Court_locator.key_fips
                     ,'~thor_data400::key::courtlocatorlookup::' +filedate+'::fips'
    									   ,'~thor_data400::key::courtlocatorlookup::fips',bk1,2);

build_keys := parallel(bk1);

// move keys to built
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::courtlocatorlookup::' +filedate+'::fips'
                                  ,'~thor_data400::key::courtlocatorlookup::fips'
								  ,mv1);
move_build_keys := parallel(mv1);

// Move keys to QA
ut.MAC_SK_Move('~thor_data400::key::courtlocatorlookup::fips',    'Q', mvq1);
move_qa_keys := parallel(mvq1);

do_all:= sequential(
					Court_locator.proc_build_lookup_autokey(filedate) //build auto keys
					,build_keys
					,move_build_keys
					,move_qa_keys
		); 
return do_all;
												   
end;