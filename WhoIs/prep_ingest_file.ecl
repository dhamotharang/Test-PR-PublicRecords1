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

	Inv_Pattern := '^REDACTED$|^REDACTED |REDACTED FOR PRIVACY|REDACTED FOR GDPR PRIVACY|GDPR MASKED|PENDING RENEWAL OR DELETION|'+
	               '^NA$|^N/A$|^NO COMPANY$|^NONE$|NOT AVAILABLE$|NOT DISCLOSED|NOT PUBLISHED|NOT SHOWN|^NULL$|^UNKNOWN|STATUTORY MASKING ENABLED|'+
							 	 '^PRIVATE REGISTRATION$|DNSPROTECT$|^HIDDEN$|^FOR SALE$|^DATA REDACTED|NON-PUBLIC DATA|PERSONAL DATA, CAN NOT BE PUBLICLY DISCLOSED';

	InvName_Pattern :='(^ADDRESS|^ANO NYMOUS$|^1&1 INTERNET|^ADMIN CONTACT|^ADMIN COUNTRY|^ADMIN PHONE|^ADMIN STREET|^ADMIN$|'+
								'^ADMINISTRATOR|^AGENT INFORMATION TEMPORARILY SET BY TRANSFER|^APLUS.NET INTERNET SERVICES|'+
								'^BEATS|^BILLING COUNTRY|^BILLING DEPARTMENT|^BILLING PHONE|^BV DOT TK|^DOT TK ADMINISTRATOR|^COMCAST DOMAINS|'+
								'^COMPANY ENGLISH NAME|^CONTACT LINKEO|^CONTACT PRIVACY|^CONTACT PROTECT|^CONTACT TECHNIQUE LRI|'+
								'^CORPORATION SERVICE COMPANY|^CRONON AG PROFESSIONAL IT-SERVICES|^CSC CORPORATE DOMAINS, INC.|'+
								'^DANESCO TRADING LTD|^DATA PRIVACY PROTECTED|^DATA PROTECTED|^DDSE|^DEVELOPMENT SERVICES|^DIRECT PRIVACY|'+
								'^DNS ADMIN|^DNS ADMINISTRATOR|^DOMAIN ADMIN|^DOMAIN DATA GUARD|^DOMAIN DEPARTMENT|^DOMAIN EXPIRED|^DOMAIN FOR SALE|'+
								'^DOMAIN ID SHIELD SERVICE CO|^DOMAIN MANAGEMENT|^DOMAIN MANAGER|^DOMAIN NAME ADMINISTRATOR|^DOMAIN PRIVACY|'+
								'^DOMAIN PROTECTION LLC|^DOMAIN PROXY SERVICE|^DOMAIN REGISTRAR|^DOMAIN REGISTRATIONS|^DOMAIN TECH|^DOMAIN TERMINATED FOR ABUSE|^DOMAIN$|'+
								'^DOMAINCLUB PRIVACY SERVICE|^DOMAIN-IT HOSTMASTER|^DOMAINMONSTER.COM PRIVACY SERVICE|^DOMAINS ADMIN$|^DOMAINS ADMINISTRATOR|^DOMAINS MANAGER|'+
								'^DOMAINS-BANKER|^EMAIL TO INQUIRE ABOUT THIS PREMIUM DOMAIN NAME|^EXAMPLE INC|^FIRST IMPRESSION INTERACTIVE|'+
								'^GKG.NET DOMAIN PROXY SERVICE ADMINISTRATOR|^GLOBAL DOMAIN PRIVACY|^GLOBAL IP HOLDINGS INC|^GMO CLOUD K.K.|'+
								'^GMO DIGIROCK, INC.|^GMO INTERNET INC.|^GMO INTERNET, INC.|^GMO PEPABO, INC.|^GODADDY.COM, INC|'+
								'^IDENTITY PROTECTION SERVICE|^INTELLECTUAL PROPERTY DEPARTMENT|^INTERNATIONAL DOMAIN ADMINISTRATOR|^INTERNATIONAL DOMAIN TECH|'+
								'^INTERNET SAKURA|^IT$|^IT DEPARTMENT|^IT DEPTMENT|^LCN HOSTMASTER|^MALI DILI B.V.|^POINT ML ADMINISTRATOR|^MANAGER DOMAIN|'+
								'^MARRIOTT INTERNATIONAL|^MONIKER PRIVACY SERVICES|^MSN HOSTMASTER$|^N/A$|^NA$|^NAME$|^NAMESPRO.CA PRIVATEWHOIS|'+
								'^OHP$|^ONLINE$|^ORANGE REGISTRAR$|^OTSUKA CORPORATION$|^OVH$|^PERFECT PRIVACY, LLC|^PERSONAL$|^PERSONAL INFORMATION|'+
								'^PREMIUM DOMAINS|^PRIVACIDAD WHOIS SL|^PRIVACY ADMINISTRATOR|^PRIVACY HERO INC|^PRIVACY PROTECTION|'+
								'^PRIVACY SHIELD LTD|^PRIVACY.CO.COM|^PRIVATE$|^PRIVATE CONTACT|^PRIVATE PERSON|PRIVATE REGISTRANT|PRIVATE REGISTRATION|^PRIVATE USER|'+
								'^PRIVATE WHOIS|^PROTECTION OF PRIVATE PERSON|^PROXY PROTECTION LLC|^PTS PRIVACY & TRUSTEE SERVICES|'+
								'^REACTIVATION PERIOD|REALTIME.AT DOMAIN SERVICES GMBH$|^REGISTER S.P.A|^REGISTRANT PRIVACY|^REGISTRACOM|^REGISTRANT STREET|^REGISTRANTPRIVACY.COM|'+
								'^REGISTRATION PRIVACY|^REGISTRATION PRIVATE|^SAFEWHOIS.CA WHOIS PRIVACY SERVICE|^SAKURA INTERNET|SAKURA INTERNET DOMAIN REGISTRATION|'+
								'^SAKURA INTERNET INC.|^SELF$|SEE PRIVACYGUARDIAN.ORG|^SEO DEPARTMENT|^SEO SEM DOMAIN MANAGEMNT DEPT|^SOFTLAYER DOMAIN PRIVACY|'+
								'^SOLOCAL MARKETING SERVICES|SUPER PRIVACY SERVICE LTD|^SWISS DOMAIN TRUSTEE|^SYSTEM ADMIN|'+
								'^TECH ADMIN|^TECH PHONE|^TECH STREET|^TECH SUPPORT|^TECHNICAL SUPPORT|^TECHNICAL CONTACT|^TECHNICAL DEPARTMENT|^TECHNICAL MANAGER|'+
								'^THE MANAGEMENT GROUP|^THIS DOMAIN |^TLD REGISTRAR SOLUTIONS LTD|^TOLL FREE:|^UNITED-DOMAINS AG|'+
								'^WEB SERVICES$|^WEBNAMES PRIVATE|^WEBSITE$|^WEBSITE SUPPORT$|^WEBSUPPORT, S.R.O.|^WHOIS AGENT|^WHOIS DATA PROTECTION|'+
								'^WHOIS DOMAIN ADMIN|WHOISGUARD, INC|^WHOIS PRIVACY|^WHOISBYPROXY ADMIN|^WHOISGUARD PROTECTED|^WHOISSECURE|^WPX XSERVER INC.|)';

	SELF.rawtext     := CHOOSE(C, SELF.registrant_rawtext, SELF.administrativeContact_rawtext, SELF.billingContact_rawText, SELF.technicalContact_rawText, SELF.zoneContact_rawText); 
	SELF.email       := CHOOSE(C, SELF.registrant_email, SELF.administrativeContact_email, SELF.billingContact_email, SELF.technicalContact_email, SELF.zoneContact_email); 
	trim_name        := CHOOSE(C, SELF.registrant_name, SELF.administrativeContact_name, SELF.billingContact_name, SELF.technicalContact_name, SELF.zoneContact_name); 
  SELF.name        := MAP(REGEXFIND(Inv_Pattern,trim_name)=>'',
	                        REGEXFIND(InvName_Pattern,trim_name)=>'',
													REGEXFIND(':',trim_name)=>'',
	                        NOT REGEXFIND('[A-Z]',trim_name) => '',
	                        TRIM(trim_name,LEFT,RIGHT));

	trim_organization:= CHOOSE(C, SELF.registrant_organization, SELF.administrativeContact_organization, SELF.billingContact_organization, SELF.technicalContact_organization, SELF.zoneContact_organization); 
	SELF.organization:= MAP(REGEXFIND(Inv_Pattern,trim_organization)=>'',
	                        REGEXFIND(InvName_Pattern,trim_organization)=>'',
													REGEXFIND(':',trim_organization)=>'',
	                        NOT REGEXFIND('[A-Z]',trim_organization) => '',
													TRIM(trim_organization,ALL) = TRIM(self.name,ALL) => '',
	                        TRIM(trim_organization,LEFT,RIGHT));
													
	trim_city    := CHOOSE(C, SELF.registrant_city, SELF.administrativeContact_city, SELF.billingContact_city, SELF.technicalContact_city, SELF.zoneContact_city); 
  SELF.city    := MAP(REGEXFIND(Inv_Pattern,trim_city)=>'',
	                    NOT REGEXFIND('[A-Z]',trim_city) => '',
	                    TRIM(trim_city,LEFT,RIGHT));
													
	trim_state   := CHOOSE(C, SELF.registrant_state, SELF.administrativeContact_state, SELF.billingContact_state, SELF.technicalContact_state, SELF.zoneContact_state); 
  SELF.state   := MAP(REGEXFIND(Inv_Pattern,trim_state)=>'',
	                        NOT REGEXFIND('[A-Z]',trim_state) => '',
	                        TRIM(trim_state,LEFT,RIGHT));
													
	trim_postalCode  := CHOOSE(C, SELF.registrant_postalCode, SELF.administrativeContact_postalCode, SELF.billingContact_postalCode, SELF.technicalContact_postalCode, SELF.zoneContact_postalCode); 
  SELF.postalCode  := MAP(REGEXFIND(Inv_Pattern,trim_postalCode)=>'',
	                        NOT REGEXFIND('[0-9]',trim_postalCode) => '',
	                        TRIM(trim_postalCode,LEFT,RIGHT));
	
	trim_country     := CHOOSE(C, SELF.registrant_country, SELF.administrativeContact_country, SELF.billingContact_country, SELF.technicalContact_country, SELF.zoneContact_country); 
  SELF.country     := MAP(REGEXFIND(Inv_Pattern,trim_country)=>'',
	                        NOT REGEXFIND('[A-Z]',trim_country) => '',
	                        TRIM(trim_country,LEFT,RIGHT));													
													
	trim_street1 := CHOOSE(C, SELF.registrant_street1, SELF.administrativeContact_street1, SELF.billingContact_street1, SELF.technicalContact_street1, SELF.zoneContact_street1); 
  SELF.street1 := MAP(REGEXFIND(Inv_Pattern,trim_street1)=>'',
	                    NOT REGEXFIND('[0-9A-Z]',trim_street1) => '',
											TRIM(trim_street1,ALL) = TRIM(SELF.Name,ALL) => '',
											TRIM(trim_street1,ALL) = TRIM(SELF.Organization,ALL) => '',
											TRIM(trim_street1,ALL) = TRIM(SELF.City,ALL) => '',
											TRIM(trim_street1,ALL) = TRIM(SELF.State,ALL) => '',
											TRIM(trim_street1,ALL) = TRIM(SELF.Country,ALL) => '',
	                    REGEXFIND('^.*\\.COM\\|',trim_street1) => REGEXREPLACE('^.*\\.COM\\|',trim_street1,''),
	                    REGEXFIND('^.* COM\\|',trim_street1) => REGEXREPLACE('^.* COM\\|',trim_street1,''),
											REGEXFIND('\\|.*\\COM$|',trim_street1) => REGEXREPLACE('\\|.*\\COM$|',trim_street1,''),
	                    trim_street1);

	trim_street2 := CHOOSE(C, SELF.registrant_street2, SELF.administrativeContact_street2, SELF.billingContact_street2, SELF.technicalContact_street2, SELF.zoneContact_street2); 
  SELF.street2 := MAP(REGEXFIND(Inv_Pattern,trim_street2)=>'',
	                    NOT REGEXFIND('[0-9A-Z]',trim_street2) => '',
											TRIM(trim_street2,ALL) = TRIM(SELF.Name,ALL) => '',
											TRIM(trim_street2,ALL) = TRIM(SELF.Organization,ALL) => '',
											TRIM(trim_street2,ALL) = TRIM(SELF.City,ALL) => '',
											TRIM(trim_street2,ALL) = TRIM(SELF.State,ALL) => '',
											TRIM(trim_street2,ALL) = TRIM(SELF.Country,ALL) => '',
											TRIM(trim_street2,ALL) = TRIM(SELF.street1,ALL) => '',
	                    REGEXFIND('^.*\\.COM\\|',trim_street2) => REGEXREPLACE('^.*\\.COM\\|',trim_street2,''),
	                    REGEXFIND('^.* COM\\|',trim_street2) => REGEXREPLACE('^.* COM\\|',trim_street2,''),
											REGEXFIND('\\|.*\\COM$|',trim_street2) => REGEXREPLACE('\\|.*\\COM$|',trim_street2,''),
	                    trim_street2);

	trim_street3 := CHOOSE(C, SELF.registrant_street3, SELF.administrativeContact_street3, SELF.billingContact_street3, SELF.technicalContact_street3, SELF.zoneContact_street3); 
  SELF.street3 := MAP(REGEXFIND(Inv_Pattern,trim_street3)=>'',
	                    NOT REGEXFIND('[0-9A-Z]',trim_street3) => '',
											TRIM(trim_street3,ALL) = TRIM(SELF.Name,ALL) => '',
											TRIM(trim_street3,ALL) = TRIM(SELF.Organization,ALL) => '',
											TRIM(trim_street3,ALL) = TRIM(SELF.City,ALL) => '',
											TRIM(trim_street3,ALL) = TRIM(SELF.State,ALL) => '',
											TRIM(trim_street3,ALL) = TRIM(SELF.Country,ALL) => '',
											TRIM(trim_street3,ALL) = TRIM(SELF.street1,ALL) => '',
											TRIM(trim_street3,ALL) = TRIM(SELF.street2,ALL) => '',
	                    REGEXFIND('^.*\\.COM\\|',trim_street3) => REGEXREPLACE('^.*\\.COM\\|',trim_street3,''),
	                    REGEXFIND('^.* COM\\|',trim_street3) => REGEXREPLACE('^.* COM\\|',trim_street3,''),
											REGEXFIND('\\|.*\\COM$|',trim_street3) => REGEXREPLACE('\\|.*\\COM$|',trim_street3,''),
	                    trim_street3);
	
	trim_street4 := CHOOSE(C, SELF.registrant_street4, SELF.administrativeContact_street4, SELF.billingContact_street4, SELF.technicalContact_street4, SELF.zoneContact_street4); 
  SELF.street4 := MAP(REGEXFIND(Inv_Pattern,trim_street4)=>'',
	                    NOT REGEXFIND('[0-9A-Z]',trim_street4) => '',
											TRIM(trim_street4,ALL) = TRIM(SELF.Name,ALL) => '',
											TRIM(trim_street4,ALL) = TRIM(SELF.Organization,ALL) => '',
											TRIM(trim_street4,ALL) = TRIM(SELF.City,ALL) => '',
											TRIM(trim_street4,ALL) = TRIM(SELF.State,ALL) => '',
											TRIM(trim_street4,ALL) = TRIM(SELF.Country,ALL) => '',
											TRIM(trim_street4,ALL) = TRIM(SELF.street1,ALL) => '',
											TRIM(trim_street4,ALL) = TRIM(SELF.street2,ALL) => '',
											TRIM(trim_street4,ALL) = TRIM(SELF.street3,ALL) => '',
	                    REGEXFIND('^.*\\.COM\\|',trim_street4) => REGEXREPLACE('^.*\\.COM\\|',trim_street4,''),
	                    REGEXFIND('^.* COM\\|',trim_street4) => REGEXREPLACE('^.* COM\\|',trim_street4,''),
											REGEXFIND('\\|.*\\COM$|',trim_street4) => REGEXREPLACE('\\|.*\\COM$|',trim_street4,''),
	                    trim_street4);
											
	trim_fax     := CHOOSE(C, SELF.registrant_fax, SELF.administrativeContact_fax, SELF.billingContact_fax, SELF.technicalContact_fax, SELF.zoneContact_fax); 
  SELF.fax     := MAP(REGEXFIND(Inv_Pattern,trim_fax)=>'',
											NOT REGEXFIND('[1-9]',trim_fax) => '',
											TRIM(trim_fax,LEFT,RIGHT));	
											
	trim_faxExt  := CHOOSE(C, SELF.registrant_faxExt, SELF.administrativeContact_faxExt, SELF.billingContact_faxExt, SELF.technicalContact_faxExt, SELF.zoneContact_faxExt); 
  SELF.faxExt  := MAP(REGEXFIND(Inv_Pattern,trim_faxExt)=>'',
											NOT REGEXFIND('[1-9]',trim_faxExt) => '',
											TRIM(trim_faxExt,LEFT,RIGHT));	
											
	trim_phone   := CHOOSE(C, SELF.registrant_phone, SELF.administrativeContact_phone, SELF.billingContact_phone, SELF.technicalContact_phone, SELF.zoneContact_phone); 
  SELF.phone   := MAP(REGEXFIND(Inv_Pattern,trim_phone)=>'',
											NOT REGEXFIND('[1-9]',trim_phone) => '',
											TRIM(trim_phone,LEFT,RIGHT));	
											
	trim_phoneExt:= CHOOSE(C, SELF.registrant_phoneExt, SELF.administrativeContact_phoneExt, SELF.billingContact_phoneExt, SELF.technicalContact_phoneExt, SELF.zoneContact_phoneExt); 
  SELF.phoneExt:= MAP(REGEXFIND(Inv_Pattern,trim_phoneExt)=>'',
											NOT REGEXFIND('[1-9]',trim_phoneExt) => '',
											TRIM(trim_phoneExt,LEFT,RIGHT));	
											
	SELF.EmailType     := CHOOSE(C,'RE','AE','BE','TE','ZE');		
	SELF.createdDate	 := STD.Date.ConvertDateFormatMultiple(le.createdDate,fmtsin,fmtout);       //when the domain name was first registered/created
	SELF.UpdatedDate	 := STD.Date.ConvertDateFormatMultiple(le.updatedDate,fmtsin,fmtout);       //when the whois data were updated
	SELF.ExpiresDate	 := STD.Date.ConvertDateFormatMultiple(le.expiresDate,fmtsin,fmtout);       //when the domain name will expire
	SELF.Status        := ut.CleanSpacesAndUpper(le.status);                                      //domain name status code
	SELF 					:= le;
	SELF					:= [];
