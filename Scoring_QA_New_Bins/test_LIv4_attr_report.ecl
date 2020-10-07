EXPORT test_LIv4_attr_report(route,current_dt,previous_dt) := functionmacro



 file1_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.LI_Attributes_V4_XML_Generic_msn1106_0_outfile + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout,


thor),(integer)accountnumber);

 file2_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.LI_Attributes_V4_XML_Generic_msn1106_0_outfile + current_dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout,


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
	 
	 
Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_1(DS2,'AccidentAge',range1);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_2(DS2,'AccidentCount',range2);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_3(DS2,'AddrChangeCount01',range3);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_4(DS2,'AddrChangeCount03',range4);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_5(DS2,'AddrChangeCount06',range5);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_6(DS2,'AddrChangeCount12',range6);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_7(DS2,'AddrChangeCount24',range7);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_8(DS2,'AddrChangeCount60',range8);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_9(DS2,'AddrMostRecentCrimeDiff',range9);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_10(DS2,'AddrMostRecentDistance',range10);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_11(DS2,'AddrMostRecentIncomeDiff',range11);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_12(DS2,'AddrMostRecentMoveAge',range12);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_13(DS2,'AddrMostRecentStateDiff',range13);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_14(DS2,'AddrMostRecentTaxDiff',range14);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_15(DS2,'AddrMostRecentValueDIff',range15);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_16(DS2,'AddrRecentEconTrajectoryIndex',range16);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_17(DS2,'AddrStability',range17);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_18(DS2,'AgeNewestRecord',range18);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_19(DS2,'AgeOldestRecord',range19);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_20(DS2,'AircraftCount',range20);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_21(DS2,'AircraftCount01',range21);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_22(DS2,'AircraftCount03',range22);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_23(DS2,'AircraftCount06',range23);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_24(DS2,'AircraftCount12',range24);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_25(DS2,'AircraftCount24',range25);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_26(DS2,'AircraftCount60',range26);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_27(DS2,'AircraftOwner',range27);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_28(DS2,'ArrestAge',range28);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_29(DS2,'ArrestCount',range29);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_30(DS2,'ArrestCount01',range30);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_31(DS2,'ArrestCount03',range31);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_32(DS2,'ArrestCount06',range32);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_33(DS2,'ArrestCount12',range33);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_34(DS2,'ArrestCount24',range34);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_35(DS2,'ArrestCount60',range35);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_36(DS2,'AssetOwner',range36);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_37(DS2,'AssocCreditBureauOnlyCount',range37);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_38(DS2,'AssocCreditBureauOnlyCountMonth',range38);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_39(DS2,'AssocCreditBureauOnlyCountNew',range39);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_40(DS2,'AssocHighRiskTopologyCount',range40);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_41(DS2,'AssocRiskLevel',range41);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_42(DS2,'AssocSuspicousIdentitiesCount',range42);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_43(DS2,'BankruptcyAge',range43);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_44(DS2,'BankruptcyCount',range44);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_45(DS2,'BankruptcyCount01',range45);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_46(DS2,'BankruptcyCount03',range46);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_47(DS2,'BankruptcyCount06',range47);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_48(DS2,'BankruptcyCount12',range48);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_49(DS2,'BankruptcyCount24',range49);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_50(DS2,'BankruptcyCount60',range50);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_51(DS2,'BusinessActiveAssociation',range51);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_52(DS2,'BusinessAssociationAge',range52);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_53(DS2,'BusinessInactiveAssociation',range53);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_54(DS2,'BusinessInputAddrCount',range54);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_55(DS2,'ComponentCharRiskLevel',range55);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_56(DS2,'CorrelationRiskLevel',range56);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_57(DS2,'CreditBureauRecord',range57);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_58(DS2,'CurrAddrAVMValue',range58);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_59(DS2,'CurrAddrAVMValue12',range59);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_60(DS2,'CurrAddrAVMValue60',range60);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_61(DS2,'CurrAddrActivePhoneList',range61);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_62(DS2,'CurrAddrAgeLastSale',range62);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_63(DS2,'CurrAddrAgeNewestRecord',range63);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_64(DS2,'CurrAddrAgeOldestRecord',range64);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_65(DS2,'CurrAddrApplicantOwned',range65);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_66(DS2,'CurrAddrBlockIndex',range66);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_67(DS2,'CurrAddrBurglaryIndex',range67);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_68(DS2,'CurrAddrCarTheftIndex',range68);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_69(DS2,'CurrAddrCorrectional',range69);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_70(DS2,'CurrAddrCountyIndex',range70);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_71(DS2,'CurrAddrCrimeIndex',range71);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_72(DS2,'CurrAddrFamilyOwned',range72);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_73(DS2,'CurrAddrLastSalesPrice',range73);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_74(DS2,'CurrAddrLenOfRes',range74);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_75(DS2,'CurrAddrMedianIncome',range75);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_76(DS2,'CurrAddrMedianValue',range76);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_77(DS2,'CurrAddrMortgageType',range77);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_78(DS2,'CurrAddrMurderIndex',range78);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_79(DS2,'CurrAddrOccupantOwned',range79);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_80(DS2,'CurrAddrTaxMarketValue',range80);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_81(DS2,'CurrAddrTaxValue',range81);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_82(DS2,'CurrAddrTractIndex',range82);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_83(DS2,'DerogAge',range83);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_84(DS2,'DerogCount',range84);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_85(DS2,'DerogRecentCount',range85);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_86(DS2,'DerogSeverityIndex',range86);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_87(DS2,'DivAddrIdentityCount',range87);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_88(DS2,'DivAddrIdentityCountNew',range88);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_89(DS2,'DivAddrIdentityMSourceCount',range89);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_90(DS2,'DivAddrSSNCount',range90);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_91(DS2,'DivAddrSSNCountNew',range91);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_92(DS2,'DivAddrSSNMSourceCount',range92);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_93(DS2,'DivAddrSuspIdentityCountNew',range93);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_94(DS2,'DivRiskLevel',range94);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_95(DS2,'DivSSNAddrMSourceCount',range95);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_96(DS2,'DivSSNIdentityMSourceCount',range96);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_97(DS2,'DivSSNIdentityMSourceUrelCount',range97);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_98(DS2,'DivSSNLNameCountNew',range98);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_99(DS2,'DivSearchAddrSuspIdentityCount',range99);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_100(DS2,'DoNotMail',range100);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_101(DS2,'EducationAttendedCollege',range101);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_102(DS2,'EducationFieldofStudyType',range102);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_103(DS2,'EducationInstitutionPrivate',range103);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_104(DS2,'EducationInstitutionRating',range104);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_105(DS2,'EducationProgram2Yr',range105);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_106(DS2,'EducationProgram4Yr',range106);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_107(DS2,'EducationProgramGraduate',range107);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_108(DS2,'EstimatedAnnualIncome',range108);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_109(DS2,'EvictionAge',range109);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_110(DS2,'EvictionCount',range110);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_111(DS2,'EvictionCount01',range111);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_112(DS2,'EvictionCount03',range112);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_113(DS2,'EvictionCount06',range113);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_114(DS2,'EvictionCount12',range114);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_115(DS2,'EvictionCount24',range115);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_116(DS2,'EvictionCount60',range116);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_117(DS2,'FelonyAge',range117);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_118(DS2,'FelonyCount',range118);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_121(DS2,'FelonyCount01',range119);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_121(DS2,'FelonyCount03',range120);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_121(DS2,'FelonyCount06',range121);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_122(DS2,'FelonyCount12',range122);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_123(DS2,'FelonyCount24',range123);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_124(DS2,'FelonyCount60',range124);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_125(DS2,'HistoricalAddrCorrectional',range125);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_126(DS2,'IDVerAddressAssocCount',range126);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_127(DS2,'IDVerRiskLevel',range127);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_128(DS2,'IDVerSSNCreditBureauCount',range128);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_129(DS2,'IDVerSSNCreditBureauDelete',range129);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_130(DS2,'IdentityRiskLevel',range130);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_131(DS2,'InputAddrAVMValue',range131);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_132(DS2,'InputAddrAVMValue12',range132);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_133(DS2,'InputAddrAVMValue60',range133);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_134(DS2,'InputAddrActivePhoneList',range134);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_135(DS2,'InputAddrAgeLastSale',range135);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_136(DS2,'InputAddrAgeNewestRecord',range136);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_137(DS2,'InputAddrAgeOldestRecord',range137);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_138(DS2,'InputAddrApplicantOwned',range138);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_139(DS2,'InputAddrBlockIndex',range139);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_140(DS2,'InputAddrBurglaryIndex',range140);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_141(DS2,'InputAddrBusinessCount',range141);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_142(DS2,'InputAddrCarTheftIndex',range142);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_143(DS2,'InputAddrCountyIndex',range143);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_144(DS2,'InputAddrCrimeIndex',range144);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_145(DS2,'InputAddrDelivery',range145);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_146(DS2,'InputAddrErrorCode',range146);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_147(DS2,'InputAddrFamilyOwned',range147);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_148(DS2,'InputAddrHighRisk',range148);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_149(DS2,'InputAddrHistoricalMatch',range149);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_150(DS2,'InputAddrLastSalesPrice',range150);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_151(DS2,'InputAddrLenOfRes',range151);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_152(DS2,'InputAddrMedianIncome',range152);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_153(DS2,'InputAddrMedianValue',range153);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_154(DS2,'InputAddrMobilityIndex',range154);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_155(DS2,'InputAddrMortgageType',range155);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_156(DS2,'InputAddrMultiFamilyCount',range156);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_157(DS2,'InputAddrMurderIndex',range157);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_158(DS2,'InputAddrNotPrimaryRes',range158);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_159(DS2,'InputAddrOccupantOwned',range159);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_160(DS2,'InputAddrPhoneCount',range160);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_161(DS2,'InputAddrPhoneRecentCount',range161);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_162(DS2,'InputAddrProblems',range162);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_163(DS2,'InputAddrSingleFamilyCount',range163);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_164(DS2,'InputAddrTaxMarketValue',range164);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_165(DS2,'InputAddrTaxValue',range165);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_166(DS2,'InputAddrTractIndex',range166);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_167(DS2,'InputAddrVacantPropCount',range167);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_168(DS2,'InputAreaCodeChange',range168);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_169(DS2,'InputPhoneHighRisk',range169);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_170(DS2,'InputPhoneMobile',range170);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_171(DS2,'InputPhoneProblems',range171);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_172(DS2,'InputPhoneServiceType',range172);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_173(DS2,'LastNameChangeAge',range173);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_174(DS2,'LastNameChangeCount01',range174);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_175(DS2,'LastNameChangeCount03',range175);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_176(DS2,'LastNameChangeCount06',range176);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_177(DS2,'LastNameChangeCount12',range177);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_178(DS2,'LastNameChangeCount24',range178);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_179(DS2,'LastNameChangeCount60',range179);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_180(DS2,'LienCount',range180);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_181(DS2,'LienFiledAge',range181);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_182(DS2,'LienFiledCount',range182);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_183(DS2,'LienFiledCount01',range183);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_184(DS2,'LienFiledCount03',range184);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_185(DS2,'LienFiledCount06',range185);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_186(DS2,'LienFiledCount12',range186);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_187(DS2,'LienFiledCount24',range187);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_188(DS2,'LienFiledCount60',range188);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_189(DS2,'LienFiledTotal',range189);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_190(DS2,'LienReleasedAge',range190);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_191(DS2,'LienReleasedCount',range191);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_193(DS2,'LienReleasedCount01',range192);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_193(DS2,'LienReleasedCount03',range193);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_194(DS2,'LienReleasedCount06',range194);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_195(DS2,'LienReleasedCount12',range195);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_196(DS2,'LienReleasedCount24',range196);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_197(DS2,'LienReleasedCount60',range197);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_198(DS2,'LienReleasedTotal',range198);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_199(DS2,'NonDerogCount',range199);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_200(DS2,'NonDerogCount01',range200);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_201(DS2,'NonDerogCount03',range201);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_202(DS2,'NonDerogCount06',range202);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_203(DS2,'NonDerogCount12',range203);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_204(DS2,'NonDerogCount24',range204);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_205(DS2,'NonDerogCount60',range205);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_206(DS2,'OnlineDirectory',range206);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_207(DS2,'PRSearchAddrIdentities',range207);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_208(DS2,'PRSearchIdentityAddrs',range208);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_209(DS2,'PRSearchIdentityPhones',range209);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_210(DS2,'PRSearchIdentitySSNs',range210);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_211(DS2,'PRSearchLocateCount',range211);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_212(DS2,'PRSearchLocateCount01',range212);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_213(DS2,'PRSearchLocateCount03',range213);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_214(DS2,'PRSearchLocateCount06',range214);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_215(DS2,'PRSearchLocateCount12',range215);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_216(DS2,'PRSearchLocateCount24',range216);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_217(DS2,'PRSearchOtherCount',range217);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_218(DS2,'PRSearchOtherCount01',range218);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_219(DS2,'PRSearchOtherCount03',range219);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_220(DS2,'PRSearchOtherCount06',range220);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_221(DS2,'PRSearchOtherCount12',range221);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_222(DS2,'PRSearchOtherCount24',range222);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_223(DS2,'PRSearchPersonalFinanceCount',range223);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_224(DS2,'PRSearchPersonalFinanceCount01',range224);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_225(DS2,'PRSearchPersonalFinanceCount03',range225);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_226(DS2,'PRSearchPersonalFinanceCount06',range226);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_227(DS2,'PRSearchPersonalFinanceCount12',range227);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_228(DS2,'PRSearchPersonalFinanceCount24',range228);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_229(DS2,'PRSearchPhoneIdentities',range229);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_230(DS2,'PRSearchSSNIdentities',range230);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_231(DS2,'PhoneEDAAgeNewestRecord',range231);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_232(DS2,'PhoneEDAAgeOldestRecord',range232);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_233(DS2,'PhoneIdentitiesCount',range233);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_234(DS2,'PhoneIdentitiesRecentCount',range234);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_235(DS2,'PhoneOther',range235);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_236(DS2,'PhoneOtherAgeNewestRecord',range236);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_237(DS2,'PhoneOtherAgeOldestRecord',range237);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_238(DS2,'PrevAddrAVMValue',range238);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_239(DS2,'PrevAddrAgeLastSale',range239);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_240(DS2,'PrevAddrAgeNewestRecord',range240);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_241(DS2,'PrevAddrAgeOldestRecord',range241);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_242(DS2,'PrevAddrApplicantOwned',range242);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_243(DS2,'PrevAddrBlockIndex',range243);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_244(DS2,'PrevAddrBurglaryIndex',range244);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_245(DS2,'PrevAddrCarTheftIndex',range245);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_246(DS2,'PrevAddrCorrectional',range246);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_247(DS2,'PrevAddrCountyIndex',range247);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_248(DS2,'PrevAddrCrimeIndex',range248);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_249(DS2,'PrevAddrFamilyOwned',range249);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_250(DS2,'PrevAddrLastSalesPrice',range250);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_251(DS2,'PrevAddrLenOfRes',range251);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_252(DS2,'PrevAddrMedianIncome',range252);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_253(DS2,'PrevAddrMedianValue',range253);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_254(DS2,'PrevAddrMurderIndex',range254);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_255(DS2,'PrevAddrOccupantOwned',range255);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_256(DS2,'PrevAddrTaxMarketValue',range256);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_257(DS2,'PrevAddrTaxValue',range257);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_258(DS2,'PrevAddrTractIndex',range258);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_259(DS2,'ProfLicAge',range259);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_260(DS2,'ProfLicCount',range260);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_261(DS2,'ProfLicCount01',range261);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_262(DS2,'ProfLicCount03',range262);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_263(DS2,'ProfLicCount06',range263);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_264(DS2,'ProfLicCount12',range264);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_265(DS2,'ProfLicCount24',range265);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_266(DS2,'ProfLicCount60',range266);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_267(DS2,'ProfLicExpired',range267);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_268(DS2,'ProfLicTypeCategory',range268);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_269(DS2,'PropAgeNewestPurchase',range269);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_270(DS2,'PropAgeNewestSale',range270);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_271(DS2,'PropAgeOldestPurchase',range271);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_272(DS2,'PropNewestSalePrice',range272);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_273(DS2,'PropNewestSalePurchaseIndex',range273);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_274(DS2,'PropOwnedCount',range274);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_275(DS2,'PropOwnedHistoricalCount',range275);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_276(DS2,'PropOwnedTaxTotal',range276);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_277(DS2,'PropPurchasedCount01',range277);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_278(DS2,'PropPurchasedCount03',range278);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_279(DS2,'PropPurchasedCount06',range279);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_280(DS2,'PropPurchasedCount12',range280);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_281(DS2,'PropPurchasedCount24',range281);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_282(DS2,'PropPurchasedCount60',range282);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_283(DS2,'PropSoldCount01',range283);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_284(DS2,'PropSoldCount03',range284);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_285(DS2,'PropSoldCount06',range285);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_286(DS2,'PropSoldCount12',range286);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_287(DS2,'PropSoldCount24',range287);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_288(DS2,'PropSoldCount60',range288);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_289(DS2,'PropertyOwner',range289);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_290(DS2,'RecentActivityIndex',range290);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_291(DS2,'RecentUpdate',range291);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_292(DS2,'RelativesBankruptcyCount',range292);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_293(DS2,'RelativesCount',range293);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_294(DS2,'RelativesDistanceClosest',range294);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_295(DS2,'RelativesFelonyCount',range295);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_296(DS2,'RelativesPropOwnedCount',range296);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_297(DS2,'RelativesPropOwnedTaxTotal',range297);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_298(DS2,'SFDUAddrIdentitiesCount',range298);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_299(DS2,'SFDUAddrSSNCount',range299);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_300(DS2,'SSN3Years',range300);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_301(DS2,'SSNAddrCount',range301);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_302(DS2,'SSNAddrRecentCount',range302);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_303(DS2,'SSNAfter5',range303);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_304(DS2,'SSNAgeDeceased',range304);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_305(DS2,'SSNFoundOther',range305);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_306(DS2,'SSNHighIssueAge',range306);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_307(DS2,'SSNIdentitiesCount',range307);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_308(DS2,'SSNIdentitiesRecentCount',range308);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_309(DS2,'SSNLastNameCount',range309);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_310(DS2,'SSNLowIssueAge',range310);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_311(DS2,'SSNNonUS',range311);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_312(DS2,'SSNNotFound',range312);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_313(DS2,'SSNProblems',range313);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_314(DS2,'SSNRecent',range314);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_315(DS2,'SearchAddrSearchCount',range315);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_316(DS2,'SearchComponentRiskLevel',range316);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_317(DS2,'SearchPhoneSearchCount',range317);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_318(DS2,'SearchSSNSearchCount',range318);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_319(DS2,'SearchUnverifiedAddrCountYear',range319);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_320(DS2,'SearchUnverifiedDOBCountYear',range320);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_321(DS2,'SearchUnverifiedPhoneCountYear',range321);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_322(DS2,'SearchUnverifiedSSNCountYear',range322);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_323(DS2,'SearchVelocityRiskLevel',range323);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_324(DS2,'SourceOrderActivity',range324);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_325(DS2,'SourceOrderAgeLastOrder',range325);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_326(DS2,'SourceOrderSourceCount',range326);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_327(DS2,'SourceRiskLevel',range327);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_328(DS2,'SourceWatchList',range328);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_329(DS2,'SrcsConfirmIDAddrCount',range329);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_330(DS2,'SubPrimeOfferRequestCount',range330);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_331(DS2,'SubPrimeOfferRequestCount01',range331);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_332(DS2,'SubPrimeOfferRequestCount03',range332);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_333(DS2,'SubPrimeOfferRequestCount06',range333);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_334(DS2,'SubPrimeOfferRequestCount12',range334);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_335(DS2,'SubPrimeOfferRequestCount24',range335);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_336(DS2,'SubPrimeOfferRequestCount60',range336);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_337(DS2,'SubjectAddrCount',range337);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_338(DS2,'SubjectAddrRecentCount',range338);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_339(DS2,'SubjectLastNameCount',range339);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_340(DS2,'SubjectPhoneCount',range340);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_341(DS2,'SubjectPhoneRecentCount',range341);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_342(DS2,'SubjectSSNCount',range342);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_343(DS2,'SubjectSSNRecentCount',range343);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_344(DS2,'ValidationRiskLevel',range344);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_345(DS2,'VariationDOBCount',range345);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_346(DS2,'VariationDOBCountNew',range346);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_347(DS2,'VariationIdentityCount',range347);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_348(DS2,'VariationMSourcesSSNCount',range348);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_349(DS2,'VariationMSourcesSSNUnrelCount',range349);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_350(DS2,'VariationRiskLevel',range350);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_351(DS2,'VerificationFailure',range351);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_352(DS2,'VerifiedAddress',range352);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_353(DS2,'VerifiedDOB',range353);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_354(DS2,'VerifiedName',range354);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_355(DS2,'VerifiedPhone',range355);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_356(DS2,'VerifiedSSN',range356);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_357(DS2,'VoterRegistrationRecord',range357);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_358(DS2,'WatercraftCount',range358);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_359(DS2,'WatercraftCount01',range359);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_360(DS2,'WatercraftCount03',range360);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_361(DS2,'WatercraftCount06',range361);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_362(DS2,'WatercraftCount12',range362);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_363(DS2,'WatercraftCount24',range363);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_364(DS2,'WatercraftCount60',range364);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_365(DS2,'WatercraftOwner',range365);

