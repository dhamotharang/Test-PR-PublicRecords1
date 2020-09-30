EXPORT test_ita_attribute_report(route,current_dt,previous_dt) := functionmacro



 file1_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_ITA_BATCH_CapitalOne_attributes_v3_Global_Layout,


thor),(integer)acctno);

 file2_2:=distribute(dataset(route + scoring_project_pip.Output_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_ITA_BATCH_CapitalOne_attributes_v3_Global_Layout,


thor),(integer)acctno);


file1 := file1_2(errorcode='');
file2 := file2_2(errorcode='');

file1_dedup:=dedup(file1,acctno,all);
file2_dedup:=dedup(file2,acctno,all);

aa1:=join(file1_dedup,file2_dedup,left.acctno=right.acctno,inner);

aa:=aa1(acctno<>'');

DS1:=join(file1_dedup,aa,left.acctno=right.acctno,inner);

DS2:=join(file2_dedup,aa,left.acctno=right.acctno,inner);

                           
                              Missing_values:= JOIN(DS2,DS1,LEFT.acctno=RIGHT.acctno and LEFT.did!=RIGHT.did,local);
													
															
			
pfc := count(ds1);
   cfc := count(ds2);
	 
   fcd :=cfc-pfc;
pf:=count(Missing_values);
cf:=count(Missing_values);

pd:=if(pfc!= 0 and cfc=0,1,cf/cfc);
abd:=abs(pd);
ppd:=if(pfc!= 0 and cfc=0,1,(cf/cfc)*100);
	 
	 
Scoring_QA_New_Bins.ITAv3_new_bins.range_function_1(DS2,'addrstability',range1);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_2(DS2,'ageriskindicator',range2);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_3(DS2,'curraddractivephonenumber',range3);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_4(DS2,'curraddrassessedvalue',range4);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_5(DS2,'curraddrassessmarket',range5);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_6(DS2,'curraddrautoval',range6);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_7(DS2,'curraddrblockindex',range7);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_8(DS2,'curraddrburglaryindex',range8);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_9(DS2,'curraddrcartheftindex',range9);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_10(DS2,'curraddrconfscore',range10);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_11(DS2,'curraddrcountyindex',range11);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_12(DS2,'curraddrcrimeindex',range12);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_13(DS2,'curraddrhedval',range13);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_14(DS2,'curraddrlastsalesamount',range14);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_15(DS2,'curraddrlenofres',range15);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_16(DS2,'curraddrmedianhomeval',range16);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_17(DS2,'curraddrmedianincome',range17);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_18(DS2,'curraddrmurderindex',range18);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_19(DS2,'curraddrprevaddrassesseddiff',range19);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_20(DS2,'curraddrprevaddrcrimediff',range20);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_21(DS2,'curraddrprevaddrdistance',range21);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_22(DS2,'curraddrprevaddrhomevaldiff',range22);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_23(DS2,'curraddrprevaddrincomediff',range23);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_24(DS2,'curraddrpriceindval',range24);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_25(DS2,'curraddrtaxassessval',range25);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_26(DS2,'curraddrtractindex',range26);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_27(DS2,'donotmail',range27);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_28(DS2,'inputaddractivephonenumber',range28);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_29(DS2,'inputaddrassessedvalue',range29);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_30(DS2,'inputaddrassessmarket',range30);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_31(DS2,'inputaddrautoval',range31);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_32(DS2,'inputaddrblockindex',range32);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_33(DS2,'inputaddrburglaryindex',range33);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_34(DS2,'inputaddrcartheftindex',range34);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_35(DS2,'inputaddrconfscore',range35);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_36(DS2,'inputaddrcountyindex',range36);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_37(DS2,'inputaddrcrimeindex',range37);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_38(DS2,'inputaddrcurraddrassesseddiff',range38);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_39(DS2,'inputaddrcurraddrcrimediff',range39);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_40(DS2,'inputaddrcurraddrdistance',range40);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_41(DS2,'inputaddrcurraddrhomevaldiff',range41);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_42(DS2,'inputaddrcurraddrincomediff',range42);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_43(DS2,'inputaddrhedval',range43);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_44(DS2,'inputaddrlastsalesamount',range44);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_45(DS2,'inputaddrlenofres',range45);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_46(DS2,'inputaddrmedianhomeval',range46);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_47(DS2,'inputaddrmedianincome',range47);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_48(DS2,'inputaddrmurderindex',range48);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_49(DS2,'inputaddrpriceindval',range49);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_50(DS2,'inputaddrtaxassessval',range50);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_51(DS2,'inputaddrtractindex',range51);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_52(DS2,'inputphoneaddrdist',range52);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_53(DS2,'prevaddractivephonenumber',range53);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_54(DS2,'prevaddrassessedvalue',range54);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_55(DS2,'prevaddrassessmarket',range55);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_56(DS2,'prevaddrautoval',range56);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_57(DS2,'prevaddrblockindex',range57);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_58(DS2,'prevaddrburglaryindex',range58);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_59(DS2,'prevaddrcartheftindex',range59);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_60(DS2,'prevaddrconfscore',range60);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_61(DS2,'prevaddrcountyindex',range61);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_62(DS2,'prevaddrcrimeindex',range62);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_63(DS2,'prevaddrhedval',range63);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_64(DS2,'prevaddrlastsalesamount',range64);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_65(DS2,'prevaddrlenofres',range65);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_66(DS2,'prevaddrmedianhomeval',range66);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_67(DS2,'prevaddrmedianincome',range67);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_68(DS2,'prevaddrmurderindex',range68);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_69(DS2,'prevaddrpriceindval',range69);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_70(DS2,'prevaddrtaxassessval',range70);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_71(DS2,'prevaddrtractindex',range71);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_72(DS2,'propertyownedassessedtotal',range72);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_73(DS2,'recentupdate',range73);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_74(DS2,'ssnlength',range74);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_75(DS2,'timesincecurraddrfirstseen',range75);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_76(DS2,'timesincecurraddrlastseen',range76);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_77(DS2,'timesinceinputaddrfirstseen',range77);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_78(DS2,'timesinceinputaddrlastseen',range78);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_79(DS2,'timesincelastname',range79);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_80(DS2,'timesinceprevaddrfirstseen',range80);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_81(DS2,'timesinceprevaddrlastseen',range81);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_82(DS2,'timesincesubjectphonefirstseen',range82);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_83(DS2,'timesincesubjectphonelastseen',range83);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_84(DS2,'v3__addrchangecount01',range84);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_85(DS2,'v3__addrchangecount03',range85);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_86(DS2,'v3__addrchangecount06',range86);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_87(DS2,'v3__addrchangecount12',range87);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_88(DS2,'v3__addrchangecount24',range88);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_89(DS2,'v3__addrchangecount36',range89);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_90(DS2,'v3__addrchangecount60',range90);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_91(DS2,'v3__agenewestrecord',range91);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_92(DS2,'v3__ageoldestrecord',range92);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_93(DS2,'v3__aircraftcount',range93);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_94(DS2,'v3__aircraftcount01',range94);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_95(DS2,'v3__aircraftcount03',range95);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_96(DS2,'v3__aircraftcount06',range96);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_97(DS2,'v3__aircraftcount12',range97);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_98(DS2,'v3__aircraftcount24',range98);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_99(DS2,'v3__aircraftcount36',range99);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_100(DS2,'v3__aircraftcount60',range100);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_101(DS2,'v3__arrestage',range101);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_102(DS2,'v3__arrestcount',range102);

