EXPORT compare_function_riskprocessing_instant_id_batch(current_dt,previous_dt) := functionmacro


riskprocessing_instant_id_batch_layout:=RECORD
  string30 acctno;
  string12 did;
  string12 seq;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 suffix;
  string120 in_streetaddress;
  string25 in_city;
  string2 in_state;
  string5 in_zipcode;
  string25 in_country;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 st;
  string5 z5;
  string4 zip4;
  string10 lat;
  string11 long;
  string3 county;
  string7 geo_blk;
  string1 addr_type;
  string4 addr_status;
  string25 country;
  string9 ssn;
  string8 dob;
  string3 age;
  string20 dl_number;
  string2 dl_state;
  string50 email_address;
  string20 ip_address;
  string10 phone10;
  string10 wphone10;
  string100 employer_name;
  string20 lname_prev;
  string12 transaction_id;
  string20 verfirst;
  string20 verlast;
  string65 veraddr;
  string25 vercity;
  string2 verstate;
  string9 verzip;
  string4 verzip4;
  string20 vercounty;
  string9 verssn;
  string8 verdob;
  string10 verhphone;
  string1 verify_addr;
  string1 verify_dob;
  string1 valid_ssn;
  string3 nas_summary;
  string3 nap_summary;
  string1 nap_type;
  string1 nap_status;
  string3 cvi;
  string3 additional_score1;
  string3 additional_score2;
  string4 hri_1;
  string100 hri_desc_1;
  string4 hri_2;
  string100 hri_desc_2;
  string4 hri_3;
  string100 hri_desc_3;
  string4 hri_4;
  string100 hri_desc_4;
  string4 hri_5;
  string100 hri_desc_5;
  string4 hri_6;
  string100 hri_desc_6;
  string4 fua_1;
  string150 fua_desc_1;
  string4 fua_2;
  string150 fua_desc_2;
  string4 fua_3;
  string150 fua_desc_3;
  string4 fua_4;
  string150 fua_desc_4;
  string20 corrected_lname;
  string8 corrected_dob;
  string10 corrected_phone;
  string9 corrected_ssn;
  string65 corrected_address;
  string3 area_code_split;
  string8 area_code_split_date;
  string20 phone_fname;
  string20 phone_lname;
  string65 phone_address;
  string25 phone_city;
  string2 phone_st;
  string5 phone_zip;
  string10 name_addr_phone;
  string6 ssa_date_first;
  string6 ssa_date_last;
  string2 ssa_state;
  string20 ssa_state_name;
  string20 current_fname;
  string20 current_lname;
  string65 chron_address_1;
  string25 chron_city_1;
  string2 chron_st_1;
  string5 chron_zip_1;
  string4 chron_zip4_1;
  string50 chron_phone_1;
  string6 chron_dt_first_seen_1;
  string6 chron_dt_last_seen_1;
  string65 chron_address_2;
  string25 chron_city_2;
  string2 chron_st_2;
  string5 chron_zip_2;
  string4 chron_zip4_2;
  string50 chron_phone_2;
  string6 chron_dt_first_seen_2;
  string6 chron_dt_last_seen_2;
  string65 chron_address_3;
  string25 chron_city_3;
  string2 chron_st_3;
  string5 chron_zip_3;
  string4 chron_zip4_3;
  string50 chron_phone_3;
  string6 chron_dt_first_seen_3;
  string6 chron_dt_last_seen_3;
  string20 additional_fname_1;
  string20 additional_lname_1;
  string8 additional_lname_date_last_1;
  string20 additional_fname_2;
  string20 additional_lname_2;
  string8 additional_lname_date_last_2;
  string20 additional_fname_3;
  string20 additional_lname_3;
  string8 additional_lname_date_last_3;
  string60 watchlist_table;
  string120 watchlist_program;
  string10 watchlist_record_number;
  string20 watchlist_fname;
  string20 watchlist_lname;
  string65 watchlist_address;
  string25 watchlist_city;
  string2 watchlist_state;
  string5 watchlist_zip;
  string30 watchlist_country;
  string200 watchlist_entity_name;
  string1 chron_addr_1_isbest;
  string1 chron_addr_2_isbest;
  string1 chron_addr_3_isbest;
  string3 subjectssncount;
  string20 verdl;
  string8 deceaseddate;
  string8 deceaseddob;
  string15 deceasedfirst;
  string20 deceasedlast;
  string60 watchlist_table_2;
  string120 watchlist_program_2;
  string10 watchlist_record_number_2;
  string20 watchlist_fname_2;
  string20 watchlist_lname_2;
  string65 watchlist_address_2;
  string25 watchlist_city_2;
  string2 watchlist_state_2;
  string5 watchlist_zip_2;
  string30 watchlist_country_2;
  string200 watchlist_entity_name_2;
  string60 watchlist_table_3;
  string120 watchlist_program_3;
  string10 watchlist_record_number_3;
  string20 watchlist_fname_3;
  string20 watchlist_lname_3;
  string65 watchlist_address_3;
  string25 watchlist_city_3;
  string2 watchlist_state_3;
  string5 watchlist_zip_3;
  string30 watchlist_country_3;
  string200 watchlist_entity_name_3;
  string60 watchlist_table_4;
  string120 watchlist_program_4;
  string10 watchlist_record_number_4;
  string20 watchlist_fname_4;
  string20 watchlist_lname_4;
  string65 watchlist_address_4;
  string25 watchlist_city_4;
  string2 watchlist_state_4;
  string5 watchlist_zip_4;
  string30 watchlist_country_4;
  string200 watchlist_entity_name_4;
  string60 watchlist_table_5;
  string120 watchlist_program_5;
  string10 watchlist_record_number_5;
  string20 watchlist_fname_5;
  string20 watchlist_lname_5;
  string65 watchlist_address_5;
  string25 watchlist_city_5;
  string2 watchlist_state_5;
  string5 watchlist_zip_5;
  string30 watchlist_country_5;
  string200 watchlist_entity_name_5;
  string60 watchlist_table_6;
  string120 watchlist_program_6;
  string10 watchlist_record_number_6;
  string20 watchlist_fname_6;
  string20 watchlist_lname_6;
  string65 watchlist_address_6;
  string25 watchlist_city_6;
  string2 watchlist_state_6;
  string5 watchlist_zip_6;
  string30 watchlist_country_6;
  string200 watchlist_entity_name_6;
  string60 watchlist_table_7;
  string120 watchlist_program_7;
  string10 watchlist_record_number_7;
  string20 watchlist_fname_7;
  string20 watchlist_lname_7;
  string65 watchlist_address_7;
  string25 watchlist_city_7;
  string2 watchlist_state_7;
  string5 watchlist_zip_7;
  string30 watchlist_country_7;
  string200 watchlist_entity_name_7;
  string1 passportvalidated;
  string1 dobmatchlevel;
  string4 hri_7;
  string100 hri_desc_7;
  string4 hri_8;
  string100 hri_desc_8;
  string4 hri_9;
  string100 hri_desc_9;
  string4 hri_10;
  string100 hri_desc_10;
  string4 hri_11;
  string100 hri_desc_11;
  string4 hri_12;
  string100 hri_desc_12;
  string4 hri_13;
  string100 hri_desc_13;
  string4 hri_14;
  string100 hri_desc_14;
  string4 hri_15;
  string100 hri_desc_15;
  string4 hri_16;
  string100 hri_desc_16;
  string4 hri_17;
  string100 hri_desc_17;
  string4 hri_18;
  string100 hri_desc_18;
  string4 hri_19;
  string100 hri_desc_19;
  string4 hri_20;
  string100 hri_desc_20;
  string10 verprimrange;
  string2 verpredir;
  string28 verprimname;
  string4 veraddrsuffix;
  string2 verpostdir;
  string10 verunitdesignation;
  string8 versecrange;
  string10 correctedprimrange;
  string2 correctedpredir;
  string28 correctedprimname;
  string4 correctedaddrsuffix;
  string2 correctedpostdir;
  string10 correctedunitdesignation;
  string8 correctedsecrange;
  string10 phoneprimrange;
  string2 phonepredir;
  string28 phoneprimname;
  string4 phoneaddrsuffix;
  string2 phonepostdir;
  string10 phoneunitdesignation;
  string8 phonesecrange;
  string10 chronprimrange1;
  string2 chronpredir1;
  string28 chronprimname1;
  string4 chronaddrsuffix1;
  string2 chronpostdir1;
  string10 chronunitdesignation1;
  string8 chronsecrange1;
  string10 chronprimrange2;
  string2 chronpredir2;
  string28 chronprimname2;
  string4 chronaddrsuffix2;
  string2 chronpostdir2;
  string10 chronunitdesignation2;
  string8 chronsecrange2;
  string10 chronprimrange3;
  string2 chronpredir3;
  string28 chronprimname3;
  string4 chronaddrsuffix3;
  string2 chronpostdir3;
  string10 chronunitdesignation3;
  string8 chronsecrange3;
  string10 watchlistprimrange;
  string2 watchlistpredir;
  string28 watchlistprimname;
  string4 watchlistaddrsuffix;
  string2 watchlistpostdir;
  string10 watchlistunitdesignation;
  string8 watchlistsecrange;
  string10 watchlistprimrange2;
  string2 watchlistpredir2;
  string28 watchlistprimname2;
  string4 watchlistaddrsuffix2;
  string2 watchlistpostdir2;
  string10 watchlistunitdesignation2;
  string8 watchlistsecrange2;
  string10 watchlistprimrange3;
  string2 watchlistpredir3;
  string28 watchlistprimname3;
  string4 watchlistaddrsuffix3;
  string2 watchlistpostdir3;
  string10 watchlistunitdesignation3;
  string8 watchlistsecrange3;
  string10 watchlistprimrange4;
  string2 watchlistpredir4;
  string28 watchlistprimname4;
  string4 watchlistaddrsuffix4;
  string2 watchlistpostdir4;
  string10 watchlistunitdesignation4;
  string8 watchlistsecrange4;
  string10 watchlistprimrange5;
  string2 watchlistpredir5;
  string28 watchlistprimname5;
  string4 watchlistaddrsuffix5;
  string2 watchlistpostdir5;
  string10 watchlistunitdesignation5;
  string8 watchlistsecrange5;
  string10 watchlistprimrange6;
  string2 watchlistpredir6;
  string28 watchlistprimname6;
  string4 watchlistaddrsuffix6;
  string2 watchlistpostdir6;
  string10 watchlistunitdesignation6;
  string8 watchlistsecrange6;
  string10 watchlistprimrange7;
  string2 watchlistpredir7;
  string28 watchlistprimname7;
  string4 watchlistaddrsuffix7;
  string2 watchlistpostdir7;
  string10 watchlistunitdesignation7;
  string8 watchlistsecrange7;
  string errorcode;
 END;

