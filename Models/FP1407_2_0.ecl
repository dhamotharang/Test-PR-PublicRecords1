/*2014-09-25T00:47:10Z (Kenneth Hill_prod)
FP1404,FP1407 turn off debugging
*/
//Axcess Financial - custom Fraudpoint model FP1407_2 WNLI (Why not lease it)

import risk_indicators, riskwise, ut, easi;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1407_2_0( dataset(risk_indicators.Layout_Boca_Shell) clam,  integer1 num_reasons, string16 segment_in) := FUNCTION
//export FP1407_2_0( dataset(Models.fp1407_1_testlayout) clam,  integer1 num_reasons, string16 segment_in) := FUNCTION

FP_DEBUG := false;

	#if(FP_DEBUG)
		Layout_Debug := RECORD, maxlength(64236)
			Models.FP1407_1_0_LayoutDebug;
			
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
		END;
	layout_debug doModel( clam le, easi.Key_Easi_Census ri ) :=  TRANSFORM
	#else
	models.layout_modelout doModel( clam le, easi.Key_Easi_Census ri  ) := TRANSFORM
	#end

	segment_i                          := TRIM(segment_in); //TRIM(le.segment);
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	out_addr_status                  := le.shell_input.addr_status;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_type                         := le.iid.nap_type;
	cvi                              := le.iid.cvi;
	reason1                          := le.iid.reason1;
	reason2                          := le.iid.reason2;
	reason3                          := le.iid.reason3;
	reason4                          := le.iid.reason4;
	reason5                          := le.iid.reason5;
	reason6                          := le.iid.reason6;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	bus_name_match                   := le.business_header_address_summary.bus_name_match;
	addrpop                          := le.input_validation.address;
	ssnlength                        := (integer)le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	util_adl_type_list               := le.utility.utili_adl_type;
	util_adl_count                   := le.utility.utili_adl_count;
	util_add1_type_list              := le.utility.utili_addr1_type;
	util_add2_type_list              := le.utility.utili_addr2_type;
	add1_address_score               := le.address_verification.input_address_information.address_score;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_lres                        := le.lres;
	add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
	add1_advo_dnd                    := le.advo_input_addr.dnd_indicator;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_occupants_1yr               := le.addr_risk_summary.occupants_1yr;
	add1_turnover_1yr_in             := le.addr_risk_summary.turnover_1yr_in;
	add1_nhood_vacant_properties     := le.addr_risk_summary.n_vacant_properties;
	add1_nhood_business_count        := le.addr_risk_summary.n_business_count;
	add1_nhood_sfd_count             := le.addr_risk_summary.n_sfd_count;
	add1_nhood_mfd_count             := le.addr_risk_summary.n_mfd_count;
	add1_pop                         := le.addrpop;
	add2_advo_address_vacancy        := le.advo_addr_hist1.address_vacancy_indicator;	// missing in original sas xlate
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_purchase_total    := le.address_verification.owned.property_owned_purchase_total;
	property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
	property_sold_purchase_total     := le.address_verification.sold.property_owned_purchase_total;
	property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	dist_a1toa3                      := le.address_verification.distance_in_2_h2;
	dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
	add2_address_score               := le.address_verification.address_history_1.address_score;
	add2_lres                        := le.lres2;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_avm_automated_valuation_2   := le.avm.address_history_1.avm_automated_valuation2;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	add2_occupants_1yr               := le.addr_risk_summary2.occupants_1yr;
	add2_turnover_1yr_in             := le.addr_risk_summary2.turnover_1yr_in;
	add2_nhood_vacant_properties     := le.addr_risk_summary2.n_vacant_properties;
	add2_nhood_business_count        := le.addr_risk_summary2.n_business_count;
	add2_nhood_sfd_count             := le.addr_risk_summary2.n_sfd_count;
	add2_nhood_mfd_count             := le.addr_risk_summary2.n_mfd_count;
	add2_pop                         := le.addrpop2;
	add3_naprop                      := le.address_verification.address_history_2.naprop;
	avg_lres                         := le.other_address_info.avg_lres;
	max_lres                         := le.other_address_info.max_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	addr_lres_2mo_count              := le.address_history_summary.lres_2mo_count;
	addr_lres_6mo_count              := le.address_history_summary.lres_6mo_count;
	addr_lres_12mo_count             := le.address_history_summary.lres_12mo_count;
	hist_addr_match                  := le.address_history_summary.hist_addr_match;
	telcordia_type                   := le.phone_verification.telcordia_type;
	recent_disconnects               := le.phone_verification.recent_disconnects;
	header_first_seen                := le.ssn_verification.header_first_seen;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	phones_per_addr                  := le.velocity_counters.phones_per_addr;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	invalid_ssns_per_adl_c6          := le.velocity_counters.invalid_ssns_per_adl_created_6months;
	invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
	invalid_addrs_per_adl_c6         := le.velocity_counters.invalid_addrs_per_adl_created_6months;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_collection_count01           := le.acc_logs.collection.count01;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_collection_count06           := le.acc_logs.collection.count06;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_collection_count24           := le.acc_logs.collection.count24;
	inq_auto_count                   := le.acc_logs.auto.counttotal;
	inq_auto_count01                 := le.acc_logs.auto.count01;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_auto_count06                 := le.acc_logs.auto.count06;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_auto_count24                 := le.acc_logs.auto.count24;
	inq_banking_count                := le.acc_logs.banking.counttotal;
	inq_banking_count01              := le.acc_logs.banking.count01;
	inq_banking_count03              := le.acc_logs.banking.count03;
	inq_banking_count06              := le.acc_logs.banking.count06;
	inq_banking_count12              := le.acc_logs.banking.count12;
	inq_banking_count24              := le.acc_logs.banking.count24;
	inq_mortgage_count               := le.acc_logs.mortgage.counttotal;
	inq_mortgage_count01             := le.acc_logs.mortgage.count01;
	inq_mortgage_count03             := le.acc_logs.mortgage.count03;
	inq_mortgage_count06             := le.acc_logs.mortgage.count06;
	inq_mortgage_count12             := le.acc_logs.mortgage.count12;
	inq_mortgage_count24             := le.acc_logs.mortgage.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_retail_count                 := le.acc_logs.retail.counttotal;
	inq_retail_count01               := le.acc_logs.retail.count01;
	inq_retail_count03               := le.acc_logs.retail.count03;
	inq_retail_count06               := le.acc_logs.retail.count06;
	inq_retail_count12               := le.acc_logs.retail.count12;
	inq_retail_count24               := le.acc_logs.retail.count24;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_perssn                       := le.acc_logs.inquiryperssn;
	inq_adlsperssn                   := le.acc_logs.inquiryadlsperssn;
	inq_lnamesperssn                 := le.acc_logs.inquirylnamesperssn;
	inq_addrsperssn                  := le.acc_logs.inquiryaddrsperssn;
	inq_dobsperssn                   := le.acc_logs.inquirydobsperssn;
	inq_peraddr                      := le.acc_logs.inquiryperaddr;
	inq_adlsperaddr                  := le.acc_logs.inquiryadlsperaddr;
	inq_lnamesperaddr                := le.acc_logs.inquirylnamesperaddr;
	inq_ssnsperaddr                  := le.acc_logs.inquiryssnsperaddr;
	inq_perphone                     := le.acc_logs.inquiryperphone;
	inq_adlsperphone                 := le.acc_logs.inquiryadlsperphone;
	inq_banko_cm_first_seen          := le.acc_logs.cm_first_seen_date;
	inq_banko_cm_last_seen           := le.acc_logs.cm_last_seen_date;
	inq_banko_om_first_seen          := le.acc_logs.om_first_seen_date;
	inq_banko_om_last_seen           := le.acc_logs.om_last_seen_date;
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_average_days_bt_orders        := le.ibehavior.average_days_between_orders;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	pb_total_dollars                 := le.ibehavior.total_dollars;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_source_count                 := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	impulse_first_seen               := le.impulse.first_seen_date;
	impulse_last_seen                := le.impulse.last_seen_date;
	email_count                      := le.email_summary.email_ct;
	email_domain_free_count          := le.email_summary.email_domain_free_ct;
	email_domain_isp_count           := le.email_summary.email_domain_isp_ct;
	email_source_list                := le.email_summary.email_source_list;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_arrests                     := le.bjl.arrests_count;
	attr_arrests30                   := le.bjl.arrests_count30;
	attr_arrests90                   := le.bjl.arrests_count90;
	attr_arrests180                  := le.bjl.arrests_count180;
	attr_arrests12                   := le.bjl.arrests_count12;
	attr_arrests24                   := le.bjl.arrests_count24;
	attr_arrests36                   := le.bjl.arrests_count36;
	attr_arrests60                   := le.bjl.arrests_count60;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_bankruptcy_count30          := le.bjl.bk_count30;
	attr_bankruptcy_count90          := le.bjl.bk_count90;
	attr_bankruptcy_count180         := le.bjl.bk_count180;
	attr_bankruptcy_count12          := le.bjl.bk_count12;
	attr_bankruptcy_count24          := le.bjl.bk_count24;
	attr_bankruptcy_count36          := le.bjl.bk_count36;
	attr_bankruptcy_count60          := le.bjl.bk_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_sourcerisktype                := le.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_varmsrcssncount               := le.fdattributesv2.variationmsourcesssncount;
	fp_varmsrcssnunrelcount          := le.fdattributesv2.variationmsourcesssnunrelcount;
	fp_vardobcount                   := le.fdattributesv2.variationdobcount;
	fp_vardobcountnew                := le.fdattributesv2.variationdobcountnew;
	fp_srchvelocityrisktype          := le.fdattributesv2.searchvelocityrisklevel;
	fp_srchcountwk                   := le.fdattributesv2.searchcountweek;
	fp_srchunvrfdssncount            := le.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfdaddrcount           := le.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfddobcount            := le.fdattributesv2.searchunverifieddobcountyear;
	fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcount            := le.fdattributesv2.searchfraudsearchcount;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcountmo          := le.fdattributesv2.searchfraudsearchcountmonth;
	fp_srchfraudsrchcountwk          := le.fdattributesv2.searchfraudsearchcountweek;
	fp_assocrisktype                 := le.fdattributesv2.assocrisklevel;
	fp_assocsuspicousidcount         := le.fdattributesv2.assocsuspicousidentitiescount;
	fp_assoccredbureaucount          := le.fdattributesv2.assoccreditbureauonlycount;
	fp_corrrisktype                  := le.fdattributesv2.correlationrisklevel;
	fp_corrssnnamecount              := le.fdattributesv2.correlationssnnamecount;
	fp_corrssnaddrcount              := le.fdattributesv2.correlationssnaddrcount;
	fp_corraddrnamecount             := le.fdattributesv2.correlationaddrnamecount;
	fp_corraddrphonecount            := le.fdattributesv2.correlationaddrphonecount;
	fp_corrphonelastnamecount        := le.fdattributesv2.correlationphonelastnamecount;
	fp_divrisktype                   := le.fdattributesv2.divrisklevel;
	fp_divssnidmsrcurelcount         := le.fdattributesv2.divssnidentitymsourceurelcount;
	fp_divaddrsuspidcountnew         := le.fdattributesv2.divaddrsuspidentitycountnew;
	fp_divsrchaddrsuspidcount        := le.fdattributesv2.divsearchaddrsuspidentitycount;
	fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
	fp_srchssnsrchcount              := le.fdattributesv2.searchssnsearchcount;
	fp_srchssnsrchcountmo            := le.fdattributesv2.searchssnsearchcountmonth;
	fp_srchaddrsrchcount             := le.fdattributesv2.searchaddrsearchcount;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchaddrsrchcountwk           := le.fdattributesv2.searchaddrsearchcountweek;
	fp_srchphonesrchcount            := le.fdattributesv2.searchphonesearchcount;
	fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
	fp_srchphonesrchcountwk          := le.fdattributesv2.searchphonesearchcountweek;
	fp_componentcharrisktype         := le.fdattributesv2.componentcharrisklevel;
	fp_inputaddractivephonelist      := le.fdattributesv2.inputaddractivephonelist;
	fp_addrchangeincomediff          := le.fdattributesv2.addrchangeincomediff;
	fp_addrchangevaluediff           := le.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff           := le.fdattributesv2.addrchangecrimediff;
	fp_addrchangeecontrajindex       := le.fdattributesv2.addrchangeecontrajectoryindex;
	fp_curraddractivephonelist       := le.fdattributesv2.curraddractivephonelist;
	fp_curraddrmedianincome          := le.fdattributesv2.curraddrmedianincome;
	fp_curraddrmedianvalue           := le.fdattributesv2.curraddrmedianvalue;
	fp_curraddrmurderindex           := le.fdattributesv2.curraddrmurderindex;
	fp_curraddrcartheftindex         := le.fdattributesv2.curraddrcartheftindex;
	fp_curraddrburglaryindex         := le.fdattributesv2.curraddrburglaryindex;
	fp_curraddrcrimeindex            := le.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrageoldest             := le.fdattributesv2.prevaddrageoldest;
	fp_prevaddrlenofres              := le.fdattributesv2.prevaddrlenofres;
	fp_prevaddrdwelltype             := le.fdattributesv2.prevaddrdwelltype;
	fp_prevaddrstatus                := le.fdattributesv2.prevaddrstatus;
	fp_prevaddroccupantowned         := le.fdattributesv2.prevaddroccupantowned;
	fp_prevaddrmedianincome          := le.fdattributesv2.prevaddrmedianincome;
	fp_prevaddrmedianvalue           := le.fdattributesv2.prevaddrmedianvalue;
	fp_prevaddrmurderindex           := le.fdattributesv2.prevaddrmurderindex;
	fp_prevaddrcartheftindex         := le.fdattributesv2.prevaddrcartheftindex;
	fp_prevaddrburglaryindex         := le.fdattributesv2.prevaddrburglaryindex;
	fp_prevaddrcrimeindex            := le.fdattributesv2.prevaddrcrimeindex;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_cj_first_seen        := le.liens.liens_unreleased_civil_judgment.earliest_filing_date;
	liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
	liens_rel_cj_first_seen          := le.liens.liens_released_civil_judgment.earliest_filing_date;
	liens_rel_cj_last_seen           := le.liens.liens_released_civil_judgment.most_recent_filing_date;
	liens_rel_cj_total_amount        := le.liens.liens_released_civil_judgment.total_amount;
	liens_unrel_ft_last_seen         := le.liens.liens_unreleased_federal_tax.most_recent_filing_date;
	liens_unrel_ft_total_amount      := le.liens.liens_unreleased_federal_tax.total_amount;
	liens_unrel_lt_first_seen        := le.liens.liens_unreleased_landlord_tenant.earliest_filing_date;
	liens_unrel_lt_last_seen         := le.liens.liens_unreleased_landlord_tenant.most_recent_filing_date;
	liens_unrel_o_total_amount       := le.liens.liens_unreleased_other_lj.total_amount;
	liens_unrel_ot_first_seen        := le.liens.liens_unreleased_other_tax.earliest_filing_date;
	liens_unrel_ot_last_seen         := le.liens.liens_unreleased_other_tax.most_recent_filing_date;
	liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
	liens_rel_ot_first_seen          := le.liens.liens_released_other_tax.earliest_filing_date;
	liens_rel_ot_last_seen           := le.liens.liens_released_other_tax.most_recent_filing_date;
	liens_unrel_sc_first_seen        := le.liens.liens_unreleased_small_claims.earliest_filing_date;
	liens_unrel_sc_total_amount      := le.liens.liens_unreleased_small_claims.total_amount;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	felony_last_date                 := le.bjl.last_felony_date;
	rel_count                        := le.relatives.relative_count;
	rel_bankrupt_count               := le.relatives.relative_bankrupt_count;
	rel_criminal_count               := le.relatives.relative_criminal_count;
	rel_felony_count                 := le.relatives.relative_felony_count;
	crim_rel_within25miles           := le.relatives.criminal_relative_within25miles;
	crim_rel_within100miles          := le.relatives.criminal_relative_within100miles;
	crim_rel_within500miles          := le.relatives.criminal_relative_within500miles;
	rel_within25miles_count          := le.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.relatives.relative_within100miles_count;
	rel_within500miles_count         := le.relatives.relative_within500miles_count;
	rel_incomeunder50_count          := le.relatives.relative_incomeunder50_count;
	rel_incomeunder75_count          := le.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
	rel_homeunder100_count           := le.relatives.relative_homeunder100_count;
	rel_homeunder150_count           := le.relatives.relative_homeunder150_count;
	rel_homeunder200_count           := le.relatives.relative_homeunder200_count;
	rel_homeunder300_count           := le.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.relatives.relative_homeover500_count;
	rel_educationunder12_count       := le.relatives.relative_educationunder12_count;
	rel_educationover12_count        := le.relatives.relative_educationover12_count;
	rel_ageunder30_count             := le.relatives.relative_ageunder30_count;
	rel_ageunder40_count             := le.relatives.relative_ageunder40_count;
	rel_ageunder50_count             := le.relatives.relative_ageunder50_count;
	rel_ageunder60_count             := le.relatives.relative_ageunder60_count;
	rel_ageunder70_count             := le.relatives.relative_ageunder70_count;
	rel_ageover70_count              := le.relatives.relative_ageover70_count;
	current_count                    := le.vehicles.current_count;
	historical_count                 := le.vehicles.historical_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	acc_count                        := le.accident_data.acc.num_accidents;
	acc_damage_amt_total             := le.accident_data.acc.dmgamtaccidents;
	acc_last_seen                    := le.accident_data.acc.datelastaccident;
	acc_damage_amt_last              := le.accident_data.acc.dmgamtlastaccident;
	acc_count_30                     := le.accident_data.acc.numaccidents30;
	acc_count_90                     := le.accident_data.acc.numaccidents90;
	acc_count_180                    := le.accident_data.acc.numaccidents180;
	acc_count_12                     := le.accident_data.acc.numaccidents12;
	acc_count_24                     := le.accident_data.acc.numaccidents24;
	acc_count_36                     := le.accident_data.acc.numaccidents36;
	acc_count_60                     := le.accident_data.acc.numaccidents60;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	wealth_index                     := le.wealth_indicator;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	addr_stability_v2                := le.addr_stability;
	estimated_income                 := le.estimated_income;

	c_ab_av_edu                      := ri.ab_av_edu;
	c_agriculture                    := ri.agriculture;
	c_amus_indx                      := ri.amus_indx;
	c_apt20                          := ri.apt20;
	c_armforce                       := ri.armforce;
	c_asian_lang                     := ri.asian_lang;
	c_assault                        := ri.assault;
	c_bargains                       := ri.bargains;
	c_bel_edu                        := ri.bel_edu;
	c_bigapt_p                       := ri.bigapt_p;
	c_blue_col                       := ri.blue_col;
	c_blue_empl                      := ri.blue_empl;
	c_born_usa                       := ri.born_usa;
	c_burglary                       := ri.burglary;
	c_business                       := ri.business;
	c_cartheft                       := ri.cartheft;
	c_child                          := ri.child;
	c_civ_emp                        := ri.civ_emp;
	c_construction                   := ri.construction;
	c_cpiall                         := ri.cpiall;
	c_cult_indx                      := ri.cult_indx;
	c_easiqlife                      := ri.easiqlife;
	c_edu_indx                       := ri.edu_indx;
	c_employees                      := ri.employees;
	c_exp_homes                      := ri.exp_homes;
	c_exp_prod                       := ri.exp_prod;
	c_families                       := ri.families;
	c_fammar18_p                     := ri.fammar18_p;
	c_fammar_p                       := ri.fammar_p;
	c_famotf18_p                     := ri.famotf18_p;
	c_femdiv_p                       := ri.femdiv_p;
	c_finance                        := ri.finance;
	c_food                           := ri.food;
	c_for_sale                       := ri.for_sale;
	c_health                         := ri.health;
	c_hh00                           := ri.hh00;
	c_hh1_p                          := ri.hh1_p;
	c_hh2_p                          := ri.hh2_p;
	c_hh3_p                          := ri.hh3_p;
	c_hh4_p                          := ri.hh4_p;
	c_hh5_p                          := ri.hh5_p;
	c_hh6_p                          := ri.hh6_p;
	c_hh7p_p                         := ri.hh7p_p;
	c_hhsize                         := ri.hhsize;
	c_high_ed                        := ri.high_ed;
	c_high_hval                      := ri.high_hval;
	c_highinc                        := ri.highinc;
	c_highrent                       := ri.highrent;
	c_housingcpi                     := ri.housingcpi;
	c_hval_1000k_p                   := ri.hval_1000k_p;
	c_hval_1001k_p                   := ri.hval_1001k_p;
	c_hval_100k_p                    := ri.hval_100k_p;
	c_hval_125k_p                    := ri.hval_125k_p;
	c_hval_150k_p                    := ri.hval_150k_p;
	c_hval_175k_p                    := ri.hval_175k_p;
	c_hval_200k_p                    := ri.hval_200k_p;
	c_hval_20k_p                     := ri.hval_20k_p;
	c_hval_250k_p                    := ri.hval_250k_p;
	c_hval_300k_p                    := ri.hval_300k_p;
	c_hval_400k_p                    := ri.hval_400k_p;
	c_hval_40k_p                     := ri.hval_40k_p;
	c_hval_500k_p                    := ri.hval_500k_p;
	c_hval_60k_p                     := ri.hval_60k_p;
	c_hval_750k_p                    := ri.hval_750k_p;
	c_hval_80k_p                     := ri.hval_80k_p;
	c_inc_100k_p                     := ri.in100k_p;
	c_inc_125k_p                     := ri.in125k_p;
	c_inc_150k_p                     := ri.in150k_p;
	c_inc_15k_p                      := ri.in15k_p;
	c_inc_200k_p                     := ri.in200k_p;
	c_inc_201k_p                     := ri.in201k_p;
	c_inc_25k_p                      := ri.in25k_p;
	c_inc_35k_p                      := ri.in35k_p;
	c_inc_50k_p                      := ri.in50k_p;
	c_inc_75k_p                      := ri.in75k_p;
	c_incollege                      := ri.incollege;
	c_info                           := ri.info;
	c_lar_fam                        := ri.lar_fam;
	c_larceny                        := ri.larceny;
	c_low_ed                         := ri.low_ed;
	c_low_hval                       := ri.low_hval;
	c_lowinc                         := ri.lowinc;
	c_lowrent                        := ri.lowrent;
	c_lux_prod                       := ri.lux_prod;
	c_manufacturing                  := ri.manufacturing;
	c_many_cars                      := ri.many_cars;
	c_med_age                        := ri.med_age;
	c_med_hhinc                      := ri.med_hhinc;
	c_med_hval                       := ri.med_hval;
	c_med_inc                        := ri.med_inc;
	c_med_rent                       := ri.med_rent;
	c_med_yearblt                    := ri.med_yearblt;
	c_medi_indx                      := ri.medi_indx;
	c_mil_emp                        := ri.mil_emp;
	c_mining                         := ri.mining;
	c_mort_indx                      := ri.mort_indx;
	c_murders                        := ri.murders;
	c_new_homes                      := ri.new_homes;
	c_newhouse                       := ri.newhouse;
	c_no_car                         := ri.no_car;
	c_no_labfor                      := ri.no_labfor;
	c_no_move                        := ri.no_move;
	c_no_teens                       := ri.no_teens;
	c_occunit_p                      := ri.occunit_p;
	c_old_homes                      := ri.old_homes;
	c_oldhouse                       := ri.oldhouse;
	c_ownocc_p                       := ri.ownocp;
	c_pop00                          := ri.pop00;
	c_pop_0_5_p                      := ri.pop_0_5_p;
	c_pop_12_17_p                    := ri.pop_12_17_p;
	c_pop_18_24_p                    := ri.pop_18_24_p;
	c_pop_25_34_p                    := ri.pop_25_34_p;
	c_pop_35_44_p                    := ri.pop_35_44_p;
	c_pop_45_54_p                    := ri.pop_45_54_p;
	c_pop_55_64_p                    := ri.pop_55_64_p;
	c_pop_65_74_p                    := ri.pop_65_74_p;
	c_pop_6_11_p                     := ri.pop_6_11_p;
	c_pop_75_84_p                    := ri.pop_75_84_p;
	c_pop_85p_p                      := ri.pop_85p_p;
	c_popover18                      := ri.popover18;
	c_popover25                      := ri.popover25;
	c_preschl                        := ri.preschl;
	c_professional                   := ri.professional;
	c_rape                           := ri.rape;
	c_relig_indx                     := ri.relig_indx;
	c_rental                         := ri.rental;
	c_rentocc_p                      := ri.rentocp;
	c_rest_indx                      := ri.rest_indx;
	c_retail                         := ri.retail;
	c_retired                        := ri.retired;
	c_retired2                       := ri.retired2;
	c_rich_asian                     := ri.rich_asian;
	c_rich_blk                       := ri.rich_blk;
	c_rich_fam                       := ri.rich_fam;
	c_rich_hisp                      := ri.rich_hisp;
	c_rich_nfam                      := ri.rich_nfam;
	c_rich_old                       := ri.rich_old;
	c_rich_wht                       := ri.rich_wht;
	c_rich_young                     := ri.rich_young;
	c_rnt1000_p                      := ri.rnt1000_p;
	c_rnt1250_p                      := ri.rnt1250_p;
	c_rnt1500_p                      := ri.rnt1500_p;
	c_rnt2000_p                      := ri.rnt2000_p;
	c_rnt2001_p                      := ri.rnt2001_p;
	c_rnt250_p                       := ri.rnt250_p;
	c_rnt500_p                       := ri.rnt500_p;
	c_rnt750_p                       := ri.rnt750_p;
	c_robbery                        := ri.robbery;
	c_rural_p                        := ri.rural_p;
	c_serv_empl                      := ri.serv_empl;
	c_sfdu_p                         := ri.sfdu_p;
	c_span_lang                      := ri.span_lang;
	c_sub_bus                        := ri.sub_bus;
	c_totcrime                       := ri.totcrime;
	c_totsales                       := ri.totsales;
	c_trailer                        := ri.trailer;
	c_trailer_p                      := ri.trailer_p;
	c_transport                      := ri.transport;
	c_unattach                       := ri.unattach;
	c_unemp                          := ri.unemp;
	c_unempl                         := ri.unempl;
	c_urban_p                        := ri.urban_p;
	c_vacant_p                       := ri.vacant_p;
	c_very_rich                      := ri.very_rich;
	c_white_col                      := ri.white_col;
	c_wholesale                      := ri.wholesale;
	c_work_home                      := ri.work_home;
	c_young                          := ri.young;



