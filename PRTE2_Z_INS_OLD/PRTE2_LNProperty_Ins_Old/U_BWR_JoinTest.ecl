//*EXPORT JoinTest := 'todo';
IMPORT PRTE2,PRTE_CSV,PRTE, ut,NID,Doxie,address,_control,PRTE,iesp,ut,Doxie,address,STD,NID,AutoKeyB2,autokey,AutoKeyI;

	ds1  := PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__payload;
	
	OUTPUT (ds1,,'~prte::ct::ln_propertyv2::join::payload',OVERWRITE);
	OUTPUT(COUNT(ds1),NAMED('oldpayload'));	
	
	ds1a  := JOIN(ds1,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__address,
					left.fakeid = right.did,
	/*				and left.person_addr.prim_name = right.prim_name
					and left.person_addr.prim_range = right.prim_range
					and left.person_addr.sec_range = right.sec_range
					and left.person_addr.zip5 = right.zip
					and left.person_addr.st = right.st,		*/	
					left outer
//*					keep(1)
					);
//*	OUTPUT (choosen(ds1a,200));	
	OUTPUT (COUNT(ds1a),NAMED('cntds1a'));
 	OUTPUT (ds1a,,'~prte::ct::ln_propertyv2::join::ds1a::addr',OVERWRITE);	
	
	ds2  := JOIN(ds1a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__addressb2,
					left.fakeid = right.bdid,
																	
	//*						transform(PRTE2.layouts.layout_ln_propertyv2_expanded_payload,
							transform(RECORDOF(DS1a),
							self.bdid := IF(right.bdid != 0, right.bdid, left.bdid),
							self.lookups := right.lookups,
//*							self.cname_indic := right.cname_indic,
//*							self.cname_sec := right.cname_sec,
							self := left),							
					left outer
//*					keep(1)
					);

	OUTPUT (COUNT(ds2),NAMED('cntaddrb2'));
	OUTPUT (choosen(ds2,100),named('addrb2'));
	OUTPUT (ds2,,'~prte::ct::ln_propertyv2::join::ds2::addrb2',OVERWRITE);	
	
	
	ds3  := JOIN(ds2,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__citystname,
	//*				left.city_code = right.city_code
					left.fakeid = right.did,
					left outer
	//*				keep(1)
					);					
	//*OUTPUT (COUNT(ds3),NAMED('cntds3'));
	OUTPUT (ds3,,'~prte::ct::ln_propertyv2::join::ds3::citystn',OVERWRITE);	
	
	ds4  := JOIN(ds3,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__citystnameb2,
					left.fakeid  =  right.bdid,	
						transform(RECORDOF(DS3),
//*							self.bdid := IF (left.bdid = 0, right.bdid, left.bdid),
							self.bdid := IF (right.bdid != 0, right.bdid, left.bdid),
							self.lookups := IF(left.lookups = 0, right.lookups, left.lookups),
							self.city_code := IF(left.city_code = 0, right.city_code,left.city_code),
							self.st := IF(left.st = '', right.st, left.st),
							self.zip := IF(left.zip = '',left.company_addr.zip5,left.zip),
							self.company_addr.st := IF(left.company_addr.st='', right.st, left.st),
							self := left,
							self := []),							
	/*				left.city_code = right.city_code
					and left.st = right.st
					and left.cname_indic = right.cname_indic
					and left.cname_sec = right.cname_sec
					and left.bdid = right.bdid, */
					left outer
	//*				keep (1)
					);
	OUTPUT (choosen(ds4,100),NAMED('citystnb2'));	
	OUTPUT (ds4,,'~prte::ct::ln_propertyv2::join::ds4::citystnb2',OVERWRITE);	
	
	
	//*OUTPUT(choosen(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__name,50),NAMED('autokeyname'));
	ds5  := JOIN(ds4,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__name,
	/*				left.dph_lname = right.dph_lname
					and left.lname = right.lname
					and left.pfname = right.pfname
					and left.fname = right.fname
					and left.dob = right.dob  */
					left.fakeid = right.did,
           	transform(RECORDOF(DS4),				
					    self.lname := right.lname,
							self.fname := right.fname, 
							self.pfname := right.pfname,
							self.dph_lname := right.dph_lname,
							self.dob := right.dob,
							self := left),
	//*						self := []),		
					
					left outer
//*					keep (1)
					);
