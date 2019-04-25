EXPORT Acceptance_Criteria_Module := MODULE

IMPORT UT;
EXPORT AC_Macro(DS,f1,op) := MACRO

#uniquename(lay)
%lay% := record
STRING Attribute;
STRING Category;
STRING Acceptance_Criteria;  
STRING Result;
end;

#uniquename(tble)
%tble% := project(DS,transform({%lay%; Kel_Shell_QA.Layouts.Base_Layout},
                                     self.Attribute:=f1;
																		 self.Category:=MAP(f1 in ['ArrestCnt1Y',	'ArrestCnt7Y',	'ArrestNew1Y',	'ArrestOld1Y',	'ArrestNew7Y',	'ArrestOld7Y',	'MonSinceNewestArrestCnt1Y',	'MonSinceOldestArrestCnt1Y',	'MonSinceNewestArrestCnt7Y',	'MonSinceOldestArrestCnt7Y',	'CrimCnt1Y',	'CrimCnt7Y',	'CrimNew1Y',	'CrimOld1Y',	'CrimNew7Y',	'CrimOld7Y',	'MonSinceNewestCrimCnt1Y',	'MonSinceOldestCrimCnt1Y',	'MonSinceNewestCrimCnt7Y',	'MonSinceOldestCrimCnt7Y',	'FelonyCnt1Y',	'FelonyCnt7Y',	'FelonyNew1Y',	'FelonyOld1Y',	'FelonyNew7Y',	'FelonyOld7Y',	'MonSinceNewestFelonyCnt1Y',	'MonSinceOldestFelonyCnt1Y',	'MonSinceNewestFelonyCnt7Y',	'MonSinceOldestFelonyCnt7Y',	'NonfelonyCnt1Y',	'NonfelonyCnt7Y',	'NonfelonyNew1Y',	'NonfelonyOld1Y',	'NonfelonyNew7Y',	'NonfelonyOld7Y',	'MonSinceNewestNonfelonyCnt1Y',	'MonSinceOldestNonfelonyCnt1Y',	'MonSinceNewestNonfelonyCnt7Y',	'MonSinceOldestNonfelonyCnt7Y',	'CrimSeverityIndex7Y',	'CrimBehaviorIndex7Y']
																																=>'Criminal History',
																												f1 in ['BkCount120',	'BkCount24',	'BkFilingDateOldest120',	'BkFilingDateNewest120',	'BkTimeOldest120',	'BkTimeNewest120',	'BkChapter120',	'BkCh7Count120',	'BkCh13Count120',	'BkUpdateDateNewest120',	'BkTimeNewestUpdate120',	'BkDispositionDateNewest120',	'BkDisposition120',	'BkDismissedCount120',	'BkDismissedCount24',	'BkDisposedCount120',	'BkDischargedCount120',	'BkBusinessFiling120',	'BkSeverityIndex120']
																																=>'Bankruptcy_History',
																												f1 in ['ExecutiveCount',	'ExecutiveBusinessCount',	'ExecutiveBusinessAvg',	'ExecutiveActiveBusinessCount',	'ExecutiveActiveBusinessAvg',	'ExecutiveActiveBusinessPct',	'ExecutivePropOwnerCount',	'ExecutivePropOwnerPct',	'ExecutiveDerogCount',	'ExecutiveDerogPct',	'ExecutiveDerogIndex',	'ExecutiveFelonyCount',	'ExecutiveFelonyPct',	'ExecutiveCriminalCount',	'ExecutiveCriminalPct',	'ExecutiveBankruptcyCount',	'ExecutiveBankruptcyPct',	'ExecutiveEvictionCount',	'ExecutiveEvictionPct',	'ExecutiveLienCount',	'ExecutiveLienPct',	'ExecutiveJudgmentCount',	'ExecutiveJudgmentPct']				
																																=>'Business_Executive',
																												f1 in ['BusBkCount120',	'BusBkDisposedCount120',	'BusBkDischargedCount120',	'BusBkDismissedCount120',	'BusBkCh7Count120',	'BusBkCh11Count120',	'BusBkCh13Count120',	'BusBkTimeOldest120',	'BusBkTimeNewest120',	'BusBkTimeNewestUpdate120',	'BusBkNewestChapter120',	'BusBkNewestDisposition120',	'BusBkDateOldest120',	'BusBkDateNewest120',	'BusBkDateNewestUpdate120']
																												        =>'Business_Bankruptcy',
																												f1 in ['AssociateCount',	'AssociateBusinessCount',	'AssociateBusinessAvg',	'AssociateActiveBusinessCount',	'AssociateActiveBusinessAvg',	'AssociateActiveBusinessPct',	'AssociatePropOwnerCount',	'AssociatePropOwnerPct',	'AssociateDerogCount',	'AssociateDerogPct',	'AssociateDerogIndex',	'AssociateFelonyCount',	'AssociateFelonyPct',	'AssociateCriminalCount',	'AssociateCriminalPct',	'AssociateBankruptcyCount',	'AssociateBankruptcyPct',	'AssociateEvictionCount',	'AssociateEvictionPct',	'AssociateLienCount',	'AssociateLienPct',	'AssociateJudgmentCount',	'AssociateJudgmentPct']
																												        =>'Business_Associate',
																												f1 in ['InqTimeNewest12',	'InqTimeOldest12',	'InqTimeNewest60',	'InqTimeOldest60',	'InqCountDay',	'InqCountWeek',	'InqCount01',	'InqCount03',	'InqCount06',	'InqCount12',	'InqCount24',	'InqCount60',	'InqAutoTimeNewest12',	'InqAutoTimeOldest12',	'InqAutoTimeNewest60',	'InqAutoTimeOldest60',	'InqAutoCountDay',	'InqAutoCountWeek',	'InqAutoCount01',	'InqAutoCount03',	'InqAutoCount06',	'InqAutoCount12',	'InqAutoCount24',	'InqAutoCount60',	'InqBankingTimeNewest12',	'InqBankingTimeOldest12',	'InqBankingTimeNewest60',	'InqBankingTimeOldest60',	'InqBankingCountDay',	'InqBankingCountWeek',	'InqBankingCount01',	'InqBankingCount03',	'InqBankingCount06',	'InqBankingCount12',	'InqBankingCount24',	'InqBankingCount60',	'InqCommTimeNewest12',	'InqCommTimeOldest12',	'InqCommTimeNewest60',	'InqCommTimeOldest60',	'InqCommCountDay',	'InqCommCountWeek',	'InqCommCount01',	'InqCommCount03',	'InqCommCount06',	'InqCommCount12',	'InqCommCount24',	'InqCommCount60',	'InqCreditSeekingTimeNewest12',	'InqCreditSeekingTimeOldest12',	'InqCreditSeekingTimeNewest60',	'InqCreditSeekingTimeOldest60',	'InqCreditSeekingCountDay',	'InqCreditSeekingCountWeek',	'InqCreditSeekingCount01',	'InqCreditSeekingCount03',	'InqCreditSeekingCount06',	'InqCreditSeekingCount12',	'InqCreditSeekingCount24',	'InqCreditSeekingCount60',	'InqHighRiskTimeNewest12',	'InqHighRiskTimeOldest12',	'InqHighRiskTimeNewest60',	'InqHighRiskTimeOldest60',	'InqHighRiskCountDay',	'InqHighRiskCountWeek',	'InqHighRiskCount01',	'InqHighRiskCount03',	'InqHighRiskCount06',	'InqHighRiskCount12',	'InqHighRiskCount24',	'InqHighRiskCount60',	'InqMortgageTimeNewest12',	'InqMortgageTimeOldest12',	'InqMortgageTimeNewest60',	'InqMortgageTimeOldest60',	'InqMortgageCountDay',	'InqMortgageCountWeek',	'InqMortgageCount01',	'InqMortgageCount03',	'InqMortgageCount06',	'InqMortgageCount12',	'InqMortgageCount24',	'InqMortgageCount60',	'InqOtherTimeNewest12',	'InqOtherTimeOldest12',	'InqOtherTimeNewest60',	'InqOtherTimeOldest60',	'InqOtherCountDay',	'InqOtherCountWeek',	'InqOtherCount01',	'InqOtherCount03',	'InqOtherCount06',	'InqOtherCount12',	'InqOtherCount24',	'InqOtherCount60',	'InqPrepaidCardsTimeNewest12',	'InqPrepaidCardsTimeOldest12',	'InqPrepaidCardsTimeNewest60',	'InqPrepaidCardsTimeOldest60',	'InqPrepaidCardsCountDay',	'InqPrepaidCardsCountWeek',	'InqPrepaidCardsCount01',	'InqPrepaidCardsCount03',	'InqPrepaidCardsCount06',	'InqPrepaidCardsCount12',	'InqPrepaidCardsCount24',	'InqPrepaidCardsCount60',	'InqRetailTimeNewest12',	'InqRetailTimeOldest12',	'InqRetailTimeNewest60',	'InqRetailTimeOldest60',	'InqRetailCountDay',	'InqRetailCountWeek',	'InqRetailCount01',	'InqRetailCount03',	'InqRetailCount06',	'InqRetailCount12',	'InqRetailCount24',	'InqRetailCount60',	'InqRetailPaymentTimeNewest12',	'InqRetailPaymentTimeOldest12',	'InqRetailPaymentTimeNewest60',	'InqRetailPaymentTimeOldest60',	'InqRetailPaymentCountDay',	'InqRetailPaymentCountWeek',	'InqRetailPaymentCount01',	'InqRetailPaymentCount03',	'InqRetailPaymentCount06',	'InqRetailPaymentCount12',	'InqRetailPaymentCount24',	'InqRetailPaymentCount60',	'InqStudentLoanTimeNewest12',	'InqStudentLoanTimeOldest12',	'InqStudentLoanTimeNewest60',	'InqStudentLoanTimeOldest60',	'InqStudentLoanCountDay',	'InqStudentLoanCountWeek',	'InqStudentLoanCount01',	'InqStudentLoanCount03',	'InqStudentLoanCount06',	'InqStudentLoanCount12',	'InqStudentLoanCount24',	'InqStudentLoanCount60',	'InqUtilityTimeNewest12',	'InqUtilityTimeOldest12',	'InqUtilityTimeNewest60',	'InqUtilityTimeOldest60',	'InqUtilityCountDay',	'InqUtilityCountWeek',	'InqUtilityCount01',	'InqUtilityCount03',	'InqUtilityCount06',	'InqUtilityCount12',	'InqUtilityCount24',	'InqUtilityCount60',	'InqQuizProviderTimeNewest12',	'InqQuizProviderTimeOldest12',	'InqQuizProviderTimeNewest60',	'InqQuizProviderTimeOldest60',	'InqQuizProviderCountDay',	'InqQuizProviderCountWeek',	'InqQuizProviderCount01',	'InqQuizProviderCount03',	'InqQuizProviderCount06',	'InqQuizProviderCount12',	'InqQuizProviderCount24',	'InqQuizProviderCount60',	'InqCollectionTimeNewest12',	'InqCollectionTimeOldest12',	'InqCollectionTimeNewest60',	'InqCollectionTimeOldest60',	'InqCollectionCountDay',	'InqCollectionCountWeek',	'InqCollectionCount01',	'InqCollectionCount03',	'InqCollectionCount06',	'InqCollectionCount12',	'InqCollectionCount24',	'InqCollectionCount60']				
																												        =>'Inquiry_History',
																																	 'NA');
																		 self:=left;		
																		 self:=[];
														  ));
															