NULL :=__common__( -999999999);

INTEGER contains_i( string haystack, string needle ) :=__common__( (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0));

sysdate :=__common__( common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01')));

ssnpop :=__common__( ssnlength > 0);

	ver_src_ds :=__common__( Models.Common.findw_cpp(ver_sources, 'DS' , ', ', 'E') > 0);

	ver_src_eq :=__common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E') > 0);

	ver_src_en :=__common__( Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E') > 0);

	ver_src_tn :=__common__( Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E') > 0);

	ver_src_tu :=__common__( Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E') > 0);

	ver_src_cnt :=__common__( Models.Common.countw((string)(StringLib.StringToUpperCase(trim(ver_sources, ALL))), ','));//ver_src_cnt := sum(if(ver_sources = NULL, 0, 1), if(',' = NULL, 0, 1));

credit_source_cnt :=__common__( if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu)));

bureauonly2 :=__common__( credit_source_cnt > 0 and credit_source_cnt = ver_src_cnt and (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])));

_derog :=__common__( felony_count > 0 or addrs_prison_history or attr_num_unrel_liens60 > 0 or attr_eviction_count > 0 or impulse_count > 0);

fp_segment_1 :=__common__( map(
    not ssnpop		                                                                => '0 No SSN         ',
    ver_src_ds or rc_decsflag = '1' or rc_ssndobflag = '1' or rc_pwssndobflag = '1' => '1 SSN Prob       ',
    (nas_summary in [4, 7, 9])                                                    => '2 NAS 479        ',
    nap_summary <= 4 and nas_summary <= 4 or ver_src_cnt = 0                      => '3 New DID        ',
    bureauonly2                                                                   => '4 Bureau Only    ',
    _derog                                                                        => '5 Derog          ',
    Inq_count03 > 0                                                               => '6 Recent Activity',
                                                                                     '7 Other          '));

add_input_pop :=__common__( add1_pop);

add_input_advo_vacancy :=__common__( add1_advo_address_vacancy);

add_input_advo_dnd :=__common__( add1_advo_dnd);

add_curr_pop :=__common__( if(add1_isbestmatch, add1_pop, add2_pop));

add_curr_advo_vacancy :=__common__( if(add1_isbestmatch, add1_advo_address_vacancy, add2_advo_address_vacancy));

add_input_address_score :=__common__( if(add1_isbestmatch, add1_address_score, add2_address_score));

add_curr_naprop :=__common__( if(add1_isbestmatch, add1_naprop, add2_naprop));

add_input_avm_auto_val :=__common__( add1_avm_automated_valuation);

add_curr_avm_auto_val :=__common__( if(add1_isbestmatch, add1_avm_automated_valuation, add2_avm_automated_valuation));

add_curr_lres :=__common__( if(add1_isbestmatch, add1_lres, add2_lres));

add_curr_avm_auto_val_2 :=__common__( if(add1_isbestmatch, add1_avm_automated_valuation_2, add2_avm_automated_valuation_2));

add_input_naprop :=__common__( add1_naprop);

add_prev_naprop :=__common__( if(add1_isbestmatch, add2_naprop, add3_naprop));

college_file_type :=__common__( ams_file_type);

adls_per_addr_curr :=__common__( if(add1_isbestmatch, adls_per_addr, -1));

phones_per_addr_curr :=__common__( if(add1_isbestmatch, phones_per_addr, -1));

util_add_input_type_list :=__common__( util_add1_type_list);

util_add_curr_type_list :=__common__( if(add1_isbestmatch, util_add1_type_list, util_add2_type_list));

add_input_occupants_1yr :=__common__( add1_occupants_1yr);

add_input_turnover_1yr_in :=__common__( add1_turnover_1yr_in);

add_input_turnover_1yr_out :=__common__( add1_turnover_1yr_in);

add_input_nhood_bus_ct :=__common__( add1_Nhood_Business_count);

add_input_nhood_sfd_ct :=__common__( add1_Nhood_SFD_count);

add_input_nhood_mfd_ct :=__common__( add1_Nhood_MFD_count);

