IMPORT RealSource, Anchor, STD, UT, VersionControl;

EXPORT prep_ingest_file := FUNCTION

	version := (string8)VersionControl.fGetFilenameVersion(RealSource.thor_cluster+'in::email::realsource');
	
	fmtsin := ['%Y%m%d', '%Y-%m-%d'];
	fmtout:= '%Y%m%d';
	
	//Populate added fields prior to cleaning
	RealSource.Layouts.Base tAppendFields(RealSource.Layouts.Raw pInput) := TRANSFORM
		self.FirstName			:= Anchor.fCleanAscii(pInput.FirstName);
		//Clean known issues in LastName
		ClnLastName					:= Anchor.fCleanAscii(pInput.LastName);
		self.LastName				:= MAP(STD.Str.Find(ClnLastName,' JNR',1)>0 => STD.Str.FindReplace(ClnLastName,' JNR',' JR')
															,STD.Str.Find(ClnLastName,' J R',1)>0 => STD.Str.FindReplace(ClnLastName,' J R',' JR')
															,STD.Str.Find(ClnLastName,' LLL',1)>0 => STD.Str.FindReplace(ClnLastName,' LLL',' III')
															,ClnLastName);
		self.MiddleInit			:= STD.Str.FindReplace(pInput.MiddleInit,'0','');
		self.Suffix					:= STD.Str.FindReplace(pInput.Suffix,'0','');
		self.zipcode				:= STD.Str.Filter(pInput.zipcode,'1234567890');
		self.zipplus4				:= STD.Str.Filter(pInput.zipplus4,'1234567890');
		self.phone					:= STD.Str.Filter(pInput.phone,'1234567890');
		self.dob						:= STD.Date.ConvertDateFormatMultiple(pInput.DOB,fmtsin,fmtout);
		self.Email					:= STD.Str.CleanSpaces(pInput.Email);
		self.DID            := 0;
		self.RawAID					:= 0;
		self.Process_Date 	:= thorlib.wuid()[2..9];
		StdDatestamp				:= STD.Date.ConvertDateFormatMultiple(pInput.Datestamp,fmtsin,fmtout);
		vDatestamp					:= STD.Date.IsValidDate((INTEGER)StdDatestamp);
		self.date_first_seen						:= IF(vDatestamp, StdDatestamp, version); //valid since data is a monthly replace
		self.date_last_seen							:= IF(vDatestamp, StdDatestamp, version); //valid since data is a monthly replace
		self.Date_Vendor_First_Reported := version;
		self.Date_Vendor_Last_Reported 	:= version;
		self.persistent_record_id 			:= HASH64(TRIM(self.FirstName)
																							+TRIM(self.LastName)
																							+TRIM(pInput.MiddleInit)
																							+TRIM(pInput.Suffix)
																							+TRIM(pInput.Address)
																							+TRIM(pInput.City)
																							+TRIM(pInput.State)
																							+TRIM(pInput.ZipCode)
																							+TRIM(pInput.DOB)
																							+TRIM(pInput.Email));
		self																			:=	pInput;
		self																			:=	[];
	END;
	
	pAppendInput := PROJECT(RealSource.Files.Raw_out, tAppendFields(LEFT));
	
	RETURN pAppendInput;
END;