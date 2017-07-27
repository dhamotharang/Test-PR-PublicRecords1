IMPORT doxie_crs, codes, ut;

string6 makeZsix(string10 BorP) := intformat ((integer)BorP,6,1);

EXPORT 
GetStandardProperty	(DATASET (doxie_ln.layout_assessor_records) ar,
                     DATASET (doxie_ln.layout_deed_records) dr) := FUNCTION




rec :=RECORD
	doxie_crs.layout_property_ln;
	unsigned6 did;
	dr.vendor_source_flag;
	dr.fares_transaction_type;
	dr.first_td_loan_type_code;
	dr.property_use_code;
	
	dr.type_financing;
	dr.document_type_code;
	
	dr.fares_equity_flag;
	dr.fares_refi_flag;
	dr.fares_foreclosure;
	
	ar.roof_type_code;
	ar.roof_cover_code;
	ar.basement_code;
	ar.heating_code;
	ar.exterior_walls_code;
	
	ar.mortgage_loan_type_code;
	ar.pool_code; 
	ar.air_conditioning_code; 
	ar.garage_type_code;
	
	ar.other_buildings1_code; 
	ar.other_buildings2_code; 
	ar.other_buildings3_code; 
  ar.other_buildings4_code; 
  ar.other_buildings5_code; 
	ar.site_influence1_code;
	ar.site_influence2_code;
	ar.site_influence3_code;
	ar.site_influence4_code;
	ar.site_influence5_code;
	
end;

										

rec get_std_deed(dr l,Codes.Key_Codes_V3 r):= transform
  self.compare_date := l.recording_date;
	self.uapn := l.fares_unformatted_apn;
	self.fapn := l.apnt_or_pin_number;
	self.book_page := makeZsix(l.recorder_book_number) + makeZsix(l.recorder_page_number);
	self.Lot_Number := '';
	self.Name_Owner_1 := l.buyer1;
	self.Name_Owner_2 := l.buyer_mailing_address_care_of_name; 
	self.refi_flag := if(l.fares_refi_flag='T', l.fares_refi_flag, '');
	self.record_type := 'DEED';
	
	self.property_full_street_address := l.property_full_street_address;
	self.property_address_unit_number := l.property_address_unit_number;
	self.property_address_citystatezip := l.property_address_citystatezip;
	self.property_county := l.county_name;
	
	self.buyer_mailing_full_street_address := l.buyer_mailing_full_street_address;
	self.buyer_mailing_address_unit_number := l.buyer_mailing_address_unit_number;
	self.buyer_mailing_address_citystatezip := l.buyer_mailing_address_citystatezip;
	self.buyer_mailing_county := '';//patch below for now

	//self.Land_Usage := codes.FARES_1080.PROPERTY_INDICATOR_CODE(l.property_use_code);
	self.Sale_Date  := l.contract_date;
	self.Sale_Price := ut.rmv_ld_zeros(if ((integer)l.sales_price = 0, '', L.sales_price));
	self.Name_of_Seller := l.seller1;
	self.Loan_Amount := ut.rmv_ld_zeros(if ((integer)l.first_td_loan_amount = 0, '', L.first_td_loan_amount));
	self.Loan_Term_Code := l.fares_mortgage_term_code;
	self.Loan_Term := ut.rmv_ld_zeros(l.fares_mortgage_term);//
	self.Loan_Due_Date := l.first_td_due_date;//
	//self.Loan_Type := codes.FARES_1080.mortgage_loan_type_code(l.first_td_loan_type_code);
	self.Loan_Deed_Type := l.fares_mortgage_deed_type;
/*	self.Loan_Deed_Sub_Type := 
		map(l.fares_equity_flag<>'' => codes.FARES_1080.EQUITY_FLAG(l.fares_equity_flag,l.vendor_source_flag),
	      l.fares_refi_flag<>'' => codes.FARES_1080.REFI_FLAG(l.fares_refi_flag,l.vendor_source_flag),
				l.fares_foreclosure<>'' => codes.FARES_1080.FORECLOSURE(l.fares_foreclosure,l.vendor_source_flag),
				''); */
	self.Lender_Name := l.lender_name;
	
	self.Subdivision_Name := '';
	self.Total_Value := '';
	self.Land_Value := '';
	self.Improvement_Value := '';
	self.Land_Size := '';
	self.building_size := '';
	self.building_square_feet := ut.rmv_ld_zeros(l.fares_building_square_feet);
	self.Year_Built := '';
	self.Legal_Description := '';
	
	//more fields
	self.recording_date := l.recording_date;
	self.tax_year := '';
     self.tax_amount := '';
	self.mkt_total_val := '';
	self.mkt_land_val := '';
	self.mkt_improvement_val := '';
	self.living_square_feet := '';
	self.stories_number := '';
	self.foundation := '';
	self.bedrooms := '';
	self.full_baths := '';
	self.half_baths := '';
	self.assd_total_val := '';	
	//self.document_type := codes.FARES_1080.DOCTYPE(l.document_type_code,l.vendor_source_flag);
	self.InterestRate := l.first_td_interest_rate;
  self.transaction_type := r.long_desc;
	 
	self.other_buyers := [];
	self.other_sellers := [];
  self := l;
	self :=[];
