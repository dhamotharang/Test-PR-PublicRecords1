//*EXPORT Backup_Get_Payload := 'todo';
//*   PRTE2_LNProperty.Get_payload,   JOIN the LNProperty files
//* For LN_Property, join the current files into an expanded payload record
//* 
IMPORT PRTE2,PRTE_CSV,PRTE, ut,NID,Doxie,address,_control,PRTE,iesp,ut,Doxie,address,STD,NID,AutoKeyB2,autokey,AutoKeyI;

EXPORT Get_payload 																:= MODULE
	EXPORT LNPROPERTYV2 				:= FUNCTION
	

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
				self.vendor_source_flag := right.vendor_source_flag,
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
 ds19a := DEDUP(ds19,RECORD,ALL);
 /*
 	ds20 := JOIN(ds19,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__ssn2,
					left.fakeid = right.did,
					transform(layouts.layout_ln_propertyv2_expanded_payload,
				self.did := (integer)IF(left.did <> 0,left.did,right.did),
				self.lookups := right.lookups,
				self := left),
					left outer,
					keep (1)
					);
  OUTPUT (ds20,,'~prte::ct::ln_propertyv2::join::ds20',OVERWRITE);
//*OUTPUT(ds20(ln_fares_id='OA0041634156'),NAMED('ds20lnfaresid'));	 					
*/	
fBDID := PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_bdid;
OUTPUT (choosen(fBDID(ln_fares_id = 'OA0041634156'),10),NAMED('inputBDID'));	
				
  ds21 := JOIN(ds19a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_bdid,
					left.ln_fares_id = right.ln_fares_id
					and left.source_code_1 = right.source_code[1..1]
					and left.source_code_2 = right.source_code[2..2],
//*					and left.vendor_source_flag = right.vendor_source_flag,
					//*			and	left.bdid = right.bdid,
					left outer
//*					keep (1)
					); 
					