OUTPUT (ds5,,'~prte::ct::ln_propertyv2::join::ds5::name',OVERWRITE);

		
	ds6 := JOIN(ds5,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__nameb2,
					left.fakeid = right.bdid,	
	/*				left.cname_indic = right.cname_indic
					and left.cname_sec = right.cname_sec
					and left.bdid = right.bdid, */
					left outer,
					keep (1)
					);
OUTPUT (ds6,,'~prte::ct::ln_propertyv2::join::ds6::nameb2',OVERWRITE);
OUTPUT (choosen(ds6,100),named('nameb2'));
					
  ds7 := JOIN(ds6,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__namewords2,
					left.fakeid = right.bdid,	
		/*		left.st = right.state
					and left.bdid = right.bdid, */
					left outer
	//*				keep (1)
					);
	OUTPUT (ds7,,'~prte::ct::ln_propertyv2::join::ds7::words2',OVERWRITE);
	OUTPUT (CHOOSEN(ds7(word != ''),100),NAMED('words2'));
			
	ds8 := JOIN(ds7,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__phone2,
					left.fakeid = right.did,	
					left outer,
					keep (1)
					); 
	OUTPUT (choosen(ds8,100),NAMED('phone2'));		
	OUTPUT (ds8,,'~prte::ct::ln_propertyv2::join::ds8::phone2',OVERWRITE);		
	
	/*
	ds8a := JOIN(ds8,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__phone2,
					left.fakeid = right.did,	
							transform(RECORDOF(DS7),
							self.p3 := right.p3,
							self.p7 := right.p7,
							self := left,
							self := []),						
					
					left outer,
					keep (1)
					); 
	*/
	
	ds9 := JOIN(ds8,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__phoneb2,
				 left.fakeid = right.bdid,
				 				 			 
				 left outer,
				 keep (1)
				 );
	//*OUTPUT (COUNT(ds9),NAMED('cntds9'));	
	OUTPUT (choosen(ds9,100),NAMED('ds9phoneb2'));	
	OUTPUT (ds9,,'~prte::ct::ln_propertyv2::join::ds9::phoneb2',OVERWRITE);	
	
	ds10 := JOIN(ds9,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__stname,
	/*			left.st = right.st
				and left.dph_lname = right.dph_lname
				and left.pfname = right.pfname
				and left.minit = right.minit
				and left.yob = right.yob
				and left.dob = right.dob
				and left.states = right.states */
				left.fakeid = right.did,
	/*				transform(RECORDOF(DS9),
							self.yob := right.yob,
							self := left),*/
							
				left outer,
				keep (1)
				);				
	//*OUTPUT (count(ds10),NAMED('cntds10'));
	OUTPUT (choosen(ds10,100),NAMED('stname'));	
	OUTPUT (ds10,,'~prte::ct::ln_propertyv2::join::ds10::stname2',OVERWRITE);		
	
	ds11 := JOIN(ds10,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__stnameb2,
	/*			left.st = right.st
				and left.cname_indic = right.cname_indic
				and left.cname_sec = right.cname_sec */
				left.fakeid = right.bdid,
				left outer,
				keep (1)
				);
	OUTPUT (count(ds11),NAMED('stnameb2'));
				
	ds12 := JOIN(ds11,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__zip,
				left.fakeid = right.did,	
			
							transform(RECORDOF(DS11),
//*							self.did := IF (right.did != 0, right.did, left.did),
							self.zip := IF(left.zip = '', (string) right.zip,left.zip);
							self.yob := (integer) left.dob [1..4];
							self := left,
							self := []),							
				
				left outer
	//*			keep (1)
				);
//*	OUTPUT (count(ds12),NAMED('cntds12'));	
	OUTPUT (choosen(ds12,100),NAMED('zip'));		
	
	ds13 := JOIN(ds12,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__zipb2,
				left.fakeid = right.bdid,
						transform(RECORDOF(DS12),
							self.bdid := IF (right.bdid != 0, right.bdid, left.bdid),
							self.zip := IF(left.zip = '', (string) right.zip,left.zip);
							self := left,
							self := []),							
				left outer
//*				keep (1)
				);
  OUTPUT(choosen(ds13,100),NAMED('zipb2'));	
	OUTPUT (ds13,,'~prte::ct::ln_propertyv2::join::ds13::zipb2',OVERWRITE);	
	
