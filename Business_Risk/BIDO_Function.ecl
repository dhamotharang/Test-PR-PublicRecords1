import risk_indicators, models, seed_files, riskwise, ut, address, gateway, Royalty, MDR;

export BIDO_Function(string4 tribcode, boolean test_data_enabled, string addr, string city, string state, string zip,
						dataset(business_risk.Layout_Output) biid, 
						dataset(risk_indicators.Layout_Input) consumer_input, 
						dataset(Gateway.Layouts.Config) gateways,
						unsigned1 dppa_purpose, unsigned1 glb_purpose, 
						boolean ofac_only=false,
						boolean ExcludeWatchLists = false,
						unsigned1 ofac_version=1, boolean include_ofac=FALSE,
						boolean include_additional_watchlists=FALSE,
						real Global_WatchList_Threshold =.84,integer dob_radius = -1,
						unsigned1 BSversion=1,
						boolean runSSNCodes=true, boolean runBestAddrCheck=true, boolean runChronoPhoneLookup=true,	boolean runAreaCodeSplitSearch=true,
						boolean allowCellphones=false,
						string10 ExactMatchLevel=risk_indicators.iid_constants.default_ExactMatchLevel,
						string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
						string10 CustomDataFilter='',
						string50 DataPermission=risk_indicators.iid_constants.default_DataPermission) := FUNCTION
						
isUtility := false;
ln_branded_value := false;
suppressNearDups := true;
require2ele := false;
from_biid := true;
isFCRA := false;
from_IT1O := false;
includeRelativeInfo := true;
includeDLInfo := false;
includeVehInfo := false;
includeDerogInfo := true;


account_value := biid[1].account;
fein_value := biid[1].fein; 

iid := risk_indicators.InstantID_Function(consumer_input, gateways, DPPA_Purpose, GLB_Purpose, isUtility, ln_branded_value, ofac_only, 
										suppressNearDups, require2ele, from_biid, isFCRA, ExcludeWatchLists, from_IT1O, 
										ofac_version, include_ofac, include_additional_watchlists, global_watchlist_threshold, dob_radius,
										bsversion, 
										runSSNCodes,
										runChronoPhoneLookup,
										runAreaCodeSplitSearch, 
										allowcellphones,
										runBestAddrCheck,
										exactMatchLevel,
										DataRestriction,
										CustomDataFilter,
										in_DataPermission:=DataPermission
										);

iidRoyalties := if(test_data_enabled, DATASET([], Royalty.Layouts.Royalty), 
	Royalty.RoyaltyTargus.GetOnlineRoyalties(ungroup(iid), src, TargusType, TRUE, FALSE, FALSE, TRUE));

clam := risk_indicators.Boca_Shell_Function(iid, gateways, DPPA_Purpose, GLB_Purpose, isUtility, ln_branded_value,  
											includeRelativeInfo, includeDLInfo, includeVehInfo, includeDerogInfo, DataRestriction:=DataRestriction,
											DataPermission:=DataPermission);

				
r := RECORD
	business_risk.Layout_Final_Denorm;
	DATASET(Models.Layout_Model) models;
end;
	
riskwise.Layout_BusReasons_Input into_orig_input(biid le) := transform
	self.seq := le.seq;
	self.orig_addr := stringlib.stringtouppercase(addr);
	self.orig_city := stringlib.stringtouppercase(city);
	self.orig_state := stringlib.stringtouppercase(state);
	self.orig_zip := zip;
	self.orig_fax := '';
	self.orig_cmpy := le.company_name;
	self.orig_wphone := le.phone10;
	self.telcoPhoneType := le.TelcordiaPhoneType;
	
	bans_current := if(((integer)(ut.GetDate[1..6]) - (integer)(le.RecentBkDate[1..6])) < 1000, true, false);  // make sure the bans is within the last 10 years
	lien_current := if(((integer)(ut.GetDate[1..6]) - (integer)(le.RecentLienDate[1..6])) < 1000, true, false);  // make sure the bans is within the last 10 years
	self.cmpy_bans :=  map(le.fein='' or (le.company_name='' and addr='') => '3',
											  le.bkbdidflag and le.lienbdidflag and bans_current and lien_current => '5',
										       le.bkbdidflag and bans_current => '2', 
											  le.lienbdidflag and lien_current => '4',
						   					   '0');								   
