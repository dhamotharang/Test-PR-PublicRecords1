import  FBNV2,RoxieKeyBuild,ut,autokey;

export Proc_Build_Keys(string filedate) := function

SuperKeyName       	:= cluster.cluster_out+'Key::FBNV2::@version@::';
BaseKeyName 		:= Cluster.cluster_out+'Key::FBNV2::'+filedate;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_did,SuperKeyName+'did',BaseKeyName+'::did',key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_bdid,SuperKeyName+'bdid',BaseKeyName+'::bdid',key2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_jurisdiction,SuperKeyName+'jurisdiction',BaseKeyName+'::jurisdiction',key5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_rmsid_Business,SuperKeyName+'Rmsid_Business',BaseKeyName+'::Rmsid_Business',key6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_rmsid_Contact,SuperKeyName+'Rmsid_Contact',BaseKeyName+'::Rmsid_Contact',key7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_filing_number,SuperKeyName+'Filing_number',BaseKeyName+'::filing_number',key8);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_date,SuperKeyName+'date',BaseKeyName+'::date',key9); 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_RMSID,SuperKeyName+'RMSID',BaseKeyName+'::RMSID',key10); 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_LinkIds.Key,SuperKeyName+'linkids',BaseKeyName+'::linkids',key11); 

Keys := parallel(key1,key2,/*key5,*/key6,key7,key8,/*key9,*/key10,key11);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'did',BaseKeyName+'::did',mv1,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'bdid',BaseKeyName+'::bdid',mv2,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'jurisdiction',BaseKeyName+'::jurisdiction',mv5,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'Rmsid_Business',BaseKeyName+'::Rmsid_Business',mv6,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'Rmsid_Contact',BaseKeyName+'::Rmsid_Contact',mv7,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'Filing_number',BaseKeyName+'::filing_number',mv8,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'date',BaseKeyName+'::date',mv9,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'RMSID',BaseKeyName+'::RMSID',mv10,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'linkids',BaseKeyName+'::linkids',mv11,Qa);

Move_keys := parallel(mv1, mv2, /*mv5,*/ mv6, mv7, mv8,/* mv9,*/mv10,mv11);	

RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'did','Q',toq1,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'bdid','Q',toq2,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'jurisdiction','Q',toq5,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'Rmsid_Business','Q',toq6,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'Rmsid_Contact','Q',toq7,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'Filing_number','Q',toq8,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'date','Q',toq9,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'RMSID','Q',toq10,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'linkids','Q',toq11,2);
						
To_qa    :=parallel(toq1, toq2, /* toq5, */toq6, toq7, toq8, /*toq9,*/toq10,toq11);	


buildKey :=sequential(Keys,Move_keys,to_qa);	

return buildKey ;

end;

