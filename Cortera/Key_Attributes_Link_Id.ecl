import doxie,data_services;

attributes := Cortera.Files.Attributes;
EXPORT Key_Attributes_Link_Id := INDEX(attributes, {ULTIMATE_LINKID}, {attributes}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::cortera::key::attr_linkid_' + doxie.version_superkey);
						