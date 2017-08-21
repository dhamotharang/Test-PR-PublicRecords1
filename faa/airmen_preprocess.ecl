import ut,Address,std, Data_Services;
export airmen_preprocess(string version) := function

//Process Pilot
dpilotraw := Airmen_In_Allsrc.File_In_pilot ;


//output(File_relfor_ctrz);
//Process Non Pilot
dnonpilotraw := Airmen_In_Allsrc.File_In_nonpilot ;

dnpaddfill := project( dnonpilotraw,transform( Layouts.airmen.nonpilotrawfill, self.filler := '',self := left ));

//***************************************************************
//concat both pilot and nonpilot to build airmen data

File_all_airmen := dpilotraw + dnpaddfill;

Layouts.airmen.input concat_all(File_all_airmen l) := transform
self.date_first_seen := if(version <> '',version,(STRING8)Std.Date.Today());
self.date_last_seen := if(version <> '',version,(STRING8)Std.Date.Today());
self.current_flag := 'A';
self.med_exp_date := '';
self.filler := l.filler[1..31];
self := l;
end;


dairmenflag := project(File_all_airmen,concat_all(LEFT));

//***************************************************************************************
//Build Airmen data file

File_airmen_reclean := dairmenflag ( orig_rec_type = '00' );

//////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes name using the NID macro
	////////////////////////////////////////////////////////////////////////////////////// 
layouts.airmen.temp prepname ( File_airmen_reclean l ) := transform

self.orig_mname := '';
self.namesuffix := '';
self := l;
self := [];
end;

dAmenname := project( File_airmen_reclean, prepname(left));

dAmen_cln := Standardize_Name.airmen(dAmenname).clname;

/////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes addresses using the AID macro
	//////////////////////////////////////////////////////////////////////////////////////  

combinedMain 		:= Standardize_Addr.airmen(dAmen_cln).dbase : persist('~thor_data400::persist::faa_airmen_cln');


layout_airmen_data_in conv2orig( combinedMain l ) := transform
self.prim_range       :=  l.clean_address.prim_range;  
self.predir           :=  l.clean_address.predir;  
self.prim_name        :=  l.clean_address.prim_name;   
self.suffix        		:=  l.clean_address.addr_suffix;  
self.postdir          :=  l.clean_address.postdir;  
self.unit_desig       :=  l.clean_address.unit_desig;   
self.sec_range        :=  l.clean_address.sec_range;  
self.p_city_name      :=  l.clean_address.p_city_name;   
self.v_city_name      :=  l.clean_address.v_city_name;   
self.st               :=  l.clean_address.st;  
self.zip              :=  l.clean_address.zip;  
self.zip4             :=  l.clean_address.zip4;  
self.cart             :=  l.clean_address.cart;  
self.cr_sort_sz       :=  l.clean_address.cr_sort_sz;  
self.lot              :=  l.clean_address.lot;  
self.lot_order        :=  l.clean_address.lot_order;  
self.dpbc             :=  l.clean_address.dbpc;  
self.chk_digit        :=  l.clean_address.chk_digit;  
self.rec_type         :=  l.clean_address.rec_type;  
self.ace_fips_st      :=  l.clean_address.fips_state;  
self.county           :=  l.clean_address.fips_county;  
self.geo_lat          :=  l.clean_address.geo_lat;   
self.geo_long         :=  l.clean_address.geo_long;   
self.msa              :=  l.clean_address.msa;  
self.geo_blk          :=  l.clean_address.geo_blk;  
self.geo_match        :=  l.clean_address.geo_match;  
self.err_stat         :=  l.clean_address.err_stat;  
self.title            :=  l.clean_name.title;  
self.fname            :=  l.clean_name.fname;   
self.mname            :=  l.clean_name.mname;   
self.lname            :=  l.clean_name.lname;   
self.name_suffix      :=  l.clean_name.name_suffix;  
self := l;
end;

dMainstd := project( combinedMain , conv2orig( left ));




Sequential ( STD.File.StartSuperFileTransaction(),
 						 STD.File.ClearSuperFile('~thor_data400::in::faa_airmen_father'),
			       STD.File.AddSuperFile('~thor_data400::in::faa_airmen_father','~thor_data400::in::faa_airmen_in',,true),
						 STD.File.FinishSuperFileTransaction()
						);
				
		
dAirmenfather := dataset('~thor_data400::in::faa_airmen_father',layout_airmen_data_in,flat);


dAmenaddflag := project(dAirmenfather,transform(layout_airmen_data_in,SELF.current_flag := if(LEFT.current_flag = 'A' or LEFT.current_flag = 'I','I',LEFT.current_flag), SELF := LEFT ));

dAmen_dst := distribute(dAmenaddflag + dMainstd,hash(unique_id, 
orig_rec_type, 
orig_fname, 
 orig_lname, 
 street1,
 street2,
 city, 
 state, 
 zip_code, 
 country,
 region, 
 med_class, 
 med_date, 
 med_exp_date)); 


dAmen_sort := sort(dAmen_dst ,unique_id, orig_rec_type, orig_fname, orig_lname, street1, street2, city, state, zip_code, country, region, med_class, med_date, med_exp_date, current_flag, -date_last_seen,local );

