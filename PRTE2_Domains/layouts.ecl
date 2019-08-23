IMPORT Domains;

EXPORT Layouts := MODULE

  EXPORT layout_domains_base := Domains.layout_whois_base;
  
  SHARED layout_prte_extra := RECORD
    STRING10 cust_name;
    STRING10 bug_num;
    STRING8 link_dob;
    STRING9 link_ssn;
    STRING9 link_fein;
    STRING8 link_inc_date;
  END;

  EXPORT layout_key_id := RECORD
    UNSIGNED6 internetservices_id;
    layout_domains_base;
    STRING30 admin_fname;
    STRING30 admin_mname;
    STRING50 admin_lname;
    STRING30 tech_fname;
    STRING30 tech_mname;
    STRING50 tech_lname;
    STRING30 registrant_fname;
    STRING30 registrant_mname;
    STRING50 registrant_lname;
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
  END;
  
  EXPORT layout_in := RECORD
    layout_key_id - [global_sid, record_sid];
    layout_prte_extra;
  END;

  EXPORT layout_base := RECORD
    // layout_in;
		layout_key_id;
	  UNSIGNED6 powid;
    UNSIGNED6 proxid;
    UNSIGNED6 seleid;
    UNSIGNED6 orgid;
    UNSIGNED6 ultid;
    UNSIGNED8 source_rec_id :=  0;
		layout_prte_extra;		
	END;

  EXPORT layout_key_bdid := RECORD
    UNSIGNED6 bdid; 
    UNSIGNED6 internetservices_id;
  END;
  
  EXPORT layout_key_did := RECORD
    UNSIGNED6 did; 
    UNSIGNED6 internetservices_id;
  END;
  
  EXPORT layout_key_domain  :=  RECORD
    STRING45 domain_name; 
    UNSIGNED6 internetservices_id;
  END;
  
  EXPORT layout_key_whois_domain  :=  RECORD
    STRING45 dn; 
    layout_domains_base;
  END;
  
  EXPORT layout_key_whois_did  :=  RECORD
    UNSIGNED6 d; 
    layout_domains_base;
  END;
  
  EXPORT layout_key_linkids :=  RECORD
    UNSIGNED6 ultid;
    UNSIGNED6 orgid;
    UNSIGNED6 seleid;
    UNSIGNED6 proxid;
    UNSIGNED6 powid;
    UNSIGNED6 empid;
    UNSIGNED6 dotid;
    UNSIGNED2 ultscore;
    UNSIGNED2 orgscore;
    UNSIGNED2 selescore;
    UNSIGNED2 proxscore;
    UNSIGNED2 powscore;
    UNSIGNED2 empscore;
    UNSIGNED2 dotscore;
    UNSIGNED2 ultweight;
    UNSIGNED2 orgweight;
    UNSIGNED2 seleweight;
    UNSIGNED2 proxweight;
    UNSIGNED2 powweight;
    UNSIGNED2 empweight;
    UNSIGNED2 dotweight;
    layout_domains_base;
    UNSIGNED8 source_rec_id;
  END;
  
  EXPORT layout_key_autokey :=  RECORD
    layout_domains_base;
    UNSIGNED6 internetservices_id := 0;
    UNSIGNED1 zero:=0;
    STRING1   blank:= '';
    STRING46  compname := '';  
  END;
 
 Export Layout_Searchfile := RECORD (domains.layout_whois_base_bip)
	  unsigned6 internetservices_id;
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
	END;
	
	Export Layout_Whois_Base_BIP:=Record
	Domains.Layout_Whois_Base_BIP;
	End;
  
END;
