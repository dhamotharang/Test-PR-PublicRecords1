import risk_indicators;

hri_base_file := risk_indicators.File_HRI_Address_Sic((integer)zip<>0);

export Key_HRI_Address_To_Sic_Prep := index(hri_base_file, 
                                      {z5 := zip,prim_name,
                                       suffix := addr_suffix,predir,
                                       postdir,prim_range,sec_range},
                                       {sic_code},
                                       '~thor_data400::key::hri_address_to_sic' + thorlib.WUID());