layout_airmen_data_in dateroll( dAmen_sort le, dAmen_sort ri) := transform
self.date_first_seen := (string8) ut.min2((unsigned)le.date_first_seen, (unsigned)ri.date_first_seen);
 self.date_last_seen :=  (string8)max((unsigned)le.date_last_seen, (unsigned)ri.date_last_seen);
self := le;
end;

dAmenrollup := rollup(dAmen_sort,dateroll(LEFT,RIGHT),
                
 unique_id, 
 orig_rec_type, 
 orig_fname, 
 orig_lname, 
 street1,
 street2,
 city, 
 state, 
 zip_code, 
 country,
 region, 
 med_class, 
 med_date, 
 med_exp_date,local 
  );     

dAmenroll_s := sort( dAmenrollup,unique_id,current_flag, -date_last_seen,local);

layout_airmen_data_in addflag( dAmenroll_s l) := transform
self.current_flag := if ( l.unique_id = '','H',l.current_flag);
self := l;
end;

dAmenfout := output(project(dAmenroll_s,addflag(LEFT)),,'~thor_data400::in::airmen_data_' + version,overwrite);

pre := sequential(
									STD.File.StartSuperFileTransaction(),
									STD.File.ClearSuperFile('~thor_data400::in::faa_airmen_FATHER'),
									STD.File.AddSuperFile('~thor_data400::in::faa_airmen_FATHER','~thor_data400::in::faa_airmen_IN',0,true),
									STD.File.ClearSuperFile('~thor_data400::in::faa_airmen_IN'),
									STD.File.AddSuperFile('~thor_Data400::in::Faa_airmen_IN','~thor_data400::in::airmen_data_' + version),
									STD.File.FinishSuperFileTransaction() );


//********************************************************************
//Build Airmen Certificate file

dairmenIncert := dairmenflag ( orig_rec_type <> '00' );

faa.layout_airmen_certificate.v2 convert2cert(  dairmenIncert l ) := transform
self.letter := l.letter_code;
self.rec_type := l.orig_rec_type;
self.cer_type := l.orig_fname[1];
self.cer_level := l.orig_fname[2];
self.cer_exp_date := l.orig_fname[3..10];
self.ratings  := l.orig_fname[11..30] + l.orig_lname + l.street1 + l.street2[1..27];
self.filler := l.street2[28..33] + l.city + l.state + l.zip_code + l.country + l.region + l.med_class + l.med_date + l.med_exp_date + l.filler;
self := l;
end;

dAmenpiolt2cert := project( dairmenIncert, convert2cert(left));

//Previous airmen certificate file

Sequential ( STD.File.StartSuperFileTransaction(),
	 					 STD.File.ClearSuperFile('~thor_data400::in::faa_airmen_certs_father'),
			       STD.File.AddSuperFile('~thor_data400::in::faa_airmen_certs_father','~thor_data400::in::faa_airmen_certs_in',,true),
						 STD.File.FinishSuperFileTransaction()
						);
										
dAirmencertfather := dataset('~thor_data400::in::faa_airmen_certs_father',faa.layout_airmen_certificate.v2,flat);


faa.layout_airmen_certificate.v2 addflag2( dAirmencertfather l) := transform
self.current_flag := if ( l.current_flag = 'A' or l.current_flag = 'I', 'I', l.current_flag ) ;
self := l;
end;

dAmencert_dst := distribute(project(dAirmencertfather + dAmenpiolt2cert , addflag2(LEFT)),hash( unique_id, cer_type, cer_level, cer_exp_date, ratings ));

dAmencertall := sort(dAmencert_dst,unique_id, cer_type, cer_level, cer_exp_date, ratings, current_flag,local);

faa.layout_airmen_certificate.v2 tairmenrollup( dAmencertall le,dAmencertall ri) := transform
self.date_first_seen := (string8) ut.min2((unsigned)le.date_first_seen, (unsigned)ri.date_first_seen);
 self.date_last_seen :=  (string8)max((unsigned)le.date_last_seen, (unsigned)ri.date_last_seen);
self := le;
end;

dAmenrolledrec := rollup(dAmencertall,tairmenrollup(LEFT,RIGHT),
                unique_id, cer_type, cer_level, cer_exp_date, ratings,local);     



dAmenoutfinal := sort(dAmenrolledrec,unique_id,rec_type,local);

dAmenbuiltcert := output(dAmenoutfinal,,'~thor_data400::in::airmen_certificate_' + version,overwrite);

pre3 := sequential(
										STD.File.StartSuperFileTransaction(),
										STD.File.ClearSuperFile('~thor_data400::in::faa_airmen_certs_FATHER'),
										STD.File.AddSuperFile('~thor_data400::in::faa_airmen_certs_FATHER','~thor_data400::in::faa_airmen_certs_IN',0,true),
										STD.File.ClearSuperFile('~thor_data400::in::faa_airmen_certs_IN'),
										STD.File.AddSuperFile('~thor_Data400::in::Faa_airmen_certs_IN','~thor_data400::in::airmen_certificate_' + version),
										STD.File.FinishSuperFileTransaction()
									); 


return Sequential(dAmenfout,pre,dAmenbuiltcert,pre3);
end;