// sghatti::out::fcra_riskprocessing_instant_id_20131030_1

DS1:= dataset('~foreign::10.241.3.238::sghatti::out::riskprocessing_instant_id_batch_'+previous_dt, riskprocessing_instant_id_batch_layout,


 CSV(HEADING(single), QUOTE('"')));

DS2:= dataset('~foreign::10.241.3.238::sghatti::out::riskprocessing_instant_id_batch_'+current_dt, riskprocessing_instant_id_batch_layout,


 CSV(HEADING(single), QUOTE('"')));

	 
    	  RiskView_Attributes_Reports.count_function(DS1,'hri_1',c1);
      	RiskView_Attributes_Reports.count_function(DS1,'hri_2',c2);
				RiskView_Attributes_Reports.count_function(DS1,'hri_3',c3);
      	RiskView_Attributes_Reports.count_function(DS1,'hri_4',c4);
			  RiskView_Attributes_Reports.count_function(DS1,'hri_5',c5);
      	RiskView_Attributes_Reports.count_function(DS1,'hri_6',c6);
				RiskView_Attributes_Reports.count_function(DS1,'hri_7',c7);
      	RiskView_Attributes_Reports.count_function(DS1,'hri_8',c8);
				RiskView_Attributes_Reports.count_function(DS1,'hri_9',c9);
      	RiskView_Attributes_Reports.count_function(DS1,'hri_10',c10);
			  RiskView_Attributes_Reports.count_function(DS1,'hri_11',c11);
      	RiskView_Attributes_Reports.count_function(DS1,'hri_12',c12);
				RiskView_Attributes_Reports.count_function(DS1,'hri_13',c13);
      	RiskView_Attributes_Reports.count_function(DS1,'hri_14',c14);
				RiskView_Attributes_Reports.count_function(DS1,'hri_15',c15);
      	RiskView_Attributes_Reports.count_function(DS1,'hri_16',c16);
			  RiskView_Attributes_Reports.count_function(DS1,'hri_17',c17);
      	RiskView_Attributes_Reports.count_function(DS1,'hri_18',c18);
				RiskView_Attributes_Reports.count_function(DS1,'hri_19',c19);
      	RiskView_Attributes_Reports.count_function(DS1,'hri_20',c20);
				
