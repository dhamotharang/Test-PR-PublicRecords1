import domains, iesp;

export layouts := module

	export inetdomain_slim := record
     unsigned6 did                        := 0;
		 unsigned6 bdid                       := 0;
		 unsigned6 internetservices_id        := 0;
		 string45 domainname                  := '';
		 boolean isDeepDive := false;
	end;
	
	export rawrec := record(domains.layout_whois_base)
		 boolean isDeepDive := false;
		 unsigned2 penalt := 0;
		 unsigned6 internetservices_id := 0;
		string30 admin_fname;
		string30 admin_mname;
		string50 admin_lname;
		string30 tech_fname;
		string30 tech_mname;
		string50 tech_lname;
		string30 registrant_fname;
		string30 registrant_mname;
		string50 registrant_lname;
		STRING10 registrant_prim_range;
		STRING2  registrant_predir;
		STRING28 registrant_prim_name;
		STRING4  registrant_suffix;
		STRING2  registrant_postdir;
		STRING10 registrant_unit_desig;
		STRING8  registrant_sec_range;
		STRING25 registrant_p_city_name;
		STRING25 registrant_v_city_name;
		STRING2  registrant_state;
		STRING5  registrant_zip;
		 
	end;
	
	export InetDomainRecordWithPenalty := record
	   recordof(iesp.internetdomain.t_InetDomainRecord);
		 unsigned2 _penalty :=0;
		 boolean isDeepDive := false;
  end;		 
	
end;