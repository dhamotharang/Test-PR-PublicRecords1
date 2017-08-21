VendorSet := ['A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9', 'AA',
              'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AM',
							'AN', 'AP', 'AQ', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX',	'AY',
							'AZ', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9', 'C0',
							'C1', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'D0',	'D1',	'D2',
							'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9', 'E1', 'E2', 'E3',
							'E4', 'E5', 'E6', 'E7', 'E8', 'E9', 'F1', 'F2', 'F3', 'F4',
							'F5',	'F6', 'F7', 'F8', 'F9', 'G1', 'G2', 'G3', 'G4', 'G5',
							'G6', 'G8'];

dOffenses	:=	crim_common.File_Moxie_Court_Offenses_Dev(vendor in VendorSet);
dOffender	:=	crim_common.File_Moxie_Crim_Offender2_Dev(vendor in VendorSet);
//dActivity	:=	dataset('~thor_data400::in::court_crim_activity_' + Version_Development,	Layout_In_Court_Activity, flat);

Layout_Crim_Offender_CSV
 :=
  record
    string      process_date;
    string      offender_key;
    string      vendor;
    string      state_origin;
    string      data_type;
    string      source_file;
    string      case_number;
    string      case_court;
    string      case_name;
    string      case_type;
    string      case_type_desc;
    string      case_filing_dt;
    string      pty_nm;
    string      pty_nm_fmt;
    string      orig_lname;
    string      orig_fname;
    string      orig_mname;
    string      orig_name_suffix;
    string      pty_typ;
    string      nitro_flag;
    string      orig_ssn;
    string      dle_num;
    string      fbi_num;
    string      doc_num;
    string      ins_num;
    string      id_num;
    string      dl_num;
    string      dl_state;
    string      citizenship;
    string      dob;
    string      dob_alias;
    string      place_of_birth;
    string      street_address_1;
    string      street_address_2;
    string      street_address_3;
    string      street_address_4;
    string      street_address_5;
    string      race;
    string      race_desc;
    string      sex;
    string      hair_color;
    string      hair_color_desc;
    string      eye_color;
    string      eye_color_desc;
    string      skin_color;
    string      skin_color_desc;
    string      height;
    string      weight;
    string      party_status;
    string      party_status_desc;
    string      prim_range;
    string      predir;
    string      prim_name;
    string      addr_suffix;
    string      postdir;
    string      unit_desig;
    string      sec_range;
    string      p_city_name;
    string      v_city_name;
    string      state;
    string      zip5;
    string      zip4;
    string      cart;
    string      cr_sort_sz;
    string      lot;
    string      lot_order;
    string      dpbc;
    string      chk_digit;
    string      rec_type;
    string      ace_fips_st;
    string      ace_fips_county;
    string      geo_lat;
    string      geo_long;
    string      msa;
    string      geo_blk;
    string      geo_match;
    string      err_stat;
    string      title;
    string      fname;
    string      mname;
    string      lname;
    string      name_suffix;
    string      cleaning_score;
	string 		ssn;
	string	 	did;
	string	 	pgid;
  end
 ;

