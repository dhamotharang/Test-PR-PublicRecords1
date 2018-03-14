EXPORT compare_function_business_instant_id_cust_rec_batch(current_dt,previous_dt) := functionmacro


layout_reason_codes_plus_seq := RECORD
     unsigned1 seq;
     string3 reason_code;
     string reason_description;
    END;

layout_score := RECORD
    string i;
    string description;
    string3 index;
    DATASET(layout_reason_codes_plus_seq) reason_codes;
   END;

layout_model := RECORD
   string30 accountnumber;
   string description;
   DATASET(layout_score) scores;
  END;

layout:=RECORD
  string errorcode;
  string12 bdid;
  string30 account;
  string120 company_name;
  string120 alt_company_name;
  string100 addr1;
  string25 p_city_name;
  string2 st;
  string5 z5;
  string4 zip4;
  string10 lat;
  string11 long;
  string1 addr_type;
  string4 addr_status;
  string9 fein;
  string10 phone10;
  string45 ip_addr;
  string20 rep_fname;
  string20 rep_mname;
  string20 rep_lname;
  string5 rep_name_suffix;
  string20 rep_alt_lname;
  string100 rep_addr1;
  string25 rep_p_city_name;
  string2 rep_st;
  string5 rep_z5;
  string4 rep_zip4;
  string9 rep_ssn;
  string8 rep_dob;
  string10 rep_phone;
  string3 rep_age;
  string25 rep_dl_num;
  string2 rep_dl_state;
  string100 rep_email;
  string32 riskwiseid;
  string1 cnamematchflag;
  string1 addrmatchflag;
  string1 citymatchflag;
  string1 statematchflag;
  string1 zipmatchflag;
  string1 phonematchflag;
  string1 feinmatchflag;
  string1 vernotrecentflag;
  string120 vercmpy;
  string50 veraddr;
  string30 vercity;
  string2 verstate;
  string5 verzip;
  string20 vercounty;
  string10 verphone;
  string9 verfein;
  string1 bnap_indicator;
  string1 bnat_indicator;
  string1 bnas_indicator;
  string2 bvi;
  string2 ar2bi;
  string3 additional_score_1;
  string3 additional_score_2;
  string4 pri_1;
  string100 pri_desc_1;
  string4 pri_2;
  string100 pri_desc_2;
  string4 pri_3;
  string100 pri_desc_3;
  string4 pri_4;
  string100 pri_desc_4;
  string4 pri_5;
  string100 pri_desc_5;
  string4 pri_6;
  string100 pri_desc_6;
  string4 pri_7;
  string100 pri_desc_7;
  string4 pri_8;
  string100 pri_desc_8;
  string120 bestcompanyname;
  string3 bestcompanynamescore;
  string50 bestaddr;
  string30 bestcity;
  string2 beststate;
  string5 bestzip;
  string4 bestzip4;
  string3 bestaddrscore;
  string9 bestfein;
  string3 bestfeinscore;
  string10 bestphone;
  string3 bestphonescore;
  string10 addrmatchphone;
  string120 phonematchcompany;
  string50 phonematchaddr;
  string30 phonematchcity;
  string2 phonematchstate;
  string5 phonematchzip;
  string4 phonematchzip4;
  string120 feinmatchcompany1;
  string50 feinmatchaddr1;
  string30 feinmatchcity1;
  string2 feinmatchstate1;
  string5 feinmatchzip1;
  string4 feinmatchzip4_1;
  string120 feinmatchcompany2;
  string50 feinmatchaddr2;
  string30 feinmatchcity2;
  string2 feinmatchstate2;
  string5 feinmatchzip2;
  string4 feinmatchzip4_2;
  string120 feinmatchcompany3;
  string50 feinmatchaddr3;
  string30 feinmatchcity3;
  string2 feinmatchstate3;
  string5 feinmatchzip3;
  string4 feinmatchzip4_3;
  string1 baddrtype;
  string1 bphonetype;
  string120 recentbkname;
  string50 recentbkaddr;
  string30 recentbkcity;
  string2 recentbkstate;
  string5 recentbkzip;
  string4 recentbkzip4;
  string5 recentbktype;
  string8 recentbkdate;
  string4 totalbkcount;
  string120 recentlienname;
  string50 recentlienaddr;
  string30 recentliencity;
  string2 recentlienstate;
  string5 recentlienzip;
  string4 recentlienzip4;
  string8 recentliendate;
  string50 recentlientype;
  string4 releasedliencount;
  string4 unreleasedliencount;
  string8 dt_first_seen_min;
  string8 dt_last_seen_max;
  string60 watchlist_table;
  string10 watchlist_record_number;
  string120 watchlist_program;
  string120 watchlist_cmpy;
  string50 watchlist_address;
  string30 watchlist_city;
  string2 watchlist_state;
  string9 watchlist_zip;
  string30 watchlist_country;
  string1 repnameverflag;
  string20 repfnameverify;
  string20 replnameverify;
  string1 repaddrverflag;
  string50 repaddrverify;
  string1 repcityverflag;
  string25 repcityverify;
  string1 repstateverflag;
  string2 repstateverify;
  string1 repzipverflag;
  string5 repzipverify;
  string1 repzip4verflag;
  string4 repzip4verify;
  string20 repcountyverify;
  string1 repphoneverflag;
  string10 repphoneverify;
  string1 repssnverflag;
  string9 repssnverify;
  string1 repdobverflag;
  string8 repdobverify;
  string2 repnas_score;
  string2 repnap_score;
  string2 repcvi;
  string3 rep_additional_score1;
  string3 rep_additional_score2;
  string4 rep_pri_1;
  string100 rep_pri_desc_1;
  string4 rep_pri_2;
  string100 rep_pri_desc_2;
  string4 rep_pri_3;
  string100 rep_pri_desc_3;
  string4 rep_pri_4;
  string100 rep_pri_desc_4;
  string4 rep_pri_5;
  string100 rep_pri_desc_5;
  string4 rep_pri_6;
  string100 rep_pri_desc_6;
  string4 rep_followup_1;
  string150 rep_followup_desc_1;
  string4 rep_followup_2;
  string150 rep_followup_desc_2;
  string4 rep_followup_3;
  string150 rep_followup_desc_3;
  string4 rep_followup_4;
  string150 rep_followup_desc_4;
  string20 repbestfname;
  string20 repbestlname;
  string50 repbestaddr1;
  string30 repbestcity;
  string2 repbeststate;
  string5 repbestzip;
  string4 repbestzip4;
  string8 repbestdob;
  string9 repbestssn;
  string10 repbestphone;
  string1 areacodesplitflag;
  string8 areacodesplitdate;
  string3 altareacode;
  string20 repphonefname;
  string20 repphonelname;
  string50 repphoneaddr1;
  string30 repphonecity;
  string2 repphonestate;
  string5 repphonezip;
  string4 repphonezip4;
  string10 repphonefromaddr;
  string8 repssnearlydate;
  string8 repssnlatedate;
  string2 repssnissuestate;
  string60 repwatchlist_table;
  string10 repwatchlist_record_number;
  string120 repwatchlist_program;
  string20 repwatchlist_lname;
  string20 repwatchlist_fname;
  string50 repwatchlist_address;
  string30 repwatchlist_city;
  string2 repwatchlist_state;
  string9 repwatchlist_zip;
  string30 repwatchlist_country;
  string4 repwatchlist_num_with_name;
  string4 dist_homeaddr_busaddr;
  string4 dist_homephone_busaddr;
  string4 dist_homeaddr_busphone;
  string4 dist_homephone_busphone;
  string4 dist_homephone_homeaddr;
  string4 dist_busphone_busaddr;
  string50 hist_addr_1;
  string30 hist_city_1;
  string2 hist_state_1;
  string5 hist_zip_1;
  string4 hist_zip4_1;
  string10 hist_phone_1;
  string6 hist_date_last_seen_1;
  string50 hist_addr_2;
  string30 hist_city_2;
  string2 hist_state_2;
  string5 hist_zip_2;
  string4 hist_zip4_2;
  string10 hist_phone_2;
  string6 hist_date_last_seen_2;
  string50 hist_addr_3;
  string30 hist_city_3;
  string2 hist_state_3;
  string5 hist_zip_3;
  string4 hist_zip4_3;
  string10 hist_phone_3;
  string6 hist_date_last_seen_3;
  string20 alt_fname_1;
  string20 alt_lname_1;
  string6 alt_date_last_seen_1;
  string20 alt_fname_2;
  string20 alt_lname_2;
  string6 alt_date_last_seen_2;
  string20 alt_fname_3;
  string20 alt_lname_3;
  string6 alt_date_last_seen_3;
  string8 sic_code;
  string8 naics_code;
  string105 business_description;
  unsigned1 recordcount;
  string1 hist_addr_1_isbest;
  string1 hist_addr_2_isbest;
  string1 hist_addr_3_isbest;
  string3 subjectssncount;
  string20 rep_verdl;
  string8 rep_deceaseddate;
  string8 rep_deceaseddob;
  string15 rep_deceasedfirst;
  string20 rep_deceasedlast;
  string120 sos_filing_name;
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
  string200 watchlist_cmpy_2;
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
  string200 watchlist_cmpy_3;
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
  string200 watchlist_cmpy_4;
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
  string200 watchlist_cmpy_5;
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
  string200 watchlist_cmpy_6;
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
  string200 watchlist_cmpy_7;
  string60 repwatchlist_table_2;
  string120 repwatchlist_program_2;
  string10 repwatchlist_record_number_2;
  string20 repwatchlist_fname_2;
  string20 repwatchlist_lname_2;
  string65 repwatchlist_address_2;
  string25 repwatchlist_city_2;
  string2 repwatchlist_state_2;
  string5 repwatchlist_zip_2;
  string30 repwatchlist_country_2;
  string200 repwatchlist_entity_name_2;
  string60 repwatchlist_table_3;
  string120 repwatchlist_program_3;
  string10 repwatchlist_record_number_3;
  string20 repwatchlist_fname_3;
  string20 repwatchlist_lname_3;
  string65 repwatchlist_address_3;
  string25 repwatchlist_city_3;
  string2 repwatchlist_state_3;
  string5 repwatchlist_zip_3;
  string30 repwatchlist_country_3;
  string200 repwatchlist_entity_name_3;
  string60 repwatchlist_table_4;
  string120 repwatchlist_program_4;
  string10 repwatchlist_record_number_4;
  string20 repwatchlist_fname_4;
  string20 repwatchlist_lname_4;
  string65 repwatchlist_address_4;
  string25 repwatchlist_city_4;
  string2 repwatchlist_state_4;
  string5 repwatchlist_zip_4;
  string30 repwatchlist_country_4;
  string200 repwatchlist_entity_name_4;
  string60 repwatchlist_table_5;
  string120 repwatchlist_program_5;
  string10 repwatchlist_record_number_5;
  string20 repwatchlist_fname_5;
  string20 repwatchlist_lname_5;
  string65 repwatchlist_address_5;
  string25 repwatchlist_city_5;
  string2 repwatchlist_state_5;
  string5 repwatchlist_zip_5;
  string30 repwatchlist_country_5;
  string200 repwatchlist_entity_name_5;
  string60 repwatchlist_table_6;
  string120 repwatchlist_program_6;
  string10 repwatchlist_record_number_6;
  string20 repwatchlist_fname_6;
  string20 repwatchlist_lname_6;
  string65 repwatchlist_address_6;
  string25 repwatchlist_city_6;
  string2 repwatchlist_state_6;
  string5 repwatchlist_zip_6;
  string30 repwatchlist_country_6;
  string200 repwatchlist_entity_name_6;
  string60 repwatchlist_table_7;
  string120 repwatchlist_program_7;
  string10 repwatchlist_record_number_7;
  string20 repwatchlist_fname_7;
  string20 repwatchlist_lname_7;
  string65 repwatchlist_address_7;
  string25 repwatchlist_city_7;
  string2 repwatchlist_state_7;
  string5 repwatchlist_zip_7;
  string30 repwatchlist_country_7;
  string200 repwatchlist_entity_name_7;
  string1 pri_seq_1;
  string1 pri_seq_2;
  string1 pri_seq_3;
  string1 pri_seq_4;
  string1 pri_seq_5;
  string1 pri_seq_6;
  string1 pri_seq_7;
  string1 pri_seq_8;
  string1 rep_pri_seq_1;
  string1 rep_pri_seq_2;
  string1 rep_pri_seq_3;
  string1 rep_pri_seq_4;
  string1 rep_pri_seq_5;
  string1 rep_pri_seq_6;
  string1 watchlist_seq_1;
  string1 watchlist_seq_2;
  string1 watchlist_seq_3;
  string1 watchlist_seq_4;
  string1 watchlist_seq_5;
  string1 watchlist_seq_6;
  string1 watchlist_seq_7;
  string1 repwatchlist_seq_1;
  string1 repwatchlist_seq_2;
  string1 repwatchlist_seq_3;
  string1 repwatchlist_seq_4;
  string1 repwatchlist_seq_5;
  string1 repwatchlist_seq_6;
  string1 repwatchlist_seq_7;
  // DATASET(layout_model) models;
 END;





