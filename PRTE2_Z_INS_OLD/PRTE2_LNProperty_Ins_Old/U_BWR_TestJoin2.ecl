//*EXPORT TestJoin2 := 'todo';
#WORKUNIT ('name', 'testjoin2');
//*===================================================================================*//
//* PRTE2_LNProperty.Get_payload,   JOIN the LNProperty files
//* For LN_Property, join the current files into an expanded payload record
//*===================================================================================*// 
IMPORT PRTE2,PRTE_CSV,PRTE, ut,NID,Doxie,address,_control,PRTE,iesp,ut,Doxie,address,STD,NID,AutoKeyB2,autokey,AutoKeyI;

//*EXPORT Get_payload 																:= MODULE
//*	EXPORT LNPROPERTYV2 				:= FUNCTION
	
  
	ds1  := PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__payload;
	
	OUTPUT(COUNT(ds1),NAMED('oldpayload'));	
	OUTPUT (ds1,,'~prte::ct::ln_propertyv2::join::payload',OVERWRITE);
	OUTPUT(choosen(ds1,200),NAMED('ds1payl'));
	
	
	ds1a  := JOIN(ds1,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__address,
					left.fakeid = right.did,
					left outer
					);
	OUTPUT (COUNT(ds1a),NAMED('cntds1a'));
 	OUTPUT (ds1a,,'~prte::ct::ln_propertyv2::join::ds1a::addr',OVERWRITE);	
	
	ds2  := JOIN(ds1a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__addressb2,
					left.fakeid = right.bdid,
							transform(RECORDOF(DS1a),
							self.bdid := IF(right.bdid != 0, right.bdid, left.bdid),
							self.lookups := right.lookups,
							self := left),							
					   left outer
							);
  OUTPUT (COUNT(ds2),NAMED('cntaddrb2'));
	OUTPUT (choosen(ds2,100),named('addrb2'));
	OUTPUT (ds2,,'~prte::ct::ln_propertyv2::join::ds2::addrb2',OVERWRITE);	
		
	ds3  := JOIN(ds2,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__citystname,
					left.fakeid = right.did,
					left outer
  					);					
	OUTPUT (COUNT(ds3),NAMED('cntds3'));
	OUTPUT (ds3,,'~prte::ct::ln_propertyv2::join::ds3::citystn',OVERWRITE);	
	
	
	
	ds4  := JOIN(ds3,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__citystnameb2,
					left.fakeid  =  right.bdid,	
						transform(RECORDOF(DS3),
							self.bdid := IF (right.bdid != 0, right.bdid, left.bdid),
							self.lookups := IF(left.lookups = 0, right.lookups, left.lookups),
							self.city_code := IF(left.city_code = 0, right.city_code,left.city_code),
							self.st := IF(left.st = '', right.st, left.st),
							self.zip := IF(left.zip = '',left.company_addr.zip5,left.zip),
							self.company_addr.st := IF(left.company_addr.st='', right.st, left.st),
							self := left,
							self := []),							
	  					left outer
    					);
			
	ds5  := JOIN(ds4,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__name,
						left.fakeid = right.did,
           	transform(RECORDOF(DS4),				
					    self.lname := right.lname,
							self.fname := right.fname, 
							self.pfname := right.pfname,
							self.dph_lname := right.dph_lname,
							self.dob := right.dob,
							self := left),
    					left outer
							);


		
	ds6 := JOIN(ds5,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__nameb2,
					left.fakeid = right.bdid,	
					left outer,
					keep (1)
					);
