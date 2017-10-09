IMPORT ADDRESS_ATTRIBUTES, DOXIE, UT, Data_Services;

ds := PROJECT(PRTE2_BIPV2_BusHeader.file_BIP_risk(zip<> '00000'), Address_Attributes.Layouts.rBIP_AML);

EXPORT Key_AML_addr	:= INDEX(ds, 																												  				//dataset
														{zip, prim_range, prim_name, addr_suffix, predir, postdir},						//key fields
														{ds},  																																//layout
														'~prte::key::'+doxie.Version_SuperKey+'::bipv2_aml_addr');		//file