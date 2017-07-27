IMPORT iesp, Address, ut, SexOffender_Services, SexOffender, CriminalRecords_BatchService, Doxie, 
			 LN_PropertyV2_Services, marriage_divorce_v2_Services;

EXPORT Transforms := MODULE

  EXPORT NameFromComponents(STRING fname, STRING mname, STRING lname, STRING name_suffix, STRING cname) := function
		Unparsed_name := stringlib.StringCleanSpaces(fname +' '+ mname +' '+ lname+' '+ name_suffix);
	  RETURN IF(Unparsed_name != '', Unparsed_name, cname);
  END;	
	
	EXPORT doxie.layout_best PutInDoxieInput(Layouts.Batch_In_plus l) := TRANSFORM
			self.fname := l.Input_Name_First;
			self.mname := l.Input_Name_Middle;
			self.lname := l.Input_Name_Last;
			self.city_name := l.Input_p_city_name;
			self.zip := l.Input_z5;
			self.ssn := l.Input_ssn;
			self.dob := (integer4) l.Input_dob;
			self := l;		
			SELF := [];//age
		END;

	//skip over records that don't match on lname, ssn and first initial of fname	
		EXPORT BenefitAssessment_Services.Layouts.layout_dec_crim_sofr DecIncSOFOutput(
																					BenefitAssessment_Services.Layouts.layout_dec_crim_sofr L,
																					BenefitAssessment_Services.Layouts.layout_sofr R) := TRANSFORM ,
					SKIP(r.SOFR_Flag = '1' and ~(L.Input_ssn = R.ssn AND 
						L.Input_Name_Last = R.SOFR_lname AND
						L.Input_Name_First[1] = R.SOFR_fname[1] AND 
						R.date_last_seen != '' AND
						ut.NNEQ_Int(L.Input_dob[1..4], R.dob [1..4]))) 
			SELF := R;
			SELF := L;
		END;
		
		export BenefitAssessment_Services.Layouts.layout_dec_crim_sofr makeDecHit(
																									BenefitAssessment_Services.Layouts.Batch_In_plus l, 
																									BenefitAssessment_Services.Layouts.Layout_SSN r) := TRANSFORM
				SELF.DeceasedMatchCode := IF((l.Input_Name_First = r.decs_first AND 
																		l.Input_Name_Last = r.decs_last), 'SN', 
																		IF(r.dt_first_deceased != 0, 'S', ''));
				SELF.DeceasedFirstName := r.decs_first;
				SELF.DeceasedLastName := r.decs_last;
				SELF.DeceasedDOB := IF(r.decs_dob > 0, (STRING8)r.decs_dob, '');
				SELF.DeceasedDOD := IF(r.dt_first_deceased > 0, (STRING8)r.dt_first_deceased, '');
				SELF := l;
				SELF := [];//crim and sofr fields
		END;

		export CriminalRecords_BatchService.Layouts.batch_pii_in MakeCrimInput(RECORDOF(BenefitAssessment_Services.Layouts.layout_dec_crim_sofr) l) := TRANSFORM
			SELF.DOB := l.input_DOB; 
			SELF.staddr := Address.Addr1FromComponents(l.input_prim_range, l.input_predir, l.input_prim_name,
		                                     l.input_addr_suffix, l.input_postdir, 
																				 '', l.input_sec_range);
			SELF.city := l.input_p_city_name;
			SELF.state := l.input_st;
			SELF.zip := l.input_z5;
			SELF:= l; 
		END;		
		
		export BenefitAssessment_Services.Layouts.layout_dec_crim_sofr SetCrimHitsMatchCode(
																							BenefitAssessment_Services.Layouts.layout_dec_crim_sofr l, 
																							CriminalRecords_BatchService.Layouts.batch_pii_out r) := TRANSFORM 

			name_matches := l.Input_Name_Last = r.incr_lname AND
						l.Input_Name_First = r.incr_fname;
			ssn_matches := l.Input_ssn = r.incr_ssn;
			dob_matches := ut.NNEQ_Int(l.Input_dob[1..4], r.incr_dob [1..4]); 
			
			SELF.Incarcerated_Flag := r.incarceration_flag;			
			SELF.INCR_match_code := if(r.match_type = '', map(name_matches and ssn_matches and dob_matches => 'SN',
						ssn_matches and dob_matches => 'S', ''),
					map(stringlib.StringFind(r.match_type, 'S', 1) = 1  AND 
						stringlib.StringFind(r.match_type, 'N', 1) = 1 => 'SN',
						stringlib.StringFind(r.match_type, 'S', 1) = 1 => 'S',''));
			SELF := r;
			SELF := l;
		END;		
	
		EXPORT BenefitAssessment_Services.Layouts.layout_sofr MakeSofrHits(SexOffender_Services.Layouts.batch_out l, 
							SexOffender_Services.Layouts.rec_offender_plus_acctno r):= TRANSFORM
			SELF.SOFR_Flag := '1';
			SELF.SOFR_fname := l.first_name;         
			SELF.SOFR_mname := l.middle_name;
			SELF.SOFR_lname := l.last_name;
			SELF.SOFR_suffix := l.name_suffix;
			SELF.SOFR_reg_date_1 := r.reg_date_1;
			SELF.SOFR_reg_date_2 := r.reg_date_2;
			SELF.SOFR_reg_date_3 := r.reg_date_3;
			SELF.SOFR_status := r.offender_status;
			SELF.SOFR_category := r.offender_category;
			SELF.SOFR_risk_level_desc := r.risk_level_code;
			SELF.SOFR_reg_type := r.registration_type;	
			SELF.state := l.st;
			SELF.zip := l.zip5;
			SELF := l;
			SELF := r;
		END;	
	
	EXPORT BenefitAssessment_Services.Layouts.prop_flat_rec MakeDeedFlat(BenefitAssessment_Services.Layouts.rec_propOutWithAcctno l) := TRANSFORM
		SELF.acctno := l.acctno;
		SELF.Curr_Record_Type := if(l.ln_fares_id[2] = LN_PropertyV2_Services.consts.FID_TYPE_DEED, LN_PropertyV2_Services.consts.TYPE_DEED, LN_PropertyV2_Services.consts.TYPE_MORTGAGE);	
		first_addr_row := l.parties(party_type = 'P')[1];	
		SELF.ln_fares_id := l.ln_fares_id;
		
		o_first_name_row := l.parties(party_type = 'O').entity[1];
		o_second_name_row := l.parties(party_type = 'O').entity[2];
		b_first_name_row := l.parties(party_type = 'B').entity[1];
		b_second_name_row := l.parties(party_type = 'B').entity[2];	
		owner_name1 := NameFromComponents(o_first_name_row.fname, o_first_name_row.mname, o_first_name_row.lname,
				o_first_name_row.name_suffix, o_first_name_row.cname); 
		owner_name2 := NameFromComponents(o_second_name_row.fname, o_second_name_row.mname, o_second_name_row.lname,
				o_second_name_row.name_suffix, o_second_name_row.cname);
		buyer_name1 := NameFromComponents(b_first_name_row.fname, b_first_name_row.mname, b_first_name_row.lname,
				b_first_name_row.name_suffix, b_first_name_row.cname); 
		buyer_name2 := NameFromComponents(b_second_name_row.fname, b_second_name_row.mname, b_second_name_row.lname,
				b_second_name_row.name_suffix, b_second_name_row.cname);
		typeofparties := map(exists(l.parties(party_type = 'O')) => 'O',
						exists(l.parties(party_type = 'B')) =>'B', '');
		
		// The code below is mostly copied from BatchServices.xfm_Property_make_flat.
		
		property_party := l.parties(StringLib.StringToUpperCase(party_type_name) = BenefitAssessment_Services.Constants.PROPERTY)[1];
		buyer_party    := l.parties(StringLib.StringToUpperCase(party_type_name) = BenefitAssessment_Services.Constants.BUYER)[1];
		seller_party   := l.parties(StringLib.StringToUpperCase(party_type_name) = BenefitAssessment_Services.Constants.SELLER )[1];
		owner_party    := l.parties(StringLib.StringToUpperCase(party_type_name) IN [BenefitAssessment_Services.Constants.BUYER, BenefitAssessment_Services.Constants.ASSESSEE])[1];
		// Deed records won't have an assessee party.
		// assessee_party := l.parties(StringLib.StringToUpper(party_type_name) = BenefitAssessment_Services.Constants.ASSESSEE)[1];
		borrower_party := l.parties(StringLib.StringToUpperCase(party_type_name) = BenefitAssessment_Services.Constants.BORROWER)[1];
		
		SELF.Curr_Property_address 					:= Address.Addr1FromComponents(property_party.prim_range, property_party.predir, property_party.prim_name,
		                                     property_party.suffix, property_party.postdir, '', property_party.sec_range);
		SELF.Curr_property_address1         := Address.Addr1FromComponents(property_party.prim_range, property_party.predir, property_party.prim_name,
		                                     property_party.suffix, property_party.postdir, '', '');
		SELF.Curr_property_address2         := Address.Addr1FromComponents('', '', '','', '', property_party.unit_desig, property_party.sec_range);   
		SELF.Curr_property_v_city_name      := property_party.v_city_name;    
		SELF.Curr_Property_p_City_name 			:= property_party.p_city_name;
		SELF.Curr_Property_St   						:= property_party.st;
		SELF.Curr_property_zip              := property_party.zip;            
		SELF.Curr_property_zip4             := property_party.zip4;           
		SELF.Curr_property_county_name      := property_party.county_name;    
		SELF.Curr_property_geo_lat          := property_party.geo_lat;        
		SELF.Curr_property_geo_long         := property_party.geo_long;       
		SELF.Curr_property_msa              := property_party.msa;    
		SELF.Curr_property_orig_address     := property_party.orig_addr;
		SELF.Curr_property_orig_unit        := property_party.orig_unit;
		SELF.Curr_property_orig_csz         := property_party.orig_csz; 	  
		
		SELF.Curr_buyer_address1         := Address.Addr1FromComponents(buyer_party.prim_range, buyer_party.predir, buyer_party.prim_name,
		                                     buyer_party.suffix, buyer_party.postdir, '', '');
		SELF.Curr_buyer_address2         := Address.Addr1FromComponents('', '', '','', '', buyer_party.unit_desig, buyer_party.sec_range);
		SELF.Curr_buyer_p_city_name      := buyer_party.p_city_name;    
		SELF.Curr_buyer_v_city_name      := buyer_party.v_city_name;    
		SELF.Curr_buyer_st               := buyer_party.st;             
		SELF.Curr_buyer_zip              := buyer_party.zip;            
		SELF.Curr_buyer_zip4             := buyer_party.zip4;           
		SELF.Curr_buyer_county_name      := buyer_party.county_name;    
		SELF.Curr_buyer_geo_lat          := buyer_party.geo_lat;        
		SELF.Curr_buyer_geo_long         := buyer_party.geo_long;       
		SELF.Curr_buyer_msa              := buyer_party.msa;    
		SELF.Curr_buyer_orig_address     := buyer_party.orig_addr;
		SELF.Curr_buyer_orig_unit        := buyer_party.orig_unit;
		SELF.Curr_buyer_orig_csz         := buyer_party.orig_csz;
		SELF.Curr_buyer_phone_number     := buyer_party.phone_number;   	
		SELF.Curr_buyer_vesting_desc     := l.deeds[1].buyer_vesting_desc;
		
		SELF.Curr_buyer_1_orig_name      := StringLib.StringCleanSpaces(buyer_party.orig_names[1].orig_name );
		SELF.Curr_buyer_1_id_desc        := l.deeds[1].buyer1_id_desc;
		SELF.Curr_buyer_1_title          := buyer_party.entity[1].title;     
		SELF.Curr_buyer_1_first_name     := buyer_party.entity[1].fname;     
		SELF.Curr_buyer_1_middle_name    := buyer_party.entity[1].mname;     
		SELF.Curr_buyer_1_last_name      := buyer_party.entity[1].lname;      
		SELF.Curr_buyer_1_name_suffix    := buyer_party.entity[1].name_suffix;
		SELF.Curr_buyer_1_company_name   := buyer_party.entity[1].cname;     
		SELF.Curr_buyer_1_did            := buyer_party.entity[1].did;       
		SELF.Curr_buyer_1_bdid           := buyer_party.entity[1].bdid;       
		SELF.Curr_buyer_1_ssn            := buyer_party.entity[1].app_ssn;       
	
		SELF.Curr_buyer_2_orig_name      := StringLib.StringCleanSpaces( buyer_party.orig_names[2].orig_name );   
		SELF.Curr_buyer_2_id_desc        := l.deeds[1].buyer2_id_desc;
		SELF.Curr_buyer_2_title          := buyer_party.entity[2].title;     
		SELF.Curr_buyer_2_first_name     := buyer_party.entity[2].fname;     
		SELF.Curr_buyer_2_middle_name    := buyer_party.entity[2].mname;     
		SELF.Curr_buyer_2_last_name      := buyer_party.entity[2].lname;      
		SELF.Curr_buyer_2_name_suffix    := buyer_party.entity[2].name_suffix;
		SELF.Curr_buyer_2_company_name   := buyer_party.entity[2].cname;     
		SELF.Curr_buyer_2_did            := buyer_party.entity[2].did;       
		SELF.Curr_buyer_2_bdid           := buyer_party.entity[2].bdid;       
		SELF.Curr_buyer_2_ssn            := buyer_party.entity[2].app_ssn;    	
		
		s_first_name_row := seller_party.entity[1];
		s_second_name_row := seller_party.entity[2];
		SELF.Curr_seller_name1 := NameFromComponents(s_first_name_row.fname, s_first_name_row.mname, s_first_name_row.lname,
				s_first_name_row.name_suffix, s_first_name_row.cname); 
		SELF.Curr_seller_name2 := NameFromComponents(s_second_name_row.fname, s_second_name_row.mname, s_second_name_row.lname,
				s_second_name_row.name_suffix, s_second_name_row.cname);
		SELF.Curr_seller_address1         := Address.Addr1FromComponents(seller_party.prim_range, seller_party.predir, seller_party.prim_name,
		                                     seller_party.suffix, seller_party.postdir, '', '');
		SELF.Curr_seller_address2         := Address.Addr1FromComponents('', '', '','', '', seller_party.unit_desig, seller_party.sec_range);
		SELF.Curr_seller_p_city_name      := seller_party.p_city_name;    
		SELF.Curr_seller_v_city_name      := seller_party.v_city_name;    
		SELF.Curr_seller_st               := seller_party.st;             
		SELF.Curr_seller_zip              := seller_party.zip;            
		SELF.Curr_seller_zip4             := seller_party.zip4;           
		SELF.Curr_seller_county_name      := seller_party.county_name;    
		SELF.Curr_seller_geo_lat          := seller_party.geo_lat;        
		SELF.Curr_seller_geo_long         := seller_party.geo_long;       
		SELF.Curr_seller_msa              := seller_party.msa;    
		SELF.Curr_seller_orig_address     := seller_party.orig_addr;
		SELF.Curr_seller_orig_unit        := seller_party.orig_unit;
		SELF.Curr_seller_orig_csz         := seller_party.orig_csz;
		SELF.Curr_seller_phone_number     := seller_party.phone_number;   	
		
		SELF.Curr_seller_1_orig_name      := StringLib.StringCleanSpaces(seller_party.orig_names[1].orig_name );
		SELF.Curr_seller_1_id_desc        := l.deeds[1].seller1_id_desc;
		SELF.Curr_seller_1_title          := seller_party.entity[1].title;     
		SELF.Curr_seller_1_first_name     := seller_party.entity[1].fname;     
		SELF.Curr_seller_1_middle_name    := seller_party.entity[1].mname;     
		SELF.Curr_seller_1_last_name      := seller_party.entity[1].lname;      
		SELF.Curr_seller_1_name_suffix    := seller_party.entity[1].name_suffix;
		SELF.Curr_seller_1_company_name   := seller_party.entity[1].cname;     
		SELF.Curr_seller_1_did            := seller_party.entity[1].did;       
		SELF.Curr_seller_1_bdid           := seller_party.entity[1].bdid;       
		SELF.Curr_seller_1_ssn            := seller_party.entity[1].app_ssn;       
	
		SELF.Curr_seller_2_orig_name      := StringLib.StringCleanSpaces(seller_party.orig_names[2].orig_name);   
		SELF.Curr_seller_2_id_desc        := l.deeds[1].seller2_id_desc;
		SELF.Curr_seller_2_title          := seller_party.entity[2].title;     
		SELF.Curr_seller_2_first_name     := seller_party.entity[2].fname;     
		SELF.Curr_seller_2_middle_name    := seller_party.entity[2].mname;     
		SELF.Curr_seller_2_last_name      := seller_party.entity[2].lname;      
		SELF.Curr_seller_2_name_suffix    := seller_party.entity[2].name_suffix;
		SELF.Curr_seller_2_company_name   := seller_party.entity[2].cname;     
		SELF.Curr_seller_2_did            := seller_party.entity[2].did;       
		SELF.Curr_seller_2_bdid           := seller_party.entity[2].bdid;       
		SELF.Curr_seller_2_ssn            := seller_party.entity[2].app_ssn;  
		
		SELF.Curr_owner_address1         := Address.Addr1FromComponents(owner_party.prim_range, owner_party.predir, owner_party.prim_name,
		                                     owner_party.suffix, owner_party.postdir, '', '');
		SELF.Curr_owner_address2         := Address.Addr1FromComponents('', '', '','', '', owner_party.unit_desig, owner_party.sec_range);
		SELF.Curr_owner_p_city_name      := owner_party.p_city_name;    
		SELF.Curr_owner_v_city_name      := owner_party.v_city_name;    
		SELF.Curr_owner_st               := owner_party.st;             
		SELF.Curr_owner_zip              := owner_party.zip;            
		SELF.Curr_owner_zip4             := owner_party.zip4;           
		SELF.Curr_owner_county_name      := owner_party.county_name;    
		SELF.Curr_owner_geo_lat          := owner_party.geo_lat;        
		SELF.Curr_owner_geo_long         := owner_party.geo_long;       
		SELF.Curr_owner_msa              := owner_party.msa;    
		SELF.Curr_owner_orig_address     := owner_party.orig_addr;
		SELF.Curr_owner_orig_unit        := owner_party.orig_unit;
		SELF.Curr_owner_orig_csz         := owner_party.orig_csz;
		SELF.Curr_owner_phone_number     := owner_party.phone_number;   	
		
		SELF.Curr_owner_1_orig_name      := StringLib.StringCleanSpaces(owner_party.orig_names[1].orig_name );
		SELF.Curr_owner_1_title          := owner_party.entity[1].title;     
		SELF.Curr_owner_1_first_name     := owner_party.entity[1].fname;     
		SELF.Curr_owner_1_middle_name    := owner_party.entity[1].mname;     
		SELF.Curr_owner_1_last_name      := owner_party.entity[1].lname;      
		SELF.Curr_owner_1_name_suffix    := owner_party.entity[1].name_suffix;
		SELF.Curr_owner_1_company_name   := owner_party.entity[1].cname;     
		SELF.Curr_owner_1_did            := owner_party.entity[1].did;       
		SELF.Curr_owner_1_bdid           := owner_party.entity[1].bdid;       
		SELF.Curr_owner_1_ssn            := owner_party.entity[1].app_ssn;       
	
		SELF.Curr_owner_2_orig_name      := StringLib.StringCleanSpaces(owner_party.orig_names[2].orig_name);   
		SELF.Curr_owner_2_title          := owner_party.entity[2].title;     
		SELF.Curr_owner_2_first_name     := owner_party.entity[2].fname;     
		SELF.Curr_owner_2_middle_name    := owner_party.entity[2].mname;     
		SELF.Curr_owner_2_last_name      := owner_party.entity[2].lname;      
		SELF.Curr_owner_2_name_suffix    := owner_party.entity[2].name_suffix;
		SELF.Curr_owner_2_company_name   := owner_party.entity[2].cname;     
		SELF.Curr_owner_2_did            := owner_party.entity[2].did;       
		SELF.Curr_owner_2_bdid           := owner_party.entity[2].bdid;       
		SELF.Curr_owner_2_ssn            := owner_party.entity[2].app_ssn; 
				
		SELF.Curr_borrower_address1         := Address.Addr1FromComponents(borrower_party.prim_range, borrower_party.predir, borrower_party.prim_name,
		                                     borrower_party.suffix,borrower_party.postdir, '', '');
		SELF.Curr_borrower_address2         := Address.Addr1FromComponents('', '', '','', '', borrower_party.unit_desig,borrower_party.sec_range);
		SELF.Curr_borrower_p_city_name      := borrower_party.p_city_name;    
		SELF.Curr_borrower_v_city_name      := borrower_party.v_city_name;    
		SELF.Curr_borrower_st               := borrower_party.st;             
		SELF.Curr_borrower_zip              := borrower_party.zip;            
		SELF.Curr_borrower_zip4             := borrower_party.zip4;           
		SELF.Curr_borrower_county_name      := borrower_party.county_name;    
		SELF.Curr_borrower_geo_lat          := borrower_party.geo_lat;        
		SELF.Curr_borrower_geo_long         := borrower_party.geo_long;       
		SELF.Curr_borrower_msa              := borrower_party.msa;    
		SELF.Curr_borrower_orig_address     := borrower_party.orig_addr;
		SELF.Curr_borrower_orig_unit        := borrower_party.orig_unit;
		SELF.Curr_borrower_orig_csz         := borrower_party.orig_csz;
		SELF.Curr_borrower_phone_number     := borrower_party.phone_number;   	
		SELF.Curr_borrower_vesting_desc     := l.deeds[1].borrower_vesting_desc;
		
		SELF.Curr_borrower_1_orig_name      := StringLib.StringCleanSpaces(borrower_party.orig_names[1].orig_name);
		SELF.Curr_borrower_1_id_desc        := l.deeds[1].borrower1_id_desc;
		SELF.Curr_borrower_1_title          := borrower_party.entity[1].title;     
		SELF.Curr_borrower_1_first_name     := borrower_party.entity[1].fname;     
		SELF.Curr_borrower_1_middle_name    := borrower_party.entity[1].mname;     
		SELF.Curr_borrower_1_last_name      := borrower_party.entity[1].lname;      
		SELF.Curr_borrower_1_name_suffix    := borrower_party.entity[1].name_suffix;
		SELF.Curr_borrower_1_company_name   := borrower_party.entity[1].cname;     
		SELF.Curr_borrower_1_did            := borrower_party.entity[1].did;       
		SELF.Curr_borrower_1_bdid           := borrower_party.entity[1].bdid;       
		SELF.Curr_borrower_1_ssn            := borrower_party.entity[1].app_ssn;       
	  
		SELF.Curr_borrower_2_orig_name      := StringLib.StringCleanSpaces(borrower_party.orig_names[2].orig_name );   
		SELF.Curr_borrower_2_id_desc        := l.deeds[1].borrower2_id_desc;
		SELF.Curr_borrower_2_title          := borrower_party.entity[2].title;     
		SELF.Curr_borrower_2_first_name     := borrower_party.entity[2].fname;     
		SELF.Curr_borrower_2_middle_name    := borrower_party.entity[2].mname;     
		SELF.Curr_borrower_2_last_name      := borrower_party.entity[2].lname;      
		SELF.Curr_borrower_2_name_suffix    := borrower_party.entity[2].name_suffix;
		SELF.Curr_borrower_2_company_name   := borrower_party.entity[2].cname;     
		SELF.Curr_borrower_2_did            := borrower_party.entity[2].did;       
		SELF.Curr_borrower_2_bdid           := borrower_party.entity[2].bdid;       
		SELF.Curr_borrower_2_ssn            := borrower_party.entity[2].app_ssn;  
				
		SELF.Current_Property_Owned := MAP(typeofparties = '' => '',
			typeofparties = 'O' => 'Y', 'N');
		SELF.ofname1 := MAP(typeofparties = '' => '', 
			typeofparties = 'O' => o_first_name_row.fname, b_first_name_row.fname);
		SELF.ofname2:= MAP(typeofparties = '' => '', 
			typeofparties = 'O' => o_second_name_row.fname, b_second_name_row.fname);
		SELF.olname1 := MAP(typeofparties = '' => '', 
			typeofparties = 'O' =>  o_first_name_row.lname, b_first_name_row.lname);
		SELF.olname2:= MAP(typeofparties = '' => '', 
			typeofparties = 'O' => o_second_name_row.lname, b_second_name_row.lname);
		SELF.Curr_Owner_Name1 := MAP(typeofparties = '' => '', 
			typeofparties = 'O' => owner_name1, buyer_name1);
		SELF.Curr_Owner_Name2 :=MAP(typeofparties = '' => '', 
			typeofparties = 'O' => owner_name2, buyer_name2);	
		SELF.ossn1 := MAP(typeofparties = '' => '', 
			typeofparties = 'O' => o_first_name_row.app_ssn, b_first_name_row.app_ssn);
		SELF.ossn2:= MAP(typeofparties = '' => '', 
			typeofparties = 'O' => o_second_name_row.app_ssn, b_second_name_row.app_ssn);
		SELF.Curr_Sale_Date := '';
		SELF.Curr_Total_Value := ''; //not sure what this is
		SELF.Curr_Sale_Amount := l.deeds[1].sales_price;
		SELF.Curr_Assess_Value := '';
		SELF.Curr_Market_Value := '';
		SELF.Curr_Mortgage_amount := '';
		max_tot_prop := (string11) max((UNSIGNED) (l.deeds[1].sales_price)); //HIGHEST VALUE
		SELF.Curr_Total_Property_Value := if(max_tot_prop = '0', '', max_tot_prop);
		SELF.Curr_recording_date := l.deeds[1].recording_date;
		SELF.Curr_Tax_Year := '';//no deed value
		SELF.Curr_Land_Usage := l.deeds[1].property_use_desc;
		SELF.Curr_Document_Type := l.deeds[1].document_type_desc; 
		SELF.Current_Property_Owned_OOS := '';
		SELF.Curr_sortby_date := l.sortby_date;
		SELF.Curr_current_record := l.current_record;
		
		// filing info
		
		SELF.Curr_deed_state := l.deeds[1].state;
		SELF.Curr_deed_county_name := l.deeds[1].county_name;
		SELF.Curr_deed_apnt_or_pin_number := l.deeds[1].apnt_or_pin_number;					
		SELF.Curr_deed_fips_code := l.deeds[1].fips_code;
		SELF.Curr_deed_record_type := l.deeds[1].record_type;
		SELF.Curr_deed_record_type_desc := l.deeds[1].record_type_desc;
		SELF.Curr_deed_multi_apn_flag := l.deeds[1].multi_apn_flag;					
		SELF.Curr_deed_buyer_addendum_flag := l.deeds[1].buyer_addendum_flag;
		SELF.Curr_deed_seller_addendum_flag := l.deeds[1].seller_addendum_flag;		
		
		// lender info
		
		SELF.Curr_deed_lender_name := l.deeds[1].lender_name;					
		SELF.Curr_deed_lender_name_id := l.deeds[1].lender_name_id;
		SELF.Curr_deed_lender_dba_aka_name := l.deeds[1].lender_dba_aka_name;
		SELF.Curr_deed_tax_id_number := l.deeds[1].tax_id_number;
		
		// phone info
		
		SELF.Curr_deed_phone_number := l.deeds[1].phone_number;
		
		// propertyAddress info
		
		SELF.Curr_deed_property_address_code := l.deeds[1].property_address_code;
		SELF.Curr_deed_property_address_desc := l.deeds[1].property_address_desc;		
		SELF.Curr_deed_lender_full_street_address := l.deeds[1].lender_full_street_address;
		SELF.Curr_deed_lender_address_unit_number := l.deeds[1].lender_address_unit_number;
		SELF.Curr_deed_lender_address_citystatezip := l.deeds[1].lender_address_citystatezip;	
		
		// legal info	
		
		SELF.Curr_deed_legal_brief_description := l.deeds[1].legal_brief_description;
		SELF.Curr_deed_contract_date := l.deeds[1].contract_date;
		SELF.Curr_deed_recording_date := l.deeds[1].recording_date;
		SELF.Curr_deed_document_type_code := l.deeds[1].document_type_code;
		SELF.Curr_deed_document_type_desc := l.deeds[1].document_type_desc;					
		SELF.Curr_deed_arm_reset_date := l.deeds[1].arm_reset_date;
		SELF.Curr_deed_document_number := l.deeds[1].document_number;
		SELF.Curr_deed_recorder_book_number := l.deeds[1].recorder_book_number;
		SELF.Curr_deed_recorder_page_number := l.deeds[1].recorder_page_number;
		SELF.Curr_deed_land_lot_size := l.deeds[1].land_lot_size;
		SELF.Curr_deed_legal_lot_desc := l.deeds[1].legal_lot_desc;
		SELF.Curr_deed_legal_lot_number := l.deeds[1].legal_lot_number;
		SELF.Curr_deed_legal_block := l.deeds[1].legal_block;
		SELF.Curr_deed_legal_section := l.deeds[1].legal_section;
		SELF.Curr_deed_legal_district := l.deeds[1].legal_district;
		SELF.Curr_deed_legal_land_lot := l.deeds[1].legal_land_lot;
		SELF.Curr_deed_legal_unit := l.deeds[1].legal_unit;
		SELF.Curr_deed_legal_city_municipality_township := l.deeds[1].legal_city_municipality_township;
		SELF.Curr_deed_legal_subdivision_name := l.deeds[1].legal_subdivision_name;
		SELF.Curr_deed_legal_phase_number := l.deeds[1].legal_phase_number;
		SELF.Curr_deed_legal_tract_number := l.deeds[1].legal_tract_number;
		SELF.Curr_deed_legal_sec_twn_rng_mer := l.deeds[1].legal_sec_twn_rng_mer;
		SELF.Curr_deed_recorder_map_reference := l.deeds[1].recorder_map_reference;
		SELF.Curr_deed_complete_legal_description_code := l.deeds[1].complete_legal_description_code;
		SELF.Curr_deed_loan_number := l.deeds[1].loan_number;
		SELF.Curr_deed_concurrent_mortgage_book_page_document_number := l.deeds[1].concurrent_mortgage_book_page_document_number;
		SELF.Curr_deed_hawaii_tct := l.deeds[1].hawaii_tct;
		SELF.Curr_deed_hawaii_condo_cpr_code := l.deeds[1].hawaii_condo_cpr_code;
		SELF.Curr_deed_hawaii_condo_name := l.deeds[1].hawaii_condo_name;
		SELF.Curr_deed_filler_except_hawaii := l.deeds[1].filler_except_hawaii;		
		
		// sales info
		
		SELF.Curr_deed_sales_price := l.deeds[1].sales_price;
		SELF.Curr_deed_sales_price_desc := l.deeds[1].sales_price_desc;
		SELF.Curr_deed_city_transfer_tax := l.deeds[1].city_transfer_tax;
		SELF.Curr_deed_county_transfer_tax := l.deeds[1].county_transfer_tax;
		SELF.Curr_deed_total_transfer_tax := l.deeds[1].total_transfer_tax;
		SELF.Curr_deed_excise_tax_number := l.deeds[1].excise_tax_number;	
		
		// property info
		
		SELF.Curr_deed_property_use_desc := l.deeds[1].property_use_desc;
		SELF.Curr_deed_assessment_match_land_use_desc := l.deeds[1].assessment_match_land_use_desc;
		SELF.Curr_deed_condo_desc := l.deeds[1].condo_desc;
		SELF.Curr_deed_timeshare_flag := l.deeds[1].timeshare_flag;			
			
		// mortgage info
		
		SELF.Curr_deed_first_td_loan_amount := l.deeds[1].first_td_loan_amount;					
		SELF.Curr_deed_first_td_loan_type_desc := l.deeds[1].first_td_loan_type_desc;
		SELF.Curr_deed_type_financing := l.deeds[1].type_financing;
		SELF.Curr_deed_type_financing_desc := l.deeds[1].type_financing_desc;
		SELF.Curr_deed_first_td_interest_rate := l.deeds[1].first_td_interest_rate;
		SELF.Curr_deed_first_td_due_date := l.deeds[1].first_td_due_date;
		SELF.Curr_deed_title_company_name := l.deeds[1].title_company_name;
		SELF.Curr_deed_rate_change_frequency := l.deeds[1].rate_change_frequency;
		SELF.Curr_deed_rate_change_frequency_desc := l.deeds[1].rate_change_frequency_desc;
		SELF.Curr_deed_change_index := l.deeds[1].change_index;
		SELF.Curr_deed_adjustable_rate_index := l.deeds[1].adjustable_rate_index;
		SELF.Curr_deed_adjustable_rate_index_desc := l.deeds[1].adjustable_rate_index_desc;
		SELF.Curr_deed_adjustable_rate_rider := l.deeds[1].adjustable_rate_rider;
		SELF.Curr_deed_graduated_payment_rider := l.deeds[1].graduated_payment_rider;
		SELF.Curr_deed_balloon_rider := l.deeds[1].balloon_rider;
		SELF.Curr_deed_fixed_step_rate_rider := l.deeds[1].fixed_step_rate_rider;
		SELF.Curr_deed_fixed_step_rate_rider_desc := l.deeds[1].fixed_step_rate_rider_desc;
		SELF.Curr_deed_condominium_rider := l.deeds[1].condominium_rider;
		SELF.Curr_deed_planned_unit_development_rider := l.deeds[1].planned_unit_development_rider;
		SELF.Curr_deed_rate_improvement_rider := l.deeds[1].rate_improvement_rider;
		SELF.Curr_deed_assumability_rider := l.deeds[1].assumability_rider;
		SELF.Curr_deed_prepayment_rider := l.deeds[1].prepayment_rider;
		SELF.Curr_deed_one_four_family_rider := l.deeds[1].one_four_family_rider;
		SELF.Curr_deed_biweekly_payment_rider := l.deeds[1].biweekly_payment_rider;
		SELF.Curr_deed_second_home_rider := l.deeds[1].second_home_rider;
		SELF.Curr_deed_second_td_loan_amount := l.deeds[1].second_td_loan_amount;
		SELF.Curr_deed_first_td_lender_type_desc := l.deeds[1].first_td_lender_type_desc;
		SELF.Curr_deed_second_td_lender_type_desc := l.deeds[1].second_td_lender_type_desc;
		SELF.Curr_deed_partial_interest_transferred := l.deeds[1].partial_interest_transferred;
		SELF.Curr_deed_loan_term_months := l.deeds[1].loan_term_months;
		SELF.Curr_deed_loan_term_years := l.deeds[1].loan_term_years;			
		
		// addl fares info
		
		SELF.Curr_deed_transaction_type_desc := l.deeds[1].fares_transaction_type_desc;
		SELF.Curr_deed_lender_address := l.deeds[1].fares_lender_address;
		
		SELF := l;
		SELF := []; // assessment info is blank on deed records

	END;
 
	export 	BenefitAssessment_Services.Layouts.prop_flat_rec MakeAssessmentFlat(BenefitAssessment_Services.Layouts.rec_propOutWithAcctno l) := TRANSFORM
		SELF.Curr_Record_Type := LN_PropertyV2_Services.consts.TYPE_ASSESSMENT; 	
		first_addr_row := l.parties(party_type = 'P')[1];	
		SELF.ln_fares_id := l.ln_fares_id;
		
		o_first_name_row := l.parties(party_type = 'O').entity[1];
		o_second_name_row := l.parties(party_type = 'O').entity[2];

		SELF.Current_Property_Owned := 'Y'; //as all owners	
		SELF.Curr_Owner_Name1 := NameFromComponents(o_first_name_row.fname, o_first_name_row.mname, o_first_name_row.lname,
				o_first_name_row.name_suffix, o_first_name_row.cname); 
		SELF.Curr_Owner_Name2 := NameFromComponents(o_second_name_row.fname, o_second_name_row.mname, o_second_name_row.lname,
				o_second_name_row.name_suffix, o_second_name_row.cname);
  	
		SELF.ofname1 := o_first_name_row.fname;
		SELF.ofname2:= o_second_name_row.fname;
		SELF.olname1 := o_first_name_row.lname;;
		SELF.olname2:= o_second_name_row.lname;
		SELF.ossn1 := o_first_name_row.app_ssn;
		SELF.ossn2 := o_second_name_row.app_ssn;
		SELF.Curr_Sale_Date := l.assessments[1].sale_date;
		SELF.Curr_Total_Value := l.assessments[1].assessed_total_value; 
		SELF.Curr_Sale_Amount := l.assessments[1].sales_price;
		SELF.Curr_Assess_Value := l.assessments[1].assessed_land_value;
		SELF.Curr_Market_Value := l.assessments[1].market_total_value;
		SELF.Curr_Mortgage_amount := l.assessments[1].mortgage_loan_amount;
		max_property := (string11) max((UNSIGNED) l.assessments[1].sales_price, 	
				 														 (UNSIGNED) l.assessments[1].assessed_total_value,
																		 (UNSIGNED) l.assessments[1].market_total_value,
																		 (UNSIGNED) l.assessments[1].mortgage_loan_amount); //HIGHEST VALUE
		SELF.Curr_Total_Property_Value := if(max_property = '0', '', max_property);
		SELF.Curr_recording_date := l.assessments[1].recording_date;
		SELF.Curr_Tax_Year := l.assessments[1].tax_year;
		SELF.Curr_Land_Usage := l.assessments[1].county_land_use_description;
		SELF.Curr_Document_Type := l.assessments[1].document_type_desc; ;
		SELF.Current_Property_Owned_OOS := '';
		SELF.Curr_sortby_date := l.sortby_date;
		SELF.Curr_current_record := l.current_record;

		// The code below is mostly copied from BatchServices.xfm_Property_make_flat.
		property_party := l.parties(StringLib.StringToUpperCase(party_type_name) = BenefitAssessment_Services.Constants.PROPERTY)[1];
		buyer_party    := l.parties(StringLib.StringToUpperCase(party_type_name) = BenefitAssessment_Services.Constants.BUYER)[1];
		seller_party   := l.parties(StringLib.StringToUpperCase(party_type_name) = BenefitAssessment_Services.Constants.SELLER )[1];
		owner_party    := l.parties(StringLib.StringToUpperCase(party_type_name) IN [BenefitAssessment_Services.Constants.BUYER, BenefitAssessment_Services.Constants.ASSESSEE])[1];
		assessee_party := l.parties(StringLib.StringToUpperCase(party_type_name) = BenefitAssessment_Services.Constants.ASSESSEE)[1];
		// Assessment records won't have a borrower party.
		// borrower_party := l.parties(StringLib.StringToUpper(party_type_name) = BenefitAssessment_Services.Constants.BORROWER)[1];
		
		SELF.Curr_Property_address 					:= Address.Addr1FromComponents(property_party.prim_range, property_party.predir, property_party.prim_name,
		                                     property_party.suffix, property_party.postdir, '', property_party.sec_range);
		SELF.Curr_property_address1         := Address.Addr1FromComponents(property_party.prim_range, property_party.predir, property_party.prim_name,
		                                     property_party.suffix, property_party.postdir, '', '');
		SELF.Curr_property_address2         := Address.Addr1FromComponents('', '', '','', '', property_party.unit_desig, property_party.sec_range);
		SELF.Curr_property_v_city_name      := property_party.v_city_name;    
		SELF.Curr_Property_p_city_name 			:= property_party.p_city_name; 
		SELF.Curr_Property_St   						:= property_party.st;
		SELF.Curr_property_zip              := property_party.zip;            
		SELF.Curr_property_zip4             := property_party.zip4;           
		SELF.Curr_property_county_name      := property_party.county_name;    
		SELF.Curr_property_geo_lat          := property_party.geo_lat;        
		SELF.Curr_property_geo_long         := property_party.geo_long;       
		SELF.Curr_property_msa              := property_party.msa;    
		SELF.Curr_property_orig_address     := property_party.orig_addr;
		SELF.Curr_property_orig_unit        := property_party.orig_unit;
		SELF.Curr_property_orig_csz         := property_party.orig_csz; 	  
		
		SELF.Curr_buyer_address1         := Address.Addr1FromComponents(buyer_party.prim_range, buyer_party.predir, buyer_party.prim_name,
		                                     buyer_party.suffix, buyer_party.postdir, '', '');
		SELF.Curr_buyer_address2         := Address.Addr1FromComponents('', '', '','', '', buyer_party.unit_desig, buyer_party.sec_range);
		SELF.Curr_buyer_p_city_name      := buyer_party.p_city_name;    
		SELF.Curr_buyer_v_city_name      := buyer_party.v_city_name;    
		SELF.Curr_buyer_st               := buyer_party.st;             
		SELF.Curr_buyer_zip              := buyer_party.zip;            
		SELF.Curr_buyer_zip4             := buyer_party.zip4;           
		SELF.Curr_buyer_county_name      := buyer_party.county_name;    
		SELF.Curr_buyer_geo_lat          := buyer_party.geo_lat;        
		SELF.Curr_buyer_geo_long         := buyer_party.geo_long;       
		SELF.Curr_buyer_msa              := buyer_party.msa;    
		SELF.Curr_buyer_orig_address     := buyer_party.orig_addr;
		SELF.Curr_buyer_orig_unit        := buyer_party.orig_unit;
		SELF.Curr_buyer_orig_csz         := buyer_party.orig_csz;
		SELF.Curr_buyer_phone_number     := buyer_party.phone_number;   	
		SELF.Curr_buyer_vesting_desc     := l.deeds[1].buyer_vesting_desc;
		
		SELF.Curr_buyer_1_orig_name      := StringLib.StringCleanSpaces(buyer_party.orig_names[1].orig_name);
		SELF.Curr_buyer_1_id_desc        := l.deeds[1].buyer1_id_desc;
		SELF.Curr_buyer_1_title          := buyer_party.entity[1].title;     
		SELF.Curr_buyer_1_first_name     := buyer_party.entity[1].fname;     
		SELF.Curr_buyer_1_middle_name    := buyer_party.entity[1].mname;     
		SELF.Curr_buyer_1_last_name      := buyer_party.entity[1].lname;      
		SELF.Curr_buyer_1_name_suffix    := buyer_party.entity[1].name_suffix;
		SELF.Curr_buyer_1_company_name   := buyer_party.entity[1].cname;     
		SELF.Curr_buyer_1_did            := buyer_party.entity[1].did;       
		SELF.Curr_buyer_1_bdid           := buyer_party.entity[1].bdid;       
		SELF.Curr_buyer_1_ssn            := buyer_party.entity[1].app_ssn;       
	
		SELF.Curr_buyer_2_orig_name      := StringLib.StringCleanSpaces(buyer_party.orig_names[2].orig_name);   
		SELF.Curr_buyer_2_id_desc        := l.deeds[1].buyer2_id_desc;
		SELF.Curr_buyer_2_title          := buyer_party.entity[2].title;     
		SELF.Curr_buyer_2_first_name     := buyer_party.entity[2].fname;     
		SELF.Curr_buyer_2_middle_name    := buyer_party.entity[2].mname;     
		SELF.Curr_buyer_2_last_name      := buyer_party.entity[2].lname;      
		SELF.Curr_buyer_2_name_suffix    := buyer_party.entity[2].name_suffix;
		SELF.Curr_buyer_2_company_name   := buyer_party.entity[2].cname;     
		SELF.Curr_buyer_2_did            := buyer_party.entity[2].did;       
		SELF.Curr_buyer_2_bdid           := buyer_party.entity[2].bdid;       
		SELF.Curr_buyer_2_ssn            := buyer_party.entity[2].app_ssn;    	
		
		s_first_name_row := seller_party.entity[1];
		s_second_name_row := seller_party.entity[2];
		SELF.Curr_seller_name1 := NameFromComponents(s_first_name_row.fname, s_first_name_row.mname, s_first_name_row.lname,
				s_first_name_row.name_suffix, s_first_name_row.cname); 
		SELF.Curr_seller_name2 := NameFromComponents(s_second_name_row.fname, s_second_name_row.mname, s_second_name_row.lname,
				s_second_name_row.name_suffix, s_second_name_row.cname);
		SELF.Curr_seller_address1         := Address.Addr1FromComponents(seller_party.prim_range, seller_party.predir, seller_party.prim_name,
		                                     seller_party.suffix, seller_party.postdir, '', '');
		SELF.Curr_seller_address2         := Address.Addr1FromComponents('', '', '','', '', seller_party.unit_desig, seller_party.sec_range);
		SELF.Curr_seller_p_city_name      := seller_party.p_city_name;    
		SELF.Curr_seller_v_city_name      := seller_party.v_city_name;    
		SELF.Curr_seller_st               := seller_party.st;    
		SELF.Curr_seller_zip              := seller_party.zip;            
		SELF.Curr_seller_zip4             := seller_party.zip4;           
		SELF.Curr_seller_county_name      := seller_party.county_name;    
		SELF.Curr_seller_geo_lat          := seller_party.geo_lat;        
		SELF.Curr_seller_geo_long         := seller_party.geo_long;       
		SELF.Curr_seller_msa              := seller_party.msa;    
		SELF.Curr_seller_orig_address     := seller_party.orig_addr;
		SELF.Curr_seller_orig_unit        := seller_party.orig_unit;
		SELF.Curr_seller_orig_csz         := seller_party.orig_csz;
		SELF.Curr_seller_phone_number     := seller_party.phone_number;   	
		
		SELF.Curr_seller_1_orig_name      := StringLib.StringCleanSpaces(seller_party.orig_names[1].orig_name);
		SELF.Curr_seller_1_id_desc        := l.deeds[1].seller1_id_desc;
		SELF.Curr_seller_1_title          := seller_party.entity[1].title;     
		SELF.Curr_seller_1_first_name     := seller_party.entity[1].fname;     
		SELF.Curr_seller_1_middle_name    := seller_party.entity[1].mname;     
		SELF.Curr_seller_1_last_name      := seller_party.entity[1].lname;      
		SELF.Curr_seller_1_name_suffix    := seller_party.entity[1].name_suffix;
		SELF.Curr_seller_1_company_name   := seller_party.entity[1].cname;     
		SELF.Curr_seller_1_did            := seller_party.entity[1].did;       
		SELF.Curr_seller_1_bdid           := seller_party.entity[1].bdid;       
		SELF.Curr_seller_1_ssn            := seller_party.entity[1].app_ssn;       
	
		SELF.Curr_seller_2_orig_name      := StringLib.StringCleanSpaces(seller_party.orig_names[2].orig_name);   
		SELF.Curr_seller_2_id_desc        := l.deeds[1].seller2_id_desc;
		SELF.Curr_seller_2_title          := seller_party.entity[2].title;     
		SELF.Curr_seller_2_first_name     := seller_party.entity[2].fname;     
		SELF.Curr_seller_2_middle_name    := seller_party.entity[2].mname;     
		SELF.Curr_seller_2_last_name      := seller_party.entity[2].lname;      
		SELF.Curr_seller_2_name_suffix    := seller_party.entity[2].name_suffix;
		SELF.Curr_seller_2_company_name   := seller_party.entity[2].cname;     
		SELF.Curr_seller_2_did            := seller_party.entity[2].did;       
		SELF.Curr_seller_2_bdid           := seller_party.entity[2].bdid;       
		SELF.Curr_seller_2_ssn            := seller_party.entity[2].app_ssn;  
		
		SELF.Curr_owner_address1         := Address.Addr1FromComponents(owner_party.prim_range, owner_party.predir, owner_party.prim_name,
		                                     owner_party.suffix, owner_party.postdir, '', '');
		SELF.Curr_owner_address2         := Address.Addr1FromComponents('', '', '','', '', owner_party.unit_desig, owner_party.sec_range);
		SELF.Curr_owner_p_city_name      := owner_party.p_city_name;    
		SELF.Curr_owner_v_city_name      := owner_party.v_city_name;    
		SELF.Curr_owner_st               := owner_party.st;             
		SELF.Curr_owner_zip              := owner_party.zip;            
		SELF.Curr_owner_zip4             := owner_party.zip4;           
		SELF.Curr_owner_county_name      := owner_party.county_name;    
		SELF.Curr_owner_geo_lat          := owner_party.geo_lat;        
		SELF.Curr_owner_geo_long         := owner_party.geo_long;       
		SELF.Curr_owner_msa              := owner_party.msa;    
		SELF.Curr_owner_orig_address     := owner_party.orig_addr;
		SELF.Curr_owner_orig_unit        := owner_party.orig_unit;
		SELF.Curr_owner_orig_csz         := owner_party.orig_csz;
		SELF.Curr_owner_phone_number     := owner_party.phone_number;   	
		
		SELF.Curr_owner_1_orig_name      := StringLib.StringCleanSpaces(owner_party.orig_names[1].orig_name);
		SELF.Curr_owner_1_title          := owner_party.entity[1].title;     
		SELF.Curr_owner_1_first_name     := owner_party.entity[1].fname;     
		SELF.Curr_owner_1_middle_name    := owner_party.entity[1].mname;     
		SELF.Curr_owner_1_last_name      := owner_party.entity[1].lname;      
		SELF.Curr_owner_1_name_suffix    := owner_party.entity[1].name_suffix;
		SELF.Curr_owner_1_company_name   := owner_party.entity[1].cname;     
		SELF.Curr_owner_1_did            := owner_party.entity[1].did;       
		SELF.Curr_owner_1_bdid           := owner_party.entity[1].bdid;       
		SELF.Curr_owner_1_ssn            := owner_party.entity[1].app_ssn;       
	
		SELF.Curr_owner_2_orig_name      := StringLib.StringCleanSpaces(owner_party.orig_names[2].orig_name);   
		SELF.Curr_owner_2_title          := owner_party.entity[2].title;     
		SELF.Curr_owner_2_first_name     := owner_party.entity[2].fname;     
		SELF.Curr_owner_2_middle_name    := owner_party.entity[2].mname;     
		SELF.Curr_owner_2_last_name      := owner_party.entity[2].lname;      
		SELF.Curr_owner_2_name_suffix    := owner_party.entity[2].name_suffix;
		SELF.Curr_owner_2_company_name   := owner_party.entity[2].cname;     
		SELF.Curr_owner_2_did            := owner_party.entity[2].did;       
		SELF.Curr_owner_2_bdid           := owner_party.entity[2].bdid;       
		SELF.Curr_owner_2_ssn            := owner_party.entity[2].app_ssn;  
		
		SELF.Curr_assessee_address1         := Address.Addr1FromComponents(assessee_party.prim_range, assessee_party.predir, assessee_party.prim_name,
		                                     assessee_party.suffix,assessee_party.postdir, '', '');
		SELF.Curr_assessee_address2         := Address.Addr1FromComponents('', '', '','', '', assessee_party.unit_desig, assessee_party.sec_range);
		SELF.Curr_assessee_p_city_name      := assessee_party.p_city_name;    
		SELF.Curr_assessee_v_city_name      := assessee_party.v_city_name;    
		SELF.Curr_assessee_st               := assessee_party.st;             
		SELF.Curr_assessee_zip              := assessee_party.zip;            
		SELF.Curr_assessee_zip4             := assessee_party.zip4;           
		SELF.Curr_assessee_county_name      := assessee_party.county_name;    
		SELF.Curr_assessee_geo_lat          := assessee_party.geo_lat;        
		SELF.Curr_assessee_geo_long         := assessee_party.geo_long;       
		SELF.Curr_assessee_msa              := assessee_party.msa;    
		SELF.Curr_assessee_orig_address     := assessee_party.orig_addr;
		SELF.Curr_assessee_orig_unit        := assessee_party.orig_unit;
		SELF.Curr_assessee_orig_csz         := assessee_party.orig_csz;
		SELF.Curr_assessee_phone_number     := assessee_party.phone_number;   	
		
		SELF.Curr_assessee_1_orig_name      := StringLib.StringCleanSpaces(assessee_party.orig_names[1].orig_name);
		SELF.Curr_assessee_1_title          := assessee_party.entity[1].title;     
		SELF.Curr_assessee_1_first_name     := assessee_party.entity[1].fname;     
		SELF.Curr_assessee_1_middle_name    := assessee_party.entity[1].mname;     
		SELF.Curr_assessee_1_last_name      := assessee_party.entity[1].lname;      
		SELF.Curr_assessee_1_name_suffix    := assessee_party.entity[1].name_suffix;
		SELF.Curr_assessee_1_company_name   := assessee_party.entity[1].cname;     
		SELF.Curr_assessee_1_did            := assessee_party.entity[1].did;       
		SELF.Curr_assessee_1_bdid           := assessee_party.entity[1].bdid;       
		SELF.Curr_assessee_1_ssn            := assessee_party.entity[1].app_ssn;       
	
		SELF.Curr_assessee_2_orig_name      := StringLib.StringCleanSpaces(assessee_party.orig_names[2].orig_name);   
		SELF.Curr_assessee_2_title          := assessee_party.entity[2].title;     
		SELF.Curr_assessee_2_first_name     := assessee_party.entity[2].fname;     
		SELF.Curr_assessee_2_middle_name    := assessee_party.entity[2].mname;     
		SELF.Curr_assessee_2_last_name      := assessee_party.entity[2].lname;      
		SELF.Curr_assessee_2_name_suffix    := assessee_party.entity[2].name_suffix;
		SELF.Curr_assessee_2_company_name   := assessee_party.entity[2].cname;     
		SELF.Curr_assessee_2_did            := assessee_party.entity[2].did;       
		SELF.Curr_assessee_2_bdid           := assessee_party.entity[2].bdid;       
		SELF.Curr_assessee_2_ssn            := assessee_party.entity[2].app_ssn;  
		
		SELF.Curr_assess_assessed_total_value := l.assessments[1].assessed_total_value;
		SELF.Curr_assess_assessed_value_year := l.assessments[1].assessed_value_year;
		SELF.Curr_assess_homestead_homeowner_exemption := l.assessments[1].homestead_homeowner_exemption;
		SELF.Curr_assess_assessed_improvement_value := l.assessments[1].assessed_improvement_value;
		SELF.Curr_assess_market_land_value := l.assessments[1].market_land_value;
		SELF.Curr_assess_market_improvement_value := l.assessments[1].market_improvement_value;
		SELF.Curr_assess_market_total_value := l.assessments[1].market_total_value;
		SELF.Curr_assess_market_value_year := l.assessments[1].market_value_year;
		SELF.Curr_assess_assessed_land_value := l.assessments[1].assessed_land_value;
											
		// tax info
		
		SELF.Curr_assess_tax_year := l.assessments[1].tax_year;
		SELF.Curr_assess_tax_amount := l.assessments[1].tax_amount;
		SELF.Curr_assess_tax_exemption1_desc := l.assessments[1].tax_exemption1_desc;
		SELF.Curr_assess_tax_exemption2_desc := l.assessments[1].tax_exemption2_desc;
		SELF.Curr_assess_tax_exemption3_desc := l.assessments[1].tax_exemption3_desc;
		SELF.Curr_assess_tax_exemption4_desc := l.assessments[1].tax_exemption4_desc;
		SELF.Curr_assess_tax_rate_code_area := l.assessments[1].tax_rate_code_area;
		SELF.Curr_assess_tax_delinquent_year := l.assessments[1].tax_delinquent_year;
		SELF.Curr_assess_school_tax_district1 := l.assessments[1].school_tax_district1;
		SELF.Curr_assess_school_tax_district2 := l.assessments[1].school_tax_district2;
		SELF.Curr_assess_school_tax_district3 := l.assessments[1].school_tax_district3;								

		// property info			

		SELF.Curr_assess_land_square_footage := l.assessments[1].land_square_footage;
		SELF.Curr_assess_year_built := l.assessments[1].year_built;
		SELF.Curr_assess_no_of_stories := l.assessments[1].no_of_stories;
		SELF.Curr_assess_no_of_stories_desc := l.assessments[1].no_of_stories_desc;
		SELF.Curr_assess_no_of_bedrooms := l.assessments[1].no_of_bedrooms;
		SELF.Curr_assess_no_of_baths := l.assessments[1].no_of_baths;
		SELF.Curr_assess_no_of_partial_baths := l.assessments[1].no_of_partial_baths;
		SELF.Curr_assess_garage_type_desc := l.assessments[1].garage_type_desc;
		SELF.Curr_assess_pool_desc := l.assessments[1].pool_desc;
		SELF.Curr_assess_exterior_walls_desc := l.assessments[1].exterior_walls_desc;
		SELF.Curr_assess_roof_type_desc := l.assessments[1].roof_type_desc;
		SELF.Curr_assess_heating_desc := l.assessments[1].heating_desc;
		SELF.Curr_assess_heating_fuel_type_desc := l.assessments[1].heating_fuel_type_desc;
		SELF.Curr_assess_air_conditioning_desc := l.assessments[1].air_conditioning_desc;
		SELF.Curr_assess_air_conditioning_type_desc := l.assessments[1].air_conditioning_type_desc;
		SELF.Curr_assess_land_acres := l.assessments[1].land_acres;
		SELF.Curr_assess_land_dimensions := l.assessments[1].land_dimensions;
		SELF.Curr_assess_building_area := l.assessments[1].building_area;
		SELF.Curr_assess_building_area1 := l.assessments[1].building_area1;
		SELF.Curr_assess_building_area2 := l.assessments[1].building_area2;
		SELF.Curr_assess_building_area3 := l.assessments[1].building_area3;
		SELF.Curr_assess_building_area4 := l.assessments[1].building_area4;
		SELF.Curr_assess_building_area5 := l.assessments[1].building_area5;
		SELF.Curr_assess_building_area6 := l.assessments[1].building_area6;
		SELF.Curr_assess_building_area7 := l.assessments[1].building_area7;
		SELF.Curr_assess_building_area_desc := l.assessments[1].building_area_desc;
		SELF.Curr_assess_building_area1_desc := l.assessments[1].building_area1_desc;
		SELF.Curr_assess_building_area2_desc := l.assessments[1].building_area2_desc;
		SELF.Curr_assess_building_area3_desc := l.assessments[1].building_area3_desc;
		SELF.Curr_assess_building_area4_desc := l.assessments[1].building_area4_desc;
		SELF.Curr_assess_building_area5_desc := l.assessments[1].building_area5_desc;
		SELF.Curr_assess_building_area6_desc := l.assessments[1].building_area6_desc;
		SELF.Curr_assess_building_area7_desc := l.assessments[1].building_area7_desc;
		SELF.Curr_assess_effective_year_built := l.assessments[1].effective_year_built;
		SELF.Curr_assess_no_of_buildings := l.assessments[1].no_of_buildings;
		SELF.Curr_assess_no_of_units := l.assessments[1].no_of_units;
		SELF.Curr_assess_no_of_rooms := l.assessments[1].no_of_rooms;
		SELF.Curr_assess_parking_no_of_cars := l.assessments[1].parking_no_of_cars;

		SELF.Curr_assess_style_desc := l.assessments[1].style_desc;
		SELF.Curr_assess_type_construction_desc := l.assessments[1].type_construction_desc;
		SELF.Curr_assess_foundation_desc := l.assessments[1].foundation_desc;
		SELF.Curr_assess_roof_cover_desc := l.assessments[1].roof_cover_desc;
		SELF.Curr_assess_elevator := l.assessments[1].elevator;
		SELF.Curr_assess_fireplace_indicator_desc := l.assessments[1].fireplace_indicator_desc;
		SELF.Curr_assess_fireplace_number := l.assessments[1].fireplace_number;
		SELF.Curr_assess_basement_desc := l.assessments[1].basement_desc;
		SELF.Curr_assess_building_class_desc := l.assessments[1].building_class_desc;

		SELF.Curr_assess_site_influence1_desc := l.assessments[1].site_influence1_desc;
		SELF.Curr_assess_site_influence2_desc := l.assessments[1].site_influence2_desc;
		SELF.Curr_assess_site_influence3_desc := l.assessments[1].site_influence3_desc;
		SELF.Curr_assess_site_influence4_desc := l.assessments[1].site_influence4_desc;
		SELF.Curr_assess_site_influence5_desc := l.assessments[1].site_influence5_desc;

		SELF.Curr_assess_amenities1_desc := l.assessments[1].amenities1_desc;
		SELF.Curr_assess_amenities2_desc := l.assessments[1].amenities2_desc;
		SELF.Curr_assess_amenities3_desc := l.assessments[1].amenities3_desc;
		SELF.Curr_assess_amenities4_desc := l.assessments[1].amenities4_desc;
		SELF.Curr_assess_amenities5_desc := l.assessments[1].amenities5_desc;

		SELF.Curr_assess_other_buildings1_desc := l.assessments[1].other_buildings1_desc;
		SELF.Curr_assess_other_buildings2_desc := l.assessments[1].other_buildings2_desc;
		SELF.Curr_assess_other_buildings3_desc := l.assessments[1].other_buildings3_desc;
		SELF.Curr_assess_other_buildings4_desc := l.assessments[1].other_buildings4_desc;
		SELF.Curr_assess_other_buildings5_desc := l.assessments[1].other_buildings5_desc;

		SELF.Curr_assess_condo_project_name := l.assessments[1].condo_project_name;
		SELF.Curr_assess_building_name := l.assessments[1].building_name;
		SELF.Curr_assess_comments := l.assessments[1].comments;

		SELF.Curr_assess_neighborhood_code := l.assessments[1].neighborhood_code;

		// fares info

		SELF.Curr_assess_no_of_full_baths := l.assessments[1].fares_no_of_full_baths;
		SELF.Curr_assess_no_of_half_baths := l.assessments[1].fares_no_of_half_baths;
		SELF.Curr_assess_sewer_desc := l.assessments[1].fares_sewer_desc;
		SELF.Curr_assess_water_desc := l.assessments[1].fares_water_desc;
		
		SELF := l;
		SELF := []; // deed info is blank on assessment records
	
	END;
	
	export BenefitAssessment_Services.Layouts.prop_flat_Prior_rec MakeSellerDeedFlat(BenefitAssessment_Services.Layouts.rec_propOutWithAcctno l) := TRANSFORM
		SELF.Prior_Record_Type := if(l.ln_fares_id[2] = LN_PropertyV2_Services.consts.FID_TYPE_DEED, LN_PropertyV2_Services.consts.TYPE_DEED, LN_PropertyV2_Services.consts.TYPE_MORTGAGE);		
		first_addr_row := l.parties(party_type = 'P')[1];	
		SELF.ln_fares_id := l.ln_fares_id;
		SELF.Prior_sortby_date := l.sortby_date;
	
		s_first_name_row := l.parties(party_type = 'S').entity[1];
		s_second_name_row := l.parties(party_type = 'S').entity[2];
		SELF.Prior_Seller_name1 := NameFromComponents(s_first_name_row.fname, s_first_name_row.mname, s_first_name_row.lname,
				s_first_name_row.name_suffix, s_first_name_row.cname); 
		SELF.Prior_Seller_name2 := NameFromComponents(s_second_name_row.fname, s_second_name_row.mname, s_second_name_row.lname,
				s_second_name_row.name_suffix, s_second_name_row.cname);
		SELF.ofname1 := s_first_name_row.fname;
		SELF.olname1:= s_first_name_row.lname;
		SELF.ofname2 := s_second_name_row.fname;
		SELF.olname2:= s_second_name_row.lname;	
		SELF.ossn1 := s_first_name_row.app_ssn;
		SELF.ossn2:= s_second_name_row.app_ssn;
		SELF.Prior_Sale_Date := '';
		SELF.Prior_Total_Value := ''; 
		SELF.Prior_Sale_Amount := l.deeds[1].sales_price;
		SELF.Prior_Assess_Value := '';
		SELF.Prior_Market_Value := '';
		SELF.Prior_Mortgage_amount := '';
		SELF.Prior_Total_Property_Value := if(l.deeds[1].sales_price = '0', '', l.deeds[1].sales_price);
		SELF.Prior_recording_date := l.deeds[1].recording_date;
		SELF.Prior_Tax_Year := '';//no deed value
		SELF.Prior_Land_Usage := l.deeds[1].property_use_desc;
		SELF.Prior_Document_Type := l.deeds[1].document_type_desc; 
		SELF.Prior_Property_Owned_OOS := '';
		SELF.Recent_Property_Transfer := '';
		SELF.Prior_current_record := l.current_record;
		
		// The code below is mostly copied from BatchServices.xfm_Property_make_flat.
		property_party := l.parties(StringLib.StringToUpperCase(party_type_name) = BenefitAssessment_Services.Constants.PROPERTY)[1];
		buyer_party    := l.parties(StringLib.StringToUpperCase(party_type_name) = BenefitAssessment_Services.Constants.BUYER)[1];
		seller_party   := l.parties(StringLib.StringToUpperCase(party_type_name) = BenefitAssessment_Services.Constants.SELLER )[1];
		owner_party    := l.parties(StringLib.StringToUpperCase(party_type_name) IN [BenefitAssessment_Services.Constants.BUYER, BenefitAssessment_Services.Constants.ASSESSEE])[1];
		// Deed records don't have an assessee party.
		// assessee_party := l.parties(StringLib.StringToUpper(party_type_name) = BenefitAssessment_Services.Constants.ASSESSEE)[1];
		borrower_party := l.parties(StringLib.StringToUpperCase(party_type_name) = BenefitAssessment_Services.Constants.BORROWER)[1];
		
		SELF.Prior_Property_address 				:= Address.Addr1FromComponents(property_party.prim_range, property_party.predir, property_party.prim_name,
																						property_party.suffix, property_party.postdir, '', property_party.sec_range);
		SELF.Prior_property_address1         := Address.Addr1FromComponents(property_party.prim_range, property_party.predir, property_party.prim_name,
																						property_party.suffix, property_party.postdir, '', '');
		SELF.Prior_property_address2         := Address.Addr1FromComponents('', '', '','', '', property_party.unit_desig, property_party.sec_range);   
		SELF.Prior_property_v_city_name      := property_party.v_city_name;    
		SELF.Prior_Property_p_city_name 		 := property_party.p_city_name;    
		SELF.Prior_Property_St    					 := property_party.st;
		SELF.Prior_property_zip              := property_party.zip;            
		SELF.Prior_property_zip4             := property_party.zip4;           
		SELF.Prior_property_county_name      := property_party.county_name;    
		SELF.Prior_property_geo_lat          := property_party.geo_lat;        
		SELF.Prior_property_geo_long         := property_party.geo_long;       
		SELF.Prior_property_msa              := property_party.msa;    
		SELF.Prior_property_orig_address     := property_party.orig_addr;
		SELF.Prior_property_orig_unit        := property_party.orig_unit;
		SELF.Prior_property_orig_csz         := property_party.orig_csz;	;
		
		SELF.Prior_buyer_address1         := Address.Addr1FromComponents(buyer_party.prim_range, buyer_party.predir, buyer_party.prim_name,
		                                     buyer_party.suffix, buyer_party.postdir, '', '');
		SELF.Prior_buyer_address2         := Address.Addr1FromComponents('', '', '','', '', buyer_party.unit_desig, buyer_party.sec_range);
		SELF.Prior_buyer_p_city_name      := buyer_party.p_city_name;    
		SELF.Prior_buyer_v_city_name      := buyer_party.v_city_name;    
		SELF.Prior_buyer_st               := buyer_party.st;             
		SELF.Prior_buyer_zip              := buyer_party.zip;            
		SELF.Prior_buyer_zip4             := buyer_party.zip4;           
		SELF.Prior_buyer_county_name      := buyer_party.county_name;    
		SELF.Prior_buyer_geo_lat          := buyer_party.geo_lat;        
		SELF.Prior_buyer_geo_long         := buyer_party.geo_long;       
		SELF.Prior_buyer_msa              := buyer_party.msa;    
		SELF.Prior_buyer_orig_address     := buyer_party.orig_addr;
		SELF.Prior_buyer_orig_unit        := buyer_party.orig_unit;
		SELF.Prior_buyer_orig_csz         := buyer_party.orig_csz;
		SELF.Prior_buyer_phone_number     := buyer_party.phone_number;   	
		SELF.Prior_buyer_vesting_desc     := l.deeds[1].buyer_vesting_desc;
		
		SELF.Prior_buyer_1_orig_name      := StringLib.StringCleanSpaces(buyer_party.orig_names[1].orig_name);
		SELF.Prior_buyer_1_id_desc        := l.deeds[1].buyer1_id_desc;
		SELF.Prior_buyer_1_title          := buyer_party.entity[1].title;     
		SELF.Prior_buyer_1_first_name     := buyer_party.entity[1].fname;     
		SELF.Prior_buyer_1_middle_name    := buyer_party.entity[1].mname;     
		SELF.Prior_buyer_1_last_name      := buyer_party.entity[1].lname;      
		SELF.Prior_buyer_1_name_suffix    := buyer_party.entity[1].name_suffix;
		SELF.Prior_buyer_1_company_name   := buyer_party.entity[1].cname;     
		SELF.Prior_buyer_1_did            := buyer_party.entity[1].did;       
		SELF.Prior_buyer_1_bdid           := buyer_party.entity[1].bdid;       
		SELF.Prior_buyer_1_ssn            := buyer_party.entity[1].app_ssn;       
	
		SELF.Prior_buyer_2_orig_name      := StringLib.StringCleanSpaces(buyer_party.orig_names[2].orig_name);   
		SELF.Prior_buyer_2_id_desc        := l.deeds[1].buyer2_id_desc;
		SELF.Prior_buyer_2_title          := buyer_party.entity[2].title;     
		SELF.Prior_buyer_2_first_name     := buyer_party.entity[2].fname;     
		SELF.Prior_buyer_2_middle_name    := buyer_party.entity[2].mname;     
		SELF.Prior_buyer_2_last_name      := buyer_party.entity[2].lname;      
		SELF.Prior_buyer_2_name_suffix    := buyer_party.entity[2].name_suffix;
		SELF.Prior_buyer_2_company_name   := buyer_party.entity[2].cname;     
		SELF.Prior_buyer_2_did            := buyer_party.entity[2].did;       
		SELF.Prior_buyer_2_bdid           := buyer_party.entity[2].bdid;       
		SELF.Prior_buyer_2_ssn            := buyer_party.entity[2].app_ssn;    	
		
		SELF.Prior_seller_address1         := Address.Addr1FromComponents(seller_party.prim_range, seller_party.predir, seller_party.prim_name,
		                                     seller_party.suffix, seller_party.postdir, '', '');
		SELF.Prior_seller_address2         := Address.Addr1FromComponents('', '', '','', '', seller_party.unit_desig, seller_party.sec_range);
		SELF.Prior_seller_p_city_name     := seller_party.p_city_name;    
		SELF.Prior_seller_v_city_name      := seller_party.v_city_name;    
		SELF.Prior_seller_st               := seller_party.st;             
		SELF.Prior_seller_zip              := seller_party.zip;            
		SELF.Prior_seller_zip4             := seller_party.zip4;           
		SELF.Prior_seller_county_name      := seller_party.county_name;    
		SELF.Prior_seller_geo_lat          := seller_party.geo_lat;        
		SELF.Prior_seller_geo_long         := seller_party.geo_long;       
		SELF.Prior_seller_msa              := seller_party.msa;    
		SELF.Prior_seller_orig_address     := seller_party.orig_addr;
		SELF.Prior_seller_orig_unit        := seller_party.orig_unit;
		SELF.Prior_seller_orig_csz         := seller_party.orig_csz;
		SELF.Prior_seller_phone_number     := seller_party.phone_number;   	
		
		SELF.Prior_seller_1_orig_name      := StringLib.StringCleanSpaces(seller_party.orig_names[1].orig_name);
		SELF.Prior_seller_1_id_desc        := l.deeds[1].seller1_id_desc;
		SELF.Prior_seller_1_title          := seller_party.entity[1].title;     
		SELF.Prior_seller_1_first_name     := seller_party.entity[1].fname;     
		SELF.Prior_seller_1_middle_name    := seller_party.entity[1].mname;     
		SELF.Prior_seller_1_last_name      := seller_party.entity[1].lname;      
		SELF.Prior_seller_1_name_suffix    := seller_party.entity[1].name_suffix;
		SELF.Prior_seller_1_company_name   := seller_party.entity[1].cname;     
		SELF.Prior_seller_1_did            := seller_party.entity[1].did;       
		SELF.Prior_seller_1_bdid           := seller_party.entity[1].bdid;       
		SELF.Prior_seller_1_ssn            := seller_party.entity[1].app_ssn;       
	
		SELF.Prior_seller_2_orig_name      := StringLib.StringCleanSpaces(seller_party.orig_names[2].orig_name);   
		SELF.Prior_seller_2_id_desc        := l.deeds[1].seller2_id_desc;
		SELF.Prior_seller_2_title          := seller_party.entity[2].title;     
		SELF.Prior_seller_2_first_name     := seller_party.entity[2].fname;     
		SELF.Prior_seller_2_middle_name    := seller_party.entity[2].mname;     
		SELF.Prior_seller_2_last_name      := seller_party.entity[2].lname;      
		SELF.Prior_seller_2_name_suffix    := seller_party.entity[2].name_suffix;
		SELF.Prior_seller_2_company_name   := seller_party.entity[2].cname;     
		SELF.Prior_seller_2_did            := seller_party.entity[2].did;       
		SELF.Prior_seller_2_bdid           := seller_party.entity[2].bdid;       
		SELF.Prior_seller_2_ssn            := seller_party.entity[2].app_ssn;  
		
		o_first_name_row := owner_party.entity[1];
		o_second_name_row := owner_party.entity[2];
		SELF.Prior_Owner_name1 := NameFromComponents(o_first_name_row.fname, o_first_name_row.mname, o_first_name_row.lname,
				o_first_name_row.name_suffix, o_first_name_row.cname); 
		SELF.Prior_Owner_name2 := NameFromComponents(s_second_name_row.fname, s_second_name_row.mname, o_second_name_row.lname,
				o_second_name_row.name_suffix, o_second_name_row.cname); 
		SELF.Prior_owner_address1         := Address.Addr1FromComponents(owner_party.prim_range, owner_party.predir, owner_party.prim_name,
		                                     owner_party.suffix, owner_party.postdir, '', '');
		SELF.Prior_owner_address2         := Address.Addr1FromComponents('', '', '','', '', owner_party.unit_desig, owner_party.sec_range);
		SELF.Prior_owner_p_city_name      := owner_party.p_city_name;    
		SELF.Prior_owner_v_city_name      := owner_party.v_city_name;    
		SELF.Prior_owner_st               := owner_party.st;             
		SELF.Prior_owner_zip              := owner_party.zip;            
		SELF.Prior_owner_zip4             := owner_party.zip4;           
		SELF.Prior_owner_county_name      := owner_party.county_name;    
		SELF.Prior_owner_geo_lat          := owner_party.geo_lat;        
		SELF.Prior_owner_geo_long         := owner_party.geo_long;       
		SELF.Prior_owner_msa              := owner_party.msa;    
		SELF.Prior_owner_orig_address     := owner_party.orig_addr;
		SELF.Prior_owner_orig_unit        := owner_party.orig_unit;
		SELF.Prior_owner_orig_csz         := owner_party.orig_csz;
		SELF.Prior_owner_phone_number     := owner_party.phone_number;   	
		
		SELF.Prior_owner_1_orig_name      := StringLib.StringCleanSpaces(owner_party.orig_names[1].orig_name);
		SELF.Prior_owner_1_title          := owner_party.entity[1].title;     
		SELF.Prior_owner_1_first_name     := owner_party.entity[1].fname;     
		SELF.Prior_owner_1_middle_name    := owner_party.entity[1].mname;     
		SELF.Prior_owner_1_last_name      := owner_party.entity[1].lname;      
		SELF.Prior_owner_1_name_suffix    := owner_party.entity[1].name_suffix;
		SELF.Prior_owner_1_company_name   := owner_party.entity[1].cname;     
		SELF.Prior_owner_1_did            := owner_party.entity[1].did;       
		SELF.Prior_owner_1_bdid           := owner_party.entity[1].bdid;       
		SELF.Prior_owner_1_ssn            := owner_party.entity[1].app_ssn;       
	
		SELF.Prior_owner_2_orig_name      := StringLib.StringCleanSpaces(owner_party.orig_names[2].orig_name);   
		SELF.Prior_owner_2_title          := owner_party.entity[2].title;     
		SELF.Prior_owner_2_first_name     := owner_party.entity[2].fname;     
		SELF.Prior_owner_2_middle_name    := owner_party.entity[2].mname;     
		SELF.Prior_owner_2_last_name      := owner_party.entity[2].lname;      
		SELF.Prior_owner_2_name_suffix    := owner_party.entity[2].name_suffix;
		SELF.Prior_owner_2_company_name   := owner_party.entity[2].cname;     
		SELF.Prior_owner_2_did            := owner_party.entity[2].did;       
		SELF.Prior_owner_2_bdid           := owner_party.entity[2].bdid;       
		SELF.Prior_owner_2_ssn            := owner_party.entity[2].app_ssn;  
				
		SELF.Prior_borrower_address1         := Address.Addr1FromComponents(borrower_party.prim_range, borrower_party.predir, borrower_party.prim_name,
		                                     borrower_party.suffix,borrower_party.postdir, '', '');
		SELF.Prior_borrower_address2         := Address.Addr1FromComponents('', '', '','', '', borrower_party.unit_desig,borrower_party.sec_range);
		SELF.Prior_borrower_p_city_name      := borrower_party.p_city_name;    
		SELF.Prior_borrower_v_city_name      := borrower_party.v_city_name;    
		SELF.Prior_borrower_st               := borrower_party.st;             
		SELF.Prior_borrower_zip              := borrower_party.zip;            
		SELF.Prior_borrower_zip4             := borrower_party.zip4;           
		SELF.Prior_borrower_county_name      := borrower_party.county_name;    
		SELF.Prior_borrower_geo_lat          := borrower_party.geo_lat;        
		SELF.Prior_borrower_geo_long         := borrower_party.geo_long;       
		SELF.Prior_borrower_msa              := borrower_party.msa;    
		SELF.Prior_borrower_orig_address     := borrower_party.orig_addr;
		SELF.Prior_borrower_orig_unit        := borrower_party.orig_unit;
		SELF.Prior_borrower_orig_csz         := borrower_party.orig_csz;
		SELF.Prior_borrower_phone_number     := borrower_party.phone_number;   	
		SELF.Prior_borrower_vesting_desc     := l.deeds[1].borrower_vesting_desc;
		
		SELF.Prior_borrower_1_orig_name      := StringLib.StringCleanSpaces(borrower_party.orig_names[1].orig_name);
		SELF.Prior_borrower_1_id_desc        := l.deeds[1].borrower1_id_desc;
		SELF.Prior_borrower_1_title          := borrower_party.entity[1].title;     
		SELF.Prior_borrower_1_first_name     := borrower_party.entity[1].fname;     
		SELF.Prior_borrower_1_middle_name    := borrower_party.entity[1].mname;     
		SELF.Prior_borrower_1_last_name      := borrower_party.entity[1].lname;      
		SELF.Prior_borrower_1_name_suffix    := borrower_party.entity[1].name_suffix;
		SELF.Prior_borrower_1_company_name   := borrower_party.entity[1].cname;     
		SELF.Prior_borrower_1_did            := borrower_party.entity[1].did;       
		SELF.Prior_borrower_1_bdid           := borrower_party.entity[1].bdid;       
		SELF.Prior_borrower_1_ssn            := borrower_party.entity[1].app_ssn;       
	  
		SELF.Prior_borrower_2_orig_name      := StringLib.StringCleanSpaces(borrower_party.orig_names[2].orig_name);   
		SELF.Prior_borrower_2_id_desc        := l.deeds[1].borrower2_id_desc;
		SELF.Prior_borrower_2_title          := borrower_party.entity[2].title;     
		SELF.Prior_borrower_2_first_name     := borrower_party.entity[2].fname;     
		SELF.Prior_borrower_2_middle_name    := borrower_party.entity[2].mname;     
		SELF.Prior_borrower_2_last_name      := borrower_party.entity[2].lname;      
		SELF.Prior_borrower_2_name_suffix    := borrower_party.entity[2].name_suffix;
		SELF.Prior_borrower_2_company_name   := borrower_party.entity[2].cname;     
		SELF.Prior_borrower_2_did            := borrower_party.entity[2].did;       
		SELF.Prior_borrower_2_bdid           := borrower_party.entity[2].bdid;       
		SELF.Prior_borrower_2_ssn            := borrower_party.entity[2].app_ssn;  
		
		// filing info
		
		SELF.Prior_deed_state := l.deeds[1].state;
		SELF.Prior_deed_county_name := l.deeds[1].county_name;
		SELF.Prior_deed_apnt_or_pin_number := l.deeds[1].apnt_or_pin_number;					
		SELF.Prior_deed_fips_code := l.deeds[1].fips_code;
		SELF.Prior_deed_record_type := l.deeds[1].record_type;
		SELF.Prior_deed_record_type_desc := l.deeds[1].record_type_desc;
		SELF.Prior_deed_multi_apn_flag := l.deeds[1].multi_apn_flag;					
		SELF.Prior_deed_buyer_addendum_flag := l.deeds[1].buyer_addendum_flag;
		SELF.Prior_deed_seller_addendum_flag := l.deeds[1].seller_addendum_flag;		
		
		// lender info
		
		SELF.Prior_deed_lender_name := l.deeds[1].lender_name;					
		SELF.Prior_deed_lender_name_id := l.deeds[1].lender_name_id;
		SELF.Prior_deed_lender_dba_aka_name := l.deeds[1].lender_dba_aka_name;
		SELF.Prior_deed_tax_id_number := l.deeds[1].tax_id_number;
		
		// phone info
		
		SELF.Prior_deed_phone_number := l.deeds[1].phone_number;
		
		// propertyAddress info
		
		SELF.Prior_deed_property_address_code := l.deeds[1].property_address_code;
		SELF.Prior_deed_property_address_desc := l.deeds[1].property_address_desc;		
		SELF.Prior_deed_lender_full_street_address := l.deeds[1].lender_full_street_address;
		SELF.Prior_deed_lender_address_unit_number := l.deeds[1].lender_address_unit_number;
		SELF.Prior_deed_lender_address_citystatezip := l.deeds[1].lender_address_citystatezip;	
		
		// legal info	
		
		SELF.Prior_deed_legal_brief_description := l.deeds[1].legal_brief_description;
		SELF.Prior_deed_contract_date := l.deeds[1].contract_date;
		SELF.Prior_deed_recording_date := l.deeds[1].recording_date;
		SELF.Prior_deed_document_type_code := l.deeds[1].document_type_code;
		SELF.Prior_deed_document_type_desc := l.deeds[1].document_type_desc;					
		SELF.Prior_deed_arm_reset_date := l.deeds[1].arm_reset_date;
		SELF.Prior_deed_document_number := l.deeds[1].document_number;
		SELF.Prior_deed_recorder_book_number := l.deeds[1].recorder_book_number;
		SELF.Prior_deed_recorder_page_number := l.deeds[1].recorder_page_number;
		SELF.Prior_deed_land_lot_size := l.deeds[1].land_lot_size;
		SELF.Prior_deed_legal_lot_desc := l.deeds[1].legal_lot_desc;
		SELF.Prior_deed_legal_lot_number := l.deeds[1].legal_lot_number;
		SELF.Prior_deed_legal_block := l.deeds[1].legal_block;
		SELF.Prior_deed_legal_section := l.deeds[1].legal_section;
		SELF.Prior_deed_legal_district := l.deeds[1].legal_district;
		SELF.Prior_deed_legal_land_lot := l.deeds[1].legal_land_lot;
		SELF.Prior_deed_legal_unit := l.deeds[1].legal_unit;
		SELF.Prior_deed_legal_city_municipality_township := l.deeds[1].legal_city_municipality_township;
		SELF.Prior_deed_legal_subdivision_name := l.deeds[1].legal_subdivision_name;
		SELF.Prior_deed_legal_phase_number := l.deeds[1].legal_phase_number;
		SELF.Prior_deed_legal_tract_number := l.deeds[1].legal_tract_number;
		SELF.Prior_deed_legal_sec_twn_rng_mer := l.deeds[1].legal_sec_twn_rng_mer;
		SELF.Prior_deed_recorder_map_reference := l.deeds[1].recorder_map_reference;
		SELF.Prior_deed_complete_legal_description_code := l.deeds[1].complete_legal_description_code;
		SELF.Prior_deed_loan_number := l.deeds[1].loan_number;
		SELF.Prior_deed_concurrent_mortgage_book_page_document_number := l.deeds[1].concurrent_mortgage_book_page_document_number;
		SELF.Prior_deed_hawaii_tct := l.deeds[1].hawaii_tct;
		SELF.Prior_deed_hawaii_condo_cpr_code := l.deeds[1].hawaii_condo_cpr_code;
		SELF.Prior_deed_hawaii_condo_name := l.deeds[1].hawaii_condo_name;
		SELF.Prior_deed_filler_except_hawaii := l.deeds[1].filler_except_hawaii;		
		
		// sales info
		
		SELF.Prior_deed_sales_price := l.deeds[1].sales_price;
		SELF.Prior_deed_sales_price_desc := l.deeds[1].sales_price_desc;
		SELF.Prior_deed_city_transfer_tax := l.deeds[1].city_transfer_tax;
		SELF.Prior_deed_county_transfer_tax := l.deeds[1].county_transfer_tax;
		SELF.Prior_deed_total_transfer_tax := l.deeds[1].total_transfer_tax;
		SELF.Prior_deed_excise_tax_number := l.deeds[1].excise_tax_number;	
		
		// property info
		
		SELF.Prior_deed_property_use_desc := l.deeds[1].property_use_desc;
		SELF.Prior_deed_assessment_match_land_use_desc := l.deeds[1].assessment_match_land_use_desc;
		SELF.Prior_deed_condo_desc := l.deeds[1].condo_desc;
		SELF.Prior_deed_timeshare_flag := l.deeds[1].timeshare_flag;			
			
		// mortgage info
		
		SELF.Prior_deed_first_td_loan_amount := l.deeds[1].first_td_loan_amount;					
		SELF.Prior_deed_first_td_loan_type_desc := l.deeds[1].first_td_loan_type_desc;
		SELF.Prior_deed_type_financing := l.deeds[1].type_financing;
		SELF.Prior_deed_type_financing_desc := l.deeds[1].type_financing_desc;
		SELF.Prior_deed_first_td_interest_rate := l.deeds[1].first_td_interest_rate;
		SELF.Prior_deed_first_td_due_date := l.deeds[1].first_td_due_date;
		SELF.Prior_deed_title_company_name := l.deeds[1].title_company_name;
		SELF.Prior_deed_rate_change_frequency := l.deeds[1].rate_change_frequency;
		SELF.Prior_deed_rate_change_frequency_desc := l.deeds[1].rate_change_frequency_desc;
		SELF.Prior_deed_change_index := l.deeds[1].change_index;
		SELF.Prior_deed_adjustable_rate_index := l.deeds[1].adjustable_rate_index;
		SELF.Prior_deed_adjustable_rate_index_desc := l.deeds[1].adjustable_rate_index_desc;
		SELF.Prior_deed_adjustable_rate_rider := l.deeds[1].adjustable_rate_rider;
		SELF.Prior_deed_graduated_payment_rider := l.deeds[1].graduated_payment_rider;
		SELF.Prior_deed_balloon_rider := l.deeds[1].balloon_rider;
		SELF.Prior_deed_fixed_step_rate_rider := l.deeds[1].fixed_step_rate_rider;
		SELF.Prior_deed_fixed_step_rate_rider_desc := l.deeds[1].fixed_step_rate_rider_desc;
		SELF.Prior_deed_condominium_rider := l.deeds[1].condominium_rider;
		SELF.Prior_deed_planned_unit_development_rider := l.deeds[1].planned_unit_development_rider;
		SELF.Prior_deed_rate_improvement_rider := l.deeds[1].rate_improvement_rider;
		SELF.Prior_deed_assumability_rider := l.deeds[1].assumability_rider;
		SELF.Prior_deed_prepayment_rider := l.deeds[1].prepayment_rider;
		SELF.Prior_deed_one_four_family_rider := l.deeds[1].one_four_family_rider;
		SELF.Prior_deed_biweekly_payment_rider := l.deeds[1].biweekly_payment_rider;
		SELF.Prior_deed_second_home_rider := l.deeds[1].second_home_rider;
		SELF.Prior_deed_second_td_loan_amount := l.deeds[1].second_td_loan_amount;
		SELF.Prior_deed_first_td_lender_type_desc := l.deeds[1].first_td_lender_type_desc;
		SELF.Prior_deed_second_td_lender_type_desc := l.deeds[1].second_td_lender_type_desc;
		SELF.Prior_deed_partial_interest_transferred := l.deeds[1].partial_interest_transferred;
		SELF.Prior_deed_loan_term_months := l.deeds[1].loan_term_months;
		SELF.Prior_deed_loan_term_years := l.deeds[1].loan_term_years;			
		
		// addl fares info
		
		SELF.Prior_deed_transaction_type_desc := l.deeds[1].fares_transaction_type_desc;
		SELF.Prior_deed_lender_address := l.deeds[1].fares_lender_address;;	
		
		SELF := l;
		SELF := [] // no assessment data on deed records
	END;		
		
	export CriminalRecords_BatchService.Layouts.batch_in MakeCrimDerogInput(BenefitAssessment_Services.Layouts.temp_cumulative_rec l) := TRANSFORM
			SELF.name_first := l.Input_Name_First;
			SELF.name_middle := l.Input_Name_Middle;
			SELF.name_last := l.Input_Name_Last;
			SELF.prim_range := l.Input_Prim_Range;
			SELF.predir := l.Input_predir;
			SELF.prim_name := l.Input_Prim_Name;
			SELF.addr_suffix := l.Input_addr_suffix;
			SELF.postdir := l.Input_postdir;
			SELF.unit_desig := l.Input_unit_desig;
			SELF.sec_range := l.Input_Sec_Range;
			SELF.p_city_name := l.Input_p_city_name;
			SELF.st := l.Input_st;
			SELF.z5 := l.Input_z5;
			SELF.ssn := l.Input_ssn;
			SELF.dob := l.Input_dob;									
			SELF := l; 
		END;			

			export BenefitAssessment_Services.Layouts.temp_cumulative_rec SetCrimDerogHits(BenefitAssessment_Services.Layouts.temp_cumulative_rec l, 
				CriminalRecords_BatchService.Layouts.batch_out r) := TRANSFORM,
				 		SKIP(~(l.Input_ssn = r.ssn AND 
						l.Input_Name_Last = r.lname AND
						l.Input_Name_First = r.fname AND 
						ut.NNEQ_Int(l.Input_dob[1..4], r.dob [1..4])))
				SELF.CRIM_Flag := if(r.off_typ_1 = 'F' OR r.off_typ_1 = 'M', 'Y','N'); 
				SELF.CRIM_doc_num := r.doc_num;
				SELF.CRIM_lname := r.lname;
				SELF.CRIM_fname := r.fname;
				SELF.CRIM_mname := r.mname;
				SELF.CRIM_ssn := r.ssn;
				SELF.CRIM_dob := r.dob;
				SELF.CRIM_prim_range := r.prim_range;
				SELF.CRIM_predir := r.predir;
				SELF.CRIM_prim_name := r.prim_name;
				SELF.CRIM_addr_suffix := r.addr_suffix;
				SELF.CRIM_postdir := r.postdir;
				SELF.CRIM_unit_desig := r.unit_desig;
				SELF.CRIM_sec_range := r.sec_range;
				SELF.CRIM_p_city_name := r.p_city_name;
				SELF.CRIM_v_city_name := r.v_city_name;
				SELF.CRIM_st := r.st;
				SELF.CRIM_zip5 := r.zip5;
				SELF.CRIM_zip4 := r.zip4;		
				SELF := r;
				SELF := l;
		END;		
		
		EXPORT BenefitAssessment_Services.Layouts.temp_cumulative_rec AddonCrimDerogHits(
																				BenefitAssessment_Services.Layouts.temp_cumulative_rec l, 
																				BenefitAssessment_Services.Layouts.temp_cumulative_rec r) := TRANSFORM 	
					SELF.CRIM_Flag := r.CRIM_Flag; 
					SELF.CRIM_doc_num := r.CRIM_doc_num;
					SELF.CRIM_lname := r.CRIM_lname;
					SELF.CRIM_fname := r.CRIM_fname;
					SELF.CRIM_mname := r.CRIM_mname;
					SELF.CRIM_ssn := r.CRIM_ssn;
					SELF.CRIM_dob := r.CRIM_dob;
					SELF.CRIM_prim_range := r.CRIM_prim_range;
					SELF.CRIM_predir := r.CRIM_predir;
					SELF.CRIM_prim_name := r.CRIM_prim_name;
					SELF.CRIM_addr_suffix := r.CRIM_addr_suffix;
					SELF.CRIM_postdir := r.CRIM_postdir;
					SELF.CRIM_unit_desig := r.CRIM_unit_desig;
					SELF.CRIM_sec_range := r.CRIM_sec_range;
					SELF.CRIM_p_city_name := r.CRIM_p_city_name;
					SELF.CRIM_v_city_name := r.CRIM_v_city_name;
					SELF.CRIM_st := r.CRIM_st;
					SELF.CRIM_zip5 := r.CRIM_zip5;
					SELF.CRIM_zip4 := r.CRIM_zip4;
					SELF.data_type := r.data_type;
					SELF.state_origin := r.state_origin;
					SELF.case_num_1 := r.case_num_1;
					SELF.court_desc_1 := r.court_desc_1;		
					SELF.off_date_1 := r.off_date_1;
					SELF.off_code_1 := r.off_code_1;
					SELF.chg_1 := r.chg_1;
					SELF.num_of_counts_1 := r.num_of_counts_1;
					SELF.off_desc_1_1 := r.off_desc_1_1;
					SELF.off_desc_2_1 := r.off_desc_2_1;
					SELF.off_typ_1 := r.off_typ_1;
					SELF.off_lev_1 := r.off_lev_1;
					SELF.cty_conv_1 := r.cty_conv_1;
					SELF.stc_dt_1 := r.stc_dt_1;
					SELF := l;			 
		END;				
		
		EXPORT BenefitAssessment_Services.Layouts.Batch_In_Plus MakeIntoPlus(BenefitAssessment_Services.Layouts.Batch_In_Shared l) := TRANSFORM
				SELF.Input_name_first := TRIM(l.name_first, LEFT, RIGHT);
				SELF.Input_name_middle := TRIM(l.name_middle, LEFT, RIGHT);
				SELF.Input_name_last := TRIM(l.name_last, LEFT, RIGHT);
				SELF.Input_prim_range := TRIM(l.prim_range, LEFT, RIGHT);
				SELF.Input_prim_name := TRIM(l.prim_name, LEFT, RIGHT);
				SELF.Input_sec_range := TRIM(l.sec_range, LEFT, RIGHT);
				SELF.Input_predir := TRIM(l.predir, LEFT, RIGHT);
				SELF.Input_addr_suffix := TRIM(l.addr_suffix, LEFT, RIGHT);
				SELF.Input_postdir := TRIM(l.postdir, LEFT, RIGHT);
				SELF.Input_unit_desig := TRIM(l.unit_desig, LEFT, RIGHT);
				SELF.Input_p_city_name := TRIM(l.p_city_name, LEFT, RIGHT);
				SELF.Input_st := TRIM(l.st, LEFT, RIGHT);
				SELF.Input_z5 := TRIM(l.z5, LEFT, RIGHT);
				SELF.Input_ssn := TRIM(l.ssn, LEFT, RIGHT);
				SELF.Input_dob := TRIM(l.dob, LEFT, RIGHT);
				SELF.Input_state := TRIM(l.Input_state, LEFT, RIGHT);
				SELF := l;
				self := [];//all output crim/derog and familycomp fields
		END;
		
		EXPORT BenefitAssessment_Services.Layouts.layout_batch_out MakeNonHits_out(BenefitAssessment_Services.Layouts.Batch_In_Shared l) := TRANSFORM
				SELF.acctno := l.acctno; 
				SELF.err_addr := l.err_addr;
				SELF.err_search := l.err_search;
				SELF.error_code := l.error_code;
				SELF.prim_range := '';
				SELF.prim_name := '';
				SELF.sec_range := '';
				SELF.predir :='';
				SELF.addr_suffix := '';
				SELF.postdir := '';
				SELF.unit_desig := '';
				SELF.p_city_name := '';
				SELF.ssn := '';
				SELF.dob := '';		
				SELF.did := l.did;
				SELF := [];//Since not a hit, we need to set all product output fields to empty
		END;
	
		EXPORT BenefitAssessment_Services.Layouts.layout_batch_out_plus SetBestADLHits(
																			BenefitAssessment_Services.Layouts.layout_batch_out_plus L, 
																			doxie.layout_comp_addresses R) := TRANSFORM
				SELF.acctno := L.Acctno;
				SELF.current_addr_fname := R.fname ;
				SELF.current_addr_mname := R.mname ;
				SELF.current_addr_lname := R.lname;
				SELF.current_addr_suffix :=	R.name_suffix;
				currAddr := Address.Addr1FromComponents(R.prim_range, R.predir, R.prim_name,
		                                     R.suffix, R.postdir, 
																				 '', R.sec_range);
				SELF.current_addr := currAddr;
				SELF.current_addr_city := R.city_name;
				SELF.current_addr_st := R.st;
				SELF.current_addr_zip := R.zip;
				dt_seen := (STRING8) R.dt_first_seen;
				SELF.current_addr_first_seen := if(dt_seen = '0', '', dt_seen);
				dt_lst_seen := (STRING8) R.dt_last_seen;
				SELF.current_addr_last_seen := if(dt_lst_seen = '0', '', dt_lst_seen);
				InputAddrFromCompents := Address.Addr1FromComponents(L.input_prim_range, L.input_predir, L.input_prim_name,
		                                     L.input_addr_suffix, L.input_postdir, 
																				 '', L.input_sec_range);
				InputAddr := if (InputAddrFromCompents <> '', InputAddrFromCompents, l.addr);																 
				current_date := ut.GetDate;	
				//make sure right date last seen is populated as otherwise does current date on 0
				mosAtAddr := if(R.dt_first_seen > 0, ut.MonthsApart(current_date, (STRING8) R.dt_first_seen), 0);
				SELF.Months_at_addr := if(mosAtAddr > 0, (STRING) mosAtAddr, '');				
				SELF.match_input_addr := MAP(R.did = 0 => '',
							InputAddr = '' AND 
								L.Input_p_city_name = '' AND
								L.Input_st = '' AND 
								L.Input_z5 = '' => 'N',							
							currAddr = InputAddr AND 
								R.city_name = L.Input_p_city_name AND
								R.st = L.Input_st AND 
								R.zip = L.Input_z5 => 'Y',
							'N');
				SELF.current_addr_oos := if((L.input_state != '' and R.st = L.Input_State) or R.did = 0, '', 'OOS');
				SELF := L;
			END;	
			