Scoring_QA_New_Bins.test_LIv4_new_bins.range_function_366(DS2,'WealthIndex',range366);


   	  	

				
      	         ran:= range1+range2+range3+range4+range5+range6+range7+range8+range9+range10+range11+range12+range13+range14+range15+range16+range17+range18+range19+range20+range21+range22+range23+range24+range25+range26+range27+range28+range29+range30+range31+range32+range33+range34+range35+range36+range37+range38+range39+range40+range41+range42+range43+range44+range45+range46+range47+range48+range49+range50+range51+range52+range53+range54+range55+range56+range57+range58+range59+range60+range61+range62+range63+range64+range65+range66+range67+range68+range69+range70+range71+range72+range73+range74+range75+range76+range77+range78+range79+range80+range81+range82+range83+range84+range85+range86+range87+range88+range89+range90+range91+range92+range93+range94+range95+range96+range97+range98+range99+range100+range101+range102+range103+range104+range105+range106+range107+range108+range109+range110+range111+range112+range113+range114+range115+range116+range117+range118+range119+range120+range121+range122+range123+range124+range125+range126+range127+range128+range129+range130+range131+range132+range133+range134+range135+range136+range137+range138+range139+range140+range141+range142+range143+range144+range145+range146+range147+range148+range149+range150+range151+range152+range153+range154+range155+range156+range157+range158+range159+range160+range161+range162+range163+range164+range165+range166+range167+range168+range169+range170+range171+range172+range173+range174+range175+range176+range177+range178+range179+range180+range181+range182+range183+range184+range185+range186+range187+range188+range189+range190+range191+range192+range193+range194+range195+range196+range197+range198+range199+range200+range201+range202+range203+range204+range205+range206+range207+range208+range209+range210+range211+range212+range213+range214+range215+range216+range217+range218+range219+range220+range221+range222+range223+range224+range225+range226+range227+range228+range229+range230+range231+range232+range233+range234+range235+range236+range237+range238+range239+range240+range241+range242+range243+range244+range245+range246+range247+range248+range249+range250+range251+range252+range253+range254+range255+range256+range257+range258+range259+range260+range261+range262+range263+range264+range265+range266+range267+range268+range269+range270+range271+range272+range273+range274+range275+range276+range277+range278+range279+range280+range281+range282+range283+range284+range285+range286+range287+range288+range289+range290+range291+range292+range293+range294+range295+range296+range297+range298+range299+range300+range301+range302+range303+range304+range305+range306+range307+range308+range309+range310+range311+range312+range313+range314+range315+range316+range317+range318+range319+range320+range321+range322+range323+range324+range325+range326+range327+range328+range329+range330+range331+range332+range333+range334+range335+range336+range337+range338+range339+range340+range341+range342+range343+range344+range345+range346+range347+range348+range349+range350+range351+range352+range353+range354+range355+range356+range357+range358+range359+range360+range361+range362+range363+range364+range365+range366;
							Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'AddrRecentEconTrajectory',dist1);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'AgeRiskIndicator',dist2);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'BankruptcyStatus',dist3);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'BankruptcyType',dist4);

// Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'BusinessTitle',dist5);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'CurrAddrDwellType',dist6);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'CurrAddrTaxYr',dist7);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'InputAddrDwellType',dist8);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'InputAddrSICCode',dist9);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'InputAddrTaxYr',dist10);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'InputAddrValidation',dist11);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'InputPhoneType',dist12);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'PrevAddrDwellType',dist13);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'PrevAddrTaxYr',dist14);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'SSNIssueState',dist15);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'StatusMostRecent',dist16);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'StatusNextPrevious',dist17);

Scoring_QA_New_Bins.test_LIv4_new_bins.Distinct_function(DS2,'StatusPrevious',dist18);

						
												
					dis:=  dist1+dist2+dist3+dist4+dist6+dist7+dist8+dist9+dist10+dist11+dist12+dist13+dist14+dist15+dist16+dist17+dist18;
					
				
					 Scoring_QA.Range_function_module.Distinct_function7(DS2,'did',did1);
	 
	 					
				 
	 did_stats:=did1;
								
      
			
			result2_stats:= ran + dis + did_stats ;
   				
      Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AccidentAge',ave1);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AccidentCount',ave2);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrChangeCount01',ave3);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrChangeCount03',ave4);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrChangeCount06',ave5);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrChangeCount12',ave6);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrChangeCount24',ave7);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrChangeCount60',ave8);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrMostRecentCrimeDiff',ave9);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrMostRecentDistance',ave10);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrMostRecentIncomeDiff',ave11);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrMostRecentMoveAge',ave12);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrMostRecentStateDiff',ave13);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrMostRecentTaxDiff',ave14);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrMostRecentValueDIff',ave15);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrRecentEconTrajectory',ave16);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrRecentEconTrajectoryIndex',ave17);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AddrStability',ave18);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AgeNewestRecord',ave19);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AgeOldestRecord',ave20);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AgeRiskIndicator',ave21);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AircraftCount',ave22);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AircraftCount01',ave23);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AircraftCount03',ave24);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AircraftCount06',ave25);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AircraftCount12',ave26);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AircraftCount24',ave27);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AircraftCount60',ave28);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AircraftOwner',ave29);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ArrestAge',ave30);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ArrestCount',ave31);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ArrestCount01',ave32);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ArrestCount03',ave33);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ArrestCount06',ave34);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ArrestCount12',ave35);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ArrestCount24',ave36);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ArrestCount60',ave37);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AssetOwner',ave38);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AssocCreditBureauOnlyCount',ave39);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AssocCreditBureauOnlyCountMonth',ave40);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AssocCreditBureauOnlyCountNew',ave41);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AssocHighRiskTopologyCount',ave42);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AssocRiskLevel',ave43);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'AssocSuspicousIdentitiesCount',ave44);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BankruptcyAge',ave45);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BankruptcyCount',ave46);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BankruptcyCount01',ave47);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BankruptcyCount03',ave48);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BankruptcyCount06',ave49);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BankruptcyCount12',ave50);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BankruptcyCount24',ave51);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BankruptcyCount60',ave52);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BankruptcyStatus',ave53);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BankruptcyType',ave54);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BusinessActiveAssociation',ave55);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BusinessAssociationAge',ave56);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BusinessInactiveAssociation',ave57);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BusinessInputAddrCount',ave58);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'BusinessTitle',ave59);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ComponentCharRiskLevel',ave60);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CorrelationRiskLevel',ave61);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CreditBureauRecord',ave62);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrAVMValue',ave63);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrAVMValue12',ave64);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrAVMValue60',ave65);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrActivePhoneList',ave66);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrAgeLastSale',ave67);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrAgeNewestRecord',ave68);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrAgeOldestRecord',ave69);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrApplicantOwned',ave70);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrBlockIndex',ave71);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrBurglaryIndex',ave72);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrCarTheftIndex',ave73);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrCorrectional',ave74);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrCountyIndex',ave75);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrCrimeIndex',ave76);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrDwellType',ave77);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrFamilyOwned',ave78);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrLastSalesPrice',ave79);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrLenOfRes',ave80);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrMedianIncome',ave81);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrMedianValue',ave82);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrMortgageType',ave83);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrMurderIndex',ave84);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrOccupantOwned',ave85);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrTaxMarketValue',ave86);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrTaxValue',ave87);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrTaxYr',ave88);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'CurrAddrTractIndex',ave89);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DerogAge',ave90);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DerogCount',ave91);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DerogRecentCount',ave92);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DerogSeverityIndex',ave93);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DivAddrIdentityCount',ave94);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DivAddrIdentityCountNew',ave95);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DivAddrIdentityMSourceCount',ave96);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DivAddrSSNCount',ave97);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DivAddrSSNCountNew',ave98);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DivAddrSSNMSourceCount',ave99);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DivAddrSuspIdentityCountNew',ave100);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DivRiskLevel',ave101);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DivSSNAddrMSourceCount',ave102);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DivSSNIdentityMSourceCount',ave103);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DivSSNIdentityMSourceUrelCount',ave104);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DivSSNLNameCountNew',ave105);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DivSearchAddrSuspIdentityCount',ave106);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'DoNotMail',ave107);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EducationAttendedCollege',ave108);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EducationFieldofStudyType',ave109);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EducationInstitutionPrivate',ave110);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EducationInstitutionRating',ave111);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EducationProgram2Yr',ave112);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EducationProgram4Yr',ave113);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EducationProgramGraduate',ave114);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EstimatedAnnualIncome',ave115);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EvictionAge',ave116);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EvictionCount',ave117);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EvictionCount01',ave118);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EvictionCount03',ave119);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EvictionCount06',ave120);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EvictionCount12',ave121);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EvictionCount24',ave122);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'EvictionCount60',ave123);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'FelonyAge',ave124);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'FelonyCount',ave125);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'FelonyCount01',ave126);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'FelonyCount03',ave127);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'FelonyCount06',ave128);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'FelonyCount12',ave129);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'FelonyCount24',ave130);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'FelonyCount60',ave131);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'HistoricalAddrCorrectional',ave132);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'IDVerAddressAssocCount',ave133);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'IDVerRiskLevel',ave134);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'IDVerSSNCreditBureauCount',ave135);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'IDVerSSNCreditBureauDelete',ave136);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'IdentityRiskLevel',ave137);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrAVMValue',ave138);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrAVMValue12',ave139);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrAVMValue60',ave140);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrActivePhoneList',ave141);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrAgeLastSale',ave142);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrAgeNewestRecord',ave143);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrAgeOldestRecord',ave144);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrApplicantOwned',ave145);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrBlockIndex',ave146);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrBurglaryIndex',ave147);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrBusinessCount',ave148);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrCarTheftIndex',ave149);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrCountyIndex',ave150);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrCrimeIndex',ave151);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrDelivery',ave152);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrDwellType',ave153);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrErrorCode',ave154);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrFamilyOwned',ave155);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrHighRisk',ave156);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrHistoricalMatch',ave157);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrLastSalesPrice',ave158);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrLenOfRes',ave159);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrMedianIncome',ave160);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrMedianValue',ave161);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrMobilityIndex',ave162);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrMortgageType',ave163);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrMultiFamilyCount',ave164);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrMurderIndex',ave165);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrNotPrimaryRes',ave166);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrOccupantOwned',ave167);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrPhoneCount',ave168);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrPhoneRecentCount',ave169);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrProblems',ave170);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrSICCode',ave171);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrSingleFamilyCount',ave172);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrTaxMarketValue',ave173);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrTaxValue',ave174);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrTaxYr',ave175);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrTractIndex',ave176);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrVacantPropCount',ave177);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAddrValidation',ave178);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputAreaCodeChange',ave179);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputPhoneHighRisk',ave180);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputPhoneMobile',ave181);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputPhoneProblems',ave182);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputPhoneServiceType',ave183);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'InputPhoneType',ave184);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LastNameChangeAge',ave185);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LastNameChangeCount01',ave186);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LastNameChangeCount03',ave187);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LastNameChangeCount06',ave188);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LastNameChangeCount12',ave189);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LastNameChangeCount24',ave190);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LastNameChangeCount60',ave191);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienCount',ave192);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienFiledAge',ave193);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienFiledCount',ave194);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienFiledCount01',ave195);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienFiledCount03',ave196);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienFiledCount06',ave197);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienFiledCount12',ave198);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienFiledCount24',ave199);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienFiledCount60',ave200);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienFiledTotal',ave201);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienReleasedAge',ave202);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienReleasedCount',ave203);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienReleasedCount01',ave204);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienReleasedCount03',ave205);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienReleasedCount06',ave206);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienReleasedCount12',ave207);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienReleasedCount24',ave208);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienReleasedCount60',ave209);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'LienReleasedTotal',ave210);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'NonDerogCount',ave211);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'NonDerogCount01',ave212);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'NonDerogCount03',ave213);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'NonDerogCount06',ave214);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'NonDerogCount12',ave215);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'NonDerogCount24',ave216);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'NonDerogCount60',ave217);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'OnlineDirectory',ave218);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchAddrIdentities',ave219);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchIdentityAddrs',ave220);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchIdentityPhones',ave221);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchIdentitySSNs',ave222);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchLocateCount',ave223);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchLocateCount01',ave224);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchLocateCount03',ave225);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchLocateCount06',ave226);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchLocateCount12',ave227);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchLocateCount24',ave228);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchOtherCount',ave229);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchOtherCount01',ave230);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchOtherCount03',ave231);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchOtherCount06',ave232);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchOtherCount12',ave233);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchOtherCount24',ave234);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchPersonalFinanceCount',ave235);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchPersonalFinanceCount01',ave236);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchPersonalFinanceCount03',ave237);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchPersonalFinanceCount06',ave238);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchPersonalFinanceCount12',ave239);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchPersonalFinanceCount24',ave240);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchPhoneIdentities',ave241);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PRSearchSSNIdentities',ave242);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PhoneEDAAgeNewestRecord',ave243);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PhoneEDAAgeOldestRecord',ave244);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PhoneIdentitiesCount',ave245);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PhoneIdentitiesRecentCount',ave246);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PhoneOther',ave247);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PhoneOtherAgeNewestRecord',ave248);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PhoneOtherAgeOldestRecord',ave249);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrAVMValue',ave250);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrAgeLastSale',ave251);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrAgeNewestRecord',ave252);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrAgeOldestRecord',ave253);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrApplicantOwned',ave254);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrBlockIndex',ave255);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrBurglaryIndex',ave256);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrCarTheftIndex',ave257);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrCorrectional',ave258);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrCountyIndex',ave259);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrCrimeIndex',ave260);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrDwellType',ave261);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrFamilyOwned',ave262);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrLastSalesPrice',ave263);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrLenOfRes',ave264);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrMedianIncome',ave265);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrMedianValue',ave266);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrMurderIndex',ave267);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrOccupantOwned',ave268);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrTaxMarketValue',ave269);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrTaxValue',ave270);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrTaxYr',ave271);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PrevAddrTractIndex',ave272);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ProfLicAge',ave273);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ProfLicCount',ave274);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ProfLicCount01',ave275);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ProfLicCount03',ave276);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ProfLicCount06',ave277);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ProfLicCount12',ave278);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ProfLicCount24',ave279);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ProfLicCount60',ave280);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ProfLicExpired',ave281);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ProfLicTypeCategory',ave282);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropAgeNewestPurchase',ave283);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropAgeNewestSale',ave284);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropAgeOldestPurchase',ave285);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropNewestSalePrice',ave286);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropNewestSalePurchaseIndex',ave287);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropOwnedCount',ave288);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropOwnedHistoricalCount',ave289);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropOwnedTaxTotal',ave290);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropPurchasedCount01',ave291);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropPurchasedCount03',ave292);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropPurchasedCount06',ave293);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropPurchasedCount12',ave294);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropPurchasedCount24',ave295);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropPurchasedCount60',ave296);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropSoldCount01',ave297);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropSoldCount03',ave298);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropSoldCount06',ave299);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropSoldCount12',ave300);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropSoldCount24',ave301);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropSoldCount60',ave302);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'PropertyOwner',ave303);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'RecentActivityIndex',ave304);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'RecentUpdate',ave305);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'RelativesBankruptcyCount',ave306);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'RelativesCount',ave307);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'RelativesDistanceClosest',ave308);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'RelativesFelonyCount',ave309);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'RelativesPropOwnedCount',ave310);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'RelativesPropOwnedTaxTotal',ave311);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SFDUAddrIdentitiesCount',ave312);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SFDUAddrSSNCount',ave313);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSN3Years',ave314);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNAddrCount',ave315);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNAddrRecentCount',ave316);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNAfter5',ave317);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNAgeDeceased',ave318);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNFoundOther',ave319);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNHighIssueAge',ave320);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNIdentitiesCount',ave321);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNIdentitiesRecentCount',ave322);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNIssueState',ave323);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNLastNameCount',ave324);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNLowIssueAge',ave325);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNNonUS',ave326);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNNotFound',ave327);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNProblems',ave328);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SSNRecent',ave329);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SearchAddrSearchCount',ave330);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SearchComponentRiskLevel',ave331);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SearchPhoneSearchCount',ave332);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SearchSSNSearchCount',ave333);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SearchUnverifiedAddrCountYear',ave334);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SearchUnverifiedDOBCountYear',ave335);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SearchUnverifiedPhoneCountYear',ave336);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SearchUnverifiedSSNCountYear',ave337);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SearchVelocityRiskLevel',ave338);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SourceOrderActivity',ave339);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SourceOrderAgeLastOrder',ave340);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SourceOrderSourceCount',ave341);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SourceRiskLevel',ave342);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SourceWatchList',ave343);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SrcsConfirmIDAddrCount',ave344);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'StatusMostRecent',ave345);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'StatusNextPrevious',ave346);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'StatusPrevious',ave347);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubPrimeOfferRequestCount',ave348);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubPrimeOfferRequestCount01',ave349);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubPrimeOfferRequestCount03',ave350);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubPrimeOfferRequestCount06',ave351);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubPrimeOfferRequestCount12',ave352);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubPrimeOfferRequestCount24',ave353);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubPrimeOfferRequestCount60',ave354);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubjectAddrCount',ave355);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubjectAddrRecentCount',ave356);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubjectLastNameCount',ave357);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubjectPhoneCount',ave358);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubjectPhoneRecentCount',ave359);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubjectSSNCount',ave360);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'SubjectSSNRecentCount',ave361);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'ValidationRiskLevel',ave362);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'VariationDOBCount',ave363);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'VariationDOBCountNew',ave364);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'VariationIdentityCount',ave365);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'VariationMSourcesSSNCount',ave366);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'VariationMSourcesSSNUnrelCount',ave367);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'VariationRiskLevel',ave368);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'VerificationFailure',ave369);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'VerifiedAddress',ave370);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'VerifiedDOB',ave371);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'VerifiedName',ave372);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'VerifiedPhone',ave373);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'VerifiedSSN',ave374);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'VoterRegistrationRecord',ave375);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'WatercraftCount',ave376);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'WatercraftCount01',ave377);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'WatercraftCount03',ave378);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'WatercraftCount06',ave379);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'WatercraftCount12',ave380);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'WatercraftCount24',ave381);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'WatercraftCount60',ave382);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'WatercraftOwner',ave383);

