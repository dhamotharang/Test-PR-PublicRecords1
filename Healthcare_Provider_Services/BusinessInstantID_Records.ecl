Import iesp,Business_Risk,Healthcare_Header_Services;
export BusinessInstantID_Records (Healthcare_Header_Services.IParams.ReportParams inputData) := module
// Pass in global object and build input object for 
	rawData := Business_Risk.business_instantid_records();
	output_layout := iesp.instantid.t_BusinessInstantIDResult;
	output_layout xform(Business_Risk.Layout_Output input) := TRANSFORM
		// Echo Input section
		self.InputEcho.CompanyName := input.company_name;
		self.InputEcho.AlternateCompanyName := input.alt_company_name;
		self.InputEcho.CompanyAddress := iesp.ECL2ESP.SetAddress(input.prim_name, input.prim_range, 
				input.predir, input.postdir, input.addr_suffix, '', input.sec_range, input.p_city_name,
				input.st, input.z5, '', '', '', '', '', '');
		self.InputEcho.FEIN := inputData.fein;
		self.InputEcho.CompanyPhone := input.phone10;
		self.InputEcho.AuthorizedRepresentative.Name := [];
		self.InputEcho.AuthorizedRepresentative.Address := [];
		self.InputEcho.AuthorizedRepresentative.DOB := [];
		self.InputEcho.AuthorizedRepresentative.Age := 0;
		self.InputEcho.AuthorizedRepresentative.SSN := '';
		self.InputEcho.AuthorizedRepresentative.DriverLicenseNumber := '';
		self.InputEcho.AuthorizedRepresentative.DriverLicenseState := '';
		self.InputEcho.AuthorizedRepresentative.Phone10 := '';
		self.InputEcho.AuthorizedRepresentative.FormerLastName := '';
		self.InputEcho.UseDOBFilter := false;
		self.InputEcho.DOBRadius := 0;
		// AuthorizedRepresentativeResults Section
		self.AuthorizedRepresentativeResults.VerificationIndicators.Name := if(input.repNameVerFlag = 'Y',true,false);
		self.AuthorizedRepresentativeResults.VerificationIndicators.Address := if(input.RepAddrVerFlag = 'Y',true,false);
		self.AuthorizedRepresentativeResults.VerificationIndicators.Phone10 := if(input.RepPhoneVerFlag = 'Y',true,false);
		self.AuthorizedRepresentativeResults.VerificationIndicators.SSN := if(input.RepSSNVerFlag = 'Y',true,false);
		self.AuthorizedRepresentativeResults.VerificationIndicators.DOB := if(input.RepDobVerFlag = 'Y',true,false);
		self.AuthorizedRepresentativeResults.VerifiedInput.Name := iesp.ECL2ESP.SetName(input.RepFNameVerify, '', input.RepLNameVerify, '', '', '');
		self.AuthorizedRepresentativeResults.VerifiedInput.Address := iesp.ECL2ESP.SetAddress('', '', '', '', '', '', '', 
				input.RepCityVerify, input.RepStateVerify, input.RepZipVerify, input.RepZip4Verify, input.RepCountyVerify, '', input.RepAddrVerify, '', '');
		self.AuthorizedRepresentativeResults.VerifiedInput.SSN := input.RepSSNVerify;
		self.AuthorizedRepresentativeResults.VerifiedInput.Phone10 := input.RepPhoneVerify;
		self.AuthorizedRepresentativeResults.VerifiedInput.DOB := iesp.ECL2ESP.toDatestring8(input.RepDOBVerify);
		self.AuthorizedRepresentativeResults.VerifiedInput2.DriverLicenseNumber := '';
		self.AuthorizedRepresentativeResults.NameAddressSSNSummary := input.RepNAS_Score;
		self.AuthorizedRepresentativeResults.NameAddressPhoneSummary := input.RepNAP_Score;
		self.AuthorizedRepresentativeResults.ComprehensiveVerificationIndex := input.RepCVI;
		self.AuthorizedRepresentativeResults.AdditionalScore1 := input.Rep_Additional_score1;
		self.AuthorizedRepresentativeResults.AdditionalScore2 := input.Rep_Additional_Score2;
		dsAuthRepRiskInd := choosen(dataset([{input.rep_pri1, business_risk.Tra_Bus_PRI(input.rep_pri1)},
																 {input.rep_pri2, business_risk.Tra_Bus_PRI(input.rep_pri2)},
																 {input.rep_pri3, business_risk.Tra_Bus_PRI(input.rep_pri3)},
																 {input.rep_pri4, business_risk.Tra_Bus_PRI(input.rep_pri4)},
																 {input.rep_pri5, business_risk.Tra_Bus_PRI(input.rep_pri5)},
																 {input.rep_pri6, business_risk.Tra_Bus_PRI(input.rep_pri6)}],iesp.share.t_RiskIndicator),iesp.Constants.Identifier2c.MaxRiskIndicators);
		self.AuthorizedRepresentativeResults.RiskIndicators := dsAuthRepRiskInd(RiskCode<>''); 
		iesp.share.t_SequencedRiskIndicator AuthRepRiskIndAddSequence(iesp.share.t_RiskIndicator l, INTEGER c) := TRANSFORM
				SELF.Sequence := if(l.RiskCode <> '',c,skip);
				SELF := l;
				END;
		dsAuthRepRiskIndSeq := project(dsAuthRepRiskInd, AuthRepRiskIndAddSequence(left,counter));
		self.AuthorizedRepresentativeResults.SeqRiskIndicators := dsAuthRepRiskIndSeq;
		dsAuthRepFollowAction := dataset([{input.Rep_FollowUp1, business_risk.Tra_Rep_Followups(input.Rep_FollowUp1)},
																 {input.Rep_FollowUp2, business_risk.Tra_Rep_Followups(input.Rep_FollowUp2)},
																 {input.Rep_FollowUp3, business_risk.Tra_Rep_Followups(input.Rep_FollowUp3)},
																 {input.Rep_FollowUp4, business_risk.Tra_Rep_Followups(input.Rep_FollowUp4)}],iesp.instantid.t_FollowupAction);
		self.AuthorizedRepresentativeResults.FollowupActions := dsAuthRepFollowAction(Action<>'');
		self.AuthorizedRepresentativeResults.InputCorrected.Name := iesp.ECL2ESP.SetName(input.RepBestFname, '', input.RepBestLname, '', '', '');
		self.AuthorizedRepresentativeResults.InputCorrected.Address := iesp.ECL2ESP.SetAddress(input.RepBestPrimName, input.RepBestPrimRange, '', '', '', '', input.RepBestSecRange, 
				input.RepBestCity, input.RepBestState, input.RepBestZip, input.RepBestZip4, '', '', input.RepBestAddr1, '', '');
		self.AuthorizedRepresentativeResults.InputCorrected.SSN := input.RepBestSSN;
		self.AuthorizedRepresentativeResults.InputCorrected.Phone10 := input.RepBestPhone;
		self.AuthorizedRepresentativeResults.InputCorrected.DOB := iesp.ECL2ESP.toDatestring8(input.RepBestDOB);
		self.AuthorizedRepresentativeResults.AreaCodeSplitFlag := input.areacodesplitflag;
		self.AuthorizedRepresentativeResults.NewAreaCode.AreaCode := input.altareacode;
		self.AuthorizedRepresentativeResults.NewAreaCode.EffectiveDate := iesp.ECL2ESP.toDatestring8(input.areacodesplitdate);
		self.AuthorizedRepresentativeResults.ReversePhone.Name := iesp.ECL2ESP.SetName(input.RepPhoneFname, '', input.RepPhoneLname, '', '', '');
		self.AuthorizedRepresentativeResults.ReversePhone.Address := iesp.ECL2ESP.SetAddress('', '', '', '', '', '', '', 
				input.RepPhoneCity, input.RepPhoneState, input.RepPhoneZip, input.RepPhoneZip4, '', '', input.RepPhoneAddr1, '', '');
		self.AuthorizedRepresentativeResults.PhoneOfNameAddress := input.RepPhoneFromAddr;
		self.AuthorizedRepresentativeResults.SSNInfo.SSN := input.RepBestSSN;
		self.AuthorizedRepresentativeResults.SSNInfo.Valid := input.Valid_SSN;
		self.AuthorizedRepresentativeResults.SSNInfo.IssuedLocation := input.RepSSNIssueState;
		self.AuthorizedRepresentativeResults.SSNInfo.IssuedStartDate := iesp.ECL2ESP.toDatestring8(input.RepSSNEarlyDate);
		self.AuthorizedRepresentativeResults.SSNInfo.IssuedEndDate := iesp.ECL2ESP.toDatestring8(input.RepSSNLateDate);
		addrHist1 := project(input,transform(iesp.instantid.t_AlternateAddress, 
																						self.address:=iesp.ECL2ESP.SetAddress('', '', '', '', '', '', '',	left.Hist_City_1, left.Hist_State_1, left.Hist_Zip_1, left.Hist_Zip4_1, '', '', left.Hist_Addr_1, '', '');
																						self.Phone10:=left.Hist_Phone_1;
																						self.DateLastSeen:=iesp.ECL2ESP.toDate(left.Hist_Date_Last_Seen_1);
																						self.IsBestAddress:=if(left.Hist_Addr_1_isBest = 'Y',true,false)));
		addrHist2 := project(input,transform(iesp.instantid.t_AlternateAddress, 
																						self.address:=iesp.ECL2ESP.SetAddress('', '', '', '', '', '', '',	left.Hist_City_2, left.Hist_State_2, left.Hist_Zip_2, left.Hist_Zip4_2, '', '', left.Hist_Addr_2, '', '');
																						self.Phone10:=left.Hist_Phone_2;
																						self.DateLastSeen:=iesp.ECL2ESP.toDate(left.Hist_Date_Last_Seen_2);
																						self.IsBestAddress:=if(left.Hist_Addr_2_isBest = 'Y',true,false)));
		addrHist3 := project(input,transform(iesp.instantid.t_AlternateAddress, 
																						self.address:=iesp.ECL2ESP.SetAddress('', '', '', '', '', '', '',	left.Hist_City_3, left.Hist_State_3, left.Hist_Zip_3, left.Hist_Zip4_3, '', '', left.Hist_Addr_3, '', '');
																						self.Phone10:=left.Hist_Phone_3;
																						self.DateLastSeen:=iesp.ECL2ESP.toDate(left.Hist_Date_Last_Seen_3);
																						self.IsBestAddress:=if(left.Hist_Addr_3_isBest = 'Y',true,false)));
		self.AuthorizedRepresentativeResults.AlternateAddressPhones := addrHist1+addrHist2+addrHist3;
		aka1 := project(input,transform(iesp.instantid.t_AlternateName, 
																						self.Name:=iesp.ECL2ESP.SetName(left.Alt_Fname_1, '', left.Alt_Lname_1, '', '', '');
																						self.DateLastSeen:=iesp.ECL2ESP.toDatestring8(left.Alt_Date_Last_Seen_1)));
		aka2 := project(input,transform(iesp.instantid.t_AlternateName, 
																						self.Name:=iesp.ECL2ESP.SetName(left.Alt_Fname_2, '', left.Alt_Lname_2, '', '', '');
																						self.DateLastSeen:=iesp.ECL2ESP.toDatestring8(left.Alt_Date_Last_Seen_2)));
		aka3 := project(input,transform(iesp.instantid.t_AlternateName, 
																						self.Name:=iesp.ECL2ESP.SetName(left.Alt_Fname_3, '', left.Alt_Lname_3, '', '', '');
																						self.DateLastSeen:=iesp.ECL2ESP.toDatestring8(left.Alt_Date_Last_Seen_3)));
		self.AuthorizedRepresentativeResults.AKAs := aka1+aka2+aka3; 
		RepWatchList1 := if(input.RepWatchlist_Record_Number<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.RepWatchlist_table;
																						 self.RecordNumber := left.RepWatchlist_Record_Number;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.RepWatchlist_fname, '', (string)left.RepWatchlist_lname, '', '', '');
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.RepWatchlist_city, left.RepWatchlist_state, 
																																			left.RepWatchlist_zip,'','','', left.RepWatchlist_address,'','');
																						 self.Country := left.RepWatchlist_country;
																						 self.EntityName := (string)left.RepWatchlist_entity_name;
																						 self.Sequence := 1)));
		RepWatchList2 := if(input.RepWatchlist_Record_Number_2<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.RepWatchlist_table_2;
																						 self.RecordNumber := left.RepWatchlist_Record_Number_2;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.RepWatchlist_fname_2, '', (string)left.RepWatchlist_lname_2, '', '', '');
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.RepWatchlist_city_2, left.RepWatchlist_state_2, 
																																			left.RepWatchlist_zip_2,'','','', left.RepWatchlist_address_2,'','');
																						 self.Country := left.RepWatchlist_country_2;
																						 self.EntityName := (string)left.RepWatchlist_entity_name_2;
																						 self.Sequence := 2)));
		RepWatchList3 := if(input.RepWatchlist_Record_Number_3<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.RepWatchlist_table_3;
																						 self.RecordNumber := left.RepWatchlist_Record_Number_3;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.RepWatchlist_fname_3, '', (string)left.RepWatchlist_lname_3, '', '', '');
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.RepWatchlist_city_3, left.RepWatchlist_state_3, 
																																			left.RepWatchlist_zip_3,'','','', left.RepWatchlist_address_3,'','');
																						 self.Country := left.RepWatchlist_country_3;
																						 self.EntityName := (string)left.RepWatchlist_entity_name_3;
																						 self.Sequence := 3)));
		RepWatchList4 := if(input.RepWatchlist_Record_Number_4<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.RepWatchlist_table_4;
																						 self.RecordNumber := left.RepWatchlist_Record_Number_4;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.RepWatchlist_fname_4, '', (string)left.RepWatchlist_lname_4, '', '', '');
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.RepWatchlist_city_4, left.RepWatchlist_state_4, 
																																			left.RepWatchlist_zip_4,'','','', left.RepWatchlist_address_4,'','');
																						 self.Country := left.RepWatchlist_country_4;
																						 self.EntityName := (string)left.RepWatchlist_entity_name_4;
																						 self.Sequence := 4)));
		RepWatchList5 := if(input.RepWatchlist_Record_Number_5<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.RepWatchlist_table_5;
																						 self.RecordNumber := left.RepWatchlist_Record_Number_5;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.RepWatchlist_fname_5, '', (string)left.RepWatchlist_lname_5, '', '', '');
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.RepWatchlist_city_5, left.RepWatchlist_state_5, 
																																			left.RepWatchlist_zip_5,'','','', left.RepWatchlist_address_5,'','');
																						 self.Country := left.RepWatchlist_country_5;
																						 self.EntityName := (string)left.RepWatchlist_entity_name_5;
																						 self.Sequence := 5)));
		RepWatchList6 := if(input.RepWatchlist_Record_Number_6<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.RepWatchlist_table_6;
																						 self.RecordNumber := left.RepWatchlist_Record_Number_6;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.RepWatchlist_fname_6, '', (string)left.RepWatchlist_lname_6, '', '', '');
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.RepWatchlist_city_6, left.RepWatchlist_state_6, 
																																			left.RepWatchlist_zip_6,'','','', left.RepWatchlist_address_6,'','');
																						 self.Country := left.RepWatchlist_country_6;
																						 self.EntityName := (string)left.RepWatchlist_entity_name_6;
																						 self.Sequence := 6)));
		RepWatchList7 := if(input.RepWatchlist_Record_Number_7<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.RepWatchlist_table_7;
																						 self.RecordNumber := left.RepWatchlist_Record_Number_7;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.RepWatchlist_fname_7, '', (string)left.RepWatchlist_lname_7, '', '', '');
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.RepWatchlist_city_7, left.RepWatchlist_state_7, 
																																			left.RepWatchlist_zip_7,'','','', left.RepWatchlist_address_7,'','');
																						 self.Country := left.RepWatchlist_country_7;
																						 self.EntityName := (string)left.RepWatchlist_entity_name_7;
																						 self.Sequence := 7)));
		self.AuthorizedRepresentativeResults.WatchListMatch := RepWatchList1;
		repWatchListCombine := RepWatchList1+RepWatchList2+RepWatchList3+RepWatchList4+RepWatchList5+RepWatchList6+RepWatchList7;
		self.AuthorizedRepresentativeResults.WatchLists := choosen(if(exists(repWatchListCombine),repWatchListCombine),iesp.Constants.Identifier2c.MaxWatchlists);
		self.AuthorizedRepresentativeResults.DecedentInfo.Name := iesp.ECL2ESP.SetName(input.rep_deceasedFirst, '', input.rep_deceasedLast, '', '', '');
		self.AuthorizedRepresentativeResults.DecedentInfo.DOD := iesp.ECL2ESP.toDatestring8(input.rep_deceasedDate);
		self.AuthorizedRepresentativeResults.DecedentInfo.DOB := iesp.ECL2ESP.toDatestring8(input.rep_deceasedDOB);
		self.AuthorizedRepresentativeResults.FoundSSNCount := input.rep_ssncount;
		// CompanyResults Section
		self.CompanyResults.BusinessId := (string)input.bdid;
		self.CompanyResults.SOSFilingName := input.SOS_filing_name;
		self.CompanyResults.VerificationIndicators.CompanyName := if(input.CnameMatchflag = 'Y',true,false);
		self.CompanyResults.VerificationIndicators.Address := if(input.AddrMatchFlag = 'Y',true,false);
		self.CompanyResults.VerificationIndicators.City := if(input.CityMatchFlag = 'Y',true,false);
		self.CompanyResults.VerificationIndicators.State := if(input.StateMatchFlag = 'Y',true,false);
		self.CompanyResults.VerificationIndicators.Zip := if(input.ZipMatchFlag = 'Y',true,false);
		self.CompanyResults.VerificationIndicators.Phone10 := if(input.PhoneMatchFlag = 'Y',true,false);
		self.CompanyResults.VerificationIndicators._FEIN := if(input.FeinMatchFlag = 'Y',true,false);
		self.CompanyResults.VerifiedInput.CompanyName := input.vercmpy;
		self.CompanyResults.VerifiedInput.Address := iesp.ECL2ESP.SetAddress('', '', '', '', '', '', '', 
				input.vercity, input.verstate, input.verzip, input.verzip4, input.vercounty, '', input.veraddr, '', '');
		self.CompanyResults.VerifiedInput.Phone10 := input.verphone;
		self.CompanyResults.VerifiedInput._FEIN := input.verfein;
		self.CompanyResults.NameAddressPhoneIndicator := (integer)input.BNAP_Indicator;
		self.CompanyResults.NameAddressFEINIndicator := (integer)input.BNAT_Indicator;
		self.CompanyResults.NameAddressSSNIndicator := (integer)input.BNAS_Indicator;
		self.CompanyResults.BusinessVerificationIndicator := (integer)input.BVI;
		self.CompanyResults.SICCode := input.sic_code;
		self.CompanyResults.NAICSCode := input.naics_code;
		self.CompanyResults.BusinessDescription := input.business_description;
		self.CompanyResults.AdditionalScore1 := input.additional_score_1;
		self.CompanyResults.AssitionalScore2 := input.additional_score_2;
		dsRiskInd := choosen(dataset([{input.pri1, business_risk.Tra_Bus_PRI(input.pri1)},
													{input.pri2, business_risk.Tra_Bus_PRI(input.pri2)},
													{input.pri3, business_risk.Tra_Bus_PRI(input.pri3)},
													{input.pri4, business_risk.Tra_Bus_PRI(input.pri4)},
													{input.pri5, business_risk.Tra_Bus_PRI(input.pri5)},
													{input.pri6, business_risk.Tra_Bus_PRI(input.pri6)},
													{input.pri7, business_risk.Tra_Bus_PRI(input.pri7)},
													{input.pri8, business_risk.Tra_Bus_PRI(input.pri8)}],iesp.share.t_RiskIndicator),iesp.Constants.Identifier2c.MaxRiskIndicators);
		self.CompanyResults.RiskIndicators := dsRiskInd(RiskCode<>'');
		iesp.share.t_SequencedRiskIndicator RiskIndAddSequence(iesp.share.t_RiskIndicator l, INTEGER c) := TRANSFORM
				SELF.Sequence := if(l.RiskCode <> '',c,skip);
				SELF := l;
				END;
		dsRiskIndSeq := project(dsAuthRepRiskInd, RiskIndAddSequence(left,counter));
		self.CompanyResults.SeqRiskIndicators := dsRiskIndSeq;
		self.CompanyResults.InputCorrected.CompanyName := input.bestCompanyName;
		self.CompanyResults.InputCorrected.NameScore := input.score;
		self.CompanyResults.InputCorrected.Address := iesp.ECL2ESP.SetAddress('', '', '', '', '', '', '', 
				input.bestCity, input.bestState, input.bestZip, input.bestZip4, '', '', input.bestAddr, '', '');
		self.CompanyResults.InputCorrected.Phone10 := input.bestPhone;
		self.CompanyResults.InputCorrected.FEIN := input.bestFEIN;
		self.CompanyResults.InputCorrected.DateFirstSeen := iesp.ECL2ESP.toDate(input.dt_first_seen_min);
		self.CompanyResults.NameAddressOfPhone.CompanyName := if(input.PhoneMatchCompany <> '',input.PhoneMatchCompany,input.PhoneMatchFirst+' '+input.PhoneMatchLast);
		self.CompanyResults.NameAddressOfPhone.Address := iesp.ECL2ESP.SetAddress('', '', '', '', '', '', '', 
				input.PhoneMatchCity, input.phoneMatchState, input.phoneMatchZip, input.phoneMatchZip4, '', '', input.phoneMatchAddr, '', '');
		self.CompanyResults.PhoneOfNameAddress := input.CmpyPhoneFromAddr;
		feinMatch1 := project(input, transform(iesp.instantid.t_CompanyNameAddress, 
														 self.CompanyName := left.FEINMatchCompany1;
														 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.FEINMatchCity1, left.FEINMatchState1, 
																									left.FEINMatchZip1,left.FEINMatchZip4_1,'','', left.FEINMatchAddr1,'','')));
		feinMatch2 := project(input, transform(iesp.instantid.t_CompanyNameAddress, 
														 self.CompanyName := left.FEINMatchCompany2;
														 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.FEINMatchCity2, left.FEINMatchState2, 
																									left.FEINMatchZip2,left.FEINMatchZip4_2,'','', left.FEINMatchAddr2,'','')));
		feinMatch3 := project(input, transform(iesp.instantid.t_CompanyNameAddress, 
														 self.CompanyName := left.FEINMatchCompany3;
														 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.FEINMatchCity3, left.FEINMatchState3, 
																									left.FEINMatchZip3,left.FEINMatchZip4_3,'','', left.FEINMatchAddr3,'','')));
		self.CompanyResults.FEINMatchResults := feinMatch1+feinMatch2+feinMatch3;
		self.CompanyResults.AddressType := input.BAddrType;
		self.CompanyResults.PhoneType := input.BPhoneType;
		// Bankruptcy Info 
		self.CompanyResults.BankruptcyCount := input.bankruptcy_count;
		bkrupt := project(input, transform(iesp.instantid.t_CompanyNameAddress, 
														 self.CompanyName := left.RecentBkName;
														 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.RecentBkCity, left.RecentBkState, 
																									left.RecentBkZip,left.RecentBkZip4,'','', left.RecentBkAddr,'','')));
		self.CompanyResults.RecentBankruptcyNameAddress := bkrupt;
		self.CompanyResults.RecentBankruptcyFilingDate := iesp.ECL2ESP.toDatestring8(input.RecentBkDate);
		self.CompanyResults.RecentBankruptcyType := input.RecentBktype;
		 // Lien/Judgement Info (count is later)
		self.CompanyResults.RecentLienType := input.RecentLienType;
		self.CompanyResults.UnreleasedLienCounter := input.UnreleasedLienCount;
		self.CompanyResults.RecentLienNameAddress.CompanyName := input.RecentLienName;
		self.CompanyResults.RecentLienNameAddress.Address := iesp.ECL2ESP.SetAddress('','','','','','','',input.RecentLienCity, input.RecentLienState, 
																									input.RecentLienZip,input.RecentLienZip4,'','', input.RecentLienAddr,'','');
		self.CompanyResults.RecentLienFilingDate := iesp.ECL2ESP.toDatestring8(input.RecentLienDate);
		self.CompanyResults.ReleasedLienCounter := input.ReleasedLienCount;
		// WatchList
		watchList1 := if(input.watchlist_Record_Number<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.watchlist_table;
																						 self.RecordNumber := left.watchlist_Record_Number;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.watchlist_fname, '', (string)left.watchlist_lname, '', '', (string)left.watchlist_cmpy);
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.watchlist_city, left.watchlist_state, 
																																			left.watchlist_zip,'','','', left.watchlist_address,'','');
																						 self.Country := left.watchlist_country;
																						 self.EntityName := '';
																						 self.Sequence := 1)));
		watchList2 := if(input.watchlist_Record_Number_2<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.watchlist_table_2;
																						 self.RecordNumber := left.watchlist_Record_Number_2;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.watchlist_fname_2, '', (string)left.watchlist_lname_2, '', '', (string)left.watchlist_cmpy_2);
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.watchlist_city_2, left.watchlist_state_2, 
																																			left.watchlist_zip_2,'','','', left.watchlist_address_2,'','');
																						 self.Country := left.watchlist_country_2;
																						 self.EntityName := '';
																						 self.Sequence := 2)));
		watchList3 := if(input.watchlist_Record_Number_3<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.watchlist_table_3;
																						 self.RecordNumber := left.watchlist_Record_Number_3;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.watchlist_fname_3, '', (string)left.watchlist_lname_3, '', '', (string)left.watchlist_cmpy_3);
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.watchlist_city_3, left.watchlist_state_3, 
																																			left.watchlist_zip_3,'','','', left.watchlist_address_3,'','');
																						 self.Country := left.watchlist_country_3;
																						 self.EntityName := '';
																						 self.Sequence := 3)));
		watchList4 := if(input.watchlist_Record_Number_4<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.watchlist_table_4;
																						 self.RecordNumber := left.watchlist_Record_Number_4;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.watchlist_fname_4, '', (string)left.watchlist_lname_4, '', '', (string)left.watchlist_cmpy_4);
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.watchlist_city_4, left.watchlist_state_4, 
																																			left.watchlist_zip_4,'','','', left.watchlist_address_4,'','');
																						 self.Country := left.watchlist_country_4;
																						 self.EntityName := '';
																						 self.Sequence := 4)));
		watchList5 := if(input.watchlist_Record_Number_5<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.watchlist_table_5;
																						 self.RecordNumber := left.watchlist_Record_Number_5;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.watchlist_fname_5, '', (string)left.watchlist_lname_5, '', '', (string)left.watchlist_cmpy_5);
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.watchlist_city_5, left.watchlist_state_5, 
																																			left.watchlist_zip_5,'','','', left.watchlist_address_5,'','');
																						 self.Country := left.watchlist_country_5;
																						 self.EntityName := '';
																						 self.Sequence := 5)));
		watchList6 := if(input.watchlist_Record_Number_6<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.watchlist_table_6;
																						 self.RecordNumber := left.watchlist_Record_Number_6;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.watchlist_fname_6, '', (string)left.watchlist_lname_6, '', '', (string)left.watchlist_cmpy_6);
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.watchlist_city_6, left.watchlist_state_6, 
																																			left.watchlist_zip_6,'','','', left.watchlist_address_6,'','');
																						 self.Country := left.watchlist_country_6;
																						 self.EntityName := '';
																						 self.Sequence := 6)));
		watchList7 := if(input.watchlist_Record_Number_7<>'',project(input, transform(iesp.instantid.t_WatchList, 
																						 self.Table := left.watchlist_table_7;
																						 self.RecordNumber := left.watchlist_Record_Number_7;
																						 self.Name := iesp.ECL2ESP.SetName((string)left.watchlist_fname_7, '', (string)left.watchlist_lname_7, '', '', (string)left.watchlist_cmpy_7);
																						 self.Address := iesp.ECL2ESP.SetAddress('','','','','','','',left.watchlist_city_7, left.watchlist_state_7, 
																																			left.watchlist_zip_7,'','','', left.watchlist_address_7,'','');
																						 self.Country := left.watchlist_country_7;
																						 self.EntityName := '';
																						 self.Sequence := 7)));

		self.CompanyResults.WatchListMatch := watchList1;
		watchListCombine := watchList1+watchList2+watchList3+watchList4+watchList5+watchList6+watchList7;
		self.CompanyResults.WatchLists := choosen(if(exists(watchListCombine),watchListCombine),iesp.Constants.Identifier2c.MaxWatchlists);
		self.AuthorizedRepresentativeRelationshipToCompany := (integer)input.AR2BI;
		self.DistHomeAddressToBusinessAddress := input.dist_HomeAddr_BusAddr;
		self.DistHomePhoneToBusinessAddress := input.dist_HomePhone_BusAddr;
		self.DistHomeAddressToBusinessPhone := input.dist_HomeAddr_BusPhone;
		self.DistHomePhoneToBusinessPhone := input.dist_HomePhone_BusPhone;
		self.DistHomePhoneToHomeAddress := input.dist_HomePhone_HomeAddr;
		self.DistBusinessPhoneToBusinessAddress := input.dist_BusPhone_BusAddr;
		self.Models := [];
		self.ModelsSeq := [];
		self := [];
	end;
	formattedData := project(rawData,xform(left));
	export dsBusinessID := formattedData[1];
end;
