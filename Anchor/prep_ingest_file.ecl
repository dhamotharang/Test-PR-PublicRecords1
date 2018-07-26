IMPORT Anchor, STD, ut, VersionControl;

EXPORT prep_ingest_file := FUNCTION

	version := (string8)VersionControl.fGetFilenameVersion(Anchor.thor_cluster+'in::email::anchor');

	fmtsin := ['%Y%m%d'];
	fmtout:='%Y%m%d';
	
	//Populate added fields
		Anchor.Layouts.Base tAppendFields(Anchor.Layouts.Raw pInput) := TRANSFORM
			self.dob								:=	STD.Date.ConvertDateFormatMultiple(pInput.DOB,fmtsin,fmtout);
			self.zip								:=	STD.Str.Filter(pInput.zipcode,'1234567890');
			self.Address_1					:= STD.Str.CleanSpaces(MAP(STD.Str.Find(pInput.Address_1,'&APOS;',1) > 0 => STD.Str.FindReplace(pInput.Address_1,'&APOS;','\''),
																													STD.Str.Find(pInput.Address_1,':',1) > 0 => STD.Str.FindReplace(pInput.Address_1,':',' '),
																													STD.Str.Find(pInput.Address_1,';',1) > 0 => STD.Str.FindReplace(pInput.Address_1,';',' '),
																													STD.Str.Find(pInput.Address_1,'!',1) > 0 => STD.Str.FindReplace(pInput.Address_1,'!',' '),
																													STD.Str.Find(pInput.Address_1,'`',1) > 0 => STD.Str.FindReplace(pInput.Address_1,'`',''),
																													STD.Str.Find(pInput.Address_1,'^',1) > 0 => STD.Str.FindReplace(pInput.Address_1,'^',''),
																													STD.Str.Find(pInput.Address_1,'=',1) > 0 => STD.Str.FindReplace(pInput.Address_1,'=',' '),
																													STD.Str.Find(pInput.Address_1,'>',1) > 0 => STD.Str.FindReplace(pInput.Address_1,'>',' '),
																													STD.Str.Find(pInput.Address_1,'|',1) > 0 => STD.Str.FindReplace(pInput.Address_1,'|',','),
																													REGEXFIND('\\++',pInput.Address_1) => REGEXREPLACE('\\++',pInput.Address_1,' '),
																													pInput.Address_1));
			self.EmailAddress			:=	STD.Str.CleanSpaces(pInput.EmailAddress);
			self.Longitude				:= 	STD.Str.FindReplace(pInput.Longitude, '"','');
			self.DID            	:=	0;
			self.RawAID						:=	0;
			self.Process_Date 		:=	thorlib.wuid()[2..9];
			vOptInDate						:=	STD.Date.IsValidDate((INTEGER)pInput.OptInDate);
			self.date_first_seen	:=  IF(vOptInDate, pInput.OptInDate, ''); //file received quarterly so filedate is not true first/last seen date
			self.date_last_seen		:=  IF(vOptInDate, pInput.OptInDate, '');
			self.Date_Vendor_First_Reported :=	version;
			self.Date_Vendor_Last_Reported 	:=	version;
			self.persistent_record_id 			:= HASH64(TRIM(pInput.FirstName)
																								+TRIM(pInput.LastName)
																								+TRIM(pInput.DOB)
																								+TRIM(self.Address_1)
																								+TRIM(pInput.City)
																								+TRIM(pInput.State)
																								+TRIM(pInput.ZipCode)
																								+TRIM(pInput.EmailAddress));
			self									:=	pInput;
			self									:=	[];
	END;
	
	pAppendInput := PROJECT(Anchor.Files.Raw_out, tAppendFields(LEFT));
	
	RETURN pAppendInput;
END;
	