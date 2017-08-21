EXPORT File_WI_All_Available := module

shared wi_rec := 
record
   string  FULL_NAME;
   string  STREET_1;
   string  CITY_NAME;
   string STATE_CODE;
   string  ZIP_CODE;
   string  COUNTRY_NAME;
   string LICENSE_NUMBER;
   string  CRED_TYPE_ID;
   string  PROFESSION_NAME;
   string STATUS;
   string  SPECIALTY;
   string  GRANTED_DATE;
   string  RENEWAL_BY_DATE;
   string  EXPIRE_DATE;
   string  ETHNIC;
   string GENDER;
	 string CE_TO_RENEW;
	 string CE_ACC;
	 string CE_STILL_NEEDED;
   string CE_NEEDED_BY;
   string CUST_ID;
   string  DOR_TITLE_NUMBER;
   string  COUNTY;
   string  VEHICLE_ID;
   string MAKE;
   string YEAR;
   string LENGTH1;
   string WIDTH1;
   string  OWNER;
   string  LEIN_HOLDER;
   string  LEIN_HOLDER_ADDRESS;
   string  LAST_ACTION;
   string  LAST_ACTION_DATE;
   string  EMAIL;
   string NUMBER_OF_SITES;
   string  PHONE;
   string lf;
end;
      


export raw := dataset('~thor_data400::in::prolic::wi::all_available::raw',wi_rec,CSV( heading(1),separator(','),terminator(['\n','\r\n']),Quote('"'))) (full_name <> '');

end;