OUTPUT(ds21(ln_fares_id='OA0041634156'),NAMED('ds21bdid'));	

	ds21a := JOIN(ds21,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_bdid,
					left.ln_fares_id = right.ln_fares_id
					and left.source_code = right.source_code
					and left.vendor_source_flag = right.vendor_source_flag, 
//*				and left.bdid = right.bdid,				
								
				transform(RECORDOF(DS21),
				self.bdid := IF(right.bdid > 0, right.bdid,left.bdid),
				self.s_bid := IF(right.bdid > 0,right.s_bid, left.s_bid),	
				self.dt_vendor_first_reported := right.dt_vendor_first_reported,
				self.dt_vendor_last_reported  := right.dt_vendor_last_reported,
				self.process_date  := right.process_date,
//*				self.source_code := right.source_code,
				self.nameasis    := right.nameasis,
				self.conjunctive_name_seq := right.conjunctive_name_seq,
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
//*				self.vendor_source_flag := right.vendor_source_flag,
				self := left),
//*				self := []),
								
					left outer,
					keep (1)
					); 
  OUTPUT (ds21a,,'~prte::ct::ln_propertyv2::join::ds21a::bdid',OVERWRITE);	
	OUTPUT(choosen(ds21(ln_fares_id='OA0041634156'),100),named('ds21abdid'));
	
	ds22 := JOIN(ds21a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_did,
					left.ln_fares_id = right.ln_fares_id,
					left outer,
					keep (1)
					); 
					
	ds22a := JOIN(ds22,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_did,
					left.ln_fares_id = right.ln_fares_id,
//*					and left.source_code = right.source_code,
								transform(RECORDOF(DS22),
								self.p_city_name := IF(left.p_city_name = '', right.p_city_name,left.p_city_name),
								self.county      := IF(left.county = '', right.county,left.county),
								self.st          := IF(left.st = '',IF(right.st = '', left.person_addr.st, right.st),left.st),
  //*								self.state       := IF(left.state = '', left.person_addr.state, right.state),
								self.suffix      := IF(left.suffix = '', IF(right.suffix = '', left.person_addr.addr_suffix, right.suffix), left.suffix),
								self.geo_blk     := IF(left.geo_blk = '', right.geo_blk,left.geo_blk),
								self.source_code := IF(left.source_code = '', right.source_code,left.source_code),
	//*							self.source_code_1 := IF(left.source_code_1 = '', right.source_code_1,left.source_code_1),
								self.source_code_2 := IF(left.source_code_2 = '', right.source_code_2,left.source_code_2),		
								self.v_city_name   := IF(left.v_city_name = '', IF(left.p_city_name = '', left.person_addr.v_city_name,left.p_city_name),left.v_city_name),
	//*							self.zip4           := IF(left.zip4 = '', right.zip4,left.zip4),
	//*							self.cart        := IF(left.cart = '',right.cart,left.cart),
	//*							self.cr_sort_sz  := IF(left.cr_sort_sz = '', right.cr_sort_sz,left.cr_sort_sz),
	//*							self.lot         := IF(left.lot = '', right.lot,left.lot),
	//*							self.lot_order   := IF(left.lot_order = '', right.lot_order,left.lot_order),
	//*							self.dbpc        := IF(left.dbpc = '', right.dbpc,left.dbpc),
	//*							self.chk_digit   := IF(left.chk_digit = '', right.chk_digit,left.chk_digit),
	//*							self.rec_type    := IF(left.rec_type = '',right.rec_type,left.rec_type),
								self.geo_lat     := IF(left.geo_lat = '', left.person_addr.geo_lat,left.geo_lat),
								self.geo_long    := IF(left.geo_long = '', left.person_addr.geo_long,left.geo_long),
	//*							self.msa         := IF(left.msa = '',right.msa,left.msa),
								self.geo_match   := IF(left.geo_match = '',left.person_addr.geo_match,left.geo_match),
								self.err_stat    := IF(left.err_stat = '', left.person_addr.err_stat,left.err_stat),
															
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
//*					and left.source_code = right.source_code
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
					
							transform(RECORDOF(DS23),
								self.dt_vendor_first_reported := IF(left.dt_vendor_first_reported = 0,right.dt_vendor_first_reported,left.dt_vendor_first_reported),
								self.dt_vendor_last_reported  := IF(left.dt_vendor_last_reported = 0, right.dt_vendor_last_reported,left.dt_vendor_last_reported),
								self.vendor_source_flag       := IF(left.vendor_source_flag = '', right.vendor_source_flag,left.vendor_source_flag),
								self.process_date             := IF(left.process_date = '', right.process_date,left.process_date),
								self.conjunctive_name_seq     := IF(left.conjunctive_name_seq = '', right.conjunctive_name_seq,left.conjunctive_name_seq),
								self.title                    := IF(left.title = '',right.title,left.title),
								self.mname                    := IF(left.mname = '', right.mname,left.mname),
								self.nameasis                 := IF(left.nameasis = '',right.nameasis,left.nameasis),
								self.cname                    := IF(left.cname = '',right.cname,left.cname),
								self.v_city_name              := IF(left.v_city_name = '', left.p_city_name,left.v_city_name),
								self.prim_range               := IF(left.prim_range = '', right.prim_range,left.prim_range),
								self.prim_name                := IF(left.prim_name = '', right.prim_name, left.prim_name),
								self.st                       := IF(left.st = '', right.st, left.st),	
								self.zip4                     := IF(left.zip4 = '', right.zip4,left.zip4),
								self.cart        := IF(left.cart = '',right.cart,left.cart),
								self.cr_sort_sz  := IF(left.cr_sort_sz = '', right.cr_sort_sz,left.cr_sort_sz),
								self.lot         := IF(left.lot = '', right.lot,left.lot),
								self.lot_order   := IF(left.lot_order = '', right.lot_order,left.lot_order),
								self.dbpc        := IF(left.dbpc = '', right.dbpc,left.dbpc),
								self.chk_digit   := IF(left.chk_digit = '', right.chk_digit,left.chk_digit),
								self.rec_type    := IF(left.rec_type = '',right.rec_type,left.rec_type),
								self.geo_lat     := IF(left.geo_lat = '', right.geo_lat,left.geo_lat),
								self.geo_long    := IF(left.geo_long = '', right.geo_long,left.geo_long),
								self.msa         := IF(left.msa = '', right.msa,left.msa),
								self.geo_match   := IF(left.geo_match = '',right.geo_match,left.geo_match),
								self.err_stat    := IF(left.err_stat = '', right.err_stat,left.err_stat),
								self.app_tax_Id  := IF(left.app_tax_id = '',right.app_tax_id,left.app_tax_id),
								self.source_code_1 := IF(left.source_code_1 = '', right.source_code_1,left.source_code_1),
								self.source_code_2 := IF(left.source_code_2 = '', right.source_code_2,left.source_code_2),
								self.source_code   := IF(left.source_code = '', right.source_code,left.source_code),
								self := left),
	//*							self := []),
					
					
					left outer,
					keep (1)
					); 
						
 OUTPUT (ds23a,,'~prte::ct::ln_propertyv2::join::ds23a::fid',OVERWRITE);	
//* OUTPUT (ds23a(bdid=6110));
 OUTPUT (ds23a(ln_fares_id='DA0000006872' or ln_fares_id = 'RA1939707938'),NAMED('DS23arec'));
 
//* OUTPUT(COUNT(ds23a),NAMED('cntds23a'));	


/*EXPORT  ds23a := JOIN(ds23,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__namewords2,
//*					left.st = right.state
					left.bdid = right.bdid,	
					transform(PRTE2.layouts.layout_ln_propertyv2_expanded_payload,
							self.word := right.word,
							self.seq := right.seq,
							self := left), *										
					left outer,
					keep (1)
					);
	OUTPUT(COUNT(ds23a),NAMED('cntds23a'));	*/
	
	
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
//*					self.s4 := IF(left.s4 = '', right.s4,left.s4),
					self.s5 := right.s5,
					self.s6 := right.s6,
					self.s7 := right.s7,
					self.s8 := right.s8,
					self.s9 := right.s9,
//*					self.p_county_name := left.county_name,
//*					self.o_county_name := left.county_name,
//*					self.st  := IF(left.st = '', right.st, left.st),
//*					self.rec_type := IF(left.rec_type = '', left.rec_type,right.rec_type),
					self := left),
//*					self := []),
					left outer,
					keep (1)
					);
  OUTPUT (ds25,,'~prte::ct::ln_propertyv2::join::ds25::ssn2',OVERWRITE);
  OUTPUT (ds25(ln_fares_id='OA0041634156'),NAMED('ds25rec'));	 

/*
	 ds24  := JOIN(ds23a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__addressb2,
					left.bdid = right.bdid,
												
							transform(PRTE2.layouts.layout_ln_propertyv2_expanded_payload,
							self.bdid := right.bdid,
							self.cname_indic := right.cname_indic,
							self.cname_sec := right.cname_sec,
							self := left,
							self := []),
							
					left outer,
					keep(1)
					);	
	OUTPUT (ds24,,'~prte::ct::ln_propertyv2::join::ds24',OVERWRITE);	
  OUTPUT (count(ds24),NAMED('cntds24'));		
	*/
