IMPORT Civ_Court, ut;

EXPORT Files_In_NJ := MODULE

	EXPORT raw	:= dataset('~thor_data400::in::civil::nj_civil',Civ_Court.Layouts_In_NJ.raw_in,flat);
	
//Case Header
	Civ_Court.Layouts_In_NJ.case_header xfrmCase(raw pInput)	:= TRANSFORM
		self.report_number							:= pInput.report_number;
		self.venue_id										:= pInput.venue_id;
		self.court_code									:= pInput.court_code;
		self.report_request_number			:= pInput.report_request_number;
		self.docketed_judgement_year		:= pInput.docketed_judgement_year;
		self.docketed_judgement_seq_num	:= pInput.docketed_judgement_seq_num;
		self.docketed_judgement_type_code	:= pInput.docketed_judgement_type_code;
		self.debt_number								:= pInput.debt_number;
		self.record_type_code						:= pInput.record_type_code;
		self.report_request_date				:= pInput.line[29..36];
		self.report_from_date						:= pInput.line[37..44];
		self.report_to_date							:= pInput.line[45..52];
		self.record_type_code_2					:= pInput.line[53..53];
		self.docketed_judgement_number	:= pInput.line[54..63];
		self.nonacms_docket_number			:= pInput.line[64..75];
		self.nonacms_venue_id						:= pInput.line[76..78];
		self.nonacms_docket_type				:= pInput.line[79..80];
		self.filler1										:= pInput.line[81..115];
		self.case_type_code							:= pInput.line[116..118];
		self.case_title									:= pInput.line[119..173];
		self.case_filed_date						:= pInput.line[174..181];
		self.acms_docket_number					:= pInput.line[182..191];
		self.acms_venue_id							:= pInput.line[192..194];
		self.acms_court_code						:= pInput.line[195..197];
	END;
	
	EXPORT case_header	:= project(raw(record_type_code = 'A'),xfrmCase(left));
	
//Judgements per case
	Civ_Court.Layouts_In_NJ.judgement xfrmJgmt(raw pInput)	:= TRANSFORM
		self.report_number							:= pInput.report_number;
		self.venue_id										:= pInput.venue_id;
		self.court_code									:= pInput.court_code;
		self.report_request_number			:= pInput.report_request_number;
		self.docketed_judgement_year		:= pInput.docketed_judgement_year;
		self.docketed_judgement_seq_num	:= pInput.docketed_judgement_seq_num;
		self.docketed_judgement_type_code	:= pInput.docketed_judgement_type_code;
		self.debt_number								:= pInput.debt_number;
		self.record_type_code						:= pInput.record_type_code;
		self.record_type_code1					:= pInput.line[29..29];
		self.docketed_judgement_number	:= pInput.line[30..39];
		self.judgement_number						:= pInput.line[40..49];
		self.judgement_status_code			:= pInput.line[50..50];
		self.judgement_status_date			:= pInput.line[51..58];
		self.judgement_orig_amt					:= pInput.line[59..67];
		self.judgement_orig_taxed_cost_amt	:= pInput.line[68..76];
		self.judgement_orig_interest_amt		:= pInput.line[77..85];
		self.judgement_orig_atty_fee_amt		:= pInput.line[86..94];
		self.judgement_other_award_orig_amt	:= pInput.line[95..103];
		self.judgement_due_amt							:= pInput.line[104..112];
		self.judgement_due_taxed_cost_amt		:= pInput.line[113..121];
		self.judgement_due_interest_amt			:= pInput.line[122..130];
		self.judgement_due_atty_fee_amt			:= pInput.line[131..139];
		self.judgement_other_award_fee_amt	:= pInput.line[140..148];
		self.judgement_judgement_time				:= pInput.line[169..172];
		self.judgement_docket_date					:= pInput.line[173..180];
		self.judgement_entered_date					:= pInput.line[181..188];
		self.judgement_issue_date						:= pInput.line[189..196];
	END;
	
	EXPORT judgement	:= project(raw(record_type_code = 'B'),xfrmJgmt(left));
	
