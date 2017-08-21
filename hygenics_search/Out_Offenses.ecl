import hygenics_crim,Crim_Common, Corrections,codes, crimsrch, lib_fileservices, doxie_build, PromoteSupers;

fcra_v1 				:= Offenses_Joined(data_type<>'1');

fcra_filtered		:= fcra_v1(vendor in hygenics_search.sCourt_Vendors_To_Omit);
fcra_all				:= fcra_v1(vendor not in hygenics_search.sCourt_Vendors_To_Omit);

//Remove FCRA related information from non-updating sources
	hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory removeInfo(fcra_filtered l):= transform
	  self.fcra_offense_key 							:= '';
		self.fcra_conviction_flag						:= '';
		self.fcra_traffic_flag							:= '';
		self.fcra_date											:= '';
		self.fcra_date_type									:= '';
		self.conviction_override_date				:= '';
		self.conviction_override_date_type	:= '';
		self.offense_score									:= '';
		self 																:= l;
	end;
	
ds_fcra_filtered 	:= project(fcra_filtered, removeInfo(left));
ds_fcra_all			 	:= fcra_all;

all_files			:= ds_fcra_filtered + ds_fcra_all;

hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory addCOPID(all_files l):= transform

	filterField(String s) := FUNCTION
		return StringLib.StringFilter(StringLib.StringToUpperCase(s),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	END;
	
			Varr_date   				:= filterField(l.arr_date );
			Varr_disp_desc_1   	:= filterField(l.arr_disp_desc_1);
			Varr_disp_desc_2   	:= filterField(l.arr_disp_desc_2);
			Varr_off_code   		:= filterField(l.arr_off_code);
			Varr_off_desc_1   	:= filterField(l.arr_off_desc_1);
			Varr_off_desc_2   	:= filterField(l.arr_off_desc_2);
			Varr_off_lev   			:= filterField(l.arr_off_lev);
			Varr_statute   			:= filterField(l.arr_statute);
			//Vcourt_case_number  := filterField(l.court_case_number);
			Vcourt_desc   			:= filterField(l.court_desc);
			Vcourt_disp_date   	:= filterField(l.court_disp_date);
			Vcourt_disp_desc_1  := filterField(l.court_disp_desc_1);
			Vcourt_disp_desc_2  := filterField(l.court_disp_desc_2);
			Vcourt_dt   				:= filterField(l.court_dt);
			Vcourt_off_code   	:= filterField(l.court_off_code);
			Vcourt_off_desc_1   := filterField(l.court_off_desc_1);
			Vcourt_off_lev   		:= filterField(l.court_off_lev);
			Vcourt_statute   		:= filterField(l.court_statute);
			Vcourt_statute_desc := filterField(l.court_statute_desc);
			//Vcty_conv   				:= filterField(l.cty_conv);
			Vle_agency_case_number  := filterField(l.le_agency_case_number);
			Vle_agency_desc   	:= filterField(l.le_agency_desc);
			Vnum_of_counts   		:= filterField(l.num_of_counts);
			Voff_comp   				:= filterField(l.off_comp);
			Voff_date   				:= filterField(l.off_date);
			//Voffense_town				:= filterField(l.offense_town);
			Vsent_addl_prov_desc_1  := filterField(l.sent_addl_prov_desc_1);
			Vsent_addl_prov_desc_2  := filterField(l.sent_addl_prov_desc_2);
			Vsent_agency_rec_cust   := filterField(l.sent_agency_rec_cust);
			Vsent_court_fine   	:= filterField(l.sent_court_fine);
			Vsent_date   				:= filterField(l.sent_date);
			Vsent_jail   				:= filterField(l.sent_jail);
			Vsent_susp_time   	:= filterField(l.sent_susp_time);
			Vtraffic_dl_no   		:= filterField(l.traffic_dl_no);
			Vtraffic_ticket_number  := filterField(l.traffic_ticket_number);
		
		self.offense_persistent_id := if(trim(l.data_type, left, right)='5',
																							hash64(trim(l.offender_key, left, right) +
																								Voff_date +
																								Varr_date + 
																								Varr_off_code +
																								Varr_off_desc_1 +
																								Varr_off_lev +
																								Varr_statute +
																								Vnum_of_counts +
																								Vle_agency_desc +
																								Vcourt_disp_date +
																								Vcourt_disp_desc_1 +
																								Vcourt_disp_desc_2 +
																								Vcourt_dt +
																								Vle_agency_case_number +
																								Varr_disp_desc_1 +
																								Varr_disp_desc_2 +
																								Vsent_agency_rec_cust +
																								//Vaddl_sent_dates +
																								Vcourt_desc +
																								//Vcty_conv +
																								Vsent_court_fine +
																								Vsent_addl_prov_desc_1 +
																								Vsent_addl_prov_desc_2 +
																								Vsent_date),// +
																								//Voffense_town),
																							hash64(trim(l.offender_key, left, right) +
																								Voff_comp +
																								Voff_date +
																								trim(l.court_case_number, left, right) +
																								Vcourt_off_code +
																								Vcourt_off_desc_1 +
																								Vcourt_off_lev +
																								Vcourt_statute +
																								Vcourt_statute_desc +
																								Vnum_of_counts +
																								Vle_agency_desc +
																								Vcourt_disp_date +
																								Vcourt_disp_desc_1 +
																								Vcourt_disp_desc_2 +
																								Vcourt_dt +
																								Vtraffic_ticket_number +
																								Vtraffic_dl_no +
																								Vsent_date +
																								Vsent_jail +
																								Vsent_court_fine +
																								Vsent_addl_prov_desc_1 +
																								Vsent_addl_prov_desc_2 +
																								Vsent_susp_time +
																								Varr_off_desc_1 +
																								Varr_off_desc_2));// +
																								//Voffense_town));
		self.offense_category                   := MAP(l.data_type ='5' and l.arr_off_desc_1   = 'NOT SPECIFIED' => 0,
		                                               l.data_type ='2' and l.court_off_desc_1 = 'NOT SPECIFIED' => 0,
		                                               l.data_type ='5' and l.arr_off_desc_1   <> 'NOT SPECIFIED' => hygenics_crim._fns_offense_category.set_offense_category(stringlib.stringtouppercase(l.arr_off_desc_1)),
		                                               hygenics_crim._fns_offense_category.set_offense_category(stringlib.stringtouppercase(l.court_off_desc_1))
																							 );
		self := l;
	end;

fcra_v1_as_v1 := project(all_files, addCOPID(left));

	PromoteSupers.MAC_SF_BuildProcess(fcra_v1_as_v1,'~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate,aout,2,,true)
			 
export Out_Offenses := aout;	
							