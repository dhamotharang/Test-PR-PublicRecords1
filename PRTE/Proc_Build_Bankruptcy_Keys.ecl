import	_control, PRTE, PRTE_CSV, BIPV2, BankruptcyV2;

export Proc_Build_Bankruptcy_Keys(string pIndexVersion)	:= function
l_bk_main	:= {PRTE_CSV.Bankruptcy_main_join};
l_bk_search	:= PRTE_CSV.BK_Key_Layouts.searchV3;

 Main_join	:= PRTE_CSV.Bankruptcy_main_join;
 
 rKeybankruptcyv2__bdid									:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv2__bdid;
	end;
	dKeybankruptcyv2__bdid									:= 	project(PRTE_CSV.Bankruptcy_Files.search, TRANSFORM(rKeybankruptcyv2__bdid, self.p_bdid := (integer)left.bdid; self := left;));
	kKeybankruptcyv2__bdid									:=	index(dKeybankruptcyv2__bdid, {p_bdid}, {TMSID,court_code,case_number}, '~prte::key::bankruptcyv2::' + pIndexVersion + '::bdid');

	rKeybankruptcyv2__case_number						:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv2__case_number;
	end;
	dKeybankruptcyv2__case_number						:= 	project(Main_join, transform(rKeybankruptcyv2__case_number, self.filing_state := left.filing_jurisdiction; self := left;));
	kKeybankruptcyv2__case_number						:=	index(dKeybankruptcyv2__case_number, {case_number, filing_state}, {TMSID}, '~prte::key::bankruptcyv2::' + pIndexVersion + '::case_number');

	rKeybankruptcyv2__did	:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv2__did;
	end;
	dKeybankruptcyv2__did										:= 	project(PRTE_CSV.Bankruptcy_Files.search, transform(rKeybankruptcyv2__did, self.did := (integer)left.did; self := left;));
	kKeybankruptcyv2__did										:=	index(dKeybankruptcyv2__did, {did}, {TMSID,court_code,case_number}, '~prte::key::bankruptcyv2::' + pIndexVersion + '::did');

	rKeybankruptcyv2__main__tmsid						:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv2__main__tmsid;
	end;
	
	rKeybankruptcyv2__main__tmsid xformV2(l_bk_main l, l_bk_search r) := transform
		self.chapter	:= r.chapter;
		self.orig_filing_type	:= r.filing_type;
		self.corp_flag := r.corp_flag;
		self.disposed_date := r.date_last_seen;
		self.disposition := r.disposition;
		self.pro_se_ind := r.pro_se_ind;
		self.record_type	:= r.record_type;
		self.converted_date	:= r.converted_date;
		self := l;
	end;
	
	dKeybankruptcyv2__main__tmsid						:= 	join(Main_join, PRTE_CSV.Bankruptcy_Files.search, left.tmsid = right.tmsid, xformV2(left,right),left outer);
	kKeybankruptcyv2__main__tmsid						:=	index(dKeybankruptcyv2__main__tmsid, {tmsid}, {dKeybankruptcyv2__main__tmsid}, '~prte::key::bankruptcyv2::' + pIndexVersion + '::main::tmsid');

	rKeybankruptcyv2__search__tmsid					:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv2__search__tmsid;
		//BIPV2.IDlayouts.l_xlink_ids;
	end;
	dKeybankruptcyv2__search__tmsid					:= 	project(PRTE_CSV.Bankruptcy_Files.search, rKeybankruptcyv2__search__tmsid);
	kKeybankruptcyv2__search__tmsid					:=	index(dKeybankruptcyv2__search__tmsid, {tmsid}, {dKeybankruptcyv2__search__tmsid}, '~prte::key::bankruptcyv2::' + pIndexVersion + '::search::tmsid');

	rKeybankruptcyv2__search_v3_linkids			:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv2__search_v3_linkids;
	end;
	dKeybankruptcyv2__search_v3_linkids			:= 	project(PRTE_CSV.Bankruptcy_Files.search, TRANSFORM(rKeybankruptcyv2__search_v3_linkids,SELF:=LEFT;SELF:=[]));
	kKeybankruptcyv2__search_v3_linkids			:=	index(dKeybankruptcyv2__search_v3_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight}, {dKeybankruptcyv2__search_v3_linkids}, '~prte::key::bankruptcyv2::' + pIndexVersion + '::search_v3::linkids');

	rKeybankruptcyv2__ssn										:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv2__ssn;
	end;
	dKeybankruptcyv2__ssn										:= 	project(PRTE_CSV.Bankruptcy_Files.search, rKeybankruptcyv2__ssn);
	kKeybankruptcyv2__ssn										:=	index(dKeybankruptcyv2__ssn, {ssn, tmsid}, {dKeybankruptcyv2__ssn}, '~prte::key::bankruptcyv2::' + pIndexVersion + '::ssn');


