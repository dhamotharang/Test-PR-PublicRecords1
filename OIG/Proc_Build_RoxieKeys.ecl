import roxiekeybuild, ut;
export Proc_Build_RoxieKeys(string Pversion) := function
													 
//Build the LinkIds key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(OIG.Key_OIG_LinkIDs.key,
																						 '~thor_data400::key::OIG::@version@::LinkIds',
																						 '~thor_data400::key::OIG::'+Pversion+'::LinkIds',
																						 build_LinkIds_key
																						 );
return build_LinkIds_key;

end;