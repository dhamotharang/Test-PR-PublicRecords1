import  RoxieKeyBuild,ut,autokey;

export Proc_Build_DEADCO_Keys(string filedate) := function

SuperKeyName        := cluster.cluster_out+'Key::INFOUSA::Deadco::@version@::';
BaseKeyName 		:= cluster.cluster_out+'Key::INFOUSA::Deadco::'+filedate;
               
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_deadco_BDID,SuperKeyName+'bdid',BaseKeyName+'::bdid',key1);														
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InfoUSA.Key_Deadco_ABI_number,SuperKeyName+'ABI_number',BaseKeyName+'::ABI_number',key2);														
key       :=sequential(key1,key2);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'bdid',BaseKeyName+'::bdid',mv1,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'ABI_number',BaseKeyName+'::ABI_number',mv2,2);
mv        :=sequential(mv1,mv2);

RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'bdid','Q',toq1,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'ABI_number','Q',toq2,2);
toq       :=sequential(toq1,toq2); 
              
buildkeys := sequential(key,Mv,Toq);

return buildkeys;

end;