#uniquename(pjt)
%pjt%:= MAP( 

// Criminal_History
count(%tble%(Category='Criminal History'))>=1 =>

project(%tble%,transform(%lay%,
	 self.Acceptance_Criteria:='Check ArrestCnt1Y range 0~99 (except for -99) ';
	 self.Result:=if(left.Category ='Criminal History' and left.Attribute in ['ArrestCnt1Y'] and ( (integer)left.#expand(f1) in [-99] or (integer)left.#expand(f1) between 0 and 99 ),'PASS','FAIL');
	 self:=left;
									 ))+
project(%tble%,transform(%lay%,
	 self.Acceptance_Criteria:='Check ArrestCnt7Y range 0~999 (except for -99) ';
	 self.Result:=if(left.Category ='Criminal History' and left.Attribute in ['ArrestCnt7Y'] and ( (integer)left.#expand(f1) in [-99] or (integer)left.#expand(f1) between 0 and 999 ),'PASS','FAIL');
	 self:=left;
									 ))+
project(%tble%,transform(%lay%,
	 self.Acceptance_Criteria:='Check MonSinceNewestArrestCnt1Y and MonSinceOldestArrestCnt1Y range 0~12 (except for -99, -98, -97)';
	 self.Result:=if(left.Category ='Criminal History' and left.Attribute in ['MonSinceNewestArrestCnt1Y','MonSinceOldestArrestCnt1Y'] and 
	                  ((integer)left.#expand(f1) in [-97,-98,-99] or (integer)left.#expand(f1) between 0 and 12) ,'PASS','FAIL');
	 self:=left;
									 ))+									 
project(%tble%,transform(%lay%,
	 self.Acceptance_Criteria:='Check MonSinceNewestArrestCnt7Y and MonSinceOldestArrestCnt7Y range 0~84 (except for -99, -98, -97) ';
	 self.Result:=if(left.Category ='Criminal History' and left.Attribute in ['MonSinceNewestArrestCnt7Y','MonSinceOldestArrestCnt7Y'] and 
	                  ( (integer)left.#expand(f1) in [-97,-98,-99] or (integer)left.#expand(f1) between 0 and 84) ,'PASS','FAIL');
	 self:=left;
									 ))+			
// InputArchiveDateClean must be in (YYYYMM or YYYYMMDD or YYYYMMDDTTTT) format
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check [# of months between InputArchiveDateClean and ArrestNew1Y] = MonSinceNewestArrestCnt1Y (except for -99, -98, -97)  ';
						 self.Result:=if(left.Category ='Criminal History' and left.Attribute in['BkCount120','BkCount24','BkFilingDateOldest120','BkFilingDateNewest120','BkTimeOldest120','BkTimeNewest120'] and 
						                 (left.#expand(f1)  in['-97','-98','-99'] or
														 (integer)ut.monthsApart_YYYYMMDD((string)left.InputArchiveDateClean,(string)left.ArrestNew1Y)=(integer)left.MonSinceNewestArrestCnt1Y),'PASS','FAIL');
						 self:=left;
                             ))+														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check [# of months between InputArchiveDateClean and ArrestOld1Y] = MonSinceOldestArrestCnt1Y (except for -99, -98, -97)  ';
						 self.Result:=if(left.Category ='Criminal History' and left.Attribute in['BkCount120','BkCount24','BkFilingDateOldest120','BkFilingDateNewest120','BkTimeOldest120','BkTimeNewest120'] and 
						                 (left.#expand(f1)  in['-97','-98','-99'] or
														 (integer)ut.monthsApart_YYYYMMDD((string)left.InputArchiveDateClean,(string)left.ArrestOld1Y)=(integer)left.MonSinceOldestArrestCnt1Y),'PASS','FAIL');
						 self:=left;
                             ))+														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check [# of months between InputArchiveDateClean and ArrestNew7Y] = MonSinceNewestArrestCnt7Y (except for -99, -98, -97)   ';
						 self.Result:=if(left.Category ='Criminal History' and left.Attribute in['BkCount120','BkCount24','BkFilingDateOldest120','BkFilingDateNewest120','BkTimeOldest120','BkTimeNewest120'] and 
						                 (left.#expand(f1)  in['-97','-98','-99'] or
														 (integer)ut.monthsApart_YYYYMMDD((string)left.InputArchiveDateClean,(string)left.ArrestNew7Y)=(integer)left.MonSinceNewestArrestCnt7Y),'PASS','FAIL');
						 self:=left;
                             ))+															 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:=' Check [# of months between InputArchiveDateClean and ArrestOld7Y] = MonSinceOldestArrestCnt7Y (except for -99, -98, -97)  ';
						 self.Result:=if(left.Category ='Criminal History' and left.Attribute in['BkCount120','BkCount24','BkFilingDateOldest120','BkFilingDateNewest120','BkTimeOldest120','BkTimeNewest120'] and 
						                 (left.#expand(f1)  in['-97','-98','-99'] or
														 (integer)ut.monthsApart_YYYYMMDD((string)left.InputArchiveDateClean,(string)left.ArrestOld7Y)=(integer)left.MonSinceOldestArrestCnt7Y),'PASS','FAIL');
						 self:=left;
                             ))+					
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ArrestCnt1Y <= ArrestCnt7Y ';
						 self.Result:=if(left.Category ='Criminal History' and left.Attribute in ['ArrestCnt1Y','ArrestCnt7Y'] and 
						                 (integer)left.ArrestCnt1Y<=(integer)left.ArrestCnt7Y  ,'PASS','FAIL');
						 self:=left;
                             ))+	
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ArrestNew1Y >= ArrestOld1Y (except for -99, -98, -97) ';
						 self.Result:=if(left.Category ='Criminal History' and left.Attribute in ['ArrestNew1Y','ArrestOld1Y'] and 
						                (left.#expand(f1)  in ['-97','-98','-99'] or (integer)left.ArrestNew1Y>=(integer)left.ArrestOld1Y) ,'PASS','FAIL');
						 self:=left;
                             ))+														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ArrestNew7Y >= ArrestOld7Y (except for -99, -98, -97) ';
						 self.Result:=if(left.Category ='Criminal History' and left.Attribute in ['ArrestNew7Y','ArrestOld7Y'] and 
						                (left.#expand(f1)  in ['-97','-98','-99'] or (integer)left.ArrestNew7Y>=(integer)left.ArrestOld7Y) ,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check MonSinceNewestArrestCnt1Y <= MonSinceOldestArrestCnt1Y (except for -99, -98, -97)';
						 self.Result:=if(left.Category ='Criminal History' and left.Attribute in ['MonSinceNewestArrestCnt1Y','MonSinceOldestArrestCnt1Y'] and 
						                 (left.#expand(f1)  in ['-97','-98','-99'] or (integer)left.MonSinceNewestArrestCnt1Y<=(integer)left.MonSinceOldestArrestCnt1Y) ,'PASS','FAIL');
						 self:=left;
                             ))+															 													 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check MonSinceNewestArrestCnt7Y <= MonSinceOldestArrestCnt7Y (except for -99, -98, -97) ';
						 self.Result:=if(left.Category ='Criminal History' and left.Attribute in ['MonSinceNewestArrestCnt7Y','MonSinceOldestArrestCnt7Y'] and 
						                 (left.#expand(f1)  in ['-97','-98','-99'] or(integer)left.MonSinceNewestArrestCnt7Y<=(integer)left.MonSinceOldestArrestCnt7Y ),'PASS','FAIL');
						 self:=left;
                             ))+															 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:=' Check MonSinceNewestArrestCnt1Y <= MonSinceNewestArrestCnt7Y (except for -99, -98, -97)  ';
						 self.Result:=if(left.Category ='Criminal History' and left.Attribute in ['MonSinceNewestArrestCnt1Y','MonSinceNewestArrestCnt7Y'] and 
						                 (left.#expand(f1)  in ['-97','-98','-99'] or(integer)left.MonSinceNewestArrestCnt1Y<=(integer)left.MonSinceNewestArrestCnt7Y ),'PASS','FAIL');
						 self:=left;
                             ))+																 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check MonSinceOldestArrestCnt1Y <= MonSinceOldestArrestCnt7Y (except for -99, -98, -97) ';
						 self.Result:=if(left.Category ='Criminal History' and left.Attribute in ['MonSinceOldestArrestCnt1Y','MonSinceOldestArrestCnt7Y'] and 
						                 (left.#expand(f1)  in ['-97','-98','-99'] or(integer)left.MonSinceOldestArrestCnt1Y<=(integer)left.MonSinceOldestArrestCnt7Y ),'PASS','FAIL');
						 self:=left;
                             ))+													 
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check when ArrestCnt1Y=0, then ArrestNew1Y=ArrestOld1Y=MonSinceNewestArrestCnt1Y=MonSinceOldestArrestCnt1Y=-98  ';
						 self.Result:=MAP(
						                 left.Category ='Criminal History' and left.Attribute in ['ArrestCnt1Y'] and 
						                 (integer)left.ArrestCnt1Y=0 and 
														 (integer)left.ArrestNew1Y=(integer)left.ArrestOld1Y and 
														 (integer)left.ArrestOld1Y=(integer)left.MonSinceNewestArrestCnt1Y and
														 (integer)left.MonSinceNewestArrestCnt1Y=(integer)left.MonSinceOldestArrestCnt1Y and
														 (integer)left.MonSinceOldestArrestCnt1Y=-98 =>'PASS',
														 
														  left.Category ='Criminal History' and left.Attribute in ['ArrestCnt1Y'] and 
						                 (integer)left.ArrestCnt1Y<>0  =>'PASS',
														 
														 'FAIL');
						 self:=left;
                             ))+													 
														 														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check when ArrestCnt7Y=0, then ArrestNew7Y=ArrestOld7Y=MonSinceNewestArrestCnt7Y=MonSinceOldestArrestCnt7Y=-98  ';
						 self.Result:=MAP(
						                 left.Category ='Criminal History' and left.Attribute in ['ArrestCnt7Y'] and 
						                 (integer)left.ArrestCnt7Y=0 and 
														 (integer)left.ArrestNew7Y=(integer)left.ArrestOld7Y and 
														 (integer)left.ArrestOld7Y=(integer)left.MonSinceNewestArrestCnt7Y and
														 (integer)left.MonSinceNewestArrestCnt7Y=(integer)left.MonSinceOldestArrestCnt7Y and
														 (integer)left.MonSinceOldestArrestCnt7Y=-98 =>'PASS',
														 
														  left.Category ='Criminal History' and left.Attribute in ['ArrestCnt7Y'] and 
						                 (integer)left.ArrestCnt7Y<>0  =>'PASS',
														 
														 'FAIL');
						 self:=left;
                             ))+													 
														 																		 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check when ArrestCnt1Y>0, then ArrestNew1Y=ArrestNew7Y and MonSinceNewestArrestCnt1Y=MonSinceNewestArrestCnt7Y (except for -97)  ';
						 self.Result:=MAP(
						                 left.Category ='Criminal History' and left.Attribute in ['ArrestCnt1Y'] and 
														 left.#expand(f1) in ['-97'] =>'PASS',
														 
														 left.Category ='Criminal History' and left.Attribute in ['ArrestCnt1Y'] and 
						                 (integer)left.#expand(f1)>0 and 
														 (integer)left.ArrestNew1Y=(integer)left.ArrestNew7Y and 
														 (integer)left.MonSinceNewestArrestCnt1Y=(integer)left.MonSinceNewestArrestCnt7Y) =>'PASS',
														 
														  left.Category ='Criminal History' and left.Attribute in ['ArrestCnt1Y'] and 
						                 (integer)left.#expand(f1)<0  =>'PASS',
														 
														 'FAIL');
						 self:=left;
                             ))+															 
														 														 																																						 
														 
//Bankruptcy_History
count(%tble%(Category='Bankruptcy_History'))>=1 =>

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BkCount120 >= BkCount24 (except for -99) ';
						 self.Result:=if(left.Category ='Bankruptcy_History' and left.Attribute in['BkCount120','BkCount24','BkFilingDateOldest120','BkFilingDateNewest120','BkTimeOldest120','BkTimeNewest120'] and 
						                 left.#expand(f1) <> '-99' and (integer)left.BkCount120>=(integer)left.BkCount24 and ,'PASS','FAIL');
						 self:=left;
                             ))+
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BkFilingDateNewest120 >= BkFilingDateOldest120 (except for -97, -98, -99) ';
						 self.Result:=if(left.Category ='Bankruptcy_History' and left.Attribute in['BkCount120','BkCount24','BkFilingDateOldest120','BkFilingDateNewest120','BkTimeOldest120','BkTimeNewest120'] and 
						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.BkFilingDateNewest120>=(integer)left.BkFilingDateOldest120,'PASS','FAIL');
						 self:=left;
                             ))+														 

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BkTimeNewest120 <= BkTimeOldest120 (except for -97, -98, -99) ';
						 self.Result:=if(left.Category ='Bankruptcy_History' and left.Attribute in['BkCount120','BkCount24','BkFilingDateOldest120','BkFilingDateNewest120','BkTimeOldest120','BkTimeNewest120'] and 
						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.BkTimeNewest120<=(integer)left.BkTimeOldest120,'PASS','FAIL');
						 self:=left;
                             ))+														 

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check Months between [BkFilingDateOldest120, archive date] = BkTimeOldest120 (except for -97, -98, -99) ';
						 self.Result:=if(left.Category ='Bankruptcy_History' and left.Attribute in['BkCount120','BkCount24','BkFilingDateOldest120','BkFilingDateNewest120','BkTimeOldest120','BkTimeNewest120'] and 
						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)kel_Shell_QA.MonthsApart(left.BkFilingDateOldest120,left.archivedate)=(integer)left.BkTimeOldest120,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check Months between [BkFilingDateNewest120, archive date] = BkTimeNewest120 (except for -97, -98, -99) ';
						 self.Result:=if(left.Category ='Bankruptcy_History' and left.Attribute in['BkCount120','BkCount24','BkFilingDateOldest120','BkFilingDateNewest120','BkTimeOldest120','BkTimeNewest120'] and 
						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)kel_Shell_QA.MonthsApart(left.BkFilingDateNewest120,left.archivedate)=(integer)left.BkTimeNewest120,'PASS','FAIL');
						 self:=left;
                             ))+			
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BkUpdateDateNewest120 >= BkTimeNewestUpdate120';
						 self.Result:=if(left.Category ='Bankruptcy_History' and left.Attribute in['BkUpdateDateNewest120','BkTimeNewestUpdate120'] and 
						                 (integer)left.BkFilingDateNewest120>=(integer)left.BkFilingDateOldest120,'PASS','FAIL');
						 self:=left;
                             )),