Layout_In_Court_Offenses_CSV
 :=
  record
    string    process_date;
    string    offender_key;
    string    vendor;
    string    state_origin;
    string    source_file;
    string    off_comp;
    string    off_delete_flag;
    string    off_date;
    string    arr_date;
    string    num_of_counts;
    string    le_agency_cd;
    string    le_agency_desc;
    string    le_agency_case_number;
    string    traffic_ticket_number;
    string    traffic_dl_no;
    string    traffic_dl_st;
    string    arr_off_code;
    string    arr_off_desc_1;
    string    arr_off_desc_2;
    string    arr_off_type_cd;
    string    arr_off_type_desc;
    string    arr_off_lev;
    string    arr_statute;
    string    arr_statute_desc;
    string    arr_disp_date;
    string    arr_disp_code;
    string    arr_disp_desc_1;
    string    arr_disp_desc_2;
    string    pros_refer_cd;
    string    pros_refer;
    string    pros_assgn_cd;
    string    pros_assgn;
    string    pros_chg_rej;
    string    pros_off_code;
    string    pros_off_desc_1;
    string    pros_off_desc_2;
    string    pros_off_type_cd;
    string    pros_off_type_desc;
    string    pros_off_lev;
    string    pros_act_filed;
    string    court_case_number;
    string    court_cd;
    string    court_desc;
    string    court_appeal_flag;
    string    court_final_plea;
    string    court_off_code;
    string    court_off_desc_1;
    string    court_off_desc_2;
    string    court_off_type_cd;
    string    court_off_type_desc;
    string    court_off_lev;
    string    court_statute;
    string    court_additional_statutes;
    string    court_statute_desc;
    string    court_disp_date;
    string    court_disp_code;
    string    court_disp_desc_1;
    string    court_disp_desc_2;
    string    sent_date;
    string    sent_jail;
    string    sent_susp_time;
    string    sent_court_cost;
    string    sent_court_fine;
    string    sent_susp_court_fine;
    string    sent_probation;
    string    sent_addl_prov_code;
    string    sent_addl_prov_desc_1;
    string    sent_addl_prov_desc_2;
    string    sent_consec;
    string    sent_agency_rec_cust_ori;
    string    sent_agency_rec_cust;
    string    appeal_date;
    string    appeal_off_disp;
    string    appeal_final_decision;
  end
 ;
 
Layout_In_Court_Activity_CSV
 :=
  record
    string    process_date;
    string    offender_key;
    string    vendor;
    string    state_origin;
    string    source_file;
		string    off_comp;
    string    case_number;
    string    event_type;
    string    event_sort_key;
    string    event_date;
    string    event_location_code;
    string    event_location_desc;
    string    event_desc_code;
    string    event_desc_1;
    string    event_desc_2;
  end
 ;
 