END;

	ds_norm 	:= NORMALIZE(clnfile,5,t_norm_email(LEFT,COUNTER));
	ds_dist   := DISTRIBUTE(ds_norm,HASH(domainname, email, name, street1, city, state));
  ds_sort   := SORT(ds_dist,domainname,email,name,street1,city,state,LOCAL);
	ds_dedup  := DEDUP(ds_sort, EXCEPT RAWTEXT,EMAILTYPE,LOCAL);
	
	//Populate added fields prior to cleaning
	Layouts.Base tAppendFields(Layouts.CleanFields le) := TRANSFORM
		SELF.DID          							:= 0;
		SELF.RawAID											:= 0;
		SELF.Process_Date 							:= thorlib.wuid()[2..9];
		StdDatestamp										:= STD.Date.ConvertDateFormatMultiple(le.updatedDate,fmtsin,fmtout);
		vDatestamp											:= STD.Date.IsValidDate((INTEGER)StdDatestamp);
		SELF.date_first_seen						:= IF(vDatestamp, StdDatestamp, '');
		SELF.date_last_seen							:= IF(vDatestamp, StdDatestamp, '');
		SELF.Date_Vendor_First_Reported := version;
		SELF.Date_Vendor_Last_Reported 	:= version;
		SELF.current_rec 	:= TRUE;
		SELF							:= le;
		SELF							:= [];
  END;
	
  pAppendInput	:= PROJECT(ds_dedup,tAppendFields(LEFT)): persist('~thor_data400::in::WhoIs::prep_ingest');
	
	RETURN pAppendInput;
	
END;