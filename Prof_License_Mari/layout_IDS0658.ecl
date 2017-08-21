// IDS0658 / Idaho Dept of Finance / Multiple Professions //

export layout_IDS0658 := module

export mortgage := RECORD
string20   LICENSE_NUMBER;
string75   COMPANY_NAME;
string20   HOME_OFFICE_NUMR;
string75   ATTENTION;
string75   STREET_ADDR;
string40   CITY;
string5    STATE;
string10   ZIP;
string18   PHONE;
string18   FAX;
string250  DBA;
string15   EFFECTIVE_DATE;
string50   COMPANY_TYPE;
END;

export icc := RECORD
string20   LICENSE_NUMBER;
string75   COMPANY_NAME;
string75   ATTENTION;
string75   STREET_ADDR;
string40   CITY;
string5    STATE;
string10   ZIP;
string18   PHONE;
string18   FAX;
string250  DBA;
string50   COMPANY_TYPE;
END;

export common := RECORD
string20   LICENSE_NUMBER;
string75   COMPANY_NAME;
string20   HOME_OFFICE_NUMR;
string75   ATTENTION;
string75   STREET_ADDR;
string40   CITY;
string5    STATE;
string10   ZIP;
string18   PHONE;
string18   FAX;
string250  DBA;
string15   EFFECTIVE_DATE;
string50   COMPANY_TYPE;
END;


END;