OUTPUT(choosen(ds6(bdid=79970),500),NAMED('ds6nameb2'));
					
  ds7 := JOIN(ds6,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__namewords2,
					left.fakeid = right.bdid,	
					left outer
  					);
	
			
	ds8 := JOIN(ds7,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__phone2,
					left.fakeid = right.did,	
					left outer,
					keep (1)
					); 
	
	
	
	
	ds9 := JOIN(ds8,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__phoneb2,
				 left.fakeid = right.bdid,
				 				 			 
				 left outer,
				 keep (1)
				 );
	
	
	ds10 := JOIN(ds9,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__stname,
					left.fakeid = right.did,
					left outer,
	  			keep (1)
			   	);				

	
	
	ds11 := JOIN(ds10,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__stnameb2,
				left.fakeid = right.bdid,
				left outer,
				keep (1)
		   		);
					
	ds12 := JOIN(ds11,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__zip,
				left.fakeid = right.did,			
							transform(RECORDOF(DS11),
							self.zip := IF(left.zip = '', (string) right.zip,left.zip);
							self.yob := (integer) left.dob [1..4];
							self := left,
							self := []),							
							left outer
						);
	
	
	ds13 := JOIN(ds12,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__zipb2,
				left.fakeid = right.bdid,
						transform(RECORDOF(DS12),
							self.bdid := IF (right.bdid != 0, right.bdid, left.bdid),
							self.zip := IF(left.zip = '', (string) right.zip,left.zip);
							self := left,
							self := []),							
				left outer
    				);
  
					
	ds15 := JOIN(ds13,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__deed_parcelnum,
			left.ln_fares_id = right.ln_fares_id,
	  	left outer,
			keep (1)
				); 
//*	OUTPUT (ds15,,'~prte::ct::ln_propertyv2::join::ds15::deed_parcelnum',OVERWRITE);

 	
	ds16  := JOIN(ds15,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__deed_fid,
			left.ln_fares_id = right.ln_fares_id,
			left outer
							);	
//* 	OUTPUT(choosen(ds16(ln_fares_id = 'DA0105850538' ),100),NAMED('DS16'));
 	ds16a  := JOIN(ds16,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__deed_fid,
			left.ln_fares_id = right.ln_fares_id,
				transform(RECORDOF(DS16),
				self.state := IF(left.state = '', right.state, left.state),
				self.vendor_source_flag := right.vendor_source_flag,
				self.fips_code := IF(left.fips_code = '',right.fips_code, left.fips_code),
				self.legal_city_municipality_township := IF (left.legal_city_municipality_township = '',
													right.legal_city_municipality_township,
													left.legal_city_municipality_township),
				self.legal_brief_description := IF(left.legal_brief_description = '', right.legal_brief_description,
																				left.legal_city_municipality_township),
				self.county_name := IF(left.county_name = '', right.county_name, left.county_name),
				self.property_full_street_address := IF(left.property_full_street_address = '',
													right.property_full_street_address,
													left.property_full_street_address),
				self := left,
				self := right),
			left outer
							);	
	OUTPUT(choosen(ds16a(ln_fares_id = 'DA0149602742'),100),NAMED('DA014916a'));
	OUTPUT (ds16a,,'~prte::ct::ln_propertyv2::join::ds16a::deed_fid',OVERWRITE);
 				
 
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
//*		OUTPUT(choosen(ds17(ln_fares_id = 'DA0105850538'),100),NAMED('DS17'));		

	ds18  := JOIN(ds17a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__assessor_parcelnum,
			left.ln_fares_id = right.ln_fares_id,
				transform(RECORDOF(DS17a),
				self.fares_unformatted_apn := IF(left.fares_unformatted_apn = '', right.fares_unformatted_apn,left.fares_unformatted_apn),
				self := left,
				self := right),
			left outer,
			keep (1)
							);		
//*	OUTPUT(choosen(ds18(ln_fares_id = 'DA0105850538'),200),NAMED('APARCEL'));			

 	ds19  := JOIN(ds18,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__addr_search_fid,
			left.ln_fares_id = right.ln_fares_id,
			left outer,
			keep (1)
							);		
 
  ds19a := DEDUP(ds19,RECORD,ALL);