// Business_Associate		
count(%tble%(Category='Business_Associate'))>=1 =>												 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateBusinessAvg <= AssociateBusinessCount';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateCount',	'AssociateBusinessCount',	'AssociateBusinessAvg'] and 
						                 (integer)left.AssociateBusinessAvg<=(integer)left.AssociateBusinessCount,'PASS','FAIL');
						 self:=left;
                             ))+
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateBusinessCount = AssociateCount * AssociateBusinessAvg';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateCount',	'AssociateBusinessCount',	'AssociateBusinessAvg'] and 
						                 (integer)left.AssociateBusinessCount=(integer)left.AssociateCount * (integer)left.AssociateBusinessAvg,'PASS','FAIL');
						 self:=left;
                             ))+														 

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateActiveBusinessAvg<= AssociateActiveBusinessCount ';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateActiveBusinessCount',	'AssociateActiveBusinessAvg',	'AssociateActiveBusinessPct'] and 
						                 (integer)left.AssociateActiveBusinessAvg<=(integer)left.AssociateActiveBusinessCount,'PASS','FAIL');
						 self:=left;
                             ))+
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateActiveBusinessCount= AssociateCount * AssociateActiveBusinessAvg ';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateActiveBusinessCount',	'AssociateActiveBusinessAvg',	'AssociateActiveBusinessPct'] and 
						                 (integer)left.AssociateActiveBusinessCount=(integer)left.AssociateCount * (integer)left.AssociateActiveBusinessAvg,'PASS','FAIL');
						 self:=left;
                             ))+		

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateActiveBusinessAvg <= AssociateBusinessAvg ';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateActiveBusinessCount',	'AssociateActiveBusinessAvg',	'AssociateActiveBusinessPct'] and 
						                 (integer)left.AssociateActiveBusinessAvg<=(integer)left.AssociateBusinessAvg,'PASS','FAIL');
						 self:=left;
                             ))+

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateActiveBusinessCount <= AssociateBusinessCount';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateActiveBusinessCount',	'AssociateActiveBusinessAvg',	'AssociateActiveBusinessPct'] and 
						                 (integer)left.AssociateActiveBusinessCount<=(integer)left.AssociateBusinessCount,'PASS','FAIL');
						 self:=left;
                             ))+
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateActiveBusinessPct = AssociateActiveBusinessCount / AssociateBusinessCount ';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateActiveBusinessCount',	'AssociateActiveBusinessAvg',	'AssociateActiveBusinessPct'] and 
						                 (integer)left.AssociateActiveBusinessPct=(integer)left.AssociateActiveBusinessCount / (integer)left.AssociateBusinessCount,'PASS','FAIL');
						 self:=left;
                             ))+														 

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociatePropOwnerCount <= AssociateCount ';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociatePropOwnerCount',	'AssociatePropOwnerPct'] and 
						                 (integer)left.AssociatePropOwnerCount<=(integer)left.AssociateCount,'PASS','FAIL');
						 self:=left;
                             ))+
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociatePropOwnerPct = AssociatePropOwnerCount / AssociateCount ';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociatePropOwnerCount',	'AssociatePropOwnerPct'] and 
						                 (integer)left.AssociatePropOwnerPct=(integer)left.AssociatePropOwnerCount / (integer)left.AssociateCount,'PASS','FAIL');
						 self:=left;
                             ))+	

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateDerogCount <= AssociateCount ';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateDerogCount',	'AssociateDerogPct',	'AssociateDerogIndex'] and 
						                 (integer)left.AssociateDerogCount<=(integer)left.AssociateCount,'PASS','FAIL');
						 self:=left;
                             ))+
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateDerogPct = AssociateDerogCount / AssociateCount  ';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateDerogCount',	'AssociateDerogPct',	'AssociateDerogIndex'] and 
						                 (integer)left.AssociateDerogPct =(integer)left.AssociateDerogCount / (integer)left.AssociateCount,'PASS','FAIL');
						 self:=left;
                             ))+		
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateFelonyCount <= AssociateDerogCount';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateFelonyCount',	'AssociateFelonyPct',	'AssociateCriminalCount','AssociateCriminalPct'] and 
						                 (integer)left.AssociateFelonyCount <=(integer)left.AssociateDerogCount ,'PASS','FAIL');
						 self:=left;
                             ))+														 

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateFelonyPct <= AssociateDerogPct';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateFelonyCount',	'AssociateFelonyPct',	'AssociateCriminalCount','AssociateCriminalPct'] and 
						                 (integer)left.AssociateFelonyPct <=(integer)left.AssociateDerogPct ,'PASS','FAIL');
						 self:=left;
                             ))+		
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateFelonyPct = AssociateFelonyCount / AssociateCount';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateFelonyCount',	'AssociateFelonyPct',	'AssociateCriminalCount','AssociateCriminalPct'] and 
						                 (integer)left.AssociateFelonyPct =(integer)left.AssociateFelonyCount / (integer)left.AssociateCount,'PASS','FAIL');
						 self:=left;
                             ))+														 

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check align with AssociateDerogIndex';
						 self.Result:=MAP(left.Category ='Business_Associate' and left.Attribute in['AssociateFelonyCount',	'AssociateFelonyPct',	'AssociateCriminalCount','AssociateCriminalPct'] and 
						                  (integer)left.AssociateFelonyCount >0 and (integer)left.AssociateFelonyPct > 0 and (integer)left.AssociateDerogIndex =4 =>'PASS',
														  left.Category ='Business_Associate' and left.Attribute in['AssociateFelonyCount',	'AssociateFelonyPct',	'AssociateCriminalCount','AssociateCriminalPct'] and 
						                  ((integer)left.AssociateFelonyCount <=0 or (integer)left.AssociateFelonyPct <= 0) and (integer)left.AssociateDerogIndex <>4 =>'PASS',
														 'FAIL');
						 self:=left;
                             ))+
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateCriminalCount<= AssociateCount';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateFelonyCount',	'AssociateFelonyPct',	'AssociateCriminalCount','AssociateCriminalPct'] and 
						                 (integer)left.AssociateCriminalCount <=(integer)left.AssociateCount,'PASS','FAIL');
						 self:=left;
                             ))+														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateCriminalPct = AssociateCriminalCount / AssociateCount';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateFelonyCount',	'AssociateFelonyPct',	'AssociateCriminalCount','AssociateCriminalPct'] and 
						                 (integer)left.AssociateCriminalPct =(integer)left.AssociateCriminalCount / (integer)left.AssociateCount,'PASS','FAIL');
						 self:=left;
                             ))+
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateBankruptcyCount <= AssociateDerogCount';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateBankruptcyCount',	'AssociateBankruptcyPct',	'AssociateEvictionCount','AssociateEvictionPct'] and 
						                 (integer)left.AssociateBankruptcyCount <=(integer)left.AssociateDerogCount ,'PASS','FAIL');
						 self:=left;
						                ))+
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateBankruptcyPct <= AssociateDerogPct';
						  self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateBankruptcyCount',	'AssociateBankruptcyPct',	'AssociateEvictionCount','AssociateEvictionPct'] and 
						                 (integer)left.AssociateBankruptcyPct <=(integer)left.AssociateDerogPct,'PASS','FAIL');
						 self:=left;
                             ))+
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateBankruptcyPct = AssociateBankruptcyCount / AssociateCount';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateBankruptcyCount',	'AssociateBankruptcyPct',	'AssociateEvictionCount','AssociateEvictionPct'] and 
						                 (integer)left.AssociateBankruptcyPct =(integer)left.AssociateBankruptcyCount / (integer)left.AssociateCount,'PASS','FAIL');
						 self:=left;
                             ))+
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check align with AssociateDerogIndex';
						 self.Result:=MAP(left.Category ='Business_Associate' and left.Attribute in['AssociateBankruptcyCount',	'AssociateBankruptcyPct',	'AssociateEvictionCount','AssociateEvictionPct'] and 
						                  (integer)left.AssociateBankruptcyCount  > 0 and (integer)left.AssociateBankruptcyPct  > 0 and (integer)left.AssociateFelonyCount=0 and (integer)left.AssociateDerogIndex =3 =>'PASS',
														  left.Category ='Business_Associate' and left.Attribute in['AssociateBankruptcyCount',	'AssociateBankruptcyPct',	'AssociateEvictionCount','AssociateEvictionPct'] and 
						                  ((integer)left.AssociateBankruptcyCount <=0 or (integer)left.AssociateBankruptcyPct <= 0 or (integer)left.AssociateFelonyCount>0) and (integer)left.AssociateDerogIndex  <>3 =>'PASS',
														 'FAIL');
						 self:=left;
                             ))+
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateEvictionCount <= AssociateCount';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateBankruptcyCount',	'AssociateBankruptcyPct',	'AssociateEvictionCount','AssociateEvictionPct'] and 
						                 (integer)left.AssociateEvictionCount <=(integer)left.AssociateCount ,'PASS','FAIL');
						 self:=left;
                             ))+
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateEvictionPct = AssociateEvictionCount / AssociateCount';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateBankruptcyCount',	'AssociateBankruptcyPct',	'AssociateEvictionCount','AssociateEvictionPct'] and 
						                 (integer)left.AssociateEvictionPct =(integer)left.AssociateEvictionCount / (integer)left.AssociateCount,'PASS','FAIL');
						 self:=left;
                             ))+		

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateLienCount <= AssociateDerogCount';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateLienCount',	'AssociateLienPct',	'AssociateJudgmentCount','AssociateJudgmentPct'] and 
						                 (integer)left.AssociateLienCount <=(integer)left.AssociateDerogCount ,'PASS','FAIL');
						 self:=left;
                             ))+	

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateLienPct <= AssociateDerogPct';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateLienCount',	'AssociateLienPct',	'AssociateJudgmentCount','AssociateJudgmentPct'] and 
						                 (integer)left.AssociateLienPct <=(integer)left.AssociateDerogPct ,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateLienPct = AssociateLienCount / AssociateCount ';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateLienCount',	'AssociateLienPct',	'AssociateJudgmentCount','AssociateJudgmentPct'] and 
						                 (integer)left.AssociateLienPct =(integer)left.AssociateLienCount / (integer)left.AssociateCount,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateLienCount /AssociateLienPct align with AssociateDerogIndex ';
						 self.Result:=MAP(left.Category ='Business_Associate' and left.Attribute in['AssociateLienCount',	'AssociateLienPct',	'AssociateJudgmentCount','AssociateJudgmentPct'] and 
						                  (integer)left.AssociateLienCount  >0 and (integer)left.AssociateLienPct   > 0 and (integer)left.AssociateFelonyCount=0 and (integer)left.AssociateBankruptcyCount=0 and (integer)left.AssociateDerogIndex  =2 =>'PASS',
														  left.Category ='Business_Associate' and left.Attribute in['AssociateLienCount',	'AssociateLienPct',	'AssociateJudgmentCount','AssociateJudgmentPct'] and 
						                  ((integer)left.AssociateLienCount <=0 or (integer)left.AssociateLienPct <= 0 or (integer)left.AssociateFelonyCount>0 or (integer)left.AssociateBankruptcyCount>0) and (integer)left.AssociateDerogIndex  <>2 =>'PASS',
														 'FAIL');
						 self:=left;
                             ))+
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateJudgmentCount <= AssociateDerogCount ';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateLienCount',	'AssociateLienPct',	'AssociateJudgmentCount','AssociateJudgmentPct'] and 
						                 (integer)left.AssociateJudgmentCount <=(integer)left.AssociateDerogCount,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateJudgmentPct <= AssociateDerogPct';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateLienCount',	'AssociateLienPct',	'AssociateJudgmentCount','AssociateJudgmentPct'] and 
						                 (integer)left.AssociateJudgmentPct <=(integer)left.AssociateDerogPct ,'PASS','FAIL');
						 self:=left;
						                 ))+
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check AssociateJudgmentPct = AssociateJudgmentCount / AssociateCount ';
						 self.Result:=if(left.Category ='Business_Associate' and left.Attribute in['AssociateLienCount',	'AssociateLienPct',	'AssociateJudgmentCount','AssociateJudgmentPct'] and 
						                 (integer)left.AssociateJudgmentPct =(integer)left.AssociateJudgmentCount / (integer)left.AssociateCount,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check t align with AssociateDerogIndex ';
						 self.Result:=MAP(left.Category ='Business_Associate' and left.Attribute in['AssociateLienCount',	'AssociateLienPct',	'AssociateJudgmentCount','AssociateJudgmentPct'] and 
						                  (integer)left.AssociateJudgmentCount>0 and (integer)left.AssociateJudgmentPct   > 0 and (integer)left.AssociateFelonyCount=0 and (integer)left.AssociateBankruptcyCount=0 and (integer)left.AssociateDerogIndex  =1 =>'PASS',
														  left.Category ='Business_Associate' and left.Attribute in['AssociateLienCount',	'AssociateLienPct',	'AssociateJudgmentCount','AssociateJudgmentPct'] and 
						                  ((integer)left.AssociateJudgmentCount <=0 or (integer)left.AssociateJudgmentPct <= 0 or (integer)left.AssociateFelonyCount>0 or (integer)left.AssociateBankruptcyCount>0) and (integer)left.AssociateDerogIndex  <>1 =>'PASS',
														 'FAIL');
						 self:=left;
                             )),
