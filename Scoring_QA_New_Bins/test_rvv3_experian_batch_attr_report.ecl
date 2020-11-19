EXPORT test_rvv3_experian_batch_attr_report(route,current_dt,previous_dt) := functionmacro


file1_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_Experian_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Experian_Attributes_V3_Global_Layout,

thor),(integer)accountnumber);
file2_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_Experian_outfile + current_dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Experian_Attributes_V3_Global_Layout,

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
	 


Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_1(DS2,'addrchanges12',range1);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_2(DS2,'addrchanges180',range2);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_3(DS2,'addrchanges24',range3);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_4(DS2,'addrchanges30',range4);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_5(DS2,'addrchanges36',range5);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_6(DS2,'addrchanges60',range6);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_7(DS2,'addrchanges90',range7);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_8(DS2,'addrhighrisk',range8);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_84(DS2,'addrprison',range9);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_10(DS2,'agenewestrecord',range10);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_11(DS2,'ageoldestrecord',range11);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_12(DS2,'assesseddiff',range12);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_13(DS2,'assesseddiff2',range13);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_14(DS2,'bankruptcy_count',range14);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_15(DS2,'bankruptcy_count12',range15);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_16(DS2,'bankruptcy_count180',range16);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_17(DS2,'bankruptcy_count24',range17);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_18(DS2,'bankruptcy_count30',range18);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_19(DS2,'bankruptcy_count36',range19);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_20(DS2,'bankruptcy_count60',range20);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_21(DS2,'bankruptcy_count90',range21);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_22(DS2,'bankruptcyage',range22);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_23(DS2,'bestreportedage',range23);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_24(DS2,'caagelastsale',range24);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_25(DS2,'caagenewestrecord',range25);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_26(DS2,'caageoldestrecord',range26);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_27(DS2,'caassessedvalue',range27);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_28(DS2,'cafamilyowned',range28);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_29(DS2,'calandusecode',range29);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_30(DS2,'calastsaleamount',range30);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_31(DS2,'calenofres',range31);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_33(DS2,'canotprimaryres',range32);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_33(DS2,'caoccupantowned',range33);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_34(DS2,'caownedbysubject',range34);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_35(DS2,'caphonelisted',range35);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_36(DS2,'correctedflag',range36);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_37(DS2,'curraddravmconfidence',range37);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_38(DS2,'curraddravmhedonic',range38);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_39(DS2,'curraddravmsalesprice',range39);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_40(DS2,'curraddravmtax',range40);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_41(DS2,'curraddravmvalue',range41);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_42(DS2,'curraddrblockindex',range42);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_43(DS2,'curraddrcountyindex',range43);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_44(DS2,'curraddrtaxmarketvalue',range44);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_45(DS2,'curraddrtractindex',range45);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_46(DS2,'derogage',range46);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_47(DS2,'diffstate',range47);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_48(DS2,'diffstate2',range48);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_49(DS2,'distcurrprev',range49);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_50(DS2,'distinputcurr',range50);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_51(DS2,'educationattendedcollege',range51);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_52(DS2,'educationinstitutionprivate',range52);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_53(DS2,'educationinstitutionrating',range53);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_54(DS2,'educationprogram2yr',range54);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_55(DS2,'educationprogram4yr',range55);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_55(DS2,'educationprogramgraduate',range56);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_57(DS2,'eviction_count',range57);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_58(DS2,'eviction_count12',range58);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_59(DS2,'eviction_count180',range59);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_60(DS2,'eviction_count24',range60);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_61(DS2,'eviction_count30',range61);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_62(DS2,'eviction_count36',range62);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_63(DS2,'eviction_count60',range63);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_64(DS2,'eviction_count90',range64);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_65(DS2,'evictionage',range65);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_66(DS2,'felonies',range66);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_67(DS2,'felonies12',range67);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_68(DS2,'felonies180',range68);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_69(DS2,'felonies24',range69);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_73(DS2,'felonies30',range70);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_71(DS2,'felonies36',range71);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_72(DS2,'felonies60',range72);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_73(DS2,'felonies90',range73);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_74(DS2,'felonyage',range74);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_75(DS2,'iaagelastsale',range75);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_76(DS2,'iaagenewestrecord',range76);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_77(DS2,'iaageoldestrecord',range77);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_78(DS2,'iaassessedvalue',range78);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_79(DS2,'iafamilyowned',range79);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_80(DS2,'ialandusecode',range80);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_81(DS2,'ialastsaleamount',range81);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_82(DS2,'ialenofres',range82);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_83(DS2,'ianotprimaryres',range83);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_84(DS2,'iaoccupantowned',range84);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_85(DS2,'iaownedbysubject',range85);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_86(DS2,'iaphonelisted',range86);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_84(DS2,'idtheftflag',range87);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_88(DS2,'inferredminimumage',range88);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_89(DS2,'inputaddravmconfidence',range89);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_90(DS2,'inputaddravmhedonic',range90);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_91(DS2,'inputaddravmsalesprice',range91);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_92(DS2,'inputaddravmtax',range92);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_93(DS2,'inputaddravmvalue',range93);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_94(DS2,'inputaddrblockindex',range94);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_95(DS2,'inputaddrcountyindex',range95);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_96(DS2,'inputaddridentitiescount',range96);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_97(DS2,'inputaddridentitiesrecentcount',range97);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_98(DS2,'inputaddrphonecount',range98);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_99(DS2,'inputaddrphonerecentcount',range99);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_100(DS2,'inputaddrssncount',range100);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_101(DS2,'inputaddrssnrecentcount',range101);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_102(DS2,'inputaddrtaxmarketvalue',range102);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_103(DS2,'inputaddrtractindex',range103);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_104(DS2,'inputcurrmatch',range104);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_105(DS2,'inputprevmatch',range105);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_106(DS2,'invalidaddr',range106);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_107(DS2,'invalidphone',range107);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_108(DS2,'invalidssn',range108);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_109(DS2,'isnover',range109);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_110(DS2,'isrecentupdate',range110);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_110(DS2,'issued3',range111);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_112(DS2,'issuedage5',range112);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_113(DS2,'lienfederaltaxfiledcount',range113);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_114(DS2,'lienfederaltaxfiledtotal',range114);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_115(DS2,'lienfederaltaxreleasedcount',range115);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_116(DS2,'lienfederaltaxreleasedtotal',range116);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_117(DS2,'lienfiledage',range117);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_118(DS2,'lienforeclosurefiledcount',range118);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_119(DS2,'lienforeclosurefiledtotal',range119);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_118(DS2,'lienforeclosurereleasedcount',range120);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_121(DS2,'lienforeclosurereleasedtotal',range121);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_122(DS2,'lienjudgmentfiledcount',range122);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_123(DS2,'lienjudgmentfiledtotal',range123);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_124(DS2,'lienjudgmentreleasedcount',range124);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_125(DS2,'lienjudgmentreleasedtotal',range125);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_126(DS2,'lienlandlordtenantfiledcount',range126);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_127(DS2,'lienlandlordtenantfiledtotal',range127);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_128(DS2,'lienlandlordtenantreleasedcount',range128);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_129(DS2,'lienlandlordtenantreleasedtotal',range129);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_130(DS2,'lienotherfiledcount',range130);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_131(DS2,'lienotherfiledtotal',range131);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_132(DS2,'lienotherreleasedcount',range132);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_133(DS2,'lienotherreleasedtotal',range133);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_118(DS2,'lienpreforeclosurefiledcount',range134);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_135(DS2,'lienpreforeclosurefiledtotal',range135);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_118(DS2,'lienpreforeclosurereleasedcount',range136);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_137(DS2,'lienpreforeclosurereleasedtotal',range137);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_138(DS2,'lienreleasedage',range138);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_139(DS2,'liensmallclaimsfiledcount',range139);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_140(DS2,'liensmallclaimsfiledtotal',range140);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_141(DS2,'liensmallclaimsreleasedcount',range141);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_142(DS2,'liensmallclaimsreleasedtotal',range142);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_143(DS2,'lientaxotherfiledcount',range143);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_144(DS2,'lientaxotherfiledtotal',range144);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_145(DS2,'lientaxotherreleasedcount',range145);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_146(DS2,'lientaxotherreleasedtotal',range146);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_147(DS2,'mobility_indicator',range147);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_148(DS2,'nonus',range148);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_149(DS2,'num_liens',range149);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_150(DS2,'num_nonderogs',range150);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_151(DS2,'num_nonderogs12',range151);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_152(DS2,'num_nonderogs180',range152);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_153(DS2,'num_nonderogs24',range153);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_154(DS2,'num_nonderogs30',range154);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_155(DS2,'num_nonderogs36',range155);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_156(DS2,'num_nonderogs60',range156);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_157(DS2,'num_nonderogs90',range157);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_158(DS2,'num_proflic',range158);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_159(DS2,'num_proflic12',range159);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_160(DS2,'num_proflic180',range160);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_161(DS2,'num_proflic24',range161);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_162(DS2,'num_proflic30',range162);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_163(DS2,'num_proflic36',range163);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_164(DS2,'num_proflic60',range164);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_165(DS2,'num_proflic90',range165);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_166(DS2,'num_proflic_exp12',range166);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_167(DS2,'num_proflic_exp180',range167);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_168(DS2,'num_proflic_exp24',range168);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_169(DS2,'num_proflic_exp30',range169);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_170(DS2,'num_proflic_exp36',range170);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_171(DS2,'num_proflic_exp60',range171);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_172(DS2,'num_proflic_exp90',range172);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_173(DS2,'num_released_liens',range173);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_174(DS2,'num_released_liens12',range174);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_175(DS2,'num_released_liens180',range175);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_176(DS2,'num_released_liens24',range176);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_177(DS2,'num_released_liens30',range177);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_178(DS2,'num_released_liens36',range178);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_179(DS2,'num_released_liens60',range179);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_180(DS2,'num_released_liens90',range180);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_181(DS2,'num_unreleased_liens',range181);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_182(DS2,'num_unreleased_liens12',range182);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_183(DS2,'num_unreleased_liens180',range183);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_184(DS2,'num_unreleased_liens24',range184);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_185(DS2,'num_unreleased_liens30',range185);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_186(DS2,'num_unreleased_liens36',range186);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_187(DS2,'num_unreleased_liens60',range187);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_188(DS2,'num_unreleased_liens90',range188);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_189(DS2,'numaircraft',range189);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_190(DS2,'numaircraft12',range190);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_191(DS2,'numaircraft180',range191);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_192(DS2,'numaircraft24',range192);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_194(DS2,'numaircraft30',range193);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_194(DS2,'numaircraft36',range194);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_195(DS2,'numaircraft60',range195);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_196(DS2,'numaircraft90',range196);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_197(DS2,'numpurchase12',range197);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_198(DS2,'numpurchase180',range198);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_199(DS2,'numpurchase24',range199);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_200(DS2,'numpurchase30',range200);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_201(DS2,'numpurchase36',range201);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_202(DS2,'numpurchase60',range202);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_203(DS2,'numpurchase90',range203);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_204(DS2,'numsold12',range204);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_205(DS2,'numsold180',range205);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_206(DS2,'numsold24',range206);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_207(DS2,'numsold30',range207);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_208(DS2,'numsold36',range208);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_209(DS2,'numsold60',range209);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_210(DS2,'numsold90',range210);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_211(DS2,'numsources',range211);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_212(DS2,'numwatercraft',range212);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_213(DS2,'numwatercraft12',range213);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_214(DS2,'numwatercraft180',range214);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_215(DS2,'numwatercraft24',range215);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_219(DS2,'numwatercraft30',range216);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_217(DS2,'numwatercraft36',range217);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_218(DS2,'numwatercraft60',range218);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_219(DS2,'numwatercraft90',range219);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_220(DS2,'paagelastsale',range220);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_221(DS2,'paagenewestrecord',range221);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_222(DS2,'paageoldestrecord',range222);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_223(DS2,'paassessedvalue',range223);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_224(DS2,'pafamilyowned',range224);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_225(DS2,'palandusecode',range225);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_226(DS2,'palastsaleamount',range226);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_227(DS2,'palenofres',range227);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_228(DS2,'paoccupantowned',range228);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_229(DS2,'paownedbysubject',range229);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_230(DS2,'paphonelisted',range230);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_231(DS2,'phoneaddrdist',range231);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_232(DS2,'phoneedaagenewestrecord',range232);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_233(DS2,'phoneedaageoldestrecord',range233);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_234(DS2,'phonehighrisk',range234);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_235(DS2,'phoneidentitiescount',range235);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_236(DS2,'phoneidentitiesrecentcount',range236);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_237(DS2,'phonemobile',range237);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_238(DS2,'phoneotheragenewestrecord',range238);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_239(DS2,'phoneotherageoldestrecord',range239);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_240(DS2,'phonepager',range240);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_241(DS2,'phonezipmismatch',range241);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_242(DS2,'predictedannualincome',range242);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_243(DS2,'prevaddravmconfidence',range243);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_244(DS2,'prevaddravmhedonic',range244);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_245(DS2,'prevaddravmsalesprice',range245);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_246(DS2,'prevaddravmtax',range246);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_247(DS2,'prevaddravmvalue',range247);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_248(DS2,'prevaddrblockindex',range248);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_249(DS2,'prevaddrcountyindex',range249);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_250(DS2,'prevaddrtaxmarketvalue',range250);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_251(DS2,'prevaddrtractindex',range251);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_252(DS2,'proflicage',range252);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_253(DS2,'proflictypecategory',range253);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_254(DS2,'propagenewestpurchase',range254);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_255(DS2,'propagenewestsale',range255);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_256(DS2,'propageoldestpurchase',range256);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_257(DS2,'property_historically_owned',range257);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_258(DS2,'property_owned_assessed_total',range258);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_259(DS2,'property_owned_total',range259);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_260(DS2,'propnewestsaleprice',range260);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_261(DS2,'propnewestsalepurchaseindex',range261);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_271(DS2,'recentissue',range262);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_110(DS2,'securityalert',range263);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_110(DS2,'securityfreeze',range264);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_265(DS2,'ssnaddrcount',range265);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_266(DS2,'ssnaddrrecentcount',range266);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_267(DS2,'ssndeceased',range267);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_268(DS2,'ssnidentitiescount',range268);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_269(DS2,'ssnidentitiesrecentcount',range269);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_270(DS2,'ssnissuedpriordob',range270);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_271(DS2,'ssnnotfound',range271);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_272(DS2,'ssnvalid',range272);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_273(DS2,'subjectaddrcount',range273);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_274(DS2,'subjectaddrrecentcount',range274);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_275(DS2,'subjectphonecount',range275);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_276(DS2,'subjectphonerecentcount',range276);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_277(DS2,'subjectssncount',range277);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_278(DS2,'subjectssnrecentcount',range278);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_279(DS2,'subprimesolicitedcount',range279);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_280(DS2,'subprimesolicitedcount01',range280);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_281(DS2,'subprimesolicitedcount03',range281);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_282(DS2,'subprimesolicitedcount06',range282);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_283(DS2,'subprimesolicitedcount12',range283);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_284(DS2,'subprimesolicitedcount24',range284);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_285(DS2,'subprimesolicitedcount36',range285);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_286(DS2,'subprimesolicitedcount60',range286);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_287(DS2,'total_number_derogs',range287);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_288(DS2,'verifiedaddress',range288);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_289(DS2,'verifieddob',range289);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_290(DS2,'verifiedname',range290);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_291(DS2,'verifiedphone',range291);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_292(DS2,'verifiedphonefullname',range292);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_293(DS2,'verifiedphonelastname',range293);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_294(DS2,'verifiedssn',range294);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_295(DS2,'wealth_indicator',range295);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_296(DS2,'zipcorpmil',range296);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.range_function_297(DS2,'zippobox',range297);


      	
      	
      	ran:= range1+range2+range3+range4+range5+range6+range7+range8+range9+range10+range11+range12+range13+range14+range15+range16+range17+range18+range19+range20+range21+range22+range23+range24+range25+range26+range27+range28+range29+range30+range31+range32+range33+range34+range35+range36+range37+range38+range39+range40+range41+range42+range43+range44+range45+range46+range47+range48+range49+range50+range51+range52+range53+range54+range55+range56+range57+range58+range59+range60+range61+range62+range63+range64+range65+range66+range67+range68+range69+range70+range71+range72+range73+range74+range75+range76+range77+range78+range79+range80+range81+range82+range83+range84+range85+range86+range87+range88+range89+range90+range91+range92+range93+range94+range95+range96+range97+range98+range99+range100+range101+range102+range103+range104+range105+range106+range107+range108+range109+range110+range111+range112+range113+range114+range115+range116+range117+range118+range119+range120+range121+range122+range123+range124+range125+range126+range127+range128+range129+range130+range131+range132+range133+range134+range135+range136+range137+range138+range139+range140+range141+range142+range143+range144+range145+range146+range147+range148+range149+range150+range151+range152+range153+range154+range155+range156+range157+range158+range159+range160+range161+range162+range163+range164+range165+range166+range167+range168+range169+range170+range171+range172+range173+range174+range175+range176+range177+range178+range179+range180+range181+range182+range183+range184+range185+range186+range187+range188+range189+range190+range191+range192+range193+range194+range195+range196+range197+range198+range199+range200+range201+range202+range203+range204+range205+range206+range207+range208+range209+range210+range211+range212+range213+range214+range215+range216+range217+range218+range219+range220+range221+range222+range223+range224+range225+range226+range227+range228+range229+range230+range231+range232+range233+range234+range235+range236+range237+range238+range239+range240+range241+range242+range243+range244+range245+range246+range247+range248+range249+range250+range251+range252+range253+range254+range255+range256+range257+range258+range259+range260+range261+range262+range263+range264+range265+range266+range267+range268+range269+range270+range271+range272+range273+range274+range275+range276+range277+range278+range279+range280+range281+range282+range283+range284+range285+range286+range287+range288+range289+range290+range291+range292+range293+range294+range295+range296+range297;
				
				

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'cadwelltype',dist1);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'curraddrtaxyr',dist2);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'ecotrajectory',dist3);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'ecotrajectory2',dist4);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'filing_type',dist5);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'iadwelltype',dist6);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'inputaddrtaxyr',dist7);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'issuestate',dist8);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'padwelltype',dist9);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'phonestatus',dist10);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'prevaddrtaxyr',dist11);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'statusaddr',dist12);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'statusaddr2',dist13);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function(DS2,'statusaddr3',dist14);
				 
			Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function2(DS2,'disposition',dist15);
Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function2(DS2,'caphonenumber',dist16);
Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function2(DS2,'iaphonenumber',dist17);
Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function2(DS2,'paphonenumber',dist18);
Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function2(DS2,'expire_date_last_proflic',dist19);
Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function2(DS2,'proflic_type',dist20);
Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function2(DS2,'deceaseddate',dist21);
Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function2(DS2,'highissuedate',dist22);
Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Distinct_function2(DS2,'lowissuedate',dist23);
				 
							
											 
											 
				
					dis:= dist1+dist2+dist3+dist4+dist5+dist6+dist7+dist8+dist9+dist10+dist11+dist12+dist13+dist14+ dist15+dist16+dist17+dist18+dist19+dist20+dist21+dist22+dist23;

					 Scoring_QA.Range_function_module.Distinct_function7(DS2,'did',did1);

	 
	 
	 did_stats:=did1;
				
			result2_stats:= ran + dis +did_stats;
   				
Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'addrchanges12',ave1);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'addrchanges180',ave2);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'addrchanges24',ave3);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'addrchanges30',ave4);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'addrchanges36',ave5);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'addrchanges60',ave6);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'addrchanges90',ave7);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'addrhighrisk',ave8);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'addrprison',ave9);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'agenewestrecord',ave10);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ageoldestrecord',ave11);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'assesseddiff',ave12);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'assesseddiff2',ave13);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'bankruptcy_count',ave14);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'bankruptcy_count12',ave15);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'bankruptcy_count180',ave16);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'bankruptcy_count24',ave17);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'bankruptcy_count30',ave18);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'bankruptcy_count36',ave19);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'bankruptcy_count60',ave20);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'bankruptcy_count90',ave21);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'bankruptcyage',ave22);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'bestreportedage',ave23);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'caagelastsale',ave24);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'caagenewestrecord',ave25);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'caageoldestrecord',ave26);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'caassessedvalue',ave27);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'cadwelltype',ave28);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'cafamilyowned',ave29);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'calandusecode',ave30);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'calastsaleamount',ave31);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'calenofres',ave32);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'canotprimaryres',ave33);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'caoccupantowned',ave34);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'caownedbysubject',ave35);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'caphonelisted',ave36);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'correctedflag',ave37);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'curraddravmconfidence',ave38);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'curraddravmhedonic',ave39);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'curraddravmsalesprice',ave40);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'curraddravmtax',ave41);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'curraddravmvalue',ave42);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'curraddrblockindex',ave43);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'curraddrcountyindex',ave44);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'curraddrtaxmarketvalue',ave45);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'curraddrtaxyr',ave46);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'curraddrtractindex',ave47);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'derogage',ave48);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'diffstate',ave49);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'diffstate2',ave50);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'distcurrprev',ave51);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'distinputcurr',ave52);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ecotrajectory',ave53);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ecotrajectory2',ave54);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'educationattendedcollege',ave55);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'educationinstitutionprivate',ave56);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'educationinstitutionrating',ave57);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'educationprogram2yr',ave58);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'educationprogram4yr',ave59);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'educationprogramgraduate',ave60);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'eviction_count',ave61);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'eviction_count12',ave62);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'eviction_count180',ave63);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'eviction_count24',ave64);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'eviction_count30',ave65);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'eviction_count36',ave66);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'eviction_count60',ave67);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'eviction_count90',ave68);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'evictionage',ave69);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'felonies',ave70);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'felonies12',ave71);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'felonies180',ave72);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'felonies24',ave73);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'felonies30',ave74);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'felonies36',ave75);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'felonies60',ave76);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'felonies90',ave77);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'felonyage',ave78);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'filing_type',ave79);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'iaagelastsale',ave80);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'iaagenewestrecord',ave81);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'iaageoldestrecord',ave82);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'iaassessedvalue',ave83);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'iadwelltype',ave84);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'iafamilyowned',ave85);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ialandusecode',ave86);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ialastsaleamount',ave87);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ialenofres',ave88);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ianotprimaryres',ave89);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'iaoccupantowned',ave90);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'iaownedbysubject',ave91);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'iaphonelisted',ave92);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'idtheftflag',ave93);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inferredminimumage',ave94);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddravmconfidence',ave95);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddravmhedonic',ave96);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddravmsalesprice',ave97);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddravmtax',ave98);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddravmvalue',ave99);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddrblockindex',ave100);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddrcountyindex',ave101);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddridentitiescount',ave102);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddridentitiesrecentcount',ave103);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddrphonecount',ave104);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddrphonerecentcount',ave105);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddrssncount',ave106);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddrssnrecentcount',ave107);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddrtaxmarketvalue',ave108);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddrtaxyr',ave109);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputaddrtractindex',ave110);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputcurrmatch',ave111);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'inputprevmatch',ave112);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'invalidaddr',ave113);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'invalidphone',ave114);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'invalidssn',ave115);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'isnover',ave116);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'isrecentupdate',ave117);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'issued3',ave118);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'issuedage5',ave119);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'issuestate',ave120);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienfederaltaxfiledcount',ave121);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienfederaltaxfiledtotal',ave122);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienfederaltaxreleasedcount',ave123);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienfederaltaxreleasedtotal',ave124);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienfiledage',ave125);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienforeclosurefiledcount',ave126);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienforeclosurefiledtotal',ave127);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienforeclosurereleasedcount',ave128);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienforeclosurereleasedtotal',ave129);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienjudgmentfiledcount',ave130);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienjudgmentfiledtotal',ave131);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienjudgmentreleasedcount',ave132);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienjudgmentreleasedtotal',ave133);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienlandlordtenantfiledcount',ave134);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienlandlordtenantfiledtotal',ave135);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienlandlordtenantreleasedcount',ave136);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienlandlordtenantreleasedtotal',ave137);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienotherfiledcount',ave138);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienotherfiledtotal',ave139);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienotherreleasedcount',ave140);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienotherreleasedtotal',ave141);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienpreforeclosurefiledcount',ave142);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienpreforeclosurefiledtotal',ave143);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienpreforeclosurereleasedcount',ave144);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienpreforeclosurereleasedtotal',ave145);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lienreleasedage',ave146);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'liensmallclaimsfiledcount',ave147);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'liensmallclaimsfiledtotal',ave148);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'liensmallclaimsreleasedcount',ave149);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'liensmallclaimsreleasedtotal',ave150);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lientaxotherfiledcount',ave151);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lientaxotherfiledtotal',ave152);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lientaxotherreleasedcount',ave153);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'lientaxotherreleasedtotal',ave154);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'mobility_indicator',ave155);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'nonus',ave156);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_liens',ave157);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_nonderogs',ave158);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_nonderogs12',ave159);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_nonderogs180',ave160);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_nonderogs24',ave161);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_nonderogs30',ave162);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_nonderogs36',ave163);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_nonderogs60',ave164);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_nonderogs90',ave165);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic',ave166);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic12',ave167);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic180',ave168);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic24',ave169);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic30',ave170);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic36',ave171);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic60',ave172);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic90',ave173);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic_exp12',ave174);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic_exp180',ave175);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic_exp24',ave176);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic_exp30',ave177);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic_exp36',ave178);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic_exp60',ave179);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_proflic_exp90',ave180);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_released_liens',ave181);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_released_liens12',ave182);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_released_liens180',ave183);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_released_liens24',ave184);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_released_liens30',ave185);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_released_liens36',ave186);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_released_liens60',ave187);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_released_liens90',ave188);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_unreleased_liens',ave189);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_unreleased_liens12',ave190);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_unreleased_liens180',ave191);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_unreleased_liens24',ave192);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_unreleased_liens30',ave193);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_unreleased_liens36',ave194);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_unreleased_liens60',ave195);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'num_unreleased_liens90',ave196);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numaircraft',ave197);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numaircraft12',ave198);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numaircraft180',ave199);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numaircraft24',ave200);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numaircraft30',ave201);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numaircraft36',ave202);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numaircraft60',ave203);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numaircraft90',ave204);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numpurchase12',ave205);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numpurchase180',ave206);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numpurchase24',ave207);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numpurchase30',ave208);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numpurchase36',ave209);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numpurchase60',ave210);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numpurchase90',ave211);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numsold12',ave212);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numsold180',ave213);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numsold24',ave214);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numsold30',ave215);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numsold36',ave216);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numsold60',ave217);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numsold90',ave218);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numsources',ave219);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numwatercraft',ave220);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numwatercraft12',ave221);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numwatercraft180',ave222);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numwatercraft24',ave223);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numwatercraft30',ave224);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numwatercraft36',ave225);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numwatercraft60',ave226);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'numwatercraft90',ave227);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'paagelastsale',ave228);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'paagenewestrecord',ave229);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'paageoldestrecord',ave230);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'paassessedvalue',ave231);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'padwelltype',ave232);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'pafamilyowned',ave233);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'palandusecode',ave234);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'palastsaleamount',ave235);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'palenofres',ave236);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'paoccupantowned',ave237);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'paownedbysubject',ave238);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'paphonelisted',ave239);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'phoneaddrdist',ave240);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'phoneedaagenewestrecord',ave241);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'phoneedaageoldestrecord',ave242);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'phonehighrisk',ave243);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'phoneidentitiescount',ave244);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'phoneidentitiesrecentcount',ave245);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'phonemobile',ave246);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'phoneotheragenewestrecord',ave247);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'phoneotherageoldestrecord',ave248);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'phonepager',ave249);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'phonestatus',ave250);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'phonezipmismatch',ave251);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'predictedannualincome',ave252);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'prevaddravmconfidence',ave253);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'prevaddravmhedonic',ave254);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'prevaddravmsalesprice',ave255);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'prevaddravmtax',ave256);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'prevaddravmvalue',ave257);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'prevaddrblockindex',ave258);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'prevaddrcountyindex',ave259);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'prevaddrtaxmarketvalue',ave260);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'prevaddrtaxyr',ave261);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'prevaddrtractindex',ave262);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'proflicage',ave263);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'proflictypecategory',ave264);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'propagenewestpurchase',ave265);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'propagenewestsale',ave266);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'propageoldestpurchase',ave267);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'property_historically_owned',ave268);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'property_owned_assessed_total',ave269);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'property_owned_total',ave270);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'propnewestsaleprice',ave271);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'propnewestsalepurchaseindex',ave272);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'recentissue',ave273);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'securityalert',ave274);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'securityfreeze',ave275);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ssnaddrcount',ave276);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ssnaddrrecentcount',ave277);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ssndeceased',ave278);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ssnidentitiescount',ave279);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ssnidentitiesrecentcount',ave280);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ssnissuedpriordob',ave281);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ssnnotfound',ave282);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'ssnvalid',ave283);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'statusaddr',ave284);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'statusaddr2',ave285);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'statusaddr3',ave286);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subjectaddrcount',ave287);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subjectaddrrecentcount',ave288);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subjectphonecount',ave289);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subjectphonerecentcount',ave290);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subjectssncount',ave291);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subjectssnrecentcount',ave292);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subprimesolicitedcount',ave293);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subprimesolicitedcount01',ave294);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subprimesolicitedcount03',ave295);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subprimesolicitedcount06',ave296);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subprimesolicitedcount12',ave297);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subprimesolicitedcount24',ave298);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subprimesolicitedcount36',ave299);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'subprimesolicitedcount60',ave300);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'total_number_derogs',ave301);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'verifiedaddress',ave302);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'verifieddob',ave303);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'verifiedname',ave304);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'verifiedphone',ave305);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'verifiedphonefullname',ave306);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'verifiedphonelastname',ave307);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'verifiedssn',ave308);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'wealth_indicator',ave309);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'zipcorpmil',ave310);

