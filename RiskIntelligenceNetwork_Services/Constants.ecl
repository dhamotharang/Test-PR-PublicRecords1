﻿IMPORT AutoKeyI;

EXPORT Constants := MODULE
 EXPORT STRING FRAUD_PLATFORM := 'FraudGov';

 EXPORT Fragment_Types := MODULE
  EXPORT BANK_ACCOUNT_NUMBER_FRAGMENT := 'BANK_ACCOUNT';
  EXPORT DEVICE_ID_FRAGMENT := 'DEVICE_ID';
  EXPORT DRIVERS_LICENSE_NUMBER_FRAGMENT := 'DLN';
  EXPORT GEOLOCATION_FRAGMENT := 'GEO_LOCATION';
  EXPORT IP_ADDRESS_FRAGMENT := 'IP_ADDRESS';
  EXPORT MAILING_ADDRESS_FRAGMENT := 'MAILING_ADDRESS';
  EXPORT NAME_FRAGMENT := 'FULL_NAME';
  EXPORT PERSON_FRAGMENT := 'LEXID';
  EXPORT PHONE_FRAGMENT := 'PHONENO';
  EXPORT PHYSICAL_ADDRESS_FRAGMENT := 'PHYSICAL_ADDRESS';
  EXPORT SSN_FRAGMENT := 'FULL_SSN';
  EXPORT EMAIL_FRAGMENT := 'EMAIL';
 END;

 EXPORT KelEntityIdentifier := MODULE
  EXPORT STRING LEXID := '_01';
  EXPORT STRING PHYSICAL_ADDRESS := '_09';
  EXPORT STRING SSN := '_15';
  EXPORT STRING PHONENO := '_16';
  EXPORT STRING EMAIL := '_17';
  EXPORT STRING IPADDRESS := '_18';
  EXPORT STRING BANKACCOUNT := '_19';
  EXPORT STRING DLNUMBER := '_20';
 END;

 EXPORT EntityType := MODULE
  EXPORT INTEGER LEXID := 1;
  EXPORT INTEGER PHYSICAL_ADDRESS := 9;
  EXPORT INTEGER SSN := 15;
  EXPORT INTEGER PHONENO := 16;
  EXPORT INTEGER EMAIL := 17;
  EXPORT INTEGER IPADDRESS := 18;
  EXPORT INTEGER BANKACCOUNT := 19;
  EXPORT INTEGER DLNUMBER := 20;
 END;

 EXPORT INTEGER MAX_JOIN_LIMIT := 10000;

 EXPORT FRAGMENT_SEPARATOR := '@@@';

 EXPORT RECORD_SOURCE := MODULE
  EXPORT REALTIME := 'Realtime';
  EXPORT CONTRIBUTED := 'Contributed';
 END;

 EXPORT RECORD_TYPE := MODULE
  EXPORT ELEMENT := 'Element';
  EXPORT IDENTITY := 'Identity';
 END;

 // Mapping the FDN file type field above to our usage of the field for FraudGov
 // file_type 2 is reserved for Applicable Public Records, not used for FraudGov.
 // file_type 4 is reserved for Relationship Analytics, not used for FraudGov.
 EXPORT PayloadFileTypeEnum := ENUM(unsigned1,KnownFraud=1,IdentityActivity=3,StatusUpdate=5);

 EXPORT appends_value := 'BEST_ALL';
 EXPORT verify_value := 'BEST_ALL';

 //Error's
 EXPORT INVALID_INPUT_CODE := AutoKeyI.errorcodes._codes.INVALID_INPUT; // 303
 EXPORT INVALID_INPUT_MSG  := AutoKeyI.errorcodes._msgs(INVALID_INPUT_CODE);
 EXPORT INSUFFICIENT_INPUT_CODE := AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT; // 301
 EXPORT INSUFFICIENT_INPUT_MSG  := AutoKeyI.errorcodes._msgs(INSUFFICIENT_INPUT_CODE);
 EXPORT TOO_MAY_RECORDS_CODE := AutoKeyI.errorcodes._codes.TOO_MANY_SUBJECTS; // 203
 EXPORT TOO_MAY_RECORDS_MSG  := AutoKeyI.errorcodes._msgs(TOO_MAY_RECORDS_CODE);

 EXPORT STRING PREPAID_VALUE := '1';
 EXPORT RIN_ID_START_VALUE := 900000000000;
 EXPORT CURR_PROFILE_FLAG := 1;
 
 EXPORT IP_ADDRESS_ELEMENT := MODULE
  EXPORT IP_ADDRESS_WILD_CHAR := ['x', 'X'];
  EXPORT APPEND_THREE_ZERO := '000';
  EXPORT APPEND_TWO_ZERO := '00';
  EXPORT APPEND_ONE_ZERO := '0';
 END;

 EXPORT INQUIRY_SOURCE := 'RIN_API';
 
 EXPORT IDENTITY_FLAGS := MODULE
  EXPORT IDENTITY_IN_CONTRIB := 'Y';
  EXPORT IDENTITY_NOT_FOUND := 'N';
  EXPORT REALTIME_IDENTITY := 'R';
  EXPORT UNSCORABLE_IDENTITY := 'U';
  EXPORT MULTIPLE_IDENTITY := 'M';
 END;
END;