/*	
	ds25  := JOIN(ds23,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__citystnameb2,
	        left.city_code = right.city_code,
					and left.st = right.st
					and left.cname_indic = right.cname_indic
					and left.cname_sec = right.cname_sec 
					left.bdid = right.bdid, 
					left outer,
					keep (1)
					);
  //*OUTPUT (count(ds25),NAMED('cntds25'));	
	//*OUTPUT (ds25,,'~prte::ct::ln_propertyv2::join::ds25',OVERWRITE);	*/
	
/*	
	ds26 := JOIN(ds25,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__nameb2,
//*					left.cname_indic = right.cname_indic
//*					and left.cname_sec = right.cname_sec
					left.bdid = right.bdid,
					left outer,
					keep (1)
					);
OUTPUT(COUNT(ds26),NAMED('cntds26'));		
OUTPUT (ds26,,'~prte::ct::ln_propertyv2::join::ds26',OVERWRITE);
*/
	
/*EXPORT  ds27 := JOIN(ds26,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__namewords2,
//*					left.st = right.state
					left.bdid = right.bdid,
					
							
							transform(PRTE2.layouts.layout_ln_propertyv2_expanded_payload,
							self.word := right.word,
							self.seq := right.seq,
							self := left), 
					
					
					left outer,
					keep (1)
					);
	OUTPUT(COUNT(ds27),NAMED('cntds27'));	*/
	
//*l:=PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__payload(foreclosure_id<>'');
//*l:=ds16(foreclosure_id<>'');
//*r:=PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__bdid(fid<>'');
	
//*	ds17 := JOIN(ds16,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__bdid,
//*left.foreclosure_id = right.fid,
/* EXPORT	ds18 := join(ds16,r
		,left.fid=right.fid,
//* 			,transform({ {l.foreclosure_id} left_, {r.fid} right_}
			,self.left_ := left
			,self.right_ := right) 
				transform(layouts.layout_ln_propertyv2_expanded_payload,
				self.bdid := right.bdid,
				self.s4 := (string)left.ssn[4..4],
				self.ssn4 := (integer)left.ssn[6..9],
				self := left),
				left outer,
				keep (1)
				); */
				
		/*	,transform({ {l.foreclosure_id} left_, {r.fid} right_}
			,self.left_ := left
			,self.right_ := right) */

/*				transform({{l.foreclosure_id}left_,{r.fid}right_},
				self.left_ := left,
				self.right_ := right));	*/
//*				,left.foreclosure_id=right.fid
/*			transform({ {l.foreclosure_id} left_, {r.fid} right_}
			,self.left_ := left
			,self.right_ := right
			));*/
/*				transform(layouts.layout_foreclosure_expanded_payload,
				self.bdid := right.bdid,
				self.s4 := (string)left.ssn[4..4],
				self.ssn4 := (integer)left.ssn[6..9],
				self := left),
				left outer,
				keep (1)
				); */
/*EXPORT	ds18 := JOIN(ds17,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__yyyyyy,
//*			left.foreclosure_id = right.fid,
			left.fid = right.fid,
			transform(layouts.layout_ln_propertyv2_expanded_payload,
				self.did := (integer)IF(left.did <> 0,left.did,right.did),
				self := left),
				
			left outer,
			keep (1)
				); 	*/
 //* OUTPUT (ds16,,'~prte::ct::foreclosure::join::all',OVERWRITE);		
//*OUTPUT (CHOOSEN(ds16,200));	

//*EXPORT ds19 := dedup(project(ds18,layouts.layout_foreclosure_expanded_payload),record,all);
			
/*	
	layouts.layout_ln_propertyv2_expanded_payload PROJ_RECS(ds18 l) := transform
	    self.ssn4 := (integer)l.ssn [6..9];  
			self.s4 := (string)l.ssn[4..4];
			self := l;
			self := [];
	end;

	retds := project(ds18,PROJ_RECS(left));  */
		
	EXPORT retds_ln_propertyv2 := ds25;
	OUTPUT (choosen(retds_ln_propertyv2,200));
	
	//* OUTPUT (choosen(ds1,100),NAMED('ds1'));
		 /*OUTPUT (choosen(ds6,100),NAMED('ds6'));
	 OUTPUT (choosen(ds7,100),NAMED('ds7'));
	 	 OUTPUT (choosen(ds11,100),NAMED('ds11'));*/
	//*OUTPUT (choosen(ds12,100),NAMED('ds12'));
	  //*	 OUTPUT (choosen(ds16(foreclosure_id='2031155051RBSCITIZENSNA'),10));
	//* OUTPUT(choosen(ds17(bdid=999900453802),10));
	//* OUTPUT(choosen(ds17(fid='2031155051RBSCITIZENSNA'),10));
	//* OUTPUT (retds,,'~prte::ct::ln_propertyv2::join::retds',OVERWRITE);	
	
	  RETURN retds_ln_propertyv2;
		END;
//*	END;

//* ===============================================================================*//
//* Get the new Customer Test LN_Property records                                  *//
//* ===============================================================================*//	
 EXPORT NEW_LNPROPERTYV2 (STRING pindexversion)					:= FUNCTION
 SHARED string8 today_date := ut.GetDate; 

//* change the file name when you get the new test file and spray it:
 SHARED	testds := DATASET('~thor40_241_7::prct_pii::in::custtest::LNPROPERTY4',PRTE2.Layouts.batch_in_LNProperty,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(62768)));
 //*OUTPUT(choosen(testds,150)); 
  LNPropertyRec      := RECORD
		PRTE2.layouts.layout_LN_PropertyV2_expanded_payload;
 END;
 //*ds_inLayoutMaster_AKB :=  project(testds, transform(LNPropertyRec,	
	LNPropertyRec  Reformat_TESTDS (testds L, Integer C) := TRANSFORM
	 string clean_address := address.CleanAddress182(l.address, l.city + ' ' + l.st + ' ' + l.zip);
 	 SELF.fakeid     := (unsigned) 16000000 + C;  
	 SELF.zero       := (unsigned1)0;
	 SELF.prim_name  :=  clean_address [13..40];
	 SELF.prim_range := clean_address [1..10];