end;

std_deed_wtransaction := join(dr,Codes.Key_Codes_V3,right.file_name = 'FARES_1080' and right.field_name ='TRANSACTION_TYPE' and
						left.vendor_source_flag = right.field_name2 and left.fares_transaction_type = right.code, get_std_deed(left,right),
						left outer, keep(1)); 

Codes.Mac_GetPropertyCode(std_deed_wtransaction,std_deed_wdocument,Codes.Key_Codes_V3, 'FARES_1080','DOCUMENT_TYPE',
			document_type_code,document_type);

Codes.Mac_GetPropertyCode(std_deed_wdocument,std_deed_wmortgage_loan,Codes.Key_Codes_V3, 'FARES_1080','MORTGAGE_LOAN_TYPE_CODE',
			first_td_loan_type_code,Loan_Type);
			
Codes.Mac_GetPropertyCode(std_deed_wmortgage_loan,std_deed_wproperty_code,Codes.Key_Codes_V3, 'FARES_1080','PROPERTY_INDICATOR_CODE',
			property_use_code,Land_Usage);
			
Codes.Mac_GetPropertyCode(std_deed_wproperty_code,std_deed_wInterestType,Codes.Key_Codes_V3, 'FARES_1080','TYPE_FINANCING',
			type_financing,InterestRateType);
			
Codes.Mac_GetPropertyCode(std_deed_wInterestType,std_deed_wLoan_Deed_sub_Type1,Codes.Key_Codes_V3, 'FARES_1080','EQUITY_FLAG',
			fares_equity_flag,Loan_Deed_Sub_Type);
			
Codes.Mac_GetPropertyCode(std_deed_wLoan_Deed_sub_Type1,std_deed_wLoan_Deed_sub_Type2,Codes.Key_Codes_V3, 'FARES_1080','REFI_FLAG',
			fares_refi_flag,Loan_Deed_Sub_Type);

Codes.Mac_GetPropertyCode(std_deed_wLoan_Deed_sub_Type2,std_deed_wLoan_Deed_sub_Type3,Codes.Key_Codes_V3, 'FARES_1080','FORECLOSURE',
			fares_foreclosure,Loan_Deed_Sub_Type);

rec_out := record(doxie_crs.layout_property_ln)
	unsigned6 did;
end;
									