//Debts per judgement
		Civ_Court.Layouts_In_NJ.debts xfrmDebt(raw pInput)	:= TRANSFORM
		self.report_number							:= pInput.report_number;
		self.venue_id										:= pInput.venue_id;
		self.court_code									:= pInput.court_code;
		self.report_request_number			:= pInput.report_request_number;
		self.docketed_judgement_year		:= pInput.docketed_judgement_year;
		self.docketed_judgement_seq_num	:= pInput.docketed_judgement_seq_num;
		self.docketed_judgement_type_code	:= pInput.docketed_judgement_type_code;
		self.debt_number								:= pInput.debt_number;
		self.record_type_code						:= pInput.record_type_code;
		self.record_type_code1					:= pInput.line[29..29];
		self.docketed_judgement_number	:= pInput.line[30..39];
		self.debt_number1								:= pInput.line[40..42];
		self.devt_status_code						:= pInput.line[43..43];
		self.debt_status_date						:= pInput.line[44..51];
		self.entered_date								:= pInput.line[52..59];
		self.party_orig_amt							:= pInput.line[60..68];
		self.party_orig_taxed_cost_amt	:= pInput.line[69..77];
		self.party_orig_interest_amt		:= pInput.line[78..86];
		self.party_orig_atty_fee_amt		:= pInput.line[87..95];
		self.party_other_award_orig_amt	:= pInput.line[96..104];
		self.party_due_amt							:= pInput.line[105..113];
		self.party_due_taxed_cost_amt		:= pInput.line[114..122];
		self.party_due_interest_amt			:= pInput.line[123..131];
		self.party_due_atty_fee_amt			:= pInput.line[132..140];
		self.party_other_award_due_amt	:= pInput.line[141..148];
		self.debt_comments							:= pInput.line[170..224];
	END;
	
	EXPORT debts	:= project(raw(record_type_code = 'C'),xfrmDebt(left));
	
	//Parties involved in case
	Civ_Court.Layouts_In_NJ.party xfrmParty(raw pInput)	:= TRANSFORM
		self.report_number							:= pInput.report_number;
		self.venue_id										:= pInput.venue_id;
		self.court_code									:= pInput.court_code;
		self.report_request_number			:= pInput.report_request_number;
		self.docketed_judgement_year		:= pInput.docketed_judgement_year;
		self.docketed_judgement_seq_num	:= pInput.docketed_judgement_seq_num;
		self.docketed_judgement_type_code	:= pInput.docketed_judgement_type_code;
		self.debt_number								:= pInput.debt_number;
		self.record_type_code						:= pInput.record_type_code;
		self.party_type_indicator				:= pInput.line[29..29];
		self.party_record_type_code			:= pInput.line[30..30];
		self.party_type_indicator1			:= pInput.line[31..31]; 
		self.docketed_judgement_number	:= pInput.line[32..41];
		self.debt_number1								:= pInput.line[42..43];
		self.party_name									:= pInput.line[44..73];
		self.party_role_type_code				:= pInput.line[74..75];
		self.ptydebt_status_date				:= pInput.line[76..83];
		self.ptydebt_status_code				:= pInput.line[84..85];
		self.atty_firm_last_name				:= pInput.line[86..105];
		self.atty_firm_first_name				:= pInput.line[106..114];
		self.atty_firm_middle_init			:= pInput.line[115..115];
		self.nonatty_comments						:= pInput.line[116..150];
		self.party_initials							:= pInput.line[151..160];
		self.party_street_name					:= pInput.line[161..196];
		self.party_addt_street_name			:= pInput.line[197..232];
		self.party_city_name						:= pInput.line[233..248];
		self.party_state_code						:= pInput.line[249..250];
		self.party_zip_code							:= pInput.line[251..259];
		self.party_affiliation_code			:= pInput.line[260..262];
		self.party_number								:= pInput.line[263..265];
	END;
	
	EXPORT party := project(raw(record_type_code = 'D' and party_type_indicator in ['1','0']),xfrmParty(left));
	
	Civ_Court.Layouts_In_NJ.party_alias xfrmAlias(raw pInput)	:= TRANSFORM
		self.report_number							:= pInput.report_number;
		self.venue_id										:= pInput.venue_id;
		self.court_code									:= pInput.court_code;
		self.report_request_number			:= pInput.report_request_number;
		self.docketed_judgement_year		:= pInput.docketed_judgement_year;
		self.docketed_judgement_seq_num	:= pInput.docketed_judgement_seq_num;
		self.docketed_judgement_type_code	:= pInput.docketed_judgement_type_code;
		self.debt_number								:= pInput.debt_number;
		self.record_type_code						:= pInput.record_type_code;
		self.party_type_indicator				:= pInput.line[29..29];
		self.party_record_type_code			:= pInput.line[30..30];
		self.party_type_indicator1			:= pInput.line[31..31]; 
		self.docketed_judgement_number	:= pInput.line[32..41];
		self.debt_number1								:= pInput.line[42..43];
		self.party_alternate_name				:= pInput.line[44..108];
		self.party_name									:= pInput.line[109..138];
		self.alternate_type_code				:= pInput.line[139..140];
		self.party_number								:= pInput.line[141..143];
	END;
	
	EXPORT party_alias	:= project(raw(record_type_code = 'D' and party_type_indicator ='2'),xfrmAlias(left));
	
	Civ_Court.Layouts_In_NJ.party_guardian xfrmGuardian(raw pInput)	:= TRANSFORM
		self.report_number							:= pInput.report_number;
		self.venue_id										:= pInput.venue_id;
		self.court_code									:= pInput.court_code;
		self.report_request_number			:= pInput.report_request_number;
		self.docketed_judgement_year		:= pInput.docketed_judgement_year;
		self.docketed_judgement_seq_num	:= pInput.docketed_judgement_seq_num;
		self.docketed_judgement_type_code	:= pInput.docketed_judgement_type_code;
		self.debt_number								:= pInput.debt_number;
		self.record_type_code						:= pInput.record_type_code;
		self.party_type_indicator				:= pInput.line[29..29];
		self.party_record_type_code			:= pInput.line[30..30];
		self.party_type_indicator1			:= pInput.line[31..31]; 
		self.docketed_judgement_number	:= pInput.line[32..41];
		self.debt_number1								:= pInput.line[42..43];
		self.party_alternate_name				:= pInput.line[44..73];
		self.party_name									:= pInput.line[74..103];
		self.guardian_affiliation_code	:= pInput.line[104..106];
		self.party_number								:= pInput.line[107..109];
	END;
	
	EXPORT guardian	:= project(raw(record_type_code = 'D' and party_type_indicator ='3'),xfrmGuardian(left));
	
	//Judgement Notes - Currently not used
	Civ_Court.Layouts_In_NJ.jdgmt_notes xfrmNotes(raw pInput)	:= TRANSFORM
		self.report_number							:= pInput.report_number;
		self.venue_id										:= pInput.venue_id;
		self.court_code									:= pInput.court_code;
		self.report_request_number			:= pInput.report_request_number;
		self.docketed_judgement_year		:= pInput.docketed_judgement_year;
		self.docketed_judgement_seq_num	:= pInput.docketed_judgement_seq_num;
		self.docketed_judgement_type_code	:= pInput.docketed_judgement_type_code;
		self.debt_number								:= pInput.debt_number;
		self.record_type_code						:= pInput.record_type_code;
		self.record_type_code1					:= pInput.line[29..29];
		self.docketed_judgement_number	:= pInput.line[30..39];
		self.jdgcomm_comments						:= pInput.line[40..114];
		self.jdg_entered_date						:= pInput.line[115..122];
	END;
	
	EXPORT jdgmt_notes	:= project(raw(record_type_code = 'E'),xfrmNotes(left));
	
END;