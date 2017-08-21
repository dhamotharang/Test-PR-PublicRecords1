import  Taxpro,RoxieKeyBuild,ut,autokey;

export Proc_Build_Key(string filedate) := function

SuperKeyName    := cluster.cluster_out+'Key::Taxpro::@version@::';
BaseKeyName 		:= Cluster.cluster_out+'Key::Taxpro::'+filedate;

																
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_did,SuperKeyName+'did',BaseKeyName+'::did',key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_bdid,SuperKeyName+'bdid',BaseKeyName+'::bdid',key2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_tmsid,SuperKeyName+'tmsid',BaseKeyName+'::tmsid',key3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_LinkIDs.key,SuperKeyName+'LinkIDs',BaseKeyName+'::LinkIDs',key4);
Keys := parallel(key1,key2,key3,key4);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'did',BaseKeyName+'::did',mv1,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'bdid',BaseKeyName+'::bdid',mv2,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'tmsid',BaseKeyName+'::tmsid',mv3,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'LinkIDs',BaseKeyName+'::LinkIDs',mv4,Qa);
Move_keys := parallel(mv1, mv2,mv3,mv4);	

RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'did','Q',toq1,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'bdid','Q',toq2,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'tmsid','Q',toq3,2);	
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'LinkIDs','Q',toq4,2);					
To_qa    :=parallel(toq1, toq2,toq3,toq4);

buildKey :=sequential(Keys,Move_keys,to_qa);	

return buildKey ;

end;