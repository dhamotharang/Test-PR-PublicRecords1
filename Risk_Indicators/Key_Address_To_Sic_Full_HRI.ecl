import risk_indicators,business_header,ut;

dAddrSicCodeBase := files().AddressSicCode.built((integer)zip<>0, sic_code in set_HRI_Sics);

Export Key_Address_To_Sic_Full_HRI := index(dAddrSicCodeBase, 
                                       {z5 := zip,prim_name,
                                        suffix := addr_suffix,predir,
                                        postdir,prim_range,sec_range},
                                       {sic_code, Source},
                                       keynames().AddressSicCodeFullHRI.qa);