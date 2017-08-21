import  UCCV2,RoxieKeyBuild,ut,autokey;

export Proc_Build_UCC_Keys_BID(string filedate) := function

SuperKeyName		:= cluster.cluster_out+'Key::ucc::';
BaseKeyName 		:= SuperKeyName+filedate;
																
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_bid,SuperKeyName+'bid',BaseKeyName+'::bid',key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_Bid_w_Type,SuperKeyName+'bid_w_type',BaseKeyName+'::bid_w_type',key2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_RMSID_Party_BID,SuperKeyName+'party_Rmsid_BID',BaseKeyName+'::party_Rmsid_BID',key3);

Keys := parallel(key1,key2,key3);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'bid',BaseKeyName+'::bid',mv1,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'bid_w_type',BaseKeyName+'::bid_w_type',mv2,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'party_Rmsid_BID',BaseKeyName+'::party_Rmsid_BID',mv3,2);

Move_keys := parallel(mv1, mv2, mv3);	

ut.MAC_SK_Move_V2(SuperKeyName+'bid','Q',toq1,2);
ut.MAC_SK_Move_V2(SuperKeyName+'bid_w_type','Q',toq2,2);
ut.MAC_SK_Move_V2(SuperKeyName+'party_Rmsid_BID','Q',toq3,2);
						
To_qa    :=parallel(toq1, toq2, toq3);	

buildkeys := sequential(keys,Move_keys,To_qa);

return buildkeys;

end;