std_deed:=project(std_deed_wLoan_Deed_sub_Type3,transform(rec_out,self :=left));		
						
						
rec get_std_asses(ar l,codes.Key_Codes_V3 r):= transform

  self.compare_date := l.tax_year + '0000'; 
	self.uapn := l.fares_unformatted_apn;
	self.fapn := l.apna_or_pin_number;
	self.book_page := makeZsix(l.recorder_book_number) + makeZsix(l.recorder_page_number);
	self.Lot_Number := l.legal_lot_number;
	self.Name_Owner_1 := l.assessee_name; 
	self.Name_Owner_2 := l.second_assessee_name; 
	self.record_type := 'ASSESSOR';
	
	self.property_full_street_address := l.property_full_street_address;
	self.property_address_unit_number := l.property_unit_number;
	self.property_address_citystatezip := l.property_city_state_zip;
	self.property_county := l.county_name;
	
	self.buyer_mailing_full_street_address := l.mailing_full_street_address;
	self.buyer_mailing_address_unit_number := l.mailing_unit_number;
	self.buyer_mailing_address_citystatezip := l.mailing_city_state_zip;
	self.buyer_mailing_county := l.mailing_county;

	self.Land_Usage := l.land_use_decoded;
	self.Sale_Date  := l.sale_date;
	self.Sale_Price := ut.rmv_ld_zeros(if ((integer)l.sales_price = 0, '', L.sales_price));
	self.Name_of_Seller := l.fares_seller_name;
	self.Loan_Amount := ut.rmv_ld_zeros(if ((integer)l.mortgage_loan_amount = 0, '', L.mortgage_loan_amount));
	self.Loan_Term_Code := '';//l.mortgage_term_code;
	self.Loan_Term := '';//l.mortgage_term;
	//self.Loan_Type := l.mortgage_loan_type_code;
	self.Loan_Deed_Type := '';//l.mortgage_deed_type;
	self.Loan_Deed_Sub_Type := '';
	self.Lender_Name := l.mortgage_lender_name;
	
	self.Subdivision_Name := l.legal_subdivision_name;
	self.Total_Value := ut.rmv_ld_zeros(if ((integer)l.assessed_total_value = 0, '', l.assessed_total_value));
	self.Land_Value := ut.rmv_ld_zeros(if ((integer)l.assessed_land_value = 0, '', l.assessed_land_value));
	self.Improvement_Value := ut.rmv_ld_zeros(if ((integer)l.assessed_improvement_value = 0, '', l.assessed_improvement_value));
	self.assd_total_val := ut.rmv_ld_zeros(if ((integer)l.assessed_total_value = 0, '', l.assessed_total_value));
	self.Land_Size := functions.GetSquareFootage (l.land_acres, l.land_square_footage);
	self.building_size := ut.rmv_ld_zeros(if ((integer)l.fares_adjusted_gross_square_feet = 0, '', l.fares_adjusted_gross_square_feet));
	self.building_square_feet := ut.rmv_ld_zeros(if ((integer)l.building_area = 0, '', l.building_area));
	self.living_square_feet := ut.rmv_ld_zeros(if ((integer)l.fares_living_square_feet= 0, '', l.fares_living_square_feet));
	self.Year_Built := l.year_built;
	self.Legal_Description := l.legal_brief_description;
	self.stories_number := ut.rmv_ld_zeros(if ((integer)l.no_of_stories = 0, '', (string)((integer)l.no_of_stories)));
	self.bedrooms  := ut.rmv_ld_zeros(if ((integer)l.no_of_bedrooms = 0, '', (string)((integer)l.no_of_bedrooms)));
	
	fb := map ((integer)l.fares_no_of_full_baths > 0 => (string)((integer)l.fares_no_of_full_baths),
			 (integer)l.no_of_baths > 0 => (string)(((integer)l.no_of_baths - 50*(integer)l.no_of_partial_baths) div 100),
			 '');
	hb := map ((integer)l.fares_no_of_half_baths > 0 => (string)((integer)l.fares_no_of_half_baths),
			 (integer)l.no_of_partial_baths > 0 => (string)((integer)l.no_of_partial_baths),
			 '');	
	self.full_baths := ut.rmv_ld_zeros(fb);
	self.half_baths := ut.rmv_ld_zeros(hb); 
	
	self.tax_amount := l.tax_amount;
	self.tax_year := if(l.Tax_Year <> '', l.Tax_Year, l.Assessed_Value_Year);
	self.mkt_total_val := ut.rmv_ld_zeros(l.market_total_value);
	self.mkt_land_val := ut.rmv_ld_zeros(l.market_land_value);
	self.mkt_improvement_val := ut.rmv_ld_zeros(l.market_improvement_value);
	
	self.homesteadExemption := If(l.homestead_homeowner_exemption In ['Y','H'],'YES','');
	self.FirePlace := l.FirePlace_Number;
	self.foundation :=r.long_desc;
	self.document_number := l.recorder_document_number;
	//more fields
	self.document_type := '';
	self.transaction_type := '';
 
	self.other_buyers := [];
	self.other_sellers := [];
  self := l;
	self :=[];
end;


std_asses_wfoundation0 := join(ar,codes.Key_Codes_V3, right.file_name='FARES_2580' and right.field_name ='FOUNDATION' and
							left.vendor_source_flag = right.field_name2 and left.foundation_code=right.code, get_std_asses(left,right),
							left outer, keep(1));

Codes.Mac_GetPropertyCode(std_asses_wfoundation0,std_asses_wfoundation,Codes.Key_Codes_V3, 'FARES_2580','ROOF_COVER',
			roof_cover_code,roof_cover);
Codes.Mac_GetPropertyCode(std_asses_wfoundation,std_asses_wroof_type,Codes.Key_Codes_V3, 'FARES_2580','ROOF_TYPE',
			roof_type_code,roof_type);
