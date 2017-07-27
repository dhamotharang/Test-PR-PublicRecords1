Import Data_Services,	address_attributes, risk_indicators,VehicleV2,VehLic,Doxie,ut,lib_StringLib,NID;

vehicle_slim_dist	:=	Address_Attributes.file_vehicles;

cleaned	:=	vehicle_slim_dist(	zip5				!=	''	and 
																prim_range	!=	''	and 
																prim_name 	!=''
															);
								
export	key_vehicles_addr	:=	index(cleaned,
																			{zip5,prim_range,prim_name,suffix,predir},
																			{cleaned},
																			Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::vehiclev2::vehicles_address_'	+	doxie.Version_SuperKey
																		);

