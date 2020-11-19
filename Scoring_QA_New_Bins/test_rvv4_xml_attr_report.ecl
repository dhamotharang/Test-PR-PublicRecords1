EXPORT test_rvv4_xml_attr_report (route,current_dt,previous_dt) := functionmacro

// EXPORT FCRA_RiskView_xml_generic_attributes_v4 (route,current_dt,previous_dt) := functionmacro

import Scoring_Project_Macros;

 file1_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_XML_Generic_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_Generic_Attributes_V4_Global_Layout,


thor), (integer) accountnumber);

 file2_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_XML_Generic_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_Generic_Attributes_V4_Global_Layout,


thor), (integer) accountnumber);


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
	 
	 Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_1(DS2,'addrchangecount01',range1);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_2(DS2,'addrchangecount03',range2);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_3(DS2,'addrchangecount06',range3);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_4(DS2,'addrchangecount12',range4);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_5(DS2,'addrchangecount24',range5);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_6(DS2,'addrchangecount60',range6);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_7(DS2,'addrmostrecentdistance',range7);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_8(DS2,'addrmostrecentmoveage',range8);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_9(DS2,'addrmostrecentstatediff',range9);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_10(DS2,'addrmostrecenttaxdiff',range10);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_11(DS2,'addrrecentecontrajectoryindex',range11);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_12(DS2,'addrstability',range12);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_13(DS2,'agenewestrecord',range13);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_14(DS2,'ageoldestrecord',range14);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_15(DS2,'aircraftcount',range15);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_17(DS2,'aircraftcount01',range16);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_17(DS2,'aircraftcount03',range17);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_18(DS2,'aircraftcount06',range18);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_19(DS2,'aircraftcount12',range19);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_20(DS2,'aircraftcount24',range20);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_21(DS2,'aircraftcount60',range21);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_22(DS2,'aircraftowner',range22);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_23(DS2,'assetowner',range23);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_24(DS2,'bankruptcyage',range24);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_25(DS2,'bankruptcycount',range25);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_26(DS2,'bankruptcycount01',range26);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_27(DS2,'bankruptcycount03',range27);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_28(DS2,'bankruptcycount06',range28);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_29(DS2,'bankruptcycount12',range29);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_30(DS2,'bankruptcycount24',range30);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_31(DS2,'bankruptcycount60',range31);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_32(DS2,'bestreportedage',range32);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_33(DS2,'businessactiveassociation',range33);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_34(DS2,'businessassociationage',range34);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_35(DS2,'businessinactiveassociation',range35);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_48(DS2,'consumerstatement',range36);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_37(DS2,'curraddractivephonelist',range37);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_38(DS2,'curraddragelastsale',range38);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_39(DS2,'curraddragenewestrecord',range39);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_40(DS2,'curraddrageoldestrecord',range40);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_41(DS2,'curraddrapplicantowned',range41);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_42(DS2,'curraddravmvalue',range42);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_43(DS2,'curraddravmvalue12',range43);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_44(DS2,'curraddravmvalue60',range44);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_45(DS2,'curraddrblockindex',range45);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_48(DS2,'curraddrcorrectional',range46);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_47(DS2,'curraddrcountyindex',range47);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_48(DS2,'curraddrfamilyowned',range48);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_49(DS2,'curraddrlastsalesprice',range49);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_50(DS2,'curraddrlenofres',range50);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_51(DS2,'curraddrmortgagetype',range51);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_52(DS2,'curraddroccupantowned',range52);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_53(DS2,'curraddrtaxmarketvalue',range53);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_54(DS2,'curraddrtaxvalue',range54);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_55(DS2,'curraddrtractindex',range55);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_56(DS2,'derogage',range56);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_57(DS2,'derogcount',range57);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_58(DS2,'derogrecentcount',range58);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_59(DS2,'derogseverityindex',range59);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_60(DS2,'educationattendedcollege',range60);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_61(DS2,'educationfieldofstudytype',range61);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_62(DS2,'educationinstitutionprivate',range62);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_63(DS2,'educationinstitutionrating',range63);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_64(DS2,'educationprogram2yr',range64);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_65(DS2,'educationprogram4yr',range65);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_66(DS2,'educationprogramgraduate',range66);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_67(DS2,'emailaddress',range67);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_68(DS2,'estimatedannualincome',range68);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_69(DS2,'evictionage',range69);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_70(DS2,'evictioncount',range70);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_71(DS2,'evictioncount01',range71);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_72(DS2,'evictioncount03',range72);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_73(DS2,'evictioncount06',range73);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_74(DS2,'evictioncount12',range74);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_75(DS2,'evictioncount24',range75);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_76(DS2,'evictioncount60',range76);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_77(DS2,'felonyage',range77);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_78(DS2,'felonycount',range78);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_79(DS2,'felonycount01',range79);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_80(DS2,'felonycount03',range80);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_81(DS2,'felonycount06',range81);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_82(DS2,'felonycount12',range82);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_83(DS2,'felonycount24',range83);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_84(DS2,'felonycount60',range84);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_85(DS2,'highriskcreditactivity',range85);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_86(DS2,'historicaladdrcorrectional',range86);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_48(DS2,'idtheftflag',range87);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_88(DS2,'inferredminimumage',range88);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_89(DS2,'inputaddractivephonelist',range89);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_90(DS2,'inputaddragelastsale',range90);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_91(DS2,'inputaddragenewestrecord',range91);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_92(DS2,'inputaddrageoldestrecord',range92);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_93(DS2,'inputaddrapplicantowned',range93);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_94(DS2,'inputaddravmvalue',range94);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_95(DS2,'inputaddravmvalue12',range95);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_96(DS2,'inputaddravmvalue60',range96);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_97(DS2,'inputaddrblockindex',range97);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_98(DS2,'inputaddrcountyindex',range98);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_99(DS2,'inputaddrdelivery',range99);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_100(DS2,'inputaddrfamilyowned',range100);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_101(DS2,'inputaddrhighrisk',range101);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_102(DS2,'inputaddrhistoricalmatch',range102);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_103(DS2,'inputaddrlastsalesprice',range103);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_104(DS2,'inputaddrlenofres',range104);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_105(DS2,'inputaddrmortgagetype',range105);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_106(DS2,'inputaddrnotprimaryres',range106);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_107(DS2,'inputaddroccupantowned',range107);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_108(DS2,'inputaddrphonecount',range108);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_109(DS2,'inputaddrphonerecentcount',range109);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_110(DS2,'inputaddrproblems',range110);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_111(DS2,'inputaddrtaxmarketvalue',range111);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_112(DS2,'inputaddrtaxvalue',range112);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_113(DS2,'inputaddrtractindex',range113);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_114(DS2,'inputphonehighrisk',range114);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_115(DS2,'inputphonemobile',range115);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_116(DS2,'inputphoneproblems',range116);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_117(DS2,'inquirycollectionsrecent',range117);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_118(DS2,'inquiryotherrecent',range118);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_119(DS2,'inquirypersonalfinancerecent',range119);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_120(DS2,'invaliddl',range120);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_121(DS2,'liencount',range121);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_122(DS2,'lienfederaltaxfiledcount',range122);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_123(DS2,'lienfederaltaxfiledtotal',range123);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_124(DS2,'lienfederaltaxreleasedcount',range124);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_125(DS2,'lienfederaltaxreleasedtotal',range125);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_126(DS2,'lienfiledage',range126);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_127(DS2,'lienfiledcount',range127);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_128(DS2,'lienfiledcount01',range128);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_129(DS2,'lienfiledcount03',range129);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_130(DS2,'lienfiledcount06',range130);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_131(DS2,'lienfiledcount12',range131);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_132(DS2,'lienfiledcount24',range132);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_133(DS2,'lienfiledcount60',range133);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_134(DS2,'lienfiledtotal',range134);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_135(DS2,'lienforeclosurefiledcount',range135);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_136(DS2,'lienforeclosurefiledtotal',range136);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_137(DS2,'lienforeclosurereleasedcount',range137);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_138(DS2,'lienforeclosurereleasedtotal',range138);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_139(DS2,'lienjudgmentfiledcount',range139);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_140(DS2,'lienjudgmentfiledtotal',range140);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_141(DS2,'lienjudgmentreleasedcount',range141);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_142(DS2,'lienjudgmentreleasedtotal',range142);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_143(DS2,'lienlandlordtenantfiledcount',range143);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_144(DS2,'lienlandlordtenantfiledtotal',range144);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_145(DS2,'lienlandlordtenantreleasedcount',range145);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_146(DS2,'lienlandlordtenantreleasedtotal',range146);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_147(DS2,'lienotherfiledcount',range147);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_148(DS2,'lienotherfiledtotal',range148);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_149(DS2,'lienotherreleasedcount',range149);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_150(DS2,'lienotherreleasedtotal',range150);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_151(DS2,'lienreleasedage',range151);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_152(DS2,'lienreleasedcount',range152);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_154(DS2,'lienreleasedcount01',range153);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_154(DS2,'lienreleasedcount03',range154);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_155(DS2,'lienreleasedcount06',range155);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_156(DS2,'lienreleasedcount12',range156);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_157(DS2,'lienreleasedcount24',range157);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_158(DS2,'lienreleasedcount60',range158);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_159(DS2,'lienreleasedtotal',range159);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_160(DS2,'liensmallclaimsfiledcount',range160);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_161(DS2,'liensmallclaimsfiledtotal',range161);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_162(DS2,'liensmallclaimsreleasedcount',range162);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_163(DS2,'liensmallclaimsreleasedtotal',range163);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_164(DS2,'lientaxotherfiledcount',range164);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_165(DS2,'lientaxotherfiledtotal',range165);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_166(DS2,'lientaxotherreleasedcount',range166);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_167(DS2,'lientaxotherreleasedtotal',range167);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_168(DS2,'nonderogcount',range168);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_169(DS2,'nonderogcount01',range169);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_170(DS2,'nonderogcount03',range170);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_171(DS2,'nonderogcount06',range171);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_172(DS2,'nonderogcount12',range172);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_173(DS2,'nonderogcount24',range173);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_174(DS2,'nonderogcount60',range174);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_175(DS2,'phoneedaagenewestrecord',range175);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_176(DS2,'phoneedaageoldestrecord',range176);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_177(DS2,'phoneidentitiescount',range177);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_178(DS2,'phoneidentitiesrecentcount',range178);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_179(DS2,'phoneotheragenewestrecord',range179);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_180(DS2,'phoneotherageoldestrecord',range180);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_181(DS2,'prescreenoptout',range181);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_182(DS2,'prevaddragelastsale',range182);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_183(DS2,'prevaddragenewestrecord',range183);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_184(DS2,'prevaddrageoldestrecord',range184);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_185(DS2,'prevaddrapplicantowned',range185);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_186(DS2,'prevaddravmvalue',range186);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_187(DS2,'prevaddrblockindex',range187);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_188(DS2,'prevaddrcorrectional',range188);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_189(DS2,'prevaddrcountyindex',range189);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_190(DS2,'prevaddrfamilyowned',range190);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_191(DS2,'prevaddrlastsalesprice',range191);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_192(DS2,'prevaddrlenofres',range192);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_193(DS2,'prevaddroccupantowned',range193);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_194(DS2,'prevaddrtaxmarketvalue',range194);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_195(DS2,'prevaddrtaxvalue',range195);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_196(DS2,'prevaddrtractindex',range196);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_197(DS2,'proflicage',range197);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_198(DS2,'profliccount',range198);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_199(DS2,'profliccount01',range199);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_200(DS2,'profliccount03',range200);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_201(DS2,'profliccount06',range201);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_202(DS2,'profliccount12',range202);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_203(DS2,'profliccount24',range203);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_204(DS2,'profliccount60',range204);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_205(DS2,'proflicexpired',range205);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_206(DS2,'proflictypecategory',range206);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_207(DS2,'propagenewestpurchase',range207);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_208(DS2,'propagenewestsale',range208);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_209(DS2,'propageoldestpurchase',range209);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_210(DS2,'propertyowner',range210);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_211(DS2,'propnewestsaleprice',range211);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_212(DS2,'propnewestsalepurchaseindex',range212);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_213(DS2,'propownedcount',range213);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_214(DS2,'propownedhistoricalcount',range214);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_215(DS2,'propownedtaxtotal',range215);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_217(DS2,'proppurchasedcount01',range216);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_217(DS2,'proppurchasedcount03',range217);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_218(DS2,'proppurchasedcount06',range218);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_219(DS2,'proppurchasedcount12',range219);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_220(DS2,'proppurchasedcount24',range220);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_221(DS2,'proppurchasedcount60',range221);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_222(DS2,'propsoldcount01',range222);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_223(DS2,'propsoldcount03',range223);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_224(DS2,'propsoldcount06',range224);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_225(DS2,'propsoldcount12',range225);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_226(DS2,'propsoldcount24',range226);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_227(DS2,'propsoldcount60',range227);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_228(DS2,'recentactivityindex',range228);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_229(DS2,'recentupdate',range229);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_231(DS2,'securityalert',range230);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_231(DS2,'securityfreeze',range231);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_232(DS2,'srcsconfirmidaddrcount',range232);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_236(DS2,'ssn3years',range233);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_234(DS2,'ssnaddrcount',range234);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_235(DS2,'ssnaddrrecentcount',range235);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_236(DS2,'ssnafter5',range236);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_237(DS2,'ssnagedeceased',range237);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_238(DS2,'ssnhighissueage',range238);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_239(DS2,'ssnidentitiescount',range239);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_240(DS2,'ssnidentitiesrecentcount',range240);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_241(DS2,'ssnlowissueage',range241);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_242(DS2,'ssnnonus',range242);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_243(DS2,'ssnnotfound',range243);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_244(DS2,'ssnproblems',range244);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_236(DS2,'ssnrecent',range245);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_246(DS2,'subjectaddrcount',range246);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_247(DS2,'subjectaddrrecentcount',range247);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_248(DS2,'subjectphonecount',range248);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_249(DS2,'subjectphonerecentcount',range249);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_250(DS2,'subjectssncount',range250);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_251(DS2,'subjectssnrecentcount',range251);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_252(DS2,'subprimeofferrequestcount',range252);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_253(DS2,'subprimeofferrequestcount01',range253);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_254(DS2,'subprimeofferrequestcount03',range254);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_255(DS2,'subprimeofferrequestcount06',range255);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_256(DS2,'subprimeofferrequestcount12',range256);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_257(DS2,'subprimeofferrequestcount24',range257);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_258(DS2,'subprimeofferrequestcount60',range258);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_259(DS2,'verificationfailure',range259);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_260(DS2,'verifiedaddress',range260);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_261(DS2,'verifieddob',range261);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_262(DS2,'verifiedname',range262);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_263(DS2,'verifiedphone',range263);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_264(DS2,'verifiedssn',range264);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_265(DS2,'voterregistrationrecord',range265);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_266(DS2,'watercraftcount',range266);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_268(DS2,'watercraftcount01',range267);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_268(DS2,'watercraftcount03',range268);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_269(DS2,'watercraftcount06',range269);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_270(DS2,'watercraftcount12',range270);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_271(DS2,'watercraftcount24',range271);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_272(DS2,'watercraftcount60',range272);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_273(DS2,'watercraftowner',range273);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.range_function_274(DS2,'wealthindex',range274);



      	