Layout_In_Court_Offenses_CSV	tOffensesToCSV(dOffenses pInput)
 :=
  transform
	self.process_date                  := trim(pInput.process_date);                     
	self.offender_key                  := trim(pInput.offender_key);                     
	self.vendor                        := trim(pInput.vendor);                           
	self.state_origin                  := trim(pInput.state_origin);                     
	self.source_file                   := trim(pInput.source_file);                      
	self.off_comp                      := trim(pInput.off_comp);                         
	self.off_delete_flag               := trim(pInput.off_delete_flag);                  
	self.off_date                      := trim(pInput.off_date);                         
	self.arr_date                      := trim(pInput.arr_date);                         
	self.num_of_counts                 := trim(pInput.num_of_counts);                    
	self.le_agency_cd                  := trim(pInput.le_agency_cd);                     
	self.le_agency_desc                := trim(pInput.le_agency_desc);                   
	self.le_agency_case_number         := trim(pInput.le_agency_case_number);            
	self.traffic_ticket_number         := trim(pInput.traffic_ticket_number);            
	self.traffic_dl_no                 := trim(pInput.traffic_dl_no);                    
	self.traffic_dl_st                 := trim(pInput.traffic_dl_st);                    
	self.arr_off_code                  := trim(pInput.arr_off_code);                     
	self.arr_off_desc_1                := trim(pInput.arr_off_desc_1);                   
	self.arr_off_desc_2                := trim(pInput.arr_off_desc_2);                   
	self.arr_off_type_cd               := trim(pInput.arr_off_type_cd);                  
	self.arr_off_type_desc             := trim(pInput.arr_off_type_desc);                
	self.arr_off_lev                   := trim(pInput.arr_off_lev);                      
	self.arr_statute                   := trim(pInput.arr_statute);                      
	self.arr_statute_desc              := trim(pInput.arr_statute_desc);                 
	self.arr_disp_date                 := trim(pInput.arr_disp_date);                    
	self.arr_disp_code                 := trim(pInput.arr_disp_code);                    
	self.arr_disp_desc_1               := trim(pInput.arr_disp_desc_1);                  
	self.arr_disp_desc_2               := trim(pInput.arr_disp_desc_2);                  
	self.pros_refer_cd                 := trim(pInput.pros_refer_cd);                    
	self.pros_refer                    := trim(pInput.pros_refer);                       
	self.pros_assgn_cd                 := trim(pInput.pros_assgn_cd);                    
	self.pros_assgn                    := trim(pInput.pros_assgn);                       
	self.pros_chg_rej                  := trim(pInput.pros_chg_rej);                     
	self.pros_off_code                 := trim(pInput.pros_off_code);                    
	self.pros_off_desc_1               := trim(pInput.pros_off_desc_1);                  
	self.pros_off_desc_2               := trim(pInput.pros_off_desc_2);                  
	self.pros_off_type_cd              := trim(pInput.pros_off_type_cd);                 
	self.pros_off_type_desc            := trim(pInput.pros_off_type_desc);               
	self.pros_off_lev                  := trim(pInput.pros_off_lev);                     
	self.pros_act_filed                := trim(pInput.pros_act_filed);                   
	self.court_case_number             := trim(pInput.court_case_number);                
	self.court_cd                      := trim(pInput.court_cd);                         
	self.court_desc                    := trim(pInput.court_desc);                       
	self.court_appeal_flag             := trim(pInput.court_appeal_flag);                
	self.court_final_plea              := trim(pInput.court_final_plea);                 
	self.court_off_code                := trim(pInput.court_off_code);                   
	self.court_off_desc_1              := trim(pInput.court_off_desc_1);                 
	self.court_off_desc_2              := trim(pInput.court_off_desc_2);                 
	self.court_off_type_cd             := trim(pInput.court_off_type_cd);                
	self.court_off_type_desc           := trim(pInput.court_off_type_desc);              
	self.court_off_lev                 := trim(pInput.court_off_lev);                    
	self.court_statute                 := trim(pInput.court_statute);                    
	self.court_additional_statutes     := trim(pInput.court_additional_statutes);        
	self.court_statute_desc            := trim(pInput.court_statute_desc);               
	self.court_disp_date               := trim(pInput.court_disp_date);                  
	self.court_disp_code               := trim(pInput.court_disp_code);                  
	self.court_disp_desc_1             := trim(pInput.court_disp_desc_1);                
	self.court_disp_desc_2             := trim(pInput.court_disp_desc_2);                
	self.sent_date                     := trim(pInput.sent_date);                        
	self.sent_jail                     := trim(pInput.sent_jail);                        
	self.sent_susp_time                := trim(pInput.sent_susp_time);                   
	self.sent_court_cost               := trim(pInput.sent_court_cost);                  
	self.sent_court_fine               := trim(pInput.sent_court_fine);                  
	self.sent_susp_court_fine          := trim(pInput.sent_susp_court_fine);             
	self.sent_probation                := trim(pInput.sent_probation);                   
	self.sent_addl_prov_code           := trim(pInput.sent_addl_prov_code);              
	self.sent_addl_prov_desc_1         := trim(pInput.sent_addl_prov_desc_1);            
	self.sent_addl_prov_desc_2         := trim(pInput.sent_addl_prov_desc_2);            
	self.sent_consec                   := trim(pInput.sent_consec);                      
	self.sent_agency_rec_cust_ori      := trim(pInput.sent_agency_rec_cust_ori);         
	self.sent_agency_rec_cust          := trim(pInput.sent_agency_rec_cust);             
	self.appeal_date                   := trim(pInput.appeal_date);                      
	self.appeal_off_disp               := trim(pInput.appeal_off_disp);                  
	self.appeal_final_decision         := trim(pInput.appeal_final_decision);            
  end
 ;

