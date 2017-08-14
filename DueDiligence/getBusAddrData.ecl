IMPORT Address_Attributes, Business_Header, codes, ADVO, Business_Risk, Risk_indicators, RiskWise, Address, YellowPages, Easi, Business_Risk_BIP, DueDiligence;

/*
	Following Keys being used:
			Address_Attributes.key_AML_addr
*/

EXPORT getBusAddrData(DATASET(DueDiligence.Layouts.Busn_Internal) inData,
												Business_Risk_BIP.LIB_Business_Shell_LIBIN options) := FUNCTION

	riskKey := Address_Attributes.key_AML_addr;

	//get unique addrress for businesses coming in
	sortInData := SORT(inData, seq, DueDiligence.Constants.mac_ListTop3Linkids(), Busn_info.address.prim_range, Busn_info.address.prim_name, Busn_info.address.addr_suffix, Busn_info.address.postdir, Busn_info.address.zip5);
	dedupInData  :=  dedup(sortInData, seq, DueDiligence.Constants.mac_ListTop3Linkids(), Busn_info.address.prim_range, Busn_info.address.prim_name, Busn_info.address.addr_suffix, Busn_info.address.postdir, Busn_info.address.zip5);

	RiskLayout := RECORD
		unsigned4	seq := 0;
		unsigned4	historydate;
		UNSIGNED6 ultid;
		UNSIGNED6 orgid;
		UNSIGNED6 seleid;
		UNSIGNED6 proxid;
		UNSIGNED6 powid;
		unsigned2 	score := 0;
		string30	 	account := '';
		STRING120  cnp_name;
		unsigned3 	cmpymatch_score;
		string120 	company_name := '';
		string10  	prim_range := '';
		string2   	predir := '';
		string28  	prim_name := '';
		string4   	addr_suffix := '';
		string2   	postdir := '';
		string10  	unit_desig := '';
		string8   	sec_range := '';
		string25  	city_name := '';
		string2   	st := '';
		string5   	z5 := '';		
		STRING60  CmpyType;		
		STRING10  cnp_phone;
		STRING9 	cnp_fein;
		BOOLEAN		potential_shelf		:= FALSE;
		STRING4		shelf_reason;
		INTEGER4	bizCnt;
		INTEGER4 	hifcaRiskKey;
		INTEGER4	inc_st_loose;
		INTEGER4	inc_st_loose_cnt;
		INTEGER4	trust;
		STRING60	company_org_structure_derived;
		INTEGER4	no_fein;
		INTEGER4 no_fein_cnt;
		INTEGER4 vacant;
		INTEGER4 naics_risk_high;
		INTEGER4 naics_risk_med;
		INTEGER4 naics_risk_low;
		BOOLEAN	potentialNIS			:=	FALSE;
		INTEGER4	storage;
		INTEGER4	priv_post;
		INTEGER4	undel_sec;
		INTEGER4	drop;
		BOOLEAN	potential_remail	:=	FALSE;
		BOOLEAN LooseStateIncorpPct;   //inc_st_loose_cnt / bzn_cnt  when the bzn_cnt > 100
		BOOLEAN NoFeinBusnPct;    //no_fein_cnt / bzn_cnt  when the bzn_cnt > 100
	END;


	RiskLayout  GetRisk(DueDiligence.Layouts.Busn_Internal le, riskKey ri)  := TRANSFORM
			cmpymatch_score 	:= Business_Risk.CnameScore(le.busn_info.companyName, ri.cnp_name);		
			self.cmpymatch_score := cmpymatch_score;
			
			SELF.seq  := le.seq;
			SELF.ultid := le.busn_info.BIP_IDs.UltID.LinkID;
			SELF.orgid := le.busn_info.BIP_IDs.OrgID.LinkID;
			SELF.seleid := le.busn_info.BIP_IDs.SeleID.LinkID;
			SELF.proxid := le.busn_info.BIP_IDs.ProxID.LinkID;
			SELF.powid := le.busn_info.BIP_IDs.PowID.LinkID;
			self.historydate := le.historydate;
			self.bizCnt := ri.biz_cnt;
			self.hifcaRiskKey := ri.hifca;
			self.CmpyType   := if(ri.trust >= 1 ,  'TRUST', trim(ri.company_org_structure_derived));
			self.no_fein_cnt   := ri.no_fein_cnt;
			self.no_fein := ri.no_fein;
			self.inc_st_loose   :=  ri.inc_st_loose;
			self.inc_st_loose_cnt   :=  ri.inc_st_loose_cnt;
			self.potentialNIS			:=	ri.potential_NIS;
			self.storage    :=  ri.storage;
			self.priv_post   :=  ri.priv_post;
			self.undel_sec    :=  ri.undel_sec;
			self.drop     :=   ri.drop;
			self.potential_remail	:=	ri.potential_remail;
			self.LooseStateIncorpPct := false;
			self.NoFeinBusnPct  := false;

			self.city_name := le.busn_info.address.city;	
			self.company_name := le.busn_info.companyName;
			
			self := le;
			self := ri;
			SELF := [];
	END;

	with_Risk := join(dedupInData, riskKey, 
										KEYED(trim(LEFT.busn_info.address.zip5) 					= RIGHT.zip) AND
										KEYED(trim(LEFT.busn_info.address.prim_range) 	= RIGHT.prim_range) AND
										KEYED(trim(LEFT.busn_info.address.prim_name) 		= RIGHT.prim_name) AND
										KEYED(trim(LEFT.busn_info.address.addr_suffix) 	= RIGHT.addr_suffix) AND
										KEYED(trim(LEFT.busn_info.address.predir) 			= RIGHT.predir) AND
										KEYED(trim(LEFT.busn_info.address.postdir)			= RIGHT.postdir),
										getRisk(LEFT, RIGHT),
										atmost(100));
																
	
	GetRiskSS := ungroup(sort(with_Risk, seq, DueDiligence.Constants.mac_ListTop3Linkids(), -cmpymatch_score));

	RolledAddrRisk := rollup(GetRiskSS,
														LEFT.seq = right.seq and
														LEFT.ultid = RIGHT.ultid AND
														LEFT.orgid = RIGHT.orgid AND
														LEFT.seleid = RIGHT.seleid,
														TRANSFORM(RiskLayout,
																			self.no_fein := max(LEFT.no_fein, RIGHT.no_fein);
																			self := LEFT;
																			self := [];));
												
	AddRiskDtl := join(inData, RolledAddrRisk,
												left.seq = right.seq and
												LEFT.busn_info.BIP_IDs.UltID.LinkID = RIGHT.ultID AND
												LEFT.busn_info.BIP_IDs.OrgID.LinkID = RIGHT.orgID AND
												LEFT.busn_info.BIP_IDs.SeleID.LinkID = RIGHT.seleID,
												TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																	self.NoFein := RIGHT.no_fein > 0 and LEFT.fein = '';
																	self := LEFT;), 
												LEFT OUTER);







// output(inData, named('inData'));
// output(sortInData, named('sortInData'));
// output(dedupInData, named('dedupInData'));
// output(with_Risk, named('with_Risk'));
// output(GetRiskSS, named('GetRiskSS'));
// output(RolledAddrRisk, named('RolledAddrRisk'));



RETURN AddRiskDtl;

END;