ar:=	c1  + c2  + c3  + c4 + c5 + c6 + c7 + c8  + c9  + c10 +
		  c11 + c12 + c13 + c14 + c15 + c16 + c17 + c18 + c19 + c20;	

	

			RiskView_Attributes_Reports.count_function1(ar,'hri_indicator',ar_1);
			
	
				
      
				
				
						 
				score_file1:=	ar_1;
						 
			////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////
			
			
	      
    	  RiskView_Attributes_Reports.count_function(DS2,'hri_1',cc1);
      	RiskView_Attributes_Reports.count_function(DS2,'hri_2',cc2);
				RiskView_Attributes_Reports.count_function(DS2,'hri_3',cc3);
      	RiskView_Attributes_Reports.count_function(DS2,'hri_4',cc4);
			  RiskView_Attributes_Reports.count_function(DS2,'hri_5',cc5);
      	RiskView_Attributes_Reports.count_function(DS2,'hri_6',cc6);
				
				RiskView_Attributes_Reports.count_function(DS2,'hri_7',cc7);
      	RiskView_Attributes_Reports.count_function(DS2,'hri_8',cc8);
				RiskView_Attributes_Reports.count_function(DS2,'hri_9',cc9);
      	RiskView_Attributes_Reports.count_function(DS2,'hri_10',cc10);
			  RiskView_Attributes_Reports.count_function(DS2,'hri_11',cc11);
      	RiskView_Attributes_Reports.count_function(DS2,'hri_12',cc12);
				RiskView_Attributes_Reports.count_function(DS2,'hri_13',cc13);
      	RiskView_Attributes_Reports.count_function(DS2,'hri_14',cc14);
				RiskView_Attributes_Reports.count_function(DS2,'hri_15',cc15);
      	RiskView_Attributes_Reports.count_function(DS2,'hri_16',cc16);
			  RiskView_Attributes_Reports.count_function(DS2,'hri_17',cc17);
      	RiskView_Attributes_Reports.count_function(DS2,'hri_18',cc18);
				RiskView_Attributes_Reports.count_function(DS2,'hri_19',cc19);
      	RiskView_Attributes_Reports.count_function(DS2,'hri_20',cc20);
				