Layout_Crim_Offender_CSV	tOffenderToCSV(dOffender pInput)
 :=
  transform
	self.process_date		   := trim(pInput.process_date,left,right);
	self.offender_key          := trim(pInput.offender_key,left,right);
	self.vendor                := trim(pInput.vendor,left,right);
	self.state_origin          := trim(pInput.state_origin,left,right);
	self.data_type             := trim(pInput.data_type,left,right);
	self.source_file           := trim(pInput.source_file,left,right);
	self.case_number           := trim(pInput.case_number,left,right);
	self.case_court            := trim(pInput.case_court,left,right);
	self.case_name             := trim(pInput.case_name,left,right);
	self.case_type             := trim(pInput.case_type,left,right);
	self.case_type_desc        := trim(pInput.case_type_desc,left,right);
	self.case_filing_dt        := trim(pInput.case_filing_dt,left,right);
	self.pty_nm                := trim(pInput.pty_nm,left,right);
	self.pty_nm_fmt            := trim(pInput.pty_nm_fmt,left,right);
	self.orig_lname            := trim(pInput.orig_lname,left,right);
	self.orig_fname            := trim(pInput.orig_fname,left,right);
	self.orig_mname            := trim(pInput.orig_mname,left,right);
	self.orig_name_suffix      := trim(pInput.orig_name_suffix,left,right);
	self.pty_typ               := trim(pInput.pty_typ,left,right);
	self.nitro_flag            := trim(pInput.nitro_flag,left,right);
	self.orig_ssn              := trim(pInput.orig_ssn,left,right);
	self.dle_num               := trim(pInput.dle_num,left,right);
	self.fbi_num               := trim(pInput.fbi_num,left,right);
	self.doc_num               := trim(pInput.doc_num,left,right);
	self.ins_num               := trim(pInput.ins_num,left,right);
	self.id_num                := trim(pInput.id_num,left,right);
	self.dl_num                := trim(pInput.dl_num,left,right);
	self.dl_state              := trim(pInput.dl_state,left,right);
	self.citizenship           := trim(pInput.citizenship,left,right);
	self.dob                   := trim(pInput.dob,left,right);
	self.dob_alias             := trim(pInput.dob_alias,left,right);
	self.place_of_birth        := trim(pInput.place_of_birth,left,right);
	self.street_address_1      := trim(pInput.street_address_1,left,right);
	self.street_address_2      := trim(pInput.street_address_2,left,right);
	self.street_address_3      := trim(pInput.street_address_3,left,right);
	self.street_address_4      := trim(pInput.street_address_4,left,right);
	self.street_address_5      := trim(pInput.street_address_5,left,right);
	self.race                  := trim(pInput.race,left,right);
	self.race_desc             := trim(pInput.race_desc,left,right);
	self.sex                   := trim(pInput.sex,left,right);
	self.hair_color            := trim(pInput.hair_color,left,right);
	self.hair_color_desc       := trim(pInput.hair_color_desc,left,right);
	self.eye_color             := trim(pInput.eye_color,left,right);
	self.eye_color_desc        := trim(pInput.eye_color_desc,left,right);
	self.skin_color            := trim(pInput.skin_color,left,right);
	self.skin_color_desc       := trim(pInput.skin_color_desc,left,right);
	self.height                := trim(pInput.height,left,right);
	self.weight                := trim(pInput.weight,left,right);
	self.party_status          := trim(pInput.party_status,left,right);
	self.party_status_desc     := trim(pInput.party_status_desc,left,right);
	self.prim_range            := trim(pInput.prim_range,left,right);
	self.predir                := trim(pInput.predir,left,right);
	self.prim_name             := trim(pInput.prim_name,left,right);
	self.addr_suffix           := trim(pInput.addr_suffix,left,right);
	self.postdir               := trim(pInput.postdir,left,right);
	self.unit_desig            := trim(pInput.unit_desig,left,right);
	self.sec_range             := trim(pInput.sec_range,left,right);
	self.p_city_name           := trim(pInput.p_city_name,left,right);
	self.v_city_name           := trim(pInput.v_city_name,left,right);
	self.state                 := trim(pInput.state,left,right);
	self.zip5                  := trim(pInput.zip5,left,right);
	self.zip4                  := trim(pInput.zip4,left,right);
	self.cart                  := trim(pInput.cart,left,right);
	self.cr_sort_sz            := trim(pInput.cr_sort_sz,left,right);
	self.lot                   := trim(pInput.lot,left,right);
	self.lot_order             := trim(pInput.lot_order,left,right);
	self.dpbc                  := trim(pInput.dpbc,left,right);
	self.chk_digit             := trim(pInput.chk_digit,left,right);
	self.rec_type              := trim(pInput.rec_type,left,right);
	self.ace_fips_st           := trim(pInput.ace_fips_st,left,right);
	self.ace_fips_county       := trim(pInput.ace_fips_county,left,right);
	self.geo_lat               := trim(pInput.geo_lat,left,right);
	self.geo_long              := trim(pInput.geo_long,left,right);
	self.msa                   := trim(pInput.msa,left,right);
	self.geo_blk               := trim(pInput.geo_blk,left,right);
	self.geo_match             := trim(pInput.geo_match,left,right);
	self.err_stat              := trim(pInput.err_stat,left,right);
	self.title                 := trim(pInput.title,left,right);
	self.fname                 := trim(pInput.fname,left,right);
	self.mname                 := trim(pInput.mname,left,right);
	self.lname                 := trim(pInput.lname,left,right);
	self.name_suffix           := trim(pInput.name_suffix,left,right);
	self.cleaning_score        := trim(pInput.cleaning_score,left,right);
	self.ssn                   := trim(pInput.ssn,left,right);
	self.did                   := trim(pInput.did,left,right);
	self.pgid                  := trim(pInput.pgid,left,right);
  end
 ;
 
