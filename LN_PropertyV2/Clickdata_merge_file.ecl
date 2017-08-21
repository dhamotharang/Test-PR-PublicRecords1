import Marketing_Best,LN_PropertyV2,LN_Property,ut,_control;   

// keep latest record per property (if dups exists)

ds_deed:=dedup(sort(LN_PropertyV2.file_clickdata_deed,click_hhid,-(integer)recording_date,-(integer)contract_date,-(integer)process_date),click_hhid);
ds_tax := dedup(sort(LN_PropertyV2.file_clickdata_tax,click_hhid,-(integer)tax_year,-(integer)assessed_value_year,-(integer)process_date),click_hhid);
ds_total :=  dedup(sort(distribute(Marketing_Best.file_total_source_clickdata,hash(click_id)),click_id,local),click_id,local) ; 
search_ln:= LN_PropertyV2.file_search_building(ln_fares_id[1] != 'R') ; 

//append mailing cleaning address 

tempd_rec := record
ds_deed ;
string70 m_street_address ; 
string25 m_city_name;
string2 m_st;
string5 m_zip;
string4 m_zip4;
end; 

tempd_rec get_add(ds_deed l, search_ln r ) := transform 

self.m_street_address := trim(r.prim_range,left,right)+' '+trim(r.predir,left,right)+' '+trim(r.prim_name,left,right)+' '+trim(r.suffix,left,right)+' '+trim(r.postdir,left,right) + ' '+trim(r.unit_desig,left,right)
+' '+trim(r.sec_range,left,right)   ; 
self.m_city_name :=  r.p_city_name;
self.m_st  := r.st ;
self.m_zip  := r.zip ;
self.m_zip4  := r.zip4 ;
self := l ;
  
end ; 

djoin_address := join(distribute(ds_deed,hash(ln_fares_id)),distribute(search_ln(source_code[2]in ['O','B']),hash(ln_fares_id)), left.ln_fares_id = right.ln_fares_id
                                         ,get_add(left,right),left outer ,keep(1),local);
tempa_rec := record

ds_tax ;
string70 m_street_address ; 
string25 m_city_name;
string2 m_st;
string5 m_zip;
string4 m_zip4;
end; 

tempa_rec get_add1(ds_tax l, search_ln r ) := transform 

self.m_street_address := trim(r.prim_range,left,right)+' '+trim(r.predir,left,right)+' '+trim(r.prim_name,left,right)+' '+trim(r.suffix,left,right)+' '+trim(r.postdir,left,right) + ' '+trim(r.unit_desig,left,right)
+' '+trim(r.sec_range,left,right)   ; 
self.m_city_name :=  r.p_city_name;
self.m_st  := r.st ;
self.m_zip  := r.zip ;
self.m_zip4  := r.zip4 ;
self := l ;
  
end ; 

ajoin_address := join(distribute(ds_tax,hash(ln_fares_id)),distribute(search_ln(source_code[2]='O'),hash(ln_fares_id)), left.ln_fares_id = right.ln_fares_id
                                          ,get_add1(left,right),left outer ,keep(1),local);

//get all owners of property 

temp_rect := record 
ajoin_address ; 
string36 click_id ; 
string20  fname;
string20  lname;

end ; 

temp_rect populate_click_id(ajoin_address l, search_ln r) := transform

// l.property_full_street_address ='' and  l.property_city_state_zip='' => true for dnm supressed records 

string l_name_t :=regexreplace('([[:print:]])\\1*',StringLib.StringFilterOut(r.lname,'AEIOUY'), '$1',nocase);
string l_lname_t1      := StringLib.StringToUpperCase(l_name_t[1..4]);
boolean is_padd_empty := if(l.property_full_street_address ='' and  l.property_city_state_zip='', true , false); 
		
		self.click_id := if(is_padd_empty,trim(l.click_hhid,left,right)+trim(l_lname_t1,left,right),
		ut.fn_create_click_id(trim(l.prim_range,left,right)+' '+trim(l.predir,left,right)+' '+trim(l.prim_name,left,right)+' '+trim(l.suffix,left,right)+' '+trim(l.postdir,left,right)+' '+trim(l.unit_desig,left,right)+' '+trim(l.sec_range,left,right),l.zip,r.lname,'','',''));
		self.fname := r.fname ; 
		self.lname := r.lname ; 
		self := l;
	end;
				
