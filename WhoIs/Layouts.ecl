Import AID, Address, bipv2;
EXPORT layouts := MODULE
	EXPORT raw := RECORD
		STRING100 domainName;
		STRING100 registrarName;
		STRING80  contactEmail;
		STRING50  whoisServer;
		STRING50  nameServers;
		STRING50  createdDate;	            //when the domain name was first registered/created
		STRING50  updatedDate;	            //when the whois data were updated
		STRING50  expiresDate;	            //when the domain name will expire
		STRING10  standardRegCreatedDate;	//created date in the standard format(YYYY-mm-dd), e.g. 2012-02-01
		STRING10  standardRegUpdatedDate;	//updated date in the standard format(YYYY-mm-dd), e.g. 2012-02-01
		STRING10  standardRegExpiresDate;	//expires date in the standard format(YYYY-mm-dd), e.g. 2012-02-01
		STRING50  status;	                //domain name status code
		STRING10  Audit_auditUpdatedDate;	//the timestamp of when the whois record is collected in the standardFormat(YYYYmm-dd), e.g. 2012-02-01

		// The domain name registrant is the owner of the domain name. 
		STRING100 registrant_rawtext;
		STRING80  registrant_email;
		STRING50  registrant_name;
		STRING50  registrant_organization;
		STRING100 registrant_street1;
		STRING100 registrant_street2;
		STRING100 registrant_street3;
		STRING100 registrant_street4;
		STRING25  registrant_city;
		STRING10  registrant_state;
		STRING20  registrant_postalCode;
		STRING20  registrant_country;
		STRING15  registrant_fax;
		STRING15  registrant_faxExt;
		STRING15  registrant_phone;
		STRING15  registrant_phoneExt;
		
		// The administrative contact is the person in charge of the administrative 
		// dealings pertaining to the company owning the domain name.
		STRING100 administrativeContact_rawtext;
		STRING80  administrativeContact_email;
		STRING50  administrativeContact_name;
		STRING50  administrativeContact_organization;
		STRING100 administrativeContact_street1;
		STRING100 administrativeContact_street2;
		STRING100 administrativeContact_street3;
		STRING100 administrativeContact_street4;
		STRING25  administrativeContact_city;
		STRING10  administrativeContact_state;
		STRING20  administrativeContact_postalCode;
		STRING20  administrativeContact_country;
		STRING15  administrativeContact_fax;
		STRING15  administrativeContact_faxExt;
		STRING15  administrativeContact_phone;
		STRING15  administrativeContact_phoneExt;
		// the billing contact is the individual who is authorized by the registrant 
		// to receive the invoice for domain name registration and domain name renewal fees.	
		STRING100 billingContact_rawText; 
		STRING80  billingContact_email; 
		STRING50  billingContact_name;
		STRING50  billingContact_organization; 
		STRING100 billingContact_street1;
		STRING100 billingContact_street2; 
		STRING100 billingContact_street3;
		STRING100 billingContact_street4; 
		STRING25  billingContact_city; 
		STRING10  billingContact_state;
		STRING20 billingContact_postalCode; 
		STRING20 billingContact_country;
		STRING15 billingContact_fax; 
		STRING15 billingContact_faxExt;
		STRING15 billingContact_phone; 
		STRING15 billingContact_phoneExt;
		// The technical contact is the person in charge of all technical questions 
		// regarding a particular domain name.			
		STRING100 technicalContact_rawText; 
		STRING80  technicalContact_email;
		STRING50  technicalContact_name; 
		STRING50  technicalContact_organization;
		STRING100 technicalContact_street1; 
		STRING100 technicalContact_street2;
		STRING100 technicalContact_street3; 
		STRING100 technicalContact_street4;
		STRING25  technicalContact_city; 
		STRING10  technicalContact_state;
		STRING20  technicalContact_postalCode; 
		STRING20  technicalContact_country;
		STRING15  technicalContact_fax; 
		STRING15  technicalContact_faxExt;
		STRING15  technicalContact_phone; 
		STRING15  technicalContact_phoneExt;
		// The domain technical/zone contact is the person who tends to the technical aspects of 
		// maintaining the domain’s name server and resolver software, and database files.
		STRING100 zoneContact_rawText; 
		STRING80  zoneContact_email; 
		STRING50  zoneContact_name;
		STRING50  zoneContact_organization; 
		STRING100 zoneContact_street1; 
		STRING100 zoneContact_street2;
		STRING100 zoneContact_street3; 
		STRING100 zoneContact_street4; 
		STRING25  zoneContact_city;
		STRING10  zoneContact_state; 
		STRING20  zoneContact_postalCode; 
		STRING20  zoneContact_country;
		STRING15  zoneContact_fax; 
		STRING15  zoneContact_faxExt; 
		STRING15  zoneContact_phone;
		STRING15  zoneContact_phoneExt;
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
		STRING10  state;
		STRING20  postalCode;
		STRING20  country;
		STRING15 fax;
		STRING15 faxExt;
		STRING15 phone;
		STRING15 phoneExt;
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
		
  EXPORT UniqueId := RECORD
	UNSIGNED8 unique_id;
	Base;
	END;
END;	