add_input_nhood_vac_prop :=__common__( add1_Nhood_Vacant_Properties);

add_curr_occupants_1yr :=__common__( if(add1_isbestmatch, add1_occupants_1yr, add2_occupants_1yr));

add_curr_turnover_1yr_in :=__common__( if(add1_isbestmatch, add1_turnover_1yr_in, add2_turnover_1yr_in));

add_curr_turnover_1yr_out :=__common__( if(add1_isbestmatch, add1_turnover_1yr_in, add2_turnover_1yr_in));

add_curr_nhood_bus_ct :=__common__( if(add1_isbestmatch, add1_Nhood_Business_count, add2_Nhood_Business_count));

add_curr_nhood_sfd_ct :=__common__( if(add1_isbestmatch, add1_Nhood_SFD_count, add2_Nhood_SFD_count));

add_curr_nhood_mfd_ct :=__common__( if(add1_isbestmatch, add1_Nhood_MFD_count, add2_Nhood_MFD_count));

add_curr_nhood_vac_prop :=__common__( if(add1_isbestmatch, add1_Nhood_Vacant_Properties, add2_Nhood_Vacant_Properties));

college_income_level_code :=__common__( ams_income_level_code);

adls_per_ssn :=__common__( adlperssn_count);

r_nas_addr_verd_d_1 :=__common__( (nas_summary in [3, 5, 6, 8, 10, 11, 12]));

c_nap_phn_verd_d_1 :=__common__( (nap_summary in [4, 6, 7, 9, 10, 11, 12]));

c_nap_addr_verd_d_1 :=__common__( (nap_summary in [3, 5, 6, 8, 10, 11, 12]));

c_nap_lname_verd_d_1 :=__common__( (nap_summary in [2, 5, 7, 8, 9, 11, 12]));

c_nap_fname_verd_d_1 :=__common__( (nap_summary in [2, 3, 4, 8, 9, 10, 12]));

c_nap_contradictory_i_1 :=__common__( (nap_summary in [1]));

c_inf_phn_verd_d_1 :=__common__( (infutor_nap in [4, 6, 7, 9, 10, 11, 12]));

c_inf_addr_verd_d_1 :=__common__( (infutor_nap in [3, 5, 6, 8, 10, 11, 12]));

c_inf_lname_verd_d_1 :=__common__( (infutor_nap in [2, 5, 7, 8, 9, 11, 12]));

c_inf_fname_verd_d_1 :=__common__( (infutor_nap in [2, 3, 4, 8, 9, 10, 12]));

c_inf_nothing_found_i_1 :=__common__( (infutor_nap in [0]));

c_inf_contradictory_i_1 :=__common__( (infutor_nap in [1]));

r_c16_inv_ssn_per_adl_i :=__common__( if(not(truedid), NULL, min(if(invalid_ssns_per_adl = NULL, -NULL, invalid_ssns_per_adl), 999)));

r_inv_ssn_per_adl_c6_i :=__common__( if(not(truedid), NULL, min(if(invalid_ssns_per_adl_c6 = NULL, -NULL, invalid_ssns_per_adl_c6), 999)));

r_addr_not_ver_w_ssn_i :=__common__( if(not(truedid and ssnlength > 0), NULL, (integer)(nas_summary in [4, 7, 9])));

r_s65_ssn_problem_i_1 :=__common__( map(
    not(ssnlength > 0)                                                                                                                                                                                                                                                => NULL,
    dobpop and (rc_ssndobflag = '1' or rc_pwssndobflag = '1') or truedid and invalid_ssns_per_adl >= 2 or truedid and invalid_ssns_per_adl_c6 >= 1                                                                                                                        => 2,
    rc_decsflag = '1' or contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 or rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) or truedid and invalid_ssns_per_adl >= 1                          => 1,
    rc_decsflag = '0' or dobpop and (rc_ssndobflag = '0' or rc_pwssndobflag = '0') or rc_ssnvalflag = '0' or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) or truedid and invalid_ssns_per_adl = 0 or truedid and invalid_ssns_per_adl_c6 = 0 => 0,
                                                                                                                                                                                                                                                                         NULL));

r_p88_phn_dst_to_inp_add_i :=__common__( if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr));

r_phn_cell_n_2 :=__common__( if(not(hphnpop), NULL, NULL));

r_phn_cell_n_1 :=__common__( if(rc_hriskphoneflag = '1' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '1' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '04' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '55' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '60', 1, 0));

r_phn_pcs_n :=__common__( map(
    not(hphnpop)                                                                                                                                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = '3' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '3' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '64' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '65' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '66' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '67' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '68' => 1,
                                                                                                                                                                                                                                                                                                                                                                               0));

r_l70_add_invalid_i :=__common__( map(
    not(addrpop)                                        => NULL,
    trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N' => 1,
                                                           0));

r_l72_add_vacant_i :=__common__( map(
    not(add_input_pop)                                          => NULL,
    trim(trim(add_input_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                   0));

add_ec1 :=__common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

add_ec3 :=__common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3]);

add_ec4 :=__common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4]);

r_l70_add_standardized_i :=__common__( map(
    not(addrpop)                                         => NULL,
    trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E'         => 2,
    add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => 1,
                                                            0));

r_l70_inp_addr_dnd_i :=__common__( map(
    not(add_input_pop)        => NULL,
    add_input_advo_dnd = ''	 	=> NULL,
                                 (integer)(add_input_advo_dnd = 'Y')));

r_l72_add_curr_vacant_i :=__common__( map(
    not((boolean)(integer)add_curr_pop)                                => NULL,
    trim(trim((string)add_curr_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                          0));

r_f03_input_add_not_most_rec_i :=__common__( if(not(truedid and add_input_pop), NULL, (integer)rc_input_addr_not_most_recent));

r_c18_inv_add_per_adl_c6_i :=__common__( if(not(truedid), NULL, min(if(invalid_addrs_per_adl_c6 = NULL, -NULL, invalid_addrs_per_adl_c6), 999)));

r_l77_apartment_i :=__common__( map(
    not(addrpop)                                                                                                                                                                                         => NULL,
    StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = '') => 1,
                                                                                                                                                                                                            0));

r_f00_dob_score_d :=__common__( if(not(truedid and dobpop) or combo_dobscore = 255, NULL, min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 999)));

r_f01_inp_addr_address_score_d :=__common__( if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999)));

r_f00_input_dob_match_level_d :=__common__( if(not(truedid and dobpop), NULL, (integer)input_dob_match_level));

r_d30_derog_count_i :=__common__( if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999)));

r_d32_criminal_count_i :=__common__( if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999)));

r_d32_felony_count_i :=__common__( if(not(truedid), NULL, min(if(felony_count = NULL, -NULL, felony_count), 999)));

_criminal_last_date :=__common__( common.sas_date((string)(criminal_last_date)));

r_d32_mos_since_crim_ls_d :=__common__( map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => 241,
                                  max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240))));

_felony_last_date :=__common__( common.sas_date((string)(felony_last_date)));

r_d32_mos_since_fel_ls_d :=__common__( map(
    not(truedid)             => NULL,
    _felony_last_date = NULL => 241,
                                max(3, min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240))));

r_d31_mostrec_bk_i :=__common__( map(
    not(truedid)                     => NULL,
    StringLib.StringToUpperCase(TRIM(disposition[1..7]))  = 'DISMISS'  => 1,
    StringLib.StringToUpperCase(TRIM(disposition[1..8])) = 'DISCHARG' => 2,
    bankrupt or filing_count > 0 => 3,
                                        0));

r_d31_attr_bankruptcy_recency_d :=__common__( map(
    not(truedid)             => NULL,
    attr_bankruptcy_count30 >0 => 1,
    attr_bankruptcy_count90 >0  => 3,
    attr_bankruptcy_count180 >0 => 6,
    attr_bankruptcy_count12 >0  => 12,
    attr_bankruptcy_count24 >0  => 24,
    attr_bankruptcy_count36 >0  => 36,
    attr_bankruptcy_count60 >0  => 60,
    bankrupt                	  => 99,
    filing_count > 0         => 99,
                                0));

r_d31_bk_filing_count_i :=__common__( if(not(truedid), NULL, min(if(filing_count = NULL, -NULL, filing_count), 999)));

r_d31_bk_disposed_recent_count_i :=__common__( if(not(truedid), NULL, min(if(bk_disposed_recent_count = NULL, -NULL, bk_disposed_recent_count), 999)));

r_d33_eviction_recency_d :=__common__( map(
    not(truedid)             => NULL,
    attr_eviction_count90    >0 => 3,
    attr_eviction_count180   >0 => 6,
    attr_eviction_count12    >0 => 12,
    attr_eviction_count24    >0 => 24,
    attr_eviction_count36    >0 => 36,
    attr_eviction_count60    >0 => 60,
    attr_eviction_count >= 1 => 99,
                                999));

r_d33_eviction_count_i :=__common__( if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999)));

r_d34_unrel_liens_ct_i :=__common__( if(not(truedid), NULL, min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 999)));

r_d34_unrel_lien60_count_i :=__common__( if(not(truedid), NULL, min(if(attr_num_unrel_liens60 = NULL, -NULL, attr_num_unrel_liens60), 999)));

bureau_adl_eq_fseen_pos_2 :=__common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq_2 :=__common__( if(bureau_adl_eq_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_2, ',')));

_bureau_adl_fseen_eq_2 :=__common__( common.sas_date((string)(bureau_adl_fseen_eq_2)));

_src_bureau_adl_fseen :=__common__( min(if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), 999999));

r_c21_m_bureau_adl_fs_d :=__common__( map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => 1000,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999)));

bureau_adl_eq_fseen_pos_1 :=__common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq_1 :=__common__( if(bureau_adl_eq_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_1, ',')));

_bureau_adl_fseen_eq_1 :=__common__( common.sas_date((string)(bureau_adl_fseen_eq_1)));

bureau_adl_en_fseen_pos_1 :=__common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E'));

bureau_adl_fseen_en_1 :=__common__( if(bureau_adl_en_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_1, ',')));

_bureau_adl_fseen_en_1 :=__common__( common.sas_date((string)(bureau_adl_fseen_en_1)));

bureau_adl_ts_fseen_pos_1 :=__common__( Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E'));

bureau_adl_fseen_ts_1 :=__common__( if(bureau_adl_ts_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_1, ',')));

_bureau_adl_fseen_ts_1 :=__common__( common.sas_date((string)(bureau_adl_fseen_ts_1)));

bureau_adl_tu_fseen_pos_1 :=__common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E'));

bureau_adl_fseen_tu_1 :=__common__( if(bureau_adl_tu_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_1, ',')));

_bureau_adl_fseen_tu_1 :=__common__( common.sas_date((string)(bureau_adl_fseen_tu_1)));

bureau_adl_tn_fseen_pos_1 :=__common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E'));

bureau_adl_fseen_tn_1 :=__common__( if(bureau_adl_tn_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_1, ',')));

_bureau_adl_fseen_tn_1 :=__common__( common.sas_date((string)(bureau_adl_fseen_tn_1)));

_src_bureau_adl_fseen_all :=__common__( min(if(_bureau_adl_fseen_tn_1 = NULL, -NULL, _bureau_adl_fseen_tn_1), if(_bureau_adl_fseen_ts_1 = NULL, -NULL, _bureau_adl_fseen_ts_1), if(_bureau_adl_fseen_tu_1 = NULL, -NULL, _bureau_adl_fseen_tu_1), if(_bureau_adl_fseen_en_1 = NULL, -NULL, _bureau_adl_fseen_en_1), if(_bureau_adl_fseen_eq_1 = NULL, -NULL, _bureau_adl_fseen_eq_1), 999999));

f_m_bureau_adl_fs_all_d :=__common__( map(
    not(truedid)                       => NULL,
    _src_bureau_adl_fseen_all = 999999 => 1000,
                                          min(if(if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)))), 999)));

bureau_adl_eq_fseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq :=__common__( if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ',')));

_bureau_adl_fseen_eq :=__common__( common.sas_date((string)(bureau_adl_fseen_eq)));

bureau_adl_en_fseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E'));

bureau_adl_fseen_en :=__common__( if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ',')));

_bureau_adl_fseen_en :=__common__( common.sas_date((string)(bureau_adl_fseen_en)));

bureau_adl_ts_fseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E'));

bureau_adl_fseen_ts :=__common__( if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ',')));

_bureau_adl_fseen_ts :=__common__( common.sas_date((string)(bureau_adl_fseen_ts)));

bureau_adl_tu_fseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E'));

bureau_adl_fseen_tu :=__common__( if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ',')));

_bureau_adl_fseen_tu :=__common__( common.sas_date((string)(bureau_adl_fseen_tu)));

bureau_adl_tn_fseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E'));

bureau_adl_fseen_tn :=__common__( if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ',')));

_bureau_adl_fseen_tn :=__common__( common.sas_date((string)(bureau_adl_fseen_tn)));

_src_bureau_adl_fseen_notu :=__common__( min(if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999));

f_m_bureau_adl_fs_notu_d :=__common__( map(
    not(truedid)                        => NULL,
    _src_bureau_adl_fseen_notu = 999999 => 1000,
                                           min(if(if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))), 999)));

_header_first_seen :=__common__( common.sas_date((string)(header_first_seen)));

r_c10_m_hdr_fs_d :=__common__( map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => 1000,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999)));

r_c12_num_nonderogs_d :=__common__( if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 999)));

r_c15_ssns_per_adl_i :=__common__( map(
    not(truedid)             => NULL,
    ssns_per_adl = 0         => 2,
    (ssns_per_adl in [1, 2]) => 1,
                                min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 999)));

r_c15_ssns_per_adl_c6_i_1 :=__common__( map(
    not(truedid)        => NULL,
    ssns_per_adl_c6 = 0 => 1,
                           min(if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6), 999)));

r_s66_adlperssn_count_i_1 :=__common__( map(
    not(ssnlength > 0) => NULL,
    adls_per_ssn = 0   => 1,
                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999)));

_in_dob :=__common__( common.sas_date((string)(in_dob)));

yr_in_dob :=__common__( if(_in_dob = NULL, NULL, (sysdate - _in_dob) / 365.25));

yr_in_dob_int :=__common__( if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob)));

c_comb_age_d_1 :=__common__( map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL));

r_a44_curr_add_naprop_d :=__common__( if(not(truedid and (boolean)(integer)add_curr_pop), NULL, add_curr_naprop));

r_l80_inp_avm_autoval_d :=__common__( map(
    not(add_input_pop)         => NULL,
    add_input_avm_auto_val = 0 => NULL,
                                  min(if(add_input_avm_auto_val = NULL, -NULL, add_input_avm_auto_val), 300000)));

r_a46_curr_avm_autoval_d :=__common__( map(
    not(truedid)              => NULL,
    add_curr_avm_auto_val = 0 => NULL,
                                 min(if(add_curr_avm_auto_val = NULL, -NULL, add_curr_avm_auto_val), 300000)));

r_a49_curr_avm_chg_1yr_i :=__common__( map(
    not(truedid)                                              => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
                                                                 NULL));

r_a49_curr_avm_chg_1yr_pct_i :=__common__( map(
    not(truedid)                                              => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
                                                                 NULL));

r_c13_curr_addr_lres_d :=__common__( if(not(truedid and (boolean)(integer)add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999)));

