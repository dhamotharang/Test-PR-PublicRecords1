EXPORT Distribution_Module_new := MODULE

EXPORT Dis_Macro(DS,f1,min_val,max_val,bin_size,op) := MACRO


// Checking Distributions for Default vs Valid vs Invalid vs special cases
#uniquename(lay)
%lay% := record
STRING Attribute;
STRING Category;
STRING Distribution_type;
STRING Attribute_value;
end;

#uniquename(tble)
%tble% := project(DS,transform({%lay%; recordof(DS)},
                                     self.Attribute:=f1;
																		 self.Category:=MAP(f1 in ['CrimArrestCount84',	'CrimArrestCount12',	'CrimArrestDateNewest',	'CrimArrestDateOldest',	'CrimArrestTimeNewest',	'CrimArrestTimeOldest',	'CrimCount',	'CrimCount12',	'CrimDateNewest',	'CrimDateOldest',	'CrimTimeNewest',	'CrimTimeOldest',	'CrimFelonyCount',	'CrimFelonyCount12',	'CrimFelonyDateNewest',	'CrimFelonyDateOldest',	'CrimFelonyTimeNewest',	'CrimFelonyTimeOldest',	'CrimNonFelonyCount',	'CrimNonFelonyCount12',	'CrimNonFelonyDateNewest',	'CrimNonFelonyDateOldest',	'CrimNonFelonyTimeNewest',	'CrimNonFelonyTimeOldest',	'CrimAddressHistory',	'CrimXFelony',	'CrimBehaviorLevel']
																																=>'Criminal_History',
																												f1 in ['BkCount120',	'BkCount24',	'BkFilingDateOldest120',	'BkFilingDateNewest120',	'BkTimeOldest120',	'BkTimeNewest120',	'BkChapter120',	'BkCh7Count120',	'BkCh13Count120',	'BkUpdateDateNewest120',	'BkTimeNewestUpdate120',	'BkDispositionDateNewest120',	'BkDisposition120',	'BkDismissedCount120',	'BkDismissedCount24',	'BkDisposedCount120',	'BkDischargedCount120',	'BkBusinessFiling120',	'BkSeverityIndex120']
																																=>'Bankruptcy_History',
																												f1 in ['ExecutiveCount',	'ExecutiveBusinessCount',	'ExecutiveBusinessAvg',	'ExecutiveActiveBusinessCount',	'ExecutiveActiveBusinessAvg',	'ExecutiveActiveBusinessPct',	'ExecutivePropOwnerCount',	'ExecutivePropOwnerPct',	'ExecutiveDerogCount',	'ExecutiveDerogPct',	'ExecutiveDerogIndex',	'ExecutiveFelonyCount',	'ExecutiveFelonyPct',	'ExecutiveCriminalCount',	'ExecutiveCriminalPct',	'ExecutiveBankruptcyCount',	'ExecutiveBankruptcyPct',	'ExecutiveEvictionCount',	'ExecutiveEvictionPct',	'ExecutiveLienCount',	'ExecutiveLienPct',	'ExecutiveJudgmentCount',	'ExecutiveJudgmentPct']				
																																=>'Business_Executive',
																												f1 in ['BusBkCount120',	'BusBkDisposedCount120',	'BusBkDischargedCount120',	'BusBkDismissedCount120',	'BusBkCh7Count120',	'BusBkCh11Count120',	'BusBkCh13Count120',	'BusBkTimeOldest120',	'BusBkTimeNewest120',	'BusBkTimeNewestUpdate120',	'BusBkNewestChapter120',	'BusBkNewestDisposition120',	'BusBkDateOldest120',	'BusBkDateNewest120',	'BusBkDateNewestUpdate120']
																												        =>'Business_Bankruptcy',
																												f1 in ['AssociateCount',	'AssociateBusinessCount',	'AssociateBusinessAvg',	'AssociateActiveBusinessCount',	'AssociateActiveBusinessAvg',	'AssociateActiveBusinessPct',	'AssociatePropOwnerCount',	'AssociatePropOwnerPct',	'AssociateDerogCount',	'AssociateDerogPct',	'AssociateDerogIndex',	'AssociateFelonyCount',	'AssociateFelonyPct',	'AssociateCriminalCount',	'AssociateCriminalPct',	'AssociateBankruptcyCount',	'AssociateBankruptcyPct',	'AssociateEvictionCount',	'AssociateEvictionPct',	'AssociateLienCount',	'AssociateLienPct',	'AssociateJudgmentCount',	'AssociateJudgmentPct']
																												        =>'Business_Associate',
																																	 'NA');
																		 self:=left;		
																		 self:=[];
														  ));


