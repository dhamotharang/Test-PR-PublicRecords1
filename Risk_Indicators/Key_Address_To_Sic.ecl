import risk_indicators,business_header,ut;

dAddrSicCodeBase := files().AddressSicCode.built((integer)zip<>0);

Export Key_Address_To_Sic := index(dAddrSicCodeBase, 
                                       {z5 := zip,prim_name,
                                        suffix := addr_suffix,predir,
                                        postdir,prim_range,sec_range},
                                       {sic_code, source},
                                       keynames().AddressSicCode.qa);