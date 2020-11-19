EXPORT test_riskview_v5_generic_attr_report(route,current_dt,previous_dt) := functionmacro

import Scoring_Project_Macros, Scoring_QA;

 file1_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout,


thor),(integer)accountnumber);

 file2_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout,


thor),(integer)accountnumber);


 	   file1 := file1_2(errorcode='');
file2 := file2_2(errorcode='');

	


aa1:=join(file1,file2,left.accountnumber=right.accountnumber,inner);

aa:=aa1(accountnumber<>'');


DS1:=join(file1,aa,left.accountnumber=right.accountnumber,inner);

DS2:=join(file2,aa,left.accountnumber=right.accountnumber,inner);

                           
                              Missing_values:= JOIN(DS2,DS1,LEFT.accountnumber=RIGHT.accountnumber and LEFT.did!=RIGHT.did,local);
													
															
													
		pfc := count(ds1);
   cfc := count(ds2);
	 
   fcd :=cfc-pfc;
pf:=count(Missing_values);
cf:=count(Missing_values);

pd:=if(pfc!= 0 and cfc=0,1,cf/cfc);
abd:=abs(pd);
ppd:=if(pfc!= 0 and cfc=0,1,(cf/cfc)*100);
	 
	 
Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_1(DS2,'AddrChangeCount03Month',range1);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_2(DS2,'AddrChangeCount06Month',range2);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_3(DS2,'AddrChangeCount12Month',range3);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_4(DS2,'AddrChangeCount24Month',range4);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_5(DS2,'AddrChangeCount60Month',range5);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_6(DS2,'AddrCurrentAVMRatio12MonthPrior',range6);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_7(DS2,'AddrCurrentAVMRatio60MonthPrior',range7);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_8(DS2,'AddrCurrentAVMValue',range8);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_9(DS2,'AddrCurrentAVMValue12Month',range9);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_10(DS2,'AddrCurrentAVMValue60Month',range10);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_11(DS2,'AddrCurrentBlockRatio',range11);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_12(DS2,'AddrCurrentCorrectional',range12);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_13(DS2,'AddrCurrentCountyRatio',range13);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_14(DS2,'AddrCurrentDeedMailing',range14);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_15(DS2,'AddrCurrentDwellTypeIndex',range15);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_16(DS2,'AddrCurrentLastSalesPrice',range16);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_17(DS2,'AddrCurrentLengthOfRes',range17);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_18(DS2,'AddrCurrentOwnershipIndex',range18);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_19(DS2,'AddrCurrentPhoneService',range19);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_20(DS2,'AddrCurrentSubjectOwned',range20);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_21(DS2,'AddrCurrentTaxMarketValue',range21);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_22(DS2,'AddrCurrentTaxValue',range22);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_23(DS2,'AddrCurrentTimeLastSale',range23);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_24(DS2,'AddrCurrentTimeNewest',range24);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_25(DS2,'AddrCurrentTimeOldest',range25);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_26(DS2,'AddrCurrentTractRatio',range26);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_27(DS2,'AddrInputAVMRatio12MonthPrior',range27);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_28(DS2,'AddrInputAVMRatio60MonthPrior',range28);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_29(DS2,'AddrInputAVMValue',range29);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_30(DS2,'AddrInputAVMValue12Month',range30);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_31(DS2,'AddrInputAVMValue60Month',range31);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_32(DS2,'AddrInputBlockRatio',range32);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_33(DS2,'AddrInputCountyRatio',range33);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_34(DS2,'AddrInputDeedMailing',range34);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_35(DS2,'AddrInputDelivery',range35);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_36(DS2,'AddrInputDwellTypeIndex',range36);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_37(DS2,'AddrInputLastSalePrice',range37);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_38(DS2,'AddrInputLengthOfRes',range38);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_39(DS2,'AddrInputMatchIndex',range39);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_40(DS2,'AddrInputOwnershipIndex',range40);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_41(DS2,'AddrInputPhoneCount',range41);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_42(DS2,'AddrInputPhoneService',range42);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_43(DS2,'AddrInputProblems',range43);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_44(DS2,'AddrInputSubjectCount',range44);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_45(DS2,'AddrInputSubjectOwned',range45);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_46(DS2,'AddrInputTaxMarketValue',range46);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_47(DS2,'AddrInputTaxValue',range47);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_48(DS2,'AddrInputTimeLastSale',range48);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_49(DS2,'AddrInputTimeNewest',range49);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_50(DS2,'AddrInputTimeOldest',range50);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_51(DS2,'AddrInputTractRatio',range51);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_52(DS2,'AddrLastMoveEconTrajectory',range52);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_53(DS2,'AddrLastMoveEconTrajectoryIndex',range53);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_54(DS2,'AddrLastMoveTaxRatioDiff',range54);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_55(DS2,'AddrOnFileCollege',range55);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_56(DS2,'AddrOnFileCorrectional',range56);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_57(DS2,'AddrOnFileCount',range57);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_58(DS2,'AddrOnFileHighRisk',range58);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_59(DS2,'AddrPreviousCorrectional',range59);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_60(DS2,'AddrPreviousDwellTypeIndex',range60);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_61(DS2,'AddrPreviousLengthOfRes',range61);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_62(DS2,'AddrPreviousOwnershipIndex',range62);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_63(DS2,'AddrPreviousSubjectOwned',range63);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_64(DS2,'AddrPreviousTimeNewest',range64);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_65(DS2,'AddrPreviousTimeOldest',range65);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_66(DS2,'AddrStabilityIndex',range66);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_67(DS2,'AlertRegulatoryCondition',range67);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_68(DS2,'AssetIndex',range68);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_69(DS2,'AssetOwnership',range69);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_70(DS2,'AssetPersonal',range70);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_71(DS2,'AssetPersonalCount',range71);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_72(DS2,'AssetProp',range72);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_73(DS2,'AssetPropCurrentCount',range73);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_74(DS2,'AssetPropCurrentTaxTotal',range74);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_75(DS2,'AssetPropEverCount',range75);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_76(DS2,'AssetPropEverSoldCount',range76);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_77(DS2,'AssetPropIndex',range77);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_78(DS2,'AssetPropNewestMortgageType',range78);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_79(DS2,'AssetPropNewestSalePrice',range79);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_80(DS2,'AssetPropPurchaseCount12Month',range80);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_81(DS2,'AssetPropPurchaseTimeNewest',range81);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_82(DS2,'AssetPropPurchaseTimeOldest',range82);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_83(DS2,'AssetPropSalePurchaseRatio',range83);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_84(DS2,'AssetPropSaleTimeNewest',range84);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_85(DS2,'AssetPropSaleTimeOldest',range85);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_86(DS2,'AssetPropSoldCount12Month',range86);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_87(DS2,'BankruptcyChapter',range87);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_88(DS2,'BankruptcyCount',range88);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_89(DS2,'BankruptcyCount24Month',range89);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_90(DS2,'BankruptcyDismissed24Month',range90);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_91(DS2,'BankruptcyStatus',range91);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_92(DS2,'BankruptcyTimeNewest',range92);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_93(DS2,'BusinessAssociation',range93);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_94(DS2,'BusinessAssociationIndex',range94);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_95(DS2,'BusinessAssociationTimeOldest',range95);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_96(DS2,'BusinessTitleLeadership',range96);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_97(DS2,'ConfirmationInputAddress',range97);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_98(DS2,'ConfirmationInputDOB',range98);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_99(DS2,'ConfirmationInputName',range99);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_100(DS2,'ConfirmationInputSSN',range100);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_101(DS2,'ConfirmationSubjectFound',range101);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_102(DS2,'CriminalFelonyCount',range102);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_103(DS2,'CriminalFelonyCount12Month',range103);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_104(DS2,'CriminalFelonyTimeNewest',range104);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_105(DS2,'CriminalNonFelonyCount',range105);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_106(DS2,'CriminalNonFelonyCount12Month',range106);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_107(DS2,'CriminalNonFelonyTimeNewest',range107);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_108(DS2,'DerogCount',range108);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_109(DS2,'DerogCount12Month',range109);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_110(DS2,'DerogSeverityIndex',range110);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_111(DS2,'DerogTimeNewest',range111);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_112(DS2,'EducationAttendance',range112);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_113(DS2,'EducationEvidence',range113);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_114(DS2,'EducationInstitutionPrivate',range114);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_115(DS2,'EducationInstitutionRating',range115);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_116(DS2,'EducationProgramAttended',range116);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_117(DS2,'EvictionCount',range117);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_118(DS2,'EvictionCount12Month',range118);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_119(DS2,'EvictionTimeNewest',range119);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_120(DS2,'InputProvidedCity',range120);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_121(DS2,'InputProvidedDateofBirth',range121);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_122(DS2,'InputProvidedFirstName',range122);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_123(DS2,'InputProvidedLastName',range123);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_124(DS2,'InputProvidedLexID',range124);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_125(DS2,'InputProvidedPhone',range125);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_126(DS2,'InputProvidedSSN',range126);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_127(DS2,'InputProvidedState',range127);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_128(DS2,'InputProvidedStreetAddress',range128);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_129(DS2,'InputProvidedZipCode',range129);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_130(DS2,'InquiryAuto12Month',range130);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_131(DS2,'InquiryBanking12Month',range131);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_132(DS2,'InquiryCollections12Month',range132);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_133(DS2,'InquiryNonShortTerm12Month',range133);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_134(DS2,'InquiryShortTerm12Month',range134);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_135(DS2,'InquiryTelcom12Month',range135);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_136(DS2,'LienJudgmentCount',range136);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_137(DS2,'LienJudgmentCount12Month',range137);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_138(DS2,'LienJudgmentCourtCount',range138);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_139(DS2,'LienJudgmentDollarTotal',range139);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_140(DS2,'LienJudgmentForeclosureCount',range140);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_141(DS2,'LienJudgmentOtherCount',range141);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_142(DS2,'LienJudgmentSeverityIndex',range142);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_143(DS2,'LienJudgmentSmallClaimsCount',range143);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_144(DS2,'LienJudgmentTaxCount',range144);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_145(DS2,'LienJudgmentTimeNewest',range145);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_146(DS2,'PhoneInputMobile',range146);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_147(DS2,'PhoneInputProblems',range147);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_148(DS2,'PhoneInputSubjectCount',range148);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_149(DS2,'ProfLicCount',range149);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_150(DS2,'ProfLicTypeCategory',range150);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_151(DS2,'PurchaseActivityCount',range151);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_152(DS2,'PurchaseActivityDollarTotal',range152);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_153(DS2,'PurchaseActivityIndex',range153);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_154(DS2,'SSNDateLowIssued',range154);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_155(DS2,'SSNDeceased',range155);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_156(DS2,'SSNProblems',range156);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_157(DS2,'SSNSubjectCount',range157);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_158(DS2,'ShortTermLoanRequest',range158);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_159(DS2,'ShortTermLoanRequest12Month',range159);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_160(DS2,'ShortTermLoanRequest24Month',range160);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_161(DS2,'SourceCredHeaderTimeNewest',range161);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_162(DS2,'SourceCredHeaderTimeOldest',range162);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_163(DS2,'SourceNonDerogCount',range163);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_164(DS2,'SourceNonDerogCount03Month',range164);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_165(DS2,'SourceNonDerogCount06Month',range165);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_166(DS2,'SourceNonDerogCount12Month',range166);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_167(DS2,'SourceNonDerogProfileIndex',range167);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_168(DS2,'SourceVoterRegistration',range168);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_169(DS2,'SubjectAbilityIndex',range169);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_170(DS2,'SubjectActivityIndex03Month',range170);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_171(DS2,'SubjectActivityIndex06Month',range171);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_172(DS2,'SubjectActivityIndex12Month',range172);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_173(DS2,'SubjectAge',range173);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_174(DS2,'SubjectDeceased',range174);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_175(DS2,'SubjectNewestRecord12Month',range175);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_176(DS2,'SubjectRecordTimeNewest',range176);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_177(DS2,'SubjectRecordTimeOldest',range177);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_178(DS2,'SubjectSSNCount',range178);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_179(DS2,'SubjectStabilityIndex',range179);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.range_function_180(DS2,'SubjectWillingnessIndex',range180);


   	  	

      	ran:= range1+range2+range3+range4+range5+range6+range7+range8+range9+range10+range11+range12+range13+range14+range15+range16+range17+range18+range19+range20+range21+range22+range23+range24+range25+range26+range27+range28+range29+range30+range31+range32+range33+range34+range35+range36+range37+range38+range39+range40+range41+range42+range43+range44+range45+range46+range47+range48+range49+range50+range51+range52+range53+range54+range55+range56+range57+range58+range59+range60+range61+range62+range63+range64+range65+range66+range67+range68+range69+range70+range71+range72+range73+range74+range75+range76+range77+range78+range79+range80+range81+range82+range83+range84+range85+range86+range87+range88+range89+range90+range91+range92+range93+range94+range95+range96+range97+range98+range99+range100+range101+range102+range103+range104+range105+range106+range107+range108+range109+range110+range111+range112+range113+range114+range115+range116+range117+range118+range119+range120+range121+range122+range123+range124+range125+range126+range127+range128+range129+range130+range131+range132+range133+range134+range135+range136+range137+range138+range139+range140+range141+range142+range143+range144+range145+range146+range147+range148+range149+range150+range151+range152+range153+range154+range155+range156+range157+range158+range159+range160+range161+range162+range163+range164+range165+range166+range167+range168+range169+range170+range171+range172+range173+range174+range175+range176+range177+range178+range179+range180;
Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Distinct_function(DS2,'AddrCurrentDwellType',dist1);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Distinct_function(DS2,'AddrCurrentTaxYr',dist2);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Distinct_function(DS2,'AddrInputDwellType',dist3);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Distinct_function(DS2,'AddrInputTaxYr',dist4);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Distinct_function(DS2,'AddrPreviousDwellType',dist5);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Distinct_function(DS2,'AssetIndexPrimaryFactor',dist6);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Distinct_function(DS2,'SubjectAbilityPrimaryFactor',dist7);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Distinct_function(DS2,'SubjectStabilityPrimaryFactor',dist8);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Distinct_function(DS2,'SubjectWillingnessPrimaryFactor',dist9);

				
					dis:= dist1+dist2+dist3+dist4+dist5+dist6+dist7+dist8+dist9;

   	

							 Scoring_QA.Range_function_module.Length_Function(DS2,'did',len1);
							
      len:=len1;
			
				 Scoring_QA.Range_function_module.Distinct_function7(DS2,'did',did1);
	 	 
	 did_stats:=did1;
	 
			result2_stats:= ran + dis + did_stats;		
		
		
		
		
Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrChangeCount03Month',ave1);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrChangeCount06Month',ave2);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrChangeCount12Month',ave3);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrChangeCount24Month',ave4);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrChangeCount60Month',ave5);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentAVMRatio12MonthPrior',ave6);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentAVMRatio60MonthPrior',ave7);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentAVMValue',ave8);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentAVMValue12Month',ave9);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentAVMValue60Month',ave10);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentBlockRatio',ave11);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentCorrectional',ave12);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentCountyRatio',ave13);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentDeedMailing',ave14);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentDwellType',ave15);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentDwellTypeIndex',ave16);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentLastSalesPrice',ave17);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentLengthOfRes',ave18);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentOwnershipIndex',ave19);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentPhoneService',ave20);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentSubjectOwned',ave21);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentTaxMarketValue',ave22);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentTaxValue',ave23);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentTaxYr',ave24);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentTimeLastSale',ave25);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentTimeNewest',ave26);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentTimeOldest',ave27);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrCurrentTractRatio',ave28);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputAVMRatio12MonthPrior',ave29);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputAVMRatio60MonthPrior',ave30);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputAVMValue',ave31);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputAVMValue12Month',ave32);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputAVMValue60Month',ave33);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputBlockRatio',ave34);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputCountyRatio',ave35);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputDeedMailing',ave36);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputDelivery',ave37);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputDwellType',ave38);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputDwellTypeIndex',ave39);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputLastSalePrice',ave40);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputLengthOfRes',ave41);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputMatchIndex',ave42);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputOwnershipIndex',ave43);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputPhoneCount',ave44);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputPhoneService',ave45);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputProblems',ave46);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputSubjectCount',ave47);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputSubjectOwned',ave48);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputTaxMarketValue',ave49);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputTaxValue',ave50);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputTaxYr',ave51);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputTimeLastSale',ave52);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputTimeNewest',ave53);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputTimeOldest',ave54);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrInputTractRatio',ave55);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrLastMoveEconTrajectory',ave56);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrLastMoveEconTrajectoryIndex',ave57);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrLastMoveTaxRatioDiff',ave58);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrOnFileCollege',ave59);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrOnFileCorrectional',ave60);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrOnFileCount',ave61);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrOnFileHighRisk',ave62);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrPreviousCorrectional',ave63);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrPreviousDwellType',ave64);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrPreviousDwellTypeIndex',ave65);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrPreviousLengthOfRes',ave66);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrPreviousOwnershipIndex',ave67);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrPreviousSubjectOwned',ave68);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrPreviousTimeNewest',ave69);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrPreviousTimeOldest',ave70);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AddrStabilityIndex',ave71);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AlertRegulatoryCondition',ave72);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetIndex',ave73);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetIndexPrimaryFactor',ave74);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetOwnership',ave75);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPersonal',ave76);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPersonalCount',ave77);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetProp',ave78);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropCurrentCount',ave79);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropCurrentTaxTotal',ave80);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropEverCount',ave81);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropEverSoldCount',ave82);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropIndex',ave83);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropNewestMortgageType',ave84);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropNewestSalePrice',ave85);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropPurchaseCount12Month',ave86);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropPurchaseTimeNewest',ave87);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropPurchaseTimeOldest',ave88);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropSalePurchaseRatio',ave89);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropSaleTimeNewest',ave90);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropSaleTimeOldest',ave91);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'AssetPropSoldCount12Month',ave92);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'BankruptcyChapter',ave93);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'BankruptcyCount',ave94);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'BankruptcyCount24Month',ave95);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'BankruptcyDismissed24Month',ave96);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'BankruptcyStatus',ave97);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'BankruptcyTimeNewest',ave98);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'BusinessAssociation',ave99);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'BusinessAssociationIndex',ave100);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'BusinessAssociationTimeOldest',ave101);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'BusinessTitleLeadership',ave102);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'ConfirmationInputAddress',ave103);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'ConfirmationInputDOB',ave104);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'ConfirmationInputName',ave105);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'ConfirmationInputSSN',ave106);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'ConfirmationSubjectFound',ave107);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'CriminalFelonyCount',ave108);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'CriminalFelonyCount12Month',ave109);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'CriminalFelonyTimeNewest',ave110);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'CriminalNonFelonyCount',ave111);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'CriminalNonFelonyCount12Month',ave112);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'CriminalNonFelonyTimeNewest',ave113);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'DerogCount',ave114);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'DerogCount12Month',ave115);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'DerogSeverityIndex',ave116);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'DerogTimeNewest',ave117);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'EducationAttendance',ave118);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'EducationEvidence',ave119);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'EducationInstitutionPrivate',ave120);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'EducationInstitutionRating',ave121);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'EducationProgramAttended',ave122);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'EvictionCount',ave123);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'EvictionCount12Month',ave124);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'EvictionTimeNewest',ave125);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InputProvidedCity',ave126);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InputProvidedDateofBirth',ave127);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InputProvidedFirstName',ave128);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InputProvidedLastName',ave129);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InputProvidedLexID',ave130);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InputProvidedPhone',ave131);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InputProvidedSSN',ave132);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InputProvidedState',ave133);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InputProvidedStreetAddress',ave134);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InputProvidedZipCode',ave135);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InquiryAuto12Month',ave136);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InquiryBanking12Month',ave137);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InquiryCollections12Month',ave138);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InquiryNonShortTerm12Month',ave139);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InquiryShortTerm12Month',ave140);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'InquiryTelcom12Month',ave141);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'LienJudgmentCount',ave142);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'LienJudgmentCount12Month',ave143);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'LienJudgmentCourtCount',ave144);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'LienJudgmentDollarTotal',ave145);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'LienJudgmentForeclosureCount',ave146);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'LienJudgmentOtherCount',ave147);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'LienJudgmentSeverityIndex',ave148);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'LienJudgmentSmallClaimsCount',ave149);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'LienJudgmentTaxCount',ave150);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'LienJudgmentTimeNewest',ave151);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'PhoneInputMobile',ave152);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'PhoneInputProblems',ave153);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'PhoneInputSubjectCount',ave154);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'ProfLicCount',ave155);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'ProfLicTypeCategory',ave156);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'PurchaseActivityCount',ave157);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'PurchaseActivityDollarTotal',ave158);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'PurchaseActivityIndex',ave159);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SSNDateLowIssued',ave160);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SSNDeceased',ave161);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SSNProblems',ave162);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SSNSubjectCount',ave163);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'ShortTermLoanRequest',ave164);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'ShortTermLoanRequest12Month',ave165);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'ShortTermLoanRequest24Month',ave166);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SourceCredHeaderTimeNewest',ave167);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SourceCredHeaderTimeOldest',ave168);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SourceNonDerogCount',ave169);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SourceNonDerogCount03Month',ave170);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SourceNonDerogCount06Month',ave171);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SourceNonDerogCount12Month',ave172);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SourceNonDerogProfileIndex',ave173);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SourceVoterRegistration',ave174);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectAbilityIndex',ave175);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectAbilityPrimaryFactor',ave176);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectActivityIndex03Month',ave177);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectActivityIndex06Month',ave178);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectActivityIndex12Month',ave179);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectAge',ave180);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectDeceased',ave181);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectNewestRecord12Month',ave182);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectRecordTimeNewest',ave183);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectRecordTimeOldest',ave184);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectSSNCount',ave185);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectStabilityIndex',ave186);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectStabilityPrimaryFactor',ave187);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectWillingnessIndex',ave188);

