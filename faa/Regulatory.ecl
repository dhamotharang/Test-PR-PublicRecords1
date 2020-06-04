EXPORT Regulatory := MODULE
	
	//
	//airmen_certificate
	//
	EXPORT 	base_layout_airmen_certificate := RECORD
		string8 date_first_seen;
		string8 date_last_seen;
		string1 current_flag;
		string1 letter;
		string7 unique_id;
		string2 rec_type;
		string1 cer_type;
		string20	cer_type_mapped;
		string1 cer_level;
		string45	cer_level_mapped;
		string8 cer_exp_date;
		string99 ratings;
		string79 filler;
		string2 lfcr;
	END;
	
	EXPORT applyAirmenCertificateInj(base_ds) := FUNCTIONMACRO
		import faa, Suppress;
		
		local Base_File_In := suppress.applyregulatory.getFile('file_faa_cert_inj.thor', faa.Regulatory.base_layout_airmen_certificate);
	
		local start := max(base_ds,(unsigned)unique_id);

		recordof(base_ds) add_id(faa.regulatory.base_layout_airmen_certificate l) := transform
			self.unique_id := intformat(start + (unsigned)l.unique_id,7,1);
			self := l;
			self := [];
		end;

		local supp_data := project(Base_File_In, add_id(left));

		local total := dedup(sort(base_ds + supp_data,current_flag, letter, unique_id, rec_type, cer_type, cer_type_mapped, cer_level, cer_level_mapped, cer_exp_date, ratings, -date_last_seen) ,except date_first_seen, date_last_seen); 

		// populate persistent record id 
		local f := project(total, transform( recordof(base_ds), self.persistent_record_id := hash64(trim(left.current_flag,left,right)+
																																											trim(left.letter,left,right)+
																																											trim(left.unique_id,left,right)+
																																											trim(left.rec_type,left,right)+
																																											trim(left.cer_type,left,right)+
																																											trim(left.cer_type_mapped,left,right)+
																																											trim(left.cer_level,left,right)+
																																											trim(left.cer_level_mapped,left,right)+
																																											trim(left.cer_exp_date,left,right)+
																																											trim(left.ratings,left,right));
                                                          
                                 
																 self := left;
																 self := [])); 
		return f;

	ENDMACRO;

	//
	//airmen_data
	//
	export base_layout_airmen_data := RECORD 
		string3		d_score;
		string9		best_ssn;
		string12	did_out;   
		 string8 date_first_seen;
		 string8 date_last_seen;
		 string1 current_flag;
		 string10 record_type;
		 string1 letter_code;
		 string7 unique_id;
		 string2 orig_rec_type;
		 string30 orig_fname;
		 string30 orig_lname;
		 string33 street1;
		 string33 street2;
		 string17 city;
		 string2 state;
		 string10 zip_code;
		 string18 country;
		 string2 region;
		 string1 med_class;
		 string6 med_date;
		 string6 med_exp_date;
		 string10 prim_range;
		 string2 predir;
		 string28 prim_name;
		 string4 suffix;
		 string2 postdir;
		 string10 unit_desig;
		 string8 sec_range;
		 string25 p_city_name;
		 string25 v_city_name;
		 string2 st;
		 string5 zip;
		 string4 zip4;
		 string4 cart;
		 string1 cr_sort_sz;
		 string4 lot;
		 string1 lot_order;
		 string2 dpbc;
		 string1 chk_digit;
		 string2 rec_type;
		 string2 ace_fips_st;
		 string3 county;
		 string18	county_name;
		 string10 geo_lat;
		 string11 geo_long;
		 string4 msa;
		 string7 geo_blk;
		 string1 geo_match;
		 string4 err_stat;
		 string5 title;
		 string20 fname;
		 string20 mname;
		 string20 lname;
		 string5 name_suffix;
		 string2 oer;
		 // string2 source;
	END;	
	
	EXPORT applyAirmenDataInj(base_ds) := FUNCTIONMACRO
		import faa, Suppress, mdr;
		local Base_File_In := suppress.applyregulatory.getFile('file_faa_inj.thor', faa.Regulatory.base_layout_airmen_data);
	
		local start := max(base_ds,(unsigned)unique_id);

		recordof(base_ds) add_id(faa.regulatory.base_layout_airmen_data l) := transform
			self.unique_id := intformat(start + (unsigned)l.unique_id,7,1);
			self.source := mdr.sourceTools.src_Airmen;
			self := l;
			self := [];
		end;
		
		local supp_data := project(Base_File_In, add_id(left));

		local total := base_ds + supp_data;

		// Add persistent record id 

		local ded_outseq :=dedup(sort( distribute(project(total, transform({total}, self.zip_code 			:= trim(left.zip_code,left,right),
																																	self.current_flag 	:= trim(left.current_flag,left,right),
																																	self.record_type 		:= trim(left.record_type,left,right),
																																	self.letter_code 		:= trim(left.letter_code,left,right),
																																	self.unique_id 			:= trim(left.unique_id,left,right),
																																	self.orig_rec_type 	:= trim(left.orig_rec_type,left,right),
																																	self.orig_fname 		:= trim(left.orig_fname,left,right),
																																	self.orig_lname 		:= trim(left.orig_lname,left,right),
																																	self.street1 				:= trim(left.street1,left,right),
																																	self.street2 				:= trim(left.street2,left,right),
																																	self.city 					:= trim(left.city,left,right),
																																	self.state 					:= trim(left.state,left,right),
																																	self.country 				:= trim(left.country,left,right),
																																	self.region 				:= trim(left.region,left,right),
																																	self.med_class 			:= trim( left.med_class,left,right),
																																	self.med_date 			:= trim(left.med_date,left,right),
																																	self.med_exp_date 	:= trim(left.med_exp_date,left,right),
																																	self.best_ssn 			:= trim(left.best_ssn,left,right), 
																																	self.did_out 				:= trim(left.did_out,left,right), self:= left)),
																	hash(current_flag,record_type,letter_code,unique_id,orig_rec_type,orig_fname,orig_lname,street1,
																	street2,city,state,zip_code,country,region,med_class,med_date,med_exp_date)),																
																				current_flag,record_type,letter_code,unique_id,orig_rec_type,orig_fname,orig_lname,street1,
																				street2,city,state,zip_code,country,region,med_class,med_date,med_exp_date,-date_last_seen,local),
																				except date_first_seen, date_last_seen, local); 

		local outf:= project( ded_outseq, transform({faa.layout_airmen_Persistent_ID },
							self.persistent_record_id :=hash64(trim(left.current_flag,left,right) +','+
																								trim(left.record_type,left,right) +','+
																								trim(left.letter_code,left,right) +','+
																								trim(left.unique_id,left,right) +','+
																								trim(left.orig_rec_type,left,right) +','+
																								trim(left.orig_fname,left,right) +','+
																								trim(left.orig_lname,left,right) +','+
																								trim(left.street1,left,right) +','+
																								trim(left.street2,left,right) +','+
																								trim(left.city,left,right) +','+
																								trim(left.state,left,right) +','+
																								trim(left.zip_code,left,right) +','+
																								trim(left.country,left,right) +','+
																								trim(left.region,left,right) +','+
																								trim(left.med_class,left,right) +','+
																								trim(left.med_date,left,right) +','+
																								trim(left.med_exp_date,left,right) ) , 
																								self := left;
																								self := [];));
	
		return outf;
	ENDMACRO;

END;