r_c14_addr_stability_v2_d :=__common__( map(
    not(truedid)          => NULL,
    addr_stability_v2 = '0' => NULL,
                             (integer)addr_stability_v2));

r_c13_max_lres_d_1 :=__common__( if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999)));

r_c14_addrs_5yr_i :=__common__( if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999)));

r_c14_addrs_10yr_i :=__common__( if(not(truedid), NULL, min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999)));

r_c14_addrs_per_adl_c6_i :=__common__( if(not(truedid), NULL, min(if(addrs_per_adl_c6 = NULL, -NULL, addrs_per_adl_c6), 999)));

r_c14_addrs_15yr_i :=__common__( if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999)));

r_a41_prop_owner_inp_only_d :=__common__( map(
    not(truedid)                                => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 => 1,
                                                   0));

r_prop_owner_history_d :=__common__( map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0));

r_ever_asset_owner_d :=__common__( map(
    not(truedid)                                                                                                                                                                                                 => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 or watercraft_count > 0 or attr_num_aircraft > 0 => 1,
                                                                                                                                                                                                                    0));

r_c20_email_count_i :=__common__( if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999)));

r_c20_email_domain_free_count_i :=__common__( if(not(truedid), NULL, min(if(email_domain_free_count = NULL, -NULL, email_domain_free_count), 999)));

r_c20_email_domain_isp_count_i :=__common__( if(not(truedid), NULL, min(if(email_domain_ISP_count = NULL, -NULL, email_domain_ISP_count), 999)));

r_l79_adls_per_addr_curr_i :=__common__( if(not(addrpop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

r_c15_ssns_per_adl_c6_i :=__common__( if(not(truedid), NULL, min(if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6), 999)));

r_l79_adls_per_addr_c6_i :=__common__( if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999)));

r_c18_invalid_addrs_per_adl_i :=__common__( if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999)));

r_has_pb_record_d_1 :=__common__( if((integer)pb_number_of_sources > 0, 1, 0));

r_a50_pb_average_dollars_d :=__common__( map(
    not(truedid)              => NULL,
    pb_average_dollars = '' => 5000,
                                 min(if(pb_average_dollars = '', -NULL, (integer)pb_average_dollars), 5000)));

r_a50_pb_total_dollars_d :=__common__( map(
    not(truedid)            => NULL,
    pb_total_dollars = '' => 10001,
                               min(if(pb_total_dollars = '', -NULL, (integer)pb_total_dollars), 10000)));

r_a50_pb_total_orders_d :=__common__( map(
    not(truedid)           => NULL,
    pb_total_orders = '' => -1,
                              (integer)pb_total_orders));

r_pb_order_freq_d :=__common__( map(
    not(truedid)                     => NULL,
    pb_number_of_sources = ''      => NULL,
    pb_average_days_bt_orders = '' => -1,
                                        min(if(pb_average_days_bt_orders = '', -NULL, (integer)pb_average_days_bt_orders), 999)));

r_l78_no_phone_at_addr_vel_i :=__common__( map(
    not(addrpop)             => NULL,
    phones_per_addr_curr = 0 => 1,
                                0));

r_i60_inq_count12_i :=__common__( if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999)));

r_i60_credit_seeking_i :=__common__( if(not(truedid), NULL, if(max(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)), min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)), min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)), min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)), min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)) = NULL, 0, min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03))), if(min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)) = NULL, 0, min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03))), if(min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)) = NULL, 0, min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03))), if(min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)) = NULL, 0, min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03))), if(min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)) = NULL, 0, min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)))))));

r_i60_inq_recency_d :=__common__( map(
    not(truedid) => NULL,
    inq_count01  >0 => 1,
    inq_count03  >0 => 3,
    inq_count06  >0 => 6,
    inq_count12  >0 => 12,
    inq_count24  >0 => 24,
    inq_count    >0 => 99,
                    999));

r_i61_inq_collection_count12_i :=__common__( if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999)));

r_i61_inq_collection_recency_d :=__common__( map(
    not(truedid)           => NULL,
    inq_collection_count01 >0 => 1,
    inq_collection_count03 >0 => 3,
    inq_collection_count06 >0 => 6,
    inq_collection_count12 >0 => 12,
    inq_collection_count24 >0 => 24,
    inq_collection_count   >0 => 99,
                              999));

r_i60_inq_auto_count12_i :=__common__( if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999)));

r_i60_inq_auto_recency_d :=__common__( map(
    not(truedid)     => NULL,
    inq_auto_count01 >0 => 1,
    inq_auto_count03 >0 => 3,
    inq_auto_count06 >0 => 6,
    inq_auto_count12 >0 => 12,
    inq_auto_count24 >0 => 24,
    inq_auto_count   >0 => 99,
                        999));

r_i60_inq_banking_count12_i :=__common__( if(not(truedid), NULL, min(if(inq_banking_count12 = NULL, -NULL, inq_banking_count12), 999)));

r_i60_inq_banking_recency_d :=__common__( map(
    not(truedid)        => NULL,
    inq_banking_count01 >0 => 1,
    inq_banking_count03 >0 => 3,
    inq_banking_count06 >0 => 6,
    inq_banking_count12 >0 => 12,
    inq_banking_count24 >0 => 24,
    inq_banking_count   >0 => 99,
                           999));

r_i60_inq_mortgage_recency_d :=__common__( map(
    not(truedid)         => NULL,
    inq_mortgage_count01 >0 => 1,
    inq_mortgage_count03 >0 => 3,
    inq_mortgage_count06 >0 => 6,
    inq_mortgage_count12 >0 => 12,
    inq_mortgage_count24 >0 => 24,
    inq_mortgage_count   >0 => 99,
                            999));

r_i60_inq_hiriskcred_count12_i :=__common__( if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999)));

r_i60_inq_hiriskcred_recency_d :=__common__( map(
    not(truedid)               => NULL,
    inq_highRiskCredit_count01 >0 => 1,
    inq_highRiskCredit_count03 >0 => 3,
    inq_highRiskCredit_count06 >0 => 6,
    inq_highRiskCredit_count12 >0 => 12,
    inq_highRiskCredit_count24 >0 => 24,
    inq_highRiskCredit_count   >0 => 99,
                                  999));

r_i60_inq_retail_count12_i :=__common__( if(not(truedid), NULL, min(if(inq_retail_count12 = NULL, -NULL, inq_retail_count12), 999)));

r_i60_inq_retail_recency_d :=__common__( map(
    not(truedid)       => NULL,
    inq_retail_count01 >0 => 1,
    inq_retail_count03 >0 => 3,
    inq_retail_count06 >0 => 6,
    inq_retail_count12 >0 => 12,
    inq_retail_count24 >0 => 24,
    inq_retail_count   >0 => 99,
                          999));

r_i60_inq_comm_count12_i :=__common__( if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999)));

r_i60_inq_comm_recency_d :=__common__( map(
    not(truedid)               => NULL,
    inq_communications_count01 >0 => 1,
    inq_communications_count03 >0 => 3,
    inq_communications_count06 >0 => 6,
    inq_communications_count12 >0 => 12,
    inq_communications_count24 >0 => 24,
    inq_communications_count   >0 => 99,
                                  999));

f_bus_fname_verd_d :=__common__( if(not(addrpop), NULL, (integer)(bus_name_match in [2, 4])));

f_bus_lname_verd_d :=__common__( if(not(addrpop), NULL, (integer)(bus_name_match in [3, 4])));

f_bus_name_nover_i :=__common__( if(not(addrpop), NULL, (integer)(bus_name_match = 1)));

f_adl_util_inf_n_1 :=__common__( if(contains_i(util_adl_type_list, '1') > 0, 1, 0));

f_adl_util_conv_n_1 :=__common__( if(contains_i(util_adl_type_list, '2') > 0, 1, 0));

f_adl_util_misc_n_1 :=__common__( if(contains_i(StringLib.StringToUpperCase(util_adl_type_list), 'Z') > 0, 1, 0));

f_util_adl_count_n :=__common__( if(not(truedid), NULL, util_adl_count));

f_util_add_input_conv_n_1 :=__common__( if(contains_i(util_add_input_type_list, '2') > 0, 1, 0));

f_util_add_input_misc_n_1 :=__common__( if(contains_i(StringLib.StringToUpperCase(util_add_input_type_list), 'Z') > 0, 1, 0));

f_util_add_curr_inf_n_1 :=__common__( if(contains_i(util_add_curr_type_list, '1') > 0, 1, 0));

f_util_add_curr_misc_n_1 :=__common__( if(contains_i(StringLib.StringToUpperCase(util_add_curr_type_list), 'Z') > 0, 1, 0));

add_input_nhood_prop_sum_3 :=__common__( if(max(add_input_nhood_bus_ct, add_input_nhood_sfd_ct, add_input_nhood_mfd_ct) = NULL, NULL, sum(if(add_input_nhood_bus_ct = NULL, 0, add_input_nhood_bus_ct), if(add_input_nhood_sfd_ct = NULL, 0, add_input_nhood_sfd_ct), if(add_input_nhood_mfd_ct = NULL, 0, add_input_nhood_mfd_ct))));

f_add_input_nhood_bus_pct_i :=__common__( map(
    not(addrpop)               => NULL,
    add_input_nhood_bus_ct = 0 => NULL,
                                  add_input_nhood_bus_ct / add_input_nhood_prop_sum_3));

f_add_input_has_mfd_ct_i_1 :=__common__( if(add_input_nhood_mfd_ct = 0, 0, 1));

add_input_nhood_prop_sum_2 :=__common__( if(max(add_input_nhood_bus_ct, add_input_nhood_sfd_ct, add_input_nhood_mfd_ct) = NULL, NULL, sum(if(add_input_nhood_bus_ct = NULL, 0, add_input_nhood_bus_ct), if(add_input_nhood_sfd_ct = NULL, 0, add_input_nhood_sfd_ct), if(add_input_nhood_mfd_ct = NULL, 0, add_input_nhood_mfd_ct))));

f_add_input_nhood_mfd_pct_i :=__common__( map(
    not(addrpop)               => NULL,
    add_input_nhood_mfd_ct = 0 => NULL,
                                  add_input_nhood_mfd_ct / add_input_nhood_prop_sum_2));

add_input_nhood_prop_sum_1 :=__common__( if(max(add_input_nhood_bus_ct, add_input_nhood_sfd_ct, add_input_nhood_mfd_ct) = NULL, NULL, sum(if(add_input_nhood_bus_ct = NULL, 0, add_input_nhood_bus_ct), if(add_input_nhood_sfd_ct = NULL, 0, add_input_nhood_sfd_ct), if(add_input_nhood_mfd_ct = NULL, 0, add_input_nhood_mfd_ct))));

f_add_input_nhood_sfd_pct_d :=__common__( map(
    not(addrpop)               => NULL,
    add_input_nhood_sfd_ct = 0 => -1,
                                  add_input_nhood_sfd_ct / add_input_nhood_prop_sum_1));

add_input_nhood_prop_sum :=__common__( if(max(add_input_nhood_bus_ct, add_input_nhood_sfd_ct, add_input_nhood_mfd_ct) = NULL, NULL, sum(if(add_input_nhood_bus_ct = NULL, 0, add_input_nhood_bus_ct), if(add_input_nhood_sfd_ct = NULL, 0, add_input_nhood_sfd_ct), if(add_input_nhood_mfd_ct = NULL, 0, add_input_nhood_mfd_ct))));

f_add_input_nhood_vac_pct_i :=__common__( map(
    not(addrpop)                 => NULL,
    add_input_nhood_prop_sum = 0 => -1,
                                    add_input_nhood_vac_prop / add_input_nhood_prop_sum));

add_curr_nhood_prop_sum_3 :=__common__( if(max(add_curr_nhood_bus_ct, add_curr_nhood_sfd_ct, add_curr_nhood_mfd_ct) = NULL, NULL, sum(if(add_curr_nhood_bus_ct = NULL, 0, add_curr_nhood_bus_ct), if(add_curr_nhood_sfd_ct = NULL, 0, add_curr_nhood_sfd_ct), if(add_curr_nhood_mfd_ct = NULL, 0, add_curr_nhood_mfd_ct))));

f_add_curr_nhood_bus_pct_i :=__common__( map(
    not(addrpop)              => NULL,
    add_curr_nhood_bus_ct = 0 => NULL,
                                 add_curr_nhood_bus_ct / add_curr_nhood_prop_sum_3));

f_add_curr_has_mfd_ct_i_1 :=__common__( if(add_curr_nhood_mfd_ct = 0, 0, 1));

add_curr_nhood_prop_sum_2 :=__common__( if(max(add_curr_nhood_bus_ct, add_curr_nhood_sfd_ct, add_curr_nhood_mfd_ct) = NULL, NULL, sum(if(add_curr_nhood_bus_ct = NULL, 0, add_curr_nhood_bus_ct), if(add_curr_nhood_sfd_ct = NULL, 0, add_curr_nhood_sfd_ct), if(add_curr_nhood_mfd_ct = NULL, 0, add_curr_nhood_mfd_ct))));

f_add_curr_nhood_mfd_pct_i :=__common__( map(
    not(addrpop)              => NULL,
    add_curr_nhood_mfd_ct = 0 => NULL,
                                 add_curr_nhood_mfd_ct / add_curr_nhood_prop_sum_2));

add_curr_nhood_prop_sum_1 :=__common__( if(max(add_curr_nhood_bus_ct, add_curr_nhood_sfd_ct, add_curr_nhood_mfd_ct) = NULL, NULL, sum(if(add_curr_nhood_bus_ct = NULL, 0, add_curr_nhood_bus_ct), if(add_curr_nhood_sfd_ct = NULL, 0, add_curr_nhood_sfd_ct), if(add_curr_nhood_mfd_ct = NULL, 0, add_curr_nhood_mfd_ct))));

f_add_curr_nhood_sfd_pct_d :=__common__( map(
    not(addrpop)              => NULL,
    add_curr_nhood_sfd_ct = 0 => -1,
                                 add_curr_nhood_sfd_ct / add_curr_nhood_prop_sum_1));

add_curr_nhood_prop_sum :=__common__( if(max(add_curr_nhood_bus_ct, add_curr_nhood_sfd_ct, add_curr_nhood_mfd_ct) = NULL, NULL, sum(if(add_curr_nhood_bus_ct = NULL, 0, add_curr_nhood_bus_ct), if(add_curr_nhood_sfd_ct = NULL, 0, add_curr_nhood_sfd_ct), if(add_curr_nhood_mfd_ct = NULL, 0, add_curr_nhood_mfd_ct))));

f_add_curr_nhood_vac_pct_i :=__common__( map(
    not(addrpop)                => NULL,
    add_curr_nhood_prop_sum = 0 => -1,
                                   add_curr_nhood_vac_prop / add_curr_nhood_prop_sum));

f_recent_disconnects_i :=__common__( if(not(hphnpop), NULL, min(if(recent_disconnects = NULL, -NULL, recent_disconnects), 999)));

f_inq_count24_i :=__common__( if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999)));

f_inq_auto_count24_i :=__common__( if(not(truedid), NULL, min(if(inq_Auto_count24 = NULL, -NULL, inq_Auto_count24), 999)));

f_inq_banking_count24_i :=__common__( if(not(truedid), NULL, min(if(inq_Banking_count24 = NULL, -NULL, inq_Banking_count24), 999)));