tax_wid := join(distribute(ajoin_address,hash(ln_fares_id)),distribute(search_ln(source_code='OP'),hash(ln_fares_id)),
										left.ln_fares_id = right.ln_fares_id,
											 populate_click_id(left,right),
 										 left outer, local) :  persist('~persist::property_merge_tax') ; 
//get all owners of property 

temp_recd := record 
djoin_address ; 
string36 click_id ; 
string20  fname;
string20  lname;

end ; 

temp_recd populate_click_id1(djoin_address l, search_ln r) := transform

// l.property_full_street_address ='' and  l.property_city_state_zip='' => true for dnm supressed records 
		
string l_name_t :=regexreplace('([[:print:]])\\1*',StringLib.StringFilterOut(r.lname,'AEIOUY'), '$1',nocase);
string l_lname_t1      := StringLib.StringToUpperCase(l_name_t[1..4]);
boolean is_padd_empty := if(l.property_full_street_address ='' and  l.property_address_citystatezip='', true , false); 
		
		self.click_id := if(is_padd_empty,trim(l.click_hhid,left,right)+trim(l_lname_t1,left,right),
		ut.fn_create_click_id(trim(l.prim_range,left,right)+' '+trim(l.predir,left,right)+' '+trim(l.prim_name,left,right)+' '+trim(l.suffix,left,right)+' '+trim(l.postdir,left,right)+' '+trim(l.unit_desig,left,right)+' '+trim(l.sec_range,left,right),l.zip,r.lname,'','',''));
		self.fname := r.fname ; 
		self.lname := r.lname ; 
		self := l;
	end;
				
deed_wid := join(distribute(djoin_address,hash(ln_fares_id)),distribute(search_ln(source_code in ['OP','BP']),hash(ln_fares_id)),
										left.ln_fares_id = right.ln_fares_id,
											 populate_click_id1(left,right),
											 left outer, local) :  persist('~persist::property_merge_deed') ; 
 
tax_widd := dedup(sort(distribute(tax_wid,hash(click_id)),click_id, -(integer)tax_year,-(integer)assessed_value_year,-(integer)process_date,local),click_id,local ) ;
deed_widd := dedup(sort(distribute(deed_wid,hash(click_id)),click_id,from_file,-(integer)recording_date,-(integer)contract_date,-(integer)process_date,local ),click_id,from_file,local) ;

LN_PropertyV2.layout_clickdata.join_td  join_t_d(deed_widd l, tax_widd r) := transform 

string  tstreetadd := trim(r.prim_range,left,right)+' '+trim(r.predir,left,right)+' '+trim(r.prim_name,left,right)+' '+trim(r.suffix,left,right)+' '+trim(r.postdir,left,right) + ' '+trim(r.unit_desig,left,right)
+' '+trim(r.sec_range,left,right)   ;

boolean isdempty := if((trim(l.prim_range,left,right)+trim(l.predir,left,right)+trim(l.prim_name,left,right)+trim(l.suffix,left,right)+trim(l.postdir,left,right) +trim(l.unit_desig,left,right)
+trim(l.sec_range,left,right)  + trim(l.p_city_name,left,right)+trim(l.st,left,right)+trim(l.zip,left,right))='' ,true,false);

string dstreetadd := trim(l.prim_range,left,right)+' '+trim(l.predir,left,right)+' '+trim(l.prim_name,left,right)+' '+trim(l.suffix,left,right)+' '+trim(l.postdir,left,right) + ' '+trim(l.unit_desig,left,right)
+' '+trim(l.sec_range,left,right)   ;

boolean isdmempty := if(trim(l.m_street_address,left,right)+trim(l.m_city_name,left,right)+trim(l.m_st,left,right)+trim(l.m_zip4,left,right)='' ,true,false);
/*
boolean check_tlatest := if(r.tax_year <>'' and l.recording_date<>'' and r.tax_year > l.recording_date[1..4], true,
                      if(r.recording_date <>'' and l.recording_date <>'' and r.recording_date[1..4] > l.recording_date[1..4] , true,false));				  

boolean is_match  := if(l.click_id = r.click_id,true,false); */

self.ln_fares_ida := r.ln_fares_id; 
self.ln_fares_idd := l.ln_fares_id;
self.apna_or_pin_number := if(l.apnt_or_pin_number <> '',l.apnt_or_pin_number,r.apna_or_pin_number);
self.owner1 := if(l.name1<>'',l.name1,r.assessee_name) ;  
self.owner2 := if(l.name2<>'',l.name2,r.second_assessee_name) ; 
self.Owner_name_type := 'O';

