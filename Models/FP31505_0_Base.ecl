import easi, Models, risk_indicators, riskwise, std;

bs_with_ip := record
	risk_indicators.Layout_Boca_Shell bs;
	riskwise.Layout_IP2O ip;
end;

export FP31505_0_Base( dataset(bs_with_ip) clam, integer1 num_reasons, boolean criminal, BOOLEAN include_FDN = true ) := FUNCTION

FP_DEBUG := false;
	
Models.Layout_FP31505 doTopLevel(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
	isFCRA := false;
	truedid                          := le.bs.truedid;
	out_unit_desig                   := le.bs.shell_input.unit_desig;
	out_sec_range                    := le.bs.shell_input.sec_range;
	out_z5                           := le.bs.shell_input.z5;
	out_addr_type                    := le.bs.shell_input.addr_type;
	out_addr_status                  := le.bs.shell_input.addr_status;
	in_dob                           := le.bs.shell_input.dob;
	nas_summary                      := le.bs.iid.nas_summary;
	nap_summary                      := le.bs.iid.nap_summary;
	nap_type                         := le.bs.iid.nap_type;
	nap_status                       := le.bs.iid.nap_status;
	rc_ssndod                        := le.bs.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := (integer)le.bs.iid.inputaddrnotmostrecent;
	rc_hriskphoneflag                := (integer)le.bs.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.bs.iid.hphonetypeflag;
	rc_phonevalflag                  := (integer)le.bs.iid.phonevalflag;
	rc_hphonevalflag                 := (integer)le.bs.iid.hphonevalflag;
	rc_pwphonezipflag                := le.bs.iid.pwphonezipflag;
	rc_hriskaddrflag                 := (integer)le.bs.iid.hriskaddrflag;
	rc_decsflag                      := (integer)le.bs.iid.decsflag;
	rc_ssndobflag                    := (integer)le.bs.iid.socsdobflag;
	rc_pwssndobflag                  := (integer)le.bs.iid.pwsocsdobflag;
	rc_ssnvalflag                    := (integer)le.bs.iid.socsvalflag;
	rc_pwssnvalflag                  := le.bs.iid.pwsocsvalflag;
	rc_addrvalflag                   := le.bs.iid.addrvalflag;
	rc_dwelltype                     := le.bs.iid.dwelltype;
	rc_ssnmiskeyflag                 := le.bs.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.bs.iid.addrmiskeyflag;
	rc_addrcommflag                  := (integer)le.bs.iid.addrcommflag;
	rc_hrisksic                      := le.bs.iid.hrisksic;
	rc_hrisksicphone                 := le.bs.iid.hrisksicphone;
	rc_disthphoneaddr                := le.bs.iid.disthphoneaddr;
	rc_phonetype                     := (integer)le.bs.iid.phonetype;
	rc_ziptypeflag                   := (integer)le.bs.iid.ziptypeflag;
	rc_zipclass                      := le.bs.iid.zipclass;
	combo_ssnscore                   := le.bs.iid.combo_ssnscore;
	combo_dobscore                   := le.bs.iid.combo_dobscore;
	hdr_source_profile               := le.bs.source_profile;
	hdr_source_profile_index         := le.bs.source_profile_index;
	ver_sources                      := le.bs.header_summary.ver_sources;
	ver_sources_first_seen           := le.bs.header_summary.ver_sources_first_seen_date;
	bus_addr_match_count             := le.bs.business_header_address_summary.bus_addr_match_cnt;
	bus_name_match                   := le.bs.business_header_address_summary.bus_name_match;
	bus_ssn_match                    := le.bs.business_header_address_summary.bus_ssn_match;
	bus_phone_match                  := le.bs.business_header_address_summary.bus_phone_match;
	fnamepop                         := le.bs.input_validation.firstname;
	lnamepop                         := le.bs.input_validation.lastname;
	addrpop                          := le.bs.input_validation.address;
	ssnlength                        := (integer)le.bs.input_validation.ssn_length;
	dobpop                           := le.bs.input_validation.dateofbirth;
	emailpop                         := le.bs.input_validation.email;
	hphnpop                          := le.bs.input_validation.homephone;
	util_adl_type_list               := le.bs.utility.utili_adl_type;
	util_adl_count                   := le.bs.utility.utili_adl_count;
	util_add_input_type_list         := le.bs.utility.utili_addr1_type;
	util_add_curr_type_list          := le.bs.utility.utili_addr2_type;
	add_input_address_score          := le.bs.address_verification.input_address_information.address_score;
	add_input_house_number_match     := (integer)le.bs.address_verification.input_address_information.house_number_match;
	add_input_isbestmatch            := le.bs.address_verification.input_address_information.isbestmatch;
	add_input_dirty_address          := (integer)le.bs.address_verification.inputaddr_dirty;
	add_input_addr_not_verified      := (integer)le.bs.address_verification.inputAddr_not_verified;
	add_input_owned_not_occ          := (integer)le.bs.address_verification.inputaddr_owned_not_occupied;
	add_input_occ_index              := (integer)le.bs.address_verification.inputaddr_occupancy_index;
	add_input_advo_vacancy           := le.bs.advo_input_addr.Address_Vacancy_Indicator	;
	add_input_advo_throw_back        := le.bs.advo_input_addr.Throw_Back_Indicator	;
	add_input_advo_seasonal          := le.bs.advo_input_addr.Seasonal_Delivery_Indicator;
	add_input_advo_dnd               := le.bs.advo_input_addr.DND_Indicator	;
	add_input_advo_drop              := le.bs.advo_input_addr.Drop_Indicator;
	add_input_advo_res_or_bus        := le.bs.advo_input_addr.Residential_or_Business_Ind	;
	add_input_avm_auto_val           := le.bs.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.bs.address_verification.input_address_information.naprop;
	add_input_mortgage_date          := le.bs.address_verification.input_address_information.mortgage_date;
	add_input_mortgage_type          := le.bs.address_verification.input_address_information.mortgage_type;
	add_input_financing_type         := le.bs.address_verification.input_address_information.type_financing;
	add_input_occupants_1yr          := le.bs.addr_risk_summary.occupants_1yr ;
	add_input_turnover_1yr_in        := le.bs.addr_risk_summary.turnover_1yr_in ;
	add_input_turnover_1yr_out       := le.bs.addr_risk_summary.turnover_1yr_out ;
	add_input_nhood_vac_prop         := le.bs.addr_risk_summary.N_Vacant_Properties;
	add_input_nhood_bus_ct           := le.bs.addr_risk_summary.N_Business_Count ;
	add_input_nhood_sfd_ct           := le.bs.addr_risk_summary.N_SFD_Count ;
	add_input_nhood_mfd_ct           := le.bs.addr_risk_summary.N_MFD_Count;
	add_input_pop                    := le.bs.addrPop;
	property_owned_total             := le.bs.address_verification.owned.property_total;
	add_curr_isbestmatch             := le.bs.address_verification.address_history_1.isbestmatch;
	add_curr_lres                    := le.bs.lres2;
	add_curr_occ_index               := (integer)le.bs.address_verification.currAddr_occupancy_index;
	add_curr_advo_vacancy            := le.bs.advo_addr_hist1.Address_Vacancy_Indicator	;
	add_curr_advo_throw_back         := le.bs.advo_addr_hist1.Throw_Back_Indicator	;
	add_curr_advo_seasonal           := le.bs.advo_addr_hist1.Seasonal_Delivery_Indicator;
	add_curr_advo_drop               := le.bs.advo_addr_hist1.Drop_Indicator;
	add_curr_advo_res_or_bus         := le.bs.advo_addr_hist1.Residential_or_Business_Ind	;
	add_curr_avm_auto_val            := le.bs.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := le.bs.avm.address_history_1.avm_automated_valuation2;
	add_curr_naprop                  := le.bs.address_verification.address_history_1.naprop;
	add_curr_mortgage_date           := le.bs.address_verification.address_history_1.mortgage_date;
	add_curr_mortgage_type           := le.bs.address_verification.address_history_1.mortgage_type;
	add_curr_financing_type          := le.bs.address_verification.address_history_1.type_financing;
	add_curr_hr_address              := (integer)le.bs.address_verification.address_history_1.hr_address;
	add_curr_occupants_1yr           := le.bs.addr_risk_summary2.occupants_1yr ;
	add_curr_turnover_1yr_in         := le.bs.addr_risk_summary2.turnover_1yr_in ;
	add_curr_turnover_1yr_out        := le.bs.addr_risk_summary2.turnover_1yr_out ;
	add_curr_nhood_vac_prop          := le.bs.addr_risk_summary2.N_Vacant_Properties;
	add_curr_nhood_bus_ct            := le.bs.addr_risk_summary2.N_Business_Count ;
	add_curr_nhood_sfd_ct            := le.bs.addr_risk_summary2.N_SFD_Count ;
	add_curr_nhood_mfd_ct            := le.bs.addr_risk_summary2.N_MFD_Count;
	add_curr_pop                     := le.bs.addrPop2;
	add_prev_naprop                  := le.bs.address_verification.address_history_2.naprop;
	max_lres                         := le.bs.other_address_info.max_lres;
	addrs_5yr                        := le.bs.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.bs.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.bs.other_address_info.addrs_last_15years;
	addrs_prison_history             := (integer)le.bs.other_address_info.isprison;
	telcordia_type                   := le.bs.phone_verification.telcordia_type;
	recent_disconnects               := if(isFCRA, 0, le.bs.phone_verification.recent_disconnects);
	phone_ver_insurance              := le.bs.insurance_phones_summary.Insurance_Phone_Verification;
	phone_ver_experian               := le.bs.Experian_Phone_Verification;
	header_first_seen                := le.bs.ssn_verification.header_first_seen;
	inputssncharflag                 := le.bs.ssn_verification.validation.inputsocscharflag;
	ssns_per_adl                     := le.bs.velocity_counters.ssns_per_adl;
	adls_per_ssn                     := le.bs.ssn_verification.adlperssn_count;	//kh-changed to ssn_verification
	// adls_per_ssn                     := le.bs.velocity_counters.adlperssn_count;
	addrs_per_ssn                    := if(isFCRA, 0, le.bs.velocity_counters.addrs_per_ssn );
	adls_per_addr_curr               := le.bs.velocity_counters.adls_per_addr_current;
	phones_per_addr_curr             := le.bs.velocity_counters.phones_per_addr_current;
	ssns_per_adl_c6                  := le.bs.velocity_counters.ssns_per_adl_created_6months;
	addrs_per_adl_c6                 := le.bs.velocity_counters.addrs_per_adl_created_6months;
	lnames_per_adl_c6                := if(isFCRA, 0, le.bs.velocity_counters.lnames_per_adl180);
	addrs_per_ssn_c6                 := if(isFCRA, 0, le.bs.velocity_counters.addrs_per_ssn_created_6months );
	adls_per_addr_c6                 := le.bs.velocity_counters.adls_per_addr_created_6months;
	phones_per_addr_c6               := if(isFCRA, 0, le.bs.velocity_counters.phones_per_addr_created_6months );
	adls_per_phone_c6                := if(isFCRA, 0, le.bs.velocity_counters.adls_per_phone_created_6months );
	dl_addrs_per_adl                 := le.bs.velocity_counters.dl_addrs_per_adl;
	invalid_phones_per_adl           := le.bs.velocity_counters.invalid_phones_per_adl;
	invalid_phones_per_adl_c6        := le.bs.velocity_counters.invalid_phones_per_adl_created_6months;
	invalid_ssns_per_adl             := le.bs.velocity_counters.invalid_ssns_per_adl;
	invalid_ssns_per_adl_c6          := le.bs.velocity_counters.invalid_ssns_per_adl_created_6months;
	invalid_addrs_per_adl            := le.bs.velocity_counters.invalid_addrs_per_adl;
	invalid_addrs_per_adl_c6         := le.bs.velocity_counters.invalid_addrs_per_adl_created_6months;
	inq_email_ver_count              := le.bs.acc_logs.inquiry_email_ver_ct;
	inq_count                        := le.bs.acc_logs.inquiries.counttotal;
	inq_count_day                    := if(isFCRA, 0, le.bs.acc_logs.inquiries.countday);
	inq_count_week                   := if(isFCRA, 0, le.bs.acc_logs.inquiries.countweek);
	inq_count01                      := le.bs.acc_logs.inquiries.count01;
	inq_count03                      := le.bs.acc_logs.inquiries.count03;
	inq_count06                      := le.bs.acc_logs.inquiries.count06;
	inq_count12                      := le.bs.acc_logs.inquiries.count12;
	inq_count24                      := le.bs.acc_logs.inquiries.count24;
	inq_auto_count                   := le.bs.acc_logs.auto.counttotal;
	inq_auto_count_day               := if(isFCRA, 0, le.bs.acc_logs.auto.countday);
	inq_auto_count_week              := if(isFCRA, 0, le.bs.acc_logs.auto.countweek);
	inq_auto_count01                 := le.bs.acc_logs.auto.count01;
	inq_auto_count03                 := le.bs.acc_logs.auto.count03;
	inq_auto_count06                 := le.bs.acc_logs.auto.count06;
	inq_auto_count12                 := le.bs.acc_logs.auto.count12;
	inq_auto_count24                 := le.bs.acc_logs.auto.count24;
	inq_banking_count                := le.bs.acc_logs.banking.counttotal;
	inq_banking_count_day            := if(isFCRA, 0, le.bs.acc_logs.banking.countday);
	inq_banking_count_week           := if(isFCRA, 0, le.bs.acc_logs.banking.countweek);
	inq_banking_count01              := le.bs.acc_logs.banking.count01;
	inq_banking_count03              := le.bs.acc_logs.banking.count03;
	inq_banking_count06              := le.bs.acc_logs.banking.count06;
	inq_banking_count12              := le.bs.acc_logs.banking.count12;
	inq_banking_count24              := le.bs.acc_logs.banking.count24;
	inq_collection_count             := le.bs.acc_logs.collection.counttotal;
	inq_collection_count_day         := if(isFCRA, 0, le.bs.acc_logs.collection.countday);
	inq_collection_count_week        := if(isFCRA, 0, le.bs.acc_logs.collection.countweek);
	inq_collection_count01           := le.bs.acc_logs.collection.count01;
	inq_collection_count03           := le.bs.acc_logs.collection.count03;
	inq_collection_count06           := le.bs.acc_logs.collection.count06;
	inq_collection_count12           := le.bs.acc_logs.collection.count12;
	inq_collection_count24           := le.bs.acc_logs.collection.count24;
	inq_communications_count         := le.bs.acc_logs.communications.counttotal;
	inq_communications_count_day     := if(isFCRA, 0, le.bs.acc_logs.communications.countday);
	inq_communications_count_week    := if(isFCRA, 0, le.bs.acc_logs.communications.countweek);
	inq_communications_count01       := le.bs.acc_logs.communications.count01;
	inq_communications_count03       := le.bs.acc_logs.communications.count03;
	inq_communications_count06       := le.bs.acc_logs.communications.count06;
	inq_communications_count12       := le.bs.acc_logs.communications.count12;
	inq_communications_count24       := le.bs.acc_logs.communications.count24;
	inq_highriskcredit_count         := le.bs.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count_day     := if(isFCRA, 0, le.bs.acc_logs.highriskcredit.countday);
	inq_highriskcredit_count_week    := if(isFCRA, 0, le.bs.acc_logs.highriskcredit.countweek);
	inq_highriskcredit_count01       := le.bs.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.bs.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.bs.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.bs.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.bs.acc_logs.highriskcredit.count24;
	inq_mortgage_count               := le.bs.acc_logs.mortgage.counttotal;
	inq_mortgage_count_day           := if(isFCRA, 0, le.bs.acc_logs.mortgage.countday);
	inq_mortgage_count_week          := if(isFCRA, 0, le.bs.acc_logs.mortgage.countweek);
	inq_mortgage_count01             := le.bs.acc_logs.mortgage.count01;
	inq_mortgage_count03             := le.bs.acc_logs.mortgage.count03;
	inq_mortgage_count06             := le.bs.acc_logs.mortgage.count06;
	inq_mortgage_count12             := le.bs.acc_logs.mortgage.count12;
	inq_mortgage_count24             := le.bs.acc_logs.mortgage.count24;
	inq_other_count                  := le.bs.acc_logs.other.counttotal;
	inq_other_count_day              := if(isFCRA, 0, le.bs.acc_logs.other.countday);
	inq_other_count_week             := if(isFCRA, 0, le.bs.acc_logs.other.countweek);
	inq_other_count24                := le.bs.acc_logs.other.count24;
	inq_prepaidcards_count           := le.bs.acc_logs.prepaidcards.counttotal;
	inq_prepaidcards_count_day       := if(isFCRA, 0, le.bs.acc_logs.prepaidCards.countday);
	inq_prepaidcards_count_week      := if(isFCRA, 0, le.bs.acc_logs.prepaidCards.countweek);
	inq_prepaidcards_count01         := le.bs.acc_logs.prepaidcards.count01;
	inq_prepaidcards_count03         := le.bs.acc_logs.prepaidcards.count03;
	inq_prepaidcards_count06         := le.bs.acc_logs.prepaidcards.count06;
	inq_prepaidcards_count12         := le.bs.acc_logs.prepaidcards.count12;
	inq_prepaidcards_count24         := le.bs.acc_logs.prepaidcards.count24;
	inq_quizprovider_count           := le.bs.acc_logs.quizprovider.counttotal;
	inq_quizprovider_count_day       := if(isFCRA, 0, le.bs.acc_logs.QuizProvider.countday);
	inq_quizprovider_count_week      := if(isFCRA, 0, le.bs.acc_logs.QuizProvider.countweek);
	inq_quizprovider_count24         := le.bs.acc_logs.quizprovider.count24;
	inq_retail_count                 := le.bs.acc_logs.retail.counttotal;
	inq_retail_count_day             := if(isFCRA, 0, le.bs.acc_logs.retail.countday);
	inq_retail_count_week            := if(isFCRA, 0, le.bs.acc_logs.retail.countweek);
	inq_retail_count01               := le.bs.acc_logs.retail.count01;
	inq_retail_count03               := le.bs.acc_logs.retail.count03;
	inq_retail_count06               := le.bs.acc_logs.retail.count06;
	inq_retail_count12               := le.bs.acc_logs.retail.count12;
	inq_retail_count24               := le.bs.acc_logs.retail.count24;
	inq_retailpayments_count         := le.bs.acc_logs.retailpayments.counttotal;
	inq_retailpayments_count_day     := if(isFCRA, 0, le.bs.acc_logs.retailPayments.countday);
	inq_retailpayments_count_week    := if(isFCRA, 0, le.bs.acc_logs.retailPayments.countweek);
	inq_retailpayments_count01       := le.bs.acc_logs.retailpayments.count01;
	inq_retailpayments_count03       := le.bs.acc_logs.retailpayments.count03;
	inq_retailpayments_count06       := le.bs.acc_logs.retailpayments.count06;
	inq_retailpayments_count12       := le.bs.acc_logs.retailpayments.count12;
	inq_retailpayments_count24       := le.bs.acc_logs.retailpayments.count24;
	inq_studentloan_count            := le.bs.acc_logs.studentloans.counttotal;
	inq_studentloan_count_day        := if(isFCRA, 0, le.bs.acc_logs.StudentLoans.countday);
	inq_studentloan_count_week       := if(isFCRA, 0, le.bs.acc_logs.StudentLoans.countweek);
	inq_studentloan_count01          := le.bs.acc_logs.studentloans.count01;
	inq_studentloan_count03          := le.bs.acc_logs.studentloans.count03;
	inq_studentloan_count06          := le.bs.acc_logs.studentloans.count06;
	inq_studentloan_count12          := le.bs.acc_logs.studentloans.count12;
	inq_studentloan_count24          := le.bs.acc_logs.studentloans.count24;
	inq_utilities_count              := le.bs.acc_logs.utilities.counttotal;
	inq_utilities_count_day          := if(isFCRA, 0, le.bs.acc_logs.Utilities.countday);
	inq_utilities_count_week         := if(isFCRA, 0, le.bs.acc_logs.Utilities.countweek);
	inq_utilities_count01            := le.bs.acc_logs.utilities.count01;
	inq_utilities_count03            := le.bs.acc_logs.utilities.count03;
	inq_utilities_count06            := le.bs.acc_logs.utilities.count06;
	inq_utilities_count12            := le.bs.acc_logs.utilities.count12;
	inq_utilities_count24            := le.bs.acc_logs.utilities.count24;
	inq_billgroup_count              := le.bs.acc_logs.inq_billgroup_count;
	inq_billgroup_count24            := le.bs.acc_logs.inq_billgroup_count24;
	inq_perssn                       := if(isFCRA, 0, le.bs.acc_logs.inquiryPerSSN );
	inq_adlsperssn                   := if(isFCRA, 0, le.bs.acc_logs.inquiryADLsPerSSN );
	inq_lnamesperssn                 := if(isFCRA, 0, le.bs.acc_logs.inquiryLNamesPerSSN );
	inq_addrsperssn                  := if(isFCRA, 0, le.bs.acc_logs.inquiryAddrsPerSSN );
	inq_dobsperssn                   := if(isFCRA, 0, le.bs.acc_logs.inquiryDOBsPerSSN );
	inq_peraddr                      := if(isFCRA, 0, le.bs.acc_logs.inquiryPerAddr );
	inq_adlsperaddr                  := if(isFCRA, 0, le.bs.acc_logs.inquiryADLsPerAddr );
	inq_lnamesperaddr                := if(isFCRA, 0, le.bs.acc_logs.inquiryLNamesPerAddr );
	inq_ssnsperaddr                  := if(isFCRA, 0, le.bs.acc_logs.inquirySSNsPerAddr );
	inq_perphone                     := if(isFCRA, 0, le.bs.acc_logs.inquiryPerPhone );
	inq_adlsperphone                 := if(isFCRA, 0, le.bs.acc_logs.inquiryADLsPerPhone );
	inq_email_per_adl                := le.bs.acc_logs.inquiryemailsperadl;
	inq_adls_per_email               := if(isFCRA, 0, le.bs.acc_logs.inquiryADLsPerEmail );
	inq_banko_am_first_seen          := le.bs.acc_logs.am_first_seen_date;
	inq_banko_am_last_seen           := le.bs.acc_logs.am_last_seen_date;
	inq_banko_cm_first_seen          := le.bs.acc_logs.cm_first_seen_date;
	inq_banko_cm_last_seen           := le.bs.acc_logs.cm_last_seen_date;
	inq_banko_om_first_seen          := le.bs.acc_logs.om_first_seen_date;
	inq_banko_om_last_seen           := le.bs.acc_logs.om_last_seen_date;
	pb_number_of_sources             := le.bs.ibehavior.number_of_sources;
	pb_average_days_bt_orders        := le.bs.ibehavior.average_days_between_orders;
	pb_average_dollars               := le.bs.ibehavior.average_amount_per_order;
	pb_total_dollars                 := le.bs.ibehavior.total_dollars;
	pb_total_orders                  := le.bs.ibehavior.total_number_of_orders;
	br_source_count                  := le.bs.employment.source_ct;
	infutor_nap                      := le.bs.infutor_phone.infutor_nap;	//kh-corrected
	stl_inq_count                    := le.bs.impulse.count;
	stl_inq_count90                  := le.bs.impulse.count90;
	stl_inq_count180                 := le.bs.impulse.count180;
	stl_inq_count12                  := le.bs.impulse.count12;
	stl_inq_count24                  := le.bs.impulse.count24;
	email_count                      := le.bs.email_summary.email_ct;
	email_domain_free_count          := le.bs.email_summary.email_domain_free_ct;
	email_domain_isp_count           := le.bs.email_summary.email_domain_isp_ct;
	email_verification     					 := (integer)le.bs.email_summary.identity_email_verification_level;
	email_name_addr_verification     := le.bs.email_summary.reverse_email.verification_level;
	adl_per_email                    := le.bs.email_summary.reverse_email.adls_per_email;
	attr_num_aircraft                := le.bs.aircraft.aircraft_count;
	attr_total_number_derogs         := le.bs.total_number_derogs;
	attr_arrests                     := le.bs.bjl.arrests_count;
	attr_arrests30                   := le.bs.bjl.arrests_count30;
	attr_arrests90                   := le.bs.bjl.arrests_count90;
	attr_arrests180                  := le.bs.bjl.arrests_count180;
	attr_arrests12                   := le.bs.bjl.arrests_count12;
	attr_arrests24                   := le.bs.bjl.arrests_count24;
	attr_arrests36                   := le.bs.bjl.arrests_count36;
	attr_arrests60                   := le.bs.bjl.arrests_count60;
	attr_num_unrel_liens60           := le.bs.bjl.liens_unreleased_count60;
	attr_bankruptcy_count30          := le.bs.bjl.bk_count30;
	attr_bankruptcy_count90          := le.bs.bjl.bk_count90;
	attr_bankruptcy_count180         := le.bs.bjl.bk_count180;
	attr_bankruptcy_count12          := le.bs.bjl.bk_count12;
	attr_bankruptcy_count24          := le.bs.bjl.bk_count24;
	attr_bankruptcy_count36          := le.bs.bjl.bk_count36;
	attr_bankruptcy_count60          := le.bs.bjl.bk_count60;
	attr_eviction_count              := le.bs.bjl.eviction_count;
	attr_eviction_count90            := le.bs.bjl.eviction_count90;
	attr_eviction_count180           := le.bs.bjl.eviction_count180;
	attr_eviction_count12            := le.bs.bjl.eviction_count12;
	attr_eviction_count24            := le.bs.bjl.eviction_count24;
	attr_eviction_count36            := le.bs.bjl.eviction_count36;
	attr_eviction_count60            := le.bs.bjl.eviction_count60;
	attr_num_nonderogs               := le.bs.source_verification.num_nonderogs;
	attr_num_nonderogs90             := le.bs.source_verification.num_nonderogs90;
	attr_num_nonderogs180            := le.bs.source_verification.num_nonderogs180;
	attr_num_nonderogs12             := le.bs.source_verification.num_nonderogs12;
	attr_num_nonderogs24             := le.bs.source_verification.num_nonderogs24;
	attr_num_nonderogs36             := le.bs.source_verification.num_nonderogs36;
	attr_num_nonderogs60             := le.bs.source_verification.num_nonderogs60;
	vf_hi_risk_ct                    := (integer)le.bs.virtual_fraud.hi_risk_ct;
	vf_lo_risk_ct                    := (integer)le.bs.virtual_fraud.lo_risk_ct;
	vf_lexid_phone_hi_risk_ct        := le.bs.virtual_fraud.lexid_phone_hi_risk_ct;
	vf_lexid_phone_lo_risk_ct        := le.bs.virtual_fraud.lexid_phone_lo_risk_ct;
	vf_altlexid_phone_hi_risk_ct     := le.bs.virtual_fraud.altlexid_phone_hi_risk_ct;
	vf_altlexid_phone_lo_risk_ct     := le.bs.virtual_fraud.altlexid_phone_lo_risk_ct;
	vf_lexid_addr_hi_risk_ct         := le.bs.virtual_fraud.lexid_addr_hi_risk_ct;
	vf_lexid_addr_lo_risk_ct         := le.bs.virtual_fraud.lexid_addr_lo_risk_ct;
	vf_altlexid_addr_hi_risk_ct      := le.bs.virtual_fraud.altlexid_addr_hi_risk_ct;
	vf_altlexid_addr_lo_risk_ct      := le.bs.virtual_fraud.altlexid_addr_lo_risk_ct;
	vf_lexid_ssn_hi_risk_ct          := le.bs.virtual_fraud.lexid_ssn_hi_risk_ct;
	vf_lexid_ssn_lo_risk_ct          := le.bs.virtual_fraud.lexid_ssn_lo_risk_ct;
	vf_altlexid_ssn_hi_risk_ct       := le.bs.virtual_fraud.altlexid_ssn_hi_risk_ct;
	vf_altlexid_ssn_lo_risk_ct       := le.bs.virtual_fraud.altlexid_ssn_lo_risk_ct;
	fp_idrisktype                    := le.bs.fdattributesv2.identityrisklevel;
	fp_idverrisktype                 := le.bs.fdattributesv2.idverrisklevel;
	fp_sourcerisktype                := le.bs.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.bs.fdattributesv2.variationrisklevel;
	fp_varmsrcssncount               := le.bs.fdattributesv2.variationmsourcesssncount;
	fp_varmsrcssnunrelcount          := le.bs.fdattributesv2.variationmsourcesssnunrelcount;
	fp_vardobcount                   := le.bs.fdattributesv2.variationdobcount;
	fp_vardobcountnew                := le.bs.fdattributesv2.variationdobcountnew;
	fp_srchvelocityrisktype          := le.bs.fdattributesv2.searchvelocityrisklevel;
	fp_srchcountwk                   := le.bs.fdattributesv2.searchcountweek;
	fp_srchcountday                  := le.bs.fdattributesv2.searchcountday;
	fp_srchunvrfdssncount            := le.bs.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfdaddrcount           := le.bs.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfddobcount            := le.bs.fdattributesv2.searchunverifieddobcountyear;
	fp_srchunvrfdphonecount          := le.bs.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcount            := le.bs.fdattributesv2.searchfraudsearchcount;
	fp_srchfraudsrchcountyr          := le.bs.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcountmo          := le.bs.fdattributesv2.searchfraudsearchcountmonth;
	fp_srchfraudsrchcountwk          := le.bs.fdattributesv2.searchfraudsearchcountweek;
	fp_srchfraudsrchcountday         := le.bs.fdattributesv2.searchfraudsearchcountday;
	fp_srchlocatesrchcountwk         := le.bs.fdattributesv2.searchlocatesearchcountweek;
	fp_srchlocatesrchcountday        := le.bs.fdattributesv2.searchlocatesearchcountday;
	fp_assocrisktype                 := le.bs.fdattributesv2.assocrisklevel;
	fp_assocsuspicousidcount         := le.bs.fdattributesv2.assocsuspicousidentitiescount;
	fp_assoccredbureaucount          := le.bs.fdattributesv2.assoccreditbureauonlycount;
	fp_assoccredbureaucountnew       := le.bs.fdattributesv2.assoccreditbureauonlycountnew;
	fp_assoccredbureaucountmo        := le.bs.fdattributesv2.assoccreditbureauonlycountmonth;
	fp_validationrisktype            := le.bs.fdattributesv2.validationrisklevel;
	fp_corrrisktype                  := le.bs.fdattributesv2.correlationrisklevel;
	fp_corrssnnamecount              := le.bs.fdattributesv2.correlationssnnamecount;
	fp_corrssnaddrcount              := le.bs.fdattributesv2.correlationssnaddrcount;
	fp_corraddrnamecount             := le.bs.fdattributesv2.correlationaddrnamecount;
	fp_corraddrphonecount            := le.bs.fdattributesv2.correlationaddrphonecount;
	fp_corrphonelastnamecount        := le.bs.fdattributesv2.correlationphonelastnamecount;
	fp_divrisktype                   := le.bs.fdattributesv2.divrisklevel;
	fp_divssnidmsrcurelcount         := le.bs.fdattributesv2.divssnidentitymsourceurelcount;
	fp_divaddrsuspidcountnew         := le.bs.fdattributesv2.divaddrsuspidentitycountnew;
	fp_divsrchaddrsuspidcount        := le.bs.fdattributesv2.divsearchaddrsuspidentitycount;
	fp_srchcomponentrisktype         := le.bs.fdattributesv2.searchcomponentrisklevel;
	fp_srchssnsrchcount              := le.bs.fdattributesv2.searchssnsearchcount;
	fp_srchssnsrchcountmo            := le.bs.fdattributesv2.searchssnsearchcountmonth;
	fp_srchssnsrchcountwk            := le.bs.fdattributesv2.searchssnsearchcountweek;
	fp_srchssnsrchcountday           := le.bs.fdattributesv2.searchssnsearchcountday;
	fp_srchaddrsrchcount             := le.bs.fdattributesv2.searchaddrsearchcount;
	fp_srchaddrsrchcountmo           := le.bs.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchaddrsrchcountwk           := le.bs.fdattributesv2.searchaddrsearchcountweek;
	fp_srchaddrsrchcountday          := le.bs.fdattributesv2.searchaddrsearchcountday;
	fp_srchphonesrchcount            := le.bs.fdattributesv2.searchphonesearchcount;
	fp_srchphonesrchcountmo          := le.bs.fdattributesv2.searchphonesearchcountmonth;
	fp_srchphonesrchcountwk          := le.bs.fdattributesv2.searchphonesearchcountweek;
	fp_srchphonesrchcountday         := le.bs.fdattributesv2.searchphonesearchcountday;
	fp_componentcharrisktype         := le.bs.fdattributesv2.componentcharrisklevel;
	fp_inputaddractivephonelist      := le.bs.fdattributesv2.inputaddractivephonelist;
	fp_addrchangeincomediff          := le.bs.fdattributesv2.addrchangeincomediff;
	fp_addrchangevaluediff           := le.bs.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff           := le.bs.fdattributesv2.addrchangecrimediff;
	fp_addrchangeecontrajindex       := le.bs.fdattributesv2.addrchangeecontrajectoryindex;
	fp_curraddractivephonelist       := le.bs.fdattributesv2.curraddractivephonelist;
	fp_curraddrmedianincome          := le.bs.fdattributesv2.curraddrmedianincome;
	fp_curraddrmedianvalue           := le.bs.fdattributesv2.curraddrmedianvalue;
	fp_curraddrmurderindex           := le.bs.fdattributesv2.curraddrmurderindex;
	fp_curraddrcartheftindex         := le.bs.fdattributesv2.curraddrcartheftindex;
	fp_curraddrburglaryindex         := le.bs.fdattributesv2.curraddrburglaryindex;
	fp_curraddrcrimeindex            := le.bs.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrageoldest             := le.bs.fdattributesv2.prevaddrageoldest;
	fp_prevaddrlenofres              := le.bs.fdattributesv2.prevaddrlenofres;
	fp_prevaddrdwelltype             := le.bs.fdattributesv2.prevaddrdwelltype;
	fp_prevaddrstatus                := le.bs.fdattributesv2.prevaddrstatus;
	fp_prevaddroccupantowned         := le.bs.fdattributesv2.prevaddroccupantowned;
	fp_prevaddrmedianincome          := le.bs.fdattributesv2.prevaddrmedianincome;
	fp_prevaddrmedianvalue           := le.bs.fdattributesv2.prevaddrmedianvalue;
	fp_prevaddrmurderindex           := le.bs.fdattributesv2.prevaddrmurderindex;
	fp_prevaddrcartheftindex         := le.bs.fdattributesv2.prevaddrcartheftindex;
	fp_prevaddrburglaryindex         := le.bs.fdattributesv2.prevaddrburglaryindex;
	fp_prevaddrcrimeindex            := le.bs.fdattributesv2.prevaddrcrimeindex;
	bankrupt                         := (integer)le.bs.bjl.bankrupt;
	disposition                      := le.bs.bjl.disposition;
	filing_count                     := le.bs.bjl.filing_count;
	bk_dismissed_recent_count        := le.bs.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bs.bjl.bk_dismissed_historical_count;
	bk_chapter                       := le.bs.bjl.bk_chapter;
	bk_disposed_recent_count         := le.bs.bjl.bk_disposed_recent_count;
	bk_disposed_historical_count     := le.bs.bjl.bk_disposed_historical_count;
	liens_recent_unreleased_count    := le.bs.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bs.bjl.liens_historical_unreleased_count;
	liens_unrel_cj_first_seen        := le.bs.liens.liens_unreleased_civil_judgment.earliest_filing_date;
	liens_unrel_cj_last_seen         := le.bs.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_cj_total_amount      := le.bs.liens.liens_unreleased_civil_judgment.total_amount;
	liens_rel_cj_first_seen          := le.bs.liens.liens_released_civil_judgment.earliest_filing_date;
	liens_rel_cj_last_seen           := le.bs.liens.liens_released_civil_judgment.most_recent_filing_date;
	liens_rel_cj_total_amount        := le.bs.liens.liens_released_civil_judgment.total_amount;
	liens_unrel_ft_first_seen        := le.bs.liens.liens_unreleased_federal_tax.earliest_filing_date;
	liens_unrel_ft_last_seen         := le.bs.liens.liens_unreleased_federal_tax.most_recent_filing_date;
	liens_unrel_ft_total_amount      := le.bs.liens.liens_unreleased_federal_tax.total_amount;
	liens_rel_ft_first_seen          := le.bs.liens.liens_released_federal_tax.earliest_filing_date;
	liens_rel_ft_last_seen           := le.bs.liens.liens_released_federal_tax.most_recent_filing_date;
	liens_rel_ft_total_amount        := le.bs.liens.liens_released_federal_tax.total_amount;
	liens_unrel_fc_first_seen        := le.bs.liens.liens_unreleased_foreclosure.earliest_filing_date;
	liens_unrel_fc_last_seen         := le.bs.liens.liens_unreleased_foreclosure.most_recent_filing_date;
	liens_unrel_fc_total_amount      := le.bs.liens.liens_unreleased_foreclosure.total_amount;
	liens_rel_fc_first_seen          := le.bs.liens.liens_released_foreclosure.earliest_filing_date;
	liens_rel_fc_last_seen           := le.bs.liens.liens_released_foreclosure.most_recent_filing_date;
	liens_rel_fc_total_amount        := le.bs.liens.liens_released_foreclosure.total_amount;
	liens_unrel_lt_first_seen        := le.bs.liens.liens_unreleased_landlord_tenant.earliest_filing_date;
	liens_unrel_lt_last_seen         := le.bs.liens.liens_unreleased_landlord_tenant.most_recent_filing_date;
	liens_rel_lt_first_seen          := le.bs.liens.liens_released_landlord_tenant.earliest_filing_date;
	liens_rel_lt_last_seen           := le.bs.liens.liens_released_landlord_tenant.most_recent_filing_date;
	liens_unrel_o_first_seen         := le.bs.liens.liens_unreleased_other_lj.earliest_filing_date;
	liens_unrel_o_last_seen          := le.bs.liens.liens_unreleased_other_lj.most_recent_filing_date;
	liens_unrel_o_total_amount       := le.bs.liens.liens_unreleased_other_lj.total_amount;
	liens_rel_o_first_seen           := le.bs.liens.liens_released_other_lj.earliest_filing_date;
	liens_rel_o_last_seen            := le.bs.liens.liens_released_other_lj.most_recent_filing_date;
	liens_rel_o_total_amount         := le.bs.liens.liens_released_other_lj.total_amount;
	liens_unrel_ot_first_seen        := le.bs.liens.liens_unreleased_other_tax.earliest_filing_date;
	liens_unrel_ot_last_seen         := le.bs.liens.liens_unreleased_other_tax.most_recent_filing_date;
	liens_unrel_ot_total_amount      := le.bs.liens.liens_unreleased_other_tax.total_amount;
	liens_rel_ot_first_seen          := le.bs.liens.liens_released_other_tax.earliest_filing_date;
	liens_rel_ot_last_seen           := le.bs.liens.liens_released_other_tax.most_recent_filing_date;
	liens_rel_ot_total_amount        := le.bs.liens.liens_released_other_tax.total_amount;
	liens_unrel_sc_first_seen        := le.bs.liens.liens_unreleased_small_claims.earliest_filing_date;
	liens_unrel_sc_last_seen         := le.bs.liens.liens_unreleased_small_claims.most_recent_filing_date;
	liens_unrel_sc_total_amount      := le.bs.liens.liens_unreleased_small_claims.total_amount;
	liens_rel_sc_first_seen          := le.bs.liens.liens_released_small_claims.earliest_filing_date;
	liens_rel_sc_last_seen           := le.bs.liens.liens_released_small_claims.most_recent_filing_date;
	liens_rel_sc_total_amount        := le.bs.liens.liens_released_small_claims.total_amount;
	liens_unrel_st_ct                := le.bs.liens.liens_unreleased_suits.count;
	liens_unrel_st_first_seen        := le.bs.liens.liens_unreleased_suits.earliest_filing_date;
	liens_unrel_st_last_seen         := le.bs.liens.liens_unreleased_suits.most_recent_filing_date;
	liens_unrel_st_total_amount      := le.bs.liens.liens_unreleased_suits.total_amount;
	liens_rel_st_ct                  := le.bs.liens.liens_released_suits.count;
	liens_rel_st_first_seen          := le.bs.liens.liens_released_suits.earliest_filing_date;
	liens_rel_st_last_seen           := le.bs.liens.liens_released_suits.most_recent_filing_date;
	liens_rel_st_total_amount        := le.bs.liens.liens_released_suits.total_amount;
	criminal_count                   := le.bs.bjl.criminal_count;
	criminal_last_date               := le.bs.bjl.last_criminal_date;
	felony_count                     := le.bs.bjl.felony_count;
	felony_last_date                 := le.bs.bjl.last_felony_date;
	foreclosure_flag                 := (integer)le.bs.bjl.foreclosure_flag;
	foreclosure_last_date            := le.bs.bjl.last_foreclosure_date;
	hh_members_ct                    := le.bs.hhid_summary.hh_members_ct;
	hh_property_owners_ct            := le.bs.hhid_summary.hh_property_owners_ct;
	hh_age_65_plus                   := le.bs.hhid_summary.hh_age_65_plus;
	hh_age_30_to_65                  := le.bs.hhid_summary.hh_age_31_to_65;
	hh_age_18_to_30                  := le.bs.hhid_summary.hh_age_18_to_30;
	hh_age_lt18                      := le.bs.hhid_summary.hh_age_lt18;
	hh_collections_ct                := le.bs.hhid_summary.hh_collections_ct;
	hh_workers_paw                   := le.bs.hhid_summary.hh_workers_paw;
	hh_payday_loan_users             := le.bs.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.bs.hhid_summary.hh_members_w_derog;
	hh_tot_derog                     := le.bs.hhid_summary.hh_tot_derog;
	hh_bankruptcies                  := le.bs.hhid_summary.hh_bankruptcies;
	hh_lienholders                   := le.bs.hhid_summary.hh_lienholders;
	hh_prof_license_holders          := le.bs.hhid_summary.hh_prof_license_holders;
	hh_criminals                     := le.bs.hhid_summary.hh_criminals;
	hh_college_attendees             := le.bs.hhid_summary.hh_college_attendees;
	rel_count                        := le.bs.relatives.relative_count;
	rel_bankrupt_count               := le.bs.relatives.relative_bankrupt_count;
	rel_criminal_count               := le.bs.relatives.relative_criminal_count;
	rel_felony_count                 := le.bs.relatives.relative_felony_count;
	crim_rel_within25miles           := le.bs.relatives.criminal_relative_within25miles;
	crim_rel_within100miles          := le.bs.relatives.criminal_relative_within100miles;
	crim_rel_within500miles          := le.bs.relatives.criminal_relative_within500miles;
	rel_within25miles_count          := le.bs.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.bs.relatives.relative_within100miles_count;
	rel_within500miles_count         := le.bs.relatives.relative_within500miles_count;
	rel_incomeunder50_count          := le.bs.relatives.relative_incomeunder50_count;
	rel_incomeunder75_count          := le.bs.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count         := le.bs.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.bs.relatives.relative_incomeover100_count;
	rel_homeunder100_count           := le.bs.relatives.relative_homeunder100_count;
	rel_homeunder150_count           := le.bs.relatives.relative_homeunder150_count;
	rel_homeunder200_count           := le.bs.relatives.relative_homeunder200_count;
	rel_homeunder300_count           := le.bs.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.bs.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.bs.relatives.relative_homeover500_count;
	rel_educationunder12_count       := le.bs.relatives.relative_educationunder12_count;
	rel_educationover12_count        := le.bs.relatives.relative_educationover12_count;
	rel_ageunder30_count             := le.bs.relatives.relative_ageunder30_count;
	rel_ageunder40_count             := le.bs.relatives.relative_ageunder40_count;
	rel_ageunder50_count             := le.bs.relatives.relative_ageunder50_count;
	rel_ageunder60_count             := le.bs.relatives.relative_ageunder60_count;
	rel_ageunder70_count             := le.bs.relatives.relative_ageunder70_count;
	rel_ageover70_count              := le.bs.relatives.relative_ageover70_count;
	current_count                    := le.bs.vehicles.current_count;
	historical_count                 := le.bs.vehicles.historical_count;
	watercraft_count                 := le.bs.watercraft.watercraft_count;
	acc_count                        := le.bs.accident_data.acc.num_accidents;
	acc_damage_amt_total             := le.bs.accident_data.acc.dmgamtaccidents;
	acc_last_seen                    := le.bs.accident_data.acc.datelastaccident;
	acc_damage_amt_last              := le.bs.accident_data.acc.dmgamtlastaccident;
	acc_count_30                     := le.bs.accident_data.acc.numaccidents30;
	acc_count_90                     := le.bs.accident_data.acc.numaccidents90;
	acc_count_180                    := le.bs.accident_data.acc.numaccidents180;
	acc_count_12                     := le.bs.accident_data.acc.numaccidents12;
	acc_count_24                     := le.bs.accident_data.acc.numaccidents24;
	acc_count_36                     := le.bs.accident_data.acc.numaccidents36;
	acc_count_60                     := le.bs.accident_data.acc.numaccidents60;
	college_income_level_code        := if(isFCRA, '', le.bs.student.income_level_code);
	college_file_type                := le.bs.student.file_type2;
	college_attendance               := le.bs.attended_college;
	prof_license_flag                := (integer)le.bs.professional_license.professional_license_flag;
	prof_license_category            := le.bs.professional_license.plcategory;
	prof_license_source              := le.bs.professional_license.proflic_source;
	prof_license_ix_sanct_ct         := le.bs.professional_license.sanctions_count;
	prof_license_ix_sanct_fs         := le.bs.professional_license.sanctions_date_first_seen;
	prof_license_ix_sanct_ls         := le.bs.professional_license.sanctions_date_last_seen;
	prof_license_ix_sanct_type       := le.bs.professional_license.most_recent_sanction_type;
	wealth_index                     := (integer)le.bs.wealth_indicator;
	input_dob_match_level            := le.bs.dobmatchlevel;
	inferred_age                     := le.bs.inferred_age;
	addr_stability_v2                := (integer)le.bs.addr_stability;
	estimated_income                 := le.bs.estimated_income;

NULL := models.common.NULL;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := common.sas_date(if(le.bs.historydate=999999, (STRING)Std.Date.Today(), (string6)le.bs.historydate+'01'));

ssnpop := __common__(  ssnlength = 9 );

fnamepop_char := __common__(  if(fnamepop, 'F', ' ') );

lnamepop_char := __common__(  if(lnamepop, 'L', ' ') );

addrpop_char := __common__(  if(addrpop, 'A', ' ') );

hphnpop_char := __common__(  if(hphnpop, 'P', ' ') );

ssnpop_char := __common__(  if(ssnpop, 'S', ' ') );

dobpop_char := __common__(  if(dobpop, 'D', ' ') );

// pii_profile_n := __common__(  '|' || (string)fnamepop_char || (string)lnamepop_char || (string)addrpop_char || (string)hphnpop_char || (string)ssnpop_char || (string)dobpop_char || '|' );
pii_profile_n := __common__(  '|' + (string)fnamepop_char + (string)lnamepop_char + (string)addrpop_char + (string)hphnpop_char + (string)ssnpop_char + (string)dobpop_char + '|' );

r_nas_ssn_verd_d := __common__(  (integer)(nas_summary in [4, 6, 7, 9, 10, 11, 12]) );

r_nas_addr_verd_d := __common__(  (integer)(nas_summary in [3, 5, 6, 8, 10, 11, 12]) );

r_nas_lname_verd_d := __common__(  (integer)(nas_summary in [2, 5, 7, 8, 9, 11, 12]) );

r_nas_fname_verd_d := __common__(  (integer)(nas_summary in [2, 3, 4, 8, 9, 10, 12]) );

r_nas_nothing_found_i := __common__(  (integer)(nas_summary in [0]) );

r_nas_contradictory_i := __common__(  (integer)(nas_summary in [1]) );

r_f00_nas_ssn_no_addr_verd_i := __common__(  (integer)(nas_summary in [4, 7, 9]) );

k_nap_phn_verd_d := __common__(  (integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12]) );

k_nap_addr_verd_d := __common__(  (integer)(nap_summary in [3, 5, 6, 8, 10, 11, 12]) );

k_nap_lname_verd_d := __common__(  (integer)(nap_summary in [2, 5, 7, 8, 9, 11, 12]) );

k_nap_fname_verd_d := __common__(  (integer)(nap_summary in [2, 3, 4, 8, 9, 10, 12]) );

k_nap_nothing_found_i := __common__(  (integer)(nap_summary in [0]) );

k_nap_contradictory_i := __common__(  (integer)(nap_summary in [1]) );

k_inf_phn_verd_d := __common__(  (integer)(infutor_nap in [4, 6, 7, 9, 10, 11, 12]) );

k_inf_addr_verd_d := __common__(  (integer)(infutor_nap in [3, 5, 6, 8, 10, 11, 12]) );

k_inf_lname_verd_d := __common__(  (integer)(infutor_nap in [2, 5, 7, 8, 9, 11, 12]) );

k_inf_fname_verd_d := __common__(  (integer)(infutor_nap in [2, 3, 4, 8, 9, 10, 12]) );

k_inf_nothing_found_i := __common__(  (integer)(infutor_nap in [0]) );

k_inf_contradictory_i := __common__(  (integer)(infutor_nap in [1]) );

r_s65_ssn_prior_dob_i := __common__(  map(
    not(ssnlength > 0 and dobpop)            => NULL,
    rc_ssndobflag = 1 or rc_pwssndobflag = 1 => 1,
    rc_ssndobflag = 0 or rc_pwssndobflag = 0 => 0,
                                                NULL) );

r_s65_ssn_invalid_i := __common__(  map(
    not(ssnlength > 0)                                                                                 => NULL,
    rc_ssnvalflag = 1 or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) => 1,
    rc_ssnvalflag = 0 or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) => 0,
                                                                                                          NULL) );

r_c16_inv_ssn_per_adl_i := __common__(  if(not(truedid), NULL, min(if(invalid_ssns_per_adl = NULL, -NULL, invalid_ssns_per_adl), 999)) );

r_c16_inv_ssn_per_adl_c6_i := __common__(  if(not(truedid), NULL, min(if(invalid_ssns_per_adl_c6 = NULL, -NULL, invalid_ssns_per_adl_c6), 999)) );

r_f00_addr_not_ver_w_ssn_i := __common__(  if(not(truedid and ssnlength > 0), NULL, (integer)(nas_summary in [4, 7, 9])) );

r_s65_ssn_problem_i := __common__(  map(
    not(ssnlength > 0)                                                                                                                                                                                                                                                => NULL,
    dobpop and (rc_ssndobflag = 1 or rc_pwssndobflag = 1) or truedid and invalid_ssns_per_adl >= 2 or truedid and invalid_ssns_per_adl_c6 >= 1                                                                                                                        => 2,
    rc_decsflag = 1 or contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 or rc_ssnvalflag = 1 or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) or truedid and invalid_ssns_per_adl >= 1                          => 1,
    rc_decsflag = 0 or dobpop and (rc_ssndobflag = 0 or rc_pwssndobflag = 0) or rc_ssnvalflag = 0 or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) or truedid and invalid_ssns_per_adl = 0 or truedid and invalid_ssns_per_adl_c6 = 0 => 0,
                                                                                                                                                                                                                                                                         NULL) );

r_p88_phn_dst_to_inp_add_i := __common__(  if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr) );

r_l70_zip_not_issued_i := __common__(  map(
    out_z5 = ''		               => NULL,
    (rc_pwphonezipflag in ['2']) => 1,
                                    0) );

r_p85_phn_not_issued_i := __common__(  map(
    not(hphnpop)                 => NULL,
    (rc_pwphonezipflag in ['4']) => 1,
                                    0) );

r_p85_phn_disconnected_i := __common__(  map(
    not(hphnpop)                                                             => NULL,
    rc_hriskphoneflag = 5 or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => 1,
                                                                                0) );

r_p85_phn_invalid_i := __common__(  map(
    not(hphnpop)                                                    => NULL,
    rc_phonevalflag = 0 or rc_hphonevalflag = 0 or rc_phonetype = 5 => 1,
                                                                       0) );

r_p85_phn_hirisk_i := __common__(  map(
    not(hphnpop)                                                                                    => NULL,
    rc_hriskphoneflag = 6 or rc_hphonetypeflag = '5' or rc_hphonevalflag = 3 or rc_addrcommflag = 1 => 1,
                                                                                                       0) );

r_phn_cell_n_1 := __common__(  if(not(hphnpop), NULL, NULL) );

r_phn_cell_n := __common__(  if(rc_hriskphoneflag = 1 or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '1' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '04' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '55' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '60', 1, 0) );

r_p86_phn_pager_i := __common__(  map(
    not(hphnpop)                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = 2 or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '2' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '02' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '56' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '61' => 1,
                                                                                                                                                                                                                                                               0) );

r_phn_pcs_n := __common__(  map(
    not(hphnpop)                                                                                                                                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = 3 or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '3' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '64' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '65' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '66' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '67' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '68' => 1,
                                                                                                                                                                                                                                                                                                                                                                               0) );

r_p86_phn_pay_phone_i := __common__(  map(
    not(hphnpop)                                           => NULL,
    trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = 'A' => 1,
                                                              0) );

r_p86_phn_fax_i := __common__(  map(
    not(hphnpop)                                           => NULL,
    trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = 'B' => 1,
                                                              0) );

r_p87_phn_corrections_i := __common__(  map(
    not(hphnpop)            				=> NULL,
    trim(rc_hrisksicphone) = '2225' => 1,
																			 0) );

r_c17_inv_phn_per_adl_i := __common__(  map(
    not(truedid)                                                => NULL,
    invalid_phones_per_adl > 0 or invalid_phones_per_adl_c6 > 0 => 1,
                                                                   0) );

r_l77_add_po_box_i := __common__(  map(
    not(addrpop or not(out_z5 = ''))                                                                                                                                                                                                                           => NULL,
    rc_hriskaddrflag = 1 or rc_ziptypeflag = 1 or StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'E' or StringLib.StringToUpperCase(trim(rc_zipclass, LEFT, RIGHT)) = 'P' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'P' => 1,
                                                                                                                                                                                                                                                                    0) );

r_l70_add_invalid_i := __common__(  map(
    not(addrpop)                                        => NULL,
    trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N' => 1,
                                                           0) );

r_l71_add_hirisk_comm_i := __common__(  map(
    not(addrpop)                                => NULL,
    rc_hriskaddrflag = 4 or rc_addrcommflag = 2 => 1,
                                                   0) );

r_l71_add_corp_zip_i := __common__(  map(
    not(addrpop or not(out_z5 = ''))         	 => NULL,
    rc_hriskaddrflag = 2 or rc_ziptypeflag = 2 => 1,
                                                  0) );

r_l72_add_vacant_i := __common__(  map(
    not(add_input_pop)                                          => NULL,
    trim(trim(add_input_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                   0) );

r_l74_add_throwback_i := __common__(  map(
    not(add_input_pop)                                             => NULL,
    trim(trim(add_input_advo_throw_back, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                      0) );

r_l75_add_drop_delivery_i := __common__(  map(
    not(add_input_pop)                                       => NULL,
    trim(trim(add_input_advo_drop, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                0) );

r_l76_add_seasonal_i := __common__(  if(not(add_input_pop), NULL, (integer)(add_input_advo_seasonal in ['Y', 'E'])) );

r_l71_add_business_i := __common__(  map(
    not(add_input_pop)                                                       => NULL,
    (trim(trim(add_input_advo_res_or_bus, LEFT), LEFT, RIGHT) in ['B', 'D']) => 1,
                                                                                0) );

add_ec1 := __common__(  (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1] );

add_ec3 := __common__(  (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3] );

add_ec4 := __common__(  (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4] );

r_l70_add_standardized_i := __common__(  map(
    not(addrpop)                                         => NULL,
    trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E'         => 2,
    add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => 1,
                                                            0) );

r_l70_inp_addr_dnd_i := __common__(  map(
    not(add_input_pop)        => NULL,
    add_input_advo_dnd = '' 	=> NULL,
                                 (integer)(add_input_advo_dnd = 'Y')) );

r_l71_add_curr_hirisk_comm_i := __common__(  if(not(add_curr_pop), NULL, add_curr_hr_address) );

r_l72_add_curr_vacant_i := __common__(  map(
    not(add_curr_pop)                                          => NULL,
    trim(trim(add_curr_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                  0) );

r_l74_add_curr_throwback_i := __common__(  map(
    not(add_curr_pop)                                             => NULL,
    trim(trim(add_curr_advo_throw_back, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                     0) );

r_l75_add_curr_drop_delivery_i := __common__(  map(
    not(add_curr_pop)                                       => NULL,
    trim(trim(add_curr_advo_drop, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                               0) );

r_l76_add_curr_seasonal_i := __common__(  if(not(add_curr_pop), NULL, (integer)(add_curr_advo_seasonal in ['Y', 'E'])) );

r_l71_add_curr_business_i := __common__(  map(
    not(add_curr_pop)                                                       => NULL,
    (trim(trim(add_curr_advo_res_or_bus, LEFT), LEFT, RIGHT) in ['B', 'D']) => 1,
                                                                               0) );

r_f03_input_add_not_most_rec_i := __common__(  if(not(truedid and add_input_pop), NULL, rc_input_addr_not_most_recent) );

r_c18_inv_add_per_adl_c6_i := __common__(  if(not(truedid), NULL, min(if(invalid_addrs_per_adl_c6 = NULL, -NULL, invalid_addrs_per_adl_c6), 999)) );

r_c19_add_prison_hist_i := __common__(  if(not(truedid), NULL, addrs_prison_history) );

r_l77_apartment_i := __common__(  map(
    not(addrpop)                                                                                                                                                                                         => NULL,
    StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = '') => 1,
                                                                                                                                                                                                            0) );

r_f00_ssn_score_d := __common__(  if(not(truedid and ssnlength > 0) or combo_ssnscore = 255, NULL, min(if(combo_ssnscore = NULL, -NULL, combo_ssnscore), 999)) );

r_f00_dob_score_d := __common__(  if(not(truedid and dobpop) or combo_dobscore = 255, NULL, min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 999)) );

r_f01_inp_addr_address_score_d := __common__(  if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999)) );

r_l70_inp_addr_dirty_i := __common__(  if(not(add_input_pop and truedid), NULL, add_input_dirty_address) );

r_f00_input_dob_match_level_d := __common__(  if(not(truedid and dobpop), NULL, (integer)input_dob_match_level) );

r_d30_derog_count_i := __common__(  if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999)) );

r_d32_criminal_count_i := __common__(  if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999)) );

r_d32_felony_count_i := __common__(  if(not(truedid), NULL, min(if(felony_count = NULL, -NULL, felony_count), 999)) );

_criminal_last_date := __common__(  common.sas_date((string)(criminal_last_date)) );

r_d32_mos_since_crim_ls_d := __common__(  map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => 241,
                                  max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240))) );

_felony_last_date := __common__(  common.sas_date((string)(felony_last_date)) );

r_d32_mos_since_fel_ls_d := __common__(  map(
    not(truedid)             => NULL,
    _felony_last_date = NULL => 241,
                                max(3, min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240))) );

r_d31_mostrec_bk_i := __common__(  map(
    not(truedid)                     => NULL,
		//kh-changed to check for truncated string
    StringLib.StringToUpperCase(disposition[1..7]) = 'DISMISS'  => 1,
    StringLib.StringToUpperCase(disposition[1..8]) = 'DISCHARG' => 2,
    bankrupt = 1 or filing_count > 0 => 3,
                                        0) );

r_d31_attr_bankruptcy_recency_d := __common__(  map(
    not(truedid)             		=> NULL,
    attr_bankruptcy_count30 >0  => 1,  //kh-added >0 for all these
    attr_bankruptcy_count90 >0  => 3,
    attr_bankruptcy_count180 >0 => 6,
    attr_bankruptcy_count12 >0  => 12,
    attr_bankruptcy_count24 >0  => 24,
    attr_bankruptcy_count36 >0  => 36,
    attr_bankruptcy_count60 >0  => 60,
    bankrupt = 1             		=> 99,
    filing_count > 0         		=> 99,
																	 0) );

r_d31_bk_filing_count_i := __common__(  if(not(truedid), NULL, min(if(filing_count = NULL, -NULL, filing_count), 999)) );

r_d31_bk_disposed_recent_count_i := __common__(  if(not(truedid), NULL, min(if(bk_disposed_recent_count = NULL, -NULL, bk_disposed_recent_count), 999)) );

r_d31_bk_disposed_hist_count_i := __common__(  if(not(truedid), NULL, min(if(bk_disposed_historical_count = NULL, -NULL, bk_disposed_historical_count), 999)) );

r_d33_eviction_recency_d := __common__(  map(
    not(truedid)             		=> NULL,
    attr_eviction_count90 >0    => 3,	//kh-added >0 for all these
    attr_eviction_count180 >0   => 6,
    attr_eviction_count12 >0    => 12,
    attr_eviction_count24 >0    => 24,
    attr_eviction_count36 >0    => 36,
    attr_eviction_count60 >0    => 60,
    attr_eviction_count >= 1 		=> 99,
																	 999) );

r_d33_eviction_count_i := __common__(  if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999)) );

r_d34_unrel_liens_ct_i := __common__(  if(not(truedid), NULL, min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 999)) );

r_d34_unrel_lien60_count_i := __common__(  if(not(truedid), NULL, min(if(attr_num_unrel_liens60 = NULL, -NULL, attr_num_unrel_liens60), 999)) );

bureau_adl_eq_fseen_pos_2 := __common__(  Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E') );

bureau_adl_fseen_eq_2 := __common__(  if(bureau_adl_eq_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_2, ',')) );

_bureau_adl_fseen_eq_2 := __common__(  common.sas_date((string)(bureau_adl_fseen_eq_2)) );

_src_bureau_adl_fseen := __common__(  min(if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), 999999) );

r_c21_m_bureau_adl_fs_d := __common__(  map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => 1000,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999)) );

bureau_adl_eq_fseen_pos_1 := __common__(  Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E') );

bureau_adl_fseen_eq_1 := __common__(  if(bureau_adl_eq_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_1, ',')) );

_bureau_adl_fseen_eq_1 := __common__(  common.sas_date((string)(bureau_adl_fseen_eq_1)) );

bureau_adl_en_fseen_pos_1 := __common__(  Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E') );

bureau_adl_fseen_en_1 := __common__(  if(bureau_adl_en_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_1, ',')) );

_bureau_adl_fseen_en_1 := __common__(  common.sas_date((string)(bureau_adl_fseen_en_1)) );

bureau_adl_ts_fseen_pos_1 := __common__(  Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E') );

bureau_adl_fseen_ts_1 := __common__(  if(bureau_adl_ts_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_1, ',')) );

_bureau_adl_fseen_ts_1 := __common__(  common.sas_date((string)(bureau_adl_fseen_ts_1)) );

bureau_adl_tu_fseen_pos_1 := __common__(  Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E') );

bureau_adl_fseen_tu_1 := __common__(  if(bureau_adl_tu_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_1, ',')) );

_bureau_adl_fseen_tu_1 := __common__(  common.sas_date((string)(bureau_adl_fseen_tu_1)) );

bureau_adl_tn_fseen_pos_1 := __common__(  Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E') );

bureau_adl_fseen_tn_1 := __common__(  if(bureau_adl_tn_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_1, ',')) );

_bureau_adl_fseen_tn_1 := __common__(  common.sas_date((string)(bureau_adl_fseen_tn_1)) );

_src_bureau_adl_fseen_all := __common__(  min(if(_bureau_adl_fseen_tn_1 = NULL, -NULL, _bureau_adl_fseen_tn_1), if(_bureau_adl_fseen_ts_1 = NULL, -NULL, _bureau_adl_fseen_ts_1), if(_bureau_adl_fseen_tu_1 = NULL, -NULL, _bureau_adl_fseen_tu_1), if(_bureau_adl_fseen_en_1 = NULL, -NULL, _bureau_adl_fseen_en_1), if(_bureau_adl_fseen_eq_1 = NULL, -NULL, _bureau_adl_fseen_eq_1), 999999) );

f_m_bureau_adl_fs_all_d := __common__(  map(
    not(truedid)                       => NULL,
    _src_bureau_adl_fseen_all = 999999 => 1000,
                                          min(if(if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)))), 999)) );

bureau_adl_eq_fseen_pos := __common__(  Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E') );

bureau_adl_fseen_eq := __common__(  if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ',')) );

_bureau_adl_fseen_eq := __common__(  common.sas_date((string)(bureau_adl_fseen_eq)) );

bureau_adl_en_fseen_pos := __common__(  Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E') );

bureau_adl_fseen_en := __common__(  if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ',')) );

_bureau_adl_fseen_en := __common__(  common.sas_date((string)(bureau_adl_fseen_en)) );

bureau_adl_ts_fseen_pos := __common__(  Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E') );

bureau_adl_fseen_ts := __common__(  if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ',')) );

_bureau_adl_fseen_ts := __common__(  common.sas_date((string)(bureau_adl_fseen_ts)) );

bureau_adl_tu_fseen_pos := __common__(  Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E') );

bureau_adl_fseen_tu := __common__(  if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ',')) );

_bureau_adl_fseen_tu := __common__(  common.sas_date((string)(bureau_adl_fseen_tu)) );

bureau_adl_tn_fseen_pos := __common__(  Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E') );

bureau_adl_fseen_tn := __common__(  if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ',')) );

_bureau_adl_fseen_tn := __common__(  common.sas_date((string)(bureau_adl_fseen_tn)) );

_src_bureau_adl_fseen_notu := __common__(  min(if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999) );

f_m_bureau_adl_fs_notu_d := __common__(  map(
    not(truedid)                        => NULL,
    _src_bureau_adl_fseen_notu = 999999 => 1000,
                                           min(if(if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))), 999)) );

_header_first_seen := __common__(  common.sas_date((string)(header_first_seen)) );

r_c10_m_hdr_fs_d := __common__(  map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => 1000,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999)) );

r_c12_nonderog_recency_i := __common__(  map(
    not(truedid)            	 => NULL,
    attr_num_nonderogs90 > 0   => 3, //kh-added >0 to all these
    attr_num_nonderogs180 > 0  => 6,
    attr_num_nonderogs12 > 0   => 12,
    attr_num_nonderogs24 > 0   => 24,
    attr_num_nonderogs36 > 0   => 36,
    attr_num_nonderogs60 > 0   => 60,
    attr_num_nonderogs >= 1 	 => 99,
																  999) );

r_c12_num_nonderogs_d := __common__(  if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 999)) );

r_c15_ssns_per_adl_i := __common__(  map(
    not(truedid)             => NULL,
    ssns_per_adl = 0         => 2,
    (ssns_per_adl in [1, 2]) => 1,
                                min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 999)) );

r_c15_ssns_per_adl_c6_i_1 := __common__(  map(
    not(truedid)        => NULL,
    ssns_per_adl_c6 = 0 => 1,
                           min(if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6), 999)) );

r_s66_adlperssn_count_i := __common__(  map(
    not(ssnlength > 0) => NULL,
    adls_per_ssn = 0   => 1,
                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999)) );

_in_dob := __common__(  common.sas_date((string)(in_dob)) );

yr_in_dob := __common__(  if(_in_dob = NULL, NULL, (sysdate - _in_dob) / 365.25) );

yr_in_dob_int := __common__(  if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob)) );

k_comb_age_d := __common__(  map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL) );

r_f03_address_match_d := __common__(  map(
    not(truedid)                                => NULL,
    add_input_isbestmatch                       => 4,
    not(add_input_pop) and add_curr_isbestmatch => 3,
    add_input_pop and add_curr_isbestmatch      => 2,
    add_curr_pop                                => 1,
    add_input_pop                               => 0,
                                                   NULL) );

r_a48_inp_addr_conv_mortgage_d := __common__(  map(
    not(truedid and add_input_pop)                                                                                                                                                                                                                                                                                                      => 2,
    add_input_financing_type = 'CNV' or (add_input_mortgage_type in ['CNV', 'N'])                                                                                                                                                                                                                                                       => 2,
    add_input_mortgage_type = '' and not((add_input_mortgage_date in [0, NULL])) or not(add_input_mortgage_type = '') and not((add_input_mortgage_type in ['CNV', 'N', 'FHA', 'G', 'VA', '1', 'D', '2', 'E', 'R', 'C', 'I', 'K', 'O', 'LHM', 'T', 'SBA', 'H', 'J', 'PMM', 'PP', 'S', 'L', 'U'])) or add_input_financing_type = '' => 2,
                                                                                                                                                                                                                                                                                                                                           1) );

r_a44_curr_add_naprop_d := __common__(  if(not(truedid and add_curr_pop), NULL, (integer)add_curr_naprop) );

r_a48_curr_addr_conv_mortg_d := __common__(  map(
    not(truedid and add_curr_pop)                                                                                                                                                                                                                                                                                                  => 2,
    add_curr_financing_type = 'CNV' or (add_curr_mortgage_type in ['CNV', 'N'])                                                                                                                                                                                                                                                    => 2,
    add_curr_mortgage_type = '' and not((add_curr_mortgage_date in [0, NULL])) or not(add_curr_mortgage_type = '') and not((add_curr_mortgage_type in ['CNV', 'N', 'FHA', 'G', 'VA', '1', 'D', '2', 'E', 'R', 'C', 'I', 'K', 'O', 'LHM', 'T', 'SBA', 'H', 'J', 'PMM', 'PP', 'S', 'L', 'U'])) or add_curr_financing_type = '' => 2,
                                                                                                                                                                                                                                                                                                                                      1) );

r_l80_inp_avm_autoval_d := __common__(  map(
    not(add_input_pop)         => NULL,
    add_input_avm_auto_val = 0 => NULL,
                                  min(if(add_input_avm_auto_val = NULL, -NULL, add_input_avm_auto_val), 300000)) );

r_a46_curr_avm_autoval_d := __common__(  map(
    // not(truedid)              => NULL,	//kh-delta
    not(add_curr_pop)            => NULL,
    add_curr_avm_auto_val = 0 => NULL,
                                 min(if(add_curr_avm_auto_val = NULL, -NULL, add_curr_avm_auto_val), 300000)) );

r_a49_curr_avm_chg_1yr_i := __common__(  map(
    // not(truedid)                                              => NULL,	//kh-delta
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
                                                                 NULL) );

r_a49_curr_avm_chg_1yr_pct_i := __common__(  map(	//kh-added decimal definition
    // not(truedid)                                              => NULL,
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12                                        => NULL,
    // add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1) / 10,	//kh-changed to divide
                                                                 NULL) );

r_c13_curr_addr_lres_d := __common__(  if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999)) );

r_c14_addr_stability_v2_d := __common__(  map(
    not(truedid)          => NULL,
    addr_stability_v2 = 0 => NULL,
                             addr_stability_v2) );

r_c13_max_lres_d := __common__(  if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999)) );

r_add_curr_pop_i := __common__(  if(not(add_curr_pop), 0, 1) );

r_c14_addrs_5yr_i := __common__(  if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999)) );

r_c14_addrs_10yr_i := __common__(  if(not(truedid), NULL, min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999)) );

r_c14_addrs_per_adl_c6_i := __common__(  if(not(truedid), NULL, min(if(addrs_per_adl_c6 = NULL, -NULL, addrs_per_adl_c6), 999)) );

r_c14_addrs_15yr_i := __common__(  if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999)) );

r_a41_prop_owner_d := __common__(  map(
    not(truedid)                                                                                   => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => 1,
                                                                                                      0) );

r_a41_prop_owner_inp_only_d := __common__(  map(
    not(truedid)                                => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 => 1,
                                                   0) );

r_prop_owner_history_d := __common__(  map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0) );

r_a43_aircraft_cnt_d := __common__(  if(not(truedid), NULL, attr_num_aircraft) );

r_a43_watercraft_cnt_d := __common__(  if(not(truedid), NULL, watercraft_count) );

r_ever_asset_owner_d := __common__(  map(
    not(truedid)                                                                                                                                                                                                 => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 or watercraft_count > 0 or attr_num_aircraft > 0 => 1,
                                                                                                                                                                                                                    0) );

r_c20_email_count_i := __common__(  if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999)) );

r_c20_email_domain_free_count_i := __common__(  if(not(truedid), NULL, min(if(email_domain_free_count = NULL, -NULL, email_domain_free_count), 999)) );

r_c20_email_domain_isp_count_i := __common__(  if(not(truedid), NULL, min(if(email_domain_ISP_count = NULL, -NULL, email_domain_ISP_count), 999)) );

r_e57_prof_license_flag_d := __common__(  if(not(truedid), NULL, prof_license_flag) );

// r_l79_adls_per_addr_curr_i := __common__(  if(not(addrpop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)) );	//kh-delta
r_l79_adls_per_addr_curr_i := __common__(  if(not(add_curr_pop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)) );

r_c15_ssns_per_adl_c6_i := __common__(  if(not(truedid), NULL, min(if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6), 999)) );

r_l79_adls_per_addr_c6_i := __common__(  if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999)) );

r_c18_invalid_addrs_per_adl_i := __common__(  if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999)) );

r_has_pb_record_d := __common__(  if((integer)pb_number_of_sources > 0, 1, 0) );

r_a50_pb_average_dollars_d := __common__(  map(
    not(truedid)              => NULL,
    pb_average_dollars = '0' 		=> 5000,
                                 min(if(pb_average_dollars = '', -NULL, (integer)pb_average_dollars), 5000)) );

r_a50_pb_total_dollars_d := __common__(  map(
    not(truedid)            => NULL,
    pb_total_dollars = '' 		=> 10001,
                               min(if(pb_total_dollars = '', -NULL, (integer)pb_total_dollars), 10000)) );

r_a50_pb_total_orders_d := __common__(  map(
    not(truedid)           => NULL,
    pb_total_orders = ''		 => -1,
                              (integer)pb_total_orders) );

r_pb_order_freq_d := __common__(  map(
    not(truedid)                     => NULL,
    pb_number_of_sources = ''	       => NULL,
    pb_average_days_bt_orders = ''		 => -1,
                                        min(if(pb_average_days_bt_orders = '0', 0, (integer)pb_average_days_bt_orders), 999)) );

r_l78_no_phone_at_addr_vel_i := __common__(  map(
    not(addrpop)             => NULL,
    phones_per_addr_curr = 0 => 1,
                                0) );

r_i60_inq_count12_i := __common__(  if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999)) );

r_i60_credit_seeking_i := __common__(  if(not(truedid), NULL, if(max(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)), min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)), min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)), min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)), min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)) = NULL, 0, min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03))), if(min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)) = NULL, 0, min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03))), if(min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)) = NULL, 0, min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03))), if(min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)) = NULL, 0, min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03))), if(min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)) = NULL, 0, min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)))))) );

r_i60_inq_recency_d := __common__(  map(
    not(truedid) 		=> NULL,
    inq_count01 > 0 => 1,
    inq_count03 > 0 => 3,
    inq_count06 > 0 => 6,
    inq_count12 > 0 => 12,
    inq_count24 > 0 => 24,
    inq_count   > 0 => 99,
											 999) );

r_i61_inq_collection_count12_i := __common__(  if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999)) );

r_i61_inq_collection_recency_d := __common__(  map(
    not(truedid)           		 => NULL,
    inq_collection_count01 > 0 => 1,
    inq_collection_count03 > 0 => 3,
    inq_collection_count06 > 0 => 6,
    inq_collection_count12 > 0 => 12,
    inq_collection_count24 > 0 => 24,
    inq_collection_count   > 0 => 99,
																	999) );

r_i60_inq_auto_count12_i := __common__(  if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999)) );

r_i60_inq_auto_recency_d := __common__(  map(
    not(truedid)     		 => NULL,
    inq_auto_count01 > 0 => 1,
    inq_auto_count03 > 0 => 3,
    inq_auto_count06 > 0 => 6,
    inq_auto_count12 > 0 => 12,
    inq_auto_count24 > 0 => 24,
    inq_auto_count   > 0 => 99,
														999) );

r_i60_inq_banking_count12_i := __common__(  if(not(truedid), NULL, min(if(inq_banking_count12 = NULL, -NULL, inq_banking_count12), 999)) );

r_i60_inq_banking_recency_d := __common__(  map(
    not(truedid)        		=> NULL,
    inq_banking_count01 > 0 => 1,
    inq_banking_count03 > 0 => 3,
    inq_banking_count06 > 0 => 6,
    inq_banking_count12 > 0 => 12,
    inq_banking_count24 > 0 => 24,
    inq_banking_count   > 0 => 99,
															 999) );

r_i60_inq_mortgage_count12_i := __common__(  if(not(truedid), NULL, min(if(inq_mortgage_count12 = NULL, -NULL, inq_mortgage_count12), 999)) );

r_i60_inq_mortgage_recency_d := __common__(  map(
    not(truedid)         		 => NULL,
    inq_mortgage_count01 > 0 => 1,
    inq_mortgage_count03 > 0 => 3,
    inq_mortgage_count06 > 0 => 6,
    inq_mortgage_count12 > 0 => 12,
    inq_mortgage_count24 > 0 => 24,
    inq_mortgage_count   > 0 => 99,
																999) );

r_i60_inq_hiriskcred_count12_i := __common__(  if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999)) );

r_i60_inq_hiriskcred_recency_d := __common__(  map(
    not(truedid)               		 => NULL,
    inq_highRiskCredit_count01 > 0 => 1,
    inq_highRiskCredit_count03 > 0 => 3,
    inq_highRiskCredit_count06 > 0 => 6,
    inq_highRiskCredit_count12 > 0 => 12,
    inq_highRiskCredit_count24 > 0 => 24,
    inq_highRiskCredit_count   > 0 => 99,
																			999) );

r_i60_inq_retail_count12_i := __common__(  if(not(truedid), NULL, min(if(inq_retail_count12 = NULL, -NULL, inq_retail_count12), 999)) );

r_i60_inq_retail_recency_d := __common__(  map(
    not(truedid)       		 => NULL,
    inq_retail_count01 > 0 => 1,
    inq_retail_count03 > 0 => 3,
    inq_retail_count06 > 0 => 6,
    inq_retail_count12 > 0 => 12,
    inq_retail_count24 > 0 => 24,
    inq_retail_count   > 0 => 99,
															999) );

r_i60_inq_comm_count12_i := __common__(  if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999)) );

r_i60_inq_comm_recency_d := __common__(  map(
    not(truedid)               		 => NULL,
    inq_communications_count01 > 0 => 1,
    inq_communications_count03 > 0 => 3,
    inq_communications_count06 > 0 => 6,
    inq_communications_count12 > 0 => 12,
    inq_communications_count24 > 0 => 24,
    inq_communications_count   > 0 => 99,
																			999) );

f_bus_addr_match_count_d := __common__(  if(not(addrpop), NULL, bus_addr_match_count) );

f_bus_fname_verd_d := __common__(  if(not(addrpop), NULL, (integer)(bus_name_match in [2, 4])) );

f_bus_lname_verd_d := __common__(  if(not(addrpop), NULL, (integer)(bus_name_match in [3, 4])) );

f_bus_name_nover_i := __common__(  if(not(addrpop), NULL, (integer)(bus_name_match = 1)) );

f_bus_ssn_match_d := __common__(  if(not(addrpop), NULL, (integer)(bus_ssn_match = 3)) );

f_bus_phone_match_d := __common__(  if(not(addrpop), NULL, (integer)(bus_phone_match = 3)) );

// f_adl_util_inf_n := __common__(  indexc(util_adl_type_list, '1') > 0 ); //kh-replaced indexc with StringFind
f_adl_util_inf_n := __common__(  (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_adl_type_list), '1', 1) > 0) );

// f_adl_util_conv_n := __common__(  indexc(util_adl_type_list, '2') > 0 ); //kh-replaced indexc with StringFind
f_adl_util_conv_n := __common__(  (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_adl_type_list), '2', 1) > 0) );

// f_adl_util_misc_n := __common__(  indexc(util_adl_type_list, 'Z') > 0 ); //kh-replaced indexc with StringFind
f_adl_util_misc_n := __common__(  (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_adl_type_list), 'Z', 1) > 0) );

f_util_adl_count_n := __common__(  if(not(truedid), NULL, util_adl_count) );

// f_util_add_input_inf_n := __common__(  indexc(util_add_input_type_list, '1') > 0 ); //kh-replaced indexc with StringFind
f_util_add_input_inf_n := __common__(  (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_input_type_list), '1', 1) > 0) );

// f_util_add_input_conv_n := __common__(  indexc(util_add_input_type_list, '2') > 0 ); //kh-replaced indexc with StringFind
f_util_add_input_conv_n := __common__(  (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_input_type_list), '2', 1) > 0) );

// f_util_add_input_misc_n := __common__(  indexc(util_add_input_type_list, 'Z') > 0 ); //kh-replaced indexc with StringFind
f_util_add_input_misc_n := __common__(  (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_input_type_list), 'Z', 1) > 0) );

// f_util_add_curr_inf_n := __common__(  indexc(util_add_curr_type_list, '1') > 0 ); //kh-replaced indexc with StringFind
f_util_add_curr_inf_n := __common__(  (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_curr_type_list), '1', 1) > 0) );

// f_util_add_curr_conv_n := __common__(  indexc(util_add_curr_type_list, '2') > 0 ); //kh-replaced indexc with StringFind
f_util_add_curr_conv_n := __common__(  (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_curr_type_list), '2', 1) > 0) );

// f_util_add_curr_misc_n := __common__(  indexc(util_add_curr_type_list, 'Z') > 0 ); //kh-replaced indexc with StringFind
f_util_add_curr_misc_n := __common__(  (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_curr_type_list), 'Z', 1) > 0) );

f_add_input_has_occ_1yr_d := __common__(  if(add_input_occupants_1yr <= 0, 0, 1) );

f_add_input_mobility_index_i := __common__(  map(
    not(addrpop)                 => NULL,
    add_input_occupants_1yr <= 0 => NULL,
                                    if(max(add_input_turnover_1yr_in, add_input_turnover_1yr_out) = NULL, NULL, sum(if(add_input_turnover_1yr_in = NULL, 0, add_input_turnover_1yr_in), if(add_input_turnover_1yr_out = NULL, 0, add_input_turnover_1yr_out))) / add_input_occupants_1yr) );

f_add_input_has_bus_ct_i := __common__(  if(add_input_nhood_BUS_ct = 0, 0, 1) );

add_input_nhood_prop_sum_3 := __common__(  if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))) );

f_add_input_nhood_bus_pct_i := __common__(  map(
    not(addrpop)               => NULL,
    add_input_nhood_BUS_ct = 0 => NULL,
                                  add_input_nhood_BUS_ct / add_input_nhood_prop_sum_3) );

f_add_input_has_mfd_ct_i := __common__(  if(add_input_nhood_MFD_ct = 0, 0, 1) );

add_input_nhood_prop_sum_2 := __common__(  if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))) );

f_add_input_nhood_mfd_pct_i := __common__(  map(
    not(addrpop)               => NULL,
    add_input_nhood_MFD_ct = 0 => NULL,
                                  add_input_nhood_MFD_ct / add_input_nhood_prop_sum_2) );

f_add_input_has_sfd_ct_d := __common__(  if(add_input_nhood_SFD_ct = 0, 0, 1) );

add_input_nhood_prop_sum_1 := __common__(  if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))) );

f_add_input_nhood_sfd_pct_d := __common__(  map(
    not(addrpop)               => NULL,
    add_input_nhood_SFD_ct = 0 => -1,
                                  add_input_nhood_SFD_ct / add_input_nhood_prop_sum_1) );

f_add_input_has_vac_ct_i := __common__(  if(add_input_nhood_prop_sum_1 = 0, 0, 1) );

add_input_nhood_prop_sum := __common__(  if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))) );

f_add_input_nhood_vac_pct_i := __common__(  map(
    not(addrpop)                 => NULL,
    add_input_nhood_prop_sum = 0 => -1,
                                    add_input_nhood_VAC_prop / add_input_nhood_prop_sum) );

f_add_curr_has_occ_1yr_d := __common__(  if(add_curr_occupants_1yr <= 0, 0, 1) );

f_add_curr_mobility_index_i := __common__(  map(
    // not(addrpop)                => NULL,	//kh-delta
    not(add_curr_pop)           => NULL,
    add_curr_occupants_1yr <= 0 => NULL,
                                   if(max(add_curr_turnover_1yr_in, add_curr_turnover_1yr_out) = NULL, NULL, sum(if(add_curr_turnover_1yr_in = NULL, 0, add_curr_turnover_1yr_in), if(add_curr_turnover_1yr_out = NULL, 0, add_curr_turnover_1yr_out))) / add_curr_occupants_1yr) );

f_add_curr_has_bus_ct_i := __common__(  if(add_curr_nhood_BUS_ct = 0, 0, 1) );

add_curr_nhood_prop_sum_3 := __common__(  if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))) );

f_add_curr_nhood_bus_pct_i := __common__(  map(
    // not(addrpop)              => NULL,	//kh-delta
    not(add_curr_pop)         => NULL,
    add_curr_nhood_BUS_ct = 0 => NULL,
                                 add_curr_nhood_BUS_ct / add_curr_nhood_prop_sum_3) );

f_add_curr_has_mfd_ct_i := __common__(  if(add_curr_nhood_MFD_ct = 0, 0, 1) );

add_curr_nhood_prop_sum_2 := __common__(  if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))) );

f_add_curr_nhood_mfd_pct_i := __common__(  map(
    // not(addrpop)              => NULL,	//kh-delta
    not(add_curr_pop)         => NULL,
    add_curr_nhood_MFD_ct = 0 => NULL,
                                 add_curr_nhood_MFD_ct / add_curr_nhood_prop_sum_2) );

f_add_curr_has_sfd_ct_d := __common__(  if(add_curr_nhood_SFD_ct = 0, 0, 1) );

add_curr_nhood_prop_sum_1 := __common__(  if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))) );

f_add_curr_nhood_sfd_pct_d := __common__(  map(
    // not(addrpop)              => NULL,	//kh-delta
    not(add_curr_pop)         => NULL,
    add_curr_nhood_SFD_ct = 0 => -1,
                                 add_curr_nhood_SFD_ct / add_curr_nhood_prop_sum_1) );

f_add_curr_has_vac_ct_i := __common__(  if(add_curr_nhood_prop_sum_1 = 0, 0, 1) );

add_curr_nhood_prop_sum := __common__(  if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))) );

f_add_curr_nhood_vac_pct_i := __common__(  map(
    // not(addrpop)                => NULL,	//kh-delta
    not(add_curr_pop)           => NULL,
    add_curr_nhood_prop_sum = 0 => -1,
                                   add_curr_nhood_VAC_prop / add_curr_nhood_prop_sum) );

f_recent_disconnects_i := __common__(  if(not(hphnpop), NULL, min(if(recent_disconnects = NULL, -NULL, recent_disconnects), 999)) );

f_inq_count_i := __common__(  if(not(truedid), NULL, min(if(inq_count = NULL, -NULL, inq_count), 999)) );

f_inq_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999)) );

f_inq_auto_count_i := __common__(  if(not(truedid), NULL, min(if(inq_Auto_count = NULL, -NULL, inq_Auto_count), 999)) );

f_inq_auto_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_Auto_count24 = NULL, -NULL, inq_Auto_count24), 999)) );

f_inq_banking_count_i := __common__(  if(not(truedid), NULL, min(if(inq_Banking_count = NULL, -NULL, inq_Banking_count), 999)) );

f_inq_banking_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_Banking_count24 = NULL, -NULL, inq_Banking_count24), 999)) );

f_inq_collection_count_i := __common__(  if(not(truedid), NULL, min(if(inq_Collection_count = NULL, -NULL, inq_Collection_count), 999)) );

f_inq_collection_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 999)) );

f_inq_communications_count_i := __common__(  if(not(truedid), NULL, min(if(inq_Communications_count = NULL, -NULL, inq_Communications_count), 999)) );

f_inq_communications_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999)) );

f_inq_highriskcredit_count_i := __common__(  if(not(truedid), NULL, min(if(inq_HighRiskCredit_count = NULL, -NULL, inq_HighRiskCredit_count), 999)) );

f_inq_highriskcredit_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999)) );

f_inq_mortgage_count_i := __common__(  if(not(truedid), NULL, min(if(inq_Mortgage_count = NULL, -NULL, inq_Mortgage_count), 999)) );

f_inq_mortgage_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_Mortgage_count24 = NULL, -NULL, inq_Mortgage_count24), 999)) );

f_inq_other_count_i := __common__(  if(not(truedid), NULL, min(if(inq_Other_count = NULL, -NULL, inq_Other_count), 999)) );

f_inq_other_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999)) );

f_inq_retail_count_i := __common__(  if(not(truedid), NULL, min(if(inq_Retail_count = NULL, -NULL, inq_Retail_count), 999)) );

f_inq_retail_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_Retail_count24 = NULL, -NULL, inq_Retail_count24), 999)) );

k_inq_per_ssn_i := __common__(  if(not(ssnlength > 0), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999)) );

k_inq_adls_per_ssn_i := __common__(  if(not(ssnlength > 0), NULL, min(if(inq_adlsperssn = NULL, -NULL, inq_adlsperssn), 999)) );

k_inq_lnames_per_ssn_i := __common__(  if(not(ssnlength > 0), NULL, min(if(inq_lnamesperssn = NULL, -NULL, inq_lnamesperssn), 999)) );

k_inq_addrs_per_ssn_i := __common__(  if(not(ssnlength > 0), NULL, min(if(inq_addrsperssn = NULL, -NULL, inq_addrsperssn), 999)) );

k_inq_dobs_per_ssn_i := __common__(  if(not(ssnlength > 0), NULL, min(if(inq_dobsperssn = NULL, -NULL, inq_dobsperssn), 999)) );

k_inq_per_addr_i := __common__(  if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)) );

k_inq_adls_per_addr_i := __common__(  if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999)) );

k_inq_lnames_per_addr_i := __common__(  if(not(addrpop), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999)) );

k_inq_ssns_per_addr_i := __common__(  if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999)) );

k_inq_per_phone_i := __common__(  if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999)) );

k_inq_adls_per_phone_i := __common__(  if(not(hphnpop), NULL, min(if(inq_adlsperphone = NULL, -NULL, inq_adlsperphone), 999)) );

_inq_banko_am_first_seen := __common__(  common.sas_date((string)(Inq_banko_am_first_seen)) );

f_mos_inq_banko_am_fseen_d := __common__(  map(
    not(truedid)                    => NULL,
    _inq_banko_am_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_am_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_am_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)))), 999)) );

_inq_banko_am_last_seen := __common__(  common.sas_date((string)(Inq_banko_am_last_seen)) );

f_mos_inq_banko_am_lseen_d := __common__(  map(
    not(truedid)                   => NULL,
    _inq_banko_am_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _inq_banko_am_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_am_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_last_seen) / (365.25 / 12)))), 999))) );

_inq_banko_cm_first_seen := __common__(  common.sas_date((string)(Inq_banko_cm_first_seen)) );

f_mos_inq_banko_cm_fseen_d := __common__(  map(
    not(truedid)                    => NULL,
    _inq_banko_cm_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)))), 999)) );

_inq_banko_cm_last_seen := __common__(  common.sas_date((string)(Inq_banko_cm_last_seen)) );

f_mos_inq_banko_cm_lseen_d := __common__(  map(
    not(truedid)                   => NULL,
    _inq_banko_cm_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)))), 999))) );

_inq_banko_om_first_seen := __common__(  common.sas_date((string)(Inq_banko_om_first_seen)) );

f_mos_inq_banko_om_fseen_d := __common__(  map(
    not(truedid)                    => NULL,
    _inq_banko_om_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)))), 999)) );

_inq_banko_om_last_seen := __common__(  common.sas_date((string)(Inq_banko_om_last_seen)) );

f_mos_inq_banko_om_lseen_d := __common__(  map(
    not(truedid)                   => NULL,
    _inq_banko_om_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)))), 999))) );

f_attr_arrests_i := __common__(  if(not(truedid), NULL, min(if(attr_arrests = NULL, -NULL, attr_arrests), 999)) );

f_attr_arrest_recency_d := __common__(  map(
    not(truedid)        => NULL,
    attr_arrests30 > 0  => 1,
    attr_arrests90 > 0  => 3,
    attr_arrests180 > 0 => 6,
    attr_arrests12 > 0  => 12,
    attr_arrests24 > 0  => 24,
    attr_arrests36 > 0  => 36,
    attr_arrests60 > 0  => 60,
    attr_arrests > 0    => 99,
                           100) );

_liens_unrel_cj_first_seen := __common__(  common.sas_date((string)(liens_unrel_CJ_first_seen)) );

f_mos_liens_unrel_cj_fseen_d := __common__(  map(
    not(truedid)                      => NULL,
    _liens_unrel_cj_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)))), 999)) );

_liens_unrel_cj_last_seen := __common__(  common.sas_date((string)(liens_unrel_CJ_last_seen)) );

f_mos_liens_unrel_cj_lseen_d := __common__(  map(
    not(truedid)                     => NULL,
    _liens_unrel_cj_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)))), 999))) );

f_liens_unrel_cj_total_amt_i := __common__(  if(not(truedid), NULL, liens_unrel_CJ_total_amount) );

_liens_rel_cj_first_seen := __common__(  common.sas_date((string)(liens_rel_CJ_first_seen)) );

f_mos_liens_rel_cj_fseen_d := __common__(  map(
    not(truedid)                    => NULL,
    _liens_rel_cj_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)))), 999)) );

_liens_rel_cj_last_seen := __common__(  common.sas_date((string)(liens_rel_CJ_last_seen)) );

f_mos_liens_rel_cj_lseen_d := __common__(  map(
    not(truedid)                   => NULL,
    _liens_rel_cj_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)))), 999))) );

f_liens_rel_cj_total_amt_i := __common__(  if(not(truedid), NULL, liens_rel_CJ_total_amount) );

_liens_unrel_ft_first_seen := __common__(  common.sas_date((string)(liens_unrel_FT_first_seen)) );

f_mos_liens_unrel_ft_fseen_d := __common__(  map(
    not(truedid)                      => NULL,
    _liens_unrel_ft_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)))), 999)) );

_liens_unrel_ft_last_seen := __common__(  common.sas_date((string)(liens_unrel_FT_last_seen)) );

f_mos_liens_unrel_ft_lseen_d := __common__(  map(
    not(truedid)                     => NULL,
    _liens_unrel_ft_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)))), 999))) );

f_liens_unrel_ft_total_amt_i := __common__(  if(not(truedid), NULL, liens_unrel_FT_total_amount) );

_liens_rel_ft_first_seen := __common__(  common.sas_date((string)(liens_rel_FT_first_seen)) );

f_mos_liens_rel_ft_fseen_d := __common__(  map(
    not(truedid)                    => NULL,
    _liens_rel_ft_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12)))), 999)) );

_liens_rel_ft_last_seen := __common__(  common.sas_date((string)(liens_rel_FT_last_seen)) );

f_mos_liens_rel_ft_lseen_d := __common__(  map(
    not(truedid)                   => NULL,
    _liens_rel_ft_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12)))), 999))) );

f_liens_rel_ft_total_amt_i := __common__(  if(not(truedid), NULL, liens_rel_FT_total_amount) );

_liens_unrel_fc_first_seen := __common__(  common.sas_date((string)(liens_unrel_FC_first_seen)) );

f_mos_liens_unrel_fc_fseen_d := __common__(  map(
    not(truedid)                      => NULL,
    _liens_unrel_fc_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12)))), 999)) );

_liens_unrel_fc_last_seen := __common__(  common.sas_date((string)(liens_unrel_FC_last_seen)) );

f_mos_liens_unrel_fc_lseen_d := __common__(  map(
    not(truedid)                     => NULL,
    _liens_unrel_fc_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_fc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_fc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_fc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_fc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_fc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_fc_last_seen) / (365.25 / 12)))), 999))) );

f_liens_unrel_fc_total_amt_i := __common__(  if(not(truedid), NULL, liens_unrel_FC_total_amount) );

_liens_rel_fc_first_seen := __common__(  common.sas_date((string)(liens_rel_FC_first_seen)) );

f_mos_liens_rel_fc_fseen_d := __common__(  map(
    not(truedid)                    => NULL,
    _liens_rel_fc_first_seen = NULL => -1,
                                       min(if(if ((sysdate - _liens_rel_fc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_fc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_fc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_fc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_fc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_fc_first_seen) / (365.25 / 12)))), 999)) );

_liens_rel_fc_last_seen := __common__(  common.sas_date((string)(liens_rel_FC_last_seen)) );

f_mos_liens_rel_fc_lseen_d := __common__(  map(
    not(truedid)                   => NULL,
    _liens_rel_fc_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_fc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_fc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_fc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_fc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_fc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_fc_last_seen) / (365.25 / 12)))), 999))) );

f_liens_rel_fc_total_amt_i := __common__(  if(not(truedid), NULL, liens_rel_FC_total_amount) );

_liens_unrel_lt_first_seen := __common__(  common.sas_date((string)(liens_unrel_LT_first_seen)) );

f_mos_liens_unrel_lt_fseen_d := __common__(  map(
    not(truedid)                      => NULL,
    _liens_unrel_lt_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12)))), 999)) );

_liens_unrel_lt_last_seen := __common__(  common.sas_date((string)(liens_unrel_LT_last_seen)) );

f_mos_liens_unrel_lt_lseen_d := __common__(  map(
    not(truedid)                     => NULL,
    _liens_unrel_lt_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12)))), 999))) );

_liens_rel_lt_first_seen := __common__(  common.sas_date((string)(liens_rel_LT_first_seen)) );

f_mos_liens_rel_lt_fseen_d := __common__(  map(
    not(truedid)                    => NULL,
    _liens_rel_lt_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _liens_rel_lt_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_lt_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_lt_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_lt_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_lt_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_lt_first_seen) / (365.25 / 12)))), 999)) );

_liens_rel_lt_last_seen := __common__(  common.sas_date((string)(liens_rel_LT_last_seen)) );

f_mos_liens_rel_lt_lseen_d := __common__(  map(
    not(truedid)                   => NULL,
    _liens_rel_lt_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_lt_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_lt_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_lt_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_lt_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_lt_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_lt_last_seen) / (365.25 / 12)))), 999))) );

_liens_unrel_o_first_seen := __common__(  common.sas_date((string)(liens_unrel_O_first_seen)) );

f_mos_liens_unrel_o_fseen_d := __common__(  map(
    not(truedid)                     => NULL,
    _liens_unrel_o_first_seen = NULL => 1000,
                                        min(if(if ((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)))), 999)) );

_liens_unrel_o_last_seen := __common__(  common.sas_date((string)(liens_unrel_O_last_seen)) );

f_mos_liens_unrel_o_lseen_d := __common__(  map(
    not(truedid)                    => NULL,
    _liens_unrel_o_last_seen = NULL => 1000,
                                       max(3, min(if(if ((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12)))), 999))) );

f_liens_unrel_o_total_amt_i := __common__(  if(not(truedid), NULL, liens_unrel_O_total_amount) );

_liens_rel_o_first_seen := __common__(  common.sas_date((string)(liens_rel_O_first_seen)) );

f_mos_liens_rel_o_fseen_d := __common__(  map(
    not(truedid)                   => NULL,
    _liens_rel_o_first_seen = NULL => 1000,
                                      min(if(if ((sysdate - _liens_rel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_o_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_o_first_seen) / (365.25 / 12)))), 999)) );

_liens_rel_o_last_seen := __common__(  common.sas_date((string)(liens_rel_O_last_seen)) );

f_mos_liens_rel_o_lseen_d := __common__(  map(
    not(truedid)                  => NULL,
    _liens_rel_o_last_seen = NULL => 1000,
                                     max(3, min(if(if ((sysdate - _liens_rel_o_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_o_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_o_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_o_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_o_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_o_last_seen) / (365.25 / 12)))), 999))) );

f_liens_rel_o_total_amt_i := __common__(  if(not(truedid), NULL, liens_rel_O_total_amount) );

_liens_unrel_ot_first_seen := __common__(  common.sas_date((string)(liens_unrel_OT_first_seen)) );

f_mos_liens_unrel_ot_fseen_d := __common__(  map(
    not(truedid)                      => NULL,
    _liens_unrel_ot_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)))), 999)) );

_liens_unrel_ot_last_seen := __common__(  common.sas_date((string)(liens_unrel_OT_last_seen)) );

f_mos_liens_unrel_ot_lseen_d := __common__(  map(
    not(truedid)                     => NULL,
    _liens_unrel_ot_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)))), 999))) );

f_liens_unrel_ot_total_amt_i := __common__(  if(not(truedid), NULL, liens_unrel_OT_total_amount) );

_liens_rel_ot_first_seen := __common__(  common.sas_date((string)(liens_rel_OT_first_seen)) );

f_mos_liens_rel_ot_fseen_d := __common__(  map(
    not(truedid)                    => NULL,
    _liens_rel_ot_first_seen = NULL => -1,
                                       min(if(if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)))), 999)) );

_liens_rel_ot_last_seen := __common__(  common.sas_date((string)(liens_rel_OT_last_seen)) );

f_mos_liens_rel_ot_lseen_d := __common__(  map(
    not(truedid)                   => NULL,
    _liens_rel_ot_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)))), 999))) );

f_liens_rel_ot_total_amt_i := __common__(  if(not(truedid), NULL, liens_rel_OT_total_amount) );

_liens_unrel_sc_first_seen := __common__(  common.sas_date((string)(liens_unrel_SC_first_seen)) );

f_mos_liens_unrel_sc_fseen_d := __common__(  map(
    not(truedid)                      => NULL,
    _liens_unrel_sc_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)))), 999)) );

_liens_unrel_sc_last_seen := __common__(  common.sas_date((string)(liens_unrel_SC_last_seen)) );

f_mos_liens_unrel_sc_lseen_d := __common__(  map(
    not(truedid)                     => NULL,
    _liens_unrel_sc_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - liens_unrel_SC_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - liens_unrel_SC_last_seen) / (365.25 / 12)), roundup((sysdate - liens_unrel_SC_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - liens_unrel_SC_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - liens_unrel_SC_last_seen) / (365.25 / 12)), roundup((sysdate - liens_unrel_SC_last_seen) / (365.25 / 12)))), 999))) );

f_liens_unrel_sc_total_amt_i := __common__(  if(not(truedid), NULL, liens_unrel_SC_total_amount) );

f_foreclosure_flag_i := __common__(  if(not(truedid), NULL, foreclosure_flag) );

_foreclosure_last_date := __common__(  common.sas_date((string)(foreclosure_last_date)) );

f_mos_foreclosure_lseen_d := __common__(  map(
    not(truedid)                  => NULL,
    _foreclosure_last_date = NULL => 1000,
                                     max(3, min(if(if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12)))), 999))) );

k_estimated_income_d := __common__(  if(not(truedid), NULL, estimated_income) );

r_wealth_index_d := __common__(  if(not(truedid), NULL, wealth_index) );

f_college_income_d := __common__(  map(
    not(truedid)                     => NULL,
    college_income_level_code = ''	 => NULL,
    college_income_level_code = 'A'  => 1,
    college_income_level_code = 'B'  => 2,
    college_income_level_code = 'C'  => 3,
    college_income_level_code = 'D'  => 4,
    college_income_level_code = 'E'  => 5,
    college_income_level_code = 'F'  => 6,
    college_income_level_code = 'G'  => 7,
    college_income_level_code = 'H'  => 8,
    college_income_level_code = 'I'  => 9,
    college_income_level_code = 'J'  => 10,
    college_income_level_code = 'K'  => 11,
                                        NULL) );

f_has_relatives_n := __common__(  if(rel_count > 0, 1, 0) );

f_rel_count_i := __common__(  if(not(truedid), NULL, min(if(rel_count = NULL, -NULL, rel_count), 999)) );

f_rel_incomeover25_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count, rel_incomeunder50_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count)))) );

f_rel_incomeover50_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count)))) );

f_rel_incomeover75_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count)))) );

f_rel_incomeover100_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_incomeover100_count) );

f_rel_homeover50_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))) );

f_rel_homeover100_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))) );

f_rel_homeover150_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))) );

f_rel_homeover200_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))) );

f_rel_homeover300_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))) );

f_rel_homeover500_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_homeover500_count) );

f_rel_ageover20_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))) );

f_rel_ageover30_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))) );

f_rel_ageover40_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))) );

f_rel_ageover50_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))) );

f_rel_ageover60_count_d_1 := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))) );

f_rel_ageover60_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_ageover70_count) );

f_rel_educationover8_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_educationunder12_count, rel_educationover12_count) = NULL, NULL, sum(if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count), if(rel_educationover12_count = NULL, 0, rel_educationover12_count)))) );

f_rel_educationover12_count_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_educationover12_count) );

f_crim_rel_under25miles_cnt_i := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     crim_rel_within25miles) );

f_crim_rel_under100miles_cnt_i := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(crim_rel_within25miles, crim_rel_within100miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles)))) );

f_crim_rel_under500miles_cnt_i := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles)))) );

f_rel_under25miles_cnt_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_within25miles_count) );

f_rel_under100miles_cnt_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count)))) );

f_rel_under500miles_cnt_d := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count)))) );

f_rel_bankrupt_count_i := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 999)) );

f_rel_criminal_count_i := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_criminal_count = NULL, -NULL, rel_criminal_count), 999)) );

f_rel_felony_count_i := __common__(  map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 999)) );

f_current_count_d := __common__(  if(not(truedid), NULL, min(if(current_count = NULL, -NULL, current_count), 999)) );

f_historical_count_d := __common__(  if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999)) );

f_accident_count_i := __common__(  if(not(truedid), NULL, min(if(acc_count = NULL, -NULL, acc_count), 999)) );

f_acc_damage_amt_total_i := __common__(  if(not(truedid), NULL, acc_damage_amt_total) );

_acc_last_seen := __common__(  common.sas_date((string)(acc_last_seen)) );

f_mos_acc_lseen_d := __common__(  map(
    not(truedid)          => NULL,
    _acc_last_seen = NULL => 1000,
                             max(3, min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999))) );

f_acc_damage_amt_last_i := __common__(  if(not(truedid), NULL, acc_damage_amt_last) );

f_acc_damage_amt_last_1mo_i := __common__(  map(
    not(truedid)     => NULL,
    acc_count_30 = 0 => -1,
                        acc_damage_amt_last) );

f_acc_damage_amt_last_3mos_i := __common__(  map(
    not(truedid)     => NULL,
    acc_count_90 = 0 => -1,
                        acc_damage_amt_last) );

f_acc_damage_amt_last_6mos_i := __common__(  map(
    not(truedid)      => NULL,
    acc_count_180 = 0 => -1,
                         acc_damage_amt_last) );

f_accident_recency_d := __common__(  map(
    not(truedid)  		=> NULL,
    acc_count_30 > 0 	=> 1,
    acc_count_90 > 0  => 3,
    acc_count_180 > 0 => 6,
    acc_count_12 > 0  => 12,
    acc_count_24 > 0  => 24,
    acc_count_36 > 0  => 36,
    acc_count_60 > 0  => 60,
    acc_count > 0     => 61,
												 62) );

f_idrisktype_i := __common__(  if(not(truedid) or fp_idrisktype = '', NULL, (integer)fp_idrisktype) );

f_idverrisktype_i := __common__(  if(not(truedid) or fp_idverrisktype = '', NULL, (integer)fp_idverrisktype) );

f_sourcerisktype_i := __common__(  map(
    not(truedid)             => NULL,
    fp_sourcerisktype = ''	 => NULL,
                                (integer)fp_sourcerisktype) );

f_varrisktype_i := __common__(  map(
    not(truedid)          => NULL,
    fp_varrisktype = ''	  => NULL,
                             (integer)fp_varrisktype) );

f_varmsrcssncount_i := __common__(  if(not(truedid), NULL, min(if(fp_varmsrcssncount = '', -NULL, (integer)fp_varmsrcssncount), 999)) );

f_varmsrcssnunrelcount_i := __common__(  if(not(truedid), NULL, min(if(fp_varmsrcssnunrelcount = '', -NULL, (integer)fp_varmsrcssnunrelcount), 999)) );

f_vardobcount_i := __common__(  if(not(truedid), NULL, min(if(fp_vardobcount = '', -NULL, (integer)fp_vardobcount), 999)) );

f_vardobcountnew_i := __common__(  if(not(truedid), NULL, min(if(fp_vardobcountnew = '', -NULL, (integer)fp_vardobcountnew), 999)) );

f_srchvelocityrisktype_i := __common__(  map(
    not(truedid)                   => NULL,
    fp_srchvelocityrisktype = ''	 => NULL,
                                      (integer)fp_srchvelocityrisktype) );

f_srchcountwk_i := __common__(  if(not(truedid), NULL, min(if(fp_srchcountwk = '', -NULL, (integer)fp_srchcountwk), 999)) );

f_srchcountday_i := __common__(  if(not(truedid), NULL, min(if(fp_srchcountday = '', -NULL, (integer)fp_srchcountday), 999)) );

f_srchunvrfdssncount_i := __common__(  if(not(truedid), NULL, min(if(fp_srchunvrfdssncount = '', -NULL, (integer)fp_srchunvrfdssncount), 999)) );

f_srchunvrfdaddrcount_i := __common__(  if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = '', -NULL, (integer)fp_srchunvrfdaddrcount), 999)) );

f_srchunvrfddobcount_i := __common__(  if(not(truedid), NULL, min(if(fp_srchunvrfddobcount = '', -NULL, (integer)fp_srchunvrfddobcount), 999)) );

f_srchunvrfdphonecount_i := __common__(  if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (integer)fp_srchunvrfdphonecount), 999)) );

f_srchfraudsrchcount_i := __common__(  if(not(truedid), NULL, min(if(fp_srchfraudsrchcount = '', -NULL, (integer)fp_srchfraudsrchcount), 999)) );

f_srchfraudsrchcountyr_i := __common__(  if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (integer)fp_srchfraudsrchcountyr), 999)) );

f_srchfraudsrchcountmo_i := __common__(  if(not(truedid), NULL, min(if(fp_srchfraudsrchcountmo = '', -NULL, (integer)fp_srchfraudsrchcountmo), 999)) );

f_srchfraudsrchcountwk_i := __common__(  if(not(truedid), NULL, min(if(fp_srchfraudsrchcountwk = '', -NULL, (integer)fp_srchfraudsrchcountwk), 999)) );

f_srchfraudsrchcountday_i := __common__(  if(not(truedid), NULL, min(if(fp_srchfraudsrchcountday = '', -NULL, (integer)fp_srchfraudsrchcountday), 999)) );

f_srchlocatesrchcountwk_i := __common__(  if(not(truedid), NULL, min(if(fp_srchlocatesrchcountwk = '', -NULL, (integer)fp_srchlocatesrchcountwk), 999)) );

f_srchlocatesrchcountday_i := __common__(  if(not(truedid), NULL, min(if(fp_srchlocatesrchcountday = '', -NULL, (integer)fp_srchlocatesrchcountday), 999)) );

f_assocrisktype_i := __common__(  map(
    not(truedid)            => NULL,
    fp_assocrisktype = ''	  => NULL,
                               (integer)fp_assocrisktype) );

f_assocsuspicousidcount_i := __common__(  if(not(truedid), NULL, min(if(fp_assocsuspicousidcount = '', -NULL, (integer)fp_assocsuspicousidcount), 999)) );

f_assoccredbureaucount_i := __common__(  if(not(truedid), NULL, min(if(fp_assoccredbureaucount = '', -NULL, (integer)fp_assoccredbureaucount), 999)) );

f_assoccredbureaucountnew_i := __common__(  if(not(truedid), NULL, (integer)fp_assoccredbureaucountnew) );

f_assoccredbureaucountmo_i := __common__(  if(not(truedid), NULL, (integer)fp_assoccredbureaucountmo) );

f_validationrisktype_i := __common__(  map(
    not(truedid)                 => NULL,
    fp_validationrisktype = ''	 => NULL,
                                    (integer)fp_validationrisktype) );

f_corrrisktype_i := __common__(  map(
    not(truedid)           => NULL,
    fp_corrrisktype = ''	 => NULL,
                              (integer)fp_corrrisktype) );

f_corrssnnamecount_d := __common__(  if(not(truedid), NULL, min(if(fp_corrssnnamecount = '', -NULL, (integer)fp_corrssnnamecount), 999)) );

f_corrssnaddrcount_d := __common__(  if(not(truedid), NULL, min(if(fp_corrssnaddrcount = '', -NULL, (integer)fp_corrssnaddrcount), 999)) );

f_corraddrnamecount_d := __common__(  if(not(truedid), NULL, min(if(fp_corraddrnamecount = '', -NULL, (integer)fp_corraddrnamecount), 999)) );

f_corraddrphonecount_d := __common__(  if(not(truedid), NULL, min(if(fp_corraddrphonecount = '', -NULL, (integer)fp_corraddrphonecount), 999)) );

f_corrphonelastnamecount_d := __common__(  if(not(truedid), NULL, min(if(fp_corrphonelastnamecount = '', -NULL, (integer)fp_corrphonelastnamecount), 999)) );

f_divrisktype_i := __common__(  map(
    not(truedid)          => NULL,
    fp_divrisktype = ''	  => NULL,
                             (integer)fp_divrisktype) );

f_divssnidmsrcurelcount_i := __common__(  if(not(truedid), NULL, min(if(fp_divssnidmsrcurelcount = '', -NULL, (integer)fp_divssnidmsrcurelcount), 999)) );

f_divaddrsuspidcountnew_i := __common__(  if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = '', -NULL, (integer)fp_divaddrsuspidcountnew), 999)) );

f_divsrchaddrsuspidcount_i := __common__(  if(not(truedid), NULL, min(if(fp_divsrchaddrsuspidcount = '', -NULL, (integer)fp_divsrchaddrsuspidcount), 999)) );

f_srchcomponentrisktype_i := __common__(  map(
    not(truedid)                    => NULL,
    fp_srchcomponentrisktype = ''	  => NULL,
                                       (integer)fp_srchcomponentrisktype) );

f_srchssnsrchcount_i := __common__(  if(not(truedid), NULL, min(if(fp_srchssnsrchcount = '', -NULL, (integer)fp_srchssnsrchcount), 999)) );

f_srchssnsrchcountmo_i := __common__(  if(not(truedid), NULL, min(if(fp_srchssnsrchcountmo = '', -NULL, (integer)fp_srchssnsrchcountmo), 999)) );

f_srchssnsrchcountwk_i := __common__(  if(not(truedid), NULL, min(if(fp_srchssnsrchcountwk = '', -NULL, (integer)fp_srchssnsrchcountwk), 999)) );

f_srchssnsrchcountday_i := __common__(  if(not(truedid), NULL, min(if(fp_srchssnsrchcountday = '', -NULL, (integer)fp_srchssnsrchcountday), 999)) );

f_srchaddrsrchcount_i := __common__(  if(not(truedid), NULL, min(if(fp_srchaddrsrchcount = '', -NULL, (integer)fp_srchaddrsrchcount), 999)) );

f_srchaddrsrchcountmo_i := __common__(  if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = '', -NULL, (integer)fp_srchaddrsrchcountmo), 999)) );

f_srchaddrsrchcountwk_i := __common__(  if(not(truedid), NULL, min(if(fp_srchaddrsrchcountwk = '', -NULL, (integer)fp_srchaddrsrchcountwk), 999)) );

f_srchaddrsrchcountday_i := __common__(  if(not(truedid), NULL, min(if(fp_srchaddrsrchcountday = '', -NULL, (integer)fp_srchaddrsrchcountday), 999)) );

f_srchphonesrchcount_i := __common__(  if(not(truedid), NULL, min(if(fp_srchphonesrchcount = '', -NULL, (integer)fp_srchphonesrchcount), 999)) );

f_srchphonesrchcountmo_i := __common__(  if(not(truedid), NULL, min(if(fp_srchphonesrchcountmo = '', -NULL, (integer)fp_srchphonesrchcountmo), 999)) );

f_srchphonesrchcountwk_i := __common__(  if(not(truedid), NULL, min(if(fp_srchphonesrchcountwk = '', -NULL, (integer)fp_srchphonesrchcountwk), 999)) );

f_srchphonesrchcountday_i := __common__(  if(not(truedid), NULL, min(if(fp_srchphonesrchcountday = '', -NULL, (integer)fp_srchphonesrchcountday), 999)) );

f_componentcharrisktype_i := __common__(  map(
    not(truedid)                    => NULL,
    fp_componentcharrisktype = ''	  => NULL,
                                       (integer)fp_componentcharrisktype) );

f_inputaddractivephonelist_d := __common__(  map(
    not(truedid)                     => NULL,
    fp_inputaddractivephonelist = '-1' => 0,
                                        (integer)fp_inputaddractivephonelist) );

f_addrchangeincomediff_d_1 := __common__(  if(not(truedid), NULL, NULL) );

f_addrchangeincomediff_d := __common__(  if(fp_addrchangeincomediff = '-1', NULL, (integer)fp_addrchangeincomediff) );

f_addrchangevaluediff_d := __common__(  map(
    not(truedid)                => NULL,
    fp_addrchangevaluediff = '-1' => NULL,
                                   (integer)fp_addrchangevaluediff) );

f_addrchangecrimediff_i := __common__(  map(
    not(truedid)                => NULL,
    fp_addrchangecrimediff = '-1' => NULL,
                                   (integer)fp_addrchangecrimediff) );

f_addrchangeecontrajindex_d := __common__(  if(not(truedid) or fp_addrchangeecontrajindex = '-1' or fp_addrchangeecontrajindex = '', NULL, (integer)fp_addrchangeecontrajindex) );

f_curraddractivephonelist_d := __common__(  map(
    // not(truedid)                    => NULL,	//kh-delta
    not(add_curr_pop)                 => NULL,
    fp_curraddractivephonelist = '-1' => NULL,	//kh-changed from 0 to NULL
                                       (integer)fp_curraddractivephonelist) );

// f_curraddrmedianincome_d := __common__(  if(not(truedid), NULL, (integer)fp_curraddrmedianincome) );	//kh-delta
f_curraddrmedianincome_d := __common__(  if(not(add_curr_pop), NULL, (integer)fp_curraddrmedianincome) );

// f_curraddrmedianvalue_d := __common__(  if(not(truedid), NULL, (integer)fp_curraddrmedianvalue) );	//kh-delta
f_curraddrmedianvalue_d := __common__(  if(not(add_curr_pop), NULL, (integer)fp_curraddrmedianvalue) );

// f_curraddrmurderindex_i := __common__(  if(not(truedid), NULL, (integer)fp_curraddrmurderindex) );	//kh-delta
f_curraddrmurderindex_i := __common__(  if(not(add_curr_pop), NULL, (integer)fp_curraddrmurderindex) );

// f_curraddrcartheftindex_i := __common__(  if(not(truedid), NULL, (integer)fp_curraddrcartheftindex) );	//kh-delta
f_curraddrcartheftindex_i := __common__(  if(not(add_curr_pop), NULL, (integer)fp_curraddrcartheftindex) );

// f_curraddrburglaryindex_i := __common__(  if(not(truedid), NULL, (integer)fp_curraddrburglaryindex) );	//kh-delta
f_curraddrburglaryindex_i := __common__(  if(not(add_curr_pop), NULL, (integer)fp_curraddrburglaryindex) );

// f_curraddrcrimeindex_i := __common__(  if(not(truedid), NULL, (integer)fp_curraddrcrimeindex) );	//kh-delta
f_curraddrcrimeindex_i := __common__(  if(not(add_curr_pop), NULL, (integer)fp_curraddrcrimeindex) );

f_prevaddrageoldest_d := __common__(  if(not(truedid), NULL, min(if(fp_prevaddrageoldest = '', -NULL, (integer)fp_prevaddrageoldest), 999)) );

f_prevaddrlenofres_d := __common__(  if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (integer)fp_prevaddrlenofres), 999)) );

f_prevaddrdwelltype_apt_n := __common__(  if(not(truedid), NULL, (integer)(fp_prevaddrdwelltype = 'H')) );

f_prevaddrdwelltype_sfd_n := __common__(  if(not(truedid), NULL, (integer)(fp_prevaddrdwelltype = 'S')) );

f_prevaddrstatus_i := __common__(  map(
    not(truedid)            => NULL,
    fp_prevaddrstatus = '0' => 1,
    fp_prevaddrstatus = 'U' => 2,
    fp_prevaddrstatus = 'R' => 3,
                               NULL) );

f_prevaddroccupantowned_i := __common__(  map(
    not(truedid)                    => NULL,
    fp_prevaddroccupantowned = ''	  => NULL,
                                       (integer)fp_prevaddroccupantowned) );

f_prevaddrmedianincome_d := __common__(  if(not(truedid), NULL, (integer)fp_prevaddrmedianincome) );

f_prevaddrmedianvalue_d := __common__(  if(not(truedid), NULL, (integer)fp_prevaddrmedianvalue) );

f_prevaddrmurderindex_i := __common__(  if(not(truedid), NULL, (integer)fp_prevaddrmurderindex) );

f_prevaddrcartheftindex_i := __common__(  if(not(truedid), NULL, (integer)fp_prevaddrcartheftindex) );

f_fp_prevaddrburglaryindex_i := __common__(  if(not(truedid), NULL, (integer)fp_prevaddrburglaryindex) );

f_fp_prevaddrcrimeindex_i := __common__(  if(not(truedid), NULL, (integer)fp_prevaddrcrimeindex) );

r_s65_ssn_deceased_i := __common__(  map(
    not(truedid or ssnlength > 0)                                          => NULL,
    rc_decsflag = 1                                                        => 1,
    rc_ssndod != 0                                                         => 1,
    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => 1,
    rc_decsflag = 0                                                        => 0,
                                                                              NULL) );

r_d31_all_bk_i := __common__(  map(
    not(truedid)                                                                                                                                                                                                                                                                                    => NULL,
		//kh-changed to check for truncated string
    StringLib.StringToUpperCase(disposition[1..7]) = 'DISMISS' or if(max(bk_dismissed_recent_count, bk_dismissed_historical_count) = NULL, NULL, sum(if(bk_dismissed_recent_count = NULL, 0, bk_dismissed_recent_count), if(bk_dismissed_historical_count = NULL, 0, bk_dismissed_historical_count))) > 0 => 1,
    StringLib.StringToUpperCase(disposition[1..8]) = 'DISCHARG' or if(max(bk_disposed_recent_count, bk_disposed_historical_count) = NULL, NULL, sum(if(bk_disposed_recent_count = NULL, 0, bk_disposed_recent_count), if(bk_disposed_historical_count = NULL, 0, bk_disposed_historical_count))) > 0      => 2,
    bankrupt = 1 or filing_count > 0                                                                                                                                                                                                                                                                => 3,
                                                                                                                                                                                                                                                                                                       0) );
//kh-changed this variable to populate as an integer as this is what the FLAPS sub model expects
// r_d31_bk_chapter_n := __common__(  map(
    // not(truedid)                                 => '',
    // not((bk_chapter in ['7', '11', '12', '13'])) => '',
                                                    // trim(bk_chapter, LEFT)) );
																										
r_d31_bk_chapter_n := __common__(  map(
    not(truedid)                                 => NULL,
    not((bk_chapter in ['7', '11', '12', '13'])) => NULL,
                                                    (integer)bk_chapter) );

r_d31_bk_dism_recent_count_i := __common__(  if(not(truedid), NULL, min(if(bk_dismissed_recent_count = NULL, -NULL, bk_dismissed_recent_count), 999)) );

r_d31_bk_dism_hist_count_i := __common__(  if(not(truedid), NULL, min(if(bk_dismissed_historical_count = NULL, -NULL, bk_dismissed_historical_count), 999)) );

r_c22_stl_inq_count90_i := __common__(  if(not(truedid), NULL, min(if(STL_Inq_count90 = NULL, -NULL, STL_Inq_count90), 999)) );

r_c22_stl_inq_count180_i := __common__(  if(not(truedid), NULL, min(if(STL_Inq_count180 = NULL, -NULL, STL_Inq_count180), 999)) );

r_c22_stl_inq_count12_i := __common__(  if(not(truedid), NULL, min(if(STL_Inq_count12 = NULL, -NULL, STL_Inq_count12), 999)) );

r_c22_stl_inq_count24_i := __common__(  if(not(truedid), NULL, min(if(STL_Inq_count24 = NULL, -NULL, STL_Inq_count24), 999)) );

r_c22_stl_recency_d := __common__(  map(
    not(truedid)         => NULL,
    stl_inq_count90 > 0  => 3,
    stl_inq_count180 > 0 => 6,
    stl_inq_count12 > 0  => 12,
    stl_inq_count24 > 0  => 24,
                            0) );

r_c12_source_profile_d := __common__(  if(not(truedid), NULL, hdr_source_profile) );

r_c12_source_profile_index_d := __common__(  if(not(truedid), NULL, hdr_source_profile_index) );

r_f01_inp_addr_not_verified_i := __common__(  if(not(add_input_pop and truedid), NULL, add_input_addr_not_verified) );

r_c23_inp_addr_occ_index_d := __common__(  if(not(add_input_pop and truedid), NULL, add_input_occ_index) );

r_c23_inp_addr_owned_not_occ_d := __common__(  if(not(add_input_pop and truedid), NULL, add_input_owned_not_occ) );

r_f04_curr_add_occ_index_d := __common__(  if(not(truedid and add_curr_pop), NULL, add_curr_occ_index) );

r_e55_college_ind_d := __common__(  map(
    not(truedid)                           => NULL,
    (college_file_type in ['H', 'C', 'A']) => 1,
    college_attendance                     => 1,
                                              0) );

r_e57_br_source_count_d := __common__(  if(not(truedid), NULL, br_source_count) );

r_i60_inq_prepaidcards_count12_i := __common__(  if(not(truedid), NULL, min(if(inq_PrepaidCards_count12 = NULL, -NULL, inq_PrepaidCards_count12), 999)) );

r_i60_inq_prepaidcards_recency_d := __common__(  map(
    not(truedid)             		 => NULL,
    inq_PrepaidCards_count01 > 0 => 1,
    inq_PrepaidCards_count03 > 0 => 3,
    inq_PrepaidCards_count06 > 0 => 6,
    inq_PrepaidCards_count12 > 0 => 12,
    inq_PrepaidCards_count24 > 0 => 24,
    inq_PrepaidCards_count   > 0 => 99,
																		999) );

r_i60_inq_retpymt_count12_i := __common__(  if(not(truedid), NULL, min(if(inq_retailpayments_count12 = NULL, -NULL, inq_retailpayments_count12), 999)) );

r_i60_inq_retpymt_recency_d := __common__(  map(
    not(truedid)               		 => NULL,
    inq_retailpayments_count01 > 0 => 1,
    inq_retailpayments_count03 > 0 => 3,
    inq_retailpayments_count06 > 0 => 6,
    inq_retailpayments_count12 > 0 => 12,
    inq_retailpayments_count24 > 0 => 24,
    inq_retailpayments_count   > 0 => 99,
																			999) );

r_i60_inq_stdloan_count12_i := __common__(  if(not(truedid), NULL, min(if(inq_studentloan_count12 = NULL, -NULL, inq_studentloan_count12), 999)) );

r_i60_inq_stdloan_recency_d := __common__(  map(
    not(truedid)            		=> NULL,
    inq_studentloan_count01 > 0 => 1,
    inq_studentloan_count03 > 0 => 3,
    inq_studentloan_count06 > 0 => 6,
    inq_studentloan_count12 > 0 => 12,
    inq_studentloan_count24 > 0 => 24,
    inq_studentloan_count   > 0 => 99,
																	 999) );

r_i60_inq_util_count12_i := __common__(  if(not(truedid), NULL, min(if(inq_utilities_count12 = NULL, -NULL, inq_utilities_count12), 999)) );

r_i60_inq_util_recency_d := __common__(  map(
    not(truedid)          		=> NULL,
    inq_utilities_count01 > 0 => 1,
    inq_utilities_count03 > 0 => 3,
    inq_utilities_count06 > 0 => 6,
    inq_utilities_count12 > 0 => 12,
    inq_utilities_count24 > 0 => 24,
    inq_utilities_count   > 0 => 99,
																 999) );

f_phone_ver_insurance_d := __common__(  if(not(truedid) or phone_ver_insurance = '-1', NULL, (integer)phone_ver_insurance) );

f_phone_ver_experian_d := __common__(  if(not(truedid) or phone_ver_experian = '-1', NULL, (integer)phone_ver_experian) );

f_addrs_per_ssn_i := __common__(  if(not(ssnlength > 0), NULL, min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 999)) );

// f_phones_per_addr_curr_i := __common__(  if(not(addrpop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999)) );	//kh-delta
f_phones_per_addr_curr_i := __common__(  if(not(add_curr_pop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999)) );

f_addrs_per_ssn_c6_i := __common__(  if(not(ssnlength > 0), NULL, min(if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6), 999)) );

f_phones_per_addr_c6_i := __common__(  if(not(addrpop), NULL, min(if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6), 999)) );

f_adls_per_phone_c6_i := __common__(  if(not(hphnpop), NULL, min(if(adls_per_phone_c6 = NULL, -NULL, adls_per_phone_c6), 999)) );

f_dl_addrs_per_adl_i := __common__(  if(not(truedid), NULL, min(if(dl_addrs_per_adl = NULL, -NULL, dl_addrs_per_adl), 999)) );

f_inq_email_ver_count_i := __common__(  if(not(truedid), NULL, min(if(inq_email_ver_count = NULL, -NULL, inq_email_ver_count), 999)) );

f_inq_count_day_i := __common__(  if(not(truedid), NULL, min(if(inq_count_day = NULL, -NULL, inq_count_day), 999)) );

f_inq_count_week_i := __common__(  if(not(truedid), NULL, min(if(inq_count_week = NULL, -NULL, inq_count_week), 999)) );

f_inq_auto_count_day_i := __common__(  if(not(truedid), NULL, min(if(inq_Auto_count_day = NULL, -NULL, inq_Auto_count_day), 999)) );

f_inq_auto_count_week_i := __common__(  if(not(truedid), NULL, min(if(inq_Auto_count_week = NULL, -NULL, inq_Auto_count_week), 999)) );

f_inq_banking_count_day_i := __common__(  if(not(truedid), NULL, min(if(inq_Banking_count_day = NULL, -NULL, inq_Banking_count_day), 999)) );

f_inq_banking_count_week_i := __common__(  if(not(truedid), NULL, min(if(inq_Banking_count_week = NULL, -NULL, inq_Banking_count_week), 999)) );

f_inq_collection_count_day_i := __common__(  if(not(truedid), NULL, min(if(inq_Collection_count_day = NULL, -NULL, inq_Collection_count_day), 999)) );

f_inq_collection_count_week_i := __common__(  if(not(truedid), NULL, min(if(inq_Collection_count_week = NULL, -NULL, inq_Collection_count_week), 999)) );

f_inq_communications_cnt_day_i := __common__(  if(not(truedid), NULL, min(if(inq_Communications_count_day = NULL, -NULL, inq_Communications_count_day), 999)) );

f_inq_communications_cnt_week_i := __common__(  if(not(truedid), NULL, min(if(inq_Communications_count_week = NULL, -NULL, inq_Communications_count_week), 999)) );

f_inq_highriskcredit_cnt_day_i := __common__(  if(not(truedid), NULL, min(if(inq_HighRiskCredit_count_day = NULL, -NULL, inq_HighRiskCredit_count_day), 999)) );

f_inq_highriskcredit_cnt_week_i := __common__(  if(not(truedid), NULL, min(if(inq_HighRiskCredit_count_week = NULL, -NULL, inq_HighRiskCredit_count_week), 999)) );

f_inq_mortgage_count_day_i := __common__(  if(not(truedid), NULL, min(if(inq_Mortgage_count_day = NULL, -NULL, inq_Mortgage_count_day), 999)) );

f_inq_mortgage_count_week_i := __common__(  if(not(truedid), NULL, min(if(inq_Mortgage_count_week = NULL, -NULL, inq_Mortgage_count_week), 999)) );

f_inq_other_count_day_i := __common__(  if(not(truedid), NULL, min(if(inq_Other_count_day = NULL, -NULL, inq_Other_count_day), 999)) );

f_inq_other_count_week_i := __common__(  if(not(truedid), NULL, min(if(inq_Other_count_week = NULL, -NULL, inq_Other_count_week), 999)) );

f_inq_prepaidcards_count_i := __common__(  if(not(truedid), NULL, min(if(inq_PrepaidCards_count = NULL, -NULL, inq_PrepaidCards_count), 999)) );

f_inq_prepaidcards_count_day_i := __common__(  if(not(truedid), NULL, min(if(inq_PrepaidCards_count_day = NULL, -NULL, inq_PrepaidCards_count_day), 999)) );

f_inq_prepaidcards_count_week_i := __common__(  if(not(truedid), NULL, min(if(inq_PrepaidCards_count_week = NULL, -NULL, inq_PrepaidCards_count_week), 999)) );

f_inq_prepaidcards_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_PrepaidCards_count24 = NULL, -NULL, inq_PrepaidCards_count24), 999)) );

f_inq_quizprovider_count_i := __common__(  if(not(truedid), NULL, min(if(inq_QuizProvider_count = NULL, -NULL, inq_QuizProvider_count), 999)) );

f_inq_quizprovider_count_day_i := __common__(  if(not(truedid), NULL, min(if(inq_QuizProvider_count_day = NULL, -NULL, inq_QuizProvider_count_day), 999)) );

f_inq_quizprovider_count_week_i := __common__(  if(not(truedid), NULL, min(if(inq_QuizProvider_count_week = NULL, -NULL, inq_QuizProvider_count_week), 999)) );

f_inq_quizprovider_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_QuizProvider_count24 = NULL, -NULL, inq_QuizProvider_count24), 999)) );

f_inq_retail_count_day_i := __common__(  if(not(truedid), NULL, min(if(inq_Retail_count_day = NULL, -NULL, inq_Retail_count_day), 999)) );

f_inq_retail_count_week_i := __common__(  if(not(truedid), NULL, min(if(inq_Retail_count_week = NULL, -NULL, inq_Retail_count_week), 999)) );

f_inq_retailpayments_cnt_i := __common__(  if(not(truedid), NULL, min(if(inq_RetailPayments_count = NULL, -NULL, inq_RetailPayments_count), 999)) );

f_inq_retailpayments_cnt_day_i := __common__(  if(not(truedid), NULL, min(if(inq_RetailPayments_count_day = NULL, -NULL, inq_RetailPayments_count_day), 999)) );

f_inq_retailpayments_cnt_week_i := __common__(  if(not(truedid), NULL, min(if(inq_RetailPayments_count_week = NULL, -NULL, inq_RetailPayments_count_week), 999)) );

f_inq_retailpayments_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_RetailPayments_count24 = NULL, -NULL, inq_RetailPayments_count24), 999)) );

f_inq_studentloan_count_i := __common__(  if(not(truedid), NULL, min(if(inq_StudentLoan_count = NULL, -NULL, inq_StudentLoan_count), 999)) );

f_inq_studentloan_count_day_i := __common__(  if(not(truedid), NULL, min(if(inq_StudentLoan_count_day = NULL, -NULL, inq_StudentLoan_count_day), 999)) );

f_inq_studentloan_count_week_i := __common__(  if(not(truedid), NULL, min(if(inq_StudentLoan_count_week = NULL, -NULL, inq_StudentLoan_count_week), 999)) );

f_inq_studentloan_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_StudentLoan_count24 = NULL, -NULL, inq_StudentLoan_count24), 999)) );

f_inq_utilities_count_i := __common__(  if(not(truedid), NULL, min(if(inq_Utilities_count = NULL, -NULL, inq_Utilities_count), 999)) );

f_inq_utilities_count_day_i := __common__(  if(not(truedid), NULL, min(if(inq_Utilities_count_day = NULL, -NULL, inq_Utilities_count_day), 999)) );

f_inq_utilities_count_week_i := __common__(  if(not(truedid), NULL, min(if(inq_Utilities_count_week = NULL, -NULL, inq_Utilities_count_week), 999)) );

f_inq_utilities_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_Utilities_count24 = NULL, -NULL, inq_Utilities_count24), 999)) );

f_inq_billgrp_count_i := __common__(  if(not(truedid), NULL, min(if(inq_billgroup_count = NULL, -NULL, inq_billgroup_count), 999)) );

f_inq_billgrp_count24_i := __common__(  if(not(truedid), NULL, min(if(inq_billgroup_count24 = NULL, -NULL, inq_billgroup_count24), 999)) );

f_inq_email_per_adl_i := __common__(  if(not(truedid), NULL, min(if(inq_email_per_adl = NULL, -NULL, inq_email_per_adl), 999)) );

f_inq_adls_per_email_i := __common__(  if(not(emailpop), NULL, min(if(inq_adls_per_email = NULL, -NULL, inq_adls_per_email), 999)) );

f_nae_email_verd_d := __common__(  (integer)((integer)email_name_addr_verification in [2, 3, 4, 5, 6, 7, 8]) );

f_nae_addr_verd_d := __common__(  (integer)((integer)email_name_addr_verification in [3, 6, 7, 8]) );

f_nae_lname_verd_d := __common__(  (integer)((integer)email_name_addr_verification in [4, 5, 7, 8]) );

f_nae_fname_verd_d := __common__(  (integer)((integer)email_name_addr_verification in [2, 5, 6, 8]) );

f_nae_nothing_found_i := __common__(  (integer)((integer)email_name_addr_verification = 0) );

f_nae_contradictory_i := __common__(  (integer)((integer)email_name_addr_verification = 1) );

f_adl_per_email_i := __common__(  if(not(emailpop), NULL, min(if(adl_per_email = NULL, -NULL, adl_per_email), 999)) );

r_c20_email_verification_d := __common__(  if(not(emailpop), NULL, email_verification) );

f_vf_hi_risk_ct_i := __common__(  if(not(truedid), NULL, min(if(vf_hi_risk_ct = NULL, -NULL, vf_hi_risk_ct), 999)) );

f_vf_lo_risk_ct_d := __common__(  if(not(truedid), NULL, min(if(vf_lo_risk_ct = NULL, -NULL, vf_lo_risk_ct), 999)) );

// f_vf_lexid_phn_hi_risk_ct_i := __common__(  if(not(truedid), NULL, min(if(vf_LexID_phone_hi_risk_ct = 0, -NULL, (integer)vf_LexID_phone_hi_risk_ct), 999)) );
f_vf_lexid_phn_hi_risk_ct_i := __common__(  if(not(truedid), NULL, min(if(vf_LexID_phone_hi_risk_ct = 0, 0, (integer)vf_LexID_phone_hi_risk_ct), 999)) );

// f_vf_lexid_phn_lo_risk_ct_d := __common__(  if(not(truedid), NULL, min(if(vf_LexID_phone_lo_risk_ct = 0, -NULL, (integer)vf_LexID_phone_lo_risk_ct), 999)) );
f_vf_lexid_phn_lo_risk_ct_d := __common__(  if(not(truedid), NULL, min(if(vf_LexID_phone_lo_risk_ct = 0, 0, (integer)vf_LexID_phone_lo_risk_ct), 999)) );

// f_vf_altlexid_phn_hi_risk_ct_i := __common__(  if(not(truedid), NULL, min(if(vf_AltLexID_phone_hi_risk_ct = 0, -NULL, (integer)vf_AltLexID_phone_hi_risk_ct), 999)) );
f_vf_altlexid_phn_hi_risk_ct_i := __common__(  if(not(truedid), NULL, min(if(vf_AltLexID_phone_hi_risk_ct = 0, 0, (integer)vf_AltLexID_phone_hi_risk_ct), 999)) );

// f_vf_altlexid_phn_lo_risk_ct_d := __common__(  if(not(truedid), NULL, min(if(vf_AltLexID_phone_lo_risk_ct = 0, -NULL, (integer)vf_AltLexID_phone_lo_risk_ct), 999)) );
f_vf_altlexid_phn_lo_risk_ct_d := __common__(  if(not(truedid), NULL, min(if(vf_AltLexID_phone_lo_risk_ct = 0, 0, (integer)vf_AltLexID_phone_lo_risk_ct), 999)) );

// f_vf_lexid_addr_hi_risk_ct_i := __common__(  if(not(truedid), NULL, min(if(vf_LexID_addr_hi_risk_ct = 0, -NULL, vf_LexID_addr_hi_risk_ct), 999)) );
f_vf_lexid_addr_hi_risk_ct_i := __common__(  if(not(truedid), NULL, min(if(vf_LexID_addr_hi_risk_ct = 0, 0, vf_LexID_addr_hi_risk_ct), 999)) );

// f_vf_lexid_addr_lo_risk_ct_d := __common__(  if(not(truedid), NULL, min(if(vf_LexID_addr_lo_risk_ct = 0, -NULL, vf_LexID_addr_lo_risk_ct), 999)) );
f_vf_lexid_addr_lo_risk_ct_d := __common__(  if(not(truedid), NULL, min(if(vf_LexID_addr_lo_risk_ct = 0, 0, vf_LexID_addr_lo_risk_ct), 999)) );

// f_vf_altlexid_addr_hi_risk_ct_i := __common__(  if(not(truedid), NULL, min(if(vf_AltLexID_addr_hi_risk_ct = 0, -NULL, vf_AltLexID_addr_hi_risk_ct), 999)) );
f_vf_altlexid_addr_hi_risk_ct_i := __common__(  if(not(truedid), NULL, min(if(vf_AltLexID_addr_hi_risk_ct = 0, 0, vf_AltLexID_addr_hi_risk_ct), 999)) );

// f_vf_altlexid_addr_lo_risk_ct_d := __common__(  if(not(truedid), NULL, min(if(vf_AltLexID_addr_lo_risk_ct = 0, -NULL, vf_AltLexID_addr_lo_risk_ct), 999)) );
f_vf_altlexid_addr_lo_risk_ct_d := __common__(  if(not(truedid), NULL, min(if(vf_AltLexID_addr_lo_risk_ct = 0, 0, vf_AltLexID_addr_lo_risk_ct), 999)) );

// f_vf_lexid_ssn_hi_risk_ct_i := __common__(  if(not(truedid), NULL, min(if(vf_LexID_ssn_hi_risk_ct = 0, -NULL, vf_LexID_ssn_hi_risk_ct), 999)) );
f_vf_lexid_ssn_hi_risk_ct_i := __common__(  if(not(truedid), NULL, min(if(vf_LexID_ssn_hi_risk_ct = 0, 0, vf_LexID_ssn_hi_risk_ct), 999)) );

// f_vf_lexid_ssn_lo_risk_ct_d := __common__(  if(not(truedid), NULL, min(if(vf_LexID_ssn_lo_risk_ct = 0, -NULL, vf_LexID_ssn_lo_risk_ct), 999)) );
f_vf_lexid_ssn_lo_risk_ct_d := __common__(  if(not(truedid), NULL, min(if(vf_LexID_ssn_lo_risk_ct = 0, 0, vf_LexID_ssn_lo_risk_ct), 999)) );

// f_vf_altlexid_ssn_hi_risk_ct_i := __common__(  if(not(truedid), NULL, min(if(vf_AltLexID_ssn_hi_risk_ct = 0, -NULL, vf_AltLexID_ssn_hi_risk_ct), 999)) );
f_vf_altlexid_ssn_hi_risk_ct_i := __common__(  if(not(truedid), NULL, min(if(vf_AltLexID_ssn_hi_risk_ct = 0, 0, vf_AltLexID_ssn_hi_risk_ct), 999)) );

// f_vf_altlexid_ssn_lo_risk_ct_d := __common__(  if(not(truedid), NULL, min(if(vf_AltLexID_ssn_lo_risk_ct = 0, -NULL, vf_AltLexID_ssn_lo_risk_ct), 999)) );
f_vf_altlexid_ssn_lo_risk_ct_d := __common__(  if(not(truedid), NULL, min(if(vf_AltLexID_ssn_lo_risk_ct = 0, 0, vf_AltLexID_ssn_lo_risk_ct), 999)) );

_liens_rel_sc_first_seen := __common__(  common.sas_date((string)(liens_rel_SC_first_seen)) );

f_mos_liens_rel_sc_fseen_d := __common__(  map(
    not(truedid)                    => NULL,
    _liens_rel_sc_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12)))), 999)) );

_liens_rel_sc_last_seen := __common__(  common.sas_date((string)(liens_rel_SC_last_seen)) );

f_mos_liens_rel_sc_lseen_d := __common__(  map(
    not(truedid)                   => NULL,
    _liens_rel_sc_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)))), 999))) );

f_liens_rel_sc_total_amt_i := __common__(  if(not(truedid), NULL, liens_rel_SC_total_amount) );

f_liens_unrel_st_ct_i := __common__(  if(not(truedid), NULL, min(if(liens_unrel_ST_ct = NULL, -NULL, liens_unrel_ST_ct), 999)) );

_liens_unrel_st_first_seen := __common__(  common.sas_date((string)(liens_unrel_ST_first_seen)) );

f_mos_liens_unrel_st_fseen_d := __common__(  map(
    not(truedid)                      => NULL,
    _liens_unrel_st_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)))), 999)) );

_liens_unrel_st_last_seen := __common__(  common.sas_date((string)(liens_unrel_ST_last_seen)) );

f_mos_liens_unrel_st_lseen_d := __common__(  map(
    not(truedid)                     => NULL,
    _liens_unrel_st_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)))), 999))) );

f_liens_unrel_st_total_amt_i := __common__(  if(not(truedid), NULL, liens_unrel_ST_total_amount) );

f_liens_rel_st_ct_i := __common__(  if(not(truedid), NULL, min(if(liens_rel_ST_ct = NULL, -NULL, liens_rel_ST_ct), 999)) );

_liens_rel_st_first_seen := __common__(  common.sas_date((string)(liens_rel_ST_first_seen)) );

f_mos_liens_rel_st_fseen_d := __common__(  map(
    not(truedid)                    => NULL,
    _liens_rel_st_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _liens_rel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_st_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_st_first_seen) / (365.25 / 12)))), 999)) );

_liens_rel_st_last_seen := __common__(  common.sas_date((string)(liens_rel_ST_last_seen)) );

f_mos_liens_rel_st_lseen_d := __common__(  map(
    not(truedid)                   => NULL,
    _liens_rel_st_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_st_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_st_last_seen) / (365.25 / 12)))), 999))) );

f_liens_rel_st_total_amt_i := __common__(  if(not(truedid), NULL, liens_rel_ST_total_amount) );

f_has_professional_license_d := __common__(  map(
    not(truedid)                      => NULL,
    not(prof_license_category = '') 	=> 1,
                                         0) );

f_prof_license_category_ix_d := __common__(  map(
    not(truedid) or prof_license_source != 'IX' => NULL,
    prof_license_category = ''                	=> NULL,
                                                   (integer)prof_license_category) );

f_has_hh_members_n := __common__(  map(
    not(truedid)      => NULL,
    hh_members_ct > 0 => 1,
                         0) );

f_hh_members_ct_d := __common__(  if(not(truedid), NULL, min(if(hh_members_ct = NULL, -NULL, hh_members_ct), 999)) );

f_property_owners_ct_d := __common__(  if(not(truedid), NULL, min(if(hh_property_owners_ct = NULL, -NULL, hh_property_owners_ct), 999)) );

f_hh_age_65_plus_d := __common__(  if(not(truedid), NULL, min(if(hh_age_65_plus = NULL, -NULL, hh_age_65_plus), 999)) );

f_hh_age_30_plus_d := __common__(  if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65)))), 999)) );

f_hh_age_18_plus_d := __common__(  if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30)))), 999)) );

f_hh_age_lt18_i := __common__(  if(not(truedid), NULL, min(if(hh_age_lt18 = NULL, -NULL, hh_age_lt18), 999)) );

f_hh_collections_ct_i := __common__(  if(not(truedid), NULL, min(if(hh_collections_ct = NULL, -NULL, hh_collections_ct), 999)) );

f_hh_workers_paw_d := __common__(  if(not(truedid), NULL, min(if(hh_workers_paw = NULL, -NULL, hh_workers_paw), 999)) );

f_hh_payday_loan_users_i := __common__(  if(not(truedid), NULL, min(if(hh_payday_loan_users = NULL, -NULL, hh_payday_loan_users), 999)) );

f_hh_members_w_derog_i := __common__(  if(not(truedid), NULL, min(if(hh_members_w_derog = NULL, -NULL, hh_members_w_derog), 999)) );

f_hh_tot_derog_i := __common__(  if(not(truedid), NULL, min(if(hh_tot_derog = NULL, -NULL, hh_tot_derog), 999)) );

f_hh_bankruptcies_i := __common__(  if(not(truedid), NULL, min(if(hh_bankruptcies = NULL, -NULL, hh_bankruptcies), 999)) );

f_hh_lienholders_i := __common__(  if(not(truedid), NULL, min(if(hh_lienholders = NULL, -NULL, hh_lienholders), 999)) );

f_hh_prof_license_holders_d := __common__(  if(not(truedid), NULL, min(if(hh_prof_license_holders = NULL, -NULL, hh_prof_license_holders), 999)) );

f_hh_criminals_i := __common__(  if(not(truedid), NULL, min(if(hh_criminals = NULL, -NULL, hh_criminals), 999)) );

f_hh_college_attendees_d := __common__(  if(not(truedid), NULL, min(if(hh_college_attendees = NULL, -NULL, hh_college_attendees), 999)) );

f_prof_lic_ix_sanct_ct_n := __common__(  if(not(truedid), NULL, min(if(prof_license_IX_sanct_ct = NULL, -NULL, prof_license_IX_sanct_ct), 999)) );

_prof_license_ix_sanct_fs := __common__(  common.sas_date((string)(Prof_license_IX_sanct_fs)) );

f_mos_prof_lic_ix_sanct_fs_n := __common__(  map(
    not(truedid)                     => NULL,
    _prof_license_ix_sanct_fs = NULL => -1,
                                        min(if(if ((sysdate - _prof_license_ix_sanct_fs) / (365.25 / 12) >= 0, truncate((sysdate - _prof_license_ix_sanct_fs) / (365.25 / 12)), roundup((sysdate - _prof_license_ix_sanct_fs) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _prof_license_ix_sanct_fs) / (365.25 / 12) >= 0, truncate((sysdate - _prof_license_ix_sanct_fs) / (365.25 / 12)), roundup((sysdate - _prof_license_ix_sanct_fs) / (365.25 / 12)))), 999)) );

_prof_license_ix_sanct_ls := __common__(  common.sas_date((string)(Prof_license_IX_sanct_ls)) );

f_mos_prof_lic_ix_sanct_ls_n := __common__(  map(
    not(truedid)                     => NULL,
    _prof_license_ix_sanct_ls = NULL => -1,
                                        max(3, min(if(if ((sysdate - _prof_license_ix_sanct_ls) / (365.25 / 12) >= 0, truncate((sysdate - _prof_license_ix_sanct_ls) / (365.25 / 12)), roundup((sysdate - _prof_license_ix_sanct_ls) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _prof_license_ix_sanct_ls) / (365.25 / 12) >= 0, truncate((sysdate - _prof_license_ix_sanct_ls) / (365.25 / 12)), roundup((sysdate - _prof_license_ix_sanct_ls) / (365.25 / 12)))), 999))) );

f_prof_lic_ix_sanct_type_n := __common__(  map(
    not(truedid)                 => '           ',
    Prof_license_IX_sanct_ct = 0 => 'NO SANCTION',
                                    trim((string)StringLib.StringToUpperCase(Prof_license_IX_sanct_type[1..11]), LEFT)) );

nf_vf_hi_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_hi_risk_ct > 0)) );

nf_vf_lo_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_lo_risk_ct > 0)) );

nf_vf_lexid_addr_hi_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_lexid_addr_hi_risk_ct > 0)) );

nf_vf_lexid_phone_hi_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_lexid_phone_hi_risk_ct > 0)) );

nf_vf_lexid_ssn_hi_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_lexid_ssn_hi_risk_ct > 0)) );

nf_vf_altlexid_addr_hi_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_altlexid_addr_hi_risk_ct > 0)) );

nf_vf_altlexid_phone_hi_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_altlexid_phone_hi_risk_ct > 0)) );

nf_vf_altlexid_ssn_hi_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_altlexid_ssn_hi_risk_ct > 0)) );

nf_vf_lexid_addr_lo_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_lexid_addr_lo_risk_ct > 0)) );

nf_vf_lexid_phone_lo_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_lexid_phone_lo_risk_ct > 0)) );

nf_vf_lexid_ssn_lo_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_lexid_ssn_lo_risk_ct > 0)) );

nf_vf_altlexid_addr_lo_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_altlexid_addr_lo_risk_ct > 0)) );

nf_vf_altlexid_phone_lo_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_altlexid_phone_lo_risk_ct > 0)) );

nf_vf_altlexid_ssn_lo_risk_ind := __common__(  if(not(truedid), NULL, (integer)(vf_altlexid_ssn_lo_risk_ct > 0)) );

nf_vf_type := __common__(  map(
    not(truedid)                                                                => NULL,
    (boolean)(integer)nf_vf_hi_risk_ind and (boolean)(integer)nf_vf_lo_risk_ind => 2,
    (boolean)(integer)nf_vf_hi_risk_ind                                         => 3,
    (boolean)(integer)nf_vf_lo_risk_ind                                         => 1,
                                                                                   0) );

nf_vf_lexid_hi_summary := __common__(  if(not(truedid), NULL, (integer)(vf_lexid_addr_hi_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_lexid_phone_hi_risk_ct > 0) * 2 +
    (integer)(vf_lexid_ssn_hi_risk_ct > 0) * 4) );

nf_vf_altlexid_hi_summary_1 := __common__(  if(not(truedid), NULL, (integer)(vf_altlexid_addr_hi_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_altlexid_phone_hi_risk_ct > 0) * 2 +
    (integer)(vf_altlexid_ssn_hi_risk_ct > 0) * 4) );

nf_vf_lexid_lo_summary := __common__(  if(not(truedid), NULL, (integer)(vf_lexid_addr_lo_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_lexid_phone_lo_risk_ct > 0) * 2 +
    (integer)(vf_lexid_ssn_lo_risk_ct > 0) * 4) );

nf_vf_altlexid_hi_summary := __common__(  if(not(truedid), NULL, (integer)(vf_altlexid_addr_lo_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_altlexid_phone_lo_risk_ct > 0) * 2 +
    (integer)(vf_altlexid_ssn_lo_risk_ct > 0) * 4) );

nf_vf_hi_summary := __common__(  if(not(truedid), NULL, max((integer)(vf_lexid_addr_hi_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_lexid_phone_hi_risk_ct > 0) * 2 +
    (integer)(vf_lexid_ssn_hi_risk_ct > 0) * 4, (integer)(vf_altlexid_addr_hi_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_altlexid_phone_hi_risk_ct > 0) * 2 +
    (integer)(vf_altlexid_ssn_hi_risk_ct > 0) * 4)) );

nf_vf_lo_summary := __common__(  if(not(truedid), NULL, max((integer)(vf_lexid_addr_lo_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_lexid_phone_lo_risk_ct > 0) * 2 +
    (integer)(vf_lexid_ssn_lo_risk_ct > 0) * 4, (integer)(vf_altlexid_addr_lo_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_altlexid_phone_lo_risk_ct > 0) * 2 +
    (integer)(vf_altlexid_ssn_lo_risk_ct > 0) * 4)) );

_vf_hi_summary := __common__(  max((integer)(vf_lexid_addr_hi_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_lexid_phone_hi_risk_ct > 0) * 2 +
    (integer)(vf_lexid_ssn_hi_risk_ct > 0) * 4, (integer)(vf_altlexid_addr_hi_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_altlexid_phone_hi_risk_ct > 0) * 2 +
    (integer)(vf_altlexid_ssn_hi_risk_ct > 0) * 4) );

_vf_lo_summary := __common__(  max((integer)(vf_lexid_addr_lo_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_lexid_phone_lo_risk_ct > 0) * 2 +
    (integer)(vf_lexid_ssn_lo_risk_ct > 0) * 4, (integer)(vf_altlexid_addr_lo_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_altlexid_phone_lo_risk_ct > 0) * 2 +
    (integer)(vf_altlexid_ssn_lo_risk_ct > 0) * 4) );

_vf_lexid_lo_summary := __common__(  (integer)(vf_lexid_addr_lo_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_lexid_phone_lo_risk_ct > 0) * 2 +
    (integer)(vf_lexid_ssn_lo_risk_ct > 0) * 4 );

_vf_lexid_hi_summary := __common__(  (integer)(vf_lexid_addr_hi_risk_ct > 0) * POWER(2, 0) +
    (integer)(vf_lexid_phone_hi_risk_ct > 0) * 2 +
    (integer)(vf_lexid_ssn_hi_risk_ct > 0) * 4 );

nf_vf_level_c514 := __common__(  map(
    (_vf_lexid_lo_summary in [3, 7]) => 0,
    _vf_lexid_lo_summary = 4         => 2,
                                        1) );

nf_vf_level_c515 := __common__(  map(
    (_vf_lexid_hi_summary in [3, 7])    => 5,
    (_vf_lexid_hi_summary in [4, 5, 6]) => 6,
                                           4) );

nf_vf_level := __common__(  map(
    not(truedid)                               => NULL,
    _vf_hi_summary = 0 and _vf_lo_summary = 0  => -1,
    _vf_hi_summary = 0 and _vf_lo_summary != 0 => nf_vf_level_c514,
    _vf_hi_summary != 0 and _vf_lo_summary = 0 => nf_vf_level_c515,
                                                  3) );

nf_vf_hi_additional_entries := __common__(  if(not(truedid), NULL, min(if(max(0, vf_hi_risk_ct - 1) = NULL, -NULL, max(0, vf_hi_risk_ct - 1)), 3)) );

nf_vf_lo_additional_entries := __common__(  if(not(truedid), NULL, min(if(max(0, vf_lo_risk_ct - 1) = NULL, -NULL, max(0, vf_lo_risk_ct - 1)), 3)) );

nf_vf_hi_addr_add_entries := __common__(  map(
    not(truedid)                 => NULL,
    vf_lexid_addr_hi_risk_ct = 0 => min(if(max(0, vf_altlexid_addr_hi_risk_ct - 1) = NULL, -NULL, max(0, vf_altlexid_addr_hi_risk_ct - 1)), 3),
                                    min(if(max(0, vf_lexid_addr_hi_risk_ct - 1) = NULL, -NULL, max(0, vf_lexid_addr_hi_risk_ct - 1)), 3)) );

nf_vf_hi_phone_add_entries := __common__(  map(
    not(truedid)                  => NULL,
    (integer)vf_lexid_phone_hi_risk_ct = 0 => min(if(max(0, (integer)vf_altlexid_phone_hi_risk_ct - 1) = NULL, -NULL, max(0, (integer)vf_altlexid_phone_hi_risk_ct - 1)), 3),
                                     min(if(max(0, (integer)vf_lexid_phone_hi_risk_ct - 1) = NULL, -NULL, max(0, (integer)vf_lexid_phone_hi_risk_ct - 1)), 3)) );

nf_vf_hi_ssn_add_entries := __common__(  map(
    not(truedid)                => NULL,
    vf_lexid_ssn_hi_risk_ct = 0 => min(if(max(0, vf_altlexid_ssn_hi_risk_ct - 1) = NULL, -NULL, max(0, vf_altlexid_ssn_hi_risk_ct - 1)), 3),
                                   min(if(max(0, vf_lexid_ssn_hi_risk_ct - 1) = NULL, -NULL, max(0, vf_lexid_ssn_hi_risk_ct - 1)), 3)) );

nf_vf_lo_addr_add_entries := __common__(  map(
    not(truedid)                 => NULL,
    vf_lexid_addr_lo_risk_ct = 0 => min(if(max(0, vf_altlexid_addr_lo_risk_ct - 1) = NULL, -NULL, max(0, vf_altlexid_addr_lo_risk_ct - 1)), 3),
                                    min(if(max(0, vf_lexid_addr_lo_risk_ct - 1) = NULL, -NULL, max(0, vf_lexid_addr_lo_risk_ct - 1)), 3)) );

nf_vf_lo_phone_add_entries := __common__(  map(
    not(truedid)                  => NULL,
    (integer)vf_lexid_phone_lo_risk_ct = 0 => min(if(max(0, (integer)vf_altlexid_phone_lo_risk_ct - 1) = NULL, -NULL, max(0, (integer)vf_altlexid_phone_lo_risk_ct - 1)), 3),
                                     min(if(max(0, (integer)vf_lexid_phone_lo_risk_ct - 1) = NULL, -NULL, max(0, (integer)vf_lexid_phone_lo_risk_ct - 1)), 3)) );

nf_vf_lo_ssn_add_entries := __common__(  map(
    not(truedid)                => NULL,
    vf_lexid_ssn_lo_risk_ct = 0 => min(if(max(0, vf_altlexid_ssn_lo_risk_ct - 1) = NULL, -NULL, max(0, vf_altlexid_ssn_lo_risk_ct - 1)), 3),
                                   min(if(max(0, vf_lexid_ssn_lo_risk_ct - 1) = NULL, -NULL, max(0, vf_lexid_ssn_lo_risk_ct - 1)), 3)) );

nf_altlexid_addr_hi_no_hi_lexid := __common__(  map(
    not(truedid)      => NULL,
    vf_hi_risk_ct > 0 => 0,
                         vf_altlexid_addr_hi_risk_ct) );

nf_altlexid_phone_hi_no_hi_lexid := __common__(  map(
    not(truedid)      => NULL,
    vf_hi_risk_ct > 0 => 0,
                         (integer)vf_altlexid_phone_hi_risk_ct) );

nf_altlexid_ssn_hi_no_hi_lexid := __common__(  map(
    not(truedid)      => NULL,
    vf_hi_risk_ct > 0 => 0,
                         vf_altlexid_ssn_hi_risk_ct) );

nf_max_altlexid_hi_no_hi_lexid := __common__(  max(nf_altlexid_addr_hi_no_hi_lexid, nf_altlexid_phone_hi_no_hi_lexid, nf_altlexid_ssn_hi_no_hi_lexid) );

nf_vf_hi_risk_hit_type := __common__(  map(
    not(truedid)                                                                                                         => NULL,
    vf_hi_risk_ct > 0 and max(vf_altlexid_addr_hi_risk_ct, (integer)vf_altlexid_phone_hi_risk_ct, vf_altlexid_ssn_hi_risk_ct) > 0 => 1,
    vf_hi_risk_ct > 0                                                                                                    => 2,
    max(vf_altlexid_addr_hi_risk_ct, (integer)vf_altlexid_phone_hi_risk_ct, vf_altlexid_ssn_hi_risk_ct) > 0                       => 3,
                                                                                                                            4) );

_alt_nohi_score := __common__(  10 * min(if(nf_altlexid_addr_hi_no_hi_lexid = NULL, -NULL, nf_altlexid_addr_hi_no_hi_lexid), 4) +
    (integer)(nf_altlexid_phone_hi_no_hi_lexid > 0) +
    2 * (integer)(nf_altlexid_ssn_hi_no_hi_lexid > 0) );

_alt_nohi_grp := __common__(  map(
    _alt_nohi_score = 0                                                   => '0: NONE            ',
    (_alt_nohi_score in [1, 2, 3])                                        => '1: NO ADDR         ',
    (_alt_nohi_score in [11, 12, 13, 21, 22, 23, 31, 32, 33, 41, 42, 43]) => '3: MIXED MULTIPLES ',
    _alt_nohi_score < 20                                                  => '2: 1 ADDR ONLY     ',
    _alt_nohi_score < 30                                                  => '3: MIXED MULTIPLES ',
                                                                             '4: 3+ ADDR ONLY    ') );

nf_vf_hi_risk_index_c530 := __common__(  map(
    _alt_nohi_grp = '1: NO ADDR'         => 6,
    _alt_nohi_grp = '2: 1 ADDR ONLY'     => 5,
    _alt_nohi_grp = '3: MIXED MULTIPLES' => 4,
                                            3) );

nf_vf_hi_risk_index := __common__(  map(
    not(truedid)                                                                                                         => NULL,
    vf_hi_risk_ct > 0 and max(vf_altlexid_addr_hi_risk_ct, (integer)vf_altlexid_phone_hi_risk_ct, vf_altlexid_ssn_hi_risk_ct) > 0 => 1,
    vf_hi_risk_ct = 1                                                                                                    => 5,
    vf_hi_risk_ct >= 2                                                                                                   => 2,
    max(vf_altlexid_addr_hi_risk_ct, (integer)vf_altlexid_phone_hi_risk_ct, vf_altlexid_ssn_hi_risk_ct) > 0                       => nf_vf_hi_risk_index_c530,
                                                                                                                            7) );

_ver_src_ds := __common__(  Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0 );

_ver_src_de := __common__(  Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0 );

_ver_src_eq := __common__(  Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0 );

_ver_src_en := __common__(  Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0 );

_ver_src_tn := __common__(  Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0 );

_ver_src_tu := __common__(  Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0 );

_credit_source_cnt := __common__(  if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu)) );

// _ver_src_cnt := __common__(  Models.Common.countw((string)(ver_sources), ARRAY(0x2ef84c0)) );
_ver_src_cnt := __common__(  Models.Common.countw((string)(StringLib.StringToUpperCase(trim(ver_sources, ALL))), ',') );	//kh-changed to this

_bureauonly := __common__(  _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])) );

_derog := __common__(  felony_count > 0 OR addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2 );

_deceased := __common__(  rc_decsflag = 1 OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de );

_ssnpriortodob := __common__(  rc_ssndobflag = 1 OR rc_pwssndobflag = 1 );

_inputmiskeys := __common__(  rc_ssnmiskeyflag or rc_addrmiskeyflag or add_input_house_number_match = 0 );

_multiplessns := __common__(  ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1 );

_hh_strikes := __common__(  if(max((integer)(hh_members_w_derog > 0), (integer)(hh_criminals > 0), (integer)(hh_payday_loan_users > 0)) = 0, NULL, sum((integer)(hh_members_w_derog > 0), (integer)(hh_criminals > 0), (integer)(hh_payday_loan_users > 0))) );

nf_seg_fraudpoint_3_0 := __common__(map(
    // (nas_summary in [4, 7, 9]) or 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = 9 or _deceased or _ssnpriortodob                         => '1: Stolen/Manip ID  ',	//kh-delta
    (addrpop and nas_summary in [4, 7, 9]) or (fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = 9) or _deceased or _ssnpriortodob  				=> '1: Stolen/Manip ID  ',
    _inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1)                                                                                                       																			=> '1: Stolen/Manip ID  ',
    // nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt = 0 or _bureauonly or ~add_curr_pop                                                                     	 																			=> '2: Synth ID         ',	//kh-delta
    (fnamepop and lnamepop and addrpop and ssnlength=9 and hphnpop and nap_summary <= 4 and nas_summary <= 4) or _ver_src_cnt = 0 or _bureauonly or ~add_curr_pop                                 				=> '2: Synth ID         ',
    _derog                                                                                                                                                           																			=> '3: Derog            ',
    Inq_count03 > 0 or Inq_count12 >= 4 or (integer)fp_srchfraudsrchcountyr >= 1 or (integer)fp_srchssnsrchcountmo >= 1 or (integer)fp_srchaddrsrchcountmo >= 1 or (integer)fp_srchphonesrchcountmo >= 1 	=> '4: Recent Activity  ',
    0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70                                                                                                    																			=> '5: Vuln Vic/Friendly',
    hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2)                                                                    																			=> '5: Vuln Vic/Friendly',
																																																																																																						 '6: Other            ') );
			self.seqa := le.bs.seq;
			self.sysdate                          := sysdate;
			self.pii_profile_n                    := pii_profile_n;
			self.r_nas_ssn_verd_d                 := r_nas_ssn_verd_d;
			self.r_nas_addr_verd_d                := r_nas_addr_verd_d;
			self.r_nas_lname_verd_d               := r_nas_lname_verd_d;
			self.r_nas_fname_verd_d               := r_nas_fname_verd_d;
			self.r_nas_nothing_found_i            := r_nas_nothing_found_i;
			self.r_nas_contradictory_i            := r_nas_contradictory_i;
			self.r_f00_nas_ssn_no_addr_verd_i     := r_f00_nas_ssn_no_addr_verd_i;
			self.k_nap_phn_verd_d                 := k_nap_phn_verd_d;
			self.k_nap_addr_verd_d                := k_nap_addr_verd_d;
			self.k_nap_lname_verd_d               := k_nap_lname_verd_d;
			self.k_nap_fname_verd_d               := k_nap_fname_verd_d;
			self.k_nap_nothing_found_i            := k_nap_nothing_found_i;
			self.k_nap_contradictory_i            := k_nap_contradictory_i;
			self.k_inf_phn_verd_d                 := k_inf_phn_verd_d;
			self.k_inf_addr_verd_d                := k_inf_addr_verd_d;
			self.k_inf_lname_verd_d               := k_inf_lname_verd_d;
			self.k_inf_fname_verd_d               := k_inf_fname_verd_d;
			self.k_inf_nothing_found_i            := k_inf_nothing_found_i;
			self.k_inf_contradictory_i            := k_inf_contradictory_i;
			self.r_s65_ssn_prior_dob_i            := r_s65_ssn_prior_dob_i;
			self.r_s65_ssn_invalid_i              := r_s65_ssn_invalid_i;
			self.r_c16_inv_ssn_per_adl_i          := r_c16_inv_ssn_per_adl_i;
			self.r_c16_inv_ssn_per_adl_c6_i       := r_c16_inv_ssn_per_adl_c6_i;
			self.r_f00_addr_not_ver_w_ssn_i       := r_f00_addr_not_ver_w_ssn_i;
			self.r_s65_ssn_problem_i              := r_s65_ssn_problem_i;
			self.r_p88_phn_dst_to_inp_add_i       := r_p88_phn_dst_to_inp_add_i;
			self.r_l70_zip_not_issued_i           := r_l70_zip_not_issued_i;
			self.r_p85_phn_not_issued_i           := r_p85_phn_not_issued_i;
			self.r_p85_phn_disconnected_i         := r_p85_phn_disconnected_i;
			self.r_p85_phn_invalid_i              := r_p85_phn_invalid_i;
			self.r_p85_phn_hirisk_i               := r_p85_phn_hirisk_i;
			self.r_phn_cell_n                     := r_phn_cell_n;
			self.r_p86_phn_pager_i                := r_p86_phn_pager_i;
			self.r_phn_pcs_n                      := r_phn_pcs_n;
			self.r_p86_phn_pay_phone_i            := r_p86_phn_pay_phone_i;
			self.r_p86_phn_fax_i                  := r_p86_phn_fax_i;
			self.r_p87_phn_corrections_i          := r_p87_phn_corrections_i;
			self.r_c17_inv_phn_per_adl_i          := r_c17_inv_phn_per_adl_i;
			self.r_l77_add_po_box_i               := r_l77_add_po_box_i;
			self.r_l70_add_invalid_i              := r_l70_add_invalid_i;
			self.r_l71_add_hirisk_comm_i          := r_l71_add_hirisk_comm_i;
			self.r_l71_add_corp_zip_i             := r_l71_add_corp_zip_i;
			self.r_l72_add_vacant_i               := r_l72_add_vacant_i;
			self.r_l74_add_throwback_i            := r_l74_add_throwback_i;
			self.r_l75_add_drop_delivery_i        := r_l75_add_drop_delivery_i;
			self.r_l76_add_seasonal_i             := r_l76_add_seasonal_i;
			self.r_l71_add_business_i             := r_l71_add_business_i;
			self.r_l70_add_standardized_i         := r_l70_add_standardized_i;
			self.r_l70_inp_addr_dnd_i             := r_l70_inp_addr_dnd_i;
			self.r_l71_add_curr_hirisk_comm_i     := r_l71_add_curr_hirisk_comm_i;
			self.r_l72_add_curr_vacant_i          := r_l72_add_curr_vacant_i;
			self.r_l74_add_curr_throwback_i       := r_l74_add_curr_throwback_i;
			self.r_l75_add_curr_drop_delivery_i   := r_l75_add_curr_drop_delivery_i;
			self.r_l76_add_curr_seasonal_i        := r_l76_add_curr_seasonal_i;
			self.r_l71_add_curr_business_i        := r_l71_add_curr_business_i;
			self.r_f03_input_add_not_most_rec_i   := r_f03_input_add_not_most_rec_i;
			self.r_c18_inv_add_per_adl_c6_i       := r_c18_inv_add_per_adl_c6_i;
			self.r_c19_add_prison_hist_i          := r_c19_add_prison_hist_i;
			self.r_l77_apartment_i                := r_l77_apartment_i;
			self.r_f00_ssn_score_d                := r_f00_ssn_score_d;
			self.r_f00_dob_score_d                := r_f00_dob_score_d;
			self.r_f01_inp_addr_address_score_d   := r_f01_inp_addr_address_score_d;
			self.r_l70_inp_addr_dirty_i           := r_l70_inp_addr_dirty_i;
			self.r_f00_input_dob_match_level_d    := r_f00_input_dob_match_level_d;
			self.r_d30_derog_count_i              := r_d30_derog_count_i;
			self.r_d32_criminal_count_i           := r_d32_criminal_count_i;
			self.r_d32_felony_count_i             := r_d32_felony_count_i;
			self.r_d32_mos_since_crim_ls_d        := r_d32_mos_since_crim_ls_d;
			self.r_d32_mos_since_fel_ls_d         := r_d32_mos_since_fel_ls_d;
			self.r_d31_mostrec_bk_i               := r_d31_mostrec_bk_i;
			self.r_d31_attr_bankruptcy_recency_d  := r_d31_attr_bankruptcy_recency_d;
			self.r_d31_bk_filing_count_i          := r_d31_bk_filing_count_i;
			self.r_d31_bk_disposed_recent_count_i := r_d31_bk_disposed_recent_count_i;
			self.r_d31_bk_disposed_hist_count_i   := r_d31_bk_disposed_hist_count_i;
			self.r_d33_eviction_recency_d         := r_d33_eviction_recency_d;
			self.r_d33_eviction_count_i           := r_d33_eviction_count_i;
			self.r_d34_unrel_liens_ct_i           := r_d34_unrel_liens_ct_i;
			self.r_d34_unrel_lien60_count_i       := r_d34_unrel_lien60_count_i;
			self.r_c21_m_bureau_adl_fs_d          := r_c21_m_bureau_adl_fs_d;
			self.f_m_bureau_adl_fs_all_d          := f_m_bureau_adl_fs_all_d;
			self.f_m_bureau_adl_fs_notu_d         := f_m_bureau_adl_fs_notu_d;
			self.r_c10_m_hdr_fs_d                 := r_c10_m_hdr_fs_d;
			self.r_c12_nonderog_recency_i         := r_c12_nonderog_recency_i;
			self.r_c12_num_nonderogs_d            := r_c12_num_nonderogs_d;
			self.r_c15_ssns_per_adl_i             := r_c15_ssns_per_adl_i;
			self.r_s66_adlperssn_count_i          := r_s66_adlperssn_count_i;
			self.k_comb_age_d                     := k_comb_age_d;
			self.r_f03_address_match_d            := r_f03_address_match_d;
			self.r_a48_inp_addr_conv_mortgage_d   := r_a48_inp_addr_conv_mortgage_d;
			self.r_a44_curr_add_naprop_d          := r_a44_curr_add_naprop_d;
			self.r_a48_curr_addr_conv_mortg_d     := r_a48_curr_addr_conv_mortg_d;
			self.r_l80_inp_avm_autoval_d          := r_l80_inp_avm_autoval_d;
			self.r_a46_curr_avm_autoval_d         := r_a46_curr_avm_autoval_d;
			self.r_a49_curr_avm_chg_1yr_i         := r_a49_curr_avm_chg_1yr_i;
			self.r_a49_curr_avm_chg_1yr_pct_i     := r_a49_curr_avm_chg_1yr_pct_i;
			self.r_c13_curr_addr_lres_d           := r_c13_curr_addr_lres_d;
			self.r_c14_addr_stability_v2_d        := r_c14_addr_stability_v2_d;
			self.r_c13_max_lres_d                 := r_c13_max_lres_d;
			self.r_add_curr_pop_i                 := r_add_curr_pop_i;
			self.r_c14_addrs_5yr_i                := r_c14_addrs_5yr_i;
			self.r_c14_addrs_10yr_i               := r_c14_addrs_10yr_i;
			self.r_c14_addrs_per_adl_c6_i         := r_c14_addrs_per_adl_c6_i;
			self.r_c14_addrs_15yr_i               := r_c14_addrs_15yr_i;
			self.r_a41_prop_owner_d               := r_a41_prop_owner_d;
			self.r_a41_prop_owner_inp_only_d      := r_a41_prop_owner_inp_only_d;
			self.r_prop_owner_history_d           := r_prop_owner_history_d;
			self.r_a43_aircraft_cnt_d             := r_a43_aircraft_cnt_d;
			self.r_a43_watercraft_cnt_d           := r_a43_watercraft_cnt_d;
			self.r_ever_asset_owner_d             := r_ever_asset_owner_d;
			self.r_c20_email_count_i              := r_c20_email_count_i;
			self.r_c20_email_domain_free_count_i  := r_c20_email_domain_free_count_i;
			self.r_c20_email_domain_isp_count_i   := r_c20_email_domain_isp_count_i;
			self.r_e57_prof_license_flag_d        := r_e57_prof_license_flag_d;
			self.r_l79_adls_per_addr_curr_i       := r_l79_adls_per_addr_curr_i;
			self.r_c15_ssns_per_adl_c6_i          := r_c15_ssns_per_adl_c6_i;
			self.r_l79_adls_per_addr_c6_i         := r_l79_adls_per_addr_c6_i;
			self.r_c18_invalid_addrs_per_adl_i    := r_c18_invalid_addrs_per_adl_i;
			self.r_has_pb_record_d                := r_has_pb_record_d;
			self.r_a50_pb_average_dollars_d       := r_a50_pb_average_dollars_d;
			self.r_a50_pb_total_dollars_d         := r_a50_pb_total_dollars_d;
			self.r_a50_pb_total_orders_d          := r_a50_pb_total_orders_d;
			self.r_pb_order_freq_d                := r_pb_order_freq_d;
			self.r_l78_no_phone_at_addr_vel_i     := r_l78_no_phone_at_addr_vel_i;
			self.r_i60_inq_count12_i              := r_i60_inq_count12_i;
			self.r_i60_credit_seeking_i           := r_i60_credit_seeking_i;
			self.r_i60_inq_recency_d              := r_i60_inq_recency_d;
			self.r_i61_inq_collection_count12_i   := r_i61_inq_collection_count12_i;
			self.r_i61_inq_collection_recency_d   := r_i61_inq_collection_recency_d;
			self.r_i60_inq_auto_count12_i         := r_i60_inq_auto_count12_i;
			self.r_i60_inq_auto_recency_d         := r_i60_inq_auto_recency_d;
			self.r_i60_inq_banking_count12_i      := r_i60_inq_banking_count12_i;
			self.r_i60_inq_banking_recency_d      := r_i60_inq_banking_recency_d;
			self.r_i60_inq_mortgage_count12_i     := r_i60_inq_mortgage_count12_i;
			self.r_i60_inq_mortgage_recency_d     := r_i60_inq_mortgage_recency_d;
			self.r_i60_inq_hiriskcred_count12_i   := r_i60_inq_hiriskcred_count12_i;
			self.r_i60_inq_hiriskcred_recency_d   := r_i60_inq_hiriskcred_recency_d;
			self.r_i60_inq_retail_count12_i       := r_i60_inq_retail_count12_i;
			self.r_i60_inq_retail_recency_d       := r_i60_inq_retail_recency_d;
			self.r_i60_inq_comm_count12_i         := r_i60_inq_comm_count12_i;
			self.r_i60_inq_comm_recency_d         := r_i60_inq_comm_recency_d;
			self.f_bus_addr_match_count_d         := f_bus_addr_match_count_d;
			self.f_bus_fname_verd_d               := f_bus_fname_verd_d;
			self.f_bus_lname_verd_d               := f_bus_lname_verd_d;
			self.f_bus_name_nover_i               := f_bus_name_nover_i;
			self.f_bus_ssn_match_d                := f_bus_ssn_match_d;
			self.f_bus_phone_match_d              := f_bus_phone_match_d;
			self.f_adl_util_inf_n                 := f_adl_util_inf_n;
			self.f_adl_util_conv_n                := f_adl_util_conv_n;
			self.f_adl_util_misc_n                := f_adl_util_misc_n;
			self.f_util_adl_count_n               := f_util_adl_count_n;
			self.f_util_add_input_inf_n           := f_util_add_input_inf_n;
			self.f_util_add_input_conv_n          := f_util_add_input_conv_n;
			self.f_util_add_input_misc_n          := f_util_add_input_misc_n;
			self.f_util_add_curr_inf_n            := f_util_add_curr_inf_n;
			self.f_util_add_curr_conv_n           := f_util_add_curr_conv_n;
			self.f_util_add_curr_misc_n           := f_util_add_curr_misc_n;
			self.f_add_input_has_occ_1yr_d        := f_add_input_has_occ_1yr_d;
			self.f_add_input_mobility_index_i     := f_add_input_mobility_index_i;
			self.f_add_input_has_bus_ct_i         := f_add_input_has_bus_ct_i;
			self.f_add_input_nhood_bus_pct_i      := f_add_input_nhood_bus_pct_i;
			self.f_add_input_has_mfd_ct_i         := f_add_input_has_mfd_ct_i;
			self.f_add_input_nhood_mfd_pct_i      := f_add_input_nhood_mfd_pct_i;
			self.f_add_input_has_sfd_ct_d         := f_add_input_has_sfd_ct_d;
			self.f_add_input_nhood_sfd_pct_d      := f_add_input_nhood_sfd_pct_d;
			self.f_add_input_has_vac_ct_i         := f_add_input_has_vac_ct_i;
			self.f_add_input_nhood_vac_pct_i      := f_add_input_nhood_vac_pct_i;
			self.f_add_curr_has_occ_1yr_d         := f_add_curr_has_occ_1yr_d;
			self.f_add_curr_mobility_index_i      := f_add_curr_mobility_index_i;
			self.f_add_curr_has_bus_ct_i          := f_add_curr_has_bus_ct_i;
			self.f_add_curr_nhood_bus_pct_i       := f_add_curr_nhood_bus_pct_i;
			self.f_add_curr_has_mfd_ct_i          := f_add_curr_has_mfd_ct_i;
			self.f_add_curr_nhood_mfd_pct_i       := f_add_curr_nhood_mfd_pct_i;
			self.f_add_curr_has_sfd_ct_d          := f_add_curr_has_sfd_ct_d;
			self.f_add_curr_nhood_sfd_pct_d       := f_add_curr_nhood_sfd_pct_d;
			self.f_add_curr_has_vac_ct_i          := f_add_curr_has_vac_ct_i;
			self.f_add_curr_nhood_vac_pct_i       := f_add_curr_nhood_vac_pct_i;
			self.f_recent_disconnects_i           := f_recent_disconnects_i;
			self.f_inq_count_i                    := f_inq_count_i;
			self.f_inq_count24_i                  := f_inq_count24_i;
			self.f_inq_auto_count_i               := f_inq_auto_count_i;
			self.f_inq_auto_count24_i             := f_inq_auto_count24_i;
			self.f_inq_banking_count_i            := f_inq_banking_count_i;
			self.f_inq_banking_count24_i          := f_inq_banking_count24_i;
			self.f_inq_collection_count_i         := f_inq_collection_count_i;
			self.f_inq_collection_count24_i       := f_inq_collection_count24_i;
			self.f_inq_communications_count_i     := f_inq_communications_count_i;
			self.f_inq_communications_count24_i   := f_inq_communications_count24_i;
			self.f_inq_highriskcredit_count_i     := f_inq_highriskcredit_count_i;
			self.f_inq_highriskcredit_count24_i   := f_inq_highriskcredit_count24_i;
			self.f_inq_mortgage_count_i           := f_inq_mortgage_count_i;
			self.f_inq_mortgage_count24_i         := f_inq_mortgage_count24_i;
			self.f_inq_other_count_i              := f_inq_other_count_i;
			self.f_inq_other_count24_i            := f_inq_other_count24_i;
			self.f_inq_retail_count_i             := f_inq_retail_count_i;
			self.f_inq_retail_count24_i           := f_inq_retail_count24_i;
			self.k_inq_per_ssn_i                  := k_inq_per_ssn_i;
			self.k_inq_adls_per_ssn_i             := k_inq_adls_per_ssn_i;
			self.k_inq_lnames_per_ssn_i           := k_inq_lnames_per_ssn_i;
			self.k_inq_addrs_per_ssn_i            := k_inq_addrs_per_ssn_i;
			self.k_inq_dobs_per_ssn_i             := k_inq_dobs_per_ssn_i;
			self.k_inq_per_addr_i                 := k_inq_per_addr_i;
			self.k_inq_adls_per_addr_i            := k_inq_adls_per_addr_i;
			self.k_inq_lnames_per_addr_i          := k_inq_lnames_per_addr_i;
			self.k_inq_ssns_per_addr_i            := k_inq_ssns_per_addr_i;
			self.k_inq_per_phone_i                := k_inq_per_phone_i;
			self.k_inq_adls_per_phone_i           := k_inq_adls_per_phone_i;
			self.f_mos_inq_banko_am_fseen_d       := f_mos_inq_banko_am_fseen_d;
			self.f_mos_inq_banko_am_lseen_d       := f_mos_inq_banko_am_lseen_d;
			self.f_mos_inq_banko_cm_fseen_d       := f_mos_inq_banko_cm_fseen_d;
			self.f_mos_inq_banko_cm_lseen_d       := f_mos_inq_banko_cm_lseen_d;
			self.f_mos_inq_banko_om_fseen_d       := f_mos_inq_banko_om_fseen_d;
			self.f_mos_inq_banko_om_lseen_d       := f_mos_inq_banko_om_lseen_d;
			self.f_attr_arrests_i                 := f_attr_arrests_i;
			self.f_attr_arrest_recency_d          := f_attr_arrest_recency_d;
			self.f_mos_liens_unrel_cj_fseen_d     := f_mos_liens_unrel_cj_fseen_d;
			self.f_mos_liens_unrel_cj_lseen_d     := f_mos_liens_unrel_cj_lseen_d;
			self.f_liens_unrel_cj_total_amt_i     := f_liens_unrel_cj_total_amt_i;
			self.f_mos_liens_rel_cj_fseen_d       := f_mos_liens_rel_cj_fseen_d;
			self.f_mos_liens_rel_cj_lseen_d       := f_mos_liens_rel_cj_lseen_d;
			self.f_liens_rel_cj_total_amt_i       := f_liens_rel_cj_total_amt_i;
			self.f_mos_liens_unrel_ft_fseen_d     := f_mos_liens_unrel_ft_fseen_d;
			self.f_mos_liens_unrel_ft_lseen_d     := f_mos_liens_unrel_ft_lseen_d;
			self.f_liens_unrel_ft_total_amt_i     := f_liens_unrel_ft_total_amt_i;
			self.f_mos_liens_rel_ft_fseen_d       := f_mos_liens_rel_ft_fseen_d;
			self.f_mos_liens_rel_ft_lseen_d       := f_mos_liens_rel_ft_lseen_d;
			self.f_liens_rel_ft_total_amt_i       := f_liens_rel_ft_total_amt_i;
			self.f_mos_liens_unrel_fc_fseen_d     := f_mos_liens_unrel_fc_fseen_d;
			self.f_mos_liens_unrel_fc_lseen_d     := f_mos_liens_unrel_fc_lseen_d;
			self.f_liens_unrel_fc_total_amt_i     := f_liens_unrel_fc_total_amt_i;
			self.f_mos_liens_rel_fc_fseen_d       := f_mos_liens_rel_fc_fseen_d;
			self.f_mos_liens_rel_fc_lseen_d       := f_mos_liens_rel_fc_lseen_d;
			self.f_liens_rel_fc_total_amt_i       := f_liens_rel_fc_total_amt_i;
			self.f_mos_liens_unrel_lt_fseen_d     := f_mos_liens_unrel_lt_fseen_d;
			self.f_mos_liens_unrel_lt_lseen_d     := f_mos_liens_unrel_lt_lseen_d;
			self.f_mos_liens_rel_lt_fseen_d       := f_mos_liens_rel_lt_fseen_d;
			self.f_mos_liens_rel_lt_lseen_d       := f_mos_liens_rel_lt_lseen_d;
			self.f_mos_liens_unrel_o_fseen_d      := f_mos_liens_unrel_o_fseen_d;
			self.f_mos_liens_unrel_o_lseen_d      := f_mos_liens_unrel_o_lseen_d;
			self.f_liens_unrel_o_total_amt_i      := f_liens_unrel_o_total_amt_i;
			self.f_mos_liens_rel_o_fseen_d        := f_mos_liens_rel_o_fseen_d;
			self.f_mos_liens_rel_o_lseen_d        := f_mos_liens_rel_o_lseen_d;
			self.f_liens_rel_o_total_amt_i        := f_liens_rel_o_total_amt_i;
			self.f_mos_liens_unrel_ot_fseen_d     := f_mos_liens_unrel_ot_fseen_d;
			self.f_mos_liens_unrel_ot_lseen_d     := f_mos_liens_unrel_ot_lseen_d;
			self.f_liens_unrel_ot_total_amt_i     := f_liens_unrel_ot_total_amt_i;
			self.f_mos_liens_rel_ot_fseen_d       := f_mos_liens_rel_ot_fseen_d;
			self.f_mos_liens_rel_ot_lseen_d       := f_mos_liens_rel_ot_lseen_d;
			self.f_liens_rel_ot_total_amt_i       := f_liens_rel_ot_total_amt_i;
			self.f_mos_liens_unrel_sc_fseen_d     := f_mos_liens_unrel_sc_fseen_d;
			self.f_mos_liens_unrel_sc_lseen_d     := f_mos_liens_unrel_sc_lseen_d;
			self.f_liens_unrel_sc_total_amt_i     := f_liens_unrel_sc_total_amt_i;
			self.f_foreclosure_flag_i             := f_foreclosure_flag_i;
			self.f_mos_foreclosure_lseen_d        := f_mos_foreclosure_lseen_d;
			self.k_estimated_income_d             := k_estimated_income_d;
			self.r_wealth_index_d                 := r_wealth_index_d;
			self.f_college_income_d               := f_college_income_d;
			self.f_has_relatives_n                := f_has_relatives_n;
			self.f_rel_count_i                    := f_rel_count_i;
			self.f_rel_incomeover25_count_d       := f_rel_incomeover25_count_d;
			self.f_rel_incomeover50_count_d       := f_rel_incomeover50_count_d;
			self.f_rel_incomeover75_count_d       := f_rel_incomeover75_count_d;
			self.f_rel_incomeover100_count_d      := f_rel_incomeover100_count_d;
			self.f_rel_homeover50_count_d         := f_rel_homeover50_count_d;
			self.f_rel_homeover100_count_d        := f_rel_homeover100_count_d;
			self.f_rel_homeover150_count_d        := f_rel_homeover150_count_d;
			self.f_rel_homeover200_count_d        := f_rel_homeover200_count_d;
			self.f_rel_homeover300_count_d        := f_rel_homeover300_count_d;
			self.f_rel_homeover500_count_d        := f_rel_homeover500_count_d;
			self.f_rel_ageover20_count_d          := f_rel_ageover20_count_d;
			self.f_rel_ageover30_count_d          := f_rel_ageover30_count_d;
			self.f_rel_ageover40_count_d          := f_rel_ageover40_count_d;
			self.f_rel_ageover50_count_d          := f_rel_ageover50_count_d;
			self.f_rel_ageover60_count_d          := f_rel_ageover60_count_d;
			self.f_rel_educationover8_count_d     := f_rel_educationover8_count_d;
			self.f_rel_educationover12_count_d    := f_rel_educationover12_count_d;
			self.f_crim_rel_under25miles_cnt_i    := f_crim_rel_under25miles_cnt_i;
			self.f_crim_rel_under100miles_cnt_i   := f_crim_rel_under100miles_cnt_i;
			self.f_crim_rel_under500miles_cnt_i   := f_crim_rel_under500miles_cnt_i;
			self.f_rel_under25miles_cnt_d         := f_rel_under25miles_cnt_d;
			self.f_rel_under100miles_cnt_d        := f_rel_under100miles_cnt_d;
			self.f_rel_under500miles_cnt_d        := f_rel_under500miles_cnt_d;
			self.f_rel_bankrupt_count_i           := f_rel_bankrupt_count_i;
			self.f_rel_criminal_count_i           := f_rel_criminal_count_i;
			self.f_rel_felony_count_i             := f_rel_felony_count_i;
			self.f_current_count_d                := f_current_count_d;
			self.f_historical_count_d             := f_historical_count_d;
			self.f_accident_count_i               := f_accident_count_i;
			self.f_acc_damage_amt_total_i         := f_acc_damage_amt_total_i;
			self.f_mos_acc_lseen_d                := f_mos_acc_lseen_d;
			self.f_acc_damage_amt_last_i          := f_acc_damage_amt_last_i;
			self.f_acc_damage_amt_last_1mo_i      := f_acc_damage_amt_last_1mo_i;
			self.f_acc_damage_amt_last_3mos_i     := f_acc_damage_amt_last_3mos_i;
			self.f_acc_damage_amt_last_6mos_i     := f_acc_damage_amt_last_6mos_i;
			self.f_accident_recency_d             := f_accident_recency_d;
			self.f_idrisktype_i                   := f_idrisktype_i;
			self.f_idverrisktype_i                := f_idverrisktype_i;
			self.f_sourcerisktype_i               := f_sourcerisktype_i;
			self.f_varrisktype_i                  := f_varrisktype_i;
			self.f_varmsrcssncount_i              := f_varmsrcssncount_i;
			self.f_varmsrcssnunrelcount_i         := f_varmsrcssnunrelcount_i;
			self.f_vardobcount_i                  := f_vardobcount_i;
			self.f_vardobcountnew_i               := f_vardobcountnew_i;
			self.f_srchvelocityrisktype_i         := f_srchvelocityrisktype_i;
			self.f_srchcountwk_i                  := f_srchcountwk_i;
			self.f_srchcountday_i                 := f_srchcountday_i;
			self.f_srchunvrfdssncount_i           := f_srchunvrfdssncount_i;
			self.f_srchunvrfdaddrcount_i          := f_srchunvrfdaddrcount_i;
			self.f_srchunvrfddobcount_i           := f_srchunvrfddobcount_i;
			self.f_srchunvrfdphonecount_i         := f_srchunvrfdphonecount_i;
			self.f_srchfraudsrchcount_i           := f_srchfraudsrchcount_i;
			self.f_srchfraudsrchcountyr_i         := f_srchfraudsrchcountyr_i;
			self.f_srchfraudsrchcountmo_i         := f_srchfraudsrchcountmo_i;
			self.f_srchfraudsrchcountwk_i         := f_srchfraudsrchcountwk_i;
			self.f_srchfraudsrchcountday_i        := f_srchfraudsrchcountday_i;
			self.f_srchlocatesrchcountwk_i        := f_srchlocatesrchcountwk_i;
			self.f_srchlocatesrchcountday_i       := f_srchlocatesrchcountday_i;
			self.f_assocrisktype_i                := f_assocrisktype_i;
			self.f_assocsuspicousidcount_i        := f_assocsuspicousidcount_i;
			self.f_assoccredbureaucount_i         := f_assoccredbureaucount_i;
			self.f_assoccredbureaucountnew_i      := f_assoccredbureaucountnew_i;
			self.f_assoccredbureaucountmo_i       := f_assoccredbureaucountmo_i;
			self.f_validationrisktype_i           := f_validationrisktype_i;
			self.f_corrrisktype_i                 := f_corrrisktype_i;
			self.f_corrssnnamecount_d             := f_corrssnnamecount_d;
			self.f_corrssnaddrcount_d             := f_corrssnaddrcount_d;
			self.f_corraddrnamecount_d            := f_corraddrnamecount_d;
			self.f_corraddrphonecount_d           := f_corraddrphonecount_d;
			self.f_corrphonelastnamecount_d       := f_corrphonelastnamecount_d;
			self.f_divrisktype_i                  := f_divrisktype_i;
			self.f_divssnidmsrcurelcount_i        := f_divssnidmsrcurelcount_i;
			self.f_divaddrsuspidcountnew_i        := f_divaddrsuspidcountnew_i;
			self.f_divsrchaddrsuspidcount_i       := f_divsrchaddrsuspidcount_i;
			self.f_srchcomponentrisktype_i        := f_srchcomponentrisktype_i;
			self.f_srchssnsrchcount_i             := f_srchssnsrchcount_i;
			self.f_srchssnsrchcountmo_i           := f_srchssnsrchcountmo_i;
			self.f_srchssnsrchcountwk_i           := f_srchssnsrchcountwk_i;
			self.f_srchssnsrchcountday_i          := f_srchssnsrchcountday_i;
			self.f_srchaddrsrchcount_i            := f_srchaddrsrchcount_i;
			self.f_srchaddrsrchcountmo_i          := f_srchaddrsrchcountmo_i;
			self.f_srchaddrsrchcountwk_i          := f_srchaddrsrchcountwk_i;
			self.f_srchaddrsrchcountday_i         := f_srchaddrsrchcountday_i;
			self.f_srchphonesrchcount_i           := f_srchphonesrchcount_i;
			self.f_srchphonesrchcountmo_i         := f_srchphonesrchcountmo_i;
			self.f_srchphonesrchcountwk_i         := f_srchphonesrchcountwk_i;
			self.f_srchphonesrchcountday_i        := f_srchphonesrchcountday_i;
			self.f_componentcharrisktype_i        := f_componentcharrisktype_i;
			self.f_inputaddractivephonelist_d     := f_inputaddractivephonelist_d;
			self.f_addrchangeincomediff_d         := f_addrchangeincomediff_d;
			self.f_addrchangevaluediff_d          := f_addrchangevaluediff_d;
			self.f_addrchangecrimediff_i          := f_addrchangecrimediff_i;
			self.f_addrchangeecontrajindex_d      := f_addrchangeecontrajindex_d;
			self.f_curraddractivephonelist_d      := f_curraddractivephonelist_d;
			self.f_curraddrmedianincome_d         := f_curraddrmedianincome_d;
			self.f_curraddrmedianvalue_d          := f_curraddrmedianvalue_d;
			self.f_curraddrmurderindex_i          := f_curraddrmurderindex_i;
			self.f_curraddrcartheftindex_i        := f_curraddrcartheftindex_i;
			self.f_curraddrburglaryindex_i        := f_curraddrburglaryindex_i;
			self.f_curraddrcrimeindex_i           := f_curraddrcrimeindex_i;
			self.f_prevaddrageoldest_d            := f_prevaddrageoldest_d;
			self.f_prevaddrlenofres_d             := f_prevaddrlenofres_d;
			self.f_prevaddrdwelltype_apt_n        := f_prevaddrdwelltype_apt_n;
			self.f_prevaddrdwelltype_sfd_n        := f_prevaddrdwelltype_sfd_n;
			self.f_prevaddrstatus_i               := f_prevaddrstatus_i;
			self.f_prevaddroccupantowned_i        := f_prevaddroccupantowned_i;
			self.f_prevaddrmedianincome_d         := f_prevaddrmedianincome_d;
			self.f_prevaddrmedianvalue_d          := f_prevaddrmedianvalue_d;
			self.f_prevaddrmurderindex_i          := f_prevaddrmurderindex_i;
			self.f_prevaddrcartheftindex_i        := f_prevaddrcartheftindex_i;
			self.f_fp_prevaddrburglaryindex_i     := f_fp_prevaddrburglaryindex_i;
			self.f_fp_prevaddrcrimeindex_i        := f_fp_prevaddrcrimeindex_i;
			self.r_s65_ssn_deceased_i             := r_s65_ssn_deceased_i;
			self.r_d31_all_bk_i                   := r_d31_all_bk_i;
			self.r_d31_bk_chapter_n               := r_d31_bk_chapter_n;
			self.r_d31_bk_dism_recent_count_i     := r_d31_bk_dism_recent_count_i;
			self.r_d31_bk_dism_hist_count_i       := r_d31_bk_dism_hist_count_i;
			self.r_c22_stl_inq_count90_i          := r_c22_stl_inq_count90_i;
			self.r_c22_stl_inq_count180_i         := r_c22_stl_inq_count180_i;
			self.r_c22_stl_inq_count12_i          := r_c22_stl_inq_count12_i;
			self.r_c22_stl_inq_count24_i          := r_c22_stl_inq_count24_i;
			self.r_c22_stl_recency_d              := r_c22_stl_recency_d;
			self.r_c12_source_profile_d           := r_c12_source_profile_d;
			self.r_c12_source_profile_index_d     := r_c12_source_profile_index_d;
			self.r_f01_inp_addr_not_verified_i    := r_f01_inp_addr_not_verified_i;
			self.r_c23_inp_addr_occ_index_d       := r_c23_inp_addr_occ_index_d;
			self.r_c23_inp_addr_owned_not_occ_d   := r_c23_inp_addr_owned_not_occ_d;
			self.r_f04_curr_add_occ_index_d       := r_f04_curr_add_occ_index_d;
			self.r_e55_college_ind_d              := r_e55_college_ind_d;
			self.r_e57_br_source_count_d          := r_e57_br_source_count_d;
			self.r_i60_inq_prepaidcards_count12_i := r_i60_inq_prepaidcards_count12_i;
			self.r_i60_inq_prepaidcards_recency_d := r_i60_inq_prepaidcards_recency_d;
			self.r_i60_inq_retpymt_count12_i      := r_i60_inq_retpymt_count12_i;
			self.r_i60_inq_retpymt_recency_d      := r_i60_inq_retpymt_recency_d;
			self.r_i60_inq_stdloan_count12_i      := r_i60_inq_stdloan_count12_i;
			self.r_i60_inq_stdloan_recency_d      := r_i60_inq_stdloan_recency_d;
			self.r_i60_inq_util_count12_i         := r_i60_inq_util_count12_i;
			self.r_i60_inq_util_recency_d         := r_i60_inq_util_recency_d;
			self.f_phone_ver_insurance_d          := f_phone_ver_insurance_d;
			self.f_phone_ver_experian_d           := f_phone_ver_experian_d;
			self.f_addrs_per_ssn_i                := f_addrs_per_ssn_i;
			self.f_phones_per_addr_curr_i         := f_phones_per_addr_curr_i;
			self.f_addrs_per_ssn_c6_i             := f_addrs_per_ssn_c6_i;
			self.f_phones_per_addr_c6_i           := f_phones_per_addr_c6_i;
			self.f_adls_per_phone_c6_i            := f_adls_per_phone_c6_i;
			self.f_dl_addrs_per_adl_i             := f_dl_addrs_per_adl_i;
			self.f_inq_email_ver_count_i          := f_inq_email_ver_count_i;
			self.f_inq_count_day_i                := f_inq_count_day_i;
			self.f_inq_count_week_i               := f_inq_count_week_i;
			self.f_inq_auto_count_day_i           := f_inq_auto_count_day_i;
			self.f_inq_auto_count_week_i          := f_inq_auto_count_week_i;
			self.f_inq_banking_count_day_i        := f_inq_banking_count_day_i;
			self.f_inq_banking_count_week_i       := f_inq_banking_count_week_i;
			self.f_inq_collection_count_day_i     := f_inq_collection_count_day_i;
			self.f_inq_collection_count_week_i    := f_inq_collection_count_week_i;
			self.f_inq_communications_cnt_day_i   := f_inq_communications_cnt_day_i;
			self.f_inq_communications_cnt_week_i  := f_inq_communications_cnt_week_i;
			self.f_inq_highriskcredit_cnt_day_i   := f_inq_highriskcredit_cnt_day_i;
			self.f_inq_highriskcredit_cnt_week_i  := f_inq_highriskcredit_cnt_week_i;
			self.f_inq_mortgage_count_day_i       := f_inq_mortgage_count_day_i;
			self.f_inq_mortgage_count_week_i      := f_inq_mortgage_count_week_i;
			self.f_inq_other_count_day_i          := f_inq_other_count_day_i;
			self.f_inq_other_count_week_i         := f_inq_other_count_week_i;
			self.f_inq_prepaidcards_count_i       := f_inq_prepaidcards_count_i;
			self.f_inq_prepaidcards_count_day_i   := f_inq_prepaidcards_count_day_i;
			self.f_inq_prepaidcards_count_week_i  := f_inq_prepaidcards_count_week_i;
			self.f_inq_prepaidcards_count24_i     := f_inq_prepaidcards_count24_i;
			self.f_inq_quizprovider_count_i       := f_inq_quizprovider_count_i;
			self.f_inq_quizprovider_count_day_i   := f_inq_quizprovider_count_day_i;
			self.f_inq_quizprovider_count_week_i  := f_inq_quizprovider_count_week_i;
			self.f_inq_quizprovider_count24_i     := f_inq_quizprovider_count24_i;
			self.f_inq_retail_count_day_i         := f_inq_retail_count_day_i;
			self.f_inq_retail_count_week_i        := f_inq_retail_count_week_i;
			self.f_inq_retailpayments_cnt_i       := f_inq_retailpayments_cnt_i;
			self.f_inq_retailpayments_cnt_day_i   := f_inq_retailpayments_cnt_day_i;
			self.f_inq_retailpayments_cnt_week_i  := f_inq_retailpayments_cnt_week_i;
			self.f_inq_retailpayments_count24_i   := f_inq_retailpayments_count24_i;
			self.f_inq_studentloan_count_i        := f_inq_studentloan_count_i;
			self.f_inq_studentloan_count_day_i    := f_inq_studentloan_count_day_i;
			self.f_inq_studentloan_count_week_i   := f_inq_studentloan_count_week_i;
			self.f_inq_studentloan_count24_i      := f_inq_studentloan_count24_i;
			self.f_inq_utilities_count_i          := f_inq_utilities_count_i;
			self.f_inq_utilities_count_day_i      := f_inq_utilities_count_day_i;
			self.f_inq_utilities_count_week_i     := f_inq_utilities_count_week_i;
			self.f_inq_utilities_count24_i        := f_inq_utilities_count24_i;
			self.f_inq_billgrp_count_i            := f_inq_billgrp_count_i;
			self.f_inq_billgrp_count24_i          := f_inq_billgrp_count24_i;
			self.f_inq_email_per_adl_i            := f_inq_email_per_adl_i;
			self.f_inq_adls_per_email_i           := f_inq_adls_per_email_i;
			self.f_nae_email_verd_d               := f_nae_email_verd_d;
			self.f_nae_addr_verd_d                := f_nae_addr_verd_d;
			self.f_nae_lname_verd_d               := f_nae_lname_verd_d;
			self.f_nae_fname_verd_d               := f_nae_fname_verd_d;
			self.f_nae_nothing_found_i            := f_nae_nothing_found_i;
			self.f_nae_contradictory_i            := f_nae_contradictory_i;
			self.f_adl_per_email_i                := f_adl_per_email_i;
			self.r_c20_email_verification_d       := r_c20_email_verification_d;
			self.f_vf_hi_risk_ct_i                := f_vf_hi_risk_ct_i;
			self.f_vf_lo_risk_ct_d                := f_vf_lo_risk_ct_d;
			self.f_vf_lexid_phn_hi_risk_ct_i      := f_vf_lexid_phn_hi_risk_ct_i;
			self.f_vf_lexid_phn_lo_risk_ct_d      := f_vf_lexid_phn_lo_risk_ct_d;
			self.f_vf_altlexid_phn_hi_risk_ct_i   := f_vf_altlexid_phn_hi_risk_ct_i;
			self.f_vf_altlexid_phn_lo_risk_ct_d   := f_vf_altlexid_phn_lo_risk_ct_d;
			self.f_vf_lexid_addr_hi_risk_ct_i     := f_vf_lexid_addr_hi_risk_ct_i;
			self.f_vf_lexid_addr_lo_risk_ct_d     := f_vf_lexid_addr_lo_risk_ct_d;
			self.f_vf_altlexid_addr_hi_risk_ct_i  := f_vf_altlexid_addr_hi_risk_ct_i;
			self.f_vf_altlexid_addr_lo_risk_ct_d  := f_vf_altlexid_addr_lo_risk_ct_d;
			self.f_vf_lexid_ssn_hi_risk_ct_i      := f_vf_lexid_ssn_hi_risk_ct_i;
			self.f_vf_lexid_ssn_lo_risk_ct_d      := f_vf_lexid_ssn_lo_risk_ct_d;
			self.f_vf_altlexid_ssn_hi_risk_ct_i   := f_vf_altlexid_ssn_hi_risk_ct_i;
			self.f_vf_altlexid_ssn_lo_risk_ct_d   := f_vf_altlexid_ssn_lo_risk_ct_d;
			self.f_mos_liens_rel_sc_fseen_d       := f_mos_liens_rel_sc_fseen_d;
			self.f_mos_liens_rel_sc_lseen_d       := f_mos_liens_rel_sc_lseen_d;
			self.f_liens_rel_sc_total_amt_i       := f_liens_rel_sc_total_amt_i;
			self.f_liens_unrel_st_ct_i            := f_liens_unrel_st_ct_i;
			self.f_mos_liens_unrel_st_fseen_d     := f_mos_liens_unrel_st_fseen_d;
			self.f_mos_liens_unrel_st_lseen_d     := f_mos_liens_unrel_st_lseen_d;
			self.f_liens_unrel_st_total_amt_i     := f_liens_unrel_st_total_amt_i;
			self.f_liens_rel_st_ct_i              := f_liens_rel_st_ct_i;
			self.f_mos_liens_rel_st_fseen_d       := f_mos_liens_rel_st_fseen_d;
			self.f_mos_liens_rel_st_lseen_d       := f_mos_liens_rel_st_lseen_d;
			self.f_liens_rel_st_total_amt_i       := f_liens_rel_st_total_amt_i;
			self.f_has_professional_license_d     := f_has_professional_license_d;
			self.f_prof_license_category_ix_d     := f_prof_license_category_ix_d;
			self.f_has_hh_members_n               := f_has_hh_members_n;
			self.f_hh_members_ct_d                := f_hh_members_ct_d;
			self.f_property_owners_ct_d           := f_property_owners_ct_d;
			self.f_hh_age_65_plus_d               := f_hh_age_65_plus_d;
			self.f_hh_age_30_plus_d               := f_hh_age_30_plus_d;
			self.f_hh_age_18_plus_d               := f_hh_age_18_plus_d;
			self.f_hh_age_lt18_i                  := f_hh_age_lt18_i;
			self.f_hh_collections_ct_i            := f_hh_collections_ct_i;
			self.f_hh_workers_paw_d               := f_hh_workers_paw_d;
			self.f_hh_payday_loan_users_i         := f_hh_payday_loan_users_i;
			self.f_hh_members_w_derog_i           := f_hh_members_w_derog_i;
			self.f_hh_tot_derog_i                 := f_hh_tot_derog_i;
			self.f_hh_bankruptcies_i              := f_hh_bankruptcies_i;
			self.f_hh_lienholders_i               := f_hh_lienholders_i;
			self.f_hh_prof_license_holders_d      := f_hh_prof_license_holders_d;
			self.f_hh_criminals_i                 := f_hh_criminals_i;
			self.f_hh_college_attendees_d         := f_hh_college_attendees_d;
			self.f_prof_lic_ix_sanct_ct_n         := f_prof_lic_ix_sanct_ct_n;
			self.f_mos_prof_lic_ix_sanct_fs_n     := f_mos_prof_lic_ix_sanct_fs_n;
			self.f_mos_prof_lic_ix_sanct_ls_n     := f_mos_prof_lic_ix_sanct_ls_n;
			self.f_prof_lic_ix_sanct_type_n       := f_prof_lic_ix_sanct_type_n;
			self.nf_vf_hi_risk_ind                := nf_vf_hi_risk_ind;
			self.nf_vf_lo_risk_ind                := nf_vf_lo_risk_ind;
			self.nf_vf_lexid_addr_hi_risk_ind     := nf_vf_lexid_addr_hi_risk_ind;
			self.nf_vf_lexid_phone_hi_risk_ind    := nf_vf_lexid_phone_hi_risk_ind;
			self.nf_vf_lexid_ssn_hi_risk_ind      := nf_vf_lexid_ssn_hi_risk_ind;
			self.nf_vf_altlexid_addr_hi_risk_ind  := nf_vf_altlexid_addr_hi_risk_ind;
			self.nf_vf_altlexid_phone_hi_risk_ind := nf_vf_altlexid_phone_hi_risk_ind;
			self.nf_vf_altlexid_ssn_hi_risk_ind   := nf_vf_altlexid_ssn_hi_risk_ind;
			self.nf_vf_lexid_addr_lo_risk_ind     := nf_vf_lexid_addr_lo_risk_ind;
			self.nf_vf_lexid_phone_lo_risk_ind    := nf_vf_lexid_phone_lo_risk_ind;
			self.nf_vf_lexid_ssn_lo_risk_ind      := nf_vf_lexid_ssn_lo_risk_ind;
			self.nf_vf_altlexid_addr_lo_risk_ind  := nf_vf_altlexid_addr_lo_risk_ind;
			self.nf_vf_altlexid_phone_lo_risk_ind := nf_vf_altlexid_phone_lo_risk_ind;
			self.nf_vf_altlexid_ssn_lo_risk_ind   := nf_vf_altlexid_ssn_lo_risk_ind;
			self.nf_vf_type                       := nf_vf_type;
			self.nf_vf_lexid_hi_summary           := nf_vf_lexid_hi_summary;
			self.nf_vf_lexid_lo_summary           := nf_vf_lexid_lo_summary;
			self.nf_vf_altlexid_hi_summary        := nf_vf_altlexid_hi_summary;
			self.nf_vf_hi_summary                 := nf_vf_hi_summary;
			self.nf_vf_lo_summary                 := nf_vf_lo_summary;
			self._vf_lexid_lo_summary             := _vf_lexid_lo_summary;
			self._vf_lexid_hi_summary             := _vf_lexid_hi_summary;
			self.nf_vf_level                      := nf_vf_level;
			self.nf_vf_hi_additional_entries      := nf_vf_hi_additional_entries;
			self.nf_vf_lo_additional_entries      := nf_vf_lo_additional_entries;
			self.nf_vf_hi_addr_add_entries        := nf_vf_hi_addr_add_entries;
			self.nf_vf_hi_phone_add_entries       := nf_vf_hi_phone_add_entries;
			self.nf_vf_hi_ssn_add_entries         := nf_vf_hi_ssn_add_entries;
			self.nf_vf_lo_addr_add_entries        := nf_vf_lo_addr_add_entries;
			self.nf_vf_lo_phone_add_entries       := nf_vf_lo_phone_add_entries;
			self.nf_vf_lo_ssn_add_entries         := nf_vf_lo_ssn_add_entries;
			self.nf_altlexid_addr_hi_no_hi_lexid  := nf_altlexid_addr_hi_no_hi_lexid;
			self.nf_altlexid_phone_hi_no_hi_lexid := nf_altlexid_phone_hi_no_hi_lexid;
			self.nf_altlexid_ssn_hi_no_hi_lexid   := nf_altlexid_ssn_hi_no_hi_lexid;
			self.nf_max_altlexid_hi_no_hi_lexid   := nf_max_altlexid_hi_no_hi_lexid;
			self.nf_vf_hi_risk_hit_type           := nf_vf_hi_risk_hit_type;
			self.nf_vf_hi_risk_index              := nf_vf_hi_risk_index;
			self.nf_seg_fraudpoint_3_0            := nf_seg_fraudpoint_3_0;
			
			self.truedid	:=	truedid	;
			self.out_unit_desig	:=	out_unit_desig	;
			self.out_sec_range	:=	out_sec_range	;
			self.out_z5	:=	out_z5	;
			self.out_addr_type	:=	out_addr_type	;
			self.out_addr_status	:=	out_addr_status	;
			self.in_dob	:=	in_dob	;
			self.nas_summary	:=	nas_summary	;
			self.nap_summary	:=	nap_summary	;
			self.nap_type	:=	nap_type	;
			self.nap_status	:=	nap_status	;
			self.rc_ssndod	:=	rc_ssndod	;
			self.rc_input_addr_not_most_recent	:=	rc_input_addr_not_most_recent	;
			self.rc_hriskphoneflag	:=	rc_hriskphoneflag	;
			self.rc_hphonetypeflag	:=	rc_hphonetypeflag	;
			self.rc_phonevalflag	:=	rc_phonevalflag	;
			self.rc_hphonevalflag	:=	rc_hphonevalflag	;
			self.rc_pwphonezipflag	:=	rc_pwphonezipflag	;
			self.rc_hriskaddrflag	:=	rc_hriskaddrflag	;
			self.rc_decsflag	:=	rc_decsflag	;
			self.rc_ssndobflag	:=	rc_ssndobflag	;
			self.rc_pwssndobflag	:=	rc_pwssndobflag	;
			self.rc_ssnvalflag	:=	rc_ssnvalflag	;
			self.rc_pwssnvalflag	:=	rc_pwssnvalflag	;
			self.rc_addrvalflag	:=	rc_addrvalflag	;
			self.rc_dwelltype	:=	rc_dwelltype	;
			self.rc_ssnmiskeyflag	:=	rc_ssnmiskeyflag	;
			self.rc_addrmiskeyflag	:=	rc_addrmiskeyflag	;
			self.rc_addrcommflag	:=	rc_addrcommflag	;
			self.rc_hrisksic	:=	rc_hrisksic	;
			self.rc_hrisksicphone	:=	rc_hrisksicphone	;
			self.rc_disthphoneaddr	:=	rc_disthphoneaddr	;
			self.rc_phonetype	:=	rc_phonetype	;
			self.rc_ziptypeflag	:=	rc_ziptypeflag	;
			self.rc_zipclass	:=	rc_zipclass	;
			self.combo_ssnscore	:=	combo_ssnscore	;
			self.combo_dobscore	:=	combo_dobscore	;
			self.hdr_source_profile	:=	hdr_source_profile	;
			self.hdr_source_profile_index	:=	hdr_source_profile_index	;
			self.ver_sources	:=	ver_sources	;
			self.ver_sources_first_seen	:=	ver_sources_first_seen	;
			self.bus_addr_match_count	:=	bus_addr_match_count	;
			self.bus_name_match	:=	bus_name_match	;
			self.bus_ssn_match	:=	bus_ssn_match	;
			self.bus_phone_match	:=	bus_phone_match	;
			self.fnamepop	:=	fnamepop	;
			self.lnamepop	:=	lnamepop	;
			self.addrpop	:=	addrpop	;
			self.ssnlength	:=	ssnlength	;
			self.dobpop	:=	dobpop	;
			self.emailpop	:=	emailpop	;
			self.hphnpop	:=	hphnpop	;
			self.util_adl_type_list	:=	util_adl_type_list	;
			self.util_adl_count	:=	util_adl_count	;
			self.util_add_input_type_list	:=	util_add_input_type_list	;
			self.util_add_curr_type_list	:=	util_add_curr_type_list	;
			self.add_input_address_score	:=	add_input_address_score	;
			self.add_input_house_number_match	:=	add_input_house_number_match	;
			self.add_input_isbestmatch	:=	add_input_isbestmatch	;
			self.add_input_dirty_address	:=	add_input_dirty_address	;
			self.add_input_addr_not_verified	:=	add_input_addr_not_verified	;
			self.add_input_owned_not_occ	:=	add_input_owned_not_occ	;
			self.add_input_occ_index	:=	add_input_occ_index	;
			self.add_input_advo_vacancy	:=	add_input_advo_vacancy	;
			self.add_input_advo_throw_back	:=	add_input_advo_throw_back	;
			self.add_input_advo_seasonal	:=	add_input_advo_seasonal	;
			self.add_input_advo_dnd	:=	add_input_advo_dnd	;
			self.add_input_advo_drop	:=	add_input_advo_drop	;
			self.add_input_advo_res_or_bus	:=	add_input_advo_res_or_bus	;
			self.add_input_avm_auto_val	:=	add_input_avm_auto_val	;
			self.add_input_naprop	:=	add_input_naprop	;
			self.add_input_mortgage_date	:=	add_input_mortgage_date	;
			self.add_input_mortgage_type	:=	add_input_mortgage_type	;
			self.add_input_financing_type	:=	add_input_financing_type	;
			self.add_input_occupants_1yr	:=	add_input_occupants_1yr	;
			self.add_input_turnover_1yr_in	:=	add_input_turnover_1yr_in	;
			self.add_input_turnover_1yr_out	:=	add_input_turnover_1yr_out	;
			self.add_input_nhood_vac_prop	:=	add_input_nhood_vac_prop	;
			self.add_input_nhood_bus_ct	:=	add_input_nhood_bus_ct	;
			self.add_input_nhood_sfd_ct	:=	add_input_nhood_sfd_ct	;
			self.add_input_nhood_mfd_ct	:=	add_input_nhood_mfd_ct	;
			self.add_input_pop	:=	add_input_pop	;
			self.property_owned_total	:=	property_owned_total	;
			self.add_curr_isbestmatch	:=	add_curr_isbestmatch	;
			self.add_curr_lres	:=	add_curr_lres	;
			self.add_curr_occ_index	:=	add_curr_occ_index	;
			self.add_curr_advo_vacancy	:=	add_curr_advo_vacancy	;
			self.add_curr_advo_throw_back	:=	add_curr_advo_throw_back	;
			self.add_curr_advo_seasonal	:=	add_curr_advo_seasonal	;
			self.add_curr_advo_drop	:=	add_curr_advo_drop	;
			self.add_curr_advo_res_or_bus	:=	add_curr_advo_res_or_bus	;
			self.add_curr_avm_auto_val	:=	add_curr_avm_auto_val	;
			self.add_curr_avm_auto_val_2	:=	add_curr_avm_auto_val_2	;
			self.add_curr_naprop	:=	add_curr_naprop	;
			self.add_curr_mortgage_date	:=	add_curr_mortgage_date	;
			self.add_curr_mortgage_type	:=	add_curr_mortgage_type	;
			self.add_curr_financing_type	:=	add_curr_financing_type	;
			self.add_curr_hr_address	:=	add_curr_hr_address	;
			self.add_curr_occupants_1yr	:=	add_curr_occupants_1yr	;
			self.add_curr_turnover_1yr_in	:=	add_curr_turnover_1yr_in	;
			self.add_curr_turnover_1yr_out	:=	add_curr_turnover_1yr_out	;
			self.add_curr_nhood_vac_prop	:=	add_curr_nhood_vac_prop	;
			self.add_curr_nhood_bus_ct	:=	add_curr_nhood_bus_ct	;
			self.add_curr_nhood_sfd_ct	:=	add_curr_nhood_sfd_ct	;
			self.add_curr_nhood_mfd_ct	:=	add_curr_nhood_mfd_ct	;
			self.add_curr_pop	:=	add_curr_pop	;
			self.add_prev_naprop	:=	add_prev_naprop	;
			self.max_lres	:=	max_lres	;
			self.addrs_5yr	:=	addrs_5yr	;
			self.addrs_10yr	:=	addrs_10yr	;
			self.addrs_15yr	:=	addrs_15yr	;
			self.addrs_prison_history	:=	addrs_prison_history	;
			self.telcordia_type	:=	telcordia_type	;
			self.recent_disconnects	:=	recent_disconnects	;
			self.phone_ver_insurance	:=	phone_ver_insurance	;
			self.phone_ver_experian	:=	phone_ver_experian	;
			self.header_first_seen	:=	header_first_seen	;
			self.inputssncharflag	:=	inputssncharflag	;
			self.ssns_per_adl	:=	ssns_per_adl	;
			self.adls_per_ssn	:=	adls_per_ssn	;
			self.addrs_per_ssn	:=	addrs_per_ssn	;
			self.adls_per_addr_curr	:=	adls_per_addr_curr	;
			self.phones_per_addr_curr	:=	phones_per_addr_curr	;
			self.ssns_per_adl_c6	:=	ssns_per_adl_c6	;
			self.addrs_per_adl_c6	:=	addrs_per_adl_c6	;
			self.lnames_per_adl_c6	:=	lnames_per_adl_c6	;
			self.addrs_per_ssn_c6	:=	addrs_per_ssn_c6	;
			self.adls_per_addr_c6	:=	adls_per_addr_c6	;
			self.phones_per_addr_c6	:=	phones_per_addr_c6	;
			self.adls_per_phone_c6	:=	adls_per_phone_c6	;
			self.dl_addrs_per_adl	:=	dl_addrs_per_adl	;
			self.invalid_phones_per_adl	:=	invalid_phones_per_adl	;
			self.invalid_phones_per_adl_c6	:=	invalid_phones_per_adl_c6	;
			self.invalid_ssns_per_adl	:=	invalid_ssns_per_adl	;
			self.invalid_ssns_per_adl_c6	:=	invalid_ssns_per_adl_c6	;
			self.invalid_addrs_per_adl	:=	invalid_addrs_per_adl	;
			self.invalid_addrs_per_adl_c6	:=	invalid_addrs_per_adl_c6	;
			self.inq_email_ver_count	:=	inq_email_ver_count	;
			self.inq_count	:=	inq_count	;
			self.inq_count_day	:=	inq_count_day	;
			self.inq_count_week	:=	inq_count_week	;
			self.inq_count01	:=	inq_count01	;
			self.inq_count03	:=	inq_count03	;
			self.inq_count06	:=	inq_count06	;
			self.inq_count12	:=	inq_count12	;
			self.inq_count24	:=	inq_count24	;
			self.inq_auto_count	:=	inq_auto_count	;
			self.inq_auto_count_day	:=	inq_auto_count_day	;
			self.inq_auto_count_week	:=	inq_auto_count_week	;
			self.inq_auto_count01	:=	inq_auto_count01	;
			self.inq_auto_count03	:=	inq_auto_count03	;
			self.inq_auto_count06	:=	inq_auto_count06	;
			self.inq_auto_count12	:=	inq_auto_count12	;
			self.inq_auto_count24	:=	inq_auto_count24	;
			self.inq_banking_count	:=	inq_banking_count	;
			self.inq_banking_count_day	:=	inq_banking_count_day	;
			self.inq_banking_count_week	:=	inq_banking_count_week	;
			self.inq_banking_count01	:=	inq_banking_count01	;
			self.inq_banking_count03	:=	inq_banking_count03	;
			self.inq_banking_count06	:=	inq_banking_count06	;
			self.inq_banking_count12	:=	inq_banking_count12	;
			self.inq_banking_count24	:=	inq_banking_count24	;
			self.inq_collection_count	:=	inq_collection_count	;
			self.inq_collection_count_day	:=	inq_collection_count_day	;
			self.inq_collection_count_week	:=	inq_collection_count_week	;
			self.inq_collection_count01	:=	inq_collection_count01	;
			self.inq_collection_count03	:=	inq_collection_count03	;
			self.inq_collection_count06	:=	inq_collection_count06	;
			self.inq_collection_count12	:=	inq_collection_count12	;
			self.inq_collection_count24	:=	inq_collection_count24	;
			self.inq_communications_count	:=	inq_communications_count	;
			self.inq_communications_count_day	:=	inq_communications_count_day	;
			self.inq_communications_count_week	:=	inq_communications_count_week	;
			self.inq_communications_count01	:=	inq_communications_count01	;
			self.inq_communications_count03	:=	inq_communications_count03	;
			self.inq_communications_count06	:=	inq_communications_count06	;
			self.inq_communications_count12	:=	inq_communications_count12	;
			self.inq_communications_count24	:=	inq_communications_count24	;
			self.inq_highriskcredit_count	:=	inq_highriskcredit_count	;
			self.inq_highriskcredit_count_day	:=	inq_highriskcredit_count_day	;
			self.inq_highriskcredit_count_week	:=	inq_highriskcredit_count_week	;
			self.inq_highriskcredit_count01	:=	inq_highriskcredit_count01	;
			self.inq_highriskcredit_count03	:=	inq_highriskcredit_count03	;
			self.inq_highriskcredit_count06	:=	inq_highriskcredit_count06	;
			self.inq_highriskcredit_count12	:=	inq_highriskcredit_count12	;
			self.inq_highriskcredit_count24	:=	inq_highriskcredit_count24	;
			self.inq_mortgage_count	:=	inq_mortgage_count	;
			self.inq_mortgage_count_day	:=	inq_mortgage_count_day	;
			self.inq_mortgage_count_week	:=	inq_mortgage_count_week	;
			self.inq_mortgage_count01	:=	inq_mortgage_count01	;
			self.inq_mortgage_count03	:=	inq_mortgage_count03	;
			self.inq_mortgage_count06	:=	inq_mortgage_count06	;
			self.inq_mortgage_count12	:=	inq_mortgage_count12	;
			self.inq_mortgage_count24	:=	inq_mortgage_count24	;
			self.inq_other_count	:=	inq_other_count	;
			self.inq_other_count_day	:=	inq_other_count_day	;
			self.inq_other_count_week	:=	inq_other_count_week	;
			self.inq_other_count24	:=	inq_other_count24	;
			self.inq_prepaidcards_count	:=	inq_prepaidcards_count	;
			self.inq_prepaidcards_count_day	:=	inq_prepaidcards_count_day	;
			self.inq_prepaidcards_count_week	:=	inq_prepaidcards_count_week	;
			self.inq_prepaidcards_count01	:=	inq_prepaidcards_count01	;
			self.inq_prepaidcards_count03	:=	inq_prepaidcards_count03	;
			self.inq_prepaidcards_count06	:=	inq_prepaidcards_count06	;
			self.inq_prepaidcards_count12	:=	inq_prepaidcards_count12	;
			self.inq_prepaidcards_count24	:=	inq_prepaidcards_count24	;
			self.inq_quizprovider_count	:=	inq_quizprovider_count	;
			self.inq_quizprovider_count_day	:=	inq_quizprovider_count_day	;
			self.inq_quizprovider_count_week	:=	inq_quizprovider_count_week	;
			self.inq_quizprovider_count24	:=	inq_quizprovider_count24	;
			self.inq_retail_count	:=	inq_retail_count	;
			self.inq_retail_count_day	:=	inq_retail_count_day	;
			self.inq_retail_count_week	:=	inq_retail_count_week	;
			self.inq_retail_count01	:=	inq_retail_count01	;
			self.inq_retail_count03	:=	inq_retail_count03	;
			self.inq_retail_count06	:=	inq_retail_count06	;
			self.inq_retail_count12	:=	inq_retail_count12	;
			self.inq_retail_count24	:=	inq_retail_count24	;
			self.inq_retailpayments_count	:=	inq_retailpayments_count	;
			self.inq_retailpayments_count_day	:=	inq_retailpayments_count_day	;
			self.inq_retailpayments_count_week	:=	inq_retailpayments_count_week	;
			self.inq_retailpayments_count01	:=	inq_retailpayments_count01	;
			self.inq_retailpayments_count03	:=	inq_retailpayments_count03	;
			self.inq_retailpayments_count06	:=	inq_retailpayments_count06	;
			self.inq_retailpayments_count12	:=	inq_retailpayments_count12	;
			self.inq_retailpayments_count24	:=	inq_retailpayments_count24	;
			self.inq_studentloan_count	:=	inq_studentloan_count	;
			self.inq_studentloan_count_day	:=	inq_studentloan_count_day	;
			self.inq_studentloan_count_week	:=	inq_studentloan_count_week	;
			self.inq_studentloan_count01	:=	inq_studentloan_count01	;
			self.inq_studentloan_count03	:=	inq_studentloan_count03	;
			self.inq_studentloan_count06	:=	inq_studentloan_count06	;
			self.inq_studentloan_count12	:=	inq_studentloan_count12	;
			self.inq_studentloan_count24	:=	inq_studentloan_count24	;
			self.inq_utilities_count	:=	inq_utilities_count	;
			self.inq_utilities_count_day	:=	inq_utilities_count_day	;
			self.inq_utilities_count_week	:=	inq_utilities_count_week	;
			self.inq_utilities_count01	:=	inq_utilities_count01	;
			self.inq_utilities_count03	:=	inq_utilities_count03	;
			self.inq_utilities_count06	:=	inq_utilities_count06	;
			self.inq_utilities_count12	:=	inq_utilities_count12	;
			self.inq_utilities_count24	:=	inq_utilities_count24	;
			self.inq_billgroup_count	:=	inq_billgroup_count	;
			self.inq_billgroup_count24	:=	inq_billgroup_count24	;
			self.inq_perssn	:=	inq_perssn	;
			self.inq_adlsperssn	:=	inq_adlsperssn	;
			self.inq_lnamesperssn	:=	inq_lnamesperssn	;
			self.inq_addrsperssn	:=	inq_addrsperssn	;
			self.inq_dobsperssn	:=	inq_dobsperssn	;
			self.inq_peraddr	:=	inq_peraddr	;
			self.inq_adlsperaddr	:=	inq_adlsperaddr	;
			self.inq_lnamesperaddr	:=	inq_lnamesperaddr	;
			self.inq_ssnsperaddr	:=	inq_ssnsperaddr	;
			self.inq_perphone	:=	inq_perphone	;
			self.inq_adlsperphone	:=	inq_adlsperphone	;
			self.inq_email_per_adl	:=	inq_email_per_adl	;
			self.inq_adls_per_email	:=	inq_adls_per_email	;
			self.inq_banko_am_first_seen	:=	inq_banko_am_first_seen	;
			self.inq_banko_am_last_seen	:=	inq_banko_am_last_seen	;
			self.inq_banko_cm_first_seen	:=	inq_banko_cm_first_seen	;
			self.inq_banko_cm_last_seen	:=	inq_banko_cm_last_seen	;
			self.inq_banko_om_first_seen	:=	inq_banko_om_first_seen	;
			self.inq_banko_om_last_seen	:=	inq_banko_om_last_seen	;
			self.pb_number_of_sources	:=	pb_number_of_sources	;
			self.pb_average_days_bt_orders	:=	pb_average_days_bt_orders	;
			self.pb_average_dollars	:=	pb_average_dollars	;
			self.pb_total_dollars	:=	pb_total_dollars	;
			self.pb_total_orders	:=	pb_total_orders	;
			self.br_source_count	:=	br_source_count	;
			self.infutor_nap	:=	infutor_nap	;
			self.stl_inq_count	:=	stl_inq_count	;
			self.stl_inq_count90	:=	stl_inq_count90	;
			self.stl_inq_count180	:=	stl_inq_count180	;
			self.stl_inq_count12	:=	stl_inq_count12	;
			self.stl_inq_count24	:=	stl_inq_count24	;
			self.email_count	:=	email_count	;
			self.email_domain_free_count	:=	email_domain_free_count	;
			self.email_domain_isp_count	:=	email_domain_isp_count	;
			self.email_name_addr_verification	:=	email_name_addr_verification	;
			self.email_verification	:=	email_verification	;
			self.adl_per_email	:=	adl_per_email	;
			self.attr_num_aircraft	:=	attr_num_aircraft	;
			self.attr_total_number_derogs	:=	attr_total_number_derogs	;
			self.attr_arrests	:=	attr_arrests	;
			self.attr_arrests30	:=	attr_arrests30	;
			self.attr_arrests90	:=	attr_arrests90	;
			self.attr_arrests180	:=	attr_arrests180	;
			self.attr_arrests12	:=	attr_arrests12	;
			self.attr_arrests24	:=	attr_arrests24	;
			self.attr_arrests36	:=	attr_arrests36	;
			self.attr_arrests60	:=	attr_arrests60	;
			self.attr_num_unrel_liens60	:=	attr_num_unrel_liens60	;
			self.attr_bankruptcy_count30	:=	attr_bankruptcy_count30	;
			self.attr_bankruptcy_count90	:=	attr_bankruptcy_count90	;
			self.attr_bankruptcy_count180	:=	attr_bankruptcy_count180	;
			self.attr_bankruptcy_count12	:=	attr_bankruptcy_count12	;
			self.attr_bankruptcy_count24	:=	attr_bankruptcy_count24	;
			self.attr_bankruptcy_count36	:=	attr_bankruptcy_count36	;
			self.attr_bankruptcy_count60	:=	attr_bankruptcy_count60	;
			self.attr_eviction_count	:=	attr_eviction_count	;
			self.attr_eviction_count90	:=	attr_eviction_count90	;
			self.attr_eviction_count180	:=	attr_eviction_count180	;
			self.attr_eviction_count12	:=	attr_eviction_count12	;
			self.attr_eviction_count24	:=	attr_eviction_count24	;
			self.attr_eviction_count36	:=	attr_eviction_count36	;
			self.attr_eviction_count60	:=	attr_eviction_count60	;
			self.attr_num_nonderogs	:=	attr_num_nonderogs	;
			self.attr_num_nonderogs90	:=	attr_num_nonderogs90	;
			self.attr_num_nonderogs180	:=	attr_num_nonderogs180	;
			self.attr_num_nonderogs12	:=	attr_num_nonderogs12	;
			self.attr_num_nonderogs24	:=	attr_num_nonderogs24	;
			self.attr_num_nonderogs36	:=	attr_num_nonderogs36	;
			self.attr_num_nonderogs60	:=	attr_num_nonderogs60	;
			self.vf_hi_risk_ct	:=	vf_hi_risk_ct	;
			self.vf_lo_risk_ct	:=	vf_lo_risk_ct	;
			self.vf_lexid_phone_hi_risk_ct	:=	vf_lexid_phone_hi_risk_ct	;
			self.vf_lexid_phone_lo_risk_ct	:=	vf_lexid_phone_lo_risk_ct	;
			self.vf_altlexid_phone_hi_risk_ct	:=	vf_altlexid_phone_hi_risk_ct	;
			self.vf_altlexid_phone_lo_risk_ct	:=	vf_altlexid_phone_lo_risk_ct	;
			self.vf_lexid_addr_hi_risk_ct	:=	vf_lexid_addr_hi_risk_ct	;
			self.vf_lexid_addr_lo_risk_ct	:=	vf_lexid_addr_lo_risk_ct	;
			self.vf_altlexid_addr_hi_risk_ct	:=	vf_altlexid_addr_hi_risk_ct	;
			self.vf_altlexid_addr_lo_risk_ct	:=	vf_altlexid_addr_lo_risk_ct	;
			self.vf_lexid_ssn_hi_risk_ct	:=	vf_lexid_ssn_hi_risk_ct	;
			self.vf_lexid_ssn_lo_risk_ct	:=	vf_lexid_ssn_lo_risk_ct	;
			self.vf_altlexid_ssn_hi_risk_ct	:=	vf_altlexid_ssn_hi_risk_ct	;
			self.vf_altlexid_ssn_lo_risk_ct	:=	vf_altlexid_ssn_lo_risk_ct	;
			self.fp_idrisktype	:=	fp_idrisktype	;
			self.fp_idverrisktype	:=	fp_idverrisktype	;
			self.fp_sourcerisktype	:=	fp_sourcerisktype	;
			self.fp_varrisktype	:=	fp_varrisktype	;
			self.fp_varmsrcssncount	:=	fp_varmsrcssncount	;
			self.fp_varmsrcssnunrelcount	:=	fp_varmsrcssnunrelcount	;
			self.fp_vardobcount	:=	fp_vardobcount	;
			self.fp_vardobcountnew	:=	fp_vardobcountnew	;
			self.fp_srchvelocityrisktype	:=	fp_srchvelocityrisktype	;
			self.fp_srchcountwk	:=	fp_srchcountwk	;
			self.fp_srchcountday	:=	fp_srchcountday	;
			self.fp_srchunvrfdssncount	:=	fp_srchunvrfdssncount	;
			self.fp_srchunvrfdaddrcount	:=	fp_srchunvrfdaddrcount	;
			self.fp_srchunvrfddobcount	:=	fp_srchunvrfddobcount	;
			self.fp_srchunvrfdphonecount	:=	fp_srchunvrfdphonecount	;
			self.fp_srchfraudsrchcount	:=	fp_srchfraudsrchcount	;
			self.fp_srchfraudsrchcountyr	:=	fp_srchfraudsrchcountyr	;
			self.fp_srchfraudsrchcountmo	:=	fp_srchfraudsrchcountmo	;
			self.fp_srchfraudsrchcountwk	:=	fp_srchfraudsrchcountwk	;
			self.fp_srchfraudsrchcountday	:=	fp_srchfraudsrchcountday	;
			self.fp_srchlocatesrchcountwk	:=	fp_srchlocatesrchcountwk	;
			self.fp_srchlocatesrchcountday	:=	fp_srchlocatesrchcountday	;
			self.fp_assocrisktype	:=	fp_assocrisktype	;
			self.fp_assocsuspicousidcount	:=	fp_assocsuspicousidcount	;
			self.fp_assoccredbureaucount	:=	fp_assoccredbureaucount	;
			self.fp_assoccredbureaucountnew	:=	fp_assoccredbureaucountnew	;
			self.fp_assoccredbureaucountmo	:=	fp_assoccredbureaucountmo	;
			self.fp_validationrisktype	:=	fp_validationrisktype	;
			self.fp_corrrisktype	:=	fp_corrrisktype	;
			self.fp_corrssnnamecount	:=	fp_corrssnnamecount	;
			self.fp_corrssnaddrcount	:=	fp_corrssnaddrcount	;
			self.fp_corraddrnamecount	:=	fp_corraddrnamecount	;
			self.fp_corraddrphonecount	:=	fp_corraddrphonecount	;
			self.fp_corrphonelastnamecount	:=	fp_corrphonelastnamecount	;
			self.fp_divrisktype	:=	fp_divrisktype	;
			self.fp_divssnidmsrcurelcount	:=	fp_divssnidmsrcurelcount	;
			self.fp_divaddrsuspidcountnew	:=	fp_divaddrsuspidcountnew	;
			self.fp_divsrchaddrsuspidcount	:=	fp_divsrchaddrsuspidcount	;
			self.fp_srchcomponentrisktype	:=	fp_srchcomponentrisktype	;
			self.fp_srchssnsrchcount	:=	fp_srchssnsrchcount	;
			self.fp_srchssnsrchcountmo	:=	fp_srchssnsrchcountmo	;
			self.fp_srchssnsrchcountwk	:=	fp_srchssnsrchcountwk	;
			self.fp_srchssnsrchcountday	:=	fp_srchssnsrchcountday	;
			self.fp_srchaddrsrchcount	:=	fp_srchaddrsrchcount	;
			self.fp_srchaddrsrchcountmo	:=	fp_srchaddrsrchcountmo	;
			self.fp_srchaddrsrchcountwk	:=	fp_srchaddrsrchcountwk	;
			self.fp_srchaddrsrchcountday	:=	fp_srchaddrsrchcountday	;
			self.fp_srchphonesrchcount	:=	fp_srchphonesrchcount	;
			self.fp_srchphonesrchcountmo	:=	fp_srchphonesrchcountmo	;
			self.fp_srchphonesrchcountwk	:=	fp_srchphonesrchcountwk	;
			self.fp_srchphonesrchcountday	:=	fp_srchphonesrchcountday	;
			self.fp_componentcharrisktype	:=	fp_componentcharrisktype	;
			self.fp_inputaddractivephonelist	:=	fp_inputaddractivephonelist	;
			self.fp_addrchangeincomediff	:=	fp_addrchangeincomediff	;
			self.fp_addrchangevaluediff	:=	fp_addrchangevaluediff	;
			self.fp_addrchangecrimediff	:=	fp_addrchangecrimediff	;
			self.fp_addrchangeecontrajindex	:=	fp_addrchangeecontrajindex	;
			self.fp_curraddractivephonelist	:=	fp_curraddractivephonelist	;
			self.fp_curraddrmedianincome	:=	fp_curraddrmedianincome	;
			self.fp_curraddrmedianvalue	:=	fp_curraddrmedianvalue	;
			self.fp_curraddrmurderindex	:=	fp_curraddrmurderindex	;
			self.fp_curraddrcartheftindex	:=	fp_curraddrcartheftindex	;
			self.fp_curraddrburglaryindex	:=	fp_curraddrburglaryindex	;
			self.fp_curraddrcrimeindex	:=	fp_curraddrcrimeindex	;
			self.fp_prevaddrageoldest	:=	fp_prevaddrageoldest	;
			self.fp_prevaddrlenofres	:=	fp_prevaddrlenofres	;
			self.fp_prevaddrdwelltype	:=	fp_prevaddrdwelltype	;
			self.fp_prevaddrstatus	:=	fp_prevaddrstatus	;
			self.fp_prevaddroccupantowned	:=	fp_prevaddroccupantowned	;
			self.fp_prevaddrmedianincome	:=	fp_prevaddrmedianincome	;
			self.fp_prevaddrmedianvalue	:=	fp_prevaddrmedianvalue	;
			self.fp_prevaddrmurderindex	:=	fp_prevaddrmurderindex	;
			self.fp_prevaddrcartheftindex	:=	fp_prevaddrcartheftindex	;
			self.fp_prevaddrburglaryindex	:=	fp_prevaddrburglaryindex	;
			self.fp_prevaddrcrimeindex	:=	fp_prevaddrcrimeindex	;
			self.bankrupt	:=	bankrupt	;
			self.disposition	:=	disposition	;
			self.filing_count	:=	filing_count	;
			self.bk_dismissed_recent_count	:=	bk_dismissed_recent_count	;
			self.bk_dismissed_historical_count	:=	bk_dismissed_historical_count	;
			self.bk_chapter	:=	bk_chapter	;
			self.bk_disposed_recent_count	:=	bk_disposed_recent_count	;
			self.bk_disposed_historical_count	:=	bk_disposed_historical_count	;
			self.liens_recent_unreleased_count	:=	liens_recent_unreleased_count	;
			self.liens_historical_unreleased_ct	:=	liens_historical_unreleased_ct	;
			self.liens_unrel_cj_first_seen	:=	liens_unrel_cj_first_seen	;
			self.liens_unrel_cj_last_seen	:=	liens_unrel_cj_last_seen	;
			self.liens_unrel_cj_total_amount	:=	liens_unrel_cj_total_amount	;
			self.liens_rel_cj_first_seen	:=	liens_rel_cj_first_seen	;
			self.liens_rel_cj_last_seen	:=	liens_rel_cj_last_seen	;
			self.liens_rel_cj_total_amount	:=	liens_rel_cj_total_amount	;
			self.liens_unrel_ft_first_seen	:=	liens_unrel_ft_first_seen	;
			self.liens_unrel_ft_last_seen	:=	liens_unrel_ft_last_seen	;
			self.liens_unrel_ft_total_amount	:=	liens_unrel_ft_total_amount	;
			self.liens_rel_ft_first_seen	:=	liens_rel_ft_first_seen	;
			self.liens_rel_ft_last_seen	:=	liens_rel_ft_last_seen	;
			self.liens_rel_ft_total_amount	:=	liens_rel_ft_total_amount	;
			self.liens_unrel_fc_first_seen	:=	liens_unrel_fc_first_seen	;
			self.liens_unrel_fc_last_seen	:=	liens_unrel_fc_last_seen	;
			self.liens_unrel_fc_total_amount	:=	liens_unrel_fc_total_amount	;
			self.liens_rel_fc_first_seen	:=	liens_rel_fc_first_seen	;
			self.liens_rel_fc_last_seen	:=	liens_rel_fc_last_seen	;
			self.liens_rel_fc_total_amount	:=	liens_rel_fc_total_amount	;
			self.liens_unrel_lt_first_seen	:=	liens_unrel_lt_first_seen	;
			self.liens_unrel_lt_last_seen	:=	liens_unrel_lt_last_seen	;
			self.liens_rel_lt_first_seen	:=	liens_rel_lt_first_seen	;
			self.liens_rel_lt_last_seen	:=	liens_rel_lt_last_seen	;
			self.liens_unrel_o_first_seen	:=	liens_unrel_o_first_seen	;
			self.liens_unrel_o_last_seen	:=	liens_unrel_o_last_seen	;
			self.liens_unrel_o_total_amount	:=	liens_unrel_o_total_amount	;
			self.liens_rel_o_first_seen	:=	liens_rel_o_first_seen	;
			self.liens_rel_o_last_seen	:=	liens_rel_o_last_seen	;
			self.liens_rel_o_total_amount	:=	liens_rel_o_total_amount	;
			self.liens_unrel_ot_first_seen	:=	liens_unrel_ot_first_seen	;
			self.liens_unrel_ot_last_seen	:=	liens_unrel_ot_last_seen	;
			self.liens_unrel_ot_total_amount	:=	liens_unrel_ot_total_amount	;
			self.liens_rel_ot_first_seen	:=	liens_rel_ot_first_seen	;
			self.liens_rel_ot_last_seen	:=	liens_rel_ot_last_seen	;
			self.liens_rel_ot_total_amount	:=	liens_rel_ot_total_amount	;
			self.liens_unrel_sc_first_seen	:=	liens_unrel_sc_first_seen	;
			self.liens_unrel_sc_last_seen	:=	liens_unrel_sc_last_seen	;
			self.liens_unrel_sc_total_amount	:=	liens_unrel_sc_total_amount	;
			self.liens_rel_sc_first_seen	:=	liens_rel_sc_first_seen	;
			self.liens_rel_sc_last_seen	:=	liens_rel_sc_last_seen	;
			self.liens_rel_sc_total_amount	:=	liens_rel_sc_total_amount	;
			self.liens_unrel_st_ct	:=	liens_unrel_st_ct	;
			self.liens_unrel_st_first_seen	:=	liens_unrel_st_first_seen	;
			self.liens_unrel_st_last_seen	:=	liens_unrel_st_last_seen	;
			self.liens_unrel_st_total_amount	:=	liens_unrel_st_total_amount	;
			self.liens_rel_st_ct	:=	liens_rel_st_ct	;
			self.liens_rel_st_first_seen	:=	liens_rel_st_first_seen	;
			self.liens_rel_st_last_seen	:=	liens_rel_st_last_seen	;
			self.liens_rel_st_total_amount	:=	liens_rel_st_total_amount	;
			self.criminal_count	:=	criminal_count	;
			self.criminal_last_date	:=	criminal_last_date	;
			self.felony_count	:=	felony_count	;
			self.felony_last_date	:=	felony_last_date	;
			self.foreclosure_flag	:=	foreclosure_flag	;
			self.foreclosure_last_date	:=	foreclosure_last_date	;
			self.hh_members_ct	:=	hh_members_ct	;
			self.hh_property_owners_ct	:=	hh_property_owners_ct	;
			self.hh_age_65_plus	:=	hh_age_65_plus	;
			self.hh_age_30_to_65	:=	hh_age_30_to_65	;
			self.hh_age_18_to_30	:=	hh_age_18_to_30	;
			self.hh_age_lt18	:=	hh_age_lt18	;
			self.hh_collections_ct	:=	hh_collections_ct	;
			self.hh_workers_paw	:=	hh_workers_paw	;
			self.hh_payday_loan_users	:=	hh_payday_loan_users	;
			self.hh_members_w_derog	:=	hh_members_w_derog	;
			self.hh_tot_derog	:=	hh_tot_derog	;
			self.hh_bankruptcies	:=	hh_bankruptcies	;
			self.hh_lienholders	:=	hh_lienholders	;
			self.hh_prof_license_holders	:=	hh_prof_license_holders	;
			self.hh_criminals	:=	hh_criminals	;
			self.hh_college_attendees	:=	hh_college_attendees	;
			self.rel_count	:=	rel_count	;
			self.rel_bankrupt_count	:=	rel_bankrupt_count	;
			self.rel_criminal_count	:=	rel_criminal_count	;
			self.rel_felony_count	:=	rel_felony_count	;
			self.crim_rel_within25miles	:=	crim_rel_within25miles	;
			self.crim_rel_within100miles	:=	crim_rel_within100miles	;
			self.crim_rel_within500miles	:=	crim_rel_within500miles	;
			self.rel_within25miles_count	:=	rel_within25miles_count	;
			self.rel_within100miles_count	:=	rel_within100miles_count	;
			self.rel_within500miles_count	:=	rel_within500miles_count	;
			self.rel_incomeunder50_count	:=	rel_incomeunder50_count	;
			self.rel_incomeunder75_count	:=	rel_incomeunder75_count	;
			self.rel_incomeunder100_count	:=	rel_incomeunder100_count	;
			self.rel_incomeover100_count	:=	rel_incomeover100_count	;
			self.rel_homeunder100_count	:=	rel_homeunder100_count	;
			self.rel_homeunder150_count	:=	rel_homeunder150_count	;
			self.rel_homeunder200_count	:=	rel_homeunder200_count	;
			self.rel_homeunder300_count	:=	rel_homeunder300_count	;
			self.rel_homeunder500_count	:=	rel_homeunder500_count	;
			self.rel_homeover500_count	:=	rel_homeover500_count	;
			self.rel_educationunder12_count	:=	rel_educationunder12_count	;
			self.rel_educationover12_count	:=	rel_educationover12_count	;
			self.rel_ageunder30_count	:=	rel_ageunder30_count	;
			self.rel_ageunder40_count	:=	rel_ageunder40_count	;
			self.rel_ageunder50_count	:=	rel_ageunder50_count	;
			self.rel_ageunder60_count	:=	rel_ageunder60_count	;
			self.rel_ageunder70_count	:=	rel_ageunder70_count	;
			self.rel_ageover70_count	:=	rel_ageover70_count	;
			self.current_count	:=	current_count	;
			self.historical_count	:=	historical_count	;
			self.watercraft_count	:=	watercraft_count	;
			self.acc_count	:=	acc_count	;
			self.acc_damage_amt_total	:=	acc_damage_amt_total	;
			self.acc_last_seen	:=	acc_last_seen	;
			self.acc_damage_amt_last	:=	acc_damage_amt_last	;
			self.acc_count_30	:=	acc_count_30	;
			self.acc_count_90	:=	acc_count_90	;
			self.acc_count_180	:=	acc_count_180	;
			self.acc_count_12	:=	acc_count_12	;
			self.acc_count_24	:=	acc_count_24	;
			self.acc_count_36	:=	acc_count_36	;
			self.acc_count_60	:=	acc_count_60	;
			self.college_income_level_code	:=	college_income_level_code	;
			self.college_file_type	:=	college_file_type	;
			self.college_attendance	:=	college_attendance	;
			self.prof_license_flag	:=	prof_license_flag	;
			self.prof_license_category	:=	prof_license_category	;
			self.prof_license_source	:=	prof_license_source	;
			self.prof_license_ix_sanct_ct	:=	prof_license_ix_sanct_ct	;
			self.prof_license_ix_sanct_fs	:=	prof_license_ix_sanct_fs	;
			self.prof_license_ix_sanct_ls	:=	prof_license_ix_sanct_ls	;
			self.prof_license_ix_sanct_type	:=	prof_license_ix_sanct_type	;
			self.wealth_index	:=	wealth_index	;
			self.input_dob_match_level	:=	input_dob_match_level	;
			self.inferred_age	:=	inferred_age	;
			self.addr_stability_v2	:=	addr_stability_v2	;
			self.estimated_income	:=	estimated_income	;
			//pick up all needed fields from the EASI census file here
			self.c_POP00	:=	if(ri.POP00 = '', NULL, (real)ri.POP00)	;
			self.c_FAMILIES	:=	if(ri.FAMILIES = '', NULL, (real)503.118697144368);
			self.c_HH00	:=	if(ri.HH00 = '', NULL, (real)ri.HH00)	;
			self.c_HHSIZE	:=	if(ri.HHSIZE = '', NULL, (real)ri.HHSIZE)	;
			self.c_MED_AGE	:=	if(ri.MED_AGE = '', NULL, (real)ri.MED_AGE)	;
			self.c_MED_RENT	:=	if(ri.MED_RENT = '', NULL, (real)ri.MED_RENT)	;
			self.c_MED_HVAL	:=	if(ri.MED_HVAL = '', NULL, (real)ri.MED_HVAL)	;
			self.c_MED_YEARBLT	:=	if(ri.MED_YEARBLT = '', NULL, (real)ri.MED_YEARBLT)	;
			self.c_MED_HHINC	:=	if(ri.MED_HHINC = '', NULL, (real)ri.MED_HHINC)	;
			self.c_URBAN_P	:=	if(ri.URBAN_P = '', NULL, (real)ri.URBAN_P)	;
			self.c_RURAL_P	:=	if(ri.RURAL_P = '', NULL, (real)ri.RURAL_P)	;
			self.c_FAMMAR_P	:=	if(ri.FAMMAR_P = '', NULL, (real)75.922350982431);
			self.c_FAMMAR18_P	:=	if(ri.FAMMAR18_P = '', NULL, (real)35.1609726337807);
			self.c_FAMOTF18_P	:=	if(ri.FAMOTF18_P = '', NULL, (real)11.6471701137404);
			self.c_POP_0_5_P	:=	if(ri.POP_0_5_P = '', NULL, (real)ri.POP_0_5_P)	;
			self.c_POP_6_11_P	:=	if(ri.POP_6_11_P = '', NULL, (real)ri.POP_6_11_P)	;
			self.c_POP_12_17_P	:=	if(ri.POP_12_17_P = '', NULL, (real)ri.POP_12_17_P)	;
			self.c_POP_18_24_P	:=	if(ri.POP_18_24_P = '', NULL, (real)ri.POP_18_24_P)	;
			self.c_POP_25_34_P	:=	if(ri.POP_25_34_P = '', NULL, (real)ri.POP_25_34_P)	;
			self.c_POP_35_44_P	:=	if(ri.POP_35_44_P = '', NULL, (real)ri.POP_35_44_P)	;
			self.c_POP_45_54_P	:=	if(ri.POP_45_54_P = '', NULL, (real)ri.POP_45_54_P)	;
			self.c_POP_55_64_P	:=	if(ri.POP_55_64_P = '', NULL, (real)ri.POP_55_64_P)	;
			self.c_POP_65_74_P	:=	if(ri.POP_65_74_P = '', NULL, (real)ri.POP_65_74_P)	;
			self.c_POP_75_84_P	:=	if(ri.POP_75_84_P = '', NULL, (real)ri.POP_75_84_P)	;
			self.c_POP_85P_P	:=	if(ri.POP_85P_P = '', NULL, (real)ri.POP_85P_P)	;
			self.c_CHILD	:=	if(ri.CHILD = '', NULL, (real)ri.CHILD)	;
			self.c_YOUNG	:=	if(ri.YOUNG = '', NULL, (real)ri.YOUNG)	;
			self.c_RETIRED	:=	if(ri.RETIRED = '', NULL, (real)12.6118637038462);
			self.c_FEMDIV_P	:=  if(ri.FEMDIV_P = '', NULL, (real)4.75019023519441);
			self.c_HH1_P	:=	if(ri.HH1_P = '', NULL, (real)ri.HH1_P)	;
			self.c_HH2_P	:=	if(ri.HH2_P = '', NULL, (real)ri.HH2_P)	;
			self.c_HH3_P	:=	if(ri.HH3_P = '', NULL, (real)ri.HH3_P)	;
			self.c_HH4_P	:=	if(ri.HH4_P = '', NULL, (real)ri.HH4_P)	;
			self.c_HH5_P	:=	if(ri.HH5_P = '', NULL, (real)ri.HH5_P)	;
			self.c_HH6_P	:=	if(ri.HH6_P = '', NULL, (real)ri.HH6_P)	;
			self.c_HH7P_P	:=	if(ri.HH7P_P = '', NULL, (real)ri.HH7P_P)	;
			self.c_VACANT_P	:=	if(ri.VACANT_P = '', NULL, (real)ri.VACANT_P)	;
			self.c_OCCUNIT_P	:=	if(ri.OCCUNIT_P = '', NULL, (real)ri.OCCUNIT_P)	;
			self.c_OWNOCC_P	:=	if(ri.OWNOCP = '', NULL, (real)ri.OWNOCP)	;
			self.c_RENTOCC_P	:=	if(ri.RENTOCP = '', NULL, (real)ri.RENTOCP)	;
			self.c_SFDU_P	:=	if(ri.SFDU_P = '', NULL, (real)ri.SFDU_P)	;
			self.c_BIGAPT_P	:=	if(ri.BIGAPT_P = '', NULL, (real)ri.BIGAPT_P)	;
			self.c_TRAILER_P	:=	if(ri.TRAILER_P = '', NULL, (real)ri.TRAILER_P)	;
			self.c_RNT250_P	:=	if(ri.RNT250_P = '', NULL, (real)ri.RNT250_P)	;
			self.c_RNT500_P	:=	if(ri.RNT500_P = '', NULL, (real)ri.RNT500_P)	;
			self.c_RNT750_P	:=	if(ri.RNT750_P = '', NULL, (real)ri.RNT750_P)	;
			self.c_RNT1000_P	:=	if(ri.RNT1000_P = '', NULL, (real)ri.RNT1000_P)	;
			self.c_RNT1250_P	:=	if(ri.RNT1250_P = '', NULL, (real)ri.RNT1250_P)	;
			self.c_RNT1500_P	:=	if(ri.RNT1500_P = '', NULL, (real)ri.RNT1500_P)	;
			self.c_RNT2000_P	:=	if(ri.RNT2000_P = '', NULL, (real)ri.RNT2000_P)	;
			self.c_RNT2001_P	:=	if(ri.RNT2001_P = '', NULL, (real)ri.RNT2001_P)	;
			self.c_HIGHRENT	:=	if(ri.HIGHRENT = '', NULL, (real)ri.HIGHRENT)	;
			self.c_LOWRENT	:=	if(ri.LOWRENT = '', NULL, (real)ri.LOWRENT)	;
			self.c_HVAL_20K_P	:=	if(ri.HVAL_20K_P = '', NULL, (real)ri.HVAL_20K_P)	;
			self.c_HVAL_40K_P	:=	if(ri.HVAL_40K_P = '', NULL, (real)ri.HVAL_40K_P)	;
			self.c_HVAL_60K_P	:=	if(ri.HVAL_60K_P = '', NULL, (real)ri.HVAL_60K_P)	;
			self.c_HVAL_80K_P	:=	if(ri.HVAL_80K_P = '', NULL, (real)ri.HVAL_80K_P)	;
			self.c_HVAL_100K_P	:=	if(ri.HVAL_100K_P = '', NULL, (real)ri.HVAL_100K_P)	;
			self.c_HVAL_125K_P	:=	if(ri.HVAL_125K_P = '', NULL, (real)ri.HVAL_125K_P)	;
			self.c_HVAL_150K_P	:=	if(ri.HVAL_150K_P = '', NULL, (real)ri.HVAL_150K_P)	;
			self.c_HVAL_175K_P	:=	if(ri.HVAL_175K_P = '', NULL, (real)ri.HVAL_175K_P)	;
			self.c_HVAL_200K_P	:=	if(ri.HVAL_200K_P = '', NULL, (real)ri.HVAL_200K_P)	;
			self.c_HVAL_250K_P	:=	if(ri.HVAL_250K_P = '', NULL, (real)ri.HVAL_250K_P)	;
			self.c_HVAL_300K_P	:=	if(ri.HVAL_300K_P = '', NULL, (real)ri.HVAL_300K_P)	;
			self.c_HVAL_400K_P	:=	if(ri.HVAL_400K_P = '', NULL, (real)ri.HVAL_400K_P)	;
			self.c_HVAL_500K_P	:=	if(ri.HVAL_500K_P = '', NULL, (real)ri.HVAL_500K_P)	;
			self.c_HVAL_750K_P	:=	if(ri.HVAL_750K_P = '', NULL, (real)ri.HVAL_750K_P)	;
			self.c_HVAL_1000K_P	:=	if(ri.HVAL_1000K_P = '', NULL, (real)ri.HVAL_1000K_P)	;
			self.c_HVAL_1001K_P	:=	if(ri.HVAL_1001K_P = '', NULL, (real)ri.HVAL_1001K_P)	;
			self.c_LOW_HVAL	:=	if(ri.LOW_HVAL = '', NULL, (real)ri.LOW_HVAL)	;
			self.c_HIGH_HVAL	:=	if(ri.HIGH_HVAL = '', NULL, (real)ri.HIGH_HVAL)	;
			self.c_NEWHOUSE	:=	if(ri.NEWHOUSE = '', NULL, (real)ri.NEWHOUSE)	;
			self.c_OLDHOUSE	:=	if(ri.OLDHOUSE = '', NULL, (real)ri.OLDHOUSE)	;
			self.C_INC_15K_P	:=	if(ri.IN15K_P = '', NULL, (real)ri.IN15K_P)	;
			self.C_INC_25K_P	:=	if(ri.IN25K_P = '', NULL, (real)ri.IN25K_P)	;
			self.C_INC_35K_P	:=	if(ri.IN50K_P = '', NULL, (real)ri.IN35K_P)	;
			self.C_INC_50K_P	:=	if(ri.IN50K_P = '', NULL, (real)ri.IN50K_P)	;
			self.C_INC_75K_P	:=	if(ri.IN75K_P = '', NULL, (real)ri.IN75K_P)	;
			self.C_INC_100K_P	:=	if(ri.IN100K_P = '', NULL, (real)ri.IN100K_P)	;
			self.C_INC_125K_P	:=	if(ri.IN125K_P = '', NULL, (real)ri.IN125K_P)	;
			self.C_INC_150K_P	:=	if(ri.IN150K_P = '', NULL, (real)ri.IN150K_P)	;
			self.C_INC_200K_P	:=	if(ri.IN200K_P = '', NULL, (real)ri.IN200K_P)	;
			self.C_INC_201K_P	:=	if(ri.IN201K_P = '', NULL, (real)ri.IN201K_P)	;
			self.c_LOWINC	:=	if(ri.LOWINC = '', NULL, (real)ri.LOWINC)	;
			self.c_HIGHINC	:=	if(ri.HIGHINC = '', NULL, (real)ri.HIGHINC)	;
			self.c_POPOVER25	:=	if(ri.POPOVER25 = '', NULL, (real)ri.POPOVER25)	;
			self.c_POPOVER18	:=	if(ri.POPOVER18 = '', NULL, (real)ri.POPOVER18)	;
			self.c_LOW_ED	:=	if(ri.LOW_ED = '', NULL, (real)ri.LOW_ED)	;
			self.c_HIGH_ED	:=	if(ri.HIGH_ED = '', NULL, (real)ri.HIGH_ED)	;
			self.c_INCOLLEGE	:=	if(ri.INCOLLEGE = '', NULL, (real)ri.INCOLLEGE)	;
			self.c_UNEMP	:=	if(ri.UNEMP = '', NULL, (real)ri.UNEMP)	;
			self.c_CIV_EMP	:=	if(ri.CIV_EMP = '', NULL, (real)ri.CIV_EMP)	;
			self.c_MIL_EMP	:=	if(ri.MIL_EMP = '', NULL, (real)ri.MIL_EMP)	;
			self.c_WHITE_COL	:=	if(ri.WHITE_COL = '', NULL, (real)ri.WHITE_COL)	;
			self.c_BLUE_COL	:=	if(ri.BLUE_COL = '', NULL, (real)ri.BLUE_COL)	;
			self.c_MURDERS	:=	if(ri.MURDERS = '', NULL, (real)ri.MURDERS)	;
			self.c_RAPE	:=	if(ri.RAPE = '', NULL, (real)ri.RAPE)	;
			self.c_ROBBERY	:=	if(ri.ROBBERY = '', NULL, (real)ri.ROBBERY)	;
			self.c_ASSAULT	:=	if(ri.ASSAULT = '', NULL, (real)ri.ASSAULT)	;
			self.c_BURGLARY	:=	if(ri.BURGLARY = '', NULL, (real)ri.BURGLARY)	;
			self.c_LARCENY	:=	if(ri.LARCENY = '', NULL, (real)ri.LARCENY)	;
			self.c_CARTHEFT	:=	if(ri.CARTHEFT = '', NULL, (real)ri.CARTHEFT)	;
			self.c_TOTCRIME	:=	if(ri.TOTCRIME = '', NULL, (real)ri.TOTCRIME)	;
			self.c_EASIQLIFE	:=	if(ri.EASIQLIFE = '', NULL, (real)111.48985712826);
			self.c_CPIALL	:=	if(ri.CPIALL = '', NULL, (real)ri.CPIALL)	;
			self.c_HOUSINGCPI	:=	if(ri.HOUSINGCPI = '', NULL, (real)ri.HOUSINGCPI)	;
			self.c_DOMIN_PROF	:=	if(ri.DOMIN_PROF = '', NULL, (real)ri.DOMIN_PROF)	;
			self.c_BUSINESS	:=	if(ri.BUSINESS = '', NULL, (real)ri.BUSINESS)	;
			self.c_EMPLOYEES	:=	if(ri.EMPLOYEES = '', NULL, (real)ri.EMPLOYEES)	;
			self.c_AGRICULTURE	:=	if(ri.AGRICULTURE = '', NULL, (real)ri.AGRICULTURE)	;
			self.c_MINING	:=	if(ri.MINING = '', NULL, (real)ri.MINING)	;
			self.c_CONSTRUCTION	:=	if(ri.CONSTRUCTION = '', NULL, (real)ri.CONSTRUCTION)	;
			self.c_MANUFACTURING	:=	if(ri.MANUFACTURING = '', NULL, (real)ri.MANUFACTURING)	;
			self.c_WHOLESALE	:=	if(ri.WHOLESALE = '', NULL, (real)ri.WHOLESALE)	;
			self.c_RETAIL	:=	if(ri.RETAIL = '', NULL, (real)ri.RETAIL)	;
			self.c_TRANSPORT	:=	if(ri.TRANSPORT = '', NULL, (real)ri.TRANSPORT)	;
			self.c_INFO	:=	if(ri.INFO = '', NULL, (real)ri.INFO)	;
			self.c_FINANCE	:=	if(ri.FINANCE = '', NULL, (real)ri.FINANCE)	;
			self.c_PROFESSIONAL	:=	if(ri.PROFESSIONAL = '', NULL, (real)ri.PROFESSIONAL)	;
			self.c_HEALTH	:=	if(ri.HEALTH = '', NULL, (real)ri.HEALTH)	;
			self.c_FOOD	:=	if(ri.FOOD = '', NULL, (real)ri.FOOD)	;
			self.c_CULT_INDX	:=	if(ri.CULT_INDX = '', NULL, (real)ri.CULT_INDX)	;
			self.c_AMUS_INDX	:=	if(ri.AMUS_INDX = '', NULL, (real)ri.AMUS_INDX)	;
			self.c_REST_INDX	:=	if(ri.REST_INDX = '', NULL, (real)ri.REST_INDX)	;
			self.c_MEDI_INDX	:=	if(ri.MEDI_INDX = '', NULL, (real)ri.MEDI_INDX)	;
			self.c_RELIG_INDX	:=	if(ri.RELIG_INDX = '', NULL, (real)105.712938197103);
			self.c_EDU_INDX	:=	if(ri.EDU_INDX = '', NULL, (real)ri.EDU_INDX)	;
			self.c_BARGAINS	:=	if(ri.BARGAINS = '', NULL, (real)ri.BARGAINS)	;
			self.c_EXP_PROD	:=	if(ri.EXP_PROD = '', NULL, (real)ri.EXP_PROD)	;
			self.c_LUX_PROD	:=	if(ri.LUX_PROD = '', NULL, (real)ri.LUX_PROD)	;
			self.c_MORT_INDX	:=	if(ri.MORT_INDX = '', NULL, (real)ri.MORT_INDX)	;
			self.c_AB_AV_EDU	:=	if(ri.AB_AV_EDU = '', NULL, (real)ri.AB_AV_EDU)	;
			self.c_APT20	:=	if(ri.APT20 = '', NULL, (real)ri.APT20)	;
			self.c_RENTAL	:=	if(ri.RENTAL = '', NULL, (real)ri.RENTAL)	;
			self.c_PRESCHL	:=	if(ri.PRESCHL = '', NULL, (real)ri.PRESCHL)	;
			self.c_BEL_EDU	:=	if(ri.BEL_EDU = '', NULL, (real)ri.BEL_EDU)	;
			self.c_BLUE_EMPL	:=	if(ri.BLUE_EMPL = '', NULL, (real)ri.BLUE_EMPL)	;
			self.c_BORN_USA	:=	if(ri.BORN_USA = '', NULL, (real)87.0113840587115);
			self.c_EXP_HOMES	:=	if(ri.EXP_HOMES = '', NULL, (real)ri.EXP_HOMES)	;
			self.c_NO_TEENS	:=	if(ri.NO_TEENS = '', NULL, (real)ri.NO_TEENS)	;
			self.c_FOR_SALE	:=	if(ri.FOR_SALE = '', NULL, (real)ri.FOR_SALE)	;
			self.c_ARMFORCE	:=	if(ri.ARMFORCE = '', NULL, (real)ri.ARMFORCE)	;
			self.c_LAR_FAM	:=	if(ri.LAR_FAM = '', NULL, (real)ri.LAR_FAM)	;
			self.c_NO_MOVE	:=	if(ri.NO_MOVE = '', NULL, (real)ri.NO_MOVE)	;
			self.c_MANY_CARS	:=	if(ri.MANY_CARS = '', NULL, (real)ri.MANY_CARS)	;
			self.c_MED_INC	:=	if(ri.MED_INC = '', NULL, (real)ri.MED_INC)	;
			self.c_NO_CAR	:=	if(ri.NO_CAR = '', NULL, (real)ri.NO_CAR)	;
			self.c_NO_LABFOR	:=	if(ri.NO_LABFOR = '', NULL, (real)ri.NO_LABFOR)	;
			self.c_RICH_OLD	:=	if(ri.RICH_OLD = '', NULL, (real)ri.RICH_OLD)	;
			self.c_OLD_HOMES	:=	if(ri.OLD_HOMES = '', NULL, (real)ri.OLD_HOMES)	;
			self.c_NEW_HOMES	:=	if(ri.NEW_HOMES = '', NULL, (real)ri.NEW_HOMES)	;
			self.c_RECENT_MOV	:=	if(ri.RECENT_MOV = '', NULL, (real)ri.RECENT_MOV)	;
			self.c_RETIRED2	:=	if(ri.RETIRED2 = '', NULL, (real)ri.RETIRED2)	;
			self.c_SERV_EMPL	:=	if(ri.SERV_EMPL = '', NULL, (real)ri.SERV_EMPL)	;
			self.c_SUB_BUS	:=	if(ri.SUB_BUS = '', NULL, (real)ri.SUB_BUS)	;
			self.c_TRAILER	:=	if(ri.TRAILER = '', NULL, (real)ri.TRAILER)	;
			self.c_UNATTACH	:=	if(ri.UNATTACH = '', NULL, (real)98.0527729860013);
			self.c_UNEMPL	:=	if(ri.UNEMPL = '', NULL, (real)ri.UNEMPL)	;
			self.c_ASIAN_LANG	:=	if(ri.ASIAN_LANG = '', NULL, (real)117.33803561876);
			self.c_RICH_ASIAN	:=	if(ri.RICH_ASIAN = '', NULL, (real)112.713374966691);
			self.c_RICH_BLK	:=	if(ri.RICH_BLK = '', NULL, (real)108.946649997295);
			self.c_RICH_FAM	:=	if(ri.RICH_FAM = '', NULL, (real)ri.RICH_FAM)	;
			self.c_RICH_HISP	:=	if(ri.RICH_HISP = '', NULL, (real)110.862655999872);
			self.c_VERY_RICH	:=	if(ri.VERY_RICH = '', NULL, (real)ri.VERY_RICH)	;
			self.c_RICH_NFAM	:=	if(ri.RICH_NFAM = '', NULL, (real)112.611775949223);
			self.c_RICH_WHT	:=	if(ri.RICH_WHT = '', NULL, (real)110.494763773769);
			self.c_SPAN_LANG	:=	if(ri.SPAN_LANG = '', NULL, (real)107.305718676308);
			self.c_WORK_HOME	:=	if(ri.WORK_HOME = '', NULL, (real)ri.WORK_HOME)	;
			self.c_RICH_YOUNG	:=	if(ri.RICH_YOUNG = '', NULL, (real)ri.RICH_YOUNG)	;
			self.c_TOTSALES	:=	if(ri.POP00 = '', NULL, (real)ri.TOTSALES)	;

			self := [];
			// self.seqa := le.seq;
  END;

	topLevelVars := join(clam, Easi.Key_Easi_Census,
		(left.bs.shell_input.st<>'' and left.bs.shell_input.county <>''	and left.bs.shell_input.geo_blk <> '' and 
		 left.bs.addrpop and 
		 keyed(right.geolink=left.bs.shell_input.st+left.bs.shell_input.county+left.bs.shell_input.geo_blk)) or
		(left.bs.addrpop2 and ~left.bs.addrpop and
		 left.bs.Address_Verification.Address_History_1.st<>'' and left.bs.Address_Verification.Address_History_1.county <>''	and left.bs.Address_Verification.Address_History_1.geo_blk <> '' and 
		 keyed(right.geolink=left.bs.Address_Verification.Address_History_1.st+left.bs.Address_Verification.Address_History_1.county+left.bs.Address_Verification.Address_History_1.geo_blk)), 
		doTopLevel(left, right), left outer,
		atmost(RiskWise.max_atmost)
		,keep(1)
	);

	emptyModel := project(topLevelVars,  
												transform(Models.Layout_FP31505,
																	self.seqa 					:= left.seqa,
																	self.pii_profile_n 	:= Risk_Indicators.iid_constants.error_con,
																	self 							:= []));
																	
	Models.Layout_FP31505 projModel(topLevelVars le) := TRANSFORM
		// subModel 		:= Models.FP31505_FLAPSD(dataset(row(le, Models.Layout_FP31505)));
		// emptyModel	:= row([], Models.Layout_FP31505);	//if insufficient input, return -999 in the score and blank indexes
		subModel := map(le.pii_profile_n	= '|FLAPSD|'			=>	Models.FP31505_FLAPSD(dataset(row(le, Models.Layout_FP31505))),
										le.pii_profile_n	= '|FLAPS |'			=>	Models.FP31505_FLAPS(dataset(row(le, Models.Layout_FP31505))),
										le.pii_profile_n	= '|FLAP D|'			=>	Models.FP31505_FLAPD(dataset(row(le, Models.Layout_FP31505))),
										le.pii_profile_n	= '|FLA SD|'			=>	Models.FP31505_FLASD(dataset(row(le, Models.Layout_FP31505))),
										le.pii_profile_n	= '|FL PSD|'			=>	Models.FP31505_FLPSD(dataset(row(le, Models.Layout_FP31505))),
										le.pii_profile_n	= '|FLAP  |'			=>	Models.FP31505_FLAP(dataset(row(le, Models.Layout_FP31505))),
										le.pii_profile_n	= '|FL PS |'			=>	Models.FP31505_FLPS(dataset(row(le, Models.Layout_FP31505))),
										le.pii_profile_n	= '|FLA S |'			=>	Models.FP31505_FLAS(dataset(row(le, Models.Layout_FP31505))),
										le.pii_profile_n	= '|FL  SD|'			=>	Models.FP31505_FLSD(dataset(row(le, Models.Layout_FP31505))),
										le.pii_profile_n	= '|FLA  D|'			=>	Models.FP31505_FLAD(dataset(row(le, Models.Layout_FP31505))),
										le.pii_profile_n	= '|FL  S |'			=>	Models.FP31505_FLS(dataset(row(le, Models.Layout_FP31505))),
										le.pii_profile_n	= '|FLA   |'			=>	Models.FP31505_FLA(dataset(row(le, Models.Layout_FP31505))),
																														emptyModel); 
		self.pii_profile_n		:= subModel[1].pii_profile_n;  //if insufficient input, this will pick up the 'ERROR' value
		self.final_score_0		:= subModel[1].final_score_0;
		self.final_score_1		:= subModel[1].final_score_1;
		self.final_score_2		:= subModel[1].final_score_2;
		self.final_score_3		:= subModel[1].final_score_3;
		self.final_score_4		:= subModel[1].final_score_4;
		self.final_score_5		:= subModel[1].final_score_5;
		self.final_score_6		:= subModel[1].final_score_6;
		self.final_score_7		:= subModel[1].final_score_7;
		self.final_score_8		:= subModel[1].final_score_8;
		self.final_score_9		:= subModel[1].final_score_9;
		self.final_score_10		:= subModel[1].final_score_10;
		self.final_score_11		:= subModel[1].final_score_11;
		self.final_score_12		:= subModel[1].final_score_12;
		self.final_score_13		:= subModel[1].final_score_13;
		self.final_score_14		:= subModel[1].final_score_14;
		self.final_score_15		:= subModel[1].final_score_15;
		self.final_score_16		:= subModel[1].final_score_16;
		self.final_score_17		:= subModel[1].final_score_17;
		self.final_score_18		:= subModel[1].final_score_18;
		self.final_score_19		:= subModel[1].final_score_19;
		self.final_score_20		:= subModel[1].final_score_20;
		self.final_score_21		:= subModel[1].final_score_21;
		self.final_score_22		:= subModel[1].final_score_22;
		self.final_score_23		:= subModel[1].final_score_23;
		self.final_score_24		:= subModel[1].final_score_24;
		self.final_score_25		:= subModel[1].final_score_25;
		self.final_score_26		:= subModel[1].final_score_26;
		self.final_score_27		:= subModel[1].final_score_27;
		self.final_score_28		:= subModel[1].final_score_28;
		self.final_score_29		:= subModel[1].final_score_29;
		self.final_score_30		:= subModel[1].final_score_30;	
		self.final_score_31		:= subModel[1].final_score_31;
		self.final_score_32		:= subModel[1].final_score_32;
		self.final_score_33		:= subModel[1].final_score_33;
		self.final_score_34		:= subModel[1].final_score_34;
		self.final_score_35		:= subModel[1].final_score_35;
		self.final_score_36		:= subModel[1].final_score_36;
		self.final_score_37		:= subModel[1].final_score_37;
		self.final_score_38		:= subModel[1].final_score_38;
		self.final_score_39		:= subModel[1].final_score_39;
		self.final_score_40		:= subModel[1].final_score_40;		
		self.final_score_41		:= subModel[1].final_score_41;
		self.final_score_42		:= subModel[1].final_score_42;
		self.final_score_43		:= subModel[1].final_score_43;
		self.final_score_44		:= subModel[1].final_score_44;
		self.final_score_45		:= subModel[1].final_score_45;
		self.final_score_46		:= subModel[1].final_score_46;
		self.final_score_47		:= subModel[1].final_score_47;
		self.final_score_48		:= subModel[1].final_score_48;
		self.final_score_49		:= subModel[1].final_score_49;
		self.final_score_50		:= subModel[1].final_score_50;		
		self.final_score_51		:= subModel[1].final_score_51;
		self.final_score_52		:= subModel[1].final_score_52;
		self.final_score_53		:= subModel[1].final_score_53;
		self.final_score_54		:= subModel[1].final_score_54;
		self.final_score_55		:= subModel[1].final_score_55;
		self.final_score_56		:= subModel[1].final_score_56;
		self.final_score_57		:= subModel[1].final_score_57;
		self.final_score_58		:= subModel[1].final_score_58;
		self.final_score_59		:= subModel[1].final_score_59;
		self.final_score_60		:= subModel[1].final_score_60;		
		self.final_score_61		:= subModel[1].final_score_61;
		self.final_score_62		:= subModel[1].final_score_62;
		self.final_score_63		:= subModel[1].final_score_63;
		self.final_score_64		:= subModel[1].final_score_64;
		self.final_score_65		:= subModel[1].final_score_65;
		self.final_score_66		:= subModel[1].final_score_66;
		self.final_score_67		:= subModel[1].final_score_67;
		self.final_score_68		:= subModel[1].final_score_68;
		self.final_score_69		:= subModel[1].final_score_69;
		self.final_score_70		:= subModel[1].final_score_70;		
		self.final_score_71		:= subModel[1].final_score_71;
		self.final_score_72		:= subModel[1].final_score_72;
		self.final_score_73		:= subModel[1].final_score_73;
		self.final_score_74		:= subModel[1].final_score_74;
		self.final_score_75		:= subModel[1].final_score_75;
		self.final_score_76		:= subModel[1].final_score_76;
		self.final_score_77		:= subModel[1].final_score_77;
		self.final_score_78		:= subModel[1].final_score_78;
		self.final_score_79		:= subModel[1].final_score_79;
		self.final_score_80		:= subModel[1].final_score_80;		
		self.final_score_81		:= subModel[1].final_score_81;
		self.final_score_82		:= subModel[1].final_score_82;
		self.final_score_83		:= subModel[1].final_score_83;
		self.final_score_84		:= subModel[1].final_score_84;
		self.final_score_85		:= subModel[1].final_score_85;
		self.final_score_86		:= subModel[1].final_score_86;
		self.final_score_87		:= subModel[1].final_score_87;
		self.final_score_88		:= subModel[1].final_score_88;
		self.final_score_89		:= subModel[1].final_score_89;
		self.final_score_90		:= subModel[1].final_score_90;		
		self.final_score_91		:= subModel[1].final_score_91;
		self.final_score_92		:= subModel[1].final_score_92;
		self.final_score_93		:= subModel[1].final_score_93;
		self.final_score_94		:= subModel[1].final_score_94;
		self.final_score_95		:= subModel[1].final_score_95;
		self.final_score_96		:= subModel[1].final_score_96;
		self.final_score_97		:= subModel[1].final_score_97;
		self.final_score_98		:= subModel[1].final_score_98;
		self.final_score_99		:= subModel[1].final_score_99;
		self.final_score_100	:= subModel[1].final_score_100;		
		self.final_score_101	:= subModel[1].final_score_101;
		self.final_score_102	:= subModel[1].final_score_102;
		self.final_score_103	:= subModel[1].final_score_103;
		self.final_score_104	:= subModel[1].final_score_104;
		self.final_score_105	:= subModel[1].final_score_105;
		self.final_score_106	:= subModel[1].final_score_106;
		self.final_score_107	:= subModel[1].final_score_107;
		self.final_score_108	:= subModel[1].final_score_108;
		self.final_score_109	:= subModel[1].final_score_109;
		self.final_score_110	:= subModel[1].final_score_110;
		self.final_score_111	:= subModel[1].final_score_111;
		self.final_score_112	:= subModel[1].final_score_112;
		self.final_score_113	:= subModel[1].final_score_113;
		self.final_score_114	:= subModel[1].final_score_114;
		self.final_score_115	:= subModel[1].final_score_115;
		self.final_score_116	:= subModel[1].final_score_116;
		self.final_score_117	:= subModel[1].final_score_117;
		self.final_score_118	:= subModel[1].final_score_118;
		self.final_score_119	:= subModel[1].final_score_119;
		self.final_score_120	:= subModel[1].final_score_120;
		self.final_score_121	:= subModel[1].final_score_121;
		self.final_score_122	:= subModel[1].final_score_122;
		self.final_score_123	:= subModel[1].final_score_123;
		self.final_score_124	:= subModel[1].final_score_124;
		self.final_score_125	:= subModel[1].final_score_125;
		self.final_score_126	:= subModel[1].final_score_126;
		self.final_score_127	:= subModel[1].final_score_127;
		self.final_score_128	:= subModel[1].final_score_128;
		self.final_score_129	:= subModel[1].final_score_129;
		self.final_score_130	:= subModel[1].final_score_130;	
		self.final_score_131	:= subModel[1].final_score_131;
		self.final_score_132	:= subModel[1].final_score_132;
		self.final_score_133	:= subModel[1].final_score_133;
		self.final_score_134	:= subModel[1].final_score_134;
		self.final_score_135	:= subModel[1].final_score_135;
		self.final_score_136	:= subModel[1].final_score_136;
		self.final_score_137	:= subModel[1].final_score_137;
		self.final_score_138	:= subModel[1].final_score_138;
		self.final_score_139	:= subModel[1].final_score_139;
		self.final_score_140	:= subModel[1].final_score_140;		
		self.final_score_141	:= subModel[1].final_score_141;
		self.final_score_142	:= subModel[1].final_score_142;
		self.final_score_143	:= subModel[1].final_score_143;
		self.final_score_144	:= subModel[1].final_score_144;
		self.final_score_145	:= subModel[1].final_score_145;
		self.final_score_146	:= subModel[1].final_score_146;
		self.final_score_147	:= subModel[1].final_score_147;
		self.final_score_148	:= subModel[1].final_score_148;
		self.final_score_149	:= subModel[1].final_score_149;
		self.final_score_150	:= subModel[1].final_score_150;		
		self.final_score_151	:= subModel[1].final_score_151;
		self.final_score_152	:= subModel[1].final_score_152;
		self.final_score_153	:= subModel[1].final_score_153;
		self.final_score_154	:= subModel[1].final_score_154;
		self.final_score_155	:= subModel[1].final_score_155;
		self.final_score_156	:= subModel[1].final_score_156;
		self.final_score_157	:= subModel[1].final_score_157;
		self.final_score_158	:= subModel[1].final_score_158;
		self.final_score_159	:= subModel[1].final_score_159;
		self.final_score_160	:= subModel[1].final_score_160;		
		self.final_score_161	:= subModel[1].final_score_161;
		self.final_score_162	:= subModel[1].final_score_162;
		self.final_score_163	:= subModel[1].final_score_163;
		self.final_score_164	:= subModel[1].final_score_164;
		self.final_score_165	:= subModel[1].final_score_165;
		self.final_score_166	:= subModel[1].final_score_166;
		self.final_score_167	:= subModel[1].final_score_167;
		self.final_score_168	:= subModel[1].final_score_168;
		self.final_score_169	:= subModel[1].final_score_169;
		self.final_score_170	:= subModel[1].final_score_170;		
		self.final_score_171	:= subModel[1].final_score_171;
		self.final_score_172	:= subModel[1].final_score_172;
		self.final_score_173	:= subModel[1].final_score_173;
		self.final_score_174	:= subModel[1].final_score_174;
		self.final_score_175	:= subModel[1].final_score_175;
		self.final_score_176	:= subModel[1].final_score_176;
		self.final_score_177	:= subModel[1].final_score_177;
		self.final_score_178	:= subModel[1].final_score_178;
		self.final_score_179	:= subModel[1].final_score_179;
		self.final_score_180	:= subModel[1].final_score_180;		
		self.final_score_181	:= subModel[1].final_score_181;
		self.final_score_182	:= subModel[1].final_score_182;
		self.final_score_183	:= subModel[1].final_score_183;
		self.final_score_184	:= subModel[1].final_score_184;
		self.final_score_185	:= subModel[1].final_score_185;
		self.final_score_186	:= subModel[1].final_score_186;
		self.final_score_187	:= subModel[1].final_score_187;
		self.final_score_188	:= subModel[1].final_score_188;
		self.final_score_189	:= subModel[1].final_score_189;
		self.final_score_190	:= subModel[1].final_score_190;		
		self.final_score_191	:= subModel[1].final_score_191;
		self.final_score_192	:= subModel[1].final_score_192;
		self.final_score_193	:= subModel[1].final_score_193;
		self.final_score_194	:= subModel[1].final_score_194;
		self.final_score_195	:= subModel[1].final_score_195;
		self.final_score_196	:= subModel[1].final_score_196;
		self.final_score_197	:= subModel[1].final_score_197;
		self.final_score_198	:= subModel[1].final_score_198;
		self.final_score_199	:= subModel[1].final_score_199;
		self.final_score_200	:= subModel[1].final_score_200;
		self.final_score_201	:= subModel[1].final_score_201;
		self.final_score_202	:= subModel[1].final_score_202;
		self.final_score_203	:= subModel[1].final_score_203;
		self.final_score_204	:= subModel[1].final_score_204;
		self.final_score_205	:= subModel[1].final_score_205;
		self.final_score_206	:= subModel[1].final_score_206;
		self.final_score_207	:= subModel[1].final_score_207;
		self.final_score_208	:= subModel[1].final_score_208;
		self.final_score_209	:= subModel[1].final_score_209;
		self.final_score_210	:= subModel[1].final_score_210;
		self.final_score_211	:= subModel[1].final_score_211;
		self.final_score_212	:= subModel[1].final_score_212;
		self.final_score_213	:= subModel[1].final_score_213;
		self.final_score_214	:= subModel[1].final_score_214;
		self.final_score_215	:= subModel[1].final_score_215;
		self.final_score_216	:= subModel[1].final_score_216;
		self.final_score_217	:= subModel[1].final_score_217;
		self.final_score_218	:= subModel[1].final_score_218;
		self.final_score_219	:= subModel[1].final_score_219;
		self.final_score_220	:= subModel[1].final_score_220;
		self.final_score_221	:= subModel[1].final_score_221;
		self.final_score_222	:= subModel[1].final_score_222;
		self.final_score_223	:= subModel[1].final_score_223;
		self.final_score_224	:= subModel[1].final_score_224;
		self.final_score_225	:= subModel[1].final_score_225;
		self.final_score_226	:= subModel[1].final_score_226;	
		self.final_score_227	:= subModel[1].final_score_227;
		self.final_score_228	:= subModel[1].final_score_228;
		self.final_score_229	:= subModel[1].final_score_229;
		self.final_score_230	:= subModel[1].final_score_230;	
		self.final_score_231	:= subModel[1].final_score_231;
		self.final_score_232	:= subModel[1].final_score_232;
		self.final_score_233	:= subModel[1].final_score_233;
		self.final_score_234	:= subModel[1].final_score_234;
		self.final_score_235	:= subModel[1].final_score_235;
		self.final_score_236	:= subModel[1].final_score_236;
		self.final_score_237	:= subModel[1].final_score_237;
		self.final_score_238	:= subModel[1].final_score_238;
		self.final_score_239	:= subModel[1].final_score_239;
		self.final_score_240	:= subModel[1].final_score_240;		
		self.final_score_241	:= subModel[1].final_score_241;
		self.final_score_242	:= subModel[1].final_score_242;
		self.final_score_243	:= subModel[1].final_score_243;
		self.final_score_244	:= subModel[1].final_score_244;
		self.final_score_245	:= subModel[1].final_score_245;
		self.final_score_246	:= subModel[1].final_score_246;
		self.final_score_247	:= subModel[1].final_score_247;
		self.final_score_248	:= subModel[1].final_score_248;
		self.final_score_249	:= subModel[1].final_score_249;
		self.final_score_250	:= subModel[1].final_score_250;		
		self.final_score_251	:= subModel[1].final_score_251;
		self.final_score_252	:= subModel[1].final_score_252;
		self.final_score_253	:= subModel[1].final_score_253;
		self.final_score_254	:= subModel[1].final_score_254;
		self.final_score_255	:= subModel[1].final_score_255;
		self.final_score_256	:= subModel[1].final_score_256;
		self.final_score_257	:= subModel[1].final_score_257;
		self.final_score_258	:= subModel[1].final_score_258;
		self.final_score_259	:= subModel[1].final_score_259;
		self.final_score_260	:= subModel[1].final_score_260;		
		self.final_score_261	:= subModel[1].final_score_261;
		self.final_score_262	:= subModel[1].final_score_262;
		self.final_score_263	:= subModel[1].final_score_263;
		self.final_score_264	:= subModel[1].final_score_264;
		self.final_score_265	:= subModel[1].final_score_265;
		self.final_score_266	:= subModel[1].final_score_266;
		self.final_score_267	:= subModel[1].final_score_267;	
		self.final_score_268	:= subModel[1].final_score_268;
		self.final_score_269	:= subModel[1].final_score_269;
		self.final_score_270	:= subModel[1].final_score_270;		
		self.final_score_271	:= subModel[1].final_score_271;
		self.final_score_272	:= subModel[1].final_score_272;
		self.final_score_273	:= subModel[1].final_score_273;
		self.final_score_274	:= subModel[1].final_score_274;
		self.final_score_275	:= subModel[1].final_score_275;
		self.final_score_276	:= subModel[1].final_score_276;
		self.final_score_277	:= subModel[1].final_score_277;
		self.final_score_278	:= subModel[1].final_score_278;
		self.final_score_279	:= subModel[1].final_score_279;
		self.final_score_280	:= subModel[1].final_score_280;		
		self.final_score_281	:= subModel[1].final_score_281;
		self.final_score_282	:= subModel[1].final_score_282;
		self.final_score_283	:= subModel[1].final_score_283;
		self.final_score_284	:= subModel[1].final_score_284;
		self.final_score_285	:= subModel[1].final_score_285;
		self.final_score_286	:= subModel[1].final_score_286;
		self.final_score_287	:= subModel[1].final_score_287;
		self.final_score_288	:= subModel[1].final_score_288;
		self.final_score_289	:= subModel[1].final_score_289;
		self.final_score_290	:= subModel[1].final_score_290;		
		self.final_score_291	:= subModel[1].final_score_291;
		self.final_score_292	:= subModel[1].final_score_292;
		self.final_score_293	:= subModel[1].final_score_293;
		self.final_score_294	:= subModel[1].final_score_294;
		self.final_score_295	:= subModel[1].final_score_295;
		self.final_score_296	:= subModel[1].final_score_296;
		self.final_score_297	:= subModel[1].final_score_297;
		self.final_score_298	:= subModel[1].final_score_298;
		self.final_score_299	:= subModel[1].final_score_299;
		self.final_score_300	:= subModel[1].final_score_300;
		self.final_score_301	:= subModel[1].final_score_301;
		self.final_score_302	:= subModel[1].final_score_302;
		self.final_score_303	:= subModel[1].final_score_303;
		self.final_score_304	:= subModel[1].final_score_304;
		self.final_score_305	:= subModel[1].final_score_305;
		self.final_score_306	:= subModel[1].final_score_306;
		self.final_score_307	:= subModel[1].final_score_307;
		self.final_score_308	:= subModel[1].final_score_308;
		self.final_score_309	:= subModel[1].final_score_309;
		self.final_score_310	:= subModel[1].final_score_310;
		self.final_score_311	:= subModel[1].final_score_311;
		self.final_score_312	:= subModel[1].final_score_312;
		self.final_score_313	:= subModel[1].final_score_313;
		self.final_score_314	:= subModel[1].final_score_314;
		self.final_score_315	:= subModel[1].final_score_315;
		self.final_score_316	:= subModel[1].final_score_316;
		self.final_score_317	:= subModel[1].final_score_317;
		self.final_score_318	:= subModel[1].final_score_318;
		self.final_score_319	:= subModel[1].final_score_319;
		self.final_score_320	:= subModel[1].final_score_320;
		self.final_score_321	:= subModel[1].final_score_321;
		self.final_score_322	:= subModel[1].final_score_322;
		self.final_score_323	:= subModel[1].final_score_323;
		self.final_score_324	:= subModel[1].final_score_324;
		self.final_score_325	:= subModel[1].final_score_325;
		self.final_score_326	:= subModel[1].final_score_326;	
		self.final_score_327	:= subModel[1].final_score_327;
		self.final_score_328	:= subModel[1].final_score_328;
		self.final_score_329	:= subModel[1].final_score_329;
		self.final_score_330	:= subModel[1].final_score_330;	
		self.final_score_331	:= subModel[1].final_score_331;
		self.final_score_332	:= subModel[1].final_score_332;
		self.final_score_333	:= subModel[1].final_score_333;
		self.final_score_334	:= subModel[1].final_score_334;
		self.final_score_335	:= subModel[1].final_score_335;
		self.final_score_336	:= subModel[1].final_score_336;
		self.final_score_337	:= subModel[1].final_score_337;
		self.final_score_338	:= subModel[1].final_score_338;
		self.final_score_339	:= subModel[1].final_score_339;
		self.final_score_340	:= subModel[1].final_score_340;		
		self.final_score_341	:= subModel[1].final_score_341;
		self.final_score_342	:= subModel[1].final_score_342;
		self.final_score_343	:= subModel[1].final_score_343;
		self.final_score_344	:= subModel[1].final_score_344;
		self.final_score_345	:= subModel[1].final_score_345;
		self.final_score_346	:= subModel[1].final_score_346;	
    self.final_adj_score0  :=  subModel[1].final_adj_score0;
    self.final_adj_score1  :=  subModel[1].final_adj_score1;
    self.final_adj_score2  :=  subModel[1].final_adj_score2;
    self.final_adj_score3  :=  subModel[1].final_adj_score3;
    self.final_adj_score4  :=  subModel[1].final_adj_score4;
    self.final_adj_score5  :=  subModel[1].final_adj_score5;
    self.final_adj_score6  :=  subModel[1].final_adj_score6;
    self.final_adj_score7  :=  subModel[1].final_adj_score7;
    self.final_adj_score8  :=  subModel[1].final_adj_score8;
    self.final_adj_score9  :=  subModel[1].final_adj_score9;
    self.final_adj_score10 :=  subModel[1].final_adj_score10;
    self.final_adj_score11 :=  subModel[1].final_adj_score11;
    self.final_adj_score12 :=  subModel[1].final_adj_score12;
    self.final_adj_score13 :=  subModel[1].final_adj_score13;
    self.final_adj_score14 :=  subModel[1].final_adj_score14;
    self.final_adj_score15 :=  subModel[1].final_adj_score15;
    self.final_adj_score16 :=  subModel[1].final_adj_score16;
    self.final_adj_score17 :=  subModel[1].final_adj_score17;
    self.final_adj_score18 :=  subModel[1].final_adj_score18;
    self.final_adj_score19 :=  subModel[1].final_adj_score19;
    self.final_adj_score20 :=  subModel[1].final_adj_score20;
    self.orig_FDN_FLAPSD_LGT  := subModel[1].orig_FDN_FLAPSD_LGT;
    self.adj_FDN_FLAPSD_LGT  := subModel[1].adj_FDN_FLAPSD_LGT;
    self.orig_FDN_FLAPS__LGT  := subModel[1].orig_FDN_FLAPS__LGT;
    self.adj_FDN_FLAPS__LGT  := subModel[1].adj_FDN_FLAPS__LGT;
    self.orig_FDN_FLA_SD_LGT  := subModel[1].orig_FDN_FLA_SD_LGT;
    self.adj_FDN_FLA_SD_LGT  := subModel[1].adj_FDN_FLA_SD_LGT;
		self.FP3_woFDN_LGT		 := subModel[1].FP3_woFDN_LGT;		
		self									 := le;
	end;

	withModel := PROJECT(topLevelVars, projModel(LEFT));
	
	#if(FP_DEBUG)
	layout_debug := record
		Models.Layout_FP31505;
		risk_indicators.Layout_Boca_Shell clam;
		Models.layout_modelout;
	END;
		Layout_Debug doModel(withModel le, clam ri) := TRANSFORM
	#else
		Models.layouts.layout_fp1109 doModel(withModel le, clam ri) := TRANSFORM
	#end

	FP3_woFDN_LGT									:= le.FP3_woFDN_LGT;
	ssnlength											:= le.ssnlength;
	rc_decsflag										:= le.rc_decsflag;
	dobpop												:= le.dobpop;
	rc_ssndobflag									:= le.rc_ssndobflag;
	rc_hrisksic										:= le.rc_hrisksic;
	hphnpop												:= le.hphnpop;
	rc_hrisksicphone							:= le.rc_hrisksicphone;
	rc_hriskaddrflag							:= le.rc_hriskaddrflag;
	rc_addrcommflag								:= le.rc_addrcommflag;
	rc_hriskphoneflag							:= le.rc_hriskphoneflag;
	rc_hphonetypeflag							:= le.rc_hphonetypeflag;
	rc_hphonevalflag							:= le.rc_hphonevalflag;
	rc_ssnvalflag									:= le.rc_ssnvalflag;
	rc_pwssnvalflag								:= le.rc_pwssnvalflag;
	rc_addrvalflag								:= le.rc_addrvalflag;
	rc_phonevalflag								:= le.rc_phonevalflag;
	ver_sources										:= le.ver_sources;
	nap_type											:= le.nap_type;
	nap_summary										:= le.nap_summary;
	felony_count									:= le.felony_count;
	addrs_prison_history					:= le.addrs_prison_history;
	attr_num_unrel_liens60				:= le.attr_num_unrel_liens60;
	attr_eviction_count						:= le.attr_eviction_count;
	stl_inq_count									:= le.stl_inq_count;
	inq_highriskcredit_count12		:= le.inq_highriskcredit_count12;
	inq_collection_count12				:= le.inq_collection_count12;
	rc_ssndod											:= le.rc_ssndod;
	rc_pwssndobflag								:= le.rc_pwssndobflag;
	rc_ssnmiskeyflag							:= le.rc_ssnmiskeyflag;
	rc_addrmiskeyflag							:= le.rc_addrmiskeyflag;
	add_input_house_number_match	:= le.add_input_house_number_match;
	ssns_per_adl									:= le.ssns_per_adl;
	ssns_per_adl_c6								:= le.ssns_per_adl_c6;
	invalid_ssns_per_adl					:= le.invalid_ssns_per_adl;
	hh_members_w_derog						:= le.hh_members_w_derog;
	hh_criminals									:= le.hh_criminals;
	hh_payday_loan_users					:= le.hh_payday_loan_users;
	nas_summary										:= le.nas_summary;
	inq_count03										:= le.inq_count03;
	inferred_age									:= le.inferred_age;
	hh_members_ct									:= le.hh_members_ct;
	lnames_per_adl_c6							:= le.lnames_per_adl_c6;
	add_curr_pop									:= le.add_curr_pop;
	rel_felony_count							:= le.rel_felony_count;
	addrpop												:= le.addrpop	;
	fnamepop											:= le.fnamepop	;
	lnamepop											:= le.lnamepop	;
	nf_seg_fraudpoint_3_0					:= le.nf_seg_fraudpoint_3_0	;
	r_C10_M_Hdr_FS_d							:= le.r_C10_M_Hdr_FS_d	;
	pii_profile_n									:= le.pii_profile_n;
	
	NULL := -999999999;

	// base := 700; //kh-delta
	base := 850;

	pts := -50;

	lgt := ln(1 / 200);

	offset := ln(((1 - 0.01) * 0.10) / (0.01 * (1 - 0.10)));  //kh-added another set of parenthesis 

	fp3_wofdn_scaled := __common__( min(if(max(round(base + pts * (FP3_woFDN_LGT - offset - lgt) / ln(2)), 300) = NULL, -NULL, max(round(base + pts * (FP3_woFDN_LGT - offset - lgt) / ln(2)), 300)), 999) );

	or_decsssn := __common__( ssnlength > 0 and rc_decsflag = 1 );

	or_ssnpriordob := __common__( ssnlength > 0 and dobpop and rc_ssndobflag = 1 );

	// or_prisonaddr := __common__( rc_hrisksic = '2225' );	//kh-delta
	or_prisonaddr := __common__( addrpop and rc_hrisksic = '2225' );

	or_prisonphone := __common__( hphnpop and rc_hrisksicphone = '2225' );

	// or_hraddr := __common__( rc_hriskaddrflag = 4 or rc_addrcommflag = 2 );	//kh-delta
	or_hraddr := __common__( addrpop and (rc_hriskaddrflag=4 or rc_addrcommflag=2) );

	or_hrphone := __common__( hphnpop and (rc_hriskphoneflag = 6 or rc_hphonetypeflag = '5' or rc_hphonevalflag = 3 or rc_addrcommflag = 1) );

	or_invalidssn := __common__( ssnlength > 0 and (rc_ssnvalflag = 1 or (rc_pwssnvalflag in ['1', '2', '3'])) );

	// or_invalidaddr := __common__( rc_addrvalflag != 'V' );	//kh-delta
	or_invalidaddr := __common__( addrpop and rc_addrvalflag != 'V' );

	or_invalidphone := __common__( hphnpop and (rc_phonevalflag = 0 or rc_hphonevalflag = 0) );

	fp3_wofdn_score := __common__( map(
			// or_decsssn or or_ssnpriordob or or_prisonaddr                                                   => min(if(fp3_wofdn_scaled = NULL, -NULL, fp3_wofdn_scaled), 540),	//kh-delta
			or_decsssn or or_ssnpriordob or or_prisonaddr                                                   => min(if(fp3_wofdn_scaled = NULL, -NULL, fp3_wofdn_scaled), 690),
			// or_prisonphone or or_hraddr or or_hrphone or or_invalidssn or or_invalidaddr or or_invalidphone => min(if(fp3_wofdn_scaled = NULL, -NULL, fp3_wofdn_scaled), 740),	//kh-delta
			or_prisonphone or or_hraddr or or_hrphone or or_invalidssn or or_invalidaddr or or_invalidphone => min(if(fp3_wofdn_scaled = NULL, -NULL, fp3_wofdn_scaled), 890),
																																																				 fp3_wofdn_scaled) );

	fp31505_0_0 := __common__( fp3_wofdn_score );
	_ver_src_ds := __common__( Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0 );

	_ver_src_de := __common__( Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0 );

	_ver_src_eq := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0 );

	_ver_src_en := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0 );

	_ver_src_tn := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0 );

	_ver_src_tu := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0 );

	_credit_source_cnt := __common__( if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu)) );

  // _ver_src_cnt := __common__( Models.Common.countw((string)(ver_sources), ARRAY(0x2ef84c0)) );
	_ver_src_cnt := __common__( Models.Common.countw((string)(StringLib.StringToUpperCase(trim(ver_sources, ALL))), ',') );	//kh-changed to this

	_bureauonly := __common__( _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])) );

	_derog := __common__( felony_count > 0 OR addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2 );

	_deceased := __common__( rc_decsflag = 1 OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de );

	_ssnpriortodob := __common__( rc_ssndobflag = 1 OR rc_pwssndobflag = 1 );

	_inputmiskeys := __common__( rc_ssnmiskeyflag or rc_addrmiskeyflag or add_input_house_number_match = 0 );

	_multiplessns := __common__( ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1 );

	_hh_strikes := __common__( if(max((integer)(hh_members_w_derog > 0), (integer)(hh_criminals > 0), (integer)(hh_payday_loan_users > 0)) = 0, NULL, sum((integer)(hh_members_w_derog > 0), (integer)(hh_criminals > 0), (integer)(hh_payday_loan_users > 0))) );

	// stolenid := __common__( if((nas_summary in [4, 7, 9]) or 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = 9 or _deceased or _ssnpriortodob, 1, 0) );	//kh-delta
	stolenid := __common__( if((addrpop and nas_summary in [4, 7, 9]) or (fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9) and inq_count03 > 0 and ssnlength = 9 or _deceased or _ssnpriortodob, 1, 0) );

	manipulatedid := __common__( if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0) );

	manipulatedidpt2 := __common__( if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = 9, 1, 0) );

	// syntheticid := __common__( if(nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt = 0 or _bureauonly or ~add_curr_pop, 1, 0) );	//kh-delta
	syntheticid := __common__( if(fnamepop and lnamepop and addrpop and ssnlength=9 and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt = 0 or _bureauonly or ~add_curr_pop, 1, 0) );
										
	suspiciousactivity := __common__( if(_derog, 1, 0) );

	// vulnerablevictim := __common__( if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0) );	//kh-delta
	vulnerablevictim := __common__( if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0) );

	friendlyfraud := __common__( if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0) );

	stolenc_fp31505_0_0 := __common__( if(stolenid = 1, fp31505_0_0, 299) );

	manip2c_fp31505_0_0 := __common__( if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2, fp31505_0_0, 299) );

	synthc_fp31505_0_0 := __common__( if(syntheticid = 1, fp31505_0_0, 299) );

	suspactc_fp31505_0_0 := __common__( if(suspiciousactivity = 1, fp31505_0_0, 299) );

	vulnvicc_fp31505_0_0 := __common__( if(vulnerablevictim = 1, fp31505_0_0, 299) );

	friendlyc_fp31505_0_0 := __common__( if(friendlyfraud = 1, fp31505_0_0, 299) );

	stolidindex := __common__( map(
			FP3_woFDN_LGT = -999																			=> 0,
			stolenc_fp31505_0_0 = 299                                 => 1,
			300 <= stolenc_fp31505_0_0 AND stolenc_fp31505_0_0 < 600  => 9,
			600 <= stolenc_fp31505_0_0 AND stolenc_fp31505_0_0 < 670  => 8,
			670 <= stolenc_fp31505_0_0 AND stolenc_fp31505_0_0 < 710  => 7,
			710 <= stolenc_fp31505_0_0 AND stolenc_fp31505_0_0 < 750  => 6,
			750 <= stolenc_fp31505_0_0 AND stolenc_fp31505_0_0 < 795  => 5,
			795 <= stolenc_fp31505_0_0 AND stolenc_fp31505_0_0 < 820  => 4,
			820 <= stolenc_fp31505_0_0 AND stolenc_fp31505_0_0 < 850  => 3,
			850 <= stolenc_fp31505_0_0 AND stolenc_fp31505_0_0 <= 999 => 2,
                                                                   99) );

	manipidindex := __common__( map(
			FP3_woFDN_LGT = -999																			=> 0,
			manip2c_fp31505_0_0 = 299                                 => 1,
			300 <= manip2c_fp31505_0_0 AND manip2c_fp31505_0_0 < 620  => 9,
			620 <= manip2c_fp31505_0_0 AND manip2c_fp31505_0_0 < 695  => 8,
			695 <= manip2c_fp31505_0_0 AND manip2c_fp31505_0_0 < 740  => 7,
			740 <= manip2c_fp31505_0_0 AND manip2c_fp31505_0_0 < 770  => 6,
			770 <= manip2c_fp31505_0_0 AND manip2c_fp31505_0_0 < 795  => 5,
			795 <= manip2c_fp31505_0_0 AND manip2c_fp31505_0_0 < 820  => 4,
			820 <= manip2c_fp31505_0_0 AND manip2c_fp31505_0_0 < 850  => 3,
			850 <= manip2c_fp31505_0_0 AND manip2c_fp31505_0_0 <= 999 => 2,
																																	 99) );

	synthidindex := __common__( map(
			FP3_woFDN_LGT = -999																		=> 0,
			synthc_fp31505_0_0 = 299                                => 1,
			300 <= synthc_fp31505_0_0 AND synthc_fp31505_0_0 < 590  => 9,
			590 <= synthc_fp31505_0_0 AND synthc_fp31505_0_0 < 650  => 8,
			650 <= synthc_fp31505_0_0 AND synthc_fp31505_0_0 < 700  => 7,
			700 <= synthc_fp31505_0_0 AND synthc_fp31505_0_0 < 750  => 6,
			750 <= synthc_fp31505_0_0 AND synthc_fp31505_0_0 < 780  => 5,
			780 <= synthc_fp31505_0_0 AND synthc_fp31505_0_0 < 810  => 4,
			810 <= synthc_fp31505_0_0 AND synthc_fp31505_0_0 < 850  => 3,
			850 <= synthc_fp31505_0_0 AND synthc_fp31505_0_0 <= 999 => 2,
																																 99) );

	suspactindex := __common__( map(
			FP3_woFDN_LGT = -999																				=> 0,
			suspactc_fp31505_0_0 = 299                                  => 1,
			300 <= suspactc_fp31505_0_0 AND suspactc_fp31505_0_0 < 580  => 9,
			580 <= suspactc_fp31505_0_0 AND suspactc_fp31505_0_0 < 650  => 8,
			650 <= suspactc_fp31505_0_0 AND suspactc_fp31505_0_0 < 690  => 7,
			690 <= suspactc_fp31505_0_0 AND suspactc_fp31505_0_0 < 750  => 6,
			750 <= suspactc_fp31505_0_0 AND suspactc_fp31505_0_0 < 795  => 5,
			795 <= suspactc_fp31505_0_0 AND suspactc_fp31505_0_0 < 830  => 4,
			830 <= suspactc_fp31505_0_0 AND suspactc_fp31505_0_0 < 860  => 3,
			860 <= suspactc_fp31505_0_0 AND suspactc_fp31505_0_0 <= 999 => 2,
																																		 99) );

	vulnvicindex := __common__( map(
			FP3_woFDN_LGT = -999																				=> 0,
			vulnvicc_fp31505_0_0 = 299                                  => 1,
			300 <= vulnvicc_fp31505_0_0 AND vulnvicc_fp31505_0_0 < 570  => 9,
			570 <= vulnvicc_fp31505_0_0 AND vulnvicc_fp31505_0_0 < 700  => 8,
			700 <= vulnvicc_fp31505_0_0 AND vulnvicc_fp31505_0_0 < 765  => 7,
			765 <= vulnvicc_fp31505_0_0 AND vulnvicc_fp31505_0_0 < 810  => 6,
			810 <= vulnvicc_fp31505_0_0 AND vulnvicc_fp31505_0_0 < 835  => 5,
			835 <= vulnvicc_fp31505_0_0 AND vulnvicc_fp31505_0_0 < 850  => 4,
			850 <= vulnvicc_fp31505_0_0 AND vulnvicc_fp31505_0_0 < 870  => 3,
			870 <= vulnvicc_fp31505_0_0 AND vulnvicc_fp31505_0_0 <= 999 => 2,
																																		 99) );

	friendfrdindex := __common__( map(
			FP3_woFDN_LGT = -999																					=> 0,
			friendlyc_fp31505_0_0 = 299                                   => 1,
			300 <= friendlyc_fp31505_0_0 AND friendlyc_fp31505_0_0 < 600  => 9,
			600 <= friendlyc_fp31505_0_0 AND friendlyc_fp31505_0_0 < 665  => 8,
			665 <= friendlyc_fp31505_0_0 AND friendlyc_fp31505_0_0 < 715  => 7,
			715 <= friendlyc_fp31505_0_0 AND friendlyc_fp31505_0_0 < 765  => 6,
			765 <= friendlyc_fp31505_0_0 AND friendlyc_fp31505_0_0 < 810  => 5,
			810 <= friendlyc_fp31505_0_0 AND friendlyc_fp31505_0_0 < 840  => 4,
			840 <= friendlyc_fp31505_0_0 AND friendlyc_fp31505_0_0 < 870  => 3,
			870 <= friendlyc_fp31505_0_0 AND friendlyc_fp31505_0_0 <= 999 => 2,
																																			 99) );



	#if(FP_DEBUG)	
	self.base                             := base;
	self.pts                              := pts;
	self.lgt                              := lgt;
	self.offset                           := offset;
	self.fp3_wofdn_scaled                 := fp3_wofdn_scaled;
	self.or_decsssn                       := or_decsssn;
	self.or_ssnpriordob                   := or_ssnpriordob;
	self.or_prisonaddr                    := or_prisonaddr;
	self.or_prisonphone                   := or_prisonphone;
	self.or_hraddr                        := or_hraddr;
	self.or_hrphone                       := or_hrphone;
	self.or_invalidssn                    := or_invalidssn;
	self.or_invalidaddr                   := or_invalidaddr;
	self.or_invalidphone                  := or_invalidphone;
	self.fp3_wofdn_score                  := fp3_wofdn_score;
	self.fp31505_0_0                      := fp31505_0_0;
	self._ver_src_ds                      := _ver_src_ds;
	self._ver_src_de                      := _ver_src_de;
	self._ver_src_eq                      := _ver_src_eq;
	self._ver_src_en                      := _ver_src_en;
	self._ver_src_tn                      := _ver_src_tn;
	self._ver_src_tu                      := _ver_src_tu;
	self._credit_source_cnt               := _credit_source_cnt;
	self._ver_src_cnt                     := _ver_src_cnt;
	self._bureauonly                      := _bureauonly;
	self._derog                           := _derog;
	self._deceased                        := _deceased;
	self._ssnpriortodob                   := _ssnpriortodob;
	self._inputmiskeys                    := _inputmiskeys;
	self._multiplessns                    := _multiplessns;
	self._hh_strikes                      := _hh_strikes;
	self.stolenid                         := stolenid;
	self.manipulatedid                    := manipulatedid;
	self.manipulatedidpt2                 := manipulatedidpt2;
	self.syntheticid                      := syntheticid;
	self.suspiciousactivity               := suspiciousactivity;
	self.vulnerablevictim                 := vulnerablevictim;
	self.friendlyfraud                    := friendlyfraud;
	self.stolenc_fp31505_0_0              := stolenc_fp31505_0_0;
	self.manip2c_fp31505_0_0              := manip2c_fp31505_0_0;
	self.synthc_fp31505_0_0               := synthc_fp31505_0_0;
	self.suspactc_fp31505_0_0             := suspactc_fp31505_0_0;
	self.vulnvicc_fp31505_0_0             := vulnvicc_fp31505_0_0;
	self.friendlyc_fp31505_0_0            := friendlyc_fp31505_0_0;
	self.stolidindex                      := if(pii_profile_n = Risk_Indicators.iid_constants.error_con, 0, stolidindex);
	self.manipidindex                     := if(pii_profile_n = Risk_Indicators.iid_constants.error_con, 0, manipidindex);
	self.synthidindex                     := if(pii_profile_n = Risk_Indicators.iid_constants.error_con, 0, synthidindex);
	self.suspactindex                     := if(pii_profile_n = Risk_Indicators.iid_constants.error_con, 0, suspactindex);
	self.vulnvicindex                     := if(pii_profile_n = Risk_Indicators.iid_constants.error_con, 0, vulnvicindex);
	self.friendfrdindex                   := if(pii_profile_n = Risk_Indicators.iid_constants.error_con, 0, friendfrdindex);
	self.clam															:= ri.bs;
	// self.clam															:= [];
	self.seq															:= le.seqa;
	self.score														:= if(pii_profile_n = Risk_Indicators.iid_constants.error_con, '', (string)fp31505_0_0);
	ritmp 																:= Models.fraudpoint3_reasons(ri.bs, ri.ip, num_reasons, criminal, include_FDN, nf_seg_fraudpoint_3_0, r_C10_M_Hdr_FS_d );
  reasons 															:= Models.Common.checkFraudPointRC34(fp31505_0_0, ritmp, num_reasons);
	self.rc1															:= reasons[1].hri;
	self.rc2															:= reasons[2].hri;
	self.rc3															:= reasons[3].hri;
	self.rc4															:= reasons[4].hri;
	self.rc5															:= reasons[5].hri;
	self.rc6															:= reasons[6].hri;
	blankRCs := DATASET([{'00',''}],risk_indicators.Layout_Desc) &
					    DATASET([{'00',''}],risk_indicators.Layout_Desc) &
					    DATASET([{'00',''}],risk_indicators.Layout_Desc) &
					    DATASET([{'00',''}],risk_indicators.Layout_Desc) &
					    DATASET([{'00',''}],risk_indicators.Layout_Desc) &
					    DATASET([{'00',''}],risk_indicators.Layout_Desc);
	self.ri																:= if(pii_profile_n = Risk_Indicators.iid_constants.error_con, blankRCs, reasons); 
	self																	:= le;
	#else
	self.seq															:= le.seqa;
	self.score														:= if(pii_profile_n = Risk_Indicators.iid_constants.error_con, '', (string)fp31505_0_0);
	ritmp 																:= Models.fraudpoint3_reasons(ri.bs, ri.ip, num_reasons, criminal, include_FDN, nf_seg_fraudpoint_3_0, r_C10_M_Hdr_FS_d );
  reasons 															:= Models.Common.checkFraudPoint3RC34(fp31505_0_0, ritmp, num_reasons);
	blankRCs := DATASET([{'00',''}],risk_indicators.Layout_Desc) &
					    DATASET([{'00',''}],risk_indicators.Layout_Desc) &
					    DATASET([{'00',''}],risk_indicators.Layout_Desc) &
					    DATASET([{'00',''}],risk_indicators.Layout_Desc) &
					    DATASET([{'00',''}],risk_indicators.Layout_Desc) &
					    DATASET([{'00',''}],risk_indicators.Layout_Desc);
  self.ri 															:= if(pii_profile_n = Risk_Indicators.iid_constants.error_con, blankRCs, reasons);	
	self.StolenIdentityIndex							:= if(pii_profile_n = Risk_Indicators.iid_constants.error_con, '', (string)stolidindex);
	self.SyntheticIdentityIndex						:= if(pii_profile_n = Risk_Indicators.iid_constants.error_con, '', (string)synthidindex);
	self.ManipulatedIdentityIndex					:= if(pii_profile_n = Risk_Indicators.iid_constants.error_con, '', (string)manipidindex);
	self.VulnerableVictimIndex						:= if(pii_profile_n = Risk_Indicators.iid_constants.error_con, '', (string)vulnvicindex);
	self.FriendlyFraudIndex								:= if(pii_profile_n = Risk_Indicators.iid_constants.error_con, '', (string)friendfrdindex);
	self.SuspiciousActivityIndex					:= if(pii_profile_n = Risk_Indicators.iid_constants.error_con, '', (string)suspactindex);
	#end
	End;

	model := JOIN(withModel, clam,
		left.seqa = right.bs.seq,
		doModel(left, right),
		atmost(RiskWise.max_atmost)
		,keep(1)
	);
	
  return model;
	
end;