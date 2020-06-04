import Domains;

export Add_DomainBDID_2Emails_With_Patterns (

	 //string						    																													pversion
	 dataset(Domains.Layout_Whois_Base_BIP														)	pDomainsFile	= Domains.File_Whois_Base_Old
	,dataset(POEsFromEmails.layouts.EmailWithUidPatternTagAndCount) pEmails				= POEsFromEmails.Get_UserId_Patterns_In_Emails()

) := function

	// Get my sample of Herzberg emails that have been determined to have domains that are potential POEs.
	//emails := POEsFromEmails.PotentialPOEsEmailUidPatternAndDomainStatisticsForAllHerzbergEmails;
	//output(count(emails),named('size_of_emails'));
		
	/*===========================================================================
		MAKE A LIST OF DOMAINS FOUND IN EMAILS & PUT THEM IN BLANK DOMAIN REGISTRANT 
		INFO RECORD
		
		I do this by 1) projecting emails into Registration Info records, 2) distributing
		by append_domain, 3) sorting locally by append_domain, and then 4) locally deduping
		by append_domain
	*/
	
	EmailDomainWithBDIDRec := RECORD
		 string120 append_domain;
		 unsigned6 bdid 									:= 0;
		 string46  registrant_name				:='';
		 string45  registrant_address1		:='';
		 string45  registrant_address2		:='';
		 string45  registrant_address3		:='';
		 string45  registrant_address4		:='';
		 string45  registrant_address5		:='';
		 string45  registrant_address6		:='';
		 string45  registrant_address7		:='';
		 string45  registrant_address8		:='';
		 string45  registrant_address9		:='';
		 string45  registrant_address10		:='';
		 string8 	 domain_date_last_seen 	:='';   
	END;

	ListOfEmailDomainsDS0 :=
		 dedup(
					 sort(
								dedup(
											sort(
													 distribute(
																			project(pEmails, EmailDomainWithBDIDRec)
																			, hash32(random())
													 )
													 , append_domain
													 , local
											)
											, append_domain
											, local
								)
					 , append_domain
					 )
					 , append_domain
		 );
	//output(count(ListOfEmailDomainsDS0),named('size_of_domains_in_emails'));
	//===========================================================================

	/*===========================================================================
		JOIN WhoisDS with list of domains from emails TO FILL IN BEST REGISTRANT INFO
	*/
	whois_base_layout := Domains.Layout_Whois_Base_BIP;

	WhoisDS := pDomainsFile(bdid<>0);
	//output(count(WhoisDS),named('Number_of_nonzero_bdid_Whois_Records')); 
	 
	EmailDomainWithBDIDRec fillRegistrantInfo( whois_base_layout l ):= TRANSFORM
		 self.append_domain 				:= l.domain_name;
		 self.domain_date_last_seen := l.date_last_seen;
		 self 											:= l;
	END;
	 
	/*
		 This joins domain BDIDs with email domains. Then, distributes them by there seqno.
		 And, finally does a local sort by seqno.
	*/
	ListOfEmailDomainsWithBestRegistrantInfoDS := 
			dedup(
						sort(
								 dedup(
											 sort(
														distribute(
																			 join( WhoisDS, ListOfEmailDomainsDS0
																						 , (left.domain_name=right.append_domain)
																						 , fillRegistrantInfo( LEFT )
																						 , LOOKUP
																			 )
																			 , hash64(random())
														)
														, append_domain, -domain_date_last_seen
														, local
											 )
											 , append_domain
											 ,local
								)
						, append_domain, -domain_date_last_seen
						)
			, append_domain
			);
	//===========================================================================

	/*===========================================================================
		JOIN emails with List of Email Domains With Filled in Best Registrant Info
	*/
	Layout_email_with_registrant_info := POEsFromEmails.layouts.EmailsWithRegistrantInfo;
	
	Layout_email_with_registrant_info combineEmailAndDomainRegistrantInfo(pEmails l, ListOfEmailDomainsWithBestRegistrantInfoDS r ):= TRANSFORM
		 self.bdid 									:= r.bdid;
		 self.registrant_name 			:= r.registrant_name;
		 self.registrant_address1 	:= r.registrant_address1;
		 self.registrant_address2 	:= r.registrant_address2;
		 self.registrant_address3 	:= r.registrant_address3;
		 self.registrant_address4 	:= r.registrant_address4;
		 self.registrant_address5 	:= r.registrant_address5;
		 self.registrant_address6 	:= r.registrant_address6;
		 self.registrant_address7 	:= r.registrant_address7;
		 self.registrant_address8 	:= r.registrant_address8;
		 self.registrant_address9 	:= r.registrant_address9;
		 self.registrant_address10 	:= r.registrant_address10;
		 self.domain_date_last_seen	:= r.domain_date_last_seen;
		 self 											:= l;
	END;

	EmailsWithRegistrationInfoDS := 
			join( 
						 pEmails					
						, ListOfEmailDomainsWithBestRegistrantInfoDS
						, (left.append_domain=right.append_domain)
						, combineEmailAndDomainRegistrantInfo( LEFT, RIGHT )
						, LOOKUP
						
			):persist(persistnames().AddDomainBDID2Emails);
	//output(count(EmailsWithRegistrationInfoDS),named('Number_of_EmailsWithRegistrationInfoDS'));
	//output(count(EmailsWithRegistrationInfoDS(bdid<>0)),named('Number_of_nonzero_bdid_EmailsWithRegistrationInfoDS'));
	//output(EmailsWithRegistrationInfoDS,named('EmailsWithRegistrationInfoDS'));
	//output(EmailsWithRegistrationInfoDS(bdid<>0), ,'~thor200_144::thumphrey::ALLHerzbergEmailsWithRegistrationInfoDS',OVERWRITE);
	//===========================================================================
	return EmailsWithRegistrationInfoDS(bdid<>0);
end;