f_inq_collection_count24_i :=__common__( if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 999)));

f_inq_communications_count24_i :=__common__( if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999)));

f_inq_highriskcredit_count24_i :=__common__( if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999)));

f_inq_mortgage_count24_i :=__common__( if(not(truedid), NULL, min(if(inq_Mortgage_count24 = NULL, -NULL, inq_Mortgage_count24), 999)));

f_inq_other_count24_i :=__common__( if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999)));

f_inq_retail_count24_i :=__common__( if(not(truedid), NULL, min(if(inq_Retail_count24 = NULL, -NULL, inq_Retail_count24), 999)));

f_inq_per_ssn_i_1 :=__common__( if(not(ssnlength > 0), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999)));

f_inq_adls_per_ssn_i_1 :=__common__( if(not(ssnlength > 0), NULL, min(if(inq_adlsperssn = NULL, -NULL, inq_adlsperssn), 999)));

f_inq_lnames_per_ssn_i_1 :=__common__( if(not(ssnlength > 0), NULL, min(if(inq_lnamesperssn = NULL, -NULL, inq_lnamesperssn), 999)));

f_inq_addrs_per_ssn_i_1 :=__common__( if(not(ssnlength > 0), NULL, min(if(inq_addrsperssn = NULL, -NULL, inq_addrsperssn), 999)));

f_inq_dobs_per_ssn_i_1 :=__common__( if(not(ssnlength > 0), NULL, min(if(inq_dobsperssn = NULL, -NULL, inq_dobsperssn), 999)));

f_inq_per_addr_i :=__common__( if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)));

f_inq_adls_per_addr_i :=__common__( if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999)));

f_inq_lnames_per_addr_i :=__common__( if(not(addrpop), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999)));

f_inq_ssns_per_addr_i :=__common__( if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999)));

f_inq_per_phone_i :=__common__( if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999)));

f_inq_adls_per_phone_i :=__common__( if(not(hphnpop), NULL, min(if(inq_adlsperphone = NULL, -NULL, inq_adlsperphone), 999)));

_inq_banko_cm_first_seen :=__common__( common.sas_date((string)(Inq_banko_cm_first_seen)));

f_mos_inq_banko_cm_fseen_d :=__common__( map(
    not(truedid)                    => NULL,
    _inq_banko_cm_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)))), 999)));

_inq_banko_cm_last_seen :=__common__( common.sas_date((string)(Inq_banko_cm_last_seen)));

f_mos_inq_banko_cm_lseen_d :=__common__( map(
    not(truedid)                   => NULL,
    _inq_banko_cm_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)))), 999))));

_inq_banko_om_first_seen :=__common__( common.sas_date((string)(Inq_banko_om_first_seen)));

f_mos_inq_banko_om_fseen_d :=__common__( map(
    not(truedid)                    => NULL,
    _inq_banko_om_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)))), 999)));

_inq_banko_om_last_seen :=__common__( common.sas_date((string)(Inq_banko_om_last_seen)));

f_mos_inq_banko_om_lseen_d :=__common__( map(
    not(truedid)                   => NULL,
    _inq_banko_om_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)))), 999))));

f_attr_arrests_i :=__common__( if(not(truedid), NULL, min(if(attr_arrests = NULL, -NULL, attr_arrests), 999)));

f_attr_arrest_recency_d :=__common__( map(
    not(truedid)        => NULL,
    attr_arrests30 > 0  => 1,
    attr_arrests90 > 0  => 3,
    attr_arrests180 > 0 => 6,
    attr_arrests12 > 0  => 12,
    attr_arrests24 > 0  => 24,
    attr_arrests36 > 0  => 36,
    attr_arrests60 > 0  => 60,
    attr_arrests > 0    => 99,
                           100));

_liens_unrel_cj_first_seen :=__common__( common.sas_date((string)(liens_unrel_CJ_first_seen)));

f_mos_liens_unrel_cj_fseen_d :=__common__( map(
    not(truedid)                      => NULL,
    _liens_unrel_cj_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_cj_last_seen :=__common__( common.sas_date((string)(liens_unrel_CJ_last_seen)));

f_mos_liens_unrel_cj_lseen_d :=__common__( map(
    not(truedid)                     => NULL,
    _liens_unrel_cj_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)))), 999))));

f_liens_unrel_cj_total_amt_i :=__common__( if(not(truedid), NULL, liens_unrel_CJ_total_amount));

_liens_rel_cj_first_seen :=__common__( common.sas_date((string)(liens_rel_CJ_first_seen)));

f_mos_liens_rel_cj_fseen_d :=__common__( map(
    not(truedid)                    => NULL,
    _liens_rel_cj_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)))), 999)));

_liens_rel_cj_last_seen :=__common__( common.sas_date((string)(liens_rel_CJ_last_seen)));

f_mos_liens_rel_cj_lseen_d :=__common__( map(
    not(truedid)                   => NULL,
    _liens_rel_cj_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)))), 999))));

f_liens_rel_cj_total_amt_i :=__common__( if(not(truedid), NULL, liens_rel_CJ_total_amount));

_liens_unrel_ft_last_seen :=__common__( common.sas_date((string)(liens_unrel_FT_last_seen)));

f_mos_liens_unrel_ft_lseen_d :=__common__( map(
    not(truedid)                     => NULL,
    _liens_unrel_ft_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)))), 999))));

f_liens_unrel_ft_total_amt_i :=__common__( if(not(truedid), NULL, liens_unrel_FT_total_amount));

_liens_unrel_lt_first_seen :=__common__( common.sas_date((string)(liens_unrel_LT_first_seen)));

f_mos_liens_unrel_lt_fseen_d :=__common__( map(
    not(truedid)                      => NULL,
    _liens_unrel_lt_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_lt_last_seen :=__common__( common.sas_date((string)(liens_unrel_LT_last_seen)));

f_mos_liens_unrel_lt_lseen_d :=__common__( map(
    not(truedid)                     => NULL,
    _liens_unrel_lt_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12)))), 999))));

f_liens_unrel_o_total_amt_i :=__common__( if(not(truedid), NULL, liens_unrel_O_total_amount));

_liens_unrel_ot_first_seen :=__common__( common.sas_date((string)(liens_unrel_OT_first_seen)));

f_mos_liens_unrel_ot_fseen_d :=__common__( map(
    not(truedid)                      => NULL,
    _liens_unrel_ot_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_ot_last_seen :=__common__( common.sas_date((string)(liens_unrel_OT_last_seen)));

f_mos_liens_unrel_ot_lseen_d :=__common__( map(
    not(truedid)                     => NULL,
    _liens_unrel_ot_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)))), 999))));

f_liens_unrel_ot_total_amt_i :=__common__( if(not(truedid), NULL, liens_unrel_OT_total_amount));

_liens_rel_ot_first_seen :=__common__( common.sas_date((string)(liens_rel_OT_first_seen)));

f_mos_liens_rel_ot_fseen_d :=__common__( map(
    not(truedid)                    => NULL,
    _liens_rel_ot_first_seen = NULL => -1,
                                       min(if(if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)))), 999)));

_liens_rel_ot_last_seen :=__common__( common.sas_date((string)(liens_rel_OT_last_seen)));

f_mos_liens_rel_ot_lseen_d :=__common__( map(
    not(truedid)                   => NULL,
    _liens_rel_ot_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)))), 999))));

_liens_unrel_sc_first_seen :=__common__( common.sas_date((string)(liens_unrel_SC_first_seen)));

f_mos_liens_unrel_sc_fseen_d :=__common__( map(
    not(truedid)                      => NULL,
    _liens_unrel_sc_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)))), 999)));

f_liens_unrel_sc_total_amt_i :=__common__( if(not(truedid), NULL, liens_unrel_SC_total_amount));

f_estimated_income_d :=__common__( if(not(truedid), NULL, estimated_income));

f_wealth_index_d :=__common__( if(not(truedid), NULL, (integer)wealth_index));

f_college_income_d :=__common__( map(
    not(truedid)                     => NULL,
    college_income_level_code = '' => NULL,
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
                                        NULL));

f_rel_count_i :=__common__( if(not(truedid), NULL, min(if(rel_count = NULL, -NULL, rel_count), 999)));

f_rel_incomeover25_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count, rel_incomeunder50_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count)))));

f_rel_incomeover50_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count)))));

f_rel_incomeover75_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count)))));

f_rel_incomeover100_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_incomeover100_count));

f_rel_homeover50_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover150_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover200_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover300_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover500_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_homeover500_count));

f_rel_ageover20_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))));

f_rel_ageover30_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))));

f_rel_ageover40_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))));

f_rel_ageover50_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))));

f_rel_educationover8_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_educationunder12_count, rel_educationover12_count) = NULL, NULL, sum(if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count), if(rel_educationover12_count = NULL, 0, rel_educationover12_count)))));

f_rel_educationover12_count_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_educationover12_count));

f_crim_rel_under25miles_cnt_i :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     crim_rel_within25miles));

f_crim_rel_under100miles_cnt_i :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(crim_rel_within25miles, crim_rel_within100miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles)))));

f_crim_rel_under500miles_cnt_i :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles)))));

f_rel_under25miles_cnt_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_within25miles_count));

f_rel_under100miles_cnt_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count)))));

f_rel_under500miles_cnt_d :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count)))));

f_rel_bankrupt_count_i :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 999)));

f_rel_criminal_count_i :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_criminal_count = NULL, -NULL, rel_criminal_count), 999)));

f_rel_felony_count_i :=__common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 999)));

f_current_count_d :=__common__( if(not(truedid), NULL, min(if(current_count = NULL, -NULL, current_count), 999)));

f_historical_count_d :=__common__( if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999)));

f_accident_count_i :=__common__( if(not(truedid), NULL, min(if(acc_count = NULL, -NULL, acc_count), 999)));

f_acc_damage_amt_total_i :=__common__( if(not(truedid), NULL, acc_damage_amt_total));

_acc_last_seen :=__common__( common.sas_date((string)(acc_last_seen)));

f_mos_acc_lseen_d :=__common__( map(
    not(truedid)          => NULL,
    _acc_last_seen = NULL => 1000,
                             max(3, min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999))));

f_acc_damage_amt_last_i :=__common__( if(not(truedid), NULL, acc_damage_amt_last));

f_accident_recency_d :=__common__( map(
    not(truedid)  => NULL,
    acc_count_30  >0 => 1,
    acc_count_90  >0 => 3,
    acc_count_180 >0 => 6,
    acc_count_12  >0 => 12,
    acc_count_24  >0 => 24,
    acc_count_36  >0 => 36,
    acc_count_60  >0 => 60,
    acc_count     >0 => 61,
                     62));

f_idverrisktype_i :=__common__( if(not(truedid) or fp_idverrisktype = '', NULL, (integer)fp_idverrisktype));

f_sourcerisktype_i :=__common__( map(
    not(truedid)             => NULL,
    fp_sourcerisktype = '' => NULL,
                                (integer)fp_sourcerisktype));

f_varrisktype_i :=__common__( map(
    not(truedid)          => NULL,
    fp_varrisktype = '' => NULL,
                             (integer)fp_varrisktype));

f_varmsrcssncount_i :=__common__( if(not(truedid), NULL, min(if(fp_varmsrcssncount = '', -NULL, (integer)fp_varmsrcssncount), 999)));

f_varmsrcssnunrelcount_i :=__common__( if(not(truedid), NULL, min(if(fp_varmsrcssnunrelcount = '', -NULL, (integer)fp_varmsrcssnunrelcount), 999)));

f_vardobcount_i :=__common__( if(not(truedid), NULL, min(if(fp_vardobcount = '', -NULL, (integer)fp_vardobcount), 999)));

f_vardobcountnew_i :=__common__( if(not(truedid), NULL, min(if(fp_vardobcountnew = '', -NULL, (integer)fp_vardobcountnew), 999)));

f_srchvelocityrisktype_i :=__common__( map(
    not(truedid)                   => NULL,
    fp_srchvelocityrisktype = '' => NULL,
                                      (integer)fp_srchvelocityrisktype));

f_srchcountwk_i :=__common__( if(not(truedid), NULL, min(if(fp_srchcountwk = '', -NULL, (integer)fp_srchcountwk), 999)));

f_srchunvrfdssncount_i :=__common__( if(not(truedid), NULL, min(if(fp_srchunvrfdssncount = '', -NULL, (integer)fp_srchunvrfdssncount), 999)));

f_srchunvrfdaddrcount_i :=__common__( if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = '', -NULL, (integer)fp_srchunvrfdaddrcount), 999)));

f_srchunvrfddobcount_i :=__common__( if(not(truedid), NULL, min(if(fp_srchunvrfddobcount = '', -NULL, (integer)fp_srchunvrfddobcount), 999)));

f_srchunvrfdphonecount_i :=__common__( if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (integer)fp_srchunvrfdphonecount), 999)));

f_srchfraudsrchcount_i :=__common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcount = '', -NULL, (integer)fp_srchfraudsrchcount), 999)));

f_srchfraudsrchcountyr_i :=__common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (integer)fp_srchfraudsrchcountyr), 999)));

f_srchfraudsrchcountmo_i :=__common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcountmo = '', -NULL, (integer)fp_srchfraudsrchcountmo), 999)));

f_srchfraudsrchcountwk_i :=__common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcountwk = '', -NULL, (integer)fp_srchfraudsrchcountwk), 999)));

f_assocrisktype_i :=__common__( map(
    not(truedid)            => NULL,
    fp_assocrisktype = '' => NULL,
                               (integer)fp_assocrisktype));

f_assocsuspicousidcount_i :=__common__( if(not(truedid), NULL, min(if(fp_assocsuspicousidcount = '', -NULL, (integer)fp_assocsuspicousidcount), 999)));

f_assoccredbureaucount_i :=__common__( if(not(truedid), NULL, min(if(fp_assoccredbureaucount = '', -NULL, (integer)fp_assoccredbureaucount), 999)));

f_corrrisktype_i :=__common__( map(
    not(truedid)           => NULL,
    fp_corrrisktype = '' => NULL,
                              (integer)fp_corrrisktype));

f_corrssnnamecount_d :=__common__( if(not(truedid), NULL, min(if(fp_corrssnnamecount = '', -NULL, (integer)fp_corrssnnamecount), 999)));

f_corrssnaddrcount_d :=__common__( if(not(truedid), NULL, min(if(fp_corrssnaddrcount = '', -NULL, (integer)fp_corrssnaddrcount), 999)));

f_corraddrnamecount_d :=__common__( if(not(truedid), NULL, min(if(fp_corraddrnamecount = '', -NULL, (integer)fp_corraddrnamecount), 999)));

f_corraddrphonecount_d :=__common__( if(not(truedid), NULL, min(if(fp_corraddrphonecount = '', -NULL, (integer)fp_corraddrphonecount), 999)));

f_corrphonelastnamecount_d :=__common__( if(not(truedid), NULL, min(if(fp_corrphonelastnamecount = '', -NULL, (integer)fp_corrphonelastnamecount), 999)));

f_divrisktype_i :=__common__( map(
    not(truedid)          => NULL,
    fp_divrisktype = '' => NULL,
                             (integer)fp_divrisktype));

f_divssnidmsrcurelcount_i :=__common__( if(not(truedid), NULL, min(if(fp_divssnidmsrcurelcount = '', -NULL, (integer)fp_divssnidmsrcurelcount), 999)));

