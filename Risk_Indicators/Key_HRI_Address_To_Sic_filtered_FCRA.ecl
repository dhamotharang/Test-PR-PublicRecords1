import Doxie, business_header, Data_Services, tools, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
hri_base_file := PRTE2_Business_Header.Files_Prte_Addr_HRI_Keys().HRI_Addr_To_Sic_Filtered_Fcra;
#ELSE
hri_base_file := files().HRIAddressSicCodeFCRA.built((integer)zip<>0);
#END;

tools.mac_FilesIndex('hri_base_file	,{z5 := zip,prim_name, suffix := addr_suffix,predir, postdir,prim_range,sec_range,dt_first_seen},{sic_code, company_name, city, state, source}',keynames(doxie.Version_SuperKey).HRIAddress_fcra_filtered			,fcra_key 	);

export Key_HRI_Address_To_Sic_filtered_FCRA := fcra_key.new;
