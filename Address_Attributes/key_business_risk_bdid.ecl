import address_attributes, doxie, data_services;

ds := Address_Attributes.file_business_risk;

export key_business_risk_bdid:=INDEX(ds, 																												       			//dataset
																		{bdid},  											 																					//key fields
																		{ds},  																												   			 	//layout
																		data_services.data_location.prefix() + 'thor_data400::key::business_header::'+doxie.Version_SuperKey+'::business_risk_bdid'); 	//file