// Business_Bankruptcy	
count(%tble%(Category='Business_Bankruptcy'))>=1 =>													 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkDisposedCount120 <= BusBkCount120';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkCount120',	'BusBkDisposedCount120',	'BusBkDischargedCount120',	'BusBkDismissedCount120'] and 
						                 (integer)left.BusBkDisposedCount120 <=(integer)left.BusBkCount120,'PASS','FAIL');
						 self:=left;
                             ))+

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkDischargedCount120 <= BusBkDisposedCount120 ';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkCount120',	'BusBkDisposedCount120',	'BusBkDischargedCount120',	'BusBkDismissedCount120'] and 
						                 (integer)left.BusBkDischargedCount120 <=(integer)left.BusBkDisposedCount120,'PASS','FAIL');
						 self:=left;
                             ))+
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkDismissedCount120 <= BusBkDisposedCount120';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkCount120',	'BusBkDisposedCount120',	'BusBkDischargedCount120',	'BusBkDismissedCount120'] and 
						                 (integer)left.BusBkDismissedCount120 <=(integer)left.BusBkDisposedCount120,'PASS','FAIL');
						 self:=left;
                             ))+

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkDischargedCount120 + BusBkDismissedCount120 <= BusBkDisposedCount120';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkCount120',	'BusBkDisposedCount120',	'BusBkDischargedCount120',	'BusBkDismissedCount120'] and 
						                 (integer)left.BusBkDischargedCount120 + (integer)left.BusBkDismissedCount120 <= (integer)left.BusBkDisposedCount120,'PASS','FAIL');
						 self:=left;
                             ))+														 

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkCh7Count120 <= BusBkCount120 ';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkCh7Count120',	'BusBkCh11Count120',	'BusBkCh13Count120'] and 
						                 (integer)left.BusBkCh7Count120 <=(integer)left.BusBkCount120,'PASS','FAIL');
						 self:=left;
                             ))+

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkCh11Count120 <= BusBkCount120';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkCh7Count120',	'BusBkCh11Count120',	'BusBkCh13Count120'] and 
						                 (integer)left.BusBkCh11Count120 <=(integer)left.BusBkCount120,'PASS','FAIL');
						 self:=left;
                             ))+
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkCh13Count120 <= BusBkCount120';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkCh7Count120',	'BusBkCh11Count120',	'BusBkCh13Count120'] and 
						                 (integer)left.BusBkCh13Count120 <=(integer)left.BusBkCount120,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkTimeOldest120 <= 120 ';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkTimeOldest120',	'BusBkTimeNewest120',	'BusBkTimeNewestUpdate120'] and 
						                 (integer)left.BusBkTimeOldest120 <=120,'PASS','FAIL');
						 self:=left;
                             ))+															 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkTimeNewest120 <= BusBkTimeOldest120 ';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkTimeOldest120',	'BusBkTimeNewest120',	'BusBkTimeNewestUpdate120'] and 
						                 (integer)left.BusBkTimeNewest120 <=(integer)left.BusBkTimeOldest120,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkTimeNewestUpdate120 <= BusBkTimeNewest120';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkTimeOldest120',	'BusBkTimeNewest120',	'BusBkTimeNewestUpdate120'] and 
						                 (integer)left.BusBkTimeNewestUpdate120 <=(integer)left.BusBkTimeNewest120,'PASS','FAIL');
						 self:=left;
                             ))+															 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkNewestChapter120 for corresponding counts';
						 self.Result:=MAP(left.Category ='Business_Bankruptcy' and left.Attribute in[	'BusBkNewestChapter120',	'BusBkNewestDisposition120'] and 
						                  (integer)left.BusBkNewestChapter120=11 and (integer)left.BusBkCh11Count120 >= 1 =>'PASS',
														  left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkNewestChapter120',	'BusBkNewestDisposition120'] and 
						                  (integer)left.BusBkNewestChapter120 <>11 or (integer)left.BusBkCh11Count120 >=1 =>'PASS',
														 'FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkNewestDisposition120 for corresponding counts';
						 self.Result:=MAP(left.Category ='Business_Bankruptcy' and left.Attribute in[	'BusBkNewestChapter120',	'BusBkNewestDisposition120'] and 
						                  (integer)left.BusBkNewestDisposition120=1 and (integer)left.BusBkDismissedCount120 >= 1 =>'PASS',
														  left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkNewestChapter120',	'BusBkNewestDisposition120'] and 
						                  (integer)left.BusBkNewestDisposition120 <>1 or (integer)left.BusBkDismissedCount120 >=1 =>'PASS',
														 'FAIL');
						 self:=left;
                             ))+				
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkDateOldest120 <= BusBkDateNewest120';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkDateOldest120',	'BusBkDateNewest120',	'BusBkDateNewestUpdate120'] and 
						                 (integer)left.BusBkTimeNewestUpdate120 <=(integer)left.BusBkTimeNewest120,'PASS','FAIL');
						 self:=left;
                             ))+
																									
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check BusBkDateNewest120 <= BusBkDateNewestUpdate120 ';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkDateOldest120',	'BusBkDateNewest120',	'BusBkDateNewestUpdate120'] and 
						                 (integer)left.BusBkDateNewest120 <=(integer)left.BusBkDateNewestUpdate120,'PASS','FAIL');
						 self:=left;
                             ))+
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check Months between [BusBkDateOldest120, archive date] = BusBkTimeOldest120 (except for -97, -98, -99) ';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkDateOldest120',	'BusBkDateNewest120',	'BusBkDateNewestUpdate120'] and 
						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)kel_Shell_QA.MonthsApart(left.BusBkDateOldest120,left.archivedate)=(integer)left.BusBkTimeOldest120,'PASS','FAIL');
						 self:=left;
                             ))+		
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check Months between [BusBkDateNewest120 , archive date]  = BusBkTimeNewest120 (except for -97, -98, -99)';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkDateOldest120',	'BusBkDateNewest120',	'BusBkDateNewestUpdate120'] and 
						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)kel_Shell_QA.MonthsApart(left.BusBkDateNewest120,left.archivedate)=(integer)left.BusBkTimeNewest120,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check Months between [BusBkDateNewestUpdate120 , archive date]  = BusBkTimeNewestUpdate120 (except for -97, -98, -99)';
						 self.Result:=if(left.Category ='Business_Bankruptcy' and left.Attribute in['BusBkDateOldest120',	'BusBkDateNewest120',	'BusBkDateNewestUpdate120'] and 
						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)kel_Shell_QA.MonthsApart(left.BusBkDateNewestUpdate120,left.archivedate)=(integer)left.BusBkTimeNewestUpdate120,'PASS','FAIL');
						 self:=left;
                             )),															 
