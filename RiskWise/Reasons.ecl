import risk_indicators, models;

export Reasons(	risk_indicators.layout_boca_shell clam, boolean PrescreenOptOut=false, boolean isCalifornia=false ) := MODULE

	export makeRC( string2 code ) := DATASET([{code, if(code='00', '', risk_indicators.getHRIDesc(code))}],risk_indicators.Layout_Desc);

	/************************************************************************/

//isCode01
//isCode01a
//isCode01b
	export rc02 := Risk_Indicators.rcSet.isCode02(clam.iid.decsflag);
	export rc03 := Risk_Indicators.rcSet.isCode03(clam.iid.socsdobflag);
	export rc04 := Risk_Indicators.rcSet.isCode04(
				clam.iid.lastcount,
				clam.iid.socscount,
				clam.iid.addrcount,
				clam.iid.phonever_type,
				clam.iid.phonelastcount,
				clam.iid.phonephonecount,
				clam.iid.phoneaddrcount,
				clam.iid.phoneaddr_lastcount,
				clam.iid.phoneaddr_phonecount,
				clam.iid.phoneaddr_addrcount,
				clam.iid.utiliaddr_lastcount,
				clam.iid.utiliaddr_phonecount,
				clam.iid.utiliaddr_addrcount);
//isCode05
	export rc06 := Risk_Indicators.rcSet.isCode06(
				clam.iid.socsvalflag, 
				clam.shell_input.ssn);
	export rc07 := Risk_Indicators.rcSet.isCode07(clam.iid.hriskphoneflag);
	export rc08 := Risk_Indicators.rcSet.isCode08(
				clam.iid.phonetype,
				clam.shell_input.phone10);
	export rc09 := Risk_Indicators.rcSet.isCode09(clam.phone_verification.telcordia_type);
	export rc10 := Risk_Indicators.rcSet.isCode10(clam.phone_verification.telcordia_type);
	export rc11 := Risk_Indicators.rcSet.isCode11(
				clam.iid.addrvalflag,
				clam.shell_input.in_streetAddress,
				clam.shell_input.in_city,
				clam.shell_input.in_state,
				clam.shell_input.in_zipCode);
	export rc12 := Risk_Indicators.rcSet.isCode12(clam.iid.zipclass);
	export rc13 := Risk_Indicators.rcSet.isCode13;
	export rc14 := Risk_Indicators.rcSet.isCode14(clam.iid.hriskaddrflag);
	export rc15 := Risk_Indicators.rcSet.isCode15(clam.iid.hriskphoneflag);
	export rc16 := Risk_Indicators.rcSet.isCode16(clam.iid.phonezipflag);