// Creating BINS for valid ranges
													 
 #uniquename(Ran)
   %Ran% :=project(%tble%,transform(%lay%, 
               self.Distribution_type:='RANGE';
   						 self.attribute_value :=if(not regexfind('Date',f1),
   						            kel_Shell_QA.CreateBins.CreateBins_ranges(f1,left.#expand(f1),(integer)min_val,(integer)max_val,(integer)bin_size),'');
   						 self:=left;                                                        
   							 ));

														 
 #uniquename(Ran2)
   %Ran2% :=project(%tble%,transform(%lay%, 
               self.Distribution_type:='VALUE_TYPE';
   						 self.attribute_value :=if(not regexfind('Date',f1),
   						            kel_Shell_QA.CreateBins.CreateBins_valid_default(f1,left.#expand(f1),(integer)min_val,(integer)max_val),'');
   						 self:=left;                                                        
   							 ));

							 
#uniquename(pjt)
%pjt%:= %Ran%(attribute_value<>'') + %Ran2%(attribute_value<>'');
											 
#uniquename(report_lay)
%report_lay% :=record
%pjt%.Attribute;
%pjt%.Category;
%pjt%.Distribution_type;
%pjt%.attribute_value;
INTEGER Result_Cnt:=COUNT(GROUP);
end;

#uniquename(report)
%report% :=	table(%pjt%,%report_lay%,Attribute,Category,Distribution_type,attribute_value);	

#uniquename(report_lay2)
%report_lay2% :=record
%report%.Attribute;
%report%.Category;
%report%.Distribution_type;
DECIMAL10_2 Result_Perc:=SUM(GROUP,%report%.Result_Cnt);
end;

#uniquename(report2)
%report2% :=	table(%report%,%report_lay2%,Attribute,Category,Distribution_type);	

#uniquename(report3)
%report3%:= join(%report%,%report2%,left.Attribute=right.Attribute and
																		left.Category=right.Category and
																		left.Distribution_type=right.Distribution_type,
																		transform({%report_lay%;DECIMAL10_2 Result_Perc},
																		self.Result_Perc:= (left.Result_Cnt/right.Result_Perc)*100;
																		self:=left;
																		self:=right;
                                   ));

op:=%report3%;

ENDMACRO;

END;

Test_file := Kel_Shell_QA.Base_Files.Base;

Distribution_Module_new.Dis_Macro(Test_file,'BkCount120','0','99','10',BkCount120);
Distribution_Module_new.Dis_Macro(Test_file,'BkCount24','0','99','10',BkCount24);
Distribution_Module_new.Dis_Macro(Test_file,'BkFilingDateOldest120','','','10',BkFilingDateOldest120);
Distribution_Module_new.Dis_Macro(Test_file,'BkFilingDateNewest120','','','10',BkFilingDateNewest120);
Distribution_Module_new.Dis_Macro(Test_file,'BkTimeOldest120','0','999','10',BkTimeOldest120);
Distribution_Module_new.Dis_Macro(Test_file,'BkTimeNewest120','0','999','10',BkTimeNewest120);
Distribution_Module_new.Dis_Macro(Test_file,'BkChapter120','0','99','10',BkChapter120);
Distribution_Module_new.Dis_Macro(Test_file,'BkCh7Count120','0','99','10',BkCh7Count120);
Distribution_Module_new.Dis_Macro(Test_file,'BkCh13Count120','0','99','10',BkCh13Count120);
Distribution_Module_new.Dis_Macro(Test_file,'BkUpdateDateNewest120','','','10',BkUpdateDateNewest120);
Distribution_Module_new.Dis_Macro(Test_file,'BkTimeNewestUpdate120','0','999','10',BkTimeNewestUpdate120);
Distribution_Module_new.Dis_Macro(Test_file,'BkDispositionDateNewest120','','','10',BkDispositionDateNewest120);
Distribution_Module_new.Dis_Macro(Test_file,'BkDisposition120','0','99','10',BkDisposition120);
Distribution_Module_new.Dis_Macro(Test_file,'BkDismissedCount120','0','99','10',BkDismissedCount120);
Distribution_Module_new.Dis_Macro(Test_file,'BkDismissedCount24','0','99','10',BkDismissedCount24);
Distribution_Module_new.Dis_Macro(Test_file,'BkDisposedCount120','0','99','10',BkDisposedCount120);
Distribution_Module_new.Dis_Macro(Test_file,'BkDischargedCount120','0','99','10',BkDischargedCount120);
Distribution_Module_new.Dis_Macro(Test_file,'BkBusinessFiling120','0','99','10',BkBusinessFiling120);
Distribution_Module_new.Dis_Macro(Test_file,'BkSeverityIndex120','0','99','10',BkSeverityIndex120);
Distribution_Module_new.Dis_Macro(Test_file,'CrimArrestCount84','0','999','10',CrimArrestCount84);
Distribution_Module_new.Dis_Macro(Test_file,'CrimArrestCount12','0','999','10',CrimArrestCount12);
Distribution_Module_new.Dis_Macro(Test_file,'CrimCount','0','999','10',CrimCount);
Distribution_Module_new.Dis_Macro(Test_file,'CrimCount12','0','999','10',CrimCount12);
Distribution_Module_new.Dis_Macro(Test_file,'CrimFelonyCount','0','999','10',CrimFelonyCount);
Distribution_Module_new.Dis_Macro(Test_file,'CrimFelonyCount12','0','999','10',CrimFelonyCount12);
Distribution_Module_new.Dis_Macro(Test_file,'CrimNonFelonyCount','0','999','10',CrimNonFelonyCount);
Distribution_Module_new.Dis_Macro(Test_file,'CrimNonFelonyCount12','0','999','10',CrimNonFelonyCount12);
Distribution_Module_new.Dis_Macro(Test_file,'CrimAddressHistory','0','99','10',CrimAddressHistory);
Distribution_Module_new.Dis_Macro(Test_file,'CrimXFelony','0','99','10',CrimXFelony);
Distribution_Module_new.Dis_Macro(Test_file,'CrimBehaviorLevel','0','99','10',CrimBehaviorLevel);
Distribution_Module_new.Dis_Macro(Test_file,'CrimArrestDateNewest','','','10',CrimArrestDateNewest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimArrestDateOldest','','','10',CrimArrestDateOldest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimArrestTimeNewest','0','9999','10',CrimArrestTimeNewest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimArrestTimeOldest','0','9999','10',CrimArrestTimeOldest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimDateNewest','','','10',CrimDateNewest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimDateOldest','','','10',CrimDateOldest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimTimeNewest','0','9999','10',CrimTimeNewest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimTimeOldest','0','9999','10',CrimTimeOldest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimFelonyDateNewest','','','10',CrimFelonyDateNewest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimFelonyDateOldest','','','10',CrimFelonyDateOldest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimFelonyTimeNewest','0','9999','10',CrimFelonyTimeNewest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimFelonyTimeOldest','0','9999','10',CrimFelonyTimeOldest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimNonFelonyDateNewest','','','10',CrimNonFelonyDateNewest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimNonFelonyDateOldest','','','10',CrimNonFelonyDateOldest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimNonFelonyTimeNewest','0','9999','10',CrimNonFelonyTimeNewest);
Distribution_Module_new.Dis_Macro(Test_file,'CrimNonFelonyTimeOldest','0','9999','10',CrimNonFelonyTimeOldest);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateCount','0','999','10',AssociateCount);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateBusinessCount','1','999','10',AssociateBusinessCount);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateBusinessAvg','1','999','10',AssociateBusinessAvg);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateActiveBusinessCount','1','999','10',AssociateActiveBusinessCount);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateActiveBusinessAvg','1','999','10',AssociateActiveBusinessAvg);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateActiveBusinessPct','1','100','10',AssociateActiveBusinessPct);
Distribution_Module_new.Dis_Macro(Test_file,'AssociatePropOwnerCount','0','999','10',AssociatePropOwnerCount);
Distribution_Module_new.Dis_Macro(Test_file,'AssociatePropOwnerPct','0','100','10',AssociatePropOwnerPct);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateDerogCount','0','999','10',AssociateDerogCount);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateDerogPct','0','100','10',AssociateDerogPct);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateDerogIndex','0','4','10',AssociateDerogIndex);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateFelonyCount','0','999','10',AssociateFelonyCount);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateFelonyPct','0','100','10',AssociateFelonyPct);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateCriminalCount','0','999','10',AssociateCriminalCount);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateCriminalPct','0','100','10',AssociateCriminalPct);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateBankruptcyCount','0','999','10',AssociateBankruptcyCount);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateBankruptcyPct','0','100','10',AssociateBankruptcyPct);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateEvictionCount','0','999','10',AssociateEvictionCount);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateEvictionPct','0','100','10',AssociateEvictionPct);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateLienCount','0','999','10',AssociateLienCount);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateLienPct','0','100','10',AssociateLienPct);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateJudgmentCount','0','999','10',AssociateJudgmentCount);
Distribution_Module_new.Dis_Macro(Test_file,'AssociateJudgmentPct','0','100','10',AssociateJudgmentPct);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkCount120','0','999','10',BusBkCount120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkDisposedCount120','1','999','10',BusBkDisposedCount120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkDischargedCount120','0','999','10',BusBkDischargedCount120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkDismissedCount120','0','999','10',BusBkDismissedCount120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkCh7Count120','0','999','10',BusBkCh7Count120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkCh11Count120','0','999','10',BusBkCh11Count120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkCh13Count120','0','999','10',BusBkCh13Count120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkTimeOldest120','0','120','10',BusBkTimeOldest120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkTimeNewest120','0','120','10',BusBkTimeNewest120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkTimeNewestUpdate120','0','120','10',BusBkTimeNewestUpdate120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkNewestChapter120','0','99','10',BusBkNewestChapter120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkNewestDisposition120','0','2','10',BusBkNewestDisposition120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkDateOldest120','0','99','10',BusBkDateOldest120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkDateNewest120','','','10',BusBkDateNewest120);
Distribution_Module_new.Dis_Macro(Test_file,'BusBkDateNewestUpdate120','','','10',BusBkDateNewestUpdate120);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveCount','0','999','10',ExecutiveCount);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveBusinessCount','1','999','10',ExecutiveBusinessCount);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveBusinessAvg','1','999','10',ExecutiveBusinessAvg);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveActiveBusinessCount','1','999','10',ExecutiveActiveBusinessCount);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveActiveBusinessAvg','1','999','10',ExecutiveActiveBusinessAvg);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveActiveBusinessPct','1','100','10',ExecutiveActiveBusinessPct);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutivePropOwnerCount','0','999','10',ExecutivePropOwnerCount);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutivePropOwnerPct','0','100','10',ExecutivePropOwnerPct);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveDerogCount','0','999','10',ExecutiveDerogCount);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveDerogPct','0','100','10',ExecutiveDerogPct);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveDerogIndex','0','4','1',ExecutiveDerogIndex);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveFelonyCount','0','999','10',ExecutiveFelonyCount);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveFelonyPct','0','100','10',ExecutiveFelonyPct);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveCriminalCount','0','999','10',ExecutiveCriminalCount);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveCriminalPct','0','100','10',ExecutiveCriminalPct);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveBankruptcyCount','0','999','10',ExecutiveBankruptcyCount);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveBankruptcyPct','0','100','10',ExecutiveBankruptcyPct);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveEvictionCount','0','999','10',ExecutiveEvictionCount);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveEvictionPct','0','100','10',ExecutiveEvictionPct);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveLienCount','0','999','10',ExecutiveLienCount);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveLienPct','0','100','10',ExecutiveLienPct);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveJudgmentCount','0','999','10',ExecutiveJudgmentCount);
Distribution_Module_new.Dis_Macro(Test_file,'ExecutiveJudgmentPct','0','100','10',ExecutiveJudgmentPct);

