import Doxie, business_header, Data_Services,tools, vault, _control;

hri_base_file := files().HRIAddressSicCodeFCRA.built((integer)zip<>0);

tools.mac_FilesIndex('hri_base_file	,{z5 := zip,prim_name, suffix := addr_suffix,predir, postdir,prim_range,sec_range,dt_first_seen},{sic_code, company_name, city, state, source}',keynames(doxie.Version_SuperKey).HRIAddress_fcra_filtered			,fcra_key 	);

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_HRI_Address_To_Sic_filtered_FCRA := vault.risk_indicators.key_HRI_Address_To_SIC_filtered_FCRA;
#ELSE
export Key_HRI_Address_To_Sic_filtered_FCRA := fcra_key.new;
#END;