//BankruptcyV3 Keys
		rKeybankruptcyv3__search__tmsid					:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv3__search__tmsid;
	end;
	dKeybankruptcyv3__search__tmsid					:= 	project(PRTE_CSV.Bankruptcy_Files.search, rKeybankruptcyv3__search__tmsid);
	kKeybankruptcyv3__search__tmsid					:=	index(dKeybankruptcyv3__search__tmsid, {tmsid}, {dKeybankruptcyv3__search__tmsid}, '~prte::key::bankruptcyv3::' + pIndexVersion + '::search::tmsid');
	
	rKeybankruptcyv3__main__tmsid						:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv3__main__tmsid;
	end;
	dKeybankruptcyv3__main__tmsid						:= 	project(Main_join, rKeybankruptcyv3__main__tmsid);
	kKeybankruptcyv3__main__tmsid						:=	index(dKeybankruptcyv3__main__tmsid, {tmsid}, {dKeybankruptcyv3__main__tmsid}, '~prte::key::bankruptcyv3::' + pIndexVersion + '::main::tmsid');

	rKeybankruptcyv3_main__supplement 			:= 
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__main_supplement;
	end;	
	dKeybankruptcyv3__main__supplement 			:= project(Main_join,rKeybankruptcyv3_main__supplement);
	kKeybankruptcyv3__main__supplement 			:= index(dKeybankruptcyv3__main__supplement, {tmsid}, {dKeybankruptcyv3__main__supplement},'~prte::key::bankruptcyv3::'+ pIndexVersion +'::main::supplemental');

	rKeybankruptcyv3_ssn4st 								:= 
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__ssn4st;
	end;	
	dKeybankruptcyv3__ssn4st 								:= project(PRTE_CSV.Bankruptcy_Files.search(ssn<>''),TRANSFORM(rKeybankruptcyv3_ssn4st,SELF.ssnlast4:=LEFT.ssn[5..9];SELF.state:=LEFT.st;SELF:=LEFT));
	kKeybankruptcyv3__ssn4st 								:= index(dKeybankruptcyv3__ssn4st, {ssnlast4, state, lname, fname}, {dKeybankruptcyv3__ssn4st}, '~prte::key::bankruptcyv3::'+ pIndexVersion +'::ssn4st');
	
	rKeybankruptcyv3_ssnmatch 							:= 
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__ssnmatch;
	end;	
	dKeybankruptcyv3__ssnmatch 							:= project(PRTE_CSV.Bankruptcy_Files.search(ssn<>''),TRANSFORM(rKeybankruptcyv3_ssnmatch,SELF.ssnmatch:=LEFT.ssn;SELF:=LEFT));
	kKeybankruptcyv3__ssnmatch 							:= index(dKeybankruptcyv3__ssnmatch, {ssnmatch}, {dKeybankruptcyv3__ssnmatch}, '~prte::key::bankruptcyv3::'+ pIndexVersion +'::ssnmatch');

	rKeybankruptcyv3_trusteeidname 					:= 
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__trusteeidname;
	end;
	dKeybankruptcyv3__trusteeidname 				:= project(Main_join(trusteeid<>''),TRANSFORM(rKeybankruptcyv3_trusteeidname,SELF:=LEFT));
	kKeybankruptcyv3__trusteeidname 				:= index(dKeybankruptcyv3__trusteeidname, {trusteeid}, {dKeybankruptcyv3__trusteeidname}, '~prte::key::bankruptcyv3::'+ pIndexVersion +'::trusteeidname');
	
	rKeybankruptcyv3__search_v3_linkids			:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv2__search_v3_linkids;
	end;
	dKeybankruptcyv3__search_v3_linkids			:= 	project(PRTE_CSV.Bankruptcy_Files.search, TRANSFORM(rKeybankruptcyv3__search_v3_linkids,SELF:=LEFT;SELF:=[]));
	kKeybankruptcyv3__search_v3_linkids			:=	index(dKeybankruptcyv3__search_v3_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight}, {dKeybankruptcyv3__search_v3_linkids}, '~prte::key::bankruptcyv3::' + pIndexVersion + '::search_v3::linkids');
	
	rKeybankruptcyv3__search__tmsid__linkids:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv3__search__tmsid__linkids;
	end;
	dKeybankruptcyv3__search__tmsid__linkids:= 	project(PRTE_CSV.Bankruptcy_Files.search, rKeybankruptcyv3__search__tmsid__linkids);
	kKeybankruptcyv3__search__tmsid__linkids:=	index(dKeybankruptcyv3__search__tmsid__linkids, {tmsid}, {dKeybankruptcyv3__search__tmsid__linkids}, '~prte::key::bankruptcyv3::' + pIndexVersion + '::search::tmsid_linkids');
	
	rKeybankruptcyv3__bdid									:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv2__bdid;
	end;
	dKeybankruptcyv3__bdid									:= 	project(PRTE_CSV.Bankruptcy_Files.search, TRANSFORM(rKeybankruptcyv3__bdid, self.p_bdid := (integer)left.bdid; self := left;));
	kKeybankruptcyv3__bdid									:=	index(dKeybankruptcyv3__bdid, {p_bdid}, {TMSID,court_code,case_number}, '~prte::key::bankruptcyv3::' + pIndexVersion + '::bdid');

	rKeybankruptcyv3__did	:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv2__did;
	end;
	dKeybankruptcyv3__did										:= 	project(PRTE_CSV.Bankruptcy_Files.search, transform(rKeybankruptcyv3__did, self.did := (integer)left.did; self := left;));
	kKeybankruptcyv3__did										:=	index(dKeybankruptcyv3__did, {did}, {TMSID,court_code,case_number}, '~prte::key::bankruptcyv3::' + pIndexVersion + '::did');
	
		rKeybankruptcyv3__case_number						:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv2__case_number;
	end;
	dKeybankruptcyv3__case_number						:= 	project(Main_join, transform(rKeybankruptcyv3__case_number, self.filing_state := left.filing_jurisdiction; self := left;));
	kKeybankruptcyv3__case_number						:=	index(dKeybankruptcyv3__case_number, {case_number, filing_state}, {TMSID}, '~prte::key::bankruptcyv3::' + pIndexVersion + '::case_number');
	
		rKeybankruptcyv3__ssn										:=
	record
		PRTE_CSV.BankruptcyV2_V3.rthor_data400__key__bankruptcyv2__ssn;
	end;
	dKeybankruptcyv3__ssn										:= 	project(PRTE_CSV.Bankruptcy_Files.search(ssn<>''), rKeybankruptcyv3__ssn);
	kKeybankruptcyv3__ssn										:=	index(dKeybankruptcyv3__ssn, {ssn, tmsid}, {dKeybankruptcyv3__ssn}, '~prte::key::bankruptcyv3::' + pIndexVersion + '::ssn');

