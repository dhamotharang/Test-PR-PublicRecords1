//* Scramble - scramble the LN_Property test file	
//OBSOLETE LINDA CAIN CODE - see PRTE2_X_Ins_PropertyScramble.Scramble_LNP
IMPORT PRTE2,ut;
#WORKUNIT ('name', 'Scramble LN_Property');

//* In Dev, uncomment the ut.foreign_prod thus:
//*  testds := DATASET(ut.foreign_prod +  '~thor400_20::prct_pii::in::custtest::LNPROPERTY4',PRTE2.Layouts.batch_in_LNProperty,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(62768)));
	testds := DATASET(/*ut.foreign_prod + */ '~thor400_20::prct_pii::in::custtest::LNPROPERTY4',PRTE2.Layouts.batch_in_LNProperty,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(62768)));
  LNPropertyRec      := RECORD
	  PRTE2.layouts.LN_Property_W_SEQ
  END;
	
 Sorted_Testds   := SORT(testds, address, apt, city, st, zip);
 OUTPUT(choosen(Sorted_Testds,350),named('sorted'));
 Max_Orig 			 := COUNT(sorted_Testds);
 OUTPUT(max_orig, named('maxorig'));
 
 LN_Test_Deduped := DEDUP(Sorted_Testds,address,apt,city,st,zip);
 
 Max_Seq         := COUNT(LN_Test_Deduped);
 
 LNPropertyRec   AddSeqNo (LN_Test_Deduped L, integer C) := TRANSFORM
		self.old_seq_no     := (unsigned) C;
		new_seq             := (unsigned) C + 1;
		self.new_seq_no     := IF(new_seq > Max_seq, 1, new_seq);
		SELF                := L;
		SELF                := [];
	END;
Sequenced_DS          := PROJECT(LN_Test_Deduped, AddSeqNo (Left, Counter));
OUTPUT (choosen(Sequenced_DS,350),named('seqnd'));
OUTPUT(choosen(Sequenced_DS(fname = 'NORDELL'),10),named('nordell'));
	
//* Join the sorted ln property to the file of addresses with sequence numbers,
//* appending the seq nos to the sorted LN_Property file).
LNProperty_W_Seq := JOIN(Sorted_testds, Sequenced_DS,
		left.address  = right.address and
		left.apt      = right.apt and
		left.city     = right.city and
		left.st       = right.st and
		left.zip      = right.zip,  
		
		transform(LNPropertyRec,
				self.old_seq_no := right.old_seq_no,
				self.new_seq_no := right.new_seq_no,
				SELF            := left),
		left outer
		);
OUTPUT(choosen(LNProperty_W_Seq,350), named('wseq'));
		


//* Now Join and Scrambled Addresses:

