EXPORT Test_fpv201_attr_report(route,current_dt,previous_dt) := functionmacro

//

 file1_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.FP_V2_XML_American_Express_FP1109_0_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V201_AmericanExpress_Global_Layout,


thor),(integer)acctno);



 file2_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.FP_V2_XML_American_Express_FP1109_0_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V201_AmericanExpress_Global_Layout,

thor),(integer)acctno);

file1 := file1_2(errorcode='');
file2 := file2_2(errorcode='');



aa1:=join(file1,file2,left.acctno=right.acctno,inner);

// aa2:=aa1(errorcode='');
aa:=aa1(acctno<>'');

DS1:=join(file1,aa,left.acctno=right.acctno,inner);

DS2:=join(file2,aa,left.acctno=right.acctno,inner);

  	  
				 Missing_values:= JOIN(DS2,DS1,LEFT.acctno=RIGHT.acctno and LEFT.did!=RIGHT.did,local);
					
					pfc := count(ds1);
   cfc := count(ds2);
	 
   fcd :=cfc-pfc;
pf:=count(Missing_values);
cf:=count(Missing_values);

pd:=if(pfc!= 0 and cfc=0,1,cf/cfc);
abd:=abs(pd);
ppd:=if(pfc!= 0 and cfc=0,1,(cf/cfc)*100);
	 
	 
Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_1(DS2,'addrchangecrimediff',range1);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_2(DS2,'addrchangedistance',range2);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_3(DS2,'addrchangeecontrajectoryindex',range3);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_4(DS2,'addrchangeincomediff',range4);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_5(DS2,'addrchangestatediff',range5);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_6(DS2,'addrchangevaluediff',range6);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_7(DS2,'assoccount',range7);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_8(DS2,'assoccreditbureauonlycount',range8);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_9(DS2,'assoccreditbureauonlycountmonth',range9);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_10(DS2,'assoccreditbureauonlycountnew',range10);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_11(DS2,'assocdistanceclosest',range11);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_12(DS2,'assochighrisktopologycount',range12);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_13(DS2,'assocrisklevel',range13);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_14(DS2,'assocsuspicousidentitiescount',range14);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_15(DS2,'componentcharrisklevel',range15);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_16(DS2,'correlationaddrnamecount',range16);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_17(DS2,'correlationaddrphonecount',range17);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_18(DS2,'correlationphonelastnamecount',range18);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_19(DS2,'correlationrisklevel',range19);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_20(DS2,'correlationssnaddrcount',range20);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_21(DS2,'correlationssnnamecount',range21);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_22(DS2,'curraddractivephonelist',range22);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_23(DS2,'curraddragenewest',range23);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_24(DS2,'curraddrageoldest',range24);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_25(DS2,'curraddrburglaryindex',range25);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_26(DS2,'curraddrcartheftindex',range26);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_27(DS2,'curraddrcrimeindex',range27);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_28(DS2,'curraddrlenofres',range28);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_29(DS2,'curraddrmedianincome',range29);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_30(DS2,'curraddrmedianvalue',range30);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_31(DS2,'curraddrmurderindex',range31);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_32(DS2,'divaddridentitycount',range32);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_33(DS2,'divaddridentitycountnew',range33);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_34(DS2,'divaddridentitymsourcecount',range34);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_35(DS2,'divaddrphonecount',range35);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_36(DS2,'divaddrphonecountnew',range36);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_37(DS2,'divaddrphonemsourcecount',range37);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_38(DS2,'divaddrssncount',range38);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_39(DS2,'divaddrssncountnew',range39);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_40(DS2,'divaddrssnmsourcecount',range40);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_41(DS2,'divaddrsuspidentitycountnew',range41);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_42(DS2,'divphoneaddrcount',range42);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_43(DS2,'divphoneaddrcountnew',range43);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_44(DS2,'divphoneidentitycount',range44);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_45(DS2,'divphoneidentitycountnew',range45);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_46(DS2,'divphoneidentitymsourcecount',range46);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_47(DS2,'divrisklevel',range47);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_48(DS2,'divsearchaddridentitycount',range48);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_49(DS2,'divsearchaddrsuspidentitycount',range49);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_50(DS2,'divsearchphoneidentitycount',range50);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_51(DS2,'divsearchssnidentitycount',range51);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_52(DS2,'divssnaddrcount',range52);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_53(DS2,'divssnaddrcountnew',range53);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_54(DS2,'divssnaddrmsourcecount',range54);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_55(DS2,'divssnidentitycount',range55);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_56(DS2,'divssnidentitycountnew',range56);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_57(DS2,'divssnidentitymsourcecount',range57);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_58(DS2,'divssnidentitymsourceurelcount',range58);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_59(DS2,'divssnlnamecount',range59);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_60(DS2,'divssnlnamecountnew',range60);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_61(DS2,'friendlyfraudindex',range61);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_62(DS2,'identityagenewest',range62);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_63(DS2,'identityageoldest',range63);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_64(DS2,'identityageriskindicator',range64);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_65(DS2,'identityrecentupdate',range65);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_66(DS2,'identityrecordcount',range66);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_67(DS2,'identityrisklevel',range67);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_68(DS2,'identitysourcecount',range68);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_69(DS2,'idveraddrcreditbureaucount',range69);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_70(DS2,'idveraddress',range70);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_71(DS2,'idveraddressassoccount',range71);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_72(DS2,'idveraddressdriverslicense',range72);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_73(DS2,'idveraddressmatchescurrent',range73);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_74(DS2,'idveraddressnotcurrent',range74);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_75(DS2,'idveraddresssourcecount',range75);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_76(DS2,'idveraddressvehicleregistation',range76);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_77(DS2,'idveraddressvoter',range77);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_78(DS2,'idverdob',range78);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_79(DS2,'idverdobsourcecount',range79);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_80(DS2,'idverdriverslicense',range80);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_81(DS2,'idverdriverslicensetype',range81);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_82(DS2,'idvername',range82);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_83(DS2,'idverphone',range83);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_84(DS2,'idverrisklevel',range84);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_85(DS2,'idverssn',range85);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_86(DS2,'idverssncreditbureaucount',range86);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_87(DS2,'idverssncreditbureaudelete',range87);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_88(DS2,'idverssndriverslicense',range88);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_89(DS2,'idverssnsourcecount',range89);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_90(DS2,'inputaddractivephonelist',range90);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_91(DS2,'inputaddragenewest',range91);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_92(DS2,'inputaddrageoldest',range92);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_93(DS2,'inputaddrbusinesscount',range93);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_94(DS2,'inputaddrdelivery',range94);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_95(DS2,'inputaddrlenofres',range95);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_96(DS2,'inputaddrnbrhdburglaryindex',range96);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_97(DS2,'inputaddrnbrhdbusinesscount',range97);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_98(DS2,'inputaddrnbrhdcartheftindex',range98);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_99(DS2,'inputaddrnbrhdcrimeindex',range99);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_100(DS2,'inputaddrnbrhdmedianincome',range100);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_101(DS2,'inputaddrnbrhdmedianvalue',range101);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_102(DS2,'inputaddrnbrhdmobilityindex',range102);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_103(DS2,'inputaddrnbrhdmultifamilycount',range103);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_104(DS2,'inputaddrnbrhdmurderindex',range104);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_105(DS2,'inputaddrnbrhdsinglefamilycount',range105);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_106(DS2,'inputaddrnbrhdvacantpropcount',range106);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_107(DS2,'inputaddroccupantowned',range107);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_108(DS2,'inputaddrtype',range108);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_109(DS2,'ipcontinent',range109);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_110(DS2,'manipulatedidentityindex',range110);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_111(DS2,'prevaddragenewest',range111);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_112(DS2,'prevaddrageoldest',range112);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_113(DS2,'prevaddrburglaryindex',range113);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_114(DS2,'prevaddrcartheftindex',range114);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_115(DS2,'prevaddrcrimeindex',range115);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_116(DS2,'prevaddrlenofres',range116);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_117(DS2,'prevaddrmedianincome',range117);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_118(DS2,'prevaddrmedianvalue',range118);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_119(DS2,'prevaddrmurderindex',range119);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_120(DS2,'prevaddroccupantowned',range120);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_121(DS2,'searchaddrsearchcount',range121);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_122(DS2,'searchaddrsearchcountday',range122);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_123(DS2,'searchaddrsearchcountmonth',range123);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_124(DS2,'searchaddrsearchcountweek',range124);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_125(DS2,'searchaddrsearchcountyear',range125);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_126(DS2,'searchbankingsearchcount',range126);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_127(DS2,'searchbankingsearchcountday',range127);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_128(DS2,'searchbankingsearchcountmonth',range128);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_129(DS2,'searchbankingsearchcountweek',range129);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_130(DS2,'searchbankingsearchcountyear',range130);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_131(DS2,'searchcomponentrisklevel',range131);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_132(DS2,'searchcount',range132);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_133(DS2,'searchcountday',range133);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_134(DS2,'searchcountmonth',range134);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_135(DS2,'searchcountweek',range135);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_136(DS2,'searchcountyear',range136);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_137(DS2,'searchfraudsearchcount',range137);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_138(DS2,'searchfraudsearchcountday',range138);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_139(DS2,'searchfraudsearchcountmonth',range139);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_140(DS2,'searchfraudsearchcountweek',range140);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_141(DS2,'searchfraudsearchcountyear',range141);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_142(DS2,'searchhighrisksearchcount',range142);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_143(DS2,'searchhighrisksearchcountday',range143);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_144(DS2,'searchhighrisksearchcountmonth',range144);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_145(DS2,'searchhighrisksearchcountweek',range145);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_146(DS2,'searchhighrisksearchcountyear',range146);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_147(DS2,'searchlocatesearchcount',range147);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_148(DS2,'searchlocatesearchcountday',range148);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_149(DS2,'searchlocatesearchcountmonth',range149);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_150(DS2,'searchlocatesearchcountweek',range150);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_151(DS2,'searchlocatesearchcountyear',range151);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_152(DS2,'searchphonesearchcount',range152);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_153(DS2,'searchphonesearchcountday',range153);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_154(DS2,'searchphonesearchcountmonth',range154);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_155(DS2,'searchphonesearchcountweek',range155);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_156(DS2,'searchphonesearchcountyear',range156);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_157(DS2,'searchssnsearchcount',range157);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_158(DS2,'searchssnsearchcountday',range158);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_159(DS2,'searchssnsearchcountmonth',range159);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_160(DS2,'searchssnsearchcountweek',range160);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_161(DS2,'searchssnsearchcountyear',range161);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_162(DS2,'searchunverifiedaddrcountyear',range162);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_163(DS2,'searchunverifieddobcountyear',range163);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_164(DS2,'searchunverifiedphonecountyear',range164);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_165(DS2,'searchunverifiedssncountyear',range165);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_166(DS2,'searchvelocityrisklevel',range166);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_167(DS2,'sourceaccidents',range167);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_168(DS2,'sourceassets',range168);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_169(DS2,'sourcebusinessrecords',range169);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_170(DS2,'sourcecreditbureau',range170);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_171(DS2,'sourcecreditbureauagechange',range171);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_172(DS2,'sourcecreditbureauagenewest',range172);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_173(DS2,'sourcecreditbureauageoldest',range173);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_174(DS2,'sourcecreditbureaucount',range174);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_175(DS2,'sourcedonotmail',range175);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_176(DS2,'sourcedriverslicense',range176);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_177(DS2,'sourceeducation',range177);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_178(DS2,'sourcefirstreportingidentity',range178);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_179(DS2,'sourceoccupationallicense',range179);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_180(DS2,'sourceonlinedirectory',range180);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_181(DS2,'sourcephonedirectoryassistance',range181);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_182(DS2,'sourcephonenonpublicdirectory',range182);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_183(DS2,'sourceproperty',range183);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_184(DS2,'sourcepublicrecord',range184);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_185(DS2,'sourcepublicrecordcount',range185);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_186(DS2,'sourcepublicrecordcountyear',range186);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_187(DS2,'sourcerisklevel',range187);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_188(DS2,'sourcevehicleregistration',range188);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_189(DS2,'sourcevoterregistration',range189);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_190(DS2,'ssnhighissueage',range190);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_191(DS2,'ssnlowissueage',range191);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_192(DS2,'ssnnonus',range192);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_193(DS2,'stolenidentityindex',range193);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_194(DS2,'suspiciousactivityindex',range194);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_195(DS2,'syntheticidentityindex',range195);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_196(DS2,'validationaddrproblems',range196);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_197(DS2,'validationdlproblems',range197);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_198(DS2,'validationipproblems',range198);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_199(DS2,'validationphoneproblems',range199);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_200(DS2,'validationrisklevel',range200);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_201(DS2,'validationssnproblems',range201);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_202(DS2,'variationaddrchangeage',range202);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_203(DS2,'variationaddrcountnew',range203);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_204(DS2,'variationaddrcountyear',range204);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_205(DS2,'variationaddrstability',range205);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_206(DS2,'variationdobcount',range206);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_207(DS2,'variationdobcountnew',range207);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_208(DS2,'variationidentitycount',range208);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_209(DS2,'variationlastnamecount',range209);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_210(DS2,'variationlastnamecountnew',range210);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_211(DS2,'variationmsourcesssncount',range211);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_212(DS2,'variationmsourcesssnunrelcount',range212);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_213(DS2,'variationphonecount',range213);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_214(DS2,'variationphonecountnew',range214);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_215(DS2,'variationrisklevel',range215);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_216(DS2,'variationsearchaddrcount',range216);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_217(DS2,'variationsearchphonecount',range217);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_218(DS2,'variationsearchssncount',range218);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_219(DS2,'variationssncount',range219);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_220(DS2,'variationssncountnew',range220);

Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_221(DS2,'vulnerablevictimindex',range221);


      	
      	
      	ran:= range1+range2+range3+range4+range5+range6+range7+range8+range9+range10+range11+range12+range13+range14+range15+range16+range17+range18+range19+range20+range21+range22+range23+range24+range25+range26+range27+range28+range29+range30+range31+range32+range33+range34+range35+range36+range37+range38+range39+range40+range41+range42+range43+range44+range45+range46+range47+range48+range49+range50+range51+range52+range53+range54+range55+range56+range57+range58+range59+range60+range61+range62+range63+range64+range65+range66+range67+range68+range69+range70+range71+range72+range73+range74+range75+range76+range77+range78+range79+range80+range81+range82+range83+range84+range85+range86+range87+range88+range89+range90+range91+range92+range93+range94+range95+range96+range97+range98+range99+range100+range101+range102+range103+range104+range105+range106+range107+range108+range109+range110+range111+range112+range113+range114+range115+range116+range117+range118+range119+range120+range121+range122+range123+range124+range125+range126+range127+range128+range129+range130+range131+range132+range133+range134+range135+range136+range137+range138+range139+range140+range141+range142+range143+range144+range145+range146+range147+range148+range149+range150+range151+range152+range153+range154+range155+range156+range157+range158+range159+range160+range161+range162+range163+range164+range165+range166+range167+range168+range169+range170+range171+range172+range173+range174+range175+range176+range177+range178+range179+range180+range181+range182+range183+range184+range185+range186+range187+range188+range189+range190+range191+range192+range193+range194+range195+range196+range197+range198+range199+range200+range201+range202+range203+range204+range205+range206+range207+range208+range209+range210+range211+range212+range213+range214+range215+range216+range217+range218+range219+range220+range221;
      	
				 
						
						Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function2(DS2,'addrchangeecontrajectory',dist1);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function(DS2,'curraddrdwelltype',dist2);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function(DS2,'curraddrstatus',dist3);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function(DS2,'inputaddrdwelltype',dist4);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function(DS2,'inputphonetype',dist5);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function(DS2,'prevaddrdwelltype',dist6);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function(DS2,'prevaddrstatus',dist7);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function2(DS2,'ssnissuestate',dist8);
Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function2(DS2,'ssnissuestate',dist9);
Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function2(DS2,'ssnissuestate',dist10);

				 	
											
											
													
										
				
				dis := dist1+dist2+dist3+dist4+dist5+dist6+dist7+dist8+dist9+dist10;
				
							 Scoring_QA.range_function_module.Distinct_function7(DS2,'did',did1);
	 
	 
	 did_stats:=did1;
								
      
			
			result2_stats:= ran + dis + did_stats;
   				
        
			  Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'addrchangecrimediff',ave1);
				
Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'addrchangedistance',ave2);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'addrchangeecontrajectory',ave3);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'addrchangeecontrajectoryindex',ave4);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'addrchangeincomediff',ave5);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'addrchangestatediff',ave6);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'addrchangevaluediff',ave7);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'assoccount',ave8);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'assoccreditbureauonlycount',ave9);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'assoccreditbureauonlycountmonth',ave10);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'assoccreditbureauonlycountnew',ave11);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'assocdistanceclosest',ave12);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'assochighrisktopologycount',ave13);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'assocrisklevel',ave14);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'assocsuspicousidentitiescount',ave15);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'componentcharrisklevel',ave16);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'correlationaddrnamecount',ave17);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'correlationaddrphonecount',ave18);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'correlationphonelastnamecount',ave19);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'correlationrisklevel',ave20);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'correlationssnaddrcount',ave21);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'correlationssnnamecount',ave22);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'curraddractivephonelist',ave23);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'curraddragenewest',ave24);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'curraddrageoldest',ave25);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'curraddrburglaryindex',ave26);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'curraddrcartheftindex',ave27);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'curraddrcrimeindex',ave28);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'curraddrdwelltype',ave29);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'curraddrlenofres',ave30);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'curraddrmedianincome',ave31);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'curraddrmedianvalue',ave32);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'curraddrmurderindex',ave33);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'curraddrstatus',ave34);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divaddridentitycount',ave35);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divaddridentitycountnew',ave36);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divaddridentitymsourcecount',ave37);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divaddrphonecount',ave38);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divaddrphonecountnew',ave39);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divaddrphonemsourcecount',ave40);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divaddrssncount',ave41);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divaddrssncountnew',ave42);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divaddrssnmsourcecount',ave43);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divaddrsuspidentitycountnew',ave44);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divphoneaddrcount',ave45);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divphoneaddrcountnew',ave46);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divphoneidentitycount',ave47);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divphoneidentitycountnew',ave48);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divphoneidentitymsourcecount',ave49);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divrisklevel',ave50);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divsearchaddridentitycount',ave51);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divsearchaddrsuspidentitycount',ave52);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divsearchphoneidentitycount',ave53);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divsearchssnidentitycount',ave54);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divssnaddrcount',ave55);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divssnaddrcountnew',ave56);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divssnaddrmsourcecount',ave57);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divssnidentitycount',ave58);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divssnidentitycountnew',ave59);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divssnidentitymsourcecount',ave60);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divssnidentitymsourceurelcount',ave61);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divssnlnamecount',ave62);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'divssnlnamecountnew',ave63);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'friendlyfraudindex',ave64);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'identityagenewest',ave65);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'identityageoldest',ave66);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'identityageriskindicator',ave67);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'identityrecentupdate',ave68);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'identityrecordcount',ave69);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'identityrisklevel',ave70);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'identitysourcecount',ave71);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idveraddrcreditbureaucount',ave72);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idveraddress',ave73);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idveraddressassoccount',ave74);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idveraddressdriverslicense',ave75);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idveraddressmatchescurrent',ave76);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idveraddressnotcurrent',ave77);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idveraddresssourcecount',ave78);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idveraddressvehicleregistation',ave79);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idveraddressvoter',ave80);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idverdob',ave81);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idverdobsourcecount',ave82);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idverdriverslicense',ave83);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idverdriverslicensetype',ave84);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idvername',ave85);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idverphone',ave86);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idverrisklevel',ave87);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idverssn',ave88);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idverssncreditbureaucount',ave89);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idverssncreditbureaudelete',ave90);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idverssndriverslicense',ave91);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'idverssnsourcecount',ave92);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddractivephonelist',ave93);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddragenewest',ave94);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrageoldest',ave95);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrbusinesscount',ave96);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrdelivery',ave97);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrdwelltype',ave98);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrlenofres',ave99);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrnbrhdburglaryindex',ave100);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrnbrhdbusinesscount',ave101);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrnbrhdcartheftindex',ave102);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrnbrhdcrimeindex',ave103);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrnbrhdmedianincome',ave104);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrnbrhdmedianvalue',ave105);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrnbrhdmobilityindex',ave106);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrnbrhdmultifamilycount',ave107);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrnbrhdmurderindex',ave108);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrnbrhdsinglefamilycount',ave109);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrnbrhdvacantpropcount',ave110);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddroccupantowned',ave111);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputaddrtype',ave112);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'inputphonetype',ave113);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'ipcontinent',ave114);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'manipulatedidentityindex',ave115);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'prevaddragenewest',ave116);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'prevaddrageoldest',ave117);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'prevaddrburglaryindex',ave118);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'prevaddrcartheftindex',ave119);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'prevaddrcrimeindex',ave120);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'prevaddrdwelltype',ave121);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'prevaddrlenofres',ave122);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'prevaddrmedianincome',ave123);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'prevaddrmedianvalue',ave124);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'prevaddrmurderindex',ave125);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'prevaddroccupantowned',ave126);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'prevaddrstatus',ave127);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchaddrsearchcount',ave128);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchaddrsearchcountday',ave129);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchaddrsearchcountmonth',ave130);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchaddrsearchcountweek',ave131);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchaddrsearchcountyear',ave132);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchbankingsearchcount',ave133);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchbankingsearchcountday',ave134);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchbankingsearchcountmonth',ave135);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchbankingsearchcountweek',ave136);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchbankingsearchcountyear',ave137);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchcomponentrisklevel',ave138);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchcount',ave139);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchcountday',ave140);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchcountmonth',ave141);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchcountweek',ave142);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchcountyear',ave143);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchfraudsearchcount',ave144);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchfraudsearchcountday',ave145);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchfraudsearchcountmonth',ave146);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchfraudsearchcountweek',ave147);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchfraudsearchcountyear',ave148);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchhighrisksearchcount',ave149);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchhighrisksearchcountday',ave150);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchhighrisksearchcountmonth',ave151);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchhighrisksearchcountweek',ave152);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchhighrisksearchcountyear',ave153);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchlocatesearchcount',ave154);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchlocatesearchcountday',ave155);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchlocatesearchcountmonth',ave156);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchlocatesearchcountweek',ave157);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchlocatesearchcountyear',ave158);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchphonesearchcount',ave159);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchphonesearchcountday',ave160);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchphonesearchcountmonth',ave161);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchphonesearchcountweek',ave162);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchphonesearchcountyear',ave163);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchssnsearchcount',ave164);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchssnsearchcountday',ave165);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchssnsearchcountmonth',ave166);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchssnsearchcountweek',ave167);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchssnsearchcountyear',ave168);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchunverifiedaddrcountyear',ave169);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchunverifieddobcountyear',ave170);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchunverifiedphonecountyear',ave171);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchunverifiedssncountyear',ave172);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'searchvelocityrisklevel',ave173);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourceaccidents',ave174);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourceassets',ave175);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcebusinessrecords',ave176);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcecreditbureau',ave177);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcecreditbureauagechange',ave178);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcecreditbureauagenewest',ave179);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcecreditbureauageoldest',ave180);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcecreditbureaucount',ave181);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcedonotmail',ave182);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcedriverslicense',ave183);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourceeducation',ave184);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcefirstreportingidentity',ave185);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourceoccupationallicense',ave186);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourceonlinedirectory',ave187);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcephonedirectoryassistance',ave188);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcephonenonpublicdirectory',ave189);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourceproperty',ave190);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcepublicrecord',ave191);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcepublicrecordcount',ave192);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcepublicrecordcountyear',ave193);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcerisklevel',ave194);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcevehicleregistration',ave195);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'sourcevoterregistration',ave196);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'ssnhighissueage',ave197);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'ssnissuestate',ave198);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'ssnlowissueage',ave199);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'ssnnonus',ave200);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'stolenidentityindex',ave201);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'suspiciousactivityindex',ave202);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'syntheticidentityindex',ave203);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'validationaddrproblems',ave204);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'validationdlproblems',ave205);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'validationipproblems',ave206);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'validationphoneproblems',ave207);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'validationrisklevel',ave208);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'validationssnproblems',ave209);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationaddrchangeage',ave210);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationaddrcountnew',ave211);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationaddrcountyear',ave212);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationaddrstability',ave213);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationdobcount',ave214);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationdobcountnew',ave215);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationidentitycount',ave216);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationlastnamecount',ave217);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationlastnamecountnew',ave218);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationmsourcesssncount',ave219);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationmsourcesssnunrelcount',ave220);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationphonecount',ave221);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationphonecountnew',ave222);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationrisklevel',ave223);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationsearchaddrcount',ave224);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationsearchphonecount',ave225);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationsearchssncount',ave226);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationssncount',ave227);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'variationssncountnew',ave228);

Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'vulnerablevictimindex',ave229);


				
      	
      	   avearage:= ave1+ave2+ave3+ave4+ave5+ave6+ave7+ave8+ave9+ave10+ave11+ave12+ave13+ave14+ave15+ave16+ave17+ave18+ave19+ave20+ave21+ave22+ave23+ave24+ave25+ave26+ave27+ave28+ave29+ave30+ave31+ave32+ave33+ave34+ave35+ave36+ave37+ave38+ave39+ave40+ave41+ave42+ave43+ave44+ave45+ave46+ave47+ave48+ave49+ave50+ave51+ave52+ave53+ave54+ave55+ave56+ave57+ave58+ave59+ave60+ave61+ave62+ave63+ave64+ave65+ave66+ave67+ave68+ave69+ave70+ave71+ave72+ave73+ave74+ave75+ave76+ave77+ave78+ave79+ave80+ave81+ave82+ave83+ave84+ave85+ave86+ave87+ave88+ave89+ave90+ave91+ave92+ave93+ave94+ave95+ave96+ave97+ave98+ave99+ave100+ave101+ave102+ave103+ave104+ave105+ave106+ave107+ave108+ave109+ave110+ave111+ave112+ave113+ave114+ave115+ave116+ave117+ave118+ave119+ave120+ave121+ave122+ave123+ave124+ave125+ave126+ave127+ave128+ave129+ave130+ave131+ave132+ave133+ave134+ave135+ave136+ave137+ave138+ave139+ave140+ave141+ave142+ave143+ave144+ave145+ave146+ave147+ave148+ave149+ave150+ave151+ave152+ave153+ave154+ave155+ave156+ave157+ave158+ave159+ave160+ave161+ave162+ave163+ave164+ave165+ave166+ave167+ave168+ave169+ave170+ave171+ave172+ave173+ave174+ave175+ave176+ave177+ave178+ave179+ave180+ave181+ave182+ave183+ave184+ave185+ave186+ave187+ave188+ave189+ave190+ave191+ave192+ave193+ave194+ave195+ave196+ave197+ave198+ave199+ave200+ave201+ave202+ave203+ave204+ave205+ave206+ave207+ave208+ave209+ave210+ave211+ave212+ave213+ave214+ave215+ave216+ave217+ave218+ave219+ave220+ave221+ave222+ave223+ave224+ave225+ave226+ave227+ave228+ave229;
      	
								
											 
										 
											 
				

	
	
   result4_stats:=avearage   ;
	 

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
                                         self.file_version:='FraudPoint_V201_AMEX';
																				 self.mode:='xml';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='FraudPoint_V201_AMEX';
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

		  did_results := DATASET([{'FraudPoint_V201','xml','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
											
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.FP_V2_XML_American_Express_FP1109_0_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.FP_V2_XML_American_Express_FP1109_0_outfile[2..] + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.FP_V2_XML_American_Express_FP1109_0_outfile[2..] + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2);

return seq;

endmacro;
