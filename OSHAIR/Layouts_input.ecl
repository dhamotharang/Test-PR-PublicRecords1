Import bipv2;
EXPORT Layouts_input := module

export Accident	:=	record
	string9		summary_nr;
	string7		report_id;
	string16	event_date_time;
	string8		filler;
	string60	event_desc;
	string200	event_keyword;
	string1		const_end_use;
	string4		build_stories;
	string4		nonbuild_ht;
	string1		project_cost;
	string1		project_type;
	string40	sic_list;
	string1		fatality;
	string1		state_flag;
	string80	abstract_text;
end;

export AccidentAbstract	:=	record
	string9		summary_nr;
	string4		line_nr;
	string80	abstract_text;
end;

export AccidentInjury	:=	record
	string9		summary_nr;
	string9		rel_insp_nr;
	string2		age;
	string1		sex;
	string2		nature_of_inj;
	string2		part_of_body;
	string2		src_of_injury;
	string2		event_type;
	string2		evn_factor;
	string2		hum_factor;
	string3		occ_code;
	string1		degree_of_inj;
	string1		task_assigned;
	string4		hazsub;
	string2		const_op;
	string2		const_op_cause;
	string2		fat_cause;
	string4		fall_distance;
	string4		fall_ht;
	string250	injury_line_nr;
end;

export Inspection	:=	record
	string9		activity_nr;
	string7		reporting_id;
	string1		state_flag;
	string50	estab_name;
	string50	site_address;
	string30	site_city;
	string2		site_state;
	string5		site_zip;
	string1		owner_type;
	string4		owner_code;
	string1		adv_notice;
	string1		safety_hlth;
	string4		sic_code;
	string6		naics_code;
	string1		insp_type;
	string1		insp_scope;
	string1		why_no_insp;
	string1		union_status;
	string1		safety_manuf;
	string1		safety_const;
	string1		safety_marit;
	string1		health_manuf;
	string1		health_const;
	string1		health_marit;
	string1		migrant;
	string50	mail_street;
	string30	mail_city;
	string2		mail_state;
	string5		mail_zip;
	string17	host_est_key;
	string5		nr_in_estab;
	string10	open_date;
	string10	case_mod_date;
	string10	close_conf_date;
	string10	close_case_date;
	string4		open_year;
	string4		case_mod_year;
	string4		close_conf_year;
	string4		close_case_year;
	string1		osha_accident_indicator;
	string1		violation_type_s;
	string1		violation_type_o;
	string1		violation_type_r;
	string1		violation_type_u;
	string1		violation_type_w;
	string1		inspection_to_filter;
end;

export OptionalInfo	:=	record
	string9		activity_nr;
	string1		opt_type;
	string2		opt_id;
	string50	opt_value;
	string28	opt_info_id;
end;	

export RelatedActivity	:=	record
	string9		activity_nr;
	string1		rel_type;
	string9		rel_act_nr;
	string1		rel_safety;
	string1		rel_health;
end;

export	StrategicCodes	:=	record
	string9		activity_nr;
	string1		prog_type;
	string25	prog_value;
end;

export	Violation	:=	record
	string9		activity_nr;
	string7		citation_id;
	string1		delete_flag;
	string22	standard;
	string1		viol_type;
	string10	issuance_date;
	string10	abate_date;
	string1		abate_complete;
	string10	current_penalty;
	string10 	initial_penalty;
	string10	contest_date;
	string10	final_order_date;
	string5		nr_instances;
	string5		nr_exposed;
	string1		rec;
	string2		gravity;
	string1		emphasis;
	string10	hazcat;
	string9		fta_insp_nr;
	string8		fta_issuance_date;
	string10	fta_penalty;
	string8		fta_contest_date;
	string8		fta_final_order_date;
	string4		hazsub1;
	string4		hazsub2;
	string4		hazsub3;
	string4		hazsub4;
	string4		hazsub5;
end;

export ViolationEvent	:=	record
	string9		activity_nr;
	string7		citation_id;
	string1		pen_fta;
	string1		hist_event;
	string10	hist_date;
	string10	hist_penalty;
	string10	hist_abate_date;
	string1		hist_vtype;
	string9		hist_insp_nr;
end;

export GenDutyStd	:=	record
	string9		activity_nr;
	string7		citation_id;
	string6		line_nr;
	string80	line_text;
end;

export cleaned_inspection := record
  unsigned4 dt_first_seen						    := 0;
	unsigned4 dt_last_seen						    := 0;
	unsigned4 dt_vendor_first_reported    := 0;
	unsigned4 dt_vendor_last_reported	    := 0;
  bipv2.IDlayouts.l_xlink_ids           ;		  //Added for BIP project
	unsigned8 source_rec_id 					    := 0; //Added for BIP project	
	string2 source 										    := '';
  OSHAIR.layout_OSHAIR_inspection_clean ;
	unsigned8	raw_aid											:= 0; //Added for AID 
	unsigned8	ace_aid										 	:= 0; //Added for AID 
	string100	prep_addr_line1						 	:=''; //Added for AID 
	string50	prep_addr_line_last				 	:=''; //Added for AID 
end; 

end;