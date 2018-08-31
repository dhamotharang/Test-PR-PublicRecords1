IMPORT Acquireweb_Plus, MDR, prte2, ut, STD, VersionControl;

EXPORT prep_business_ingest := FUNCTION

	version := (string8)VersionControl.fGetFilenameVersion('~thor::in::acquireweb::business');
	
	business_file_in  := Acquireweb_Plus.files.Email_Busi_dedup;
	
	prte2.CleanFields(business_file_in, ClnBusinessIn);

	Acquireweb_Plus.layouts.Business_Base tAppendFields(ClnBusinessIn L):=TRANSFORM
		SELF.AWID				 := L.AWID_Business;
	  trimaddress1     := STD.Str.CleanSpaces(IF(TRIM(L.address1) = 'NULL','',L.address1));
		trimaddress2     := STD.Str.CleanSpaces(IF(TRIM(L.address2) = 'NULL','',L.address2));
	  SELF.address1    := trimaddress1;
		SELF.address2    := trimaddress2;
		SELF.clean_title := '';
		ClnFname				 := STD.Str.CleanSpaces(L.FIRSTNAME);
		ClnLname				 := STD.Str.CleanSpaces(L.LASTNAME);
    SELF.firstname   := IF(L.FIRSTNAME = 'NULL','',L.FIRSTNAME);
    SELF.lastname    := IF(L.LASTNAME = 'NULL','',L.LASTNAME);
		SELF.date_vendor_first_reported := version;
    SELF.date_vendor_last_reported  := version;
		SELF.current_rec 	:= TRUE;
		SELF.SOURCE	:= MDR.sourceTools.src_Acquiredweb_plus;
		SELF				:= L;
		SELF				:= [];
  end;
	
  pAppendInput	:= PROJECT(ClnBusinessIn,tAppendFields(LEFT));
	
	RETURN pAppendInput;
END;