// Scoring_QA_New_Bins.ITAv3_new_bins.range_function_103(DS2,'v3__arrestcount01',range103);
Scoring_QA_New_Bins.ITAv3_new_bins.range_function_104(DS2,'v3__arrestcount01',range103);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_104(DS2,'v3__arrestcount03',range104);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_105(DS2,'v3__arrestcount06',range105);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_106(DS2,'v3__arrestcount12',range106);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_107(DS2,'v3__arrestcount24',range107);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_108(DS2,'v3__arrestcount36',range108);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_109(DS2,'v3__arrestcount60',range109);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_110(DS2,'v3__bankruptcyage',range110);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_111(DS2,'v3__bankruptcycount',range111);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_112(DS2,'v3__bankruptcycount01',range112);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_113(DS2,'v3__bankruptcycount03',range113);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_114(DS2,'v3__bankruptcycount06',range114);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_115(DS2,'v3__bankruptcycount12',range115);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_116(DS2,'v3__bankruptcycount24',range116);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_117(DS2,'v3__bankruptcycount36',range117);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_118(DS2,'v3__bankruptcycount60',range118);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_119(DS2,'v3__creditbureaurecord',range119);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_120(DS2,'v3__curraddractivephonelist',range120);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_121(DS2,'v3__curraddragelastsale',range121);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_122(DS2,'v3__curraddrapplicantowned',range122);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_123(DS2,'v3__curraddrfamilyowned',range123);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_124(DS2,'v3__curraddrlandusecode',range124);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_125(DS2,'v3__curraddroccupantowned',range125);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_126(DS2,'v3__curraddrprison',range126);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_127(DS2,'v3__currprevaddrstatediff',range127);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_128(DS2,'v3__derogage',range128);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_129(DS2,'v3__derogcount',range129);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_130(DS2,'v3__derogseverityindex',range130);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_131(DS2,'v3__educationattendedcollege',range131);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_132(DS2,'v3__educationfieldofstudytype',range132);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_133(DS2,'v3__educationinstitutionprivate',range133);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_134(DS2,'v3__educationinstitutionrating',range134);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_135(DS2,'v3__educationprogram2yr',range135);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_136(DS2,'v3__educationprogram4yr',range136);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_137(DS2,'v3__educationprogramgraduate',range137);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_138(DS2,'v3__evictionage',range138);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_139(DS2,'v3__evictioncount',range139);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_141(DS2,'v3__evictioncount01',range140);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_141(DS2,'v3__evictioncount03',range141);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_142(DS2,'v3__evictioncount06',range142);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_143(DS2,'v3__evictioncount12',range143);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_144(DS2,'v3__evictioncount24',range144);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_145(DS2,'v3__evictioncount36',range145);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_146(DS2,'v3__evictioncount60',range146);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_147(DS2,'v3__felonyage',range147);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_148(DS2,'v3__felonycount',range148);

