import SALT311,BIPV2_LGID3, BIPV2,BIPV2_Best, Business_Header, TopBusiness_BIPV2,BIPV2_ProxID;

export Layouts := module

Export Candidate:=RECORD
  unsigned6 lgid3;
  unsigned6 rcid;
  string34 sbfe_id;
  string10 nodes_below_st;
  string20 lgid3ifhrchy;
  unsigned6 originalseleid;
  unsigned6 originalorgid;
  string30 cnp_number;
  string9 active_duns_number;
  string9 duns_number;
  unsigned4 duns_number_concept;
  string9 company_fein;
  string2 company_inc_state;
  string32 company_charter_number;
  string10 cnp_btype;
  string50 company_name_type_derived;
  string9 hist_duns_number;
  string30 active_domestic_corp_key;
  string30 hist_domestic_corp_key;
  string30 foreign_corp_key;
  string30 unk_corp_key;
  string250 cnp_name;
  string1 cnp_hasnumber;
  string20 cnp_lowv;
  boolean cnp_translated;
  integer4 cnp_classid;
  string10 prim_range;
  string28 prim_name;
  string8 sec_range;
  string25 v_city_name;
  string2 st;
  string5 zip;
  boolean has_lgid;
  boolean is_sele_level;
  boolean is_org_level;
  boolean is_ult_level;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  unsigned2 levels_from_top;
  unsigned3 nodes_total;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string2 salt_partition;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned1 lgid3ifhrchy_prop;
  unsigned1 company_name_prop;
  unsigned1 cnp_number_prop;
  unsigned1 active_duns_number_prop;
  unsigned1 duns_number_prop;
  unsigned1 duns_number_concept_prop;
  unsigned1 company_inc_state_prop;
  unsigned1 company_charter_number_prop;
  unsigned2 buddies;
  integer2 sbfe_id_weight100;
  boolean sbfe_id_isnull;
  integer2 lgid3ifhrchy_weight100;
  boolean lgid3ifhrchy_isnull;
  string500 company_name;
  integer2 company_name_weight100;
  boolean company_name_isnull;
  integer2 cnp_number_weight100;
  boolean cnp_number_isnull;
  integer2 active_duns_number_weight100;
  boolean active_duns_number_isnull;
  integer2 duns_number_weight100;
  boolean duns_number_isnull;
  integer2 duns_number_concept_weight100;
  boolean duns_number_concept_isnull;
  integer2 company_fein_weight100;
  boolean company_fein_isnull;
  integer2 company_inc_state_weight100;
  boolean company_inc_state_isnull;
  integer2 company_charter_number_weight100;
  boolean company_charter_number_isnull;
  integer2 cnp_btype_weight100;
  boolean cnp_btype_isnull;
  unsigned8 __internal_fpos__;
 END;


Export Layout_Matches:=RECORD,maxlength(32000)  
  unsigned6 lgid31;
  unsigned6 lgid32;
  unsigned2 rule;
  integer2 conf;
  integer2 dateoverlap;
  integer2 conf_prop;
  unsigned6 rcid1;
  unsigned6 rcid2;
  string source_id;
END;


	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary := module
	
		export Layout_Link_Fields := record
			string link_fein := '';
			string link_inc_date := '';
			string cust_name := '';
		end;
	
		export Layout_BusLinking :=
	  record
				Layout_Link_Fields;
				business_header.Layout_Business_Linking.Linking_Interface;
		end;
		
		export Layout_BHL_Company :=
	  record
				Layout_Link_Fields;
				business_header.Layout_Business_Linking.Company_;
		end;
		
		export Layout_BHL_Contact :=
	  record
				Layout_Link_Fields;
				business_header.Layout_Business_Linking.Contact;
		end;
		
		export Layout_BHL_Combined :=
	  record
				Layout_Link_Fields;
				business_header.Layout_Business_Linking.Combined;
		end;
		
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Out Layouts
	////////////////////////////////////////////////////////////////////////
	export Base := module
	
		export Layout_CommonBase :=
	  record
				BIPV2.CommonBase_mod.Layout_Static;
	  end;
		
		export Layout_License := 
		record
			TopBusiness_BIPV2.layouts.rec_license_combined_layout;
		end;
		
		export Layout_Industry := 
		record
			TopBusiness_BIPV2.layouts.rec_industry_combined_layout;
		end;
		
		export Layout_Contacts := 
		record
			BIPV2.IDlayouts.l_xlink_ids; 
			BIPV2.Layout_Business_Linking_Full;
			boolean executive_ind := false;
			integer executive_ind_order:=0;
			unsigned4 global_sid:=0;
      unsigned8 record_sid:=0;

		end;

		export Layout_Best := 
		record
			BIPV2_Best.Layouts.Base;
		end;
		
		export Layout_sele_relative :=
		record
			unsigned6 seleid1                     ;
			unsigned6 seleid2                     ;
			integer2  duns_number_score           ;
			integer2  duns_number_cnt             ;
			integer2  enterprise_number_score     ;
			integer2  enterprise_number_cnt       ;
			integer2  source_score                ;
			integer2  source_cnt                  ;
			integer2  contact_score               ;
			integer2  contact_cnt                 ;
			integer2  address_score               ;
			integer2  address_cnt                 ;
			integer2  namest_score                ;
			integer2  namest_cnt                  ;
			integer2  charter_score               ;
			integer2  charter_cnt                 ;
			integer2  fein_score                  ;
			integer2  fein_cnt                    ;
			integer2  mname_score                 ;
			integer2  contact_ssn_score           ;
			integer2  contact_phone_score         ;
			integer2  contact_email_username_score;
			unsigned4 dt_first_seen_track         ;
			unsigned4 dt_last_seen_track          ;
			unsigned4 dt_first_seen_contact_track ;
			unsigned4 dt_last_seen_contact_track  ;
			unsigned2 total_cnt                   ;
			integer2  total_score                 ;
		 end;
		
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Key Layouts
	////////////////////////////////////////////////////////////////////////
	export lKey := module
	/*
		export Layout_Proxid_Matches := RECORD//in this module for because of ,foward bug
			UNSIGNED2 Rule;
			INTEGER2 Conf := 0;
			INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
			INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
			SALT30.UIDType Proxid1;
			SALT30.UIDType Proxid2;
			SALT30.UIDType rcid1 := 0;
			SALT30.UIDType rcid2 := 0;
		end;
		
		export Layout_Proxid_Attr_Matches := RECORD(Layout_Proxid_Matches),MAXLENGTH(32000)
			SALT30.StrType source_id;
			UNSIGNED2 support_cnp_name := 0; // External support for cnp_name
		end;
		*/
		export Layout_Proxid_Attr_matches := record
			BIPV2_ProxID.match_candidates(DATASET([],BIPV2_ProxID.layout_DOT_Base)).Layout_Attribute_Matches;
		end;
		
		export Layout_Proxid_Candidates := record
			BIPV2_ProxID.match_candidates(DATASET([],BIPV2_ProxID.layout_DOT_Base)).Layout_Candidates;
		end;
		
		export Layout_Proxid_Specificities := record
			BIPV2_ProxID.Layout_Specificities.r;
		end;
		
		
	end;
	
end;