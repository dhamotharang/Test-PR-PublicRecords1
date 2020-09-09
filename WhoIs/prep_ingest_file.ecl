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


// Normalized Name records
Layouts.CleanFields t_norm_email (layouts.raw le, INTEGER C) := TRANSFORM
	self.domainName    := ut.CleanSpacesAndUpper(le.domainName);
	self.registrarName := ut.CleanSpacesAndUpper(le.registrarName);
	self.contactEmail  := ut.CleanSpacesAndUpper(le.contactEmail);
	self.whoisServer   := ut.CleanSpacesAndUpper(le.whoisServer);
	self.nameServers   := ut.CleanSpacesAndUpper(le.nameServers);
	self.registrant_rawtext	:= ut.cleanSpacesAndUpper(le.registrant_rawtext);
	self.registrant_email	  := ut.cleanSpacesAndUpper(le.registrant_email);
	self.registrant_name	    := ut.cleanSpacesAndUpper(le.registrant_name);
	self.registrant_organization	:= ut.cleanSpacesAndUpper(le.registrant_organization);
	self.registrant_street1	:= ut.cleanSpacesAndUpper(le.registrant_street1);
	self.registrant_street2	:= ut.cleanSpacesAndUpper(le.registrant_street2);
	self.registrant_street3	:= ut.cleanSpacesAndUpper(le.registrant_street3);
	self.registrant_street4	:= ut.cleanSpacesAndUpper(le.registrant_street4);
	self.registrant_city 	  := ut.cleanSpacesAndUpper(le.registrant_city);
	self.registrant_state	  := ut.cleanSpacesAndUpper(le.registrant_state);
	self.registrant_postalCode	:= ut.cleanSpacesAndUpper(le.registrant_postalCode);
	self.registrant_country	:= ut.cleanSpacesAndUpper(le.registrant_country);
	self.registrant_fax	    := ut.cleanSpacesAndUpper(le.registrant_fax);
	self.registrant_faxExt	  := ut.cleanSpacesAndUpper(le.registrant_faxExt);
	self.registrant_phone	  := ut.cleanSpacesAndUpper(le.registrant_phone);
	self.registrant_phoneExt	:= ut.cleanSpacesAndUpper(le.registrant_phoneExt);
	self.administrativeContact_rawtext	:= ut.cleanSpacesAndUpper(le.administrativeContact_rawtext);
	self.administrativeContact_email 	:= ut.cleanSpacesAndUpper(le.administrativeContact_email);
	self.administrativeContact_name	  := ut.cleanSpacesAndUpper(le.administrativeContact_name);
	self.administrativeContact_organization	:= ut.cleanSpacesAndUpper(le.administrativeContact_organization);
	self.administrativeContact_street1	:= ut.cleanSpacesAndUpper(le.administrativeContact_street1);
	self.administrativeContact_street2	:= ut.cleanSpacesAndUpper(le.administrativeContact_street2);
	self.administrativeContact_street3	:= ut.cleanSpacesAndUpper(le.administrativeContact_street3);
	self.administrativeContact_street4	:= ut.cleanSpacesAndUpper(le.administrativeContact_street4);
	self.administrativeContact_city	  := ut.cleanSpacesAndUpper(le.administrativeContact_city);
	self.administrativeContact_state	  := ut.cleanSpacesAndUpper(le.administrativeContact_state);
	self.administrativeContact_postalCode	:= ut.cleanSpacesAndUpper(le.administrativeContact_postalCode);
	self.administrativeContact_country	:= ut.cleanSpacesAndUpper(le.administrativeContact_country);
	self.administrativeContact_fax   	:= ut.cleanSpacesAndUpper(le.administrativeContact_fax);
	self.administrativeContact_faxExt	:= ut.cleanSpacesAndUpper(le.administrativeContact_faxExt);
	self.administrativeContact_phone	:= ut.cleanSpacesAndUpper(le.administrativeContact_phone);
	self.administrativeContact_phoneExt	:= ut.cleanSpacesAndUpper(le.administrativeContact_phoneExt);
	self.billingContact_rawText 	:= ut.cleanSpacesAndUpper(le.billingContact_rawText );
	self.billingContact_email 	  := ut.cleanSpacesAndUpper(le.billingContact_email );
	self.billingContact_name	    := ut.cleanSpacesAndUpper(le.billingContact_name);
	self.billingContact_organization 	:= ut.cleanSpacesAndUpper(le.billingContact_organization );
	self.billingContact_street1	:= ut.cleanSpacesAndUpper(le.billingContact_street1);
	self.billingContact_street2 	:= ut.cleanSpacesAndUpper(le.billingContact_street2 );
	self.billingContact_street3	:= ut.cleanSpacesAndUpper(le.billingContact_street3);
	self.billingContact_street4 	:= ut.cleanSpacesAndUpper(le.billingContact_street4 );
	self.billingContact_city 	:= ut.cleanSpacesAndUpper(le.billingContact_city );
	self.billingContact_state	:= ut.cleanSpacesAndUpper(le.billingContact_state);
	self.billingContact_postalCode 	:= ut.cleanSpacesAndUpper(le.billingContact_postalCode );
	self.billingContact_country	:= ut.cleanSpacesAndUpper(le.billingContact_country);
	self.billingContact_fax 	  := ut.cleanSpacesAndUpper(le.billingContact_fax );
	self.billingContact_faxExt	:= ut.cleanSpacesAndUpper(le.billingContact_faxExt);
	self.billingContact_phone 	:= ut.cleanSpacesAndUpper(le.billingContact_phone );
	self.billingContact_phoneExt	:= ut.cleanSpacesAndUpper(le.billingContact_phoneExt);
	self.technicalContact_rawText 	:= ut.cleanSpacesAndUpper(le.technicalContact_rawText );
	self.technicalContact_email	  := ut.cleanSpacesAndUpper(le.technicalContact_email);
	self.technicalContact_name 	  := ut.cleanSpacesAndUpper(le.technicalContact_name );
	self.technicalContact_organization	:= ut.cleanSpacesAndUpper(le.technicalContact_organization);
	self.technicalContact_street1 	:= ut.cleanSpacesAndUpper(le.technicalContact_street1 );
	self.technicalContact_street2	:= ut.cleanSpacesAndUpper(le.technicalContact_street2);
	self.technicalContact_street3 	:= ut.cleanSpacesAndUpper(le.technicalContact_street3 );
	self.technicalContact_street4	:= ut.cleanSpacesAndUpper(le.technicalContact_street4);
	self.technicalContact_city 	  := ut.cleanSpacesAndUpper(le.technicalContact_city );
	self.technicalContact_state	  := ut.cleanSpacesAndUpper(le.technicalContact_state);
	self.technicalContact_postalCode 	:= ut.cleanSpacesAndUpper(le.technicalContact_postalCode );
	self.technicalContact_country	:= ut.cleanSpacesAndUpper(le.technicalContact_country);
	self.technicalContact_fax  	  := ut.cleanSpacesAndUpper(le.technicalContact_fax );
	self.technicalContact_faxExt	  := ut.cleanSpacesAndUpper(le.technicalContact_faxExt);
	self.technicalContact_phone 	:= ut.cleanSpacesAndUpper(le.technicalContact_phone );
	self.technicalContact_phoneExt	:= ut.cleanSpacesAndUpper(le.technicalContact_phoneExt);
	self.zoneContact_rawText := ut.cleanSpacesAndUpper(le.zoneContact_rawText );
	self.zoneContact_email 	:= ut.cleanSpacesAndUpper(le.zoneContact_email );
	self.zoneContact_name	  := ut.cleanSpacesAndUpper(le.zoneContact_name);
	self.zoneContact_organization 	:= ut.cleanSpacesAndUpper(le.zoneContact_organization );
	self.zoneContact_street1 	:= ut.cleanSpacesAndUpper(le.zoneContact_street1 );
	self.zoneContact_street2	  := ut.cleanSpacesAndUpper(le.zoneContact_street2);
	self.zoneContact_street3 	:= ut.cleanSpacesAndUpper(le.zoneContact_street3 );
	self.zoneContact_street4 	:= ut.cleanSpacesAndUpper(le.zoneContact_street4 );
	self.zoneContact_city	  := ut.cleanSpacesAndUpper(le.zoneContact_city);
	self.zoneContact_state 	:= ut.cleanSpacesAndUpper(le.zoneContact_state );
	self.zoneContact_postalCode 	:= ut.cleanSpacesAndUpper(le.zoneContact_postalCode );
	self.zoneContact_country	:= ut.cleanSpacesAndUpper(le.zoneContact_country);
	self.zoneContact_fax 	  := ut.cleanSpacesAndUpper(le.zoneContact_fax );
	self.zoneContact_faxExt 	:= ut.cleanSpacesAndUpper(le.zoneContact_faxExt );
	self.zoneContact_phone	:= ut.cleanSpacesAndUpper(le.zoneContact_phone);
	self.zoneContact_phoneExt	:= ut.cleanSpacesAndUpper(le.zoneContact_phoneExt);
	SELF.rawtext     := CHOOSE(C, self.registrant_rawtext, self.administrativeContact_rawtext, self.billingContact_rawText, self.technicalContact_rawText, self.zoneContact_rawText); 
	SELF.email       := CHOOSE(C, self.registrant_email, self.administrativeContact_email, self.billingContact_email, self.technicalContact_email, self.zoneContact_email); 
	trim_name        := CHOOSE(C, self.registrant_name, self.administrativeContact_name, self.billingContact_name, self.technicalContact_name, self.zoneContact_name); 
  SELF.name        := IF(regexfind('(REDACTED FOR PRIVACY|REGISTRATION PRIVATE)',trim(trim_name,left,right)),'',trim_name);
	trim_organization:= CHOOSE(C, self.registrant_organization, self.administrativeContact_organization, self.billingContact_organization, self.technicalContact_organization, self.zoneContact_organization); 
	SELF.organization:= IF(trim(trim_organization,left,right) != 'REDACTED FOR PRIVACY',trim_organization,'');
	trim_street1 := CHOOSE(C, self.registrant_street1, self.administrativeContact_street1, self.billingContact_street1, self.technicalContact_street1, self.zoneContact_street1); 
  cln_street1  := MAP(trim_street1 = 'REDACTED FOR PRIVACY' => '',
	                    regexfind('^.*\\.COM\\|',trim_street1) => regexreplace('^.*\\.COM\\|',trim_street1,''),
	                    regexfind('^.* COM\\|',trim_street1) => regexreplace('^.* COM\\|',trim_street1,''),
											regexfind('\\|.*\\COM$|',trim_street1) => regexreplace('\\|.*\\COM$|',trim_street1,''),
	                    trim_street1);
  SELF.street1 := cln_street1;
	trim_street2 := CHOOSE(C, self.registrant_street2, self.administrativeContact_street2, self.billingContact_street2, self.technicalContact_street2, self.zoneContact_street2); 
  SELF.street2 := IF(trim(trim_street2,left,right) != 'REDACTED FOR PRIVACY',trim_street2,'');
	trim_street3 := CHOOSE(C, self.registrant_street3, self.administrativeContact_street3, self.billingContact_street3, self.technicalContact_street3, self.zoneContact_street3); 
  SELF.street3 := IF(trim(trim_street3,left,right) != 'REDACTED FOR PRIVACY',trim_street3,'');
	trim_street4 := CHOOSE(C, self.registrant_street4, self.administrativeContact_street4, self.billingContact_street4, self.technicalContact_street4, self.zoneContact_street4); 
  SELF.street4 := IF(trim(trim_street4,left,right) != 'REDACTED FOR PRIVACY',trim_street4,'');
	trim_city    := CHOOSE(C, self.registrant_city, self.administrativeContact_city, self.billingContact_city, self.technicalContact_city, self.zoneContact_city); 
  SELF.city    := IF(trim(trim_city,left,right) != 'REDACTED FOR PRIVACY',trim_city,'');
	trim_state   := CHOOSE(C, self.registrant_state, self.administrativeContact_state, self.billingContact_state, self.technicalContact_state, self.zoneContact_state); 
  SELF.state   := IF(trim(trim_state,left,right) != 'REDACTED FOR PRIVACY',trim_state,'');
	trim_postalCode  := CHOOSE(C, self.registrant_postalCode, self.administrativeContact_postalCode, self.billingContact_postalCode, self.technicalContact_postalCode, self.zoneContact_postalCode); 
  SELF.postalCode  := IF(trim(trim_postalCode,left,right) != 'REDACTED FOR PRIVACY',trim_postalCode,'');
	trim_country     := CHOOSE(C, self.registrant_country, self.administrativeContact_country, self.billingContact_country, self.technicalContact_country, self.zoneContact_country); 
  SELF.country     := IF(trim(trim_country,left,right) != 'REDACTED FOR PRIVACY',trim_country,'');
	trim_fax         := CHOOSE(C, self.registrant_fax, self.administrativeContact_fax, self.billingContact_fax, self.technicalContact_fax, self.zoneContact_fax); 
  SELF.fax         := IF(trim(trim_fax,left,right) != 'REDACTED FOR PRIVACY',trim_fax,'');
	trim_faxExt      := CHOOSE(C, self.registrant_faxExt, self.administrativeContact_faxExt, self.billingContact_faxExt, self.technicalContact_faxExt, self.zoneContact_faxExt); 
  SELF.faxExt      := IF(trim(trim_faxExt,left,right) != 'REDACTED FOR PRIVACY',trim_faxExt,'');
	trim_phone   := CHOOSE(C, self.registrant_phone, self.administrativeContact_phone, self.billingContact_phone, self.technicalContact_phone, self.zoneContact_phone); 
  SELF.phone   := IF(trim(trim_phone,left,right) != 'REDACTED FOR PRIVACY',trim_phone,'');
	trim_phoneExt:= CHOOSE(C, self.registrant_phoneExt, self.administrativeContact_phoneExt, self.billingContact_phoneExt, self.technicalContact_phoneExt, self.zoneContact_phoneExt); 
  SELF.phoneExt:= IF(trim(trim_phoneExt,left,right) != 'REDACTED FOR PRIVACY',trim_phoneExt,'');
	SELF.EmailType       := CHOOSE(C,'RE','AE','BE','TE','ZE');
	SELF 					:= le;
	SELF					:= [];