// Business_Executive
count(%tble%(Category='Business_Executive'))>=1 =>	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveBusinessAvg <= ExecutiveBusinessCount ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveCount',	'ExecutiveBusinessCount',	'ExecutiveBusinessAvg'] and 
						                 (integer)left.ExecutiveBusinessAvg <=(integer)left.ExecutiveBusinessCount,'PASS','FAIL');
						 self:=left;
                             ))+	
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveBusinessAvg <= ExecutiveBusinessCount ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveCount',	'ExecutiveBusinessCount',	'ExecutiveBusinessAvg'] and 
						                 (integer)left.ExecutiveBusinessAvg <=(integer)left.ExecutiveBusinessCount,'PASS','FAIL');
						 self:=left;
                             ))+	
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveBusinessCount = ExecutiveCount * ExecutiveBusinessAvg';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveCount',	'ExecutiveBusinessCount',	'ExecutiveBusinessAvg'] and 
						                 (integer)left.ExecutiveBusinessCount =(integer)left.ExecutiveCount * (integer)left.ExecutiveBusinessAvg ,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveActiveBusinessAvg <= ExecutiveActiveBusinessCount ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveActiveBusinessCount',	'ExecutiveActiveBusinessAvg',	'ExecutiveActiveBusinessPct'] and 
						                 (integer)left.ExecutiveActiveBusinessAvg <=(integer)left.ExecutiveActiveBusinessCount ,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveActiveBusinessCount = ExecutiveCount * ExecutiveActiveBusinessAvg ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveActiveBusinessCount',	'ExecutiveActiveBusinessAvg',	'ExecutiveActiveBusinessPct'] and 
						                 (integer)left.ExecutiveActiveBusinessCount =(integer)left.ExecutiveCount * (integer)left.ExecutiveActiveBusinessAvg ,'PASS','FAIL');
						 self:=left;
                             ))+														 													 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveActiveBusinessAvg <= ExecutiveBusinessAvg  ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveActiveBusinessCount',	'ExecutiveActiveBusinessAvg',	'ExecutiveActiveBusinessPct'] and 
						                 (integer)left.ExecutiveActiveBusinessAvg <=(integer)left.ExecutiveBusinessAvg ,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveActiveBusinessCount <= ExecutiveBusinessCount  ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveActiveBusinessCount',	'ExecutiveActiveBusinessAvg',	'ExecutiveActiveBusinessPct'] and 
						                 (integer)left.ExecutiveActiveBusinessCount <=(integer)left.ExecutiveBusinessCount ,'PASS','FAIL');
						 self:=left;
                             ))+															 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveActiveBusinessPct = ExecutiveActiveBusinessCount / ExecutiveBusinessCount ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveActiveBusinessCount',	'ExecutiveActiveBusinessAvg',	'ExecutiveActiveBusinessPct'] and 
						                 (integer)left.ExecutiveActiveBusinessPct =(integer)left.ExecutiveActiveBusinessCount/ (integer)left.ExecutiveBusinessCount ,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutivePropOwnerCount <= ExecutiveCount  ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutivePropOwnerCount',	'ExecutivePropOwnerPct'] and 
						                 (integer)left.ExecutivePropOwnerCount <=(integer)left.ExecutiveCount,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutivePropOwnerPct = ExecutivePropOwnerCount / ExecutiveCount';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutivePropOwnerCount',	'ExecutivePropOwnerPct'] and 
						                 (integer)left.ExecutivePropOwnerPct =(integer)left.ExecutivePropOwnerCount / (integer)left.ExecutiveCount,'PASS','FAIL');
						 self:=left;
                             ))+
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveDerogCount <= ExecutiveCount ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveDerogCount',	'ExecutiveDerogPct',	'ExecutiveDerogIndex'] and 
						                 (integer)left.ExecutiveDerogCount <=(integer)left.ExecutiveCount,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveDerogPct = ExecutiveDerogCount / ExecutiveCount';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveDerogCount',	'ExecutiveDerogPct',	'ExecutiveDerogIndex'] and 
						                 (integer)left.ExecutiveDerogPct =(integer)left.ExecutiveDerogCount / (integer)left.ExecutiveCount,'PASS','FAIL');
						 self:=left;
                             ))+														 

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveFelonyCount <= ExecutiveDerogCount ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveFelonyCount',	'ExecutiveFelonyPct',	'ExecutiveCriminalCount',	'ExecutiveCriminalPct'] and 
						                 (integer)left.ExecutiveFelonyCount <=(integer)left.ExecutiveDerogCount,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveFelonyPct <= ExecutiveDerogPct  ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveFelonyCount',	'ExecutiveFelonyPct',	'ExecutiveCriminalCount',	'ExecutiveCriminalPct'] and 
						                 (integer)left.ExecutiveFelonyPct <=(integer)left.ExecutiveDerogPct,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveFelonyPct = ExecutiveFelonyCount / ExecutiveCount ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveFelonyCount',	'ExecutiveFelonyPct',	'ExecutiveCriminalCount',	'ExecutiveCriminalPct'] and 
						                 (integer)left.ExecutiveFelonyPct =(integer)left.ExecutiveFelonyCount / (integer)left.ExecutiveCount,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:=' Check ExecutiveFelonyCount /ExecutiveFelonyPct align with ExecutiveDerogIndex ';
						 self.Result:=MAP(left.Category ='Business_Executive' and left.Attribute in['ExecutiveFelonyCount',	'ExecutiveFelonyPct',	'ExecutiveCriminalCount',	'ExecutiveCriminalPct'] and 
						                  (integer)left.ExecutiveFelonyCount >0 and (integer)left.ExecutiveFelonyPct > 0 and (integer)left.ExecutiveDerogIndex =4 =>'PASS',
														  left.Category ='Business_Executive' and left.Attribute in['ExecutiveFelonyCount',	'ExecutiveFelonyPct',	'ExecutiveCriminalCount',	'ExecutiveCriminalPct'] and 
						                  ((integer)left.ExecutiveFelonyCount <=0 or (integer)left.ExecutiveFelonyPct <= 0) and (integer)left.ExecutiveDerogIndex <>4 =>'PASS',
														 'FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveCriminalCount <= ExecutiveCount  ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveFelonyCount',	'ExecutiveFelonyPct',	'ExecutiveCriminalCount',	'ExecutiveCriminalPct'] and 
						                 (integer)left.ExecutiveCriminalCount <=(integer)left.ExecutiveCount,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveCriminalPct = ExecutiveCriminalCount / ExecutiveCount';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveFelonyCount',	'ExecutiveFelonyPct',	'ExecutiveCriminalCount',	'ExecutiveCriminalPct'] and 
						                 (integer)left.ExecutiveCriminalPct =(integer)left.ExecutiveCriminalCount / (integer)left.ExecutiveCount,'PASS','FAIL');
						 self:=left;
                             ))+	
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveBankruptcyPct <= ExecutiveDerogPct ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveBankruptcyCount',	'ExecutiveBankruptcyPct',	'ExecutiveEvictionCount',	'ExecutiveEvictionPct'] and 
						                 (integer)left.ExecutiveBankruptcyPct <=(integer)left.ExecutiveDerogPct,'PASS','FAIL');
						 self:=left;
                             ))+														 

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveBankruptcyCount <= ExecutiveDerogCount ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveBankruptcyCount',	'ExecutiveBankruptcyPct',	'ExecutiveEvictionCount',	'ExecutiveEvictionPct'] and 
						                 (integer)left.ExecutiveBankruptcyCount <=(integer)left.ExecutiveDerogCount,'PASS','FAIL');
						 self:=left;
                             ))+		
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveBankruptcyPct = ExecutiveBankruptcyCount / ExecutiveCount ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveBankruptcyCount',	'ExecutiveBankruptcyPct',	'ExecutiveEvictionCount',	'ExecutiveEvictionPct'] and 
						                 (integer)left.ExecutiveBankruptcyPct =(integer)left.ExecutiveBankruptcyCount / (integer)left.ExecutiveCount,'PASS','FAIL');
						 self:=left;
                             ))+														 

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveBankruptcyCount /ExecutiveBankruptcyPct align with ExecutiveDerogIndex ';
						 self.Result:=MAP(left.Category ='Business_Executive' and left.Attribute in['ExecutiveBankruptcyCount',	'ExecutiveBankruptcyPct',	'ExecutiveEvictionCount',	'ExecutiveEvictionPct'] and
						                  (integer)left.ExecutiveBankruptcyCount >0 and (integer)left.ExecutiveDerogIndex =3 =>'PASS',
														  left.Category ='Business_Executive' and left.Attribute in['ExecutiveBankruptcyCount',	'ExecutiveBankruptcyPct',	'ExecutiveEvictionCount',	'ExecutiveEvictionPct'] and
						                  (integer)left.ExecutiveBankruptcyCount <=0 or (integer)left.ExecutiveDerogIndex <>3 =>'PASS',
														 'FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveEvictionCount <= ExecutiveCount ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveBankruptcyCount',	'ExecutiveBankruptcyPct',	'ExecutiveEvictionCount',	'ExecutiveEvictionPct'] and 
						                 (integer)left.ExecutiveEvictionCount <=(integer)left.ExecutiveCount,'PASS','FAIL');
						 self:=left;
                             ))+														 

project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveEvictionPct = ExecutiveEvictionCount / ExecutiveCount ';
						 self.Result:=if(left.Category ='Business_Executive' and left.Attribute in['ExecutiveBankruptcyCount',	'ExecutiveBankruptcyPct',	'ExecutiveEvictionCount',	'ExecutiveEvictionPct'] and 
						                 (integer)left.ExecutiveEvictionPct =(integer)left.ExecutiveEvictionCount / (integer)left.ExecutiveCount,'PASS','FAIL');
						 self:=left;
                             ))+	
														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check align with ExecutiveDerogIndex ';
						 self.Result:=MAP(left.Category ='Business_Executive' and left.Attribute in['ExecutiveBankruptcyCount',	'ExecutiveBankruptcyPct',	'ExecutiveEvictionCount',	'ExecutiveEvictionPct'] and
						                  (integer)left.ExecutiveBankruptcyPct >0 and (integer)left.ExecutiveDerogIndex =3 =>'PASS',
														  left.Category ='Business_Executive' and left.Attribute in['ExecutiveBankruptcyCount',	'ExecutiveBankruptcyPct',	'ExecutiveEvictionCount',	'ExecutiveEvictionPct'] and
						                  (integer)left.ExecutiveBankruptcyPct <=0 or (integer)left.ExecutiveDerogIndex <>3 =>'PASS',
														 'FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:=' Check ExecutiveLienCount <= ExecutiveDerogCount  ';
						 self.Result:= if((integer)left.ExecutiveLienCount <=(integer)left.ExecutiveDerogCount,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:=' Check ExecutiveLienPct <= ExecutiveDerogPct  ';
						 self.Result:= if((integer)left.ExecutiveLienPct <=(integer)left.ExecutiveDerogPct,'PASS','FAIL');
						 self:=left;
                             ))+														 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveLienPct = ExecutiveLienCount / ExecutiveCount  ';
						 self.Result:= if((integer)left.ExecutiveLienPct =(integer)left.ExecutiveLienCount / (integer)left.ExecutiveCount,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveJudgmentCount <= ExecutiveDerogCount  ';
						 self.Result:= if((integer)left.ExecutiveJudgmentCount <=(integer)left.ExecutiveDerogCount,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveJudgmentPct <= ExecutiveDerogPct  ';
						 self.Result:= if((integer)left.ExecutiveJudgmentPct <=(integer)left.ExecutiveDerogPct ,'PASS','FAIL');
						 self:=left;
                             ))+	
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check ExecutiveJudgmentPct = ExecutiveJudgmentCount / ExecutiveCount ';
						 self.Result:= if((integer)left.ExecutiveJudgmentPct =(integer)left.ExecutiveJudgmentCount / (integer)left.ExecutiveCount,'PASS','FAIL');
						 self:=left;
                             ))+															 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check align with ExecutiveDerogIndex ';
						 self.Result:=MAP(left.Category ='Business_Executive' and left.Attribute in['ExecutiveLienCount',	'ExecutiveLienPct',	'ExecutiveJudgmentCount',	'ExecutiveJudgmentPct'	] and
						                  (integer)left.ExecutiveLienCount >0 and (integer)left.ExecutiveFelonyCount =0 and(integer)left.ExecutiveBankruptcyCount =0 and (integer)left.ExecutiveDerogIndex =2 =>'PASS',
														  left.Category ='Business_Executive' and left.Attribute in['ExecutiveLienCount',	'ExecutiveLienPct',	'ExecutiveJudgmentCount',	'ExecutiveJudgmentPct'	] and
						                  (integer)left.ExecutiveLienCount <=0 and ((integer)left.ExecutiveFelonyCount =0 or(integer)left.ExecutiveBankruptcyCount =0 or (integer)left.ExecutiveDerogIndex <>2 ) =>'PASS',
														 'FAIL');
						 self:=left;
                             ))+															 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check align with ExecutiveDerogIndex ';
						 self.Result:=MAP(left.Category ='Business_Executive' and left.Attribute in['ExecutiveLienCount',	'ExecutiveLienPct',	'ExecutiveJudgmentCount',	'ExecutiveJudgmentPct'	] and
						                  (integer)left.ExecutiveLienPct >0 and (integer)left.ExecutiveFelonyCount =0 and(integer)left.ExecutiveBankruptcyCount =0 and (integer)left.ExecutiveDerogIndex =2 =>'PASS',
														  left.Category ='Business_Executive' and left.Attribute in['ExecutiveLienCount',	'ExecutiveLienPct',	'ExecutiveJudgmentCount',	'ExecutiveJudgmentPct'	] and
						                  (integer)left.ExecutiveLienPct <=0 and ((integer)left.ExecutiveFelonyCount =0 or(integer)left.ExecutiveBankruptcyCount =0 or (integer)left.ExecutiveDerogIndex <>2 ) =>'PASS',
														 'FAIL');
						 self:=left;
                             ))+															 
																		 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check align with ExecutiveDerogIndex ';
						 self.Result:=MAP(left.Category ='Business_Executive' and left.Attribute in['ExecutiveLienCount',	'ExecutiveLienPct',	'ExecutiveJudgmentCount',	'ExecutiveJudgmentPct'	] and
						                  (integer)left.ExecutiveJudgmentCount >0 and (integer)left.ExecutiveDerogIndex =3 =>'PASS',
														  left.Category ='Business_Executive' and left.Attribute in['ExecutiveLienCount',	'ExecutiveLienPct',	'ExecutiveJudgmentCount',	'ExecutiveJudgmentPct'	] and
						                  (integer)left.ExecutiveJudgmentCount <=0 or (integer)left.ExecutiveDerogIndex <>3 =>'PASS',
														 'FAIL');
						 self:=left;
                             ))+															 
project(%tble%,transform(%lay%, 
             self.Acceptance_Criteria:='Check align with ExecutiveDerogIndex ';
						 self.Result:=MAP(left.Category ='Business_Executive' and left.Attribute in['ExecutiveLienCount',	'ExecutiveLienPct',	'ExecutiveJudgmentCount',	'ExecutiveJudgmentPct'	] and
						                  (integer)left.ExecutiveJudgmentPct >0  and (integer)left.ExecutiveFelonyCount =0 and(integer)left.ExecutiveBankruptcyCount =0 and (integer)left.ExecutiveDerogIndex =1  =>'PASS',
														  left.Category ='Business_Executive' and left.Attribute in['ExecutiveLienCount',	'ExecutiveLienPct',	'ExecutiveJudgmentCount',	'ExecutiveJudgmentPct'	] and
						                  (integer)left.ExecutiveJudgmentPct <=0 and ((integer)left.ExecutiveFelonyCount =0 or(integer)left.ExecutiveBankruptcyCount =0 or (integer)left.ExecutiveDerogIndex <>1 ) =>'PASS',
														 'FAIL');
						 self:=left;
                             )),	
														 