// property
self.state  := if(l.state <>'', l.state,r.state_code) ;
self.fips_county := if(l.fips_code <>'', r.fips_code,l.fips_code) ;
self.msa :=  if(l.msa <>'', l.msa,r.msa) ; 
self.fips_city := '' ; 
self.scf := if(l.zip[1..3] <>'', l.zip,r.zip) ;  
self.county_name := if(l.county_name <>'' , l.county_name,r.county_name); 
self.ltv := if((integer)l.ltv <> 0 , l.ltv, r.ltv); 
self.available_home_equity :=(integer) r.market_total_value - ((integer)l.first_td_loan_amount + (integer)l.second_td_loan_amount) ; 
self.sale_price   := if(l.sales_price <>'',l.sales_price,r.sales_price);
self.document_number := if(l.document_number<>'',l.document_number,r.recorder_document_number) ; 
self.recorder_book_number := if(l.recorder_book_number<>'',l.recorder_book_number,r.recorder_book_number) ;
self.recorder_page_number :=  if(l.recorder_page_number<>'',l.recorder_page_number,r.recorder_page_number) ;
self.latest_flag  := if(l.latest_flag<>'',l.latest_flag,r.latest_flag) ; 
self.property_type  := if(l.assessment_match_land_use_code<>'',l.assessment_match_land_use_code, r.standardized_land_use_code);
self.recording_date	  := if(l.recording_date<>'' ,l.recording_date,r.recording_date);

self.lname  :=if(l.lname<>'',l.lname,r.lname) ;
self.fname  :=if(l.lname<>'',l.fname,r.fname) ;

self.p_street_address := if(~isdempty,dstreetadd,tstreetadd); 
self.p_city_name :=  if(~isdempty ,l.p_city_name,r.p_city_name);
self.p_st  := if(~isdempty ,l.st,r.st);  ;
self.p_zip  := if(~isdempty,l.zip,r.zip) ;
self.p_zip4  := if(~isdempty,l.zip4,r.zip4) ;
self.p_rec_type := if(~isdempty,l.rec_type,r.rec_type);
self.p_geo_lat  := if(~isdempty, l.geo_lat,r.geo_lat);
self.p_geo_long  := if(~isdempty,l.geo_long,r.geo_long) ;

self.m_street_address := if(~isdmempty,l.m_street_address,r.m_street_address); 
self.m_city_name   := if(~isdmempty,l.m_city_name,r.m_city_name); 
self.m_st   := if(~isdmempty,l.m_st,r.m_st); 
self.m_zip  := if(~isdmempty,l.m_zip,r.m_zip); 
self.m_zip4 := if(~isdmempty,l.m_zip4,r.m_zip4); 

self.click_id  := if(l.click_id<>'',l.click_id,r.click_id) ;
self.click_hhid  :=if(l.click_hhid<>'',l.click_hhid,r.click_hhid) ;
self.process_date  :=if(l.process_date<>'',l.process_date,r.process_date) ;

