IMPORT DCAV2, Address, Standard;

EXPORT Layouts := MODULE

	EXPORT companies := DCAV2.Layouts.input.companies;
	EXPORT layout_entnum := DCAV2.Layouts.base.keybuildentnum;
	EXPORT killreport_clean := DCAV2.Layouts.input.killreport_clean - enterprise_nbr - __filename;
	EXPORT mergeracquis_clean := DCAV2.Layouts.input.MergerAcquis_clean - __filename;
	EXPORT layout_clean182_fips := Address.Layout_Clean182_fips;
	EXPORT clean_phones := DCAV2.Layouts.clean_phones;
	EXPORT clean_dates :=  DCAV2.Layouts.clean_dates;

	EXPORT layout_linkids := RECORD
		unsigned6 ultid;
		unsigned6 orgid;
		unsigned6 seleid;
		unsigned6 proxid;
		unsigned6 powid;
		unsigned6 empid;
		unsigned6 dotid;
		unsigned2 ultscore;
		unsigned2 orgscore;
		unsigned2 selescore;
		unsigned2 proxscore;
		unsigned2 powscore;
		unsigned2 empscore;
		unsigned2 dotscore;
		unsigned2 ultweight;
		unsigned2 orgweight;
		unsigned2 seleweight;
		unsigned2 proxweight;
		unsigned2 powweight;
		unsigned2 empweight;
		unsigned2 dotweight;
		unsigned6 src_rid;
		unsigned6 rid;
		unsigned6 bdid;
		unsigned1 bdid_score;
		unsigned4 date_first_seen;
		unsigned4 date_last_seen;
		unsigned4 date_vendor_first_reported;
		unsigned4 date_vendor_last_reported;
		unsigned8 physical_rawaid;
		unsigned8 physical_aceaid;
		unsigned8 mailing_rawaid;
		unsigned8 mailing_aceaid;
		unsigned1 record_type;
		string6 file_type;
		unsigned3 lncagid;
		unsigned3 lncaghid;
		unsigned2 lncaiid;
		companies rawfields;
		killreport_clean killreport;
		mergeracquis_clean mergeracquis;
		layout_clean182_fips physical_address;
		layout_clean182_fips mailing_address;
		clean_phones clean_phones;
		clean_dates clean_dates;
	 END;
	 
	EXPORT layout_bdid := RECORD
		unsigned6 bdid;
		string8 process_date;
		string9 enterprise_num;
		string9 parent_enterprise_number;
		string9 ultimate_enterprise_number;
		string70 type_orig;
		string105 name;
		string107 note;
		string2 level;
		string9 root;
		string4 sub;
		string105 parent_name;
		string15 parent_number;
		string66 jv_parent1;
		string15 jv1_;
		string44 jv_parent2;
		string15 jv2_;
		string1 po_box_bldg;
		string347 street;
		string30 foreign_po;
		string30 misc__adr;
		string15 postal_code_1;
		string30 city;
		string2 state;
		string15 zip;
		string20 province;
		string15 postal_code_2;
		string29 country;
		string15 postal_code_3;
		string45 phone;
		string39 fax;
		string44 telex;
		string82 e_mail;
		string85 url;
		string1 po_box_bldg_a;
		string43 streeta;
		string30 foreign_po_boxa;
		string29 misc__adr_a;
		string13 postal_code_1a;
		string25 city_a;
		string2 state_a;
		string15 zip_a;
		string18 province_a;
		string13 postal_code_2a;
		string29 countrya;
		string15 postal_code_3a;
		string2 incorp;
		string5 percent_owned;
		string12 earnings;
		string12 sales;
		string15 sales_desc;
		string12 assets;
		string12 liabilities;
		string12 net_worth_;
		string6 fye;
		string9 emp_num;
		string1 import_orig;
		string1 export_orig;
		string1502 bus_desc;
		string4 sic1;
		string97 text1;
		string4 sic2;
		string97 text2;
		string4 sic3;
		string97 text3;
		string4 sic4;
		string97 text4;
		string4 sic5;
		string97 text5;
		string4 sic6;
		string97 text6;
		string4 sic7;
		string97 text7;
		string4 sic8;
		string97 text8;
		string4 sic9;
		string97 text9;
		string4 sic10;
		string97 text10;
		string46 name_1;
		string63 title_1;
		string3 code_1;
		string45 name_2;
		string65 title_2;
		string3 code_2;
		string44 name_3;
		string65 title_3;
		string3 code_3;
		string36 name_4;
		string65 title_4;
		string3 code_4;
		string43 name_5;
		string65 title_5;
		string3 code_5;
		string43 name_6;
		string65 title_6;
		string3 code_6;
		string42 name_7;
		string65 title_7;
		string3 code_7;
		string40 name_8;
		string65 title_8;
		string3 code_8;
		string37 name_9;
		string61 title_9;
		string3 code_9;
		string38 name_10;
		string65 title_10;
		string3 code_10;
		string11 ticker_symbol;
		string7 exchange1;
		string6 exchange2;
		string6 exchange3;
		string6 exchange4;
		string6 exchange5;
		string6 exchange6;
		string4 exchange7;
		string4 exchange8;
		string4 exchange9;
		string4 exchange10;
		string4 exchange11;
		string4 exchange12;
		string4 exchange13;
		string3 exchange14;
		string3 exchange15;
		string3 exchange16;
		string3 exchange17;
		string2 exchange18;
		string3 exchange19;
		string8 update_date;
		string5 exec1_title;
		string20 exec1_fname;
		string20 exec1_mname;
		string20 exec1_lname;
		string5 exec1_name_suffix;
		string3 exec1_score;
		string5 exec2_title;
		string20 exec2_fname;
		string20 exec2_mname;
		string20 exec2_lname;
		string5 exec2_name_suffix;
		string3 exec2_score;
		string5 exec3_title;
		string20 exec3_fname;
		string20 exec3_mname;
		string20 exec3_lname;
		string5 exec3_name_suffix;
		string3 exec3_score;
		string5 exec4_title;
		string20 exec4_fname;
		string20 exec4_mname;
		string20 exec4_lname;
		string5 exec4_name_suffix;
		string3 exec4_score;
		string5 exec5_title;
		string20 exec5_fname;
		string20 exec5_mname;
		string20 exec5_lname;
		string5 exec5_name_suffix;
		string3 exec5_score;
		string5 exec6_title;
		string20 exec6_fname;
		string20 exec6_mname;
		string20 exec6_lname;
		string5 exec6_name_suffix;
		string3 exec6_score;
		string5 exec7_title;
		string20 exec7_fname;
		string20 exec7_mname;
		string20 exec7_lname;
		string5 exec7_name_suffix;
		string3 exec7_score;
		string5 exec8_title;
		string20 exec8_fname;
		string20 exec8_mname;
		string20 exec8_lname;
		string5 exec8_name_suffix;
		string3 exec8_score;
		string5 exec9_title;
		string20 exec9_fname;
		string20 exec9_mname;
		string20 exec9_lname;
		string5 exec9_name_suffix;
		string3 exec9_score;
		string5 exec10_title;
		string20 exec10_fname;
		string20 exec10_mname;
		string20 exec10_lname;
		string5 exec10_name_suffix;
		string3 exec10_score;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 z5;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dpbc;
		string1 chk_digit;
		string2 rec_type;
		string5 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string10 prim_rangea;
		string2 predira;
		string28 prim_namea;
		string4 addr_suffixa;
		string2 postdira;
		string10 unit_desiga;
		string8 sec_rangea;
		string25 p_city_namea;
		string25 v_city_namea;
		string2 sta;
		string5 zipa;
		string4 zip4a;
		string4 carta;
		string1 cr_sort_sza;
		string4 lota;
		string1 lot_ordera;
		string2 dpbca;
		string1 chk_digita;
		string2 rec_typea;
		string5 countya;
		string10 geo_lata;
		string11 geo_longa;
		string4 msaa;
		string7 geo_blka;
		string1 geo_matcha;
		string4 err_stata;
		string1 lf;
		unsigned8 __internal_fpos__;
	 END;
 
	//layout of the infile sprayed
	EXPORT layout_in := RECORD
		string8 process_date;
		string9 Enterprise_num;
		string70 Type_orig;
		string105 Name;
		string107 Note;
		string2 Level;
		string9 Root;
		string4 Sub;
		string105 Parent_Name;
		string15 Parent_Number;
		string66 JV_Parent1;
		string15 JV1_;
		string44 JV_Parent2;
		string15 JV2_;
		string1 PO_Box_Bldg;
		string347 Street;
		string30 Foreign_PO;
		string30 Misc__adr;
		string15 Postal_Code_1;
		string30 City;
		string2 State;
		string5 Zip;
		string20 Province;
		string15 Postal_Code_2;
		string29 Country;
		string15 Postal_Code_3;
		string45 Phone;
		string39 Fax;
		string44 Telex;
		string82 E_mail;
		string85 URL;
		string1 PO_Box_Bldg_A;
		string43 StreetA;
		string30 Foreign_PO_BoxA;
		string29 Misc__adr_A;
		string13 Postal_Code_1A;
		string25 City_A;
		string2 State_A;
		string15 Zip_A;
		string18 Province_A;
		string13 Postal_Code_2A;
		string29 CountryA;
		string15 Postal_Code_3A;
		string2 Incorp;
		string5 percent_owned;
		string12 Earnings;
		string12 Sales;
		string15 Sales_Desc;
		string12 Assets;
		string12 Liabilities;
		string12 Net_Worth_;
		string6 FYE;
		string9 EMP_NUM;
		string1 Import_orig;
		string1 Export_orig;
		string1502 Bus_Desc;
		string4 Sic1;
		string97 Text1;
		string4 Sic2;
		string97 Text2;
		string4 Sic3;
		string97 Text3;
		string4 Sic4;
		string97 Text4;
		string4 Sic5;
		string97 Text5;
		string4 Sic6;
		string97 Text6;
		string4 Sic7;
		string97 Text7;
		string4 Sic8;
		string97 Text8;
		string4 Sic9;
		string97 Text9;
		string4 Sic10;
		string97 Text10;
		string46 Name_1;
		string63 Title_1;
		string3 code_1;
		string45 Name_2;
		string65 Title_2;
		string3 code_2;
		string44 Name_3;
		string65 Title_3;
		string3 code_3;
		string36 Name_4;
		string65 Title_4;
		string3 code_4;
		string43 Name_5;
		string65 Title_5;
		string3 code_5;
		string43 Name_6;
		string65 Title_6;
		string3 code_6;
		string42 Name_7;
		string65 Title_7;
		string3 code_7;
		string40 Name_8;
		string65 Title_8;
		string3 code_8;
		string37 Name_9;
		string61 Title_9;
		string3 code_9;
		string38 Name_10;
		string65 Title_10;
		string3 code_10;
		string11 Ticker_Symbol;
		string7 Exchange1;
		string6 Exchange2;
		string6 Exchange3;
		string6 Exchange4;
		string6 Exchange5;
		string6 Exchange6;
		string4 Exchange7;
		string4 Exchange8;
		string4 Exchange9;
		string4 Exchange10;
		string4 Exchange11;
		string4 Exchange12;
		string4 Exchange13;
		string3 Exchange14;
		string3 Exchange15;
		string3 Exchange16;
		string3 Exchange17;
		string2 Exchange18;
		string3 Exchange19;
		string7 Naics1;
		string150 Naics_Text1;
		string7 Naics2;
		string150 Naics_Text2;
		string7 Naics3;
		string150 Naics_Text3;
		string7 Naics4;
		string150 Naics_Text4;
		string7 Naics5;
		string150 Naics_Text5;
		string7 Naics6;
		string150 Naics_Text6;
		string7 Naics7;
		string150 Naics_Text7;
		string7 Naics8;
		string150 Naics_Text8;
		string7 Naics9;
		string150 Naics_Text9;
		string7 Naics10;
		string150 Naics_Text10;
		string8 Update_Date;
		string5 exec1_title;
		string20 exec1_fname;
		string20 exec1_mname;
		string20 exec1_lname;
		string5 exec1_name_suffix;
		string3 exec1_score;
		string5 exec2_title;
		string20 exec2_fname;
		string20 exec2_mname;
		string20 exec2_lname;
		string5 exec2_name_suffix;
		string3 exec2_score;
		string5 exec3_title;
		string20 exec3_fname;
		string20 exec3_mname;
		string20 exec3_lname;
		string5 exec3_name_suffix;
		string3 exec3_score;
		string5 exec4_title;
		string20 exec4_fname;
		string20 exec4_mname;
		string20 exec4_lname;
		string5 exec4_name_suffix;
		string3 exec4_score;
		string5 exec5_title;
		string20 exec5_fname;
		string20 exec5_mname;
		string20 exec5_lname;
		string5 exec5_name_suffix;
		string3 exec5_score;
		string5 exec6_title;
		string20 exec6_fname;
		string20 exec6_mname;
		string20 exec6_lname;
		string5 exec6_name_suffix;
		string3 exec6_score;
		string5 exec7_title;
		string20 exec7_fname;
		string20 exec7_mname;
		string20 exec7_lname;
		string5 exec7_name_suffix;
		string3 exec7_score;
		string5 exec8_title;
		string20 exec8_fname;
		string20 exec8_mname;
		string20 exec8_lname;
		string5 exec8_name_suffix;
		string3 exec8_score;
		string5 exec9_title;
		string20 exec9_fname;
		string20 exec9_mname;
		string20 exec9_lname;
		string5 exec9_name_suffix;
		string3 exec9_score;
		string5 exec10_title;
		string20 exec10_fname;
		string20 exec10_mname;
		string20 exec10_lname;
		string5 exec10_name_suffix;
		string3 exec10_score;
		string150 cust_name;
		string20 bug_num;
		string8 link_dob;
		string9 link_ssn;
		string link_fein;
		string8 link_inc_date;
	END;
	
	EXPORT layout_base := RECORD
		layout_in;
		companies companies;
		killreport_clean killreport;
		mergeracquis_clean mergeracquis;
		layout_clean182_fips physical_address;
		layout_clean182_fips mailing_address;
		clean_phones clean_phones;
		clean_dates clean_dates;
		unsigned6 did;
		unsigned6 bdid;
		string physical_addr_1;
		string physical_addr_2;
		unsigned8 physical_rawaid;
		string mailing_addr_1;
		string mailing_addr_2;
		unsigned8 mailing_rawaid;
		string addr_1;
		string addr_2;
		unsigned8 rawaid;	
		string1 addr_type_flag; //'P' for Physical, 'M' for Mailing (needed for AID function)		
		unsigned6 ultid;
		unsigned6 orgid;
		unsigned6 seleid;
		unsigned6 proxid;
		unsigned6 powid;
		unsigned6 empid;
		unsigned6 dotid;    
		unsigned8 row_id;
	END;
   
