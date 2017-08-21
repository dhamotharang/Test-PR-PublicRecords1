EXPORT Constants := MODULE

  EXPORT ClientID := MODULE
    export string NCO := 'NCO';
    export string PRA := 'PRA';
    export string BWH := 'BWH';
  END;

  // frequency type
  EXPORT T_FREQUENCY := MODULE
    export string1 NONE  := '';
    export string1 MONTH := 'M';
    export string1 WEEK  := 'W';
    export string1 DAY   := 'D';
  END;

  // Monitor subject
  EXPORT T_SUBJECT := MODULE
    export unsigned2 NONE     := 0;
    export unsigned2 ADDRESS  := 1;
    export unsigned2 PHONE    := 2;
    export unsigned2 PROPERTY := 4;
    export unsigned2 PAW      := 8;
  END;

  EXPORT unsigned1 MAX_SUBJECTS := 16;

  // phone types
  EXPORT T_PHONES := MODULE
    export unsigned2 PHONE_TA := 1;
    export unsigned2 PHONE_TB := 2;
    export unsigned2 PHONE_TD := 4;
    export unsigned2 PHONE_TG := 8;
    export unsigned2 PHONE_TC := 16;
  END;

  EXPORT string ValidDataTypes := 'APRW';

  EXPORT ERR_CODE := MODULE
    export unsigned1 NOERR := 0; // success
    export unsigned1 PERSON    := 2; // for example, personal info
    export unsigned1 REQUEST_TYPE := 32; // request type: must be A,P,R,W or any combination of these.

    // fatal errors:
    export unsigned1 CLIENT_ID := 1; // invalid/suspicious customer ID (for NCO: server and/or worksource)
    export unsigned1 ACCOUNT   := 4; // invalid record id (NCO: account_identifier)
    export unsigned1 REQUEST   := 8; // like, transaction request
    export unsigned1 RECORD_NOT_FOUND := 16;
  END;

END;