final_report:= BkCount120+	BkCount24+	BkFilingDateOldest120+	BkFilingDateNewest120+	BkTimeOldest120+	BkTimeNewest120+	BkChapter120+	BkCh7Count120+	BkCh13Count120+	BkUpdateDateNewest120+	BkTimeNewestUpdate120+	BkDispositionDateNewest120+	BkDisposition120+	BkDismissedCount120+	BkDismissedCount24+	BkDisposedCount120+	BkDischargedCount120+	BkBusinessFiling120+	BkSeverityIndex120+	CrimArrestCount84+	CrimArrestCount12+	CrimCount+	CrimCount12+	CrimFelonyCount+	CrimFelonyCount12+	CrimNonFelonyCount+	CrimNonFelonyCount12+	CrimAddressHistory+	CrimXFelony+	CrimBehaviorLevel+	CrimArrestDateNewest+	CrimArrestDateOldest+	CrimArrestTimeNewest+	CrimArrestTimeOldest+	CrimDateNewest+	CrimDateOldest+	CrimTimeNewest+	CrimTimeOldest+	CrimFelonyDateNewest+	CrimFelonyDateOldest+	CrimFelonyTimeNewest+	CrimFelonyTimeOldest+	CrimNonFelonyDateNewest+	CrimNonFelonyDateOldest+	CrimNonFelonyTimeNewest+	CrimNonFelonyTimeOldest+	AssociateCount+	AssociateBusinessCount+	AssociateBusinessAvg+	AssociateActiveBusinessCount+	AssociateActiveBusinessAvg+	AssociateActiveBusinessPct+	AssociatePropOwnerCount+	AssociatePropOwnerPct+	AssociateDerogCount+	AssociateDerogPct+	AssociateDerogIndex+	AssociateFelonyCount+	AssociateFelonyPct+	AssociateCriminalCount+	AssociateCriminalPct+	AssociateBankruptcyCount+	AssociateBankruptcyPct+	AssociateEvictionCount+	AssociateEvictionPct+	AssociateLienCount+	AssociateLienPct+	AssociateJudgmentCount+	AssociateJudgmentPct+	BusBkCount120+	BusBkDisposedCount120+	BusBkDischargedCount120+	BusBkDismissedCount120+	BusBkCh7Count120+	BusBkCh11Count120+	BusBkCh13Count120+	BusBkTimeOldest120+	BusBkTimeNewest120+	BusBkTimeNewestUpdate120+	BusBkNewestChapter120+	BusBkNewestDisposition120+	BusBkDateOldest120+	BusBkDateNewest120+	BusBkDateNewestUpdate120+	ExecutiveCount+	ExecutiveBusinessCount+	ExecutiveBusinessAvg+	ExecutiveActiveBusinessCount+	ExecutiveActiveBusinessAvg+	ExecutiveActiveBusinessPct+	ExecutivePropOwnerCount+	ExecutivePropOwnerPct+	ExecutiveDerogCount+	ExecutiveDerogPct+	ExecutiveDerogIndex+	ExecutiveFelonyCount+	ExecutiveFelonyPct+	ExecutiveCriminalCount+	ExecutiveCriminalPct+	ExecutiveBankruptcyCount+	ExecutiveBankruptcyPct+	ExecutiveEvictionCount+	ExecutiveEvictionPct+	ExecutiveLienCount+	ExecutiveLienPct+	ExecutiveJudgmentCount+	ExecutiveJudgmentPct;
// choosen(final_report,all);

output(final_report,,'~kel_shell::out::attributes_results',thor,compressed,overwrite);