ar2:=	cc1  + cc2  + cc3  + cc4 + cc5 + cc6 + cc7 + cc8  + cc9  + cc10 +
		  cc11 + cc12 + cc13 + cc14 + cc15 + cc16 + cc17 + cc18 + cc19 + cc20;		

	

			RiskView_Attributes_Reports.count_function1(ar2,'hri_indicator',ar_2);
			
	
				
      	
				
				
				
						score_file2:=	ar_2;	 
						 
		    compare_layout := RECORD
   		   string file_version;
				 string mode;
   		   string field_name;
				 integer p_file_count;
				 integer c_file_count;
				 integer file_count_diff;
         STRING50 reason_code; 
         decimal20_4 p_frequency;
         decimal20_4 c_frequency;
         decimal20_4 frequency_diff;
   			decimal20_4 perc_frequency_diff;
      	  decimal20_4 p_proportion;
         decimal20_4 c_proportion;
         decimal20_4 proportion_diff;
   			decimal20_4 abs_proportion_diff;
   			decimal20_4 perc_proportion_diff;
   	
   								
               END;		
							 
			compare_result1:= join(score_file2,score_file1,
   				                                    
         	                                        left.field_name = right.field_name and
            									               	      left.attribute_value = right.attribute_value //and
            									                      // left.Count1 = right.Count1
      																							,transform(	compare_layout, 
																										self.file_version:='riskprocessing_instant_id',
																										self.mode:='batch',
																										                          self.field_name:=if(left.field_name='',right.field_name,left.field_name),
																																							self.p_file_count:=count(ds1),
																																							self.c_file_count:=count(ds2),
																																							self.file_count_diff:=count(ds2)-count(ds1),
                     			 			                                          	  self.reason_code:= if(left.attribute_value='',  right.attribute_value, left.attribute_value ) ,
         																																		  self.p_frequency:=right.Count1,
                     			 			                                              self.c_frequency:=left.Count1,
                  																														self.frequency_diff:=left.Count1-right.Count1,
   																																						self.perc_frequency_diff:=if (right.Count1!= 0 and left.Count1=0,1,(left.Count1-right.Count1)/left.Count1),
      																																				self.p_proportion:=right.Count1/count(ds1),
                     			 			                                              self.c_proportion:=left.Count1/count(ds2),
                  																													  self.proportion_diff:=(left.Count1/count(ds2))-(right.Count1/count(ds1)),
   																																						self.abs_proportion_diff:=abs((left.Count1/count(ds2))-(right.Count1/count(ds1))),
   																																						self.perc_proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,abs(((left.Count1/count(ds2))-(right.Count1/count(ds1)))/(left.Count1/count(ds2))))
   																																						
         																						                        ),full outer
         																																											 );					 
							 
							 
							 
						 
																										 
																																														 
							return choosen(compare_result1,all);			
							
							
							endmacro;