DS1:= dataset('~foreign::10.241.3.238::sghatti::out::business_instant_id_batch_cust_rec_'+previous_dt, layout,


 CSV(HEADING(single), QUOTE('"')));



DS2:= dataset('~foreign::10.241.3.238::sghatti::out::business_instant_id_batch_cust_rec_'+current_dt, layout,


 CSV(HEADING(single), QUOTE('"')));


    	  RiskView_Attributes_Reports.count_function(DS1,'pri_1',c1);
      	RiskView_Attributes_Reports.count_function(DS1,'pri_2',c2);
				RiskView_Attributes_Reports.count_function(DS1,'pri_3',c3);
      	RiskView_Attributes_Reports.count_function(DS1,'pri_4',c4);
			  RiskView_Attributes_Reports.count_function(DS1,'pri_5',c5);
      	RiskView_Attributes_Reports.count_function(DS1,'pri_6',c6);
				RiskView_Attributes_Reports.count_function(DS1,'pri_7',c7);
      	RiskView_Attributes_Reports.count_function(DS1,'pri_8',c8);
				RiskView_Attributes_Reports.count_function(DS1,'rep_pri_1',c9);
      	RiskView_Attributes_Reports.count_function(DS1,'rep_pri_2',c10);
			  RiskView_Attributes_Reports.count_function(DS1,'rep_pri_3',c11);
      	RiskView_Attributes_Reports.count_function(DS1,'rep_pri_4',c12);
				RiskView_Attributes_Reports.count_function(DS1,'rep_pri_5',c13);
      	RiskView_Attributes_Reports.count_function(DS1,'rep_pri_6',c14);
			
				