Scoring_QA_New_Bins.test_rvv3_experian_new_bins.Average_func(DS2,'zippobox',ave311);


    
								 
      	   avearage:= ave1+ave2+ave3+ave4+ave5+ave6+ave7+ave8+ave9+ave10+ave11+ave12+ave13+ave14+ave15+ave16+ave17+ave18+ave19+ave20+ave21+ave22+ave23+ave24+ave25+ave26+ave27+ave28+ave29+ave30+ave31+ave32+ave33+ave34+ave35+ave36+ave37+ave38+ave39+ave40+ave41+ave42+ave43+ave44+ave45+ave46+ave47+ave48+ave49+ave50+ave51+ave52+ave53+ave54+ave55+ave56+ave57+ave58+ave59+ave60+ave61+ave62+ave63+ave64+ave65+ave66+ave67+ave68+ave69+ave70+ave71+ave72+ave73+ave74+ave75+ave76+ave77+ave78+ave79+ave80+ave81+ave82+ave83+ave84+ave85+ave86+ave87+ave88+ave89+ave90+ave91+ave92+ave93+ave94+ave95+ave96+ave97+ave98+ave99+ave100+ave101+ave102+ave103+ave104+ave105+ave106+ave107+ave108+ave109+ave110+ave111+ave112+ave113+ave114+ave115+ave116+ave117+ave118+ave119+ave120+ave121+ave122+ave123+ave124+ave125+ave126+ave127+ave128+ave129+ave130+ave131+ave132+ave133+ave134+ave135+ave136+ave137+ave138+ave139+ave140+ave141+ave142+ave143+ave144+ave145+ave146+ave147+ave148+ave149+ave150+ave151+ave152+ave153+ave154+ave155+ave156+ave157+ave158+ave159+ave160+ave161+ave162+ave163+ave164+ave165+ave166+ave167+ave168+ave169+ave170+ave171+ave172+ave173+ave174+ave175+ave176+ave177+ave178+ave179+ave180+ave181+ave182+ave183+ave184+ave185+ave186+ave187+ave188+ave189+ave190+ave191+ave192+ave193+ave194+ave195+ave196+ave197+ave198+ave199+ave200+ave201+ave202+ave203+ave204+ave205+ave206+ave207+ave208+ave209+ave210+ave211+ave212+ave213+ave214+ave215+ave216+ave217+ave218+ave219+ave220+ave221+ave222+ave223+ave224+ave225+ave226+ave227+ave228+ave229+ave230+ave231+ave232+ave233+ave234+ave235+ave236+ave237+ave238+ave239+ave240+ave241+ave242+ave243+ave244+ave245+ave246+ave247+ave248+ave249+ave250+ave251+ave252+ave253+ave254+ave255+ave256+ave257+ave258+ave259+ave260+ave261+ave262+ave263+ave264+ave265+ave266+ave267+ave268+ave269+ave270+ave271+ave272+ave273+ave274+ave275+ave276+ave277+ave278+ave279+ave280+ave281+ave282+ave283+ave284+ave285+ave286+ave287+ave288+ave289+ave290+ave291+ave292+ave293+ave294+ave295+ave296+ave297+ave298+ave299+ave300+ave301+ave302+ave303+ave304+ave305+ave306+ave307+ave308+ave309+ave310+ave311;
				
								 			 
	
	

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
                                         self.file_version:='RiskView_Experian_attributes_v3';
																				 self.mode:='batch';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='RiskView_Experian_attributes_v3';
																				 self.mode:='batch';
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

		  did_results := DATASET([{'RiskView_Experian_attributes_v3','batch','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
											
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_Experian_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_Experian_outfile[2..] + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_Experian_outfile[2..] + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2);

return seq;

endmacro;