Scoring_QA_New_Bins.test_LIv4_new_bins.Average_func(DS2,'WealthIndex',ave384);

   
                   
					
	
      	   avearage:= ave1+ave2+ave3+ave4+ave5+ave6+ave7+ave8+ave9+ave10+ave11+ave12+ave13+ave14+ave15+ave16+ave17+ave18+ave19+ave20+ave21+ave22+ave23+ave24+ave25+ave26+ave27+ave28+ave29+ave30+ave31+ave32+ave33+ave34+ave35+ave36+ave37+ave38+ave39+ave40+ave41+ave42+ave43+ave44+ave45+ave46+ave47+ave48+ave49+ave50+ave51+ave52+ave53+ave54+ave55+ave56+ave57+ave58+ave59+ave60+ave61+ave62+ave63+ave64+ave65+ave66+ave67+ave68+ave69+ave70+ave71+ave72+ave73+ave74+ave75+ave76+ave77+ave78+ave79+ave80+ave81+ave82+ave83+ave84+ave85+ave86+ave87+ave88+ave89+ave90+ave91+ave92+ave93+ave94+ave95+ave96+ave97+ave98+ave99+ave100+ave101+ave102+ave103+ave104+ave105+ave106+ave107+ave108+ave109+ave110+ave111+ave112+ave113+ave114+ave115+ave116+ave117+ave118+ave119+ave120+ave121+ave122+ave123+ave124+ave125+ave126+ave127+ave128+ave129+ave130+ave131+ave132+ave133+ave134+ave135+ave136+ave137+ave138+ave139+ave140+ave141+ave142+ave143+ave144+ave145+ave146+ave147+ave148+ave149+ave150+ave151+ave152+ave153+ave154+ave155+ave156+ave157+ave158+ave159+ave160+ave161+ave162+ave163+ave164+ave165+ave166+ave167+ave168+ave169+ave170+ave171+ave172+ave173+ave174+ave175+ave176+ave177+ave178+ave179+ave180+ave181+ave182+ave183+ave184+ave185+ave186+ave187+ave188+ave189+ave190+ave191+ave192+ave193+ave194+ave195+ave196+ave197+ave198+ave199+ave200+ave201+ave202+ave203+ave204+ave205+ave206+ave207+ave208+ave209+ave210+ave211+ave212+ave213+ave214+ave215+ave216+ave217+ave218+ave219+ave220+ave221+ave222+ave223+ave224+ave225+ave226+ave227+ave228+ave229+ave230+ave231+ave232+ave233+ave234+ave235+ave236+ave237+ave238+ave239+ave240+ave241+ave242+ave243+ave244+ave245+ave246+ave247+ave248+ave249+ave250+ave251+ave252+ave253+ave254+ave255+ave256+ave257+ave258+ave259+ave260+ave261+ave262+ave263+ave264+ave265+ave266+ave267+ave268+ave269+ave270+ave271+ave272+ave273+ave274+ave275+ave276+ave277+ave278+ave279+ave280+ave281+ave282+ave283+ave284+ave285+ave286+ave287+ave288+ave289+ave290+ave291+ave292+ave293+ave294+ave295+ave296+ave297+ave298+ave299+ave300+ave301+ave302+ave303+ave304+ave305+ave306+ave307+ave308+ave309+ave310+ave311+ave312+ave313+ave314+ave315+ave316+ave317+ave318+ave319+ave320+ave321+ave322+ave323+ave324+ave325+ave326+ave327+ave328+ave329+ave330+ave331+ave332+ave333+ave334+ave335+ave336+ave337+ave338+ave339+ave340+ave341+ave342+ave343+ave344+ave345+ave346+ave347+ave348+ave349+ave350+ave351+ave352+ave353+ave354+ave355+ave356+ave357+ave358+ave359+ave360+ave361+ave362+ave363+ave364+ave365+ave366+ave367+ave368+ave369+ave370+ave371+ave372+ave373+ave374+ave375+ave376+ave377+ave378+ave379+ave380+ave381+ave382+ave383+ave384;

											 
						
	 
   result4_stats:=avearage  ;
	 
	
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
                                         self.file_version:='leadintegrity_generic_v4';
																				 self.mode:='xml';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='leadintegrity_generic_v4';
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

		  did_results := DATASET([{'leadintegrity_generic_v4','xml','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
											
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.LI_Attributes_V4_XML_Generic_msn1106_0_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.LI_Attributes_V4_XML_Generic_msn1106_0_outfile[2..] + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.LI_Attributes_V4_XML_Generic_msn1106_0_outfile[2..] + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2);

return seq;

endmacro;


