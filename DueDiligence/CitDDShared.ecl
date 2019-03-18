IMPORT Address, DueDiligence, Risk_Indicators, STD;

EXPORT CitDDShared := MODULE

  //constants shared between Citizenship and Due Diligence
  EXPORT VALIDATION_INVALID_GLB := 'Not an allowable GLB permissible purpose';
  EXPORT VALIDATION_INVALID_DPPA := 'Not an allowable DPPA permissible purpose';
  EXPORT VALIDATION_INVALID_DD_ATTRIBUTE_REQUEST_WITH_CITIZENSHIP := 'Business attributes are not valid with a citizenship request';
  EXPORT VALIDATION_INVALID_PRODUCT_REQUEST_TYPE := 'Product Request Type is required or invalid. Product Request Type = AttributesOnly, CitizenshipOnly or AttributesAndCitizenship';

  
  //we want to use the standard BS Options used in the Boca Shell.  
  EXPORT INTEGER DEFAULT_BS_VERSION := 52;
	EXPORT UNSIGNED8 DEFAULT_BS_OPTIONS :=  (risk_indicators.iid_constants.BSOptions.IncludeDoNotMail +
                                          risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity +
                                          risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary);
  
  EXPORT PRODUCT_REQUESTED_ENUM := ENUM(UNSIGNED1, EMPTY=0, ATTRIBUTES_ONLY=1, CITIZENSHIP_ONLY=2, BOTH=3);
  
  EXPORT DUEDILIGENCE_PRODUCTS := [PRODUCT_REQUESTED_ENUM.ATTRIBUTES_ONLY, PRODUCT_REQUESTED_ENUM.BOTH];
  EXPORT CITIZENSHIP_PRODUCTS := [PRODUCT_REQUESTED_ENUM.CITIZENSHIP_ONLY, PRODUCT_REQUESTED_ENUM.BOTH];
  
  EXPORT VALID_REQUESTED_PRODUCTS := ['attributesonly', 'citizenshiponly', 'attributesandcitizenship'];
  



  
  EXPORT isValidGLBA(UNSIGNED1 glbPurpose) := FUNCTION
    RETURN (glbPurpose BETWEEN 0 AND 7) OR glbPurpose = 11 OR glbPurpose = 12;
  END;
  
  EXPORT isValidDPPA(UNSIGNED1 dppaPurpose) := FUNCTION
    RETURN dppaPurpose BETWEEN 0 AND 7;
  END;
  
  EXPORT cleanAddress(DueDiligence.Layouts.Address addressToClean) := FUNCTION
    
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
  
  
  EXPORT stripNonNumericValues(STRING stringToStrip) := FUNCTION
    strippedString := STD.Str.Filter(stringToStrip, DueDiligence.Constants.NUMERIC_VALUES);
    
    RETURN TRIM(strippedString);
  END;
  
  EXPORT mapFullName := MACRO
    unparsedName := STD.Str.ToUpperCase(LEFT.individual.name.fullName);
    fName := STD.Str.ToUpperCase(LEFT.individual.name.firstName);
    mName := STD.Str.ToUpperCase(LEFT.individual.name.middleName);
    lName := STD.Str.ToUpperCase(LEFT.individual.name.lastName);
    sName := STD.Str.ToUpperCase(LEFT.individual.name.suffix);
    
    
    cleanedName := MAP(STD.Str.ToUpperCase(LEFT.individual.nameInputOrder) = 'FML' => Address.CleanPersonFML73(unparsedName),
                       STD.Str.ToUpperCase(LEFT.individual.nameInputOrder) = 'LFM' => Address.CleanPersonLFM73(unparsedName),
                       Address.CleanPerson73(unparsedName));	

    cleanedFirst := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[6..25]), DueDiligence.Constants.EMPTY);
    cleanedMiddle := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[26..45]), DueDiligence.Constants.EMPTY);
    cleanedLast := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[46..65]), DueDiligence.Constants.EMPTY);
    cleanedSuffix := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[66..70]), DueDiligence.Constants.EMPTY);

    SELF.fullName := unparsedName;
    SELF.firstName := IF(fName = DueDiligence.Constants.EMPTY, cleanedFirst, fName);
    SELF.middleName := IF(mName = DueDiligence.Constants.EMPTY, cleanedMiddle, mName);
    SELF.lastName := IF(lName = DueDiligence.Constants.EMPTY, cleanedLast, lName);
    SELF.suffix := IF(sName = DueDiligence.Constants.EMPTY, cleanedSuffix, sName);                                                                                                    
  ENDMACRO;



END;