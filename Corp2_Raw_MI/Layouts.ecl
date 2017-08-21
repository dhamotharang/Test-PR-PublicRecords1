IMPORT Corp2_Mapping;
EXPORT Layouts := module

  shared max_size := _Dataset().max_record_size;//4096

	export MasterStringLayoutIn					:= record, 		maxlength(max_size)
		string payload;
	end;
	
	export MasterStringLayoutBase				:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		MasterStringLayoutIn;
	end;
	
	export DeleteLayoutIn								:= record			//"00" record type (Delete Record)
		string7		date_00;															//date of record - julian jjjccyy
		string7		type_00;															//type of record "00"
		string7		trans_00;															//indicator "D"
		string7		id_no_00;															//identification number
		string7		filler_00;														//filler
	end;
	
	export DeleteLayoutBase							:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		DeleteLayoutIn;
	end;
	
	export CorpMaster1ALayoutIn					:= record			//"1A" record type
		string7		rec_date_1a;													//date of record - julian jjjccyy
		string2		rec_type_1a;													//type of record "1A"
		string1		trans_code_1a;												//indicator (â€˜Aâ€™, â€˜Câ€™, â€˜Nâ€™)	
		string6		c_no_1a;															//identification number
		string140	c_name_1a;														//corporation name
		string1		c_agent_1a;														//agent code
		string8		c_date_inc_1a;												//date of incorporation-ccyymmdd
		string1		c_term_1a;														//term of existence
		string8		c_date_end_1a;												//ending date - ccyymmdd
		string45	c_reg_agent_1a;												//registered agent name
		string32	c_agent_adr_1a;												//registered agent address
		string8		c_act1_1a;														//statutory act
		string8		c_act2_1a;														//statutory act
		string8		c_act3_1a;														//statutory act
		string15	c_filler_1a;													//filler
	end;

	export CorpMaster1ALayoutBase				:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		CorpMaster1ALayoutIn;
	end;

	export CorpMaster1BLayoutIn					:= record			//"1B" record type
		string7 	rec_date_1b;													//date of record - julian jjjccyy
		string2 	rec_type_1b;													//type of record "1B"
		string1 	trans_code_1b;												//indicator (â€˜Aâ€™, â€˜Câ€™, â€˜Nâ€™)	
		string6 	c_no_1b;															//identification number
		string32 	a_adr_1b;															//resident agent address
		string26 	a_city_1b;														//resident agent city
		string2 	a_state_1b;														//resident agent state
		string9 	a_zip_1b;															//resident agent zip
		string4 	rpt_fy_1b;														//annual report year
		string4 	rpt_roll_1b;													//microfilm number
		string4 	rpt_frame_1b;													//microfilm frame number
		string1 	stock_his_1b;													//indicator change in stock (â€˜yâ€™, â€™nâ€™)	
		string9 	fe_no_1b;															//fein
		string1 	name_his_1b;													//name change flag
		string25 	purpose_1b;														//purpose
		string1 	m_addr_1b;														//mailing address (â€˜yâ€™, â€˜nâ€™)
		string3 	assum_name_1b;												//number of assumed names
		string1 	rpt_ext_1b;														//number of extensions for ar
		string2 	inc_st_1b;														//state of incorporation code	
		string8 	date_out_1b;													//date dissolved - ccyymmdd
		string1 	pend_fl_1b;														//flag for pending records
		string1 	out_fl_1b;														//flag if corporation is inactive
		string1 	alert_fl_1b;													//flag if any special messages
		string2 	reason_out_1b;												//reason dissolved code
		string16 	total_shares_1b;											//total authorized shares	
		string121 filler_1b;														//filler
	end;

	export CorpMaster1BLayoutBase				:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		CorpMaster1BLayoutIn;
	end;
	
	export LP2ALayoutIn									:= record			//"2A" record type
		string7 	rec_date_2a;													//date of record - julian jjjccyy
		string2 	rec_type_2a;													//type of record "1B"
		string1 	trans_code_2a;												//indicator (â€˜Aâ€™, â€˜Câ€™, â€˜Nâ€™)	
		string6 	l_corp_no_2a;													//identification number	
		string140	l_name_2a;														//name
		string32 	l_addr1_2a;														//1st address line
		string32 	l_addr2_2a;														//2nd address line
		string26 	l_city_2a;														//city
		string2 	l_state_2a;														//state
		string9 	l_zip_2a;															//zip
		string33 	filler_2a;														//filler
	end;

	export LP2ALayoutBase								:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		LP2ALayoutIn;
	end;
	
	export LP2BLayoutIn 								:= record			//"2B" record type
		string7 	rec_date_2b;													//date of record - julian jjjccyy
		string2 	rec_type_2b;													//type of record "2B"
		string1 	trans_code_2b;												//indicator ("A", "C", "N")
		string6 	l_corp_no_2b;													//identification number
		string45 	l_agent_2b;														//agent name
		string32 	l_agent_addr1_2b;											//1st address line
		string32 	l_agent_addr2_2b;											//2nd address line
		string26 	l_agent_city_2b;											//city
		string2 	l_agent_state_2b;											//state code
		string9 	l_agent_zip_2b;												//zip
		string2 	l_county_code_2b;											//county code
		string8 	l_formed_date_2b;											//date formed - ccyymmdd
		string8 	l_term_date_2b;												//duration - ccyymmdd
		string1 	l_term_flag_2b;												//indicator - ("0","1")
		string2 	l_form_state_2b;											//state code - where formed
		string8 	l_out_date_2b;												//date of expiration - ccyymmdd
		string2 	l_out_why_2b;													//reason for expiration code
		string1 	l_hist_flag_2b;												//indicator - ("0","1","2")
		string4 	l_assum_flag_2b;											//assumption flag
		string1 	l_p_flag_2b;													//indicator - ("Y","N")
		string1 	l_out_flag_2b;												//indicator - ("0","1")
		string1 	l_alert_flag_2b;											//indicator - ("Y","N","0")
		string3 	l_num_part_2b;												//number of partners
		string9 	l_fe_num_2b;													//fein
		string77 	filler_2b;														//filler
	end;

	export LP2BLayoutBase								:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		LP2BLayoutIn;
	end;

	export LLC3ALayoutIn 								:= record			//"3A" record type
		string7		rec_date_3a;													//date of record â€“ julian jjjccyy		
		string2		rec_type_3a;													//record type indicator (â€3Aâ€)		
		string1		trans_code_3a;												//indicator (â€Aâ€, â€Câ€)		
		string6		corp_3a;															//identification number		
		string140	corp_name_3a;													//llc name		
		string1		corp_agent_code_3a;										//registered agent type		
		string8		incorp_date_3a;												//date of incorporation-ccyymmdd		
		string1		term_code_3a;													//term code (â€œ0â€, â€œ1â€, â€œ2â€)		
		string8		end_date_3a;													//ending date - ccyymmdd		
		string45	r_agent_3a;														//agent name		
		string32	agent_addr_3a;												//agent address		
		string8		act1_3a;															//statutory act 		
		string8		act2_3a;															//statutory act		
		string8		act3_3a;															//statutory act		
		string15	filler_3a; 														//filler
	end;

	export LLC3ALayoutBase							:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		LLC3ALayoutIn;
	end;
	
	export LLC3BLayoutIn 								:= record			//"3B" record type
		string7		rec_date_3b;													//date of record â€“ julian jjjccyy	
		string2		rec_type_3b;													//record type indicator (â€˜3bâ€™)	
		string1		trans_code_3b;												//indicator (â€œAâ€ or â€œCâ€)
		string6		corp_3b;															//identification number	
		string32	agent_addr_3b;												//agent address	
		string26	agent_city_3b;												//agent city	
		string2		agent_state_3b;												//agent state code	
		string9		agent_zip_3b;													//agent zip	
		string25	purpose_3b;														//purpose	
		string8		end_date_3b;													//ending date - ccyymmdd	
		string2		out_fl_3b;														//reason out code	
		string3		asum_nme_3b;													//indicator (â€˜nâ€™ or â€˜yâ€™)	
		string1		pend_fl_3b;														//indicator (â€˜nâ€™ or â€˜yâ€™)	
		string1		alert_fl_3b;													//indicator (â€˜nâ€™ or â€˜yâ€™)	
		string8		managed_by_3b;												//member or managers	
		string157	filler_3b;														//filler	
	end;

	export LLC3BLayoutBase							:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		LLC3BLayoutIn;
	end;
	
	export NameRegistrationLayoutIn 		:= record			//"30" record type	
		string7		rec_date_30;													//date of record â€“ julian jjjccyy	
		string2		rec_type_30;													//record type indicator (â€œ30â€)	
		string1		trans_code_30;												//indicator (â€œCâ€ or â€œNâ€)	
		string6		r_no_30;															//identification number	
		string140	name_30;															//name	
		string32	addr1_30;															//1st line of address	
		string32	addr2_30;															//2nd line of address	
		string26	city_30;															//city	
		string2		st_30;																//state code	
		string9		zip_30;																//zip	
		string2		corp_st_30;														//state of incorporation	
		string8		corp_date_30;													//date formed â€“ ccyymmdd	
		string8		reg_date_30;													//date registered â€“ ccyymmdd	
		string8		exp_date_30;													//expiration date â€“ ccyymmdd	
		string1		pend_fl_30;														//flag for pending record	
		string2		out_fl_30;														//flag for expired name	
		string1		alert_fl_30;													//flag for special messages	
		string4		filler_30;														//filler
	end;
	
	export NameRegistrationLayoutBase		:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		NameRegistrationLayoutIn;
	end;
	
	export MailingLayoutIn							:= record			//"50" record type		
		string7		rec_date_50;													//date of record â€“ julian jjjccyy 	
		string2		rec_type_50;													//record type indicator (â€œ50â€)	
		string1		trans_code_50;												//indicator (â€œCâ€ or â€œNâ€)
		string6		corp_no_50;														//identification number	
		string32	addr1_50;															//1st line of address	
		string32	addr2_50;															//2nd line of address	
		string26	city_50;															//city	
		string2		st_50;																//state code	
		string9		zip_50;																//zip	
		string8		pob_50;																//p.o. box	
		string165	filler_50;														//filler
	end;

	export MailingLayoutBase						:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		MailingLayoutIn;
	end;

	export PendingLayoutIn 							:= record			//"60" record type
		string7		rec_date_60;													//date of record â€“ julian jjjccyy	
		string2		rec_type_60;													//record type indicator (â€œ60â€)	
		string1		trans_code_60;												//indicator (â€œCâ€ or â€œNâ€)	
		string6		pend_no_60;														//identification number	
		string4		pend_status_60;												//status	
		string140	pend_name_60;													//pending name	
		string2		pend_ex_60;														//examiner code	
		string2		p_rej_code1_60;												//rejection code	
		string2		p_rej_code2_60;												//rejection code	
		string2		p_rej_code3_60;												//rejection code	
		string8		fil_date_60;													//date filed - ccyymmdd	
		string8		exp_date_60;													//date expires - ccyymmdd	
		string8		rcd_date_60;													//date received - ccyymmdd	
		string6		new_form_60;													//form number	
		string92	filler_60;														//filler		
	end;
	
	export PendingLayoutBase						:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		PendingLayoutIn;
	end;

	export HistoryLayoutIn 							:= record			//"70" record type
		string7		rec_date_70;													//date of record â€“ julian jjjccyy	
		string2		rec_type_70;													//record type indicator (â€œ70â€)	
		string1		trans_code_70;												//indicator (â€œCâ€ or â€œNâ€)	
		string6		corp_no_70;														//identification number	
		string2		rec_typ_70;														//type of change filed code	
		string45	info_70;															//written statement of change	
		string8		h_date_70;														//date of change - ccyymmdd	
		string4		roll_70;															//microfilm number	
		string4		frame_70;															//microfilm frame number	
		string45	info2_70;															//additional written information	
		string45	info3_70;															//additional written information	
		string45	info4_70;															//additional written information	
		string45	info5_70;															//additional written information	
		string31	filler_70;														//filler	
	end;
	
	export HistoryLayoutBase						:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		HistoryLayoutIn;
	end;

	export AssumedNameLayoutIn 					:= record			//"80" record type
		string7		rec_date_80;													//date of record â€“ julian jjjccyy	
		string2		rec_type_80;													//record type indicator (â€œ80â€)	
		string1		trans_code_80;												//indicator (â€œcâ€ or â€œnâ€)	
		string6		corp_no_80;														//identification number	
		string3		rec_no_80;														//number of assumed name	
		string8		file_date_80;													//date filed - ccyymmdd	
		string8		exp_date_80;													//expiration date - ccyymmdd	
		string140	name_80;															//name	
		string8		renw_date_80;													//renew date - ccyymmdd	
		string107	filler_80;														//filler
	end;	
	
	export AssumedNameLayoutBase				:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		AssumedNameLayoutIn;
	end;

	export GeneralPartnerLayoutIn 			:= record			//"90" record type
		string7		rec_date_90;													//date of record â€“ julian jjjccyy	
		string2		rec_type_90;													//record type indicator (â€œ90â€)	
		string1		trans_code_90;												//indicator (â€œCâ€ or â€œNâ€)	
		string6		gp_no_90;															//identification number	
		string60	gp_name_90;														//name of general partner	
		string32	gp_addr1_90;													//1st line of address for partner	
		string32	gp_addr2_90;													//2nd line of address for partner 	
		string26	gp_city_90;														//city for partner	
		string2		gp_state_90;													//state code for partner	
		string9		gp_zip_90;														//zip for partner	
		string113	filler_90;														//filler
	end;
	
	export GeneralPartnerLayoutBase			:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		GeneralPartnerLayoutIn;
	end;

	//Temporary Layouts
	export Temp_CorpMaster 							:= record
		CorpMaster1ALayoutIn;
		CorpMaster1BLayoutIn;
	end;

	export Temp_LP 											:= record
		LP2ALayoutIn;
		LP2BLayoutIn;
	end;	

	export Temp_LLC 										:= record
		LLC3ALayoutIn;
		LLC3BLayoutIn;
	end;
	
	export Temp_CorpGeneralPartner			:= record
		GeneralPartnerLayoutIn;
		Corp2_Mapping.LayoutsCommon.Main.Corp_legal_name;
	end;
	
	export Temp_CorpAssumedName					:= record
		string8		corp_inc_date;
		string8		corp_forgn_date;
		AssumedNameLayoutIn;
	end;	
	
end;
			