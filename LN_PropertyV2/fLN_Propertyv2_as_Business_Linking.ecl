IMPORT Business_Header_SS, Business_Header,Business_HeaderV2, ut, Lib_StringLib, mdr, Address;

EXPORT fLN_Propertyv2_as_Business_Linking(

	 DATASET(Layout_DID_Out													                    ) pLNPropertySearch  		= File_Search_DID			
	,dataset(Layouts.layout_deed_mortgage_common_model_base_scrubs	    ) pLNPropertyDeed		    = Files.Base.DeedMortgage
	,dataset(Layouts.layout_property_common_model_base_scrubs			      ) pLNPropertyTax			  = Files.Base.Assessment		
	,DATASET(layout_addl_fares_deed									                    ) pLNPropertyAddlDeed   = File_addl_fares_deed	
	,DATASET(layout_addl_fares_tax									                    ) pLNPropertyAddlTax	  = File_addl_Fares_tax	
	,Boolean IsPRCT = false
) := FUNCTION
	
  dProperty	:= 	LN_Propertyv2_as_Business_Link_Prep(
											 pLNPropertySearch  
											,pLNPropertyDeed		
											,pLNPropertyTax			
											,pLNPropertyAddlDeed
											,pLNPropertyAddlTax
											,
											,IsPRCT);	
	
	dPropertyPrepNoPartialOwnership := 	dProperty(lib_stringlib.StringLib.StringFilterOut(partial_interest_transferred,' 0') = '');
  dPropertyNames :=  dPropertyPrepNoPartialOwnership((TRIM(fname) + TRIM(lname)) <> '');
	
		
 	Business_Header.Layout_Business_Linking.Contact tAsPrepToBusLinkContact(layout_business_link_prep pInput) :=	TRANSFORM
    SELF.tmp_join_id_contact         := pInput.vl_id;		
		SELF.contact_address_type        := 'C';
		SELF.contact_name.title          := pInput.title;
		SELF.contact_name.fname          := pInput.fname;
		SELF.contact_name.mname          := pInput.mname;
		SELF.contact_name.lname          := pInput.lname;
		SELF.contact_name.name_suffix    := pInput.name_suffix;
		SELF.contact_name.name_score     := '';
		SELF.contact_job_title_raw       := 'OWNER';
		SELF                             := pInput;
		SELF                             := [];
	END;

  //CONTACTS					                                      
	
	dPropertyContact :=	PROJECT(dPropertyNames, tAsPrepToBusLinkContact(LEFT));
  dPropertyContact_filt := dPropertyContact((integer)business_header.CleanName(contact_name.fname,contact_name.mname,contact_name.lname,contact_name.name_suffix)[142] < 3,
	                                           Business_Header.CheckPersonName(contact_name.fname, contact_name.mname, contact_name.lname, contact_name.name_suffix));
	
	dContactDist     :=	DISTRIBUTE(dPropertyContact_filt,hash(tmp_join_id_contact));
	dContactsSort		 :=	SORT(dContactDist, tmp_join_id_contact, contact_name.lname, contact_name.fname, contact_name.mname, contact_name.name_suffix,LOCAL);
	dContactsDedup	 :=	DEDUP(dContactsSort, tmp_join_id_contact, contact_name.lname, contact_name.fname, contact_name.mname, contact_name.name_suffix,LOCAL);
  
  
	Business_Header.Layout_Business_Linking.Company_  tAsPrepToBusLinkCompany(layout_business_link_prep pInput) :=	TRANSFORM,
	                                                  SKIP(pInput.company_address.prim_range = '' AND pInput.company_address.p_city_name = '' AND 
																										     pInput.company_address.st  = '' AND pInput.company_address.zip = '')
    SELF.tmp_join_id_company         := pInput.vl_id;		
		SELF.source 				          	 :=	pInput.source;
		SELF.dt_first_seen		           :=	pInput.dt_first_seen;
		SELF.dt_last_seen			           :=	pInput.dt_last_seen;
		SELF.dt_vendor_first_reported		 :=	pInput.dt_vendor_first_reported;
		SELF.dt_vendor_last_reported		 :=	pInput.dt_vendor_last_reported;
		SELF.company_name		        		 :=	Stringlib.StringToUpperCase(pInput.company_name);
		SELF.company_address.prim_range	 :=	pInput.company_address.prim_range;
		SELF.company_address.predir			 :=	pInput.company_address.predir;
		SELF.company_address.prim_name	 :=	pInput.company_address.prim_name;
		SELF.company_address.addr_suffix :=	pInput.company_address.addr_suffix;
		SELF.company_address.postdir		 :=	pInput.company_address.postdir;
		SELF.company_address.unit_desig	 :=	pInput.company_address.unit_desig;
		SELF.company_address.sec_range	 :=	pInput.company_address.sec_range;
		SELF.company_address.p_city_name :=	pInput.company_address.p_city_name;
		SELF.company_address.v_city_name :=	pInput.company_address.v_city_name;
		SELF.company_address.st		       :=	pInput.company_address.st;
		SELF.company_address.zip				 :=	pInput.company_address.zip;
		SELF.company_address.zip4				 :=	pInput.company_address.zip4;
		SELF.company_address.cart        :=	pInput.company_address.cart; 
		SELF.company_address.cr_sort_sz  :=	pInput.company_address.cr_sort_sz;
		SELF.company_address.lot         :=	pInput.company_address.lot;
		SELF.company_address.lot_order   :=	pInput.company_address.lot_order;
		SELF.company_address.dbpc        :=	pInput.company_address.dbpc;
		SELF.company_address.chk_digit   :=	pInput.company_address.chk_digit;
		SELF.company_address.rec_type    :=	pInput.company_address.rec_type;
		SELF.company_address.fips_state  :=	pInput.company_address.fips_state;
		SELF.company_address.fips_county :=	pInput.company_address.fips_county;
		SELF.company_address.geo_lat		 :=	pInput.company_address.geo_lat;
		SELF.company_address.geo_long		 :=	pInput.company_address.geo_long;
		SELF.company_address.msa			   :=	pInput.company_address.msa;
		SELF.company_address.geo_blk     :=	pInput.company_address.geo_blk;
		SELF.company_address.geo_match   :=	pInput.company_address.geo_match;
		SELF.company_address.err_stat    :=	pInput.company_address.err_stat;
		SELF.company_phone					     :=	Business_Header.CleanPhone(pInput.company_phone);
		SELF.phone_type                  := IF((INTEGER)SELF.company_phone = 0, '', 'T');
		SELF.vl_id                       := pInput.vl_id;
		SELF.source_record_id            := pInput.source_record_id;
		SELF.company_bdid                := pInput.company_bdid;
		SELF                             := pInput;
		SELF                             := [];
	END;

  //COMPANY
	dPropertyPrepCompanyOnly		    	:=	dProperty(company_name <> '');
	dPropertyPrepCompany	            :=	PROJECT(dPropertyPrepCompanyOnly,  tAsPrepToBusLinkCompany(LEFT));
	
		 

  ////////////////////////////////////////////////////////////////////////
	// CLEAN COMPANY
	////////////////////////////////////////////////////////////////////////
	Property_clean := LN_PropertyV2.As_Business_Linking_Function(dPropertyPrepCompany);
	
  Property_clean_dist   := DISTRIBUTE(Property_clean, HASH(tmp_join_id_company));
	Property_clean_dedup  := DEDUP(SORT(Property_clean_dist, record, LOCAL), record, LOCAL);
															 
 	Business_Header.Layout_Business_Linking.Combined Comb_Prop(Business_Header.Layout_Business_Linking.Company_ L, Business_Header.Layout_Business_Linking.Contact R) := TRANSFORM
	  SELF.company_address_type_raw := R.contact_address_type;  	
  	SELF                          := L;
		SELF                          := R;
	END;
	
	jCombined1 := JOIN(Property_clean_dedup,dContactsDedup,
	           LEFT.tmp_join_id_company=RIGHT.tmp_join_id_contact,
						 Comb_Prop(LEFT,RIGHT),
						 LEFT OUTER,LOCAL);
	  	
	JComb_proj := PROJECT(jCombined1(trim(company_name)<>''),Business_Header.Layout_Business_Linking.Linking_Interface);
	JComb_dist := DISTRIBUTE(JComb_proj, HASH(vl_id, company_name));
	dAll_Dedup := DEDUP(SORT(JComb_dist, record, LOCAL), record, LOCAL);
			
	RETURN dAll_Dedup ;
	
END;