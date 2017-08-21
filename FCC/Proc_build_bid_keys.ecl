import  FBNV2,RoxieKeyBuild,ut,autokey;

export Proc_Build_bid_Keys(string filedate) := function

SuperKeyName       	:= '~thor_data400::key::fcc::@version@::';
BaseKeyName 		:= '~thor_data400::key::fcc::'+filedate;

																
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(fcc.Key_FCC_BID,'',basekeyname+'::bid',key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(fcc.Key_FCC_seq_bid,'',BaseKeyName+'::bid::seq',key2);

Keys := parallel(key1,key2);


RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'bid',BaseKeyName+'::bid',mv1,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'bid::seq',BaseKeyName+'::bid::seq',mv2,Qa);

Move_keys := parallel(mv1, mv2);	


RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'bid','Q',toq1,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'bid::seq','Q',toq2,2);
						
To_qa    :=parallel(toq1, toq2);

buildKey :=sequential(Keys,Move_keys,to_qa);	

return buildKey ;

end;

