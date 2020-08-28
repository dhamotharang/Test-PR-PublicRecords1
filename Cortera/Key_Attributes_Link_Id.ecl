import doxie,data_services;

attributes := Cortera.Files().Base.Attributes.Built;
EXPORT Key_Attributes_Link_Id := INDEX(attributes, {ULTIMATE_LINKID}, {attributes}, 
				Data_Services.Data_location.Prefix('tools')+'thor_data400::key::cortera::'+ doxie.Version_SuperKey + '::attr_linkid');
						