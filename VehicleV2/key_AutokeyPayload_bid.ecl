import autokeyb2,standard,doxie,ut,vehicleV2;
dBase 		  := dataset([], recordof(VehicleV2.file_SearchAutokey_Party_bid));

autokeyb2.MAC_FID_Payload(dBase ,'','','','','','','','','',append_did,append_bdid, VehicleV2.Constant.str_Bid_autokeyname + 'payload',plk,'');
export key_AutokeyPayload_bid  :=plk;  