END;

	ds_norm 	:= NORMALIZE(WhoIs.files.raw_out,5,t_norm_email(LEFT,COUNTER)): persist('~thor_data400::in::normlize_email_test');
	// GoodNormEmail  := ds_norm(TRIM(email,ALL) <> '')/*: persist('~thor_data400::in::filter_email_test')*/;

	// ds_disted	:= DISTRIBUTE(ds_norm,HASH(domainname, email, name, street1, city, state,emailtype))/*: persist('~thor_data400::in::distribute_email_test')*/;
	// ds_sorted	:= SORT(ds_disted,RECORD,LOCAL)/*: persist('~thor_data400::in::sort_email_test')*/;
  ds_deduped:= DEDUP(SORT(DISTRIBUTE(ds_norm,HASH(domainname, email, name, street1, city, state,emailtype)),RECORD,LOCAL),RECORD,ALL,LOCAL)/*: persist('~thor_data400::in::dedup_email_test')*/;
  	

	//Populate added fields prior to cleaning
	Layouts.Base tAppendFields(Layouts.CleanFields le) := TRANSFORM
		self.createdDate	 := STD.Date.ConvertDateFormatMultiple(le.createdDate,fmtsin,fmtout);       //when the domain name was first registered/created
		self.updatedDate	 := STD.Date.ConvertDateFormatMultiple(le.updatedDate,fmtsin,fmtout);        //when the whois data were updated
		self.expiresDate	 := STD.Date.ConvertDateFormatMultiple(le.expiresDate,fmtsin,fmtout);         //when the domain name will expire
		self.status        := ut.CleanSpacesAndUpper(le.status);                //domain name status code
		self.DID          							:= 0;
		self.RawAID											:= 0;
		self.Process_Date 							:= thorlib.wuid()[2..9];
		StdDatestamp										:= STD.Date.ConvertDateFormatMultiple(le.updatedDate,fmtsin,fmtout);
		vDatestamp											:= STD.Date.IsValidDate((INTEGER)StdDatestamp);
		self.date_first_seen						:= IF(vDatestamp, StdDatestamp, '');
		self.date_last_seen							:= IF(vDatestamp, StdDatestamp, '');
		self.Date_Vendor_First_Reported := version;
		self.Date_Vendor_Last_Reported 	:= version;
		// self.persistent_record_id    		:= 0;
		SELF.current_rec 	:= TRUE;
		SELF							:= le;
		SELF							:= [];
  END;
	
  pAppendInput	:= PROJECT(ds_deduped,tAppendFields(LEFT))/*: persist('~thor_data400::in::prep_ingest_test')*/;
	
	RETURN pAppendInput;
	
END;