// Scoring_QA_New_Bins.ITAv3_new_bins.range_function_149(DS2,'v3__felonycount01',range149);
// Scoring_QA_New_Bins.ITAv3_new_bins.range_function_150(DS2,'v3__felonycount03',range150);
// Scoring_QA_New_Bins.ITAv3_new_bins.range_function_151(DS2,'v3__felonycount06',range151);
// Scoring_QA_New_Bins.ITAv3_new_bins.range_function_152(DS2,'v3__felonycount12',range152);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_153(DS2,'v3__felonycount01',range149);
Scoring_QA_New_Bins.ITAv3_new_bins.range_function_153(DS2,'v3__felonycount03',range150);
Scoring_QA_New_Bins.ITAv3_new_bins.range_function_153(DS2,'v3__felonycount06',range151);
Scoring_QA_New_Bins.ITAv3_new_bins.range_function_153(DS2,'v3__felonycount12',range152);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_153(DS2,'v3__felonycount24',range153);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_154(DS2,'v3__felonycount36',range154);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_155(DS2,'v3__felonycount60',range155);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_156(DS2,'v3__historicaladdrprison',range156);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_157(DS2,'v3__inputaddractivephonelist',range157);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_158(DS2,'v3__inputaddragelastsale',range158);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_159(DS2,'v3__inputaddrapplicantowned',range159);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_160(DS2,'v3__inputaddrfamilyowned',range160);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_161(DS2,'v3__inputaddrhighrisk',range161);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_162(DS2,'v3__inputaddridentitiescount',range162);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_163(DS2,'v3__inputaddridentitiesrecentcount',range163);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_164(DS2,'v3__inputaddrlandusecode',range164);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_165(DS2,'v3__inputaddrnotprimaryres',range165);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_166(DS2,'v3__inputaddroccupantowned',range166);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_167(DS2,'v3__inputaddrphonecount',range167);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_168(DS2,'v3__inputaddrphonerecentcount',range168);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_169(DS2,'v3__inputaddrprison',range169);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_170(DS2,'v3__inputaddrssncount',range170);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_171(DS2,'v3__inputaddrssnrecentcount',range171);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_172(DS2,'v3__inputareacodechange',range172);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_173(DS2,'v3__inputcurraddrmatch',range173);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_174(DS2,'v3__inputcurraddrstatediff',range174);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_175(DS2,'v3__inputphonehighrisk',range175);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_176(DS2,'v3__inputphonemobile',range176);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_177(DS2,'v3__inputphonepager',range177);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_178(DS2,'v3__inputphonetype',range178);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_179(DS2,'v3__inputprevaddrmatch',range179);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_180(DS2,'v3__inputzipcorpmil',range180);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_181(DS2,'v3__inputzippobox',range181);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_182(DS2,'v3__invalidaddr',range182);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_183(DS2,'v3__invalidphone',range183);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_184(DS2,'v3__invalidphonezip',range184);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_185(DS2,'v3__invalidssn',range185);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_186(DS2,'v3__lastnamechangecount01',range186);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_187(DS2,'v3__lastnamechangecount03',range187);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_188(DS2,'v3__lastnamechangecount06',range188);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_189(DS2,'v3__lastnamechangecount12',range189);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_190(DS2,'v3__lastnamechangecount24',range190);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_191(DS2,'v3__lastnamechangecount36',range191);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_192(DS2,'v3__lastnamechangecount60',range192);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_193(DS2,'v3__liencount',range193);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_194(DS2,'v3__lienfiledage',range194);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_195(DS2,'v3__lienfiledcount',range195);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_196(DS2,'v3__lienfiledcount01',range196);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_197(DS2,'v3__lienfiledcount03',range197);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_198(DS2,'v3__lienfiledcount06',range198);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_199(DS2,'v3__lienfiledcount12',range199);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_200(DS2,'v3__lienfiledcount24',range200);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_201(DS2,'v3__lienfiledcount36',range201);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_202(DS2,'v3__lienfiledcount60',range202);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_203(DS2,'v3__lienreleasedage',range203);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_204(DS2,'v3__lienreleasedcount',range204);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_206(DS2,'v3__lienreleasedcount01',range205);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_206(DS2,'v3__lienreleasedcount03',range206);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_207(DS2,'v3__lienreleasedcount06',range207);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_208(DS2,'v3__lienreleasedcount12',range208);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_209(DS2,'v3__lienreleasedcount24',range209);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_210(DS2,'v3__lienreleasedcount36',range210);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_211(DS2,'v3__lienreleasedcount60',range211);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_212(DS2,'v3__nonderogcount',range212);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_213(DS2,'v3__nonderogcount01',range213);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_214(DS2,'v3__nonderogcount03',range214);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_215(DS2,'v3__nonderogcount06',range215);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_216(DS2,'v3__nonderogcount12',range216);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_217(DS2,'v3__nonderogcount24',range217);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_218(DS2,'v3__nonderogcount36',range218);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_219(DS2,'v3__nonderogcount60',range219);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_220(DS2,'v3__phoneidentitiescount',range220);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_221(DS2,'v3__phoneidentitiesrecentcount',range221);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_222(DS2,'v3__phoneother',range222);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_223(DS2,'v3__phoneotheragenewestrecord',range223);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_224(DS2,'v3__phoneotherageoldestrecord',range224);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_225(DS2,'v3__predictedannualincome',range225);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_226(DS2,'v3__prevaddractivephonelist',range226);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_227(DS2,'v3__prevaddragelastsale',range227);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_228(DS2,'v3__prevaddrapplicantowned',range228);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_229(DS2,'v3__prevaddrfamilyowned',range229);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_230(DS2,'v3__prevaddrlandusecode',range230);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_231(DS2,'v3__prevaddroccupantowned',range231);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_232(DS2,'v3__prevaddrprison',range232);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_233(DS2,'v3__proflicage',range233);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_234(DS2,'v3__profliccount',range234);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_235(DS2,'v3__profliccount01',range235);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_236(DS2,'v3__profliccount03',range236);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_237(DS2,'v3__profliccount06',range237);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_238(DS2,'v3__profliccount12',range238);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_239(DS2,'v3__profliccount24',range239);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_240(DS2,'v3__profliccount36',range240);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_241(DS2,'v3__profliccount60',range241);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_242(DS2,'v3__proflicexpirecount01',range242);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_243(DS2,'v3__proflicexpirecount03',range243);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_244(DS2,'v3__proflicexpirecount06',range244);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_245(DS2,'v3__proflicexpirecount12',range245);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_246(DS2,'v3__proflicexpirecount24',range246);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_247(DS2,'v3__proflicexpirecount36',range247);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_248(DS2,'v3__proflicexpirecount60',range248);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_249(DS2,'v3__proflictypecategory',range249);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_250(DS2,'v3__propagenewestpurchase',range250);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_251(DS2,'v3__propagenewestsale',range251);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_252(DS2,'v3__propageoldestpurchase',range252);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_253(DS2,'v3__propnewestsalepurchaseindex',range253);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_254(DS2,'v3__propownedcount',range254);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_255(DS2,'v3__propownedhistoricalcount',range255);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_256(DS2,'v3__proppurchasedcount01',range256);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_257(DS2,'v3__proppurchasedcount03',range257);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_258(DS2,'v3__proppurchasedcount06',range258);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_259(DS2,'v3__proppurchasedcount12',range259);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_260(DS2,'v3__proppurchasedcount24',range260);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_261(DS2,'v3__proppurchasedcount36',range261);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_262(DS2,'v3__proppurchasedcount60',range262);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_263(DS2,'v3__propsoldcount01',range263);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_264(DS2,'v3__propsoldcount03',range264);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_265(DS2,'v3__propsoldcount06',range265);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_266(DS2,'v3__propsoldcount12',range266);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_267(DS2,'v3__propsoldcount24',range267);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_268(DS2,'v3__propsoldcount36',range268);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_269(DS2,'v3__propsoldcount60',range269);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_270(DS2,'v3__prsearchcollectioncount',range270);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_271(DS2,'v3__prsearchcollectioncount01',range271);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_272(DS2,'v3__prsearchcollectioncount03',range272);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_273(DS2,'v3__prsearchcollectioncount06',range273);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_274(DS2,'v3__prsearchcollectioncount12',range274);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_275(DS2,'v3__prsearchcollectioncount24',range275);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_276(DS2,'v3__prsearchcollectioncount36',range276);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_277(DS2,'v3__prsearchcollectioncount60',range277);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_278(DS2,'v3__prsearchidvfraudcount',range278);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_279(DS2,'v3__prsearchidvfraudcount01',range279);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_280(DS2,'v3__prsearchidvfraudcount03',range280);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_281(DS2,'v3__prsearchidvfraudcount06',range281);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_282(DS2,'v3__prsearchidvfraudcount12',range282);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_283(DS2,'v3__prsearchidvfraudcount24',range283);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_284(DS2,'v3__prsearchidvfraudcount36',range284);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_285(DS2,'v3__prsearchidvfraudcount60',range285);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_286(DS2,'v3__prsearchothercount',range286);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_287(DS2,'v3__prsearchothercount01',range287);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_288(DS2,'v3__prsearchothercount03',range288);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_289(DS2,'v3__prsearchothercount06',range289);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_290(DS2,'v3__prsearchothercount12',range290);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_291(DS2,'v3__prsearchothercount24',range291);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_292(DS2,'v3__prsearchothercount36',range292);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_293(DS2,'v3__prsearchothercount60',range293);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_294(DS2,'v3__relativesbankruptcycount',range294);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_295(DS2,'v3__relativescount',range295);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_296(DS2,'v3__relativesdistanceclosest',range296);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_297(DS2,'v3__relativesfelonycount',range297);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_298(DS2,'v3__relativespropownedcount',range298);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_299(DS2,'v3__relativespropownedtaxtotal',range299);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_300(DS2,'v3__sfduaddridentitiescount',range300);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_301(DS2,'v3__sfduaddrssncount',range301);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_302(DS2,'v3__srcsconfirmidaddrcount',range302);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_303(DS2,'v3__ssn3years',range303);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_304(DS2,'v3__ssnaddrcount',range304);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_305(DS2,'v3__ssnaddrrecentcount',range305);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_306(DS2,'v3__ssnafter5',range306);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_307(DS2,'v3__ssndeceased',range307);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_308(DS2,'v3__ssnfoundother',range308);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_309(DS2,'v3__ssnidentitiescount',range309);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_310(DS2,'v3__ssnidentitiesrecentcount',range310);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_311(DS2,'v3__ssnissued',range311);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_312(DS2,'v3__ssnissuedpriordob',range312);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_313(DS2,'v3__ssnlastnamecount',range313);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_314(DS2,'v3__ssnnonus',range314);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_315(DS2,'v3__ssnnotfound',range315);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_316(DS2,'v3__ssnrecent',range316);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_317(DS2,'v3__subjectaddrcount',range317);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_318(DS2,'v3__subjectaddrrecentcount',range318);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_319(DS2,'v3__subjectlastnamecount',range319);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_320(DS2,'v3__subjectphonecount',range320);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_321(DS2,'v3__subjectphonerecentcount',range321);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_322(DS2,'v3__subjectssncount',range322);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_323(DS2,'v3__subjectssnrecentcount',range323);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_324(DS2,'v3__subprimesolicitedcount',range324);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_325(DS2,'v3__subprimesolicitedcount01',range325);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_326(DS2,'v3__subprimesolicitedcount03',range326);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_327(DS2,'v3__subprimesolicitedcount06',range327);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_328(DS2,'v3__subprimesolicitedcount12',range328);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_329(DS2,'v3__subprimesolicitedcount24',range329);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_330(DS2,'v3__subprimesolicitedcount36',range330);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_331(DS2,'v3__subprimesolicitedcount60',range331);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_332(DS2,'v3__verificationfailure',range332);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_333(DS2,'v3__verifiedaddress',range333);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_334(DS2,'v3__verifieddob',range334);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_335(DS2,'v3__verifiedname',range335);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_336(DS2,'v3__verifiedphone',range336);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_337(DS2,'v3__verifiedphonefullname',range337);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_338(DS2,'v3__verifiedphonelastname',range338);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_339(DS2,'v3__verifiedssn',range339);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_340(DS2,'v3__watercraftcount',range340);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_341(DS2,'v3__watercraftcount01',range341);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_342(DS2,'v3__watercraftcount03',range342);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_343(DS2,'v3__watercraftcount06',range343);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_344(DS2,'v3__watercraftcount12',range344);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_345(DS2,'v3__watercraftcount24',range345);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_346(DS2,'v3__watercraftcount36',range346);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_347(DS2,'v3__watercraftcount60',range347);