/*	ds14 := JOIN(ds13,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__namewords2,
				left.bdid = right.bdid,
				left outer,
				keep (1)
				); */
				
	ds15 := JOIN(ds13,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__deed_parcelnum,
			left.ln_fares_id = right.ln_fares_id,
	  	left outer,
			keep (1)
				); 
 //*   OUTPUT (choosen(ds15,100),NAMED('ds15'));	
		OUTPUT (ds15,,'~prte::ct::ln_propertyv2::join::ds15::dparcelnum',OVERWRITE);
		OUTPUT (ds15(ln_fares_id = 'DD0000000354'),NAMED('parcelnum'));	
//*	OUTPUT (count(ds15),NAMED('cntds15'));		
//*	OUTPUT(choosen(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__fid,100),NAMED('fidfile'));
 OUTPUT(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__deed_fid(ln_fares_id = 'DD0000000354'),NAMED('olddeed'));	

//* Do I need a KEEP (1) on this join?	
	ds16  := JOIN(ds15,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__deed_fid,
			left.ln_fares_id = right.ln_fares_id,
			left outer
							);	
	//*	OUTPUT (count(ds16),NAMED('cntds16'));
 OUTPUT (ds16(ln_fares_id = 'DD0000000354'),NAMED('deedfid'));								
 OUTPUT (ds16,,'~prte::ct::ln_propertyv2::join::ds16::fid',OVERWRITE);
 
 	ds16a  := JOIN(ds16,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__deed_fid,
			left.ln_fares_id = right.ln_fares_id,
				transform(RECORDOF(DS16),
				self.state := IF(left.state = '', right.state, left.state),
				self := left,
				self := right),
			left outer
							);	
							
 OUTPUT (ds16a(ln_fares_id = 'DD0000000354'),NAMED('deedfida'));								
 OUTPUT (ds16a,,'~prte::ct::ln_propertyv2::join::ds16a::fid',OVERWRITE);
 
 
/*					transform(RECORDOF(DS15),
							self.state := IF (left.state = '', right.state, left.state),
							self.proc_date := IF (left.proc_date = 0, right.proc_date, left.proc_date),
							self.process_date := IF(left.process_date = 0, right.process_date, left.process-date),
							self.from_file := IF(left.from_file = '', right.from_file, left.from_file),
							self.fips_code := IF(left.fips_code = '', right.fips_code, left.fips_code),
              self.county_name := IF(left.county_name = '', right.county_name, left.county_name),							
							self.fares_unformatted_apn := IF(yleft.fares_unformatted_apn = '', right.fares_unformatted_apn, left.fares_unformatted_apn),
							self.buyer_or_borrower_ind := IF(left.buyer_or_borrower_ind = '', right.buyer_or_borrower_ind, left.buyer_or_borrower_ind),
							self.name1 := IF(left.name1 = '', right.name1, left.name1),
							self.name1-id-code := IF(left.name1_id_code = '', right.name1_id_code,left.name1_id_code),
							self.name2-id-code := IF(left.name2_id_code = '', right.name2_id_code,left.name2_id_code),
							self.mailing_street := IF(left.mailing_street = '', right.mailing_street,left.mailing_street),
							self.mailing_CSZ  := IF(left.mailing_CSZ = '', right.mailing_CSZ, left.mailing_CSZ),
							self.seller1 := IF(left.seller1 = '', right.seller1, left.seller1),
							self.seller_mailing_full_street_address := right.seller_mailing_full_street_addres,
							self.seller_mailing_address_citystatezip := right.seller_mailing_address_citystatezip,
							self.property_full_street_address := IF(left.property_full_street_address = '',right.property_full_street_address,left.property_full_street_address),
							self.property_address_citystatezip := IF(left.property_address_citystatezip = '', right.property_address_citystatezip, left.property_address_citystatezip),
							self.legal_lot_code := IF(left.legal_lot_code = '', right.legal_lot_code, left.legal_lot_code),
							self.legal_city_municipality_township = IF(left.legal_city_municipality_township = '', right.legal_city_municipality_township,
							                                           left.legal_city_municipality_township),
						  self.legal_subdivision_name := IF(left.legal_subdivision_name = '',right.legal_subdivision_name, left.legal_subdivision_name),
							self.contract_date := IF(left.contract_date = '', right.contract_date, left.contract_date),
							
							self := left),
							self := []),	
						left outer
							);	*/	
