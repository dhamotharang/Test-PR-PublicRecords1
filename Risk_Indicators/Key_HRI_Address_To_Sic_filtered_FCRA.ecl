import Doxie, business_header, Data_Services,tools;

hri_base_file := files().HRIAddressSicCodeFCRA.built((integer)zip<>0);

tools.mac_FilesIndex('hri_base_file	,{z5 := zip,prim_name, suffix := addr_suffix,predir, postdir,prim_range,sec_range,dt_first_seen},{sic_code, company_name, city, state, source}',keynames(doxie.Version_SuperKey).HRIAddress_fcra_filtered			,fcra_key 	);

export Key_HRI_Address_To_Sic_filtered_FCRA := fcra_key.new;
