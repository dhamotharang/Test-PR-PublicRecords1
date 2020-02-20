/*--SOAP--
<message name="CDIP_Batch_Service" wuTimeout="300000">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/> 
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
</message>
*/

import STD, address, riskwise, ut, gateway, AutoStandardI, risk_indicators;

export CDIP_Batch_Service := MACRO

	// Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
	
	unsigned1 DPPA := 0 : stored('DPPAPurpose');
	unsigned1 GLB  := AutoStandardI.Constants.GLBPurpose_default : stored('GLBPurpose');
	string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	string10 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
  unsigned1 ofac_version_      := 1        : stored('OFACVersion');
  

	batch_in       := dataset([],Risk_Indicators.CDIP_Layouts.Batch_In) : STORED('batch_in',few);
  gateways_in := Gateway.Configuration.Get();
	history_date   := 999999 : stored('HistoryDateYYYYMM');
  
  // CCPA Fields
  unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
  string TransactionID := '' : stored ('_TransactionId');
  string BatchUID := '' : stored('_BatchUID');
  unsigned6 GlobalCompanyId := 0 : stored('_GCID');
  
Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := if(ofac_version_ = 4 and le.servicename = 'bridgerwlc', le.servicename, '');
	self.url := if(ofac_version_ = 4 and le.servicename = 'bridgerwlc', le.url, ''); 	
  self := le;
end;
gateways := project(gateways_in, gw_switch(left));


	/* IID & Boca Shell Values */
	isUtility           := false;
	isLN                := false;
	includeRel          := true;
	includeDL           := true;
	includeVeh          := true;
	includeDerog        := true;
	bsVersion           := 2;
	isFCRA              := false;
	ln_branded          := false;
	ofac_only           := true;
	suppressNearDups    := false;
	require2ele         := false;
	from_biid           := false;
	excludeWatchlists   := false;
	from_IT1O           := false;
	ofac_version        := ofac_version_;
	include_ofac        := if(ofac_version = 1, false, true);
	addtl_watchlists    := false;
	watchlist_threshold := if(ofac_version in [1, 2, 3], 0.84, 0.85);
	dob_radius          := -1;
	includeRelativeInfo := true;
	includeDLInfo       := true;
	includeVehInfo      := true;
	includeDerogInfo    := true;
	doScore             := true;
	nugen               := true;
	unsigned1 AppendBest := 1;		// search best file
	
