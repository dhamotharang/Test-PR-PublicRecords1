import PRTE2_Vehicle, mdr;

//*** Keeping records with orig_name_type of '1', '4' & '5' as per bug# 139354
EXPORT File_VehicleV2_Base := project(PRTE2_Vehicle.File_VehicleV2_Party_Building(trim(vehicle_key) <> '' and ultid <> 0 and orig_name_type in ['1','4','5']),
																			transform({PRTE2_Vehicle.Layouts.Party_Building, string2 source := ''}, self.source := MDR.sourceTools.fVehicles(left.state_origin,left.source_code),self := left))
																			:persist('~prte::persist::PRTE2_BIPV2_WAF::File_VehicleV2_Base');