ran:= range1+range2+range3+range4+range5+range6+range7+range8+range9+range10+range11+range12+range13+range14+range15+range16+range17+range18+range19+range20+range21+range22+range23+range24+range25+range26+range27+range28+range29+range30+range31+range32+range33+range34+range35+range36+range37+range38+range39+range40+range41+range42+range43+range44+range45+range46+range47+range48+range49+range50+range51+range52+range53+range54+range55+range56+range57+range58+range59+range60+range61+range62+range63+range64+range65+range66+range67+range68+range69+range70+range71+range72+range73+range74+range75+range76+range77+range78+range79+range80+range81+range82+range83+range84+range85+range86+range87+range88+range89+range90+range91+range92+range93+range94+range95+range96+range97+range98+range99+range100+range101+range102+range103+range104+range105+range106+range107+range108+range109+range110+range111+range112+range113+range114+range115+range116+range117+range118+range119+range120+range121+range122+range123+range124+range125+range126+range127+range128+range129+range130+range131+range132+range133+range134+range135+range136+range137+range138+range139+range140+range141+range142+range143+range144+range145+range146+range147+range148+range149+range150+range151+range152+range153+range154+range155+range156+range157+range158+range159+range160+range161+range162+range163+range164+range165+range166+range167+range168+range169+range170+range171+range172+range173+range174+range175+range176+range177+range178+range179+range180+range181+range182+range183+range184+range185+range186+range187+range188+range189+range190+range191+range192+range193+range194+range195+range196+range197+range198+range199+range200+range201+range202+range203+range204+range205+range206+range207+range208+range209+range210+range211+range212+range213+range214+range215+range216+range217+range218+range219+range220+range221+range222+range223+range224+range225+range226+range227+range228+range229+range230+range231+range232+range233+range234+range235+range236+range237+range238+range239+range240+range241+range242+range243+range244+range245+range246+range247+range248+range249+range250+range251+range252+range253+range254+range255+range256+range257+range258+range259+range260+range261+range262+range263+range264+range265+range266+range267+range268+range269+range270+range271+range272+range273+range274;
								 
Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function(DS2,'addrrecentecontrajectory',dist1);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function(DS2,'bankruptcytype',dist2);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function(DS2,'curraddrdwelltype',dist3);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function(DS2,'curraddrtaxyr',dist4);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function(DS2,'inputaddrdwelltype',dist5);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function(DS2,'inputaddrtaxyr',dist6);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function(DS2,'prevaddrdwelltype',dist7);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function(DS2,'prevaddrtaxyr',dist8);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function(DS2,'statusmostrecent',dist9);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function(DS2,'statusnextprevious',dist10);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function(DS2,'statusprevious',dist11);
Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function2(DS2,'bankruptcystatus',dist12);
Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function2(DS2,'businesstitle',dist13);
Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function2(DS2,'proflictype',dist14);
Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Distinct_function2(DS2,'ssnissuestate',dist15);
		



					dis:= dist1+dist2+dist3+dist4+dist5+dist6+dist7+dist8+dist9+dist10+dist11+dist12+dist13+dist14+dist15;

 Scoring_QA.Range_function_module.Length_Function(DS2,'did',len1);

							
      len:=len1;
			
	 				 Scoring_QA.Range_function_module.Distinct_function7(DS2,'did',did1);

	 
	 did_stats:=did1;
	 
			result2_stats:= ran + dis + did_stats;
   				
Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'addrchangecount01',ave1);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'addrchangecount03',ave2);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'addrchangecount06',ave3);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'addrchangecount12',ave4);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'addrchangecount24',ave5);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'addrchangecount60',ave6);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'addrmostrecentdistance',ave7);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'addrmostrecentmoveage',ave8);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'addrmostrecentstatediff',ave9);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'addrmostrecenttaxdiff',ave10);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'addrrecentecontrajectory',ave11);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'addrrecentecontrajectoryindex',ave12);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'addrstability',ave13);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'agenewestrecord',ave14);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ageoldestrecord',ave15);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'aircraftcount',ave16);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'aircraftcount01',ave17);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'aircraftcount03',ave18);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'aircraftcount06',ave19);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'aircraftcount12',ave20);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'aircraftcount24',ave21);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'aircraftcount60',ave22);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'aircraftowner',ave23);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'assetowner',ave24);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'bankruptcyage',ave25);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'bankruptcycount',ave26);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'bankruptcycount01',ave27);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'bankruptcycount03',ave28);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'bankruptcycount06',ave29);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'bankruptcycount12',ave30);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'bankruptcycount24',ave31);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'bankruptcycount60',ave32);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'bankruptcytype',ave33);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'bestreportedage',ave34);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'businessactiveassociation',ave35);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'businessassociationage',ave36);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'businessinactiveassociation',ave37);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'consumerstatement',ave38);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddractivephonelist',ave39);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddragelastsale',ave40);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddragenewestrecord',ave41);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrageoldestrecord',ave42);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrapplicantowned',ave43);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddravmvalue',ave44);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddravmvalue12',ave45);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddravmvalue60',ave46);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrblockindex',ave47);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrcorrectional',ave48);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrcountyindex',ave49);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrdwelltype',ave50);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrfamilyowned',ave51);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrlastsalesprice',ave52);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrlenofres',ave53);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrmortgagetype',ave54);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddroccupantowned',ave55);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrtaxmarketvalue',ave56);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrtaxvalue',ave57);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrtaxyr',ave58);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'curraddrtractindex',ave59);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'derogage',ave60);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'derogcount',ave61);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'derogrecentcount',ave62);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'derogseverityindex',ave63);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'educationattendedcollege',ave64);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'educationfieldofstudytype',ave65);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'educationinstitutionprivate',ave66);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'educationinstitutionrating',ave67);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'educationprogram2yr',ave68);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'educationprogram4yr',ave69);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'educationprogramgraduate',ave70);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'emailaddress',ave71);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'estimatedannualincome',ave72);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'evictionage',ave73);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'evictioncount',ave74);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'evictioncount01',ave75);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'evictioncount03',ave76);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'evictioncount06',ave77);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'evictioncount12',ave78);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'evictioncount24',ave79);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'evictioncount60',ave80);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'felonyage',ave81);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'felonycount',ave82);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'felonycount01',ave83);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'felonycount03',ave84);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'felonycount06',ave85);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'felonycount12',ave86);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'felonycount24',ave87);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'felonycount60',ave88);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'highriskcreditactivity',ave89);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'historicaladdrcorrectional',ave90);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'idtheftflag',ave91);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inferredminimumage',ave92);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddractivephonelist',ave93);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddragelastsale',ave94);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddragenewestrecord',ave95);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrageoldestrecord',ave96);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrapplicantowned',ave97);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddravmvalue',ave98);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddravmvalue12',ave99);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddravmvalue60',ave100);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrblockindex',ave101);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrcountyindex',ave102);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrdelivery',ave103);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrdwelltype',ave104);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrfamilyowned',ave105);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrhighrisk',ave106);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrhistoricalmatch',ave107);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrlastsalesprice',ave108);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrlenofres',ave109);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrmortgagetype',ave110);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrnotprimaryres',ave111);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddroccupantowned',ave112);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrphonecount',ave113);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrphonerecentcount',ave114);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrproblems',ave115);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrtaxmarketvalue',ave116);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrtaxvalue',ave117);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrtaxyr',ave118);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputaddrtractindex',ave119);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputphonehighrisk',ave120);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputphonemobile',ave121);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inputphoneproblems',ave122);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inquirycollectionsrecent',ave123);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inquiryotherrecent',ave124);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'inquirypersonalfinancerecent',ave125);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'invaliddl',ave126);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'liencount',ave127);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienfederaltaxfiledcount',ave128);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienfederaltaxfiledtotal',ave129);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienfederaltaxreleasedcount',ave130);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienfederaltaxreleasedtotal',ave131);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienfiledage',ave132);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienfiledcount',ave133);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienfiledcount01',ave134);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienfiledcount03',ave135);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienfiledcount06',ave136);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienfiledcount12',ave137);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienfiledcount24',ave138);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienfiledcount60',ave139);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienfiledtotal',ave140);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienforeclosurefiledcount',ave141);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienforeclosurefiledtotal',ave142);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienforeclosurereleasedcount',ave143);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienforeclosurereleasedtotal',ave144);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienjudgmentfiledcount',ave145);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienjudgmentfiledtotal',ave146);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienjudgmentreleasedcount',ave147);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienjudgmentreleasedtotal',ave148);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienlandlordtenantfiledcount',ave149);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienlandlordtenantfiledtotal',ave150);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienlandlordtenantreleasedcount',ave151);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienlandlordtenantreleasedtotal',ave152);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienotherfiledcount',ave153);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienotherfiledtotal',ave154);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienotherreleasedcount',ave155);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienotherreleasedtotal',ave156);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienreleasedage',ave157);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienreleasedcount',ave158);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienreleasedcount01',ave159);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienreleasedcount03',ave160);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienreleasedcount06',ave161);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienreleasedcount12',ave162);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienreleasedcount24',ave163);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienreleasedcount60',ave164);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lienreleasedtotal',ave165);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'liensmallclaimsfiledcount',ave166);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'liensmallclaimsfiledtotal',ave167);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'liensmallclaimsreleasedcount',ave168);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'liensmallclaimsreleasedtotal',ave169);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lientaxotherfiledcount',ave170);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lientaxotherfiledtotal',ave171);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lientaxotherreleasedcount',ave172);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'lientaxotherreleasedtotal',ave173);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'nonderogcount',ave174);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'nonderogcount01',ave175);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'nonderogcount03',ave176);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'nonderogcount06',ave177);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'nonderogcount12',ave178);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'nonderogcount24',ave179);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'nonderogcount60',ave180);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'phoneedaagenewestrecord',ave181);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'phoneedaageoldestrecord',ave182);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'phoneidentitiescount',ave183);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'phoneidentitiesrecentcount',ave184);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'phoneotheragenewestrecord',ave185);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'phoneotherageoldestrecord',ave186);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prescreenoptout',ave187);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddragelastsale',ave188);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddragenewestrecord',ave189);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddrageoldestrecord',ave190);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddrapplicantowned',ave191);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddravmvalue',ave192);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddrblockindex',ave193);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddrcorrectional',ave194);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddrcountyindex',ave195);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddrdwelltype',ave196);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddrfamilyowned',ave197);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddrlastsalesprice',ave198);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddrlenofres',ave199);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddroccupantowned',ave200);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddrtaxmarketvalue',ave201);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddrtaxvalue',ave202);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddrtaxyr',ave203);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'prevaddrtractindex',ave204);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'proflicage',ave205);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'profliccount',ave206);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'profliccount01',ave207);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'profliccount03',ave208);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'profliccount06',ave209);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'profliccount12',ave210);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'profliccount24',ave211);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'profliccount60',ave212);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'proflicexpired',ave213);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'proflictypecategory',ave214);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propagenewestpurchase',ave215);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propagenewestsale',ave216);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propageoldestpurchase',ave217);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propertyowner',ave218);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propnewestsaleprice',ave219);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propnewestsalepurchaseindex',ave220);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propownedcount',ave221);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propownedhistoricalcount',ave222);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propownedtaxtotal',ave223);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'proppurchasedcount01',ave224);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'proppurchasedcount03',ave225);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'proppurchasedcount06',ave226);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'proppurchasedcount12',ave227);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'proppurchasedcount24',ave228);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'proppurchasedcount60',ave229);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propsoldcount01',ave230);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propsoldcount03',ave231);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propsoldcount06',ave232);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propsoldcount12',ave233);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propsoldcount24',ave234);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'propsoldcount60',ave235);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'recentactivityindex',ave236);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'recentupdate',ave237);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'securityalert',ave238);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'securityfreeze',ave239);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'srcsconfirmidaddrcount',ave240);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ssn3years',ave241);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ssnaddrcount',ave242);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ssnaddrrecentcount',ave243);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ssnafter5',ave244);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ssnagedeceased',ave245);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ssnhighissueage',ave246);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ssnidentitiescount',ave247);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ssnidentitiesrecentcount',ave248);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ssnlowissueage',ave249);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ssnnonus',ave250);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ssnnotfound',ave251);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ssnproblems',ave252);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'ssnrecent',ave253);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'statusmostrecent',ave254);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'statusnextprevious',ave255);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'statusprevious',ave256);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'subjectaddrcount',ave257);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'subjectaddrrecentcount',ave258);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'subjectphonecount',ave259);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'subjectphonerecentcount',ave260);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'subjectssncount',ave261);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'subjectssnrecentcount',ave262);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'subprimeofferrequestcount',ave263);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'subprimeofferrequestcount01',ave264);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'subprimeofferrequestcount03',ave265);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'subprimeofferrequestcount06',ave266);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'subprimeofferrequestcount12',ave267);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'subprimeofferrequestcount24',ave268);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'subprimeofferrequestcount60',ave269);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'verificationfailure',ave270);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'verifiedaddress',ave271);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'verifieddob',ave272);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'verifiedname',ave273);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'verifiedphone',ave274);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'verifiedssn',ave275);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'voterregistrationrecord',ave276);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'watercraftcount',ave277);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'watercraftcount01',ave278);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'watercraftcount03',ave279);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'watercraftcount06',ave280);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'watercraftcount12',ave281);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'watercraftcount24',ave282);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'watercraftcount60',ave283);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'watercraftowner',ave284);