if(ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));
	
	layout_acctno := record
		unsigned4 input_seq;
		string30 acctno;
		Risk_Indicators.Layout_Input;
	end;
	

	// this transform copied from RiskView_Batch_Service with minor cleanup and code to allow for retrieval of input seq and acctno
	layout_acctno iidPrep( batch_in le, integer c ) := TRANSFORM
		// save input data for output
		self.input_seq := le.seq;
		self.acctno := le.acctno;
	
		self.seq := c; // input seq is overwritten. abandon all hope, ye who enter here.
		historydate := if(le.HistoryDateYYYYMM=0, history_date, le.HistoryDateYYYYMM);
		self.historydate := historydate;
		self.ssn := le.ssn;
		self.dob := riskwise.cleandob(le.dob);
		self.age := if ((integer)le.age = 0 and (integer)le.dob != 0, (string3)ut.Age((integer)le.dob), (le.age));
		
		self.phone10  := RiskWise.CleanPhone(le.home_phone);
		self.wphone10 := RiskWise.CleanPhone(le.work_phone);
		
		cleaned_name := address.CleanPerson73(le.UnParsedFullName);
		boolean valid_cleaned := le.UnParsedFullName <> '';
		
		self.fname  := STD.STR.ToUpperCase(if(le.Name_First=''   AND valid_cleaned, cleaned_name[6..25], le.Name_First));
		self.lname  := STD.STR.ToUpperCase(if(le.Name_Last=''    AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
		self.mname  := STD.STR.ToUpperCase(if(le.Name_Middle=''  AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
		self.suffix := STD.STR.ToUpperCase(if(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix));	
		self.title  := STD.STR.ToUpperCase(if(valid_cleaned, cleaned_name[1..5],''));

		street_address := risk_indicators.MOD_AddressClean.street_address(le.street_addr, le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
		clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;											




		SELF.in_streetAddress := street_address;
		SELF.in_city          := le.p_City_name;
		SELF.in_state         := le.St;
		SELF.in_zipCode       := le.Z5;
			
		self.prim_range    := clean_a2[1..10];
		self.predir        := clean_a2[11..12];
		self.prim_name     := clean_a2[13..40];
		self.addr_suffix   := clean_a2[41..44];
		self.postdir       := clean_a2[45..46];
		self.unit_desig    := clean_a2[47..56];
		self.sec_range     := clean_a2[57..65];
		self.p_city_name   := clean_a2[90..114];
		self.st            := clean_a2[115..116];
		self.z5            := clean_a2[117..121];
		self.zip4          := clean_a2[122..125];
		self.lat           := clean_a2[146..155];
		self.long          := clean_a2[156..166];
		self.addr_type     := clean_a2[139];
		self.addr_status   := clean_a2[179..182];
		self.county        := clean_a2[143..145];
		self.geo_blk       := clean_a2[171..177];



		self.dl_number := STD.STR.ToUpperCase(riskwise.cleanDL_num(le.dl_number));
		self.dl_state  := STD.STR.ToUpperCase(le.dl_state);
		
		self := [];
	END;
	iid_prep_acct := PROJECT(batch_in, iidPrep(LEFT,COUNTER));

	iid_prep := project( iid_prep_acct, risk_indicators.Layout_Input );

                    
	iid := risk_indicators.InstantID_Function(iid_prep, 
		gateways, 
		dppa, 
		glb, 
		isUtility, 
		ln_branded, 
		ofac_only,
		suppressNearDups,
		require2ele,
		isFCRA,
		from_biid,
		ExcludeWatchLists,
		from_IT1O,
		ofac_version,
		include_ofac,
		addtl_watchlists,
		watchlist_threshold,
		dob_radius,
		bsversion,
		in_DataRestriction := DataRestriction,
		in_append_best := AppendBest, 
		in_DataPermission := DataPermission,
        LexIdSourceOptout := LexIdSourceOptout, 
        TransactionID := TransactionID, 
        BatchUID := BatchUID, 
        GlobalCompanyID := GlobalCompanyID
	);

	clam := risk_indicators.Boca_Shell_Function(
		iid,
		gateways,
		dppa,
		glb,
		isUtility,
		ln_branded,
		includeRel,
		includeDL,
		includeVeh,
		includeDerog,
		bsversion,
		doScore,
		nugen,
		DataRestriction := DataRestriction, 
		DataPermission := DataPermission,
        LexIdSourceOptout := LexIdSourceOptout, 
        TransactionID := TransactionID, 
        BatchUID := BatchUID, 
        GlobalCompanyID := GlobalCompanyID
	);

	
	
	Risk_Indicators.CDIP_Layouts.Batch_Out toOut( clam le, iid_prep_acct ri ) := TRANSFORM
		self.seq                                  := (string)ri.input_seq;
		self.acctno                               := ri.acctno;
		
		self.did                                  := (string12)le.did;

		/* Input */
		self.unit_desig                           := le.shell_input.unit_desig;
		self.addr_type                            := le.shell_input.addr_type;

		/* InstantID */
		self.NAS_Summary                          := (string2) le.iid.NAS_Summary;
		self.NAP_Summary                          := (string2) le.iid.NAP_Summary;
		self.nap_type                             := le.iid.nap_type;
		self.nap_status                           := le.iid.nap_status;
		self.CVI                                  := (string2) le.iid.CVI;
		self.reason1                              := le.iid.reason1;
		self.reason2                              := le.iid.reason2;
		self.reason3                              := le.iid.reason3;
		self.reason4                              := le.iid.reason4;
		self.reason5                              := le.iid.reason5;
		self.reason6                              := le.iid.reason6;
		// self.hriskphoneflag                       := le.iid.hriskphoneflag;
		self.hphonetypeflag                       := le.iid.hphonetypeflag;
		// self.phonevalflag                         := le.iid.phonevalflag;
		self.hphonevalflag                        := le.iid.hphonevalflag;
		// self.phonezipflag                         := le.iid.phonezipflag;
		self.PWphonezipflag                       := le.iid.PWphonezipflag;
		self.phonedissflag                        := if( le.iid.phonedissflag, '1', '0' );
		self.wphonedissflag                       := if( le.iid.wphonedissflag, '1', '0' );
		self.hriskaddrflag                        := le.iid.hriskaddrflag;
		self.decsflag                             := le.iid.decsflag;
		self.socsdobflag                          := le.iid.socsdobflag;
		// self.PWsocsdobflag                        := le.iid.PWsocsdobflag;
		// self.socsvalflag                          := le.iid.socsvalflag;
		// self.PWsocsvalflag                        := le.iid.PWsocsvalflag;
		self.soclhighissue                        := le.iid.soclhighissue;
		self.addrvalflag                          := le.iid.addrvalflag;
		// self.dwelltype                            := le.iid.dwelltype;
		self.bansflag                             := le.iid.bansflag;
		self.Sources                              := le.iid.Sources;
		self.firstcount                           := (string5) le.iid.firstcount;
		self.lastcount                            := (string5) le.iid.lastcount;
		self.addrcount                            := (string5) le.iid.addrcount;
		self.socscount                            := (string5) le.iid.socscount;
		self.numelever                            := (string5) le.iid.numelever;
		self.phoneaddr_addrcount                  := (string5) le.iid.phoneaddr_addrcount;
		self.phoneaddr_phonecount                 := (string5) le.iid.phoneaddr_phonecount;
		self.utiliaddr_addrcount                  := (string5) le.iid.utiliaddr_addrcount;
		self.utiliaddr_phonecount                 := (string5) le.iid.utiliaddr_phonecount;
		self.hphonemiskeyflag                     := if( le.iid.hphonemiskeyflag, '1', '0' );
		self.addrmiskeyflag                       := if( le.iid.addrmiskeyflag, '1', '0' );
		self.hrisksic                             := le.iid.hrisksic;
		self.hrisksicphone                        := le.iid.hrisksicphone;
		// self.zipclass                             := le.iid.zipclass;
		self.cityzipflag                          := le.iid.cityzipflag;
		self.combo_ssnscore                       := (string3) le.iid.combo_ssnscore;
		self.combo_dobscore                       := (string3) le.iid.combo_dobscore;
		// self.combo_cmpyscore                      := (string3) le.iid.combo_cmpyscore; // removed, as company info won't be populated
		self.combo_firstcount                     := (string3) le.iid.combo_firstcount;
		self.combo_lastcount                      := (string3) le.iid.combo_lastcount;
		self.combo_addrcount                      := (string3) le.iid.combo_addrcount;
		self.watchlistHit                         := if( le.iid.watchlistHit, '1', '0' );


		/* Source Verification Data */
		self.EQ_count                             := (string5) le.Source_Verification.EQ_count;
		self.TU_count                             := (string5) le.Source_Verification.TU_count;
		self.DL_count                             := (string5) le.Source_Verification.DL_count;
		self.PR_count                             := (string5) le.Source_Verification.PR_count;
		self.V_count                              := (string5) le.Source_Verification.V_count;
		self.EM_count                             := (string5) le.Source_Verification.EM_count;
		self.W_count                              := (string5) le.Source_Verification.W_count;

		/* Available Sources */
		self.dl_available                         := if( le.Available_Sources.DL, '1', '0' );
		self.voter_available                      := if( le.Available_Sources.voter, '1', '0' );


		/* Name Verification */
		self.adl_score                            := (string3) le.Name_Verification.adl_score;
		self.source_count                         := (string3) le.Name_Verification.source_count;
		self.fname_credit_sourced                 := if( le.Name_Verification.fname_credit_sourced, '1', '0' );
		self.lname_credit_sourced                 := if( le.Name_Verification.lname_credit_sourced, '1', '0' );
		self.fname_tu_sourced                     := if( le.Name_Verification.fname_tu_sourced, '1', '0' );
		self.lname_tu_sourced                     := if( le.Name_Verification.lname_tu_sourced, '1', '0' );
		self.fname_eda_sourced                    := if( le.Name_Verification.fname_eda_sourced, '1', '0' );
		self.lname_eda_sourced                    := if( le.Name_Verification.lname_eda_sourced, '1', '0' );
		self.fname_dl_sourced                     := if( le.Name_Verification.fname_dl_sourced, '1', '0' );
		self.lname_dl_sourced                     := if( le.Name_Verification.lname_dl_sourced, '1', '0' );
		self.fname_voter_sourced                  := if( le.Name_Verification.fname_voter_sourced, '1', '0' );
		self.lname_voter_sourced                  := if( le.Name_Verification.lname_voter_sourced, '1', '0' );
		self.fname_utility_sourced                := if( le.Name_Verification.fname_utility_sourced, '1', '0' );
		self.lname_utility_sourced                := if( le.Name_Verification.lname_utility_sourced, '1', '0' );
		self.Age                                  := (string3) le.Name_Verification.Age;

		/* ADDRESS */
		/* Input Address */
		self.addr1_House_Number_match             := if( le.Address_Verification.Input_Address_Information.House_Number_match, '1', '0' );
		self.addr1_isbestmatch                    := if( le.Address_Verification.Input_Address_Information.isbestmatch, '1', '0' );
		self.addr1_source_count                   := (string3) le.Address_Verification.Input_Address_Information.source_count;
		self.addr1_credit_sourced                 := if( le.Address_Verification.Input_Address_Information.credit_sourced, '1', '0' );
		self.addr1_eda_sourced                    := if( le.Address_Verification.Input_Address_Information.eda_sourced, '1', '0' );
		self.addr1_dl_sourced                     := if( le.Address_Verification.Input_Address_Information.dl_sourced, '1', '0' );
		self.addr1_voter_sourced                  := if( le.Address_Verification.Input_Address_Information.voter_sourced, '1', '0' );
		self.addr1_applicant_owned                := if( le.Address_Verification.Input_Address_Information.applicant_owned, '1', '0' );
		self.addr1_occupant_owned                 := if( le.Address_Verification.Input_Address_Information.occupant_owned, '1', '0' );
		self.addr1_family_owned                   := if( le.Address_Verification.Input_Address_Information.family_owned, '1', '0' );
		self.addr1_family_sold                    := if( le.Address_Verification.Input_Address_Information.family_sold, '1', '0' );
		self.addr1_applicant_sold                 := if( le.Address_Verification.Input_Address_Information.applicant_sold, '1', '0' );
		self.addr1_naprop                         := (string3) le.Address_Verification.Input_Address_Information.naprop;
		self.addr1_purchase_date                  := (string8) le.Address_Verification.Input_Address_Information.purchase_date;
		self.addr1_built_date                     := (string8) le.Address_Verification.Input_Address_Information.built_date;
		self.addr1_purchase_amount                := (string13) le.Address_Verification.Input_Address_Information.purchase_amount;
		self.addr1_mortgage_amount                := (string13) le.Address_Verification.Input_Address_Information.mortgage_amount;
		self.addr1_mortgage_date                  := (string8) le.Address_Verification.Input_Address_Information.mortgage_date;
		self.addr1_assessed_amount                := (string13) le.Address_Verification.Input_Address_Information.assessed_amount;
		self.addr1_date_first_seen                := (string8) le.Address_Verification.Input_Address_Information.date_first_seen;
		self.addr1_census_age                     := le.Address_Verification.Input_Address_Information.census_age;
		self.addr1_census_income                  := le.Address_Verification.Input_Address_Information.census_income;
		self.addr1_census_home_value              := le.Address_Verification.Input_Address_Information.census_home_value;
		self.addr1_census_education               := le.Address_Verification.Input_Address_Information.census_education;
		self.addr1_avm_land_use_code              := le.AVM.Input_Address_Information.avm_land_use_code;
		self.addr1_avm_assessed_total_value       := le.AVM.Input_Address_Information.avm_assessed_total_value;
		self.addr1_avm_market_total_value         := le.AVM.Input_Address_Information.avm_market_total_value;
		self.addr1_avm_tax_assessment_valuation   := (string13) le.AVM.Input_Address_Information.avm_tax_assessment_valuation;
		self.addr1_avm_price_index_valuation      := (string13) le.AVM.Input_Address_Information.avm_price_index_valuation;
		self.addr1_avm_hedonic_valuation          := (string13) le.AVM.Input_Address_Information.avm_hedonic_valuation;
		self.addr1_avm_automated_valuation        := (string13) le.AVM.Input_Address_Information.avm_automated_valuation;
		self.addr1_avm_confidence_score           := (string13) le.AVM.Input_Address_Information.avm_confidence_score;
		self.addr1_avm_median_fips_level          := (string13) le.AVM.Input_Address_Information.avm_median_fips_level;
		self.addr1_avm_median_geo11_level         := (string13) le.AVM.Input_Address_Information.avm_median_geo11_level;
		self.addr1_avm_median_geo12_level         := (string13) le.AVM.Input_Address_Information.avm_median_geo12_level;


		/* Address History 1 */
		self.addr2_House_Number_match             := if( le.Address_Verification.Address_History_1.House_Number_match, '1', '0' );
		self.addr2_isbestmatch                    := if( le.Address_Verification.Address_History_1.isbestmatch, '1', '0' );
		self.addr2_source_count                   := (string3) le.Address_Verification.Address_History_1.source_count;
		self.addr2_credit_sourced                 := if( le.Address_Verification.Address_History_1.credit_sourced, '1', '0' );
		self.addr2_eda_sourced                    := if( le.Address_Verification.Address_History_1.eda_sourced, '1', '0' );
		self.addr2_dl_sourced                     := if( le.Address_Verification.Address_History_1.dl_sourced, '1', '0' );
		self.addr2_voter_sourced                  := if( le.Address_Verification.Address_History_1.voter_sourced, '1', '0' );
		self.addr2_applicant_owned                := if( le.Address_Verification.Address_History_1.applicant_owned, '1', '0' );
		self.addr2_occupant_owned                 := if( le.Address_Verification.Address_History_1.occupant_owned, '1', '0' );
		self.addr2_family_owned                   := if( le.Address_Verification.Address_History_1.family_owned, '1', '0' );
		self.addr2_family_sold                    := if( le.Address_Verification.Address_History_1.family_sold, '1', '0' );
		self.addr2_applicant_sold                 := if( le.Address_Verification.Address_History_1.applicant_sold, '1', '0' );
		self.addr2_naprop                         := (string3) le.Address_Verification.Address_History_1.naprop;
		self.addr2_purchase_date                  := (string8) le.Address_Verification.Address_History_1.purchase_date;
		self.addr2_built_date                     := (string8) le.Address_Verification.Address_History_1.built_date;
		self.addr2_purchase_amount                := (string13) le.Address_Verification.Address_History_1.purchase_amount;
		self.addr2_mortgage_amount                := (string13) le.Address_Verification.Address_History_1.mortgage_amount;
		self.addr2_mortgage_date                  := (string8) le.Address_Verification.Address_History_1.mortgage_date;
		self.addr2_assessed_amount                := (string13) le.Address_Verification.Address_History_1.assessed_amount;
		self.addr2_date_first_seen                := (string8) le.Address_Verification.Address_History_1.date_first_seen;
		self.addr2_HR_Address                     := if( le.Address_Verification.Address_History_1.HR_Address, '1', '0' );
		self.addr2_census_age                     := le.Address_Verification.Address_History_1.census_age;
		self.addr2_census_income                  := le.Address_Verification.Address_History_1.census_income;
		self.addr2_census_home_value              := le.Address_Verification.Address_History_1.census_home_value;
		self.addr2_avm_assessed_total_value       := le.AVM.Address_History_1.avm_assessed_total_value;
		self.addr2_avm_market_total_value         := le.AVM.Address_History_1.avm_market_total_value;
		self.addr2_avm_tax_assessment_valuation   := (string13) le.AVM.Address_History_1.avm_tax_assessment_valuation;
		self.addr2_avm_price_index_valuation      := (string13) le.AVM.Address_History_1.avm_price_index_valuation;
		self.addr2_avm_hedonic_valuation          := (string13) le.AVM.Address_History_1.avm_hedonic_valuation;
		self.addr2_avm_automated_valuation        := (string13) le.AVM.Address_History_1.avm_automated_valuation;
		self.addr2_avm_confidence_score           := (string13) le.AVM.Address_History_1.avm_confidence_score;
		self.addr2_avm_median_fips_level          := (string13) le.AVM.Address_History_1.avm_median_fips_level;
		self.addr2_avm_median_geo11_level         := (string13) le.AVM.Address_History_1.avm_median_geo11_level;
		self.addr2_avm_median_geo12_level         := (string13) le.AVM.Address_History_1.avm_median_geo12_level;

		/* Address History 2 */
		self.addr3_House_Number_match             := if( le.Address_Verification.Address_History_2.House_Number_match, '1', '0' );
		self.addr3_isbestmatch                    := if( le.Address_Verification.Address_History_2.isbestmatch, '1', '0' );
		self.addr3_source_count                   := (string3) le.Address_Verification.Address_History_2.source_count;
		self.addr3_credit_sourced                 := if( le.Address_Verification.Address_History_2.credit_sourced, '1', '0' );
		self.addr3_eda_sourced                    := if( le.Address_Verification.Address_History_2.eda_sourced, '1', '0' );
		self.addr3_dl_sourced                     := if( le.Address_Verification.Address_History_2.dl_sourced, '1', '0' );
		self.addr3_voter_sourced                  := if( le.Address_Verification.Address_History_2.voter_sourced, '1', '0' );
		self.addr3_applicant_owned                := if( le.Address_Verification.Address_History_2.applicant_owned, '1', '0' );
		self.addr3_occupant_owned                 := if( le.Address_Verification.Address_History_2.occupant_owned, '1', '0' );
		self.addr3_family_owned                   := if( le.Address_Verification.Address_History_2.family_owned, '1', '0' );
		self.addr3_family_sold                    := if( le.Address_Verification.Address_History_2.family_sold, '1', '0' );
		self.addr3_applicant_sold                 := if( le.Address_Verification.Address_History_2.applicant_sold, '1', '0' );
		self.addr3_naprop                         := (string3) le.Address_Verification.Address_History_2.naprop;
		self.addr3_purchase_date                  := (string8) le.Address_Verification.Address_History_2.purchase_date;
		self.addr3_built_date                     := (string8) le.Address_Verification.Address_History_2.built_date;
		self.addr3_purchase_amount                := (string13) le.Address_Verification.Address_History_2.purchase_amount;
		self.addr3_mortgage_amount                := (string13) le.Address_Verification.Address_History_2.mortgage_amount;
		self.addr3_mortgage_date                  := (string8) le.Address_Verification.Address_History_2.mortgage_date;
		self.addr3_assessed_amount                := (string13) le.Address_Verification.Address_History_2.assessed_amount;
		self.addr3_date_first_seen                := (string8) le.Address_Verification.Address_History_2.date_first_seen;
		self.addr3_HR_Address                     := if( le.Address_Verification.Address_History_2.HR_Address, '1', '0' );
		self.addr3_census_age                     := le.Address_Verification.Address_History_2.census_age;
		self.addr3_census_income                  := le.Address_Verification.Address_History_2.census_income;
		self.addr3_census_home_value              := le.Address_Verification.Address_History_2.census_home_value;
		self.owned_property_total                 := (string3) le.Address_Verification.owned.property_total;
		self.owned_property_owned_purchase_total  := (string13) le.Address_Verification.owned.property_owned_purchase_total;
		self.owned_property_owned_purchase_count  := (string5) le.Address_Verification.owned.property_owned_purchase_count;
		self.owned_property_owned_assessed_total  := (string13) le.Address_Verification.owned.property_owned_assessed_total;
		self.owned_property_owned_assessed_count  := (string5) le.Address_Verification.owned.property_owned_assessed_count;
		self.sold_property_total                  := (string3) le.Address_Verification.sold.property_total;
		self.sold_property_owned_purchase_total   := (string13) le.Address_Verification.sold.property_owned_purchase_total;

		/* Other Address Fields */
		self.avg_lres                             := (string3) le.Other_Address_Info.avg_lres;
		self.max_lres                             := (string3) le.Other_Address_Info.max_lres;
		self.addrs_last_5years                    := (string3) le.Other_Address_Info.addrs_last_5years;
		self.addrs_last_10years                   := (string3) le.Other_Address_Info.addrs_last_10years;
		self.addrs_last_15years                   := (string3) le.Other_Address_Info.addrs_last_15years;

		/* Phone Verification */
		self.telcordia_type                       := le.Phone_Verification.telcordia_type;
		self.recent_disconnects                   := (string3) le.Phone_Verification.recent_disconnects;

		/* SSN Verification & Validation */
		self.namePerSSN_count                     := (string5) le.SSN_Verification.namePerSSN_count;
		self.credit_sourced                       := if( le.SSN_Verification.credit_sourced, '1', '0' );
		self.credit_first_seen                    := (string8) le.SSN_Verification.credit_first_seen;
		self.credit_last_seen                     := (string8) le.SSN_Verification.credit_last_seen;
		self.header_first_seen                    := (string8) le.SSN_Verification.header_first_seen;
		self.header_last_seen                     := (string8) le.SSN_Verification.header_last_seen;
		self.tu_sourced                           := if( le.SSN_Verification.tu_sourced, '1', '0' );
		self.voter_sourced                        := if( le.SSN_Verification.voter_sourced, '1', '0' );
		self.utility_sourced                      := if( le.SSN_Verification.utility_sourced, '1', '0' );
		self.bk_sourced                           := if( le.SSN_Verification.bk_sourced, '1', '0' );
		self.other_sourced                        := if( le.SSN_Verification.other_sourced, '1', '0' );
		self.inputsocscharflag                    := le.SSN_Verification.Validation.inputsocscharflag;
		
		
		/* Velocity Counters */
		self.ssns_per_adl                         := (string3) le.Velocity_Counters.ssns_per_adl;
		self.addrs_per_adl                        := (string3) le.Velocity_Counters.addrs_per_adl;
		self.phones_per_adl                       := (string3) le.Velocity_Counters.phones_per_adl;
		self.adlPerSSN_count                      := (string5) le.SSN_Verification.adlPerSSN_count;
		self.adls_per_addr                        := (string3) le.Velocity_Counters.adls_per_addr;
		self.ssns_per_addr                        := (string3) le.Velocity_Counters.ssns_per_addr;
		self.phones_per_addr                      := (string3) le.Velocity_Counters.phones_per_addr;
		self.adls_per_phone                       := (string3) le.Velocity_Counters.adls_per_phone;
		self.ssns_per_adl_created_6months         := (string3) le.Velocity_Counters.ssns_per_adl_created_6months;
		
		
		/* Derogs/BJL */
		self.Bankrupt                             := if( le.BJL.Bankrupt, '1', '0' );
		self.date_last_seen                       := (string8) le.BJL.date_last_seen;
		self.filing_count                         := (string3) le.BJL.filing_count;
		self.bk_recent_count                      := (string3) le.BJL.bk_recent_count;
		self.bk_disposed_recent_count             := (string3) le.BJL.bk_disposed_recent_count;
		self.bk_disposed_historical_count         := (string3) le.BJL.bk_disposed_historical_count;
		self.liens_recent_unreleased_count        := (string3) le.BJL.liens_recent_unreleased_count;
		self.liens_historical_unreleased_count    := (string3) le.BJL.liens_historical_unreleased_count;
		self.last_liens_unreleased_date           := (string8) le.BJL.last_liens_unreleased_date;
		self.liens_recent_released_count          := (string3) le.BJL.liens_recent_released_count;
		self.liens_historical_released_count      := (string3) le.BJL.liens_historical_released_count;
		self.criminal_count                       := (string3) le.BJL.criminal_count;
		self.last_criminal_date                   := (string8) le.BJL.last_criminal_date;
		self.felony_count                         := (string3) le.BJL.felony_count;
		self.last_felony_date                     := (string8) le.BJL.last_felony_date;
		self.foreclosure_flag                     := if( le.BJL.foreclosure_flag, '1', '0' );
		self.last_foreclosure_date                := le.BJL.last_foreclosure_date;

		/* Relatives */
		self.relative_count                       := (string3) le.Relatives.relative_count;
		self.relative_bankrupt_count              := (string3) le.Relatives.relative_bankrupt_count;
		self.relative_criminal_count              := (string3) le.Relatives.relative_criminal_count;
		self.relative_criminal_total              := (string3) le.Relatives.relative_criminal_total;
		self.criminal_relative_within25miles      := (string3) le.Relatives.criminal_relative_within25miles;
		self.criminal_relative_within100miles     := (string3) le.Relatives.criminal_relative_within100miles;
		self.criminal_relative_within500miles     := (string3) le.Relatives.criminal_relative_within500miles;
		self.criminal_relative_withinOther        := (string3) le.Relatives.criminal_relative_withinOther;
		self.relatives_property_count             := (string3) le.Relatives.owned.relatives_property_count;
		self.relatives_property_total             := (string3) le.Relatives.owned.relatives_property_total;
		self.relatives_property_purchase_count    := (string3) le.Relatives.owned.relatives_property_owned_purchase_count;
		self.relatives_property_assessed_total    := (string13) le.Relatives.owned.relatives_property_owned_assessed_total;
		self.relative_within25miles_count         := (string3) le.Relatives.relative_within25miles_count;
		self.relative_within100miles_count        := (string3) le.Relatives.relative_within100miles_count;
		self.relative_within500miles_count        := (string3) le.Relatives.relative_within500miles_count;
		self.relative_withinOther_count           := (string3) le.Relatives.relative_withinOther_count;
		self.relative_incomeUnder25_count         := (string3) le.Relatives.relative_incomeUnder25_count;
		self.relative_incomeUnder50_count         := (string3) le.Relatives.relative_incomeUnder50_count;
		self.relative_incomeUnder75_count         := (string3) le.Relatives.relative_incomeUnder75_count;
		self.relative_incomeUnder100_count        := (string3) le.Relatives.relative_incomeUnder100_count;
		self.relative_incomeOver100_count         := (string3) le.Relatives.relative_incomeOver100_count;
		self.relative_homeUnder50_count           := (string3) le.Relatives.relative_homeUnder50_count;
		self.relative_homeUnder100_count          := (string3) le.Relatives.relative_homeUnder100_count;
		self.relative_homeUnder150_count          := (string3) le.Relatives.relative_homeUnder150_count;
		self.relative_homeUnder200_count          := (string3) le.Relatives.relative_homeUnder200_count;
		self.relative_homeUnder300_count          := (string3) le.Relatives.relative_homeUnder300_count;
		self.relative_homeUnder500_count          := (string3) le.Relatives.relative_homeUnder500_count;
		self.relative_educationUnder8_count       := (string3) le.Relatives.relative_educationUnder8_count;
		self.relative_educationUnder12_count      := (string3) le.Relatives.relative_educationUnder12_count;
		self.relative_educationOver12_count       := (string3) le.Relatives.relative_educationOver12_count;
		self.relative_vehicle_owned_count         := (string3) le.Relatives.relative_vehicle_owned_count;
		self.relatives_at_input_address           := (string3) le.Relatives.relatives_at_input_address;
		
		/* Vehicles */
		self.vehicle_current_count                := (string3) le.Vehicles.current_count;
		self.vehicle_historical_count             := (string3) le.Vehicles.historical_count;

		/* Watercraft */
		self.watercraft_count                     := (string3) le.Watercraft.watercraft_count;

		/* American Student */
		self.income_level_code                    := le.STUDENT.INCOME_LEVEL_CODE;

		/* Professional License */
		self.professional_license_flag            := if( le.Professional_License.professional_license_flag, '1', '0' );
		self.professional_license_type            := le.Professional_License.license_type;

		/* Scores, RC's & Pre-Calc's */
		self.fd3_score                            := le.FD_Scores.fd3;
		self.fd6_score                            := le.FD_Scores.fd6;
		self.fp_score                             := le.FD_Scores.FraudPoint;
		self.fp_reason1                           := le.FD_Scores.reason1FP;
		self.fp_reason2                           := le.FD_Scores.reason2FP;
		self.fp_reason3                           := le.FD_Scores.reason3FP;
		self.fp_reason4                           := le.FD_Scores.reason4FP;
		self.fp_reason5                           := le.FD_Scores.reason5FP;
		self.fp_reason6                           := le.FD_Scores.reason6FP;
		self.wealth_indicator                     := le.wealth_indicator;
		self.inferred_dob                         := (string8)le.reported_dob; 
		self.mobility_indicator                   := le.mobility_indicator;
	END;                       

	batchOut := join( clam, iid_prep_acct, left.seq=right.seq, toOut(LEFT,RIGHT), left outer );

	output(batchOut,named('Results'));	
ENDMACRO;
// risk_indicators.CDIP_Batch_Service();