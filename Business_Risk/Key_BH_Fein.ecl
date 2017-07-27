import business_header, address, Risk_Indicators;

export Key_BH_Fein := index(business_header.File_Business_Header_Best(fein != 0),
		{fein,company_name},{string120 addr1 := Risk_Indicators.MOD_AddressClean.street_address('',prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range),city,state,zip,zip4},
		'~thor_Data400::key::business_InstantID_FEIN2Addr_QA');
		