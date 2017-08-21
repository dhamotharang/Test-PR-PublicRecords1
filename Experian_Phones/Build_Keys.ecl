import RoxieKeyBuild;
EXPORT Build_Keys (string version) := module
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Experian_Phones.Key_Did,
																					Filenames.key +  '::@version@::did',
																					Filenames.key +  '::'+version+'::did', 
                                         bk_did);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Experian_Phones.Key_Did_Digits,
																					Filenames.key +  '::@version@::did_digits',
																					Filenames.key +  '::'+version+'::did_digits', 
                                         bk_did_digits);
																				 

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Filenames.key +  '::@version@::did', 
								 Filenames.key +  '::'+version+'::did',
                                         mv_did);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Filenames.key +  '::@version@::did_digits', 
								 Filenames.key +  '::'+version+'::did_digits',
                                         mv_did_digits);								

RoxieKeyBuild.Mac_SK_Move_V2(Filenames.key +  '::@version@::did', 'Q', mv_did_key_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Filenames.key +  '::@version@::did_digits', 'Q', mv_did_digits_key_QA);


full_build_keys := sequential(
				parallel(bk_did,bk_did_digits),
				parallel(mv_did,mv_did_digits),
				parallel(mv_did_key_QA, mv_did_digits_key_QA)
				);

export All := full_build_keys;
end;