ar:=	c1  + c2  + c3  + c4 + c5 + c6 + c7 + c8  + c9  + c10 +
		  c11 + c12 + c13 + c14;	

	

			RiskView_Attributes_Reports.count_function1(ar,'pri_indicator',ar_1);
			
	
				
      
				
				
						 
				score_file1:=	ar_1;
						 
			////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////
			
			
	      
    	  RiskView_Attributes_Reports.count_function(DS2,'pri_1',cc1);
      	RiskView_Attributes_Reports.count_function(DS2,'pri_2',cc2);
				RiskView_Attributes_Reports.count_function(DS2,'pri_3',cc3);
      	RiskView_Attributes_Reports.count_function(DS2,'pri_4',cc4);
			  RiskView_Attributes_Reports.count_function(DS2,'pri_5',cc5);
      	RiskView_Attributes_Reports.count_function(DS2,'pri_6',cc6);
				RiskView_Attributes_Reports.count_function(DS2,'pri_7',cc7);
      	RiskView_Attributes_Reports.count_function(DS2,'pri_8',cc8);
				RiskView_Attributes_Reports.count_function(DS2,'rep_pri_1',cc9);
      	RiskView_Attributes_Reports.count_function(DS2,'rep_pri_2',cc10);
			  RiskView_Attributes_Reports.count_function(DS2,'rep_pri_3',cc11);
      	RiskView_Attributes_Reports.count_function(DS2,'rep_pri_4',cc12);
				RiskView_Attributes_Reports.count_function(DS2,'rep_pri_5',cc13);
      	RiskView_Attributes_Reports.count_function(DS2,'rep_pri_6',cc14);
				
ar2:=	cc1  + cc2  + cc3  + cc4 + cc5 + cc6 + cc7 + cc8  + cc9  + cc10 +
		  cc11 + cc12 + cc13 + cc14;		

	

			RiskView_Attributes_Reports.count_function1(ar2,'pri_indicator',ar_2);
			
	
				
      	
				
				
				
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
																										self.file_version:='business_instant_id_cust_rec',
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