// 	Inquiry_History		
count(%tble%(Category='Inquiry_History'))>=1 =>												 
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqTimeNewest60 >= InqTimeNewest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqTimeNewest12','InqTimeOldest12','InqTimeNewest60','InqTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqTimeNewest60>=(integer)left.InqTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+															 
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqTimeOldest60 >= InqTimeOldest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqTimeNewest12','InqTimeOldest12','InqTimeNewest60','InqTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqTimeOldest60>=(integer)left.InqTimeOldest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqTimeOldest12 >= InqTimeNewest12 (except for -99, -98, and -97)';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqTimeNewest12','InqTimeOldest12','InqTimeNewest60','InqTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqTimeOldest12>=(integer)left.InqTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqTimeOldest60 >= InqTimeNewest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqTimeNewest12','InqTimeOldest12','InqTimeNewest60','InqTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqTimeOldest60>=(integer)left.InqTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqTimeNewest12 & InqTimeOldest12 capped at 12  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqTimeNewest12','InqTimeOldest12'] and 
   						                 (integer)left.#expand(f1)<=12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqTimeNewest60 & InqTimeOldest60 capped at 60 ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqTimeNewest60','InqTimeOldest60'] and 
   						                 (integer)left.#expand(f1)<=60,'PASS','FAIL');
   						 self:=left;
                                ))+		
   														 
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqCountDay <= InqCountWeek <= InqCount01 <= InqCount03 <= InqCount06 <= InqCount12 <= InqCount24 <= InqCount60 (except for -99)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqCountDay',	'InqCountWeek',	'InqCount01',	'InqCount03',	'InqCount06',	'InqCount12',	'InqCount24',	'InqCount60'] and 
   						                 left.#expand(f1) not in['-99'] and 
   														 ((integer)left.InqCountDay<=(integer)left.InqCountWeek)  and
   														 ((integer)left.InqCountWeek<=(integer)left.InqCount01)  and
   														 ((integer)left.InqCount01<=(integer)left.InqCount03)  and
   														 ((integer)left.InqCount03<=(integer)left.InqCount06)  and
   														 ((integer)left.InqCount06<=(integer)left.InqCount12)  and
   														 ((integer)left.InqCount12<=(integer)left.InqCount24)  and
   														 ((integer)left.InqCount24<=(integer)left.InqCount60),'PASS','FAIL');
   						 self:=left;
                                ))+
   	
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqAutoTimeNewest60 >= InqAutoTimeNewest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqAutoTimeNewest12',	'InqAutoTimeOldest12',	'InqAutoTimeNewest60',	'InqAutoTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqAutoTimeNewest60>=(integer)left.InqAutoTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+															 
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqAutoTimeOldest60 >= InqAutoTimeOldest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqAutoTimeNewest12',	'InqAutoTimeOldest12',	'InqAutoTimeNewest60',	'InqAutoTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqAutoTimeOldest60>=(integer)left.InqAutoTimeOldest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqAutoTimeOldest12 >= InqAutoTimeNewest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqAutoTimeNewest12',	'InqAutoTimeOldest12',	'InqAutoTimeNewest60',	'InqAutoTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqAutoTimeOldest12>=(integer)left.InqAutoTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqAutoTimeOldest60 >= InqAutoTimeNewest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqAutoTimeNewest12',	'InqAutoTimeOldest12',	'InqAutoTimeNewest60',	'InqAutoTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqAutoTimeOldest60>=(integer)left.InqAutoTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqAutoTimeNewest12 & InqAutoTimeOldest12 capped at 12  ';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqAutoTimeNewest12',	'InqAutoTimeOldest12'] and 
   						                 (integer)left.#expand(f1)<=12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqAutoTimeNewest60 & InqAutoTimeOldest60 capped at 60 ';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqAutoTimeNewest60',	'InqAutoTimeOldest60'] and 
   						                 (integer)left.#expand(f1)<=60,'PASS','FAIL');
   						 self:=left;
                                ))+	
   														 
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='InqAutoCountDay <= InqAutoCountWeek <= InqAutoCount01 <= InqAutoCount03 <= InqAutoCount06 <= InqAutoCount12 <= InqAutoCount24 <= InqAutoCount60 (except for -99)';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqAutoCountDay',	'InqAutoCountWeek',	'InqAutoCount01',	'InqAutoCount03',	'InqAutoCount06',	'InqAutoCount12',	'InqAutoCount24',	'InqAutoCount60'] and 
   						                 left.#expand(f1) not in['-99'] and 
   														 ((integer)left.InqAutoCountDay<=(integer)left.InqAutoCountWeek)  and
   														 ((integer)left.InqAutoCountWeek<=(integer)left.InqAutoCount01 )  and
   														 ((integer)left.InqAutoCount01 <=(integer)left.InqAutoCount03)  and
   														 ((integer)left.InqAutoCount03<=(integer)left.InqAutoCount06 )  and
   														 ((integer)left.InqAutoCount06 <=(integer)left.InqAutoCount12 )  and
   														 ((integer)left.InqAutoCount12 <=(integer)left.InqAutoCount24 )  and
   														 ((integer)left.InqAutoCount24 <=(integer)left.InqAutoCount60 ),'PASS','FAIL');
   						 self:=left;
                                ))+														 
   														 
   
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqBankingTimeNewest60 >= InqBankingTimeNewest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqBankingTimeNewest12',	'InqBankingTimeOldest12',	'InqBankingTimeNewest60',	'InqBankingTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqBankingTimeNewest60>=(integer)left.InqBankingTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+															 
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqBankingTimeOldest60 >= InqBankingTimeOldest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqBankingTimeNewest12',	'InqBankingTimeOldest12',	'InqBankingTimeNewest60',	'InqBankingTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqBankingTimeOldest60>=(integer)left.InqBankingTimeOldest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqBankingTimeOldest12 >= InqBankingTimeNewest12 (except for -99, -98, and -97)';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqBankingTimeNewest12',	'InqBankingTimeOldest12',	'InqBankingTimeNewest60',	'InqBankingTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqBankingTimeOldest12>=(integer)left.InqBankingTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqBankingTimeOldest60 >= InqBankingTimeNewest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqBankingTimeNewest12',	'InqBankingTimeOldest12',	'InqBankingTimeNewest60',	'InqBankingTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqBankingTimeOldest60>=(integer)left.InqBankingTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqBankingTimeNewest12 & InqBankingTimeOldest12 capped at 12 ';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqBankingTimeNewest12',	'InqBankingTimeOldest12'] and 
   						                 (integer)left.#expand(f1)<=12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqBankingTimeNewest60 & InqBankingTimeOldest60 capped at 60 ';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqBankingTimeNewest60',	'InqBankingTimeOldest60'] and 
   						                 (integer)left.#expand(f1)<=60,'PASS','FAIL');
   						 self:=left;
                                ))+					

