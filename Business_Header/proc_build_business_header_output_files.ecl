IMPORT Business_Header, ut, versioncontrol, lib_fileservices, header_services,mdr;

export proc_build_business_header_output_files(

	 string																		pversion
	,dataset(Layout_Business_Header_Base		)	pBH_Base						= Files().Base.Business_Headers.built
	,dataset(Layout_Business_Relative				)	pBH_Relatives				= Files().Base.Business_Relatives.built
	,dataset(Layout_Business_Relative_Group	)	pBH_Relative_Group	= Files().Base.Business_Relatives_Group.built
	,dataset(Layout_Business_Header_Stat		)	pBH_Stat						= Files().Base.Stat.built											
                                                           
) := 
module

	shared bh1 := pBH_Base;

	shared in_hdr2 := bh1;// + header.transunion_did;

	full_out_suppress2 := project(Business_Header.Prep_Build.applyDidAddressBusiness_sup2(in_hdr2), Business_Header.Layout_Business_Header_Base);

	/////////////////////////////////////////////////////////////////////////
	// -- Start of moxie
	/////////////////////////////////////////////////////////////////////////

	bh := Business_Header.Prep_Build.applyBusinessHeaderInj(full_out_suppress2);
	
	bh_Filtered := filters.outs.business_headers(bh);

	Business_Header.Layout_Business_Header_Base fixbhdates(bh L) := transform
		self.dt_first_seen := map(validatedate((string8)L.dt_first_seen) = '' => 0, 
								L.dt_first_seen);
		self.dt_last_seen :=  map(validatedate((string8)L.dt_last_seen) = ''  => self.dt_first_seen, 
								L.dt_last_seen < self.dt_first_seen => self.dt_first_seen,
								L.dt_last_seen);
		self := L;
	end;

	bh_date_fix := project(if(Flags.Out.ShouldFilter, bh_Filtered, bh),  fixbhdates(left));

	// Rollup base to discard blank addresses if current clean name name, source, vendor_id exists with an address
	BH_Base_Dist := distribute(bh_date_fix, hash(source, trim(vendor_id), trim(match_company_name)));
	BH_Base_Sort := sort(BH_Base_Dist, source, vendor_id, match_company_name, if(current, 0, 1), if(zip <> 0, 0, 1), local);

	BH_Base_Rollup := rollup(BH_Base_Sort,
															 left.source = right.source and
															 left.vendor_id <> '' and right.vendor_id <> '' and left.vendor_id = right.vendor_id and 
								 left.match_company_name = right.match_company_name and
															 right.zip = 0
															 and left.bdid = right.bdid
															 ,
								 Business_Header.TRA_Merge_Business_Header_Base(left, right),
								 local);

	// Rollup and Project Business Header File into Accurint Business Search format
	Layout_Business_Header_Rollup := RECORD
	Business_Header.Layout_Business_Header_Out;
	STRING81 match_company_name;
	UNSIGNED2 phone_score;
	UNSIGNED6 rcid;
	END;

	Layout_Business_Header_Rollup InitForRollup(Business_Header.Layout_Business_Header_Base L) := TRANSFORM
	SELF.bdid := (STRING12)INTFORMAT(L.bdid, 12, 1);
	SELF.dt_first_seen := IF(L.dt_first_seen <> 0, (STRING8)L.dt_first_seen, '');
	SELF.dt_last_seen := IF(L.dt_last_seen <> 0, (STRING8)L.dt_last_seen, '');
	SELF.dt_vendor_first_reported := IF(L.dt_vendor_first_reported <> 0, (STRING8)L.dt_vendor_first_reported, '');
	SELF.dt_vendor_last_reported := IF(L.dt_vendor_last_reported <> 0, (STRING8)L.dt_vendor_last_reported, '');
	SELF.zip := IF(L.zip <> 0, (STRING5)INTFORMAT(L.zip, 5, 1), '');
	SELF.zip4 := IF(L.zip4 <> 0, (STRING4)INTFORMAT(L.zip4, 4, 1), '');
	SELF.phone := IF(L.phone <> 0, (STRING10)INTFORMAT(L.phone, 10, 1), '');
	SELF.fein := IF(L.fein <> 0, (STRING9) INTFORMAT(L.fein, 9, 1), '');
	SELF.current := IF(L.current, 'Y', 'N');
	
	SELF.gong_flag								:= IF(MDR.sourceTools.SourceIsGong_Business					(L.source)
																	or	MDR.sourceTools.SourceIsGong_Government				(L.source), 'Y', 'N');
	SELF.yellowpages_flag					:= IF(MDR.sourceTools.SourceIsYellow_Pages					(L.source), 'Y', 'N');
	SELF.corp_flag								:= IF(MDR.sourceTools.SourceIsCorpV2								(L.source), 'Y', 'N');
	SELF.ucc_flag									:= IF(MDR.sourceTools.SourceIsUCCS									(L.source), 'Y', 'N');
	SELF.bankruptcy_flag					:= IF(MDR.sourceTools.SourceIsBankruptcy						(L.source), 'Y', 'N');
	SELF.domain_flag							:= IF(MDR.sourceTools.SourceIsWhois_domains					(L.source), 'Y', 'N');
	SELF.fbn_flag									:= IF(MDR.sourceTools.SourceIsFBNV2									(L.source), 'Y', 'N');//deprecated
	SELF.busreg_flag							:= IF(MDR.sourceTools.SourceIsBusiness_Registration	(L.source), 'Y', 'N');
	SELF.edgar_flag								:= IF(MDR.sourceTools.SourceIsEdgar									(L.source), 'Y', 'N');
	SELF.dnb_flag									:= IF(MDR.sourceTools.SourceIsDunn_Bradstreet				(L.source), 'Y', 'N');
	SELF.irs_5500_flag						:= IF(MDR.sourceTools.SourceIsIRS_5500							(L.source), 'Y', 'N');
	SELF.employee_directory_flag	:= IF(MDR.sourceTools.SourceIsEmployee_Directories	(L.source), 'Y', 'N');
	SELF.fdic_flag								:= IF(MDR.sourceTools.SourceIsFDIC									(L.source), 'Y', 'N');
	SELF.sales_tax_flag						:= IF(MDR.sourceTools.SourceIsState_Sales_Tax				(L.source), 'Y', 'N');
	SELF.sec_broker_flag					:= IF(MDR.sourceTools.SourceIsSEC_Broker_Dealer			(L.source), 'Y', 'N');
	SELF.fl_non_profit_flag				:= IF(MDR.sourceTools.SourceIsFL_Non_Profit					(L.source), 'Y', 'N');
	SELF.workers_comp_flag				:= IF(MDR.sourceTools.SourceIsWorkmans_Comp					(L.source), 'Y', 'N');
	SELF.vickers_flag							:= IF(MDR.sourceTools.SourceIsVickers								(L.source), 'Y', 'N');
	SELF.irs_non_profit_flag			:= IF(MDR.sourceTools.SourceIsIRS_Non_Profit				(L.source), 'Y', 'N');
	SELF.prof_lic_flag						:= IF(MDR.sourceTools.SourceIsProfessional_License	(L.source), 'Y', 'N');
	SELF.fl_fbn_flag							:= IF(MDR.sourceTools.SourceIsFL_FBN								(L.source), 'Y', 'N');
	SELF.dea_flag									:= IF(MDR.sourceTools.SourceIsDea										(L.source), 'Y', 'N');
	SELF.tradeshow_flag						:= IF(MDR.sourceTools.SourceIsAccurint_Trade_Show		(L.source), 'Y', 'N');
	SELF.ska_flag									:= IF(MDR.sourceTools.SourceIsSKA										(L.source), 'Y', 'N');
	SELF.liens_flag								:= IF(MDR.sourceTools.SourceIsLiens									(L.source), 'Y', 'N');
	SELF.credit_union_flag				:= IF(MDR.sourceTools.SourceIsCredit_Unions					(L.source), 'Y', 'N');
	SELF.fcc_flag									:= IF(MDR.sourceTools.SourceIsFCC_Radio_Licenses		(L.source), 'Y', 'N');
	SELF.ebr_flag									:= IF(MDR.sourceTools.SourceIsEBR										(L.source), 'Y', 'N');
	SELF.bbb_member_flag					:= IF(MDR.sourceTools.SourceIsBBB_Member						(L.source), 'Y', 'N');
	SELF.bbb_nonmember_flag				:= IF(MDR.sourceTools.SourceIsBBB_Non_Member				(L.source), 'Y', 'N');
	SELF.infousa_abius_flag				:= IF(MDR.sourceTools.SourceIsINFOUSA_ABIUS_USABIZ	(L.source), 'Y', 'N');
	SELF.infousa_idexec_flag			:= IF(MDR.sourceTools.SourceIsINFOUSA_IDEXEC				(L.source), 'Y', 'N');
	SELF.infousa_deadco_flag			:= IF(MDR.sourceTools.SourceIsINFOUSA_DEAD_COMPANIES(L.source), 'Y', 'N');
	SELF.infousa_fbns_flag				:= IF(MDR.sourceTools.SourceIsFBNV2									(L.source), 'Y', 'N');
	SELF.vehicles_flag						:= IF(MDR.sourceTools.SourceIsVehicle								(L.source), 'Y', 'N');
	SELF.watercraft_flag					:= IF(MDR.sourceTools.sourceIsWC										(L.source), 'Y', 'N');
	SELF.ln_property_flag					:= IF(MDR.sourceTools.SourceIsLnPropertyV2					(L.source), 'Y', 'N');

	SELF.match_company_name := ut.CleanCompany(L.company_name);
	SELF.DPPA_State := if(L.dppa, L.vendor_id[1..2], '');
	SELF := L;
	END;

	BHF_Out_Init := PROJECT(BH_Base_Rollup, InitForRollup(LEFT));
	COUNT(BHF_Out_Init);

	// Determine if D&B source records match existing company information
	BHF_Out_DNB := BHF_Out_Init(MDR.sourceTools.SourceIsDunn_Bradstreet(source));
	BHF_Out_DNB_Dist := sort(DISTRIBUTE(BHF_Out_DNB, HASH(bdid)), 
				bdid,match_company_name, zip, prim_name,prim_range, rcid,local);

	BHF_Out_Not_DNB := BHF_Out_Init(not MDR.sourceTools.SourceIsDunn_Bradstreet(source));
	BHF_Out_Not_DNB_Dist := sort(DISTRIBUTE(BHF_Out_Not_DNB, HASH(bdid)),
				bdid,match_company_name, zip, prim_name,prim_range, rcid,local);

	Layout_Business_Header_Rollup MatchDNB(Layout_Business_Header_Rollup L, Layout_Business_Header_Rollup R) := transform
	SELF := R;
	END;

	BHF_Out_DNB_Match := JOIN(BHF_Out_Not_DNB_Dist,
														BHF_Out_DNB_Dist		,
														 LEFT.bdid = RIGHT.bdid AND
															 LEFT.match_company_name = RIGHT.match_company_name AND
															 LEFT.zip = RIGHT.zip AND
															 LEFT.prim_name = RIGHT.prim_name AND
															 LEFT.prim_range = RIGHT.prim_range,
														 MatchDNB(LEFT, RIGHT),
														 LOCAL
														 ,keep(1));

	BHF_Out_DNB_Match_Sort := SORT(BHF_Out_DNB_Match, rcid, LOCAL);
	BHF_Out_DNB_Match_Dedup := DEDUP(BHF_Out_DNB_Match_Sort, rcid, LOCAL);

	// Blank All indicative fields but company_name, city, and state for non-matched records
	Layout_Business_Header_Rollup FixNonMatchDNB(Layout_Business_Header_Rollup L, Layout_Business_Header_Rollup R) := transform
	SELF.prim_range := '';
	SELF.predir := '';
	SELF.prim_name := '';
	SELF.addr_suffix := '';
	SELF.postdir := '';
	SELF.unit_desig := '';
	SELF.sec_range := '';
	SELF.zip := '';
	SELF.zip4 := '';
	SELF.county := '';
	SELF.msa := '';
	SELF.geo_lat := '';
	SELF.geo_long := '';
	SELF.phone := '';
	SELF.fein := '';
	SELF := L;
	END;

	BHF_Out_DNB_Dist_rcid := sort(DISTRIBUTE(BHF_Out_DNB_Dist, HASH(rcid)), 
				rcid, local);

	BHF_Out_DNB_NoMatch := JOIN(BHF_Out_DNB_Dist_rcid,
															BHF_Out_DNB_Match_Dedup,
															LEFT.rcid = RIGHT.rcid,
															FixNonMatchDNB(LEFT, RIGHT),
															LEFT ONLY,
															LOCAL);

	// Determine if the NoMatch record is a standalone DNB Record
	BHF_Out_Not_DNB_Dist_Sort := SORT(BHF_Out_Not_DNB_Dist, bdid, local);
	BHF_Out_Not_DNB_Dist_Dedup := DEDUP(BHF_Out_Not_DNB_Dist_Sort, bdid, local);


	BHF_Out_DNB_NoMatch_matchdnb := sort(DISTRIBUTE(BHF_Out_DNB_NoMatch, HASH(bdid)), 
				bdid, local);

	BHF_Out_DNB_NoMatch_BDID := JOIN(BHF_Out_Not_DNB_Dist_Dedup,
																	 BHF_Out_DNB_NoMatch_matchdnb,
																	 LEFT.bdid = RIGHT.BDID,
																	 MatchDNB(LEFT, RIGHT),
																	 LOCAL);

	BHF_Out_DNB_NoMatch_BDID_Sort := SORT(BHF_Out_DNB_NoMatch_BDID, rcid, LOCAL);
	BHF_Out_DNB_NoMatch_BDID_Dedup := DEDUP(BHF_Out_DNB_NoMatch_BDID_Sort, rcid, LOCAL);


	BHF_Out_Fixed := BHF_Out_Not_DNB_Dist + BHF_Out_DNB_Match_Dedup + BHF_Out_DNB_NoMatch_BDID_Dedup;

	// Rollup Flags
	Layout_BDID_Flags := record
		string12  bdid;            // Seisint Business Identifier
		string1   current;          // 'Y' Indicates record current within source, otherwise historical
		string1   gong_flag;        // 'Y' Indicates Gong record(s) present
		string1   yellowpages_flag; // 'Y' Indicates YellowPages record(s) present
		string1   corp_flag;        // 'Y' Indicates Corporate record(s) present
		string1   ucc_flag;         // 'Y' Indicates UCC record(s) present
		string1   bankruptcy_flag;  // 'Y' Indicates Bankruptcy record(s) present
		string1   domain_flag;      // 'Y' Indicates Whois record(s) present
		string1   fbn_flag;         // 'Y' Indicates FBN record(s) present
		string1   busreg_flag;      // 'Y' Indicates Business Registration record(s) present
		string1   edgar_flag;       // 'Y' Indicates SEC EDGAR filing record(s) present
		string1   dnb_flag;         // 'Y' Indicated Dun and Bradstreet record(s) present
		string1   irs_5500_flag;    // 'Y' Indicates IRS 5500 record(s) present
		string1   employee_directory_flag;   // 'Y' Indicates Employee Directory record(s) present
		string1   fdic_flag;        // 'Y' Indicates FDIC record(s) present
		string1   sales_tax_flag;   // 'Y' Indicates State Sales Tax record(s) present
		string1   sec_broker_flag;  // 'Y' Indicates SEC Broker Dealer record(s) present
		string1   fl_non_profit_flag;// 'Y' Indicates FL Non-Profit Corporation record(s) present
		string1   workers_comp_flag;  // 'Y' Indicates State Worker's Comp record(s) present
		string1   vickers_flag;     // 'Y' Indicates Vickers record(s) present
		string1   irs_non_profit_flag;// 'Y' Indicates IRS Non Profit Organization record(s) present
		string1   prof_lic_flag;    // 'Y' Indicates Professional License record(s) present
		string1   fl_fbn_flag;       // 'Y' Indicates FL FBN record(s) present
		string1   dea_flag;         // 'Y' Indicates DEA record(s) present
		string1   tradeshow_flag;   // 'Y' Indicates Accurint Tradeshow record(s) present
		string1   ska_flag;         // 'Y' Indicates SKA record(s) present
		string1   liens_flag;		// 'Y' Indicates liens and judgment record(s) present
		string1   credit_union_flag;// 'Y' Indicates credit union record(s) present
	end;

	BHF_Flags_Dist := DISTRIBUTE(BHF_Out_Fixed, HASH(bdid));

	/////////////////////////////////////////////////////////////
	Layout_BDID_Flags InitFlags(Layout_Business_Header_Rollup L) := TRANSFORM
	SELF := L;
	END;

	BHF_Flags_Init := PROJECT(BHF_Flags_Dist, InitFlags(LEFT));
	BHF_Flags_Sort := SORT(BHF_Flags_Init, bdid, LOCAL);

	Layout_BDID_Flags RollupFlags(Layout_BDID_Flags L, Layout_BDID_Flags R) := TRANSFORM
	SELF.gong_flag := IF(R.gong_flag = 'Y', R.gong_flag, L.gong_flag);
	SELF.yellowpages_flag := IF(R.yellowpages_flag = 'Y', R.yellowpages_flag, L.yellowpages_flag);
	SELF.corp_flag := IF(R.corp_flag = 'Y', R.corp_flag, L.corp_flag);
	SELF.ucc_flag := IF(R.ucc_flag = 'Y', R.ucc_flag, L.ucc_flag);
	SELF.bankruptcy_flag := IF(R.bankruptcy_flag = 'Y', R.bankruptcy_flag, L.bankruptcy_flag);
	SELF.domain_flag := IF(R.domain_flag = 'Y', R.domain_flag, L.domain_flag);
	SELF.fbn_flag := IF(R.fbn_flag = 'Y', R.fbn_flag, L.fbn_flag);
	SELF.busreg_flag := IF(R.busreg_flag = 'Y', R.busreg_flag, L.busreg_flag);
	SELF.dnb_flag := IF(R.dnb_flag = 'Y', R.dnb_flag, L.dnb_flag);
	SELF.irs_5500_flag := IF(R.irs_5500_flag = 'Y', R.irs_5500_flag, L.irs_5500_flag);
	SELF.employee_directory_flag := IF(R.employee_directory_flag = 'Y', R.employee_directory_flag, L.employee_directory_flag);
	SELF.fdic_flag := IF(R.fdic_flag = 'Y', R.fdic_flag, L.fdic_flag);
	SELF.sales_tax_flag := IF(R.sales_tax_flag = 'Y', R.sales_tax_flag, L.sales_tax_flag);
	SELF.sec_broker_flag := IF(R.sec_broker_flag = 'Y', R.sec_broker_flag, L.sec_broker_flag);
	SELF.fl_non_profit_flag := IF(R.fl_non_profit_flag = 'Y', R.fl_non_profit_flag, L.fl_non_profit_flag);
	SELF.workers_comp_flag := IF(R.workers_comp_flag = 'Y', R.workers_comp_flag, L.workers_comp_flag);
	SELF.vickers_flag := IF(R.vickers_flag = 'Y', R.vickers_flag, L.vickers_flag);
	SELF.irs_non_profit_flag := IF(R.irs_non_profit_flag = 'Y', R.irs_non_profit_flag, L.irs_non_profit_flag);
	SELF.prof_lic_flag := IF(R.prof_lic_flag = 'Y', R.prof_lic_flag, L.prof_lic_flag);
	SELF.fl_fbn_flag := IF(R.fl_fbn_flag = 'Y', R.fl_fbn_flag, L.fl_fbn_flag);
	SELF.dea_flag := IF(R.dea_flag = 'Y', R.dea_flag, L.dea_flag);
	SELF.tradeshow_flag := IF(R.tradeshow_flag = 'Y', R.tradeshow_flag, L.tradeshow_flag);
	SELF.ska_flag := IF(R.ska_flag = 'Y', R.ska_flag, L.ska_flag);
	SELF.liens_flag := IF(R.liens_flag = 'Y', R.liens_flag, L.liens_flag);
	SELF.credit_union_flag := IF(R.credit_union_flag = 'Y', R.credit_union_flag, L.credit_union_flag);
	SELF := L;
	END;

	BHF_Flags_Rollup := ROLLUP(BHF_Flags_Sort,
													 LEFT.bdid = RIGHT.bdid,
													 RollupFlags(LEFT, RIGHT),
													 LOCAL);

	// Replace Flags on records with rolled up flags by BDID
	Layout_Business_Header_Rollup ReplaceFlags(Layout_Business_Header_Rollup L, Layout_BDID_Flags R) := TRANSFORM
	SELF.current := R.current;
	SELF.gong_flag := R.gong_flag;
	SELF.yellowpages_flag := R.yellowpages_flag;
	SELF.corp_flag := R.corp_flag;
	SELF.ucc_flag := R.ucc_flag ;
	SELF.bankruptcy_flag := R.bankruptcy_flag;
	SELF.domain_flag := R.domain_flag;
	SELF.fbn_flag := R.fbn_flag;
	SELF.busreg_flag := R.busreg_flag;
	SELF.edgar_flag := R.edgar_flag;
	SELF.dnb_flag := R.dnb_flag;
	SELF.irs_5500_flag := R.irs_5500_flag;
	SELF.employee_directory_flag := R.employee_directory_flag;
	SELF.fdic_flag := R.fdic_flag;
	SELF.sales_tax_flag := R.sales_tax_flag;
	SELF.sec_broker_flag := R.sec_broker_flag;
	SELF.fl_non_profit_flag := R.fl_non_profit_flag;
	SELF.workers_comp_flag := R.workers_comp_flag;
	SELF.vickers_flag := R.vickers_flag;
	SELF.irs_non_profit_flag := R.irs_non_profit_flag;
	SELF.prof_lic_flag := R.prof_lic_flag;
	SELF.fl_fbn_flag := R.fl_fbn_flag;
	SELF.dea_flag := R.dea_flag;
	SELF.tradeshow_flag := R.tradeshow_flag;
	SELF.ska_flag := R.ska_flag;
	SELF.liens_flag := R.liens_flag;
	SELF.credit_union_flag := R.credit_union_flag;
	SELF := L;
	END;


	BHF_Out_Flags := JOIN(BHF_Flags_Dist,
												BHF_Flags_Rollup,
							LEFT.bdid = RIGHT.bdid,
							ReplaceFlags(LEFT, RIGHT),
							LEFT OUTER,
							LOCAL);
							 
	// Keep only highest scoring phone numbers for bdid, company, address, fein
	BHF_Out_Dist := DISTRIBUTE(BHF_Flags_Dist, HASH(bdid, TRIM(match_company_name), zip));
	BHF_Out_Sort := SORT(BHF_Out_Dist, bdid, source, match_company_name, zip, prim_name, prim_range,
											 IF(phone<> '', 0, 1), -phone_score, phone, Business_Header.Map_Source_Hierarchy(source),
											 IF(fein <> '', 0, 1), fein,
											 IF(sec_range <> '', 0, 1), sec_range,
											 LOCAL);

	Layout_Business_Header_Rollup RollupBHF(Layout_Business_Header_Rollup L, Layout_Business_Header_Rollup R) := TRANSFORM
	SELF.dt_first_seen := MAP(L.dt_first_seen = ''
														 OR (L.dt_first_seen <> '' AND R.dt_first_seen <> '' AND R.dt_first_seen < L.dt_first_seen) => R.dt_first_seen,
														L.dt_first_seen);
	SELF.dt_last_seen := MAP(L.dt_last_seen = ''
														 OR (L.dt_last_seen <> '' AND R.dt_last_seen <> '' AND R.dt_last_seen > L.dt_last_seen) => R.dt_last_seen,
														L.dt_last_seen);
	SELF.dt_vendor_first_reported := MAP(L.dt_vendor_first_reported = ''
														 OR (L.dt_vendor_first_reported <> '' AND R.dt_vendor_first_reported <> '' AND R.dt_vendor_first_reported < L.dt_vendor_first_reported) => R.dt_vendor_first_reported,
														L.dt_vendor_first_reported);
	SELF.dt_vendor_last_reported := MAP(L.dt_vendor_last_reported = ''
														 OR (L.dt_vendor_last_reported <> '' AND R.dt_vendor_last_reported <> '' AND R.dt_vendor_last_reported > L.dt_vendor_last_reported) => R.dt_vendor_last_reported,
														L.dt_vendor_last_reported);
	SELF := L;
	END;

	BHF_Out_Rollup := ROLLUP(BHF_Out_Sort,
													 LEFT.bdid = RIGHT.bdid AND
							 LEFT.source = RIGHT.source AND
													 LEFT.match_company_name = RIGHT.match_company_name AND
													 LEFT.zip = RIGHT.zip AND
													 LEFT.prim_name = RIGHT.prim_name AND
													 LEFT.prim_range = RIGHT.prim_range AND
													 (RIGHT.sec_range = '' OR LEFT.sec_range = RIGHT.sec_range) AND
													 (RIGHT.fein = '' OR LEFT.fein = RIGHT.fein),
													 RollupBHF(LEFT, RIGHT),
													 LOCAL);

	COUNT(BHF_Out_Rollup);

	// Stat to determine uniqueness of match company name
	Layout_Company_Name := record
	BHF_Out_Rollup.match_company_name;
	end;

	Company_Names := table(BHF_Out_Rollup, Layout_Company_name);

	Layout_Company_Name_Stat := record
	Company_Names.match_company_name;
	unsigned4 cnt := count(group);
	end;

	Company_Name_Stat := table(Company_Names, Layout_Company_Name_Stat, match_company_name);
	Company_Name_Stat_Dist := distribute(Company_Name_Stat(cnt=1), hash(match_company_name));

	// Filter out blank address records, unless they have a phone or fein or city,state or company name is unique
	BHF_Out_Filtered := BHF_Out_Rollup(zip <> '' or (zip = '' and (MDR.sourceTools.SourceIsDunn_Bradstreet(source) or phone <> '' or fein <> '' or (city <> '' and state <> ''))));
	BHF_Out_Blank_Address := BHF_Out_Rollup(not(zip <> '' or (zip = '' and (MDR.sourceTools.SourceIsDunn_Bradstreet(source) or phone <> '' or fein <> '' or (city <> '' and state <> '')))));
	BHF_Out_Blank_Address_Dist := distribute(BHF_Out_Blank_Address, hash(match_company_name));

	Layout_Business_Header_Rollup SelectUniqueCompany(Layout_Business_Header_Rollup l, Layout_Company_Name_Stat r) := transform
	self := l;
	end;

	BHF_Out_Blank_Address_Unique := join(BHF_Out_Blank_Address_Dist,
																			 Company_Name_Stat_Dist,
										 left.match_company_name = right.match_company_name,
										 SelectUniqueCompany(left, right),
										 local);

	BHF_Out_Combined := BHF_Out_Rollup;						 
										 
	Business_Header.Layout_Business_Header_Out FormatOutput(Layout_Business_Header_Rollup L) := TRANSFORM
	SELF := L;
	END;

	shared BHF_Out := PROJECT(BHF_Out_Combined, FormatOutput(LEFT));



	///////////////////////////////////////////////////////////////////////////////////////////
	// Generate the Business Relatives Output file
	///////////////////////////////////////////////////////////////////////////////////////////

	Business_Header.Layout_Business_Relatives_Out FormatBusinessRelatives(Business_Header.Layout_Business_Relative l) := transform
	self.bdid1 := (string12)intformat(l.bdid1, 12, 1);
	self.bdid2 := (string12)intformat(l.bdid2, 12, 1);
	self.corp_charter_number := if(l.corp_charter_number, 'Y', 'N');
	self.business_registration := if(l.business_registration, 'Y', 'N');
	self.bankruptcy_filing := if(l.bankruptcy_filing, 'Y', 'N');
	self.duns_number := if(l.duns_number, 'Y', 'N');
	self.duns_tree := if(l.duns_tree, 'Y', 'N');
	self.edgar_cik := if(l.edgar_cik, 'Y', 'N');
	self.name := if(l.name, 'Y', 'N');
	self.name_address := if(l.name_address, 'Y', 'N');
	self.name_phone := if(l.name_phone, 'Y', 'N');
	self.gong_group := if(l.gong_group, 'Y', 'N');
	self.ucc_filing := if(l.ucc_filing, 'Y', 'N');
	self.fbn_filing := if(l.fbn_filing, 'Y', 'N');
	self.fein := if(l.fein, 'Y', 'N');
	self.phone := if(l.phone, 'Y', 'N');
	self.addr := if(l.addr, 'Y', 'N');
	self.mail_addr := if(l.mail_addr, 'Y', 'N');
	self.dca_company_number := if(l.dca_company_number, 'Y', 'N');
	self.dca_hierarchy := if(l.dca_hierarchy, 'Y', 'N');
	self.abi_number := if(l.abi_number, 'Y', 'N');
	self.abi_hierarchy := if(l.abi_hierarchy, 'Y', 'N');
	self.rel_group := if(l.rel_group, 'Y', 'N');
	end;

	// Remove relatives with name relationship only
	br := pBH_Relatives;

	emptyBusinessRelatives := DATASET([], business_header.Layout_Business_Relative);
  relatives_base_file_append := Business_Header.Prep_Build.applyBusinessRelativesInj(emptyBusinessRelatives); 

  Suppression_Layout := header_services.Supplemental_Data.layout_in;

	header_services.Supplemental_Data.mac_verify('businessrelatives_sup.txt', Suppression_Layout, supp_ds_func);

	Suppression_In := supp_ds_func();

	dRelativesSuppressedIn := project(Suppression_In, Suppress.applyRegulatory.in_to_out(left));

	rHashBDID := Suppress.applyRegulatory.layout_out;

	rFullOut_HashBDID := record
	 business_header.Layout_Business_Relative;
	 rHashBDID hash1;
	 rHashBDID hash2;
	end;

	rFullOut_HashBDID tHashBDID(business_header.Layout_Business_Relative l) := transform                            
		self.hash1.hval := hashmd5(intformat(l.bdid1,12,1),intformat(l.bdid2,12,1));
		self.hash2.hval := hashmd5(intformat(l.bdid2,12,1),intformat(l.bdid1,12,1));
		self := l;
	end;
	 
	dHeader_withMD5 := project(br, tHashBDID(left));

	business_header.Layout_Business_Relative tSuppress(dHeader_withMD5 l, dRelativesSuppressedIn r) := transform
	 self := l;
	end;

	full_out_suppress := join(dHeader_withMD5,
													dRelativesSuppressedIn,
													(left.hash1.hval = right.hval) or (left.hash2.hval = right.hval),
													tSuppress(left,right),
													left only,
													all);

	full_out_suppress2 := full_out_suppress + Relatives_Base_File_Append;

	br_filtered := filters.outs.business_Relatives(full_out_suppress2); 

	shared BH_Relatives_Out := project(if(Flags.Out.ShouldFilter, br_filtered, full_out_suppress2)
	(
	 corp_charter_number or
	 business_registration or
	 bankruptcy_filing or
	 duns_number or
	 duns_tree or
	 edgar_cik or
	 name_address or
	 name_phone or
	 gong_group or
	 ucc_filing or
	 fbn_filing or
	 fein or
	 phone or
	 addr or
	 mail_addr or
	 dca_company_number or
	 dca_hierarchy or
	 abi_number or
	 abi_hierarchy), FormatBusinessRelatives(left));

	///////////////////////////////////////////////////////////
	// Generate the Business Relatives Group Output File
	///////////////////////////////////////////////////////////
	Business_Header.Layout_Business_Relatives_Group_Out FormatBusinessRelativesGroup(Business_Header.Layout_Business_Relative_Group l) := transform
	self.group_id := (string12)intformat(l.group_id, 12, 1);
	self.bdid := (string12)intformat(l.bdid, 12, 1);
	self := l;
	end;

	brg := pBH_Relative_Group;
	brg_filter := filters.outs.business_Relatives_Group(pBH_Relative_Group);

	shared BH_Relatives_Group_Out := project(if(Flags.Out.ShouldFilter, brg_filter, brg), FormatBusinessRelativesGroup(left));


	///////////////////////////////////////////////////////////
	// Generate the Business Header Best File
	///////////////////////////////////////////////////////////
	Business_Header.Layout_BH_Best_Out FormatBHBest(Business_Header.Layout_BH_Best L) := transform
	SELF.bdid := (STRING12)INTFORMAT(L.bdid, 12, 1);
	SELF.zip := IF(L.zip <> 0, (STRING5)INTFORMAT(L.zip, 5, 1), '');
	SELF.zip4 := IF(L.zip4 <> 0, (STRING4)INTFORMAT(L.zip4, 4, 1), '');
	SELF.phone := IF(L.phone <> 0, (STRING10)INTFORMAT(L.phone, 10, 1), '');
	SELF.fein := IF(L.fein <> 0, (STRING9) INTFORMAT(L.fein, 9, 1), '');
	SELF := L;
	end;

	//CNG W20070816-150957 dat//////////////////////////////////

	Drop_Header_Layout2 := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
	Record
		string15 	bdid;	         
		string10 	dt_last_seen;
		string120 company_name;
		string10 	prim_range;
		string2   predir;
		string28 	prim_name;
		string4  	addr_suffix;
		string2   postdir;
		string5  	unit_desig;
		string8  	sec_range;
		string25 	city;
		string2   state;
		string8 	zip;
		string5 	zip4;
		string15 	phone;
		string10 	fein;       
		string3 	best_flags;
		string2   source;	 
		string2   DPPA_State;
		string2 	eor;
	end;

	header_services.Supplemental_Data.mac_verify('file_business_best_inj.txt', Drop_Header_Layout2, attr);

	Base_File_Append_In2 := attr();

	business_header.Layout_BH_Best reformat_header2(Base_File_Append_In2 L) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
	 transform
		self.bdid := (unsigned6) L.bdid;
		self.dt_last_seen := (unsigned4) L.dt_last_seen;
		self.zip := (unsigned3) L.zip;
		self.zip4 := (unsigned2) L.zip4;
		self.phone := (unsigned6) L.phone;
		self.fein := (unsigned4) L.fein;
		self.best_flags := (unsigned1) l.best_flags;
		self := L;
	 end;	 
	 
	Base_File_Append2 := project(Base_File_Append_In2, reformat_header2(left)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

	/////////////////////////////////////////////////////
 
  //Recreate best file to remove EBR data.  It can stay in the base file but not the out file.
	in_hdr := Business_Header.BestAll(filters.outs.business_header_best(pBH_Base), MDR.sourceTools.src_EBR,true);	//want to convert source codes back to old ones

	mainDataSet := in_hdr + Base_File_Append2;

	f_bbs := join(	mainDataSet, 
									Base_File_Append2,
									left.bdid = right.bdid,
									left only,
									lookup);


	rDataSet := f_bbs + Base_File_Append2;
	/////////////////////////////////////////////////////
	best_full_out_suppress := project(Business_Header.Prep_Build.applyDidAddressBusiness_sup2(rDataSet), Business_Header.Layout_BH_Best);

	bhb := best_full_out_suppress;

	shared BH_Best_Out := project(bhb, FormatBHBest(left));

	string6 format_stat(unsigned4 i) := INTFORMAT(i, 6, 1);

	// Generate the Business Header Stats File
	shared Business_Header.Layout_Business_Header_Stat_Out FormatBHStat(Business_Header.Layout_Business_Header_Stat L) := TRANSFORM
	SELF.bdid := (STRING12)INTFORMAT(L.bdid, 12, 1);
	SELF.base_record_count := format_stat(L.base_record_count);
	SELF.corp_charter_number_relative_count := format_stat(L.corp_charter_number_relative_count);
	SELF.business_registration_relative_count := format_stat(L.business_registration_relative_count);
	SELF.bankruptcy_filing_relative_count := format_stat(L.bankruptcy_filing_relative_count);
	SELF.duns_number_relative_count := format_stat(L.duns_number_relative_count);
	SELF.duns_tree_relative_count := format_stat(L.duns_tree_relative_count);
	SELF.edgar_cik_relative_count := format_stat(L.edgar_cik_relative_count);
	SELF.name_relative_count := format_stat(L.name_relative_count);
	SELF.name_address_relative_count :=format_stat(L.name_address_relative_count);
	SELF.name_phone_relative_count := format_stat(L.name_phone_relative_count);
	SELF.gong_group_relative_count := format_stat(L.gong_group_relative_count);
	SELF.ucc_filing_relative_count := format_stat(L.ucc_filing_relative_count);
	SELF.fbn_filing_relative_count := format_stat(L.fbn_filing_relative_count);
	SELF.fein_relative_count := format_stat(L.fein_relative_count);
	SELF.phone_relative_count := format_stat(L.phone_relative_count);
	SELF.addr_relative_count := format_stat(L.addr_relative_count);
	SELF.mail_addr_relative_count := format_stat(L.mail_addr_relative_count);
	SELF.dca_company_number_relative_count := format_stat(L.dca_company_number_relative_count);
	SELF.dca_hierarchy_relative_count := format_stat(L.dca_hierarchy_relative_count);
	SELF.abi_number_relative_count := format_stat(L.abi_number_relative_count);
	SELF.abi_hierarchy_relative_count := format_stat(L.abi_hierarchy_relative_count);
	END;

	shared bhstats := pBH_Stat;

	shared bh_Stat_overflow := bhstats(business_header.isStatOverflow(bhstats));

	shared bhs_filter := filters.outs.business_header_stat(pBH_Stat);

	shared BH_Stat_Out := project(if(Flags.Out.ShouldFilter, bhs_filter, bhstats),FormatBHStat(LEFT));

	////////////////////////////////////////////////////////////////////////////////////////////////
	shared Outnames		:= filenames(pversion).out	;
	shared Basenames	:= filenames(pversion).base	;

	// Create the Business Contacts Output File
	VersionControl.macBuildNewLogicalFile( Outnames.Search.new					,BHF_Out								,BuildHeaderout								);
	VersionControl.macBuildNewLogicalFile( Outnames.Relatives.new				,BH_Relatives_Out				,BuildRelativesOut						);
	VersionControl.macBuildNewLogicalFile( Outnames.RelativesGroup.new	,BH_Relatives_Group_Out	,BuildRelativesGroupOut	,false);
	VersionControl.macBuildNewLogicalFile( Outnames.HeaderBest.new			,BH_Best_Out						,BuildHeaderBestOut						);
	VersionControl.macBuildNewLogicalFile( Outnames.Stat.new						,BH_Stat_Out						,BuildStatOut									);
	VersionControl.macBuildNewLogicalFile( Basenames.StatOverflow.new		,bh_Stat_overflow				,BuildStatOverflowOut					);
                                //use newest stat overflow file just written out--otherwise in resubmits
                                //it will run this graph every time
	shared stat_overflow_check := output(count(Files(pversion).Base.StatOverflow.new), named('STAT_OVERFLOW_HAD_BETTER_BE_ZERO'));

	outs :=
	sequential(
		parallel(
			 BuildHeaderout					
			,BuildRelativesOut			
			,BuildRelativesGroupOut	
			,BuildHeaderBestOut			
			,BuildStatOut						
			,BuildStatOverflowOut		
			
		)
		,stat_overflow_check
	);
	
	export all := 
	sequential(
		 outs
		,promote(pversion,'^(?!.*?contact.*).*?out::business_header.*?').new2built
		,promote(pversion,'stat_overflow').new2built
	);

end;