Scoring_QA_New_Bins.test_riskview_v5_generic_new_bins.Average_func(DS2,'SubjectWillingnessPrimaryFactor',ave189);



      
				
      	avearage:= ave1+ave2+ave3+ave4+ave5+ave6+ave7+ave8+ave9+ave10+ave11+ave12+ave13+ave14+ave15+ave16+ave17+ave18+ave19+ave20+ave21+ave22+ave23+ave24+ave25+ave26+ave27+ave28+ave29+ave30+ave31+ave32+ave33+ave34+ave35+ave36+ave37+ave38+ave39+ave40+ave41+ave42+ave43+ave44+ave45+ave46+ave47+ave48+ave49+ave50+ave51+ave52+ave53+ave54+ave55+ave56+ave57+ave58+ave59+ave60+ave61+ave62+ave63+ave64+ave65+ave66+ave67+ave68+ave69+ave70+ave71+ave72+ave73+ave74+ave75+ave76+ave77+ave78+ave79+ave80+ave81+ave82+ave83+ave84+ave85+ave86+ave87+ave88+ave89+ave90+ave91+ave92+ave93+ave94+ave95+ave96+ave97+ave98+ave99+ave100+ave101+ave102+ave103+ave104+ave105+ave106+ave107+ave108+ave109+ave110+ave111+ave112+ave113+ave114+ave115+ave116+ave117+ave118+ave119+ave120+ave121+ave122+ave123+ave124+ave125+ave126+ave127+ave128+ave129+ave130+ave131+ave132+ave133+ave134+ave135+ave136+ave137+ave138+ave139+ave140+ave141+ave142+ave143+ave144+ave145+ave146+ave147+ave148+ave149+ave150+ave151+ave152+ave153+ave154+ave155+ave156+ave157+ave158+ave159+ave160+ave161+ave162+ave163+ave164+ave165+ave166+ave167+ave168+ave169+ave170+ave171+ave172+ave173+ave174+ave175+ave176+ave177+ave178+ave179+ave180+ave181+ave182+ave183+ave184+ave185+ave186+ave187+ave188+ave189;
					
					result4_stats:=avearage;
					
	 
	 
	  compare_layout_stats := RECORD
		  string file_version;
			string mode;
      string field_name;
      string distribution_type;		
      STRING50 attribute_value; 
			decimal20_4 Count1;
      decimal20_4 file_count;
      decimal20_4 ds_count;

     						
    END;
		
		
		compare_layout_stats func(result4_stats l):=transform
                                         self.file_version:='fcra_rvattributes_v5';
																				 self.mode:='xml';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='fcra_rvattributes_v5';
																				 self.mode:='xml';
																			   self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 
																				 self:=l;
		
		end;
		
		result2_stats_project:= project(result2_stats,func1(left));

		compare_layout := RECORD
            		  string file_version;
            			string mode;
                  string field_name;
                  string distribution_type;
            			decimal20_4 p_file_count;
                  decimal20_4 c_file_count;
                  decimal20_4 file_count_diff;
									decimal20_4 matched_file_count;
                  STRING50 attribute_value; 
                  decimal20_4 p_frequency;
                  decimal20_4 c_frequency;
                  decimal20_4 frequency_diff;
            			decimal20_4 perc_frequency_diff;
               	  decimal20_4 p_proportion;
                  decimal20_4 c_proportion;
                  decimal20_4 proportion_diff;
            			decimal20_4 abs_proportion_diff;
            			decimal20_4 perc_proportion_diff;
            			decimal20_4 PSI;
            								
                        END;	

		  did_results := DATASET([{'fcra_rvattributes_v5','xml','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
											
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile[2..] + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile[2..] + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2);

return seq;

endmacro;