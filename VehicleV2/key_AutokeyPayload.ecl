import autokeyb2,standard,doxie,ut,vehicleV2;

dBase 		  := dataset([], recordof(VehicleV2.file_SearchAutokey_Party));

autokeyb2.MAC_FID_Payload(dBase ,'','','','','','','','','',append_did,append_bdid, VehicleV2.Constant.str_autokeyname + 'payload',plk,'');
export key_AutokeyPayload :=plk;  