EXPORT BenefitAssessment_Services.layouts.norm_prop_rec  normCurrProperty(BenefitAssessment_Services.layouts.layout_batch_out_seq l, integer c) := transform
    self.seq := l.seq;  //maintain parent sequence number for joining back next
			
	    self.MortgageAmount := case(c,1=>l.curr_Mortgage_Amount1,
  																  2=>l.curr_Mortgage_Amount2,
	   															  3=>l.curr_Mortgage_Amount3,
			   													  4=>l.curr_Mortgage_Amount4,
					  											  5=>l.curr_Mortgage_Amount5,
																    '');
      self.DocumentType := case(c,1=>l.curr_Document_Type1,
						  										2=>l.curr_Document_Type2,
							  									3=>l.curr_Document_Type3,
								  								4=>l.curr_Document_Type4,
									  							5=>l.curr_Document_Type5,
																  '');
      self.PropertyOwnedOOS := case(c,1=>l.current_Property_Owned_OOS1,
										  						  2=>l.current_Property_Owned_OOS2,
											  				  	3=>l.current_Property_Owned_OOS3,
												  		  		4=>l.current_Property_Owned_OOS4,
													    			5=>l.current_Property_Owned_OOS5,
															   	'');
      self.PropertyOwned := case(c,1=>l.current_Property_Owned1,
														  		2=>l.current_Property_Owned2,
															  	3=>l.current_Property_Owned3,
																  4=>l.current_Property_Owned4,
																  5=>l.current_Property_Owned5,
																  '');
			self.RecordType := case(c,1=>l.curr_record_type1,
																2=>l.curr_record_type2,
																3=>l.curr_record_type3,
																4=>l.curr_record_type4,
																5=>l.curr_record_type5,
																'');
			self.SalePrice := case(c,1=>l.Curr_Sale_Amount1,
															 2=>l.Curr_Sale_Amount2,
															 3=>l.Curr_Sale_Amount3,
															 4=>l.Curr_Sale_Amount4,
															 5=>l.Curr_Sale_Amount5,
																'');
			self.TaxYear := (INTEGER)case(c,1=>l.Curr_Tax_Year1,
													 	          2=>l.Curr_Tax_Year2,
														          3=>l.Curr_Tax_Year3,
														          4=>l.Curr_Tax_Year4,
														          5=>l.Curr_Tax_Year5,
														          '');
			self.AssessedValue := case(c,1=>l.Curr_Assess_Value1,
																	 2=>l.Curr_Assess_Value2,
																	 3=>l.Curr_Assess_Value3,
																	 4=>l.Curr_Assess_Value4,
																	 5=>l.Curr_Assess_Value5,
																   '');
			self.TotalValue :=  case(c,1=>l.Curr_Total_Value1,
																		2=>l.Curr_Total_Value2,
																		3=>l.Curr_Total_Value3,
																		4=>l.Curr_Total_Value4,
																		5=>l.Curr_Total_Value5,
																		'');
			self.MarketValue := case(c,1=>l.Curr_Market_Value1,
														 		 2=>l.Curr_Market_Value2,
													  		 3=>l.Curr_Market_Value3,
																 4=>l.Curr_Market_Value4,
																 5=>l.Curr_Market_Value5,
																		'');
			self.TotalPropertyValue := case(c,1=>l.Curr_Total_Property_Value1,
																        2=>l.Curr_Total_Property_Value2,
																        3=>l.Curr_Total_Property_Value3,
																        4=>l.Curr_Total_Property_Value4,
																        5=>l.Curr_Total_Property_Value5,
																        '');
			self.LandUsage :=    case(c,1=>l.Curr_Land_Usage1,
																	2=>l.Curr_Land_Usage2,
																	3=>l.Curr_Land_Usage3,
																	4=>l.Curr_Land_Usage4,
																	5=>l.Curr_Land_Usage5,
																	'');
  		self.SaleDate := case(c,1=>iesp.ECL2ESP.toDatestring8(l.Curr_Sale_Date1),
													 	  2=>iesp.ECL2ESP.toDatestring8(l.Curr_Sale_Date2),
														  3=>iesp.ECL2ESP.toDatestring8(l.Curr_Sale_Date3),
														  4=>iesp.ECL2ESP.toDatestring8(l.Curr_Sale_Date4),
														  5=>iesp.ECL2ESP.toDatestring8(l.Curr_Sale_Date5),
														     iesp.ECL2ESP.toDatestring8('')
																 );
			self.RecordingDate := case(c,1=>iesp.ECL2ESP.toDatestring8(l.Curr_recording_date1),
																	 2=>iesp.ECL2ESP.toDatestring8(l.Curr_recording_date2),
																	 3=>iesp.ECL2ESP.toDatestring8(l.Curr_recording_date3),
																	 4=>iesp.ECL2ESP.toDatestring8(l.Curr_recording_date4),
																	 5=>iesp.ECL2ESP.toDatestring8(l.Curr_recording_date5),
																        iesp.ECL2ESP.toDatestring8('')
																				);
			self.PropertyAddress := case(c,1=>iesp.ECL2ESP.SetAddress('','','','','','','',l.Curr_Property_p_City_name1,l.Curr_Property_St1,l.Curr_Property_Zip1,'','','', l.Curr_Property_address1, '',
																			 stringlib.stringcleanspaces(l.Curr_Property_p_City_name1 +' '+l.Curr_Property_St1+' '+l.Curr_Property_Zip1)),
																     2=>iesp.ECL2ESP.SetAddress('','','','','','','',l.Curr_Property_p_City_name2,l.Curr_Property_St2,l.Curr_Property_Zip2,'','','', l.Curr_Property_address2, '',
	  																	 stringlib.stringcleanspaces(l.Curr_Property_p_City_name2 +' '+l.Curr_Property_St2+' '+l.Curr_Property_Zip2)),
																     3=>iesp.ECL2ESP.SetAddress('','','','','','','',l.Curr_Property_p_City_name3,l.Curr_Property_St3,l.Curr_Property_Zip3,'','','', l.Curr_Property_address3, '',
																			 stringlib.stringcleanspaces(l.Curr_Property_p_City_name3 +' '+l.Curr_Property_St3+' '+l.Curr_Property_Zip3)),
																     4=>iesp.ECL2ESP.SetAddress('','','','','','','',l.Curr_Property_p_City_name4,l.Curr_Property_St4,l.Curr_Property_Zip4,'','','', l.Curr_Property_address4, '',
		  																 stringlib.stringcleanspaces(l.Curr_Property_p_City_name4 +' '+l.Curr_Property_St4+' '+l.Curr_Property_Zip4)),
															       5=>iesp.ECL2ESP.SetAddress('','','','','','','',l.Curr_Property_p_City_name5,l.Curr_Property_St5,l.Curr_Property_Zip5,'','','', l.Curr_Property_address5, '',
																			 stringlib.stringcleanspaces(l.Curr_Property_p_City_name5 +' '+l.Curr_Property_St5+' '+l.Curr_Property_Zip5)),
																        iesp.ECL2ESP.SetAddress('','','','','','','','','','','','','', '', '',''));
	   // 5 sets of sellers 1 & 2 and 5 sets of owners 1 & 2
	   self.sellers := case(c,1=> dataset([{l.Curr_Seller_Name11},{l.Curr_Seller_Name21}],iesp.share.t_StringArrayItem),
														2=> dataset([{l.Curr_Seller_Name12},{l.Curr_Seller_Name22}],iesp.share.t_StringArrayItem),
														3=> dataset([{l.Curr_Seller_Name13},{l.Curr_Seller_Name23}],iesp.share.t_StringArrayItem),
														4=> dataset([{l.Curr_Seller_Name14},{l.Curr_Seller_Name24}],iesp.share.t_StringArrayItem),
														5=> dataset([{l.Curr_Seller_Name15},{l.Curr_Seller_Name25}],iesp.share.t_StringArrayItem)
		                     );//end case
		 self.owners :=  case(c,1=> dataset([{l.Curr_Owner_Name11},{l.Curr_Owner_Name21}],iesp.share.t_StringArrayItem),
														2=> dataset([{l.Curr_Owner_Name12},{l.Curr_Owner_Name22}],iesp.share.t_StringArrayItem),
														3=> dataset([{l.Curr_Owner_Name13},{l.Curr_Owner_Name23}],iesp.share.t_StringArrayItem),
														4=> dataset([{l.Curr_Owner_Name14},{l.Curr_Owner_Name24}],iesp.share.t_StringArrayItem),
														5=> dataset([{l.Curr_Owner_Name15},{l.Curr_Owner_Name25}],iesp.share.t_StringArrayItem)
		                     );//end case                                       |
     self.sellers2.names := case(c,1=> if (l.Curr_Seller_Name11 <>'' or l.Curr_Seller_Name21 <> '',
		                                        dataset([{l.Curr_Seller_Name11,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Curr_Seller_Name21,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)), 
											             2=> if (l.Curr_Seller_Name12 <>'' or l.Curr_Seller_Name22 <> '',
		                                        dataset([{l.Curr_Seller_Name12,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Curr_Seller_Name22,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)), 
																	 3=> if (l.Curr_Seller_Name13 <>'' or l.Curr_Seller_Name23 <> '',
		                                        dataset([{l.Curr_Seller_Name13,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Curr_Seller_Name23,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)),
																	 4=> if (l.Curr_Seller_Name14 <>'' or l.Curr_Seller_Name24 <> '',
		                                        dataset([{l.Curr_Seller_Name14,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Curr_Seller_Name24,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)), 
																	 5=> if (l.Curr_Seller_Name15 <>'' or l.Curr_Seller_Name25 <> '',
		                                        dataset([{l.Curr_Seller_Name15,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Curr_Seller_Name25,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name))); 						
		 self.owners2.names :=  case(c,1=> if (l.Curr_Owner_Name11 <>'' or l.Curr_Owner_Name21 <> '',
		                                        dataset([{l.Curr_Owner_Name11,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Curr_Owner_Name21,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)), 
											             2=> if (l.Curr_Owner_Name12 <>'' or l.Curr_Owner_Name22 <> '',
		                                        dataset([{l.Curr_Owner_Name12,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Curr_Owner_Name22,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)), 
																	 3=> if (l.Curr_Owner_Name13 <>'' or l.Curr_Owner_Name23 <> '',
		                                        dataset([{l.Curr_Owner_Name13,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Curr_Owner_Name23,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)),
																	 4=> if (l.Curr_Owner_Name14 <>'' or l.Curr_Owner_Name24 <> '',
		                                        dataset([{l.Curr_Owner_Name14,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Curr_Owner_Name24,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)), 
																	 5=> if (l.Curr_Owner_Name15 <>'' or l.Curr_Owner_Name25 <> '',
		                                        dataset([{l.Curr_Owner_Name15,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Curr_Owner_Name25,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name))); 				
		            	SELF := [];
  END;


EXPORT BenefitAssessment_Services.layouts.norm_prop_rec  normPriorProperty(BenefitAssessment_Services.layouts.layout_batch_out_seq l, integer c) := transform
      self.seq := l.seq;  //maintain parent sequence number for joining back next
			self.MortgageAmount := case(c,1=>l.Prior_Mortgage_Amount1,
  																  2=>l.Prior_Mortgage_Amount2,
	   															  3=>l.Prior_Mortgage_Amount3,
			   												  	4=>l.Prior_Mortgage_Amount4,
					  											  5=>l.Prior_Mortgage_Amount5,
																    '');
      self.DocumentType := case(c,1=>l.Prior_Document_Type1,
						  										2=>l.Prior_Document_Type2,
							  									3=>l.Prior_Document_Type3,
								  								4=>l.Prior_Document_Type4,
									  							5=>l.Prior_Document_Type5,
																  '');
      self.PropertyOwnedOOS := case(c,1=>l.Prior_Property_Owned_OOS1,
										  						    2=>l.Prior_Property_Owned_OOS2,
											  				  	  3=>l.Prior_Property_Owned_OOS3,
												  		  	  	4=>l.Prior_Property_Owned_OOS4,
													    		  	5=>l.Prior_Property_Owned_OOS5,
															     	'');
    
			self.RecentPropertyTransfer := case(c,1=>l.Recent_Property_Transfer1,
																            2=>l.Recent_Property_Transfer2,
																            3=>l.Recent_Property_Transfer3,
																            4=>l.Recent_Property_Transfer4,
																            5=>l.Recent_Property_Transfer5,
																           '');
			self.RecordType := case(c,1=>l.Prior_record_type1,
																2=>l.Prior_record_type2,
																3=>l.Prior_record_type3,
																4=>l.Prior_record_type4,
																5=>l.Prior_record_type5,
																'');
			self.SalePrice := case(c,1=>l.Prior_Sale_Amount1,
															 2=>l.Prior_Sale_Amount2,
															 3=>l.Prior_Sale_Amount3,
															 4=>l.Prior_Sale_Amount4,
															 5=>l.Prior_Sale_Amount5,
																'');
			self.TaxYear := (integer)case(c,1=>l.Prior_Tax_Year1,
													 	          2=>l.Prior_Tax_Year2,
														          3=>l.Prior_Tax_Year3,
														          4=>l.Prior_Tax_Year4,
														          5=>l.Prior_Tax_Year5,
														         '');
			self.AssessedValue := case(c,1=>l.Prior_Assess_Value1,
																	 2=>l.Prior_Assess_Value2,
																	 3=>l.Prior_Assess_Value3,
																	 4=>l.Prior_Assess_Value4,
																	 5=>l.Prior_Assess_Value5,
																   '');
			self.TotalValue :=  case(c,1=>l.Prior_Total_Value1,
																		2=>l.Prior_Total_Value2,
																		3=>l.Prior_Total_Value3,
																		4=>l.Prior_Total_Value4,
																		5=>l.Prior_Total_Value5,
																		'');
			self.MarketValue :=  case(c,1=>l.Prior_Market_Value1,
																		 2=>l.Prior_Market_Value2,
																		 3=>l.Prior_Market_Value3,
																		 4=>l.Prior_Market_Value4,
																		 5=>l.Prior_Market_Value5,
																		'');
			self.TotalPropertyValue := case(c,1=>l.Prior_Total_Property_Value1,
																				2=>l.Prior_Total_Property_Value2,
																				3=>l.Prior_Total_Property_Value3,
																				4=>l.Prior_Total_Property_Value4,
																				5=>l.Prior_Total_Property_Value5,
																				'');
			self.LandUsage :=  case(c,1=>l.Prior_Land_Usage1,
																	 2=>l.Prior_Land_Usage2,
																	 3=>l.Prior_Land_Usage3,
																	 4=>l.Prior_Land_Usage4,
																	 5=>l.Prior_Land_Usage5,
																	'');
  		self.SaleDate := case(c,1=>iesp.ECL2ESP.toDatestring8(l.Prior_Sale_Date1),
													 	  2=>iesp.ECL2ESP.toDatestring8(l.Prior_Sale_Date2),
														  3=>iesp.ECL2ESP.toDatestring8(l.Prior_Sale_Date3),
														  4=>iesp.ECL2ESP.toDatestring8(l.Prior_Sale_Date4),
														  5=>iesp.ECL2ESP.toDatestring8(l.Prior_Sale_Date5),
														  iesp.ECL2ESP.toDatestring8(''));
			self.RecordingDate := case(c,1=>iesp.ECL2ESP.toDatestring8(l.Prior_recording_date1),
																	 2=>iesp.ECL2ESP.toDatestring8(l.Prior_recording_date2),
																	 3=>iesp.ECL2ESP.toDatestring8(l.Prior_recording_date3),
																	 4=>iesp.ECL2ESP.toDatestring8(l.Prior_recording_date4),
																	 5=>iesp.ECL2ESP.toDatestring8(l.Prior_recording_date5),
																	iesp.ECL2ESP.toDatestring8(''));
			self.PropertyAddress := case(c,1=>iesp.ECL2ESP.SetAddress('','','','','','','',l.Prior_Property_p_city_name1,l.Prior_Property_St1,l.Prior_Property_Zip1,'','','', l.Prior_Property_address1, '',
																			 stringlib.stringcleanspaces(l.Prior_Property_p_city_name1 +' '+l.Prior_Property_St1+' '+l.Prior_Property_Zip1)),
																     2=>iesp.ECL2ESP.SetAddress('','','','','','','',l.Prior_Property_p_city_name2,l.Prior_Property_St2,l.Prior_Property_Zip2,'','','', l.Prior_Property_address2, '',
	  																	 stringlib.stringcleanspaces(l.Prior_Property_p_city_name2 +' '+l.Prior_Property_St2+' '+l.Prior_Property_Zip2)),
																     3=>iesp.ECL2ESP.SetAddress('','','','','','','',l.Prior_Property_p_city_name3,l.Prior_Property_St3,l.Prior_Property_Zip3,'','','', l.Prior_Property_address3, '',
																			 stringlib.stringcleanspaces(l.Prior_Property_p_city_name3 +' '+l.Prior_Property_St3+' '+l.Prior_Property_Zip3)),
																     4=>iesp.ECL2ESP.SetAddress('','','','','','','',l.Prior_Property_p_city_name4,l.Prior_Property_St4,l.Prior_Property_Zip4,'','','', l.Prior_Property_address4, '',
		  																 stringlib.stringcleanspaces(l.Prior_Property_p_city_name4 +' '+l.Prior_Property_St4+' '+l.Prior_Property_Zip4)),
															       5=>iesp.ECL2ESP.SetAddress('','','','','','','',l.Prior_Property_p_city_name5,l.Prior_Property_St5,l.Prior_Property_Zip5,'','','', l.Prior_Property_address5, '',
																			 stringlib.stringcleanspaces(l.Prior_Property_p_city_name5 +' '+l.Prior_Property_St5+' '+l.Prior_Property_Zip5)),
																     iesp.ECL2ESP.SetAddress('','','','','','','','','','','','','', '', '',''));
																			
	   // 5 sets of sellers 1 & 2 and 5 sets of owners 1 & 2
	   self.sellers := case(c,1=> dataset([{l.Prior_Seller_Name11},{l.Prior_Seller_Name21}],iesp.share.t_StringArrayItem),
														2=> dataset([{l.Prior_Seller_Name12},{l.Prior_Seller_Name22}],iesp.share.t_StringArrayItem),
														3=> dataset([{l.Prior_Seller_Name13},{l.Prior_Seller_Name23}],iesp.share.t_StringArrayItem),
														4=> dataset([{l.Prior_Seller_Name14},{l.Prior_Seller_Name24}],iesp.share.t_StringArrayItem),
														5=> dataset([{l.Prior_Seller_Name15},{l.Prior_Seller_Name25}],iesp.share.t_StringArrayItem)
		                     );//end case
		 self.owners :=  case(c,1=> dataset([{l.Prior_Owner_Name11},{l.Prior_Owner_Name21}],iesp.share.t_StringArrayItem),
														2=> dataset([{l.Prior_Owner_Name12},{l.Prior_Owner_Name22}],iesp.share.t_StringArrayItem),
														3=> dataset([{l.Prior_Owner_Name13},{l.Prior_Owner_Name23}],iesp.share.t_StringArrayItem),
														4=> dataset([{l.Prior_Owner_Name14},{l.Prior_Owner_Name24}],iesp.share.t_StringArrayItem),
														5=> dataset([{l.Prior_Owner_Name15},{l.Prior_Owner_Name25}],iesp.share.t_StringArrayItem)
		                     );//end case
      self.sellers2.names := case(c,1=> if (l.Prior_Seller_Name11 <>'' or l.Prior_Seller_Name21 <> '',
		                                        dataset([{l.Prior_Seller_Name11,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Prior_Seller_Name21,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)), 
											             2=> if (l.Prior_Seller_Name12 <>'' or l.Prior_Seller_Name22 <> '',
		                                        dataset([{l.Prior_Seller_Name12,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Prior_Seller_Name22,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)), 
																	 3=> if (l.Prior_Seller_Name13 <>'' or l.Prior_Seller_Name23 <> '',
		                                        dataset([{l.Prior_Seller_Name13,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Prior_Seller_Name23,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)),
																	 4=> if (l.Prior_Seller_Name14 <>'' or l.Prior_Seller_Name24 <> '',
		                                        dataset([{l.Prior_Seller_Name14,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Prior_Seller_Name24,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)), 
																	 5=> if (l.Prior_Seller_Name15 <>'' or l.Prior_Seller_Name25 <> '',
		                                        dataset([{l.Prior_Seller_Name15,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Prior_Seller_Name25,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)
																						)); 						
		 self.owners2.names :=  case(c,1=> if (l.Prior_Owner_Name11 <>'' or l.Prior_Owner_Name21 <> '',
		                                        dataset([{l.Prior_Owner_Name11,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Prior_Owner_Name21,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)), 
											             2=> if (l.Prior_Owner_Name12 <>'' or l.Prior_Owner_Name22 <> '',
		                                        dataset([{l.Prior_Owner_Name12,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Prior_Owner_Name22,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)), 
																	 3=> if (l.Prior_Owner_Name13 <>'' or l.Prior_Owner_Name23 <> '',
		                                        dataset([{l.Prior_Owner_Name13,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Prior_Owner_Name23,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)),
																	 4=> if (l.Prior_Owner_Name14 <>'' or l.Prior_Owner_Name24 <> '',
		                                        dataset([{l.Prior_Owner_Name14,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Prior_Owner_Name24,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)), 
																	 5=> if (l.Prior_Owner_Name15 <>'' or l.Prior_Owner_Name25 <> '',
		                                        dataset([{l.Prior_Owner_Name15,'','','','','','',0,0,0,0,0,0,0,'','','',''},
		                                            {l.Prior_Owner_Name25,'','','','','','',0,0,0,0,0,0,0,'','','',''}],
																								iesp.property.t_Property2Name),
																						dataset([],	iesp.property.t_Property2Name)
																						)); 		
			SELF := [];
	
  END;
	
	EXPORT BenefitAssessment_Services.Layouts.md_with_acctno set_MD_main(marriage_divorce_v2_Services.layouts.batch_out L) := TRANSFORM
		isPart1 := L.party1_did <> 0;
		SELF.which_party              := if(isPart1, '1', '2'); // p1 & p2 aliases are formatted in marriage_divorce_v2_Services.fn_getMD_report so L.party1_did will be either p1's did or p1A's did
		SELF.party_type 			        := if(isPart1, L.party1_type 			         , L.party2_type 		           );
		SELF.party_name_fmt 		      := if(isPart1, L.party1_name_fmt 		       , L.party2_name_fmt 	         );
		SELF.party_orig_name 		      := if(isPart1, L.party1_orig_name 		     , L.party2_orig_name 		     );
		SELF.party_orig_name_alias 	  := if(isPart1, L.party1_orig_name_alias    , L.party2_orig_name_alias    );
		SELF.party_dob 				        := if(isPart1, L.party1_dob 			         , L.party2_dob 			         );
		SELF.party_residence_address1 := if(isPart1, L.party1_residence_address1 , L.party2_residence_address1 );
		SELF.party_residence_city     := if(isPart1, L.party1_residence_city     , L.party2_residence_city     );
		SELF.party_residence_state    := if(isPart1, L.party1_residence_state    , L.party2_residence_state    );
		SELF.party_orig_zip           := if(isPart1, L.party1_orig_zip           , L.party2_orig_zip           );
		SELF.party_residence_county   := if(isPart1, L.party1_residence_county   , L.party2_residence_county   );
		SELF.party_times_married      := if(isPart1, L.party1_times_married      , L.party2_times_married      );
	  SELF.party_did                := if(isPart1, L.party1_did                , L.party2_did                );
		SELF.acctno :=''; //gets set in next join
		SELF := L;
	END;	
			
END;