//isCode17
//isCode18 
	export rc19 := Risk_Indicators.rcSet.isCode19(
				clam.iid.combo_lastcount,
				clam.iid.combo_addrcount,
				clam.iid.combo_hphonecount,
				clam.iid.combo_ssncount);
	export rc20 := Risk_Indicators.rcSet.isCode20(
				clam.iid.combo_lastcount,
				clam.iid.combo_addrcount,
				clam.iid.combo_hphonecount,
				clam.iid.combo_ssncount);
	export rc21 := Risk_Indicators.rcSet.isCode21(
				clam.shell_input.lname,
				clam.shell_input.phone10,
				clam.iid.combo_lastcount,
				clam.iid.combo_addrcount,
				clam.iid.combo_hphonecount);
	export rc22 := Risk_Indicators.rcSet.isCode22(
				clam.shell_input.lname,
				clam.shell_input.in_streetAddress,
				clam.iid.combo_lastcount,
				clam.iid.combo_addrcount,
				clam.iid.combo_hphonecount);
	export rc23 := Risk_Indicators.rcSet.isCode23(
				clam.shell_input.ssn,
				clam.shell_input.lname,
				clam.iid.combo_lastcount,
				clam.iid.combo_addrcount,
				clam.iid.combo_hphonecount,
				clam.iid.combo_ssncount);
	export rc24 := Risk_Indicators.rcSet.isCode24(
				clam.shell_input.in_streetAddress,
				clam.shell_input.ssn,
				clam.iid.combo_lastcount,
				clam.iid.combo_addrcount,
				clam.iid.combo_ssncount);
	export rc25 := Risk_Indicators.rcSet.isCode25(
				clam.shell_input.in_streetAddress,
				clam.iid.combo_lastcount,
				clam.iid.combo_addrcount,
				clam.iid.combo_hphonecount,
				clam.iid.combo_ssncount);
	export rc26 := Risk_Indicators.rcSet.isCode26(
				clam.shell_input.ssn,
				clam.iid.combo_lastcount,
				clam.iid.combo_addrcount,
				clam.iid.combo_ssncount,
				true,	// with23and24
				false,	// with19
				clam.iid.combo_hphonecount);
	export rc27 := Risk_Indicators.rcSet.isCode27(
				clam.shell_input.phone10,
				clam.iid.combo_lastcount,
				clam.iid.combo_hphonecount);
	export rc28 := Risk_Indicators.rcSet.isCode28(
				clam.iid.combo_dobcount,
				clam.shell_input.dob);
	export rc29 := Risk_Indicators.rcSet.isCode29(clam.iid.socsmiskeyflag);
	export rc30 := Risk_Indicators.rcSet.isCode30(clam.iid.addrmiskeyflag);
	export rc31 := Risk_Indicators.rcSet.isCode31(clam.iid.hphonemiskeyflag);
	export rc32 := Risk_Indicators.rcSet.isCode32(clam.iid.watchlist_table, clam.iid.watchlist_record_number);
//isCode33
	export rc34 := Risk_Indicators.rcSet.isCode34(
		clam.iid.combo_lastcount, clam.iid.combo_addrcount, clam.iid.combo_hphonecount, clam.iid.combo_ssncount, 
		clam.shell_input.phone10, clam.shell_input.ssn);
	
	export rc35 :=  isCalifornia and (
			(integer)(boolean)clam.iid.combo_firstcount+(integer)(boolean)clam.iid.combo_lastcount
			+(integer)(boolean)clam.iid.combo_addrcount+(integer)(boolean)clam.iid.combo_hphonecount
			+(integer)(boolean)clam.iid.combo_ssncount+(integer)(boolean)clam.iid.combo_dobcount) < 3;
//isCode36
	export rc37 := Risk_Indicators.rcSet.isCode37(
				clam.shell_input.lname,
				clam.iid.combo_lastcount,
				clam.iid.combo_addrcount,
				clam.iid.combo_hphonecount,
				clam.iid.combo_ssncount);
	export rc38 := Risk_Indicators.rcSet.IsCode38(
				clam.iid.altlast,
				clam.iid.socscount,
				clam.iid.lastcount,
				clam.iid.altlast2,
				clam.iid.correctlast<>'');
	export rc39 := Risk_Indicators.rcSet.isCode39(clam.iid.socllowissue, clam.historydate);
	export rc40 := Risk_Indicators.rcSet.isCode40( clam.iid.zipclass );
//isCode41
	export rc42 := Risk_Indicators.rcSet.isCode42(clam.iid.bansflag);
	export rc43 := Risk_Indicators.rcSet.isCode43(
				clam.iid.bansflag,
				clam.iid.firstcount,
				clam.iid.lastcount,
				clam.iid.addrcount);
//isCode43b
//isCode44
	export rc45 := Risk_Indicators.rcSet.isCode45(
				clam.iid.lastcount,
				clam.iid.socscount,
				clam.iid.addrcount,
				clam.iid.phonever_type,
				clam.iid.phonelastcount,
				clam.iid.phonephonecount,
				clam.iid.phoneaddrcount,
				clam.iid.phoneaddr_lastcount,
				clam.iid.phoneaddr_phonecount,
				clam.iid.phoneaddr_addrcount,
				clam.iid.utiliaddr_lastcount,
				clam.iid.utiliaddr_phonecount,
				clam.iid.utiliaddr_addrcount);
