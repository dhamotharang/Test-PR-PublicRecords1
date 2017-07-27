import  RoxieKeyBuild,ut,autokey;

export Proc_Build_DEADCO_BDID_Key(string filedate) := function

SuperKeyName        := cluster.cluster_out+'Key::INFOUSA::Deadco::@version@::';
BaseKeyName 		:= cluster.cluster_out+'Key::INFOUSA::Deadco::'+filedate;
               
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_deadco_BDID,SuperKeyName+'bdid',BaseKeyName+'::bdid',key1);														

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'bdid',BaseKeyName+'::bdid',mv2,2);

RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'bdid','Q',toq2,2);
						

               
buildkeys := sequential(key1,Mv2,Toq2);

return buildkeys;

end;