//the rest are used to build empty keys	
  EXPORT layout_hierarchy_parent_to_child_entnum := RECORD
		string9 parent_enterprise_number;
		string9 enterprise_num;
		string2 child_level;
		unsigned8 __internal_fpos__;
	END;
	    
	EXPORT layout_hierarchy_bdid := RECORD
		unsigned6 bdid;
		string2 level;
		string9 root;
		string4 sub;
		string9 parent_root;
		string4 parent_sub;
		unsigned8 __internal_fpos__;
	END;
  
	EXPORT layout_hierarchy_parent_to_child_root_sub := RECORD
		string9 parent_root;
		string4 parent_sub;
		string9 child_root;
		string4 child_sub;
		string2 child_level;
		unsigned8 __internal_fpos__;
  END;

  EXPORT layout_hierarchy_root_sub := RECORD
		string9 root;
		string4 sub;
		unsigned6 bdid;
		string2 level;
		string9 parent_root;
		string4 parent_sub;
		unsigned8 __internal_fpos__;
	END;

	EXPORT layout_root_sub := RECORD
		string9 root;
		string4 sub;
		unsigned6 bdid;
		string8 process_date;
		string9 enterprise_num;
		string9 parent_enterprise_number;
		string9 ultimate_enterprise_number;
		string70 type_orig;
		string105 name;
		string107 note;
		string2 level;
		string105 parent_name;
		string15 parent_number;
		string66 jv_parent1;
		string15 jv1_;
		string44 jv_parent2;
		string15 jv2_;
		string1 po_box_bldg;
		string347 street;
		string30 foreign_po;
		string30 misc__adr;
		string15 postal_code_1;
		string30 city;
		string2 state;
		string15 zip;
		string20 province;
		string15 postal_code_2;
		string29 country;
		string15 postal_code_3;
		string45 phone;
		string39 fax;
		string44 telex;
		string82 e_mail;
		string85 url;
		string1 po_box_bldg_a;
		string43 streeta;
		string30 foreign_po_boxa;
		string29 misc__adr_a;
		string13 postal_code_1a;
		string25 city_a;
		string2 state_a;
		string15 zip_a;
		string18 province_a;
		string13 postal_code_2a;
		string29 countrya;
		string15 postal_code_3a;
		string2 incorp;
		string5 percent_owned;
		string12 earnings;
		string12 sales;
		string15 sales_desc;
		string12 assets;
		string12 liabilities;
		string12 net_worth_;
		string6 fye;
		string9 emp_num;
		string1 import_orig;
		string1 export_orig;
		string1502 bus_desc;
		string4 sic1;
		string97 text1;
		string4 sic2;
		string97 text2;
		string4 sic3;
		string97 text3;
		string4 sic4;
		string97 text4;
		string4 sic5;
		string97 text5;
		string4 sic6;
		string97 text6;
		string4 sic7;
		string97 text7;
		string4 sic8;
		string97 text8;
		string4 sic9;
		string97 text9;
		string4 sic10;
		string97 text10;
		string46 name_1;
		string63 title_1;
		string3 code_1;
		string45 name_2;
		string65 title_2;
		string3 code_2;
		string44 name_3;
		string65 title_3;
		string3 code_3;
		string36 name_4;
		string65 title_4;
		string3 code_4;
		string43 name_5;
		string65 title_5;
		string3 code_5;
		string43 name_6;
		string65 title_6;
		string3 code_6;
		string42 name_7;
		string65 title_7;
		string3 code_7;
		string40 name_8;
		string65 title_8;
		string3 code_8;
		string37 name_9;
		string61 title_9;
		string3 code_9;
		string38 name_10;
		string65 title_10;
		string3 code_10;
		string11 ticker_symbol;
		string7 exchange1;
		string6 exchange2;
		string6 exchange3;
		string6 exchange4;
		string6 exchange5;
		string6 exchange6;
		string4 exchange7;
		string4 exchange8;
		string4 exchange9;
		string4 exchange10;
		string4 exchange11;
		string4 exchange12;
		string4 exchange13;
		string3 exchange14;
		string3 exchange15;
		string3 exchange16;
		string3 exchange17;
		string2 exchange18;
		string3 exchange19;
		string8 update_date;
		string5 exec1_title;
		string20 exec1_fname;
		string20 exec1_mname;
		string20 exec1_lname;
		string5 exec1_name_suffix;
		string3 exec1_score;
		string5 exec2_title;
		string20 exec2_fname;
		string20 exec2_mname;
		string20 exec2_lname;
		string5 exec2_name_suffix;
		string3 exec2_score;
		string5 exec3_title;
		string20 exec3_fname;
		string20 exec3_mname;
		string20 exec3_lname;
		string5 exec3_name_suffix;
		string3 exec3_score;
		string5 exec4_title;
		string20 exec4_fname;
		string20 exec4_mname;
		string20 exec4_lname;
		string5 exec4_name_suffix;
		string3 exec4_score;
		string5 exec5_title;
		string20 exec5_fname;
		string20 exec5_mname;
		string20 exec5_lname;
		string5 exec5_name_suffix;
		string3 exec5_score;
		string5 exec6_title;
		string20 exec6_fname;
		string20 exec6_mname;
		string20 exec6_lname;
		string5 exec6_name_suffix;
		string3 exec6_score;
		string5 exec7_title;
		string20 exec7_fname;
		string20 exec7_mname;
		string20 exec7_lname;
		string5 exec7_name_suffix;
		string3 exec7_score;
		string5 exec8_title;
		string20 exec8_fname;
		string20 exec8_mname;
		string20 exec8_lname;
		string5 exec8_name_suffix;
		string3 exec8_score;
		string5 exec9_title;
		string20 exec9_fname;
		string20 exec9_mname;
		string20 exec9_lname;
		string5 exec9_name_suffix;
		string3 exec9_score;
		string5 exec10_title;
		string20 exec10_fname;
		string20 exec10_mname;
		string20 exec10_lname;
		string5 exec10_name_suffix;
		string3 exec10_score;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 z5;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dpbc;
		string1 chk_digit;
		string2 rec_type;
		string5 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string10 prim_rangea;
		string2 predira;
		string28 prim_namea;
		string4 addr_suffixa;
		string2 postdira;
		string10 unit_desiga;
		string8 sec_rangea;
		string25 p_city_namea;
		string25 v_city_namea;
		string2 sta;
		string5 zipa;
		string4 zip4a;
		string4 carta;
		string1 cr_sort_sza;
		string4 lota;
		string1 lot_ordera;
		string2 dpbca;
		string1 chk_digita;
		string2 rec_typea;
		string5 countya;
		string10 geo_lata;
		string11 geo_longa;
		string4 msaa;
		string7 geo_blka;
		string1 geo_matcha;
		string4 err_stata;
		string1 lf;
		unsigned8 __internal_fpos__;
	 END;
	
	EXPORT layout_autokey := 
	RECORD
			unsigned6 bdid;
			STRING105 company_name; 	
			STRING45  company_phone;
			STRING2   Level;
			STRING9   Root;
			STRING4   Sub;
			STRING105 Parent_Name;
			STRING15  Parent_Number;			
			string9   Enterprise_num;
			string9   Parent_Enterprise_number;  
			Standard.L_Address.base bus_addr;
			UNSIGNED1 zero             :=  0;
			STRING1  blank            := '';
			STRING1  blank_prim_name  := '';
			STRING1  blank_prim_range := '';
			STRING1  blank_st         := '';
			STRING1  blank_city       := '';
			STRING1  blank_zip5       := '';
			STRING1  blank_sec_range  := '';
	END;
		
		
END;