//isCode46
//isCode47
	export rc48 := Risk_Indicators.rcSet.isCode48(
				clam.shell_input.fname,
				clam.iid.combo_firstcount,
				clam.iid.combo_lastcount);
	export rc49 := Risk_Indicators.rcSet.isCode49(clam.iid.disthphoneaddr);
	export rc50 := Risk_Indicators.rcSet.isCode50(
				clam.iid.hriskaddrflag,
				clam.iid.hrisksic,
				clam.iid.hriskphoneflag,
				clam.iid.hrisksicphone);
	export rc51 := Risk_Indicators.rcSet.isCode51(
				clam.shell_input.lname,
				clam.shell_input.ssn,
				clam.iid.lastssnmatch2,
				clam.iid.socsverlevel,
				clam.iid.ssnExists);
	export rc52 := Risk_Indicators.rcSet.isCode52(
				clam.shell_input.fname,
				clam.shell_input.ssn,
				clam.iid.firstssnmatch,
				clam.iid.socsverlevel,
				clam.iid.ssnExists);
	export rc53 := Risk_Indicators.rcSet.isCode53(clam.iid.disthphonewphone);
//isCode54
	export rc55 := Risk_Indicators.rcSet.isCode55(clam.iid.wphonevalflag);
	export rc56 := Risk_Indicators.rcSet.isCode56(clam.iid.wphonedissflag);
	export rc57 := Risk_Indicators.rcSet.isCode57(clam.iid.wphonetypeflag);
//isCode58
//isCode59

	export rc5Q := clam.acc_logs.inquiries.count12 >= 5;

//isCode60
//isCode61
//isCode62
//isCode63
	export rc64 := Risk_Indicators.rcSet.isCode64(
				clam.iid.dirsaddr_phone, 
				clam.shell_input.phone10, 
				clam.iid.dirsaddr_lastscore);
	
//isCode65
//isCode66
//isCode67
//isCode68
//isCode69
//isCode70
	export rc71 := Risk_Indicators.rcSet.isCode71(
				clam.iid.ssnExists,
				clam.shell_input.ssn,
				clam.iid.socsvalflag);
	export rc72 := Risk_Indicators.rcSet.isCode72(
				(string)clam.iid.socsverlevel,
				clam.shell_input.ssn,
				clam.iid.ssnExists,
				clam.iid.lastssnmatch2);
	export rc73 := Risk_Indicators.rcSet.isCode73(
				clam.shell_input.phone10,
				clam.iid.phonephonecount,
				clam.iid.combo_hphonecount);
	export rc74 := Risk_Indicators.rcSet.isCode74(
				clam.iid.phonelastcount,
				clam.iid.phoneaddrcount,
				clam.iid.phonephonecount,
				clam.iid.phonevalflag);
	export rc75 := Risk_Indicators.rcSet.isCode75(clam.iid.publish_code);
	export rc76 := Risk_Indicators.rcSet.isCode76(clam.iid.correctlast);
	export rc77 := Risk_Indicators.rcSet.isCode77(
				clam.shell_input.lname,
				clam.shell_input.fname);
	export rc78 := Risk_Indicators.rcSet.isCode78(clam.shell_input.in_streetAddress);
	export rc79 := Risk_Indicators.rcSet.isCode79(clam.shell_input.ssn);
	export rc80 := Risk_Indicators.rcSet.isCode80(clam.shell_input.phone10);
	export rc81 := Risk_Indicators.rcSet.isCode81(clam.shell_input.dob);
	export rc82 := Risk_Indicators.rcSet.isCode82(
				clam.iid.name_addr_phone,
				clam.shell_input.phone10,
				clam.iid.dirsaddr_lastscore);
	export rc83 := Risk_Indicators.rcSet.isCode83(clam.iid.correctdob);
