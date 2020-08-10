IMPORT iesp, Address;

// NOTE -
// When streetIsPrimRange do not set the StreetAddress1 and StreetAddress2 values in response
// addresses. There is at least one special hack (and others may be added
// later!) which override the default behavior of the cleaner.
//
// If values are returned in the StreetAddress fields and field values are
// later accessed through AutoStandard.InterfaceTranslator, the address will
// be re-parsed resulting in undesirable results. The values returned by
// this module are expected to be the final parsed values used throughout
// UPS Services.

EXPORT mod_Address(iesp.share.t_Address inAddr, BOOLEAN isCanada = FALSE) := MODULE

  SHARED enoughToClean(iesp.share.t_Address inp) :=
    (IF (isCanada, inp.PostalCode, inp.Zip5) <> '') OR
    (inp.City <> '' AND inp.State <> '' );

  inStreetAddrType1 := TRIM(TRIM(inAddr.StreetAddress1) + ' ' + TRIM(inAddr.StreetAddress2));
  inStreetAddrType2 := TRIM(TRIM(inAddr.StreetNumber) + ' ' +
                            TRIM(inAddr.StreetPreDirection) + ' ' +
                               TRIM(inAddr.StreetName) + ' ' +
                            TRIM(inAddr.StreetSuffix) + ' ' +
                            TRIM(inAddr.StreetPostDirection) + ' ' +
                            TRIM(inAddr.UnitDesignation) + ' ' +
                            TRIM(inAddr.UnitNumber)
                              );
                            
  SHARED inStreetAddr := IF(TRIM(inStreetAddrType1) <> '',inStreetAddrType1,inStreetAddrType2);
  
  inZip5 := TRIM(inAddr.Zip5, LEFT, RIGHT);
  SHARED useZip5 := MAP(LENGTH(inZip5) = 5 => inZip5,
                        LENGTH(inZip5) = 4 => '0' + inZip5,
                        LENGTH(inZip5) = 3 => '00' + inZip5,
                        LENGTH(inZip5) = 2 => '000' + inZip5,
                        ''); // IF inZip5 was NOT given, it's '0' so force to empty STRING

  SHARED inCityStateZip := inAddr.City + ', ' + inAddr.State + ' ' + useZip5;

  // per bugzilla 38155, if only a one to six digit numeric value is given as
  // the street address, force it into the primray range field. Default
  // behavior of the cleaner is to place this value into the primary name.
  SHARED streetIsPrimRange := REGEXFIND('^\\d{1,6}$', inStreetAddr);
  SHARED useStreetAddr := IF(streetIsPrimRange, '', inStreetAddr);
  SHARED CountryCode := IF (isCanada , address.Components.Country.CA,address.Components.Country.US);
  // the address cleaner is only useful if we have a city/state or a zip code
  // included with the input. If neither are input, the cleaner does not even
  // attempt to parse the street address and returns an empty response. In
  // these cases, we'll use a bogus city/state/zip to force a parse of the
  // street, but will exclude the artificial data from the response.
  EXPORT multi() := FUNCTION
    enough := enoughToClean(inAddr);
    fakeCityStateZip := IF(CountryCode =address.Components.Country.CA ,'NOREALCITY, BC XXXXX','NOREALCITY, NY 00000');
    clnAddr := Address.GetCleanAddress( useStreetAddr,
                                        IF(enough, inCityStateZip, fakeCityStateZip),
                                        CountryCode).results;
                
    iesp.share.t_Address MA() := TRANSFORM
      SELF.StreetName := clnAddr.prim_name;
      SELF.StreetNumber:= IF(streetIsPrimRange, inStreetAddr, clnAddr.prim_range);
      SELF.StreetPreDirection := clnAddr.predir;
      SELF.StreetPostDirection := clnAddr.postdir;
      SELF.StreetSuffix := clnAddr.suffix;
      SELF.UnitDesignation := clnAddr.unit_desig;
      SELF.UnitNumber := clnAddr.sec_range;
      SELF.StreetAddress1 := useStreetAddr;
      SELF.StreetAddress2 := '';
      SELF.City := IF(enough, clnAddr.v_city, inAddr.city);
      SELF.state := IF(enough, clnAddr.state, inAddr.state);
      SELF.zip5 := IF(enough, clnAddr.zip, useZip5);
      SELF.zip4 := IF(enough, clnAddr.zip4, '');
      SELF.county := '';
      SELF.postalcode := clnAddr.postal_code;
      SELF.statecityzip := '';
    END;
    
    r := DATASET([MA()])[1];
          
    RETURN r;
  END;
  
  // given our inputs, which is the better parsing method?
  EXPORT iesp.share.t_Address bestparser() := FUNCTION
    raw_resp := multi();

    // sometimes, we get a street address input along the lines of "3688 JONES
    // BLVD 400". Without a unit designation (APT, UNIT, STE, etc.), the
    // address cleaner really doesn't do a good job, and outputs "JONES BLVD
    // 400" as the primary name. We'll attempt to catch these and correct
    // them in most cases.

    secRangeRegex:= '^(.+)\\s+(AVE|BLVD|CIR|HWY|PKWY|PL|RD|ST|TER|TRCE|TRL|WAY)\\s+(\\d+)\\s*$';

    hasStealthSecRange := raw_resp.StreetName <> '' AND
                          raw_resp.StreetSuffix = '' AND
                          raw_resp.UnitNumber = '' AND
                          REGEXFIND(secRangeRegex, raw_resp.StreetName);

    primNameFromRegex := REGEXFIND(secRangeRegex, raw_resp.StreetName, 1);
    suffixFromRegex := REGEXFIND(secRangeRegex, raw_resp.StreetName, 2);
    secRangeFromRegex := REGEXFIND(secRangeRegex, raw_resp.StreetName, 3);

    iesp.share.t_Address MA() := TRANSFORM
      SELF.StreetName := IF(hasStealthSecRange, primNameFromRegex, raw_resp.StreetName);
      SELF.StreetNumber:= raw_resp.StreetNumber;
      SELF.StreetPreDirection := raw_resp.StreetPreDirection;
      SELF.StreetPostDirection := raw_resp.StreetPostDirection;
      SELF.StreetSuffix := IF(hasStealthSecRange, suffixFromRegex, raw_resp.StreetSuffix);
      SELF.UnitDesignation := raw_resp.UnitDesignation;
      SELF.UnitNumber := IF(hasStealthSecRange, secRangeFromRegex, raw_resp.UnitNumber);
      SELF.StreetAddress1 := raw_resp.StreetAddress1;
      SELF.StreetAddress2 := raw_resp.StreetAddress2;
      SELF.City := raw_resp.City;
      SELF.state := raw_resp.State;
      SELF.zip5 := raw_resp.Zip5;
      SELF.zip4 := raw_resp.Zip4;
      SELF.county := raw_resp.County;
      SELF.postalcode := raw_resp.PostalCode;
      SELF.statecityzip := raw_resp.StateCityZip;
    END;
    
    fixed_resp := DATASET([MA()])[1];

    RETURN fixed_resp;
  END;

END;