f_divaddrsuspidcountnew_i :=__common__( if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = '', -NULL, (integer)fp_divaddrsuspidcountnew), 999)));

f_divsrchaddrsuspidcount_i :=__common__( if(not(truedid), NULL, min(if(fp_divsrchaddrsuspidcount = '', -NULL, (integer)fp_divsrchaddrsuspidcount), 999)));

f_srchcomponentrisktype_i :=__common__( map(
    not(truedid)                    => NULL,
    fp_srchcomponentrisktype = '' => NULL,
                                       (integer)fp_srchcomponentrisktype));

f_srchssnsrchcount_i :=__common__( if(not(truedid), NULL, min(if(fp_srchssnsrchcount = '', -NULL, (integer)fp_srchssnsrchcount), 999)));

f_srchssnsrchcountmo_i :=__common__( if(not(truedid), NULL, min(if(fp_srchssnsrchcountmo = '', -NULL, (integer)fp_srchssnsrchcountmo), 999)));

f_srchaddrsrchcount_i :=__common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcount = '', -NULL, (integer)fp_srchaddrsrchcount), 999)));

f_srchaddrsrchcountmo_i :=__common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = '', -NULL, (integer)fp_srchaddrsrchcountmo), 999)));

f_srchaddrsrchcountwk_i :=__common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcountwk = '', -NULL, (integer)fp_srchaddrsrchcountwk), 999)));

f_srchphonesrchcount_i :=__common__( if(not(truedid), NULL, min(if(fp_srchphonesrchcount = '', -NULL, (integer)fp_srchphonesrchcount), 999)));

f_srchphonesrchcountmo_i :=__common__( if(not(truedid), NULL, min(if(fp_srchphonesrchcountmo = '', -NULL, (integer)fp_srchphonesrchcountmo), 999)));

f_srchphonesrchcountwk_i :=__common__( if(not(truedid), NULL, min(if(fp_srchphonesrchcountwk = '', -NULL, (integer)fp_srchphonesrchcountwk), 999)));

f_componentcharrisktype_i :=__common__( map(
    not(truedid)                    => NULL,
    fp_componentcharrisktype = '' => NULL,
                                       (integer)fp_componentcharrisktype));

f_inputaddractivephonelist_d :=__common__( map(
    not(truedid)                     => NULL,
    (integer)fp_inputaddractivephonelist = -1 => NULL,
                                        (integer)fp_inputaddractivephonelist));

f_addrchangeincomediff_d_1 :=__common__( if(not(truedid), NULL, NULL));

f_addrchangeincomediff_d :=__common__( if((integer)fp_addrchangeincomediff = -1, NULL, (integer)fp_addrchangeincomediff));

f_addrchangevaluediff_d :=__common__( map(
    not(truedid)                => NULL,
    (integer)fp_addrchangevaluediff = -1 => NULL,
                                   (integer)fp_addrchangevaluediff));

f_addrchangecrimediff_i :=__common__( map(
    not(truedid)                => NULL,
    (integer)fp_addrchangecrimediff = -1 => NULL,
                                   (integer)fp_addrchangecrimediff));

f_addrchangeecontrajindex_d :=__common__( if(not(truedid) or (fp_addrchangeecontrajindex = ''), NULL, (integer)fp_addrchangeecontrajindex));

f_curraddractivephonelist_d :=__common__( map(
    not(truedid)                    => NULL,
    (integer)fp_curraddractivephonelist = -1 => NULL,
                                       (integer)fp_curraddractivephonelist));

f_curraddrmedianincome_d :=__common__( if(not(truedid), NULL, (integer)fp_curraddrmedianincome));

f_curraddrmedianvalue_d :=__common__( if(not(truedid), NULL, (integer)fp_curraddrmedianvalue));

f_curraddrmurderindex_i :=__common__( if(not(truedid), NULL, (integer)fp_curraddrmurderindex));

f_curraddrcartheftindex_i :=__common__( if(not(truedid), NULL, (integer)fp_curraddrcartheftindex));

f_curraddrburglaryindex_i :=__common__( if(not(truedid), NULL, (integer)fp_curraddrburglaryindex));

f_curraddrcrimeindex_i :=__common__( if(not(truedid), NULL, (integer)fp_curraddrcrimeindex));

f_prevaddrageoldest_d :=__common__( if(not(truedid), NULL, min(if(fp_prevaddrageoldest = '', -NULL, (integer)fp_prevaddrageoldest), 999)));

f_prevaddrlenofres_d :=__common__( if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (integer)fp_prevaddrlenofres), 999)));

f_prevaddrdwelltype_apt_n :=__common__( if(not(truedid), NULL, (integer)(fp_prevaddrdwelltype = 'H')));

f_prevaddrdwelltype_sfd_n :=__common__( if(not(truedid), NULL, (integer)(fp_prevaddrdwelltype = 'S')));

f_prevaddrstatus_i :=__common__( map(
    not(truedid)            => NULL,
    fp_prevaddrstatus = '0' => 1,
    fp_prevaddrstatus = 'U' => 2,
    fp_prevaddrstatus = 'R' => 3,
                               NULL));

f_prevaddrmedianincome_d :=__common__( if(not(truedid), NULL, (integer)fp_prevaddrmedianincome));

f_prevaddrmedianvalue_d :=__common__( if(not(truedid), NULL, (integer)fp_prevaddrmedianvalue));

f_prevaddrmurderindex_i :=__common__( if(not(truedid), NULL, (integer)fp_prevaddrmurderindex));

f_prevaddrcartheftindex_i :=__common__( if(not(truedid), NULL, (integer)fp_prevaddrcartheftindex));

f_fp_prevaddrburglaryindex_i :=__common__( if(not(truedid), NULL, (integer)fp_prevaddrburglaryindex));

f_fp_prevaddrcrimeindex_i :=__common__( if(not(truedid), NULL, (integer)fp_prevaddrcrimeindex));

email_src_im :=__common__( Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0);

c_impulse_count_i :=__common__( map(
    not(truedid)                           => NULL,
    impulse_count = 0 and email_src_im  => 1,
                                              impulse_count));

_impulse_first_seen :=__common__( common.sas_date((string)(impulse_first_seen)));

c_mos_since_impulse_fs_d :=__common__( map(
    not(truedid)                    => NULL,
    not(_impulse_first_seen = NULL) => min(if(if ((sysdate - _impulse_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _impulse_first_seen) / (365.25 / 12)), roundup((sysdate - _impulse_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _impulse_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _impulse_first_seen) / (365.25 / 12)), roundup((sysdate - _impulse_first_seen) / (365.25 / 12)))), 240),
                                       241));

_impulse_last_seen :=__common__( common.sas_date((string)(impulse_last_seen)));

c_mos_since_impulse_ls_d :=__common__( map(
    not(truedid)                   => NULL,
    not(_impulse_last_seen = NULL) => min(if(if ((sysdate - _impulse_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _impulse_last_seen) / (365.25 / 12)), roundup((sysdate - _impulse_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _impulse_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _impulse_last_seen) / (365.25 / 12)), roundup((sysdate - _impulse_last_seen) / (365.25 / 12)))), 240),
                                      241));

r_e55_college_ind_d :=__common__( map(
    not(truedid)                           => NULL,
    (college_file_type in ['H', 'C', 'A']) => 1,
                                              0));

r_has_paw_source_d_1 :=__common__( if(paw_source_count > 0, 1, 0));

_paw_first_seen :=__common__( common.sas_date((string)(paw_first_seen)));

r_mos_since_paw_fseen_d :=__common__( map(
    not(truedid)                => NULL,
    not(_paw_first_seen = NULL) => min(if(if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12)))), 240),
                                   -1));

r_c13_avg_lres_d :=__common__( if(not(truedid), NULL, avg_lres));

r_c13_max_lres_d :=__common__( if(not(truedid), NULL, max_lres));

c_unique_addr_count_i :=__common__( if(not(truedid), NULL, unique_addr_count));

c_addr_lres_2mo_ct_i :=__common__( map(
    not(truedid)                => NULL,
    addr_lres_2mo_count = -9999 => 0,
                                   addr_lres_2mo_count));

c_addr_lres_6mo_ct_i :=__common__( map(
    not(truedid)                => NULL,
    addr_lres_6mo_count = -9999 => 0,
                                   addr_lres_6mo_count));

c_addr_lres_12mo_ct_i :=__common__( map(
    not(truedid)                 => NULL,
    addr_lres_12mo_count = -9999 => 0,
                                    addr_lres_12mo_count));

c_hist_addr_match_i :=__common__( map(
    not(truedid)            => NULL,
    hist_addr_match = -9999 => 99,
    hist_addr_match = 0     => 100,
                               min(if(hist_addr_match = NULL, -NULL, hist_addr_match), 98)));

c_dist_best_to_prev_addr_i :=__common__( map(
    not(truedid)     => NULL,
    add1_isbestmatch => dist_a1toa2,
                        dist_a2toa3));

c_dist_input_to_prev_addr_i :=__common__( map(
    not(truedid)     => NULL,
    add1_isbestmatch => dist_a1toa2,
                        dist_a1toa3));

c_a49_prop_owned_purchase_tot_d_1 :=__common__( if(not(truedid or add1_pop), NULL, property_owned_purchase_total));

c_a49_prop_owned_assessed_tot_d_1 :=__common__( if(not(truedid or add1_pop), NULL, property_owned_assessed_total));

c_a49_prop_sold_purchase_tot_d_1 :=__common__( if(not(truedid or add1_pop), NULL, property_sold_purchase_total));

c_a49_prop_sold_assessed_tot_d_1 :=__common__( if(not(truedid or add1_pop), NULL, property_sold_assessed_total));

f_add_input_mobility_index_n :=__common__( map(
    not(addrpop)                 => NULL,
    add_input_occupants_1yr <= 0 => NULL,
                                    if(max(add_input_turnover_1yr_in, add_input_turnover_1yr_out) = NULL, NULL, sum(if(add_input_turnover_1yr_in = NULL, 0, add_input_turnover_1yr_in), if(add_input_turnover_1yr_out = NULL, 0, add_input_turnover_1yr_out))) / add_input_occupants_1yr));

f_add_curr_mobility_index_n :=__common__( map(
    not(addrpop)                => NULL,
    add_curr_occupants_1yr <= 0 => NULL,
                                   if(max(add_curr_turnover_1yr_in, add_curr_turnover_1yr_out) = NULL, NULL, sum(if(add_curr_turnover_1yr_in = NULL, 0, add_curr_turnover_1yr_in), if(add_curr_turnover_1yr_out = NULL, 0, add_curr_turnover_1yr_out))) / add_curr_occupants_1yr));

f_prevaddroccupantowned_d :=__common__( map(
    not(truedid)                    => NULL,
    fp_prevaddroccupantowned = '' => NULL,
                                       (integer)fp_prevaddroccupantowned));

fp_segment :=__common__( if(fp_segment_1 = '', '5 Derog', fp_segment_1));

segment :=__common__( if(segment_i = '', 'KMART', StringLib.StringToUpperCase(segment_i)));

// these are all derived, there are no NULLS
r_nas_addr_verd_d :=__common__( r_nas_addr_verd_d_1); //if(r_nas_addr_verd_d_1 <= NULL, 1, r_nas_addr_verd_d_1);

c_nap_phn_verd_d :=__common__( c_nap_phn_verd_d_1); //if(c_nap_phn_verd_d_1 <= NULL, 0, c_nap_phn_verd_d_1);

c_nap_addr_verd_d :=__common__( c_nap_addr_verd_d_1); //if(c_nap_addr_verd_d_1 <= NULL, 1, c_nap_addr_verd_d_1);

c_nap_lname_verd_d :=__common__( c_nap_lname_verd_d_1); //if(c_nap_lname_verd_d_1 <= NULL, 1, c_nap_lname_verd_d_1);

c_nap_fname_verd_d :=__common__( c_nap_fname_verd_d_1);//if(c_nap_fname_verd_d_1 <= NULL, 0, c_nap_fname_verd_d_1);

c_nap_contradictory_i :=__common__( c_nap_contradictory_i_1);//if(c_nap_contradictory_i_1 <= NULL, 0, c_nap_contradictory_i_1);

c_inf_phn_verd_d :=__common__( c_inf_phn_verd_d_1);//if(c_inf_phn_verd_d_1 <= NULL, 0, c_inf_phn_verd_d_1);

c_inf_addr_verd_d :=__common__( c_inf_addr_verd_d_1);//if(c_inf_addr_verd_d_1 <= NULL, 0, c_inf_addr_verd_d_1);

c_inf_lname_verd_d :=__common__( c_inf_lname_verd_d_1);//if(c_inf_lname_verd_d_1 <= NULL, 0, c_inf_lname_verd_d_1);

c_inf_fname_verd_d :=__common__( c_inf_fname_verd_d_1);//if(c_inf_fname_verd_d_1 <= NULL, 0, c_inf_fname_verd_d_1);

c_inf_nothing_found_i :=__common__( c_inf_nothing_found_i_1);//if(c_inf_nothing_found_i_1 <= NULL, 0, c_inf_nothing_found_i_1);

c_inf_contradictory_i :=__common__( c_inf_contradictory_i_1);//if(c_inf_contradictory_i_1 <= NULL, 0, c_inf_contradictory_i_1);

r_s65_ssn_problem_i :=__common__( if(r_s65_ssn_problem_i_1 <= NULL, 0, r_s65_ssn_problem_i_1));

r_phn_cell_n :=__common__( if(r_phn_cell_n_1 <= NULL, 1, r_phn_cell_n_1));

r_s66_adlperssn_count_i :=__common__( if(r_s66_adlperssn_count_i_1 <= NULL, 2, r_s66_adlperssn_count_i_1));

c_comb_age_d :=__common__( if(c_comb_age_d_1 <= NULL, 37, c_comb_age_d_1));

r_has_pb_record_d :=__common__( if(r_has_pb_record_d_1 <= NULL, 1, r_has_pb_record_d_1));

f_adl_util_inf_n :=__common__( if(f_adl_util_inf_n_1 <= NULL, 0, f_adl_util_inf_n_1));

f_adl_util_conv_n :=__common__( if(f_adl_util_conv_n_1 <= NULL, 1, f_adl_util_conv_n_1));

f_adl_util_misc_n :=__common__( if(f_adl_util_misc_n_1 <= NULL, 0, f_adl_util_misc_n_1));

f_util_add_input_conv_n :=__common__( if(f_util_add_input_conv_n_1 <= NULL, 1, f_util_add_input_conv_n_1));

f_util_add_input_misc_n :=__common__( if(f_util_add_input_misc_n_1 <= NULL, 1, f_util_add_input_misc_n_1));

f_util_add_curr_inf_n :=__common__( if(f_util_add_curr_inf_n_1 <= NULL, 0, f_util_add_curr_inf_n_1));

f_util_add_curr_misc_n :=__common__( if(f_util_add_curr_misc_n_1 <= NULL, 1, f_util_add_curr_misc_n_1));

f_add_input_has_mfd_ct_i :=__common__( if(f_add_input_has_mfd_ct_i_1 <= NULL, 1, f_add_input_has_mfd_ct_i_1));

f_add_curr_has_mfd_ct_i :=__common__( if(f_add_curr_has_mfd_ct_i_1 <= NULL, 1, f_add_curr_has_mfd_ct_i_1));

