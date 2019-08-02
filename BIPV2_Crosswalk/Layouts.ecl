export Layouts := module	

    /**
       Child Record Structures to store the individual PII
     **/
     export DateWorkRec := record
          unsigned6                   ultid;
          unsigned6                   orgid;
          unsigned6                   seleid;
		unsigned4                   dt_first_seen;
          unsigned4                   dt_last_seen;
	end;
	
     export ContactNameRec := record
	     string5            title;
	     string20           fname;
	     string20           mname;
	     string20           lname;	
	     string5            name_suffix;
	     string12           sourceGroup;
		string2            source;
		unsigned2          contact_name_permits;
		unsigned4          dt_first_seen_at_business;
          unsigned4          dt_last_seen_at_business;
	end;

     export ContactSSNRec := record
	     string9            contact_ssn;
	     string12           sourceGroup;
		string2            source;
		unsigned2          contact_ssn_permits;
	end;

     export ContactDOBRec := record
	     unsigned4          contact_dob;
	     string12           sourceGroup;
		string2            source;
		unsigned2          contact_dob_permits;
	end;
	
     export ContactEmailRec := record
	     string60           contact_email;
	     string12           sourceGroup;
		string2            source;
		unsigned2          contact_email_permits;
	end;
	
     export ContactPhoneRec := record
	     string10           contact_phone;
	     string12           sourceGroup;
		string2            source;
		unsigned2          contact_phone_permits;
	end;

     export ContactAddressRec := record
		string10           prim_range;
		string2            predir;
		string28           prim_name;
		string4            addr_suffix;
		string2            postdir;
		string10           unit_desig;
	     string8            sec_range;
		string25           v_city_name;
	     string2            st;
	     string5            zip;
	     string4            zip4;
	     string12           sourceGroup;
		string2            source;
		unsigned2          contact_address_permits;
	end;
	
     export JobTitleRec := record
		string50           job_title;
		integer            executive_ind_order;
	     string12           sourceGroup;
		string2            source;
		unsigned2          job_title_permits;
	end;

	/**
	Layout for the non-key dataset
	**/
     export CrossWalkRec := record
          unsigned6                   ultid;
          unsigned6                   orgid;
          unsigned6                   seleid;
          unsigned6                   proxid;
	     unsigned6                   empid;
          unsigned6                   contact_did;
		unsigned4                   dt_first_seen;
          unsigned4                   dt_last_seen;
          dataset(ContactNameRec)     contactNames;
          dataset(ContactSSNRec)      contactSSNs;
          dataset(ContactDOBRec)      contactDOBs;
          dataset(ContactEmailRec)    contactEmails;
          dataset(ContactPhoneRec)    contactPhones;
          dataset(ContactAddressRec)  contactAddresses;
          dataset(JobTitleRec)        jobTitles;
     end;
	
     /**
	  Final Layout used for Keys
	**/
     export BipToConsumerCrossWalkRec := record
          CrossWalkRec;
		unsigned4 global_sid;
          unsigned8 record_sid;
     end;

     export ConsumerToBipCrossWalkRec := record(CrossWalkRec - contactSSNs - contactDOBs - contactEmails - contactPhones - contactAddresses)
		unsigned4 global_sid;
          unsigned8 record_sid;
     end;
		
	
	/**
	 Intermediate Layouts used in the Build Step
	**/
     export CrossWalkWorkRec1 := record
          unsigned6          ultid;
          unsigned6          orgid;
          unsigned6          seleid;
          unsigned6          proxid;
	     unsigned6          empid;
          unsigned6          contact_did;
          integer            executive_ind_order;
	     string5            title;
	     string20           fname;
	     string20           mname;
	     string20           lname;	
	     string5            name_suffix;
	     string12           sourceGroup;
		unsigned4          dt_first_seen;
          unsigned4          dt_last_seen;
		unsigned4          dt_first_seen_at_business;
          unsigned4          dt_last_seen_at_business;
		string9            contact_ssn;
	     unsigned4          contact_dob;
	     string60           contact_email;
	     string10           contact_phone;
		string10           prim_range;
		string2            predir;
		string28           prim_name;
		string4            addr_suffix;
		string2            postdir;
		string10           unit_desig;
	     string8            sec_range;
		string25           v_city_name;
	     string2            st;
	     string5            zip;
	     string4            zip4;
		string2            source;
		string34           vl_id;
		string50           job_title;
		integer            jobTitleOrder;
     end;

     export CrossWalkWorkRec2 := record
          unsigned6                   ultid;
          unsigned6                   orgid;
          unsigned6                   seleid;
          unsigned6                   contact_did;
          unsigned6                   empid;
          dataset(JobTitleRec)        jobTitles;
     end;	

	
	/**
	 Roxie Interface Intermediate Layouts For consumer 2 bip
	**/
     export ConsumerToBipWorkRec1 := record
          unsigned6                   contact_did;
          unsigned6                   ultid;
          unsigned6                   orgid;
          unsigned6                   seleid;
          unsigned6                   proxid;
		unsigned6                   uniqueID;
		unsigned4                   dt_first_seen;
          unsigned4                   dt_last_seen;
          JobTitleRec;
		dataset(ContactNameRec)     contactNames;
     end;

     export ConsumerToBipWorkRec2 := record
          unsigned6                   contact_did;
          unsigned6                   ultid;
          unsigned6                   orgid;
          unsigned6                   seleid;
          unsigned6                   proxid;
		unsigned6                   uniqueID;
		unsigned4                   dt_first_seen;
          unsigned4                   dt_last_seen;
          JobTitleRec;
		ContactNameRec;
     end;

	/**
	 Roxie Interface Final Layout For consumer 2 bip
	**/
     export ConsumerToBipFinalRec := record
	     unsigned6          uniqueID;
	     unsigned6          ultid;
          unsigned6          orgid;
          unsigned6          seleid;
          unsigned6          proxid;
          unsigned6          contact_did;		
		unsigned4          dt_first_seen;
          unsigned4          dt_last_seen;
		unsigned4          dt_first_seen_at_business;
          unsigned4          dt_last_seen_at_business;
		integer            executive_ind_order;
          string50           job_title1;
          string50           job_title2;
          string50           job_title3;
     end;

	/**
	 Roxie Interface Intermediate Layouts For bip 2 consumer
	**/
     export BipToConsumerWorkRec1 := record
	     unsigned6                   ultid;
          unsigned6                   orgid;
          unsigned6                   seleid;
          unsigned6                   proxid;
	     unsigned6                   empid;
		unsigned6                   uniqueID;
          unsigned6                   contact_did;
		unsigned4                   dt_first_seen;
          unsigned4                   dt_last_seen;
          ContactNameRec;
          dataset(ContactSSNRec)      contactSSNs;
          dataset(ContactDOBRec)      contactDOBs;
          dataset(ContactEmailRec)    contactEmails;
          dataset(ContactPhoneRec)    contactPhones;
          dataset(ContactAddressRec)  contactAddresses;
          dataset(JobTitleRec)        jobTitles;
	end;
	
     export BipToConsumerWorkRec2 := record
	     unsigned6                   ultid;
          unsigned6                   orgid;
          unsigned6                   seleid;
          unsigned6                   proxid;
	     unsigned6                   empid;
		unsigned6                   uniqueID;
          unsigned6                   contact_did;
		unsigned4                   dt_first_seen;
          unsigned4                   dt_last_seen;
          ContactNameRec;
          ContactSSNRec;
          dataset(ContactDOBRec)      contactDOBs;
          dataset(ContactEmailRec)    contactEmails;
          dataset(ContactPhoneRec)    contactPhones;
          dataset(ContactAddressRec)  contactAddresses;
          dataset(JobTitleRec)        jobTitles;
	end;
 
      export BipToConsumerWorkRec3 := record
	     unsigned6                   ultid;
          unsigned6                   orgid;
          unsigned6                   seleid;
          unsigned6                   proxid;
	     unsigned6                   empid;
          unsigned6                   contact_did;
		unsigned6                   uniqueID;
		unsigned4                   dt_first_seen;
          unsigned4                   dt_last_seen;
          ContactNameRec;
          ContactSSNRec;
          ContactDOBRec;
          dataset(ContactEmailRec)    contactEmails;
          dataset(ContactPhoneRec)    contactPhones;
          dataset(ContactAddressRec)  contactAddresses;
          dataset(JobTitleRec)        jobTitles;
	end;

      export BipToConsumerWorkRec4 := record
	     unsigned6                   ultid;
          unsigned6                   orgid;
          unsigned6                   seleid;
          unsigned6                   proxid;
	     unsigned6                   empid;
		unsigned6                   uniqueID;
          unsigned6                   contact_did;
		unsigned4                   dt_first_seen;
          unsigned4                   dt_last_seen;
          ContactNameRec;
          ContactSSNRec;
          ContactDOBRec;
          ContactEmailRec;
          dataset(ContactPhoneRec)    contactPhones;
          dataset(ContactAddressRec)  contactAddresses;
          dataset(JobTitleRec)        jobTitles;
	end;	
	
     export BipToConsumerWorkRec5 := record
	     unsigned6                   ultid;
          unsigned6                   orgid;
          unsigned6                   seleid;
          unsigned6                   proxid;
	     unsigned6                   empid;
		unsigned6                   uniqueID;
          unsigned6                   contact_did;
		unsigned4                   dt_first_seen;
          unsigned4                   dt_last_seen;
          ContactNameRec;
          ContactSSNRec;
          ContactDOBRec;
          ContactEmailRec;
          ContactPhoneRec;
          dataset(ContactAddressRec)  contactAddresses;
          dataset(JobTitleRec)        jobTitles;
	end;	
	
     export BipToConsumerWorkRec6 := record
	     unsigned6                   ultid;
          unsigned6                   orgid;
          unsigned6                   seleid;
          unsigned6                   proxid;
	     unsigned6                   empid;
		unsigned6                   uniqueID;
          unsigned6                   contact_did;
		unsigned4                   dt_first_seen;
          unsigned4                   dt_last_seen;
          ContactNameRec;
          ContactSSNRec;
          ContactDOBRec;
          ContactEmailRec;
          ContactPhoneRec;
          ContactAddressRec;
          dataset(JobTitleRec)        jobTitles;
	end;	
	
     export BipToConsumerWorkRec7 := record
	     unsigned6                   ultid;
          unsigned6                   orgid;
          unsigned6                   seleid;
          unsigned6                   proxid;
	     unsigned6                   empid;
		unsigned6                   uniqueID;
          unsigned6                   contact_did;
		unsigned4                   dt_first_seen;
          unsigned4                   dt_last_seen;
          ContactNameRec;
          ContactSSNRec;
          ContactDOBRec;
          ContactEmailRec;
          ContactPhoneRec;
          ContactAddressRec;
          JobTitleRec;
	end;	

	/**
	 Roxie Interface Final Layout2 For bip 2 consumer
	**/	
	export BipToConsumerFinalRec := record
	     unsigned6          uniqueID;
	     unsigned6          ultid;
          unsigned6          orgid;
          unsigned6          seleid;
          unsigned6          proxid;
	     unsigned6          empid;
          unsigned6          contact_did;
		unsigned4          dt_first_seen;
          unsigned4          dt_last_seen;
	     string5            title;
	     string20           fname;
	     string20           mname;
	     string20           lname;	
	     string5            name_suffix;
		unsigned4          dt_first_seen_at_business;
          unsigned4          dt_last_seen_at_business;
		string9            contact_ssn;
		unsigned4          contact_dob;
		string60           contact_email;
		string10           contact_phone;
		string10           prim_range;
		string2            predir;
		string28           prim_name;
		string4            addr_suffix;
		string2            postdir;
		string10           unit_desig;
	     string8            sec_range;
		string25           v_city_name;
	     string2            st;
	     string5            zip;
	     string4            zip4;
		integer            executive_ind_order;
          string50           job_title1;
          string50           job_title2;
          string50           job_title3;
	end;
end;