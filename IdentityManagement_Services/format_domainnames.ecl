/***
 ** Function takes doxie_crs Layout_Whois dataset and project/transform to iesdl layout t_InetDomainRecorddesired
***/

IMPORT Doxie_crs, iesp;


out_rec := iesp.identitymanagementreport.t_IdmInetDomainRecord;

EXPORT out_rec format_domainnames (DATASET(Doxie_crs.Layout_Whois) domain_raw) := FUNCTION


	integer2 getmonth(STRING3 mon) := FUNCTION
		integer2 month := MAP(mon ='Jan' =>1, mon ='Feb' =>2, mon ='Mar' =>3,
													mon ='Apr' =>4, mon ='May' =>5, mon ='Jun' =>6,
													mon ='Jul' =>7, mon ='Aug' =>8, mon ='Sep' =>9,
													mon ='Oct' =>10, mon ='Nov' =>11, mon ='Dec' =>12,0);
		RETURN month;
	END;

  // Function to convert date from format 'DD-MON-YYYY'(31-Oct-2013) to t_date
	iesp.share.t_Date Convertto_Datemon(STRING11 date) := FUNCTION 
		RETURN	row ({date[8..11], getmonth(date[4..6]), date[1..2]}, iesp.share.t_Date);
	END;
 
 
 
  // Trasnform to registrants
  iesp.internetdomain.t_InetDomainPerson toreg (Doxie_crs.Layout_Whois L):= TRANSFORM
		SELF.Name := L.registrant_name;
		domain_addr := DATASET([{L.registrant_address1},{L.registrant_address2},{L.registrant_address3},
																			{L.registrant_address4},{L.registrant_address5},{L.registrant_address6},
																			{L.registrant_address7},{L.registrant_address8}],iesp.share.t_StringArrayItem);
																			
		SELF.InetDomainAddress  := CHOOSEN (domain_addr(value <> ''),iesp.constants.INTERNETDOMAIN_MAX_COUNT_ADDRESSES);
		SELF := [];
	END;

  
	// Transform to the required iesdl layout
	out_rec toout(Doxie_crs.Layout_Whois L) := TRANSFORM
		SELF.DomainName  						:= L.domain_name;
		SELF.DateLastSeen   				:= iesp.ECL2ESP.toDatestring8(L.date_last_seen);
		SELF.DateLastUpdated  			:= Convertto_Datemon(L.update_date);
		SELF.DateExpires   					:= Convertto_Datemon(L.expire_date);
		SELF.Registrant   					:= PROJECT(L,toreg(LEFT)); 
	END;
	
	domain_rec := PROJECT(domain_raw,toout(LEFT));
/*******
	// DEBUG
	OUTPUT(domain_rec,NAMED('domain_rec'));
*******/
	RETURN domain_rec;

END;