f_inq_per_ssn_i :=__common__( if(f_inq_per_ssn_i_1 <= NULL, 2, f_inq_per_ssn_i_1));

f_inq_adls_per_ssn_i :=__common__( if(f_inq_adls_per_ssn_i_1 <= NULL, 1, f_inq_adls_per_ssn_i_1));

f_inq_lnames_per_ssn_i :=__common__( if(f_inq_lnames_per_ssn_i_1 <= NULL, 1, f_inq_lnames_per_ssn_i_1));

f_inq_addrs_per_ssn_i :=__common__( if(f_inq_addrs_per_ssn_i_1 <= NULL, 1, f_inq_addrs_per_ssn_i_1));

f_inq_dobs_per_ssn_i :=__common__( if(f_inq_dobs_per_ssn_i_1 <= NULL, 0, f_inq_dobs_per_ssn_i_1));

r_has_paw_source_d :=__common__( if(r_has_paw_source_d_1 <= NULL, 0, r_has_paw_source_d_1));

c_a49_prop_owned_purchase_tot_d :=__common__( if(c_a49_prop_owned_purchase_tot_d_1 <= NULL, 0, c_a49_prop_owned_purchase_tot_d_1));

c_a49_prop_owned_assessed_tot_d :=__common__( if(c_a49_prop_owned_assessed_tot_d_1 <= NULL, 0, c_a49_prop_owned_assessed_tot_d_1));

c_a49_prop_sold_purchase_tot_d :=__common__( if(c_a49_prop_sold_purchase_tot_d_1 <= NULL, 0, c_a49_prop_sold_purchase_tot_d_1));

c_a49_prop_sold_assessed_tot_d :=__common__( if(c_a49_prop_sold_assessed_tot_d_1 <= NULL, 0, c_a49_prop_sold_assessed_tot_d_1));

Models.fp1407_1_0_tree1();
Models.fp1407_1_0_tree2();
Models.fp1407_1_0_tree3();
Models.fp1407_1_0_tree4();


tnscore :=__common__( sum(N0_1, N1_1, N2_1, N3_1, N4_1, N5_1, N6_1, N7_1, N8_1, N9_1, 
    N10_1, N11_1, N12_1, N13_1, N14_1, N15_1, N16_1, N17_1, N18_1, N19_1, 
    N20_1, N21_1, N22_1, N23_1, N24_1, N25_1, N26_1, N27_1, N28_1, N29_1, 
    N30_1, N31_1, N32_1, N33_1, N34_1, N35_1, N36_1, N37_1, N38_1, N39_1, 
    N40_1, N41_1, N42_1, N43_1, N44_1, N45_1, N46_1, N47_1, N48_1, N49_1, 
    N50_1, N51_1, N52_1, N53_1, N54_1, N55_1, N56_1, N57_1, N58_1, N59_1, 
    N60_1, N61_1, N62_1, N63_1, N64_1, N65_1, N66_1, N67_1, N68_1, N69_1, 
    N70_1, N71_1, N72_1, N73_1, N74_1, N75_1, N76_1, N77_1, N78_1, N79_1, 
    N80_1, N81_1, N82_1, N83_1, N84_1, N85_1, N86_1, N87_1, N88_1, N89_1, 
    N90_1, N91_1, N92_1, N93_1, N94_1, N95_1, N96_1, N97_1, N98_1, N99_1, 
    N100_1, N101_1, N102_1, N103_1, N104_1, N105_1, N106_1, N107_1, N108_1, N109_1, 
    N110_1, N111_1, N112_1, N113_1, N114_1, N115_1, N116_1, N117_1, N118_1, N119_1, 
    N120_1, N121_1, N122_1, N123_1, N124_1, N125_1, N126_1, N127_1, N128_1, N129_1, 
    N130_1, N131_1, N132_1, N133_1, N134_1, N135_1, N136_1, N137_1, N138_1, N139_1, 
    N140_1, N141_1, N142_1, N143_1, N144_1, N145_1, N146_1, N147_1, N148_1, N149_1, 
    N150_1, N151_1, N152_1, N153_1, N154_1, N155_1, N156_1, N157_1, N158_1, N159_1, 
    N160_1, N161_1, N162_1, N163_1, N164_1, N165_1, N166_1, N167_1, N168_1, N169_1, 
    N170_1, N171_1, N172_1, N173_1, N174_1, N175_1, N176_1, N177_1, N178_1, N179_1, 
    N180_1, N181_1, N182_1, N183_1, N184_1, N185_1, N186_1, N187_1, N188_1, N189_1, 
    N190_1, N191_1, N192_1, N193_1, N194_1, N195_1, N196_1, N197_1, N198_1, N199_1, 
    N200_1, N201_1, N202_1, N203_1, N204_1, N205_1, N206_1, N207_1, N208_1, N209_1, 
    N210_1, N211_1, N212_1, N213_1, N214_1, N215_1, N216_1, N217_1, N218_1, N219_1, 
    N220_1, N221_1, N222_1, N223_1, N224_1, N225_1, N226_1, N227_1, N228_1, N229_1, 
    N230_1, N231_1, N232_1, N233_1, N234_1, N235_1, N236_1, N237_1, N238_1, N239_1, 
    N240_1, N241_1, N242_1, N243_1, N244_1, N245_1, N246_1, N247_1, N248_1, N249_1, 
    N250_1, N251_1, N252_1, N253_1, N254_1, N255_1, N256_1, N257_1, N258_1, N259_1, 
    N260_1, N261_1, N262_1, N263_1, N264_1, N265_1, N266_1, N267_1, N268_1, N269_1, 
    N270_1, N271_1, N272_1, N273_1, N274_1, N275_1, N276_1, N277_1, N278_1, N279_1, 
    N280_1, N281_1, N282_1, N283_1, N284_1, N285_1, N286_1, N287_1, N288_1, N289_1, 
    N290_1, N291_1, N292_1, N293_1, N294_1, N295_1, N296_1, N297_1, N298_1, N299_1, 
    N300_1, N301_1, N302_1, N303_1, N304_1, N305_1, N306_1, N307_1, N308_1, N309_1, 
    N310_1, N311_1, N312_1, N313_1, N314_1, N315_1, N316_1, N317_1, N318_1, N319_1, 
    N320_1, N321_1, N322_1, N323_1, N324_1, N325_1, N326_1, N327_1, N328_1, N329_1, 
    N330_1, N331_1, N332_1, N333_1, N334_1, N335_1, N336_1, N337_1, N338_1, N339_1, 
    N340_1, N341_1, N342_1, N343_1, N344_1, N345_1, N346_1, N347_1, N348_1, N349_1, 
    N350_1, N351_1, N352_1, N353_1, N354_1, N355_1, N356_1, N357_1, N358_1, N359_1, 
    N360_1, N361_1, N362_1, N363_1, N364_1, N365_1, N366_1, N367_1, N368_1, N369_1, 
    N370_1, N371_1, N372_1, N373_1, N374_1, N375_1, N376_1, N377_1, N378_1, N379_1, 
    N380_1, N381_1, N382_1, N383_1, N384_1, N385_1, N386_1, N387_1, N388_1, N389_1, 
    N390_1, N391_1, N392_1, N393_1, N394_1, N395_1, N396_1, N397_1, N398_1, N399_1, 
    N400_1, N401_1, N402_1, N403_1, N404_1, N405_1, N406_1, N407_1, N408_1, N409_1, 
    N410_1, N411_1, N412_1, N413_1, N414_1, N415_1, N416_1, N417_1, N418_1, N419_1, 
    N420_1, N421_1, N422_1, N423_1, N424_1, N425_1, N426_1, N427_1, N428_1, N429_1, 
    N430_1, N431_1, N432_1, N433_1, N434_1, N435_1, N436_1, N437_1, N438_1, N439_1, 
    N440_1, N441_1, N442_1, N443_1, N444_1, N445_1, N446_1, N447_1, N448_1, N449_1, 
    N450_1, N451_1, N452_1, N453_1, N454_1, N455_1, N456_1, N457_1, N458_1, N459_1, 
    N460_1, N461_1, N462_1, N463_1, N464_1, N465_1, N466_1, N467_1, N468_1, N469_1, 
    N470_1, N471_1, N472_1, N473_1, N474_1, N475_1, N476_1, N477_1, N478_1, N479_1, 
    N480_1, N481_1, N482_1, N483_1, N484_1, N485_1, N486_1, N487_1, N488_1, N489_1, 
    N490_1, N491_1, N492_1, N493_1, N494_1, N495_1, N496_1, N497_1, N498_1, N499_1, 
    N500_1, N501_1, N502_1, N503_1, N504_1, N505_1, N506_1, N507_1, N508_1, N509_1, 
    N510_1, N511_1, N512_1, N513_1, N514_1, N515_1, N516_1, N517_1, N518_1, N519_1, 
    N520_1, N521_1, N522_1, N523_1, N524_1, N525_1, N526_1, N527_1, N528_1, N529_1, 
    N530_1, N531_1, N532_1, N533_1, N534_1, N535_1, N536_1, N537_1, N538_1, N539_1, 
    N540_1, N541_1, N542_1, N543_1, N544_1, N545_1, N546_1, N547_1, N548_1, N549_1, 
    N550_1, N551_1, N552_1, N553_1, N554_1, N555_1, N556_1, N557_1, N558_1, N559_1, 
    N560_1, N561_1, N562_1, N563_1, N564_1, N565_1, N566_1, N567_1, N568_1, N569_1, 
    N570_1, N571_1, N572_1, N573_1, N574_1, N575_1, N576_1, N577_1, N578_1, N579_1, 
    N580_1, N581_1, N582_1, N583_1, N584_1, N585_1, N586_1, N587_1, N588_1, N589_1, 
    N590_1, N591_1, N592_1, N593_1, N594_1, N595_1, N596_1, N597_1, N598_1, N599_1, 
    N600_1, N601_1, N602_1, N603_1, N604_1, N605_1, N606_1, N607_1, N608_1, N609_1, 
    N610_1, N611_1, N612_1, N613_1, N614_1, N615_1, N616_1, N617_1, N618_1, N619_1, 
    N620_1, N621_1, N622_1, N623_1, N624_1, N625_1, N626_1, N627_1, N628_1, N629_1, 
    N630_1, N631_1, N632_1, N633_1, N634_1, N635_1, N636_1, N637_1, N638_1, N639_1, 
    N640_1, N641_1, N642_1, N643_1, N644_1, N645_1, N646_1, N647_1, N648_1, N649_1, 
    N650_1, N651_1, N652_1, N653_1, N654_1, N655_1, N656_1, N657_1, N658_1, N659_1, 
    N660_1, N661_1, N662_1, N663_1, N664_1, N665_1, N666_1, N667_1, N668_1, N669_1, 
    N670_1, N671_1, N672_1, N673_1, N674_1, N675_1, N676_1, N677_1, N678_1, N679_1, 
    N680_1, N681_1, N682_1, N683_1, N684_1, N685_1, N686_1, N687_1, N688_1, N689_1, 
    N690_1, N691_1, N692_1, N693_1, N694_1, N695_1, N696_1, N697_1, N698_1, N699_1, 
    N700_1, N701_1, N702_1, N703_1, N704_1, N705_1, N706_1, N707_1, N708_1, N709_1, 
    N710_1, N711_1, N712_1, N713_1, N714_1, N715_1, N716_1, N717_1, N718_1, N719_1, 
    N720_1, N721_1, N722_1, N723_1, N724_1, N725_1, N726_1, N727_1, N728_1, N729_1, 
    N730_1, N731_1, N732_1, N733_1, N734_1, N735_1, N736_1, N737_1, N738_1, N739_1, 
    N740_1, N741_1, N742_1, N743_1, N744_1, N745_1, N746_1, N747_1, N748_1, N749_1, 
    N750_1, N751_1, N752_1, N753_1, N754_1, N755_1, N756_1, N757_1, N758_1, N759_1, 
    N760_1, N761_1, N762_1, N763_1, N764_1, N765_1, N766_1, N767_1, N768_1, N769_1, 
    N770_1, N771_1, N772_1, N773_1, N774_1, N775_1, N776_1, N777_1, N778_1, N779_1, 
    N780_1, N781_1, N782_1, N783_1, N784_1, N785_1, N786_1, N787_1, N788_1, N789_1, 
    N790_1, N791_1, N792_1, N793_1, N794_1, N795_1, N796_1, N797_1, N798_1, N799_1, 
    N800_1, N801_1, N802_1, N803_1, N804_1, N805_1, N806_1, N807_1, N808_1, N809_1, 
    N810_1, N811_1, N812_1, N813_1, N814_1, N815_1, N816_1, N817_1, N818_1, N819_1, 
    N820_1, N821_1, N822_1, N823_1, N824_1, N825_1, N826_1, N827_1, N828_1, N829_1, 
    N830_1, N831_1, N832_1, N833_1, N834_1, N835_1, N836_1, N837_1, N838_1, N839_1, 
    N840_1, N841_1, N842_1, N843_1, N844_1, N845_1, N846_1, N847_1, N848_1, N849_1, 
    N850_1, N851_1, N852_1, N853_1, N854_1, N855_1, N856_1, N857_1, N858_1, N859_1, 
    N860_1, N861_1, N862_1, N863_1, N864_1, N865_1, N866_1, N867_1, N868_1, N869_1, 
    N870_1, N871_1, N872_1, N873_1, N874_1, N875_1, N876_1, N877_1, N878_1, N879_1, 
    N880_1, N881_1, N882_1, N883_1, N884_1, N885_1, N886_1, N887_1, N888_1, N889_1, 
    N890_1, N891_1, N892_1, N893_1, N894_1, N895_1, N896_1, N897_1, N898_1, N899_1, 
    N900_1, N901_1, N902_1, N903_1, N904_1, N905_1, N906_1, N907_1, N908_1, N909_1, 
    N910_1, N911_1, N912_1, N913_1, N914_1, N915_1, N916_1, N917_1, N918_1, N919_1, 
    N920_1, N921_1, N922_1, N923_1, N924_1, N925_1, N926_1, N927_1, N928_1, N929_1, 
    N930_1, N931_1, N932_1, N933_1, N934_1, N935_1, N936_1, N937_1, N938_1, N939_1, 
    N940_1, N941_1, N942_1, N943_1, N944_1, N945_1, N946_1, N947_1, N948_1, N949_1, 
    N950_1, N951_1, N952_1, N953_1, N954_1, N955_1, N956_1, N957_1, N958_1, N959_1, 
    N960_1, N961_1, N962_1, N963_1, N964_1, N965_1, N966_1, N967_1, N968_1, N969_1, 
    N970_1, N971_1, N972_1, N973_1, N974_1, N975_1, N976_1, N977_1, N978_1, N979_1, 
    N980_1, N981_1, N982_1, N983_1, N984_1, N985_1, N986_1, N987_1, N988_1, N989_1, 
    N990_1, N991_1, N992_1, N993_1, N994_1, N995_1, N996_1, N997_1, N998_1, N999_1, 
    N1000_1, N1001_1, N1002_1, N1003_1, N1004_1, N1005_1, N1006_1, N1007_1, N1008_1, N1009_1, 
    N1010_1, N1011_1, N1012_1, N1013_1, N1014_1, N1015_1, N1016_1, N1017_1, N1018_1, N1019_1, 
    N1020_1, N1021_1, N1022_1, N1023_1, N1024_1, N1025_1, N1026_1, N1027_1, N1028_1, N1029_1, 
    N1030_1, N1031_1, N1032_1, N1033_1, N1034_1, N1035_1, N1036_1, N1037_1, N1038_1, N1039_1, 
    N1040_1, N1041_1, N1042_1, N1043_1, N1044_1, N1045_1, N1046_1, N1047_1, N1048_1, N1049_1, 
    N1050_1, N1051_1, N1052_1, N1053_1, N1054_1, N1055_1, N1056_1, N1057_1, N1058_1, N1059_1, 
    N1060_1, N1061_1, N1062_1, N1063_1, N1064_1, N1065_1, N1066_1, N1067_1, N1068_1, N1069_1, 
    N1070_1, N1071_1, N1072_1, N1073_1, N1074_1, N1075_1, N1076_1, N1077_1, N1078_1, N1079_1, 
    N1080_1, N1081_1, N1082_1, N1083_1, N1084_1, N1085_1, N1086_1, N1087_1, N1088_1, N1089_1, 
    N1090_1, N1091_1, N1092_1, N1093_1, N1094_1, N1095_1, N1096_1, N1097_1, N1098_1, N1099_1, 
    N1100_1, N1101_1, N1102_1, N1103_1, N1104_1, N1105_1, N1106_1, N1107_1, N1108_1, N1109_1, 
    N1110_1, N1111_1, N1112_1, N1113_1, N1114_1, N1115_1, N1116_1, N1117_1, N1118_1, N1119_1, 
    N1120_1, N1121_1, N1122_1, N1123_1, N1124_1, N1125_1, N1126_1, N1127_1, N1128_1, N1129_1, 
    N1130_1, N1131_1, N1132_1, N1133_1, N1134_1, N1135_1, N1136_1, N1137_1, N1138_1, N1139_1, 
    N1140_1, N1141_1, N1142_1, N1143_1, N1144_1, N1145_1, N1146_1, N1147_1, N1148_1, N1149_1, 
    N1150_1, N1151_1, N1152_1, N1153_1, N1154_1, N1155_1, N1156_1, N1157_1, N1158_1, N1159_1, 
    N1160_1, N1161_1, N1162_1, N1163_1, N1164_1, N1165_1, N1166_1, N1167_1, N1168_1, N1169_1, 
    N1170_1, N1171_1, N1172_1, N1173_1, N1174_1, N1175_1, N1176_1, N1177_1, N1178_1, N1179_1, 
    N1180_1, N1181_1, N1182_1, N1183_1, N1184_1, N1185_1, N1186_1, N1187_1, N1188_1, N1189_1, 
    N1190_1, N1191_1, N1192_1, N1193_1, N1194_1, N1195_1, N1196_1, N1197_1, N1198_1, N1199_1, 
    N1200_1, N1201_1, N1202_1, N1203_1, N1204_1, N1205_1, N1206_1, N1207_1, N1208_1, N1209_1, 
    N1210_1, N1211_1, N1212_1, N1213_1, N1214_1, N1215_1, N1216_1, N1217_1, N1218_1, N1219_1, 
    N1220_1, N1221_1, N1222_1, N1223_1, N1224_1, N1225_1, N1226_1, N1227_1, N1228_1, N1229_1, 
    N1230_1, N1231_1, N1232_1, N1233_1, N1234_1, N1235_1, N1236_1, N1237_1, N1238_1, N1239_1, 
    N1240_1, N1241_1, N1242_1, N1243_1, N1244_1, N1245_1, N1246_1, N1247_1, N1248_1, N1249_1, 
    N1250_1, N1251_1, N1252_1, N1253_1, N1254_1, N1255_1, N1256_1, N1257_1, N1258_1, N1259_1, 
    N1260_1, N1261_1, N1262_1, N1263_1, N1264_1, N1265_1, N1266_1, N1267_1, N1268_1, N1269_1, 
    N1270_1, N1271_1, N1272_1, N1273_1, N1274_1, N1275_1, N1276_1, N1277_1, N1278_1, N1279_1, 
    N1280_1, N1281_1, N1282_1, N1283_1, N1284_1, N1285_1, N1286_1, N1287_1, N1288_1, N1289_1, 
    N1290_1, N1291_1, N1292_1, N1293_1, N1294_1, N1295_1, N1296_1, N1297_1, N1298_1, N1299_1, 
    N1300_1, N1301_1, N1302_1, N1303_1, N1304_1, N1305_1, N1306_1, N1307_1, N1308_1, N1309_1, 
    N1310_1, N1311_1, N1312_1, N1313_1, N1314_1, N1315_1, N1316_1, N1317_1, N1318_1, N1319_1, 
    N1320_1, N1321_1, N1322_1, N1323_1, N1324_1, N1325_1, N1326_1, N1327_1, N1328_1, N1329_1, 
    N1330_1, N1331_1, N1332_1, N1333_1, N1334_1, N1335_1, N1336_1, N1337_1, N1338_1, N1339_1, 
    N1340_1, N1341_1, N1342_1, N1343_1, N1344_1, N1345_1, N1346_1, N1347_1, N1348_1, N1349_1, 
    N1350_1, N1351_1, N1352_1, N1353_1, N1354_1, N1355_1, N1356_1, N1357_1, N1358_1, N1359_1, 
    N1360_1, N1361_1, N1362_1, N1363_1, N1364_1, N1365_1, N1366_1, N1367_1, N1368_1, N1369_1, 
    N1370_1, N1371_1, N1372_1, N1373_1, N1374_1, N1375_1, N1376_1, N1377_1, N1378_1, N1379_1, 
    N1380_1, N1381_1, N1382_1, N1383_1, N1384_1, N1385_1, N1386_1, N1387_1, N1388_1, N1389_1, 
    N1390_1, N1391_1, N1392_1, N1393_1, N1394_1, N1395_1, N1396_1, N1397_1, N1398_1, N1399_1, 
    N1400_1, N1401_1, N1402_1, N1403_1, N1404_1, N1405_1, N1406_1, N1407_1, N1408_1, N1409_1, 
    N1410_1, N1411_1, N1412_1, N1413_1, N1414_1, N1415_1, N1416_1, N1417_1, N1418_1, N1419_1, 
    N1420_1, N1421_1, N1422_1, N1423_1, N1424_1, N1425_1, N1426_1, N1427_1, N1428_1, N1429_1, 
    N1430_1, N1431_1, N1432_1, N1433_1, N1434_1, N1435_1, N1436_1, N1437_1, N1438_1, N1439_1, 
    N1440_1, N1441_1, N1442_1, N1443_1, N1444_1, N1445_1, N1446_1, N1447_1, N1448_1, N1449_1, 
    N1450_1, N1451_1, N1452_1, N1453_1, N1454_1, N1455_1, N1456_1, N1457_1, N1458_1, N1459_1, 
    N1460_1, N1461_1, N1462_1, N1463_1, N1464_1, N1465_1, N1466_1, N1467_1, N1468_1, N1469_1, 
    N1470_1, N1471_1, N1472_1, N1473_1, N1474_1, N1475_1, N1476_1, N1477_1, N1478_1, N1479_1, 
    N1480_1, N1481_1, N1482_1, N1483_1, N1484_1, N1485_1, N1486_1, N1487_1, N1488_1, N1489_1, 
    N1490_1, N1491_1, N1492_1, N1493_1, N1494_1, N1495_1, N1496_1, N1497_1, N1498_1, N1499_1, 
    N1500_1, N1501_1, N1502_1, N1503_1, N1504_1, N1505_1, N1506_1, N1507_1, N1508_1, N1509_1, 
    N1510_1, N1511_1, N1512_1, N1513_1, N1514_1, N1515_1, N1516_1, N1517_1, N1518_1, N1519_1, 
    N1520_1, N1521_1, N1522_1, N1523_1, N1524_1, N1525_1, N1526_1, N1527_1, N1528_1, N1529_1, 
    N1530_1, N1531_1, N1532_1, N1533_1, N1534_1, N1535_1, N1536_1, N1537_1, N1538_1, N1539_1, 
    N1540_1, N1541_1, N1542_1, N1543_1, N1544_1, N1545_1, N1546_1, N1547_1, N1548_1, N1549_1, 
    N1550_1, N1551_1, N1552_1, N1553_1, N1554_1, N1555_1, N1556_1, N1557_1, N1558_1, N1559_1, 
    N1560_1, N1561_1, N1562_1, N1563_1, N1564_1, N1565_1, N1566_1, N1567_1, N1568_1, N1569_1, 
    N1570_1, N1571_1, N1572_1, N1573_1, N1574_1, N1575_1, N1576_1, N1577_1, N1578_1, N1579_1, 
    N1580_1, N1581_1, N1582_1, N1583_1, N1584_1, N1585_1, N1586_1, N1587_1, N1588_1, N1589_1, 
    N1590_1, N1591_1, N1592_1, N1593_1, N1594_1, N1595_1, N1596_1, N1597_1, N1598_1, N1599_1, 
    N1600_1, N1601_1, N1602_1, N1603_1, N1604_1, N1605_1, N1606_1, N1607_1, N1608_1, N1609_1, 
    N1610_1, N1611_1, N1612_1, N1613_1, N1614_1, N1615_1, N1616_1, N1617_1, N1618_1, N1619_1, 
    N1620_1, N1621_1, N1622_1, N1623_1, N1624_1, N1625_1, N1626_1, N1627_1, N1628_1, N1629_1, 
    N1630_1, N1631_1, N1632_1, N1633_1, N1634_1, N1635_1, N1636_1, N1637_1, N1638_1, N1639_1, 
    N1640_1, N1641_1, N1642_1, N1643_1, N1644_1, N1645_1, N1646_1, N1647_1, N1648_1, N1649_1, 
    N1650_1, N1651_1, N1652_1, N1653_1, N1654_1, N1655_1, N1656_1, N1657_1, N1658_1, N1659_1, 
    N1660_1, N1661_1, N1662_1, N1663_1, N1664_1, N1665_1, N1666_1, N1667_1, N1668_1, N1669_1, 
    N1670_1, N1671_1, N1672_1, N1673_1, N1674_1, N1675_1, N1676_1, N1677_1, N1678_1, N1679_1, 
    N1680_1, N1681_1, N1682_1, N1683_1, N1684_1, N1685_1, N1686_1, N1687_1, N1688_1, N1689_1, 
    N1690_1, N1691_1, N1692_1, N1693_1, N1694_1, N1695_1, N1696_1, N1697_1, N1698_1, N1699_1, 
    N1700_1, N1701_1, N1702_1, N1703_1, N1704_1, N1705_1, N1706_1, N1707_1, N1708_1, N1709_1, 
    N1710_1, N1711_1, N1712_1, N1713_1, N1714_1, N1715_1, N1716_1, N1717_1, N1718_1, N1719_1, 
    N1720_1, N1721_1, N1722_1, N1723_1, N1724_1, N1725_1, N1726_1, N1727_1, N1728_1, N1729_1, 
    N1730_1, N1731_1, N1732_1, N1733_1, N1734_1, N1735_1, N1736_1, N1737_1, N1738_1, N1739_1, 
    N1740_1, N1741_1, N1742_1, N1743_1, N1744_1, N1745_1, N1746_1, N1747_1, N1748_1, N1749_1, 
    N1750_1, N1751_1, N1752_1, N1753_1, N1754_1, N1755_1, N1756_1, N1757_1, N1758_1, N1759_1, 
    N1760_1, N1761_1, N1762_1, N1763_1, N1764_1, N1765_1, N1766_1, N1767_1, N1768_1, N1769_1, 
    N1770_1, N1771_1, N1772_1, N1773_1, N1774_1, N1775_1, N1776_1, N1777_1, N1778_1, N1779_1, 
    N1780_1, N1781_1, N1782_1, N1783_1, N1784_1, N1785_1, N1786_1, N1787_1, N1788_1, N1789_1, 
    N1790_1, N1791_1, N1792_1, N1793_1, N1794_1, N1795_1, N1796_1, N1797_1, N1798_1, N1799_1, 
    N1800_1, N1801_1, N1802_1, N1803_1, N1804_1, N1805_1, N1806_1, N1807_1, N1808_1, N1809_1, 
    N1810_1, N1811_1, N1812_1, N1813_1));