//*	 SELF.sec_range  := clean_address [57..64];	
	 SELF.sec_range  := L.Apt;
	 SELF.city_code  := doxie.Make_CityCode(L.city);
	 SELF.st         := IF(clean_address [115..116] > ' ',clean_address [115..116],L.st);
	 self.state      := IF(clean_address [115..116] > ' ',clean_address [115..116],L.st);
	 self.zip        := clean_address[117..121]; 
	 self.zip4       := clean_address[122..125];
	 SELF.phone      := L.deed_phone_number;
	 SELF.dph_lname  := metaphonelib.DMetaPhone1(l.lname);
	 SELF.pfname     := NID.PreferredFirstVersionedStr(L.fname,2);
	 SELF.minit      := L.mname [1..1];
	 SELF.msa        := clean_address [167..170];
	 SELF.err_stat   := clean_address[179..182];
	 SELF.cart       := clean_address[126..129];
	 SELF.cr_sort_sz := clean_address[130];
	 SELF.lot        := clean_address[131..134];
	 SELF.lot_order  := clean_address[135];
	 SELF.dbpc       := clean_address[136..137];
	 SELF.chk_digit  := clean_address[138];
	 SELF.rec_type   := clean_address[139..140];
	 SELF.county     := clean_address[141..145];
	 self.geo_lat    := clean_address[146..155];
	 self.geo_long   := clean_address[156..166];
	 SELF.geo_blk    := clean_address[171..177];
	 SELF.geo_match  := clean_address[178];
	 SELF.p_city_name := clean_address[65..89];
	 SELF.v_city_name := clean_address[90..114];
	 self.s4         := (unsigned) l.ssn[6..9];
	 SELF.yob        := (unsigned2) L.DOB [1..4];
	 SELF.DOB        := (unsigned4) L.DOB;
	 self.s1         :=  l.ssn[1..1];
	 self.s2         :=  l.ssn[2..2];
	 self.s3         :=  l.ssn[3..3];
 	 
	 self.s5         :=  l.ssn[5..5]; 
	 self.s6         :=  l.ssn[6..6];
	 self.s7         :=  l.ssn[7..7];
	 self.s8         :=  l.ssn[8..8];
	 self.s9         :=  l.ssn[9..9];		
	 
	 SELF.which_orig := 'T';
	 SELF.dt_first_seen            := (unsigned)today_date[1..6];
	 SELF.dt_last_seen             := (unsigned)today_date[1..6];
	 SELF.dt_vendor_first_reported := (unsigned)today_date[1..6];
	 SELF.dt_vendor_last_reported  := (unsigned)today_date[1..6];
	 SELF.vendor_source_flag       := L.fid_type;
	 SELF.process_date             := today_date;
	 SELF.source_code_2            := 'P';
	 SELF.source_code_1            := 'O';
	 SELF.source_code   := 'OP';
	 SELF.app_tax_id  := L.deed_tax_id_number;
	 SELF.app_ssn     := L.ssn;
	 SELF.person_name.fname := L.fname;
	 SELF.person_name.mname := L.mname;
	 SELF.person_name.lname := L.lname;
	 self.nameasis  := IF(l.mname > '', TRIM(L.fname) + ' ' + TRIM(L.mname)  + ' ' + TRIM(l.lname),
	                              TRIM(L.fname)  + ' ' + TRIM(L.lname));
	 SELF.person_addr.prim_range   := clean_address [1..10];
	 SELF.person_addr.predir       := clean_address[11..12];
	 SELF.person_addr.prim_name    := clean_address [13..40];
	 SELF.person_addr.addr_suffix  := clean_address [41..44];
	 Self.person_addr.postdir      := clean_address [45..46];
	 SELF.person_addr.unit_desig   := clean_address [47..56];