// deed 
self.Loan1_amount := l.first_td_loan_amount ;
self.Loan2_amount  := l.second_td_loan_amount ;
self.fst_mortgage_type  := l.first_td_loan_type_code ;
self.fst_mortgage_rate_type  := l.type_financing ;
self.fst_mortgage_lender_name  := l.lender_name ;
self.sale_date  := l.contract_date;
self.seller1     := l.seller1 ; 
self.seller2  :=   l.seller2  ; 
self.seller_mailing_full_street_address :=  l.seller_mailing_full_street_address ; 
self.seller_mailing_address_unit_number :=  l.seller_mailing_address_unit_number; 
self.seller_mailing_address_citystatezip :=  l.seller_mailing_address_citystatezip; 
self.legal_lot_code   :=  l.legal_lot_code  ; 
self.legal_lot_number  :=   l.legal_lot_number  ; 
self.legal_city_municipality_township  := l.legal_city_municipality_township  ;  
self.legal_subdivision_name  :=   l.legal_subdivision_name  ; 
self.arm_reset_date   :=   l.arm_reset_date  ;
self.document_type_code  :=   l.document_type_code   ; 
self.loan_number   :=  l.loan_number  ; 
self.first_td_lender_type_code  :=  l.first_td_lender_type_code   ;
self.second_td_lender_type_code  :=  l.second_td_lender_type_code   ;
self.first_td_interest_rate   :=   l.first_td_interest_rate  ;
self.first_td_due_date   :=   l.first_td_due_date  ;
self.title_company_name  :=  l.title_company_name  ;
self.loan_term_months  :=   l.loan_term_months  ;	
self.loan_term_years  :=   l.loan_term_years  ;	
self.lender_name_id   :=   l.lender_name_id   ;
self.lender_full_street_address  :=  l.lender_full_street_address ;
self.lender_address_unit_number  :=  l.lender_address_unit_number ;
self.lender_address_citystatezip  :=  l.lender_address_citystatezip ;
self.property_use_code   :=  l.property_use_code  ; 
self.land_lot_size   :=   l.land_lot_size ; 
self.adjustable_rate_index   :=  l.adjustable_rate_index  ;
self.adjustable_rate_rider  :=   l.adjustable_rate_rider ;
self.balloon_rider    :=   l.balloon_rider ;
self.fixed_step_rate_rider  :=  l.fixed_step_rate_rider ;
self.planned_unit_development_rider  :=  l.planned_unit_development_rider;
self.rate_improvement_rider  :=  l.rate_improvement_rider ;
self.assumability_rider  :=  l.assumability_rider ;
self.prepayment_rider   :=  l.prepayment_rider ;
self.second_home_rider  :=  l.second_home_rider ;
self.data_source_code   :=  l.data_source_code ;
//self.contract_date    :=  l.contract_date  ;

self.market_value  :=  r.market_total_value ; 
self.year_built  := r.year_built;
self.number_of_rooms :=r.no_of_rooms;
self.number_of_bedrooms := r.no_of_bedrooms ;
self.number_of_bathrooms :=r.no_of_baths;
self.garage_type := r.garage_type_code;
self.garage_size := r.parking_no_of_cars ;
self.swimming_pool :=r.pool_code;
self.building_style :=r.style_code;
self.frame_or_outer_wall_type := r.exterior_walls_code;
self.foundation_type  := r.foundation_code;
self.heating_type  := r.heating_code;
self.air_conditioning_type := r.air_conditioning_code;
self.basement_type  := r.basement_code;
self.roof_type  := r.roof_type_code;
self.ownership_type_code := r.ownership_type_code  ;	
self.county_land_use_description   := r.county_land_use_description  ;	
self.owner_occupied	   := r.owner_occupied   ;
self.transfer_date	 := r.transfer_date  ;

self.document_type	:= r.document_type ;
self.mortgage_loan_amount  := r.mortgage_loan_amount  ;
self.mortgage_loan_type_code	  := r.mortgage_loan_type_code  ;
self.mortgage_lender_name     := r.mortgage_lender_name  ;
self.mortgage_lender_type_code   := r.mortgage_lender_type_code   ;
self.prior_transfer_date   := r.prior_transfer_date  ;
self.prior_recording_date   := r.prior_recording_date  ;
self.prior_sales_price     := r.prior_sales_price  ;
self.assessed_land_value    := r.assessed_land_value  ;
self.assessed_improvement_value   := r.assessed_improvement_value  ;
self.assessed_total_value    := r.assessed_total_value   ;
self.assessed_value_year   := r.assessed_value_year  ;
self.market_land_value     := r.market_land_value   ;
self.market_improvement_value   := r.market_improvement_value  ;
self.market_value_year    := r.market_value_year  ;
self.homestead_homeowner_exemption   := r.homestead_homeowner_exemption  ;
self.tax_exemption1_code   := r.tax_exemption1_code  ;
self.tax_rate_code_area   := r.tax_rate_code_area  ;
self.tax_amount    := r.tax_amount   ;
self.tax_year     := r.tax_year  ;
self.tax_delinquent_year   := r.tax_delinquent_year   ;
self.school_tax_district1   := r.school_tax_district1  ;
self.land_acres    := r.land_acres ;
self.land_square_footage   := r.land_square_footage  ;
self.land_dimensions   := r.land_dimensions  ;
self.building_area    := r.building_area  ;
self.building_area_indicator   := r.building_area_indicator  ;
self.building_area1    := r.building_area1  ;
self.effective_year_built   := r.effective_year_built  ;
self.no_of_buildings   := r.no_of_buildings  ;
self.no_of_stories    := r.no_of_stories   ;
self.no_of_units    := r.no_of_units  ;
self.no_of_partial_baths   := r.no_of_partial_baths  ;
self.garage_type_code    := r.garage_type_code  ;
self.heating_fuel_type_code  := r.heating_fuel_type_code  ;
self.elevator   := r.elevator   ;
self.fireplace_number    := r.fireplace_number   ;
self.neighborhood_code    := r.neighborhood_code  ;
self.tape_cut_date    := r.tape_cut_date  ;
self.certification_date   := r.certification_date  ;