//isCode84
	export rc85 := Risk_Indicators.rcSet.isCode85(clam.shell_input.ssn, clam.iid.socllowissue);
//isCode86
//isCode87
//isCode88
	export rc89 := Risk_Indicators.rcSet.isCode89( clam.iid.socllowissue, clam.historydate );
	export rc90 := Risk_Indicators.rcSet.isCode90(clam.iid.socllowissue, clam.shell_input.dob);
	export rc91 := Risk_Indicators.rcSet.isCode91(clam.consumerflags.security_freeze);
	export rc92 := Risk_Indicators.rcSet.isCode92(clam.consumerflags.security_alert);
	export rc93 := Risk_Indicators.rcSet.isCode93(clam.consumerflags.id_theft_flag);
	export rc94 := Risk_Indicators.rcSet.isCode94(clam.consumerflags.dispute_flag);
	export rc95 := Risk_Indicators.rcSet.isCode95(PrescreenOptOut);
	export rc96 := Risk_Indicators.rcSet.isCode96(clam.consumerflags.corrected_flag);
	export rc97 := Risk_Indicators.rcSet.isCode97(clam.bjl.felony_count);
	export rc98 := Risk_Indicators.rcSet.isCode98(
				clam.bjl.liens_recent_unreleased_count,
				clam.bjl.liens_historical_unreleased_count);
	export rc99 := Risk_Indicators.rcSet.isCode99(
				clam.address_verification.input_address_information.source_count,
				clam.address_verification.input_address_information.isbestmatch);
	export rc9A := Risk_Indicators.rcSet.isCode9A(
				clam.address_verification.input_address_information.naprop,
				clam.address_verification.address_history_1.naprop,
				clam.address_verification.address_history_2.naprop,
				clam.address_verification.input_address_information.applicant_owned,
				clam.address_verification.input_address_information.family_owned,
				clam.address_verification.input_address_information.family_sold,
				clam.address_verification.input_address_information.applicant_sold,
				clam.address_verification.address_history_1.applicant_owned,
				clam.address_verification.address_history_1.family_owned,
				clam.address_verification.address_history_1.family_sold,
				clam.address_verification.address_history_1.applicant_sold,
				clam.address_verification.address_history_2.applicant_owned,
				clam.address_verification.address_history_2.family_owned,
				clam.address_verification.address_history_2.family_sold,
				clam.address_verification.address_history_2.applicant_sold,
				clam.address_verification.owned.property_total,
				clam.address_verification.sold.property_total,
				clam.address_verification.ambiguous.property_total);
	export rc9B := Risk_Indicators.rcSet.isCode9B(
				clam.address_verification.input_address_information.naprop,
				clam.address_verification.owned.property_total,
				clam.address_verification.address_history_1.naprop,
				clam.address_verification.address_history_2.naprop,
				clam.address_verification.sold.property_total);
	export rc9C := Risk_Indicators.rcSet.isCode9C(clam.address_verification.input_address_information.date_first_seen,
																								clam.historydate);
	export rc9D := Risk_Indicators.rcSet.isCode9D(
				clam.address_verification.input_address_information.date_first_seen,
				clam.address_verification.address_history_1.date_first_seen,
				clam.address_verification.address_history_2.date_first_seen,
				clam.historydate);
	export rc9E := Risk_Indicators.rcSet.isCode9E(
				clam.name_verification.source_count,
				clam.address_verification.input_address_information.source_count);
	export rc9F := Risk_Indicators.rcSet.isCode9F(
				clam.address_verification.input_address_information.date_last_seen,
				clam.address_verification.address_history_1.date_last_seen,
				clam.ssn_verification.credit_last_seen,
				clam.ssn_verification.header_last_seen,
				clam.historydate);

	export rc9G := Risk_Indicators.rcSet.isCode9G(
				clam.name_verification.age,
				clam.shell_input.dob,
				clam.historydate);
	export rc9H := Risk_Indicators.rcSet.isCode9H(clam.impulse.count);
	export rc9I := Risk_Indicators.rcSet.isCode9I( clam.inferred_age,
				''=trim(clam.student.DATE_FIRST_SEEN)
				AND ''=trim(clam.student.DATE_LAST_SEEN)
				AND ''=trim(clam.student.CRRT_CODE)
				AND ''=trim(clam.student.ADDRESS_TYPE_CODE)
				AND ''=trim(clam.student.AGE)
				AND ''=trim(clam.student.DOB_FORMATTED)
				AND ''=trim(clam.student.CLASS)
				AND ''=trim(clam.student.COLLEGE_NAME)	
				AND ''=trim(clam.student.COLLEGE_CODE)
				AND ''=trim(clam.student.COLLEGE_TYPE)
				AND ''=trim(clam.student.INCOME_LEVEL_CODE)
				AND ''=trim(clam.student.FILE_TYPE)
				AND ''=trim(clam.student.rec_type)
				AND ''=trim(clam.student.COLLEGE_TIER), // no_AMS means all student fields are blank
				clam.student.file_type,
				clam.student.college_code,
				clam.student.college_type,
				clam.student.college_name);
	export rc9J := Risk_Indicators.rcSet.isCode9J( clam.historydate, clam.ssn_verification.header_first_seen, clam.ssn_verification.credit_first_seen );

