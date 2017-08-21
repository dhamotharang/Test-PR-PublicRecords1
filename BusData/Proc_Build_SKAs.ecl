import business_header,business_header_ss,ut,did_add, STRATA,mdr;

//-----------[ nixie ]----------
df0 := busdata.File_SKA_Nixie_In;

// Eliminate duplicate records
df1 := dedup(sort(df0,record),record);

rec1 := record
	busdata.layout_ska_nixie_bdid;
	string2	source;
end;

// Create a unique source_rec_id by hashing on all raw fields
rec1 into_bdid(df1 L) := transform
	self.bdid 				 := 0;
	self.source 			 := MDR.sourceTools.src_SKA;
	self.source_rec_id := hash64(
														 ut.fnTrim2Upper(l.prename)
														,ut.fnTrim2Upper(l.first_name)
														,ut.fnTrim2Upper(l.middle)
														,ut.fnTrim2Upper(l.last_name)
														,ut.fnTrim2Upper(l.dept_title)
														,ut.fnTrim2Upper(l.dept_code)
														,ut.fnTrim2Upper(l.dept_expl)
														,ut.fnTrim2Upper(l.spec)
														,ut.fnTrim2Upper(l.spec_expl)
														,ut.fnTrim2Upper(l.dept_file)
														,ut.fnTrim2Upper(l.company_name)
														,ut.fnTrim2Upper(l.address1)
														,ut.fnTrim2Upper(l.city)
														,ut.fnTrim2Upper(l.state)														
 														,ut.fnTrim2Upper(l.zip)
														,ut.fnTrim2Upper(l.area_code)			
														,ut.fnTrim2Upper(l.phone)			
														,ut.fnTrim2Upper(l.id)			
														,ut.fnTrim2Upper(l.persid)			
														,ut.fnTrim2Upper(l.nixie_date)
														);
	self 							:= l;
end;

df1_2_proj	:= project(df1,into_bdid(LEFT));

// Dedup on source_rec_id: found dup records with different
// mail_geo_lat/mail_geo/long/mail_msa, etc. 
df1_2 			:= dedup(sort(df1_2_proj,source_rec_id),source_rec_id);

business_header.MAC_Source_Match(
				 df1_2													// infile
				,outf1													// outfile
				,false													// bool_bdid_field_is_string12
				,bdid														// bdid_field
				,false													// bool_infile_has_source_field
				,MDR.sourceTools.src_SKA				// source_type_or_field
				,false													// bool_infile_has_source_group
				,foo														// source_group_field
				,company_name										// company_name_field
				,mail_prim_range								// prim_range_field
				,mail_prim_name									// prim_name_field
				,mail_sec_range									// sec_range_field
				,mail_zip												// zip_field
				,true														// bool_infile_has_phone
				,phone													// phone_field
				,false													// bool_infile_has_fein
				,foo														// fein_field
				,																// bool_infile_has_vendor_id = 'false'
				,																// vendor_id field					 = 'vendor_id'
				);

myset := ['A','P'];

Business_Header_SS.MAC_Match_Flex(
			 outf1																// input dataset						
			,myset				                				// bdid matchset what fields to match on           
			,company_name	                        // company_name	              
			,mail_prim_range		                  // prim_range		              
			,mail_prim_name		                    // prim_name		              
			,mail_zip					                    // zip5					              
			,mail_sec_range		                    // sec_range		              
			,mail_st				        		          // state				              
			,phone						                    // phone				              
			,foo            			           	  	// fein              
			,bdid										        			// bdid												
			,rec1																	// output layout 
			,false                               	// output layout has bdid score field? 																	
			,foo                     							// bdid_score                 
			,outf1_3										          // output dataset
			,																			// keep count
			,																			// default threshold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set							// create BIP keys only
			,																			// url
			,																			// email 
			,mail_p_city_name											// city
			,fname																// fname
			,mname																// mname
			,lname																// lname
			,																			// contact ssn
			,source																// source
			,source_rec_id												// source_record_id
			,true																	// if mac_Source_Match appears exists before flex macro
		);	

outf1_4 := project(outf1_3, transform(busdata.layout_ska_nixie_bdid,self := LEFT));

ut.MAC_SF_BuildProcess(outf1_4,'~thor_data400::base::ska_nixie',do1,2);

//--------------[ verified ]----------

df2 := busdata.File_SKA_Verified_In;

rec2 := record
	unsigned4	seq;
	busdata.layout_ska_verified_bdid;
	string2	source;	
end;