expsum_2 :=__common__( 0.0);

class_threshold :=__common__( 0.5);

score0 :=__common__( exp(-tnscore));

expsum_1 :=__common__( expsum_2 + score0);

score1 :=__common__( exp(tnscore));

expsum :=__common__( expsum_1 + score1);

prob0 :=__common__( score0 / expsum);

prob1 :=__common__( score1 / expsum);

base :=__common__( 700);

pts :=__common__( -50);

odds :=__common__( .2221 / (1 - .2221));

fp1407_2_2_2 :=__common__(  min(if(max(round(pts * (ln(prob1 / (1 - prob1)) - ln(odds)) / ln(2) + base) - 50, 300) = NULL, -NULL, max(round(pts * (ln(prob1 / (1 - prob1)) - ln(odds)) / ln(2) + base) - 50, 300)), 999));

ov_cvi_0 :=__common__( cvi = 0);

ov_cvi_10 :=__common__( cvi = 10);

ov_ssn_deceased :=__common__( rc_decsflag = '1' or Models.Common.findw_cpp(ver_sources, 'DS' , ', ', 'E') > 0 or Models.Common.findw_cpp(ver_sources, 'DE' , ', ', 'E') > 0);

ov_invalid_ssn :=__common__( reason1 = '06' or reason2 = '06' or reason3 = '06' or reason4 = '06' or reason5 = '06' or reason6 = '06');

ov_ssn_itin :=__common__( reason1 = 'IT' or reason2 = 'IT' or reason3 = 'IT' or reason4 = 'IT' or reason5 = 'IT' or reason6 = 'IT');

ov_prison_address :=__common__( reason1 = '50' or reason2 = '50' or reason3 = '50' or reason4 = '50' or reason5 = '50' or reason6 = '50');

ov_ssn_issued_prior_to_dob :=__common__( reason1 = '03' or reason2 = '03' or reason3 = '03' or reason4 = '03' or reason5 = '03' or reason6 = '03');

ov_no_lexid_found :=__common__( (Integer)truedid = 0 and add1_naprop < 3);

fp1407_2_0 :=__common__( map(
    ov_cvi_0 or ov_ssn_deceased or (ov_invalid_ssn and not ov_ssn_itin) or ov_prison_address or ov_ssn_issued_prior_to_dob or ov_no_lexid_found => 250,
    ov_cvi_10 and fp1407_2_2_2 > 550                                                                                      => 550,
                                                                                                                             fp1407_2_2_2));
																																																														 
pred_1 :=__common__( 0);

pred :=__common__( if(prob1 > class_threshold, 1, pred_1));

#if(FP_DEBUG)
		/* Model Input Variables */
	self.clam															:= le;
	Models.FP1407_1_0_debugout();

#end
	self.seq := le.seq;
	ritmp :=  Models.fraudpoint_reasons(le, blank_ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34(fp1407_2_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)fp1407_2_0;
	self := [];
END;

model :=   join(clam, Easi.Key_Easi_Census,
	left.shell_input.st<>''
		and left.shell_input.county <>''
		and left.shell_input.geo_blk <> ''
		and keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
	doModel(left, right), left outer,
	atmost(RiskWise.max_atmost)
	,keep(1)
);
	return model;
END;	