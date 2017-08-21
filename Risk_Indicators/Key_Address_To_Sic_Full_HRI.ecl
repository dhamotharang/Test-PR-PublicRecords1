import risk_indicators,business_header,ut,PRTE2_Business_Header;


#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
dAddrSicCodeBase := PRTE2_Business_Header.Files_Prte_Addr_HRI_Keys().Address_To_Sic_Full_HRI;
#ELSE
dAddrSicCodeBase := files().AddressSicCode.built((integer)zip<>0, sic_code in set_HRI_Sics);
#END;

Export Key_Address_To_Sic_Full_HRI := index(dAddrSicCodeBase, 
                                       {z5 := zip,prim_name,
                                        suffix := addr_suffix,predir,
                                        postdir,prim_range,sec_range},
                                       {sic_code, Source},
                                       keynames().AddressSicCodeFullHRI.qa);