Scoring_QA_New_Bins.ITAv3_new_bins.range_function_348(DS2,'wealthindex',range348);




      	
			
				
			  	
      	ran:= range1+range2+range3+range4+range5+range6+range7+range8+range9+range10+range11+range12+range13+range14+range15+range16+range17+range18+range19+range20+range21+range22+range23+range24+range25+range26+range27+range28+range29+range30+range31+range32+range33+range34+range35+range36+range37+range38+range39+range40+range41+range42+range43+range44+range45+range46+range47+range48+range49+range50+range51+range52+range53+range54+range55+range56+range57+range58+range59+range60+range61+range62+range63+range64+range65+range66+range67+range68+range69+range70+range71+range72+range73+range74+range75+range76+range77+range78+range79+range80+range81+range82+range83+range84+range85+range86+range87+range88+range89+range90+range91+range92+range93+range94+range95+range96+range97+range98+range99+range100+range101+range102+range103+range104+range105+range106+range107+range108+range109+range110+range111+range112+range113+range114+range115+range116+range117+range118+range119+range120+range121+range122+range123+range124+range125+range126+range127+range128+range129+range130+range131+range132+range133+range134+range135+range136+range137+range138+range139+range140+range141+range142+range143+range144+range145+range146+range147+range148+range149+range150+range151+range152+range153+range154+range155+range156+range157+range158+range159+range160+range161+range162+range163+range164+range165+range166+range167+range168+range169+range170+range171+range172+range173+range174+range175+range176+range177+range178+range179+range180+range181+range182+range183+range184+range185+range186+range187+range188+range189+range190+range191+range192+range193+range194+range195+range196+range197+range198+range199+range200+range201+range202+range203+range204+range205+range206+range207+range208+range209+range210+range211+range212+range213+range214+range215+range216+range217+range218+range219+range220+range221+range222+range223+range224+range225+range226+range227+range228+range229+range230+range231+range232+range233+range234+range235+range236+range237+range238+range239+range240+range241+range242+range243+range244+range245+range246+range247+range248+range249+range250+range251+range252+range253+range254+range255+range256+range257+range258+range259+range260+range261+range262+range263+range264+range265+range266+range267+range268+range269+range270+range271+range272+range273+range274+range275+range276+range277+range278+range279+range280+range281+range282+range283+range284+range285+range286+range287+range288+range289+range290+range291+range292+range293+range294+range295+range296+range297+range298+range299+range300+range301+range302+range303+range304+range305+range306+range307+range308+range309+range310+range311+range312+range313+range314+range315+range316+range317+range318+range319+range320+range321+range322+range323+range324+range325+range326+range327+range328+range329+range330+range331+range332+range333+range334+range335+range336+range337+range338+range339+range340+range341+range342+range343+range344+range345+range346+range347+range348;


Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'AddrValErrorCode',dist1);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'CurrAddrTaxAssessedYR',dist2);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'EconomicTrajectory',dist3);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'EconomicTrajectory2',dist4);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'InputAddrTaxAssessedYR',dist5);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'MostRecentBankruptStatus',dist6);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'PrevAddrTaxAssessedYR',dist7);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'SIC',dist8);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'SSNIssueState',dist9);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'SSNProbs',dist10);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'ServiceType',dist11);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'v3__CurrAddrDwellType',dist12);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'v3__InputAddrDwellType',dist13);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'v3__InputAddrValidation',dist14);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'v3__InputPhoneStatus',dist15);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'v3__PrevAddrDwellType',dist16);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'v3__StatusMostRecent',dist17);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'v3__StatusNextPrevious',dist18);

