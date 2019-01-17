import iesp, Seed_Files, Address, risk_indicators, RiskWise;

EXPORT CreditReport_TestSeed_Function(DATASET(BusinessCredit_Services.Layouts.in_key) inData,
																STRING32 TestDataTableName_in) := FUNCTION
		
	
	working_layout := RECORD
		// string30 in_seq;
		string20 dataset_name;
		data16 hashkey;
		iesp.businesscreditreport.t_BusinessCreditReportRecord;
		
	END;
	
	working_layout getSearchKey(BusinessCredit_Services.Layouts.in_key le) := TRANSFORM
		// self.in_seq := (String)le.Seq;
		self.dataset_name := TestDataTableName_in;

		self.hashkey := Seed_Files.Hash_InstantID(
		                    StringLib.StringToUpperCase(trim(le.authrep_first)),   // fname,
		                    StringLib.StringToUpperCase(trim(le.authrep_last)),    // lname,
		                    risk_indicators.nullstring,                            // ssn -- not used in business products,
		                    StringLib.StringToUpperCase(trim(le.company_fein)),    // fein,
		                    StringLib.StringToUpperCase(trim(le.company_zip)),     // zip,
		                    StringLib.StringToUpperCase(trim(le.company_phone)),   // phone,
		                    StringLib.StringToUpperCase(trim(le.company_name)));   // company_name
	
		self := [];
	END;
	
	inrecs := project(inData, getSearchKey(LEFT));
	
	working_layout append_bestInfo (working_layout le, Seed_Files.BusinessCreditReport_keys.BestInfo rt) := transform
		self.BestInformation.BusinessIds.DotID                  := rt.Best_Bus_DotID                      ;
		self.BestInformation.BusinessIds.EmpID                  := rt.Best_Bus_EmpID                      ;
		self.BestInformation.BusinessIds.POWID                  := rt.Best_Bus_POWID                      ;
		self.BestInformation.BusinessIds.ProxID                 := rt.Best_Bus_ProxID                     ;
		self.BestInformation.BusinessIds.SeleID                 := rt.Best_Bus_SeleID                     ;
		self.BestInformation.BusinessIds.OrgID                  := rt.Best_Bus_OrgID                      ;
		self.BestInformation.BusinessIds.UltID                  := rt.Best_Bus_UltID                      ;
		self.BestInformation.CompanyName                        := rt.Best_Bus_CompanyName                ;
		self.BestInformation.CompanyAddress.StreetNumber        := rt.Best_CmpyAddr_StreetNumber          ;
		self.BestInformation.CompanyAddress.StreetPreDirection  := rt.Best_CmpyAddr_StreetPreDirection    ;
		self.BestInformation.CompanyAddress.StreetName          := rt.Best_CmpyAddr_StreetName            ;
		self.BestInformation.CompanyAddress.StreetSuffix        := rt.Best_CmpyAddr_StreetSuffix          ;
		self.BestInformation.CompanyAddress.StreetPostDirection := rt.Best_CmpyAddr_StreetPostDirection   ;
		self.BestInformation.CompanyAddress.UnitDesignation     := rt.Best_CmpyAddr_UnitDesignation       ;
		self.BestInformation.CompanyAddress.UnitNumber          := rt.Best_CmpyAddr_UnitNumber            ;
		self.BestInformation.CompanyAddress.StreetAddress1      := rt.Best_CmpyAddr_StreetAddress1        ;
		self.BestInformation.CompanyAddress.StreetAddress2      := rt.Best_CmpyAddr_StreetAddress2        ;
		self.BestInformation.CompanyAddress.City                := rt.Best_CmpyAddr_City                  ;
		self.BestInformation.CompanyAddress.State               := rt.Best_CmpyAddr_State                 ;
		self.BestInformation.CompanyAddress.Zip5                := rt.Best_CmpyAddr_Zip5                  ;
		self.BestInformation.CompanyAddress.Zip4                := rt.Best_CmpyAddr_Zip4                  ;
		self.BestInformation.CompanyAddress.County              := rt.Best_CmpyAddr_County                ;
		self.BestInformation.CompanyAddress.PostalCode          := rt.Best_CmpyAddr_PostalCode            ;
		self.BestInformation.CompanyAddress.StateCityZip        := rt.Best_CmpyAddr_StateCityZip          ;
		self.BestInformation.TIN                                := rt.Best_TIN                            ;
		self.BestInformation.CompanyPhone                       := rt.Best_CompanyPhone                   ;
		self.BestInformation.UniqueId                           := rt.Best_UniqueId                       ;
		self.BestInformation.AuthRepName.Full                   := rt.Best_AuthRepName_Full               ;
		self.BestInformation.AuthRepName.First                  := rt.Best_AuthRepName_First              ;
		self.BestInformation.AuthRepName.Middle                 := rt.Best_AuthRepName_Middle             ;
		self.BestInformation.AuthRepName.Last                   := rt.Best_AuthRepName_Last               ;
		self.BestInformation.AuthRepName.Suffix                 := rt.Best_AuthRepName_Suffix             ;
		self.BestInformation.AuthRepName.Prefix                 := rt.Best_AuthRepName_Prefix             ;
		self.BestInformation.AuthRepAddress.StreetNumber        := rt.Best_AuthRepAddr_StreetNumber       ;
		self.BestInformation.AuthRepAddress.StreetPreDirection  := rt.Best_AuthRepAddr_StreetPreDirection ;
		self.BestInformation.AuthRepAddress.StreetName          := rt.Best_AuthRepAddr_StreetName         ;
		self.BestInformation.AuthRepAddress.StreetSuffix        := rt.Best_AuthRepAddr_StreetSuffix       ;
		self.BestInformation.AuthRepAddress.StreetPostDirection := rt.Best_AuthRepAddr_StreetPostDirection;
		self.BestInformation.AuthRepAddress.UnitDesignation     := rt.Best_AuthRepAddr_UnitDesignation    ;
		self.BestInformation.AuthRepAddress.UnitNumber          := rt.Best_AuthRepAddr_UnitNumber         ;
		self.BestInformation.AuthRepAddress.StreetAddress1      := rt.Best_AuthRepAddr_StreetAddress1     ;
		self.BestInformation.AuthRepAddress.StreetAddress2      := rt.Best_AuthRepAddr_StreetAddress2     ;
		self.BestInformation.AuthRepAddress.City                := rt.Best_AuthRepAddr_City               ;
		self.BestInformation.AuthRepAddress.State               := rt.Best_AuthRepAddr_State              ;
		self.BestInformation.AuthRepAddress.Zip5                := rt.Best_AuthRepAddr_Zip5               ;
		self.BestInformation.AuthRepAddress.Zip4                := rt.Best_AuthRepAddr_Zip4               ;
		self.BestInformation.AuthRepAddress.County              := rt.Best_AuthRepAddr_County             ;
		self.BestInformation.AuthRepAddress.PostalCode          := rt.Best_AuthRepAddr_PostalCode         ;
		self.BestInformation.AuthRepAddress.StateCityZip        := rt.Best_AuthRepAddr_StateCityZip       ;
		self.BestInformation.AuthRepSSN                         := rt.Best_AuthRepSSN                     ;
		self.BestInformation.AuthRepPhone                       := rt.Best_AuthRepPhone                   ;
		self.BestInformation.RecentTradeDate.Year               := rt.Best_RecTrade_Year                  ;
		self.BestInformation.RecentTradeDate.Month              := rt.Best_RecTrade_Month                 ;
		self.BestInformation.RecentTradeDate.Day                := rt.Best_RecTrade_Day                   ;
		self.BestInformation.EstablishedDate.Year               := rt.Best_Est_Year                       ;
		self.BestInformation.EstablishedDate.Month              := rt.Best_Est_Month                      ;
		self.BestInformation.EstablishedDate.Day                := rt.Best_Est_Day                        ;
		self.BestInformation.AnnualIncome                       := rt.Best_AnnualIncome                   ;
		self.BestInformation.NoOfEmployees                      := rt.Best_NoOfEmployees                  ;
		self.BestInformation.PrimaryIndustryCode                := rt.Best_PrimaryIndustryCode            ;
		self.BestInformation.PrimaryIndustryDescription         := rt.Best_PrimaryIndustryDescription     ;
		self.BestInformation.BusinessType                       := rt.Best_BusinessType                   ;
		self.BestInformation.ParentCompanyName                  := rt.Best_ParentCompanyName              ;
		self.BestInformation.sosActiveIndicator                 := rt.Best_sosActiveIndicator             ;
		self.BestInformation.BusinessCreditIndicator            := rt.Best_BusinessCreditIndicator        ;
		
		self := le;  // everything else from the left
		self := [];
	end;
	
	CR_BestInfo := join(inrecs, Seed_Files.BusinessCreditReport_keys.BestInfo,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_bestInfo(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_Scorings (working_layout le, Seed_Files.BusinessCreditReport_keys.Scoring rt) := transform
	
		Scorings1 := project(rt, transform(iesp.businesscreditreport.t_BusinessCreditScoring, 										
			self.DateScored.Year                       := rt.Scoring1_Scored_Year               ;
			self.DateScored.Month                      := rt.Scoring1_Scored_Month              ;
			self.DateScored.Day                        := rt.Scoring1_Scored_Day                ;
			self.CurrentPriorFlag                      := rt.Scoring1_CurrentPriorFlag          ;
			self.PrimaryIndustryCode                   := rt.Scoring1_PrimaryIndustryCode       ;
			self.PrimaryIndustryDescription            := rt.Scoring1_PrimaryIndustryDescription;
			self.IndustryScore                         := rt.Scoring1_IndustryScore             ;
			self.scores := 
				project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditScore, 
					self.ScoreType                   := rt.Scoring1_ScoreType      ;
					self.MinScoreRange               := rt.Scoring1_MinScoreRange  ;
					self.MaxScoreRange               := rt.Scoring1_MaxScoreRange  ;
					self.Score                       := rt.Scoring1_Score          ;
					self.ScoreRiskLevel              := rt.Scoring1_ScoreRiskLevel ;
					scorereasons1a := 
						project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditScoreReason,
							self.Sequence    := rt.Scoring1_Sequence1    ;
							self.ReasonCode  := rt.Scoring1_ReasonCode1  ;
							self.Description := rt.Scoring1_Description1 ;
						));
					scorereasons2a :=
						project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditScoreReason,
							self.Sequence    := rt.Scoring1_Sequence2    ;
							self.ReasonCode  := rt.Scoring1_ReasonCode2  ;
							self.Description := rt.Scoring1_Description2 ;
						));
						scorereasons3a :=
						project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditScoreReason,
							self.Sequence    := rt.Scoring1_Sequence3    ;
							self.ReasonCode  := rt.Scoring1_ReasonCode3  ;
							self.Description := rt.Scoring1_Description3 ;
						));
						scorereasons4a :=
						project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditScoreReason,
							self.Sequence    := rt.Scoring1_Sequence4    ;
							self.ReasonCode  := rt.Scoring1_ReasonCode4  ;
							self.Description := rt.Scoring1_Description4 ;
						));
							
					self.scoreReasons := scorereasons1a + scorereasons2a + scorereasons3a + scorereasons4a;		
				));
		));

		Scorings2 := project(rt, transform(iesp.businesscreditreport.t_BusinessCreditScoring, 										
			self.DateScored.Year                       := rt.Scoring2_Scored_Year               ;
			self.DateScored.Month                      := rt.Scoring2_Scored_Month              ;
			self.DateScored.Day                        := rt.Scoring2_Scored_Day                ;
			self.CurrentPriorFlag                      := rt.Scoring2_CurrentPriorFlag          ;
			self.PrimaryIndustryCode                   := rt.Scoring2_PrimaryIndustryCode       ;
			self.PrimaryIndustryDescription            := rt.Scoring2_PrimaryIndustryDescription;
			self.IndustryScore                         := rt.Scoring2_IndustryScore             ;
			self.scores := 
				project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditScore, 
					self.ScoreType                   := rt.Scoring2_ScoreType      ;
					self.MinScoreRange               := rt.Scoring2_MinScoreRange  ;
					self.MaxScoreRange               := rt.Scoring2_MaxScoreRange  ;
					self.Score                       := rt.Scoring2_Score          ;
					self.ScoreRiskLevel              := rt.Scoring2_ScoreRiskLevel ;
					scorereasons1b := 
						project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditScoreReason,
							self.Sequence    := rt.Scoring2_Sequence1    ;
							self.ReasonCode  := rt.Scoring2_ReasonCode1  ;
							self.Description := rt.Scoring2_Description1 ;
						));
					scorereasons2b :=
						project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditScoreReason,
							self.Sequence    := rt.Scoring2_Sequence2    ;
							self.ReasonCode  := rt.Scoring2_ReasonCode2  ;
							self.Description := rt.Scoring2_Description2 ;
						));
						scorereasons3b :=
						project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditScoreReason,
							self.Sequence    := rt.Scoring2_Sequence3    ;
							self.ReasonCode  := rt.Scoring2_ReasonCode3  ;
							self.Description := rt.Scoring2_Description3 ;
						));
						scorereasons4b :=
						project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditScoreReason,
							self.Sequence    := rt.Scoring2_Sequence4    ;
							self.ReasonCode  := rt.Scoring2_ReasonCode4  ;
							self.Description := rt.Scoring2_Description4 ;
						));
							
					self.scoreReasons := scorereasons1b + scorereasons2b + scorereasons3b + scorereasons4b;		
				));
		));
		
		self.Scorings := Scorings1 + Scorings2;	
		self := le;  // everything else from the left
		self := [];
	end;
	
	CR_Scoring := join(CR_BestInfo, Seed_Files.BusinessCreditReport_keys.Scoring,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_Scorings(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_Summary (working_layout le, Seed_Files.BusinessCreditReport_keys.Summary rt) := transform
		self.TradeSummary :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditTradeSummary,
				self.OpenAccountsCount     := rt.TradeSumm_OpenAccountsCount     ;
				self.AccountOpenDate.Year  := rt.TradeSumm_Year                  ;
				self.AccountOpenDate.Month := rt.TradeSumm_Month                 ;
				self.AccountOpenDate.Day   := rt.TradeSumm_Day                   ;
				self.TotalOverdue          := rt.TradeSumm_TotalOverdue          ;
				self.MostSevereStatus      := rt.TradeSumm_MostSevereStatus      ;
				self.HighestCredit         := rt.TradeSumm_HighestCredit         ;
				self.TotalCurrentExposure  := rt.TradeSumm_TotalCurrentExposure  ;
				self.MedianBalance         := rt.TradeSumm_MedianBalance         ;
				self.AvgOpenBalance        := rt.TradeSumm_AvgOpenBalance        ;
				self.ChargeOffRecorded     := rt.TradeSumm_ChargeOffRecorded     ;
				self.AccountsWithGuarantor := rt.TradeSumm_AccountsWithGuarantor ;
		));		
		self.PaymentSummary :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditPaymentSummary,
				self.TotalCurrentExposure            := rt.PaySumm_TotalCurrentExposure            ;
				self.WithInTermsPercent              := rt.PaySumm_WithInTermsPercent              ;
				self.PastDueAgingAmount01to30Percent := rt.PaySumm_PastDueAgingAmount01to30Percent ;
				self.PastDueAgingAmount31to60Percent := rt.PaySumm_PastDueAgingAmount31to60Percent ;
				self.PastDueAgingAmount61to90Percent := rt.PaySumm_PastDueAgingAmount61to90Percent ;
				self.PastDueAgingAmount91PlusPercent := rt.PaySumm_PastDueAgingAmount91PlusPercent ;
		));
		
		AccountDetail1 :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditAccountDetail,
				self.BusinessContributorNumber    := rt.AcctDet1_BusinessContributorNumber    ;
				self.BusinessAccountNumber        := rt.AcctDet1_BusinessAccountNumber        ;
				self.AccountStatus                := rt.AcctDet1_AccountStatus                ;
				self.AccountTypeReportedCode      := rt.AcctDet1_AccountTypeReportedCode      ;
				self.AccountTypeReportedDesc      := rt.AcctDet1_AccountTypeReportedDesc      ;
				self.AccountOpenDate.Year         := rt.AcctDet1_Open_Year                    ;
				self.AccountOpenDate.Month        := rt.AcctDet1_Open_Month                   ;
				self.AccountOpenDate.Day          := rt.AcctDet1_Open_Day                     ;
				self.AccountReportedDate.Year     := rt.AcctDet1_Report_Year                  ;
				self.AccountReportedDate.Month    := rt.AcctDet1_Report_Month                 ;
				self.AccountReportedDate.Day      := rt.AcctDet1_Report_Day                   ;
				self.AccountClosureDate.Year      := rt.AcctDet1_Close_Year                   ;
				self.AccountClosureDate.Month     := rt.AcctDet1_Close_Month                  ;
				self.AccountClosureDate.Day       := rt.AcctDet1_Close_Day                    ;
				self.AccountClosureReason         := rt.AcctDet1_AccountClosureReason         ;
				self.OriginalAmount               := rt.AcctDet1_OriginalAmount               ;
				self.AmountOutstanding            := rt.AcctDet1_AmountOutstanding            ;
				self.CollateralIndicator          := rt.AcctDet1_CollateralIndicator          ;
				self.TypeOfCollateral             := rt.AcctDet1_TypeOfCollateral             ;
				self.Overdue                      := rt.AcctDet1_Overdue                      ;
				self.PastDueAmount                := rt.AcctDet1_PastDueAmount                ;
				self.AccountExpirationDate.Year   := rt.AcctDet1_Exp_Year                     ;
				self.AccountExpirationDate.Month  := rt.AcctDet1_Exp_Month                    ;
				self.AccountExpirationDate.Day    := rt.AcctDet1_Exp_Day                      ;
				self.PaymentAmountScheduled       := rt.AcctDet1_PaymentAmountScheduled       ;
				self.PaymentFrequency             := rt.AcctDet1_PaymentFrequency             ;
				self.PaymentTypeCode              := rt.AcctDet1_PaymentTypeCode              ;
				self.PaymentTypeDesc              := rt.AcctDet1_PaymentTypeDesc              ;
				self.LastPaymentAmount            := rt.AcctDet1_LastPaymentAmount            ;
				self.LastPaymentDate.Year         := rt.AcctDet1_LastPay_Year                 ;
				self.LastPaymentDate.Month        := rt.AcctDet1_LastPay_Month                ;
				self.LastPaymentDate.Day          := rt.AcctDet1_LastPay_Day                  ;
				self.DelinquencyDate.Year         := rt.AcctDet1_Delinq_Year                  ;
				self.DelinquencyDate.Month        := rt.AcctDet1_Delinq_Month                 ;
				self.DelinquencyDate.Day          := rt.AcctDet1_Delinq_Day                   ;
				self.GovernmentGuaranteed         := rt.AcctDet1_GovernmentGuaranteed         ;
				self.GovernmentGuaranteedCategory := rt.AcctDet1_GovernmentGuaranteedCategory ;
				self.NumberOfGuarantors           := rt.AcctDet1_NumberOfGuarantors           ;
				self.YearlyCreditUtils := 
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessYearlyCreditUtilized, 
						self.Year                           := rt.AcctDet1_YrUtils_Year                           ;
						self.AvgCreditUtilizedPercent       := rt.AcctDet1_YrUtils_AvgCreditUtilizedPercent       ;
						self.HighestCreditLimitOfYear       := rt.AcctDet1_YrUtils_HighestCreditLimitOfYear       ;
						self.HighestOutstandingAmountOfYear := rt.AcctDet1_YrUtils_HighestOutstandingAmountOfYear ;
					));
				self.AccountPaymentHistory := 
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditAccountPaymentHistory,
						self.ReportedDate.Year          := rt.AcctDet1_Pay_Hist_Rep_Year           ;
						self.ReportedDate.Month         := rt.AcctDet1_Pay_Hist_Rep_Month          ;
						self.ReportedDate.Day           := rt.AcctDet1_Pay_Hist_Rep_Day            ;
						self.ClosureDate.Year           := rt.AcctDet1_Pay_Hist_Close_Year         ;
						self.ClosureDate.Month          := rt.AcctDet1_Pay_Hist_Close_Month        ;
						self.ClosureDate.Day            := rt.AcctDet1_Pay_Hist_Close_Day          ;
						self.ClosureReason              := rt.AcctDet1_Pay_Hist_ClosureReason      ;
						self.CurrentCreditLimit         := rt.AcctDet1_Pay_Hist_CurrentCreditLimit ;
						self.AmountOutstanding          := rt.AcctDet1_Pay_Hist_AmountOutstanding  ;
						self.PaymentStatus              := rt.AcctDet1_Pay_Hist_PaymentStatus      ;
						self.PastDueAmount              := rt.AcctDet1_Pay_Hist_PastDueAmount      ;
						self.IsExtendedOverdue          := rt.AcctDet1_Pay_Hist_IsExtendedOverdue  ;
					));
				self := [];   // Blank out fields that don't have testseed value.
		));
		
		AccountDetail2 :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditAccountDetail,
				self.BusinessContributorNumber    := rt.AcctDet2_BusinessContributorNumber    ;
				self.BusinessAccountNumber        := rt.AcctDet2_BusinessAccountNumber        ;
				self.AccountStatus                := rt.AcctDet2_AccountStatus                ;
				self.AccountTypeReportedCode      := rt.AcctDet2_AccountTypeReportedCode      ;
				self.AccountTypeReportedDesc      := rt.AcctDet2_AccountTypeReportedDesc      ;
				self.AccountOpenDate.Year         := rt.AcctDet2_Open_Year                    ;
				self.AccountOpenDate.Month        := rt.AcctDet2_Open_Month                   ;
				self.AccountOpenDate.Day          := rt.AcctDet2_Open_Day                     ;
				self.AccountReportedDate.Year     := rt.AcctDet2_Report_Year                  ;
				self.AccountReportedDate.Month    := rt.AcctDet2_Report_Month                 ;
				self.AccountReportedDate.Day      := rt.AcctDet2_Report_Day                   ;
				self.AccountClosureDate.Year      := rt.AcctDet2_Close_Year                   ;
				self.AccountClosureDate.Month     := rt.AcctDet2_Close_Month                  ;
				self.AccountClosureDate.Day       := rt.AcctDet2_Close_Day                    ;
				self.AccountClosureReason         := rt.AcctDet2_AccountClosureReason         ;
				self.OriginalAmount               := rt.AcctDet2_OriginalAmount               ;
				self.AmountOutstanding            := rt.AcctDet2_AmountOutstanding            ;
				self.CollateralIndicator          := rt.AcctDet2_CollateralIndicator          ;
				self.TypeOfCollateral             := rt.AcctDet2_TypeOfCollateral             ;
				self.Overdue                      := rt.AcctDet2_Overdue                      ;
				self.PastDueAmount                := rt.AcctDet2_PastDueAmount                ;
				self.AccountExpirationDate.Year   := rt.AcctDet2_Exp_Year                     ;
				self.AccountExpirationDate.Month  := rt.AcctDet2_Exp_Month                    ;
				self.AccountExpirationDate.Day    := rt.AcctDet2_Exp_Day                      ;
				self.PaymentAmountScheduled       := rt.AcctDet2_PaymentAmountScheduled       ;
				self.PaymentFrequency             := rt.AcctDet2_PaymentFrequency             ;
				self.PaymentTypeCode              := rt.AcctDet2_PaymentTypeCode              ;
				self.PaymentTypeDesc              := rt.AcctDet2_PaymentTypeDesc              ;
				self.LastPaymentAmount            := rt.AcctDet2_LastPaymentAmount            ;
				self.LastPaymentDate.Year         := rt.AcctDet2_LastPay_Year                 ;
				self.LastPaymentDate.Month        := rt.AcctDet2_LastPay_Month                ;
				self.LastPaymentDate.Day          := rt.AcctDet2_LastPay_Day                  ;
				self.DelinquencyDate.Year         := rt.AcctDet2_Delinq_Year                  ;
				self.DelinquencyDate.Month        := rt.AcctDet2_Delinq_Month                 ;
				self.DelinquencyDate.Day          := rt.AcctDet2_Delinq_Day                   ;
				self.GovernmentGuaranteed         := rt.AcctDet2_GovernmentGuaranteed         ;
				self.GovernmentGuaranteedCategory := rt.AcctDet2_GovernmentGuaranteedCategory ;
				self.NumberOfGuarantors           := rt.AcctDet2_NumberOfGuarantors           ;
				self.YearlyCreditUtils := 
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessYearlyCreditUtilized, 
						self.Year                           := rt.AcctDet2_YrUtils_Year                           ;
						self.AvgCreditUtilizedPercent       := rt.AcctDet2_YrUtils_AvgCreditUtilizedPercent       ;
						self.HighestCreditLimitOfYear       := rt.AcctDet2_YrUtils_HighestCreditLimitOfYear       ;
						self.HighestOutstandingAmountOfYear := rt.AcctDet2_YrUtils_HighestOutstandingAmountOfYear ;
					));
				self.AccountPaymentHistory := 
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditAccountPaymentHistory,
						self.ReportedDate.Year          := rt.AcctDet2_Pay_Hist_Rep_Year                      ;
						self.ReportedDate.Month         := rt.AcctDet2_Pay_Hist_Rep_Month                     ;
						self.ReportedDate.Day           := rt.AcctDet2_Pay_Hist_Rep_Day                       ;
						self.ClosureDate.Year           := rt.AcctDet2_Pay_Hist_Close_Year                    ;
						self.ClosureDate.Month          := rt.AcctDet2_Pay_Hist_Close_Month                   ;
						self.ClosureDate.Day            := rt.AcctDet2_Pay_Hist_Close_Day                     ;
						self.ClosureReason              := rt.AcctDet2_Pay_Hist_ClosureReason                 ;
						self.CurrentCreditLimit         := rt.AcctDet2_Pay_Hist_CurrentCreditLimit            ;
						self.AmountOutstanding          := rt.AcctDet2_Pay_Hist_AmountOutstanding             ;
						self.PaymentStatus              := rt.AcctDet2_Pay_Hist_PaymentStatus                 ;
						self.PastDueAmount              := rt.AcctDet2_Pay_Hist_PastDueAmount                 ;
						self.IsExtendedOverdue          := rt.AcctDet2_Pay_Hist_IsExtendedOverdue             ;
					));
				self := [];  // Blank out fields that don't have testseed value.
		));
		
		self.AccountDetail := AccountDetail1 + AccountDetail2;
		
		CreditUtils1 :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditUtilized,
				self.CreditLimit               := rt.Cred_Util1_CreditLimit           ;
				self.CreditUtilized            := rt.Cred_Util1_CreditUtilized        ;
				self.AvailableCredit           := rt.Cred_Util1_AvailableCredit       ;
				self.CreditUtilizedPercent     := rt.Cred_Util1_CreditUtilizedPercent ;
				self.CurrentPriorFlag          := rt.Cred_Util1_CurrentPriorFlag      ;
				self.ScoreCalculatedDate.Year  := rt.Cred_Util1_Calc_Year             ;
				self.ScoreCalculatedDate.Month := rt.Cred_Util1_Calc_Month            ;
				self.ScoreCalculatedDate.Day   := rt.Cred_Util1_Calc_Day              ;
		));
		
		CreditUtils2 :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditUtilized,
				self.CreditLimit               := rt.Cred_Util2_CreditLimit           ;
				self.CreditUtilized            := rt.Cred_Util2_CreditUtilized        ;
				self.AvailableCredit           := rt.Cred_Util2_AvailableCredit       ;
				self.CreditUtilizedPercent     := rt.Cred_Util2_CreditUtilizedPercent ;
				self.CurrentPriorFlag          := rt.Cred_Util2_CurrentPriorFlag      ;
				self.ScoreCalculatedDate.Year  := rt.Cred_Util2_Calc_Year             ;
				self.ScoreCalculatedDate.Month := rt.Cred_Util2_Calc_Month            ;
				self.ScoreCalculatedDate.Day   := rt.Cred_Util2_Calc_Day              ;
		));
		
		self.CreditUtils := CreditUtils1 + CreditUtils2;
		
		DBTs1 :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditDBT,
				//DBTs
				self.DBTCalculatedDate.Year     := rt.DBT1_Calc_Year                 ;
				self.DBTCalculatedDate.Month    := rt.DBT1_Calc_Month                ;
				self.DBTCalculatedDate.Day      := rt.DBT1_Calc_Day                  ;
				self.DBTMinRange                := rt.DBT1MinRange                   ;
				self.DBTMaxRange                := rt.DBT1MaxRange                   ;
				self.DBT                        := rt.DBT1                           ;
				self.CurrentPriorFlag           := rt.DBT1_CurrentPriorFlag          ;
				self.PriorYear                  := rt.DBT1_PriorYear                 ;
				self.PriorYearDBTAverage        := rt.DBT1_PriorYearDBTAverage       ;
				self.PrimaryIndustryCode        := rt.DBT1_PrimaryIndustryCode       ;
				self.PrimaryIndustryDescription := rt.DBT1_PrimaryIndustryDescription;
				self.IndustryDBTAverage         := rt.DBT1_IndustryDBTAverage        ;
		));
		
		DBTs2 :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditDBT,
				//DBTs
				self.DBTCalculatedDate.Year     := rt.DBT2_Calc_Year                 ;
				self.DBTCalculatedDate.Month    := rt.DBT2_Calc_Month                ;
				self.DBTCalculatedDate.Day      := rt.DBT2_Calc_Day                  ;
				self.DBTMinRange                := rt.DBT2MinRange                   ;
				self.DBTMaxRange                := rt.DBT2MaxRange                   ;
				self.DBT                        := rt.DBT2                           ;
				self.CurrentPriorFlag           := rt.DBT2_CurrentPriorFlag          ;
				self.PriorYear                  := rt.DBT2_PriorYear                 ;
				self.PriorYearDBTAverage        := rt.DBT2_PriorYearDBTAverage       ;
				self.PrimaryIndustryCode        := rt.DBT2_PrimaryIndustryCode       ;
				self.PrimaryIndustryDescription := rt.DBT2_PrimaryIndustryDescription;
				self.IndustryDBTAverage         := rt.DBT2_IndustryDBTAverage        ;
		));

		self.DBTs := DBTs1 + DBTs2;
		
		Inquiries1 :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditInquiry,
				self.PrimaryIndustryCode        := rt.Inq1_PrimaryIndustryCode        ;
				self.PrimaryIndustryDescription := rt.Inq1_PrimaryIndustryDescription ;
				self.TotalInquiryCount          := rt.Inq1_TotalInquiryCount          ;
				self.InquiryCount03Month        := rt.Inq1_InquiryCount03Month        ;
				self.InquiryCount06Month        := rt.Inq1_InquiryCount06Month        ;
				self.InquiryCount09Month        := rt.Inq1_InquiryCount09Month        ;
				self.InquiryCount12Month        := rt.Inq1_InquiryCount12Month        ;
			));
			
		Inquiries2 :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditInquiry,
				self.PrimaryIndustryCode        := rt.Inq2_PrimaryIndustryCode        ;
				self.PrimaryIndustryDescription := rt.Inq2_PrimaryIndustryDescription ;
				self.TotalInquiryCount          := rt.Inq2_TotalInquiryCount          ;
				self.InquiryCount03Month        := rt.Inq2_InquiryCount03Month        ;
				self.InquiryCount06Month        := rt.Inq2_InquiryCount06Month        ;
				self.InquiryCount09Month        := rt.Inq2_InquiryCount09Month        ;
				self.InquiryCount12Month        := rt.Inq2_InquiryCount12Month        ;
			));

		self.Inquiries := Inquiries1 + Inquiries2;
		
		Subsidiaries1 :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditSubsidiary,
				self.BusinessIds.DotID       := rt.Sub1_DotID                   ;
				self.BusinessIds.EmpID       := rt.Sub1_EmpID                   ;
				self.BusinessIds.POWID       := rt.Sub1_POWID                   ;
				self.BusinessIds.ProxID      := rt.Sub1_ProxID                  ;
				self.BusinessIds.SeleID      := rt.Sub1_SeleID                  ;
				self.BusinessIds.OrgID       := rt.Sub1_OrgID                   ;
				self.BusinessIds.UltID       := rt.Sub1_UltID                   ;
				self.CompanyName             := rt.Sub1_CompanyName             ;
				self.RelationType            := rt.Sub1_RelationType            ;
				self.BusinessCreditIndicator := rt.Sub1_BusinessCreditIndicator ;
		));
		
		Subsidiaries2 :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditSubsidiary,
				self.BusinessIds.DotID       := rt.Sub2_DotID                   ;
				self.BusinessIds.EmpID       := rt.Sub2_EmpID                   ;
				self.BusinessIds.POWID       := rt.Sub2_POWID                   ;
				self.BusinessIds.ProxID      := rt.Sub2_ProxID                  ;
				self.BusinessIds.SeleID      := rt.Sub2_SeleID                  ;
				self.BusinessIds.OrgID       := rt.Sub2_OrgID                   ;
				self.BusinessIds.UltID       := rt.Sub2_UltID                   ;
				self.CompanyName             := rt.Sub2_CompanyName             ;
				self.RelationType            := rt.Sub2_RelationType            ;
				self.BusinessCreditIndicator := rt.Sub2_BusinessCreditIndicator ;
		));
		
		self.Subsidiaries := Subsidiaries1 + Subsidiaries2;
	
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_Summary := join(CR_Scoring, Seed_Files.BusinessCreditReport_keys.Summary,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_Summary(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_OwnerGuarantor (working_layout le, Seed_Files.BusinessCreditReport_keys.OwnGuartor rt) := transform
		OwnerGuarantor1 := 
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditOwnerGuarantor,
				self.BusinessIds.DotID                 := rt.OG1_Bus_DotID                          ;
				self.BusinessIds.EmpID                 := rt.OG1_Bus_EmpID                          ;
				self.BusinessIds.POWID                 := rt.OG1_Bus_POWID                          ;
				self.BusinessIds.ProxID                := rt.OG1_Bus_ProxID                         ;
				self.BusinessIds.SeleID                := rt.OG1_Bus_SeleID                         ;
				self.BusinessIds.OrgID                 := rt.OG1_Bus_OrgID                          ;
				self.BusinessIds.UltID                 := rt.OG1_Bus_UltID                          ;
				self.UniqueId                          := rt.OG1_UniqueId                           ;
				self.EntityName.Full                   := rt.OG1_EntName_Full                       ;
				self.EntityName.First                  := rt.OG1_EntName_First                      ;
				self.EntityName.Middle                 := rt.OG1_EntName_Middle                     ;
				self.EntityName.Last                   := rt.OG1_EntName_Last                       ;
				self.EntityName.Suffix                 := rt.OG1_EntName_Suffix                     ;
				self.EntityName.Prefix                 := rt.OG1_EntName_Prefix                     ;
				self.EntityName.CompanyName            := rt.OG1_EntName_CompanyName                ;
				self.EntityType                        := rt.OG1_EntityType                         ;
				self.EntityAddress.StreetNumber        := rt.OG1_EntAddr_StreetNumber               ;
				self.EntityAddress.StreetPreDirection  := rt.OG1_EntAddr_StreetPreDirection         ;
				self.EntityAddress.StreetName          := rt.OG1_EntAddr_StreetName                 ;
				self.EntityAddress.StreetSuffix        := rt.OG1_EntAddr_StreetSuffix               ;
				self.EntityAddress.StreetPostDirection := rt.OG1_EntAddr_StreetPostDirection        ;
				self.EntityAddress.UnitDesignation     := rt.OG1_EntAddr_UnitDesignation            ;
				self.EntityAddress.UnitNumber          := rt.OG1_EntAddr_UnitNumber                 ;
				self.EntityAddress.StreetAddress1      := rt.OG1_EntAddr_StreetAddress1             ;
				self.EntityAddress.StreetAddress2      := rt.OG1_EntAddr_StreetAddress2             ;
				self.EntityAddress.City                := rt.OG1_EntAddr_City                       ;
				self.EntityAddress.State               := rt.OG1_EntAddr_State                      ;
				self.EntityAddress.Zip5                := rt.OG1_EntAddr_Zip5                       ;
				self.EntityAddress.Zip4                := rt.OG1_EntAddr_Zip4                       ;
				self.EntityAddress.County              := rt.OG1_EntAddr_County                     ;
				self.EntityAddress.PostalCode          := rt.OG1_EntAddr_PostalCode                 ;
				self.EntityAddress.StateCityZip        := rt.OG1_EntAddr_StateCityZip               ;
				self.OwnerGuarantorIndicator           := rt.OwnerGuarantorIndicator                ;
				self.OwnershipPercent                  := rt.OG1_OwnershipPercent                   ;
				self.BusinessCreditIndicator           := rt.OG1_BusinessCreditIndicator            ;
				self.AccountDetails := 
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditAccountDetails,
						self.BusinessIds.DotID         := rt.OG1_AcctDet_DotID                      ;
						self.BusinessIds.EmpID         := rt.OG1_AcctDet_EmpID                      ;
						self.BusinessIds.POWID         := rt.OG1_AcctDet_POWID                      ;
						self.BusinessIds.ProxID        := rt.OG1_AcctDet_ProxID                     ;
						self.BusinessIds.SeleID        := rt.OG1_AcctDet_SeleID                     ;
						self.BusinessIds.OrgID         := rt.OG1_AcctDet_OrgID                      ;
						self.BusinessIds.UltID         := rt.OG1_AcctDet_UltID                      ;
						self.CompanyName               := rt.OG1_AcctDet_CompanyName                ;
						self.BusinessContributorNumber := rt.OG1_AcctDet_BusinessContributorNumber  ;
						self.BusinessAccountNumber     := rt.OG1_AcctDet_BusinessAccountNumber      ;
						self.AccountTypeReportedCode   := rt.OG1_AcctDet_AccountTypeReportedCode    ;
						self.AccountTypeReportedDesc   := rt.OG1_AcctDet_AccountTypeReportedDesc    ;
						self.AccountStatus             := rt.OG1_AcctDet_AccountStatus              ;
						self.AccountOpenDate.Year      := rt.OG1_AcctDet_Open_Year                  ;
						self.AccountOpenDate.Month     := rt.OG1_AcctDet_Open_Month                 ;
						self.AccountOpenDate.Day       := rt.OG1_AcctDet_Open_Day                   ;
						self.OriginalAmount            := rt.OG1_AcctDet_OriginalAmount             ;
						self.AmountOutstanding         := rt.OG1_AcctDet_AmountOutstanding          ;
						self.Overdue                   := rt.OG1_AcctDet_Overdue                    ;
						self.PastDueAmount             := rt.OG1_AcctDet_PastDueAmount              ;
						self.BusinessCreditIndicator   := rt.OG1_AcctDet_BusinessCreditIndicator    ;
						self.AccountPaymentHistory := 
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditAccountPaymentHistory,
								self.ReportedDate.Year          := rt.OG1_AcctDet_PayHist_Rep_Year           ;
								self.ReportedDate.Month         := rt.OG1_AcctDet_PayHist_Rep_Month          ;
								self.ReportedDate.Day           := rt.OG1_AcctDet_PayHist_Rep_Day            ;
								self.ClosureDate.Year           := rt.OG1_AcctDet_PayHist_Close_Year         ;
								self.ClosureDate.Month          := rt.OG1_AcctDet_PayHist_Close_Month        ;
								self.ClosureDate.Day            := rt.OG1_AcctDet_PayHist_Close_Day          ;
								self.ClosureReason              := rt.OG1_AcctDet_PayHist_ClosureReason      ;
								self.CurrentCreditLimit         := rt.OG1_AcctDet_PayHist_CurrentCreditLimit ;
								self.AmountOutstanding          := rt.OG1_AcctDet_PayHist_AmountOutstanding  ;
								self.PaymentStatus              := rt.OG1_AcctDet_PayHist_PaymentStatus      ;
								self.PastDueAmount              := rt.OG1_AcctDet_PayHist_PastDueAmount      ;
								self.IsExtendedOverdue          := rt.OG1_AcctDet_PayHist_IsExtendedOverdue  ;
						));
				));
				self.RelatedAccountDetails := 
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditAccountDetails,
						self.BusinessIds.DotID         := rt.OG1_RelDet_DotID                       ;
						self.BusinessIds.EmpID         := rt.OG1_RelDet_EmpID                       ;
						self.BusinessIds.POWID         := rt.OG1_RelDet_POWID                       ;
						self.BusinessIds.ProxID        := rt.OG1_RelDet_ProxID                      ;
						self.BusinessIds.SeleID        := rt.OG1_RelDet_SeleID                      ;
						self.BusinessIds.OrgID         := rt.OG1_RelDet_OrgID                       ;
						self.BusinessIds.UltID         := rt.OG1_RelDet_UltID                       ;
						self.CompanyName               := rt.OG1_RelDet_CompanyName                 ;
						self.BusinessContributorNumber := rt.OG1_RelDet_BusinessContributorNumber   ;
						self.BusinessAccountNumber     := rt.OG1_RelDet_BusinessAccountNumber       ;
						self.AccountTypeReportedCode   := rt.OG1_RelDet_AccountTypeReportedCode     ;
						self.AccountTypeReportedDesc   := rt.OG1_RelDet_AccountTypeReportedDesc     ;
						self.AccountStatus             := rt.OG1_RelDet_AccountStatus               ;
						self.AccountOpenDate.Year      := rt.OG1_RelDet_Open_Year                   ;
						self.AccountOpenDate.Month     := rt.OG1_RelDet_Open_Month                  ;
						self.AccountOpenDate.Day       := rt.OG1_RelDet_Open_Day                    ;
						self.OriginalAmount            := rt.OG1_RelDet_OriginalAmount              ;
						self.AmountOutstanding         := rt.OG1_RelDet_AmountOutstanding           ;
						self.Overdue                   := rt.OG1_RelDet_Overdue                     ;
						self.PastDueAmount             := rt.OG1_RelDet_PastDueAmount               ;
						self.BusinessCreditIndicator   := rt.OG1_RelDet_BusinessCreditIndicator     ;
						self.AccountPaymentHistory := 
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditAccountPaymentHistory,
								self.ReportedDate.Year   := rt.OG1_RelDet_PayHist_Rep_Year            ;
								self.ReportedDate.Month  := rt.OG1_RelDet_PayHist_Rep_Month           ;
								self.ReportedDate.Day    := rt.OG1_RelDet_PayHist_Rep_Day             ;
								self.ClosureDate.Year    := rt.OG1_RelDet_PayHist_Close_Year          ;
								self.ClosureDate.Month   := rt.OG1_RelDet_PayHist_Close_Month         ;
								self.ClosureDate.Day     := rt.OG1_RelDet_PayHist_Close_Day           ;
								self.ClosureReason       := rt.OG1_RelDet_PayHist_ClosureReason       ;
								self.CurrentCreditLimit  := rt.OG1_RelDet_PayHist_CurrentCreditLimit  ;
								self.AmountOutstanding   := rt.OG1_RelDet_PayHist_AmountOutstanding   ;
								self.PaymentStatus       := rt.OG1_RelDet_PayHist_PaymentStatus       ;
								self.PastDueAmount       := rt.OG1_RelDet_PayHist_PastDueAmount       ;
								self.IsExtendedOverdue   := rt.OG1_RelDet_PayHist_IsExtendedOverdue   ;
						));
				));
		));
		
		OwnerGuarantor2 := 
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditOwnerGuarantor,
				self.BusinessIds.DotID                 := rt.OG2_Bus_DotID                          ;
				self.BusinessIds.EmpID                 := rt.OG2_Bus_EmpID                          ;
				self.BusinessIds.POWID                 := rt.OG2_Bus_POWID                          ;
				self.BusinessIds.ProxID                := rt.OG2_Bus_ProxID                         ;
				self.BusinessIds.SeleID                := rt.OG2_Bus_SeleID                         ;
				self.BusinessIds.OrgID                 := rt.OG2_Bus_OrgID                          ;
				self.BusinessIds.UltID                 := rt.OG2_Bus_UltID                          ;
				self.UniqueId                          := rt.OG2_UniqueId                           ;
				self.EntityName.Full                   := rt.OG2_EntName_Full                       ;
				self.EntityName.First                  := rt.OG2_EntName_First                      ;
				self.EntityName.Middle                 := rt.OG2_EntName_Middle                     ;
				self.EntityName.Last                   := rt.OG2_EntName_Last                       ;
				self.EntityName.Suffix                 := rt.OG2_EntName_Suffix                     ;
				self.EntityName.Prefix                 := rt.OG2_EntName_Prefix                     ;
				self.EntityName.CompanyName            := rt.OG2_EntName_CompanyName                ;
				self.EntityType                        := rt.OG2_EntityType                         ;
				self.EntityAddress.StreetNumber        := rt.OG2_EntAddr_StreetNumber               ;
				self.EntityAddress.StreetPreDirection  := rt.OG2_EntAddr_StreetPreDirection         ;
				self.EntityAddress.StreetName          := rt.OG2_EntAddr_StreetName                 ;
				self.EntityAddress.StreetSuffix        := rt.OG2_EntAddr_StreetSuffix               ;
				self.EntityAddress.StreetPostDirection := rt.OG2_EntAddr_StreetPostDirection        ;
				self.EntityAddress.UnitDesignation     := rt.OG2_EntAddr_UnitDesignation            ;
				self.EntityAddress.UnitNumber          := rt.OG2_EntAddr_UnitNumber                 ;
				self.EntityAddress.StreetAddress1      := rt.OG2_EntAddr_StreetAddress1             ;
				self.EntityAddress.StreetAddress2      := rt.OG2_EntAddr_StreetAddress2             ;
				self.EntityAddress.City                := rt.OG2_EntAddr_City                       ;
				self.EntityAddress.State               := rt.OG2_EntAddr_State                      ;
				self.EntityAddress.Zip5                := rt.OG2_EntAddr_Zip5                       ;
				self.EntityAddress.Zip4                := rt.OG2_EntAddr_Zip4                       ;
				self.EntityAddress.County              := rt.OG2_EntAddr_County                     ;
				self.EntityAddress.PostalCode          := rt.OG2_EntAddr_PostalCode                 ;
				self.EntityAddress.StateCityZip        := rt.OG2_EntAddr_StateCityZip               ;
				self.OwnerGuarantorIndicator           := rt.OwnerGuarantorIndicator2               ;
				self.OwnershipPercent                  := rt.OG2_OwnershipPercent                   ;
				self.BusinessCreditIndicator           := rt.OG2_BusinessCreditIndicator            ;
				self.AccountDetails := 
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditAccountDetails,
						self.BusinessIds.DotID         := rt.OG2_AcctDet_DotID                      ;
						self.BusinessIds.EmpID         := rt.OG2_AcctDet_EmpID                      ;
						self.BusinessIds.POWID         := rt.OG2_AcctDet_POWID                      ;
						self.BusinessIds.ProxID        := rt.OG2_AcctDet_ProxID                     ;
						self.BusinessIds.SeleID        := rt.OG2_AcctDet_SeleID                     ;
						self.BusinessIds.OrgID         := rt.OG2_AcctDet_OrgID                      ;
						self.BusinessIds.UltID         := rt.OG2_AcctDet_UltID                      ;
						self.CompanyName               := rt.OG2_AcctDet_CompanyName                ;
						self.BusinessContributorNumber := rt.OG2_AcctDet_BusinessContributorNumber  ;
						self.BusinessAccountNumber     := rt.OG2_AcctDet_BusinessAccountNumber      ;
						self.AccountTypeReportedCode   := rt.OG2_AcctDet_AccountTypeReportedCode    ;
						self.AccountTypeReportedDesc   := rt.OG2_AcctDet_AccountTypeReportedDesc    ;
						self.AccountStatus             := rt.OG2_AcctDet_AccountStatus              ;
						self.AccountOpenDate.Year      := rt.OG2_AcctDet_Open_Year                  ;
						self.AccountOpenDate.Month     := rt.OG2_AcctDet_Open_Month                 ;
						self.AccountOpenDate.Day       := rt.OG2_AcctDet_Open_Day                   ;
						self.OriginalAmount            := rt.OG2_AcctDet_OriginalAmount             ;
						self.AmountOutstanding         := rt.OG2_AcctDet_AmountOutstanding          ;
						self.Overdue                   := rt.OG2_AcctDet_Overdue                    ;
						self.PastDueAmount             := rt.OG2_AcctDet_PastDueAmount              ;
						self.BusinessCreditIndicator   := rt.OG2_AcctDet_BusinessCreditIndicator    ;
						self.AccountPaymentHistory := 
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditAccountPaymentHistory,
								self.ReportedDate.Year   := rt.OG2_AcctDet_PayHist_Rep_Year           ;
								self.ReportedDate.Month  := rt.OG2_AcctDet_PayHist_Rep_Month          ;
								self.ReportedDate.Day    := rt.OG2_AcctDet_PayHist_Rep_Day            ;
								self.ClosureDate.Year    := rt.OG2_AcctDet_PayHist_Close_Year         ;
								self.ClosureDate.Month   := rt.OG2_AcctDet_PayHist_Close_Month        ;
								self.ClosureDate.Day     := rt.OG2_AcctDet_PayHist_Close_Day          ;
								self.ClosureReason       := rt.OG2_AcctDet_PayHist_ClosureReason      ;
								self.CurrentCreditLimit  := rt.OG2_AcctDet_PayHist_CurrentCreditLimit ;
								self.AmountOutstanding   := rt.OG2_AcctDet_PayHist_AmountOutstanding  ;
								self.PaymentStatus       := rt.OG2_AcctDet_PayHist_PaymentStatus      ;
								self.PastDueAmount       := rt.OG2_AcctDet_PayHist_PastDueAmount      ;
								self.IsExtendedOverdue   := rt.OG2_AcctDet_PayHist_IsExtendedOverdue  ;
						));
				));
				self.RelatedAccountDetails := 
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditAccountDetails,
						self.BusinessIds.DotID            := rt.OG2_RelDet_DotID                       ;
						self.BusinessIds.EmpID            := rt.OG2_RelDet_EmpID                       ;
						self.BusinessIds.POWID            := rt.OG2_RelDet_POWID                       ;
						self.BusinessIds.ProxID           := rt.OG2_RelDet_ProxID                      ;
						self.BusinessIds.SeleID           := rt.OG2_RelDet_SeleID                      ;
						self.BusinessIds.OrgID            := rt.OG2_RelDet_OrgID                       ;
						self.BusinessIds.UltID            := rt.OG2_RelDet_UltID                       ;
						self.CompanyName                  := rt.OG2_RelDet_CompanyName                 ;
						self.BusinessContributorNumber    := rt.OG2_RelDet_BusinessContributorNumber   ;
						self.BusinessAccountNumber        := rt.OG2_RelDet_BusinessAccountNumber       ;
						self.AccountTypeReportedCode      := rt.OG2_RelDet_AccountTypeReportedCode     ;
						self.AccountTypeReportedDesc      := rt.OG2_RelDet_AccountTypeReportedDesc     ;
						self.AccountStatus                := rt.OG2_RelDet_AccountStatus               ;
						self.AccountOpenDate.Year         := rt.OG2_RelDet_Open_Year                   ;
						self.AccountOpenDate.Month        := rt.OG2_RelDet_Open_Month                  ;
						self.AccountOpenDate.Day          := rt.OG2_RelDet_Open_Day                    ;
						self.OriginalAmount               := rt.OG2_RelDet_OriginalAmount              ;
						self.AmountOutstanding            := rt.OG2_RelDet_AmountOutstanding           ;
						self.Overdue                      := rt.OG2_RelDet_Overdue                     ;
						self.PastDueAmount                := rt.OG2_RelDet_PastDueAmount               ;
						self.BusinessCreditIndicator      := rt.OG2_RelDet_BusinessCreditIndicator     ;
						self.AccountPaymentHistory := 
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditAccountPaymentHistory,
								self.ReportedDate.Year   := rt.OG2_RelDet_PayHist_Rep_Year            ;
								self.ReportedDate.Month  := rt.OG2_RelDet_PayHist_Rep_Month           ;
								self.ReportedDate.Day    := rt.OG2_RelDet_PayHist_Rep_Day             ;
								self.ClosureDate.Year    := rt.OG2_RelDet_PayHist_Close_Year          ;
								self.ClosureDate.Month   := rt.OG2_RelDet_PayHist_Close_Month         ;
								self.ClosureDate.Day     := rt.OG2_RelDet_PayHist_Close_Day           ;
								self.ClosureReason       := rt.OG2_RelDet_PayHist_ClosureReason       ;
								self.CurrentCreditLimit  := rt.OG2_RelDet_PayHist_CurrentCreditLimit  ;
								self.AmountOutstanding   := rt.OG2_RelDet_PayHist_AmountOutstanding   ;
								self.PaymentStatus       := rt.OG2_RelDet_PayHist_PaymentStatus       ;
								self.PastDueAmount       := rt.OG2_RelDet_PayHist_PastDueAmount       ;
								self.IsExtendedOverdue   := rt.OG2_RelDet_PayHist_IsExtendedOverdue   ;
						));
				));
		));
		
		self.OwnerGuarantors := OwnerGuarantor1 + OwnerGuarantor2;
		
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_OwnerGuarantor := join(CR_Summary, Seed_Files.BusinessCreditReport_keys.OwnGuartor,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_OwnerGuarantor(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_Bankruptcy (working_layout le, Seed_Files.BusinessCreditReport_keys.TopBusBankr rt) := transform
		self.TopBusinessRecord.BankruptcySection := 
			project(rt, transform(iesp.TopBusinessReport.t_TopBusinessBankruptcySection,
				self.DerogSummaryCntBankruptcy                              := rt.Bank_DerogSummaryCntBankruptcy      ;
				self.TotalDerogSummaryCntBankruptcy                         := rt.Bank_TotalDerogSummaryCntBankruptcy ;
				self.AsDebtors := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessBankruptcy,
					self.CourtCode                := rt.Bank_CourtCode          ;
					self.CourtLocation            := rt.Bank_CourtLocation      ;
					self.SSN                      := rt.Bank_SSN                ;
					self.TaxID                    := rt.Bank_TaxID              ;
					self.UniqueID                 := rt.Bank_UniqueID           ;
					self.Comment                  := rt.Bank_Comment            ;
					self.FilingStatus             := rt.Bank_FilingStatus       ;
					self.OriginalFilingType       := rt.Bank_OriginalFilingType ;
					self.StatusHistory            := rt.Bank_StatusHistory      ;
					self.OriginalCaseNumber       := rt.Bank_OriginalCaseNumber ;
					self.Status                   := rt.Bank_Status             ;
					self.StatusRaw                := rt.Bank_StatusRaw          ;
					self.FilingType               := rt.Bank_FilingType         ;
					self.FilerType                := rt.Bank_FilerType          ;
					self.StatusDate.Year          := rt.Bank_Stat_Year          ;
					self.StatusDate.Month         := rt.Bank_Stat_Month         ;
					self.StatusDate.Day           := rt.Bank_Stat_Day           ;
					self.OriginalFilingDate.Year  := rt.Bank_Orig_Year          ;
					self.OriginalFilingDate.Month := rt.Bank_Orig_Month         ;
					self.OriginalFilingDate.Day   := rt.Bank_Orig_Day           ;
					self.Debtors := 
						project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessBankruptcyParty,
							self.CompanyName                    := rt.Bank_Debt_CompanyName               ;
							self.Name.Full                      := rt.Bank_Debt_Full                      ;
							self.Name.First                     := rt.Bank_Debt_First                     ;
							self.Name.Middle                    := rt.Bank_Debt_Middle                    ;
							self.Name.Last                      := rt.Bank_Debt_Last                      ;
							self.Name.Suffix                    := rt.Bank_Debt_Suffix                    ;
							self.Name.Prefix                    := rt.Bank_Debt_Prefix                    ;
							self.Address.StreetNumber           := rt.Bank_Debt_StreetNumber              ;
							self.Address.StreetPreDirection     := rt.Bank_Debt_StreetPreDirection        ;
							self.Address.StreetName             := rt.Bank_Debt_StreetName                ;
							self.Address.StreetSuffix           := rt.Bank_Debt_StreetSuffix              ;
							self.Address.StreetPostDirection    := rt.Bank_Debt_StreetPostDirection       ;
							self.Address.UnitDesignation        := rt.Bank_Debt_UnitDesignation           ;
							self.Address.UnitNumber             := rt.Bank_Debt_UnitNumber                ;
							self.Address.StreetAddress1         := rt.Bank_Debt_StreetAddress1            ;
							self.Address.StreetAddress2         := rt.Bank_Debt_StreetAddress2            ;
							self.Address.City                   := rt.Bank_Debt_City                      ;
							self.Address.State                  := rt.Bank_Debt_State                     ;
							self.Address.Zip5                   := rt.Bank_Debt_Zip5                      ;
							self.Address.Zip4                   := rt.Bank_Debt_Zip4                      ;
							self.Address.County                 := rt.Bank_Debt_County                    ;
							self.Address.PostalCode             := rt.Bank_Debt_PostalCode                ;
							self.Address.StateCityZip           := rt.Bank_Debt_StateCityZip              ;
							self.TaxID                          := rt.Bank_Debt_TaxID                     ;
							self.SSN                            := rt.Bank_Debt_SSN                       ;
					));
					self.Attorneys := 
						project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessBankruptcyParty,
							self.CompanyName                  := rt.Bank_Att_CompanyName                ;
							self.Name.Full                    := rt.Bank_Att_Full                       ;
							self.Name.First                   := rt.Bank_Att_First                      ;
							self.Name.Middle                  := rt.Bank_Att_Middle                     ;
							self.Name.Last                    := rt.Bank_Att_Last                       ;
							self.Name.Suffix                  := rt.Bank_Att_Suffix                     ;
							self.Name.Prefix                  := rt.Bank_Att_Prefix                     ;
							self.Address.StreetNumber         := rt.Bank_Att_StreetNumber               ;
							self.Address.StreetPreDirection   := rt.Bank_Att_StreetPreDirection         ;
							self.Address.StreetName           := rt.Bank_Att_StreetName                 ;
							self.Address.StreetSuffix         := rt.Bank_Att_StreetSuffix               ;
							self.Address.StreetPostDirection  := rt.Bank_Att_StreetPostDirection        ;
							self.Address.UnitDesignation      := rt.Bank_Att_UnitDesignation            ;
							self.Address.UnitNumber           := rt.Bank_Att_UnitNumber                 ;
							self.Address.StreetAddress1       := rt.Bank_Att_StreetAddress1             ;
							self.Address.StreetAddress2       := rt.Bank_Att_StreetAddress2             ;
							self.Address.City                 := rt.Bank_Att_City                       ;
							self.Address.State                := rt.Bank_Att_State                      ;
							self.Address.Zip5                 := rt.Bank_Att_Zip5                       ;
							self.Address.Zip4                 := rt.Bank_Att_Zip4                       ;
							self.Address.County               := rt.Bank_Att_County                     ;
							self.Address.PostalCode           := rt.Bank_Att_PostalCode                 ;
							self.Address.StateCityZip         := rt.Bank_Att_StateCityZip               ;
							self.TaxID                        := rt.Bank_Att_TaxID                      ;
							self.SSN                          := rt.Bank_Att_SSN                        ;
					));
					self.Trustees := 
						project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessBankruptcyParty,
							self.CompanyName                   := rt.Bank_Trust_CompanyName              ;
							self.Name.Full                     := rt.Bank_Trust_Full                     ;
							self.Name.First                    := rt.Bank_Trust_First                    ;
							self.Name.Middle                   := rt.Bank_Trust_Middle                   ;
							self.Name.Last                     := rt.Bank_Trust_Last                     ;
							self.Name.Suffix                   := rt.Bank_Trust_Suffix                   ;
							self.Name.Prefix                   := rt.Bank_Trust_Prefix                   ;
							self.Address.StreetNumber          := rt.Bank_Trust_StreetNumber             ;
							self.Address.StreetPreDirection    := rt.Bank_Trust_StreetPreDirection       ;
							self.Address.StreetName            := rt.Bank_Trust_StreetName               ;
							self.Address.StreetSuffix          := rt.Bank_Trust_StreetSuffix             ;
							self.Address.StreetPostDirection   := rt.Bank_Trust_StreetPostDirection      ;
							self.Address.UnitDesignation       := rt.Bank_Trust_UnitDesignation          ;
							self.Address.UnitNumber            := rt.Bank_Trust_UnitNumber               ;
							self.Address.StreetAddress1        := rt.Bank_Trust_StreetAddress1           ;
							self.Address.StreetAddress2        := rt.Bank_Trust_StreetAddress2           ;
							self.Address.City                  := rt.Bank_Trust_City                     ;
							self.Address.State                 := rt.Bank_Trust_State                    ;
							self.Address.Zip5                  := rt.Bank_Trust_Zip5                     ;
							self.Address.Zip4                  := rt.Bank_Trust_Zip4                     ;
							self.Address.County                := rt.Bank_Trust_County                   ;
							self.Address.PostalCode            := rt.Bank_Trust_PostalCode               ;
							self.Address.StateCityZip          := rt.Bank_Trust_StateCityZip             ;
							self.TaxID                         := rt.Bank_Trust_TaxID                    ;
							self.SSN                           := rt.Bank_Trust_SSN                      ;
					));
					self.SourceDocs :=
						project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
							self.BusinessIds.DotID           := rt.Bank_Docs_DotID                     ;
							self.BusinessIds.EmpID           := rt.Bank_Docs_EmpID                     ;
							self.BusinessIds.POWID           := rt.Bank_Docs_POWID                     ;
							self.BusinessIds.ProxID          := rt.Bank_Docs_ProxID                    ;
							self.BusinessIds.SeleID          := rt.Bank_Docs_SeleID                    ;
							self.BusinessIds.OrgID           := rt.Bank_Docs_OrgID                     ;
							self.BusinessIds.UltID           := rt.Bank_Docs_UltID                     ;
							self.IdType                      := rt.Bank_Docs_IdType                    ;
							self.IdValue                     := rt.Bank_Docs_IdValue                   ;
							self.Section                     := rt.Bank_Docs_Section                   ;
							self.Source                      := rt.Bank_Docs_Source                    ;
							self.Address.StreetNumber        := rt.Bank_Docs_StreetNumber              ;
							self.Address.StreetPreDirection  := rt.Bank_Docs_StreetPreDirection        ;
							self.Address.StreetName          := rt.Bank_Docs_StreetName                ;
							self.Address.StreetSuffix        := rt.Bank_Docs_StreetSuffix              ;
							self.Address.StreetPostDirection := rt.Bank_Docs_StreetPostDirection       ;
							self.Address.UnitDesignation     := rt.Bank_Docs_UnitDesignation           ;
							self.Address.UnitNumber          := rt.Bank_Docs_UnitNumber                ;
							self.Address.StreetAddress1      := rt.Bank_Docs_StreetAddress1            ;
							self.Address.StreetAddress2      := rt.Bank_Docs_StreetAddress2            ;
							self.Address.City                := rt.Bank_Docs_City                      ;
							self.Address.State               := rt.Bank_Docs_State                     ;
							self.Address.Zip5                := rt.Bank_Docs_Zip5                      ;
							self.Address.Zip4                := rt.Bank_Docs_Zip4                      ;
							self.Address.County              := rt.Bank_Docs_County                    ;
							self.Address.PostalCode          := rt.Bank_Docs_PostalCode                ;
							self.Address.StateCityZip        := rt.Bank_Docs_StateCityZip              ;
							self.Name.Full                   := rt.Bank_Docs_Full                      ;
							self.Name.First                  := rt.Bank_Docs_First                     ;
							self.Name.Middle                 := rt.Bank_Docs_Middle                    ;
							self.Name.Last                   := rt.Bank_Docs_Last                      ;
							self.Name.Suffix                 := rt.Bank_Docs_Suffix                    ;
							self.Name.Prefix                 := rt.Bank_Docs_Prefix                    ;
							self.Name.CompanyName            := rt.Bank_Docs_CompanyName               ;
					));
				));
				self.DebtorSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID                  := rt.Bank_DebtDocs_DotID                 ;
						self.BusinessIds.EmpID                  := rt.Bank_DebtDocs_EmpID                 ;
						self.BusinessIds.POWID                  := rt.Bank_DebtDocs_POWID                 ;
						self.BusinessIds.ProxID                 := rt.Bank_DebtDocs_ProxID                ;
						self.BusinessIds.SeleID                 := rt.Bank_DebtDocs_SeleID                ;
						self.BusinessIds.OrgID                  := rt.Bank_DebtDocs_OrgID                 ;
						self.BusinessIds.UltID                  := rt.Bank_DebtDocs_UltID                 ;
						self.IdType                             := rt.Bank_DebtDocs_IdType                ;
						self.IdValue                            := rt.Bank_DebtDocs_IdValue               ;
						self.Section                            := rt.Bank_DebtDocs_Section               ;
						self.Source                             := rt.Bank_DebtDocs_Source                ;
						self.Address.StreetNumber               := rt.Bank_DebtDocs_StreetNumber          ;
						self.Address.StreetPreDirection         := rt.Bank_DebtDocs_StreetPreDirection    ;
						self.Address.StreetName                 := rt.Bank_DebtDocs_StreetName            ;
						self.Address.StreetSuffix               := rt.Bank_DebtDocs_StreetSuffix          ;
						self.Address.StreetPostDirection        := rt.Bank_DebtDocs_StreetPostDirection   ;
						self.Address.UnitDesignation            := rt.Bank_DebtDocs_UnitDesignation       ;
						self.Address.UnitNumber                 := rt.Bank_DebtDocs_UnitNumber            ;
						self.Address.StreetAddress1             := rt.Bank_DebtDocs_StreetAddress1        ;
						self.Address.StreetAddress2             := rt.Bank_DebtDocs_StreetAddress2        ;
						self.Address.City                       := rt.Bank_DebtDocs_City                  ;
						self.Address.State                      := rt.Bank_DebtDocs_State                 ;
						self.Address.Zip5                       := rt.Bank_DebtDocs_Zip5                  ;
						self.Address.Zip4                       := rt.Bank_DebtDocs_Zip4                  ;
						self.Address.County                     := rt.Bank_DebtDocs_County                ;
						self.Address.PostalCode                 := rt.Bank_DebtDocs_PostalCode            ;
						self.Address.StateCityZip               := rt.Bank_DebtDocs_StateCityZip          ;
						self.Name.Full                          := rt.Bank_DebtDocs_Full                  ;
						self.Name.First                         := rt.Bank_DebtDocs_First                 ;
						self.Name.Middle                        := rt.Bank_DebtDocs_Middle                ;
						self.Name.Last                          := rt.Bank_DebtDocs_Last                  ;
						self.Name.Suffix                        := rt.Bank_DebtDocs_Suffix                ;
						self.Name.Prefix                        := rt.Bank_DebtDocs_Prefix                ;
						self.Name.CompanyName                   := rt.Bank_DebtDocs_CompanyName           ;
				));
		));
	
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_Bankruptcy := join(CR_OwnerGuarantor, Seed_Files.BusinessCreditReport_keys.TopBusBankr,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_Bankruptcy(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_Liens (working_layout le, Seed_Files.BusinessCreditReport_keys.TopBusLiens rt) := transform
		self.TopBusinessRecord.LienSection := 
			project(rt, transform(iesp.TopBusinessReport.t_TopBusinessLienSection,
				self.DerogSummaryCntJL                                           := rt.Lien_DerogSummaryCntJL            ;
				self.ReturnedRecordCount                                         := rt.Lien_ReturnedRecordCount          ;
				self.TotalRecordCount                                            := rt.Lien_TotalRecordCount             ;
				self.JudgmentsLiens :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessJudgmentLienDetail,
						self.Debtors := 
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessJudgmentLienParty,
								self.CompanyName                    := rt.JudgLien_Debt_CompanyName         ;
								self.TaxId                          := rt.JudgLien_Debt_TaxId               ;
								self.SSN                            := rt.JudgLien_Debt_SSN                 ;
								self.Name.Full                      := rt.JudgLien_Debt_Full                ;
								self.Name.First                     := rt.JudgLien_Debt_First               ;
								self.Name.Middle                    := rt.JudgLien_Debt_Middle              ;
								self.Name.Last                      := rt.JudgLien_Debt_Last                ;
								self.Name.Suffix                    := rt.JudgLien_Debt_Suffix              ;
								self.Name.Prefix                    := rt.JudgLien_Debt_Prefix              ;
								self.Address.StreetNumber           := rt.JudgLien_Debt_StreetNumber        ;
								self.Address.StreetPreDirection     := rt.JudgLien_Debt_StreetPreDirection  ;
								self.Address.StreetName             := rt.JudgLien_Debt_StreetName          ;
								self.Address.StreetSuffix           := rt.JudgLien_Debt_StreetSuffix        ;
								self.Address.StreetPostDirection    := rt.JudgLien_Debt_StreetPostDirection ;
								self.Address.UnitDesignation        := rt.JudgLien_Debt_UnitDesignation     ;
								self.Address.UnitNumber             := rt.JudgLien_Debt_UnitNumber          ;
								self.Address.StreetAddress1         := rt.JudgLien_Debt_StreetAddress1      ;
								self.Address.StreetAddress2         := rt.JudgLien_Debt_StreetAddress2      ;
								self.Address.City                   := rt.JudgLien_Debt_City                ;
								self.Address.State                  := rt.JudgLien_Debt_State               ;
								self.Address.Zip5                   := rt.JudgLien_Debt_Zip5                ;
								self.Address.Zip4                   := rt.JudgLien_Debt_Zip4                ;
								self.Address.County                 := rt.JudgLien_Debt_County              ;
								self.Address.PostalCode             := rt.JudgLien_Debt_PostalCode          ;
								self.Address.StateCityZip           := rt.JudgLien_Debt_StateCityZip        ;
						));
						self.Creditors :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessJudgmentLienParty,
								self.CompanyName                  := rt.JudgLien_Cred_CompanyName         ;
								self.TaxId                        := rt.JudgLien_Cred_TaxId               ;
								self.SSN                          := rt.JudgLien_Cred_SSN                 ;
								self.Name.Full                    := rt.JudgLien_Cred_Full                ;
								self.Name.First                   := rt.JudgLien_Cred_First               ;
								self.Name.Middle                  := rt.JudgLien_Cred_Middle              ;
								self.Name.Last                    := rt.JudgLien_Cred_Last                ;
								self.Name.Suffix                  := rt.JudgLien_Cred_Suffix              ;
								self.Name.Prefix                  := rt.JudgLien_Cred_Prefix              ;
								self.Address.StreetNumber         := rt.JudgLien_Cred_StreetNumber        ;
								self.Address.StreetPreDirection   := rt.JudgLien_Cred_StreetPreDirection  ;
								self.Address.StreetName           := rt.JudgLien_Cred_StreetName          ;
								self.Address.StreetSuffix         := rt.JudgLien_Cred_StreetSuffix        ;
								self.Address.StreetPostDirection  := rt.JudgLien_Cred_StreetPostDirection ;
								self.Address.UnitDesignation      := rt.JudgLien_Cred_UnitDesignation     ;
								self.Address.UnitNumber           := rt.JudgLien_Cred_UnitNumber          ;
								self.Address.StreetAddress1       := rt.JudgLien_Cred_StreetAddress1      ;
								self.Address.StreetAddress2       := rt.JudgLien_Cred_StreetAddress2      ;
								self.Address.City                 := rt.JudgLien_Cred_City                ;
								self.Address.State                := rt.JudgLien_Cred_State               ;
								self.Address.Zip5                 := rt.JudgLien_Cred_Zip5                ;
								self.Address.Zip4                 := rt.JudgLien_Cred_Zip4                ;
								self.Address.County               := rt.JudgLien_Cred_County              ;
								self.Address.PostalCode           := rt.JudgLien_Cred_PostalCode          ;
								self.Address.StateCityZip         := rt.JudgLien_Cred_StateCityZip        ;
						));
						self.Filings :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessJudgmentLienFilings,
								self.FilingNumber       := rt.JudgLien_FilingNumber      ;
								self.FilingType         := rt.JudgLien_FilingType        ;
								self.FilingStatus       := rt.JudgLien_FilingStatus      ;
								self.FilingDate.Year    := rt.JudgLien_Filing_File_Year  ;
								self.FilingDate.Month   := rt.JudgLien_Filing_File_Month ;
								self.FilingDate.Day     := rt.JudgLien_Filing_File_Day   ;
								self.ReleaseDate.Year   := rt.JudgLien_Filing_Rel_Year   ;
								self.ReleaseDate.Month  := rt.JudgLien_Filing_Rel_Month  ;
								self.ReleaseDate.Day    := rt.JudgLien_Filing_Rel_Day    ;
								self.Agency             := rt.JudgLien_File_Agency       ;
								self.AgencyState        := rt.JudgLien_File_AgencyState  ;
								self.AgencyCounty       := rt.JudgLien_File_AgencyCounty ;
						));
						self.FilingJurisdiction                        := rt.JudgLien_FilingJurisdiction       ;
						self.Amount                                    := rt.JudgLien_Amount                   ;
						self.OrigFilingNumber                          := rt.JudgLien_OrigFilingNumber         ;
						self.OrigFilingType                            := rt.JudgLien_OrigFilingType           ;
						self.OrigFilingDate.Year                       := rt.JudgLien_Orig_Year                ;
						self.OrigFilingDate.Month                      := rt.JudgLien_Orig_Month               ;
						self.OrigFilingDate.Day                        := rt.JudgLien_Orig_Day                 ;
						self.ReleaseDate.Year                          := rt.JudgLien_Rel_Year                 ;
						self.ReleaseDate.Month                         := rt.JudgLien_Rel_Month                ;
						self.ReleaseDate.Day                           := rt.JudgLien_Rel_Day                  ;
						self.Eviction                                  := rt.JudgLien_Eviction                 ;
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID           := rt.JudgLien_Docs_DotID               ;
								self.BusinessIds.EmpID           := rt.JudgLien_Docs_EmpID               ;
								self.BusinessIds.POWID           := rt.JudgLien_Docs_POWID               ;
								self.BusinessIds.ProxID          := rt.JudgLien_Docs_ProxID              ;
								self.BusinessIds.SeleID          := rt.JudgLien_Docs_SeleID              ;
								self.BusinessIds.OrgID           := rt.JudgLien_Docs_OrgID               ;
								self.BusinessIds.UltID           := rt.JudgLien_Docs_UltID               ;
								self.IdType                      := rt.JudgLien_Docs_IdType              ;
								self.IdValue                     := rt.JudgLien_Docs_IdValue             ;
								self.Section                     := rt.JudgLien_Docs_Section             ;
								self.Source                      := rt.JudgLien_Docs_Source              ;
								self.Address.StreetNumber        := rt.JudgLien_Docs_StreetNumber        ;
								self.Address.StreetPreDirection  := rt.JudgLien_Docs_StreetPreDirection  ;
								self.Address.StreetName          := rt.JudgLien_Docs_StreetName          ;
								self.Address.StreetSuffix        := rt.JudgLien_Docs_StreetSuffix        ;
								self.Address.StreetPostDirection := rt.JudgLien_Docs_StreetPostDirection ;
								self.Address.UnitDesignation     := rt.JudgLien_Docs_UnitDesignation     ;
								self.Address.UnitNumber          := rt.JudgLien_Docs_UnitNumber          ;
								self.Address.StreetAddress1      := rt.JudgLien_Docs_StreetAddress1      ;
								self.Address.StreetAddress2      := rt.JudgLien_Docs_StreetAddress2      ;
								self.Address.City                := rt.JudgLien_Docs_City                ;
								self.Address.State               := rt.JudgLien_Docs_State               ;
								self.Address.Zip5                := rt.JudgLien_Docs_Zip5                ;
								self.Address.Zip4                := rt.JudgLien_Docs_Zip4                ;
								self.Address.County              := rt.JudgLien_Docs_County              ;
								self.Address.PostalCode          := rt.JudgLien_Docs_PostalCode          ;
								self.Address.StateCityZip        := rt.JudgLien_Docs_StateCityZip        ;
								self.Name.Full                   := rt.JudgLien_Docs_Full                ;
								self.Name.First                  := rt.JudgLien_Docs_First               ;
								self.Name.Middle                 := rt.JudgLien_Docs_Middle              ;
								self.Name.Last                   := rt.JudgLien_Docs_Last                ;
								self.Name.Suffix                 := rt.JudgLien_Docs_Suffix              ;
								self.Name.Prefix                 := rt.JudgLien_Docs_Prefix              ;
								self.Name.CompanyName            := rt.JudgLien_Docs_CompanyName         ;
						));
				));
				self.SourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID                             := rt.Lien_Docs_DotID                   ;
						self.BusinessIds.EmpID                             := rt.Lien_Docs_EmpID                   ;
						self.BusinessIds.POWID                             := rt.Lien_Docs_POWID                   ;
						self.BusinessIds.ProxID                            := rt.Lien_Docs_ProxID                  ;
						self.BusinessIds.SeleID                            := rt.Lien_Docs_SeleID                  ;
						self.BusinessIds.OrgID                             := rt.Lien_Docs_OrgID                   ;
						self.BusinessIds.UltID                             := rt.Lien_Docs_UltID                   ;
						self.IdType                                        := rt.Lien_Docs_IdType                  ;
						self.IdValue                                       := rt.Lien_Docs_IdValue                 ;
						self.Section                                       := rt.Lien_Docs_Section                 ;
						self.Source                                        := rt.Lien_Docs_Source                  ;
						self.Address.StreetNumber                          := rt.Lien_Docs_StreetNumber            ;
						self.Address.StreetPreDirection                    := rt.Lien_Docs_StreetPreDirection      ;
						self.Address.StreetName                            := rt.Lien_Docs_StreetName              ;
						self.Address.StreetSuffix                          := rt.Lien_Docs_StreetSuffix            ;
						self.Address.StreetPostDirection                   := rt.Lien_Docs_StreetPostDirection     ;
						self.Address.UnitDesignation                       := rt.Lien_Docs_UnitDesignation         ;
						self.Address.UnitNumber                            := rt.Lien_Docs_UnitNumber              ;
						self.Address.StreetAddress1                        := rt.Lien_Docs_StreetAddress1          ;
						self.Address.StreetAddress2                        := rt.Lien_Docs_StreetAddress2          ;
						self.Address.City                                  := rt.Lien_Docs_City                    ;
						self.Address.State                                 := rt.Lien_Docs_State                   ;
						self.Address.Zip5                                  := rt.Lien_Docs_Zip5                    ;
						self.Address.Zip4                                  := rt.Lien_Docs_Zip4                    ;
						self.Address.County                                := rt.Lien_Docs_County                  ;
						self.Address.PostalCode                            := rt.Lien_Docs_PostalCode              ;
						self.Address.StateCityZip                          := rt.Lien_Docs_StateCityZip            ;
						self.Name.Full                                     := rt.Lien_Docs_Full                    ;
						self.Name.First                                    := rt.Lien_Docs_First                   ;
						self.Name.Middle                                   := rt.Lien_Docs_Middle                  ;
						self.Name.Last                                     := rt.Lien_Docs_Last                    ;
						self.Name.Suffix                                   := rt.Lien_Docs_Suffix                  ;
						self.Name.Prefix                                   := rt.Lien_Docs_Prefix                  ;
						self.Name.CompanyName                              := rt.Lien_Docs_CompanyName             ;
				))
		));
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_Liens := join(CR_Bankruptcy, Seed_Files.BusinessCreditReport_keys.TopBusLiens,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_Liens(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_UCC (working_layout le, Seed_Files.BusinessCreditReport_keys.TopBusUCC rt) := transform
		self.TopBusinessRecord.UCCSection := 
			project(rt, transform(iesp.TopBusinessReport.t_TopBusinessUCCSection,
				self.DerogSummaryCntUCC     := rt.UCC_DerogSummaryCntUCC    ;
				self.SecuredAssetsCntUCC    := rt.UCC_SecuredAssetsCntUCC   ;
				self.ReturnedAsDebtorCount  := rt.UCC_ReturnedAsDebtorCount ;
				self.TotalAsDebtorCount     := rt.UCC_TotalAsDebtorCount    ;
				self.ReturnedAsSecuredCount := rt.UCC_ReturnedAsSecuredCount;
				self.TotalAsSecuredCount    := rt.UCC_TotalAsSecuredCount   ;
				self.AsDebtor.ActiveUCCs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCC,
						self.FilingJurisdiction                      := rt.Debt_ActUCC_FilingJurisdiction          ;
						self.OriginalFilingNumber                    := rt.Debt_ActUCC_OriginalFilingNumber        ;
						self.OriginalFilingDate.Year                 := rt.Debt_ActUCC_Orig_Year                   ;
						self.OriginalFilingDate.Month                := rt.Debt_ActUCC_Orig_Month                  ;
						self.OriginalFilingDate.Day                  := rt.Debt_ActUCC_Orig_Day                    ;
						self.LatestFilingType                        := rt.Debt_ActUCC_LatestFilingType            ;
						self.FilingAgencyName                        := rt.Debt_ActUCC_FilingAgencyName            ;
						self.FilingAgencyAddress.StreetNumber        := rt.Debt_ActUCC_StreetNumber                ;
						self.FilingAgencyAddress.StreetPreDirection  := rt.Debt_ActUCC_StreetPreDirection          ;
						self.FilingAgencyAddress.StreetName          := rt.Debt_ActUCC_StreetName                  ;
						self.FilingAgencyAddress.StreetSuffix        := rt.Debt_ActUCC_StreetSuffix                ;
						self.FilingAgencyAddress.StreetPostDirection := rt.Debt_ActUCC_StreetPostDirection         ;
						self.FilingAgencyAddress.UnitDesignation     := rt.Debt_ActUCC_UnitDesignation             ;
						self.FilingAgencyAddress.UnitNumber          := rt.Debt_ActUCC_UnitNumber                  ;
						self.FilingAgencyAddress.StreetAddress1      := rt.Debt_ActUCC_StreetAddress1              ;
						self.FilingAgencyAddress.StreetAddress2      := rt.Debt_ActUCC_StreetAddress2              ;
						self.FilingAgencyAddress.City                := rt.Debt_ActUCC_City                        ;
						self.FilingAgencyAddress.State               := rt.Debt_ActUCC_State                       ;
						self.FilingAgencyAddress.Zip5                := rt.Debt_ActUCC_Zip5                        ;
						self.FilingAgencyAddress.Zip4                := rt.Debt_ActUCC_Zip4                        ;
						self.FilingAgencyAddress.County              := rt.Debt_ActUCC_County                      ;
						self.FilingAgencyAddress.PostalCode          := rt.Debt_ActUCC_PostalCode                  ;
						self.FilingAgencyAddress.StateCityZip        := rt.Debt_ActUCC_StateCityZip                ;
						self.Filings := 
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCFiling,
								self.FilingNumber                                  := rt.Debt_ActUCC_FilingNumber                ;
								self.FilingDate.Year                               := rt.Debt_ActUCC_File_Year                   ;
								self.FilingDate.Month                              := rt.Debt_ActUCC_File_Month                  ;
								self.FilingDate.Day                                := rt.Debt_ActUCC_File_Day                    ;
								self.FilingType                                    := rt.Debt_ActUCC_FilingType                  ;
								self.ExpirationDate.Year                           := rt.Debt_ActUCC_Exp_Year                    ;
								self.ExpirationDate.Month                          := rt.Debt_ActUCC_Exp_Month                   ;
								self.ExpirationDate.Day                            := rt.Debt_ActUCC_Exp_Day                     ;
								self.Debtors := 
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCParty,
										self.OriginalName                       := rt.Debt_ActUCC_Debt_OriginalName           ;
										self.CompanyName                        := rt.Debt_ActUCC_Debt_CompanyName            ;
										self.TaxId                              := rt.Debt_ActUCC_Debt_TaxId                  ;
										self.SSN                                := rt.Debt_ActUCC_Debt_SSN                    ;
										self.Name.Full                          := rt.Debt_ActUCC_Debt_Full                   ;
										self.Name.First                         := rt.Debt_ActUCC_Debt_First                  ;
										self.Name.Middle                        := rt.Debt_ActUCC_Debt_Middle                 ;
										self.Name.Last                          := rt.Debt_ActUCC_Debt_Last                   ;
										self.Name.Suffix                        := rt.Debt_ActUCC_Debt_Suffix                 ;
										self.Name.Prefix                        := rt.Debt_ActUCC_Debt_Prefix                 ;
										self.Address.StreetNumber               := rt.Debt_ActUCC_Debt_StreetNumber           ;
										self.Address.StreetPreDirection         := rt.Debt_ActUCC_Debt_StreetPreDirection     ;
										self.Address.StreetName                 := rt.Debt_ActUCC_Debt_StreetName             ;
										self.Address.StreetSuffix               := rt.Debt_ActUCC_Debt_StreetSuffix           ;
										self.Address.StreetPostDirection        := rt.Debt_ActUCC_Debt_StreetPostDirection    ;
										self.Address.UnitDesignation            := rt.Debt_ActUCC_Debt_UnitDesignation        ;
										self.Address.UnitNumber                 := rt.Debt_ActUCC_Debt_UnitNumber             ;
										self.Address.StreetAddress1             := rt.Debt_ActUCC_Debt_StreetAddress1         ;
										self.Address.StreetAddress2             := rt.Debt_ActUCC_Debt_StreetAddress2         ;
										self.Address.City                       := rt.Debt_ActUCC_Debt_City                   ;
										self.Address.State                      := rt.Debt_ActUCC_Debt_State                  ;
										self.Address.Zip5                       := rt.Debt_ActUCC_Debt_Zip5                   ;
										self.Address.Zip4                       := rt.Debt_ActUCC_Debt_Zip4                   ;
										self.Address.County                     := rt.Debt_ActUCC_Debt_County                 ;
										self.Address.PostalCode                 := rt.Debt_ActUCC_Debt_PostalCode             ;
										self.Address.StateCityZip               := rt.Debt_ActUCC_Debt_StateCityZip           ;
								));
								self.Secureds := 
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCParty,
										self.OriginalName                      := rt.Debt_ActUCC_Sec_OriginalName            ;
										self.CompanyName                       := rt.Debt_ActUCC_Sec_CompanyName             ;
										self.TaxId                             := rt.Debt_ActUCC_Sec_TaxId                   ;
										self.SSN                               := rt.Debt_ActUCC_Sec_SSN                     ;
										self.Name.Full                         := rt.Debt_ActUCC_Sec_Full                    ;
										self.Name.First                        := rt.Debt_ActUCC_Sec_First                   ;
										self.Name.Middle                       := rt.Debt_ActUCC_Sec_Middle                  ;
										self.Name.Last                         := rt.Debt_ActUCC_Sec_Last                    ;
										self.Name.Suffix                       := rt.Debt_ActUCC_Sec_Suffix                  ;
										self.Name.Prefix                       := rt.Debt_ActUCC_Sec_Prefix                  ;
										self.Address.StreetNumber              := rt.Debt_ActUCC_Sec_StreetNumber            ;
										self.Address.StreetPreDirection        := rt.Debt_ActUCC_Sec_StreetPreDirection      ;
										self.Address.StreetName                := rt.Debt_ActUCC_Sec_StreetName              ;
										self.Address.StreetSuffix              := rt.Debt_ActUCC_Sec_StreetSuffix            ;
										self.Address.StreetPostDirection       := rt.Debt_ActUCC_Sec_StreetPostDirection     ;
										self.Address.UnitDesignation           := rt.Debt_ActUCC_Sec_UnitDesignation         ;
										self.Address.UnitNumber                := rt.Debt_ActUCC_Sec_UnitNumber              ;
										self.Address.StreetAddress1            := rt.Debt_ActUCC_Sec_StreetAddress1          ;
										self.Address.StreetAddress2            := rt.Debt_ActUCC_Sec_StreetAddress2          ;
										self.Address.City                      := rt.Debt_ActUCC_Sec_City                    ;
										self.Address.State                     := rt.Debt_ActUCC_Sec_State                   ;
										self.Address.Zip5                      := rt.Debt_ActUCC_Sec_Zip5                    ;
										self.Address.Zip4                      := rt.Debt_ActUCC_Sec_Zip4                    ;
										self.Address.County                    := rt.Debt_ActUCC_Sec_County                  ;
										self.Address.PostalCode                := rt.Debt_ActUCC_Sec_PostalCode              ;
										self.Address.StateCityZip              := rt.Debt_ActUCC_Sec_StateCityZip            ;
								));
								self.Assignees :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCParty,
										self.OriginalName                     := rt.Debt_ActUCC_Assign_OriginalName         ;
										self.CompanyName                      := rt.Debt_ActUCC_Assign_CompanyName          ;
										self.TaxId                            := rt.Debt_ActUCC_Assign_TaxId                ;
										self.SSN                              := rt.Debt_ActUCC_Assign_SSN                  ;
										self.Name.Full                        := rt.Debt_ActUCC_Assign_Full                 ;
										self.Name.First                       := rt.Debt_ActUCC_Assign_First                ;
										self.Name.Middle                      := rt.Debt_ActUCC_Assign_Middle               ;
										self.Name.Last                        := rt.Debt_ActUCC_Assign_Last                 ;
										self.Name.Suffix                      := rt.Debt_ActUCC_Assign_Suffix               ;
										self.Name.Prefix                      := rt.Debt_ActUCC_Assign_Prefix               ;
										self.Address.StreetNumber             := rt.Debt_ActUCC_Assign_StreetNumber         ;
										self.Address.StreetPreDirection       := rt.Debt_ActUCC_Assign_StreetPreDirection   ;
										self.Address.StreetName               := rt.Debt_ActUCC_Assign_StreetName           ;
										self.Address.StreetSuffix             := rt.Debt_ActUCC_Assign_StreetSuffix         ;
										self.Address.StreetPostDirection      := rt.Debt_ActUCC_Assign_StreetPostDirection  ;
										self.Address.UnitDesignation          := rt.Debt_ActUCC_Assign_UnitDesignation      ;
										self.Address.UnitNumber               := rt.Debt_ActUCC_Assign_UnitNumber           ;
										self.Address.StreetAddress1           := rt.Debt_ActUCC_Assign_StreetAddress1       ;
										self.Address.StreetAddress2           := rt.Debt_ActUCC_Assign_StreetAddress2       ;
										self.Address.City                     := rt.Debt_ActUCC_Assign_City                 ;
										self.Address.State                    := rt.Debt_ActUCC_Assign_State                ;
										self.Address.Zip5                     := rt.Debt_ActUCC_Assign_Zip5                 ;
										self.Address.Zip4                     := rt.Debt_ActUCC_Assign_Zip4                 ;
										self.Address.County                   := rt.Debt_ActUCC_Assign_County               ;
										self.Address.PostalCode               := rt.Debt_ActUCC_Assign_PostalCode           ;
										self.Address.StateCityZip             := rt.Debt_ActUCC_Assign_StateCityZip         ;
								));
								self.Collaterals :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCCollateral,
										self.FilingNumber                   := rt.Debt_ActUCC_Col_FilingNumber            ;
										self.FilingDate.Year                := rt.Debt_ActUCC_Col_File_Year               ;
										self.FilingDate.Month               := rt.Debt_ActUCC_Col_File_Month              ;
										self.FilingDate.Day                 := rt.Debt_ActUCC_Col_File_Day                ;
										self.CollateralSequence             := rt.Debt_ActUCC_CollateralSequence          ;
										self.CollateralDescription          := rt.Debt_ActUCC_CollateralDescription       ;
								));
						));
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID           := rt.Debt_ActUCC_Docs_DotID                  ;
								self.BusinessIds.EmpID           := rt.Debt_ActUCC_Docs_EmpID                  ;
								self.BusinessIds.POWID           := rt.Debt_ActUCC_Docs_POWID                  ;
								self.BusinessIds.ProxID          := rt.Debt_ActUCC_Docs_ProxID                 ;
								self.BusinessIds.SeleID          := rt.Debt_ActUCC_Docs_SeleID                 ;
								self.BusinessIds.OrgID           := rt.Debt_ActUCC_Docs_OrgID                  ;
								self.BusinessIds.UltID           := rt.Debt_ActUCC_Docs_UltID                  ;
								self.IdType                      := rt.Debt_ActUCC_Docs_IdType                 ;
								self.IdValue                     := rt.Debt_ActUCC_Docs_IdValue                ;
								self.Section                     := rt.Debt_ActUCC_Docs_Section                ;
								self.Source                      := rt.Debt_ActUCC_Docs_Source                 ;
								self.Address.StreetNumber        := rt.Debt_ActUCC_Docs_StreetNumber           ;
								self.Address.StreetPreDirection  := rt.Debt_ActUCC_Docs_StreetPreDirection     ;
								self.Address.StreetName          := rt.Debt_ActUCC_Docs_StreetName             ;
								self.Address.StreetSuffix        := rt.Debt_ActUCC_Docs_StreetSuffix           ;
								self.Address.StreetPostDirection := rt.Debt_ActUCC_Docs_StreetPostDirection    ;
								self.Address.UnitDesignation     := rt.Debt_ActUCC_Docs_UnitDesignation        ;
								self.Address.UnitNumber          := rt.Debt_ActUCC_Docs_UnitNumber             ;
								self.Address.StreetAddress1      := rt.Debt_ActUCC_Docs_StreetAddress1         ;
								self.Address.StreetAddress2      := rt.Debt_ActUCC_Docs_StreetAddress2         ;
								self.Address.City                := rt.Debt_ActUCC_Docs_City                   ;
								self.Address.State               := rt.Debt_ActUCC_Docs_State                  ;
								self.Address.Zip5                := rt.Debt_ActUCC_Docs_Zip5                   ;
								self.Address.Zip4                := rt.Debt_ActUCC_Docs_Zip4                   ;
								self.Address.County              := rt.Debt_ActUCC_Docs_County                 ;
								self.Address.PostalCode          := rt.Debt_ActUCC_Docs_PostalCode             ;
								self.Address.StateCityZip        := rt.Debt_ActUCC_Docs_StateCityZip           ;
								self.Name.Full                   := rt.Debt_ActUCC_Docs_Full                   ;
								self.Name.First                  := rt.Debt_ActUCC_Docs_First                  ;
								self.Name.Middle                 := rt.Debt_ActUCC_Docs_Middle                 ;
								self.Name.Last                   := rt.Debt_ActUCC_Docs_Last                   ;
								self.Name.Suffix                 := rt.Debt_ActUCC_Docs_Suffix                 ;
								self.Name.Prefix                 := rt.Debt_ActUCC_Docs_Prefix                 ;
								self.Name.CompanyName            := rt.Debt_ActUCC_Docs_CompanyName            ;
						));
				));
				self.AsDebtor.ActiveSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID           := rt.Debt_ActUCC_ActDocs_DotID               ;
						self.BusinessIds.EmpID           := rt.Debt_ActUCC_ActDocs_EmpID               ;
						self.BusinessIds.POWID           := rt.Debt_ActUCC_ActDocs_POWID               ;
						self.BusinessIds.ProxID          := rt.Debt_ActUCC_ActDocs_ProxID              ;
						self.BusinessIds.SeleID          := rt.Debt_ActUCC_ActDocs_SeleID              ;
						self.BusinessIds.OrgID           := rt.Debt_ActUCC_ActDocs_OrgID               ;
						self.BusinessIds.UltID           := rt.Debt_ActUCC_ActDocs_UltID               ;
						self.IdType                      := rt.Debt_ActUCC_ActDocs_IdType              ;
						self.IdValue                     := rt.Debt_ActUCC_ActDocs_IdValue             ;
						self.Section                     := rt.Debt_ActUCC_ActDocs_Section             ;
						self.Source                      := rt.Debt_ActUCC_ActDocs_Source              ;
						self.Address.StreetNumber        := rt.Debt_ActUCC_ActDocs_StreetNumber        ;
						self.Address.StreetPreDirection  := rt.Debt_ActUCC_ActDocs_StreetPreDirection  ;
						self.Address.StreetName          := rt.Debt_ActUCC_ActDocs_StreetName          ;
						self.Address.StreetSuffix        := rt.Debt_ActUCC_ActDocs_StreetSuffix        ;
						self.Address.StreetPostDirection := rt.Debt_ActUCC_ActDocs_StreetPostDirection ;
						self.Address.UnitDesignation     := rt.Debt_ActUCC_ActDocs_UnitDesignation     ;
						self.Address.UnitNumber          := rt.Debt_ActUCC_ActDocs_UnitNumber          ;
						self.Address.StreetAddress1      := rt.Debt_ActUCC_ActDocs_StreetAddress1      ;
						self.Address.StreetAddress2      := rt.Debt_ActUCC_ActDocs_StreetAddress2      ;
						self.Address.City                := rt.Debt_ActUCC_ActDocs_City                ;
						self.Address.State               := rt.Debt_ActUCC_ActDocs_State               ;
						self.Address.Zip5                := rt.Debt_ActUCC_ActDocs_Zip5                ;
						self.Address.Zip4                := rt.Debt_ActUCC_ActDocs_Zip4                ;
						self.Address.County              := rt.Debt_ActUCC_ActDocs_County              ;
						self.Address.PostalCode          := rt.Debt_ActUCC_ActDocs_PostalCode          ;
						self.Address.StateCityZip        := rt.Debt_ActUCC_ActDocs_StateCityZip        ;
						self.Name.Full                   := rt.Debt_ActUCC_ActDocs_Full                ;
						self.Name.First                  := rt.Debt_ActUCC_ActDocs_First               ;
						self.Name.Middle                 := rt.Debt_ActUCC_ActDocs_Middle              ;
						self.Name.Last                   := rt.Debt_ActUCC_ActDocs_Last                ;
						self.Name.Suffix                 := rt.Debt_ActUCC_ActDocs_Suffix              ;
						self.Name.Prefix                 := rt.Debt_ActUCC_ActDocs_Prefix              ;
						self.Name.CompanyName            := rt.Debt_ActUCC_ActDocs_CompanyName         ;
				));
				self.AsDebtor.TerminatedUCCs := 
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCC,
						self.FilingJurisdiction                                   := rt.Debt_TermUCC_FilingJurisdiction         ;
						self.OriginalFilingNumber                                 := rt.Debt_TermUCC_OriginalFilingNumber       ;
						self.OriginalFilingDate.Year                              := rt.Debt_TermUCC_OrigFile_Year              ;
						self.OriginalFilingDate.Month                             := rt.Debt_TermUCC_OrigFile_Month             ;
						self.OriginalFilingDate.Day                               := rt.Debt_TermUCC_OrigFile_Day               ;
						self.LatestFilingType                                     := rt.Debt_TermUCC_LatestFilingType           ;
						self.FilingAgencyName                                     := rt.Debt_TermUCC_FilingAgencyName           ;
						self.FilingAgencyAddress.StreetNumber                     := rt.Debt_TermUCC_StreetNumber               ;
						self.FilingAgencyAddress.StreetPreDirection               := rt.Debt_TermUCC_StreetPreDirection         ;
						self.FilingAgencyAddress.StreetName                       := rt.Debt_TermUCC_StreetName                 ;
						self.FilingAgencyAddress.StreetSuffix                     := rt.Debt_TermUCC_StreetSuffix               ;
						self.FilingAgencyAddress.StreetPostDirection              := rt.Debt_TermUCC_StreetPostDirection        ;
						self.FilingAgencyAddress.UnitDesignation                  := rt.Debt_TermUCC_UnitDesignation            ;
						self.FilingAgencyAddress.UnitNumber                       := rt.Debt_TermUCC_UnitNumber                 ;
						self.FilingAgencyAddress.StreetAddress1                   := rt.Debt_TermUCC_StreetAddress1             ;
						self.FilingAgencyAddress.StreetAddress2                   := rt.Debt_TermUCC_StreetAddress2             ;
						self.FilingAgencyAddress.City                             := rt.Debt_TermUCC_City                       ;
						self.FilingAgencyAddress.State                            := rt.Debt_TermUCC_State                      ;
						self.FilingAgencyAddress.Zip5                             := rt.Debt_TermUCC_Zip5                       ;
						self.FilingAgencyAddress.Zip4                             := rt.Debt_TermUCC_Zip4                       ;
						self.FilingAgencyAddress.County                           := rt.Debt_TermUCC_County                     ;
						self.FilingAgencyAddress.PostalCode                       := rt.Debt_TermUCC_PostalCode                 ;
						self.FilingAgencyAddress.StateCityZip                     := rt.Debt_TermUCC_StateCityZip               ;
						self.Filings :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCFiling,
								self.FilingNumber                              := rt.Debt_TermUCC_FilingNumber               ;
								self.FilingDate.Year                           := rt.Debt_TermUCC_File_Year                  ;
								self.FilingDate.Month                          := rt.Debt_TermUCC_File_Month                 ;
								self.FilingDate.Day                            := rt.Debt_TermUCC_File_Day                   ;
								self.FilingType                                := rt.Debt_TermUCC_FilingType                 ;
								self.ExpirationDate.Year                       := rt.Debt_TermUCC_Exp_Year                   ;
								self.ExpirationDate.Month                      := rt.Debt_TermUCC_Exp_Month                  ;
								self.ExpirationDate.Day                        := rt.Debt_TermUCC_Exp_Day                    ;
								self.Debtors :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCParty,
										self.OriginalName                   := rt.Debt_TermUCC_Debt_OriginalName          ;
										self.CompanyName                    := rt.Debt_TermUCC_Debt_CompanyName           ;
										self.TaxId                          := rt.Debt_TermUCC_Debt_TaxId                 ;
										self.SSN                            := rt.Debt_TermUCC_Debt_SSN                   ;
										self.Name.Full                      := rt.Debt_TermUCC_Debt_Full                  ;
										self.Name.First                     := rt.Debt_TermUCC_Debt_First                 ;
										self.Name.Middle                    := rt.Debt_TermUCC_Debt_Middle                ;
										self.Name.Last                      := rt.Debt_TermUCC_Debt_Last                  ;
										self.Name.Suffix                    := rt.Debt_TermUCC_Debt_Suffix                ;
										self.Name.Prefix                    := rt.Debt_TermUCC_Debt_Prefix                ;
										self.Address.StreetNumber           := rt.Debt_TermUCC_Debt_StreetNumber          ;
										self.Address.StreetPreDirection     := rt.Debt_TermUCC_Debt_StreetPreDirection    ;
										self.Address.StreetName             := rt.Debt_TermUCC_Debt_StreetName            ;
										self.Address.StreetSuffix           := rt.Debt_TermUCC_Debt_StreetSuffix          ;
										self.Address.StreetPostDirection    := rt.Debt_TermUCC_Debt_StreetPostDirection   ;
										self.Address.UnitDesignation        := rt.Debt_TermUCC_Debt_UnitDesignation       ;
										self.Address.UnitNumber             := rt.Debt_TermUCC_Debt_UnitNumber            ;
										self.Address.StreetAddress1         := rt.Debt_TermUCC_Debt_StreetAddress1        ;
										self.Address.StreetAddress2         := rt.Debt_TermUCC_Debt_StreetAddress2        ;
										self.Address.City                   := rt.Debt_TermUCC_Debt_City                  ;
										self.Address.State                  := rt.Debt_TermUCC_Debt_State                 ;
										self.Address.Zip5                   := rt.Debt_TermUCC_Debt_Zip5                  ;
										self.Address.Zip4                   := rt.Debt_TermUCC_Debt_Zip4                  ;
										self.Address.County                 := rt.Debt_TermUCC_Debt_County                ;
										self.Address.PostalCode             := rt.Debt_TermUCC_Debt_PostalCode            ;
										self.Address.StateCityZip           := rt.Debt_TermUCC_Debt_StateCityZip          ;
								));
								self.Secureds :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCParty,
										self.OriginalName                  := rt.Debt_TermUCC_Sec_OriginalName           ;
										self.CompanyName                   := rt.Debt_TermUCC_Sec_CompanyName            ;
										self.TaxId                         := rt.Debt_TermUCC_Sec_TaxId                  ;
										self.SSN                           := rt.Debt_TermUCC_Sec_SSN                    ;
										self.Name.Full                     := rt.Debt_TermUCC_Sec_Full                   ;
										self.Name.First                    := rt.Debt_TermUCC_Sec_First                  ;
										self.Name.Middle                   := rt.Debt_TermUCC_Sec_Middle                 ;
										self.Name.Last                     := rt.Debt_TermUCC_Sec_Last                   ;
										self.Name.Suffix                   := rt.Debt_TermUCC_Sec_Suffix                 ;
										self.Name.Prefix                   := rt.Debt_TermUCC_Sec_Prefix                 ;
										self.Address.StreetNumber          := rt.Debt_TermUCC_Sec_StreetNumber           ;
										self.Address.StreetPreDirection    := rt.Debt_TermUCC_Sec_StreetPreDirection     ;
										self.Address.StreetName            := rt.Debt_TermUCC_Sec_StreetName             ;
										self.Address.StreetSuffix          := rt.Debt_TermUCC_Sec_StreetSuffix           ;
										self.Address.StreetPostDirection   := rt.Debt_TermUCC_Sec_StreetPostDirection    ;
										self.Address.UnitDesignation       := rt.Debt_TermUCC_Sec_UnitDesignation        ;
										self.Address.UnitNumber            := rt.Debt_TermUCC_Sec_UnitNumber             ;
										self.Address.StreetAddress1        := rt.Debt_TermUCC_Sec_StreetAddress1         ;
										self.Address.StreetAddress2        := rt.Debt_TermUCC_Sec_StreetAddress2         ;
										self.Address.City                  := rt.Debt_TermUCC_Sec_City                   ;
										self.Address.State                 := rt.Debt_TermUCC_Sec_State                  ;
										self.Address.Zip5                  := rt.Debt_TermUCC_Sec_Zip5                   ;
										self.Address.Zip4                  := rt.Debt_TermUCC_Sec_Zip4                   ;
										self.Address.County                := rt.Debt_TermUCC_Sec_County                 ;
										self.Address.PostalCode            := rt.Debt_TermUCC_Sec_PostalCode             ;
										self.Address.StateCityZip          := rt.Debt_TermUCC_Sec_StateCityZip           ;
								));
								self.Assignees :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCParty,
										self.OriginalName                 := rt.Debt_TermUCC_Assign_OriginalName        ;
										self.CompanyName                  := rt.Debt_TermUCC_Assign_CompanyName         ;
										self.TaxId                        := rt.Debt_TermUCC_Assign_TaxId               ;
										self.SSN                          := rt.Debt_TermUCC_Assign_SSN                 ;
										self.Name.Full                    := rt.Debt_TermUCC_Assign_Full                ;
										self.Name.First                   := rt.Debt_TermUCC_Assign_First               ;
										self.Name.Middle                  := rt.Debt_TermUCC_Assign_Middle              ;
										self.Name.Last                    := rt.Debt_TermUCC_Assign_Last                ;
										self.Name.Suffix                  := rt.Debt_TermUCC_Assign_Suffix              ;
										self.Name.Prefix                  := rt.Debt_TermUCC_Assign_Prefix              ;
										self.Address.StreetNumber         := rt.Debt_TermUCC_Assign_StreetNumber        ;
										self.Address.StreetPreDirection   := rt.Debt_TermUCC_Assign_StreetPreDirection  ;
										self.Address.StreetName           := rt.Debt_TermUCC_Assign_StreetName          ;
										self.Address.StreetSuffix         := rt.Debt_TermUCC_Assign_StreetSuffix        ;
										self.Address.StreetPostDirection  := rt.Debt_TermUCC_Assign_StreetPostDirection ;
										self.Address.UnitDesignation      := rt.Debt_TermUCC_Assign_UnitDesignation     ;
										self.Address.UnitNumber           := rt.Debt_TermUCC_Assign_UnitNumber          ;
										self.Address.StreetAddress1       := rt.Debt_TermUCC_Assign_StreetAddress1      ;
										self.Address.StreetAddress2       := rt.Debt_TermUCC_Assign_StreetAddress2      ;
										self.Address.City                 := rt.Debt_TermUCC_Assign_City                ;
										self.Address.State                := rt.Debt_TermUCC_Assign_State               ;
										self.Address.Zip5                 := rt.Debt_TermUCC_Assign_Zip5                ;
										self.Address.Zip4                 := rt.Debt_TermUCC_Assign_Zip4                ;
										self.Address.County               := rt.Debt_TermUCC_Assign_County              ;
										self.Address.PostalCode           := rt.Debt_TermUCC_Assign_PostalCode          ;
										self.Address.StateCityZip         := rt.Debt_TermUCC_Assign_StateCityZip        ;
								));
								self.Collaterals :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCCollateral,
										self.FilingNumber               := rt.Debt_TermUCC_Col_FilingNumber           ;
										self.FilingDate.Year            := rt.Debt_TermUCC_Col_File_Year              ;
										self.FilingDate.Month           := rt.Debt_TermUCC_Col_File_Month             ;
										self.FilingDate.Day             := rt.Debt_TermUCC_Col_File_Day               ;
										self.CollateralSequence         := rt.Debt_TermUCC_Col_CollateralSequence     ;
										self.CollateralDescription      := rt.Debt_TermUCC_Col_CollateralDescription  ;
								));
						));
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID                      := rt.Debt_TermUCC_Docs_DotID                 ;
								self.BusinessIds.EmpID                      := rt.Debt_TermUCC_Docs_EmpID                 ;
								self.BusinessIds.POWID                      := rt.Debt_TermUCC_Docs_POWID                 ;
								self.BusinessIds.ProxID                     := rt.Debt_TermUCC_Docs_ProxID                ;
								self.BusinessIds.SeleID                     := rt.Debt_TermUCC_Docs_SeleID                ;
								self.BusinessIds.OrgID                      := rt.Debt_TermUCC_Docs_OrgID                 ;
								self.BusinessIds.UltID                      := rt.Debt_TermUCC_Docs_UltID                 ;
								self.IdType                                 := rt.Debt_TermUCC_Docs_IdType                ;
								self.IdValue                                := rt.Debt_TermUCC_Docs_IdValue               ;
								self.Section                                := rt.Debt_TermUCC_Docs_Section               ;
								self.Source                                 := rt.Debt_TermUCC_Docs_Source                ;
								self.Address.StreetNumber                   := rt.Debt_TermUCC_Docs_StreetNumber          ;
								self.Address.StreetPreDirection             := rt.Debt_TermUCC_Docs_StreetPreDirection    ;
								self.Address.StreetName                     := rt.Debt_TermUCC_Docs_StreetName            ;
								self.Address.StreetSuffix                   := rt.Debt_TermUCC_Docs_StreetSuffix          ;
								self.Address.StreetPostDirection            := rt.Debt_TermUCC_Docs_StreetPostDirection   ;
								self.Address.UnitDesignation                := rt.Debt_TermUCC_Docs_UnitDesignation       ;
								self.Address.UnitNumber                     := rt.Debt_TermUCC_Docs_UnitNumber            ;
								self.Address.StreetAddress1                 := rt.Debt_TermUCC_Docs_StreetAddress1        ;
								self.Address.StreetAddress2                 := rt.Debt_TermUCC_Docs_StreetAddress2        ;
								self.Address.City                           := rt.Debt_TermUCC_Docs_City                  ;
								self.Address.State                          := rt.Debt_TermUCC_Docs_State                 ;
								self.Address.Zip5                           := rt.Debt_TermUCC_Docs_Zip5                  ;
								self.Address.Zip4                           := rt.Debt_TermUCC_Docs_Zip4                  ;
								self.Address.County                         := rt.Debt_TermUCC_Docs_County                ;
								self.Address.PostalCode                     := rt.Debt_TermUCC_Docs_PostalCode            ;
								self.Address.StateCityZip                   := rt.Debt_TermUCC_Docs_StateCityZip          ;
								self.Name.Full                              := rt.Debt_TermUCC_Docs_Full                  ;
								self.Name.First                             := rt.Debt_TermUCC_Docs_First                 ;
								self.Name.Middle                            := rt.Debt_TermUCC_Docs_Middle                ;
								self.Name.Last                              := rt.Debt_TermUCC_Docs_Last                  ;
								self.Name.Suffix                            := rt.Debt_TermUCC_Docs_Suffix                ;
								self.Name.Prefix                            := rt.Debt_TermUCC_Docs_Prefix                ;
								self.Name.CompanyName                       := rt.Debt_TermUCC_Docs_CompanyName           ;
						));
				));
				self.AsDebtor.TerminatedSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID                              := rt.Debt_TermDocs_DotID                     ;
						self.BusinessIds.EmpID                              := rt.Debt_TermDocs_EmpID                     ;
						self.BusinessIds.POWID                              := rt.Debt_TermDocs_POWID                     ;
						self.BusinessIds.ProxID                             := rt.Debt_TermDocs_ProxID                    ;
						self.BusinessIds.SeleID                             := rt.Debt_TermDocs_SeleID                    ;
						self.BusinessIds.OrgID                              := rt.Debt_TermDocs_OrgID                     ;
						self.BusinessIds.UltID                              := rt.Debt_TermDocs_UltID                     ;
						self.IdType                                         := rt.Debt_TermDocs_IdType                    ;
						self.IdValue                                        := rt.Debt_TermDocs_IdValue                   ;
						self.Section                                        := rt.Debt_TermDocs_Section                   ;
						self.Source                                         := rt.Debt_TermDocs_Source                    ;
						self.Address.StreetNumber                           := rt.Debt_TermDocs_StreetNumber              ;
						self.Address.StreetPreDirection                     := rt.Debt_TermDocs_StreetPreDirection        ;
						self.Address.StreetName                             := rt.Debt_TermDocs_StreetName                ;
						self.Address.StreetSuffix                           := rt.Debt_TermDocs_StreetSuffix              ;
						self.Address.StreetPostDirection                    := rt.Debt_TermDocs_StreetPostDirection       ;
						self.Address.UnitDesignation                        := rt.Debt_TermDocs_UnitDesignation           ;
						self.Address.UnitNumber                             := rt.Debt_TermDocs_UnitNumber                ;
						self.Address.StreetAddress1                         := rt.Debt_TermDocs_StreetAddress1            ;
						self.Address.StreetAddress2                         := rt.Debt_TermDocs_StreetAddress2            ;
						self.Address.City                                   := rt.Debt_TermDocs_City                      ;
						self.Address.State                                  := rt.Debt_TermDocs_State                     ;
						self.Address.Zip5                                   := rt.Debt_TermDocs_Zip5                      ;
						self.Address.Zip4                                   := rt.Debt_TermDocs_Zip4                      ;
						self.Address.County                                 := rt.Debt_TermDocs_County                    ;
						self.Address.PostalCode                             := rt.Debt_TermDocs_PostalCode                ;
						self.Address.StateCityZip                           := rt.Debt_TermDocs_StateCityZip              ;
						self.Name.Full                                      := rt.Debt_TermDocs_Full                      ;
						self.Name.First                                     := rt.Debt_TermDocs_First                     ;
						self.Name.Middle                                    := rt.Debt_TermDocs_Middle                    ;
						self.Name.Last                                      := rt.Debt_TermDocs_Last                      ;
						self.Name.Suffix                                    := rt.Debt_TermDocs_Suffix                    ;
						self.Name.Prefix                                    := rt.Debt_TermDocs_Prefix                    ;
						self.Name.CompanyName                               := rt.Debt_TermDocs_CompanyName               ;
				));
				self.AsSecured.ActiveUCCs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCC,
						self.FilingJurisdiction                                       := rt.Sec_ActUCC_FilingJurisdiction          ;
						self.OriginalFilingNumber                                     := rt.Sec_ActUCC_OriginalFilingNumber        ;
						self.OriginalFilingDate.Year                                  := rt.Sec_ActUCC_Orig_Year                   ;
						self.OriginalFilingDate.Month                                 := rt.Sec_ActUCC_Orig_Month                  ;
						self.OriginalFilingDate.Day                                   := rt.Sec_ActUCC_Orig_Day                    ;
						self.LatestFilingType                                         := rt.Sec_ActUCC_LatestFilingType            ;
						self.FilingAgencyName                                         := rt.Sec_ActUCC_FilingAgencyName            ;
						self.FilingAgencyAddress.StreetNumber                         := rt.Sec_ActUCC_StreetNumber                ;
						self.FilingAgencyAddress.StreetPreDirection                   := rt.Sec_ActUCC_StreetPreDirection          ;
						self.FilingAgencyAddress.StreetName                           := rt.Sec_ActUCC_StreetName                  ;
						self.FilingAgencyAddress.StreetSuffix                         := rt.Sec_ActUCC_StreetSuffix                ;
						self.FilingAgencyAddress.StreetPostDirection                  := rt.Sec_ActUCC_StreetPostDirection         ;
						self.FilingAgencyAddress.UnitDesignation                      := rt.Sec_ActUCC_UnitDesignation             ;
						self.FilingAgencyAddress.UnitNumber                           := rt.Sec_ActUCC_UnitNumber                  ;
						self.FilingAgencyAddress.StreetAddress1                       := rt.Sec_ActUCC_StreetAddress1              ;
						self.FilingAgencyAddress.StreetAddress2                       := rt.Sec_ActUCC_StreetAddress2              ;
						self.FilingAgencyAddress.City                                 := rt.Sec_ActUCC_City                        ;
						self.FilingAgencyAddress.State                                := rt.Sec_ActUCC_State                       ;
						self.FilingAgencyAddress.Zip5                                 := rt.Sec_ActUCC_Zip5                        ;
						self.FilingAgencyAddress.Zip4                                 := rt.Sec_ActUCC_Zip4                        ;
						self.FilingAgencyAddress.County                               := rt.Sec_ActUCC_County                      ;
						self.FilingAgencyAddress.PostalCode                           := rt.Sec_ActUCC_PostalCode                  ;
						self.FilingAgencyAddress.StateCityZip                         := rt.Sec_ActUCC_StateCityZip                ;
						self.Filings := 
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCFiling,
								self.FilingNumber                                  := rt.Sec_ActUCC_FilingNumber                ;
								self.FilingDate.Year                               := rt.Sec_ActUCC_File_Year                   ;
								self.FilingDate.Month                              := rt.Sec_ActUCC_File_Month                  ;
								self.FilingDate.Day                                := rt.Sec_ActUCC_File_Day                    ;
								self.FilingType                                    := rt.Sec_ActUCC_FilingType                  ;
								self.ExpirationDate.Year                           := rt.Sec_ActUCC_Exp_Year                    ;
								self.ExpirationDate.Month                          := rt.Sec_ActUCC_Exp_Month                   ;
								self.ExpirationDate.Day                            := rt.Sec_ActUCC_Exp_Day                     ;
								self.Debtors := 
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCParty,
										self.OriginalName                       := rt.Sec_ActUCC_Debt_OriginalName           ;
										self.CompanyName                        := rt.Sec_ActUCC_Debt_CompanyName            ;
										self.TaxId                              := rt.Sec_ActUCC_Debt_TaxId                  ;
										self.SSN                                := rt.Sec_ActUCC_Debt_SSN                    ;
										self.Name.Full                          := rt.Sec_ActUCC_Debt_Full                   ;
										self.Name.First                         := rt.Sec_ActUCC_Debt_First                  ;
										self.Name.Middle                        := rt.Sec_ActUCC_Debt_Middle                 ;
										self.Name.Last                          := rt.Sec_ActUCC_Debt_Last                   ;
										self.Name.Suffix                        := rt.Sec_ActUCC_Debt_Suffix                 ;
										self.Name.Prefix                        := rt.Sec_ActUCC_Debt_Prefix                 ;
										self.Address.StreetNumber               := rt.Sec_ActUCC_Debt_StreetNumber           ;
										self.Address.StreetPreDirection         := rt.Sec_ActUCC_Debt_StreetPreDirection     ;
										self.Address.StreetName                 := rt.Sec_ActUCC_Debt_StreetName             ;
										self.Address.StreetSuffix               := rt.Sec_ActUCC_Debt_StreetSuffix           ;
										self.Address.StreetPostDirection        := rt.Sec_ActUCC_Debt_StreetPostDirection    ;
										self.Address.UnitDesignation            := rt.Sec_ActUCC_Debt_UnitDesignation        ;
										self.Address.UnitNumber                 := rt.Sec_ActUCC_Debt_UnitNumber             ;
										self.Address.StreetAddress1             := rt.Sec_ActUCC_Debt_StreetAddress1         ;
										self.Address.StreetAddress2             := rt.Sec_ActUCC_Debt_StreetAddress2         ;
										self.Address.City                       := rt.Sec_ActUCC_Debt_City                   ;
										self.Address.State                      := rt.Sec_ActUCC_Debt_State                  ;
										self.Address.Zip5                       := rt.Sec_ActUCC_Debt_Zip5                   ;
										self.Address.Zip4                       := rt.Sec_ActUCC_Debt_Zip4                   ;
										self.Address.County                     := rt.Sec_ActUCC_Debt_County                 ;
										self.Address.PostalCode                 := rt.Sec_ActUCC_Debt_PostalCode             ;
										self.Address.StateCityZip               := rt.Sec_ActUCC_Debt_StateCityZip           ;
								));
								self.Secureds := 
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCParty,
										self.OriginalName                      := rt.Sec_ActUCC_Sec_OriginalName            ;
										self.CompanyName                       := rt.Sec_ActUCC_Sec_CompanyName             ;
										self.TaxId                             := rt.Sec_ActUCC_Sec_TaxId                   ;
										self.SSN                               := rt.Sec_ActUCC_Sec_SSN                     ;
										self.Name.Full                         := rt.Sec_ActUCC_Sec_Full                    ;
										self.Name.First                        := rt.Sec_ActUCC_Sec_First                   ;
										self.Name.Middle                       := rt.Sec_ActUCC_Sec_Middle                  ;
										self.Name.Last                         := rt.Sec_ActUCC_Sec_Last                    ;
										self.Name.Suffix                       := rt.Sec_ActUCC_Sec_Suffix                  ;
										self.Name.Prefix                       := rt.Sec_ActUCC_Sec_Prefix                  ;
										self.Address.StreetNumber              := rt.Sec_ActUCC_Sec_StreetNumber            ;
										self.Address.StreetPreDirection        := rt.Sec_ActUCC_Sec_StreetPreDirection      ;
										self.Address.StreetName                := rt.Sec_ActUCC_Sec_StreetName              ;
										self.Address.StreetSuffix              := rt.Sec_ActUCC_Sec_StreetSuffix            ;
										self.Address.StreetPostDirection       := rt.Sec_ActUCC_Sec_StreetPostDirection     ;
										self.Address.UnitDesignation           := rt.Sec_ActUCC_Sec_UnitDesignation         ;
										self.Address.UnitNumber                := rt.Sec_ActUCC_Sec_UnitNumber              ;
										self.Address.StreetAddress1            := rt.Sec_ActUCC_Sec_StreetAddress1          ;
										self.Address.StreetAddress2            := rt.Sec_ActUCC_Sec_StreetAddress2          ;
										self.Address.City                      := rt.Sec_ActUCC_Sec_City                    ;
										self.Address.State                     := rt.Sec_ActUCC_Sec_State                   ;
										self.Address.Zip5                      := rt.Sec_ActUCC_Sec_Zip5                    ;
										self.Address.Zip4                      := rt.Sec_ActUCC_Sec_Zip4                    ;
										self.Address.County                    := rt.Sec_ActUCC_Sec_County                  ;
										self.Address.PostalCode                := rt.Sec_ActUCC_Sec_PostalCode              ;
										self.Address.StateCityZip              := rt.Sec_ActUCC_Sec_StateCityZip            ;
								));
								self.Assignees :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCParty,
										self.OriginalName                     := rt.Sec_ActUCC_Assign_OriginalName         ;
										self.CompanyName                      := rt.Sec_ActUCC_Assign_CompanyName          ;
										self.TaxId                            := rt.Sec_ActUCC_Assign_TaxId                ;
										self.SSN                              := rt.Sec_ActUCC_Assign_SSN                  ;
										self.Name.Full                        := rt.Sec_ActUCC_Assign_Full                 ;
										self.Name.First                       := rt.Sec_ActUCC_Assign_First                ;
										self.Name.Middle                      := rt.Sec_ActUCC_Assign_Middle               ;
										self.Name.Last                        := rt.Sec_ActUCC_Assign_Last                 ;
										self.Name.Suffix                      := rt.Sec_ActUCC_Assign_Suffix               ;
										self.Name.Prefix                      := rt.Sec_ActUCC_Assign_Prefix               ;
										self.Address.StreetNumber             := rt.Sec_ActUCC_Assign_StreetNumber         ;
										self.Address.StreetPreDirection       := rt.Sec_ActUCC_Assign_StreetPreDirection   ;
										self.Address.StreetName               := rt.Sec_ActUCC_Assign_StreetName           ;
										self.Address.StreetSuffix             := rt.Sec_ActUCC_Assign_StreetSuffix         ;
										self.Address.StreetPostDirection      := rt.Sec_ActUCC_Assign_StreetPostDirection  ;
										self.Address.UnitDesignation          := rt.Sec_ActUCC_Assign_UnitDesignation      ;
										self.Address.UnitNumber               := rt.Sec_ActUCC_Assign_UnitNumber           ;
										self.Address.StreetAddress1           := rt.Sec_ActUCC_Assign_StreetAddress1       ;
										self.Address.StreetAddress2           := rt.Sec_ActUCC_Assign_StreetAddress2       ;
										self.Address.City                     := rt.Sec_ActUCC_Assign_City                 ;
										self.Address.State                    := rt.Sec_ActUCC_Assign_State                ;
										self.Address.Zip5                     := rt.Sec_ActUCC_Assign_Zip5                 ;
										self.Address.Zip4                     := rt.Sec_ActUCC_Assign_Zip4                 ;
										self.Address.County                   := rt.Sec_ActUCC_Assign_County               ;
										self.Address.PostalCode               := rt.Sec_ActUCC_Assign_PostalCode           ;
										self.Address.StateCityZip             := rt.Sec_ActUCC_Assign_StateCityZip         ;
								));
								self.Collaterals :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCCollateral,
										self.FilingNumber                   := rt.Sec_ActUCC_Col_FilingNumber            ;
										self.FilingDate.Year                := rt.Sec_ActUCC_Col_File_Year               ;
										self.FilingDate.Month               := rt.Sec_ActUCC_Col_File_Month              ;
										self.FilingDate.Day                 := rt.Sec_ActUCC_Col_File_Day                ;
										self.CollateralSequence             := rt.Sec_ActUCC_CollateralSequence          ;
										self.CollateralDescription          := rt.Sec_ActUCC_CollateralDescription       ;
								));
						));
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID           := rt.Sec_ActUCC_Docs_DotID                  ;
								self.BusinessIds.EmpID           := rt.Sec_ActUCC_Docs_EmpID                  ;
								self.BusinessIds.POWID           := rt.Sec_ActUCC_Docs_POWID                  ;
								self.BusinessIds.ProxID          := rt.Sec_ActUCC_Docs_ProxID                 ;
								self.BusinessIds.SeleID          := rt.Sec_ActUCC_Docs_SeleID                 ;
								self.BusinessIds.OrgID           := rt.Sec_ActUCC_Docs_OrgID                  ;
								self.BusinessIds.UltID           := rt.Sec_ActUCC_Docs_UltID                  ;
								self.IdType                      := rt.Sec_ActUCC_Docs_IdType                 ;
								self.IdValue                     := rt.Sec_ActUCC_Docs_IdValue                ;
								self.Section                     := rt.Sec_ActUCC_Docs_Section                ;
								self.Source                      := rt.Sec_ActUCC_Docs_Source                 ;
								self.Address.StreetNumber        := rt.Sec_ActUCC_Docs_StreetNumber           ;
								self.Address.StreetPreDirection  := rt.Sec_ActUCC_Docs_StreetPreDirection     ;
								self.Address.StreetName          := rt.Sec_ActUCC_Docs_StreetName             ;
								self.Address.StreetSuffix        := rt.Sec_ActUCC_Docs_StreetSuffix           ;
								self.Address.StreetPostDirection := rt.Sec_ActUCC_Docs_StreetPostDirection    ;
								self.Address.UnitDesignation     := rt.Sec_ActUCC_Docs_UnitDesignation        ;
								self.Address.UnitNumber          := rt.Sec_ActUCC_Docs_UnitNumber             ;
								self.Address.StreetAddress1      := rt.Sec_ActUCC_Docs_StreetAddress1         ;
								self.Address.StreetAddress2      := rt.Sec_ActUCC_Docs_StreetAddress2         ;
								self.Address.City                := rt.Sec_ActUCC_Docs_City                   ;
								self.Address.State               := rt.Sec_ActUCC_Docs_State                  ;
								self.Address.Zip5                := rt.Sec_ActUCC_Docs_Zip5                   ;
								self.Address.Zip4                := rt.Sec_ActUCC_Docs_Zip4                   ;
								self.Address.County              := rt.Sec_ActUCC_Docs_County                 ;
								self.Address.PostalCode          := rt.Sec_ActUCC_Docs_PostalCode             ;
								self.Address.StateCityZip        := rt.Sec_ActUCC_Docs_StateCityZip           ;
								self.Name.Full                   := rt.Sec_ActUCC_Docs_Full                   ;
								self.Name.First                  := rt.Sec_ActUCC_Docs_First                  ;
								self.Name.Middle                 := rt.Sec_ActUCC_Docs_Middle                 ;
								self.Name.Last                   := rt.Sec_ActUCC_Docs_Last                   ;
								self.Name.Suffix                 := rt.Sec_ActUCC_Docs_Suffix                 ;
								self.Name.Prefix                 := rt.Sec_ActUCC_Docs_Prefix                 ;
								self.Name.CompanyName            := rt.Sec_ActUCC_Docs_CompanyName            ;
						));
				));
				self.AsSecured.ActiveSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID           := rt.Sec_ActDocs_DotID               ;
						self.BusinessIds.EmpID           := rt.Sec_ActDocs_EmpID               ;
						self.BusinessIds.POWID           := rt.Sec_ActDocs_POWID               ;
						self.BusinessIds.ProxID          := rt.Sec_ActDocs_ProxID              ;
						self.BusinessIds.SeleID          := rt.Sec_ActDocs_SeleID              ;
						self.BusinessIds.OrgID           := rt.Sec_ActDocs_OrgID               ;
						self.BusinessIds.UltID           := rt.Sec_ActDocs_UltID               ;
						self.IdType                      := rt.Sec_ActDocs_IdType              ;
						self.IdValue                     := rt.Sec_ActDocs_IdValue             ;
						self.Section                     := rt.Sec_ActDocs_Section             ;
						self.Source                      := rt.Sec_ActDocs_Source              ;
						self.Address.StreetNumber        := rt.Sec_ActDocs_StreetNumber        ;
						self.Address.StreetPreDirection  := rt.Sec_ActDocs_StreetPreDirection  ;
						self.Address.StreetName          := rt.Sec_ActDocs_StreetName          ;
						self.Address.StreetSuffix        := rt.Sec_ActDocs_StreetSuffix        ;
						self.Address.StreetPostDirection := rt.Sec_ActDocs_StreetPostDirection ;
						self.Address.UnitDesignation     := rt.Sec_ActDocs_UnitDesignation     ;
						self.Address.UnitNumber          := rt.Sec_ActDocs_UnitNumber          ;
						self.Address.StreetAddress1      := rt.Sec_ActDocs_StreetAddress1      ;
						self.Address.StreetAddress2      := rt.Sec_ActDocs_StreetAddress2      ;
						self.Address.City                := rt.Sec_ActDocs_City                ;
						self.Address.State               := rt.Sec_ActDocs_State               ;
						self.Address.Zip5                := rt.Sec_ActDocs_Zip5                ;
						self.Address.Zip4                := rt.Sec_ActDocs_Zip4                ;
						self.Address.County              := rt.Sec_ActDocs_County              ;
						self.Address.PostalCode          := rt.Sec_ActDocs_PostalCode          ;
						self.Address.StateCityZip        := rt.Sec_ActDocs_StateCityZip        ;
						self.Name.Full                   := rt.Sec_ActDocs_Full                ;
						self.Name.First                  := rt.Sec_ActDocs_First               ;
						self.Name.Middle                 := rt.Sec_ActDocs_Middle              ;
						self.Name.Last                   := rt.Sec_ActDocs_Last                ;
						self.Name.Suffix                 := rt.Sec_ActDocs_Suffix              ;
						self.Name.Prefix                 := rt.Sec_ActDocs_Prefix              ;
						self.Name.CompanyName            := rt.Sec_ActDocs_CompanyName         ;
				));
				self.AsSecured.TerminatedUCCs := 
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCC,
						self.FilingJurisdiction                                   := rt.Sec_TermUCC_FilingJurisdiction         ;
						self.OriginalFilingNumber                                 := rt.Sec_TermUCC_OriginalFilingNumber       ;
						self.OriginalFilingDate.Year                              := rt.Sec_TermUCC_Orig_Year                  ;
						self.OriginalFilingDate.Month                             := rt.Sec_TermUCC_Orig_Month                 ;
						self.OriginalFilingDate.Day                               := rt.Sec_TermUCC_Orig_Day                   ;
						self.LatestFilingType                                     := rt.Sec_TermUCC_LatestFilingType           ;
						self.FilingAgencyName                                     := rt.Sec_TermUCC_FilingAgencyName           ;
						self.FilingAgencyAddress.StreetNumber                     := rt.Sec_TermUCC_StreetNumber               ;
						self.FilingAgencyAddress.StreetPreDirection               := rt.Sec_TermUCC_StreetPreDirection         ;
						self.FilingAgencyAddress.StreetName                       := rt.Sec_TermUCC_StreetName                 ;
						self.FilingAgencyAddress.StreetSuffix                     := rt.Sec_TermUCC_StreetSuffix               ;
						self.FilingAgencyAddress.StreetPostDirection              := rt.Sec_TermUCC_StreetPostDirection        ;
						self.FilingAgencyAddress.UnitDesignation                  := rt.Sec_TermUCC_UnitDesignation            ;
						self.FilingAgencyAddress.UnitNumber                       := rt.Sec_TermUCC_UnitNumber                 ;
						self.FilingAgencyAddress.StreetAddress1                   := rt.Sec_TermUCC_StreetAddress1             ;
						self.FilingAgencyAddress.StreetAddress2                   := rt.Sec_TermUCC_StreetAddress2             ;
						self.FilingAgencyAddress.City                             := rt.Sec_TermUCC_City                       ;
						self.FilingAgencyAddress.State                            := rt.Sec_TermUCC_State                      ;
						self.FilingAgencyAddress.Zip5                             := rt.Sec_TermUCC_Zip5                       ;
						self.FilingAgencyAddress.Zip4                             := rt.Sec_TermUCC_Zip4                       ;
						self.FilingAgencyAddress.County                           := rt.Sec_TermUCC_County                     ;
						self.FilingAgencyAddress.PostalCode                       := rt.Sec_TermUCC_PostalCode                 ;
						self.FilingAgencyAddress.StateCityZip                     := rt.Sec_TermUCC_StateCityZip               ;
						self.Filings :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCFiling,
								self.FilingNumber                              := rt.Sec_TermUCC_FilingNumber               ;
								self.FilingDate.Year                           := rt.Sec_TermUCC_File_Year                  ;
								self.FilingDate.Month                          := rt.Sec_TermUCC_File_Month                 ;
								self.FilingDate.Day                            := rt.Sec_TermUCC_File_Day                   ;
								self.FilingType                                := rt.Sec_TermUCC_FilingType                 ;
								self.ExpirationDate.Year                       := rt.Sec_TermUCC_Exp_Year                   ;
								self.ExpirationDate.Month                      := rt.Sec_TermUCC_Exp_Month                  ;
								self.ExpirationDate.Day                        := rt.Sec_TermUCC_Exp_Day                    ;
								self.Debtors :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCParty,
										self.OriginalName                   := rt.Sec_TermUCC_Debt_OriginalName          ;
										self.CompanyName                    := rt.Sec_TermUCC_Debt_CompanyName           ;
										self.TaxId                          := rt.Sec_TermUCC_Debt_TaxId                 ;
										self.SSN                            := rt.Sec_TermUCC_Debt_SSN                   ;
										self.Name.Full                      := rt.Sec_TermUCC_Debt_Full                  ;
										self.Name.First                     := rt.Sec_TermUCC_Debt_First                 ;
										self.Name.Middle                    := rt.Sec_TermUCC_Debt_Middle                ;
										self.Name.Last                      := rt.Sec_TermUCC_Debt_Last                  ;
										self.Name.Suffix                    := rt.Sec_TermUCC_Debt_Suffix                ;
										self.Name.Prefix                    := rt.Sec_TermUCC_Debt_Prefix                ;
										self.Address.StreetNumber           := rt.Sec_TermUCC_Debt_StreetNumber          ;
										self.Address.StreetPreDirection     := rt.Sec_TermUCC_Debt_StreetPreDirection    ;
										self.Address.StreetName             := rt.Sec_TermUCC_Debt_StreetName            ;
										self.Address.StreetSuffix           := rt.Sec_TermUCC_Debt_StreetSuffix          ;
										self.Address.StreetPostDirection    := rt.Sec_TermUCC_Debt_StreetPostDirection   ;
										self.Address.UnitDesignation        := rt.Sec_TermUCC_Debt_UnitDesignation       ;
										self.Address.UnitNumber             := rt.Sec_TermUCC_Debt_UnitNumber            ;
										self.Address.StreetAddress1         := rt.Sec_TermUCC_Debt_StreetAddress1        ;
										self.Address.StreetAddress2         := rt.Sec_TermUCC_Debt_StreetAddress2        ;
										self.Address.City                   := rt.Sec_TermUCC_Debt_City                  ;
										self.Address.State                  := rt.Sec_TermUCC_Debt_State                 ;
										self.Address.Zip5                   := rt.Sec_TermUCC_Debt_Zip5                  ;
										self.Address.Zip4                   := rt.Sec_TermUCC_Debt_Zip4                  ;
										self.Address.County                 := rt.Sec_TermUCC_Debt_County                ;
										self.Address.PostalCode             := rt.Sec_TermUCC_Debt_PostalCode            ;
										self.Address.StateCityZip           := rt.Sec_TermUCC_Debt_StateCityZip          ;
								));
								self.Secureds :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCParty,
										self.OriginalName                  := rt.Sec_TermUCC_Sec_OriginalName           ;
										self.CompanyName                   := rt.Sec_TermUCC_Sec_CompanyName            ;
										self.TaxId                         := rt.Sec_TermUCC_Sec_TaxId                  ;
										self.SSN                           := rt.Sec_TermUCC_Sec_SSN                    ;
										self.Name.Full                     := rt.Sec_TermUCC_Sec_Full                   ;
										self.Name.First                    := rt.Sec_TermUCC_Sec_First                  ;
										self.Name.Middle                   := rt.Sec_TermUCC_Sec_Middle                 ;
										self.Name.Last                     := rt.Sec_TermUCC_Sec_Last                   ;
										self.Name.Suffix                   := rt.Sec_TermUCC_Sec_Suffix                 ;
										self.Name.Prefix                   := rt.Sec_TermUCC_Sec_Prefix                 ;
										self.Address.StreetNumber          := rt.Sec_TermUCC_Sec_StreetNumber           ;
										self.Address.StreetPreDirection    := rt.Sec_TermUCC_Sec_StreetPreDirection     ;
										self.Address.StreetName            := rt.Sec_TermUCC_Sec_StreetName             ;
										self.Address.StreetSuffix          := rt.Sec_TermUCC_Sec_StreetSuffix           ;
										self.Address.StreetPostDirection   := rt.Sec_TermUCC_Sec_StreetPostDirection    ;
										self.Address.UnitDesignation       := rt.Sec_TermUCC_Sec_UnitDesignation        ;
										self.Address.UnitNumber            := rt.Sec_TermUCC_Sec_UnitNumber             ;
										self.Address.StreetAddress1        := rt.Sec_TermUCC_Sec_StreetAddress1         ;
										self.Address.StreetAddress2        := rt.Sec_TermUCC_Sec_StreetAddress2         ;
										self.Address.City                  := rt.Sec_TermUCC_Sec_City                   ;
										self.Address.State                 := rt.Sec_TermUCC_Sec_State                  ;
										self.Address.Zip5                  := rt.Sec_TermUCC_Sec_Zip5                   ;
										self.Address.Zip4                  := rt.Sec_TermUCC_Sec_Zip4                   ;
										self.Address.County                := rt.Sec_TermUCC_Sec_County                 ;
										self.Address.PostalCode            := rt.Sec_TermUCC_Sec_PostalCode             ;
										self.Address.StateCityZip          := rt.Sec_TermUCC_Sec_StateCityZip           ;
								));
								self.Assignees :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCParty,
										self.OriginalName                 := rt.Sec_TermUCC_Assign_OriginalName        ;
										self.CompanyName                  := rt.Sec_TermUCC_Assign_CompanyName         ;
										self.TaxId                        := rt.Sec_TermUCC_Assign_TaxId               ;
										self.SSN                          := rt.Sec_TermUCC_Assign_SSN                 ;
										self.Name.Full                    := rt.Sec_TermUCC_Assign_Full                ;
										self.Name.First                   := rt.Sec_TermUCC_Assign_First               ;
										self.Name.Middle                  := rt.Sec_TermUCC_Assign_Middle              ;
										self.Name.Last                    := rt.Sec_TermUCC_Assign_Last                ;
										self.Name.Suffix                  := rt.Sec_TermUCC_Assign_Suffix              ;
										self.Name.Prefix                  := rt.Sec_TermUCC_Assign_Prefix              ;
										self.Address.StreetNumber         := rt.Sec_TermUCC_Assign_StreetNumber        ;
										self.Address.StreetPreDirection   := rt.Sec_TermUCC_Assign_StreetPreDirection  ;
										self.Address.StreetName           := rt.Sec_TermUCC_Assign_StreetName          ;
										self.Address.StreetSuffix         := rt.Sec_TermUCC_Assign_StreetSuffix        ;
										self.Address.StreetPostDirection  := rt.Sec_TermUCC_Assign_StreetPostDirection ;
										self.Address.UnitDesignation      := rt.Sec_TermUCC_Assign_UnitDesignation     ;
										self.Address.UnitNumber           := rt.Sec_TermUCC_Assign_UnitNumber          ;
										self.Address.StreetAddress1       := rt.Sec_TermUCC_Assign_StreetAddress1      ;
										self.Address.StreetAddress2       := rt.Sec_TermUCC_Assign_StreetAddress2      ;
										self.Address.City                 := rt.Sec_TermUCC_Assign_City                ;
										self.Address.State                := rt.Sec_TermUCC_Assign_State               ;
										self.Address.Zip5                 := rt.Sec_TermUCC_Assign_Zip5                ;
										self.Address.Zip4                 := rt.Sec_TermUCC_Assign_Zip4                ;
										self.Address.County               := rt.Sec_TermUCC_Assign_County              ;
										self.Address.PostalCode           := rt.Sec_TermUCC_Assign_PostalCode          ;
										self.Address.StateCityZip         := rt.Sec_TermUCC_Assign_StateCityZip        ;
								));
								self.Collaterals :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessUCCCollateral,
										self.FilingNumber               := rt.Sec_TermUCC_Col_FilingNumber           ;
										self.FilingDate.Year            := rt.Sec_TermUCC_Col_File_Year              ;
										self.FilingDate.Month           := rt.Sec_TermUCC_Col_File_Month             ;
										self.FilingDate.Day             := rt.Sec_TermUCC_Col_File_Day               ;
										self.CollateralSequence         := rt.Sec_TermUCC_Col_CollateralSequence     ;
										self.CollateralDescription      := rt.Sec_TermUCC_Col_CollateralDescription  ;
								));
						));
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID            := rt.Sec_TermUCC_Docs_DotID                 ;
								self.BusinessIds.EmpID            := rt.Sec_TermUCC_Docs_EmpID                 ;
								self.BusinessIds.POWID            := rt.Sec_TermUCC_Docs_POWID                 ;
								self.BusinessIds.ProxID           := rt.Sec_TermUCC_Docs_ProxID                ;
								self.BusinessIds.SeleID           := rt.Sec_TermUCC_Docs_SeleID                ;
								self.BusinessIds.OrgID            := rt.Sec_TermUCC_Docs_OrgID                 ;
								self.BusinessIds.UltID            := rt.Sec_TermUCC_Docs_UltID                 ;
								self.IdType                       := rt.Sec_TermUCC_Docs_IdType                ;
								self.IdValue                      := rt.Sec_TermUCC_Docs_IdValue               ;
								self.Section                      := rt.Sec_TermUCC_Docs_Section               ;
								self.Source                       := rt.Sec_TermUCC_Docs_Source                ;
								self.Address.StreetNumber         := rt.Sec_TermUCC_Docs_StreetNumber          ;
								self.Address.StreetPreDirection   := rt.Sec_TermUCC_Docs_StreetPreDirection    ;
								self.Address.StreetName           := rt.Sec_TermUCC_Docs_StreetName            ;
								self.Address.StreetSuffix         := rt.Sec_TermUCC_Docs_StreetSuffix          ;
								self.Address.StreetPostDirection  := rt.Sec_TermUCC_Docs_StreetPostDirection   ;
								self.Address.UnitDesignation      := rt.Sec_TermUCC_Docs_UnitDesignation       ;
								self.Address.UnitNumber           := rt.Sec_TermUCC_Docs_UnitNumber            ;
								self.Address.StreetAddress1       := rt.Sec_TermUCC_Docs_StreetAddress1        ;
								self.Address.StreetAddress2       := rt.Sec_TermUCC_Docs_StreetAddress2        ;
								self.Address.City                 := rt.Sec_TermUCC_Docs_City                  ;
								self.Address.State                := rt.Sec_TermUCC_Docs_State                 ;
								self.Address.Zip5                 := rt.Sec_TermUCC_Docs_Zip5                  ;
								self.Address.Zip4                 := rt.Sec_TermUCC_Docs_Zip4                  ;
								self.Address.County               := rt.Sec_TermUCC_Docs_County                ;
								self.Address.PostalCode           := rt.Sec_TermUCC_Docs_PostalCode            ;
								self.Address.StateCityZip         := rt.Sec_TermUCC_Docs_StateCityZip          ;
								self.Name.Full                    := rt.Sec_TermUCC_Docs_Full                  ;
								self.Name.First                   := rt.Sec_TermUCC_Docs_First                 ;
								self.Name.Middle                  := rt.Sec_TermUCC_Docs_Middle                ;
								self.Name.Last                    := rt.Sec_TermUCC_Docs_Last                  ;
								self.Name.Suffix                  := rt.Sec_TermUCC_Docs_Suffix                ;
								self.Name.Prefix                  := rt.Sec_TermUCC_Docs_Prefix                ;
								self.Name.CompanyName             := rt.Sec_TermUCC_Docs_CompanyName           ;
						));
				));
				self.AsSecured.TerminatedSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID           := rt.Sec_TermDocs_DotID                     ;
						self.BusinessIds.EmpID           := rt.Sec_TermDocs_EmpID                     ;
						self.BusinessIds.POWID           := rt.Sec_TermDocs_POWID                     ;
						self.BusinessIds.ProxID          := rt.Sec_TermDocs_ProxID                    ;
						self.BusinessIds.SeleID          := rt.Sec_TermDocs_SeleID                    ;
						self.BusinessIds.OrgID           := rt.Sec_TermDocs_OrgID                     ;
						self.BusinessIds.UltID           := rt.Sec_TermDocs_UltID                     ;
						self.IdType                      := rt.Sec_TermDocs_IdType                    ;
						self.IdValue                     := rt.Sec_TermDocs_IdValue                   ;
						self.Section                     := rt.Sec_TermDocs_Section                   ;
						self.Source                      := rt.Sec_TermDocs_Source                    ;
						self.Address.StreetNumber        := rt.Sec_TermDocs_StreetNumber              ;
						self.Address.StreetPreDirection  := rt.Sec_TermDocs_StreetPreDirection        ;
						self.Address.StreetName          := rt.Sec_TermDocs_StreetName                ;
						self.Address.StreetSuffix        := rt.Sec_TermDocs_StreetSuffix              ;
						self.Address.StreetPostDirection := rt.Sec_TermDocs_StreetPostDirection       ;
						self.Address.UnitDesignation     := rt.Sec_TermDocs_UnitDesignation           ;
						self.Address.UnitNumber          := rt.Sec_TermDocs_UnitNumber                ;
						self.Address.StreetAddress1      := rt.Sec_TermDocs_StreetAddress1            ;
						self.Address.StreetAddress2      := rt.Sec_TermDocs_StreetAddress2            ;
						self.Address.City                := rt.Sec_TermDocs_City                      ;
						self.Address.State               := rt.Sec_TermDocs_State                     ;
						self.Address.Zip5                := rt.Sec_TermDocs_Zip5                      ;
						self.Address.Zip4                := rt.Sec_TermDocs_Zip4                      ;
						self.Address.County              := rt.Sec_TermDocs_County                    ;
						self.Address.PostalCode          := rt.Sec_TermDocs_PostalCode                ;
						self.Address.StateCityZip        := rt.Sec_TermDocs_StateCityZip              ;
						self.Name.Full                   := rt.Sec_TermDocs_Full                      ;
						self.Name.First                  := rt.Sec_TermDocs_First                     ;
						self.Name.Middle                 := rt.Sec_TermDocs_Middle                    ;
						self.Name.Last                   := rt.Sec_TermDocs_Last                      ;
						self.Name.Suffix                 := rt.Sec_TermDocs_Suffix                    ;
						self.Name.Prefix                 := rt.Sec_TermDocs_Prefix                    ;
						self.Name.CompanyName            := rt.Sec_TermDocs_CompanyName               ;
				));
		));
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_UCC := join(CR_Liens, Seed_Files.BusinessCreditReport_keys.TopBusUCC,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_UCC(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_Property (working_layout le, Seed_Files.BusinessCreditReport_keys.TopBusProp rt) := transform
		self.TopBusinessRecord.PropertySection := 
			project(rt, transform(iesp.TopBusinessReport.t_TopBusinessPropertySection,
				self.PropertyRecordCount         := rt.PropertyRecordCount      ;
				self.TotalPropertyRecordCount    := rt.TotalPropertyRecordCount ;
				// self.PropertyRecords := 
					// project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessPropertySummary,
				self.PropertyRecords.CurrentRecordsCount        := rt.Prop_Recs_CurrentRecordsCount      ;
				self.PropertyRecords.TotalCurrentRecordsCount   := rt.Prop_Recs_TotalCurrentRecordsCount ;
				self.PropertyRecords.PriorRecordsCount          := rt.Prop_Recs_PriorRecordsCount        ;
				self.PropertyRecords.TotalPriorRecordsCount     := rt.Prop_Recs_TotalPriorRecordsCount   ;
				self.PropertyRecords.Properties :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessProperty,
						self.PropertyUniqueID                    := rt.Prop_Recs_PropertyUniqueID             ;
						self.SourceObscure                       := rt.Prop_Recs_SourceObscure                ;
						self.PropertyAddress.StreetNumber        := rt.Prop_Recs_PropAddr_StreetNumber        ;
						self.PropertyAddress.StreetPreDirection  := rt.Prop_Recs_PropAddr_StreetPreDirection  ;
						self.PropertyAddress.StreetName          := rt.Prop_Recs_PropAddr_StreetName          ;
						self.PropertyAddress.StreetSuffix        := rt.Prop_Recs_PropAddr_StreetSuffix        ;
						self.PropertyAddress.StreetPostDirection := rt.Prop_Recs_PropAddr_StreetPostDirection ;
						self.PropertyAddress.UnitDesignation     := rt.Prop_Recs_PropAddr_UnitDesignation     ;
						self.PropertyAddress.UnitNumber          := rt.Prop_Recs_PropAddr_UnitNumber          ;
						self.PropertyAddress.StreetAddress1      := rt.Prop_Recs_PropAddr_StreetAddress1      ;
						self.PropertyAddress.StreetAddress2      := rt.Prop_Recs_PropAddr_StreetAddress2      ;
						self.PropertyAddress.City                := rt.Prop_Recs_PropAddr_City                ;
						self.PropertyAddress.State               := rt.Prop_Recs_PropAddr_State               ;
						self.PropertyAddress.Zip5                := rt.Prop_Recs_PropAddr_Zip5                ;
						self.PropertyAddress.Zip4                := rt.Prop_Recs_PropAddr_Zip4                ;
						self.PropertyAddress.County              := rt.Prop_Recs_PropAddr_County              ;
						self.PropertyAddress.PostalCode          := rt.Prop_Recs_PropAddr_PostalCode          ;
						self.PropertyAddress.StateCityZip        := rt.Prop_Recs_PropAddr_StateCityZip        ;
						self.IsNoticeOfDefault                   := rt.Prop_Recs_IsNoticeOfDefault            ;
						self.IsForeclosed                        := rt.Prop_Recs_IsForeclosed                 ;
						self.APN                                 := rt.Prop_Recs_APN                          ;
						self.AddressType                         := rt.Prop_Recs_AddressType                  ;
						self.PurchasePrice                       := rt.Prop_Recs_PurchasePrice                ;
						self.SalesPrice                          := rt.Prop_Recs_SalesPrice                   ;
						self.DocumentType                        := rt.Prop_Recs_DocumentType                 ;
						self.AssessedValue                       := rt.Prop_Recs_AssessedValue                ;
						self.MarketLandValue                     := rt.Prop_Recs_MarketLandValue              ;
						self.TotalMarketValue                    := rt.Prop_Recs_TotalMarketValue             ;
						self.AssessmentDate.Year                 := rt.Prop_Recs_Assess_Year                  ;
						self.AssessmentDate.Month                := rt.Prop_Recs_Assess_Month                 ;
						self.AssessmentDate.Day                  := rt.Prop_Recs_Assess_Day                   ;
						self.ContractDate.Year                   := rt.Prop_Recs_Con_Year                     ;
						self.ContractDate.Month                  := rt.Prop_Recs_Con_Month                    ;
						self.ContractDate.Day                    := rt.Prop_Recs_Con_Day                      ;
						self.SaleDate.Year                       := rt.Prop_Recs_Sale_Year                    ;
						self.SaleDate.Month                      := rt.Prop_Recs_Sale_Month                   ;
						self.SaleDate.Day                        := rt.Prop_Recs_Sale_Day                     ;
						self.RecordingDate.Year                  := rt.Prop_Recs_Rec_Year                     ;
						self.RecordingDate.Month                 := rt.Prop_Recs_Rec_Month                    ;
						self.RecordingDate.Day                   := rt.Prop_Recs_Rec_Day                      ;
						self.CurrentRecord                       := rt.Prop_Recs_CurrentRecord                ;
						self.PSourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID          := rt.Prop_Recs_PDocs_DotID               ;
								self.BusinessIds.EmpID          := rt.Prop_Recs_PDocs_EmpID               ;
								self.BusinessIds.POWID          := rt.Prop_Recs_PDocs_POWID               ;
								self.BusinessIds.ProxID         := rt.Prop_Recs_PDocs_ProxID              ;
								self.BusinessIds.SeleID         := rt.Prop_Recs_PDocs_SeleID              ;
								self.BusinessIds.OrgID          := rt.Prop_Recs_PDocs_OrgID               ;
								self.BusinessIds.UltID          := rt.Prop_Recs_PDocs_UltID               ;
								self.IdType                     := rt.Prop_Recs_PDocs_IdType              ;
								self.IdValue                    := rt.Prop_Recs_PDocs_IdValue             ;
								self.Section                    := rt.Prop_Recs_PDocs_Section             ;
								self.Source                     := rt.Prop_Recs_PDocs_Source              ;
								self.Address.StreetNumber       := rt.Prop_Recs_PDocs_StreetNumber        ;
								self.Address.StreetPreDirection := rt.Prop_Recs_PDocs_StreetPreDirection  ;
								self.Address.StreetName         := rt.Prop_Recs_PDocs_StreetName          ;
								self.Address.StreetSuffix       := rt.Prop_Recs_PDocs_StreetSuffix        ;
								self.Address.StreetPostDirection:= rt.Prop_Recs_PDocs_StreetPostDirection ;
								self.Address.UnitDesignation    := rt.Prop_Recs_PDocs_UnitDesignation     ;
								self.Address.UnitNumber         := rt.Prop_Recs_PDocs_UnitNumber          ;
								self.Address.StreetAddress1     := rt.Prop_Recs_PDocs_StreetAddress1      ;
								self.Address.StreetAddress2     := rt.Prop_Recs_PDocs_StreetAddress2      ;
								self.Address.City               := rt.Prop_Recs_PDocs_City                ;
								self.Address.State              := rt.Prop_Recs_PDocs_State               ;
								self.Address.Zip5               := rt.Prop_Recs_PDocs_Zip5                ;
								self.Address.Zip4               := rt.Prop_Recs_PDocs_Zip4                ;
								self.Address.County             := rt.Prop_Recs_PDocs_County              ;
								self.Address.PostalCode         := rt.Prop_Recs_PDocs_PostalCode          ;
								self.Address.StateCityZip       := rt.Prop_Recs_PDocs_StateCityZip        ;
								self.Name.Full                  := rt.Prop_Recs_PDocs_Full                ;
								self.Name.First                 := rt.Prop_Recs_PDocs_First               ;
								self.Name.Middle                := rt.Prop_Recs_PDocs_Middle              ;
								self.Name.Last                  := rt.Prop_Recs_PDocs_Last                ;
								self.Name.Suffix                := rt.Prop_Recs_PDocs_Suffix              ;
								self.Name.Prefix                := rt.Prop_Recs_PDocs_Prefix              ;
								self.Name.CompanyName           := rt.Prop_Recs_PDocs_CompanyName         ;
						));
						self.FSourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID           := rt.Prop_Recs_FDocs_DotID               ;
								self.BusinessIds.EmpID           := rt.Prop_Recs_FDocs_EmpID               ;
								self.BusinessIds.POWID           := rt.Prop_Recs_FDocs_POWID               ;
								self.BusinessIds.ProxID          := rt.Prop_Recs_FDocs_ProxID              ;
								self.BusinessIds.SeleID          := rt.Prop_Recs_FDocs_SeleID              ;
								self.BusinessIds.OrgID           := rt.Prop_Recs_FDocs_OrgID               ;
								self.BusinessIds.UltID           := rt.Prop_Recs_FDocs_UltID               ;
								self.IdType                      := rt.Prop_Recs_FDocs_IdType              ;
								self.IdValue                     := rt.Prop_Recs_FDocs_IdValue             ;
								self.Section                     := rt.Prop_Recs_FDocs_Section             ;
								self.Source                      := rt.Prop_Recs_FDocs_Source              ;
								self.Address.StreetNumber        := rt.Prop_Recs_FDocs_StreetNumber        ;
								self.Address.StreetPreDirection  := rt.Prop_Recs_FDocs_StreetPreDirection  ;
								self.Address.StreetName          := rt.Prop_Recs_FDocs_StreetName          ;
								self.Address.StreetSuffix        := rt.Prop_Recs_FDocs_StreetSuffix        ;
								self.Address.StreetPostDirection := rt.Prop_Recs_FDocs_StreetPostDirection ;
								self.Address.UnitDesignation     := rt.Prop_Recs_FDocs_UnitDesignation     ;
								self.Address.UnitNumber          := rt.Prop_Recs_FDocs_UnitNumber          ;
								self.Address.StreetAddress1      := rt.Prop_Recs_FDocs_StreetAddress1      ;
								self.Address.StreetAddress2      := rt.Prop_Recs_FDocs_StreetAddress2      ;
								self.Address.City                := rt.Prop_Recs_FDocs_City                ;
								self.Address.State               := rt.Prop_Recs_FDocs_State               ;
								self.Address.Zip5                := rt.Prop_Recs_FDocs_Zip5                ;
								self.Address.Zip4                := rt.Prop_Recs_FDocs_Zip4                ;
								self.Address.County              := rt.Prop_Recs_FDocs_County              ;
								self.Address.PostalCode          := rt.Prop_Recs_FDocs_PostalCode          ;
								self.Address.StateCityZip        := rt.Prop_Recs_FDocs_StateCityZip        ;
								self.Name.Full                   := rt.Prop_Recs_FDocs_Full                ;
								self.Name.First                  := rt.Prop_Recs_FDocs_First               ;
								self.Name.Middle                 := rt.Prop_Recs_FDocs_Middle              ;
								self.Name.Last                   := rt.Prop_Recs_FDocs_Last                ;
								self.Name.Suffix                 := rt.Prop_Recs_FDocs_Suffix              ;
								self.Name.Prefix                 := rt.Prop_Recs_FDocs_Prefix              ;
								self.Name.CompanyName            := rt.Prop_Recs_FDocs_CompanyName         ;
						));
						self.Parties :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessPropertyParty,
								self.Owners :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessPropertyTransaction,
										self.PartyType                                            := rt.Prop_Recs_Part_Owner_PartyType                     ;
										self.CompanyName                                          := rt.Prop_Recs_Part_Owner_CompanyName                   ;
										self.Name.Full                                            := rt.Prop_Recs_Part_Owner_Full                          ;
										self.Name.First                                           := rt.Prop_Recs_Part_Owner_First                         ;
										self.Name.Middle                                          := rt.Prop_Recs_Part_Owner_Middle                        ;
										self.Name.Last                                            := rt.Prop_Recs_Part_Owner_Last                          ;
										self.Name.Suffix                                          := rt.Prop_Recs_Part_Owner_Suffix                        ;
										self.Name.Prefix                                          := rt.Prop_Recs_Part_Owner_Prefix                        ;
										self.Address.StreetNumber                                 := rt.Prop_Recs_Part_Owner_StreetNumber                  ;
										self.Address.StreetPreDirection                           := rt.Prop_Recs_Part_Owner_StreetPreDirection            ;
										self.Address.StreetName                                   := rt.Prop_Recs_Part_Owner_StreetName                    ;
										self.Address.StreetSuffix                                 := rt.Prop_Recs_Part_Owner_StreetSuffix                  ;
										self.Address.StreetPostDirection                          := rt.Prop_Recs_Part_Owner_StreetPostDirection           ;
										self.Address.UnitDesignation                              := rt.Prop_Recs_Part_Owner_UnitDesignation               ;
										self.Address.UnitNumber                                   := rt.Prop_Recs_Part_Owner_UnitNumber                    ;
										self.Address.StreetAddress1                               := rt.Prop_Recs_Part_Owner_StreetAddress1                ;
										self.Address.StreetAddress2                               := rt.Prop_Recs_Part_Owner_StreetAddress2                ;
										self.Address.City                                         := rt.Prop_Recs_Part_Owner_City                          ;
										self.Address.State                                        := rt.Prop_Recs_Part_Owner_State                         ;
										self.Address.Zip5                                         := rt.Prop_Recs_Part_Owner_Zip5                          ;
										self.Address.Zip4                                         := rt.Prop_Recs_Part_Owner_Zip4                          ;
										self.Address.County                                       := rt.Prop_Recs_Part_Owner_County                        ;
										self.Address.PostalCode                                   := rt.Prop_Recs_Part_Owner_PostalCode                    ;
										self.Address.StateCityZip                                 := rt.Prop_Recs_Part_Owner_StateCityZip                  ;
										self.PartyTypeName                                        := rt.Prop_Recs_Part_Owner_PartyTypeName                 ;
										self.PropertyAddress.Address.StreetNumber                 := rt.Prop_Recs_Part_Owner_Geo_StreetNumber              ;
										self.PropertyAddress.Address.StreetPreDirection           := rt.Prop_Recs_Part_Owner_Geo_StreetPreDirection        ;
										self.PropertyAddress.Address.StreetName                   := rt.Prop_Recs_Part_Owner_Geo_StreetName                ;
										self.PropertyAddress.Address.StreetSuffix                 := rt.Prop_Recs_Part_Owner_Geo_StreetSuffix              ;
										self.PropertyAddress.Address.StreetPostDirection          := rt.Prop_Recs_Part_Owner_Geo_StreetPostDirection       ;
										self.PropertyAddress.Address.UnitDesignation              := rt.Prop_Recs_Part_Owner_Geo_UnitDesignation           ;
										self.PropertyAddress.Address.UnitNumber                   := rt.Prop_Recs_Part_Owner_Geo_UnitNumber                ;
										self.PropertyAddress.Address.StreetAddress1               := rt.Prop_Recs_Part_Owner_Geo_StreetAddress1            ;
										self.PropertyAddress.Address.StreetAddress2               := rt.Prop_Recs_Part_Owner_Geo_StreetAddress2            ;
										self.PropertyAddress.Address.City                         := rt.Prop_Recs_Part_Owner_Geo_City                      ;
										self.PropertyAddress.Address.State                        := rt.Prop_Recs_Part_Owner_Geo_State                     ;
										self.PropertyAddress.Address.Zip5                         := rt.Prop_Recs_Part_Owner_Geo_Zip5                      ;
										self.PropertyAddress.Address.Zip4                         := rt.Prop_Recs_Part_Owner_Geo_Zip4                      ;
										self.PropertyAddress.Address.County                       := rt.Prop_Recs_Part_Owner_Geo_County                    ;
										self.PropertyAddress.Address.PostalCode                   := rt.Prop_Recs_Part_Owner_Geo_PostalCode                ;
										self.PropertyAddress.Address.StateCityZip                 := rt.Prop_Recs_Part_Owner_Geo_StateCityZip              ;
										self.PropertyAddress.GeoLocationMatch.Latitude            := rt.Prop_Recs_Part_Owner_Geo_Latitude                  ;
										self.PropertyAddress.GeoLocationMatch.Longitude           := rt.Prop_Recs_Part_Owner_Geo_Longitude                 ;
										self.PropertyAddress.GeoLocationMatch.MatchCode           := rt.Prop_Recs_Part_Owner_Geo_MatchCode                 ;
										self.PropertyAddress.GeoLocationMatch.MatchDesc           := rt.Prop_Recs_Part_Owner_Geo_MatchDesc                 ;
										self.Cart                                                 := rt.Prop_Recs_Part_Owner_Cart                          ;
										self.CrSortSz                                             := rt.Prop_Recs_Part_Owner_CrSortSz                      ;
										self.Lot                                                  := rt.Prop_Recs_Part_Owner_Lot                           ;
										self.LotOrder                                             := rt.Prop_Recs_Part_Owner_LotOrder                      ;
										self.DBPC                                                 := rt.Prop_Recs_Part_Owner_DBPC                          ;
										self.CheckDigit                                           := rt.Prop_Recs_Part_Owner_CheckDigit                    ;
										self.RecordType                                           := rt.Prop_Recs_Part_Owner_RecordType                    ;
										self.MSANumber                                            := rt.Prop_Recs_Part_Owner_MSANumber                     ;
										self.GeoBlk                                               := rt.Prop_Recs_Part_Owner_GeoBlk                        ;
										self.GeoMatch                                             := rt.Prop_Recs_Part_Owner_GeoMatch                      ;
										self.Phone10                                              := rt.Prop_Recs_Part_Owner_Phone10                       ;
										self.UniqueID                                             := rt.Prop_Recs_Part_Owner_UniqueID                      ;
										self.BusinessIdentity.DotID                               := rt.Prop_Recs_Part_Owner_DotID                         ;
										self.BusinessIdentity.EmpID                               := rt.Prop_Recs_Part_Owner_EmpID                         ;
										self.BusinessIdentity.POWID                               := rt.Prop_Recs_Part_Owner_POWID                         ;
										self.BusinessIdentity.ProxID                              := rt.Prop_Recs_Part_Owner_ProxID                        ;
										self.BusinessIdentity.SeleID                              := rt.Prop_Recs_Part_Owner_SeleID                        ;
										self.BusinessIdentity.OrgID                               := rt.Prop_Recs_Part_Owner_OrgID                         ;
										self.BusinessIdentity.UltID                               := rt.Prop_Recs_Part_Owner_UltID                         ;
										self.SSN                                                  := rt.Prop_Recs_Part_Owner_SSN                           ;
										self.ProxyNameSeq                                         := rt.Prop_Recs_Part_Owner_ProxyNameSeq                  ;
										self.OriginalName                                         := rt.Prop_Recs_Part_Owner_OriginalName                  ;
										self.IdCode                                               := rt.Prop_Recs_Part_Owner_IdCode                        ;
										self.IdDescription                                        := rt.Prop_Recs_Part_Owner_IdDescription                 ;
								));
								self.Sellers :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessPropertyTransaction,
										self.PartyType                                           := rt.Prop_Recs_Part_Seller_PartyType                    ;
										self.CompanyName                                         := rt.Prop_Recs_Part_Seller_CompanyName                  ;
										self.Name.Full                                           := rt.Prop_Recs_Part_Seller_Full                         ;
										self.Name.First                                          := rt.Prop_Recs_Part_Seller_First                        ;
										self.Name.Middle                                         := rt.Prop_Recs_Part_Seller_Middle                       ;
										self.Name.Last                                           := rt.Prop_Recs_Part_Seller_Last                         ;
										self.Name.Suffix                                         := rt.Prop_Recs_Part_Seller_Suffix                       ;
										self.Name.Prefix                                         := rt.Prop_Recs_Part_Seller_Prefix                       ;
										self.Address.StreetNumber                                := rt.Prop_Recs_Part_Seller_StreetNumber                 ;
										self.Address.StreetPreDirection                          := rt.Prop_Recs_Part_Seller_StreetPreDirection           ;
										self.Address.StreetName                                  := rt.Prop_Recs_Part_Seller_StreetName                   ;
										self.Address.StreetSuffix                                := rt.Prop_Recs_Part_Seller_StreetSuffix                 ;
										self.Address.StreetPostDirection                         := rt.Prop_Recs_Part_Seller_StreetPostDirection          ;
										self.Address.UnitDesignation                             := rt.Prop_Recs_Part_Seller_UnitDesignation              ;
										self.Address.UnitNumber                                  := rt.Prop_Recs_Part_Seller_UnitNumber                   ;
										self.Address.StreetAddress1                              := rt.Prop_Recs_Part_Seller_StreetAddress1               ;
										self.Address.StreetAddress2                              := rt.Prop_Recs_Part_Seller_StreetAddress2               ;
										self.Address.City                                        := rt.Prop_Recs_Part_Seller_City                         ;
										self.Address.State                                       := rt.Prop_Recs_Part_Seller_State                        ;
										self.Address.Zip5                                        := rt.Prop_Recs_Part_Seller_Zip5                         ;
										self.Address.Zip4                                        := rt.Prop_Recs_Part_Seller_Zip4                         ;
										self.Address.County                                      := rt.Prop_Recs_Part_Seller_County                       ;
										self.Address.PostalCode                                  := rt.Prop_Recs_Part_Seller_PostalCode                   ;
										self.Address.StateCityZip                                := rt.Prop_Recs_Part_Seller_StateCityZip                 ;
										self.PartyTypeName                                       := rt.Prop_Recs_Part_Seller_PartyTypeName                ;
										self.PropertyAddress.Address.StreetNumber                := rt.Prop_Recs_Part_Seller_Geo_StreetNumber             ;
										self.PropertyAddress.Address.StreetPreDirection          := rt.Prop_Recs_Part_Seller_Geo_StreetPreDirection       ;
										self.PropertyAddress.Address.StreetName                  := rt.Prop_Recs_Part_Seller_Geo_StreetName               ;
										self.PropertyAddress.Address.StreetSuffix                := rt.Prop_Recs_Part_Seller_Geo_StreetSuffix             ;
										self.PropertyAddress.Address.StreetPostDirection         := rt.Prop_Recs_Part_Seller_Geo_StreetPostDirection      ;
										self.PropertyAddress.Address.UnitDesignation             := rt.Prop_Recs_Part_Seller_Geo_UnitDesignation          ;
										self.PropertyAddress.Address.UnitNumber                  := rt.Prop_Recs_Part_Seller_Geo_UnitNumber               ;
										self.PropertyAddress.Address.StreetAddress1              := rt.Prop_Recs_Part_Seller_Geo_StreetAddress1           ;
										self.PropertyAddress.Address.StreetAddress2              := rt.Prop_Recs_Part_Seller_Geo_StreetAddress2           ;
										self.PropertyAddress.Address.City                        := rt.Prop_Recs_Part_Seller_Geo_City                     ;
										self.PropertyAddress.Address.State                       := rt.Prop_Recs_Part_Seller_Geo_State                    ;
										self.PropertyAddress.Address.Zip5                        := rt.Prop_Recs_Part_Seller_Geo_Zip5                     ;
										self.PropertyAddress.Address.Zip4                        := rt.Prop_Recs_Part_Seller_Geo_Zip4                     ;
										self.PropertyAddress.Address.County                      := rt.Prop_Recs_Part_Seller_Geo_County                   ;
										self.PropertyAddress.Address.PostalCode                  := rt.Prop_Recs_Part_Seller_Geo_PostalCode               ;
										self.PropertyAddress.Address.StateCityZip                := rt.Prop_Recs_Part_Seller_Geo_StateCityZip             ;
										self.PropertyAddress.GeoLocationMatch.Latitude           := rt.Prop_Recs_Part_Seller_Geo_Latitude                 ;
										self.PropertyAddress.GeoLocationMatch.Longitude          := rt.Prop_Recs_Part_Seller_Geo_Longitude                ;
										self.PropertyAddress.GeoLocationMatch.MatchCode          := rt.Prop_Recs_Part_Seller_Geo_MatchCode                ;
										self.PropertyAddress.GeoLocationMatch.MatchDesc          := rt.Prop_Recs_Part_Seller_Geo_MatchDesc                ;
										self.Cart                                                := rt.Prop_Recs_Part_Seller_Cart                         ;
										self.CrSortSz                                            := rt.Prop_Recs_Part_Seller_CrSortSz                     ;
										self.Lot                                                 := rt.Prop_Recs_Part_Seller_Lot                          ;
										self.LotOrder                                            := rt.Prop_Recs_Part_Seller_LotOrder                     ;
										self.DBPC                                                := rt.Prop_Recs_Part_Seller_DBPC                         ;
										self.CheckDigit                                          := rt.Prop_Recs_Part_Seller_CheckDigit                   ;
										self.RecordType                                          := rt.Prop_Recs_Part_Seller_RecordType                   ;
										self.MSANumber                                           := rt.Prop_Recs_Part_Seller_MSANumber                    ;
										self.GeoBlk                                              := rt.Prop_Recs_Part_Seller_GeoBlk                       ;
										self.GeoMatch                                            := rt.Prop_Recs_Part_Seller_GeoMatch                     ;
										self.Phone10                                             := rt.Prop_Recs_Part_Seller_Phone10                      ;
										self.UniqueID                                            := rt.Prop_Recs_Part_Seller_UniqueID                     ;
										self.BusinessIdentity.DotID                              := rt.Prop_Recs_Part_Seller_DotID                        ;
										self.BusinessIdentity.EmpID                              := rt.Prop_Recs_Part_Seller_EmpID                        ;
										self.BusinessIdentity.POWID                              := rt.Prop_Recs_Part_Seller_POWID                        ;
										self.BusinessIdentity.ProxID                             := rt.Prop_Recs_Part_Seller_ProxID                       ;
										self.BusinessIdentity.SeleID                             := rt.Prop_Recs_Part_Seller_SeleID                       ;
										self.BusinessIdentity.OrgID                              := rt.Prop_Recs_Part_Seller_OrgID                        ;
										self.BusinessIdentity.UltID                              := rt.Prop_Recs_Part_Seller_UltID                        ;
										self.SSN                                                 := rt.Prop_Recs_Part_Seller_SSN                          ;
										self.ProxyNameSeq                                        := rt.Prop_Recs_Part_Seller_ProxyNameSeq                 ;
										self.OriginalName                                        := rt.Prop_Recs_Part_Seller_OriginalName                 ;
										self.IdCode                                              := rt.Prop_Recs_Part_Seller_IdCode                       ;
										self.IdDescription                                       := rt.Prop_Recs_Part_Seller_IdDescription                ;
								));
								self.Borrowers :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessPropertyTransaction,
										self.PartyType                                         := rt.Prop_Recs_Part_Borrow_PartyType                    ;
										self.CompanyName                                       := rt.Prop_Recs_Part_Borrow_CompanyName                  ;
										self.Name.Full                                         := rt.Prop_Recs_Part_Borrow_Full                         ;
										self.Name.First                                        := rt.Prop_Recs_Part_Borrow_First                        ;
										self.Name.Middle                                       := rt.Prop_Recs_Part_Borrow_Middle                       ;
										self.Name.Last                                         := rt.Prop_Recs_Part_Borrow_Last                         ;
										self.Name.Suffix                                       := rt.Prop_Recs_Part_Borrow_Suffix                       ;
										self.Name.Prefix                                       := rt.Prop_Recs_Part_Borrow_Prefix                       ;
										self.Address.StreetNumber                              := rt.Prop_Recs_Part_Borrow_StreetNumber                 ;
										self.Address.StreetPreDirection                        := rt.Prop_Recs_Part_Borrow_StreetPreDirection           ;
										self.Address.StreetName                                := rt.Prop_Recs_Part_Borrow_StreetName                   ;
										self.Address.StreetSuffix                              := rt.Prop_Recs_Part_Borrow_StreetSuffix                 ;
										self.Address.StreetPostDirection                       := rt.Prop_Recs_Part_Borrow_StreetPostDirection          ;
										self.Address.UnitDesignation                           := rt.Prop_Recs_Part_Borrow_UnitDesignation              ;
										self.Address.UnitNumber                                := rt.Prop_Recs_Part_Borrow_UnitNumber                   ;
										self.Address.StreetAddress1                            := rt.Prop_Recs_Part_Borrow_StreetAddress1               ;
										self.Address.StreetAddress2                            := rt.Prop_Recs_Part_Borrow_StreetAddress2               ;
										self.Address.City                                      := rt.Prop_Recs_Part_Borrow_City                         ;
										self.Address.State                                     := rt.Prop_Recs_Part_Borrow_State                        ;
										self.Address.Zip5                                      := rt.Prop_Recs_Part_Borrow_Zip5                         ;
										self.Address.Zip4                                      := rt.Prop_Recs_Part_Borrow_Zip4                         ;
										self.Address.County                                    := rt.Prop_Recs_Part_Borrow_County                       ;
										self.Address.PostalCode                                := rt.Prop_Recs_Part_Borrow_PostalCode                   ;
										self.Address.StateCityZip                              := rt.Prop_Recs_Part_Borrow_StateCityZip                 ;
										self.PartyTypeName                                     := rt.Prop_Recs_Part_Borrow_PartyTypeName                ;
										self.PropertyAddress.Address.StreetNumber              := rt.Prop_Recs_Part_Borrow_Geo_StreetNumber             ;
										self.PropertyAddress.Address.StreetPreDirection        := rt.Prop_Recs_Part_Borrow_Geo_StreetPreDirection       ;
										self.PropertyAddress.Address.StreetName                := rt.Prop_Recs_Part_Borrow_Geo_StreetName               ;
										self.PropertyAddress.Address.StreetSuffix              := rt.Prop_Recs_Part_Borrow_Geo_StreetSuffix             ;
										self.PropertyAddress.Address.StreetPostDirection       := rt.Prop_Recs_Part_Borrow_Geo_StreetPostDirection      ;
										self.PropertyAddress.Address.UnitDesignation           := rt.Prop_Recs_Part_Borrow_Geo_UnitDesignation          ;
										self.PropertyAddress.Address.UnitNumber                := rt.Prop_Recs_Part_Borrow_Geo_UnitNumber               ;
										self.PropertyAddress.Address.StreetAddress1            := rt.Prop_Recs_Part_Borrow_Geo_StreetAddress1           ;
										self.PropertyAddress.Address.StreetAddress2            := rt.Prop_Recs_Part_Borrow_Geo_StreetAddress2           ;
										self.PropertyAddress.Address.City                      := rt.Prop_Recs_Part_Borrow_Geo_City                     ;
										self.PropertyAddress.Address.State                     := rt.Prop_Recs_Part_Borrow_Geo_State                    ;
										self.PropertyAddress.Address.Zip5                      := rt.Prop_Recs_Part_Borrow_Geo_Zip5                     ;
										self.PropertyAddress.Address.Zip4                      := rt.Prop_Recs_Part_Borrow_Geo_Zip4                     ;
										self.PropertyAddress.Address.County                    := rt.Prop_Recs_Part_Borrow_Geo_County                   ;
										self.PropertyAddress.Address.PostalCode                := rt.Prop_Recs_Part_Borrow_Geo_PostalCode               ;
										self.PropertyAddress.Address.StateCityZip              := rt.Prop_Recs_Part_Borrow_Geo_StateCityZip             ;
										self.PropertyAddress.GeoLocationMatch.Latitude         := rt.Prop_Recs_Part_Borrow_Geo_Latitude                 ;
										self.PropertyAddress.GeoLocationMatch.Longitude        := rt.Prop_Recs_Part_Borrow_Geo_Longitude                ;
										self.PropertyAddress.GeoLocationMatch.MatchCode        := rt.Prop_Recs_Part_Borrow_Geo_MatchCode                ;
										self.PropertyAddress.GeoLocationMatch.MatchDesc        := rt.Prop_Recs_Part_Borrow_Geo_MatchDesc                ;
										self.Cart                                              := rt.Prop_Recs_Part_Borrow_Cart                         ;
										self.CrSortSz                                          := rt.Prop_Recs_Part_Borrow_CrSortSz                     ;
										self.Lot                                               := rt.Prop_Recs_Part_Borrow_Lot                          ;
										self.LotOrder                                          := rt.Prop_Recs_Part_Borrow_LotOrder                     ;
										self.DBPC                                              := rt.Prop_Recs_Part_Borrow_DBPC                         ;
										self.CheckDigit                                        := rt.Prop_Recs_Part_Borrow_CheckDigit                   ;
										self.RecordType                                        := rt.Prop_Recs_Part_Borrow_RecordType                   ;
										self.MSANumber                                         := rt.Prop_Recs_Part_Borrow_MSANumber                    ;
										self.GeoBlk                                            := rt.Prop_Recs_Part_Borrow_GeoBlk                       ;
										self.GeoMatch                                          := rt.Prop_Recs_Part_Borrow_GeoMatch                     ;
										self.Phone10                                           := rt.Prop_Recs_Part_Borrow_Phone10                      ;
										self.UniqueID                                          := rt.Prop_Recs_Part_Borrow_UniqueID                     ;
										self.BusinessIdentity.DotID                            := rt.Prop_Recs_Part_Borrow_DotID                        ;
										self.BusinessIdentity.EmpID                            := rt.Prop_Recs_Part_Borrow_EmpID                        ;
										self.BusinessIdentity.POWID                            := rt.Prop_Recs_Part_Borrow_POWID                        ;
										self.BusinessIdentity.ProxID                           := rt.Prop_Recs_Part_Borrow_ProxID                       ;
										self.BusinessIdentity.SeleID                           := rt.Prop_Recs_Part_Borrow_SeleID                       ;
										self.BusinessIdentity.OrgID                            := rt.Prop_Recs_Part_Borrow_OrgID                        ;
										self.BusinessIdentity.UltID                            := rt.Prop_Recs_Part_Borrow_UltID                        ;
										self.SSN                                               := rt.Prop_Recs_Part_Borrow_SSN                          ;
										self.ProxyNameSeq                                      := rt.Prop_Recs_Part_Borrow_ProxyNameSeq                 ;
										self.OriginalName                                      := rt.Prop_Recs_Part_Borrow_OriginalName                 ;
										self.IdCode                                            := rt.Prop_Recs_Part_Borrow_IdCode                       ;
										self.IdDescription                                     := rt.Prop_Recs_Part_Borrow_IdDescription                ;
								));
								self.Mortgages :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessPropertyMortgageInfo,
										self.LoanAmount           := rt.Prop_Recs_Part_Mortgage_LoanAmount      ;
										self.LoanAmount2          := rt.Prop_Recs_Part_Mortgage_LoanAmount2     ;
										self.LoanType             := rt.Prop_Recs_Part_Mortgage_LoanType        ;
										self.TransactionType      := rt.Prop_Recs_Part_Mortgage_TransactionType ;
										self.AddressType          := rt.Prop_Recs_Part_Mortgage_AddressType     ;
										self.Description          := rt.Prop_Recs_Part_Mortgage_Description     ;
										self.LenderName           := rt.Prop_Recs_Part_Mortgage_LenderName      ;
										self.LoanDate.Year        := rt.Prop_Recs_Part_Mortgage_Loan_Year       ;
										self.LoanDate.Month       := rt.Prop_Recs_Part_Mortgage_Loan_Month      ;
										self.LoanDate.Day         := rt.Prop_Recs_Part_Mortgage_Loan_Day        ;
										self.ContractDate.Year    := rt.Prop_Recs_Part_Mortgage_Con_Year        ;
										self.ContractDate.Month   := rt.Prop_Recs_Part_Mortgage_Con_Month       ;
										self.ContractDate.Day     := rt.Prop_Recs_Part_Mortgage_Con_Day         ;
										self.SaleDate.Year        := rt.Prop_Recs_Part_Mortgage_Sale_Year       ;
										self.SaleDate.Month       := rt.Prop_Recs_Part_Mortgage_Sale_Month      ;
										self.SaleDate.Day         := rt.Prop_Recs_Part_Mortgage_Sale_Day        ;
										self.RecordingDate.Year   := rt.Prop_Recs_Part_Mortgage_Rec_Year        ;
										self.RecordingDate.Month  := rt.Prop_Recs_Part_Mortgage_Rec_Month       ;
										self.RecordingDate.Day    := rt.Prop_Recs_Part_Mortgage_Rec_Day         ;
										self.DocumentType         := rt.Prop_Recs_Part_Mortgage_DocumentType    ;
										self.AssessmentDate.Year  := rt.Prop_Recs_Part_Mortgage_Assess_Year     ;
										self.AssessmentDate.Month := rt.Prop_Recs_Part_Mortgage_Assess_Month    ;
										self.AssessmentDate.Day   := rt.Prop_Recs_Part_Mortgage_Assess_Day      ;
								));
								self.Foreclosures :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessPropertyForeclosure,
										self.RecordingDate.Year                             := rt.Prop_Recs_Part_Foreclose_Rec_Year                  ;
										self.RecordingDate.Month                            := rt.Prop_Recs_Part_Foreclose_Rec_Month                 ;
										self.RecordingDate.Day                              := rt.Prop_Recs_Part_Foreclose_Rec_Day                   ;
										self.AuctionDate.Year                               := rt.Prop_Recs_Part_Foreclose_Auct_Year                 ;
										self.AuctionDate.Month                              := rt.Prop_Recs_Part_Foreclose_Auct_Month                ;
										self.AuctionDate.Day                                := rt.Prop_Recs_Part_Foreclose_Auct_Day                  ;
										self.PlaintiffName1                                 := rt.Prop_Recs_Part_Foreclose_PlaintiffName1            ;
										self.PlaintiffName2                                 := rt.Prop_Recs_Part_Foreclose_PlaintiffName2            ;
										self.PlaintiffCompanyName                           := rt.Prop_Recs_Part_Foreclose_PlaintiffCompanyName      ;
										self.DefendantName1                                 := rt.Prop_Recs_Part_Foreclose_DefendantName1            ;
										self.DefendantName2                                 := rt.Prop_Recs_Part_Foreclose_DefendantName2            ;
										self.DefendantName3                                 := rt.Prop_Recs_Part_Foreclose_DefendantName3            ;
										self.DefendantName4                                 := rt.Prop_Recs_Part_Foreclose_DefendantName4            ;
										self.DefendantCompanyName1                          := rt.Prop_Recs_Part_Foreclose_DefendantCompanyName1     ;
										self.DefendantCompanyName2                          := rt.Prop_Recs_Part_Foreclose_DefendantCompanyName2     ;
										self.DefendantCompanyName3                          := rt.Prop_Recs_Part_Foreclose_DefendantCompanyName3     ;
										self.DefendantCompanyName4                          := rt.Prop_Recs_Part_Foreclose_DefendantCompanyName4     ;
										self.SiteAddress1.StreetNumber                      := rt.Prop_Recs_Part_Foreclose_Site1_StreetNumber        ;
										self.SiteAddress1.StreetPreDirection                := rt.Prop_Recs_Part_Foreclose_Site1_StreetPreDirection  ;
										self.SiteAddress1.StreetName                        := rt.Prop_Recs_Part_Foreclose_Site1_StreetName          ;
										self.SiteAddress1.StreetSuffix                      := rt.Prop_Recs_Part_Foreclose_Site1_StreetSuffix        ;
										self.SiteAddress1.StreetPostDirection               := rt.Prop_Recs_Part_Foreclose_Site1_StreetPostDirection ;
										self.SiteAddress1.UnitDesignation                   := rt.Prop_Recs_Part_Foreclose_Site1_UnitDesignation     ;
										self.SiteAddress1.UnitNumber                        := rt.Prop_Recs_Part_Foreclose_Site1_UnitNumber          ;
										self.SiteAddress1.StreetAddress1                    := rt.Prop_Recs_Part_Foreclose_Site1_StreetAddress1      ;
										self.SiteAddress1.StreetAddress2                    := rt.Prop_Recs_Part_Foreclose_Site1_StreetAddress2      ;
										self.SiteAddress1.City                              := rt.Prop_Recs_Part_Foreclose_Site1_City                ;
										self.SiteAddress1.State                             := rt.Prop_Recs_Part_Foreclose_Site1_State               ;
										self.SiteAddress1.Zip5                              := rt.Prop_Recs_Part_Foreclose_Site1_Zip5                ;
										self.SiteAddress1.Zip4                              := rt.Prop_Recs_Part_Foreclose_Site1_Zip4                ;
										self.SiteAddress1.County                            := rt.Prop_Recs_Part_Foreclose_Site1_County              ;
										self.SiteAddress1.PostalCode                        := rt.Prop_Recs_Part_Foreclose_Site1_PostalCode          ;
										self.SiteAddress1.StateCityZip                      := rt.Prop_Recs_Part_Foreclose_Site1_StateCityZip        ;
										self.SiteAddress2.StreetNumber                      := rt.Prop_Recs_Part_Foreclose_Site2_StreetNumber        ;
										self.SiteAddress2.StreetPreDirection                := rt.Prop_Recs_Part_Foreclose_Site2_StreetPreDirection  ;
										self.SiteAddress2.StreetName                        := rt.Prop_Recs_Part_Foreclose_Site2_StreetName          ;
										self.SiteAddress2.StreetSuffix                      := rt.Prop_Recs_Part_Foreclose_Site2_StreetSuffix        ;
										self.SiteAddress2.StreetPostDirection               := rt.Prop_Recs_Part_Foreclose_Site2_StreetPostDirection ;
										self.SiteAddress2.UnitDesignation                   := rt.Prop_Recs_Part_Foreclose_Site2_UnitDesignation     ;
										self.SiteAddress2.UnitNumber                        := rt.Prop_Recs_Part_Foreclose_Site2_UnitNumber          ;
										self.SiteAddress2.StreetAddress1                    := rt.Prop_Recs_Part_Foreclose_Site2_StreetAddress1      ;
										self.SiteAddress2.StreetAddress2                    := rt.Prop_Recs_Part_Foreclose_Site2_StreetAddress2      ;
										self.SiteAddress2.City                              := rt.Prop_Recs_Part_Foreclose_Site2_City                ;
										self.SiteAddress2.State                             := rt.Prop_Recs_Part_Foreclose_Site2_State               ;
										self.SiteAddress2.Zip5                              := rt.Prop_Recs_Part_Foreclose_Site2_Zip5                ;
										self.SiteAddress2.Zip4                              := rt.Prop_Recs_Part_Foreclose_Site2_Zip4                ;
										self.SiteAddress2.County                            := rt.Prop_Recs_Part_Foreclose_Site2_County              ;
										self.SiteAddress2.PostalCode                        := rt.Prop_Recs_Part_Foreclose_Site2_PostalCode          ;
										self.SiteAddress2.StateCityZip                      := rt.Prop_Recs_Part_Foreclose_Site2_StateCityZip        ;
										self.LenderFirstName                                := rt.Prop_Recs_Part_Foreclose_LenderFirstName           ;
										self.LenderLastName                                 := rt.Prop_Recs_Part_Foreclose_LenderLastName            ;
										self.LenderCompanyName                              := rt.Prop_Recs_Part_Foreclose_LenderCompanyName         ;
										self.AttorneyName                                   := rt.Prop_Recs_Part_Foreclose_AttorneyName              ;
										self.AttorneyPhoneNumber                            := rt.Prop_Recs_Part_Foreclose_AttorneyPhoneNumber       ;
										self.Address.StreetNumber                           := rt.Prop_Recs_Part_Foreclose_Addr_StreetNumber         ;
										self.Address.StreetPreDirection                     := rt.Prop_Recs_Part_Foreclose_Addr_StreetPreDirection   ;
										self.Address.StreetName                             := rt.Prop_Recs_Part_Foreclose_Addr_StreetName           ;
										self.Address.StreetSuffix                           := rt.Prop_Recs_Part_Foreclose_Addr_StreetSuffix         ;
										self.Address.StreetPostDirection                    := rt.Prop_Recs_Part_Foreclose_Addr_StreetPostDirection  ;
										self.Address.UnitDesignation                        := rt.Prop_Recs_Part_Foreclose_Addr_UnitDesignation      ;
										self.Address.UnitNumber                             := rt.Prop_Recs_Part_Foreclose_Addr_UnitNumber           ;
										self.Address.StreetAddress1                         := rt.Prop_Recs_Part_Foreclose_Addr_StreetAddress1       ;
										self.Address.StreetAddress2                         := rt.Prop_Recs_Part_Foreclose_Addr_StreetAddress2       ;
										self.Address.City                                   := rt.Prop_Recs_Part_Foreclose_Addr_City                 ;
										self.Address.State                                  := rt.Prop_Recs_Part_Foreclose_Addr_State                ;
										self.Address.Zip5                                   := rt.Prop_Recs_Part_Foreclose_Addr_Zip5                 ;
										self.Address.Zip4                                   := rt.Prop_Recs_Part_Foreclose_Addr_Zip4                 ;
										self.Address.County                                 := rt.Prop_Recs_Part_Foreclose_Addr_County               ;
										self.Address.PostalCode                             := rt.Prop_Recs_Part_Foreclose_Addr_PostalCode           ;
										self.Address.StateCityZip                           := rt.Prop_Recs_Part_Foreclose_Addr_StateCityZip         ;
										self.DocumentType                                   := rt.Prop_Recs_Part_Foreclose_DocumentType              ;
										self.FSourceDocs :=
											project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
												self.BusinessIds.DotID               := rt.Prop_Recs_Part_Foreclose_FDocs_DotID               ;
												self.BusinessIds.EmpID               := rt.Prop_Recs_Part_Foreclose_FDocs_EmpID               ;
												self.BusinessIds.POWID               := rt.Prop_Recs_Part_Foreclose_FDocs_POWID               ;
												self.BusinessIds.ProxID              := rt.Prop_Recs_Part_Foreclose_FDocs_ProxID              ;
												self.BusinessIds.SeleID              := rt.Prop_Recs_Part_Foreclose_FDocs_SeleID              ;
												self.BusinessIds.OrgID               := rt.Prop_Recs_Part_Foreclose_FDocs_OrgID               ;
												self.BusinessIds.UltID               := rt.Prop_Recs_Part_Foreclose_FDocs_UltID               ;
												self.IdType                          := rt.Prop_Recs_Part_Foreclose_FDocs_IdType              ;
												self.IdValue                         := rt.Prop_Recs_Part_Foreclose_FDocs_IdValue             ;
												self.Section                         := rt.Prop_Recs_Part_Foreclose_FDocs_Section             ;
												self.Source                          := rt.Prop_Recs_Part_Foreclose_FDocs_Source              ;
												self.Address.StreetNumber            := rt.Prop_Recs_Part_Foreclose_FDocs_StreetNumber        ;
												self.Address.StreetPreDirection      := rt.Prop_Recs_Part_Foreclose_FDocs_StreetPreDirection  ;
												self.Address.StreetName              := rt.Prop_Recs_Part_Foreclose_FDocs_StreetName          ;
												self.Address.StreetSuffix            := rt.Prop_Recs_Part_Foreclose_FDocs_StreetSuffix        ;
												self.Address.StreetPostDirection     := rt.Prop_Recs_Part_Foreclose_FDocs_StreetPostDirection ;
												self.Address.UnitDesignation         := rt.Prop_Recs_Part_Foreclose_FDocs_UnitDesignation     ;
												self.Address.UnitNumber              := rt.Prop_Recs_Part_Foreclose_FDocs_UnitNumber          ;
												self.Address.StreetAddress1          := rt.Prop_Recs_Part_Foreclose_FDocs_StreetAddress1      ;
												self.Address.StreetAddress2          := rt.Prop_Recs_Part_Foreclose_FDocs_StreetAddress2      ;
												self.Address.City                    := rt.Prop_Recs_Part_Foreclose_FDocs_City                ;
												self.Address.State                   := rt.Prop_Recs_Part_Foreclose_FDocs_State               ;
												self.Address.Zip5                    := rt.Prop_Recs_Part_Foreclose_FDocs_Zip5                ;
												self.Address.Zip4                    := rt.Prop_Recs_Part_Foreclose_FDocs_Zip4                ;
												self.Address.County                  := rt.Prop_Recs_Part_Foreclose_FDocs_County              ;
												self.Address.PostalCode              := rt.Prop_Recs_Part_Foreclose_FDocs_PostalCode          ;
												self.Address.StateCityZip            := rt.Prop_Recs_Part_Foreclose_FDocs_StateCityZip        ;
												self.Name.Full                       := rt.Prop_Recs_Part_Foreclose_FDocs_Full                ;
												self.Name.First                      := rt.Prop_Recs_Part_Foreclose_FDocs_First               ;
												self.Name.Middle                     := rt.Prop_Recs_Part_Foreclose_FDocs_Middle              ;
												self.Name.Last                       := rt.Prop_Recs_Part_Foreclose_FDocs_Last                ;
												self.Name.Suffix                     := rt.Prop_Recs_Part_Foreclose_FDocs_Suffix              ;
												self.Name.Prefix                     := rt.Prop_Recs_Part_Foreclose_FDocs_Prefix              ;
												self.Name.CompanyName                := rt.Prop_Recs_Part_Foreclose_FDocs_CompanyName         ;
										));
								));
								self.NoticeOfDefaults :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessPropertyForeclosure,
										self.RecordingDate.Year                         := rt.Prop_Recs_Part_Default_Rec_Year                    ;
										self.RecordingDate.Month                        := rt.Prop_Recs_Part_Default_Rec_Month                   ;
										self.RecordingDate.Day                          := rt.Prop_Recs_Part_Default_Rec_Day                     ;
										self.AuctionDate.Year                           := rt.Prop_Recs_Part_Default_Auct_Year                   ;
										self.AuctionDate.Month                          := rt.Prop_Recs_Part_Default_Auct_Month                  ;
										self.AuctionDate.Day                            := rt.Prop_Recs_Part_Default_Auct_Day                    ;
										self.PlaintiffName1                             := rt.Prop_Recs_Part_Default_PlaintiffName1              ;
										self.PlaintiffName2                             := rt.Prop_Recs_Part_Default_PlaintiffName2              ;
										self.PlaintiffCompanyName                       := rt.Prop_Recs_Part_Default_PlaintiffCompanyName        ;
										self.DefendantName1                             := rt.Prop_Recs_Part_Default_DefendantName1              ;
										self.DefendantName2                             := rt.Prop_Recs_Part_Default_DefendantName2              ;
										self.DefendantName3                             := rt.Prop_Recs_Part_Default_DefendantName3              ;
										self.DefendantName4                             := rt.Prop_Recs_Part_Default_DefendantName4              ;
										self.DefendantCompanyName1                      := rt.Prop_Recs_Part_Default_DefendantCompanyName1       ;
										self.DefendantCompanyName2                      := rt.Prop_Recs_Part_Default_DefendantCompanyName2       ;
										self.DefendantCompanyName3                      := rt.Prop_Recs_Part_Default_DefendantCompanyName3       ;
										self.DefendantCompanyName4                      := rt.Prop_Recs_Part_Default_DefendantCompanyName4       ;
										self.SiteAddress1.StreetNumber                  := rt.Prop_Recs_Part_Default_Site1_StreetNumber          ;
										self.SiteAddress1.StreetPreDirection            := rt.Prop_Recs_Part_Default_Site1_StreetPreDirection    ;
										self.SiteAddress1.StreetName                    := rt.Prop_Recs_Part_Default_Site1_StreetName            ;
										self.SiteAddress1.StreetSuffix                  := rt.Prop_Recs_Part_Default_Site1_StreetSuffix          ;
										self.SiteAddress1.StreetPostDirection           := rt.Prop_Recs_Part_Default_Site1_StreetPostDirection   ;
										self.SiteAddress1.UnitDesignation               := rt.Prop_Recs_Part_Default_Site1_UnitDesignation       ;
										self.SiteAddress1.UnitNumber                    := rt.Prop_Recs_Part_Default_Site1_UnitNumber            ;
										self.SiteAddress1.StreetAddress1                := rt.Prop_Recs_Part_Default_Site1_StreetAddress1        ;
										self.SiteAddress1.StreetAddress2                := rt.Prop_Recs_Part_Default_Site1_StreetAddress2        ;
										self.SiteAddress1.City                          := rt.Prop_Recs_Part_Default_Site1_City                  ;
										self.SiteAddress1.State                         := rt.Prop_Recs_Part_Default_Site1_State                 ;
										self.SiteAddress1.Zip5                          := rt.Prop_Recs_Part_Default_Site1_Zip5                  ;
										self.SiteAddress1.Zip4                          := rt.Prop_Recs_Part_Default_Site1_Zip4                  ;
										self.SiteAddress1.County                        := rt.Prop_Recs_Part_Default_Site1_County                ;
										self.SiteAddress1.PostalCode                    := rt.Prop_Recs_Part_Default_Site1_PostalCode            ;
										self.SiteAddress1.StateCityZip                  := rt.Prop_Recs_Part_Default_Site1_StateCityZip          ;
										self.SiteAddress2.StreetNumber                  := rt.Prop_Recs_Part_Default_Site2_StreetNumber          ;
										self.SiteAddress2.StreetPreDirection            := rt.Prop_Recs_Part_Default_Site2_StreetPreDirection    ;
										self.SiteAddress2.StreetName                    := rt.Prop_Recs_Part_Default_Site2_StreetName            ;
										self.SiteAddress2.StreetSuffix                  := rt.Prop_Recs_Part_Default_Site2_StreetSuffix          ;
										self.SiteAddress2.StreetPostDirection           := rt.Prop_Recs_Part_Default_Site2_StreetPostDirection   ;
										self.SiteAddress2.UnitDesignation               := rt.Prop_Recs_Part_Default_Site2_UnitDesignation       ;
										self.SiteAddress2.UnitNumber                    := rt.Prop_Recs_Part_Default_Site2_UnitNumber            ;
										self.SiteAddress2.StreetAddress1                := rt.Prop_Recs_Part_Default_Site2_StreetAddress1        ;
										self.SiteAddress2.StreetAddress2                := rt.Prop_Recs_Part_Default_Site2_StreetAddress2        ;
										self.SiteAddress2.City                          := rt.Prop_Recs_Part_Default_Site2_City                  ;
										self.SiteAddress2.State                         := rt.Prop_Recs_Part_Default_Site2_State                 ;
										self.SiteAddress2.Zip5                          := rt.Prop_Recs_Part_Default_Site2_Zip5                  ;
										self.SiteAddress2.Zip4                          := rt.Prop_Recs_Part_Default_Site2_Zip4                  ;
										self.SiteAddress2.County                        := rt.Prop_Recs_Part_Default_Site2_County                ;
										self.SiteAddress2.PostalCode                    := rt.Prop_Recs_Part_Default_Site2_PostalCode            ;
										self.SiteAddress2.StateCityZip                  := rt.Prop_Recs_Part_Default_Site2_StateCityZip          ;
										self.LenderFirstName                            := rt.Prop_Recs_Part_Default_LenderFirstName             ;
										self.LenderLastName                             := rt.Prop_Recs_Part_Default_LenderLastName              ;
										self.LenderCompanyName                          := rt.Prop_Recs_Part_Default_LenderCompanyName           ;
										self.AttorneyName                               := rt.Prop_Recs_Part_Default_AttorneyName                ;
										self.AttorneyPhoneNumber                        := rt.Prop_Recs_Part_Default_AttorneyPhoneNumber         ;
										self.Address.StreetNumber                       := rt.Prop_Recs_Part_Default_StreetNumber                ;
										self.Address.StreetPreDirection                 := rt.Prop_Recs_Part_Default_StreetPreDirection          ;
										self.Address.StreetName                         := rt.Prop_Recs_Part_Default_StreetName                  ;
										self.Address.StreetSuffix                       := rt.Prop_Recs_Part_Default_StreetSuffix                ;
										self.Address.StreetPostDirection                := rt.Prop_Recs_Part_Default_StreetPostDirection         ;
										self.Address.UnitDesignation                    := rt.Prop_Recs_Part_Default_UnitDesignation             ;
										self.Address.UnitNumber                         := rt.Prop_Recs_Part_Default_UnitNumber                  ;
										self.Address.StreetAddress1                     := rt.Prop_Recs_Part_Default_StreetAddress1              ;
										self.Address.StreetAddress2                     := rt.Prop_Recs_Part_Default_StreetAddress2              ;
										self.Address.City                               := rt.Prop_Recs_Part_Default_City                        ;
										self.Address.State                              := rt.Prop_Recs_Part_Default_State                       ;
										self.Address.Zip5                               := rt.Prop_Recs_Part_Default_Zip5                        ;
										self.Address.Zip4                               := rt.Prop_Recs_Part_Default_Zip4                        ;
										self.Address.County                             := rt.Prop_Recs_Part_Default_County                      ;
										self.Address.PostalCode                         := rt.Prop_Recs_Part_Default_PostalCode                  ;
										self.Address.StateCityZip                       := rt.Prop_Recs_Part_Default_StateCityZip                ;
										self.DocumentType                               := rt.Prop_Recs_Part_Default_DocumentType                ;
										self.FSourceDocs :=
											project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
												self.BusinessIds.DotID           := rt.Prop_Recs_Part_Default_FDocs_DotID                 ;
												self.BusinessIds.EmpID           := rt.Prop_Recs_Part_Default_FDocs_EmpID                 ;
												self.BusinessIds.POWID           := rt.Prop_Recs_Part_Default_FDocs_POWID                 ;
												self.BusinessIds.ProxID          := rt.Prop_Recs_Part_Default_FDocs_ProxID                ;
												self.BusinessIds.SeleID          := rt.Prop_Recs_Part_Default_FDocs_SeleID                ;
												self.BusinessIds.OrgID           := rt.Prop_Recs_Part_Default_FDocs_OrgID                 ;
												self.BusinessIds.UltID           := rt.Prop_Recs_Part_Default_FDocs_UltID                 ;
												self.IdType                      := rt.Prop_Recs_Part_Default_FDocs_IdType                ;
												self.IdValue                     := rt.Prop_Recs_Part_Default_FDocs_IdValue               ;
												self.Section                     := rt.Prop_Recs_Part_Default_FDocs_Section               ;
												self.Source                      := rt.Prop_Recs_Part_Default_FDocs_Source                ;
												self.Address.StreetNumber        := rt.Prop_Recs_Part_Default_FDocs_StreetNumber          ;
												self.Address.StreetPreDirection  := rt.Prop_Recs_Part_Default_FDocs_StreetPreDirection    ;
												self.Address.StreetName          := rt.Prop_Recs_Part_Default_FDocs_StreetName            ;
												self.Address.StreetSuffix        := rt.Prop_Recs_Part_Default_FDocs_StreetSuffix          ;
												self.Address.StreetPostDirection := rt.Prop_Recs_Part_Default_FDocs_StreetPostDirection   ;
												self.Address.UnitDesignation     := rt.Prop_Recs_Part_Default_FDocs_UnitDesignation       ;
												self.Address.UnitNumber          := rt.Prop_Recs_Part_Default_FDocs_UnitNumber            ;
												self.Address.StreetAddress1      := rt.Prop_Recs_Part_Default_FDocs_StreetAddress1        ;
												self.Address.StreetAddress2      := rt.Prop_Recs_Part_Default_FDocs_StreetAddress2        ;
												self.Address.City                := rt.Prop_Recs_Part_Default_FDocs_City                  ;
												self.Address.State               := rt.Prop_Recs_Part_Default_FDocs_State                 ;
												self.Address.Zip5                := rt.Prop_Recs_Part_Default_FDocs_Zip5                  ;
												self.Address.Zip4                := rt.Prop_Recs_Part_Default_FDocs_Zip4                  ;
												self.Address.County              := rt.Prop_Recs_Part_Default_FDocs_County                ;
												self.Address.PostalCode          := rt.Prop_Recs_Part_Default_FDocs_PostalCode            ;
												self.Address.StateCityZip        := rt.Prop_Recs_Part_Default_FDocs_StateCityZip          ;
												self.Name.Full                   := rt.Prop_Recs_Part_Default_FDocs_Full                  ;
												self.Name.First                  := rt.Prop_Recs_Part_Default_FDocs_First                 ;
												self.Name.Middle                 := rt.Prop_Recs_Part_Default_FDocs_Middle                ;
												self.Name.Last                   := rt.Prop_Recs_Part_Default_FDocs_Last                  ;
												self.Name.Suffix                 := rt.Prop_Recs_Part_Default_FDocs_Suffix                ;
												self.Name.Prefix                 := rt.Prop_Recs_Part_Default_FDocs_Prefix                ;
												self.Name.CompanyName            := rt.Prop_Recs_Part_Default_FDocs_CompanyName           ;
										));
								));
						));
						self.FIDType                                := rt.Prop_Recs_FIDType                           ;
						self.FIDTypeDesc                            := rt.Prop_Recs_FIDTypeDesc                       ;
						self.SortByDate                             := rt.Prop_Recs_SortByDate                        ;
						self.VendorSourceGlag                       := rt.Prop_Recs_VendorSourceGlag                  ;
						self.VendorSourceDesc                       := rt.Prop_Recs_VendorSourceDesc                  ;
						self.AccurintCurrentRecord                  := rt.Prop_Recs_AccurintCurrentRecord             ;
						self.Deeds.State                            := rt.Prop_Recs_Deed_State                        ;
						self.Deeds.CountyName                       := rt.Prop_Recs_Deed_CountyName                   ;
						self.Deeds.LenderName                       := rt.Prop_Recs_Deed_LenderName                   ;
						self.Deeds.LegalBriefDescription            := rt.Prop_Recs_Deed_LegalBriefDescription        ;
						self.Deeds.DocumentTypeCode                 := rt.Prop_Recs_Deed_DocumentTypeCode             ;
						self.Deeds.DocumentTypeDesc                 := rt.Prop_Recs_Deed_DocumentTypeDesc             ;
						self.Deeds.ArmResetDate                     := rt.Prop_Recs_Deed_ArmResetDate                 ;
						self.Deeds.DocumentNumber                   := rt.Prop_Recs_Deed_DocumentNumber               ;
						self.Deeds.RecorderBookNumber               := rt.Prop_Recs_Deed_RecorderBookNumber           ;
						self.Deeds.RecorderPageNumber               := rt.Prop_Recs_Deed_RecorderPageNumber           ;
						self.Deeds.LandLotSize                      := rt.Prop_Recs_Deed_LandLotSize                  ;
						self.Deeds.CityTransferTax                  := rt.Prop_Recs_Deed_CityTransferTax              ;
						self.Deeds.CountyTransferTax                := rt.Prop_Recs_Deed_CountyTransferTax            ;
						self.Deeds.TotalTransferTax                 := rt.Prop_Recs_Deed_TotalTransferTax             ;
						self.Deeds.PropertyUseCode                  := rt.Prop_Recs_Deed_PropertyUseCode              ;
						self.Deeds.PropertyUseDesc                  := rt.Prop_Recs_Deed_PropertyUseDesc              ;
						self.Deeds.FirstTdLoanAmount                := rt.Prop_Recs_Deed_FirstTdLoanAmount            ;
						self.Deeds.FirstTdLoanTypeCode              := rt.Prop_Recs_Deed_FirstTdLoanTypeCode          ;
						self.Deeds.FirstTdLoanTypeDesc              := rt.Prop_Recs_Deed_FirstTdLoanTypeDesc          ;
						self.Deeds.TypeFinancing                    := rt.Prop_Recs_Deed_TypeFinancing                ;
						self.Deeds.FirstTdInterestRate              := rt.Prop_Recs_Deed_FirstTdInterestRate          ;
						self.Deeds.FirstTdDueDate                   := rt.Prop_Recs_Deed_FirstTdDueDate               ;
						self.Deeds.TitleCompanyName                 := rt.Prop_Recs_Deed_TitleCompanyName             ;
						self.Deeds.FaresTransactionType             := rt.Prop_Recs_Deed_FaresTransactionType         ;
						self.Deeds.FaresTransactionTypeDesc         := rt.Prop_Recs_Deed_FaresTransactionTypeDesc     ;
						self.Deeds.FaresMortgageDeedType            := rt.Prop_Recs_Deed_FaresMortgageDeedType        ;
						self.Deeds.FaresMortgageDeedTypeDesc        := rt.Prop_Recs_Deed_FaresMortgageDeedTypeDesc    ;
						self.Deeds.FaresMortgageTermCode            := rt.Prop_Recs_Deed_FaresMortgageTermCode        ;
						self.Deeds.FaresMortgageTermCodeDesc        := rt.Prop_Recs_Deed_FaresMortgageTermCodeDesc    ;
						self.Deeds.FaresMortgageTerm                := rt.Prop_Recs_Deed_FaresMortgageTerm            ;
						self.Deeds.FaresIrisApn                     := rt.Prop_Recs_Deed_FaresIrisApn                 ;
						self.Accessor.StateCode                     := rt.Prop_Recs_Acc_StateCode                     ;
						self.Accessor.FipsCode                      := rt.Prop_Recs_Acc_FipsCode                      ;
						self.Accessor.DuplicateAPNMultipleAddressId := rt.Prop_Recs_Acc_DuplicateAPNMultipleAddressId ;
						self.Accessor.AssesseeOwnershipRightsCode   := rt.Prop_Recs_Acc_AssesseeOwnershipRightsCode   ;
						self.Accessor.AssesseeOwnershipRightsDesc   := rt.Prop_Recs_Acc_AssesseeOwnershipRightsDesc   ;
						self.Accessor.AssesseeRelationshipCode      := rt.Prop_Recs_Acc_AssesseeRelationshipCode      ;
						self.Accessor.AssesseeRelationshipDesc      := rt.Prop_Recs_Acc_AssesseeRelationshipDesc      ;
						self.Accessor.OwnerOccupied                 := rt.Prop_Recs_Acc_OwnerOccupied                 ;
						self.Accessor.PriorRecordingDate            := rt.Prop_Recs_Acc_PriorRecordingDate            ;
						self.Accessor.CountyLandUseDescription      := rt.Prop_Recs_Acc_CountyLandUseDescription      ;
						self.Accessor.StandardizedLandUseCode       := rt.Prop_Recs_Acc_StandardizedLandUseCode       ;
						self.Accessor.StandardizedLandUseDesc       := rt.Prop_Recs_Acc_StandardizedLandUseDesc       ;
						self.Accessor.LegalLotNumber                := rt.Prop_Recs_Acc_LegalLotNumber                ;
						self.Accessor.LegalSubdivisionName          := rt.Prop_Recs_Acc_LegalSubdivisionName          ;
						self.Accessor.RecordTypeCode                := rt.Prop_Recs_Acc_RecordTypeCode                ;
						self.Accessor.RecordTypeDesc                := rt.Prop_Recs_Acc_RecordTypeDesc                ;
						self.Accessor.MortgageLoanAmount            := rt.Prop_Recs_Acc_MortgageLoanAmount            ;
						self.Accessor.MortgageLoanTypeCode          := rt.Prop_Recs_Acc_MortgageLoanTypeCode          ;
						self.Accessor.MortgageLoanTypeDesc          := rt.Prop_Recs_Acc_MortgageLoanTypeDesc          ;
						self.Accessor.MortgageLenderName            := rt.Prop_Recs_Acc_MortgageLenderName            ;
						self.Accessor.AssessedTotalValue            := rt.Prop_Recs_Acc_AssessedTotalValue            ;
						self.Accessor.AssessedValueYear             := rt.Prop_Recs_Acc_AssessedValueYear             ;
						self.Accessor.HomesteadHomeownerExemption   := rt.Prop_Recs_Acc_HomesteadHomeownerExemption   ;
						self.Accessor.MarketImprovementValue        := rt.Prop_Recs_Acc_MarketImprovementValue        ;
						self.Accessor.MarketTotalValue              := rt.Prop_Recs_Acc_MarketTotalValue              ;
						self.Accessor.MarketValueYear               := rt.Prop_Recs_Acc_MarketValueYear               ;
						self.Accessor.TaxAmount                     := rt.Prop_Recs_Acc_TaxAmount                     ;
						self.Accessor.TaxYear                       := rt.Prop_Recs_Acc_TaxYear                       ;
						self.Accessor.LandSquareFootage             := rt.Prop_Recs_Acc_LandSquareFootage             ;
						self.Accessor.YearBuilt                     := rt.Prop_Recs_Acc_YearBuilt                     ;
						self.Accessor.NumberOfStories               := rt.Prop_Recs_Acc_NumberOfStories               ;
						self.Accessor.NumberOfStoriesDesc           := rt.Prop_Recs_Acc_NumberOfStoriesDesc           ;
						self.Accessor.NumberOfBedrooms              := rt.Prop_Recs_Acc_NumberOfBedrooms              ;
						self.Accessor.NumberOfBaths                 := rt.Prop_Recs_Acc_NumberOfBaths                 ;
						self.Accessor.NumberOfPartialBaths          := rt.Prop_Recs_Acc_NumberOfPartialBaths          ;
						self.Accessor.GarageTypeCode                := rt.Prop_Recs_Acc_GarageTypeCode                ;
						self.Accessor.PoolCode                      := rt.Prop_Recs_Acc_PoolCode                      ;
						self.Accessor.PoolDesc                      := rt.Prop_Recs_Acc_PoolDesc                      ;
						self.Accessor.ExteriorWallsCode             := rt.Prop_Recs_Acc_ExteriorWallsCode             ;
						self.Accessor.ExteriorWallsDesc             := rt.Prop_Recs_Acc_ExteriorWallsDesc             ;
						self.Accessor.RoofTypeCode                  := rt.Prop_Recs_Acc_RoofTypeCode                  ;
						self.Accessor.RoofTypeDesc                  := rt.Prop_Recs_Acc_RoofTypeDesc                  ;
						self.Accessor.HeatingCode                   := rt.Prop_Recs_Acc_HeatingCode                   ;
						self.Accessor.HeatingDesc                   := rt.Prop_Recs_Acc_HeatingDesc                   ;
						self.Accessor.HeatingFuelTypeCode           := rt.Prop_Recs_Acc_HeatingFuelTypeCode           ;
						self.Accessor.HeatingFuelTypeDesc           := rt.Prop_Recs_Acc_HeatingFuelTypeDesc           ;
						self.Accessor.AirConditioningCode           := rt.Prop_Recs_Acc_AirConditioningCode           ;
						self.Accessor.AirConditioningDesc           := rt.Prop_Recs_Acc_AirConditioningDesc           ;
						self.Accessor.AirConditioningTypeCode       := rt.Prop_Recs_Acc_AirConditioningTypeCode       ;
						self.Accessor.AirConditioningTypeDesc       := rt.Prop_Recs_Acc_AirConditioningTypeDesc       ;
						self.FaresLivingSquareFeet                  := rt.Prop_Recs_FaresLivingSquareFeet             ;
						self.PartyType                              := rt.Prop_Recs_PartyType                         ;
						self.PartyTypeName                          := rt.Prop_Recs_PartyTypeName                     ;
						self.Address.Address.StreetNumber           := rt.Prop_Recs_GeoAddr_StreetNumber              ;
						self.Address.Address.StreetPreDirection     := rt.Prop_Recs_GeoAddr_StreetPreDirection        ;
						self.Address.Address.StreetName             := rt.Prop_Recs_GeoAddr_StreetName                ;
						self.Address.Address.StreetSuffix           := rt.Prop_Recs_GeoAddr_StreetSuffix              ;
						self.Address.Address.StreetPostDirection    := rt.Prop_Recs_GeoAddr_StreetPostDirection       ;
						self.Address.Address.UnitDesignation        := rt.Prop_Recs_GeoAddr_UnitDesignation           ;
						self.Address.Address.UnitNumber             := rt.Prop_Recs_GeoAddr_UnitNumber                ;
						self.Address.Address.StreetAddress1         := rt.Prop_Recs_GeoAddr_StreetAddress1            ;
						self.Address.Address.StreetAddress2         := rt.Prop_Recs_GeoAddr_StreetAddress2            ;
						self.Address.Address.City                   := rt.Prop_Recs_GeoAddr_City                      ;
						self.Address.Address.State                  := rt.Prop_Recs_GeoAddr_State                     ;
						self.Address.Address.Zip5                   := rt.Prop_Recs_GeoAddr_Zip5                      ;
						self.Address.Address.Zip4                   := rt.Prop_Recs_GeoAddr_Zip4                      ;
						self.Address.Address.County                 := rt.Prop_Recs_GeoAddr_County                    ;
						self.Address.Address.PostalCode             := rt.Prop_Recs_GeoAddr_PostalCode                ;
						self.Address.Address.StateCityZip           := rt.Prop_Recs_GeoAddr_StateCityZip              ;
						self.Address.GeoLocationMatch.Latitude      := rt.Prop_Recs_Geo_Latitude                      ;
						self.Address.GeoLocationMatch.Longitude     := rt.Prop_Recs_Geo_Longitude                     ;
						self.Address.GeoLocationMatch.MatchCode     := rt.Prop_Recs_Geo_MatchCode                     ;
						self.Address.GeoLocationMatch.MatchDesc     := rt.Prop_Recs_Geo_MatchDesc                     ;
						self.MSA                                    := rt.Prop_Recs_MSA                               ;
						self.GeoBlk                                 := rt.Prop_Recs_GeoBlk                            ;
						self.GeoMatch                               := rt.Prop_Recs_GeoMatch                          ;
						self.Phone10                                := rt.Prop_Recs_Phone10                           ;
				));
				self.PropertyRecords.CurrentSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID           := rt.Prop_Recs_CurrDocs_DotID               ;
						self.BusinessIds.EmpID           := rt.Prop_Recs_CurrDocs_EmpID               ;
						self.BusinessIds.POWID           := rt.Prop_Recs_CurrDocs_POWID               ;
						self.BusinessIds.ProxID          := rt.Prop_Recs_CurrDocs_ProxID              ;
						self.BusinessIds.SeleID          := rt.Prop_Recs_CurrDocs_SeleID              ;
						self.BusinessIds.OrgID           := rt.Prop_Recs_CurrDocs_OrgID               ;
						self.BusinessIds.UltID           := rt.Prop_Recs_CurrDocs_UltID               ;
						self.IdType                      := rt.Prop_Recs_CurrDocs_IdType              ;
						self.IdValue                     := rt.Prop_Recs_CurrDocs_IdValue             ;
						self.Section                     := rt.Prop_Recs_CurrDocs_Section             ;
						self.Source                      := rt.Prop_Recs_CurrDocs_Source              ;
						self.Address.StreetNumber        := rt.Prop_Recs_CurrDocs_StreetNumber        ;
						self.Address.StreetPreDirection  := rt.Prop_Recs_CurrDocs_StreetPreDirection  ;
						self.Address.StreetName          := rt.Prop_Recs_CurrDocs_StreetName          ;
						self.Address.StreetSuffix        := rt.Prop_Recs_CurrDocs_StreetSuffix        ;
						self.Address.StreetPostDirection := rt.Prop_Recs_CurrDocs_StreetPostDirection ;
						self.Address.UnitDesignation     := rt.Prop_Recs_CurrDocs_UnitDesignation     ;
						self.Address.UnitNumber          := rt.Prop_Recs_CurrDocs_UnitNumber          ;
						self.Address.StreetAddress1      := rt.Prop_Recs_CurrDocs_StreetAddress1      ;
						self.Address.StreetAddress2      := rt.Prop_Recs_CurrDocs_StreetAddress2      ;
						self.Address.City                := rt.Prop_Recs_CurrDocs_City                ;
						self.Address.State               := rt.Prop_Recs_CurrDocs_State               ;
						self.Address.Zip5                := rt.Prop_Recs_CurrDocs_Zip5                ;
						self.Address.Zip4                := rt.Prop_Recs_CurrDocs_Zip4                ;
						self.Address.County              := rt.Prop_Recs_CurrDocs_County              ;
						self.Address.PostalCode          := rt.Prop_Recs_CurrDocs_PostalCode          ;
						self.Address.StateCityZip        := rt.Prop_Recs_CurrDocs_StateCityZip        ;
						self.Name.Full                   := rt.Prop_Recs_CurrDocs_Full                ;
						self.Name.First                  := rt.Prop_Recs_CurrDocs_First               ;
						self.Name.Middle                 := rt.Prop_Recs_CurrDocs_Middle              ;
						self.Name.Last                   := rt.Prop_Recs_CurrDocs_Last                ;
						self.Name.Suffix                 := rt.Prop_Recs_CurrDocs_Suffix              ;
						self.Name.Prefix                 := rt.Prop_Recs_CurrDocs_Prefix              ;
						self.Name.CompanyName            := rt.Prop_Recs_CurrDocs_CompanyName         ;
				));
				self.PropertyRecords.PriorSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID           := rt.Prop_Recs_PriorDocs_DotID               ;
						self.BusinessIds.EmpID           := rt.Prop_Recs_PriorDocs_EmpID               ;
						self.BusinessIds.POWID           := rt.Prop_Recs_PriorDocs_POWID               ;
						self.BusinessIds.ProxID          := rt.Prop_Recs_PriorDocs_ProxID              ;
						self.BusinessIds.SeleID          := rt.Prop_Recs_PriorDocs_SeleID              ;
						self.BusinessIds.OrgID           := rt.Prop_Recs_PriorDocs_OrgID               ;
						self.BusinessIds.UltID           := rt.Prop_Recs_PriorDocs_UltID               ;
						self.IdType                      := rt.Prop_Recs_PriorDocs_IdType              ;
						self.IdValue                     := rt.Prop_Recs_PriorDocs_IdValue             ;
						self.Section                     := rt.Prop_Recs_PriorDocs_Section             ;
						self.Source                      := rt.Prop_Recs_PriorDocs_Source              ;
						self.Address.StreetNumber        := rt.Prop_Recs_PriorDocs_StreetNumber        ;
						self.Address.StreetPreDirection  := rt.Prop_Recs_PriorDocs_StreetPreDirection  ;
						self.Address.StreetName          := rt.Prop_Recs_PriorDocs_StreetName          ;
						self.Address.StreetSuffix        := rt.Prop_Recs_PriorDocs_StreetSuffix        ;
						self.Address.StreetPostDirection := rt.Prop_Recs_PriorDocs_StreetPostDirection ;
						self.Address.UnitDesignation     := rt.Prop_Recs_PriorDocs_UnitDesignation     ;
						self.Address.UnitNumber          := rt.Prop_Recs_PriorDocs_UnitNumber          ;
						self.Address.StreetAddress1      := rt.Prop_Recs_PriorDocs_StreetAddress1      ;
						self.Address.StreetAddress2      := rt.Prop_Recs_PriorDocs_StreetAddress2      ;
						self.Address.City                := rt.Prop_Recs_PriorDocs_City                ;
						self.Address.State               := rt.Prop_Recs_PriorDocs_State               ;
						self.Address.Zip5                := rt.Prop_Recs_PriorDocs_Zip5                ;
						self.Address.Zip4                := rt.Prop_Recs_PriorDocs_Zip4                ;
						self.Address.County              := rt.Prop_Recs_PriorDocs_County              ;
						self.Address.PostalCode          := rt.Prop_Recs_PriorDocs_PostalCode          ;
						self.Address.StateCityZip        := rt.Prop_Recs_PriorDocs_StateCityZip        ;
						self.Name.Full                   := rt.Prop_Recs_PriorDocs_Full                ;
						self.Name.First                  := rt.Prop_Recs_PriorDocs_First               ;
						self.Name.Middle                 := rt.Prop_Recs_PriorDocs_Middle              ;
						self.Name.Last                   := rt.Prop_Recs_PriorDocs_Last                ;
						self.Name.Suffix                 := rt.Prop_Recs_PriorDocs_Suffix              ;
						self.Name.Prefix                 := rt.Prop_Recs_PriorDocs_Prefix              ;
						self.Name.CompanyName            := rt.Prop_Recs_PriorDocs_CompanyName         ;
				));
				self.PropertyRecords.DerogSummaryCntForeclosureNOD  := rt.Prop_Recs_DerogSummaryCntForeclosureNOD  ;
				self.PropertyRecords.ForeclosureNODRecordCount      := rt.Prop_Recs_ForeclosureNODRecordCount      ;
		));
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_Property := join(CR_UCC, Seed_Files.BusinessCreditReport_keys.TopBusProp,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_Property(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_MotorVehicle (working_layout le, Seed_Files.BusinessCreditReport_keys.TopBusMV rt) := transform
		self.TopBusinessRecord.MotorVehicleSection :=
			project(rt, transform(iesp.TopBusinessReport.t_TopBusinessMotorVehicleSection,
				self.MotorVehicleRecordCount      := rt.MV_MotorVehicleRecordCount      ;
				self.TotalMotorVehicleRecordCount := rt.MV_TotalMotorVehicleRecordCount ;
				self.MotorVehicleRecords.CurrentRecordCount      := rt.MV_Recs_CurrentRecordCount      ;
				self.MotorVehicleRecords.TotalCurrentRecordCount := rt.MV_Recs_TotalCurrentRecordCount ;
				self.MotorVehicleRecords.PriorRecordCount        := rt.MV_Recs_PriorRecordCount        ;
				self.MotorVehicleRecords.TotalPriorRecordCount   := rt.MV_Recs_TotalPriorRecordCount   ;
				self.MotorVehicleRecords.CurrentVehicles :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessMotorVehicleDetail,
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID             := rt.MV_Recs_Curr_Docs_DotID                 ;
								self.BusinessIds.EmpID             := rt.MV_Recs_Curr_Docs_EmpID                 ;
								self.BusinessIds.POWID             := rt.MV_Recs_Curr_Docs_POWID                 ;
								self.BusinessIds.ProxID            := rt.MV_Recs_Curr_Docs_ProxID                ;
								self.BusinessIds.SeleID            := rt.MV_Recs_Curr_Docs_SeleID                ;
								self.BusinessIds.OrgID             := rt.MV_Recs_Curr_Docs_OrgID                 ;
								self.BusinessIds.UltID             := rt.MV_Recs_Curr_Docs_UltID                 ;
								self.IdType                        := rt.MV_Recs_Curr_Docs_IdType                ;
								self.IdValue                       := rt.MV_Recs_Curr_Docs_IdValue               ;
								self.Section                       := rt.MV_Recs_Curr_Docs_Section               ;
								self.Source                        := rt.MV_Recs_Curr_Docs_Source                ;
								self.Address.StreetNumber          := rt.MV_Recs_Curr_Docs_StreetNumber          ;
								self.Address.StreetPreDirection    := rt.MV_Recs_Curr_Docs_StreetPreDirection    ;
								self.Address.StreetName            := rt.MV_Recs_Curr_Docs_StreetName            ;
								self.Address.StreetSuffix          := rt.MV_Recs_Curr_Docs_StreetSuffix          ;
								self.Address.StreetPostDirection   := rt.MV_Recs_Curr_Docs_StreetPostDirection   ;
								self.Address.UnitDesignation       := rt.MV_Recs_Curr_Docs_UnitDesignation       ;
								self.Address.UnitNumber            := rt.MV_Recs_Curr_Docs_UnitNumber            ;
								self.Address.StreetAddress1        := rt.MV_Recs_Curr_Docs_StreetAddress1        ;
								self.Address.StreetAddress2        := rt.MV_Recs_Curr_Docs_StreetAddress2        ;
								self.Address.City                  := rt.MV_Recs_Curr_Docs_City                  ;
								self.Address.State                 := rt.MV_Recs_Curr_Docs_State                 ;
								self.Address.Zip5                  := rt.MV_Recs_Curr_Docs_Zip5                  ;
								self.Address.Zip4                  := rt.MV_Recs_Curr_Docs_Zip4                  ;
								self.Address.County                := rt.MV_Recs_Curr_Docs_County                ;
								self.Address.PostalCode            := rt.MV_Recs_Curr_Docs_PostalCode            ;
								self.Address.StateCityZip          := rt.MV_Recs_Curr_Docs_StateCityZip          ;
								self.Name.Full                     := rt.MV_Recs_Curr_Docs_Full                  ;
								self.Name.First                    := rt.MV_Recs_Curr_Docs_First                 ;
								self.Name.Middle                   := rt.MV_Recs_Curr_Docs_Middle                ;
								self.Name.Last                     := rt.MV_Recs_Curr_Docs_Last                  ;
								self.Name.Suffix                   := rt.MV_Recs_Curr_Docs_Suffix                ;
								self.Name.Prefix                   := rt.MV_Recs_Curr_Docs_Prefix                ;
								self.Name.CompanyName              := rt.MV_Recs_Curr_Docs_CompanyName           ;
						));
						self.VIN                  := rt.MV_Recs_Curr_VIN                        ;
						self.VehicleType          := rt.MV_Recs_Curr_VehicleType                ;
						self.ModelYear            := rt.MV_Recs_Curr_ModelYear                  ;
						self.Make                 := rt.MV_Recs_Curr_Make                       ;
						self.Series               := rt.MV_Recs_Curr_Series                     ;
						self.Style                := rt.MV_Recs_Curr_Style                      ;
						self.BasePrice            := rt.MV_Recs_Curr_BasePrice                  ;
						self.StateOfOrigin        := rt.MV_Recs_Curr_StateOfOrigin              ;
						self.Color                := rt.MV_Recs_Curr_Color                      ;
						self.VehicleUse           := rt.MV_Recs_Curr_VehicleUse                 ;
						self.NumberOfCylinders    := rt.MV_Recs_Curr_NumberOfCylinders          ;
						self.EngineSize           := rt.MV_Recs_Curr_EngineSize                 ;
						self.FuelTypeName         := rt.MV_Recs_Curr_FuelTypeName               ;
						self.Restraints           := rt.MV_Recs_Curr_Restraints                 ;
						self.AntiLockBrakes       := rt.MV_Recs_Curr_AntiLockBrakes             ;
						self.AirConditioning      := rt.MV_Recs_Curr_AirConditioning            ;
						self.DaytimeRunningLights := rt.MV_Recs_Curr_DaytimeRunningLights       ;
						self.PowerSteering        := rt.MV_Recs_Curr_PowerSteering              ;
						self.PowerBrakes          := rt.MV_Recs_Curr_PowerBrakes                ;
						self.PowerWindows         := rt.MV_Recs_Curr_PowerWindows               ;
						self.SecuritySystem       := rt.MV_Recs_Curr_SecuritySystem             ;
						self.Roof                 := rt.MV_Recs_Curr_Roof                       ;
						self.Radio                := rt.MV_Recs_Curr_Radio                      ;
						self.FrontWheelDrive      := rt.MV_Recs_Curr_FrontWheelDrive            ;
						self.FourWheelDrive       := rt.MV_Recs_Curr_FourWheelDrive             ;
						self.TiltWheel            := rt.MV_Recs_Curr_TiltWheel                  ;
						self.NonDMVSource         := rt.MV_Recs_Curr_NonDMVSource               ;
						self.Parties :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessMotorVehicleParty,
								self.PartyTypeDescription             := rt.MV_Recs_Curr_Part_PartyTypeDescription  ;
								self.CompanyName                      := rt.MV_Recs_Curr_Part_CompanyName           ;
								self.Name.Full                        := rt.MV_Recs_Curr_Part_Full                  ;
								self.Name.First                       := rt.MV_Recs_Curr_Part_First                 ;
								self.Name.Middle                      := rt.MV_Recs_Curr_Part_Middle                ;
								self.Name.Last                        := rt.MV_Recs_Curr_Part_Last                  ;
								self.Name.Suffix                      := rt.MV_Recs_Curr_Part_Suffix                ;
								self.Name.Prefix                      := rt.MV_Recs_Curr_Part_Prefix                ;
								self.Address.StreetNumber             := rt.MV_Recs_Curr_Part_StreetNumber          ;
								self.Address.StreetPreDirection       := rt.MV_Recs_Curr_Part_StreetPreDirection    ;
								self.Address.StreetName               := rt.MV_Recs_Curr_Part_StreetName            ;
								self.Address.StreetSuffix             := rt.MV_Recs_Curr_Part_StreetSuffix          ;
								self.Address.StreetPostDirection      := rt.MV_Recs_Curr_Part_StreetPostDirection   ;
								self.Address.UnitDesignation          := rt.MV_Recs_Curr_Part_UnitDesignation       ;
								self.Address.UnitNumber               := rt.MV_Recs_Curr_Part_UnitNumber            ;
								self.Address.StreetAddress1           := rt.MV_Recs_Curr_Part_StreetAddress1        ;
								self.Address.StreetAddress2           := rt.MV_Recs_Curr_Part_StreetAddress2        ;
								self.Address.City                     := rt.MV_Recs_Curr_Part_City                  ;
								self.Address.State                    := rt.MV_Recs_Curr_Part_State                 ;
								self.Address.Zip5                     := rt.MV_Recs_Curr_Part_Zip5                  ;
								self.Address.Zip4                     := rt.MV_Recs_Curr_Part_Zip4                  ;
								self.Address.County                   := rt.MV_Recs_Curr_Part_County                ;
								self.Address.PostalCode               := rt.MV_Recs_Curr_Part_PostalCode            ;
								self.Address.StateCityZip             := rt.MV_Recs_Curr_Part_StateCityZip          ;
								self.TitleNumber                      := rt.MV_Recs_Curr_Part_TitleNumber           ;
								self.TitleDate.Year                   := rt.MV_Recs_Curr_Part_Title_Year            ;
								self.TitleDate.Month                  := rt.MV_Recs_Curr_Part_Title_Month           ;
								self.TitleDate.Day                    := rt.MV_Recs_Curr_Part_Title_Day             ;
								self.OriginalRegistrationDate.Year    := rt.MV_Recs_Curr_Part_OrigReg_Year          ;
								self.OriginalRegistrationDate.Month   := rt.MV_Recs_Curr_Part_OrigReg_Month         ;
								self.OriginalRegistrationDate.Day     := rt.MV_Recs_Curr_Part_OrigReg_Day           ;
								self.RegistrationDate.Year            := rt.MV_Recs_Curr_Part_Reg_Year              ;
								self.RegistrationDate.Month           := rt.MV_Recs_Curr_Part_Reg_Month             ;
								self.RegistrationDate.Day             := rt.MV_Recs_Curr_Part_Reg_Day               ;
								self.RegistrationExpirationDate.Year  := rt.MV_Recs_Curr_Part_RegExp_Year           ;
								self.RegistrationExpirationDate.Month := rt.MV_Recs_Curr_Part_RegExp_Month          ;
								self.RegistrationExpirationDate.Day   := rt.MV_Recs_Curr_Part_RegExp_Day            ;
								self.LicensePlate                     := rt.MV_Recs_Curr_Part_LicensePlate          ;
								self.LicensePlateState                := rt.MV_Recs_Curr_Part_LicensePlateState     ;
								self.LicensePlateType                 := rt.MV_Recs_Curr_Part_LicensePlateType      ;
								self.PreviousLicensePlate             := rt.MV_Recs_Curr_Part_PreviousLicensePlate  ;
								self.TitleStatus                      := rt.MV_Recs_Curr_Part_TitleStatus           ;
								self.OdometerMileage                  := rt.MV_Recs_Curr_Part_OdometerMileage       ;
								self.DecalYear                        := rt.MV_Recs_Curr_Part_DecalYear             ;
								self.SourceDateFirstSeen.Year         := rt.MV_Recs_Curr_Part_FSeen_Year            ;
								self.SourceDateFirstSeen.Month        := rt.MV_Recs_Curr_Part_FSeen_Month           ;
								self.SourceDateFirstSeen.Day          := rt.MV_Recs_Curr_Part_FSeen_Day             ;
								self.SourceDateLastSeen.Year          := rt.MV_Recs_Curr_Part_LSeen_Year            ;
								self.SourceDateLastSeen.Month         := rt.MV_Recs_Curr_Part_LSeen_Month           ;
								self.SourceDateLastSeen.Day           := rt.MV_Recs_Curr_Part_LSeen_Day             ;
						));
				));
				self.MotorVehicleRecords.CurrentSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID           := rt.MV_Recs_CurrDocs_DotID                  ;
						self.BusinessIds.EmpID           := rt.MV_Recs_CurrDocs_EmpID                  ;
						self.BusinessIds.POWID           := rt.MV_Recs_CurrDocs_POWID                  ;
						self.BusinessIds.ProxID          := rt.MV_Recs_CurrDocs_ProxID                 ;
						self.BusinessIds.SeleID          := rt.MV_Recs_CurrDocs_SeleID                 ;
						self.BusinessIds.OrgID           := rt.MV_Recs_CurrDocs_OrgID                  ;
						self.BusinessIds.UltID           := rt.MV_Recs_CurrDocs_UltID                  ;
						self.IdType                      := rt.MV_Recs_CurrDocs_IdType                 ;
						self.IdValue                     := rt.MV_Recs_CurrDocs_IdValue                ;
						self.Section                     := rt.MV_Recs_CurrDocs_Section                ;
						self.Source                      := rt.MV_Recs_CurrDocs_Source                 ;
						self.Address.StreetNumber        := rt.MV_Recs_CurrDocs_StreetNumber           ;
						self.Address.StreetPreDirection  := rt.MV_Recs_CurrDocs_StreetPreDirection     ;
						self.Address.StreetName          := rt.MV_Recs_CurrDocs_StreetName             ;
						self.Address.StreetSuffix        := rt.MV_Recs_CurrDocs_StreetSuffix           ;
						self.Address.StreetPostDirection := rt.MV_Recs_CurrDocs_StreetPostDirection    ;
						self.Address.UnitDesignation     := rt.MV_Recs_CurrDocs_UnitDesignation        ;
						self.Address.UnitNumber          := rt.MV_Recs_CurrDocs_UnitNumber             ;
						self.Address.StreetAddress1      := rt.MV_Recs_CurrDocs_StreetAddress1         ;
						self.Address.StreetAddress2      := rt.MV_Recs_CurrDocs_StreetAddress2         ;
						self.Address.City                := rt.MV_Recs_CurrDocs_City                   ;
						self.Address.State               := rt.MV_Recs_CurrDocs_State                  ;
						self.Address.Zip5                := rt.MV_Recs_CurrDocs_Zip5                   ;
						self.Address.Zip4                := rt.MV_Recs_CurrDocs_Zip4                   ;
						self.Address.County              := rt.MV_Recs_CurrDocs_County                 ;
						self.Address.PostalCode          := rt.MV_Recs_CurrDocs_PostalCode             ;
						self.Address.StateCityZip        := rt.MV_Recs_CurrDocs_StateCityZip           ;
						self.Name.Full                   := rt.MV_Recs_CurrDocs_Full                   ;
						self.Name.First                  := rt.MV_Recs_CurrDocs_First                  ;
						self.Name.Middle                 := rt.MV_Recs_CurrDocs_Middle                 ;
						self.Name.Last                   := rt.MV_Recs_CurrDocs_Last                   ;
						self.Name.Suffix                 := rt.MV_Recs_CurrDocs_Suffix                 ;
						self.Name.Prefix                 := rt.MV_Recs_CurrDocs_Prefix                 ;
						self.Name.CompanyName            := rt.MV_Recs_CurrDocs_CompanyName            ;
				));
				self.MotorVehicleRecords.PriorVehicles :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessMotorVehicleDetail,
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID               := rt.MV_Recs_Prior_Docs_DotID                ;
								self.BusinessIds.EmpID               := rt.MV_Recs_Prior_Docs_EmpID                ;
								self.BusinessIds.POWID               := rt.MV_Recs_Prior_Docs_POWID                ;
								self.BusinessIds.ProxID              := rt.MV_Recs_Prior_Docs_ProxID               ;
								self.BusinessIds.SeleID              := rt.MV_Recs_Prior_Docs_SeleID               ;
								self.BusinessIds.OrgID               := rt.MV_Recs_Prior_Docs_OrgID                ;
								self.BusinessIds.UltID               := rt.MV_Recs_Prior_Docs_UltID                ;
								self.IdType                          := rt.MV_Recs_Prior_Docs_IdType               ;
								self.IdValue                         := rt.MV_Recs_Prior_Docs_IdValue              ;
								self.Section                         := rt.MV_Recs_Prior_Docs_Section              ;
								self.Source                          := rt.MV_Recs_Prior_Docs_Source               ;
								self.Address.StreetNumber            := rt.MV_Recs_Prior_Docs_StreetNumber         ;
								self.Address.StreetPreDirection      := rt.MV_Recs_Prior_Docs_StreetPreDirection   ;
								self.Address.StreetName              := rt.MV_Recs_Prior_Docs_StreetName           ;
								self.Address.StreetSuffix            := rt.MV_Recs_Prior_Docs_StreetSuffix         ;
								self.Address.StreetPostDirection     := rt.MV_Recs_Prior_Docs_StreetPostDirection  ;
								self.Address.UnitDesignation         := rt.MV_Recs_Prior_Docs_UnitDesignation      ;
								self.Address.UnitNumber              := rt.MV_Recs_Prior_Docs_UnitNumber           ;
								self.Address.StreetAddress1          := rt.MV_Recs_Prior_Docs_StreetAddress1       ;
								self.Address.StreetAddress2          := rt.MV_Recs_Prior_Docs_StreetAddress2       ;
								self.Address.City                    := rt.MV_Recs_Prior_Docs_City                 ;
								self.Address.State                   := rt.MV_Recs_Prior_Docs_State                ;
								self.Address.Zip5                    := rt.MV_Recs_Prior_Docs_Zip5                 ;
								self.Address.Zip4                    := rt.MV_Recs_Prior_Docs_Zip4                 ;
								self.Address.County                  := rt.MV_Recs_Prior_Docs_County               ;
								self.Address.PostalCode              := rt.MV_Recs_Prior_Docs_PostalCode           ;
								self.Address.StateCityZip            := rt.MV_Recs_Prior_Docs_StateCityZip         ;
								self.Name.Full                       := rt.MV_Recs_Prior_Docs_Full                 ;
								self.Name.First                      := rt.MV_Recs_Prior_Docs_First                ;
								self.Name.Middle                     := rt.MV_Recs_Prior_Docs_Middle               ;
								self.Name.Last                       := rt.MV_Recs_Prior_Docs_Last                 ;
								self.Name.Suffix                     := rt.MV_Recs_Prior_Docs_Suffix               ;
								self.Name.Prefix                     := rt.MV_Recs_Prior_Docs_Prefix               ;
								self.Name.CompanyName                := rt.MV_Recs_Prior_Docs_CompanyName          ;
						));
						self.VIN                                           := rt.MV_Recs_Prior_VIN                       ;
						self.VehicleType                                   := rt.MV_Recs_Prior_VehicleType               ;
						self.ModelYear                                     := rt.MV_Recs_Prior_ModelYear                 ;
						self.Make                                          := rt.MV_Recs_Prior_Make                      ;
						self.Series                                        := rt.MV_Recs_Prior_Series                    ;
						self.Style                                         := rt.MV_Recs_Prior_Style                     ;
						self.BasePrice                                     := rt.MV_Recs_Prior_BasePrice                 ;
						self.StateOfOrigin                                 := rt.MV_Recs_Prior_StateOfOrigin             ;
						self.Color                                         := rt.MV_Recs_Prior_Color                     ;
						self.VehicleUse                                    := rt.MV_Recs_Prior_VehicleUse                ;
						self.NumberOfCylinders                             := rt.MV_Recs_Prior_NumberOfCylinders         ;
						self.EngineSize                                    := rt.MV_Recs_Prior_EngineSize                ;
						self.FuelTypeName                                  := rt.MV_Recs_Prior_FuelTypeName              ;
						self.Restraints                                    := rt.MV_Recs_Prior_Restraints                ;
						self.AntiLockBrakes                                := rt.MV_Recs_Prior_AntiLockBrakes            ;
						self.AirConditioning                               := rt.MV_Recs_Prior_AirConditioning           ;
						self.DaytimeRunningLights                          := rt.MV_Recs_Prior_DaytimeRunningLights      ;
						self.PowerSteering                                 := rt.MV_Recs_Prior_PowerSteering             ;
						self.PowerBrakes                                   := rt.MV_Recs_Prior_PowerBrakes               ;
						self.PowerWindows                                  := rt.MV_Recs_Prior_PowerWindows              ;
						self.SecuritySystem                                := rt.MV_Recs_Prior_SecuritySystem            ;
						self.Roof                                          := rt.MV_Recs_Prior_Roof                      ;
						self.Radio                                         := rt.MV_Recs_Prior_Radio                     ;
						self.FrontWheelDrive                               := rt.MV_Recs_Prior_FrontWheelDrive           ;
						self.FourWheelDrive                                := rt.MV_Recs_Prior_FourWheelDrive            ;
						self.TiltWheel                                     := rt.MV_Recs_Prior_TiltWheel                 ;
						self.NonDMVSource                                  := rt.MV_Recs_Prior_NonDMVSource              ;
						self.Parties :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessMotorVehicleParty,
								self.PartyTypeDescription               := rt.MV_Recs_Prior_Part_PartyTypeDescription ;
								self.CompanyName                        := rt.MV_Recs_Prior_Part_CompanyName          ;
								self.Name.Full                          := rt.MV_Recs_Prior_Part_Full                 ;
								self.Name.First                         := rt.MV_Recs_Prior_Part_First                ;
								self.Name.Middle                        := rt.MV_Recs_Prior_Part_Middle               ;
								self.Name.Last                          := rt.MV_Recs_Prior_Part_Last                 ;
								self.Name.Suffix                        := rt.MV_Recs_Prior_Part_Suffix               ;
								self.Name.Prefix                        := rt.MV_Recs_Prior_Part_Prefix               ;
								self.Address.StreetNumber               := rt.MV_Recs_Prior_Part_StreetNumber         ;
								self.Address.StreetPreDirection         := rt.MV_Recs_Prior_Part_StreetPreDirection   ;
								self.Address.StreetName                 := rt.MV_Recs_Prior_Part_StreetName           ;
								self.Address.StreetSuffix               := rt.MV_Recs_Prior_Part_StreetSuffix         ;
								self.Address.StreetPostDirection        := rt.MV_Recs_Prior_Part_StreetPostDirection  ;
								self.Address.UnitDesignation            := rt.MV_Recs_Prior_Part_UnitDesignation      ;
								self.Address.UnitNumber                 := rt.MV_Recs_Prior_Part_UnitNumber           ;
								self.Address.StreetAddress1             := rt.MV_Recs_Prior_Part_StreetAddress1       ;
								self.Address.StreetAddress2             := rt.MV_Recs_Prior_Part_StreetAddress2       ;
								self.Address.City                       := rt.MV_Recs_Prior_Part_City                 ;
								self.Address.State                      := rt.MV_Recs_Prior_Part_State                ;
								self.Address.Zip5                       := rt.MV_Recs_Prior_Part_Zip5                 ;
								self.Address.Zip4                       := rt.MV_Recs_Prior_Part_Zip4                 ;
								self.Address.County                     := rt.MV_Recs_Prior_Part_County               ;
								self.Address.PostalCode                 := rt.MV_Recs_Prior_Part_PostalCode           ;
								self.Address.StateCityZip               := rt.MV_Recs_Prior_Part_StateCityZip         ;
								self.TitleNumber                        := rt.MV_Recs_Prior_Part_TitleNumber          ;
								self.TitleDate.Year                     := rt.MV_Recs_Prior_Part_Title_Year           ;
								self.TitleDate.Month                    := rt.MV_Recs_Prior_Part_Title_Month          ;
								self.TitleDate.Day                      := rt.MV_Recs_Prior_Part_Title_Day            ;
								self.OriginalRegistrationDate.Year      := rt.MV_Recs_Prior_Part_OrigReg_Year         ;
								self.OriginalRegistrationDate.Month     := rt.MV_Recs_Prior_Part_OrigReg_Month        ;
								self.OriginalRegistrationDate.Day       := rt.MV_Recs_Prior_Part_OrigReg_Day          ;
								self.RegistrationDate.Year              := rt.MV_Recs_Prior_Part_Reg_Year             ;
								self.RegistrationDate.Month             := rt.MV_Recs_Prior_Part_Reg_Month            ;
								self.RegistrationDate.Day               := rt.MV_Recs_Prior_Part_Reg_Day              ;
								self.RegistrationExpirationDate.Year    := rt.MV_Recs_Prior_Part_RegExp_Year          ;
								self.RegistrationExpirationDate.Month   := rt.MV_Recs_Prior_Part_RegExp_Month         ;
								self.RegistrationExpirationDate.Day     := rt.MV_Recs_Prior_Part_RegExp_Day           ;
								self.LicensePlate                       := rt.MV_Recs_Prior_Part_LicensePlate         ;
								self.LicensePlateState                  := rt.MV_Recs_Prior_Part_LicensePlateState    ;
								self.LicensePlateType                   := rt.MV_Recs_Prior_Part_LicensePlateType     ;
								self.PreviousLicensePlate               := rt.MV_Recs_Prior_Part_PreviousLicensePlate ;
								self.TitleStatus                        := rt.MV_Recs_Prior_Part_TitleStatus          ;
								self.OdometerMileage                    := rt.MV_Recs_Prior_Part_OdometerMileage      ;
								self.DecalYear                          := rt.MV_Recs_Prior_Part_DecalYear            ;
								self.SourceDateFirstSeen.Year           := rt.MV_Recs_Prior_Part_FSeen_Year           ;
								self.SourceDateFirstSeen.Month          := rt.MV_Recs_Prior_Part_FSeen_Month          ;
								self.SourceDateFirstSeen.Day            := rt.MV_Recs_Prior_Part_FSeen_Day            ;
								self.SourceDateLastSeen.Year            := rt.MV_Recs_Prior_Part_LSeen_Year           ;
								self.SourceDateLastSeen.Month           := rt.MV_Recs_Prior_Part_LSeen_Month          ;
								self.SourceDateLastSeen.Day             := rt.MV_Recs_Prior_Part_LSeen_Day            ;
						));
				));
				self.MotorVehicleRecords.PriorSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID           := rt.MV_Recs_PriorDocs_DotID                 ;
						self.BusinessIds.EmpID           := rt.MV_Recs_PriorDocs_EmpID                 ;
						self.BusinessIds.POWID           := rt.MV_Recs_PriorDocs_POWID                 ;
						self.BusinessIds.ProxID          := rt.MV_Recs_PriorDocs_ProxID                ;
						self.BusinessIds.SeleID          := rt.MV_Recs_PriorDocs_SeleID                ;
						self.BusinessIds.OrgID           := rt.MV_Recs_PriorDocs_OrgID                 ;
						self.BusinessIds.UltID           := rt.MV_Recs_PriorDocs_UltID                 ;
						self.IdType                      := rt.MV_Recs_PriorDocs_IdType                ;
						self.IdValue                     := rt.MV_Recs_PriorDocs_IdValue               ;
						self.Section                     := rt.MV_Recs_PriorDocs_Section               ;
						self.Source                      := rt.MV_Recs_PriorDocs_Source                ;
						self.Address.StreetNumber        := rt.MV_Recs_PriorDocs_StreetNumber          ;
						self.Address.StreetPreDirection  := rt.MV_Recs_PriorDocs_StreetPreDirection    ;
						self.Address.StreetName          := rt.MV_Recs_PriorDocs_StreetName            ;
						self.Address.StreetSuffix        := rt.MV_Recs_PriorDocs_StreetSuffix          ;
						self.Address.StreetPostDirection := rt.MV_Recs_PriorDocs_StreetPostDirection   ;
						self.Address.UnitDesignation     := rt.MV_Recs_PriorDocs_UnitDesignation       ;
						self.Address.UnitNumber          := rt.MV_Recs_PriorDocs_UnitNumber            ;
						self.Address.StreetAddress1      := rt.MV_Recs_PriorDocs_StreetAddress1        ;
						self.Address.StreetAddress2      := rt.MV_Recs_PriorDocs_StreetAddress2        ;
						self.Address.City                := rt.MV_Recs_PriorDocs_City                  ;
						self.Address.State               := rt.MV_Recs_PriorDocs_State                 ;
						self.Address.Zip5                := rt.MV_Recs_PriorDocs_Zip5                  ;
						self.Address.Zip4                := rt.MV_Recs_PriorDocs_Zip4                  ;
						self.Address.County              := rt.MV_Recs_PriorDocs_County                ;
						self.Address.PostalCode          := rt.MV_Recs_PriorDocs_PostalCode            ;
						self.Address.StateCityZip        := rt.MV_Recs_PriorDocs_StateCityZip          ;
						self.Name.Full                   := rt.MV_Recs_PriorDocs_Full                  ;
						self.Name.First                  := rt.MV_Recs_PriorDocs_First                 ;
						self.Name.Middle                 := rt.MV_Recs_PriorDocs_Middle                ;
						self.Name.Last                   := rt.MV_Recs_PriorDocs_Last                  ;
						self.Name.Suffix                 := rt.MV_Recs_PriorDocs_Suffix                ;
						self.Name.Prefix                 := rt.MV_Recs_PriorDocs_Prefix                ;
						self.Name.CompanyName            := rt.MV_Recs_PriorDocs_CompanyName           ;
				));
		));
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_MotorVehicle := join(CR_Property, Seed_Files.BusinessCreditReport_keys.TopBusMV,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_MotorVehicle(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_WaterCraft (working_layout le, Seed_Files.BusinessCreditReport_keys.TopBusWCraft rt) := transform
		self.TopBusinessRecord.WatercraftSection := 
			project(rt, transform(iesp.TopBusinessReport.t_TopBusinessWatercraftSection,
				self.WatercraftRecordCount       := rt.WC_WatercraftRecordCount               ;
				self.TotalWatercraftRecordCount  := rt.WC_TotalWatercraftRecordCount          ;
				self.WatercraftRecords.CurrentRecordCount      := rt.WC_Recs_CurrentRecordCount             ;
				self.WatercraftRecords.TotalCurrentRecordCount := rt.WC_Recs_TotalCurrentRecordCount        ;
				self.WatercraftRecords.CurrentWatercrafts :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessWatercraftDetail,
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID                 := rt.WC_Recs_Curr_Docs_DotID                ;
								self.BusinessIds.EmpID                 := rt.WC_Recs_Curr_Docs_EmpID                ;
								self.BusinessIds.POWID                 := rt.WC_Recs_Curr_Docs_POWID                ;
								self.BusinessIds.ProxID                := rt.WC_Recs_Curr_Docs_ProxID               ;
								self.BusinessIds.SeleID                := rt.WC_Recs_Curr_Docs_SeleID               ;
								self.BusinessIds.OrgID                 := rt.WC_Recs_Curr_Docs_OrgID                ;
								self.BusinessIds.UltID                 := rt.WC_Recs_Curr_Docs_UltID                ;
								self.IdType                            := rt.WC_Recs_Curr_Docs_IdType               ;
								self.IdValue                           := rt.WC_Recs_Curr_Docs_IdValue              ;
								self.Section                           := rt.WC_Recs_Curr_Docs_Section              ;
								self.Source                            := rt.WC_Recs_Curr_Docs_Source               ;
								self.Address.StreetNumber              := rt.WC_Recs_Curr_Docs_StreetNumber         ;
								self.Address.StreetPreDirection        := rt.WC_Recs_Curr_Docs_StreetPreDirection   ;
								self.Address.StreetName                := rt.WC_Recs_Curr_Docs_StreetName           ;
								self.Address.StreetSuffix              := rt.WC_Recs_Curr_Docs_StreetSuffix         ;
								self.Address.StreetPostDirection       := rt.WC_Recs_Curr_Docs_StreetPostDirection  ;
								self.Address.UnitDesignation           := rt.WC_Recs_Curr_Docs_UnitDesignation      ;
								self.Address.UnitNumber                := rt.WC_Recs_Curr_Docs_UnitNumber           ;
								self.Address.StreetAddress1            := rt.WC_Recs_Curr_Docs_StreetAddress1       ;
								self.Address.StreetAddress2            := rt.WC_Recs_Curr_Docs_StreetAddress2       ;
								self.Address.City                      := rt.WC_Recs_Curr_Docs_City                 ;
								self.Address.State                     := rt.WC_Recs_Curr_Docs_State                ;
								self.Address.Zip5                      := rt.WC_Recs_Curr_Docs_Zip5                 ;
								self.Address.Zip4                      := rt.WC_Recs_Curr_Docs_Zip4                 ;
								self.Address.County                    := rt.WC_Recs_Curr_Docs_County               ;
								self.Address.PostalCode                := rt.WC_Recs_Curr_Docs_PostalCode           ;
								self.Address.StateCityZip              := rt.WC_Recs_Curr_Docs_StateCityZip         ;
								self.Name.Full                         := rt.WC_Recs_Curr_Docs_Full                 ;
								self.Name.First                        := rt.WC_Recs_Curr_Docs_First                ;
								self.Name.Middle                       := rt.WC_Recs_Curr_Docs_Middle               ;
								self.Name.Last                         := rt.WC_Recs_Curr_Docs_Last                 ;
								self.Name.Suffix                       := rt.WC_Recs_Curr_Docs_Suffix               ;
								self.Name.Prefix                       := rt.WC_Recs_Curr_Docs_Prefix               ;
								self.Name.CompanyName                  := rt.WC_Recs_Curr_Docs_CompanyName          ;
						));
						self.StateJurisdiction      := rt.WC_Recs_Curr_StateJurisdiction         ;
						self.HullNumber             := rt.WC_Recs_Curr_HullNumber                ;
						self.ModelYear              := rt.WC_Recs_Curr_ModelYear                 ;
						self.VesselMake             := rt.WC_Recs_Curr_VesselMake                ;
						self.VesselModel            := rt.WC_Recs_Curr_VesselModel               ;
						self.Propulsion             := rt.WC_Recs_Curr_Propulsion                ;
						self.Length                 := rt.WC_Recs_Curr_Length                    ;
						self.Use                    := rt.WC_Recs_Curr_Use                       ;
						self.VesselName             := rt.WC_Recs_Curr_VesselName                ;
						self.RegistrationStatus     := rt.WC_Recs_Curr_RegistrationStatus        ;
						self.RegistrationNumber     := rt.WC_Recs_Curr_RegistrationNumber        ;
						self.RegistrationDate.Year  := rt.WC_Recs_Curr_Reg_Year                  ;
						self.RegistrationDate.Month := rt.WC_Recs_Curr_Reg_Month                 ;
						self.RegistrationDate.Day   := rt.WC_Recs_Curr_Reg_Day                   ;
						self.ExpirationDate.Year    := rt.WC_Recs_Curr_Exp_Year                  ;
						self.ExpirationDate.Month   := rt.WC_Recs_Curr_Exp_Month                 ;
						self.ExpirationDate.Day     := rt.WC_Recs_Curr_Exp_Day                   ;
						self.NonDMVSource           := rt.WC_Recs_Curr_NonDMVSource              ;
						self.PriorParties :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessWatercraftParty,
								self.PartyTypeDescription            := rt.WC_Recs_Curr_PP_PartyTypeDescription   ;
								self.CompanyName                     := rt.WC_Recs_Curr_PP_CompanyName            ;
								self.Name.Full                       := rt.WC_Recs_Curr_PP_Full                   ;
								self.Name.First                      := rt.WC_Recs_Curr_PP_First                  ;
								self.Name.Middle                     := rt.WC_Recs_Curr_PP_Middle                 ;
								self.Name.Last                       := rt.WC_Recs_Curr_PP_Last                   ;
								self.Name.Suffix                     := rt.WC_Recs_Curr_PP_Suffix                 ;
								self.Name.Prefix                     := rt.WC_Recs_Curr_PP_Prefix                 ;
								self.Address.StreetNumber            := rt.WC_Recs_Curr_PP_StreetNumber           ;
								self.Address.StreetPreDirection      := rt.WC_Recs_Curr_PP_StreetPreDirection     ;
								self.Address.StreetName              := rt.WC_Recs_Curr_PP_StreetName             ;
								self.Address.StreetSuffix            := rt.WC_Recs_Curr_PP_StreetSuffix           ;
								self.Address.StreetPostDirection     := rt.WC_Recs_Curr_PP_StreetPostDirection    ;
								self.Address.UnitDesignation         := rt.WC_Recs_Curr_PP_UnitDesignation        ;
								self.Address.UnitNumber              := rt.WC_Recs_Curr_PP_UnitNumber             ;
								self.Address.StreetAddress1          := rt.WC_Recs_Curr_PP_StreetAddress1         ;
								self.Address.StreetAddress2          := rt.WC_Recs_Curr_PP_StreetAddress2         ;
								self.Address.City                    := rt.WC_Recs_Curr_PP_City                   ;
								self.Address.State                   := rt.WC_Recs_Curr_PP_State                  ;
								self.Address.Zip5                    := rt.WC_Recs_Curr_PP_Zip5                   ;
								self.Address.Zip4                    := rt.WC_Recs_Curr_PP_Zip4                   ;
								self.Address.County                  := rt.WC_Recs_Curr_PP_County                 ;
								self.Address.PostalCode              := rt.WC_Recs_Curr_PP_PostalCode             ;
								self.Address.StateCityZip            := rt.WC_Recs_Curr_PP_StateCityZip           ;
						));
						self.CurrentParties :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessWatercraftParty,
								self.PartyTypeDescription          := rt.WC_Recs_Curr_CP_PartyTypeDescription   ;
								self.CompanyName                   := rt.WC_Recs_Curr_CP_CompanyName            ;
								self.Name.Full                     := rt.WC_Recs_Curr_CP_Full                   ;
								self.Name.First                    := rt.WC_Recs_Curr_CP_First                  ;
								self.Name.Middle                   := rt.WC_Recs_Curr_CP_Middle                 ;
								self.Name.Last                     := rt.WC_Recs_Curr_CP_Last                   ;
								self.Name.Suffix                   := rt.WC_Recs_Curr_CP_Suffix                 ;
								self.Name.Prefix                   := rt.WC_Recs_Curr_CP_Prefix                 ;
								self.Address.StreetNumber          := rt.WC_Recs_Curr_CP_StreetNumber           ;
								self.Address.StreetPreDirection    := rt.WC_Recs_Curr_CP_StreetPreDirection     ;
								self.Address.StreetName            := rt.WC_Recs_Curr_CP_StreetName             ;
								self.Address.StreetSuffix          := rt.WC_Recs_Curr_CP_StreetSuffix           ;
								self.Address.StreetPostDirection   := rt.WC_Recs_Curr_CP_StreetPostDirection    ;
								self.Address.UnitDesignation       := rt.WC_Recs_Curr_CP_UnitDesignation        ;
								self.Address.UnitNumber            := rt.WC_Recs_Curr_CP_UnitNumber             ;
								self.Address.StreetAddress1        := rt.WC_Recs_Curr_CP_StreetAddress1         ;
								self.Address.StreetAddress2        := rt.WC_Recs_Curr_CP_StreetAddress2         ;
								self.Address.City                  := rt.WC_Recs_Curr_CP_City                   ;
								self.Address.State                 := rt.WC_Recs_Curr_CP_State                  ;
								self.Address.Zip5                  := rt.WC_Recs_Curr_CP_Zip5                   ;
								self.Address.Zip4                  := rt.WC_Recs_Curr_CP_Zip4                   ;
								self.Address.County                := rt.WC_Recs_Curr_CP_County                 ;
								self.Address.PostalCode            := rt.WC_Recs_Curr_CP_PostalCode             ;
								self.Address.StateCityZip          := rt.WC_Recs_Curr_CP_StateCityZip           ;
						));
				));
				self.WatercraftRecords.CurrentSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID           := rt.WC_Recs_CurrDocs_DotID                 ;
						self.BusinessIds.EmpID           := rt.WC_Recs_CurrDocs_EmpID                 ;
						self.BusinessIds.POWID           := rt.WC_Recs_CurrDocs_POWID                 ;
						self.BusinessIds.ProxID          := rt.WC_Recs_CurrDocs_ProxID                ;
						self.BusinessIds.SeleID          := rt.WC_Recs_CurrDocs_SeleID                ;
						self.BusinessIds.OrgID           := rt.WC_Recs_CurrDocs_OrgID                 ;
						self.BusinessIds.UltID           := rt.WC_Recs_CurrDocs_UltID                 ;
						self.IdType                      := rt.WC_Recs_CurrDocs_IdType                ;
						self.IdValue                     := rt.WC_Recs_CurrDocs_IdValue               ;
						self.Section                     := rt.WC_Recs_CurrDocs_Section               ;
						self.Source                      := rt.WC_Recs_CurrDocs_Source                ;
						self.Address.StreetNumber        := rt.WC_Recs_CurrDocs_StreetNumber          ;
						self.Address.StreetPreDirection  := rt.WC_Recs_CurrDocs_StreetPreDirection    ;
						self.Address.StreetName          := rt.WC_Recs_CurrDocs_StreetName            ;
						self.Address.StreetSuffix        := rt.WC_Recs_CurrDocs_StreetSuffix          ;
						self.Address.StreetPostDirection := rt.WC_Recs_CurrDocs_StreetPostDirection   ;
						self.Address.UnitDesignation     := rt.WC_Recs_CurrDocs_UnitDesignation       ;
						self.Address.UnitNumber          := rt.WC_Recs_CurrDocs_UnitNumber            ;
						self.Address.StreetAddress1      := rt.WC_Recs_CurrDocs_StreetAddress1        ;
						self.Address.StreetAddress2      := rt.WC_Recs_CurrDocs_StreetAddress2        ;
						self.Address.City                := rt.WC_Recs_CurrDocs_City                  ;
						self.Address.State               := rt.WC_Recs_CurrDocs_State                 ;
						self.Address.Zip5                := rt.WC_Recs_CurrDocs_Zip5                  ;
						self.Address.Zip4                := rt.WC_Recs_CurrDocs_Zip4                  ;
						self.Address.County              := rt.WC_Recs_CurrDocs_County                ;
						self.Address.PostalCode          := rt.WC_Recs_CurrDocs_PostalCode            ;
						self.Address.StateCityZip        := rt.WC_Recs_CurrDocs_StateCityZip          ;
						self.Name.Full                   := rt.WC_Recs_CurrDocs_Full                  ;
						self.Name.First                  := rt.WC_Recs_CurrDocs_First                 ;
						self.Name.Middle                 := rt.WC_Recs_CurrDocs_Middle                ;
						self.Name.Last                   := rt.WC_Recs_CurrDocs_Last                  ;
						self.Name.Suffix                 := rt.WC_Recs_CurrDocs_Suffix                ;
						self.Name.Prefix                 := rt.WC_Recs_CurrDocs_Prefix                ;
						self.Name.CompanyName            := rt.WC_Recs_CurrDocs_CompanyName           ;
				));
				self.WatercraftRecords.PriorRecordCount       := rt.WC_Recs_PriorRecordCount               ;
				self.WatercraftRecords.TotalPriorRecordCount  := rt.WC_Recs_TotalPriorRecordCount          ;
				self.WatercraftRecords.PriorWatercrafts :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessWatercraftDetail,
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID                   := rt.WC_Recs_Prior_Docs_DotID               ;
								self.BusinessIds.EmpID                   := rt.WC_Recs_Prior_Docs_EmpID               ;
								self.BusinessIds.POWID                   := rt.WC_Recs_Prior_Docs_POWID               ;
								self.BusinessIds.ProxID                  := rt.WC_Recs_Prior_Docs_ProxID              ;
								self.BusinessIds.SeleID                  := rt.WC_Recs_Prior_Docs_SeleID              ;
								self.BusinessIds.OrgID                   := rt.WC_Recs_Prior_Docs_OrgID               ;
								self.BusinessIds.UltID                   := rt.WC_Recs_Prior_Docs_UltID               ;
								self.IdType                              := rt.WC_Recs_Prior_Docs_IdType              ;
								self.IdValue                             := rt.WC_Recs_Prior_Docs_IdValue             ;
								self.Section                             := rt.WC_Recs_Prior_Docs_Section             ;
								self.Source                              := rt.WC_Recs_Prior_Docs_Source              ;
								self.Address.StreetNumber                := rt.WC_Recs_Prior_Docs_StreetNumber        ;
								self.Address.StreetPreDirection          := rt.WC_Recs_Prior_Docs_StreetPreDirection  ;
								self.Address.StreetName                  := rt.WC_Recs_Prior_Docs_StreetName          ;
								self.Address.StreetSuffix                := rt.WC_Recs_Prior_Docs_StreetSuffix        ;
								self.Address.StreetPostDirection         := rt.WC_Recs_Prior_Docs_StreetPostDirection ;
								self.Address.UnitDesignation             := rt.WC_Recs_Prior_Docs_UnitDesignation     ;
								self.Address.UnitNumber                  := rt.WC_Recs_Prior_Docs_UnitNumber          ;
								self.Address.StreetAddress1              := rt.WC_Recs_Prior_Docs_StreetAddress1      ;
								self.Address.StreetAddress2              := rt.WC_Recs_Prior_Docs_StreetAddress2      ;
								self.Address.City                        := rt.WC_Recs_Prior_Docs_City                ;
								self.Address.State                       := rt.WC_Recs_Prior_Docs_State               ;
								self.Address.Zip5                        := rt.WC_Recs_Prior_Docs_Zip5                ;
								self.Address.Zip4                        := rt.WC_Recs_Prior_Docs_Zip4                ;
								self.Address.County                      := rt.WC_Recs_Prior_Docs_County              ;
								self.Address.PostalCode                  := rt.WC_Recs_Prior_Docs_PostalCode          ;
								self.Address.StateCityZip                := rt.WC_Recs_Prior_Docs_StateCityZip        ;
								self.Name.Full                           := rt.WC_Recs_Prior_Docs_Full                ;
								self.Name.First                          := rt.WC_Recs_Prior_Docs_First               ;
								self.Name.Middle                         := rt.WC_Recs_Prior_Docs_Middle              ;
								self.Name.Last                           := rt.WC_Recs_Prior_Docs_Last                ;
								self.Name.Suffix                         := rt.WC_Recs_Prior_Docs_Suffix              ;
								self.Name.Prefix                         := rt.WC_Recs_Prior_Docs_Prefix              ;
								self.Name.CompanyName                    := rt.WC_Recs_Prior_Docs_CompanyName         ;
						));
						self.StateJurisdiction      := rt.WC_Recs_Prior_StateJurisdiction        ;
						self.HullNumber             := rt.WC_Recs_Prior_HullNumber               ;
						self.ModelYear              := rt.WC_Recs_Prior_ModelYear                ;
						self.VesselMake             := rt.WC_Recs_Prior_VesselMake               ;
						self.VesselModel            := rt.WC_Recs_Prior_VesselModel              ;
						self.Propulsion             := rt.WC_Recs_Prior_Propulsion               ;
						self.Length                 := rt.WC_Recs_Prior_Length                   ;
						self.Use                    := rt.WC_Recs_Prior_Use                      ;
						self.VesselName             := rt.WC_Recs_Prior_VesselName               ;
						self.RegistrationStatus     := rt.WC_Recs_Prior_RegistrationStatus       ;
						self.RegistrationNumber     := rt.WC_Recs_Prior_RegistrationNumber       ;
						self.RegistrationDate.Year  := rt.WC_Recs_Prior_Reg_Year                 ;
						self.RegistrationDate.Month := rt.WC_Recs_Prior_Reg_Month                ;
						self.RegistrationDate.Day   := rt.WC_Recs_Prior_Reg_Day                  ;
						self.ExpirationDate.Year    := rt.WC_Recs_Prior_Exp_Year                 ;
						self.ExpirationDate.Month   := rt.WC_Recs_Prior_Exp_Month                ;
						self.ExpirationDate.Day     := rt.WC_Recs_Prior_Exp_Day                  ;
						self.NonDMVSource           := rt.WC_Recs_Prior_NonDMVSource             ;
						self.PriorParties :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessWatercraftParty,
								self.PartyTypeDescription              := rt.WC_Recs_Prior_PP_PartyTypeDescription  ;
								self.CompanyName                       := rt.WC_Recs_Prior_PP_CompanyName           ;
								self.Name.Full                         := rt.WC_Recs_Prior_PP_Full                  ;
								self.Name.First                        := rt.WC_Recs_Prior_PP_First                 ;
								self.Name.Middle                       := rt.WC_Recs_Prior_PP_Middle                ;
								self.Name.Last                         := rt.WC_Recs_Prior_PP_Last                  ;
								self.Name.Suffix                       := rt.WC_Recs_Prior_PP_Suffix                ;
								self.Name.Prefix                       := rt.WC_Recs_Prior_PP_Prefix                ;
								self.Address.StreetNumber              := rt.WC_Recs_Prior_PP_StreetNumber          ;
								self.Address.StreetPreDirection        := rt.WC_Recs_Prior_PP_StreetPreDirection    ;
								self.Address.StreetName                := rt.WC_Recs_Prior_PP_StreetName            ;
								self.Address.StreetSuffix              := rt.WC_Recs_Prior_PP_StreetSuffix          ;
								self.Address.StreetPostDirection       := rt.WC_Recs_Prior_PP_StreetPostDirection   ;
								self.Address.UnitDesignation           := rt.WC_Recs_Prior_PP_UnitDesignation       ;
								self.Address.UnitNumber                := rt.WC_Recs_Prior_PP_UnitNumber            ;
								self.Address.StreetAddress1            := rt.WC_Recs_Prior_PP_StreetAddress1        ;
								self.Address.StreetAddress2            := rt.WC_Recs_Prior_PP_StreetAddress2        ;
								self.Address.City                      := rt.WC_Recs_Prior_PP_City                  ;
								self.Address.State                     := rt.WC_Recs_Prior_PP_State                 ;
								self.Address.Zip5                      := rt.WC_Recs_Prior_PP_Zip5                  ;
								self.Address.Zip4                      := rt.WC_Recs_Prior_PP_Zip4                  ;
								self.Address.County                    := rt.WC_Recs_Prior_PP_County                ;
								self.Address.PostalCode                := rt.WC_Recs_Prior_PP_PostalCode            ;
								self.Address.StateCityZip              := rt.WC_Recs_Prior_PP_StateCityZip          ;
						));
						self.CurrentParties :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessWatercraftParty,
								self.PartyTypeDescription            := rt.WC_Recs_Prior_CP_PartyTypeDescription  ;
								self.CompanyName                     := rt.WC_Recs_Prior_CP_CompanyName           ;
								self.Name.Full                       := rt.WC_Recs_Prior_CP_Full                  ;
								self.Name.First                      := rt.WC_Recs_Prior_CP_First                 ;
								self.Name.Middle                     := rt.WC_Recs_Prior_CP_Middle                ;
								self.Name.Last                       := rt.WC_Recs_Prior_CP_Last                  ;
								self.Name.Suffix                     := rt.WC_Recs_Prior_CP_Suffix                ;
								self.Name.Prefix                     := rt.WC_Recs_Prior_CP_Prefix                ;
								self.Address.StreetNumber            := rt.WC_Recs_Prior_CP_StreetNumber          ;
								self.Address.StreetPreDirection      := rt.WC_Recs_Prior_CP_StreetPreDirection    ;
								self.Address.StreetName              := rt.WC_Recs_Prior_CP_StreetName            ;
								self.Address.StreetSuffix            := rt.WC_Recs_Prior_CP_StreetSuffix          ;
								self.Address.StreetPostDirection     := rt.WC_Recs_Prior_CP_StreetPostDirection   ;
								self.Address.UnitDesignation         := rt.WC_Recs_Prior_CP_UnitDesignation       ;
								self.Address.UnitNumber              := rt.WC_Recs_Prior_CP_UnitNumber            ;
								self.Address.StreetAddress1          := rt.WC_Recs_Prior_CP_StreetAddress1        ;
								self.Address.StreetAddress2          := rt.WC_Recs_Prior_CP_StreetAddress2        ;
								self.Address.City                    := rt.WC_Recs_Prior_CP_City                  ;
								self.Address.State                   := rt.WC_Recs_Prior_CP_State                 ;
								self.Address.Zip5                    := rt.WC_Recs_Prior_CP_Zip5                  ;
								self.Address.Zip4                    := rt.WC_Recs_Prior_CP_Zip4                  ;
								self.Address.County                  := rt.WC_Recs_Prior_CP_County                ;
								self.Address.PostalCode              := rt.WC_Recs_Prior_CP_PostalCode            ;
								self.Address.StateCityZip            := rt.WC_Recs_Prior_CP_StateCityZip          ;
						));
				));
				self.WatercraftRecords.PriorSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID           := rt.WC_Recs_PriorDocs_DotID                ;
						self.BusinessIds.EmpID           := rt.WC_Recs_PriorDocs_EmpID                ;
						self.BusinessIds.POWID           := rt.WC_Recs_PriorDocs_POWID                ;
						self.BusinessIds.ProxID          := rt.WC_Recs_PriorDocs_ProxID               ;
						self.BusinessIds.SeleID          := rt.WC_Recs_PriorDocs_SeleID               ;
						self.BusinessIds.OrgID           := rt.WC_Recs_PriorDocs_OrgID                ;
						self.BusinessIds.UltID           := rt.WC_Recs_PriorDocs_UltID                ;
						self.IdType                      := rt.WC_Recs_PriorDocs_IdType               ;
						self.IdValue                     := rt.WC_Recs_PriorDocs_IdValue              ;
						self.Section                     := rt.WC_Recs_PriorDocs_Section              ;
						self.Source                      := rt.WC_Recs_PriorDocs_Source               ;
						self.Address.StreetNumber        := rt.WC_Recs_PriorDocs_StreetNumber         ;
						self.Address.StreetPreDirection  := rt.WC_Recs_PriorDocs_StreetPreDirection   ;
						self.Address.StreetName          := rt.WC_Recs_PriorDocs_StreetName           ;
						self.Address.StreetSuffix        := rt.WC_Recs_PriorDocs_StreetSuffix         ;
						self.Address.StreetPostDirection := rt.WC_Recs_PriorDocs_StreetPostDirection  ;
						self.Address.UnitDesignation     := rt.WC_Recs_PriorDocs_UnitDesignation      ;
						self.Address.UnitNumber          := rt.WC_Recs_PriorDocs_UnitNumber           ;
						self.Address.StreetAddress1      := rt.WC_Recs_PriorDocs_StreetAddress1       ;
						self.Address.StreetAddress2      := rt.WC_Recs_PriorDocs_StreetAddress2       ;
						self.Address.City                := rt.WC_Recs_PriorDocs_City                 ;
						self.Address.State               := rt.WC_Recs_PriorDocs_State                ;
						self.Address.Zip5                := rt.WC_Recs_PriorDocs_Zip5                 ;
						self.Address.Zip4                := rt.WC_Recs_PriorDocs_Zip4                 ;
						self.Address.County              := rt.WC_Recs_PriorDocs_County               ;
						self.Address.PostalCode          := rt.WC_Recs_PriorDocs_PostalCode           ;
						self.Address.StateCityZip        := rt.WC_Recs_PriorDocs_StateCityZip         ;
						self.Name.Full                   := rt.WC_Recs_PriorDocs_Full                 ;
						self.Name.First                  := rt.WC_Recs_PriorDocs_First                ;
						self.Name.Middle                 := rt.WC_Recs_PriorDocs_Middle               ;
						self.Name.Last                   := rt.WC_Recs_PriorDocs_Last                 ;
						self.Name.Suffix                 := rt.WC_Recs_PriorDocs_Suffix               ;
						self.Name.Prefix                 := rt.WC_Recs_PriorDocs_Prefix               ;
						self.Name.CompanyName            := rt.WC_Recs_PriorDocs_CompanyName          ;
				));
		));
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_WaterCraft := join(CR_MotorVehicle, Seed_Files.BusinessCreditReport_keys.TopBusWCraft,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_WaterCraft(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_AirCraft (working_layout le, Seed_Files.BusinessCreditReport_keys.TopBusACraft rt) := transform
		self.TopBusinessRecord.AircraftSection :=
			project(rt, transform(iesp.TopBusinessReport.t_TopBusinessAircraftSection,
				self.AircraftRecordCount        := rt.AC_AircraftRecordCount      ;
				self.TotalAircraftRecordCount   := rt.AC_TotalAircraftRecordCount ;
				self.AircraftRecords.CurrentRecordCount       := rt.AC_Recs_CurrentRecordCount      ;
				self.AircraftRecords.TotalCurrentRecordCount  := rt.AC_Recs_TotalCurrentRecordCount ;
				self.AircraftRecords.CurrentAircrafts :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessAircraft,
						self.AircraftNumber                             := rt.AC_Recs_Curr_AircraftNumber            ;
						self.ModelYear                                  := rt.AC_Recs_Curr_ModelYear                 ;
						self.Manufacturer                               := rt.AC_Recs_Curr_Manufacturer              ;
						self.Model                                      := rt.AC_Recs_Curr_Model                     ;
						self.AircraftType                               := rt.AC_Recs_Curr_AircraftType              ;
						self.SerialNumber                               := rt.AC_Recs_Curr_SerialNumber              ;
						self.Engines                                    := rt.AC_Recs_Curr_Engines                   ;
						self.RegistrationDate.Year                      := rt.AC_Recs_Curr_Reg_Year                  ;
						self.RegistrationDate.Month                     := rt.AC_Recs_Curr_Reg_Month                 ;
						self.RegistrationDate.Day                       := rt.AC_Recs_Curr_Reg_Day                   ;
						self.RegistrationNumber                         := rt.AC_Recs_Curr_RegistrationNumber        ;
						self.RegistrationAddress.StreetNumber           := rt.AC_Recs_Curr_StreetNumber              ;
						self.RegistrationAddress.StreetPreDirection     := rt.AC_Recs_Curr_StreetPreDirection        ;
						self.RegistrationAddress.StreetName             := rt.AC_Recs_Curr_StreetName                ;
						self.RegistrationAddress.StreetSuffix           := rt.AC_Recs_Curr_StreetSuffix              ;
						self.RegistrationAddress.StreetPostDirection    := rt.AC_Recs_Curr_StreetPostDirection       ;
						self.RegistrationAddress.UnitDesignation        := rt.AC_Recs_Curr_UnitDesignation           ;
						self.RegistrationAddress.UnitNumber             := rt.AC_Recs_Curr_UnitNumber                ;
						self.RegistrationAddress.StreetAddress1         := rt.AC_Recs_Curr_StreetAddress1            ;
						self.RegistrationAddress.StreetAddress2         := rt.AC_Recs_Curr_StreetAddress2            ;
						self.RegistrationAddress.City                   := rt.AC_Recs_Curr_City                      ;
						self.RegistrationAddress.State                  := rt.AC_Recs_Curr_State                     ;
						self.RegistrationAddress.Zip5                   := rt.AC_Recs_Curr_Zip5                      ;
						self.RegistrationAddress.Zip4                   := rt.AC_Recs_Curr_Zip4                      ;
						self.RegistrationAddress.County                 := rt.AC_Recs_Curr_County                    ;
						self.RegistrationAddress.PostalCode             := rt.AC_Recs_Curr_PostalCode                ;
						self.RegistrationAddress.StateCityZip           := rt.AC_Recs_Curr_StateCityZip              ;
						self.CurrentParties :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessAircraftParty,
								self.SerialNumber                := rt.AC_Recs_Curr_CP_SerialNumber           ;
								self.RegistrationDate.Year       := rt.AC_Recs_Curr_CP_Reg_Year               ;
								self.RegistrationDate.Month      := rt.AC_Recs_Curr_CP_Reg_Month              ;
								self.RegistrationDate.Day        := rt.AC_Recs_Curr_CP_Reg_Day                ;
								self.CompanyName                 := rt.AC_Recs_Curr_CP_CompanyName            ;
								self.Name.Full                   := rt.AC_Recs_Curr_CP_Full                   ;
								self.Name.First                  := rt.AC_Recs_Curr_CP_First                  ;
								self.Name.Middle                 := rt.AC_Recs_Curr_CP_Middle                 ;
								self.Name.Last                   := rt.AC_Recs_Curr_CP_Last                   ;
								self.Name.Suffix                 := rt.AC_Recs_Curr_CP_Suffix                 ;
								self.Name.Prefix                 := rt.AC_Recs_Curr_CP_Prefix                 ;
								self.Address.StreetNumber        := rt.AC_Recs_Curr_CP_StreetNumber           ;
								self.Address.StreetPreDirection  := rt.AC_Recs_Curr_CP_StreetPreDirection     ;
								self.Address.StreetName          := rt.AC_Recs_Curr_CP_StreetName             ;
								self.Address.StreetSuffix        := rt.AC_Recs_Curr_CP_StreetSuffix           ;
								self.Address.StreetPostDirection := rt.AC_Recs_Curr_CP_StreetPostDirection    ;
								self.Address.UnitDesignation     := rt.AC_Recs_Curr_CP_UnitDesignation        ;
								self.Address.UnitNumber          := rt.AC_Recs_Curr_CP_UnitNumber             ;
								self.Address.StreetAddress1      := rt.AC_Recs_Curr_CP_StreetAddress1         ;
								self.Address.StreetAddress2      := rt.AC_Recs_Curr_CP_StreetAddress2         ;
								self.Address.City                := rt.AC_Recs_Curr_CP_City                   ;
								self.Address.State               := rt.AC_Recs_Curr_CP_State                  ;
								self.Address.Zip5                := rt.AC_Recs_Curr_CP_Zip5                   ;
								self.Address.Zip4                := rt.AC_Recs_Curr_CP_Zip4                   ;
								self.Address.County              := rt.AC_Recs_Curr_CP_County                 ;
								self.Address.PostalCode          := rt.AC_Recs_Curr_CP_PostalCode             ;
								self.Address.StateCityZip        := rt.AC_Recs_Curr_CP_StateCityZip           ;
						));
						self.PriorParties :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessAircraftParty,
								self.SerialNumber                  := rt.AC_Recs_Curr_PP_SerialNumber           ;
								self.RegistrationDate.Year         := rt.AC_Recs_Curr_PP_Reg_Year               ;
								self.RegistrationDate.Month        := rt.AC_Recs_Curr_PP_Reg_Month              ;
								self.RegistrationDate.Day          := rt.AC_Recs_Curr_PP_Reg_Day                ;
								self.CompanyName                   := rt.AC_Recs_Curr_PP_CompanyName            ;
								self.Name.Full                     := rt.AC_Recs_Curr_PP_Full                   ;
								self.Name.First                    := rt.AC_Recs_Curr_PP_First                  ;
								self.Name.Middle                   := rt.AC_Recs_Curr_PP_Middle                 ;
								self.Name.Last                     := rt.AC_Recs_Curr_PP_Last                   ;
								self.Name.Suffix                   := rt.AC_Recs_Curr_PP_Suffix                 ;
								self.Name.Prefix                   := rt.AC_Recs_Curr_PP_Prefix                 ;
								self.Address.StreetNumber          := rt.AC_Recs_Curr_PP_StreetNumber           ;
								self.Address.StreetPreDirection    := rt.AC_Recs_Curr_PP_StreetPreDirection     ;
								self.Address.StreetName            := rt.AC_Recs_Curr_PP_StreetName             ;
								self.Address.StreetSuffix          := rt.AC_Recs_Curr_PP_StreetSuffix           ;
								self.Address.StreetPostDirection   := rt.AC_Recs_Curr_PP_StreetPostDirection    ;
								self.Address.UnitDesignation       := rt.AC_Recs_Curr_PP_UnitDesignation        ;
								self.Address.UnitNumber            := rt.AC_Recs_Curr_PP_UnitNumber             ;
								self.Address.StreetAddress1        := rt.AC_Recs_Curr_PP_StreetAddress1         ;
								self.Address.StreetAddress2        := rt.AC_Recs_Curr_PP_StreetAddress2         ;
								self.Address.City                  := rt.AC_Recs_Curr_PP_City                   ;
								self.Address.State                 := rt.AC_Recs_Curr_PP_State                  ;
								self.Address.Zip5                  := rt.AC_Recs_Curr_PP_Zip5                   ;
								self.Address.Zip4                  := rt.AC_Recs_Curr_PP_Zip4                   ;
								self.Address.County                := rt.AC_Recs_Curr_PP_County                 ;
								self.Address.PostalCode            := rt.AC_Recs_Curr_PP_PostalCode             ;
								self.Address.StateCityZip          := rt.AC_Recs_Curr_PP_StateCityZip           ;
						));
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID            := rt.AC_Recs_Curr_Docs_DotID                ;
								self.BusinessIds.EmpID            := rt.AC_Recs_Curr_Docs_EmpID                ;
								self.BusinessIds.POWID            := rt.AC_Recs_Curr_Docs_POWID                ;
								self.BusinessIds.ProxID           := rt.AC_Recs_Curr_Docs_ProxID               ;
								self.BusinessIds.SeleID           := rt.AC_Recs_Curr_Docs_SeleID               ;
								self.BusinessIds.OrgID            := rt.AC_Recs_Curr_Docs_OrgID                ;
								self.BusinessIds.UltID            := rt.AC_Recs_Curr_Docs_UltID                ;
								self.IdType                       := rt.AC_Recs_Curr_Docs_IdType               ;
								self.IdValue                      := rt.AC_Recs_Curr_Docs_IdValue              ;
								self.Section                      := rt.AC_Recs_Curr_Docs_Section              ;
								self.Source                       := rt.AC_Recs_Curr_Docs_Source               ;
								self.Address.StreetNumber         := rt.AC_Recs_Curr_Docs_StreetNumber         ;
								self.Address.StreetPreDirection   := rt.AC_Recs_Curr_Docs_StreetPreDirection   ;
								self.Address.StreetName           := rt.AC_Recs_Curr_Docs_StreetName           ;
								self.Address.StreetSuffix         := rt.AC_Recs_Curr_Docs_StreetSuffix         ;
								self.Address.StreetPostDirection  := rt.AC_Recs_Curr_Docs_StreetPostDirection  ;
								self.Address.UnitDesignation      := rt.AC_Recs_Curr_Docs_UnitDesignation      ;
								self.Address.UnitNumber           := rt.AC_Recs_Curr_Docs_UnitNumber           ;
								self.Address.StreetAddress1       := rt.AC_Recs_Curr_Docs_StreetAddress1       ;
								self.Address.StreetAddress2       := rt.AC_Recs_Curr_Docs_StreetAddress2       ;
								self.Address.City                 := rt.AC_Recs_Curr_Docs_City                 ;
								self.Address.State                := rt.AC_Recs_Curr_Docs_State                ;
								self.Address.Zip5                 := rt.AC_Recs_Curr_Docs_Zip5                 ;
								self.Address.Zip4                 := rt.AC_Recs_Curr_Docs_Zip4                 ;
								self.Address.County               := rt.AC_Recs_Curr_Docs_County               ;
								self.Address.PostalCode           := rt.AC_Recs_Curr_Docs_PostalCode           ;
								self.Address.StateCityZip         := rt.AC_Recs_Curr_Docs_StateCityZip         ;
								self.Name.Full                    := rt.AC_Recs_Curr_Docs_Full                 ;
								self.Name.First                   := rt.AC_Recs_Curr_Docs_First                ;
								self.Name.Middle                  := rt.AC_Recs_Curr_Docs_Middle               ;
								self.Name.Last                    := rt.AC_Recs_Curr_Docs_Last                 ;
								self.Name.Suffix                  := rt.AC_Recs_Curr_Docs_Suffix               ;
								self.Name.Prefix                  := rt.AC_Recs_Curr_Docs_Prefix               ;
								self.Name.CompanyName             := rt.AC_Recs_Curr_Docs_CompanyName          ;
						));
				));
				self.AircraftRecords.CurrentSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID                         := rt.AC_Recs_CurrDocs_DotID                 ;
						self.BusinessIds.EmpID                         := rt.AC_Recs_CurrDocs_EmpID                 ;
						self.BusinessIds.POWID                         := rt.AC_Recs_CurrDocs_POWID                 ;
						self.BusinessIds.ProxID                        := rt.AC_Recs_CurrDocs_ProxID                ;
						self.BusinessIds.SeleID                        := rt.AC_Recs_CurrDocs_SeleID                ;
						self.BusinessIds.OrgID                         := rt.AC_Recs_CurrDocs_OrgID                 ;
						self.BusinessIds.UltID                         := rt.AC_Recs_CurrDocs_UltID                 ;
						self.IdType                                    := rt.AC_Recs_CurrDocs_IdType                ;
						self.IdValue                                   := rt.AC_Recs_CurrDocs_IdValue               ;
						self.Section                                   := rt.AC_Recs_CurrDocs_Section               ;
						self.Source                                    := rt.AC_Recs_CurrDocs_Source                ;
						self.Address.StreetNumber                      := rt.AC_Recs_CurrDocs_StreetNumber          ;
						self.Address.StreetPreDirection                := rt.AC_Recs_CurrDocs_StreetPreDirection    ;
						self.Address.StreetName                        := rt.AC_Recs_CurrDocs_StreetName            ;
						self.Address.StreetSuffix                      := rt.AC_Recs_CurrDocs_StreetSuffix          ;
						self.Address.StreetPostDirection               := rt.AC_Recs_CurrDocs_StreetPostDirection   ;
						self.Address.UnitDesignation                   := rt.AC_Recs_CurrDocs_UnitDesignation       ;
						self.Address.UnitNumber                        := rt.AC_Recs_CurrDocs_UnitNumber            ;
						self.Address.StreetAddress1                    := rt.AC_Recs_CurrDocs_StreetAddress1        ;
						self.Address.StreetAddress2                    := rt.AC_Recs_CurrDocs_StreetAddress2        ;
						self.Address.City                              := rt.AC_Recs_CurrDocs_City                  ;
						self.Address.State                             := rt.AC_Recs_CurrDocs_State                 ;
						self.Address.Zip5                              := rt.AC_Recs_CurrDocs_Zip5                  ;
						self.Address.Zip4                              := rt.AC_Recs_CurrDocs_Zip4                  ;
						self.Address.County                            := rt.AC_Recs_CurrDocs_County                ;
						self.Address.PostalCode                        := rt.AC_Recs_CurrDocs_PostalCode            ;
						self.Address.StateCityZip                      := rt.AC_Recs_CurrDocs_StateCityZip          ;
						self.Name.Full                                 := rt.AC_Recs_CurrDocs_Full                  ;
						self.Name.First                                := rt.AC_Recs_CurrDocs_First                 ;
						self.Name.Middle                               := rt.AC_Recs_CurrDocs_Middle                ;
						self.Name.Last                                 := rt.AC_Recs_CurrDocs_Last                  ;
						self.Name.Suffix                               := rt.AC_Recs_CurrDocs_Suffix                ;
						self.Name.Prefix                               := rt.AC_Recs_CurrDocs_Prefix                ;
						self.Name.CompanyName                          := rt.AC_Recs_CurrDocs_CompanyName           ;
				));
				self.AircraftRecords.PriorRecordCount              := rt.AC_Recs_PriorRecordCount               ;
				self.AircraftRecords.TotalPriorRecordCount         := rt.AC_Recs_TotalPriorRecordCount          ;
				self.AircraftRecords.PriorAircrafts :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessAircraft,
						self.AircraftNumber                             := rt.AC_Recs_Prior_AircraftNumber            ;
						self.ModelYear                                  := rt.AC_Recs_Prior_ModelYear                 ;
						self.Manufacturer                               := rt.AC_Recs_Prior_Manufacturer              ;
						self.Model                                      := rt.AC_Recs_Prior_Model                     ;
						self.AircraftType                               := rt.AC_Recs_Prior_AircraftType              ;
						self.SerialNumber                               := rt.AC_Recs_Prior_SerialNumber              ;
						self.Engines                                    := rt.AC_Recs_Prior_Engines                   ;
						self.RegistrationDate.Year                      := rt.AC_Recs_Prior_Reg_Year                  ;
						self.RegistrationDate.Month                     := rt.AC_Recs_Prior_Reg_Month                 ;
						self.RegistrationDate.Day                       := rt.AC_Recs_Prior_Reg_Day                   ;
						self.RegistrationNumber                         := rt.AC_Recs_Prior_RegistrationNumber        ;
						self.RegistrationAddress.StreetNumber           := rt.AC_Recs_Prior_StreetNumber              ;
						self.RegistrationAddress.StreetPreDirection     := rt.AC_Recs_Prior_StreetPreDirection        ;
						self.RegistrationAddress.StreetName             := rt.AC_Recs_Prior_StreetName                ;
						self.RegistrationAddress.StreetSuffix           := rt.AC_Recs_Prior_StreetSuffix              ;
						self.RegistrationAddress.StreetPostDirection    := rt.AC_Recs_Prior_StreetPostDirection       ;
						self.RegistrationAddress.UnitDesignation        := rt.AC_Recs_Prior_UnitDesignation           ;
						self.RegistrationAddress.UnitNumber             := rt.AC_Recs_Prior_UnitNumber                ;
						self.RegistrationAddress.StreetAddress1         := rt.AC_Recs_Prior_StreetAddress1            ;
						self.RegistrationAddress.StreetAddress2         := rt.AC_Recs_Prior_StreetAddress2            ;
						self.RegistrationAddress.City                   := rt.AC_Recs_Prior_City                      ;
						self.RegistrationAddress.State                  := rt.AC_Recs_Prior_State                     ;
						self.RegistrationAddress.Zip5                   := rt.AC_Recs_Prior_Zip5                      ;
						self.RegistrationAddress.Zip4                   := rt.AC_Recs_Prior_Zip4                      ;
						self.RegistrationAddress.County                 := rt.AC_Recs_Prior_County                    ;
						self.RegistrationAddress.PostalCode             := rt.AC_Recs_Prior_PostalCode                ;
						self.RegistrationAddress.StateCityZip           := rt.AC_Recs_Prior_StateCityZip              ;
						self.CurrentParties :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessAircraftParty,
								self.SerialNumber                := rt.AC_Recs_Prior_CP_SerialNumber           ;
								self.RegistrationDate.Year       := rt.AC_Recs_Prior_CP_Reg_Year               ;
								self.RegistrationDate.Month      := rt.AC_Recs_Prior_CP_Reg_Month              ;
								self.RegistrationDate.Day        := rt.AC_Recs_Prior_CP_Reg_Day                ;
								self.CompanyName                 := rt.AC_Recs_Prior_CP_CompanyName            ;
								self.Name.Full                   := rt.AC_Recs_Prior_CP_Full                   ;
								self.Name.First                  := rt.AC_Recs_Prior_CP_First                  ;
								self.Name.Middle                 := rt.AC_Recs_Prior_CP_Middle                 ;
								self.Name.Last                   := rt.AC_Recs_Prior_CP_Last                   ;
								self.Name.Suffix                 := rt.AC_Recs_Prior_CP_Suffix                 ;
								self.Name.Prefix                 := rt.AC_Recs_Prior_CP_Prefix                 ;
								self.Address.StreetNumber        := rt.AC_Recs_Prior_CP_StreetNumber           ;
								self.Address.StreetPreDirection  := rt.AC_Recs_Prior_CP_StreetPreDirection     ;
								self.Address.StreetName          := rt.AC_Recs_Prior_CP_StreetName             ;
								self.Address.StreetSuffix        := rt.AC_Recs_Prior_CP_StreetSuffix           ;
								self.Address.StreetPostDirection := rt.AC_Recs_Prior_CP_StreetPostDirection    ;
								self.Address.UnitDesignation     := rt.AC_Recs_Prior_CP_UnitDesignation        ;
								self.Address.UnitNumber          := rt.AC_Recs_Prior_CP_UnitNumber             ;
								self.Address.StreetAddress1      := rt.AC_Recs_Prior_CP_StreetAddress1         ;
								self.Address.StreetAddress2      := rt.AC_Recs_Prior_CP_StreetAddress2         ;
								self.Address.City                := rt.AC_Recs_Prior_CP_City                   ;
								self.Address.State               := rt.AC_Recs_Prior_CP_State                  ;
								self.Address.Zip5                := rt.AC_Recs_Prior_CP_Zip5                   ;
								self.Address.Zip4                := rt.AC_Recs_Prior_CP_Zip4                   ;
								self.Address.County              := rt.AC_Recs_Prior_CP_County                 ;
								self.Address.PostalCode          := rt.AC_Recs_Prior_CP_PostalCode             ;
								self.Address.StateCityZip        := rt.AC_Recs_Prior_CP_StateCityZip           ;
						));
						self.PriorParties :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessAircraftParty,
								self.SerialNumber                  := rt.AC_Recs_Prior_PP_SerialNumber           ;
								self.RegistrationDate.Year         := rt.AC_Recs_Prior_PP_Reg_Year               ;
								self.RegistrationDate.Month        := rt.AC_Recs_Prior_PP_Reg_Month              ;
								self.RegistrationDate.Day          := rt.AC_Recs_Prior_PP_Reg_Day                ;
								self.CompanyName                   := rt.AC_Recs_Prior_PP_CompanyName            ;
								self.Name.Full                     := rt.AC_Recs_Prior_PP_Full                   ;
								self.Name.First                    := rt.AC_Recs_Prior_PP_First                  ;
								self.Name.Middle                   := rt.AC_Recs_Prior_PP_Middle                 ;
								self.Name.Last                     := rt.AC_Recs_Prior_PP_Last                   ;
								self.Name.Suffix                   := rt.AC_Recs_Prior_PP_Suffix                 ;
								self.Name.Prefix                   := rt.AC_Recs_Prior_PP_Prefix                 ;
								self.Address.StreetNumber          := rt.AC_Recs_Prior_PP_StreetNumber           ;
								self.Address.StreetPreDirection    := rt.AC_Recs_Prior_PP_StreetPreDirection     ;
								self.Address.StreetName            := rt.AC_Recs_Prior_PP_StreetName             ;
								self.Address.StreetSuffix          := rt.AC_Recs_Prior_PP_StreetSuffix           ;
								self.Address.StreetPostDirection   := rt.AC_Recs_Prior_PP_StreetPostDirection    ;
								self.Address.UnitDesignation       := rt.AC_Recs_Prior_PP_UnitDesignation        ;
								self.Address.UnitNumber            := rt.AC_Recs_Prior_PP_UnitNumber             ;
								self.Address.StreetAddress1        := rt.AC_Recs_Prior_PP_StreetAddress1         ;
								self.Address.StreetAddress2        := rt.AC_Recs_Prior_PP_StreetAddress2         ;
								self.Address.City                  := rt.AC_Recs_Prior_PP_City                   ;
								self.Address.State                 := rt.AC_Recs_Prior_PP_State                  ;
								self.Address.Zip5                  := rt.AC_Recs_Prior_PP_Zip5                   ;
								self.Address.Zip4                  := rt.AC_Recs_Prior_PP_Zip4                   ;
								self.Address.County                := rt.AC_Recs_Prior_PP_County                 ;
								self.Address.PostalCode            := rt.AC_Recs_Prior_PP_PostalCode             ;
								self.Address.StateCityZip          := rt.AC_Recs_Prior_PP_StateCityZip           ;
						));
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID            := rt.AC_Recs_Prior_Docs_DotID                ;
								self.BusinessIds.EmpID            := rt.AC_Recs_Prior_Docs_EmpID                ;
								self.BusinessIds.POWID            := rt.AC_Recs_Prior_Docs_POWID                ;
								self.BusinessIds.ProxID           := rt.AC_Recs_Prior_Docs_ProxID               ;
								self.BusinessIds.SeleID           := rt.AC_Recs_Prior_Docs_SeleID               ;
								self.BusinessIds.OrgID            := rt.AC_Recs_Prior_Docs_OrgID                ;
								self.BusinessIds.UltID            := rt.AC_Recs_Prior_Docs_UltID                ;
								self.IdType                       := rt.AC_Recs_Prior_Docs_IdType               ;
								self.IdValue                      := rt.AC_Recs_Prior_Docs_IdValue              ;
								self.Section                      := rt.AC_Recs_Prior_Docs_Section              ;
								self.Source                       := rt.AC_Recs_Prior_Docs_Source               ;
								self.Address.StreetNumber         := rt.AC_Recs_Prior_Docs_StreetNumber         ;
								self.Address.StreetPreDirection   := rt.AC_Recs_Prior_Docs_StreetPreDirection   ;
								self.Address.StreetName           := rt.AC_Recs_Prior_Docs_StreetName           ;
								self.Address.StreetSuffix         := rt.AC_Recs_Prior_Docs_StreetSuffix         ;
								self.Address.StreetPostDirection  := rt.AC_Recs_Prior_Docs_StreetPostDirection  ;
								self.Address.UnitDesignation      := rt.AC_Recs_Prior_Docs_UnitDesignation      ;
								self.Address.UnitNumber           := rt.AC_Recs_Prior_Docs_UnitNumber           ;
								self.Address.StreetAddress1       := rt.AC_Recs_Prior_Docs_StreetAddress1       ;
								self.Address.StreetAddress2       := rt.AC_Recs_Prior_Docs_StreetAddress2       ;
								self.Address.City                 := rt.AC_Recs_Prior_Docs_City                 ;
								self.Address.State                := rt.AC_Recs_Prior_Docs_State                ;
								self.Address.Zip5                 := rt.AC_Recs_Prior_Docs_Zip5                 ;
								self.Address.Zip4                 := rt.AC_Recs_Prior_Docs_Zip4                 ;
								self.Address.County               := rt.AC_Recs_Prior_Docs_County               ;
								self.Address.PostalCode           := rt.AC_Recs_Prior_Docs_PostalCode           ;
								self.Address.StateCityZip         := rt.AC_Recs_Prior_Docs_StateCityZip         ;
								self.Name.Full                    := rt.AC_Recs_Prior_Docs_Full                 ;
								self.Name.First                   := rt.AC_Recs_Prior_Docs_First                ;
								self.Name.Middle                  := rt.AC_Recs_Prior_Docs_Middle               ;
								self.Name.Last                    := rt.AC_Recs_Prior_Docs_Last                 ;
								self.Name.Suffix                  := rt.AC_Recs_Prior_Docs_Suffix               ;
								self.Name.Prefix                  := rt.AC_Recs_Prior_Docs_Prefix               ;
								self.Name.CompanyName             := rt.AC_Recs_Prior_Docs_CompanyName          ;
						));
				));
				self.AircraftRecords.PriorSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID                         := rt.AC_Recs_PriorDocs_DotID                 ;
						self.BusinessIds.EmpID                         := rt.AC_Recs_PriorDocs_EmpID                 ;
						self.BusinessIds.POWID                         := rt.AC_Recs_PriorDocs_POWID                 ;
						self.BusinessIds.ProxID                        := rt.AC_Recs_PriorDocs_ProxID                ;
						self.BusinessIds.SeleID                        := rt.AC_Recs_PriorDocs_SeleID                ;
						self.BusinessIds.OrgID                         := rt.AC_Recs_PriorDocs_OrgID                 ;
						self.BusinessIds.UltID                         := rt.AC_Recs_PriorDocs_UltID                 ;
						self.IdType                                    := rt.AC_Recs_PriorDocs_IdType                ;
						self.IdValue                                   := rt.AC_Recs_PriorDocs_IdValue               ;
						self.Section                                   := rt.AC_Recs_PriorDocs_Section               ;
						self.Source                                    := rt.AC_Recs_PriorDocs_Source                ;
						self.Address.StreetNumber                      := rt.AC_Recs_PriorDocs_StreetNumber          ;
						self.Address.StreetPreDirection                := rt.AC_Recs_PriorDocs_StreetPreDirection    ;
						self.Address.StreetName                        := rt.AC_Recs_PriorDocs_StreetName            ;
						self.Address.StreetSuffix                      := rt.AC_Recs_PriorDocs_StreetSuffix          ;
						self.Address.StreetPostDirection               := rt.AC_Recs_PriorDocs_StreetPostDirection   ;
						self.Address.UnitDesignation                   := rt.AC_Recs_PriorDocs_UnitDesignation       ;
						self.Address.UnitNumber                        := rt.AC_Recs_PriorDocs_UnitNumber            ;
						self.Address.StreetAddress1                    := rt.AC_Recs_PriorDocs_StreetAddress1        ;
						self.Address.StreetAddress2                    := rt.AC_Recs_PriorDocs_StreetAddress2        ;
						self.Address.City                              := rt.AC_Recs_PriorDocs_City                  ;
						self.Address.State                             := rt.AC_Recs_PriorDocs_State                 ;
						self.Address.Zip5                              := rt.AC_Recs_PriorDocs_Zip5                  ;
						self.Address.Zip4                              := rt.AC_Recs_PriorDocs_Zip4                  ;
						self.Address.County                            := rt.AC_Recs_PriorDocs_County                ;
						self.Address.PostalCode                        := rt.AC_Recs_PriorDocs_PostalCode            ;
						self.Address.StateCityZip                      := rt.AC_Recs_PriorDocs_StateCityZip          ;
						self.Name.Full                                 := rt.AC_Recs_PriorDocs_Full                  ;
						self.Name.First                                := rt.AC_Recs_PriorDocs_First                 ;
						self.Name.Middle                               := rt.AC_Recs_PriorDocs_Middle                ;
						self.Name.Last                                 := rt.AC_Recs_PriorDocs_Last                  ;
						self.Name.Suffix                               := rt.AC_Recs_PriorDocs_Suffix                ;
						self.Name.Prefix                               := rt.AC_Recs_PriorDocs_Prefix                ;
						self.Name.CompanyName                          := rt.AC_Recs_PriorDocs_CompanyName           ;
				));
		));
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_AirCraft := join(CR_WaterCraft, Seed_Files.BusinessCreditReport_keys.TopBusACraft,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_AirCraft(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_License (working_layout le, Seed_Files.BusinessCreditReport_keys.TopBusLic rt) := transform
		self.TopBusinessRecord.LicenseSection :=
			project(rt, transform(iesp.TopBusinessReport.t_TopBusinessLicenseSection,
				self.LicenseRecordCount := rt.LicenseRecordCount ;
				self.LicenseTotalCount := rt.LicenseTotalCount ;
				self.LicenseRecords.Licenses :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessLicenseRecord,
						self.LicenseNumber := rt.LicRecs_LicenseNumber ;
						self.Description := rt.LicRecs_Description ;
						self.Issuer := rt.LicRecs_Issuer ;
						self.IssueDate.Year := rt.LicRecs_Issue_Year ;
						self.IssueDate.Month := rt.LicRecs_Issue_Month ;
						self.IssueDate.Day := rt.LicRecs_Issue_Day ;
						self.ExpirationDate.Year := rt.LicRecs_Exp_Year ;
						self.ExpirationDate.Month := rt.LicRecs_Exp_Month ;
						self.ExpirationDate.Day := rt.LicRecs_Exp_Day ;
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID := rt.LicRecs_Docs_DotID ;
								self.BusinessIds.EmpID := rt.LicRecs_Docs_EmpID ;
								self.BusinessIds.POWID := rt.LicRecs_Docs_POWID ;
								self.BusinessIds.ProxID := rt.LicRecs_Docs_ProxID ;
								self.BusinessIds.SeleID := rt.LicRecs_Docs_SeleID ;
								self.BusinessIds.OrgID := rt.LicRecs_Docs_OrgID ;
								self.BusinessIds.UltID := rt.LicRecs_Docs_UltID ;
								self.IdType := rt.LicRecs_Docs_IdType ;
								self.IdValue := rt.LicRecs_Docs_IdValue ;
								self.Section := rt.LicRecs_Docs_Section ;
								self.Source := rt.LicRecs_Docs_Source ;
								self.Address.StreetNumber := rt.LicRecs_Docs_StreetNumber ;
								self.Address.StreetPreDirection := rt.LicRecs_Docs_StreetPreDirection ;
								self.Address.StreetName := rt.LicRecs_Docs_StreetName ;
								self.Address.StreetSuffix := rt.LicRecs_Docs_StreetSuffix ;
								self.Address.StreetPostDirection := rt.LicRecs_Docs_StreetPostDirection ;
								self.Address.UnitDesignation := rt.LicRecs_Docs_UnitDesignation ;
								self.Address.UnitNumber := rt.LicRecs_Docs_UnitNumber ;
								self.Address.StreetAddress1 := rt.LicRecs_Docs_StreetAddress1 ;
								self.Address.StreetAddress2 := rt.LicRecs_Docs_StreetAddress2 ;
								self.Address.City := rt.LicRecs_Docs_City ;
								self.Address.State := rt.LicRecs_Docs_State ;
								self.Address.Zip5 := rt.LicRecs_Docs_Zip5 ;
								self.Address.Zip4 := rt.LicRecs_Docs_Zip4 ;
								self.Address.County := rt.LicRecs_Docs_County ;
								self.Address.PostalCode := rt.LicRecs_Docs_PostalCode ;
								self.Address.StateCityZip := rt.LicRecs_Docs_StateCityZip ;
								self.Name.Full := rt.LicRecs_Docs_Full ;
								self.Name.First := rt.LicRecs_Docs_First ;
								self.Name.Middle := rt.LicRecs_Docs_Middle ;
								self.Name.Last := rt.LicRecs_Docs_Last ;
								self.Name.Suffix := rt.LicRecs_Docs_Suffix ;
								self.Name.Prefix := rt.LicRecs_Docs_Prefix ;
								self.Name.CompanyName := rt.LicRecs_Docs_CompanyName ;
						));
				));
				self.LicenseRecords.SourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID := rt.LicRecsDocs_DotID ;
						self.BusinessIds.EmpID := rt.LicRecsDocs_EmpID ;
						self.BusinessIds.POWID := rt.LicRecsDocs_POWID ;
						self.BusinessIds.ProxID := rt.LicRecsDocs_ProxID ;
						self.BusinessIds.SeleID := rt.LicRecsDocs_SeleID ;
						self.BusinessIds.OrgID := rt.LicRecsDocs_OrgID ;
						self.BusinessIds.UltID := rt.LicRecsDocs_UltID ;
						self.IdType := rt.LicRecsDocs_IdType ;
						self.IdValue := rt.LicRecsDocs_IdValue ;
						self.Section := rt.LicRecsDocs_Section ;
						self.Source := rt.LicRecsDocs_Source ;
						self.Address.StreetNumber := rt.LicRecsDocs_StreetNumber ;
						self.Address.StreetPreDirection := rt.LicRecsDocs_StreetPreDirection ;
						self.Address.StreetName := rt.LicRecsDocs_StreetName ;
						self.Address.StreetSuffix := rt.LicRecsDocs_StreetSuffix ;
						self.Address.StreetPostDirection := rt.LicRecsDocs_StreetPostDirection ;
						self.Address.UnitDesignation := rt.LicRecsDocs_UnitDesignation ;
						self.Address.UnitNumber := rt.LicRecsDocs_UnitNumber ;
						self.Address.StreetAddress1 := rt.LicRecsDocs_StreetAddress1 ;
						self.Address.StreetAddress2 := rt.LicRecsDocs_StreetAddress2 ;
						self.Address.City := rt.LicRecsDocs_City ;
						self.Address.State := rt.LicRecsDocs_State ;
						self.Address.Zip5 := rt.LicRecsDocs_Zip5 ;
						self.Address.Zip4 := rt.LicRecsDocs_Zip4 ;
						self.Address.County := rt.LicRecsDocs_County ;
						self.Address.PostalCode := rt.LicRecsDocs_PostalCode ;
						self.Address.StateCityZip := rt.LicRecsDocs_StateCityZip ;
						self.Name.Full := rt.LicRecsDocs_Full ;
						self.Name.First := rt.LicRecsDocs_First ;
						self.Name.Middle := rt.LicRecsDocs_Middle ;
						self.Name.Last := rt.LicRecsDocs_Last ;
						self.Name.Suffix := rt.LicRecsDocs_Suffix ;
						self.Name.Prefix := rt.LicRecsDocs_Prefix ;
						self.Name.CompanyName := rt.LicRecsDocs_CompanyName ;
				));
		));
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_License := join(CR_AirCraft, Seed_Files.BusinessCreditReport_keys.TopBusLic,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_License(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_Incorporation (working_layout le, Seed_Files.BusinessCreditReport_keys.TopBusIncorp rt) := transform
		self.TopBusinessRecord.IncorporationSection :=
			project(rt, transform(iesp.TopBusinessReport.t_TopBusinessIncorporationSection,
				self.CorpFilings :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessIncorporationInfo,
						self.StateOfOrigin := rt.Incorp_File_StateOfOrigin ;
						self.CorporationName := rt.Incorp_File_CorporationName ;
						self.FilingNumber := rt.Incorp_File_FilingNumber ;
						self.BusinessType := rt.Incorp_File_BusinessType ;
						self.FilingDate.Year := rt.Incorp_File_Filing_Year ;
						self.FilingDate.Month := rt.Incorp_File_Filing_Month ;
						self.FilingDate.Day := rt.Incorp_File_Filing_Day ;
						self.BusinessStatus := rt.Incorp_File_BusinessStatus ;
						self.NameStatus := rt.Incorp_File_NameStatus ;
						self.ForeignDomesticIndicator := rt.Incorp_File_ForeignDomesticIndicator ;
						self.ForeignState := rt.Incorp_File_ForeignState ;
						self.FilingType := rt.Incorp_File_FilingType ;
						self.ForProfitIndicator := rt.Incorp_File_ForProfitIndicator ;
						self.Origin := rt.Incorp_File_Origin ;
						self.CorpHistories :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessIncorporationHistory,
								self.Date.Year := rt.Incorp_File_Hist_Year ;
								self.Date.Month := rt.Incorp_File_Hist_Month ;
								self.Date.Day := rt.Incorp_File_Hist_Day ;
								self.Description := rt.Incorp_File_Hist_Description ;
						));
						self.TermOfExistence._Type := rt.Incorp_File_Exist_Type ;
						self.TermOfExistence.ExpirationDate.Year := rt.Incorp_File_Exist_Exp_Year ;
						self.TermOfExistence.ExpirationDate.Month := rt.Incorp_File_Exist_Exp_Month ;
						self.TermOfExistence.ExpirationDate.Day := rt.Incorp_File_Exist_Exp_Day ;
						self.TermOfExistence.Years := rt.Incorp_File_Exist_Years ;
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID := rt.Incorp_File_Docs_DotID ;
								self.BusinessIds.EmpID := rt.Incorp_File_Docs_EmpID ;
								self.BusinessIds.POWID := rt.Incorp_File_Docs_POWID ;
								self.BusinessIds.ProxID := rt.Incorp_File_Docs_ProxID ;
								self.BusinessIds.SeleID := rt.Incorp_File_Docs_SeleID ;
								self.BusinessIds.OrgID := rt.Incorp_File_Docs_OrgID ;
								self.BusinessIds.UltID := rt.Incorp_File_Docs_UltID ;
								self.IdType := rt.Incorp_File_Docs_IdType ;
								self.IdValue := rt.Incorp_File_Docs_IdValue ;
								self.Section := rt.Incorp_File_Docs_Section ;
								self.Source := rt.Incorp_File_Docs_Source ;
								self.Address.StreetNumber := rt.Incorp_File_Docs_StreetNumber ;
								self.Address.StreetPreDirection := rt.Incorp_File_Docs_StreetPreDirection ;
								self.Address.StreetName := rt.Incorp_File_Docs_StreetName ;
								self.Address.StreetSuffix := rt.Incorp_File_Docs_StreetSuffix ;
								self.Address.StreetPostDirection := rt.Incorp_File_Docs_StreetPostDirection ;
								self.Address.UnitDesignation := rt.Incorp_File_Docs_UnitDesignation ;
								self.Address.UnitNumber := rt.Incorp_File_Docs_UnitNumber ;
								self.Address.StreetAddress1 := rt.Incorp_File_Docs_StreetAddress1 ;
								self.Address.StreetAddress2 := rt.Incorp_File_Docs_StreetAddress2 ;
								self.Address.City := rt.Incorp_File_Docs_City ;
								self.Address.State := rt.Incorp_File_Docs_State ;
								self.Address.Zip5 := rt.Incorp_File_Docs_Zip5 ;
								self.Address.Zip4 := rt.Incorp_File_Docs_Zip4 ;
								self.Address.County := rt.Incorp_File_Docs_County ;
								self.Address.PostalCode := rt.Incorp_File_Docs_PostalCode ;
								self.Address.StateCityZip := rt.Incorp_File_Docs_StateCityZip ;
								self.Name.Full := rt.Incorp_File_Docs_Full ;
								self.Name.First := rt.Incorp_File_Docs_First ;
								self.Name.Middle := rt.Incorp_File_Docs_Middle ;
								self.Name.Last := rt.Incorp_File_Docs_Last ;
								self.Name.Suffix := rt.Incorp_File_Docs_Suffix ;
								self.Name.Prefix := rt.Incorp_File_Docs_Prefix ;
								self.Name.CompanyName := rt.Incorp_File_Docs_CompanyName ;
						));
						self.NameType := rt.Incorp_File_NameType ;
						self.Addresses :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessIncorporationAddress,
								self.Address.StreetNumber := rt.Incorp_File_StreetNumber ;
								self.Address.StreetPreDirection := rt.Incorp_File_StreetPreDirection ;
								self.Address.StreetName := rt.Incorp_File_StreetName ;
								self.Address.StreetSuffix := rt.Incorp_File_StreetSuffix ;
								self.Address.StreetPostDirection := rt.Incorp_File_StreetPostDirection ;
								self.Address.UnitDesignation := rt.Incorp_File_UnitDesignation ;
								self.Address.UnitNumber := rt.Incorp_File_UnitNumber ;
								self.Address.StreetAddress1 := rt.Incorp_File_StreetAddress1 ;
								self.Address.StreetAddress2 := rt.Incorp_File_StreetAddress2 ;
								self.Address.City := rt.Incorp_File_City ;
								self.Address.State := rt.Incorp_File_State ;
								self.Address.Zip5 := rt.Incorp_File_Zip5 ;
								self.Address.Zip4 := rt.Incorp_File_Zip4 ;
								self.Address.County := rt.Incorp_File_County ;
								self.Address.PostalCode := rt.Incorp_File_PostalCode ;
								self.Address.StateCityZip := rt.Incorp_File_StateCityZip ;
								self.AddressType := rt.Incorp_File_AddressType ;
						));
						self.InGoodStanding := rt.Incorp_File_InGoodStanding ;
						self.ForeignIncorporationDate.Year := rt.Incorp_File_ForIncorp_Year ;
						self.ForeignIncorporationDate.Month := rt.Incorp_File_ForIncorp_Month ;
						self.ForeignIncorporationDate.Day := rt.Incorp_File_ForIncorp_Day ;
						self.Purpose := rt.Incorp_File_Purpose ;
						self.AdditionalInfo := rt.Incorp_File_AdditionalInfo ;
						self.RegisteredAgentName.Full := rt.Incorp_File_RegAgent_Full ;
						self.RegisteredAgentName.First := rt.Incorp_File_RegAgent_First ;
						self.RegisteredAgentName.Middle := rt.Incorp_File_RegAgent_Middle ;
						self.RegisteredAgentName.Last := rt.Incorp_File_RegAgent_Last ;
						self.RegisteredAgentName.Suffix := rt.Incorp_File_RegAgent_Suffix ;
						self.RegisteredAgentName.Prefix := rt.Incorp_File_RegAgent_Prefix ;
						self.RegisteredAgentName.CompanyName := rt.Incorp_File_RegAgent_CompanyName ;
						self.RegisteredAgentAddress.StreetNumber := rt.Incorp_File_RegAgent_StreetNumber ;
						self.RegisteredAgentAddress.StreetPreDirection := rt.Incorp_File_RegAgent_StreetPreDirection ;
						self.RegisteredAgentAddress.StreetName := rt.Incorp_File_RegAgent_StreetName ;
						self.RegisteredAgentAddress.StreetSuffix := rt.Incorp_File_RegAgent_StreetSuffix ;
						self.RegisteredAgentAddress.StreetPostDirection := rt.Incorp_File_RegAgent_StreetPostDirection ;
						self.RegisteredAgentAddress.UnitDesignation := rt.Incorp_File_RegAgent_UnitDesignation ;
						self.RegisteredAgentAddress.UnitNumber := rt.Incorp_File_RegAgent_UnitNumber ;
						self.RegisteredAgentAddress.StreetAddress1 := rt.Incorp_File_RegAgent_StreetAddress1 ;
						self.RegisteredAgentAddress.StreetAddress2 := rt.Incorp_File_RegAgent_StreetAddress2 ;
						self.RegisteredAgentAddress.City := rt.Incorp_File_RegAgent_City ;
						self.RegisteredAgentAddress.State := rt.Incorp_File_RegAgent_State ;
						self.RegisteredAgentAddress.Zip5 := rt.Incorp_File_RegAgent_Zip5 ;
						self.RegisteredAgentAddress.Zip4 := rt.Incorp_File_RegAgent_Zip4 ;
						self.RegisteredAgentAddress.County := rt.Incorp_File_RegAgent_County ;
						self.RegisteredAgentAddress.PostalCode := rt.Incorp_File_RegAgent_PostalCode ;
						self.RegisteredAgentAddress.StateCityZip := rt.Incorp_File_RegAgent_StateCityZip ;
				));
				self.ReturnedCorpFilings := rt.Incorp_ReturnedCorpFilings ;
				self.TotalCorpFilings := rt.Incorp_TotalCorpFilings ;
				self.SourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID := rt.IncorpDocs_DotID ;
						self.BusinessIds.EmpID := rt.IncorpDocs_EmpID ;
						self.BusinessIds.POWID := rt.IncorpDocs_POWID ;
						self.BusinessIds.ProxID := rt.IncorpDocs_ProxID ;
						self.BusinessIds.SeleID := rt.IncorpDocs_SeleID ;
						self.BusinessIds.OrgID := rt.IncorpDocs_OrgID ;
						self.BusinessIds.UltID := rt.IncorpDocs_UltID ;
						self.IdType := rt.IncorpDocs_IdType ;
						self.IdValue := rt.IncorpDocs_IdValue ;
						self.Section := rt.IncorpDocs_Section ;
						self.Source := rt.IncorpDocs_Source ;
						self.Address.StreetNumber := rt.IncorpDocs_StreetNumber ;
						self.Address.StreetPreDirection := rt.IncorpDocs_StreetPreDirection ;
						self.Address.StreetName := rt.IncorpDocs_StreetName ;
						self.Address.StreetSuffix := rt.IncorpDocs_StreetSuffix ;
						self.Address.StreetPostDirection := rt.IncorpDocs_StreetPostDirection ;
						self.Address.UnitDesignation := rt.IncorpDocs_UnitDesignation ;
						self.Address.UnitNumber := rt.IncorpDocs_UnitNumber ;
						self.Address.StreetAddress1 := rt.IncorpDocs_StreetAddress1 ;
						self.Address.StreetAddress2 := rt.IncorpDocs_StreetAddress2 ;
						self.Address.City := rt.IncorpDocs_City ;
						self.Address.State := rt.IncorpDocs_State ;
						self.Address.Zip5 := rt.IncorpDocs_Zip5 ;
						self.Address.Zip4 := rt.IncorpDocs_Zip4 ;
						self.Address.County := rt.IncorpDocs_County ;
						self.Address.PostalCode := rt.IncorpDocs_PostalCode ;
						self.Address.StateCityZip := rt.IncorpDocs_StateCityZip ;
						self.Name.Full := rt.IncorpDocs_Full ;
						self.Name.First := rt.IncorpDocs_First ;
						self.Name.Middle := rt.IncorpDocs_Middle ;
						self.Name.Last := rt.IncorpDocs_Last ;
						self.Name.Suffix := rt.IncorpDocs_Suffix ;
						self.Name.Prefix := rt.IncorpDocs_Prefix ;
						self.Name.CompanyName := rt.IncorpDocs_CompanyName ;
				));
		));
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_Incorporation := join(CR_License, Seed_Files.BusinessCreditReport_keys.TopBusIncorp,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_Incorporation(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_OperationSites (working_layout le, Seed_Files.BusinessCreditReport_keys.TopBusOperSites rt) := transform
		self.TopBusinessRecord.OperationsSitesSection :=
			project(rt, transform(iesp.topbusinessreport.t_TopBusinessOperationsSitesSection,
				self.ReturnedRecordCount := rt.Ops_ReturnedRecordCount;
				self.TotalRecordCount := rt.Ops_TotalRecordCount;
				self.OperationsSites :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessOperationSite,
						self.StateName := rt.Ops_Site_StateName;
						self.StateAddressCount := rt.Ops_Site_StateAddressCount;
						self.StateTotalAddressCount := rt.Ops_Site_StateTotalAddressCount;
						self.Addresses :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessOpSiteAddress,
								self.Address.StreetNumber := rt.Ops_Site_StreetNumber;
								self.Address.StreetPreDirection := rt.Ops_Site_StreetPreDirection;
								self.Address.StreetName := rt.Ops_Site_StreetName;
								self.Address.StreetSuffix := rt.Ops_Site_StreetSuffix;
								self.Address.StreetPostDirection := rt.Ops_Site_StreetPostDirection;
								self.Address.UnitDesignation := rt.Ops_Site_UnitDesignation;
								self.Address.UnitNumber := rt.Ops_Site_UnitNumber;
								self.Address.StreetAddress1 := rt.Ops_Site_StreetAddress1;
								self.Address.StreetAddress2 := rt.Ops_Site_StreetAddress2;
								self.Address.City := rt.Ops_Site_City;
								self.Address.State := rt.Ops_Site_State;
								self.Address.Zip5 := rt.Ops_Site_Zip5;
								self.Address.Zip4 := rt.Ops_Site_Zip4;
								self.Address.County := rt.Ops_Site_County;
								self.Address.PostalCode := rt.Ops_Site_PostalCode;
								self.Address.StateCityZip := rt.Ops_Site_StateCityZip;
								self.MsaName := rt.Ops_Site_MsaName;
								self.PropertyLink := rt.Ops_Site_PropertyLink;
								self.Phones :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessOpSitePhone,
										self.Phone10 := rt.Ops_Site_Phone_Phone10;
										self.ListingType := rt.Ops_Site_Phone_ListingType;
										self.ActiveEDA := rt.Ops_Site_Phone_ActiveEDA;
										self.Disconnected := rt.Ops_Site_Phone_Disconnected;
										self.LineType := rt.Ops_Site_Phone_LineType;
										self.ListingName := rt.Ops_Site_Phone_ListingName;
										self.FromDate.Year := rt.Ops_Site_Phone_From_Year;
										self.FromDate.Month := rt.Ops_Site_Phone_From_Month;
										self.FromDate.Day := rt.Ops_Site_Phone_From_Day;
										self.ToDate.Year := rt.Ops_Site_Phone_To_Year;
										self.ToDate.Month := rt.Ops_Site_Phone_To_Month;
										self.ToDate.Day := rt.Ops_Site_Phone_To_Day;
								));
								self.SourceDocs :=
									project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
										self.BusinessIds.DotID := rt.Ops_Site_Phone_Docs_DotID;
										self.BusinessIds.EmpID := rt.Ops_Site_Phone_Docs_EmpID;
										self.BusinessIds.POWID := rt.Ops_Site_Phone_Docs_POWID;
										self.BusinessIds.ProxID := rt.Ops_Site_Phone_Docs_ProxID;
										self.BusinessIds.SeleID := rt.Ops_Site_Phone_Docs_SeleID;
										self.BusinessIds.OrgID := rt.Ops_Site_Phone_Docs_OrgID;
										self.BusinessIds.UltID := rt.Ops_Site_Phone_Docs_UltID;
										self.IdType := rt.Ops_Site_Phone_Docs_IdType;
										self.IdValue := rt.Ops_Site_Phone_Docs_IdValue;
										self.Section := rt.Ops_Site_Phone_Docs_Section;
										self.Source := rt.Ops_Site_Phone_Docs_Source;
										self.Address.StreetNumber := rt.Ops_Site_Phone_Docs_StreetNumber;
										self.Address.StreetPreDirection := rt.Ops_Site_Phone_Docs_StreetPreDirection;
										self.Address.StreetName := rt.Ops_Site_Phone_Docs_StreetName;
										self.Address.StreetSuffix := rt.Ops_Site_Phone_Docs_StreetSuffix;
										self.Address.StreetPostDirection := rt.Ops_Site_Phone_Docs_StreetPostDirection;
										self.Address.UnitDesignation := rt.Ops_Site_Phone_Docs_UnitDesignation;
										self.Address.UnitNumber := rt.Ops_Site_Phone_Docs_UnitNumber;
										self.Address.StreetAddress1 := rt.Ops_Site_Phone_Docs_StreetAddress1;
										self.Address.StreetAddress2 := rt.Ops_Site_Phone_Docs_StreetAddress2;
										self.Address.City := rt.Ops_Site_Phone_Docs_City;
										self.Address.State := rt.Ops_Site_Phone_Docs_State;
										self.Address.Zip5 := rt.Ops_Site_Phone_Docs_Zip5;
										self.Address.Zip4 := rt.Ops_Site_Phone_Docs_Zip4;
										self.Address.County := rt.Ops_Site_Phone_Docs_County;
										self.Address.PostalCode := rt.Ops_Site_Phone_Docs_PostalCode;
										self.Address.StateCityZip := rt.Ops_Site_Phone_Docs_StateCityZip;
										self.Name.Full := rt.Ops_Site_Phone_Docs_Full;
										self.Name.First := rt.Ops_Site_Phone_Docs_First;
										self.Name.Middle := rt.Ops_Site_Phone_Docs_Middle;
										self.Name.Last := rt.Ops_Site_Phone_Docs_Last;
										self.Name.Suffix := rt.Ops_Site_Phone_Docs_Suffix;
										self.Name.Prefix := rt.Ops_Site_Phone_Docs_Prefix;
										self.Name.CompanyName := rt.Ops_Site_Phone_Docs_CompanyName;
								));
						));
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID := rt.Ops_SiteDocs_DotID;
								self.BusinessIds.EmpID := rt.Ops_SiteDocs_EmpID;
								self.BusinessIds.POWID := rt.Ops_SiteDocs_POWID;
								self.BusinessIds.ProxID := rt.Ops_SiteDocs_ProxID;
								self.BusinessIds.SeleID := rt.Ops_SiteDocs_SeleID;
								self.BusinessIds.OrgID := rt.Ops_SiteDocs_OrgID;
								self.BusinessIds.UltID := rt.Ops_SiteDocs_UltID;
								self.IdType := rt.Ops_SiteDocs_IdType;
								self.IdValue := rt.Ops_SiteDocs_IdValue;
								self.Section := rt.Ops_SiteDocs_Section;
								self.Source := rt.Ops_SiteDocs_Source;
								self.Address.StreetNumber := rt.Ops_SiteDocs_StreetNumber;
								self.Address.StreetPreDirection := rt.Ops_SiteDocs_StreetPreDirection;
								self.Address.StreetName := rt.Ops_SiteDocs_StreetName;
								self.Address.StreetSuffix := rt.Ops_SiteDocs_StreetSuffix;
								self.Address.StreetPostDirection := rt.Ops_SiteDocs_StreetPostDirection;
								self.Address.UnitDesignation := rt.Ops_SiteDocs_UnitDesignation;
								self.Address.UnitNumber := rt.Ops_SiteDocs_UnitNumber;
								self.Address.StreetAddress1 := rt.Ops_SiteDocs_StreetAddress1;
								self.Address.StreetAddress2 := rt.Ops_SiteDocs_StreetAddress2;
								self.Address.City := rt.Ops_SiteDocs_City;
								self.Address.State := rt.Ops_SiteDocs_State;
								self.Address.Zip5 := rt.Ops_SiteDocs_Zip5;
								self.Address.Zip4 := rt.Ops_SiteDocs_Zip4;
								self.Address.County := rt.Ops_SiteDocs_County;
								self.Address.PostalCode := rt.Ops_SiteDocs_PostalCode;
								self.Address.StateCityZip := rt.Ops_SiteDocs_StateCityZip;
								self.Name.Full := rt.Ops_SiteDocs_Full;
								self.Name.First := rt.Ops_SiteDocs_First;
								self.Name.Middle := rt.Ops_SiteDocs_Middle;
								self.Name.Last := rt.Ops_SiteDocs_Last;
								self.Name.Suffix := rt.Ops_SiteDocs_Suffix;
								self.Name.Prefix := rt.Ops_SiteDocs_Prefix;
								self.Name.CompanyName := rt.Ops_SiteDocs_CompanyName;
						));
				));
				self.SourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID := rt.OpsDocs_DotID;
						self.BusinessIds.EmpID := rt.OpsDocs_EmpID;
						self.BusinessIds.POWID := rt.OpsDocs_POWID;
						self.BusinessIds.ProxID := rt.OpsDocs_ProxID;
						self.BusinessIds.SeleID := rt.OpsDocs_SeleID;
						self.BusinessIds.OrgID := rt.OpsDocs_OrgID;
						self.BusinessIds.UltID := rt.OpsDocs_UltID;
						self.IdType := rt.OpsDocs_IdType;
						self.IdValue := rt.OpsDocs_IdValue;
						self.Section := rt.OpsDocs_Section;
						self.Source := rt.OpsDocs_Source;
						self.Address.StreetNumber := rt.OpsDocs_StreetNumber;
						self.Address.StreetPreDirection := rt.OpsDocs_StreetPreDirection;
						self.Address.StreetName := rt.OpsDocs_StreetName;
						self.Address.StreetSuffix := rt.OpsDocs_StreetSuffix;
						self.Address.StreetPostDirection := rt.OpsDocs_StreetPostDirection;
						self.Address.UnitDesignation := rt.OpsDocs_UnitDesignation;
						self.Address.UnitNumber := rt.OpsDocs_UnitNumber;
						self.Address.StreetAddress1 := rt.OpsDocs_StreetAddress1;
						self.Address.StreetAddress2 := rt.OpsDocs_StreetAddress2;
						self.Address.City := rt.OpsDocs_City;
						self.Address.State := rt.OpsDocs_State;
						self.Address.Zip5 := rt.OpsDocs_Zip5;
						self.Address.Zip4 := rt.OpsDocs_Zip4;
						self.Address.County := rt.OpsDocs_County;
						self.Address.PostalCode := rt.OpsDocs_PostalCode;
						self.Address.StateCityZip := rt.OpsDocs_StateCityZip;
						self.Name.Full := rt.OpsDocs_Full;
						self.Name.First := rt.OpsDocs_First;
						self.Name.Middle := rt.OpsDocs_Middle;
						self.Name.Last := rt.OpsDocs_Last;
						self.Name.Suffix := rt.OpsDocs_Suffix;
						self.Name.Prefix := rt.OpsDocs_Prefix;
						self.Name.CompanyName := rt.OpsDocs_CompanyName;
				));
		));
	
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_OperationSites := join(CR_Incorporation, Seed_Files.BusinessCreditReport_keys.TopBusOperSites,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_OperationSites(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_Parent (working_layout le, Seed_Files.BusinessCreditReport_keys.TopBusParent rt) := transform
		self.TopBusinessRecord.ParentSection :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditParentSection,
				self.BusinessIds.DotID := rt.Parent_DotID;
				self.BusinessIds.EmpID := rt.Parent_EmpID;
				self.BusinessIds.POWID := rt.Parent_POWID;
				self.BusinessIds.ProxID := rt.Parent_ProxID;
				self.BusinessIds.SeleID := rt.Parent_SeleID;
				self.BusinessIds.OrgID := rt.Parent_OrgID;
				self.BusinessIds.UltID := rt.Parent_UltID;
				self.CompanyName := rt.Parent_CompanyName;
				self.Address.StreetNumber := rt.Parent_StreetNumber;
				self.Address.StreetPreDirection := rt.Parent_StreetPreDirection;
				self.Address.StreetName := rt.Parent_StreetName;
				self.Address.StreetSuffix := rt.Parent_StreetSuffix;
				self.Address.StreetPostDirection := rt.Parent_StreetPostDirection;
				self.Address.UnitDesignation := rt.Parent_UnitDesignation;
				self.Address.UnitNumber := rt.Parent_UnitNumber;
				self.Address.StreetAddress1 := rt.Parent_StreetAddress1;
				self.Address.StreetAddress2 := rt.Parent_StreetAddress2;
				self.Address.City := rt.Parent_City;
				self.Address.State := rt.Parent_State;
				self.Address.Zip5 := rt.Parent_Zip5;
				self.Address.Zip4 := rt.Parent_Zip4;
				self.Address.County := rt.Parent_County;
				self.Address.PostalCode := rt.Parent_PostalCode;
				self.Address.StateCityZip := rt.Parent_StateCityZip;
				self.PhoneInfo.Phone10 := rt.Parent_Phone10;
				self.PhoneInfo.PubNonpub := rt.Parent_PubNonpub;
				self.PhoneInfo.ListingPhone10 := rt.Parent_ListingPhone10;
				self.PhoneInfo.ListingName := rt.Parent_ListingName;
				self.PhoneInfo.TimeZone := rt.Parent_TimeZone;
				self.PhoneInfo.ListingTimeZone := rt.Parent_ListingTimeZone;
				self.BusinessCreditIndicator := rt.Parent_BusinessCreditIndicator;
		));
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_Parent := join(CR_OperationSites, Seed_Files.BusinessCreditReport_keys.TopBusParent,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_Parent(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_ConnectedBusiness (working_layout le, Seed_Files.BusinessCreditReport_keys.TopBusConnected rt) := transform
		self.TopBusinessRecord.ConnectedBusinessSection :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditConnectedBusinessSection,
				self.CountConnectedBusinesses := rt.CountConnectedBusinesses;
				self.TotalCountConnectedBusinesses := rt.TotalCountConnectedBusinesses;
				self.ConnectedBusinessRecords :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditConnectedBusiness,
						self.BusinessIds.DotID := rt.ConBusRecs_DotID;
						self.BusinessIds.EmpID := rt.ConBusRecs_EmpID;
						self.BusinessIds.POWID := rt.ConBusRecs_POWID;
						self.BusinessIds.ProxID := rt.ConBusRecs_ProxID;
						self.BusinessIds.SeleID := rt.ConBusRecs_SeleID;
						self.BusinessIds.OrgID := rt.ConBusRecs_OrgID;
						self.BusinessIds.UltID := rt.ConBusRecs_UltID;
						self.CompanyName := rt.ConBusRecs_CompanyName;
						self.Address.StreetNumber := rt.ConBusRecs_StreetNumber;
						self.Address.StreetPreDirection := rt.ConBusRecs_StreetPreDirection;
						self.Address.StreetName := rt.ConBusRecs_StreetName;
						self.Address.StreetSuffix := rt.ConBusRecs_StreetSuffix;
						self.Address.StreetPostDirection := rt.ConBusRecs_StreetPostDirection;
						self.Address.UnitDesignation := rt.ConBusRecs_UnitDesignation;
						self.Address.UnitNumber := rt.ConBusRecs_UnitNumber;
						self.Address.StreetAddress1 := rt.ConBusRecs_StreetAddress1;
						self.Address.StreetAddress2 := rt.ConBusRecs_StreetAddress2;
						self.Address.City := rt.ConBusRecs_City;
						self.Address.State := rt.ConBusRecs_State;
						self.Address.Zip5 := rt.ConBusRecs_Zip5;
						self.Address.Zip4 := rt.ConBusRecs_Zip4;
						self.Address.County := rt.ConBusRecs_County;
						self.Address.PostalCode := rt.ConBusRecs_PostalCode;
						self.Address.StateCityZip := rt.ConBusRecs_StateCityZip;
						self.TIN := rt.ConBusRecs_TIN;
						self.TINSource := rt.ConBusRecs_TINSource;
						self.BusinessCreditIndicator := rt.ConBusRecs_BusinessCreditIndicator;
				));
		));
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_ConnectedBusiness := join(CR_Parent, Seed_Files.BusinessCreditReport_keys.TopBusConnected,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_ConnectedBusiness(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_Contacts (working_layout le, Seed_Files.BusinessCreditReport_keys.TopBusContacts rt) := transform
		self.TopBusinessRecord.ContactSection :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditContactSection,
				self.CurrentExecutiveCount := rt.Cont_CurrentExecutiveCount ;
				self.TotalCurrentExecutiveCount := rt.Cont_TotalCurrentExecutiveCount ;
				self.CurrentExecutives :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusinessreport.t_TopBusinessIndividual,
						self.Name.Full := rt.Cont_CurrExec_Full ;
						self.Name.First := rt.Cont_CurrExec_First ;
						self.Name.Middle := rt.Cont_CurrExec_Middle ;
						self.Name.Last := rt.Cont_CurrExec_Last ;
						self.Name.Suffix := rt.Cont_CurrExec_Suffix ;
						self.Name.Prefix := rt.Cont_CurrExec_Prefix ;
						self.Address.StreetNumber := rt.Cont_CurrExec_StreetNumber ;
						self.Address.StreetPreDirection := rt.Cont_CurrExec_StreetPreDirection ;
						self.Address.StreetName := rt.Cont_CurrExec_StreetName ;
						self.Address.StreetSuffix := rt.Cont_CurrExec_StreetSuffix ;
						self.Address.StreetPostDirection := rt.Cont_CurrExec_StreetPostDirection ;
						self.Address.UnitDesignation := rt.Cont_CurrExec_UnitDesignation ;
						self.Address.UnitNumber := rt.Cont_CurrExec_UnitNumber ;
						self.Address.StreetAddress1 := rt.Cont_CurrExec_StreetAddress1 ;
						self.Address.StreetAddress2 := rt.Cont_CurrExec_StreetAddress2 ;
						self.Address.City := rt.Cont_CurrExec_City ;
						self.Address.State := rt.Cont_CurrExec_State ;
						self.Address.Zip5 := rt.Cont_CurrExec_Zip5 ;
						self.Address.Zip4 := rt.Cont_CurrExec_Zip4 ;
						self.Address.County := rt.Cont_CurrExec_County ;
						self.Address.PostalCode  := rt.Cont_CurrExec_PostalCode  ;
						self.Address.StateCityZip := rt.Cont_CurrExec_StateCityZip ;
						self.UniqueId := rt.Cont_CurrExec_UniqueId ;
						self.SSN := rt.Cont_CurrExec_SSN ;
						self.IsDeceased := rt.Cont_CurrExec_IsDeceased ;
						self.HasDerog := rt.Cont_CurrExec_HasDerog ;
						self.HasCriminalConviction := rt.Cont_CurrExec_HasCriminalConviction ;
						self.IsSexualOffender := rt.Cont_CurrExec_IsSexualOffender ;
						self.ExecutiveElsewhere := rt.Cont_CurrExec_ExecutiveElsewhere ;
						self.BestPosition.CompanyTitle := rt.Cont_CurrExec_BestPos_CompanyTitle ;
						self.BestPosition.FromDate.Year := rt.Cont_CurrExec_BestPos_From_Year ;
						self.BestPosition.FromDate.Month := rt.Cont_CurrExec_BestPos_From_Month ;
						self.BestPosition.FromDate.Day := rt.Cont_CurrExec_BestPos_From_Day ;
						self.BestPosition.ToDate.Year := rt.Cont_CurrExec_BestPos_To_Year ;
						self.BestPosition.ToDate.Month := rt.Cont_CurrExec_BestPos_To_Month ;
						self.BestPosition.ToDate.Day := rt.Cont_CurrExec_BestPos_To_Day ;
						self.OtherCurrents :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessPosition,
								self.CompanyTitle := rt.Cont_CurrExec_Curr_CompanyTitle ;
								self.FromDate.Year := rt.Cont_CurrExec_Curr_From_Year ;
								self.FromDate.Month := rt.Cont_CurrExec_Curr_From_Month ;
								self.FromDate.Day := rt.Cont_CurrExec_Curr_From_Day ;
								self.ToDate.Year := rt.Cont_CurrExec_Curr_To_Year ;
								self.ToDate.Month := rt.Cont_CurrExec_Curr_To_Month ;
								self.ToDate.Day := rt.Cont_CurrExec_Curr_To_Day ;
						));
						self.AllOthers :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessPosition,
								self.CompanyTitle := rt.Cont_CurrExec_Other_CompanyTitle ;
								self.FromDate.Year := rt.Cont_CurrExec_Other_From_Year ;
								self.FromDate.Month := rt.Cont_CurrExec_Other_From_Month ;
								self.FromDate.Day := rt.Cont_CurrExec_Other_From_Day ;
								self.ToDate.Year := rt.Cont_CurrExec_Other_To_Year ;
								self.ToDate.Month := rt.Cont_CurrExec_Other_To_Month ;
								self.ToDate.Day := rt.Cont_CurrExec_Other_To_Day ;
						));
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID := rt.Cont_CurrExec_Docs_DotID ;
								self.BusinessIds.EmpID := rt.Cont_CurrExec_Docs_EmpID ;
								self.BusinessIds.POWID := rt.Cont_CurrExec_Docs_POWID ;
								self.BusinessIds.ProxID := rt.Cont_CurrExec_Docs_ProxID ;
								self.BusinessIds.SeleID := rt.Cont_CurrExec_Docs_SeleID ;
								self.BusinessIds.OrgID := rt.Cont_CurrExec_Docs_OrgID ;
								self.BusinessIds.UltID := rt.Cont_CurrExec_Docs_UltID ;
								self.IdType := rt.Cont_CurrExec_Docs_IdType ;
								self.IdValue := rt.Cont_CurrExec_Docs_IdValue ;
								self.Section := rt.Cont_CurrExec_Docs_Section ;
								self.Source := rt.Cont_CurrExec_Docs_Source ;
								self.Address.StreetNumber := rt.Cont_CurrExec_Docs_StreetNumber ;
								self.Address.StreetPreDirection := rt.Cont_CurrExec_Docs_StreetPreDirection ;
								self.Address.StreetName := rt.Cont_CurrExec_Docs_StreetName ;
								self.Address.StreetSuffix := rt.Cont_CurrExec_Docs_StreetSuffix ;
								self.Address.StreetPostDirection := rt.Cont_CurrExec_Docs_StreetPostDirection ;
								self.Address.UnitDesignation := rt.Cont_CurrExec_Docs_UnitDesignation ;
								self.Address.UnitNumber := rt.Cont_CurrExec_Docs_UnitNumber ;
								self.Address.StreetAddress1 := rt.Cont_CurrExec_Docs_StreetAddress1 ;
								self.Address.StreetAddress2 := rt.Cont_CurrExec_Docs_StreetAddress2 ;
								self.Address.City := rt.Cont_CurrExec_Docs_City ;
								self.Address.State := rt.Cont_CurrExec_Docs_State ;
								self.Address.Zip5 := rt.Cont_CurrExec_Docs_Zip5 ;
								self.Address.Zip4 := rt.Cont_CurrExec_Docs_Zip4 ;
								self.Address.County := rt.Cont_CurrExec_Docs_County ;
								self.Address.PostalCode := rt.Cont_CurrExec_Docs_PostalCode ;
								self.Address.StateCityZip := rt.Cont_CurrExec_Docs_StateCityZip ;
								self.Name.Full := rt.Cont_CurrExec_Docs_Full ;
								self.Name.First := rt.Cont_CurrExec_Docs_First ;
								self.Name.Middle := rt.Cont_CurrExec_Docs_Middle ;
								self.Name.Last := rt.Cont_CurrExec_Docs_Last ;
								self.Name.Suffix := rt.Cont_CurrExec_Docs_Suffix ;
								self.Name.Prefix := rt.Cont_CurrExec_Docs_Prefix ;
								self.Name.CompanyName := rt.Cont_CurrExec_Docs_CompanyName ;
						));
				));
				self.CurrentSourceDocs :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
						self.BusinessIds.DotID := rt.Cont_CurrDocs_DotID ;
						self.BusinessIds.EmpID := rt.Cont_CurrDocs_EmpID ;
						self.BusinessIds.POWID := rt.Cont_CurrDocs_POWID ;
						self.BusinessIds.ProxID := rt.Cont_CurrDocs_ProxID ;
						self.BusinessIds.SeleID := rt.Cont_CurrDocs_SeleID ;
						self.BusinessIds.OrgID := rt.Cont_CurrDocs_OrgID ;
						self.BusinessIds.UltID := rt.Cont_CurrDocs_UltID ;
						self.IdType := rt.Cont_CurrDocs_IdType ;
						self.IdValue := rt.Cont_CurrDocs_IdValue ;
						self.Section := rt.Cont_CurrDocs_Section ;
						self.Source := rt.Cont_CurrDocs_Source ;
						self.Address.StreetNumber := rt.Cont_CurrDocs_StreetNumber ;
						self.Address.StreetPreDirection := rt.Cont_CurrDocs_StreetPreDirection ;
						self.Address.StreetName := rt.Cont_CurrDocs_StreetName ;
						self.Address.StreetSuffix := rt.Cont_CurrDocs_StreetSuffix ;
						self.Address.StreetPostDirection := rt.Cont_CurrDocs_StreetPostDirection ;
						self.Address.UnitDesignation := rt.Cont_CurrDocs_UnitDesignation ;
						self.Address.UnitNumber := rt.Cont_CurrDocs_UnitNumber ;
						self.Address.StreetAddress1 := rt.Cont_CurrDocs_StreetAddress1 ;
						self.Address.StreetAddress2 := rt.Cont_CurrDocs_StreetAddress2 ;
						self.Address.City := rt.Cont_CurrDocs_City ;
						self.Address.State := rt.Cont_CurrDocs_State ;
						self.Address.Zip5 := rt.Cont_CurrDocs_Zip5 ;
						self.Address.Zip4 := rt.Cont_CurrDocs_Zip4 ;
						self.Address.County := rt.Cont_CurrDocs_County ;
						self.Address.PostalCode := rt.Cont_CurrDocs_PostalCode ;
						self.Address.StateCityZip := rt.Cont_CurrDocs_StateCityZip ;
						self.Name.Full := rt.Cont_CurrDocs_Full ;
						self.Name.First := rt.Cont_CurrDocs_First ;
						self.Name.Middle := rt.Cont_CurrDocs_Middle ;
						self.Name.Last := rt.Cont_CurrDocs_Last ;
						self.Name.Suffix := rt.Cont_CurrDocs_Suffix ;
						self.Name.Prefix := rt.Cont_CurrDocs_Prefix ;
						self.Name.CompanyName := rt.Cont_CurrDocs_CompanyName ;
				));
				self.PriorExecutiveCount  := rt.Cont_PriorExecutiveCount ;
				self.TotalPriorExecutiveCount := rt.Cont_TotalPriorExecutiveCount ;
				self.PriorExecutives :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusinessreport.t_TopBusinessIndividual,
						self.Name.Full := rt.Cont_PriorExec_Full ;
						self.Name.First := rt.Cont_PriorExec_First ;
						self.Name.Middle := rt.Cont_PriorExec_Middle ;
						self.Name.Last := rt.Cont_PriorExec_Last ;
						self.Name.Suffix := rt.Cont_PriorExec_Suffix ;
						self.Name.Prefix := rt.Cont_PriorExec_Prefix ;
						self.Address.StreetNumber := rt.Cont_PriorExec_StreetNumber ;
						self.Address.StreetPreDirection := rt.Cont_PriorExec_StreetPreDirection ;
						self.Address.StreetName := rt.Cont_PriorExec_StreetName ;
						self.Address.StreetSuffix := rt.Cont_PriorExec_StreetSuffix ;
						self.Address.StreetPostDirection := rt.Cont_PriorExec_StreetPostDirection ;
						self.Address.UnitDesignation := rt.Cont_PriorExec_UnitDesignation ;
						self.Address.UnitNumber := rt.Cont_PriorExec_UnitNumber ;
						self.Address.StreetAddress1 := rt.Cont_PriorExec_StreetAddress1 ;
						self.Address.StreetAddress2 := rt.Cont_PriorExec_StreetAddress2 ;
						self.Address.City := rt.Cont_PriorExec_City ;
						self.Address.State := rt.Cont_PriorExec_State ;
						self.Address.Zip5 := rt.Cont_PriorExec_Zip5 ;
						self.Address.Zip4 := rt.Cont_PriorExec_Zip4 ;
						self.Address.County := rt.Cont_PriorExec_County ;
						self.Address.PostalCode := rt.Cont_PriorExec_PostalCode ;
						self.Address.StateCityZip := rt.Cont_PriorExec_StateCityZip ;
						self.UniqueId := rt.Cont_PriorExec_UniqueId ;
						self.SSN := rt.Cont_PriorExec_SSN ;
						self.IsDeceased := rt.Cont_PriorExec_IsDeceased ;
						self.HasDerog := rt.Cont_PriorExec_HasDerog ;
						self.HasCriminalConviction := rt.Cont_PriorExec_HasCriminalConviction ;
						self.IsSexualOffender := rt.Cont_PriorExec_IsSexualOffender ;
						self.ExecutiveElsewhere := rt.Cont_PriorExec_ExecutiveElsewhere ;
						self.BestPosition.CompanyTitle := rt.Cont_PriorExec_BestPos_CompanyTitle ;
						self.BestPosition.FromDate.Year := rt.Cont_PriorExec_BestPos_From_Year ;
						self.BestPosition.FromDate.Month := rt.Cont_PriorExec_BestPos_From_Month ;
						self.BestPosition.FromDate.Day := rt.Cont_PriorExec_BestPos_From_Day ;
						self.BestPosition.ToDate.Year := rt.Cont_PriorExec_BestPos_To_Year ;
						self.BestPosition.ToDate.Month := rt.Cont_PriorExec_BestPos_To_Month ;
						self.BestPosition.ToDate.Day := rt.Cont_PriorExec_BestPos_To_Day ;
						self.OtherCurrents :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessPosition,
								self.CompanyTitle := rt.Cont_PriorExec_Curr_CompanyTitle ;
								self.FromDate.Year := rt.Cont_PriorExec_Curr_From_Year ;
								self.FromDate.Month := rt.Cont_PriorExec_Curr_From_Month ;
								self.FromDate.Day := rt.Cont_PriorExec_Curr_From_Day ;
								self.ToDate.Year := rt.Cont_PriorExec_Curr_To_Year ;
								self.ToDate.Month := rt.Cont_PriorExec_Curr_To_Month ;
								self.ToDate.Day := rt.Cont_PriorExec_Curr_To_Day ;
						));
						self.AllOthers :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.TopBusinessReport.t_TopBusinessPosition,
								self.CompanyTitle := rt.Cont_PriorExec_Other_CompanyTitle ;
								self.FromDate.Year := rt.Cont_PriorExec_Other_From_Year ;
								self.FromDate.Month := rt.Cont_PriorExec_Other_From_Month ;
								self.FromDate.Day := rt.Cont_PriorExec_Other_From_Day ;
								self.ToDate.Year := rt.Cont_PriorExec_Other_To_Year ;
								self.ToDate.Month := rt.Cont_PriorExec_Other_To_Month ;
								self.ToDate.Day := rt.Cont_PriorExec_Other_To_Day ;
						));
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID := rt.Cont_PriorExec_Docs_DotID ;
								self.BusinessIds.EmpID := rt.Cont_PriorExec_Docs_EmpID ;
								self.BusinessIds.POWID := rt.Cont_PriorExec_Docs_POWID ;
								self.BusinessIds.ProxID := rt.Cont_PriorExec_Docs_ProxID ;
								self.BusinessIds.SeleID := rt.Cont_PriorExec_Docs_SeleID ;
								self.BusinessIds.OrgID := rt.Cont_PriorExec_Docs_OrgID ;
								self.BusinessIds.UltID := rt.Cont_PriorExec_Docs_UltID ;
								self.IdType := rt.Cont_PriorExec_Docs_IdType ;
								self.IdValue := rt.Cont_PriorExec_Docs_IdValue ;
								self.Section := rt.Cont_PriorExec_Docs_Section ;
								self.Source := rt.Cont_PriorExec_Docs_Source ;
								self.Address.StreetNumber := rt.Cont_PriorExec_Docs_StreetNumber ;
								self.Address.StreetPreDirection := rt.Cont_PriorExec_Docs_StreetPreDirection ;
								self.Address.StreetName := rt.Cont_PriorExec_Docs_StreetName ;
								self.Address.StreetSuffix := rt.Cont_PriorExec_Docs_StreetSuffix ;
								self.Address.StreetPostDirection := rt.Cont_PriorExec_Docs_StreetPostDirection ;
								self.Address.UnitDesignation := rt.Cont_PriorExec_Docs_UnitDesignation ;
								self.Address.UnitNumber := rt.Cont_PriorExec_Docs_UnitNumber ;
								self.Address.StreetAddress1 := rt.Cont_PriorExec_Docs_StreetAddress1 ;
								self.Address.StreetAddress2 := rt.Cont_PriorExec_Docs_StreetAddress2 ;
								self.Address.City := rt.Cont_PriorExec_Docs_City ;
								self.Address.State := rt.Cont_PriorExec_Docs_State ;
								self.Address.Zip5 := rt.Cont_PriorExec_Docs_Zip5 ;
								self.Address.Zip4 := rt.Cont_PriorExec_Docs_Zip4 ;
								self.Address.County := rt.Cont_PriorExec_Docs_County ;
								self.Address.PostalCode := rt.Cont_PriorExec_Docs_PostalCode ;
								self.Address.StateCityZip := rt.Cont_PriorExec_Docs_StateCityZip ;
								self.Name.Full := rt.Cont_PriorExec_Docs_Full ;
								self.Name.First := rt.Cont_PriorExec_Docs_First ;
								self.Name.Middle := rt.Cont_PriorExec_Docs_Middle ;
								self.Name.Last := rt.Cont_PriorExec_Docs_Last ;
								self.Name.Suffix := rt.Cont_PriorExec_Docs_Suffix ;
								self.Name.Prefix := rt.Cont_PriorExec_Docs_Prefix ;
								self.Name.CompanyName := rt.Cont_PriorExec_Docs_CompanyName ;
						));
				));
		));
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_Contacts := join(CR_ConnectedBusiness, Seed_Files.BusinessCreditReport_keys.TopBusContacts,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_Contacts(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	working_layout append_Final (working_layout le, Seed_Files.BusinessCreditReport_keys.FinalSect rt) := transform
				//Activity
		self.Activity :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditActivity,
				self.SicCodes :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditCodeDescription,
						self.Code := rt.Act_Code ;
						self.Description := rt.Act_Description ;
						self.IsPrimary := rt.Act_isPrimary ;
				));
				self.NaicsCodes :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.businesscreditreport.t_BusinessCreditCodeDescription,
						self.Code := rt.Act_Naics_Code ;
						self.Description := rt.Act_Naics_Description ;
						self.IsPrimary := rt.Act_Naics_isPrimary ;
				));
		));
				//Additional Information
		self.AdditionalInfo :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditAdditionalInfo,
				self.CompanyNameVariations :=
					project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusinessreport.t_TopBusinessBestOtherCompany,
						self.CompanyName := rt.AddInfo_NameVar_CompanyName ;
						self.DateFirstSeen.Year := rt.AddInfo_NameVar_FSeen_Year ;
						self.DateFirstSeen.Month := rt.AddInfo_NameVar_FSeen_Month ;
						self.DateFirstSeen.Day := rt.AddInfo_NameVar_FSeen_Day ;
						self.DateLastSeen.Year := rt.AddInfo_NameVar_LSeen_Year ;
						self.DateLastSeen.Month := rt.AddInfo_NameVar_LSeen_Month ;
						self.DateLastSeen.Day := rt.AddInfo_NameVar_LSeen_Day ;
						self.Status := rt.AddInfo_NameVar_Status ;
						self.SourceDocs :=
							project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
								self.BusinessIds.DotID := rt.AddInfo_NameVar_Docs_DotID ;
								self.BusinessIds.EmpID := rt.AddInfo_NameVar_Docs_EmpID ;
								self.BusinessIds.POWID := rt.AddInfo_NameVar_Docs_POWID ;
								self.BusinessIds.ProxID := rt.AddInfo_NameVar_Docs_ProxID ;
								self.BusinessIds.SeleID := rt.AddInfo_NameVar_Docs_SeleID ;
								self.BusinessIds.OrgID := rt.AddInfo_NameVar_Docs_OrgID ;
								self.BusinessIds.UltID := rt.AddInfo_NameVar_Docs_UltID ;
								self.IdType := rt.AddInfo_NameVar_Docs_IdType ;
								self.IdValue := rt.AddInfo_NameVar_Docs_IdValue ;
								self.Section := rt.AddInfo_NameVar_Docs_Section ;
								self.Source := rt.AddInfo_NameVar_Docs_Source ;
								self.Address.StreetNumber := rt.AddInfo_NameVar_Docs_StreetNumber ;
								self.Address.StreetPreDirection := rt.AddInfo_NameVar_Docs_StreetPreDirection ;
								self.Address.StreetName := rt.AddInfo_NameVar_Docs_StreetName ;
								self.Address.StreetSuffix := rt.AddInfo_NameVar_Docs_StreetSuffix ;
								self.Address.StreetPostDirection := rt.AddInfo_NameVar_Docs_StreetPostDirection ;
								self.Address.UnitDesignation := rt.AddInfo_NameVar_Docs_UnitDesignation ;
								self.Address.UnitNumber := rt.AddInfo_NameVar_Docs_UnitNumber ;
								self.Address.StreetAddress1 := rt.AddInfo_NameVar_Docs_StreetAddress1 ;
								self.Address.StreetAddress2 := rt.AddInfo_NameVar_Docs_StreetAddress2 ;
								self.Address.City := rt.AddInfo_NameVar_Docs_City ;
								self.Address.State := rt.AddInfo_NameVar_Docs_State ;
								self.Address.Zip5 := rt.AddInfo_NameVar_Docs_Zip5 ;
								self.Address.Zip4 := rt.AddInfo_NameVar_Docs_Zip4 ;
								self.Address.County := rt.AddInfo_NameVar_Docs_County ;
								self.Address.PostalCode := rt.AddInfo_NameVar_Docs_PostalCode ;
								self.Address.StateCityZip := rt.AddInfo_NameVar_Docs_StateCityZip ;
								self.Name.Full := rt.AddInfo_NameVar_Docs_Full ;
								self.Name.First := rt.AddInfo_NameVar_Docs_First ;
								self.Name.Middle := rt.AddInfo_NameVar_Docs_Middle ;
								self.Name.Last := rt.AddInfo_NameVar_Docs_Last ;
								self.Name.Suffix := rt.AddInfo_NameVar_Docs_Suffix ;
								self.Name.Prefix := rt.AddInfo_NameVar_Docs_Prefix ;
								self.Name.CompanyName := rt.AddInfo_NameVar_Docs_CompanyName ;
						));
				));
				self.MailingAddress.StreetNumber := rt.AddInfo_StreetNumber ;
				self.MailingAddress.StreetPreDirection := rt.AddInfo_StreetPreDirection ;
				self.MailingAddress.StreetName := rt.AddInfo_StreetName ;
				self.MailingAddress.StreetSuffix := rt.AddInfo_StreetSuffix ;
				self.MailingAddress.StreetPostDirection := rt.AddInfo_StreetPostDirection ;
				self.MailingAddress.UnitDesignation := rt.AddInfo_UnitDesignation ;
				self.MailingAddress.UnitNumber := rt.AddInfo_UnitNumber ;
				self.MailingAddress.StreetAddress1 := rt.AddInfo_StreetAddress1 ;
				self.MailingAddress.StreetAddress2 := rt.AddInfo_StreetAddress2 ;
				self.MailingAddress.City := rt.AddInfo_City ;
				self.MailingAddress.State := rt.AddInfo_State ;
				self.MailingAddress.Zip5 := rt.AddInfo_Zip5 ;
				self.MailingAddress.Zip4 := rt.AddInfo_Zip4 ;
				self.MailingAddress.County := rt.AddInfo_County ;
				self.MailingAddress.PostalCode := rt.AddInfo_PostalCode ;
				self.MailingAddress.StateCityZip := rt.AddInfo_StateCityZip ;
				self.PhoneNumber := rt.AddInfo_PhoneNumber ;
				self.CompanyURL := rt.AddInfo_CompanyURL ;
		));
				//Phone Sources
		PhoneSources1 :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditPhoneSources,
				self.Source := rt.Phone1_Source ;
				self.DateFirstSeen.Year := rt.Phone1_FSeen_Year ;
				self.DateFirstSeen.Month := rt.Phone1_FSeen_Month ;
				self.DateFirstSeen.Day := rt.Phone1_FSeen_Day ;
				self.DateLastSeen.Year := rt.Phone1_LSeen_Year ;
				self.DateLastSeen.Month := rt.Phone1_LSeen_Month ;
				self.DateLastSeen.Day := rt.Phone1_LSeen_Day ;
				self.RecordCount := rt.Phone1_RecordCount ;
		));
		PhoneSources2 :=
			project(rt, transform(iesp.businesscreditreport.t_BusinessCreditPhoneSources,
				self.Source := rt.Phone2_Source ;
				self.DateFirstSeen.Year := rt.Phone2_FSeen_Year ;
				self.DateFirstSeen.Month := rt.Phone2_FSeen_Month ;
				self.DateFirstSeen.Day := rt.Phone2_FSeen_Day ;
				self.DateLastSeen.Year := rt.Phone2_LSeen_Year ;
				self.DateLastSeen.Month := rt.Phone2_LSeen_Month ;
				self.DateLastSeen.Day := rt.Phone2_LSeen_Day ;
				self.RecordCount := rt.Phone2_RecordCount ;
		));
		
		self.PhoneSources := PhoneSources1 + PhoneSources2;
	
		self := le;  // everything else from the left
		self := [];
	END;
	
	CR_Final := join(CR_Contacts, Seed_Files.BusinessCreditReport_keys.FinalSect,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		append_Final(left, right),
		LEFT OUTER, KEEP(2), ATMOST(RiskWise.max_atmost)
	);
	
	FinalSeed := project(CR_Final, Transform(iesp.businesscreditreport.t_BusinessCreditReportRecord, self := left, self := []));
	
	return FinalSeed;
END;

