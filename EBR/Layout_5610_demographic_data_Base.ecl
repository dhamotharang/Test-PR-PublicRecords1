import address, dx_common;

export Layout_5610_demographic_data_Base := 
record
   Layout_Base;
   unsigned6  did        := 0;
   unsigned1  did_score  := 0;
   unsigned4  ssn        := 0;
   string8    process_date;
   string10   FILE_NUMBER;
   string4    SEGMENT_CODE;
   string5    SEQUENCE_NUMBER;
   string2    FISCAL_YR_END_MM;
   string1    PROFIT_RANGE_CODE;
   string25   PROFIT_RANGE_DESC;
   string7    PROFIT_RANGE_ACTUAL;
   string1    NET_WORTH_CODE;
   string25   NET_WORTH_DESC;
   string7    NET_WORTH_ACTUAL;
   string4    IN_BLDNG_SINCE_YY;
   string1    OWN_OR_RENT_CODE;
   string7    BLDNG_SQUARE_FEET;
   string7    ACTIVE_CUST_COUNT;
   string1    OWNERSHIP_CODE;
   string20   OWNERSHIP_DESC;
   string31   CORP_NAME;
   string20   CORP_CITY;
   string2    CORP_STATE_CODE;
   string20   CORP_STATE_DESC;
   string10   CORP_PHONE;
   string10   OFFICER_TITLE;
   string10   OFFICER_FIRST_NAME;
   string1    OFFICER_M_I;
   string20   OFFICER_LAST_NAME;
   address.Layout_Clean_Name clean_officer_name;
   dx_common.layout_metadata - [global_sid, record_sid];
end;