//FCRA Keys - copy of non-fcra keys
	kKeybankruptcyv3__bdid_fcra										:=	index(dKeybankruptcyv3__bdid, {p_bdid}, {TMSID,court_code,case_number}, '~prte::key::bankruptcyv3::fcra::' + pIndexVersion + '::bdid');
	kKeybankruptcyv3__case_number_fcra						:=	index(dKeybankruptcyv3__case_number, {case_number, filing_state}, {TMSID}, '~prte::key::bankruptcyv3::fcra::' + pIndexVersion + '::case_number');	
	kKeybankruptcyv3__did_fcra										:=	index(dKeybankruptcyv3__did, {did}, {TMSID,court_code,case_number}, '~prte::key::bankruptcyv3::fcra::' + pIndexVersion + '::did');
	kKeybankruptcyv3__main__supplement_fcra				:=  index(dKeybankruptcyv3__main__supplement, {tmsid}, {dKeybankruptcyv3__main__supplement},'~prte::key::bankruptcyv3::fcra::'+ pIndexVersion +'::main::supplemental');
  kKeybankruptcyv3__ssn_fcra										:=	index(dKeybankruptcyv3__ssn, {ssn, tmsid}, {dKeybankruptcyv3__ssn}, '~prte::key::bankruptcyv3::fcra::' + pIndexVersion + '::ssn');
	kKeybankruptcyv3__ssn4st_fcra									:=  index(dKeybankruptcyv3__ssn4st, {ssnlast4, state, lname, fname}, {dKeybankruptcyv3__ssn4st}, '~prte::key::bankruptcyv3::fcra::'+ pIndexVersion +'::ssn4st');	
	kKeybankruptcyv3__main__tmsid_fcra						:=	index(dKeybankruptcyv3__main__tmsid, {tmsid}, {dKeybankruptcyv3__main__tmsid}, '~prte::key::bankruptcyv3::fcra::' + pIndexVersion + '::main::tmsid');
	kKeybankruptcyv3__search__tmsid_fcra					:=	index(dKeybankruptcyv3__search__tmsid, {tmsid}, {dKeybankruptcyv3__search__tmsid}, '~prte::key::bankruptcyv3::fcra::' + pIndexVersion + '::search::tmsid');
	kKeybankruptcyv3__trusteeidname_fcra					:=  index(dKeybankruptcyv3__trusteeidname, {trusteeid}, {dKeybankruptcyv3__trusteeidname}, '~prte::key::bankruptcyv3::fcra::'+ pIndexVersion +'::trusteeidname');
	kKeybankruptcyv3__search__tmsid__linkids_fcra	:=	index(dKeybankruptcyv3__search__tmsid__linkids, {tmsid}, {dKeybankruptcyv3__search__tmsid__linkids}, '~prte::key::bankruptcyv3::fcra::' + pIndexVersion + '::search::tmsid_linkids');