//*	OUTPUT (count(ds16),NAMED('cntds16'));
 
 
 /*
  ds16a  := JOIN(ds16,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__deed_fid,
			left.ln_fares_id = right.ln_fares_id,
			transform(RECORDOF(DS16),
			self := left,
			self := right),
			left outer
							);	
							
 OUTPUT (ds16a(ln_fares_id = 'DD0000000354'),NAMED('deed16a'));								
 OUTPUT (ds16a,,'~prte::ct::ln_propertyv2::join::dsx16a::fid',OVERWRITE);

 */
	ds17  := JOIN(ds16a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_fid_county,
			left.ln_fares_id = right.ln_fares_id,
			left outer,
			keep (1)
				);		
				
	ds17a  := JOIN(ds17,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_fid_county,
			left.ln_fares_id = right.ln_fares_id,
				transform(RECORDOF(DS17),
				self.p_county_name := right.p_county_name,
				self.o_county_name := right.o_county_name,
				self := left,
				self := right),
			left outer,
			keep (1)
				);		
//*OUTPUT (count(ds17a),NAMED('cntds17a'));	
	OUTPUT (ds17a,,'~prte::ct::ln_propertyv2::join::ds17a::county',OVERWRITE);	

	ds18  := JOIN(ds17a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__assessor_parcelnum,
			left.ln_fares_id = right.ln_fares_id,
				transform(RECORDOF(DS17a),
				self.fares_unformatted_apn := right.fares_unformatted_apn,
				self := left,
				self := right),
			left outer
							);		
OUTPUT (count(ds18),NAMED('cntds18'));	
OUTPUT (ds18,,'~prte::ct::ln_propertyv2::join::ds18::aparcelnum',OVERWRITE);				

 	ds19  := JOIN(ds18,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__addr_search_fid,
			left.ln_fares_id = right.ln_fares_id,
			left outer
							);		
 OUTPUT (count(ds19),NAMED('cntds19'));
 OUTPUT (ds19,,'~prte::ct::ln_propertyv2::join::ds19',OVERWRITE);
 
 
  ds21 := JOIN(ds19,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_bdid,
					left.ln_fares_id = right.ln_fares_id ,
//*			and	left.bdid = right.bdid,
					left outer
//*					keep (1)
					); 
	ds21a := JOIN(ds21,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_bdid,
					left.ln_fares_id = right.ln_fares_id
					and left.source_code = right.source_code, 
//*				and left.bdid = right.bdid,				
								
				transform(RECORDOF(DS21),
				self.s_bid := IF(right.bdid > 0,right.bdid, 0),	
				self.dt_vendor_first_reported := right.dt_vendor_first_reported,
				self.dt_vendor_last_reported  := right.dt_vendor_last_reported,
				self.process_date  := right.process_date,
				self.source_code := right.source_code,
				self.nameasis    := right.nameasis,
				self.msa         := right.msa,
				self.geo_long    := right.geo_long,
				self.geo_lat     := right.geo_lat,
				self.county      := right.county,
				self.rec_type    := right.rec_type,
				self.dbpc        := right.dbpc,
				self.chk_digit   := right.chk_digit,
				self.cart        := right.cart,
				self.cr_sort_sz  := right.cr_sort_sz,
				self.lot         := right.lot,
				self.lot_order   := right.lot_order,
				self.geo_blk     := right.geo_blk,
				self.geo_match   := right.geo_match,
				self.err_stat    := right.err_stat,				
				self.p_city_name := right.p_city_name,
				self.v_city_name := right.v_city_name,
				self.vendor_source_flag := right.vendor_source_flag,
				self := left),
//*				self := []),
									
					left outer,
					keep (1)
					); 
  OUTPUT (ds21a,,'~prte::ct::ln_propertyv2::join::ds21a::bdid',OVERWRITE);	
	OUTPUT(choosen(ds21,100),named('bdid'));
	
	ds22 := JOIN(ds21a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_did,
					left.ln_fares_id = right.ln_fares_id,
					left outer,
					keep (1)
					); 
					
	ds22a := JOIN(ds22,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_did,
					left.ln_fares_id = right.ln_fares_id,
								transform(RECORDOF(DS22),
								self.p_city_name := right.p_city_name,
								self.county      := right.county,
								self.geo_blk     := right.geo_blk,
								self.source_code := right.source_code,
								self := left),
//*								self := []),
					
					left outer,
					keep (1)
					); 			
	
  OUTPUT (ds22a,,'~prte::ct::ln_propertyv2::join::ds22a::sdid',OVERWRITE);
	OUTPUT (ds22a(ln_fares_id = 'OA0041634156'),NAMED('sdidrec'));

  ds23 := JOIN(ds22a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_fid,
					left.ln_fares_id = right.ln_fares_id
					and left.source_code_2 = right.source_code_2
					and left.source_code_1 = right.source_code_1
					and left.lname         = right.lname
					and left.fname         = right.fname,
					left outer,
					keep (1)
					); 
	OUTPUT (ds23,,'~prte::ct::ln_propertyv2::join::ds23::fid',OVERWRITE);					
					
 ds23a := JOIN(ds23,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_fid,
					left.ln_fares_id = right.ln_fares_id
					and left.source_code_2 = right.source_code_2
					and left.source_code_1 = right.source_code_1
					and left.lname         = right.lname
					and left.fname         = right.fname,
					
							transform(RECORDOF(DS22),
								self.dt_vendor_first_reported := right.dt_vendor_first_reported,
								self.dt_vendor_last_reported  := right.dt_vendor_last_reported,
								self.vendor_source_flag       := right.vendor_source_flag,
								self.process_date             := right.process_date,
								self.conjunctive_name_seq     := right.conjunctive_name_seq,
								self.title                    := right.title,
								self.mname                    := right.mname,
								self.nameasis                 := right.nameasis,
								self.cname                    := right.cname,
								self.v_city_name              := right.v_city_name,
								self.zip4                     := right.zip4,
								self.cart        := right.cart,
								self.cr_sort_sz  := right.cr_sort_sz,
								self.lot         := right.lot,
								self.lot_order   := right.lot_order,
								self.dbpc        := right.dbpc,
								self.chk_digit   := right.chk_digit,
								self.rec_type    := right.rec_type,
								self.geo_lat     := right.geo_lat,
								self.geo_long    := right.geo_long,
								self.msa         := right.msa,
								self.geo_match   := right.geo_match,
								self.err_stat    := right.err_stat,
								self.app_tax_Id  := right.app_tax_id,
								self.source_code_1 := right.source_code_1,
								self.source_code_2 := right.source_code_2,
								self.source_code   := right.source_code,
								self := left),
	//*							self := []),
					
					
					left outer,
					keep (1)
					); 
						
 OUTPUT (ds23a,,'~prte::ct::ln_propertyv2::join::ds23a::fid',OVERWRITE);	