end; 

dsjoin_td := join(deed_widd,tax_widd,
				  left.click_id = right.click_id,
				   join_t_d(left,right),full  outer, local) :  persist('~persist::property_merge_td') ; 

 

LN_PropertyV2.layout_clickdata.join_tds  tjoin(dsjoin_td l, ds_total r) := transform 

self.gender_code := r.Primary_Gender ;
self.phone := r.telephone;
self.age_id := r.Household_Age_Code;
self.income_hh_id :=  r.Household_Income_Identifier;
self.lor := r.Length_of_Residence;
self.marital_status := r.Marital_Status;
self.household_children := r.Number_of_Children_in_Household ;
self.occupation := r.Household_Occupation;
self.cc_user := r.Credit_Card_Usage_Bank_Card;
self.mail_resp := r.Mail_Public_Responder_Indicator;
self.dwell_type := r.Dwelling_Type;
self.outdoor_ind := r.Outdoors_Dimension_Household;
self.fitness_ind := r.Fitness_Dimension_Household;
self.good_life_ind := r.Good_Life_Dimension_Household;
self.diy_ind  := r.Do_It_Yourself_Dimension_Household;
self.bluechip_ind := r.Blue_Chip_Dimension_Household;
self.athletic_ind := r.Athletic_Dimension_Household;
self.domestic_ind := r.Domestic_Dimension_Household;
self.culture_ind := r.Cultural_Dimension_Household;
self.tech_ind := r.Technology_Dimension_Household;
self.available_home_equity  := (string) l.available_home_equity ; 
self.click_hh_id := trim(l.click_hhid,left,right); 
self:= l ;
end; 
dsjoin_tds := join(distribute(dsjoin_td,hash(click_id)),distribute(ds_total,hash(click_id)),
				  left.click_id = right.click_id,
				   tjoin(left,right),left outer,local) :  persist('~persist::property_merge_tds') ; 
		   
//to do 
// if last names are differenet for owners then click id wuld be different => multiple record 
// per property exist and - 122457
// check the clean name left is first owner 

// append fips city 

look_rec := record
string  zip;
string fips_city ;
end;

fips_lookup := dataset('~thor_data400::ln_propertyv2::merged.clickdata_fips_city',look_rec,csv(separator('\t'),maxlength(16384)));

fips_lookupd := dedup(fips_lookup,record,all); 

dsjoin_tds tjoinfips(dsjoin_tds L, fips_lookupd R) := transform
self.fips_city := R.fips_city ;
self := L ;
end;

file_join := join(dsjoin_tds, fips_lookupd, left.p_zip = right.zip, tjoinfips(left,right), left outer,LOOKUP);

ut.mac_suppress_by_phonetype(file_join,phone,m_st,phone_suppression,false);

write_out := output(phone_suppression(p_st <> '' and p_st in ln_property.valid_states),, '~thor_data400::ln_propertyv2::merged.clickdata',__compressed__,overwrite) ;

// despray 

DestinationIP := _control.IPAddress.edata12;

despray_out := fileservices.despray( '~thor_data400::ln_propertyv2::merged.clickdata', DestinationIP, '/hds_180/property_clickdata/property_merge_tds_'+ut.GetDate+'.d00',,,,TRUE);
  
send_email:= fileservices.SendEmail('cdsdataops@seisint.com,kgummadi@seisint.com','Property merged clickdata files available on edata12 /hds_180/property_clickdata/property_merge_tds_'+ut.GetDate+'.d00' ,'');
send_bad_email := FileServices.sendemail('krishna.gummadi@lexisnexis.com', 'property click data meged file build failed', failmessage,'');

export Clickdata_merge_file := sequential(write_out, despray_out):success(send_email), failure(send_bad_email);
 

 