Codes.Mac_GetPropertyCode(std_asses_wroof_type,std_asses_wbasement,Codes.Key_Codes_V3, 'FARES_2580','BASEMENT_FINISH',
			basement_code,basement);			
Codes.Mac_GetPropertyCode(std_asses_wbasement,std_asses_wheating,Codes.Key_Codes_V3, 'FARES_2580','HEATING',
			heating_code,heating);
Codes.Mac_GetPropertyCode(std_asses_wheating,std_asses_wExtwalls,Codes.Key_Codes_V3, 'FARES_2580','EXTERIOR_WALLS',
			exterior_walls_code,ExteriorWalls);							
Codes.Mac_GetPropertyCode(std_asses_wExtwalls,std_asses_wMortgage_Loan,Codes.Key_Codes_V3, 'FARES_2580','MORTGAGE_LOAN_TYPE_CODE',
			mortgage_loan_type_code,Loan_Type);		
Codes.Mac_GetPropertyCode(std_asses_wMortgage_Loan,std_asses_wPool,Codes.Key_Codes_V3, 'FARES_2580','POOL_CODE',
			pool_code,Pool);	
Codes.Mac_GetPropertyCode(std_asses_wPool,std_asses_wAir_Conditioning,Codes.Key_Codes_V3, 'FARES_2580','AIR_CONDITIONING',
			air_conditioning_code,AirConditioning);			
Codes.Mac_GetPropertyCode(std_asses_wAir_Conditioning,std_asses_wGarage,Codes.Key_Codes_V3, 'FARES_2580','GARAGE',
			garage_type_code,Garage);	
Codes.Mac_GetPropertyCode(std_asses_wGarage,std_asses_wOtherBuildings1,Codes.Key_Codes_V3, 'FARES_2580','OTHER_BUILDINGS1_CODE',
			other_buildings1_code,OtherBuildings1);	
Codes.Mac_GetPropertyCode(std_asses_wOtherBuildings1,std_asses_wOtherBuildings2,Codes.Key_Codes_V3, 'FARES_2580','OTHER_BUILDINGS2_CODE',
			other_buildings2_code,OtherBuildings2);	
Codes.Mac_GetPropertyCode(std_asses_wOtherBuildings2,std_asses_wOtherBuildings3,Codes.Key_Codes_V3, 'FARES_2580','OTHER_BUILDINGS3_CODE',
			other_buildings3_code,OtherBuildings3);	
Codes.Mac_GetPropertyCode(std_asses_wOtherBuildings3,std_asses_wOtherBuildings4,Codes.Key_Codes_V3, 'FARES_2580','OTHER_BUILDINGS4_CODE',
			other_buildings4_code,OtherBuildings4);				
Codes.Mac_GetPropertyCode(std_asses_wOtherBuildings4,std_asses_wOtherBuildings5,Codes.Key_Codes_V3, 'FARES_2580','OTHER_BUILDINGS5_CODE',
			other_buildings5_code,OtherBuildings5);	
Codes.Mac_GetPropertyCode(std_asses_wOtherBuildings5,std_asses_wOtherChar1,Codes.Key_Codes_V3, 'FARES_2580','SITE_INFLUENCE1_CODE',
			site_influence1_code,OtherCharacteristics1);	
Codes.Mac_GetPropertyCode(std_asses_wOtherChar1,std_asses_wOtherChar2,Codes.Key_Codes_V3, 'FARES_2580','SITE_INFLUENCE2_CODE',
			site_influence2_code,OtherCharacteristics2);
Codes.Mac_GetPropertyCode(std_asses_wOtherChar2,std_asses_wOtherChar3,Codes.Key_Codes_V3, 'FARES_2580','SITE_INFLUENCE3_CODE',
			site_influence3_code,OtherCharacteristics3);
Codes.Mac_GetPropertyCode(std_asses_wOtherChar3,std_asses_wOtherChar4,Codes.Key_Codes_V3, 'FARES_2580','SITE_INFLUENCE4_CODE',
			site_influence4_code,OtherCharacteristics4);
Codes.Mac_GetPropertyCode(std_asses_wOtherChar4,std_asses_wOtherChar5,Codes.Key_Codes_V3, 'FARES_2580','SITE_INFLUENCE5_CODE',
			site_influence5_code,OtherCharacteristics5);
			

std_asses:=project(std_asses_wOtherChar5,transform(rec_out,self :=left));						

//combine deeds & asses together
std_property := dedup(sort(std_deed & std_asses, ln_fares_id, current), ln_fares_id, current);

RETURN std_property;
END;