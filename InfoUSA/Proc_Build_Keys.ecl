import  RoxieKeyBuild,ut,autokey,VersionControl,InfoUSA,doxie,Tools;

export Proc_Build_Keys(string filedate, string source) := function

SuperKeyName  := cluster.cluster_out+'Key::INFOUSA::'+source+'::@version@::';
BaseKeyName 	:= cluster.cluster_out+'Key::INFOUSA::'+source+'::'+filedate;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_DEADCO_LinkIds.Key,SuperKeyName+'linkids',BaseKeyName+'::linkids',key0);														
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_DEADCO_BDID,SuperKeyName+'bdid',BaseKeyName+'::bdid',key1);														
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_DEADCO_ABI_number,SuperKeyName+'ABI_number',BaseKeyName+'::ABI_number',key2);														
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_ABIUS_BDID,SuperKeyName+'bdid',BaseKeyName+'::bdid',key3);														
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_ABIUS_ABI_number,SuperKeyName+'ABI_number',BaseKeyName+'::ABI_number',key4);	
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_ABIUS_LinkIds.Key,SuperKeyName+'linkids',BaseKeyName+'::linkids',key5);														
key       :=if (source='DEADCO',sequential(key0,key1,key2),sequential(key3,key4,key5));

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'linkids',BaseKeyName+'::linkids',mv0,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'bdid',BaseKeyName+'::bdid',mv1,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'ABI_number',BaseKeyName+'::ABI_number',mv2,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'linkids',BaseKeyName+'::linkids',mv3,2);
mv        :=if (source='DEADCO',sequential(mv0,mv1,mv2),sequential(mv1,mv2,mv3));

RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'linkids','Q',toq0,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'bdid','Q',toq1,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'ABI_number','Q',toq2,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'linkids','Q',toq3,2);
toq       :=if (source='DEADCO',sequential(toq0,toq1,toq2),sequential(toq1,toq2,toq3)); 
              
buildkeys := sequential(key,Mv,Toq);

return buildkeys;

end;