// Build Autokeys
	autokeys			:=	PRTE.proc_build_Bankruptcy_autokeys(pIndexVersion);
	autokeysFCRA 	:=	PRTE.proc_build_Bankruptcy_autokeys(pIndexVersion, true);

return	sequential(
											parallel( autokeys,
																build(kKeybankruptcyv2__bdid									, update),
																build(kKeybankruptcyv2__case_number						, update),
																build(kKeybankruptcyv2__did										, update),
																build(kKeybankruptcyv2__search_v3_linkids			, update),
																build(kKeybankruptcyv2__search__tmsid					, update),
																build(kKeybankruptcyv2__main__tmsid						, update),
																build(kKeybankruptcyv2__ssn										, update),
																build(kKeybankruptcyv3__search__tmsid					, update),																
																build(kKeybankruptcyv3__main__tmsid						, update),
																build(kKeybankruptcyv3__main__supplement			, update),																																	
																build(kKeybankruptcyv3__ssn4st								, update),
																build(kKeybankruptcyv3__ssnmatch							, update),															
																build(kKeybankruptcyv3__trusteeidname					, update),
																build(kKeybankruptcyv3__search_v3_linkids			, update),
																build(kKeybankruptcyv3__search__tmsid__linkids, update),
																build(kKeybankruptcyv3__bdid									, update),
																build(kKeybankruptcyv3__did										, update),
																build(kKeybankruptcyv3__case_number						, update),
																build(kKeybankruptcyv3__ssn										, update),
																
																autokeysFCRA,																														
																build(kKeybankruptcyv3__bdid_fcra										, update),
																build(kKeybankruptcyv3__case_number_fcra						, update),
																build(kKeybankruptcyv3__did_fcra										, update),
																build(kKeybankruptcyv3__main__supplement_fcra				, update),
																build(kKeybankruptcyv3__main__tmsid_fcra						, update),
																build(kKeybankruptcyv3__search__tmsid_fcra					, update),																
																build(kKeybankruptcyv3__ssn_fcra										, update),
																build(kKeybankruptcyv3__ssn4st_fcra									, update),
																build(kKeybankruptcyv3__trusteeidname_fcra					, update),
																build(kKeybankruptcyv3__search__tmsid__linkids_fcra	, update)																											
										),
											PRTE.UpdateVersion('BankruptcyV2Keys',									//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				),
												
											PRTE.UpdateVersion('FCRA_BankruptcyKeys',								//	Package name
   																			pIndexVersion,												//	Package version
   																			_control.MyInfo.EmailAddressNormal,		//	Who to email with specifics
   																			'B',																	//	B = Boca, A = Alpharetta
   																			'F',																	//	N = Non-FCRA, F = FCRA
   																			'N'																		//	N = Do not also include boolean, Y = Include boolean, too
																				)
										);

end;
