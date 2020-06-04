import Business_Header, AID;
EXPORT Layout_Business_Linking_Full := record
		Business_Header.Layout_Business_Linking.Linking_Interface; 
		unsigned8	company_Aceaid	:= 0;
		string50	company_name_type_derived := '';
		string50	company_address_type_derived := '';
		string60	company_org_structure_derived := '';
		string50	company_name_status_derived := '';
		string50	company_status_derived := '';
    
		string1	proxid_status_private := '';
		string1	powid_status_private  := '';
		string1	seleid_status_private := '';
		string1	orgid_status_private  := '';
		string1	ultid_status_private  := '';
    
		string1	proxid_status_public := '';
		string1	powid_status_public  := '';
		string1	seleid_status_public := '';
		string1	orgid_status_public  := '';
		string1	ultid_status_public  := '';
		string50	contact_type_derived := '';
		string50	contact_job_title_derived := '';
		string30	contact_status_derived := '';		
    string1   address_type_derived := ''; //residential('R') or business address('B')
    boolean   is_vanity_name_derived := false; //
end;
