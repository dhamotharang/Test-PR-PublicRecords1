import BIPV2;

EXPORT Layouts :=
module

	export	core_business_info_proxid := RECORD
   string100 									business_name;
   string70 									business_address;
   string25 									city;
   string2 										state;
   string5 										zip5;
   string5 										county;
   string31 									county_name;
   string4 										msa;
   string4 										err_stat;
   string3 										age_of_company;
   unsigned4 									dt_first_seen;
   unsigned4 									dt_last_seen;
   string10 									business_phone;
	end;

	export	core_business_info_seleid := RECORD
		core_business_info_proxid;
		string60 									business_email;
		integer8 									annual_revenue;
		string2 									src_revenue;
		integer8 									number_of_employees;
		string4 									sic_primary;
		string4 									sic2;
		string4 									sic3;
		string4 									sic4;
		string4 									sic5;
		string6 									naics_primary;
		string6 									naics2;
		string6 									naics3;
		string6 									naics4;
		string6 									naics5;
  end;

  export business_information := record
    unsigned6                 seleid          ;
    unsigned6                 proxid          ;
    unsigned6                 ultid           ;
    unsigned6                 orgid           ;
    core_business_info_seleid seleid_level    ;
    core_business_info_proxid proxid_level    ;        
  end;

  export business_contact := record
		unsigned6                 seleid;
		unsigned6                 proxid;
		unsigned6                 lexid;
		unsigned6                 empid;
		string                 		fname;
		string                 		lname;
		unsigned4                 dt_first_seen;
		unsigned4                 dt_last_seen;
		string70                	contact_address;
		string25                 	city;
		string2                 	state;
		string5                 	zip5;
		string5                 	county;
		string31                 	county_name;
		string60                 	contact_email_address;
		string                 		title;
		unsigned4                 title_dt_first_seen;
		unsigned4                 title_dt_last_seen;
		string                 		title2;
		unsigned4                 title2_dt_first_seen;
		unsigned4                 title2_dt_last_seen;
		string               		  title3;
		unsigned4                 title3_dt_first_seen;
		unsigned4                 title3_dt_last_seen;
		string              		   title4;
		unsigned4                 title4_dt_first_seen;
		unsigned4                 title4_dt_last_seen;
		string              		  title5;
		unsigned4                 title5_dt_first_seen;
		unsigned4                 title5_dt_last_seen;
		unsigned8                 person_hierarchy;
	end;

  export business_information_prep := 
  record
    unsigned6             seleid              ;
    unsigned6             proxid              ;
    unsigned6             ultid               ;
    unsigned6             orgid               ;
    // string2               source              ;
    string100             business_name       ;
    string10              prim_range          ;
    string2               predir              ;
    string28              prim_name           ;
    string4               addr_suffix         ;
    string2               postdir             ;
    string10              unit_desig          ;
    string8               sec_range           ;
    string25              p_city_name         ;
    string25              v_city_name         ;
    string2               st                  ;
    string5               zip                 ;
    string4               msa                 ;
    string4               err_stat            ;
    string2               fips_state          ;
    string3               fips_county         ;
    string3               age_of_company      ;
    unsigned4             dt_first_seen       ;
    unsigned4             dt_last_seen        ;
    string10              business_phone      ;
    string60              business_email      ;
    unsigned              annual_revenue      ;
    string2               src_revenue         ;
    unsigned              number_of_employees ;
    string4               SIC_Primary         ;
    string4               SIC2                ;
    string4               SIC3                ;
    string4               SIC4                ;
    string4               SIC5                ;
    string6               NAICS_Primary       ;
    string6               NAICS2              ;
    string6               NAICS3              ;
    string6               NAICS4              ;
    string6               NAICS5              ;
  end;

  export source_rank := 
  record
    unsigned2 rank_order  ;
    string2   source      ;
  end;
  
end;