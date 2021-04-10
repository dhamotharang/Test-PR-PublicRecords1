Import AID, Address, bipv2;
EXPORT layouts := MODULE
	EXPORT raw := RECORD
		string domainName;
		string registrarName;
		string contactEmail;
		string whoisServer;
		string nameServers;
		string createdDate;	            //when the domain name was first registered/created
		string updatedDate;	            //when the whois data were updated
		string expiresDate;	            //when the domain name will expire
		string standardRegCreatedDate;	//created date in the standard format(YYYY-mm-dd), e.g. 2012-02-01
		string standardRegUpdatedDate;	//updated date in the standard format(YYYY-mm-dd), e.g. 2012-02-01
		string standardRegExpiresDate;	//expires date in the standard format(YYYY-mm-dd), e.g. 2012-02-01
		string status;	                //domain name status code
		string Audit_auditUpdatedDate;	//the timestamp of when the whois record is collected in the standardFormat(YYYYmm-dd), e.g. 2012-02-01

		// The domain name registrant is the owner of the domain name. 
		string registrant_rawtext;
		string registrant_email;
		string registrant_name;
		string registrant_organization;
		string registrant_street1;
		string registrant_street2;
		string registrant_street3;
		string registrant_street4;
		string registrant_city;
		string registrant_state;
		string registrant_postalCode;
		string registrant_country;
		string registrant_fax;
		string registrant_faxExt;
		string registrant_phone;
		string registrant_phoneExt;
		
		// The administrative contact is the person in charge of the administrative 
		// dealings pertaining to the company owning the domain name.
		string administrativeContact_rawtext;
		string administrativeContact_email;
		string administrativeContact_name;
		string administrativeContact_organization;
		string administrativeContact_street1;
		string administrativeContact_street2;
		string administrativeContact_street3;
		string administrativeContact_street4;
		string administrativeContact_city;
		string administrativeContact_state;
		string administrativeContact_postalCode;
		string administrativeContact_country;
		string administrativeContact_fax;
		string administrativeContact_faxExt;
		string administrativeContact_phone;
		string administrativeContact_phoneExt;
		// the billing contact is the individual who is authorized by the registrant 
		// to receive the invoice for domain name registration and domain name renewal fees.	
		string billingContact_rawText; 
		string billingContact_email; 
		string billingContact_name;
		string billingContact_organization; 
		string billingContact_street1;
		string billingContact_street2; 
		string billingContact_street3;
		string billingContact_street4; 
		string billingContact_city; 
		string billingContact_state;
		string billingContact_postalCode; 
		string billingContact_country;
		string billingContact_fax; 
		string billingContact_faxExt;
		string billingContact_phone; 
		string billingContact_phoneExt;
		// The technical contact is the person in charge of all technical questions 
		// regarding a particular domain name.			
		string technicalContact_rawText; 
		string technicalContact_email;
		string technicalContact_name; 
		string technicalContact_organization;
		string technicalContact_street1; 
		string technicalContact_street2;
		string technicalContact_street3; 
		string technicalContact_street4;
		string technicalContact_city; 
		string technicalContact_state;
		string technicalContact_postalCode; 
		string technicalContact_country;
		string technicalContact_fax; 
		string technicalContact_faxExt;
		string technicalContact_phone; 
		string technicalContact_phoneExt;
		// The domain technical/zone contact is the person who tends to the technical aspects of 
		// maintaining the domain’s name server and resolver software, and database files.
		string zoneContact_rawText; 
		string zoneContact_email; 
		string zoneContact_name;
		string zoneContact_organization; 
		string zoneContact_street1; 
		string zoneContact_street2;
		string zoneContact_street3; 
		string zoneContact_street4; 
		string zoneContact_city;
		string zoneContact_state; 
		string zoneContact_postalCode; 
		string zoneContact_country;
		string zoneContact_fax; 
		string zoneContact_faxExt; 
		string zoneContact_phone;
		string zoneContact_phoneExt;
	END;
	
	EXPORT CleanFields := RECORD
	  raw;
		STRING10  EmailType;
		STRING rawtext;
		STRING email;
		STRING name;
		STRING organization;
		STRING street1;
		STRING street2;
		STRING street3;
		STRING street4;
		STRING city;
		STRING state;
		STRING postalCode;
		STRING country;
		STRING fax;
		STRING faxExt;
		STRING phone;
		STRING phoneExt;
	END;

	EXPORT Base	:= RECORD
		UNSIGNED6 rcid; //Used for Ingest process
	  CleanFields;
		UNSIGNED8	persistent_record_id := 0;	//unique record identifier
		UNSIGNED8 uniq_email_id := 0;   //unique email identifier
	
		
		//DID fields
		UNSIGNED8 DID;
		UNSIGNED8 DID_Score;

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
		
		//Instance tracking fields
		STRING8		process_date;
		STRING8		date_first_seen;
		STRING8		date_last_seen;
		STRING8		date_vendor_first_reported;
		STRING8		date_vendor_last_reported;
		STRING		clean_cname;
		BOOLEAN 	current_rec;
		bipv2.IDlayouts.l_xlink_ids;
		END;
		
  EXPORT UniqueId := RECORD
	UNSIGNED8 unique_id;
	Base;
	END;
END;	