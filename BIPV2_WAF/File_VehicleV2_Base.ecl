import VehicleV2, mdr;

//*** Keeping records with orig_name_type of '1', '4' & '5' as per bug# 139354
EXPORT File_VehicleV2_Base := project(vehicleV2.File_VehicleV2_Party_Building(trim(vehicle_key) <> '' and ultid <> 0 and orig_name_type in ['1','4','5']),
																			transform({VehicleV2.Layout_Base.Party_Base_BIP, string2 source := ''}, self.source := MDR.sourceTools.fVehicles(left.state_origin,left.source_code),self := left))
																			:persist('~thor_data400::persist::BIPV2_WAF::File_VehicleV2_Base');