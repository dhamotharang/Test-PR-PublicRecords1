

EXPORT layout_Business_Batch_out := 
	RECORD

		STRING30  acctno                  := '';
    UNSIGNED2 penalt                  :=  0;

		// Core

		STRING2   Level;
		STRING9   Root;
		STRING4   Sub;
		STRING15  Parent_Number;
	 
		UNSIGNED6 bdid	                  :=  0;
		STRING8   process_date            := '';
		STRING150 company_name            := '';
		STRING300 street                  := '';
		STRING30  city                    := '';
		STRING2   state                   := '';
		STRING15  zip                     := '';
		STRING20  phone                   := '';
		
		STRING6   sic_cd                  := '';
		STRING97  sic_desc                := '';
		STRING12  sales                   := '';
		STRING12  earnings                := '';
		STRING9   num_employees           := '';
		STRING82  email                   := '';
		STRING85  url                     := '';
		
		// Parent
		
		STRING30  parent_company_name     := '';
		STRING300 parent_street           := '';
		STRING30  parent_city             := '';
		STRING2   parent_state            := '';
		STRING15  parent_zip              := '';
		STRING20  parent_phone            := '';
		
		// Subsidiaries
		
		STRING30  parent_subsid_1_company_name    := '';
		STRING300 parent_subsid_1_street          := '';
		STRING30  parent_subsid_1_city            := '';
		STRING2   parent_subsid_1_state           := '';
		STRING15  parent_subsid_1_zip             := '';
		STRING20  parent_subsid_1_phone           := '';
		
		STRING30  parent_subsid_2_company_name    := '';
		STRING300 parent_subsid_2_street          := '';
		STRING30  parent_subsid_2_city            := '';
		STRING2   parent_subsid_2_state           := '';
		STRING15  parent_subsid_2_zip             := '';
		STRING20  parent_subsid_2_phone           := '';		
	                               
		// Contacts (10) "contacts are ordered by title-hierarchy"
		
		STRING60 executive_1_name         := '';
		STRING50 executive_1_title        := '';
		
		STRING60 executive_2_name         := '';
		STRING50 executive_2_title        := '';

		STRING60 executive_3_name         := '';
		STRING50 executive_3_title        := '';

		STRING60 executive_4_name         := '';
		STRING50 executive_4_title        := '';

		STRING60 executive_5_name         := '';
		STRING50 executive_5_title        := '';

		STRING60 executive_6_name         := '';
		STRING50 executive_6_title        := '';

		STRING60 executive_7_name         := '';
		STRING50 executive_7_title        := '';

		STRING60 executive_8_name         := '';
		STRING50 executive_8_title        := '';

		STRING60 executive_9_name         := '';
		STRING50 executive_9_title        := '';

		STRING60 executive_10_name        := '';
		STRING50 executive_10_title       := '';

		// Secondary SICs (4)
		
		STRING6  secondary_sic_1_cd       := '';
		STRING50 secondary_sic_1_desc     := '';
		STRING6  secondary_sic_2_cd       := '';
		STRING50 secondary_sic_2_desc     := '';	
		STRING6  secondary_sic_3_cd       := '';
		STRING50 secondary_sic_3_desc     := '';	
		STRING6  secondary_sic_4_cd       := '';
		STRING50 secondary_sic_4_desc     := '';					

	END;
		