//* OUTPUT(choosen(ds19a(ln_fares_id = 'DA0105850538'),100),NAMED('ds19aADDRSEARCH'));		

				
  ds21 := JOIN(ds19a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_bdid,
					left.ln_fares_id = right.ln_fares_id
					and left.source_code_1 = right.source_code[1..1]
					and left.source_code_2 = right.source_code[2..2],
					left outer
					); 
					
	

	ds21a := JOIN(ds21,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_bdid,
					left.ln_fares_id = right.ln_fares_id
					and left.source_code = right.source_code
					and left.vendor_source_flag = right.vendor_source_flag, 
								
				transform(RECORDOF(DS21),
				self.bdid := IF(right.bdid > 0, right.bdid,left.bdid),
				self.s_bid := IF(right.bdid > 0,right.s_bid, left.s_bid),	
				self.dt_vendor_first_reported := right.dt_vendor_first_reported,
				self.dt_vendor_last_reported  := right.dt_vendor_last_reported,
				self.process_date  := right.process_date,

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
				self := left),
					left outer,
					keep (1)
					); 

	
	ds22 := JOIN(ds21a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_did,
					left.ln_fares_id = right.ln_fares_id,
					left outer,
					keep (1)
					); 
					
	ds22a := JOIN(ds22,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_did,
					left.ln_fares_id = right.ln_fares_id,

								transform(RECORDOF(DS22),
								self.p_city_name := IF(left.p_city_name = '', right.p_city_name,left.p_city_name),
								self.county      := IF(left.county = '', right.county,left.county),
								self.st          := IF(left.st = '',IF(right.st = '', left.person_addr.st, right.st),left.st),
  
								self.suffix      := IF(left.suffix = '', IF(right.suffix = '', left.person_addr.addr_suffix, right.suffix), left.suffix),
								self.geo_blk     := IF(left.geo_blk = '', right.geo_blk,left.geo_blk),
								self.source_code := IF(left.source_code = '', right.source_code,left.source_code),
	
								self.source_code_2 := IF(left.source_code_2 = '', right.source_code_2,left.source_code_2),		
								self.v_city_name   := IF(left.v_city_name = '', IF(left.p_city_name = '', left.person_addr.v_city_name,left.p_city_name),left.v_city_name),
	
								self.geo_lat     := IF(left.geo_lat = '', left.person_addr.geo_lat,left.geo_lat),
								self.geo_long    := IF(left.geo_long = '', left.person_addr.geo_long,left.geo_long),
	
								self.geo_match   := IF(left.geo_match = '',left.person_addr.geo_match,left.geo_match),
								self.err_stat    := IF(left.err_stat = '', left.person_addr.err_stat,left.err_stat),
															
								self := left),
					left outer,
					keep (1)
						); 			
	
 

  ds23 := JOIN(ds22a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_fid,
			 left.DID = right.DID
	//*		 left.person_name.lname = right.lname,
	//*		 left.person_name.fname = right.fname,
			 and left.st = right.st
			 and left.p_city_name = right.p_city_name
					
	//*				left.ln_fares_id = right.ln_fares_id
	//*				and left.source_code_2 = right.source_code_2
	//*				and left.source_code_1 = right.source_code_1

					and left.lname         = right.lname
					and left.fname         = right.fname,
					left outer
					,keep (1)
					); 		
					
 ds23a := JOIN(ds23,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_fid,
	//*				left.ln_fares_id = right.ln_fares_id
 //*					and left.source_code_2 = right.source_code_2
//*					and left.source_code_1 = right.source_code_1
//*					and left.lname         = right.lname
//*					and left.fname         = right.fname,
					
					left.DID = right.DID
				  and left.st = right.st
			    and left.p_city_name = right.p_city_name
					and left.lname         = right.lname
					and left.fname         = right.fname,
					
							transform(RECORDOF(DS23),
							  self.ln_fares_id := IF(left.ln_fares_id = '', right.ln_fares_id, left.ln_fares_id),
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
	//*							self.state_code := right.state_code,
								self := left,
								self := right),
				
					left outer
					,keep (1)
					); 
						