//*	 SELF.person_addr.sec_range    := clean_address [57..64];
	 SELF.person_addr.sec_range    := L.Apt;
	 SELF.person_addr.st := IF(clean_address [115..116] > ' ',clean_address [115..116],L.property_st);
	 SELF.person_addr.zip5 := IF( clean_address [117..121] > '0', (string5) clean_address [117..121], L.zip);
	 SELF.person_addr.zip4 := IF (clean_address [122..125] > '0', (string) clean_address [122..125], (string) L.property_zip4);
	 SELF.person_addr.geo_lat      := L.property_geo_lat;
	 SELF.person_addr.geo_long     := L.property_geo_long;
	 SELF.person_addr.fips_state   := clean_address[141..142];
	 SELF.person_addr.fips_county  := clean_address[143..145];
	 SELF.person_addr.v_city_name  := IF (clean_address [90..114] > '', clean_address [90..114], L.property_v_city_name);
   SELF.person_addr.err_stat 		:=  clean_address [179..182];	
	 SELF.person_addr.geo_blk			:= 	clean_address [171..177];
	 SELF.person_addr.geo_match		:= 	clean_address [178];
	 SELF.person_addr.cbsa					:= 	clean_address [167..170];
	 SELF.predir                   :=  clean_address[11..12];
	 SELF.postdir                  :=  clean_address [45..46];
	 SELF.suffix                   := clean_address [41..44];
	 SELF.proc_date                := (unsigned8) pIndexVersion [1..8];
	 SELF.current_record           := 'Y';
	 SELF.from_file                := IF (L.fid_type = 'A', 'F', 'D');
	 SELF.fips_code                := IF(L.Deed_fips_code > '', L.Deed_fips_code, L.assess_fips_code);
	 SELF.state_code               := L.assess_state_code;
	 SELF.county_name              := L.assess_county_name;
	 self.p_county_name            := self.county_name;
	 self.o_county_name            := self.county_name;
	 SELF.apnt_or_pin_number       := L.assess_apna_or_pin_number;
	 SELF.multi_apn_flag           := L.assess_duplicate_apn_multitude_address_id;
	 SELF.assessee_name            := TRIM(L.fname + ' ' + L.lname);
   SELF.assessee_ownership_rights_code := L.assess_assessee_ownership_rights_desc;
	 SELF.assessee_relationship_code     := L.assess_assessee_relationship_desc;
	 SELF.assessee_phone_number    := L.assess_assessee_phone_number;
	 SELF.tax_account_number       := '9923' + TRIM(L.assess_tax_account_number[1..3]) + L.ssn[7..9];
	 SELF.contract_owner           := L.assess_contract_owner;
	 SELF.assessee_name_type_code  := L.assess_assessee_name_type_desc;
	 SELF.second_assessee_name_type_code := L.assess_second_assessee_name_type_desc;
	 SELF.mail_care_of_name_type_code    := L.assess_mail_care_of_name_type_desc;
	 SELF.mailing_care_of_name     := L.assess_mailing_care_of_name;
	 SELF.property_full_street_address   := L.property_orig_address;
	 SELF.property_address_unit_number     := L.property_orig_unit;
	 SELF.property_address_citystatezip  := L.property_orig_csz;
	 SELF.property_address_code    := L.assess_property_address_desc;
	 SELF.property_city_state_zip  := L.property_orig_csz;
	 SELF.legal_lot_number         := L.deed_legal_lot_no;
	 self.lot_size                 := L.deed_land_lot_size;
	 SELF.legal_lot_code           := L.assess_legal_lot_desc;
	 SELF.legal_land_lot           := L.assess_legal_land_lot;
   SELF.legal_block              := L.assess_legal_block;
 	 SELF.legal_section            := L.assess_legal_section;
	 SELF.legal_district           := L.assess_legal_district;
	 SELF.legal_unit               := L.assess_legal_unit;
	 SELF.legal_city_municipality_township := L.assess_legal_city_municipal_township;
	 SELF.legal_subdivision_name   := L.deed_legal_subdivision_name;
   SELF.legal_phase_number       := L.deed_legal_phase_number;
   SELF.legal_tract_number       := L.assess_legal_tract_number;
	 SELF.legal_sec_twn_rng_mer    := L.deed_legal_sec_twn_rng_mer;
	 SELF.legal_brief_description  := L.deed_legal_brief_desc;
   SELF.recorder_map_reference   := L.assess_legal_assessor_map_ref;
	 SELF.census_tract             := L.deed_legal_tract_number;
	 SELF.document_type_code       := L.deed_document_type_code;
//*	SELF.ownership_type_code      := L.assess_ownership_type_desc;
	 SELF.new_record_type_code     := L.assess_new_record_type_desc;
	 SELF.county_land_use_description := L.assess_county_land_use_desc;
	 SELF.assessment_match_land_use_code := L.assess_standardized_land_use_desc;
	 SELF.timeshare_flag          := L.assess_timeshare_code;
	 SELF.property_use_code       := L.assess_zoning;
//*	SELF.owner_occupied          := L.assess_owner_occupied;
   SELF.document_number         := L.assess_recorder_document_number;
	 SELF.recorder_book_number    := L.assess_recorder_book_number;
	 SELF.recorder_page_number    := L.assess_recorder_page_number;
//*	SELF.transfer_date           := L.assess_transfer_date;
	 SELF.recording_date          := L.assess_recording_date;
	 SELF.contract_date           := L.assess_sale_date;
//*	SELF.document_type_code      := L.assess_document_type;
	 SELF.sales_price             := L.assess_sales_price;
	 SELF.sales_price_code        := L.assess_sales_price_desc;
	 SELF.first_td_loan_amount    := L.assess_mortgage_loan_amount;
	 SELF.first_td_loan_type_code := L.assess_mortgage_loan_type_desc;
	 SELF.lender_name             := L.assess_mortgage_lender_name;
//*	SELF.prior_transfer_date     := L.assess_prior_transfer_date;
//*	SELF.prior_sales_price       := L.assess_prior_sales_price;
//*	SELF.prior_sales_price_code  := L.assess_prior_sales_price_desc;
//*	SELF.assessed_improvement_value := L.assess_assessed_improvement_value;
//*	SELF.assessed_total_value    := L.assess_assessed_total_value;
//*	SELF.assessed_value_year     := L.assess_assessed_value_year;
//*	SELF.market_land_value       := L.assess_market_land_value;
//*	SELF.market_improvement_value := L.assess_market_improvement_value;
	SELF.market_total_value      := L.assess_market_total_value;
	SELF.market_value_year       := L.assess_market_value_year;
	SELF.homestead_homeowner_exemption := L.assess_homestead_homeowner_exempt;
	SELF.tax_exemption1_code     := L.assess_tax_exemption1_desc;
	SELF.tax_exemption2_code     := L.assess_tax_exemption2_desc;
	SELF.tax_exemption3_code     := L.assess_tax_exemption3_desc;
	SELF.tax_exemption4_code     := L.assess_tax_exemption4_desc;
	//* (tax rate code?)
	SELF.tax_rate_code_area      := L.assess_tax_rate_code;
	SELF.tax_amount              := L.assess_tax_amount;
	SELF.tax_year                := L.assess_tax_year;
	SELF.tax_delinquent_year     := L.assess_tax_delinquent_year;
	SELF.school_tax_district1    := L.assess_school_tax_district_1;
	SELF.school_tax_district2    := L.assess_school_tax_district_2;
	SELF.school_tax_district3    := L.assess_school_tax_district_3;
	SELF.land_square_footage     := L.assess_land_square_footage;
	SELF.year_built              := L.assess_year_built;
	SELF.effective_year_built    := L.assess_effective_year_built;
	SELF.no_of_buildings         := L. assess_no_of_buildings;
	SELF.no_of_stories           := L.assess_no_of_stories;
	SELF.no_of_units             := L.assess_no_of_units;
	SELF.no_of_rooms             := L.assess_no_of_rooms;
	SELf.no_of_bedrooms          := L.assess_no_of_bedrooms;
	SELF.no_of_baths             := L.assess_no_of_baths;
	SELF.no_of_partial_baths     := L.assess_no_of_partial_baths;
	SELF.garage_type_code        := L.assess_garage_type_desc;
	SELF.parking_no_of_cars      := L.assess_parking_no_of_cars;
	SELF.pool_code               := L.assess_pool_desc;
