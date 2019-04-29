import SALT311,BIPV2_LGID3, BIPV2,BIPV2_Best, Business_Header, TopBusiness_BIPV2,BIPV2_ProxID;

export Layouts := module

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