project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqBankingCountDay <= InqBankingCountWeek <= InqBankingCount01 <= InqBankingCount03 <= InqBankingCount06 <= InqBankingCount12 <= InqBankingCount24 <= InqBankingCount60 (except for -99)';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqBankingCountDay',	'InqBankingCountWeek',	'InqBankingCount01',	'InqBankingCount03',	'InqBankingCount06',	'InqBankingCount12',	'InqBankingCount24',	'InqBankingCount60'] and 
   						                 left.#expand(f1) not in['-99'] and 
   														 Kel_Shell_QA.Functions.JIRA_266((integer)left.InqBankingCountDay,(integer) left.InqBankingCountWeek, (integer)left.InqBankingCount01, (integer)left.InqBankingCount03,
   														          (integer)left.InqBankingCount06, (integer)left.InqBankingCount12, (integer)left.InqBankingCount24,(integer) left.InqBankingCount60) ,'PASS','FAIL');
   														
   						 self:=left;
                                )),
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqCommTimeNewest60 >= InqCommTimeNewest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqCommTimeNewest12',	'InqCommTimeOldest12',	'InqCommTimeNewest60',	'InqCommTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqCommTimeNewest60>=(integer)left.InqCommTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+															 
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqCommTimeOldest60 >= InqCommTimeOldest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqCommTimeNewest12',	'InqCommTimeOldest12',	'InqCommTimeNewest60',	'InqCommTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqCommTimeOldest60>=(integer)left.InqCommTimeOldest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check   InqCommTimeOldest12 >= InqCommTimeNewest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqCommTimeNewest12',	'InqCommTimeOldest12',	'InqCommTimeNewest60',	'InqCommTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqCommTimeOldest12>=(integer)left.InqCommTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqCommTimeOldest60 >= InqCommTimeNewest12 (except for -99, -98, and -97)   ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqCommTimeNewest12',	'InqCommTimeOldest12',	'InqCommTimeNewest60',	'InqCommTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqCommTimeOldest60>=(integer)left.InqCommTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqCommTimeNewest12 & InqCommTimeOldest12 capped at 12  ';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqCommTimeNewest12',	'InqCommTimeOldest12'] and 
   						                 (integer)left.#expand(f1)<=12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqCommTimeNewest60 & InqCommTimeOldest60 capped at 60';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqCommTimeNewest60',	'InqCommTimeOldest60'] and 
   						                 (integer)left.#expand(f1)<=60,'PASS','FAIL');
   						 self:=left;
                                ))+																		
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqCommCountDay <= InqCommCountWeek <= InqCommCount01 <= InqCommCount03 <= InqCommCount06 <= InqCommCount12 <= InqCommCount24 <= InqCommCount60 (except for -99)';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqCommCountDay',	'InqCommCountWeek',	'InqCommCount01',	'InqCommCount03',	'InqCommCount06',	'InqCommCount12',	'InqCommCount24',	'InqCommCount60'] and 
   						                 left.#expand(f1) not in['-99'] and 
   														 Kel_Shell_QA.Functions.JIRA_266((integer)left.InqCommCountDay,(integer) left.InqCommCountWeek, (integer)left.InqCommCount01, (integer)left.InqCommCount03,
   														          (integer)left.InqCommCount06, (integer)left.InqCommCount12, (integer)left.InqCommCount24,(integer) left.InqCommCount60) ,'PASS','FAIL');
   														
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqCreditSeekingTimeNewest60 >= InqCreditSeekingTimeNewest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqCreditSeekingTimeNewest12',	'InqCreditSeekingTimeOldest12',	'InqCreditSeekingTimeNewest60',	'InqCreditSeekingTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqCreditSeekingTimeNewest60>=(integer)left.InqCreditSeekingTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+															 
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqCreditSeekingTimeOldest60 >= InqCreditSeekingTimeOldest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqCreditSeekingTimeNewest12',	'InqCreditSeekingTimeOldest12',	'InqCreditSeekingTimeNewest60',	'InqCreditSeekingTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqCreditSeekingTimeOldest60>=(integer)left.InqCreditSeekingTimeOldest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqCreditSeekingTimeOldest12 >= InqCreditSeekingTimeNewest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqCreditSeekingTimeNewest12',	'InqCreditSeekingTimeOldest12',	'InqCreditSeekingTimeNewest60',	'InqCreditSeekingTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqCreditSeekingTimeOldest12>=(integer)left.InqCreditSeekingTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqCreditSeekingTimeOldest60 >= InqCreditSeekingTimeNewest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqCreditSeekingTimeNewest12',	'InqCreditSeekingTimeOldest12',	'InqCreditSeekingTimeNewest60',	'InqCreditSeekingTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqCreditSeekingTimeOldest60>=(integer)left.InqCreditSeekingTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqCreditSeekingTimeNewest12 & InqCreditSeekingTimeOldest12 capped at 12 ';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqCreditSeekingTimeNewest12',	'InqCreditSeekingTimeOldest12'] and 
   						                 (integer)left.#expand(f1)<=12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqCreditSeekingTimeNewest60 & InqCreditSeekingTimeOldest60 capped at 60';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqCreditSeekingTimeNewest60',	'InqCreditSeekingTimeOldest60'] and 
   						                 (integer)left.#expand(f1)<=60,'PASS','FAIL');
   						 self:=left;
                                ))+	
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqCreditSeekingCountDay <= InqCreditSeekingCountWeek <= InqCreditSeekingCount01 <= InqCreditSeekingCount03 <= InqCreditSeekingCount06 <= InqCreditSeekingCount12 <= InqCreditSeekingCount24 <= InqCreditSeekingCount60 (except for -99)';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqCreditSeekingCountDay',	'InqCreditSeekingCountWeek',	'InqCreditSeekingCount01',	'InqCreditSeekingCount03',	'InqCreditSeekingCount06',	'InqCreditSeekingCount12',	'InqCreditSeekingCount24',	'InqCreditSeekingCount60'] and 
   						                 left.#expand(f1) not in['-99'] and 
   														 Kel_Shell_QA.Functions.JIRA_266((integer)left.InqCreditSeekingCountDay,(integer) left.InqCreditSeekingCountWeek, (integer)left.InqCreditSeekingCount01, (integer)left.InqCreditSeekingCount03,
   														          (integer)left.InqCreditSeekingCount06, (integer)left.InqCreditSeekingCount12 , (integer)left.InqCreditSeekingCount24 ,(integer) left.InqCreditSeekingCount60) ,'PASS','FAIL');
   														
   						 self:=left;
                                ))+			
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqHighRiskTimeNewest60 >= InqHighRiskTimeNewest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqHighRiskTimeNewest12',	'InqHighRiskTimeOldest12',	'InqHighRiskTimeNewest60',	'InqHighRiskTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqHighRiskTimeNewest60>=(integer)left.InqHighRiskTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+															 
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqHighRiskTimeOldest60 >= InqHighRiskTimeOldest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqHighRiskTimeNewest12',	'InqHighRiskTimeOldest12',	'InqHighRiskTimeNewest60',	'InqHighRiskTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqHighRiskTimeOldest60>=(integer)left.InqHighRiskTimeOldest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check   InqHighRiskTimeOldest12 >= InqHighRiskTimeNewest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqHighRiskTimeNewest12',	'InqHighRiskTimeOldest12',	'InqHighRiskTimeNewest60',	'InqHighRiskTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqHighRiskTimeOldest12>=(integer)left.InqHighRiskTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqHighRiskTimeOldest60 >= InqHighRiskTimeNewest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqHighRiskTimeNewest12',	'InqHighRiskTimeOldest12',	'InqHighRiskTimeNewest60',	'InqHighRiskTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqHighRiskTimeOldest60>=(integer)left.InqHighRiskTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqHighRiskTimeNewest12 & InqHighRiskTimeOldest12 capped at 12  ';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqHighRiskTimeNewest12',	'InqHighRiskTimeOldest12'] and 
   						                 (integer)left.#expand(f1)<=12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqHighRiskTimeNewest60 & InqHighRiskTimeOldest60 capped at 60';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqHighRiskTimeNewest60',	'InqHighRiskTimeOldest60'] and 
   						                 (integer)left.#expand(f1)<=60,'PASS','FAIL');
   						 self:=left;
                                ))+		
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqHighRiskCountDay <= InqHighRiskCountWeek <= InqHighRiskCount01 <= InqHighRiskCount03 <= InqHighRiskCount06 <= InqHighRiskCount12 <= InqHighRiskCount24 <= InqHighRiskCount60 (except for -99)';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqHighRiskCountDay',	'InqHighRiskCountWeek',	'InqHighRiskCount01',	'InqHighRiskCount03',	'InqHighRiskCount06',	'InqHighRiskCount12',	'InqHighRiskCount24',	'InqHighRiskCount60'] and 
   						                 left.#expand(f1) not in['-99'] and 
   														 Kel_Shell_QA.Functions.JIRA_266((integer)left.InqHighRiskCountDay,(integer) left.InqHighRiskCountWeek, (integer)left.InqHighRiskCount01, (integer)left.InqHighRiskCount03,
   														          (integer)left.InqHighRiskCount06, (integer)left.InqHighRiskCount12 , (integer)left.InqHighRiskCount24 ,(integer) left.InqHighRiskCount60) ,'PASS','FAIL');
   														
   						 self:=left;
                                ))+	
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqMortgageTimeNewest60 >= InqMortgageTimeNewest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqMortgageTimeNewest12',	'InqMortgageTimeOldest12',	'InqMortgageTimeNewest60',	'InqMortgageTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqMortgageTimeNewest60>=(integer)left.InqMortgageTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+															 
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check   InqMortgageTimeOldest60 >= InqMortgageTimeOldest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqMortgageTimeNewest12',	'InqMortgageTimeOldest12',	'InqMortgageTimeNewest60',	'InqMortgageTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqMortgageTimeOldest60>=(integer)left.InqMortgageTimeOldest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check   InqMortgageTimeOldest12 >= InqMortgageTimeNewest12 (except for -99, -98, and -97)   ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqMortgageTimeNewest12',	'InqMortgageTimeOldest12',	'InqMortgageTimeNewest60',	'InqMortgageTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqMortgageTimeOldest12>=(integer)left.InqMortgageTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check   InqMortgageTimeOldest60 >= InqMortgageTimeNewest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqMortgageTimeNewest12',	'InqMortgageTimeOldest12',	'InqMortgageTimeNewest60',	'InqMortgageTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqMortgageTimeOldest60>=(integer)left.InqMortgageTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqMortgageTimeNewest12 & InqMortgageTimeOldest12 capped at 12  ';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqMortgageTimeNewest12',	'InqMortgageTimeOldest12'] and 
   						                 (integer)left.#expand(f1)<=12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqMortgageTimeNewest60 & InqMortgageTimeOldest60 capped at 60';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqMortgageTimeNewest60',	'InqMortgageTimeOldest60'] and 
   						                 (integer)left.#expand(f1)<=60,'PASS','FAIL');
   						 self:=left;
                                ))+		
																
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqMortgageCountDay <= InqMortgageCountWeek <= InqMortgageCount01 <= InqMortgageCount03 <= InqMortgageCount06 <= InqMortgageCount12 <= InqMortgageCount24 <= InqMortgageCount60 (except for -99)';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqMortgageCountDay',	'InqMortgageCountWeek',	'InqMortgageCount01',	'InqMortgageCount03',	'InqMortgageCount06',	'InqMortgageCount12',	'InqMortgageCount24',	'InqMortgageCount60'] and 
   						                 left.#expand(f1) not in['-99'] and 
   														 Kel_Shell_QA.Functions.JIRA_266((integer)left.InqMortgageCountDay,(integer) left.InqMortgageCountWeek, (integer)left.InqMortgageCount01, (integer)left.InqMortgageCount03,
   														          (integer)left.InqMortgageCount06, (integer)left.InqMortgageCount12 , (integer)left.InqMortgageCount24 ,(integer) left.InqMortgageCount60) ,'PASS','FAIL');
   														
   						 self:=left;
                                ))+			
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqOtherTimeNewest60 >= InqOtherTimeNewest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqOtherTimeNewest12',	'InqOtherTimeOldest12',	'InqOtherTimeNewest60',	'InqOtherTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqOtherTimeNewest60>=(integer)left.InqOtherTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+															 
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqOtherTimeOldest60 >= InqOtherTimeOldest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqOtherTimeNewest12',	'InqOtherTimeOldest12',	'InqOtherTimeNewest60',	'InqOtherTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqOtherTimeOldest60>=(integer)left.InqOtherTimeOldest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqOtherTimeOldest12 >= InqOtherTimeNewest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqOtherTimeNewest12',	'InqOtherTimeOldest12',	'InqOtherTimeNewest60',	'InqOtherTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqOtherTimeOldest12>=(integer)left.InqOtherTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check   InqOtherTimeOldest60 >= InqOtherTimeNewest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqOtherTimeNewest12',	'InqOtherTimeOldest12',	'InqOtherTimeNewest60',	'InqOtherTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqOtherTimeOldest60>=(integer)left.InqOtherTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check InqOtherTimeNewest12 & InqOtherTimeOldest12 capped at 12 ';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqOtherTimeNewest12',	'InqOtherTimeOldest12'] and 
   						                 (integer)left.#expand(f1)<=12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqOtherTimeNewest60 & InqOtherTimeOldest60 capped at 60';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqOtherTimeNewest60',	'InqOtherTimeOldest60'] and 
   						                 (integer)left.#expand(f1)<=60,'PASS','FAIL');
   						 self:=left;
                                ))+	
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqOtherCountDay <= InqOtherCountWeek <= InqOtherCount01 <= InqOtherCount03 <= InqOtherCount06 <= InqOtherCount12 <= InqOtherCount24 <= InqOtherCount60 (except for -99)';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in[	'InqOtherCountDay',	'InqOtherCountWeek',	'InqOtherCount01',	'InqOtherCount03',	'InqOtherCount06',	'InqOtherCount12',	'InqOtherCount24',	'InqOtherCount60'] and 
   						                 left.#expand(f1) not in['-99'] and 
   														 Kel_Shell_QA.Functions.JIRA_266((integer)left.InqOtherCountDay,(integer) left.InqOtherCountWeek, (integer)left.InqOtherCount01, (integer)left.InqOtherCount03,
   														          (integer)left.InqOtherCount06, (integer)left.InqOtherCount12 , (integer)left.InqOtherCount24 ,(integer) left.InqOtherCount60) ,'PASS','FAIL');
   														
   						 self:=left;
                                ))+		
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqPrepaidCardsTimeNewest60 >= InqPrepaidCardsTimeNewest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqPrepaidCardsTimeNewest12',	'InqPrepaidCardsTimeOldest12',	'InqPrepaidCardsTimeNewest60',	'InqPrepaidCardsTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqPrepaidCardsTimeNewest60>=(integer)left.InqPrepaidCardsTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+															 
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqPrepaidCardsTimeOldest60 >= InqPrepaidCardsTimeOldest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqPrepaidCardsTimeNewest12',	'InqPrepaidCardsTimeOldest12',	'InqPrepaidCardsTimeNewest60',	'InqPrepaidCardsTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqPrepaidCardsTimeOldest60>=(integer)left.InqPrepaidCardsTimeOldest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqPrepaidCardsTimeOldest12 >= InqPrepaidCardsTimeNewest12 (except for -99, -98, and -97) ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqPrepaidCardsTimeNewest12',	'InqPrepaidCardsTimeOldest12',	'InqPrepaidCardsTimeNewest60',	'InqPrepaidCardsTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqPrepaidCardsTimeOldest12>=(integer)left.InqPrepaidCardsTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqPrepaidCardsTimeOldest60 >= InqPrepaidCardsTimeNewest12 (except for -99, -98, and -97)  ';
   						 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqPrepaidCardsTimeNewest12',	'InqPrepaidCardsTimeOldest12',	'InqPrepaidCardsTimeNewest60',	'InqPrepaidCardsTimeOldest60'] and 
   						                 left.#expand(f1) not in['-97','-98','-99'] and (integer)left.InqPrepaidCardsTimeOldest60>=(integer)left.InqPrepaidCardsTimeNewest12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqPrepaidCardsTimeNewest12 & InqPrepaidCardsTimeOldest12 capped at 12  ';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqPrepaidCardsTimeNewest12',	'InqPrepaidCardsTimeOldest12'] and 
   						                 (integer)left.#expand(f1)<=12,'PASS','FAIL');
   						 self:=left;
                                ))+
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='Check  InqPrepaidCardsTimeNewest60 & InqPrepaidCardsTimeOldest60 capped at 60 ';
   						 	 self.Result:=if(left.Category ='Inquiry_History' and left.Attribute in['InqPrepaidCardsTimeNewest60',	'InqPrepaidCardsTimeOldest60'] and 
   						                 (integer)left.#expand(f1)<=60,'PASS','FAIL');
   						 self:=left;
                                ))+																	
project(%tble%,transform(%lay%, 
                self.Acceptance_Criteria:='NA';
   						  self.Result:='NA';
   						  self:=left;
                                ))
																
																);
														 
														 												 
														 
