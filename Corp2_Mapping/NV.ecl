IMPORT Default,Corp2,Address,Lib_AddrClean,
			 Ut,lib_STRINGlib,_Control,VersionControl,
			 _Validate;

EXPORT NV := MODULE
    SHARED STRING2 STATE_ORIGIN := 'nv';
	
    EXPORT UI(STRING pInp,STRING1 pCase = '',BOOLEAN pRemoveSpace = TRUE) :=
	 	     COrp2.Rewrite_Common.UniformInput(pInp,pCase,pRemoveSpace);
				 
	SHARED CIDt(STRING8 pDate) := Corp2.Rewrite_Common.CleanInvalidDates(UI(pDate));

	SHARED f_conv_date(STRING pDate) := pDate[7..10] +
	                                    pDate[1..2] +
								        pDate[4..5];
										
    SHARED VDt(STRING pDate) := Corp2.Rewrite_Common.DateIsValid(pDate); 									

	//Declare Raw Input Super Files		

	SHARED STRING isfName	(STRING pFileIdentifier,string pprocessdate = '') := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pprocessdate,true);
	
	SHARED STRING isfCorporation(string pprocessdate = '')  := isfName('Corporation',pprocessdate);
	SHARED STRING isfRA(string pprocessdate = '')  := isfName('RA',pprocessdate);	
	SHARED STRING isfOfficers(string pprocessdate = '')  := isfName('Officers',pprocessdate);	
	SHARED STRING isfActions (string pprocessdate = '') := isfName('Actions',pprocessdate);	
	SHARED STRING isfStock(string pprocessdate = '')  := isfName('Stocks',pprocessdate);
	
	EXPORT Layouts_Raw_Input := 
    MODULE
       EXPORT Corporation := RECORD, MAXLENGTH(1150)
	     STRING10  corp_id;
         STRING10  ra_id;
         STRING50  corp_type;
         STRING50  corp_category;
         STRING50  corp_status;
         STRING15  managed_by;
         STRING250 corp_name;
         STRING3   qualifying_state;
         STRING50  corp_no;
         STRING21  capital_amt;
         STRING10  no_par_share_count;
         STRING250 corp_foreign_name;
         STRING1   is_on_admin_hold;
         STRING3   classification;
         STRING150 reservation_owner_name;
         STRING65  reservation_owner_addr1;
         STRING65  reservation_owner_addr2;
         STRING25  reservation_owner_city;
         STRING2   reservation_owner_st;
         STRING10  reservation_owner_zip;
         STRING3   reservation_owner_country;
         STRING10  creation_dt;
         STRING10  status_changed_dt;
         STRING10  annual_lo_due_dt;
         STRING10  ra_resigned_dt;
         STRING10  expired_dt;
       END;
	   
	   EXPORT RA := RECORD, MAXLENGTH(2048)
	     STRING10  ra_id;
         STRING150 name;
         STRING65  addr1;
         STRING65  addr2;
         STRING25  city;
         STRING2   st;
         STRING10  zip;
         STRING65  mailing_addr1;
         STRING65  mailing_addr2;
         STRING25  mailing_city;
         STRING2   mailing_st;
         STRING10  mailing_zip;
         STRING3   mailing_county;
         STRING3   mailing_country;
         STRING30  phone_no;
         STRING30  fax_no;
         STRING100 email_address;
		 STRING    clean_ra_pname;
		 STRING    clean_ra_cname;
		 STRING182 clean_ra_principal_address;
		 STRING182 clean_ra_mailing_address;
	   END;
	   
	   EXPORT Officers := RECORD,MAXLENGTH(1024)
	     STRING10  officer_id;
         STRING10  corp_id;
         STRING50  officer_type;
         STRING70  last_name;
         STRING40  first_name; 
         STRING1   middle_initial;
         STRING65  addr1;
         STRING65  addr2;
         STRING25  city;
         STRING2   st;
         STRING10  zip;
         STRING3   county;
         STRING3   country;
         STRING1   inactive;
         STRING100 email_address;
         STRING1   terminated;
         STRING1   resigned;
		
	   END;
	     
	   EXPORT Actions := RECORD,MAXLENGTH(1615)
	     STRING10   action_id;
         STRING10   corp_id;
         STRING10   action_dt;
         STRING50   action_type;
         STRING1500 action_notes;
         STRING20   document_no;
         STRING10   effective_dt;
         STRING1    has_stock; 
       END;
	   
	   EXPORT Stock := RECORD,MAXLENGTH(60)
	     STRING10 stock_id;
         STRING10 corp_id;
         STRING19 par_share_count;
         STRING20 par_share_value;
       END;

    END; //Layouts_Raw_Input
	

	EXPORT Files_Raw_Input(string pprocessdate = '') := 
	MODULE
	     SHARED _Definition(STRING pFile) := DATASET(pFile,
	                                                 Corp2.Rewrite_Common.Layout_Generic,
				                                     CSV(HEADING(0),
									                 SEPARATOR(['']),
                                                     TERMINATOR(['\n'])));	
	
	     EXPORT Corporation := _Definition(isfCorporation(pprocessdate));
	     EXPORT RA := _Definition(isfRA(pprocessdate));
	     EXPORT Officers := _Definition(isfOfficers(pprocessdate));
	     EXPORT Actions := _Definition(isfActions(pprocessdate));
	     EXPORT Stock := _Definition(isfStock(pprocessdate));
		 
		 EXPORT Classification := DATASET(_dataset().foreign_prod + 'thor_data400::in::corp2::lookup::classification::nv',
	                                      Corp2.Rewrite_Common.Layout_Generic_Lookup,
				                          CSV(HEADING(0),
				                          SEPARATOR(['|']),
						                  QUOTE(['\"']),
                                          TERMINATOR(['\n'])));	
		 
	END; //Files Raw Input
	
 
  //********************************************************************
  //SPRAY RAW UPDATE FILES
  // ********************************************************************
  EXPORT SprayInputFiles(STRING8 pProcessDate) := MODULE
  
	  EXPORT STRING v_IP := Corp2.Rewrite_Common.SprayEnvironment('edata10').IP;
 	  EXPORT STRING v_GroupName := Corp2.Rewrite_Common.SprayEnvironment('edata10').GroupName;
	  EXPORT STRING v_SourceDir := Corp2.Rewrite_Common.SprayEnvironment('edata10').RootDir + '/' + STATE_ORIGIN + '/' + pProcessDate;																		
		
	  //Declare Raw Input Logical Files
	  SHARED STRING ilfName	(STRING pFileIdentifier) := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pProcessDate,true);
	
	  SHARED SprayIt (STRING pInputLinkFile,
	                  STRING pUnixSrcFile,
			  						STRING pInputSuperFile):= Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(pInputLinkFile,
	                                                                                                             v_IP,
				       		                                                                                     v_SourceDir,
					  							                                                                 pUnixSrcFile,
						  						                                                                 pInputSuperFile,
							  					                                                                 v_GroupName,
								  				                                                                 pProcessDate,
									  																			 '\\n'); 
	
	  SHARED STRING ilf_Crp := 'Corporation';
	  SHARED STRING ilfCorporation  := ilfName(ilf_Crp);
	  EXPORT Corporation := SprayIt(ilfCorporation,'corporation.parsed',isfCorporation());
	 
	  SHARED STRING ilf_RAgt := 'RA';
	  SHARED STRING ilfRA  := ilfName(ilf_RAgt);
	  EXPORT RA := SprayIt(ilfRA,'ra.parsed',isfRA());
	 
	  SHARED STRING ilf_Offc := 'Officers';
	  SHARED STRING ilfOfficers  := ilfName(ilf_Offc);
	  EXPORT Officers := SprayIt(ilfOfficers,'officers.parsed',isfOfficers()); 
	 
	  SHARED STRING ilf_Act := 'Actions';
	  SHARED STRING ilfActions  := ilfName(ilf_Act);
	  EXPORT Actions := SprayIt(ilfActions,'actions.parsed',isfActions());
	  
	  SHARED STRING ilf_Stk := 'Stocks';
	  SHARED STRING ilfStock  := ilfName(ilf_Stk);
	  EXPORT Stock := SprayIt(ilfStock,'stock.parsed',isfStock());
	  
																						 
  END; //SPRAY RAW UPDATE FILES
 
  //********************************************************************
  // PROCESS CORPORATE MASTER (CORP) DATA
  //********************************************************************
  EXPORT Process_Corp_Data(STRING8 pProcessDate,STRING2 pState_Origin) := MODULE
   Layouts_Raw_Input.Corporation Corporation_Phase1(Corp2.Rewrite_Common.Layout_Generic L) := TRANSFORM
     SELF.corp_id :=  L.Payload[1..10];                         //STRING10  corp_id;
     SELF.ra_id := L.Payload[11..20];                           //STRING10  ra_id;
     SELF.corp_type := L.Payload[21..70];                       //STRING50  corp_type;
     SELF.corp_category := L.Payload[71..120];                  //STRING50  corp_category;
     SELF.corp_status := L.Payload[121..170];                   //STRING50  corp_status;
     SELF.managed_by := L.Payload[171..185];                    //STRING15  managed_by;
     SELF.corp_name := L.Payload[186..435];                     //STRING250 corp_name;
     SELF.qualifying_state := L.Payload[436..438];              //STRING3   qualifying_state;
     SELF.corp_no := L.Payload[439..488];                       //STRING50  corp_no;
     SELF.capital_amt := L.Payload[489..509];                   //STRING21  capital_amt;
     SELF.no_par_share_count := L.Payload[510..519];            //STRING10  no_par_share_count;
     SELF.corp_foreign_name := L.Payload[520..769];             //STRING250 corp_foreign_name;
     SELF.is_on_admin_hold := L.Payload[770..770];              //STRING1   is_on_admin_hold;
     SELF.classification := L.Payload[771..773];                //STRING3   classification;
     SELF.reservation_owner_name := L.Payload[774..923];        //STRING150 reservation_owner_name;
     SELF.reservation_owner_addr1 := L.Payload[924..988];       //STRING65  reservation_owner_addr1;
     SELF.reservation_owner_addr2 := L.Payload[989..1053];      //STRING65  reservation_owner_addr2;
     SELF.reservation_owner_city := L.Payload[1054..1078];      //STRING25  reservation_owner_city;
     SELF.reservation_owner_st := L.Payload[1079..1080];        //STRING2   reservation_owner_st;
   
     STRING3 v_reservation_owner_country := UI(L.Payload[1091..1093],'U');
	 SELF.reservation_owner_country := v_reservation_owner_country;   //STRING3   reservation_owner_country;
	
	 STRING v_reservation_owner_zip := L.Payload[1081..1090];         //STRING10  reservation_owner_zip; 
	 SELF.reservation_owner_zip := Corp2.Rewrite_Common.CleanZip(v_reservation_owner_zip,
	                                                             v_reservation_owner_country = 'USA'); 
	 
	
	 
	 STRING v_creation_dt := f_conv_date(L.Payload[1094..1103]);           //STRING10  creation_dt;
	 SELF.creation_dt := IF(VDt(v_creation_dt),v_creation_dt,'');
     
	 STRING v_status_changed_dt := f_conv_date(L.Payload[1104..1113]);           //STRING10  status_changed_dt;
     SELF.status_changed_dt  := IF(VDt(v_status_changed_dt),v_status_changed_dt,'');
	 
	 STRING v_annual_lo_due_dt :=  f_conv_date(L.Payload[1114..1123]);           //STRING10  annual_lo_due_dt;
     SELF.annual_lo_due_dt  := IF(VDt(v_annual_lo_due_dt),v_annual_lo_due_dt,'');
	 
	 STRING v_ra_resigned_dt := f_conv_date(L.Payload[1124..1133]);           //STRING10  ra_resigned_dt;
     SELF.ra_resigned_dt  := IF(VDt(v_ra_resigned_dt),v_ra_resigned_dt,'');
	 
	 STRING v_expired_dt := f_conv_date(L.Payload[1134..1143]);           //STRING10  expired_dt
     SELF.expired_dt  := IF(VDt(v_expired_dt),v_expired_dt,'');
	 
	 SELF := [];
   END;
   
   
   EXPORT Corporation_0 := PROJECT(Files_Raw_Input(pProcessDate).Corporation,Corporation_Phase1(LEFT));
   //EXPORT Corporation_d := DISTRIBUTE(Corporation_0,HASH32(UI(ra_id)));
  
  
   Layouts_Raw_Input.RA RA_Phase1(Corp2.Rewrite_Common.Layout_Generic L) := TRANSFORM
     SELF.ra_id := L.Payload[1..10];    //STRING10  ra_id;
     STRING v_name := L.Payload[11..160];   //STRING150 name;
	 SELF.name := v_name;
     STRING v_addr1 := L.Payload[166..225]; //STRING65  addr1;
	 SELF.addr1 := v_addr1; 
     STRING v_addr2 := L.Payload[226..290]; //STRING65  addr2;
	 SELF.addr2 := v_addr2;
	 STRING v_city := L.Payload[291..315];  //STRING25  city;
     SELF.city := v_city;
	 STRING v_st := L.Payload[316..317];    //STRING2   st;
     SELF.st := v_st;
	 STRING v_zip := L.Payload[318..327];             //STRING10  zip;
     SELF.zip := v_zip;
	 STRING v_mailing_addr1 := L.Payload[328..392];   //STRING65  mailing_addr1; 
     SELF.mailing_addr1 := v_mailing_addr1;
	 STRING v_mailing_addr2 := L.Payload[393..457];   //STRING65  mailing_addr2;
     SELF.mailing_addr2 := v_mailing_addr2;
	 STRING v_mailing_city := L.Payload[458..482];    //STRING25  mailing_city;
     SELF.mailing_city := v_mailing_city;
	 STRING v_mailing_st := L.Payload[483..484];      //STRING2   mailing_st;
     SELF.mailing_st := v_mailing_st;
	 
     STRING v_mailing_county := L.Payload[495..497];  //STRING3   mailing_county;	 
	 SELF.mailing_county := v_mailing_county;
	 
	 STRING v_mailing_country := UI(L.Payload[498..500],'U'); //STRING3   mailing_country;
     SELF.mailing_country := v_mailing_country;
	 
     STRING v_mailing_zip := L.Payload[485..494];     //STRING10  mailing_zip;
	 SELF.mailing_zip := Corp2.Rewrite_Common.CleanZip(v_mailing_zip,
	                                                   v_mailing_country = 'USA');
     
	 STRING v_phone_no := L.Payload[501..530];        //STRING30  phone_no;
	 SELF.phone_no := v_phone_no;
	 STRING v_fax_no := L.Payload[531..560];          //STRING30  fax_no;
     SELF.fax_no := v_fax_no;
	 STRING v_email_address := L.Payload[561..660];   //STRING100 email_address;
     SELF.email_address := v_email_address; 
	 SELF.clean_ra_pname := IF(Corp2.Rewrite_Common.IsPerson(v_name),v_Name,'');
     SELF.clean_ra_cname := IF(Corp2.Rewrite_Common.IsCompany(v_name),v_name,'');
	 SELF.clean_ra_principal_address := Address.CleanAddress182(Corp2.Rewrite_Common.PreCleanAddress(v_addr1 + ' ' + v_addr2,
		                                                                                       	     v_city,v_st,v_zip
																								     ).AddressLine1,
	                                                            Corp2.Rewrite_Common.PreCleanAddress(v_addr1 + ' ' + v_addr2,
		                                                                                    	     v_city,v_st,v_zip).AddressLine2
				  		  																		     );
	 SELF.clean_ra_mailing_address := Address.CleanAddress182(Corp2.Rewrite_Common.PreCleanAddress(v_mailing_addr1 + ' ' + v_mailing_addr2,
		                                                                       	                   v_mailing_city,v_mailing_st,v_mailing_zip
											                  ).AddressLine1,
	                                                          Corp2.Rewrite_Common.PreCleanAddress(v_mailing_addr1 + ' ' + v_mailing_addr2,
		                                                                                           v_mailing_city,v_mailing_st,v_mailing_zip).AddressLine2
				  		                                                                           );
	  
	 
   END;  
  
   EXPORT RA_0 := PROJECT(Files_Raw_Input(pProcessDate).RA,RA_Phase1(LEFT)); 
     
   
   EXPORT Layout_Corporation_RA_tmp := RECORD
    Layouts_Raw_Input.Corporation;
	Layouts_Raw_Input.RA - ra_id;
   END;
   
  
   
   EXPORT Corporation_RA_0 := JOIN(DISTRIBUTE(Corporation_0,HASH32(UI(ra_id))),
	 					           DISTRIBUTE(RA_0,HASH32(UI(ra_id))),
                                   UI(LEFT.ra_id) = UI(RIGHT.ra_id),
						           TRANSFORM(Layout_Corporation_RA_tmp, SELF := LEFT; SELF := RIGHT),
						           LEFT OUTER, LOCAL);
							 
							 
   EXPORT Corporation_RA := DISTRIBUTE(Corporation_RA_0,RANDOM()) 
							 ;
  
   
   EXPORT Non_Trade_Marks_0 := Corporation_RA(UI(corp_type,'U') NOT IN ['SERVICEMARK',
                                                                        'TRADEMARK',
																        'TRADENAME']);
																	  
   //Process Non-Trade Marks																	  
   SHARED Corp2.Layout_Corporate_Direct_Corp_In Corporation_Phase1_default(RECORDOF(Non_Trade_Marks_0) L) := TRANSFORM
    
     BOOLEAN has_business_address := (UI(L.addr1) <> '' AND UI(L.city) <> '');
	 SELF.dt_vendor_first_reported := pProcessDate;
     SELF.dt_vendor_last_reported := pProcessDate;
	 SELF.dt_first_seen := MAP(CIDt(L.creation_dt) <> '' => L.creation_dt,
	                           CIDt(L.status_changed_dt) <> '' => L.status_changed_dt,
					           pProcessDate);
	 SELF.dt_last_seen := IF(regexfind('ACTIVE',UI(L.corp_status,'U')), pProcessDate, L.Status_changed_dt);
	 SELF.corp_key := L.corp_id;
	 SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,'').StateFips;
     SELF.corp_state_origin := UI(pState_Origin,'U');
     SELF.corp_process_date := pProcessDate;
     SELF.corp_orig_sos_charter_nbr := L.corp_no;
     SELF.corp_src_type := 'SOS';
     SELF.corp_ln_name_type_cd := '01'; 
     SELF.corp_ln_name_type_desc := IF(UI(L.corp_type,'U') = 'RESERVEDNAME','RESERVER','LEGAL');
	 //SELF.corp_supp_nbr := L.corp_no;
	 SELF.corp_legal_name := L.Corp_Name;
     //SELF.corp_filing_date := L.creation_dt;
     //SELF.corp_filing_desc := 'CREATION DATE';
     SELF.corp_status_desc := L.corp_status;
     SELF.corp_standing := IF(UI(L.corp_status,'U') ='ACTIVE','Y',''); 
     SELF.corp_status_date := L.status_changed_dt;
     
	 BOOLEAN is_domestic := regexfind('(DOMESTIC|DOM)',UI(L.corp_type,'U')) AND UI(L.qualifying_state) <> ''; 
	 BOOLEAN is_foreign := regexfind('FOREIGN',UI(L.corp_type,'U')) AND UI(L.qualifying_state) <> '';
	 
	 SELF.corp_inc_state := IF(is_domestic, L.qualifying_state,'');
     SELF.corp_inc_date := L.creation_dt;
     
	 SELF.corp_term_exist_cd := IF(L.expired_dt <> '', 'D','P');
     SELF.corp_term_exist_exp := IF(L.expired_dt <> '', L.expired_dt,'');
     SELF.corp_term_exist_desc := IF(L.expired_dt <> '','EXPIRATION DATE','PERPETUAL');
     
	 
	 SELF.corp_foreign_domestic_ind := MAP( is_domestic => 'D',
	                                        is_foreign =>'F','');
	 
	 STRING v_corp_forgn_state_cd := IF(is_foreign,L.qualifying_state,'');										
	 SELF.corp_forgn_state_cd := v_corp_forgn_state_cd;
  
     SELF.corp_forgn_state_desc := IF(LENGTH(UI(v_corp_forgn_state_cd)) = 2,
	                                  Corp2.Rewrite_Common.GetUniqueKey(UI(v_corp_forgn_state_cd,'U')).StateDesc,
									  '');
     SELF.corp_orig_org_structure_cd := L.classification;
     SELF.corp_orig_org_structure_desc := L.corp_type;
     SELF.corp_for_profit_ind := IF(regexfind('NONPROFIT',UI(L.corp_type,'U')),'N','');
	 SELF.corp_status_comment := IF(UI(L.is_on_admin_hold) = 'T',
						           'IS ON ADMINISTRATIVE HOLD', ''); 
	 SELF.corp_addl_info := IF(UI(L.managed_by) <> '','MANAGED BY: ' + L.managed_by,'');
	 SELF.corp_ra_dt_first_seen := IF(CIDt(L.ra_resigned_dt) <> '',L.ra_resigned_dt,pProcessDate);
	 SELF.corp_ra_dt_last_seen := IF(CIDt(L.ra_resigned_dt) <> '',L.ra_resigned_dt,pProcessDate);
	 SELF.corp_ra_resign_date := L.ra_resigned_dt;
     SELF.corp_ra_name := L.Name;
     SELF.corp_ra_title_desc := IF(UI(L.name) != '','REGISTERED AGENT','');
     SELF.corp_ra_address_type_desc := IF(Corp2.Rewrite_Common.AddressExists( L.Addr1,L.Addr2,
					                                                          L.City,L.St, L.Zip),
										  'REGISTERED OFFICE', '');
		
     SELF.corp_ra_address_line1 := IF(has_business_address,L.addr1,L.mailing_addr1);
     SELF.corp_ra_address_line2 := IF(has_business_address,L.addr2,L.mailing_addr2);
     SELF.corp_ra_address_line3 := IF(has_business_address,L.city,L.mailing_city);
	 SELF.corp_ra_address_line4 := IF(has_business_address,L.st,L.mailing_st);
	 SELF.corp_ra_address_line5 := IF(has_business_address,L.zip,L.mailing_zip);
     SELF.corp_ra_address_line6 := IF(has_business_address,'',L.mailing_country);
   
  
     SELF.corp_ra_phone_number := L.phone_no;
     SELF.corp_ra_email_address := L.email_address;
	 
	 v_Cleaned_pname := Corp2.Rewrite_Common.CleanPerson73(L.clean_ra_pname);
	 l_Broken_out_pname := Address.CleanNameFields(v_Cleaned_pname);
     SELF.corp_ra_title1:= l_Broken_out_pname.title;
     SELF.corp_ra_fname1:= l_Broken_out_pname.fname;
     SELF.corp_ra_mname1:= l_Broken_out_pname.mname;
     SELF.corp_ra_lname1:= l_Broken_out_pname.lname;
     SELF.corp_ra_name_suffix1:= l_Broken_out_pname.name_suffix;
     SELF.corp_ra_score1:= IF((INTEGER) l_Broken_out_pname.name_score <> 0,
	                                    l_Broken_out_pname.name_score,''); 
	
	
	 STRING v_Cleaned_cname := Corp2.Rewrite_Common.CleanPerson73(L.clean_ra_cname);
     l_Broken_out_cname := Address.CleanNameFields(v_Cleaned_cname);
     SELF.corp_ra_cname1 := TRIM(l_Broken_out_cname.fname,LEFT,RIGHT) + ' ' +
                            TRIM(l_Broken_out_cname.mname,LEFT,RIGHT) + ' ' +
                            TRIM(l_Broken_out_cname.lname,LEFT,RIGHT) + ' ' +
                            TRIM(l_Broken_out_cname.name_suffix,LEFT,RIGHT);
     SELF.corp_ra_cname1_score:= IF((INTEGER) l_Broken_out_cname.name_score <> 0,
	                                l_Broken_out_cname.name_score,''); 
	 
	       
	 Broken_Out_CleanAgentAddress := Address.CleanAddressFieldsFips(IF(has_business_address,L.clean_ra_principal_address,L.clean_ra_mailing_address));
     SELF.corp_ra_prim_range:=       Broken_Out_CleanAgentAddress.prim_range;
     SELF.corp_ra_predir:= 	         Broken_Out_CleanAgentAddress.predir;		
     SELF.corp_ra_prim_name:= 	     Broken_Out_CleanAgentAddress.prim_name;	
     SELF.corp_ra_addr_suffix:=      Broken_Out_CleanAgentAddress.addr_suffix;
     SELF.corp_ra_postdir:= 	     Broken_Out_CleanAgentAddress.postdir;	
     SELF.corp_ra_unit_desig:=       Broken_Out_CleanAgentAddress.unit_desig;
     SELF.corp_ra_sec_range:= 	     Broken_Out_CleanAgentAddress.sec_range;	
     SELF.corp_ra_p_city_name:=      Broken_Out_CleanAgentAddress.p_city_name;
     SELF.corp_ra_v_city_name:=      Broken_Out_CleanAgentAddress.v_city_name;
     SELF.corp_ra_state:= 	         Broken_Out_CleanAgentAddress.st;		
     SELF.corp_ra_zip5:= 	         Broken_Out_CleanAgentAddress.zip;		
     SELF.corp_ra_zip4:= 	         Broken_Out_CleanAgentAddress.zip4;		
     SELF.corp_ra_cart:= 	         Broken_Out_CleanAgentAddress.cart;		
     SELF.corp_ra_cr_sort_sz:=       Broken_Out_CleanAgentAddress.cr_sort_sz;
     SELF.corp_ra_lot:= 	         Broken_Out_CleanAgentAddress.lot;		
     SELF.corp_ra_lot_order:= 	     Broken_Out_CleanAgentAddress.lot_order;	
     SELF.corp_ra_dpbc:= 	         Broken_Out_CleanAgentAddress.dbpc;	
     SELF.corp_ra_chk_digit:= 	     Broken_Out_CleanAgentAddress.chk_digit;	
     SELF.corp_ra_rec_type:= 	     Broken_Out_CleanAgentAddress.rec_type;	
     SELF.corp_ra_ace_fips_st:=      Broken_Out_CleanAgentAddress.fips_state;
     SELF.corp_ra_county:= 	         Broken_Out_CleanAgentAddress.fips_county;
     SELF.corp_ra_geo_lat:= 	     Broken_Out_CleanAgentAddress.geo_lat;	
     SELF.corp_ra_geo_long:= 	     Broken_Out_CleanAgentAddress.geo_long;	
     SELF.corp_ra_msa:= 	         Broken_Out_CleanAgentAddress.msa;		
     SELF.corp_ra_geo_blk:= 	     Broken_Out_CleanAgentAddress.geo_blk;	
     SELF.corp_ra_geo_match:= 	     Broken_Out_CleanAgentAddress.geo_match;	
     SELF.corp_ra_err_stat:= 	     Broken_Out_CleanAgentAddress.err_stat; 
     SELF := [];
  END;

  EXPORT Non_Trade_Marks_d00 := PROJECT(Non_Trade_Marks_0,Corporation_Phase1_default(LEFT));
  
   
 
  //Process Supplemental Corp Names
  EXPORT Supp_Corp_Names_0 := Corporation_RA(UI(corp_foreign_name) != '',
                                             NOT regexfind('SAME',UI(corp_foreign_name))); 
  
    
  EXPORT Supp_Corp_Names_d00 := PROJECT(Supp_Corp_Names_0,Corporation_Phase1_default(LEFT));
   
 
 
  Corp2.Layout_Corporate_Direct_Corp_In Corporation_Phase1_supp_nm(RECORDOF(Supp_Corp_Names_d00) L,
                                                                   RECORDOF(Supp_Corp_Names_0) R) := TRANSFORM
    SELF.corp_supp_key := '32-' + UI(L.corp_key) + '-' + '10';
	SELF.corp_legal_name := R.corp_foreign_name;
    SELF.corp_ln_name_type_cd := '10';
    SELF.corp_ln_name_type_desc := 'FOREIGN NAME';  
	SELF := L;
  END; 
 
  EXPORT Supp_Corp_Names_d01 := JOIN(DISTRIBUTE(Supp_Corp_Names_d00,HASH32(UI(corp_key))),
                                     DISTRIBUTE(Supp_Corp_Names_0,HASH32(UI(corp_id))),
									 UI(LEFT.corp_key) = UI(RIGHT.corp_id),
									 Corporation_Phase1_supp_nm(LEFT,RIGHT),
									 LEFT OUTER,LOCAL);
 
   
  
  //Process Trade Marks
  EXPORT Trade_Marks_0 := Corporation_RA(UI(corp_type,'U') IN ['SERVICEMARK',
                                                               'TRADEMARK',
												   	           'TRADENAME']);  
														
  EXPORT Trade_Marks_1 := PROJECT(Trade_Marks_0,Corporation_Phase1_default(LEFT));
  
 
 
 
  Corp2.Layout_Corporate_Direct_Corp_In Corporation_Phase1_tm(RECORDOF(Trade_Marks_1) L,
                                                              RECORDOF(Corporation_RA) R) := TRANSFORM
    
	STRING v_trade_type := UI(R.corp_type,'U');
    BOOLEAN is_tradename := regexfind('TRADENAME',v_trade_type);
    BOOLEAN is_trademark := regexfind('TRADEMARK',v_trade_type);
    BOOLEAN is_servicemark := regexfind('SERVICEMARK',v_trade_type);
	BOOLEAN is_reservedname := regexfind('RESERVEDNAME',v_trade_type);
   
    SELF.corp_ln_name_type_cd := MAP(is_tradename => '04',
	                                 is_trademark => '03',
	                                 is_servicemark => '05',
									 is_reservedname => '07','');
	
    SELF.corp_ln_name_type_desc := MAP(is_tradename => 'TRADE NAME',
	                                   is_trademark => 'TRADE MARK',
	                                   is_servicemark => 'SERVICE MARK',
									   is_reservedname => 'RESERVED NAME','');
   
    SELF := L;
  END;
  
    
  EXPORT Trade_Marks_d00 := JOIN(DISTRIBUTE(Trade_Marks_1,HASH32(UI(corp_key))),
                                 DISTRIBUTE(Corporation_RA,HASH32(UI(corp_id))),
								 UI(LEFT.corp_key) = UI(RIGHT.corp_id),
							     Corporation_Phase1_tm(LEFT,RIGHT),
								 LEFT OUTER,LOCAL);
 
   
  
  
   EXPORT Trade_Marks_d01 := JOIN(Trade_Marks_d00,
                                  Files_Raw_Input(pProcessDate).Classification,
	 							  UI(LEFT.corp_orig_org_structure_cd) = UI(RIGHT.code),
	 						      TRANSFORM(Corp2.Layout_Corporate_Direct_Corp_In,SELF.corp_orig_org_structure_desc := RIGHT.Description;SELF := LEFT;),
								  LEFT OUTER,LOOKUP);
  
  
  
   
   EXPORT Corporations_Merged := PROJECT(Non_Trade_Marks_d00 +
                                         Supp_Corp_Names_d01 +
				  	                     Trade_Marks_d01,
										 TRANSFORM(Corp2.Layout_Corporate_Direct_Corp_In,
										           SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,LEFT.corp_key).UKey;SELF := LEFT;));
	 							 
  
   RECORDOF(Corporations_Merged) LookupCountryCode(RECORDOF(Corporations_Merged) L,
	                                                RECORDOF(Corp2.Rewrite_Common.Lookup_ISO_Contry_Code_3) R) := TRANSFORM
	 SELF.corp_forgn_state_desc := IF(LENGTH(UI(L.corp_forgn_state_cd)) > 2,R.Description,L.corp_forgn_state_desc);
	 
	 SELF.corp_ra_address_line6 := IF(UI(L.corp_ra_address_line6) <> '' AND 
	                                  UI(L.corp_ra_address_line6,'U') <> 'USA',
								      R.description,L.corp_ra_address_line6);
	 
	 SELF := L;
   END;
   	 
	 
   //Add foreign state description for the foreign countries	 
   EXPORT Corporate_Direct_Corp := JOIN(DISTRIBUTE(Corporations_Merged,RANDOM()),
                                        Corp2.Rewrite_Common.Lookup_ISO_Contry_Code_3,
			  					        UI(LEFT.corp_forgn_state_cd,'U') = UI(RIGHT.code,'U'),
							            LookupCountryCode(LEFT,RIGHT),
								        LEFT OUTER,LOOKUP);
	
	
  END;
 
  //********************************************************************
  // PROCESS CORPORATE CONTACT (CONT) DATA
  //********************************************************************/
  EXPORT Process_Cont_Data(STRING8 pProcessDate,STRING2 pState_Origin) := MODULE
    
	Layouts_Raw_Input.Officers Officers_Phase1(Corp2.Rewrite_Common.Layout_Generic L) := TRANSFORM
      SELF.officer_id := L.Payload[1..10];      //STRING10  officer_id;
      SELF.corp_id := L.Payload[11..20];        //STRING10  corp_id;
      SELF.officer_type := L.Payload[21..70];   //STRING50  officer_type;
      SELF.last_name := L.Payload[71..140];     //STRING70  last_name;
      SELF.first_name := L.Payload[141..180];   //STRING40  first_name; 
      SELF.middle_initial := L.Payload[181..181];  //STRING1   middle_initial;
      SELF.addr1 := L.Payload[182..246];           //STRING65  addr1;
      SELF.addr2 := L.Payload[247..311];           //STRING65  addr2;
      SELF.city := L.Payload[312..336];            //STRING25  city;
      SELF.st := L.Payload[337..338];              //STRING2   st;
      
      SELF.county := L.Payload[349..351];          //STRING3   county;
     
	  STRING v_country := UI(L.Payload[352..354],'U');     //STRING3   country;
	  SELF.country := v_country;	       
      
	  STRING v_zip := L.Payload[339..348];             //STRING10  zip;
	  SELF.zip := Corp2.Rewrite_Common.CleanZip(v_zip,v_country = 'USA');
	  
	  
	  SELF.inactive := L.Payload[355..355];        //STRING1   inactive;
      SELF.email_address := L.Payload[356..455];   //STRING100 email_address;
      SELF.terminated := L.Payload[456..456];      //STRING1   terminated;
      SELF.resigned := L.Payload[457..457];        //STRING1   resigned;	
	  SELF := [];
    END;
	
	EXPORT Officers_0 := PROJECT(Files_Raw_Input(pProcessDate).Officers,Officers_Phase1(LEFT));
  
    Corp2.Layout_Corporate_Direct_Cont_In Officers_Phase2(RECORDOF(Officers_0) L) := TRANSFORM
	  SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.corp_id).UKey;
	  STRING v_officer_type := UI(L.officer_type,'U');
      SELF.cont_title1_desc := MAP(v_officer_type = 'GPLP' => 'GENERAL PARTNER',
	                               v_officer_type = 'MMEMBER' => 'MANAGING MEMBER',
                                   v_officer_type ='MPARTNER' => 'MANAGING PARTNER',
                                   L.officer_type);
      
	  STRING v_cont_name := TRIM(L.first_name) + 
	                        IF(TRIM(L.first_name) <> '',' ','') + 
							TRIM(L.middle_initial) + 
							IF(TRIM(L.first_name) <> '' OR TRIM(L.middle_initial) <> '',' ','') +
							TRIM(L.last_name);
	  SELF.cont_name := v_cont_name;
	  
	  STRING clean_cont_pname := IF(Corp2.Rewrite_Common.IsPerson(v_cont_name),v_cont_name,'');
      STRING clean_cont_cname := IF(Corp2.Rewrite_Common.IsCompany(v_cont_name),v_cont_name,'');
	 
	  STRING v_Cleaned_pname := Corp2.Rewrite_Common.CleanPerson73(clean_cont_pname);
	  //STRING v_Cleaned_cname := Corp2.Rewrite_Common.CleanPerson73(clean_cont_cname);
      
	  l_Broken_out_pname := Address.CleanNameFields(v_Cleaned_pname);
	  
      SELF.cont_title1:= l_Broken_out_pname.title;
      SELF.cont_fname1:= l_Broken_out_pname.fname;
      SELF.cont_mname1:= l_Broken_out_pname.mname;
      SELF.cont_lname1:= l_Broken_out_pname.lname;
      SELF.cont_name_suffix1:= l_Broken_out_pname.name_suffix;
      SELF.cont_score1:= l_Broken_out_pname.name_score; 
      SELF.cont_cname1 := clean_cont_cname;
	  SELF.cont_cname1_score := Corp2.Rewrite_Common.CleanPerson73(clean_cont_cname)[71..73];
	    
	  	  
	  SELF.cont_address_line1 := L.addr1;
      SELF.cont_address_line2 := L.addr2;
      SELF.cont_address_line3 := L.city;
	  SELF.cont_address_line4 := L.st;
	  STRING v_cont_address_line5 := Corp2.Rewrite_Common.CleanZip(L.zip);
	  SELF.cont_address_line5 := v_cont_address_line5;
      SELF.cont_email_address := L.email_address;
      SELF.cont_type_desc := 'OFFICER';
      SELF.cont_status_desc := MAP( 'T' = L.inactive => 'INACTIVE',
	                                'T' = L.terminated => 'TERMINATED',
									'T' = L.resigned => 'RESIGNED', '');
  	  
	  STRING v_address_line1 := Corp2.Rewrite_Common.PreCleanAddress( L.addr1
                                                                     ,L.addr2
						                                             ,L.city
					                                                 ,L.st
						                                             ,v_cont_address_line5).AddressLine1;
	 
	  STRING v_address_line2 := Corp2.Rewrite_Common.PreCleanAddress( L.addr1
                                                                     ,L.addr2
						                                             ,L.city
					                                                 ,L.st
						                                             ,v_cont_address_line5).AddressLine2;
	 
	  STRING clean_address := Address.CleanAddress182(v_address_line1,
                                                    v_address_line2); 
	  
	  Broken_Out_CleanContAddress := Address.CleanAddressFieldsFips(clean_address);
      SELF.cont_prim_range:=       Broken_Out_CleanContAddress.prim_range;
      SELF.cont_predir:= 	       Broken_Out_CleanContAddress.predir;		
      SELF.cont_prim_name:= 	   Broken_Out_CleanContAddress.prim_name;	
      SELF.cont_addr_suffix:=      Broken_Out_CleanContAddress.addr_suffix;
      SELF.cont_postdir:= 	       Broken_Out_CleanContAddress.postdir;	
      SELF.cont_unit_desig:=       Broken_Out_CleanContAddress.unit_desig;
      SELF.cont_sec_range:= 	   Broken_Out_CleanContAddress.sec_range;	
      SELF.cont_p_city_name:=      Broken_Out_CleanContAddress.p_city_name;
      SELF.cont_v_city_name:=      Broken_Out_CleanContAddress.v_city_name;
      SELF.cont_state:= 	       Broken_Out_CleanContAddress.st;		
      SELF.cont_zip5:= 	           Broken_Out_CleanContAddress.zip;		
      SELF.cont_zip4:= 	           Broken_Out_CleanContAddress.zip4;		
      SELF.cont_cart:= 	           Broken_Out_CleanContAddress.cart;		
      SELF.cont_cr_sort_sz:=       Broken_Out_CleanContAddress.cr_sort_sz;
      SELF.cont_lot:= 	           Broken_Out_CleanContAddress.lot;		
      SELF.cont_lot_order:= 	   Broken_Out_CleanContAddress.lot_order;	
      SELF.cont_dpbc:= 	           Broken_Out_CleanContAddress.dbpc;	
      SELF.cont_chk_digit:= 	   Broken_Out_CleanContAddress.chk_digit;	
      SELF.cont_rec_type:= 	       Broken_Out_CleanContAddress.rec_type;	
      SELF.cont_ace_fips_st:=      Broken_Out_CleanContAddress.fips_state;
      SELF.cont_county:= 	       Broken_Out_CleanContAddress.fips_county;
      SELF.cont_geo_lat:= 	       Broken_Out_CleanContAddress.geo_lat;	
      SELF.cont_geo_long:= 	       Broken_Out_CleanContAddress.geo_long;	
      SELF.cont_msa:= 	           Broken_Out_CleanContAddress.msa;		
      SELF.cont_geo_blk:= 	       Broken_Out_CleanContAddress.geo_blk;	
      SELF.cont_geo_match:= 	   Broken_Out_CleanContAddress.geo_match;	
      SELF.cont_err_stat:= 	       Broken_Out_CleanContAddress.err_stat;  
	  SELF := [];
	 END;
  
     EXPORT Officers_1 := PROJECT(Officers_0,Officers_Phase2(LEFT));
	  
	 
	 //Process Reservaion owners
	 EXPORT Reservation_Owners_0 := Process_Corp_Data(pProcessDate,pState_Origin).Corporation_RA(UI(corp_type,'U') IN ['SERVICEMARK','TRADEMARK','TRADENAME',
																														'RESERVEDNAME']);
     Corp2.Layout_Corporate_Direct_Cont_In Reservation_Owners_Phase2( RECORDOF(Reservation_Owners_0) L) := TRANSFORM
	   SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.corp_id).UKey;
       SELF.cont_type_cd := 'O';//IF(UI(l.corp_type,'U') ='TRADEMARK','I','');
	   SELF.cont_type_desc := 'OWNER';//'APPLICANT';
       SELF.cont_name := L.reservation_owner_name;
       STRING clean_cont_pname := IF(Corp2.Rewrite_Common.IsPerson(L.reservation_owner_name),L.reservation_owner_name,'');
       STRING clean_cont_cname := IF(Corp2.Rewrite_Common.IsCompany(L.reservation_owner_name),L.reservation_owner_name,'');
	 
	   STRING v_Cleaned_pname := Corp2.Rewrite_Common.CleanPerson73(clean_cont_pname);
	   //STRING v_Cleaned_cname := Corp2.Rewrite_Common.CleanPerson73(clean_cont_cname);
      
	  l_Broken_out_pname := Address.CleanNameFields(v_Cleaned_pname); 
	  
      SELF.cont_title1:= l_Broken_out_pname.title;
      SELF.cont_fname1:= l_Broken_out_pname.fname;
      SELF.cont_mname1:= l_Broken_out_pname.mname;
      SELF.cont_lname1:= l_Broken_out_pname.lname;
      SELF.cont_name_suffix1:= l_Broken_out_pname.name_suffix;
      SELF.cont_score1:= l_Broken_out_pname.name_score; 
      SELF.cont_cname1 := clean_cont_cname;
	  SELF.cont_cname1_score := Corp2.Rewrite_Common.CleanPerson73(clean_cont_cname)[71..73];
	    
	  
	  SELF.cont_address_type_cd := 'T';
      SELF.cont_address_type_desc := 'CONTACT';
	  SELF.cont_address_line1 := L.reservation_owner_addr1;
      SELF.cont_address_line2 := L.reservation_owner_addr2;
      SELF.cont_address_line3 := L.reservation_owner_city;
      SELF.cont_address_line4 := L.reservation_owner_st;  
	  SELF.cont_address_line5 := L.reservation_owner_zip;
	  SELF.cont_address_line6 := L.reservation_owner_country;
	 
	  STRING v_address_line1 := Corp2.Rewrite_Common.PreCleanAddress( L.reservation_owner_addr1
                                                                     ,L.reservation_owner_addr2
						                                             ,L.reservation_owner_city
					                                                 ,L.reservation_owner_st
						                                             ,L.reservation_owner_country).AddressLine1;
	 
	  STRING v_address_line2 := Corp2.Rewrite_Common.PreCleanAddress( L.reservation_owner_addr1
                                                                     ,L.reservation_owner_addr2
						                                             ,L.reservation_owner_city
					                                                 ,L.reservation_owner_st
						                                             ,L.reservation_owner_country).AddressLine2;
	 
	  STRING clean_address := Address.CleanAddress182(v_address_line1,
                                                      v_address_line2); 
	  
	  Broken_Out_CleanContAddress := Address.CleanAddressFieldsFips(clean_address);
      SELF.cont_prim_range:=       Broken_Out_CleanContAddress.prim_range;
      SELF.cont_predir:= 	       Broken_Out_CleanContAddress.predir;		
      SELF.cont_prim_name:= 	   Broken_Out_CleanContAddress.prim_name;	
      SELF.cont_addr_suffix:=      Broken_Out_CleanContAddress.addr_suffix;
      SELF.cont_postdir:= 	       Broken_Out_CleanContAddress.postdir;	
      SELF.cont_unit_desig:=       Broken_Out_CleanContAddress.unit_desig;
      SELF.cont_sec_range:= 	   Broken_Out_CleanContAddress.sec_range;	
      SELF.cont_p_city_name:=      Broken_Out_CleanContAddress.p_city_name;
      SELF.cont_v_city_name:=      Broken_Out_CleanContAddress.v_city_name;
      SELF.cont_state:= 	       Broken_Out_CleanContAddress.st;		
      SELF.cont_zip5:= 	           Broken_Out_CleanContAddress.zip;		
      SELF.cont_zip4:= 	           Broken_Out_CleanContAddress.zip4;		
      SELF.cont_cart:= 	           Broken_Out_CleanContAddress.cart;		
      SELF.cont_cr_sort_sz:=       Broken_Out_CleanContAddress.cr_sort_sz;
      SELF.cont_lot:= 	           Broken_Out_CleanContAddress.lot;		
      SELF.cont_lot_order:= 	   Broken_Out_CleanContAddress.lot_order;	
      SELF.cont_dpbc:= 	           Broken_Out_CleanContAddress.dbpc;	
      SELF.cont_chk_digit:= 	   Broken_Out_CleanContAddress.chk_digit;	
      SELF.cont_rec_type:= 	       Broken_Out_CleanContAddress.rec_type;	
      SELF.cont_ace_fips_st:=      Broken_Out_CleanContAddress.fips_state;
      SELF.cont_county:= 	       Broken_Out_CleanContAddress.fips_county;
      SELF.cont_geo_lat:= 	       Broken_Out_CleanContAddress.geo_lat;	
      SELF.cont_geo_long:= 	       Broken_Out_CleanContAddress.geo_long;	
      SELF.cont_msa:= 	           Broken_Out_CleanContAddress.msa;		
      SELF.cont_geo_blk:= 	       Broken_Out_CleanContAddress.geo_blk;	
      SELF.cont_geo_match:= 	   Broken_Out_CleanContAddress.geo_match;	
      SELF.cont_err_stat:= 	       Broken_Out_CleanContAddress.err_stat;  
	  SELF := [];
	 END;
	 
	 
	 EXPORT Reservation_Owners_1 := PROJECT(Reservation_Owners_0,Reservation_Owners_Phase2(LEFT));
	 
	
	 SHARED Reservation_Owners_Domestic := Reservation_Owners_1(UI(cont_address_line6) = '' OR 
	                                                           UI(cont_address_line6,'U') = 'USA');
	 
	 Reservation_Owners_Foreign_0 := Reservation_Owners_1(UI(cont_address_line6) <> '' AND 
	                                                      UI(cont_address_line6,'U') <> 'USA');
														
	 						
	 
	 EXPORT Reservation_Owners_Foreign_1 := JOIN(DISTRIBUTE(Reservation_Owners_Foreign_0,RANDOM()),
                                                 Corp2.Rewrite_Common.Lookup_ISO_Contry_Code_3,
			  					                 UI(LEFT.cont_address_line6,'U') = UI(RIGHT.code,'U'),
							                     TRANSFORM(Corp2.Layout_Corporate_Direct_Cont_In,
							                               SELF.cont_address_line6 := RIGHT.description;SELF := LEFT;),
								                 LEFT OUTER,LOOKUP);
	 
	  Reservation_Owners_d00 := Reservation_Owners_Domestic +
	                            Reservation_Owners_Foreign_1;
	 
      EXPORT Corporate_Direct_Cont := Officers_1 + Reservation_Owners_d00;
	                                    
   END; //Process_Cont_Data
  
   //********************************************************************
   // PROCESS CORPORATE EVENT DATA
   //********************************************************************
   EXPORT Process_Event_Data(STRING8 pProcessDate,STRING2 pState_Origin) := MODULE	
     Layouts_Raw_Input.Actions Actions_Phase1(Corp2.Rewrite_Common.Layout_Generic L) := TRANSFORM
	   SELF.action_id := L.Payload[1..10];             //STRING10   action_id;
       SELF.corp_id := L.Payload[11..20];              //STRING10   corp_id;
       
	   STRING v_action_dt := L.Payload[21..30];        //STRING10   action_dt;
	   SELF.action_dt := f_conv_date(v_action_dt);
      
	   SELF.action_type := L.Payload[31..80];          //STRING50   action_type;
       
	   STRING v_action_notes := regexreplace('--*',L.Payload[81..1580],';');
	   SELF.action_notes := v_action_notes;       //STRING1500 action_notes;
       SELF.document_no := L.Payload[1581..1600];      //STRING20   document_no;
      
	   STRING v_effective_dt := L.Payload[1601..1610]; //STRING10   effective_dt;
	   SELF.effective_dt := f_conv_date(v_effective_dt);
       
	   SELF.has_stock := L.Payload[1611..1611];        // STRING1    has_stock;   */
     END;  
  
     EXPORT Actions_0 := PROJECT(Files_Raw_Input(pProcessDate).Actions,Actions_Phase1(LEFT));
  
     Actions_0_AR_excluded := Actions_0(UI(action_type,'U') NOT IN ['INITIALLIST',
                                                                    'AMENDEDLIST',
    									 						    'ANNUALLIST']);
																	 
	// Actions_1_d := DISTRIBUTE(Actions_0_AR_excluded,HASH32(document_no));
	// EXPORT Action_1_s := SORT(Actions_1_d, corp_id,-document_no,LOCAL);
   					
     EXPORT Action_1_s := Actions_0_AR_excluded;		
				
	 Corp2.Layout_Corporate_Direct_Event_In Actions_Phase2_FilingDt(RECORDOF(Action_1_s) L) := TRANSFORM
       SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.corp_id).UKey;
	   SELF.event_filing_reference_nbr := L.document_no;
       SELF.event_filing_date := L.action_dt;
       SELF.event_filing_desc := L.action_type;
       SELF.event_desc := L.action_notes;
     //  SELF.event_date_type_desc := 'FILING DATE';
	   SELF := []; 
     END;
	 
	 EXPORT Actions_FilingDt := PROJECT(Action_1_s,Actions_Phase2_FilingDt(LEFT));
	 
	 
	/* Corp2.Layout_Corporate_Direct_Event_In Actions_Phase2_EffectiveDt(RECORDOF(Action_1_s) L) := TRANSFORM
	   SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.corp_id).UKey;
	   SELF.event_filing_reference_nbr := L.document_no;
       SELF.event_filing_date := L.effective_dt;
       SELF.event_filing_desc := L.action_type;
       SELF.event_date_type_cd := 'EFF';
	   SELF.event_date_type_desc := 'FILING EFFECTIVE DATE';
	   SELF := []; 
     END; 
	 
	 EXPORT Actions_EffectiveDt := PROJECT(Action_1_s,Actions_Phase2_EffectiveDt(LEFT)); */
	
	 EXPORT Corporate_Direct_Event := Actions_FilingDt; //+ Actions_EffectiveDt;
	 
  END; //Process_Event_Data
  
  //********************************************************************
  // PROCESS CORP STOCK DATA
  //********************************************************************
  EXPORT Process_Stock_Data(STRING8 pProcessDate,STRING2 pState_Origin) := MODULE
     SHARED BOOLEAN _is_valid (STRING pStockAttr) := IF((INTEGER) UI(pStockAttr) > 0,TRUE,FALSE);
  
     Layouts_Raw_Input.Stock Stock_Phase1(Corp2.Rewrite_Common.Layout_Generic L) := TRANSFORM
	  SELF.stock_id := L.Payload[1..10];             //STRING10 stock_id;
      SELF.corp_id := L.Payload[11..20];             //STRING10 corp_id;
      SELF.par_share_count := L.Payload[21..39];     //STRING19 par_share_count;
      STRING v_par_share_value := L.Payload[40..59]; // STRING20 par_share_value;
	  SELF.par_share_value := v_par_share_value[1..stringlib.stringfind(v_par_share_value, '.', 1)+2];
	 END;  
	 
	 EXPORT Stock_0 := PROJECT(Files_Raw_Input(pProcessDate).Stock,Stock_Phase1(LEFT));
	 
	 Corp2.Layout_Corporate_Direct_Stock_In Stock_Phase2(RECORDOF(Stock_0) L) := TRANSFORM
	   SELF.corp_key := L.corp_id;
       SELF.stock_nbr_par_shares := IF(_is_valid(L.par_share_count),Corp2.Rewrite_Common.FormatMoney(L.par_share_count,false),'');
	   SELF.stock_par_value := IF(_is_valid(L.par_share_value),L.par_share_value,''); 
	   SELF := [];
     END;
	 
	 EXPORT Stock_d00 := PROJECT(Stock_0,Stock_Phase2(LEFT));
	 
	 
	 EXPORT Corporate_Direct_Stock := JOIN(Stock_d00,
	                                       DISTRIBUTE(Process_Corp_Data(pProcessDate,pState_Origin).Corporation_RA,RANDOM()),
										   UI(LEFT.corp_key,'U') = UI(RIGHT.corp_id,'U'),
										   TRANSFORM(Corp2.Layout_Corporate_Direct_Stock_In,
										             SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,LEFT.corp_key).UKey;  
										             SELF.stock_authorized_nbr := IF(_is_valid(RIGHT.no_par_share_count),Corp2.Rewrite_Common.FormatMoney(UI(RIGHT.no_par_share_count),true),'');
													 SELF.stock_total_capital :=  IF(_is_valid(RIGHT.no_par_share_count),Corp2.Rewrite_Common.FormatMoney(UI(RIGHT.capital_amt),true),'');
													 SELF := LEFT;),
										    LEFT OUTER, HASH);
										              
	 
	 
	 
  END; //Process Events Data
  
  //********************************************************************
  // PROCESS CORPORATE ANNUAL REPORT DATA
  //********************************************************************
  EXPORT Process_AR_Data(STRING8 pProcessDate, STRING2 pState_Origin) := MODULE
    EXPORT Actions_0_AR := Process_Event_Data(pProcessDate,pState_Origin).Actions_0(UI(action_type,'U') IN ['INITIALLIST',
                                                                                                             'AMENDEDLIST',
	                                                                                                         'ANNUALLIST']);
	 
	Corp2.Layout_Corporate_Direct_AR_In AR_Phase2(RECORDOF(Actions_0_AR) L) := TRANSFORM
	   SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.corp_id).UKey;
	   //SELF.corp_key := L.corp_id;
	   SELF.ar_filed_dt := L.action_dt; 
	   SELF.ar_type := L.action_type; 
       SELF.ar_report_nbr := L.document_no; 
       SELF.ar_comment := L.action_notes; 
	   SELF := [];
	END;
  
    EXPORT AR_d00 := PROJECT(Actions_0_AR,AR_Phase2(LEFT));
	
	EXPORT Corporate_Direct_AR := AR_d00;
	
	/*EXPORT Corporate_Direct_AR := JOIN(AR_d00,
	                                   DISTRIBUTE(Process_Corp_Data(pProcessDate,pState_Origin).Corporation_RA,RANDOM()),
								 	   UI(LEFT.corp_key,'U') = UI(RIGHT.corp_id,'U'),
									   TRANSFORM(Corp2.Layout_Corporate_Direct_AR_In,
										         SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,LEFT.corp_key).UKey;  
										         SELF.ar_due_dt := RIGHT.annual_lo_due_dt;
										 	     SELF := LEFT;),
									   LEFT OUTER, HASH); */
 
  END; //Process Annual Report Data
  
	EXPORT Main(
		 STRING8 pProcessDate
		,BOOLEAN pDebugMode		= false
		,STRING1 pSuffix			= ''
		,BOOLEAN pshouldspray = _Dataset().bShouldSpray
		,boolean pOverwrite		= false
						 
	) := 
	function
						 
						
  //Raw files spray section
  	
	SHARED sCO  := IF(pshouldspray,SprayInputFiles(pProcessDate).Corporation); 
	SHARED sRA  := IF(pshouldspray,SprayInputFiles(pProcessDate).RA);
    SHARED sOfc := IF(pshouldspray,SprayInputFiles(pProcessDate).Officers);
    SHARED sAct := IF(pshouldspray,SprayInputFiles(pProcessDate).Actions);
    SHARED sStk := IF(pshouldspray,SprayInputFiles(pProcessDate).Stock);

	
	SHARED Corp_Direct_Corp := (Process_Corp_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Corp); 

    ACD_GMA := Corp2.Rewrite_Common.AddCorpData_and_GenerateMappedOutput(Process_Corp_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Corp,
	   			 			                                             Process_Cont_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Cont,
							                                             Process_Event_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Event,
							                                             Process_Stock_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Stock,
							                                             Process_AR_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_AR,
										                                 'Corp',
																		 'Cont',
																		 'Event',
																		 'Stock',
																		 'AR',
							                                              STATE_ORIGIN,
																		  pProcessDate,
										                                  pDebugMode,
										                                  pSuffix,
																											
																		  TRUE,pOverwrite);
    
    return
	 SEQUENTIAL(if(pshouldspray = true,fSprayFiles('nv',pProcessDate,pOverwrite := pOverwrite))
	 
	         	  ,ACD_GMA.Crp,
	              ACD_GMA.Cnt,
			  	  ACD_GMA.Evt,
			  	  ACD_GMA.Stk,
				  ACD_GMA.AR
				  ); 
  END;//Main
  
  
END; //NV