import  FBNV2,RoxieKeyBuild,ut,autokey;

export Proc_Build_Keys(string filedate) := function

SuperKeyName       	:= '~thor_data400::key::fcc::@version@::';
BaseKeyName 		:= '~thor_data400::key::fcc::'+filedate;

																
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(fcc.Key_FCC_BDID,'',basekeyname+'::bdid',key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(fcc.Key_FCC_DID,'',BaseKeyName+'::did',key2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(fcc.Key_FCC_seq,'',BaseKeyName+'::seq',key3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(fcc.Key_FCC_Linkids.key,'',BaseKeyName+'::linkids',key4);

Keys := parallel(key1,key2,key3,key4);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'did',BaseKeyName+'::did',mv1,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'bdid',BaseKeyName+'::bdid',mv2,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'seq',BaseKeyName+'::seq',mv3,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'linkids',BaseKeyName+'::linkids',mv4,Qa);

Move_keys := parallel(mv1, mv2, mv3, mv4);	

RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'did','Q',toq1,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'bdid','Q',toq2,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'seq','Q',toq3,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'linkids','Q',toq4,2);
						
To_qa    :=parallel(toq1, toq2,  toq3, toq4);	


buildKey :=sequential(Keys,Move_keys,to_qa);	

return buildKey ;

end;