end;

orig_input := project(biid, into_orig_input(left));

// for 2x42, we're just returning the 0-999 score																	
ret := Models.BD3605_0_0(clam, biid, orig_input, ofac_only, true, include_additional_watchlists);

models.Layout_Reason_Codes form_rc(ret le) :=
TRANSFORM
	SELF.reason_code := if(le.ri[1].hri <> '00', le.ri[1].hri, '');
	SELF.reason_description := le.ri[1].desc;
end;
models.Layout_Reason_Codes form_rc2(ret le) :=
TRANSFORM
	SELF.reason_code := if(le.ri[2].hri <> '00', le.ri[2].hri, '');
	SELF.reason_description := le.ri[2].desc;
end;
models.Layout_Reason_Codes form_rc3(ret le) :=
TRANSFORM
	SELF.reason_code := if(le.ri[3].hri <> '00', le.ri[3].hri, '');
	SELF.reason_description := le.ri[3].desc;
end;
models.Layout_Reason_Codes form_rc4(ret le) :=
TRANSFORM
	SELF.reason_code := if(le.ri[4].hri <> '00', le.ri[4].hri, '');
	SELF.reason_description := le.ri[4].desc;
end;

models.Layout_Score form_cscore(ret le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := '0 to 999';
	reason_codes := PROJECT(le,form_rc(LEFT)) + PROJECT(le,form_rc2(LEFT)) + PROJECT(le,form_rc3(LEFT)) + PROJECT(le,form_rc4(LEFT));
	risk_indicators.MAC_add_sequence(reason_codes(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
END;


models.layout_model form_model(ret le) := TRANSFORM
	self.accountnumber := account_value;
	self.description := 'BusinessDefender';
	self.scores := PROJECT(le,form_cscore(LEFT));
END;

scores := project(ret, form_model(LEFT));

r into_final(biid L, scores R) := transform
	self.PRI_seq_1 := if(L.pri1 = '', '', '1');
	self.PRI_seq_2 := if(L.pri2 = '', '', '2');
	self.PRI_seq_3 := if(L.pri3 = '', '', '3');
	self.PRI_seq_4 := if(L.pri4 = '', '', '4');
	self.PRI_seq_5 := if(L.pri5 = '', '', '5');
	self.PRI_seq_6 := if(L.pri6 = '', '', '6');
	self.PRI_seq_7 := if(L.pri7 = '', '', '7');
	self.PRI_seq_8 := if(L.pri8 = '', '', '8');
	self.Rep_PRI_seq_1 := if (L.rep_pri1 = '', '' , '1');
	self.Rep_PRI_seq_2 := if (L.rep_pri2 = '', '' , '2');
	self.Rep_PRI_seq_3 := if (L.rep_pri3 = '', '' , '3');
	self.Rep_PRI_seq_4 := if (L.rep_pri4 = '', '' , '4');
	self.Rep_PRI_seq_5 := if (L.rep_pri5 = '', '' , '5');
	self.Rep_PRI_seq_6 := if (L.rep_pri6 = '', '' , '6');
	self.Watchlist_seq_1 := if(l.watchlist_table='', '', '1');
	self.Watchlist_seq_2 := if(l.watchlist_table_2='', '', '2');
	self.Watchlist_seq_3 := if(l.watchlist_table_3='', '', '3');
	self.Watchlist_seq_4 := if(l.watchlist_table_4='', '', '4');
	self.Watchlist_seq_5 := if(l.watchlist_table_5='', '', '5');
	self.Watchlist_seq_6 := if(l.watchlist_table_6='', '', '6');
	self.Watchlist_seq_7 := if(l.watchlist_table_7='', '', '7');
	self.RepWatchlist_seq_1 := if(l.repwatchlist_table='', '', '1');
	self.RepWatchlist_seq_2 := if(l.repwatchlist_table_2='', '', '2');
	self.RepWatchlist_seq_3 := if(l.repwatchlist_table_3='', '', '3');
	self.RepWatchlist_seq_4 := if(l.repwatchlist_table_4='', '', '4');
	self.RepWatchlist_seq_5 := if(l.repwatchlist_table_5='', '', '5');
	self.RepWatchlist_seq_6 := if(l.repwatchlist_table_6='', '', '6');
	self.RepWatchlist_seq_7 := if(l.repwatchlist_table_7='', '', '7');
	self.pri_1 := L.pri1;
	self.pri_desc_1 := if( L.pri1 = '', '', business_risk.Tra_Bus_PRI(L.pri1) );
	self.pri_2 := L.pri2;
	self.pri_desc_2 := if( L.pri2 = '', '', business_risk.Tra_Bus_PRI(L.pri2) );
	self.pri_3 := L.pri3;
	self.pri_desc_3 := if( L.pri3 = '', '', business_risk.Tra_Bus_PRI(L.pri3) );
	self.pri_4 := L.pri4;
	self.pri_desc_4 := if( L.pri4 = '', '', business_risk.Tra_Bus_PRI(L.pri4) );
	self.pri_5 := L.pri5;
	self.pri_desc_5 := if( L.pri5 = '', '', business_risk.Tra_Bus_PRI(L.pri5) );
	self.pri_6 := L.pri6;
	self.pri_desc_6 := if( L.pri6 = '', '', business_risk.Tra_Bus_PRI(L.pri6) );
	self.pri_7 := L.pri7;
	self.pri_desc_7 := if( L.pri7 = '', '', business_risk.Tra_Bus_PRI(L.pri7) );
	self.pri_8 := L.pri8;
	self.pri_desc_8 := if( L.pri8 = '', '', business_risk.Tra_Bus_PRI(L.pri8) );
	self.rep_pri_1 := L.rep_pri1;
	self.rep_pri_desc_1 := if (L.rep_pri1 = '', '' , business_risk.Tra_Rep_PRI((L.rep_pri1)));
	self.rep_pri_2 := L.rep_pri2;
	self.rep_pri_desc_2 := if (L.rep_pri2 = '', '' , business_risk.Tra_Rep_PRI((L.rep_pri2)));
	self.rep_pri_3 := L.rep_pri3;
	self.rep_pri_desc_3 := if (L.rep_pri3 = '', '' , business_risk.Tra_Rep_PRI((L.rep_pri3)));
	self.rep_pri_4 := L.rep_pri4;
	self.rep_pri_desc_4 := if (L.rep_pri4 = '', '' , business_risk.Tra_Rep_PRI((L.rep_pri4)));
	self.rep_pri_5 := L.rep_pri5;
	self.rep_pri_desc_5 := if (L.rep_pri5 = '', '' , business_risk.Tra_Rep_PRI((L.rep_pri5)));
	self.rep_pri_6 := L.rep_pri6;
	self.rep_pri_desc_6 := if (L.rep_pri6 = '', '' , business_risk.Tra_Rep_PRI((L.rep_pri6)));
	self.rep_followup_1 := L.rep_followup1;
	self.rep_followup_desc_1 := business_risk.Tra_Rep_Followups(L.rep_followup1);
	self.rep_followup_2 := L.rep_followup2;
	self.rep_followup_desc_2 := business_risk.Tra_Rep_Followups(L.rep_followup2);
	self.rep_followup_3 := L.rep_followup3;
	self.rep_followup_desc_3 := business_risk.Tra_Rep_Followups(L.rep_followup3);
	self.rep_followup_4 := L.rep_followup4;
	self.rep_followup_desc_4 := business_risk.Tra_Rep_Followups(L.rep_followup4);
	self.bdid := intformat(L.bdid, 12, 1);
	self.score := intformat(L.score, 3, 0);
	self.Account := L.account;
	self.verNotRecentFlag := if (L.verNotRecentFlag, 'Y', 'N');
	self.bestCompanyNameScore := intformat(L.bestCompanyNameScore, 3, 0);
	self.bestAddrScore := intformat(L.bestAddrScore, 3, 0);
	self.bestFEINScore := intformat(L.bestFEINScore, 3, 0);
	self.bestPhoneScore := intformat(L.bestPhoneScore, 3, 0);
	self.dt_first_Seen_min := (String)L.dt_first_seen_min;
	self.dt_last_seen_max := (string)L.dt_last_seen_max;
	//self.watchlist_num_with_name := (string)L.watchlist_num_with_name;
	self.dist_homeAddr_BusAddr := (string)L.dist_homeAddr_BusAddr;
	self.dist_homePhone_BusAddr := (string)L.dist_homePhone_busAddr;
	self.dist_homeAddr_busPhone := (string)L.dist_HomeAddr_BusPhone;
	self.dist_homePhone_BusPhone := (string)L.dist_HomePhone_BusPHone;
	self.dist_homePhone_HomeAddr := (string)L.dist_HomePhone_HomeAddr;
	self.dist_BusPhone_BusAddr	:= (string)L.dist_BusPhone_BusAddr;
	self.Hist_date_last_Seen_1 := (string)L.Hist_date_last_seen_1;
	self.Hist_date_last_Seen_2 := (string)L.Hist_date_last_seen_2;
	self.Hist_date_last_Seen_3 := (string)L.Hist_date_last_seen_3;
	self.repWatchlist_num_with_name := (string)L.repWatchlist_Num_With_Name;
	self.UnreleasedLienCount := intformat(L.unreleasedLienCount,4,0);
	self.ReleasedLienCount  := intformat(L.releasedLienCount,4, 0);
	self.TotalBKCount	:= (string)L.bankruptcy_Count;
	self.addr1 := Risk_Indicators.MOD_AddressClean.street_address('',L.prim_range, L.predir, L.prim_name, L.addr_suffix, L.postdir, L.unit_desig, L.sec_range);
	self.rep_addr1 := Risk_Indicators.MOD_AddressClean.street_address('',L.rep_prim_range, L.rep_predir, L.rep_prim_name, L.rep_addr_suffix, L.rep_postdir, L.rep_unit_desig, L.rep_sec_range); 
	self.addrmatchphone := L.CmpyPhoneFromAddr;
	self.verzip := if (L.verzip != '', intformat((integer)L.verzip,5,1),'');
	self.bestZip := if (L.bestZip != '', intformat((integer)L.bestZip,5,1),'');
	self.bestZip4 := if (L.bestZip4 != '', intformat((integer)L.bestZip4,4,1),'');
	self.phoneMatchZip := if (L.phoneMatchZip != '', intformat((integer)L.phoneMatchZip,5,1),'');
	self.phoneMatchZip4 := if (L.phoneMatchZip4 != '', intformat((integer)L.phoneMatchZip4,4,1),'');
	self.FEINMatchZip1 := if (L.FEINMatchZip1 != '', intformat((integer)L.FEINMatchZip1,5,1),'');
	self.FEINMatchZip4_1 := if (L.FEINMatchZip4_1 != '', intformat((integer)L.FEINMatchZip4_1,4,1),'');
	self.FEINMatchZip2 := if (L.FEINMatchZip2 != '', intformat((integer)L.FEINMatchZip2,5,1),'');
	self.FEINMatchZip4_2 := if (L.FEINMatchZip4_2 != '', intformat((integer)L.FEINMatchZip4_2,4,1),'');
	self.FEINMatchZip3 := if (L.FEINMatchZip3 != '', intformat((integer)L.FEINMatchZip3,5,1),'');
	self.FEINMatchZip4_3 := if (L.FEINMatchZip4_3 != '', intformat((integer)L.FEINMatchZip4_3,4,1),'');
	self.RecentBkZip := if (L.RecentBkZip != '', intformat((integer)L.RecentBkZip,5,1),'');
	self.RecentBkZip4 := if (L.RecentBkZip4 != '', intformat((integer)L.RecentBkZip4,4,1),'');
	self.RecentLienZip := if (L.RecentLienZip != '', intformat((integer)L.RecentLienZip,5,1),'');
	self.RecentLienZip4 := if (L.RecentLienZip4 != '', intformat((integer)L.RecentLienZip4,4,1),'');
	self.watchlist_zip := if (L.watchlist_zip != '', intformat((integer)L.watchlist_zip,5,1),'');
	self.RepZipVerify := if (L.RepZipVerify != '', intformat((integer)L.RepZipVerify,5,1),'');
	self.RepZip4Verify := if (L.RepZip4Verify != '', intformat((integer)L.RepZip4Verify,4,1),'');
	self.RepBestZip := if (L.RepBestZip != '', intformat((integer)L.RepBestZip,5,1),'');
	self.RepBestZip4 := if (L.RepBestZip4 != '', intformat((integer)L.RepBestZip4,4,1),'');
	self.RepPhoneZip := if (L.RepPhoneZip != '', intformat((integer)L.RepPhoneZip,5,1),'');
	self.RepPhoneZip4 := if (L.RepPhoneZip4 != '', intformat((integer)L.RepPhoneZip4,4,1),'');
	self.RepWatchlist_zip := if (L.RepWatchlist_zip != '', intformat((integer)L.RepWatchlist_zip,5,1),'');
	self.Hist_Zip_1 := if (L.Hist_Zip_1 != '', intformat((integer)L.Hist_Zip_1,5,1),'');
	self.Hist_Zip4_1 := if (L.Hist_Zip4_1 != '', intformat((integer)L.Hist_Zip4_1,4,1),'');
	self.Hist_Zip_2 := if (L.Hist_Zip_2 != '', intformat((integer)L.Hist_Zip_2,5,1),'');
	self.Hist_Zip4_2 := if (L.Hist_Zip4_2 != '', intformat((integer)L.Hist_Zip4_2,4,1),'');
	self.Hist_Zip_3 := if (L.Hist_Zip_3 != '', intformat((integer)L.Hist_Zip_3,5,1),'');
	self.Hist_Zip4_3 := if (L.Hist_Zip4_3 != '', intformat((integer)L.Hist_Zip4_3,4,1),'');	
	self.areacodesplitdate := if(l.areacodesplitflag='Y', l.areacodesplitdate, '');
	self.altareacode := if(l.areacodesplitflag='Y', l.altareacode, '');
	self.models := r;
	self := l;
end;


with_models := join(biid, scores, left.account=right.accountnumber, into_final(left,right));
	

	// check for testseed record
		seed := Choosen(Seed_Files.Key_bd1obd1i( keyed(trib=tribcode), keyed(fein1 = fein_value) ),1);
		
		Models.Layout_Model make_models(Seed_Files.Key_bd1obd1i le):=transform
			self.AccountNumber := Account_value;
			self.Description := 'BusinessDefender';
			reasoncodes := dataset([{le.fd_Reason1,le.fd_Desc1},{le.fd_Reason2,le.fd_Desc2},
					{le.fd_Reason3,le.fd_Desc3},{le.fd_Reason4,le.fd_Desc4}],models.Layout_Reason_Codes);
			risk_indicators.MAC_add_sequence(reasoncodes, reasoncodes_with_seq);
			self.Scores := dataset([{le.fd_score1,'0 to 999', '', reasoncodes_with_seq}],models.Layout_Score);
		END;
		
		r Make_BInstantID_rec(Seed_Files.Key_bd1obd1i Le) :=Transform
			self.Models :=project(le,make_models(left));
			self.account :=Account_value;
			self := le;	
			self := [];
		END;
		
		seed_final :=project(seed, Make_BInstantID_rec(left));
	// end of seed check	
	
	
	final := if(test_data_enabled and count(seed_final) > 0, seed_final, with_models);
	#stored('Royalties', iidRoyalties);
	return final;
	
END;