/*Layout_In_Court_Activity_CSV	tActivityToCSV(dActivity pInput)
 :=
  transform
    self.process_date		       := trim(pInput.process_date,left,right);
    self.offender_key		       := trim(pInput.offender_key,left,right);
    self.vendor      		       := trim(pInput.vendor,left,right);
    self.state_origin		       := trim(pInput.state_origin,left,right);
    self.source_file 		       := trim(pInput.source_file,left,right);
		self.off_comp    		       := trim(pInput.off_comp,left,right);
    self.case_number		       := trim(pInput.case_number,left,right);
    self.event_type  		       := trim(pInput.event_type,left,right);
    self.event_sort_key		     := trim(pInput.event_sort_key,left,right);
    self.event_date   		     := trim(pInput.event_date,left,right);
    self.event_location_code	 := trim(pInput.event_location_code,left,right);
    self.event_location_desc	 := trim(pInput.event_location_desc,left,right);
    self.event_desc_code		   := trim(pInput.event_desc_code,left,right);
    self.event_desc_1		       := trim(pInput.event_desc_1,left,right);
    self.event_desc_2		       := trim(pInput.event_desc_2,left,right);
  end
 ;
*/

a := output(project(dOffenses,tOffensesToCSV(left)),,'~thor_data400::out::arrest_offenses_csv_' + Crim_Common.Version_Development,csv(quote(''),separator('\t'),terminator('\n')));
b := output(project(dOffender,tOffenderToCSV(left)),,'~thor_data400::out::arrest_offender_csv_' + Crim_Common.Version_Development,csv(quote(''),separator('\t'),terminator('\n')));
//c := output(project(dActivity,tActivityToCSV(left)),,'~thor_200::temp::tkirk::court_activity_csv_test',csv(quote(''),separator('\t'),terminator('\n')));

export OUT_DaytonFullfillmentFiles := sequential(a,b/*,c*/);
