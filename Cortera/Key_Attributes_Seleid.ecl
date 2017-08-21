import doxie,data_services;

attributes := Cortera.Files.Attributes(seleid<>0);
EXPORT Key_Attributes_Seleid := INDEX(attributes, {seleid}, {attributes}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::cortera::key::attr_seleid_' + doxie.version_superkey);
