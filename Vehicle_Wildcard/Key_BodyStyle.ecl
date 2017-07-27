Import Data_Services, VehicleV2, VehLic,doxie, ut;

EXPORT Key_BodyStyle :=  index(VehicleV2.Files.base.BodyStyle(category <>'category'), {body_style, i}, {body_style_description,category},
							Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::wc_vehicle::bodystyle_'+doxie.Version_SuperKey);