Scoring_QA_New_Bins.test_rvv4_xml_new_bins.Average_func(DS2,'wealthindex',ave285);


				
      	avearage:= ave1+ave2+ave3+ave4+ave5+ave6+ave7+ave8+ave9+ave10+ave11+ave12+ave13+ave14+ave15+ave16+ave17+ave18+ave19+ave20+ave21+ave22+ave23+ave24+ave25+ave26+ave27+ave28+ave29+ave30+ave31+ave32+ave33+ave34+ave35+ave36+ave37+ave38+ave39+ave40+ave41+ave42+ave43+ave44+ave45+ave46+ave47+ave48+ave49+ave50+ave51+ave52+ave53+ave54+ave55+ave56+ave57+ave58+ave59+ave60+ave61+ave62+ave63+ave64+ave65+ave66+ave67+ave68+ave69+ave70+ave71+ave72+ave73+ave74+ave75+ave76+ave77+ave78+ave79+ave80+ave81+ave82+ave83+ave84+ave85+ave86+ave87+ave88+ave89+ave90+ave91+ave92+ave93+ave94+ave95+ave96+ave97+ave98+ave99+ave100+ave101+ave102+ave103+ave104+ave105+ave106+ave107+ave108+ave109+ave110+ave111+ave112+ave113+ave114+ave115+ave116+ave117+ave118+ave119+ave120+ave121+ave122+ave123+ave124+ave125+ave126+ave127+ave128+ave129+ave130+ave131+ave132+ave133+ave134+ave135+ave136+ave137+ave138+ave139+ave140+ave141+ave142+ave143+ave144+ave145+ave146+ave147+ave148+ave149+ave150+ave151+ave152+ave153+ave154+ave155+ave156+ave157+ave158+ave159+ave160+ave161+ave162+ave163+ave164+ave165+ave166+ave167+ave168+ave169+ave170+ave171+ave172+ave173+ave174+ave175+ave176+ave177+ave178+ave179+ave180+ave181+ave182+ave183+ave184+ave185+ave186+ave187+ave188+ave189+ave190+ave191+ave192+ave193+ave194+ave195+ave196+ave197+ave198+ave199+ave200+ave201+ave202+ave203+ave204+ave205+ave206+ave207+ave208+ave209+ave210+ave211+ave212+ave213+ave214+ave215+ave216+ave217+ave218+ave219+ave220+ave221+ave222+ave223+ave224+ave225+ave226+ave227+ave228+ave229+ave230+ave231+ave232+ave233+ave234+ave235+ave236+ave237+ave238+ave239+ave240+ave241+ave242+ave243+ave244+ave245+ave246+ave247+ave248+ave249+ave250+ave251+ave252+ave253+ave254+ave255+ave256+ave257+ave258+ave259+ave260+ave261+ave262+ave263+ave264+ave265+ave266+ave267+ave268+ave269+ave270+ave271+ave272+ave273+ave274+ave275+ave276+ave277+ave278+ave279+ave280+ave281+ave282+ave283+ave284+ave285;
					
					
					 
	

   result4_stats:=avearage ;
	 
	 
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
                                         self.file_version:='fcra_rvattributes_v4';
																				 self.mode:='xml';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='fcra_rvattributes_v4';
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

		  did_results := DATASET([{'fcra_rvattributes_v4','xml','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
											
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_XML_Generic_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_XML_Generic_outfile[2..] + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_XML_Generic_outfile[2..] + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2);

return seq;

endmacro;