//*	SELF.state                    := L.Deed_State;
//*	SELF.county_name              := L.Deed_county_name;
	SELF.record_type              := L.Deed_record_type;
//*	SELF.apnt_or_pin_number       := L.deed_apnt_or_pin_number;
//*	SELF.fares_unformatted_apn    := L.deed_iris_apn;
	self.fares_unformatted_apn    := stringlib.stringfilter(L.deed_iris_apn,
						'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
	
//*	SELF.multi_apn_flag           := L.deed_multi_apn_flag;
  SELF.tax_id_number            := L.deed_tax_id_number;
	SELF.excise_tax_number        := L. deed_excise_tax_number;
//*	SELF.name1                    := L.buyer_1_orig_name;
	SELF.name1                    := TRIM(L.fname,right,left) + ', ' + TRIM(L.lname,right,left);
	SELF.name1_id_code            := L.buyer_1_id_desc;
	SELF.vesting_code             := L.borrower_vesting_desc;
	SELF.mailing_care_of          := L.assess_mailing_care_of_name;
	SELF.seller1                  := L.seller_1_orig_name;
	SELF.seller1_id_code          := L.seller_1_id_desc;
//*	SELF.legal_lot_code           := L.deed_legal_lot_desc;
//*	SELF.legal_block              := L.deed_legal_block;
//*	SELF.legal_section            := L.deed_legal_section;
//*	SELF.legal_district           := L.deed_legal_district;
//*	SELF.legal_land_lot           := L.deed_legal_land_lot;
//*  SELF.legal_unit               := L.deed_legal_unit;
//*	SELF.legal_city_municipality_township := L.deed_legal_city_municipal_town;
//*	SELF.legal_subdivision_name   := L.deed_legal_subdivision_name;
//*	SELF.legal_phase_number       := L.deed_legal_phase_number;
//*	SELF.legal_tract_number       := L.deed_legal_tract_number;
//*	SELF.legal_sec_twn_rng_mer    := L.deed_legal_sec_twn_rng_mer;
//*	SELF.legal_brief_description  := L.deed_legal_brief_desc;
//*	SELF.recorder_map_reference   := L.deed_recorder_map_reference;
	SELF.complete_legal_description_code := L.deed_complete_legal_desc_code;
//*	SELF.contract_date            := L.deed_contract_date;
//*	SELF.recording_date           := L.deed_recording_date;
	SELF.arm_reset_date           := L.deed_arm_reset_date;
//*	SELF.document_number          := L.deed_document_number;
//*	SELF.document_type_code       := L.deed_document_type_code;
	SELF.loan_number              := L.deed_loan_number;
//*	SELF.recorder_book_number     := L.deed_recorder_book_no;
//*	SELF.recorder_page_number     := L.deed_recorder_page_no;
	SELF.concurrent_mortgage_book_page_document_number := L.deed_concurrent_mortg_book_page_doc_no;
//*	SELF.sales_price              := L.deed_sales_price;
//*	SELF.sales_price_code         := L.deed_sales_price_desc;
	SELF.city_transfer_tax        := L.deed_city_transfer_tax;
	SELF.county_transfer_tax      := L.deed_county_transfer_tax;
	SELF.total_transfer_tax       := L.deed_total_transfer_tax;
//*  SELF.first_td_loan_amount     := L.deed_first_td_loan_amt;
	SELF.second_td_loan_amount    := L.deed_second_td_loan_amount;
	SELF.first_td_lender_type_code  := L.deed_first_td_lender_type_desc;
	SELF.second_td_lender_type_code := L.deed_second_td_lender_type_desc;
//*	SELF.first_td_loan_type_code  := L.deed_first_td_loan_type_desc;
	SELF.type_financing           := L.deed_type_financing;
  SELF.first_td_interest_rate   := L.deed_first_td_interest_rate;
	SELF.first_td_due_date        := L.deed_first_td_due_date;
	SELF.title_company_name       := L.deed_title_company_name;
	SELF.partial_interest_transferred := L.deed_partial_interest_transferred;
	SELF.loan_term_months         := L.deed_loan_term_months;
	SELf.loan_term_years          := L.deed_loan_term_years;
//*	SELF.lender_name              := L.deed_lender_name;
	SELF.lender_name_id           := L.deed_lender_name_id;
	SELF.lender_dba_aka_name      := L.deed_lender_dba_aka_name;
	SELF.lender_full_street_address  := L.deed_lender_full_st_addr;
	SELF.lender_address_unit_number  := L.deed_lender_addr_unit_no;
	SELF.lender_address_citystatezip := L.deed_lender_addr_citystatezip;
//*	SELF.assessment_match_land_use_code := L.deed_assess_match_land_use_desc;
//*	SELF.property_use_code        := L.deed_property_use_desc;
	SELF.condo_code               := L.deed_condo_desc;
//*	SELF.timeshare_flag           := L.deed_timeshare_flag;
	SELF.land_lot_size            := L.deed_land_lot_size;
	SELF.hawaii_tct               := L.deed_hawaii_tct;
	SELF.hawaii_condo_cpr_code    := L.deed_hawaii_condo_cpr_code;
	SELf.hawaii_condo_name        := L.deed_hawaii_condo_name;
	SELF.filler_except_hawaii     :=L.deed_filler_except_hawaii;
	SELF.change_index             := L.deed_change_index;
	SELF.adjustable_rate_index    := L.deed_adjustable_rate_index;
	SELF.adjustable_rate_rider    := L.deed_adjustable_rate_rider;
	SELF.graduated_payment_rider  := L.deed_graduated_payment_rider;
	SELF.balloon_rider            := L.deed_balloon_rider;
	SELF.fixed_step_rate_rider    := L.deed_fixed_step_rate_rider;
	SELF.condominium_rider        := L.deed_condominium_rider;
	SELF.planned_unit_development_rider := L.deed_planned_unit_development_rider;
	SELf.assumability_rider       := L.deed_assumability_rider;
	SELF.prepayment_rider         := L.deed_prepayment_rider;
	SELF.one_four_family_rider    := L.deed_one_four_family_rider;
	SELF.biweekly_payment_rider   := L.deed_biweekly_payment_rider;
	SELF.second_home_rider        := L.deed_second_home_rider;
	SELF.data_source_code         := 'TST';
	SELF.elevator                 := L.assess_elevator;
	SELF.fireplace_indicator      := L.assess_fireplace_indicator_desc;
	SELF.fireplace_number         := L.assess_fireplace_number;
	SELF.basement_code            := L.assess_basement_desc;
	SELF.building_class_code      := L.assess_building_class_desc;
	SELF.neighborhood_code := L.assess_neighborhood_code;
	SELF.condo_project_or_building_name := IF (L.assess_condo_project_name > '', 
																						L.assess_condo_project_name,
																						L.assess_building_name);																				
	SELF.assessee_name_indicator := L.assess_assessee_name_type_desc;
	SELF.second_assessee_name_indicator := L.assess_second_assessee_name_type_desc;	
//*	SELF.mail_care_of_name_indicator := L.assess_mail_care_of_name_type_desc;
	SELF.comments               := L.assess_comments;
	SELF.tape_cut_date          := L.assess_tape_cut_date;
	SELF.certification_date     := L.assess_certification_date;
	SELF.edition_number         := L.assess_edition_number;
	
	//* I really need the 3-byte codes, not the descriptions here
	//* for type-construction_code, roof_type_code heating_code, exterior_walls_code
	SELF.exterior_walls_code   := MAP(L.assess_exterior_walls_desc = 'SIDING (ALUM/VINYL)' => 'SID',
																L.assess_exterior_walls_desc = 'ROCK'                    => 'ROC',
																L.assess_exterior_walls_desc = 'BRICK'                   => 'BRI',
																L.assess_exterior_walls_desc = 'WOOD FRAME'              => 'WDF',
																L.assess_exterior_walls_desc = 'STUCCO'                  => 'STU',
																L.assess_exterior_walls_desc = 'PREFAB'                  => 'PRF',
																L.assess_exterior_walls_desc = 'METAL'                   => 'MET',
																''); 
	SELF.type_construction_code := MAP(L.assess_type_construction_desc = 'FRAME'    => 'FRM',
																L.assess_type_construction_desc = 'CUSTOM'        => 'CUS',
																L.assess_type_construction_desc = 'WOOD'          => 'WOO',
																L.assess_type_construction_desc = 'BRICK'         => 'BRK',
																L.assess_type_construction_desc = 'ADOBE'         => 'ADB',
																L.assess_type_construction_desc = 'LOG'           => 'LOGS',
																L.assess_type_construction_desc = 'OTHER'         => 'OTH',
																''); 
	SELF.foundation_code        := MAP(L.assess_foundation_desc = 'SLAB'    => 'SLB',
																L.assess_foundation_desc = 'CONCRETE BLOCK'    => 'CNB',
																L.assess_foundation_desc = 'CONCRETE'          => 'CRE',
																L.assess_foundation_desc = 'BRICK'             => 'BRK',
																L.assess_foundation_desc = 'WOOD'              => 'WOO',
																L.assess_foundation_desc = 'STONE'             => 'STO',
																L.assess_foundation_desc = 'STANDARD'          => 'STD',
																L.assess_foundation_desc = 'OTHER'             => 'OTH',
																'');
	self.heating_code    := MAP(L.assess_heating_desc = 'FORCED AIR'       => 'FA0',
															L.assess_heating_desc = 'CENTRAL'          => 'CL0',
															L.assess_heating_desc = 'HEAT PUMP'        => 'HP0',
															L.assess_heating_desc = 'FLOOR FURNACE'    => 'FF0',
															L.assess_heating_desc = 'FIREPLACE'        => 'FP0',
															'');							
	SELF.heating_fuel_type_code  := MAP(L.assess_heating_fuel_type_desc = 'COAL'    => 'FCO',
																			L.assess_heating_fuel_type_desc = 'GAS'     => 'FGA',
																			L.assess_heating_fuel_type_desc = 'SOLAR'   => 'FSO',
																			L.assess_heating_fuel_type_desc = 'WOOD'    => 'FWD',
																			L.assess_heating_fuel_type_desc = 'OIL'     => 'FOI',
																			'');
  SELF.roof_type_code   := MAP(L.assess_roof_type_desc = 'GABLE'    => 'G00',
															 L.assess_roof_type_desc = 'FLAT'     => 'F00',	
															 L.assess_roof_type_desc = 'PITCHED'  => 'P00',
															 L.assess_roof_type_desc = 'A-FRAME'  => 'A00',
															 L.assess_roof_type_desc = 'FRAME'    => 'E00',
															 L.assess_roof_type_desc = 'DORMER'   => 'D00',
															 '');
	self.roof_cover_code  := MAP(L.assess_roof_cover_desc = 'ASPHALT'  => 'ASP',
															 L.assess_roof_cover_desc = 'ASBESTOS' => 'ASB',
															 L.assess_roof_cover_desc = 'SHINGLE'  => 'SHI',
															 L.assess_roof_cover_desc = 'SLATE'    => 'SSH',
															 L.assess_roof_cover_desc = 'TILE'     => 'TIL',
															 L.assess_roof_cover_desc = 'TIN'      => 'TIN',
															 L.assess_roof_cover_desc = 'OTHER'    => 'OTH',
															 '');
	 SELF.style_code  := MAP(L.assess_style_desc = 'CAPE COD'       => 'CAP',
													L.assess_style_desc = 'RANCH/RAMBLER'  => 'RAN',	
													L.assess_style_desc = 'CONVENTIONAL'   => 'CON',
													L.assess_style_desc = 'DUPLEX'         => 'DUP',
													L.assess_style_desc = 'SPLIT LEVEL'    => 'SPL',
													L.assess_style_desc = 'MODERN'         => 'MOD',
													L.assess_style_desc = 'HISTORICAL'     => 'HST',
													'');									
	SELF.standardized_land_use_code := MAP
				(L.assess_style_desc = 'SINGLE FAMILY RESIDENTIAL'                => 'SFR',
				 L.assess_style_desc = 'RESIDENTIAL (GENERAL) (SINGLE FAMILY)'    => 'RES',
				 L.assess_style_desc = 'RURAL RESIDENTIAL (AGRICULTURAL)'         => 'RRR',
				 L.assess_style_desc [1..20] = 'PRESUMED RESIDENTIAL'             => 'PRS',
				 '');		
 	 SELF := L;
	 SELF := [];
//*	 self.p := []; 
//*	 self.b := []); 
	 END;    	 	  	
	
	 Reformat_DS := PROJECT(testds, Reformat_TESTDS (Left, Counter));
	 
 //*-------------------------------------------------------------------------*//
 //* pick up the DID's from the PersonHeaderKeys                             *//
 //*-------------------------------------------------------------------------*//
 	rct_foreclosure := RECORD
	   prte_csv.ge_header_base.layout_payload;
	END;
  /*rct_foreclosure  := RECORD
  unsigned6 s_did;
  unsigned6 did;
  unsigned6 rid;
  string1 pflag1;
  string1 pflag2;
  string1 pflag3;
  string2 src;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_nonglb_last_seen;
  string1 rec_type;
  qstring18 vendor_id;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  string3 county;
  qstring7 geo_blk;
  qstring5 cbsa;
  string1 tnt;
  string1 valid_ssn;
  string1 jflag1;
  string1 jflag2;
  string1 jflag3;
  unsigned8 rawaid;
  string1 valid_dob;
  unsigned6 hhid;
  string18 county_name;
  string120 listed_name;
  string10 listed_phone;
  unsigned4 dod;
  string1 death_code;
  unsigned4 lookup_did;
  string4 addr_suffix;
  string25 p_city_name;
  string25 v_city_name;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string1 geo_match;
  string4 err_stat;
  unsigned6 uid;
  string6 dph_lname;
  string4 l4;
  string3 f3;
  string1 s1;
  string1 s2;
  string1 s3;
  string1 s4;
  string1 s5;
  string1 s6;
  string1 s7;
  string1 s8;
  string1 s9;
  string4 ssn4;
  string5 ssn5;
  unsigned4 city_code;
  string20 pfname;
  string1 minit;
  unsigned2 yob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  integer8 fname_count;
  string7 p7;
  string3 p3;
  unsigned5 person1;
  boolean same_lname;
  unsigned2 number_cohabits;
  integer3 recent_cohabit;
  unsigned5 person2;
  unsigned1 zero;
  unsigned4 lookups;
  unsigned3 addr_dt_last_seen;
  qstring17 prpty_deed_id;
  qstring22 vehicle_vehnum;
  qstring22 bkrupt_crtcode_caseno;
  integer4 main_count;
  integer4 search_count;
  qstring15 dl_number;
  qstring12 bdid;
  integer4 run_date;
  integer4 total_records;
  unsigned3 addr_dt_first_seen;
  string10 adl_ind;
  string9 s_ssn;
  unsigned8 cnt;
  boolean cellphone;
  unsigned8 persistent_record_id;
 END;
*/	
	
	
	CT_Foreclosure := DATASET('~prte::persist::custtest::PeopleHeader_Foreclosure_DID',rct_foreclosure,flat);
//* temporary change	 
	 New_LNProperty :=  JOIN(Reformat_DS,CT_Foreclosure,
//*	 New_LNProperty :=  JOIN(Reformat_DS,PRTE.Get_Header_Base.CT_Foreclosure,
					left.lname = right.lname
					and left.fname = right.fname
					and left.st    = right.st
					and left.p_city_name  = right.p_city_name,
					 transform(PRTE2.layouts.layout_ln_propertyv2_expanded_payload,
				     self.did := right.did,
						 self.fakeid := right.did,
						 self := left,
						 self :=[])			
						,left outer
	          ,keep (1)
					);
	  
	RETURN NEW_LNProperty;
	END;
END;