LN_Property_PreScrambled  := JOIN(LNProperty_W_Seq,LNProperty_W_Seq,
		left.new_seq_no     =  right.old_seq_no, 
//*		and left.ln_fares_id    = right.ln_fares_id,
			transform(LNPropertyRec,
//* N O T E:  should this be reversed?   N & A from the left,
//*        and data from the right?????????????????????/			  
			  self.old_seq_no := left.old_seq_no,
				self.new_seq_no := left.new_seq_no,
				self.fname      := left.fname,
				self.mname      := left.mname,
				self.lname      := left.lname,
				self.address    := left.address,
				self.apt        := left.apt,
				self.city       := left.city,
				self.st         := left.st,
				self.zip        := left.zip,
				self.deed_state := left.deed_state,
				self.deed_county_name 				:= left.deed_county_name,
				self.deed_lender_full_st_addr := left.deed_lender_full_st_addr,
				self.deed_lender_addr_unit_no := left.deed_lender_addr_unit_no,
				self.deed_lender_addr_citystatezip := left.deed_lender_addr_citystatezip,
				self.deed_legal_city_municipal_town := left.deed_legal_city_municipal_town,
				self.deed_legal_unit 					:= left.deed_legal_unit,
				self.assess_state_code 				:= left.assess_state_code,
				self.assess_county_name				 := left.assess_county_name,
				self.assess_legal_city_municipal_township := left.assess_legal_city_municipal_township,
				self.assess_census_tract 			:= left.assess_census_tract,
				self.property_address1 				:= left.property_address1,
				self.property_address2 				:= left.property_address2,
				self.property_p_city_name 		:= left.property_p_city_name,
				self.property_v_city_name 		:= left.property_v_city_name,
				self.property_st 							:= left.property_st,
				self.property_zip 						:= left.property_zip,
				self.property_zip4 						:= left.property_zip4,
				self.property_county_name 		:= left.property_county_name,
				self.property_geo_lat 				:= left.property_geo_lat,
				self.property_geo_long 				:= left.property_geo_long,
				self.property_orig_address 		:= left.property_orig_address,
				self.property_orig_unit 			:= left.property_orig_unit,
				self.property_orig_csz  			:= left.property_orig_csz,
				
				self.owner_phone_number := left.owner_phone_number,
				self.owner_p_city_name  := left.owner_p_city_name,
				self.owner_v_city_name  := left.owner_v_city_name,
				self.owner_st           := left.owner_st,
				self.owner_zip          := left.owner_zip,
				self.owner_zip4         := left.owner_zip4,
				self.owner_county_name  := left.owner_county_name,
				self.owner_orig_address := left.owner_orig_address,
				self.owner_orig_unit    := left.owner_orig_unit,
				self.owner_orig_csz     := left.owner_orig_csz,
				self.owner_1_orig_name  := left.owner_1_orig_name,
				self.owner_1_title      := left.owner_1_title,
				self.owner_1_first_name := left.owner_1_first_name,
				self.owner_1_middle_name := left.owner_1_middle_name,
				self.owner_1_last_name  := left.owner_1_last_name,
				self.owner_1_name_suffix := left.owner_1_name_suffix,
				self.owner_1_did        := left.owner_1_did,
				self.owner_1_bdid       := left.owner_1_bdid,
				self.owner_1_ssn        := left.owner_1_ssn,
				self.owner_2_orig_name  := left.owner_2_orig_name,
				self.owner_2_title      := left.owner_2_title,
				self.owner_2_first_name := left.owner_2_first_name,
				self.owner_2_middle_name := left.owner_2_middle_name,
				self.owner_2_last_name  := left.owner_2_last_name,
				self.owner_2_name_suffix := left.owner_2_name_suffix,
				self.owner_2_did        := left.owner_2_did,
				self.owner_2_bdid       := left.owner_2_bdid,
				self.owner_2_ssn        := left.owner_2_ssn,
				
				
				self.assessee_orig_address := left.assessee_orig_address,
				self.assessee_orig_unit    := left.assessee_orig_unit,
				self.assesee_orig_csz     := left.assesee_orig_csz,
				self.assessee_zip          := left.assessee_zip,
				self.assessee_zip4         := left.assessee_zip4,
				self.assessee_county_name  := left.assessee_county_name,
								
				self.assessee_address1     := left.assessee_address1,
				self.assessee_address2     := left.assessee_address2,
				self.assessee_phone_number := left.assessee_phone_number,
				self.owner_1_company_name  := left.owner_1_company_name,
				self.owner_2_company_name  := left.owner_2_company_name,
										
				self.buyer_address1				  := left.buyer_address1,
				self.buyer_address2 				:= left.buyer_address2,
				self.buyer_p_city_name 			:= left.buyer_p_city_name,
				self.buyer_v_city_name 			:= left.buyer_v_city_name,
				self.buyer_st 							:= left.buyer_st,
				self.buyer_zip 							:= left.buyer_zip,
				self.buyer_zip4 						:= left.buyer_zip4,
				self.buyer_county_name 			:= left.buyer_county_name,
//*				self.buyer_geo_lat 					:= left.buyer_geo_lat,
//*				self.buyer_geo_long 				:= left.buyer_geo_long,
				self.buyer_orig_address 		:= left.buyer_orig_address,
				self.buyer_orig_unit 				:= left.buyer_orig_unit,
				self.buyer_orig_csz 				:= left.buyer_orig_csz,
				self.seller_address1 				:= left.seller_address1,
				self.seller_address2 				:= left.seller_address2,
				self.seller_p_city_name			:= left.seller_p_city_name,
				self.seller_v_city_name 		:= left.seller_v_city_name,
				self.seller_st 							:= left.seller_st,
				self.seller_zip 						:= left.seller_zip,
				self.seller_zip4 						:= left.seller_zip4,
				self.seller_county_name 		:= left.seller_county_name,
//*				self.seller_geo_lat 				:= left.seller_geo_lat,
//*				self.seller_geo_long 				:= left.seller_geo_long,
				self.seller_orig_address 		:= left.seller_orig_address,
				self.seller_orig_unit 			:= left.seller_orig_unit,
				self.seller_orig_csz 				:= left.seller_orig_csz,
				self := right),
			left outer
			);

