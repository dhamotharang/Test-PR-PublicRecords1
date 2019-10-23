IMPORT DunnData_Email, STD, ut, PRTE2, VersionControl;

EXPORT prep_ingest_file := FUNCTION

	version := (string8)VersionControl.fGetFilenameVersion(DunnData_Email.thor_cluster+'in::email::dunndata_email');

	fmtsin := ['%Y%m%d', '%Y-%m-%d', '%m/%d/%Y'];
	fmtout:= '%Y%m%d';
	
	//Populate added fields prior to cleaning
	DunnData_Email.Layouts.Base tAppendFields(DunnData_Email.Layouts.Input pInput) := TRANSFORM
		self.email											:= REGEXREPLACE('^[~]+',pInput.email,'');
		self.name_full									:= REGEXREPLACE('^[`,%]|Z{3,}',pInput.name_full,'');
		self.address1										:= REGEXREPLACE('^[!]|Z{3,}',pInput.address1,'');
		self.address2										:= IF(LENGTH(TRIM(pInput.address2)) = 1 AND REGEXFIND('[^A-Z,0-9]',pInput.address2),'',pInput.address2);
		self.zip5												:= STD.Str.Filter(pInput.zip5,'1234567890');
		self.ZIP_ext										:= STD.Str.Filter(pInput.ZIP_ext,'1234567890');
		self.DID          							:= 0;
		self.RawAID											:= 0;
		self.Process_Date 							:= thorlib.wuid()[2..9];
		StdDatestamp										:= STD.Date.ConvertDateFormatMultiple(pInput.Lastdate,fmtsin,fmtout);
		vDatestamp											:= STD.Date.IsValidDate((INTEGER)StdDatestamp);
		self.date_first_seen						:= IF(vDatestamp, StdDatestamp, '');
		self.date_last_seen							:= IF(vDatestamp, StdDatestamp, '');
		self.Date_Vendor_First_Reported := version;
		self.Date_Vendor_Last_Reported 	:= version;
		self.persistent_record_id 			:= HASH64(TRIM(SELF.email)
																							+TRIM(SELF.name_full)
																							+TRIM(SELF.address1)
																							+TRIM(pInput.city)
																							+TRIM(pInput.state)
																							+TRIM(SELF.zip5)
																							);
		SELF.current_rec 	:= TRUE;
		SELF							:= pInput;
		SELF							:= [];
  END;
	
  pAppendInput	:= PROJECT(DunnData_email.Files.Raw_out,tAppendFields(LEFT));
	
	RETURN pAppendInput;
	
END;
