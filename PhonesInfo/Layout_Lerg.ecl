EXPORT Layout_Lerg := MODULE

	//DF-23660: Create Lerg6 Keybuild
	//DF-24140: Lerg6 Layout Change

	//Lerg6
	EXPORT lerg6_in:= RECORD
		string lata;
		string lata_name;
		string status;
		string eff_date;
		string npa;
		string nxx;
		string block_id;
		string filler1;
		string coc_type;
		string ssc;
		string dind;
		string td_eo;
		string td_at;
		string portable;
		string aocn;
		string filler2;
		string ocn;
		string loc_name;
		string loc;
		string loc_state;
		string rc_abbre;
		string rc_ty;
		string line_fr;
		string line_to;
		string switch;
		string sha_indicator;
		string filler3;
		string test_line_num;
		string test_line_response;
		string test_line_exp_date;
		string blk_1000_pool;
		string rc_lata;
		string filler4;
		string creation_date;
		string filler5;
		string e_status_date;
		string filler6;
		string last_modified_date;
		string filler7;
	END;
	
	EXPORT lerg6 := RECORD
		lerg6_in;
		string255 filename{virtual (logicalfilename)};
	END;
	
	EXPORT lerg6Hist := RECORD
		lerg6_in;	
		string255 filename;
	END;
	
	EXPORT lerg6Main := record
		string8 dt_first_reported;
		string8 dt_last_reported;
		string8 dt_start;						//Date/Time Entered in Table
		string8 dt_end;
		string2 source;
		string10 lata;
		string30 lata_name;
		string2 status;
		string8 eff_date;
		string6 eff_time;
		string3 npa;
		string3 nxx;
		string1 block_id;
		string1 filler1;
		string5 coc_type;
		string5 ssc;
		string1 dind;
		string5 td_eo;
		string5 td_at;
		string1 portable;
		string5 aocn;
		string1 filler2;
		string5 ocn;
		string20 loc_name;
		string5 loc;
		string2 loc_state;
		string20 rc_abbre;
		string5 rc_ty;
		string5 line_fr;
		string5 line_to;
		string15 switch;
		string5 sha_indicator;
		string1 filler3;
		string5 test_line_num;
		string2 test_line_response;
		string8 test_line_exp_date;
		string6 test_line_exp_time;
		string2 blk_1000_pool;
		string10 rc_lata;
		string1 filler4;
		string8 creation_date;
		string6 creation_time;
		string1 filler5;
		string8 e_status_date;
		string6 e_status_time;
		string1 filler6;
		string8 last_modified_date;
		string6 last_modified_time;
		string1 filler7;
		boolean is_current;
		string5 os1;
		string5 os2;
		string5 os3;
		string5 os4;
		string5 os5;
		string5 os6;
		string5 os7;
		string5 os8;
		string5 os9;
		string5 os10;
		string5 os11;
		string5 os12;
		string5 os13;
		string5 os14;
		string5 os15;
		string5 os16;
		string5 os17;
		string5 os18;
		string5 os19;
		string5 os20;
		string5 os21;
		string5 os22;
		string5 os23;
		string5 os24;
		string5 os25;
		string80 notes;
		unsigned4 global_sid;		//CCPA Requirement
		unsigned8 record_sid;		//CCPA Requirement
	end;
	
END;
