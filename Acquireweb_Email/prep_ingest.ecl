IMPORT Acquireweb_Email, prte2, ut, STD, VersionControl;

EXPORT prep_ingest := FUNCTION

	version := (string8)VersionControl.fGetFilenameVersion('~thor::in::acquireweb::individuals');
	
	ind_file_in   :=  Acquireweb_Email.files.file_acquireweb_email_ind_dedup;
	
	prte2.CleanFields(ind_file_in, ClnIndvIn);
	
	fmtsin := ['%Y-%m-%d','%Y%m%d'];
	fmtout:='%Y%m%d';

	Acquireweb_Email.layouts.layout_Acquireweb_Base tAppendFields(ClnIndvIn L):=TRANSFORM
		SELF.AWID				 := L.awid_ind;
		ClnFname				 := STD.Str.CleanSpaces(L.FIRSTNAME);
		ClnLname				 := STD.Str.CleanSpaces(L.LASTNAME);
    SELF.firstname   := IF(L.FIRSTNAME = 'NULL','',ClnFname);
    SELF.lastname    := IF(L.LASTNAME = 'NULL','',ClnLname);
		SELF.dob												:= STD.Date.ConvertDateFormatMultiple(L.DOB,fmtsin,fmtout);
		SELF.date_vendor_first_reported := version;
    SELF.date_vendor_last_reported  := version;
		SELF.date_first_seen            := Std.date.ConvertDateFormatMultiple(L.IndExportDate, fmtsin, fmtout);
    SELF.date_last_seen             := SELF.date_first_seen;
		SELF.current_rec 	:= TRUE;
		SELF				:= L;
		SELF				:= [];
  end;
	
  pAppendInput	:= PROJECT(ClnIndvIn,tAppendFields(LEFT));
	
	RETURN pAppendInput;
	
END;