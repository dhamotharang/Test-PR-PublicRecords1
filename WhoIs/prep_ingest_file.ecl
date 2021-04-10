IMPORT WhoIs, STD, ut, VersionControl;

EXPORT prep_ingest_file := FUNCTION
 #option('multiplePersistInstances',FALSE);
 
	version := (string8)VersionControl.fGetFilenameVersion(WhoIs.thor_cluster+'in::email::WhoIs_Data');
	
	fmtsin := ['%Y%m%d', '%Y-%m-%d', '%m/%d/%Y'];
	fmtout:= '%Y%m%d';
	
//-----------------------------------------------------------------
//NORMALIZE Email
//-----------------------------------------------------------------
/*
  'RE'   = Registrant Email
	'AE'   = AdministrativeContact Email
	'BE'	 = BillingContact Email
  'TE'   = TechnicalContact Email
  'ZE'   = ZoneContact Email
*/
infile     := WhoIs.files.raw_out;
Validfile  := infile(ut.cleanSpacesAndUpper(domainname) <> 'DOMAINNAME');
ut.CleanFields(Validfile,clnfile);

// Normalized Name records
Layouts.CleanFields t_norm_email (layouts.raw le, INTEGER C) := TRANSFORM
	SELF.domainName    := ut.CleanSpacesAndUpper(le.domainName);
	SELF.registrarName := ut.CleanSpacesAndUpper(le.registrarName);
	SELF.contactEmail  := ut.CleanSpacesAndUpper(le.contactEmail);
	SELF.whoisServer   := ut.CleanSpacesAndUpper(le.whoisServer);
	SELF.nameServers   := ut.CleanSpacesAndUpper(le.nameServers);
	SELF.registrant_rawtext	  := ut.cleanSpacesAndUpper(le.registrant_rawtext);
	SELF.registrant_email	    := ut.cleanSpacesAndUpper(le.registrant_email);
	SELF.registrant_name	    := ut.cleanSpacesAndUpper(le.registrant_name);
	SELF.registrant_organization	:= ut.cleanSpacesAndUpper(le.registrant_organization);
	SELF.registrant_street1	:= ut.cleanSpacesAndUpper(le.registrant_street1);
	SELF.registrant_street2	:= ut.cleanSpacesAndUpper(le.registrant_street2);
	SELF.registrant_street3	:= ut.cleanSpacesAndUpper(le.registrant_street3);
	SELF.registrant_street4	:= ut.cleanSpacesAndUpper(le.registrant_street4);
	SELF.registrant_city 	  := ut.cleanSpacesAndUpper(le.registrant_city);
	SELF.registrant_state	  := ut.cleanSpacesAndUpper(le.registrant_state);
	SELF.registrant_postalCode	:= ut.cleanSpacesAndUpper(le.registrant_postalCode);
	SELF.registrant_country	:= ut.cleanSpacesAndUpper(le.registrant_country);
	SELF.registrant_fax	    := ut.cleanSpacesAndUpper(le.registrant_fax);
	SELF.registrant_faxExt	:= ut.cleanSpacesAndUpper(le.registrant_faxExt);
	SELF.registrant_phone	  := ut.cleanSpacesAndUpper(le.registrant_phone);
	SELF.registrant_phoneExt	:= ut.cleanSpacesAndUpper(le.registrant_phoneExt);
	SELF.administrativeContact_rawtext	:= ut.cleanSpacesAndUpper(le.administrativeContact_rawtext);
	SELF.administrativeContact_email 	:= ut.cleanSpacesAndUpper(le.administrativeContact_email);
	SELF.administrativeContact_name	  := ut.cleanSpacesAndUpper(le.administrativeContact_name);
	SELF.administrativeContact_organization	:= ut.cleanSpacesAndUpper(le.administrativeContact_organization);
	SELF.administrativeContact_street1	:= ut.cleanSpacesAndUpper(le.administrativeContact_street1);
	SELF.administrativeContact_street2	:= ut.cleanSpacesAndUpper(le.administrativeContact_street2);
	SELF.administrativeContact_street3	:= ut.cleanSpacesAndUpper(le.administrativeContact_street3);
	SELF.administrativeContact_street4	:= ut.cleanSpacesAndUpper(le.administrativeContact_street4);
	SELF.administrativeContact_city	    := ut.cleanSpacesAndUpper(le.administrativeContact_city);
	SELF.administrativeContact_state	  := ut.cleanSpacesAndUpper(le.administrativeContact_state);
	SELF.administrativeContact_postalCode	:= ut.cleanSpacesAndUpper(le.administrativeContact_postalCode);
	SELF.administrativeContact_country:= ut.cleanSpacesAndUpper(le.administrativeContact_country);
	SELF.administrativeContact_fax   	:= ut.cleanSpacesAndUpper(le.administrativeContact_fax);
	SELF.administrativeContact_faxExt	:= ut.cleanSpacesAndUpper(le.administrativeContact_faxExt);
	SELF.administrativeContact_phone	:= ut.cleanSpacesAndUpper(le.administrativeContact_phone);
	SELF.administrativeContact_phoneExt	:= ut.cleanSpacesAndUpper(le.administrativeContact_phoneExt);
	SELF.billingContact_rawText 	:= ut.cleanSpacesAndUpper(le.billingContact_rawText );
	SELF.billingContact_email 	  := ut.cleanSpacesAndUpper(le.billingContact_email );
	SELF.billingContact_name	    := ut.cleanSpacesAndUpper(le.billingContact_name);
	SELF.billingContact_organization 	:= ut.cleanSpacesAndUpper(le.billingContact_organization );
	SELF.billingContact_street1	:= ut.cleanSpacesAndUpper(le.billingContact_street1);
	SELF.billingContact_street2 	:= ut.cleanSpacesAndUpper(le.billingContact_street2 );
	SELF.billingContact_street3	:= ut.cleanSpacesAndUpper(le.billingContact_street3);
	SELF.billingContact_street4 	:= ut.cleanSpacesAndUpper(le.billingContact_street4 );
	SELF.billingContact_city 	:= ut.cleanSpacesAndUpper(le.billingContact_city );
	SELF.billingContact_state	:= ut.cleanSpacesAndUpper(le.billingContact_state);
	SELF.billingContact_postalCode 	:= ut.cleanSpacesAndUpper(le.billingContact_postalCode );
	SELF.billingContact_country	:= ut.cleanSpacesAndUpper(le.billingContact_country);
	SELF.billingContact_fax 	  := ut.cleanSpacesAndUpper(le.billingContact_fax );
	SELF.billingContact_faxExt	:= ut.cleanSpacesAndUpper(le.billingContact_faxExt);
	SELF.billingContact_phone 	:= ut.cleanSpacesAndUpper(le.billingContact_phone );
	SELF.billingContact_phoneExt	:= ut.cleanSpacesAndUpper(le.billingContact_phoneExt);
	SELF.technicalContact_rawText 	:= ut.cleanSpacesAndUpper(le.technicalContact_rawText );
	SELF.technicalContact_email	  := ut.cleanSpacesAndUpper(le.technicalContact_email);
	SELF.technicalContact_name 	  := ut.cleanSpacesAndUpper(le.technicalContact_name );
	SELF.technicalContact_organization	:= ut.cleanSpacesAndUpper(le.technicalContact_organization);
	SELF.technicalContact_street1 	:= ut.cleanSpacesAndUpper(le.technicalContact_street1 );
	SELF.technicalContact_street2	  := ut.cleanSpacesAndUpper(le.technicalContact_street2);
	SELF.technicalContact_street3 	:= ut.cleanSpacesAndUpper(le.technicalContact_street3 );
	SELF.technicalContact_street4	:= ut.cleanSpacesAndUpper(le.technicalContact_street4);
	SELF.technicalContact_city 	  := ut.cleanSpacesAndUpper(le.technicalContact_city );
	SELF.technicalContact_state	  := ut.cleanSpacesAndUpper(le.technicalContact_state);
	SELF.technicalContact_postalCode 	:= ut.cleanSpacesAndUpper(le.technicalContact_postalCode );
	SELF.technicalContact_country	:= ut.cleanSpacesAndUpper(le.technicalContact_country);
	SELF.technicalContact_fax  	  := ut.cleanSpacesAndUpper(le.technicalContact_fax );
	SELF.technicalContact_faxExt	  := ut.cleanSpacesAndUpper(le.technicalContact_faxExt);
	SELF.technicalContact_phone 	:= ut.cleanSpacesAndUpper(le.technicalContact_phone );
	SELF.technicalContact_phoneExt	:= ut.cleanSpacesAndUpper(le.technicalContact_phoneExt);
	SELF.zoneContact_rawText := ut.cleanSpacesAndUpper(le.zoneContact_rawText );
	SELF.zoneContact_email 	:= ut.cleanSpacesAndUpper(le.zoneContact_email );
	SELF.zoneContact_name	  := ut.cleanSpacesAndUpper(le.zoneContact_name);
	SELF.zoneContact_organization 	:= ut.cleanSpacesAndUpper(le.zoneContact_organization );
	SELF.zoneContact_street1 	:= ut.cleanSpacesAndUpper(le.zoneContact_street1 );
	SELF.zoneContact_street2	  := ut.cleanSpacesAndUpper(le.zoneContact_street2);
	SELF.zoneContact_street3 	:= ut.cleanSpacesAndUpper(le.zoneContact_street3 );
	SELF.zoneContact_street4 	:= ut.cleanSpacesAndUpper(le.zoneContact_street4 );
	SELF.zoneContact_city	  := ut.cleanSpacesAndUpper(le.zoneContact_city);
	SELF.zoneContact_state 	:= ut.cleanSpacesAndUpper(le.zoneContact_state );
	SELF.zoneContact_postalCode 	:= ut.cleanSpacesAndUpper(le.zoneContact_postalCode );
	SELF.zoneContact_country	:= ut.cleanSpacesAndUpper(le.zoneContact_country);
	SELF.zoneContact_fax 	  := ut.cleanSpacesAndUpper(le.zoneContact_fax );
	SELF.zoneContact_faxExt 	:= ut.cleanSpacesAndUpper(le.zoneContact_faxExt );
	SELF.zoneContact_phone	:= ut.cleanSpacesAndUpper(le.zoneContact_phone);
	SELF.zoneContact_phoneExt	:= ut.cleanSpacesAndUpper(le.zoneContact_phoneExt);

	SELF.rawtext     := CHOOSE(C, SELF.registrant_rawtext, SELF.administrativeContact_rawtext, SELF.billingContact_rawText, SELF.technicalContact_rawText, SELF.zoneContact_rawText); 
	SELF.email       := CHOOSE(C, SELF.registrant_email, SELF.administrativeContact_email, SELF.billingContact_email, SELF.technicalContact_email, SELF.zoneContact_email); 
	trim_name        := CHOOSE(C, SELF.registrant_name, SELF.administrativeContact_name, SELF.billingContact_name, SELF.technicalContact_name, SELF.zoneContact_name); 
  SELF.name        := ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_name));

	trim_organization:= CHOOSE(C, SELF.registrant_organization, SELF.administrativeContact_organization, SELF.billingContact_organization, SELF.technicalContact_organization, SELF.zoneContact_organization); 
	SELF.organization:= ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_organization));
													
	trim_city    := CHOOSE(C, SELF.registrant_city, SELF.administrativeContact_city, SELF.billingContact_city, SELF.technicalContact_city, SELF.zoneContact_city); 
  SELF.city    := ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_city));
													
	trim_state   := CHOOSE(C, SELF.registrant_state, SELF.administrativeContact_state, SELF.billingContact_state, SELF.technicalContact_state, SELF.zoneContact_state); 
  SELF.state   := ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_state));
													
	trim_postalCode  := CHOOSE(C, SELF.registrant_postalCode, SELF.administrativeContact_postalCode, SELF.billingContact_postalCode, SELF.technicalContact_postalCode, SELF.zoneContact_postalCode); 
  SELF.postalCode  := ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_postalCode));
	
	trim_country     := CHOOSE(C, SELF.registrant_country, SELF.administrativeContact_country, SELF.billingContact_country, SELF.technicalContact_country, SELF.zoneContact_country); 
  SELF.country     := ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_country));													
													
	trim_street1 := CHOOSE(C, SELF.registrant_street1, SELF.administrativeContact_street1, SELF.billingContact_street1, SELF.technicalContact_street1, SELF.zoneContact_street1); 
  SELF.street1 := ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_street1));

	trim_street2 := CHOOSE(C, SELF.registrant_street2, SELF.administrativeContact_street2, SELF.billingContact_street2, SELF.technicalContact_street2, SELF.zoneContact_street2); 
  SELF.street2 := ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_street2));

	trim_street3 := CHOOSE(C, SELF.registrant_street3, SELF.administrativeContact_street3, SELF.billingContact_street3, SELF.technicalContact_street3, SELF.zoneContact_street3); 
  SELF.street3 := ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_street3));
	
	trim_street4 := CHOOSE(C, SELF.registrant_street4, SELF.administrativeContact_street4, SELF.billingContact_street4, SELF.technicalContact_street4, SELF.zoneContact_street4); 
  SELF.street4 := ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_street4));
											
	trim_fax     := CHOOSE(C, SELF.registrant_fax, SELF.administrativeContact_fax, SELF.billingContact_fax, SELF.technicalContact_fax, SELF.zoneContact_fax); 
  SELF.fax     := ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_fax));	
											
	trim_faxExt  := CHOOSE(C, SELF.registrant_faxExt, SELF.administrativeContact_faxExt, SELF.billingContact_faxExt, SELF.technicalContact_faxExt, SELF.zoneContact_faxExt); 
  SELF.faxExt  := ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_faxExt));	
											
	trim_phone   := CHOOSE(C, SELF.registrant_phone, SELF.administrativeContact_phone, SELF.billingContact_phone, SELF.technicalContact_phone, SELF.zoneContact_phone); 
  SELF.phone   := ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_phone));	
											
	trim_phoneExt:= CHOOSE(C, SELF.registrant_phoneExt, SELF.administrativeContact_phoneExt, SELF.billingContact_phoneExt, SELF.technicalContact_phoneExt, SELF.zoneContact_phoneExt); 
  SELF.phoneExt:= ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(trim_phoneExt));	
											
	SELF.EmailType     := CHOOSE(C,'RE','AE','BE','TE','ZE');		
	SELF.createdDate	 := STD.Date.ConvertDateFormatMultiple(le.createdDate,fmtsin,fmtout);       //when the domain name was first registered/created
	SELF.UpdatedDate	 := STD.Date.ConvertDateFormatMultiple(le.updatedDate,fmtsin,fmtout);       //when the whois data were updated
	SELF.ExpiresDate	 := STD.Date.ConvertDateFormatMultiple(le.expiresDate,fmtsin,fmtout);       //when the domain name will expire
	SELF.Status        := ut.CleanSpacesAndUpper(le.status);                                      //domain name status code
	SELF 					:= le;
	SELF					:= [];
