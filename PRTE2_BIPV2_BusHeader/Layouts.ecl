import Address, BIPV2, BIPV2_Best, Business_Header, TopBusiness_BIPV2, BIPV2_ProxID, SALT30;

export Layouts := module

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