/*  						
						'InqPrepaidCardsCountDay',	'InqPrepaidCardsCountWeek',	'InqPrepaidCardsCount01',	'InqPrepaidCardsCount03',	'InqPrepaidCardsCount06',	'InqPrepaidCardsCount12',	'InqPrepaidCardsCount24',	'InqPrepaidCardsCount60',	'InqRetailTimeNewest12',	'InqRetailTimeOldest12',	'InqRetailTimeNewest60',	'InqRetailTimeOldest60',	'InqRetailCountDay',	'InqRetailCountWeek',	'InqRetailCount01',	'InqRetailCount03',	'InqRetailCount06',	'InqRetailCount12',	'InqRetailCount24',	'InqRetailCount60',	'InqRetailPaymentTimeNewest12',	'InqRetailPaymentTimeOldest12',	'InqRetailPaymentTimeNewest60',	'InqRetailPaymentTimeOldest60',	'InqRetailPaymentCountDay',	'InqRetailPaymentCountWeek',	'InqRetailPaymentCount01',	'InqRetailPaymentCount03',	'InqRetailPaymentCount06',	'InqRetailPaymentCount12',	'InqRetailPaymentCount24',	'InqRetailPaymentCount60',	'InqStudentLoanTimeNewest12',	'InqStudentLoanTimeOldest12',	'InqStudentLoanTimeNewest60',	'InqStudentLoanTimeOldest60',	'InqStudentLoanCountDay',	'InqStudentLoanCountWeek',	'InqStudentLoanCount01',	'InqStudentLoanCount03',	'InqStudentLoanCount06',	'InqStudentLoanCount12',	'InqStudentLoanCount24',	'InqStudentLoanCount60',	'InqUtilityTimeNewest12',	'InqUtilityTimeOldest12',	'InqUtilityTimeNewest60',	'InqUtilityTimeOldest60',	'InqUtilityCountDay',	'InqUtilityCountWeek',	'InqUtilityCount01',	'InqUtilityCount03',	'InqUtilityCount06',	'InqUtilityCount12',	'InqUtilityCount24',	'InqUtilityCount60',	'InqQuizProviderTimeNewest12',	'InqQuizProviderTimeOldest12',	'InqQuizProviderTimeNewest60',	'InqQuizProviderTimeOldest60',	'InqQuizProviderCountDay',	'InqQuizProviderCountWeek',	'InqQuizProviderCount01',	'InqQuizProviderCount03',	'InqQuizProviderCount06',	'InqQuizProviderCount12',	'InqQuizProviderCount24',	'InqQuizProviderCount60',	'InqCollectionTimeNewest12',	'InqCollectionTimeOldest12',	'InqCollectionTimeNewest60',	'InqCollectionTimeOldest60',	'InqCollectionCountDay',	'InqCollectionCountWeek',	'InqCollectionCount01',	'InqCollectionCount03',	'InqCollectionCount06',	'InqCollectionCount12',	'InqCollectionCount24',	'InqCollectionCount60']				
      		
*/
		
													 
#uniquename(report_lay)
%report_lay% :=record
%pjt%.Attribute;
%pjt%.Category;
%pjt%.Acceptance_Criteria;
%pjt%.Result;
INTEGER Result_Cnt:=COUNT(GROUP);
DECIMAL10_2 Result_Perc:=(COUNT(GROUP)/COUNT(DS))*100;
end;

#uniquename(report)
%report% :=	table(%pjt%(Result<>'NA'),%report_lay%,Attribute,Category,Acceptance_Criteria,Result);		 							 

op := sort(project(%report%,transform({%report_lay%; integer Crictical_flag;},
                                        self.Crictical_flag:= if(left.Result ='FAIL' and left.Result_Perc>=10,1,0);
																				self:=left;
																				)),-Crictical_flag);
																																						

ENDMACRO;

END;

Test_file := Kel_Shell_QA.Base_Files.Base;

   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkCount120',BkCount120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkCount24',BkCount24);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkFilingDateOldest120',BkFilingDateOldest120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkFilingDateNewest120',BkFilingDateNewest120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkTimeOldest120',BkTimeOldest120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkTimeNewest120',BkTimeNewest120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkChapter120',BkChapter120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkCh7Count120',BkCh7Count120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkCh13Count120',BkCh13Count120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkUpdateDateNewest120',BkUpdateDateNewest120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkTimeNewestUpdate120',BkTimeNewestUpdate120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkDispositionDateNewest120',BkDispositionDateNewest120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkDisposition120',BkDisposition120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkDismissedCount120',BkDismissedCount120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkDismissedCount24',BkDismissedCount24);
   
   // BkDismissedCount24;
   
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkDisposedCount120',BkDisposedCount120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkDischargedCount120',BkDischargedCount120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkBusinessFiling120',BkBusinessFiling120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BkSeverityIndex120',BkSeverityIndex120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimArrestCount84',CrimArrestCount84);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimArrestCount12',CrimArrestCount12);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimArrestDateNewest',CrimArrestDateNewest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimArrestDateOldest',CrimArrestDateOldest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimArrestTimeNewest',CrimArrestTimeNewest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimArrestTimeOldest',CrimArrestTimeOldest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimCount',CrimCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimCount12',CrimCount12);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimDateNewest',CrimDateNewest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimDateOldest',CrimDateOldest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimTimeNewest',CrimTimeNewest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimTimeOldest',CrimTimeOldest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimFelonyCount',CrimFelonyCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimFelonyCount12',CrimFelonyCount12);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimFelonyDateNewest',CrimFelonyDateNewest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimFelonyDateOldest',CrimFelonyDateOldest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimFelonyTimeNewest',CrimFelonyTimeNewest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimFelonyTimeOldest',CrimFelonyTimeOldest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimNonFelonyCount',CrimNonFelonyCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimNonFelonyCount12',CrimNonFelonyCount12);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimNonFelonyDateNewest',CrimNonFelonyDateNewest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimNonFelonyDateOldest',CrimNonFelonyDateOldest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimNonFelonyTimeNewest',CrimNonFelonyTimeNewest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimNonFelonyTimeOldest',CrimNonFelonyTimeOldest);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimAddressHistory',CrimAddressHistory);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimXFelony',CrimXFelony);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'CrimBehaviorLevel',CrimBehaviorLevel);
   
   // Business Attributes
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveCount',ExecutiveCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveBusinessCount',ExecutiveBusinessCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveBusinessAvg',ExecutiveBusinessAvg);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveActiveBusinessCount',ExecutiveActiveBusinessCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveActiveBusinessAvg',ExecutiveActiveBusinessAvg);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveActiveBusinessPct',ExecutiveActiveBusinessPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutivePropOwnerCount',ExecutivePropOwnerCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutivePropOwnerPct',ExecutivePropOwnerPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveDerogCount',ExecutiveDerogCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveDerogPct',ExecutiveDerogPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveDerogIndex',ExecutiveDerogIndex);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveFelonyCount',ExecutiveFelonyCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveFelonyPct',ExecutiveFelonyPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveCriminalCount',ExecutiveCriminalCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveCriminalPct',ExecutiveCriminalPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveBankruptcyCount',ExecutiveBankruptcyCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveBankruptcyPct',ExecutiveBankruptcyPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveEvictionCount',ExecutiveEvictionCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveEvictionPct',ExecutiveEvictionPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveLienCount',ExecutiveLienCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveLienPct',ExecutiveLienPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveJudgmentCount',ExecutiveJudgmentCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'ExecutiveJudgmentPct',ExecutiveJudgmentPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkCount120',BusBkCount120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkDisposedCount120',BusBkDisposedCount120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkDischargedCount120',BusBkDischargedCount120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkDismissedCount120',BusBkDismissedCount120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkCh7Count120',BusBkCh7Count120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkCh11Count120',BusBkCh11Count120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkCh13Count120',BusBkCh13Count120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkTimeOldest120',BusBkTimeOldest120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkTimeNewest120',BusBkTimeNewest120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkTimeNewestUpdate120',BusBkTimeNewestUpdate120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkNewestChapter120',BusBkNewestChapter120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkNewestDisposition120',BusBkNewestDisposition120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkDateOldest120',BusBkDateOldest120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkDateNewest120',BusBkDateNewest120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'BusBkDateNewestUpdate120',BusBkDateNewestUpdate120);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateCount',AssociateCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateBusinessCount',AssociateBusinessCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateBusinessAvg',AssociateBusinessAvg);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateActiveBusinessCount',AssociateActiveBusinessCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateActiveBusinessAvg',AssociateActiveBusinessAvg);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateActiveBusinessPct',AssociateActiveBusinessPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociatePropOwnerCount',AssociatePropOwnerCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociatePropOwnerPct',AssociatePropOwnerPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateDerogCount',AssociateDerogCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateDerogPct',AssociateDerogPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateDerogIndex',AssociateDerogIndex);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateFelonyCount',AssociateFelonyCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateFelonyPct',AssociateFelonyPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateCriminalCount',AssociateCriminalCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateCriminalPct',AssociateCriminalPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateBankruptcyCount',AssociateBankruptcyCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateBankruptcyPct',AssociateBankruptcyPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateEvictionCount',AssociateEvictionCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateEvictionPct',AssociateEvictionPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateLienCount',AssociateLienCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateLienPct',AssociateLienPct);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateJudgmentCount',AssociateJudgmentCount);
   Acceptance_Criteria_Module.AC_Macro(Test_file,'AssociateJudgmentPct',AssociateJudgmentPct);
   
   
   final_report:=BkCount120+	BkCount24+	BkFilingDateOldest120+	BkFilingDateNewest120+	BkTimeOldest120+	BkTimeNewest120+	BkChapter120+	BkCh7Count120+	BkCh13Count120+	BkUpdateDateNewest120+	BkTimeNewestUpdate120+	BkDispositionDateNewest120+	BkDisposition120+	BkDismissedCount120+	BkDismissedCount24+	BkDisposedCount120+	BkDischargedCount120+	BkBusinessFiling120+	BkSeverityIndex120+	CrimArrestCount84+	CrimArrestCount12+	CrimArrestDateNewest+	CrimArrestDateOldest+	CrimArrestTimeNewest+	CrimArrestTimeOldest+	CrimCount+	CrimCount12+	CrimDateNewest+	CrimDateOldest+	CrimTimeNewest+	CrimTimeOldest+	CrimFelonyCount+	CrimFelonyCount12+	CrimFelonyDateNewest+	CrimFelonyDateOldest+	CrimFelonyTimeNewest+	CrimFelonyTimeOldest+	CrimNonFelonyCount+	CrimNonFelonyCount12+	CrimNonFelonyDateNewest+	CrimNonFelonyDateOldest+	CrimNonFelonyTimeNewest+	CrimNonFelonyTimeOldest+	CrimAddressHistory+	CrimXFelony+	CrimBehaviorLevel+
                 ExecutiveCount+	ExecutiveBusinessCount+	ExecutiveBusinessAvg+	ExecutiveActiveBusinessCount+	ExecutiveActiveBusinessAvg+	ExecutiveActiveBusinessPct+	ExecutivePropOwnerCount+	ExecutivePropOwnerPct+	ExecutiveDerogCount+	ExecutiveDerogPct+	ExecutiveDerogIndex+	ExecutiveFelonyCount+	ExecutiveFelonyPct+	ExecutiveCriminalCount+	ExecutiveCriminalPct+	ExecutiveBankruptcyCount+	ExecutiveBankruptcyPct+	ExecutiveEvictionCount+	ExecutiveEvictionPct+	ExecutiveLienCount+	ExecutiveLienPct+	ExecutiveJudgmentCount+	ExecutiveJudgmentPct+	BusBkCount120+	BusBkDisposedCount120+	BusBkDischargedCount120+	BusBkDismissedCount120+	BusBkCh7Count120+	BusBkCh11Count120+	BusBkCh13Count120+	BusBkTimeOldest120+	BusBkTimeNewest120+	BusBkTimeNewestUpdate120+	BusBkNewestChapter120+	BusBkNewestDisposition120+	BusBkDateOldest120+	BusBkDateNewest120+	BusBkDateNewestUpdate120+	AssociateCount+	AssociateBusinessCount+	AssociateBusinessAvg+	AssociateActiveBusinessCount+	AssociateActiveBusinessAvg+	AssociateActiveBusinessPct+	AssociatePropOwnerCount+	AssociatePropOwnerPct+	AssociateDerogCount+	AssociateDerogPct+	AssociateDerogIndex+	AssociateFelonyCount+	AssociateFelonyPct+	AssociateCriminalCount+	AssociateCriminalPct+	AssociateBankruptcyCount+	AssociateBankruptcyPct+	AssociateEvictionCount+	AssociateEvictionPct+	AssociateLienCount+	AssociateLienPct+	AssociateJudgmentCount+	AssociateJudgmentPct;
   
   // choosen(final_report,all);
   
   
   
   

