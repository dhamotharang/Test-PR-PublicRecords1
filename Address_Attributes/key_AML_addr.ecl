IMPORT ADDRESS_ATTRIBUTES, DOXIE, data_services;

ds := PROJECT(Address_Attributes.file_BIP_risk(zip<> '00000'), Address_Attributes.Layouts.rBIP_AML);

EXPORT key_AML_addr	:= INDEX(ds, 																												  				//dataset
														{zip, prim_range, prim_name, addr_suffix, predir, postdir},						//key fields
														{ds},  																																//layout
														data_services.data_location.prefix() + 'thor_data400::key::'+doxie.Version_SuperKey+'::bipv2_aml_addr');		//file