Scoring_QA_New_Bins.ITAv3_new_bins.Distinct_function(DS2,'v3__StatusPrevious',dist19);





					
					dis:= dist1+dist2+dist3+dist4+dist5+dist6+dist7+dist8+dist9+dist10+dist11+dist12+dist13+dist14+dist15+dist16+dist17+dist18+dist19;
	 					 Scoring_QA.range_function_module.Distinct_function7(DS2,'did',did1);

	 did_stats:=did1;
								
      
			
			result2_stats:= ran + dis +  ran + did_stats;
 Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'AddrValErrorCode',ave1);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'CurrAddrTaxAssessedYR',ave2);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'EconomicTrajectory',ave3);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'EconomicTrajectory2',ave4);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'InputAddrTaxAssessedYR',ave5);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'MostRecentBankruptStatus',ave6);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'PrevAddrTaxAssessedYR',ave7);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'SIC',ave8);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'SSNIssueState',ave9);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'SSNProbs',ave10);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'ServiceType',ave11);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'addrstability',ave12);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'ageriskindicator',ave13);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddractivephonenumber',ave14);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrassessedvalue',ave15);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrassessmarket',ave16);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrautoval',ave17);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrblockindex',ave18);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrburglaryindex',ave19);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrcartheftindex',ave20);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrconfscore',ave21);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrcountyindex',ave22);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrcrimeindex',ave23);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrhedval',ave24);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrlastsalesamount',ave25);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrlenofres',ave26);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrmedianhomeval',ave27);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrmedianincome',ave28);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrmurderindex',ave29);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrprevaddrassesseddiff',ave30);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrprevaddrcrimediff',ave31);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrprevaddrdistance',ave32);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrprevaddrhomevaldiff',ave33);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrprevaddrincomediff',ave34);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrpriceindval',ave35);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrtaxassessval',ave36);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'curraddrtractindex',ave37);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'donotmail',ave38);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddractivephonenumber',ave39);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrassessedvalue',ave40);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrassessmarket',ave41);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrautoval',ave42);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrblockindex',ave43);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrburglaryindex',ave44);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrcartheftindex',ave45);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrconfscore',ave46);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrcountyindex',ave47);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrcrimeindex',ave48);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrcurraddrassesseddiff',ave49);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrcurraddrcrimediff',ave50);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrcurraddrdistance',ave51);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrcurraddrhomevaldiff',ave52);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrcurraddrincomediff',ave53);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrhedval',ave54);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrlastsalesamount',ave55);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrlenofres',ave56);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrmedianhomeval',ave57);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrmedianincome',ave58);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrmurderindex',ave59);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrpriceindval',ave60);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrtaxassessval',ave61);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputaddrtractindex',ave62);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'inputphoneaddrdist',ave63);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddractivephonenumber',ave64);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrassessedvalue',ave65);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrassessmarket',ave66);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrautoval',ave67);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrblockindex',ave68);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrburglaryindex',ave69);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrcartheftindex',ave70);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrconfscore',ave71);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrcountyindex',ave72);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrcrimeindex',ave73);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrhedval',ave74);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrlastsalesamount',ave75);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrlenofres',ave76);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrmedianhomeval',ave77);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrmedianincome',ave78);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrmurderindex',ave79);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrpriceindval',ave80);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrtaxassessval',ave81);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'prevaddrtractindex',ave82);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'propertyownedassessedtotal',ave83);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'recentupdate',ave84);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'ssnlength',ave85);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'timesincecurraddrfirstseen',ave86);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'timesincecurraddrlastseen',ave87);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'timesinceinputaddrfirstseen',ave88);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'timesinceinputaddrlastseen',ave89);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'timesincelastname',ave90);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'timesinceprevaddrfirstseen',ave91);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'timesinceprevaddrlastseen',ave92);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'timesincesubjectphonefirstseen',ave93);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'timesincesubjectphonelastseen',ave94);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__CurrAddrDwellType',ave95);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__InputAddrDwellType',ave96);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__InputAddrValidation',ave97);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__InputPhoneStatus',ave98);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__PrevAddrDwellType',ave99);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__StatusMostRecent',ave100);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__StatusNextPrevious',ave101);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__StatusPrevious',ave102);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__addrchangecount01',ave103);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__addrchangecount03',ave104);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__addrchangecount06',ave105);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__addrchangecount12',ave106);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__addrchangecount24',ave107);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__addrchangecount36',ave108);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__addrchangecount60',ave109);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__agenewestrecord',ave110);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ageoldestrecord',ave111);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__aircraftcount',ave112);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__aircraftcount01',ave113);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__aircraftcount03',ave114);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__aircraftcount06',ave115);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__aircraftcount12',ave116);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__aircraftcount24',ave117);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__aircraftcount36',ave118);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__aircraftcount60',ave119);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__arrestage',ave120);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__arrestcount',ave121);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__arrestcount01',ave122);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__arrestcount03',ave123);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__arrestcount06',ave124);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__arrestcount12',ave125);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__arrestcount24',ave126);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__arrestcount36',ave127);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__arrestcount60',ave128);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__bankruptcyage',ave129);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__bankruptcycount',ave130);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__bankruptcycount01',ave131);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__bankruptcycount03',ave132);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__bankruptcycount06',ave133);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__bankruptcycount12',ave134);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__bankruptcycount24',ave135);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__bankruptcycount36',ave136);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__bankruptcycount60',ave137);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__creditbureaurecord',ave138);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__curraddractivephonelist',ave139);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__curraddragelastsale',ave140);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__curraddrapplicantowned',ave141);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__curraddrfamilyowned',ave142);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__curraddrlandusecode',ave143);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__curraddroccupantowned',ave144);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__curraddrprison',ave145);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__currprevaddrstatediff',ave146);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__derogage',ave147);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__derogcount',ave148);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__derogseverityindex',ave149);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__educationattendedcollege',ave150);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__educationfieldofstudytype',ave151);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__educationinstitutionprivate',ave152);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__educationinstitutionrating',ave153);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__educationprogram2yr',ave154);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__educationprogram4yr',ave155);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__educationprogramgraduate',ave156);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__evictionage',ave157);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__evictioncount',ave158);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__evictioncount01',ave159);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__evictioncount03',ave160);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__evictioncount06',ave161);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__evictioncount12',ave162);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__evictioncount24',ave163);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__evictioncount36',ave164);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__evictioncount60',ave165);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__felonyage',ave166);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__felonycount',ave167);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__felonycount01',ave168);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__felonycount03',ave169);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__felonycount06',ave170);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__felonycount12',ave171);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__felonycount24',ave172);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__felonycount36',ave173);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__felonycount60',ave174);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__historicaladdrprison',ave175);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddractivephonelist',ave176);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddragelastsale',ave177);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddrapplicantowned',ave178);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddrfamilyowned',ave179);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddrhighrisk',ave180);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddridentitiescount',ave181);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddridentitiesrecentcount',ave182);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddrlandusecode',ave183);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddrnotprimaryres',ave184);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddroccupantowned',ave185);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddrphonecount',ave186);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddrphonerecentcount',ave187);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddrprison',ave188);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddrssncount',ave189);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputaddrssnrecentcount',ave190);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputareacodechange',ave191);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputcurraddrmatch',ave192);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputcurraddrstatediff',ave193);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputphonehighrisk',ave194);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputphonemobile',ave195);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputphonepager',ave196);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputphonetype',ave197);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputprevaddrmatch',ave198);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputzipcorpmil',ave199);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__inputzippobox',ave200);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__invalidaddr',ave201);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__invalidphone',ave202);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__invalidphonezip',ave203);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__invalidssn',ave204);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lastnamechangecount01',ave205);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lastnamechangecount03',ave206);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lastnamechangecount06',ave207);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lastnamechangecount12',ave208);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lastnamechangecount24',ave209);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lastnamechangecount36',ave210);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lastnamechangecount60',ave211);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__liencount',ave212);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienfiledage',ave213);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienfiledcount',ave214);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienfiledcount01',ave215);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienfiledcount03',ave216);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienfiledcount06',ave217);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienfiledcount12',ave218);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienfiledcount24',ave219);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienfiledcount36',ave220);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienfiledcount60',ave221);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienreleasedage',ave222);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienreleasedcount',ave223);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienreleasedcount01',ave224);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienreleasedcount03',ave225);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienreleasedcount06',ave226);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienreleasedcount12',ave227);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienreleasedcount24',ave228);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienreleasedcount36',ave229);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__lienreleasedcount60',ave230);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__nonderogcount',ave231);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__nonderogcount01',ave232);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__nonderogcount03',ave233);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__nonderogcount06',ave234);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__nonderogcount12',ave235);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__nonderogcount24',ave236);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__nonderogcount36',ave237);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__nonderogcount60',ave238);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__phoneidentitiescount',ave239);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__phoneidentitiesrecentcount',ave240);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__phoneother',ave241);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__phoneotheragenewestrecord',ave242);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__phoneotherageoldestrecord',ave243);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__predictedannualincome',ave244);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prevaddractivephonelist',ave245);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prevaddragelastsale',ave246);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prevaddrapplicantowned',ave247);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prevaddrfamilyowned',ave248);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prevaddrlandusecode',ave249);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prevaddroccupantowned',ave250);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prevaddrprison',ave251);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proflicage',ave252);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__profliccount',ave253);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__profliccount01',ave254);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__profliccount03',ave255);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__profliccount06',ave256);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__profliccount12',ave257);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__profliccount24',ave258);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__profliccount36',ave259);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__profliccount60',ave260);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proflicexpirecount01',ave261);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proflicexpirecount03',ave262);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proflicexpirecount06',ave263);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proflicexpirecount12',ave264);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proflicexpirecount24',ave265);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proflicexpirecount36',ave266);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proflicexpirecount60',ave267);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proflictypecategory',ave268);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__propagenewestpurchase',ave269);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__propagenewestsale',ave270);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__propageoldestpurchase',ave271);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__propnewestsalepurchaseindex',ave272);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__propownedcount',ave273);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__propownedhistoricalcount',ave274);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proppurchasedcount01',ave275);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proppurchasedcount03',ave276);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proppurchasedcount06',ave277);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proppurchasedcount12',ave278);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proppurchasedcount24',ave279);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proppurchasedcount36',ave280);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__proppurchasedcount60',ave281);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__propsoldcount01',ave282);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__propsoldcount03',ave283);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__propsoldcount06',ave284);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__propsoldcount12',ave285);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__propsoldcount24',ave286);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__propsoldcount36',ave287);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__propsoldcount60',ave288);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchcollectioncount',ave289);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchcollectioncount01',ave290);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchcollectioncount03',ave291);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchcollectioncount06',ave292);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchcollectioncount12',ave293);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchcollectioncount24',ave294);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchcollectioncount36',ave295);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchcollectioncount60',ave296);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchidvfraudcount',ave297);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchidvfraudcount01',ave298);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchidvfraudcount03',ave299);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchidvfraudcount06',ave300);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchidvfraudcount12',ave301);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchidvfraudcount24',ave302);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchidvfraudcount36',ave303);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchidvfraudcount60',ave304);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchothercount',ave305);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchothercount01',ave306);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchothercount03',ave307);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchothercount06',ave308);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchothercount12',ave309);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchothercount24',ave310);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchothercount36',ave311);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__prsearchothercount60',ave312);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__relativesbankruptcycount',ave313);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__relativescount',ave314);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__relativesdistanceclosest',ave315);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__relativesfelonycount',ave316);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__relativespropownedcount',ave317);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__relativespropownedtaxtotal',ave318);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__sfduaddridentitiescount',ave319);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__sfduaddrssncount',ave320);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__srcsconfirmidaddrcount',ave321);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssn3years',ave322);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssnaddrcount',ave323);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssnaddrrecentcount',ave324);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssnafter5',ave325);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssndeceased',ave326);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssnfoundother',ave327);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssnidentitiescount',ave328);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssnidentitiesrecentcount',ave329);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssnissued',ave330);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssnissuedpriordob',ave331);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssnlastnamecount',ave332);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssnnonus',ave333);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssnnotfound',ave334);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__ssnrecent',ave335);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subjectaddrcount',ave336);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subjectaddrrecentcount',ave337);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subjectlastnamecount',ave338);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subjectphonecount',ave339);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subjectphonerecentcount',ave340);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subjectssncount',ave341);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subjectssnrecentcount',ave342);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subprimesolicitedcount',ave343);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subprimesolicitedcount01',ave344);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subprimesolicitedcount03',ave345);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subprimesolicitedcount06',ave346);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subprimesolicitedcount12',ave347);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subprimesolicitedcount24',ave348);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subprimesolicitedcount36',ave349);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__subprimesolicitedcount60',ave350);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__verificationfailure',ave351);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__verifiedaddress',ave352);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__verifieddob',ave353);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__verifiedname',ave354);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__verifiedphone',ave355);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__verifiedphonefullname',ave356);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__verifiedphonelastname',ave357);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__verifiedssn',ave358);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__watercraftcount',ave359);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__watercraftcount01',ave360);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__watercraftcount03',ave361);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__watercraftcount06',ave362);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__watercraftcount12',ave363);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__watercraftcount24',ave364);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__watercraftcount36',ave365);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'v3__watercraftcount60',ave366);