//*	OUTPUT(choosen(ds23a(ln_fares_id = 'DA0105850538' or (lname = 'WOODER' and fname = 'MARVIN')),800),NAMED('DS23a'));			
//*  OUTPUT(choosen(ds23a(ln_fares_id = 'DA0149602742'),100),NAMED('DA0149'));
	OUTPUT(choosen(ds23a,100),NAMED('ds23a'));
	OUTPUT(choosen(ds23a(ln_fares_id = 'DA0149602742'),100),NAMED('DA014923'));


	
	ds24 := JOIN(ds23a,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__assessor_fid,
					left.ln_fares_id = right.ln_fares_id,
					
						transform(RECORDOF(DS23a),
							  self.proc_date		 := right.proc_date,
								self.fips_code     := IF(left.fips_code = '', right.fips_code, left.fips_code),
								self.county_name   := IF(left.county_name = '', right.county_name, left.county_name),
								self.property_full_street_address :=
																IF(left.property_full_street_address = '', right.property_full_street_address,
																   left.property_full_street_address),
								self.legal_city_municipality_township := IF(left.legal_city_municipality_township = '',
								                   right.legal_city_municipality_township,
																	 left.legal_city_municipality_township),
								self.legal_brief_description := IF(left.legal_brief_description = '',	
																	right.legal_brief_description, left.legal_brief_description),
								self.recording_date := IF(left.recording_date = '', right.recording_date,left.recording_date),
						self := left,
						self := right,
						self := []
						),		
									
					left outer
					,keep (1)
					); 
  OUTPUT(choosen(ds24(ln_fares_id = 'DA0149602742'),100),NAMED('DA014924'));
	OUTPUT(choosen(ds24,100),NAMED('asfid'));
	
	
	
	ds24a  := JOIN(ds24,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__assessor_parcelnum,
			left.ln_fares_id = right.ln_fares_id,
				transform(RECORDOF(PRTE2.layouts.layout_ln_propertyv2_expanded_payload),
				self.fares_unformatted_apn := IF(left.fares_unformatted_apn = '', right.fares_unformatted_apn,left.fares_unformatted_apn),
										
						
				self := left,
				self := right,
				self := []),
			left outer,
			keep (1)
							);	
							
//*	OUTPUT(choosen(ds24a(ln_fares_id = 'DA0105850538'),20),NAMED('DS24APARCELNUM'));			
ds25 := JOIN(ds24A,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__ssn2,
					left.fakeid = right.did,
					transform(PRTE2.layouts.layout_ln_propertyv2_expanded_payload,

					self.lookups := IF(left.lookups = 0,right.lookups,left.lookups),
					self.s_did :=  left.did,
					self.s1 := right.s1,
					self.s2 := right.s2,
					self.s3 := right.s3,

					self.s5 := right.s5,
					self.s6 := right.s6,
					self.s7 := right.s7,
					self.s8 := right.s8,
					self.s9 := right.s9,
					self := left,
					self := right),
					left outer,
					keep (1)
					);
					
	OUTPUT(choosen(ds25(did = 999951293226),100),NAMED('DA014925'));
		
/*	
	ds25 := JOIN(ds24A,PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__ssn2,
					left.fakeid = right.did,
					transform(PRTE2.layouts.layout_ln_propertyv2_expanded_payload,

					self.lookups := IF(left.lookups = 0,right.lookups,left.lookups),
					self.s_did :=  left.did,
					self.s1 := right.s1,
					self.s2 := right.s2,
					self.s3 := right.s3,

					self.s5 := right.s5,
					self.s6 := right.s6,
					self.s7 := right.s7,
					self.s8 := right.s8,
					self.s9 := right.s9,
					self := left),
					left outer,
					keep (1)
					);
*/
  
	OUTPUT (ds25,,'~prte::ct::ln_propertyv2::join::ds25::ssn2',OVERWRITE);
  OUTPUT (ds25(ln_fares_id='OA0041634156'),NAMED('ds25rec'));	 
/*		
	 EXPORT retds_ln_propertyv2 := ds25;
	 OUTPUT (choosen(retds_ln_propertyv2,200));		
   RETURN retds_ln_propertyv2;
	END;
*/
