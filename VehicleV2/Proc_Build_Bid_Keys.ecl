import ut, autokey, AutokeyB2, RoxieKeyBuild;

export Proc_Build_Bid_Keys(string filedate) := function


RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_BID,'~thor_data400::key::vehiclev2::bid','~thor_data400::key::vehiclev2::'+filedate+'::BID',vehicle_BID_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::BID', '~thor_data400::key::vehiclev2::'+filedate+'::BID', mv_BID_key);


RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_Party_Key_FCRA_bid,'~thor_data400::key::vehiclev2::fcra::Party_Key_BID','~thor_data400::key::vehiclev2::fcra::'+filedate+'::Party_Key_BID',fcra_vehicle_bid_Party_Key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::fcra::Party_Key_BID', '~thor_data400::key::vehiclev2::fcra::'+filedate+'::Party_Key_BID', mv_fcra_bid_Party_Key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_Party_Key_bid,'~thor_data400::key::vehiclev2::Party_Key_BID','~thor_data400::key::vehiclev2::'+filedate+'::Party_Key_BID',vehicle_bid_Party_Key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::Party_Key_BID', '~thor_data400::key::vehiclev2::'+filedate+'::Party_Key_BID', mv_bid_Party_Key);

//BID autokeys

File_BID_Autokeys :=  VehicleV2.file_SearchAutokey_Party_bid;
skip_set := vehiclev2.Constant.autokey_skip_set;

AutoKeyB2.MAC_Build (File_BID_Autokeys,person_name.fname,person_name.mname,person_name.lname,
						Append_ssn,
						zero,
						zero,
						person_addr.prim_name,person_addr.prim_range,person_addr.st,person_addr.v_city_name,person_addr.zip5,person_addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookup_bit,
						Append_DID,
						Append_Clean_CName,
						Append_FEIN,
						zero,
						company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
						Append_BDID,
						VehicleV2.constant.str_Bid_AutokeyName,
						VehicleV2.constant.str_Bid_AutokeyLogicalName(filedate),
						outaction,false,
						skip_set,true,'BC',
						true,,,zero); 


AutoKeyB2.MAC_AcceptSK_to_QA(VehicleV2.constant.Str_Bid_autokeyName,mymove);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::BID',  'Q',mvTOqa_bid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::PARTY_Key_BID', 'Q',mvTOqa_bidparty_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::fcra::Party_Key_BID','Q',mvTOqa_bidparty_fcra_key,2);
r := sequential(vehicle_BID_key,mv_BID_key,mvTOqa_bid_key,
               fcra_vehicle_bid_Party_Key,mv_fcra_bid_Party_Key,mvTOqa_bidparty_fcra_key,
			   vehicle_bid_Party_Key, mv_bid_Party_Key,mvTOqa_bidparty_key,
			   outaction,mymove);
 
return r;

end;