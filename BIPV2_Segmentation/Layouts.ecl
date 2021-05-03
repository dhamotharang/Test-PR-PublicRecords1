export Layouts := module
     shared DATE_TYPE  := unsigned4;
     shared COUNT_TYPE := unsigned5;
     shared ID_TYPE    := unsigned6;
	
     export ContactTypeLayout := record
          string50   contact_type_derived;
          COUNT_TYPE cnt;
          DATE_TYPE  dt_first_seen_contact;
          DATE_TYPE  dt_last_seen_contact;
     end;
	
     export JobTitleLayout := record
          string50   contact_job_title_derived;
          COUNT_TYPE cnt;
          DATE_TYPE  dt_first_seen_contact;
          DATE_TYPE  dt_last_seen_contact;
     end;		
	
     export ContactStatusLayout := record
          string30   contact_status_derived;
          COUNT_TYPE cnt;
          DATE_TYPE  dt_first_seen_contact;
          DATE_TYPE  dt_last_seen_contact;
     end;		

     export ExecutiveLayout := record
          boolean    executive_ind;
          integer    executive_ind_order;
          COUNT_TYPE cnt;
     end;		
											 
     export ContactProxLayout := record
          ID_TYPE                      proxid;
          ID_TYPE                      contact_did;
          string10                     seg_ind;
          DATE_TYPE                    dt_first_seen_contact;
          DATE_TYPE                    dt_last_seen_contact;
          dataset(ContactTypeLayout)   contact_type;
          dataset(JobTitleLayout)      job_title;
          dataset(ContactStatusLayout) contact_status;
          dataset(ExecutiveLayout)     executive;
     end;	

     export ContactSeleLayout := record
          ID_TYPE seleid,                                                                                                         
          ContactProxLayout;
     end;

     export ResultLayout := record
          ID_TYPE                    seleid;
          dataset(ContactProxLayout) contacts;
     end;
												
     // export OrgStructureLayout := record
          // string60 company_org_structure_derived;
          // COUNT_TYPE cnt;
     // end;
	
     export SegmentationLayout := record
          ID_TYPE                     seleid;
          ID_TYPE                     ultid;
          ID_TYPE                     parent_seleid;
          DATE_TYPE                   dt_first_seen;
          DATE_TYPE                   dt_last_seen;
          COUNT_TYPE                  record_cnt;
          COUNT_TYPE                  proxid_cnt;
          COUNT_TYPE                  addr_state_cnt;
          string1                     category;
          string1                     subCategory;
          string120                   company_name;
          string10                    company_prim_range;
          string2                     company_predir;
          string28                    company_prim_name;
          string4                     company_addr_suffix;
          string2                     company_postdir;
          string10                    company_unit_desig;
          string8                     company_sec_range;
          string25                    company_p_city_name;
          string25                    address_v_city_name;
          string2                     company_st;
          string5                     company_zip5;
          string4                     company_zip4;
          string2                     state_fips;
          string3                     county_fips;
          string18                    county_name;
          string10                    company_phone;
          string9                     company_fein;
          string9                     duns_number;
          DATE_TYPE                   company_incorporation_date;
          string8                     company_sic_code1;
          string6                     company_naics_code1;
          boolean                     has_SOS;
		string1                     best_address_type;
		string1                     all_address_type;
		string3                     sourceGroups;
		unsigned6                   best_contact_did;
		string50                    best_contact_job_title; 
          string10                    best_contact_seg_ind;  
		string20                    org_structure;
		string20                    org_sub_structure;
     end;

     export SlimLayout := record
          ID_TYPE   seleid;
          ID_TYPE   proxid;
          ID_TYPE   ultid;
          string2   source;
          DATE_TYPE dt_first_seen;
          DATE_TYPE dt_last_seen;
          string2   st;
          string1   seleid_status_public;
          string60  company_org_structure_derived;
	end;
	
     export TallyLayout := record
          ID_TYPE seleid,
          ID_TYPE ultid,
          DATE_TYPE dt_first_seen,
          DATE_TYPE dt_last_seen,
          string1 seleid_status_public;
          COUNT_TYPE proxid_cnt;
          COUNT_TYPE record_cnt;
          COUNT_TYPE addr_state_cnt;
          boolean has_SOS;
	end;

	export SegKeyLayout := record
		SegmentationLayout.seleid;
		SegmentationLayout.category;
		SegmentationLayout.subcategory;
	end;
end;