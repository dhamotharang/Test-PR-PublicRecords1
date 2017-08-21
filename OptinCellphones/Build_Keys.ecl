import  RoxieKeyBuild,ut,autokey;

export Build_Keys(string filedate) := function

SuperKeyName       	:= '~thor_data400::key::OptinCellphones::@version@::';
BaseKeyName 		:= '~thor_data400::key::OptinCellphones::'+filedate ;

//Build keys					
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_email
										  ,SuperKeyName+'email_search'
										  ,BaseKeyName+'::email_search'
										  ,email_key);
																	
// Move keys to build
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'email_search'
										,BaseKeyName+'::email_search'
										,mv_email_key);

// Move keys to QA
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'email_search','Q',mv_email_key_qa);


build_keys := sequential(email_key
						,mv_email_key
						,mv_email_key_qa);
return build_keys;
end;

