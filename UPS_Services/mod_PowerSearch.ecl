IMPORT iesp, Address, STD;

EXPORT mod_PowerSearch(STRING240 inQuery, BOOLEAN isCanada =FALSE) := MODULE

  SHARED psText := TRIM(STD.STR.ToUpperCase(inQuery), LEFT, RIGHT);

  SHARED psParts := RECORD
    STRING120 Name;
    STRING120 Addr;
    STRING10 Phone;
  END;
  
  SHARED psParts getParts() := FUNCTION
    regexPhone := '^(\\d{10})$';
    phone := IF(regexFind(regexPhone, psText), regexFind(regexPhone, psText, 1), '');

    regexSplitNameAddr := '^([A-Z ]+) (\\d.+)$';
    regexNameOnly := '^[A-Z ]+$';
    name := MAP( phone <> '' => '',
                 regexFind(regexSplitNameAddr, psText) => regexFind(regexSplitNameAddr, psText, 1),
                 regexFind(regexNameOnly, psText) => psText,
                 '');
    addr := MAP( phone <> '' => '',
                 regexFind(regexSplitNameAddr, psText) => regexFind(regexSplitNameAddr, psText, 2),
                 NOT regexFind(regexNameOnly, psText) => psText,
                 '');
                 
    resp := ROW( { name, addr, phone }, psParts);
    RETURN resp;
  END;

  EXPORT iesp.share.t_NameAndCompany getName() := FUNCTION
    parts := getParts();
    name := TRIM(parts.name);

    STRING clnName := IF (name <> '', Address.CleanPerson73(name), '');
    clnFirst := TRIM(clnName[6..25]);
    clnMiddle := TRIM(clnName[26..45]);
    clnLast := TRIM(clnName[46..70]);
                   
    RETURN iesp.ECL2ESP.SetNameAndCompany(
      first := clnFirst,
      middle := clnMiddle,
      last := clnLast,
      suffix := '',
      prefix := '',
      full := '',
      company := name);
  END;

    parts := getParts();
    addr := TRIM(parts.addr);

    regexStreetCityStZip := '^(.+ (RD|ST|CT|LN|CIR|DR|HWY|BLVD|TRCE|WAY)) ([A-Z ]+) ([A-Z]{2}) (\\d{5})$';
    regexOtherCityStZip := '^(.*)\\b\\s*([A-Z ]+) ([A-Z]{2}) (\\d{5})$';
    regexStateZip := '\\b([A-Z]{2}) (\\d{5})$';
    regexStreetZip := '(.+) (\\d{5})$';
    regexZip := '(\\b\\d{5})$';
    
    street := MAP(regexFind(regexStreetCityStZip, addr) => regexFind(regexStreetCityStZip, addr, 1),
                  regexFind(regexOtherCityStZip, addr) => regexFind(regexOtherCityStZip, addr, 1),
                  regexFind(regexStreetZip, addr) => regexFind(regexStreetZip, addr, 1),
                  addr);

    city := MAP(regexFind(regexStreetCityStZip, addr) => regexFind(regexStreetCityStZip, addr, 3),
                regexFind(regexOtherCityStZip, addr) => regexFind(regexOtherCityStZip, addr, 2),
                '');

    state := MAP(regexFind(regexStreetCityStZip, addr) => regexFind(regexStreetCityStZip, addr, 4),
                 regexFind(regexOtherCityStZip, addr) => regexFind(regexOtherCityStZip, addr, 3),
                 regexFind(regexStateZip, addr) => regexFind(regexStateZip, addr, 1),
                 '');
    zip := MAP(regexFind(regexStreetCityStZip, addr) => regexFind(regexStreetCityStZip, addr, 5),
               regexFind(regexOtherCityStZip, addr) => regexFind(regexOtherCityStZip, addr, 4),
               regexFind(regexStateZip, addr) => regexFind(regexStateZip, addr, 2),
               regexFind(regexStreetZip, addr) => regexFind(regexStreetZip, addr, 2),
               regexFind(regexZip, addr) => regexFind(regexZip, addr, 1),
               '');

  EXPORT paddr := iesp.ECL2ESP.SetAddress ('', // STRING28 StreetName {xpath('StreetName')};
                    '', // STRING10 StreetNumber {xpath('StreetNumber')};
                    '', // STRING2 StreetPreDirection {xpath('StreetPreDirection')};
                    '', // STRING2 StreetPostDirection {xpath('StreetPostDirection')};
                    '', // STRING4 StreetSuffix {xpath('StreetSuffix')};
                    '', // STRING10 UnitDesignation {xpath('UnitDesignation')};
                    '', // STRING8 UnitNumber {xpath('UnitNumber')};
                    city, // STRING25 City {xpath('City')};
                    state, // STRING2 State {xpath('State')};
                    zip, // STRING5 Zip5 {xpath('Zip5')};
                    '', // STRING4 Zip4 {xpath('Zip4')};
                    '', // STRING18 County {xpath('County')};
                    street, // STRING60 StreetAddress1 {xpath('StreetAddress1')};
                    '', // STRING60 StreetAddress2 {xpath('StreetAddress2')};
                    '', // STRING9 PostalCode {xpath('PostalCode')};
                    '' // STRING50 StateCityZip {xpath('StateCityZip')};
                  );

  EXPORT iesp.share.t_Address getAddress() := FUNCTION
    RETURN mod_Address(paddr,isCanada).bestParser();
  END;

  EXPORT STRING10 getPhone() := FUNCTION
    parts := getParts();
    RETURN parts.phone;
  END;

END;