END;

	ds_norm 	:= NORMALIZE(clnfile,5,t_norm_email(LEFT,COUNTER));

	//Clean Name and Address
	Layouts.Base tAppendFields(Layouts.CleanFields le) := TRANSFORM
		SELF.DID          							:= 0;
		SELF.RawAID											:= 0;
		SELF.Process_Date 							:= thorlib.wuid()[2..9];
		StdDatestamp										:= STD.Date.ConvertDateFormatMultiple(le.updatedDate,fmtsin,fmtout);
		vDatestamp											:= STD.Date.IsValidDate((INTEGER)StdDatestamp);
		self.date_first_seen						:= IF(vDatestamp, StdDatestamp, '');
		self.date_last_seen							:= IF(vDatestamp, StdDatestamp, '');
		self.Date_Vendor_First_Reported := version;
		self.Date_Vendor_Last_Reported 	:= version;
		self.persistent_record_id    		:= 0;
		SELF.current_rec 	:= TRUE;
		
		SELF.name         := MAP(fnValidName(le.name) = false => '',
														fnValidCName(le.name) = false => '',
														REGEXFIND(':',le.name)=>'',
														NOT REGEXFIND('[A-Z]',le.name) => '',
														REGEXFIND('C/O',le.name)=> REGEXREPLACE('C/O',le.name,''),
														TRIM(le.name,LEFT,RIGHT));

		SELF.organization := MAP(fnValidName(le.organization) = false => '',
														fnValidCName(le.organization) = false => '',
														REGEXFIND(':',le.organization)=>'',
														NOT REGEXFIND('[A-Z]',le.organization) => '',
														TRIM(le.organization) = TRIM(self.name) => '',
														REGEXFIND('C/O',le.organization)=> REGEXREPLACE('C/O',le.organization,''),
														TRIM(le.organization,LEFT,RIGHT));
														
		SELF.city    := MAP(fnValidName(le.city) = false => '',
												NOT REGEXFIND('[A-Z]',le.city) => '',
												TRIM(le.city,LEFT,RIGHT));
														
		SELF.state   := MAP(fnValidName(le.state) = false => '',
														NOT REGEXFIND('[A-Z]',le.state) => '',
														TRIM(le.state,LEFT,RIGHT));
														
		SELF.postalCode  := MAP(fnValidName(le.postalCode) = false => '',
														NOT REGEXFIND('[0-9]',le.postalCode) => '',
														TRIM(le.postalCode,LEFT,RIGHT));
		
		SELF.country     := MAP(fnValidName(le.country) = false => '',
														NOT REGEXFIND('[A-Z]',le.country) => '',
														TRIM(le.country,LEFT,RIGHT));													
														
		SELF.street1 := MAP(fnValidName(le.street1) = false => '',
												NOT REGEXFIND('[0-9A-Z]',le.street1) => '',
												TRIM(le.street1) = TRIM(SELF.Name) => '',
												TRIM(le.street1) = TRIM(SELF.Organization) => '',
												TRIM(le.street1) = TRIM(SELF.City) => '',
												TRIM(le.street1) = TRIM(SELF.State) => '',
												TRIM(le.street1) = TRIM(SELF.Country) => '',
												REGEXFIND('^.*\\.COM\\|',le.street1) => REGEXREPLACE('^.*\\.COM\\|',le.street1,''),
												REGEXFIND('^.* COM\\|',le.street1) => REGEXREPLACE('^.* COM\\|',le.street1,''),
												REGEXFIND('\\|.*\\COM$|',le.street1) => REGEXREPLACE('\\|.*\\COM$|',le.street1,''),
												le.street1);

		SELF.street2 := MAP(fnValidName(le.street2) = false => '',
												NOT REGEXFIND('[0-9A-Z]',le.street2) => '',
												TRIM(le.street2) = TRIM(SELF.Name) => '',
												TRIM(le.street2) = TRIM(SELF.Organization) => '',
												TRIM(le.street2) = TRIM(SELF.City) => '',
												TRIM(le.street2) = TRIM(SELF.State) => '',
												TRIM(le.street2) = TRIM(SELF.Country) => '',
												TRIM(le.street2) = TRIM(SELF.street1) => '',
												REGEXFIND('^.*\\.COM\\|',le.street2) => REGEXREPLACE('^.*\\.COM\\|',le.street2,''),
												REGEXFIND('^.* COM\\|',le.street2) => REGEXREPLACE('^.* COM\\|',le.street2,''),
												REGEXFIND('\\|.*\\COM$|',le.street2) => REGEXREPLACE('\\|.*\\COM$|',le.street2,''),
												le.street2);

		SELF.street3 := MAP(fnValidName(le.street3) = false => '',
												NOT REGEXFIND('[0-9A-Z]',le.street3) => '',
												TRIM(le.street3) = TRIM(SELF.Name) => '',
												TRIM(le.street3) = TRIM(SELF.Organization) => '',
												TRIM(le.street3) = TRIM(SELF.City) => '',
												TRIM(le.street3) = TRIM(SELF.State) => '',
												TRIM(le.street3) = TRIM(SELF.Country) => '',
												TRIM(le.street3) = TRIM(SELF.street1) => '',
												TRIM(le.street3) = TRIM(SELF.street2) => '',
												le.street3);
		
		SELF.street4 := MAP(fnValidName(le.street4) = false => '',
												NOT REGEXFIND('[0-9A-Z]',le.street4) => '',
												TRIM(le.street4) = TRIM(SELF.Name) => '',
												TRIM(le.street4) = TRIM(SELF.Organization) => '',
												TRIM(le.street4) = TRIM(SELF.City) => '',
												TRIM(le.street4) = TRIM(SELF.State) => '',
												TRIM(le.street4) = TRIM(SELF.Country) => '',
												TRIM(le.street4) = TRIM(SELF.street1) => '',
												TRIM(le.street4) = TRIM(SELF.street2) => '',
												TRIM(le.street4) = TRIM(SELF.street3) => '',
												le.street4);
												
		SELF.fax     := MAP(fnValidName(le.fax) = false => '',
												NOT REGEXFIND('[1-9]',le.fax) => '',
												TRIM(le.fax,LEFT,RIGHT));	
												
		SELF.faxExt  := MAP(fnValidName(le.faxExt) = false => '',
												NOT REGEXFIND('[1-9]',le.faxExt) => '',
												TRIM(le.faxExt,LEFT,RIGHT));	
												
		SELF.phone   := MAP(fnValidName(le.phone) = false => '',
												NOT REGEXFIND('[1-9]',le.phone) => '',
												TRIM(le.phone,LEFT,RIGHT));	
												
		SELF.phoneExt:= MAP(fnValidName(le.phoneExt) = false => '',
												NOT REGEXFIND('[1-9]',le.phoneExt) => '',
												TRIM(le.phoneExt,LEFT,RIGHT));	
		SELF							:= le;
		SELF							:= [];
  END;
	
  AppendInput	:= PROJECT(ds_norm,tAppendFields(LEFT));
	ds_dist     := DISTRIBUTE(AppendInput,HASH(domainname, email, name, street1, city, state));
  ds_sort     := SORT(ds_dist,domainname,email,name,street1,city,state,LOCAL);
	ds_dedup    := DEDUP(ds_sort, EXCEPT RAWTEXT,EMAILTYPE,LOCAL): persist('~thor_data400::in::WhoIs::prep_ingest');
	RETURN ds_dedup;
	
END;