//* OUTPUT (ds23a(bdid=6110));
 OUTPUT (ds23a(ln_fares_id='DA0000006872' or ln_fares_id = 'RA1939707938'),NAMED('DS23arec'));
 
//* OUTPUT(COUNT(ds23a),NAMED('cntds23a'));	



	
	
	ds24 := JOIN(ds23a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__assessor_fid,
					left.ln_fares_id = right.ln_fares_id, 
					left outer,
					keep (1)
					); 
  OUTPUT (ds24,,'~prte::ct::ln_propertyv2::join::ds24',OVERWRITE);	
	
	
	ds25 := JOIN(ds24,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__ssn2,
					left.fakeid = right.did,
					transform(PRTE2.layouts.layout_ln_propertyv2_expanded_payload,
//*				self.did := (integer)IF(right.did <> 0,right.did,left.did),
					self.lookups := IF(left.lookups = 0,right.lookups,left.lookups),
					self.s_did :=  left.did,
					self.s1 := right.s1,
					self.s2 := right.s2,
					self.s3 := right.s3,
//*					self.s4 := right.s4,
					self.s5 := right.s5,
					self.s6 := right.s6,
					self.s7 := right.s7,
					self.s8 := right.s8,
					self.s9 := right.s9,
//*					self.p_county_name := left.county_name,
//*					self.o_county_name := left.county_name,
					self.st  := left.st,
					self.rec_type := left.rec_type,
					self := left),
//*					self := []),
					left outer,
					keep (1)
					);
  OUTPUT (ds25,,'~prte::ct::ln_propertyv2::join::ds25::ssn2',OVERWRITE);
  OUTPUT (ds25(ln_fares_id='OA0041634156'),NAMED('ds25rec'));	 


	