// Create a unique source_rec_id by hashing on all raw fields
rec2 into_bdid2(df2 L,integer C) := transform
	self.bdid 				 := 0;
	self.source 			 := MDR.sourceTools.src_SKA;
	self.seq 					 := C;
	self.source_rec_id := hash64(ut.fnTrim2Upper(l.prename)
														,ut.fnTrim2Upper(l.first_name)
														,ut.fnTrim2Upper(l.middle)
														,ut.fnTrim2Upper(l.last_name)
														,ut.fnTrim2Upper(l.company_title)
														,ut.fnTrim2Upper(l.do)
														,ut.fnTrim2Upper(l.key_code)
														,ut.fnTrim2Upper(l.key_title)
														,ut.fnTrim2Upper(l.company_name)
														,ut.fnTrim2Upper(l.address1)
														,ut.fnTrim2Upper(l.city)
														,ut.fnTrim2Upper(l.state)														
 														,ut.fnTrim2Upper(l.zip)
														,ut.fnTrim2Upper(l.address2)
														,ut.fnTrim2Upper(l.city2)
														,ut.fnTrim2Upper(l.state2)														
 														,ut.fnTrim2Upper(l.zip2)														
														,ut.fnTrim2Upper(l.fips)			
														,ut.fnTrim2Upper(l.phone)
														,ut.fnTrim2Upper(l.spec)
														,ut.fnTrim2Upper(l.spec_expl)
														,ut.fnTrim2Upper(l.spec2)
														,ut.fnTrim2Upper(l.spec2_expl)	
														,ut.fnTrim2Upper(l.spec3)
														,ut.fnTrim2Upper(l.spec3_expl)															
														,ut.fnTrim2Upper(l.id)			
														,ut.fnTrim2Upper(l.persid)			
														,ut.fnTrim2Upper(l.owner));		
	self 							 := l;	
end;

df2_2 := project(df2,into_bdid2(LEFT,COUNTER));

rec3 := record
	rec2;
	string10	prim_range;
	string28	prim_name;
	string10	sec_range;
	string25	p_city_name;	
	string5		my_zip;
	string2		my_st;
	unsigned1 score;
end;

rec3 into_norm(df2_2 L, integer C) := transform
	self.prim_range 	:= if (c = 1, L.mail_prim_range, 	L.alt_prim_range);
	self.prim_name 		:= if (c = 1, L.mail_prim_name, 	L.alt_prim_name);
	self.sec_range 		:= if (c = 1, L.mail_sec_range, 	L.alt_sec_range);
	self.p_city_name 	:= if (c = 1, L.mail_p_city_name, L.alt_p_city_name);	
	self.my_zip 			:= if (c = 1, L.mail_zip, 				L.alt_zip);
	self.my_st 				:= if (c = 1, L.mail_st, 					L.alt_st);
	self.score 				:= 0;
	self 							:= L;
end;

df2_3 := normalize(df2_2,2,into_norm(LEFT,COUNTER));

business_header.MAC_Source_Match(
				 df2_3															// infile
				,outf2															// outfile
				,false															// bool_bdid_field_is_string12
				,bdid																// bdid_field
				,false															// bool_infile_has_source_field
				,MDR.sourceTools.src_SKA						// source_type_or_field
				,false															// bool_infile_has_source_group
				,foo																// source_group_field
				,company_name												// company_name_field
				,prim_range													// prim_range_field
				,prim_name													// prim_name_field
				,sec_range													// sec_range_field
				,my_zip															// zip_field
				,true																// bool_infile_has_phone
				,phone															// phone_field
				,false															// bool_infile_has_fein
				,foo																// fein_field
				,																		// bool_infile_has_vendor_id = 'false'
				,																		// vendor_id field					 = 'vendor_id'
				);

outf2 fake_score(outf2 L) := transform
	self.score := if (l.bdid <> 0, 101, 0);
	self := l;
end;

outf2_bdid_score := project(outf2,fake_score(LEFT));

myset2 := ['A','P'];

Business_Header_SS.MAC_Match_Flex(
			 outf2_bdid_score											// input dataset						
			,myset2				                				// bdid matchset what fields to match on           
			,company_name	                        // company_name	              
			,prim_range		                  			// prim_range		              
			,prim_name		                    		// prim_name		              
			,my_zip					                    	// zip5					              
			,sec_range		                    		// sec_range		              
			,my_st				        		          	// state				              
			,phone						                    // phone				              
			,foo            			           	  	// fein              
			,bdid										        			// bdid												
			,rec3																	// output layout 
			,true                               	// output layout has bdid score field? 																	
			,score                     						// bdid_score                 
			,outf2_3										          // output dataset
			,																			// keep count
			,																			// default threshold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set							// create BIP keys only
			,																			// url
			,																			// email 
			,p_city_name													// city
			,fname																// fname
			,mname																// mname
			,lname																// lname
			,																			// contact ssn
			,source																// source
			,source_rec_id												// source_record_id
			,true																	// if mac_Source_Match appears exists before flex macro
		);	

outf2_4 := dedup(sort(distribute(outf2_3,hash(seq)),seq,-score,bdid,local),seq,local);

busdata.layout_ska_verified_bdid into_out(outf2_4 L) := transform
	self := L;
end;

outf2_5 := join(outf2_4, df2_2, left.seq = right.seq, into_out(LEFT),hash);

ut.MAC_SF_BuildProcess(outf2_5,'~thor_data400::base::ska_verified',do2,2);

export Build_Bases := sequential(do1, do2);

//------------------------------
Out_Population_Stats.Business_Headers.Ska(qa, BH_Stats);
Out_Population_Stats.Business_Contact.SKA(qa, BC_Stats);

STRATA.CreateAsBusinessHeaderStats(BusData.fSKA_As_Business_Header(BusData.File_SKA_Verified_Base,BusData.File_SKA_Nixie_Base),
                                   'SKA',
																	 'data',
																	 '',
																	 '',
                                   runAsBusinessHeaderStats
                                  );

export Proc_Build_SKAs := 
sequential(
	 Build_Bases
	/*,parallel(busdata.Out_Base_Stats_Population_Nixie
	          ,busdata.Out_Base_Stats_Population_Verified
	          ,runAsBusinessHeaderStats)
	,BH_Stats
	,BC_Stats*/
);
