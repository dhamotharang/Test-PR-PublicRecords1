import business_header, address, Risk_Indicators, Prte2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
df := Prte2_Business_Header.Files().Base.Business_Header_Best.Built(fein != 0);
#ELSE
df := business_header.File_Business_Header_Best(fein != 0);
#END;

export Key_BH_Fein := index(df,
		{fein,company_name},{string120 addr1 := Risk_Indicators.MOD_AddressClean.street_address('',prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range),city,state,zip,zip4},
		'~thor_Data400::key::business_InstantID_FEIN2Addr_QA');
		