export rc9K := Risk_Indicators.rcSet.isCode9K( clam.shell_input.addr_type );

export rc9L := clam.address_verification.distance_in_2_h1 > 0 and clam.address_verification.distance_in_2_h1 <= 50;
// export rc9M := clam.wealth_indicator < '5';
export rc9N := clam.other_address_info.isprison;
// export rc9O := (integer)clam.address_verification.input_address_information.eda_sourced = 0;
// export rc9P
export rc9Q := clam.acc_logs.inquiries.count12 > 0;
// export rc9R
export rc9S := trim(clam.address_verification.input_address_information.type_financing, LEFT, RIGHT) = 'ADJ';

export rc9T := clam.phone_verification.recent_disconnects > 0
	or StringLib.StringToUpperCase(clam.iid.nap_status) = 'D'
	or clam.iid.hriskphoneflag in ['5', '6']
	or clam.iid.hphonetypeflag in ['5', 'A']
	or clam.iid.hphonevalflag = '3'
	or clam.iid.phonezipflag = '1'
	or clam.iid.hriskphoneflag in ['1', '2', '3', '4']
	or (StringLib.StringToUpperCase(clam.iid.hphonetypeflag) in ['1', '2', '3', '6', '7', '9', 'A', 'U'] and clam.phone_verification.telcordia_type != '00');

export rc9U := (integer)clam.iid.addrcommflag > 0
	or StringLib.StringToUpperCase(clam.advo_input_addr.residential_or_business_ind) = 'B'
	or clam.other_address_info.isprison
	or StringLib.StringToUpperCase(clam.iid.addrvalflag) != 'V'
	or (integer)clam.iid.cityzipflag > 0
	or StringLib.StringToUpperCase(clam.advo_input_addr.address_vacancy_indicator) = 'Y'
	or StringLib.StringToUpperCase(clam.advo_input_addr.throw_back_indicator) = 'Y';

export rc9V := clam.iid.non_us_ssn
	or clam.iid.socsdobflag = '1'
	or clam.iid.pwsocsdobflag = '1'
	or clam.iid.socsvalflag = '1'
	or clam.iid.pwsocsvalflag in ['1', '2', '3', '4'];

export rc9W := (integer)clam.bjl.bankrupt > 0;



