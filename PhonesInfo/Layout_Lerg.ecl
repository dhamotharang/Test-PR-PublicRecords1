IMPORT dx_PhonesInfo;

	//DF-24397: Create Dx-Prefixed Keys

EXPORT Layout_Lerg := MODULE

	//Lerg1
	EXPORT lerg1_in := RECORD
		string4 ocn;
		string50 ocn_name;
		string20 ocn_abbr_name;
		string2	ocn_state;
		string10 category;
		string4	overall_ocn;
		string5	filler1;
		string1	filler2;
		string20 last_name;
		string10 first_name;
		string1 middle_initial;
		string50 company_name;
		string30 title;
		string address1;
		string address2;
		string10 floor;
		string20 room;
		string20 city;
		string2	state;
		string9 postal_code;
		string12 phone;
		string4 target_ocn;
		string4 overall_target_ocn;
		string1	rural_lec_indicator;
		string1	small_ilec_indicator;	
	END;
	
	EXPORT lerg1 := RECORD
		lerg1_in;
		string255 filename{virtual (logicalfilename)};
	END;
	
	EXPORT lerg1Hist := RECORD
		lerg1_in;	
		string255 filename;
	END;
	
	//Lerg1Con
	EXPORT lerg1Con_in := RECORD
		string4	ocn;
		string50 ocn_name;
		string2	ocn_state;
		string20 contact_function;
		string10 contact_phone;
		string70 contact_information;
		string16 filler;
	END;
	
	EXPORT lerg1Con := RECORD
		lerg1Con_in;	
		string255 filename{virtual (logicalfilename)};
	END;
	
	EXPORT lerg1ConHist := RECORD
		lerg1Con_in;	
		string255 filename;
	END;
	
	//Lerg1ConOver
	EXPORT lerg1ConOver_in := RECORD
		string ocn;	
		string ocn_name;
		string empty;
		string category;	
		string overall_ocn;	
		string contact_function;	
		string overall_company;
		string first_name;	
		string mi;	
		string last_name;	
		string title;	
		string address;	
		string floor;	
		string room;	
		string city;	
		string state;	
		string zip;	
		string contact_phone;	
		string email;	
		string fax;
	END;
	
	EXPORT lerg1ConOver := RECORD
		lerg1ConOver_in;	
		string255 filename{virtual (logicalfilename)};
	END;
	
	EXPORT lerg1ConOverHist := RECORD
		lerg1ConOver_in;	
		string255 filename;
	END;
	
	//Lerg Prep	
	EXPORT lergPrep := RECORD
		dx_PhonesInfo.Layouts.sourceRefBase;
		string address1;
		string address2;
		string opname;
		string country;
		string1 is_new;
		string1 rec_update;
	END;
	
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
	
	EXPORT lerg6Atc_in := RECORD
		lerg6_in;
		string os1;
		string os2;
		string os3;
		string os4;
		string os5;
		string os6;
		string os7;
		string os8;
		string os9;
		string os10;
		string os11;
		string os12;
		string os13;
		string os14;
		string os15;
		string os16;
		string os17;
		string os18;
		string os19;
		string os20;
		string os21;
		string os22;
		string os23;
		string os24;
		string os25;
	END;
	
	EXPORT lerg6Atc := RECORD
		lerg6Atc_in;
		string255 filename{virtual (logicalfilename)};
	END;
	
	EXPORT lerg6AtcHist := RECORD
		lerg6Atc_in;	
		string255 filename;
	END;
	
	EXPORT lerg6Odd_in := RECORD
		lerg6_in;
		string notes;
	END;
	
	EXPORT lerg6Odd := RECORD
		lerg6Odd_in;
		string255 filename{virtual (logicalfilename)};
	END;
	
	EXPORT lerg6OddHist := RECORD
		lerg6Odd_in;	
		string255 filename;
	END;
	
	//Lerg6 Base
	//dx_PhonesInfo.Layouts.lerg6Main
	
	EXPORT lerg6Prep := RECORD
		string3 lerg6_type;
		lerg6Atc_in;	
		string notes;
		string8 filedate;
		string255 filename;
	END;
	
	EXPORT lerg6UpdHist := record						
		string 			reference_id := '';
		string10 		phone;
		unsigned6		did:=0;
		string8			file_date := '';
	end;
	
	EXPORT lerg6UpdHist_Prep := record
		PhonesInfo.Layout_common.portedMetadata_Main;
		unsigned4   global_sid;		//CCPA Requirement
		unsigned8   record_sid;		//CCPA Requirement
	end;
	
END;