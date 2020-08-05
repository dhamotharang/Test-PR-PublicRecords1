IMPORT Address, DueDiligence, Risk_Indicators, STD;


EXPORT Address := MODULE

    //assumes inDS has a field named state and county
    EXPORT GetAddressCounty(inDS) := FUNCTIONMACRO
        IMPORT Census_Data, codes, STD;
         
        tempFIPS := PROJECT(inDS, TRANSFORM({RECORDOF(inDS), STRING5 tempFIPSCode, STRING countyNameText},
                                            SELF.tempFIPSCode := codes.st2FipsCode(STD.Str.ToUpperCase(LEFT.state)) + LEFT.county;
                                            SELF.countyNameText := '';
                                            SELF := LEFT;));
          
                                                                                                                                                                                         
        Census_Data.MAC_Fips2County_Keyed(tempFIPS, state, tempFIPSCode, countyNameText, addrWithCounty);
        
        RETURN addrWithCounty;
    ENDMACRO;


    EXPORT GetCleanAddress(DueDiligence.v3Layouts.Internal.Address addressToClean) := FUNCTION
        
        addr := Risk_Indicators.MOD_AddressClean.street_address(addressToClean.streetAddress1 + ' ' + addressToClean.streetAddress2, addressToClean.prim_range, 
                                                                addressToClean.predir, addressToClean.prim_name, addressToClean.addr_suffix, 
                                                                addressToClean.postdir, addressToClean.unit_desig, addressToClean.sec_range);

        cleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(addr, addressToClean.city, addressToClean.state, addressToClean.zip);											

        cleanedAddressFilds := Address.CleanFields(cleanAddr);

        street1 := Risk_Indicators.MOD_AddressClean.street_address(DueDiligence.Constants.EMPTY, cleanedAddressFilds.Prim_Range, cleanedAddressFilds.Predir, cleanedAddressFilds.Prim_Name, 
                                                                   cleanedAddressFilds.Addr_Suffix, cleanedAddressFilds.Postdir, cleanedAddressFilds.Unit_Desig, cleanedAddressFilds.Sec_Range);

        cleanedAddress := DATASET([TRANSFORM(DueDiligence.v3Layouts.Internal.Address,
                                              SELF.streetAddress1 := street1;
                                              SELF.streetAddress2 := TRIM(STD.Str.ToUpperCase(addressToClean.StreetAddress2));
                                              SELF.prim_range := cleanedAddressFilds.prim_range;
                                              SELF.predir := cleanedAddressFilds.predir;
                                              SELF.prim_name := cleanedAddressFilds.prim_name;
                                              SELF.addr_suffix := cleanedAddressFilds.addr_suffix;
                                              SELF.postdir := cleanedAddressFilds.postdir;
                                              SELF.unit_desig := cleanedAddressFilds.unit_desig;
                                              SELF.sec_range := cleanedAddressFilds.sec_range;
                                              SELF.city := cleanedAddressFilds.v_city_name;
                                              SELF.state := cleanedAddressFilds.st;
                                              SELF.zip := cleanedAddressFilds.zip;
                                              SELF.zip4 := cleanedAddressFilds.zip4;
                                              // Due Diligence logic is expecting only the last 3 digits of the full 5 digit FIPS Code           
                                              //    When it needs the full 5 digits of the FIPS Code it will generate the 5 digits 
                                              //    by converting the 2 character state code into the 2 digit numerice code and    
                                              //    concatenate the 2 digit state code with 3 digit county code to generate the    
                                              //    full 5 digits again.   This is consistent with other Risk Products               
                                              SELF.county := cleanedAddressFilds.county[3..5];
                                              SELF.geo_blk := cleanedAddressFilds.geo_blk;
                                              SELF := [];)])[1];

        RETURN cleanedAddress;
    END;


END;