IMPORT Acquireweb_Email, prte2, ut, STD, VersionControl;

EXPORT prep_ingest := FUNCTION

	version := (string8)VersionControl.fGetFilenameVersion('~thor::in::acquireweb::individuals');
	
	ind_file_in   :=  Acquireweb_Email.files.file_acquireweb_email_ind_dedup;
	email_file_in :=  Acquireweb_Email.files.file_Acquireweb_Email_Emails;
	
	prte2.CleanFields(ind_file_in, ClnIndvIn);
	prte2.CleanFields(email_file_in, ClnEmailIn);
	
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
	
	dist_ind			:=	DISTRIBUTE(pAppendInput,HASH32(awid));
	dist_email		:= 	DISTRIBUTE(ClnEmailIn,HASH32(AWID_Email));

  // Join the cleaned IND file to the e-mail file - removed this from base build as email was needed for ingest process
  Acquireweb_Email.layouts.layout_Acquireweb_Base jointhem(dist_ind L,dist_email R):=TRANSFORM
    SELF.emailid:=R.emailid;
    SELF.email:=R.email;
    SELF.activecode:=map(trim(R.activecode,left,right)='Y'=>'A',
												 trim(R.activecode,left,right)='N'=>'I',
												 trim(R.activecode,left,right)='A'=>'A',
												 trim(R.activecode,left,right)='I'=>'I','');
    SELF:=L;
    SELF:=[];
  END;
  new_acquireweb_data:=	JOIN(dist_ind,dist_email,LEFT.awid=RIGHT.AWID_Email,jointhem(LEFT,RIGHT),INNER,LOCAL);
	
	RETURN pAppendInput;
	
END;