Scoring_QA_New_Bins.ITAv3_new_bins.Average_func(DS2,'wealthindex',ave367);

    
                 
			
			
      	
      	   avearage:=  ave1+ave2+ave3+ave4+ave5+ave6+ave7+ave8+ave9+ave10+ave11+ave12+ave13+ave14+ave15+ave16+ave17+ave18+ave19+ave20+ave21+ave22+ave23+ave24+ave25+ave26+ave27+ave28+ave29+ave30+ave31+ave32+ave33+ave34+ave35+ave36+ave37+ave38+ave39+ave40+ave41+ave42+ave43+ave44+ave45+ave46+ave47+ave48+ave49+ave50+ave51+ave52+ave53+ave54+ave55+ave56+ave57+ave58+ave59+ave60+ave61+ave62+ave63+ave64+ave65+ave66+ave67+ave68+ave69+ave70+ave71+ave72+ave73+ave74+ave75+ave76+ave77+ave78+ave79+ave80+ave81+ave82+ave83+ave84+ave85+ave86+ave87+ave88+ave89+ave90+ave91+ave92+ave93+ave94+ave95+ave96+ave97+ave98+ave99+ave100+ave101+ave102+ave103+ave104+ave105+ave106+ave107+ave108+ave109+ave110+ave111+ave112+ave113+ave114+ave115+ave116+ave117+ave118+ave119+ave120+ave121+ave122+ave123+ave124+ave125+ave126+ave127+ave128+ave129+ave130+ave131+ave132+ave133+ave134+ave135+ave136+ave137+ave138+ave139+ave140+ave141+ave142+ave143+ave144+ave145+ave146+ave147+ave148+ave149+ave150+ave151+ave152+ave153+ave154+ave155+ave156+ave157+ave158+ave159+ave160+ave161+ave162+ave163+ave164+ave165+ave166+ave167+ave168+ave169+ave170+ave171+ave172+ave173+ave174+ave175+ave176+ave177+ave178+ave179+ave180+ave181+ave182+ave183+ave184+ave185+ave186+ave187+ave188+ave189+ave190+ave191+ave192+ave193+ave194+ave195+ave196+ave197+ave198+ave199+ave200+ave201+ave202+ave203+ave204+ave205+ave206+ave207+ave208+ave209+ave210+ave211+ave212+ave213+ave214+ave215+ave216+ave217+ave218+ave219+ave220+ave221+ave222+ave223+ave224+ave225+ave226+ave227+ave228+ave229+ave230+ave231+ave232+ave233+ave234+ave235+ave236+ave237+ave238+ave239+ave240+ave241+ave242+ave243+ave244+ave245+ave246+ave247+ave248+ave249+ave250+ave251+ave252+ave253+ave254+ave255+ave256+ave257+ave258+ave259+ave260+ave261+ave262+ave263+ave264+ave265+ave266+ave267+ave268+ave269+ave270+ave271+ave272+ave273+ave274+ave275+ave276+ave277+ave278+ave279+ave280+ave281+ave282+ave283+ave284+ave285+ave286+ave287+ave288+ave289+ave290+ave291+ave292+ave293+ave294+ave295+ave296+ave297+ave298+ave299+ave300+ave301+ave302+ave303+ave304+ave305+ave306+ave307+ave308+ave309+ave310+ave311+ave312+ave313+ave314+ave315+ave316+ave317+ave318+ave319+ave320+ave321+ave322+ave323+ave324+ave325+ave326+ave327+ave328+ave329+ave330+ave331+ave332+ave333+ave334+ave335+ave336+ave337+ave338+ave339+ave340+ave341+ave342+ave343+ave344+ave345+ave346+ave347+ave348+ave349+ave350+ave351+ave352+ave353+ave354+ave355+ave356+ave357+ave358+ave359+ave360+ave361+ave362+ave363+ave364+ave365+ave366+ave367;

	
		
				
	 
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
                                         self.file_version:='ITA_V3_Capone';
																				 self.mode:='batch';
																				 self.file_count:=count(file2_dedup),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='ITA_V3_Capone';
																				 self.mode:='batch';
																			   self.file_count:=count(file2_dedup),
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

		  did_results := DATASET([{'ITA_V3_Capone','batch','did','<DID not equal>',count(file1_dedup),count(file2_dedup),count(file2_dedup)-count(file1_dedup),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
											
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_outfile[2..] + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_outfile[2..] + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2);

return seq;
endmacro;