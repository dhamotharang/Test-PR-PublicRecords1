export Layout_Tx_Ftact := 
record
      string11  IGS_IN_TAXNO;
      string50  IGS_IN_NAME; 
      string40  IGS_IN_TAXPAYER_ADDRESS;
      string20  IGS_IN_TAXPAYER_CITY;
      string2   IGS_IN_TAXPAYER_STATE; 
      string5   IGS_IN_TAXPAYER_ZIPCODE;   
      string3   IGS_IN_TAXPAYER_COUNTY;
      string2   IGS_IN_TAXPAYER_ORG;
      string10  IGS_IN_TAXPAYER_PHONE;
      string1   IGS_IN_REC_TYPE;
      string8   IGS_IN_BEGIN_DATE;
      string8   IGS_IN_END_DATE;
      string2   IGS_IN_END_REASON_CODE;
      string10  IGS_IN_CHARTER_NUMBER;
      //string2   IGS_IN_CORP_TYPE;
      string8   IGS_IN_SOS_CHAR_DATE;
      string8   IGS_IN_SOS_CODE_DATE;
      string2   IGS_IN_SOS_STATUS;
      string1   IGS_IN_STANDING;
      string8   IGS_IN_STANDING_DATE;
      string3   IGS_IN_CURR_EXEMPT_REASON;
      string8   IGS_IN_EXEMPT_BEGIN_DATE;
      string6   NAICS_CODE;
      string2   crlf;
end;
