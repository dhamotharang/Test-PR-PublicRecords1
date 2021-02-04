Import AID, Address, bipv2;
EXPORT layouts := MODULE
	EXPORT raw := RECORD
		STRING  domainName;
		STRING  registrarName;
		STRING  contactEmail;
		STRING  whoisServer;
		STRING  nameServers;
		STRING  createdDate;	            //when the domain name was first registered/created
		STRING  updatedDate;	            //when the whois data were updated
		STRING  expiresDate;	            //when the domain name will expire
		STRING  standardRegCreatedDate;	//created date in the standard format(YYYY-mm-dd), e.g. 2012-02-01
		STRING  standardRegUpdatedDate;	//updated date in the standard format(YYYY-mm-dd), e.g. 2012-02-01
		STRING  standardRegExpiresDate;	//expires date in the standard format(YYYY-mm-dd), e.g. 2012-02-01
		STRING  status;	                //domain name status code
		STRING  Audit_auditUpdatedDate;	//the timestamp of when the whois record is collected in the standardFormat(YYYYmm-dd), e.g. 2012-02-01

		// The domain name registrant is the owner of the domain name. 
		STRING  registrant_rawtext;
		STRING  registrant_email;
		STRING  registrant_name;
		STRING  registrant_organization;
		STRING registrant_street1;
		STRING registrant_street2;
		STRING registrant_street3;
		STRING registrant_street4;
		STRING  registrant_city;
		STRING  registrant_state;
		STRING  registrant_postalCode;
		STRING  registrant_country;
		STRING  registrant_fax;
		STRING  registrant_faxExt;
		STRING  registrant_phone;
		STRING  registrant_phoneExt;
		
		// The administrative contact is the person in charge of the administrative 
		// dealings pertaining to the company owning the domain name.
		STRING administrativeContact_rawtext;
		STRING  administrativeContact_email;
		STRING  administrativeContact_name;
		STRING  administrativeContact_organization;
		STRING administrativeContact_street1;
		STRING administrativeContact_street2;
		STRING administrativeContact_street3;
		STRING administrativeContact_street4;
		STRING  administrativeContact_city;
		STRING  administrativeContact_state;
		STRING  administrativeContact_postalCode;
		STRING  administrativeContact_country;
		STRING  administrativeContact_fax;
		STRING  administrativeContact_faxExt;
		STRING  administrativeContact_phone;
		STRING  administrativeContact_phoneExt;
		// the billing contact is the individual who is authorized by the registrant 
		// to receive the invoice for domain name registration and domain name renewal fees.	
		STRING billingContact_rawText; 
		STRING  billingContact_email; 
		STRING  billingContact_name;
		STRING  billingContact_organization; 
		STRING billingContact_street1;
		STRING billingContact_street2; 
		STRING billingContact_street3;
		STRING billingContact_street4; 
		STRING  billingContact_city; 
		STRING  billingContact_state;
		STRING billingContact_postalCode; 
		STRING billingContact_country;
		STRING billingContact_fax; 
		STRING billingContact_faxExt;
		STRING billingContact_phone; 
		STRING billingContact_phoneExt;
		// The technical contact is the person in charge of all technical questions 
		// regarding a particular domain name.			
		STRING technicalContact_rawText; 
		STRING  technicalContact_email;
		STRING  technicalContact_name; 
		STRING  technicalContact_organization;
		STRING technicalContact_street1; 
		STRING technicalContact_street2;
		STRING technicalContact_street3; 
		STRING technicalContact_street4;
		STRING  technicalContact_city; 
		STRING  technicalContact_state;
		STRING  technicalContact_postalCode; 
		STRING  technicalContact_country;
		STRING  technicalContact_fax; 
		STRING  technicalContact_faxExt;
		STRING  technicalContact_phone; 
		STRING  technicalContact_phoneExt;
		// The domain technical/zone contact is the person who tends to the technical aspects of 
		// maintaining the domain’s name server and resolver software, and database files.
		STRING  zoneContact_rawText; 
		STRING  zoneContact_email; 
		STRING  zoneContact_name;
		STRING  zoneContact_organization; 
		STRING  zoneContact_street1; 
		STRING  zoneContact_street2;
		STRING  zoneContact_street3; 
		STRING  zoneContact_street4; 
		STRING  zoneContact_city;
		STRING  zoneContact_state; 
		STRING  zoneContact_postalCode; 
		STRING  zoneContact_country;
		STRING  zoneContact_fax; 
		STRING  zoneContact_faxExt; 
		STRING  zoneContact_phone;
		STRING  zoneContact_phoneExt;
	END;
	
	EXPORT CleanFields := RECORD
		STRING100 EmailType;
		STRING100 rawtext;
		STRING80  email;
		STRING100 name;
		STRING100 organization;
		STRING100 street1;
		STRING100 street2;
		STRING100 street3;
		STRING100 street4;
		STRING25  city;
		STRING25  state;
		STRING25  postalCode;
		STRING25  country;
		STRING20 fax;
		STRING20 faxExt;
		STRING20 phone;
		STRING20 phoneExt;
	  raw;		
	END;

	EXPORT Base	:= RECORD
		//DID fields
		UNSIGNED8 DID;
		UNSIGNED8 DID_Score;
		
		//Instance tracking fields
		STRING8		process_date;
		STRING8		date_first_seen;
		STRING8		date_last_seen;
		STRING8		date_vendor_first_reported;
		STRING8		date_vendor_last_reported;
		STRING50	clean_cname;
		BOOLEAN 	current_rec;
		bipv2.IDlayouts.l_xlink_ids;
		
		//Clean name fields
		STRING5		clean_title;
    STRING20	clean_fname;
    STRING20	clean_mname;
    STRING20	clean_lname;
    STRING5		clean_name_suffix;
    STRING3		clean_name_score;
		
		//AID Fields
		AID.Common.xAID	RawAID;
		STRING77	Append_Prep_Address_Situs;
		STRING54	Append_Prep_Address_Last_Situs;
		
		//Clean address fields
		address.Layout_Clean182;
		
		UNSIGNED6 rcid; //Used for Ingest process
	  CleanFields;
		// UNSIGNED8	persistent_record_id := 0;	//unique record identifier
		// UNSIGNED8 uniq_email_id := 0;   //unique email identifier		
		END;
		
END;	