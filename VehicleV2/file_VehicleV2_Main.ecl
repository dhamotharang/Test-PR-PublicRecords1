dVehicleV2Main	:=	dataset('~thor_data400::base::VehicleV2::Main',VehicleV2.Layout_Base_Main,flat);

export	file_VehicleV2_Main	:=	dVehicleV2Main(~(source_code	=	'DI'	and	state_origin	=	'NM'));