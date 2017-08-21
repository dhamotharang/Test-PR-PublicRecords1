import  RoxieKeyBuild,ut,autokey;

export Proc_Build_HF_Keys(string filedate) := function

SuperKeyName := cluster.cluster_out+'key::hunting_fishing::';
BaseKeyName  := SuperKeyName+filedate;
																
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_huntfish_did,SuperKeyName+'did',BaseKeyName+'::did',key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_huntfish_rid,SuperKeyName+'rid',BaseKeyName+'::rid',key2);

Keys := parallel(key1,key2);
											 
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::did',BaseKeyName+'::did',mv1,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::rid',BaseKeyName+'::rid',mv2,2);

Move_keys := parallel(mv1, mv2);	

RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName+'@version@::did','Q',toq1,2);
RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName+'@version@::rid','Q',toq2,2);
						
To_qa    :=parallel(toq1, toq2);

buildkeys := sequential(Keys,Move_keys,To_qa);

return buildkeys;

end;