//isCodeA0
//isCodeA1
//isCodeA2
//isCodeA3
//isCodeA4
//isCodeA5
//isCodeA6
//isCodeA7
//isCodeA8
//isCodeA9
// export isCodeA9( unsigned4 dt_first_seen_min ) := ((INTEGER)(ut.GetDate[1..6]) - (INTEGER)((STRING)dt_first_seen_min[1..6])) < 200;

//isCodeB0
	export rcBO := Risk_Indicators.rcSet.isCodeBO(clam.header_summary.ver_sources);
	export rcCO := Risk_Indicators.rcSet.isCodeCO(clam.iid.zipclass);
	export rcCR := Risk_Indicators.rcSet.isCodeCR( clam.relatives.relative_felony_count );
//isCodeCZ
//isCodeDD
//isCodeDF
//isCodeDM
//isCodeDV
	export rcEV := Risk_Indicators.rcSet.IsCodeEV(
				clam.bjl.eviction_recent_unreleased_count,
				clam.bjl.eviction_recent_released_count,
				clam.bjl.eviction_historical_unreleased_count,
				clam.bjl.eviction_historical_released_count);
//isCodeIA
//isCodeIB
//isCodeIB_can
//isCodeIC
//isCodeIC_can
//isCodeID
//isCodeIE
//isCodeIF
//isCodeIG
//isCodeIH
//isCodeII 
//isCodeIJ 
//isCodeIK 
//isCodeIT
	export rcMI := Risk_Indicators.rcSet.IsCodeMI(clam.velocity_counters.adls_per_ssn_seen_18months);
	export rcMN := Risk_Indicators.rcSet.IsCodeMN( clam.iid.socllowissue, clam.historydate );

	export rcMO := Risk_Indicators.rcSet.isCodeMO(clam.iid.zipclass);

	export rcMS := Risk_Indicators.rcSet.IsCodeMS(clam.velocity_counters.ssns_per_adl_seen_18months);
	export rcPA := Risk_Indicators.rcSet.isCodePA(clam.iid.inputAddrNotMostRecent);
	export rcPO := Risk_Indicators.rcSet.isCodePO(clam.shell_input.addr_type);
	export rcPV := Risk_Indicators.rcSet.isCodePV(
				clam.iid.dwelltype,
				clam.address_verification.input_address_information.assessed_amount,
				clam.avm.input_address_information,
				(unsigned)clam.address_verification.input_address_information.census_home_value);

	export rcSR := Risk_Indicators.rcSet.isCodeSR(clam.iid.combo_sec_rangescore);

//isCodeU1
//isCodeU2
	export rcWL := Risk_Indicators.rcSet.isCodeWL(clam.iid.watchlist_table, clam.iid.watchlist_record_number);
//isCodeZI
	export rcCL := Risk_Indicators.rcSet.isCodeCL(
					clam.shell_input.ssn, 
					clam.iid.bestSSN, 
					clam.iid.socsverlevel, 
					clam.iid.combo_ssn);


	export rcFB := Risk_Indicators.rcSet.isCodeFB( clam.header_summary.ver_sources );
	export rcFQ := Risk_Indicators.rcSet.isCodeFQ( clam.acc_logs.inquiries.count12 );
	export rcFR := Risk_Indicators.rcSet.isCodeFR( clam.relatives.relative_criminal_count );
	export rcFV := Risk_Indicators.rcSet.isCodeFV( clam.advo_input_addr.address_vacancy_indicator );

	EXPORT rcRS := Risk_Indicators.rcSet.isCodeRS(clam.shell_input.ssn, clam.iid.socsvalflag, clam.iid.socllowissue, clam.iid.socsRCISflag);
	EXPORT rcIS := Risk_Indicators.rcSet.isCodeIS(clam.shell_input.ssn, clam.iid.socsvalflag, clam.iid.socllowissue, clam.iid.socsRCISflag);
END;



// isCode9O
// isCode9M
