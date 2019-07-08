﻿IMPORT Address, DueDiligence, Risk_Indicators, STD;

EXPORT CommonAddress := MODULE


    EXPORT GetCleanAddress(DueDiligence.Layouts.Address addressToClean) := FUNCTION
        
        addr := Risk_Indicators.MOD_AddressClean.street_address(addressToClean.streetAddress1 + ' ' + addressToClean.streetAddress2, addressToClean.prim_range, 
                                                                addressToClean.predir, addressToClean.prim_name, addressToClean.addr_suffix, 
                                                                addressToClean.postdir, addressToClean.unit_desig, addressToClean.sec_range);

        cleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(addr, addressToClean.city, addressToClean.state, addressToClean.zip5);											

        cleanedAddressFilds := Address.CleanFields(cleanAddr);

        street1 := Risk_Indicators.MOD_AddressClean.street_address(DueDiligence.Constants.EMPTY, cleanedAddressFilds.Prim_Range, cleanedAddressFilds.Predir, cleanedAddressFilds.Prim_Name, 
                                                                   cleanedAddressFilds.Addr_Suffix, cleanedAddressFilds.Postdir, cleanedAddressFilds.Unit_Desig, cleanedAddressFilds.Sec_Range);

        cleanedAddress := DATASET([TRANSFORM(DueDiligence.Layouts.Address,
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
                                              SELF.zip5 := cleanedAddressFilds.zip;
                                              SELF.zip4 := cleanedAddressFilds.zip4;
                                              SELF.cart := cleanedAddressFilds.cart;
                                              SELF.cr_sort_sz := cleanedAddressFilds.cr_sort_sz;
                                              SELF.lot := cleanedAddressFilds.lot;
                                              SELF.lot_order := cleanedAddressFilds.lot_order;
                                              SELF.dbpc := cleanedAddressFilds.dbpc;
                                              SElF.chk_digit := cleanedAddressFilds.chk_digit;
                                              SELF.rec_type := cleanedAddressFilds.rec_type;
                                              // Due Diligence logic is expecting only the last 3 digits of the full 5 digit FIPS Code           
                                              //    When it needs the full 5 digits of the FIPS Code it will generate the 5 digits 
                                              //    by converting the 2 character state code into the 2 digit numerice code and    
                                              //    concatenate the 2 digit state code with 3 digit county code to generate the    
                                              //    full 5 digits again.   This is consistent with other Risk Products               
                                              SELF.county := cleanedAddressFilds.county[DueDiligence.Constants.FIRST_POS..DueDiligence.Constants.LAST_POS];
                                              SELF.geo_lat := cleanedAddressFilds.geo_lat;
                                              SELF.geo_long := cleanedAddressFilds.geo_long;
                                              SELF.msa := cleanedAddressFilds.msa;
                                              SELF.geo_blk := cleanedAddressFilds.geo_blk;
                                              SELF.geo_match := cleanedAddressFilds.geo_match;
                                              SELF.err_stat := cleanedAddressFilds.err_stat;
                                              SELF := [];)])[1];

        RETURN cleanedAddress;
    END;

END;