OUTPUT(choosen(LN_Property_PreScrambled,350),named('prescrm'));

/*							
//*Deduped_LN_Property_preScrambled  := DEDUP(LN_Property_PreScrambled,RECORD);
Sorted_LN_Property_preScrambled	:= SORT(LN_Property_PreScrambled, address, apt, city, st, zip);
OUTPUT (choosen(sorted_ln_property_prescrambled,150),named('srtscrmb'));

//* Now Join without the ln_fares_id for the non-matches:
//*LNProperty_Scrambled   := JOIN (Deduped_LN_Property_preScrambled,LNProperty_W_Seq,
//*		left.new_seq_no = right.old_seq_no,
LNProperty_Scrambled   := JOIN (Sorted_LN_Property_preScrambled,Sorted_Testds,
	  left.address = right.address and
		left.apt = right.apt and
		left.city = right.city and	
		left.st   = right.st and
		left.zip = right.zip,		
		
			transform(LNPropertyRec,
				self.old_seq_no := left.old_seq_no,
				self.new_seq_no := left.new_seq_no,
				self.ln_fares_id :=left.ln_fares_id,
	//*				self.address := IF(left.address > '', left.address, right.address),
	//*				self.city    := IF(left.city > '', left.city, right.city),
	//*				self.st      := IF(left.st > '', left.st, right.st),
	//*				self.zip     := IF(left.zip > '', left.zip, right.zip),
					
				self.deed_state										 := left.deed_state,
				self.deed_county_name 						 := left.deed_county_name,
				self.deed_lender_full_st_addr 		 := left.deed_lender_full_st_addr,
				self.deed_lender_addr_unit_no  	   := left.deed_lender_addr_unit_no,
				self.deed_lender_addr_citystatezip  := left.deed_lender_addr_citystatezip,
				self.deed_legal_city_municipal_town := left.deed_legal_city_municipal_town,
				self.deed_legal_unit 								:= left.deed_legal_unit,	
				
				self.assess_state_code  := left.assess_state_code,
				self.assess_county_name := left.assess_county_name,
					
										
					
					self := left),
			left outer
			);
OUTPUT(choosen(LNProperty_Scrambled,350),named('scrmbld'));
*/		
Sorted_LN_Scrambled     := SORT(LN_Property_PreScrambled,
															 address, apt, city, st, zip, ln_fares_id);
OUTPUT(choosen(Sorted_LN_Scrambled,350),named('sortpre'));

Deduped_Property_info_Scrambled := DEDUP(Sorted_LN_Scrambled,address, apt, city, st, zip, ln_fares_id);
OUTPUT(choosen(Deduped_Property_info_Scrambled,350),named('dedscrm'));
OUTPUT(Deduped_Property_Info_Scrambled,,'~prte::in::ct::ln_propertyv2::deduped',OVERWRITE);

LN_Scrambled  := '~prte::in::ct::csv::scrambled::ln_propertyv2';
PII_Scrambled_DS  := DATASET(LN_Scrambled,
											prte2.layouts.batch_in_LNProperty,CSV(Heading(1),QUOTE('"'),MAXLENGTH(62768)));
//* remove sequence numbers
PRTE2.Layouts.batch_in_LNProperty WOSeqNo (Deduped_Property_Info_Scrambled l) := TRANSFORM
		self := L,
		SELF := [],
END;
Unsequenced_DS  := PROJECT(Deduped_Property_Info_Scrambled, WOSeqNo (LEFT));

max_final := COUNT(Unsequenced_DS);
OUTPUT (max_final, named('maxfinal'));

//* write out the final descrambled file
OUTPUT(Unsequenced_DS,, LN_Scrambled,
					CSV(Heading(Single), QUOTE('"'), Separator(','),NOTRIM), OVERWRITE);
OUTPUT(choosen(Unsequenced_DS,350),NAMED('finalds'));
//* end of Scramble
