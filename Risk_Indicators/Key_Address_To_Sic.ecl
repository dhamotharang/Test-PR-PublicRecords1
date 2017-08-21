import risk_indicators,business_header,ut,PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
dAddrSicCodeBase := PRTE2_Business_Header.Files_Prte_Addr_HRI_Keys().Addr_To_Siccode;
#ELSE
dAddrSicCodeBase := files().AddressSicCode.built((integer)zip<>0);
#END;

Export Key_Address_To_Sic := index(dAddrSicCodeBase, 
                                       {z5 := zip,prim_name,
                                        suffix := addr_suffix,predir,
                                        postdir,prim_range,sec_range},
                                       {sic_code, source},
                                       keynames().AddressSicCode.qa);