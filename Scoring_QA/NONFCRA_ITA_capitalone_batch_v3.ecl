EXPORT NONFCRA_ITA_capitalone_batch_v3(route,current_dt,previous_dt) := functionmacro



 file1_2:= dataset(route + scoring_project_pip.Output_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_ITA_BATCH_CapitalOne_attributes_v3_Global_Layout,


thor);

 file2_2:=dataset(route + scoring_project_pip.Output_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_ITA_BATCH_CapitalOne_attributes_v3_Global_Layout,


thor);


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
	 
	 

   	  	
      	
      	
      	Scoring_QA.Range_function_module.range_function_72(DS2,'v3__ageoldestrecord',ran1);
      	Scoring_QA.Range_function_module.range_function_71(DS2,'v3__agenewestrecord',ran2);		
				Scoring_QA.Range_function_module.range_function_92(DS2,'v3__ssndeceased',ran3);
       	Scoring_QA.Range_function_module.range_function_85(DS2,'v3__propageoldestpurchase',ran4);
				Scoring_QA.Range_function_module.range_function_84(DS2,'v3__propagenewestpurchase',ran5);
				Scoring_QA.Range_function_module.range_function_24(DS2,'v3__derogage',ran6);
				Scoring_QA.Range_function_module.range_function_77(DS2,'v3__felonyage',ran7);
		   	Scoring_QA.Range_function_module.range_function_73(DS2,'v3__arrestage',ran8);
				Scoring_QA.Range_function_module.range_function_302(DS2,'v3__lienfiledage',ran9);
				Scoring_QA.Range_function_module.range_function_64(DS2,'v3__lienreleasedage',ran10);
				Scoring_QA.Range_function_module.range_function_17(DS2,'v3__bankruptcyage',ran11);
				Scoring_QA.Range_function_module.range_function_75(DS2,'v3__evictionage',ran12);
			 	Scoring_QA.Range_function_module.range_function_71(DS2,'v3__proflicage',ran13);		  
      	Scoring_QA.Range_function_module.range_function_83(DS2,'v3__phoneotherageoldestrecord',ran14);
			 	Scoring_QA.Range_function_module.range_function_82(DS2,'v3__phoneotheragenewestrecord',ran15);
				Scoring_QA.Range_function_module.range_function_74(DS2,'v3__curraddragelastsale',ran16);
				Scoring_QA.Range_function_module.range_function_57(DS2,'v3__inputaddragelastsale',ran17);
			
				
			  	
      	ran:= ran1  + ran2  + ran3  + ran4  + ran5 + ran6   + ran7  + ran8  + ran9  + ran10 +
				     ran11 + ran12 + ran13 + ran14 + ran15 + ran16 + ran17 ;
      	
				  Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subjectssncount',ran0_1);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subjectaddrcount',ran0_2);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subjectphonecount',ran0_3);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subjectssnrecentcount',ran0_4);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subjectaddrrecentcount',ran0_5);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subjectphonerecentcount',ran0_6);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__ssnidentitiescount',ran0_7);
					Scoring_QA.Range_function_module.range_function_40(DS2,'v3__ssnaddrcount',ran0_8);
			    Scoring_QA.Range_function_module.range_function_76(DS2,'v3__ssnidentitiesrecentcount',ran0_9);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__ssnaddrrecentcount',ran0_10);
					Scoring_QA.Range_function_module.range_function_78(DS2,'v3__inputaddridentitiescount',ran0_11);
					Scoring_QA.Range_function_module.range_function_79(DS2,'v3__inputaddrssncount',ran0_12);
					Scoring_QA.Range_function_module.range_function_60(DS2,'v3__inputaddrphonecount',ran0_13);
					Scoring_QA.Range_function_module.range_function_78(DS2,'v3__inputaddridentitiesrecentcount',ran0_14);
					Scoring_QA.Range_function_module.range_function_61(DS2,'v3__inputaddrssnrecentcount',ran0_15);
					Scoring_QA.Range_function_module.range_function_69(DS2,'v3__inputaddrphonerecentcount',ran0_16);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__phoneidentitiescount',ran0_17);
				  Scoring_QA.Range_function_module.range_function_76(DS2,'v3__phoneidentitiesrecentcount',ran0_18);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__ssnlastnamecount',ran0_19);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__subjectlastnamecount',ran0_20);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lastnamechangecount01',ran0_21);
				  Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lastnamechangecount03',ran0_22);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lastnamechangecount06',ran0_23);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lastnamechangecount12',ran0_24);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lastnamechangecount24',ran0_25);
				  Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lastnamechangecount36',ran0_26);
		  		Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lastnamechangecount60',ran0_27);
			  	Scoring_QA.Range_function_module.range_function_79(DS2,'v3__sfduaddridentitiescount',ran0_28);
					Scoring_QA.Range_function_module.range_function_91(DS2,'v3__sfduaddrssncount',ran0_29);
				  Scoring_QA.Range_function_module.range_function_90(DS2,'v3__relativescount',ran0_30);
      	  Scoring_QA.Range_function_module.range_function_25(DS2,'v3__relativesbankruptcycount',ran0_31);
      	  Scoring_QA.Range_function_module.range_function_25(DS2,'v3__relativesfelonycount',ran0_32);
				  Scoring_QA.Range_function_module.range_function_47(DS2,'v3__relativespropownedcount',ran0_33);
			 	  // Scoring_QA.Range_function_module.Range_Function_0(DS2,'v3__inputaddravmconfidence',ran0_34);
				  // Scoring_QA.Range_function_module.Range_Function_0(DS2,'v3__curraddravmconfidence',ran0_35);
				  // Scoring_QA.Range_function_module.Range_Function_0(DS2,'v3__prevaddravmconfidence',ran0_36);
		   	  Scoring_QA.Range_function_module.range_function_40(DS2,'v3__addrchangecount01',ran0_37);
      	  Scoring_QA.Range_function_module.range_function_40(DS2,'v3__addrchangecount03',ran0_38);
			    Scoring_QA.Range_function_module.range_function_40(DS2,'v3__addrchangecount06',ran0_39);
				  Scoring_QA.Range_function_module.range_function_40(DS2,'v3__addrchangecount12',ran0_40);
      	  Scoring_QA.Range_function_module.range_function_40(DS2,'v3__addrchangecount24',ran0_41);
      	  Scoring_QA.Range_function_module.range_function_40(DS2,'v3__addrchangecount36',ran0_42);
				  Scoring_QA.Range_function_module.range_function_40(DS2,'v3__addrchangecount60',ran0_43);
					Scoring_QA.Range_function_module.range_function_51(DS2,'v3__propownedcount',ran0_44);
					Scoring_QA.Range_function_module.range_function_51(DS2,'v3__propownedhistoricalcount',ran0_45);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proppurchasedcount01',ran0_46);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proppurchasedcount03',ran0_47);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proppurchasedcount06',ran0_48);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proppurchasedcount12',ran0_49);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proppurchasedcount24',ran0_50);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proppurchasedcount36',ran0_51);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proppurchasedcount60',ran0_52);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__propsoldcount01',ran0_53);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__propsoldcount03',ran0_54);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__propsoldcount06',ran0_55);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__propsoldcount12',ran0_56);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__propsoldcount24',ran0_57);
				  Scoring_QA.Range_function_module.range_function_76(DS2,'v3__propsoldcount36',ran0_58);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__propsoldcount60',ran0_59);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__watercraftcount',ran0_60);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__watercraftcount01',ran0_61);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'v3__watercraftcount03',ran0_62);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__watercraftcount06',ran0_63);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__watercraftcount12',ran0_64);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__watercraftcount24',ran0_65);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'v3__watercraftcount36',ran0_66);
		  		Scoring_QA.Range_function_module.range_function_31(DS2,'v3__watercraftcount60',ran0_67);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__aircraftcount',ran0_68);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__aircraftcount01',ran0_69);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__aircraftcount03',ran0_70);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__aircraftcount06',ran0_71);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__aircraftcount12',ran0_72);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__aircraftcount24',ran0_73);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__aircraftcount36',ran0_74);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__aircraftcount60',ran0_75);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subprimesolicitedcount',ran0_76);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subprimesolicitedcount01',ran0_77);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subprimesolicitedcount03',ran0_78);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subprimesolicitedcount06',ran0_79);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subprimesolicitedcount12',ran0_80);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subprimesolicitedcount24',ran0_81);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subprimesolicitedcount36',ran0_82);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__subprimesolicitedcount60',ran0_83);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__felonycount',ran0_84);
					// Scoring_QA.Range_function_module.Range_Function_0(DS2,'v3__derogcount',ran0_85);
			    Scoring_QA.Range_function_module.range_function_76(DS2,'v3__felonycount01',ran0_86);
		  		Scoring_QA.Range_function_module.range_function_76(DS2,'v3__felonycount03',ran0_87);
			    Scoring_QA.Range_function_module.range_function_76(DS2,'v3__felonycount06',ran0_88);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__felonycount12',ran0_89);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__felonycount24',ran0_90);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__felonycount36',ran0_91);
				  Scoring_QA.Range_function_module.range_function_76(DS2,'v3__felonycount60',ran0_92);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__arrestcount',ran0_93);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__arrestcount01',ran0_94);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__arrestcount03',ran0_95);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__arrestcount06',ran0_96);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__arrestcount12',ran0_97);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__arrestcount24',ran0_98);
			    Scoring_QA.Range_function_module.range_function_31(DS2,'v3__arrestcount36',ran0_99);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__arrestcount60',ran0_100);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__liencount',ran0_101);
			    Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lienfiledcount',ran0_102);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lienfiledcount01',ran0_103);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lienfiledcount03',ran0_104);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lienfiledcount06',ran0_105);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lienfiledcount12',ran0_106);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lienfiledcount24',ran0_107);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lienfiledcount36',ran0_108);
			    Scoring_QA.Range_function_module.range_function_76(DS2,'v3__lienfiledcount60',ran0_109);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__lienreleasedcount',ran0_110);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__lienreleasedcount01',ran0_111);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'v3__lienreleasedcount03',ran0_112);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__lienreleasedcount06',ran0_113);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__lienreleasedcount12',ran0_114);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__lienreleasedcount24',ran0_115);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__lienreleasedcount36',ran0_116);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__lienreleasedcount60',ran0_117);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__bankruptcycount',ran0_118);
				  Scoring_QA.Range_function_module.range_function_25(DS2,'v3__bankruptcycount01',ran0_119);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__bankruptcycount03',ran0_120);
				  Scoring_QA.Range_function_module.range_function_25(DS2,'v3__bankruptcycount06',ran0_121);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__bankruptcycount12',ran0_122);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__bankruptcycount24',ran0_123);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__bankruptcycount36',ran0_124);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__bankruptcycount60',ran0_125);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__evictioncount',ran0_126);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__evictioncount01',ran0_127);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__evictioncount03',ran0_128);
			    Scoring_QA.Range_function_module.range_function_25(DS2,'v3__evictioncount06',ran0_129);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__evictioncount12',ran0_130);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__evictioncount24',ran0_131);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__evictioncount36',ran0_132);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__evictioncount60',ran0_133);
					Scoring_QA.Range_function_module.range_function_80(DS2,'v3__nonderogcount',ran0_134);
					Scoring_QA.Range_function_module.range_function_51(DS2,'v3__nonderogcount01',ran0_135);
					Scoring_QA.Range_function_module.range_function_46(DS2,'v3__nonderogcount03',ran0_136);
					Scoring_QA.Range_function_module.range_function_46(DS2,'v3__nonderogcount06',ran0_137);
					Scoring_QA.Range_function_module.range_function_46(DS2,'v3__nonderogcount12',ran0_138);
			    Scoring_QA.Range_function_module.range_function_43(DS2,'v3__nonderogcount24',ran0_139);
					Scoring_QA.Range_function_module.range_function_39(DS2,'v3__nonderogcount36',ran0_140);
					Scoring_QA.Range_function_module.range_function_81(DS2,'v3__nonderogcount60',ran0_141);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__profliccount',ran0_142);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__profliccount01',ran0_143);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__profliccount03',ran0_144);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__profliccount06',ran0_145);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__profliccount12',ran0_146);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__profliccount24',ran0_147);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__profliccount36',ran0_148);
			    Scoring_QA.Range_function_module.range_function_76(DS2,'v3__profliccount60',ran0_149);
					// Scoring_QA.Range_function_module.Range_Function_0(DS2,'v3__profliccount60',ran0_150);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proflicexpirecount01',ran0_151);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proflicexpirecount03',ran0_152);
				  Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proflicexpirecount06',ran0_153);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proflicexpirecount12',ran0_154);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proflicexpirecount24',ran0_155);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proflicexpirecount36',ran0_156);
					Scoring_QA.Range_function_module.range_function_76(DS2,'v3__proflicexpirecount60',ran0_157);
					Scoring_QA.Range_function_module.range_function_86(DS2,'v3__prsearchcollectioncount',ran0_158);
			    Scoring_QA.Range_function_module.range_function_87(DS2,'v3__prsearchcollectioncount01',ran0_159);
					Scoring_QA.Range_function_module.range_function_87(DS2,'v3__prsearchcollectioncount03',ran0_160);
					Scoring_QA.Range_function_module.range_function_87(DS2,'v3__prsearchcollectioncount06',ran0_161);
					Scoring_QA.Range_function_module.range_function_87(DS2,'v3__prsearchcollectioncount12',ran0_162);
					Scoring_QA.Range_function_module.range_function_87(DS2,'v3__prsearchcollectioncount24',ran0_163);
					Scoring_QA.Range_function_module.range_function_87(DS2,'v3__prsearchcollectioncount36',ran0_164);
					Scoring_QA.Range_function_module.range_function_87(DS2,'v3__prsearchcollectioncount60',ran0_165);
					Scoring_QA.Range_function_module.range_function_25(DS2,'v3__prsearchidvfraudcount',ran0_166);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__prsearchidvfraudcount01',ran0_167);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__prsearchidvfraudcount03',ran0_168);
			    Scoring_QA.Range_function_module.range_function_31(DS2,'v3__prsearchidvfraudcount06',ran0_169);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__prsearchidvfraudcount12',ran0_170);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__prsearchidvfraudcount24',ran0_171);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__prsearchidvfraudcount36',ran0_172);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__prsearchidvfraudcount60',ran0_173);
					Scoring_QA.Range_function_module.range_function_87(DS2,'v3__prsearchothercount',ran0_174);
					Scoring_QA.Range_function_module.range_function_31(DS2,'v3__prsearchothercount01',ran0_175);
					Scoring_QA.Range_function_module.range_function_51(DS2,'v3__prsearchothercount03',ran0_176);
					Scoring_QA.Range_function_module.range_function_33(DS2,'v3__prsearchothercount06',ran0_177);
					Scoring_QA.Range_function_module.range_function_33(DS2,'v3__prsearchothercount12',ran0_178);
			    Scoring_QA.Range_function_module.range_function_32(DS2,'v3__prsearchothercount24',ran0_179);
					Scoring_QA.Range_function_module.range_function_88(DS2,'v3__prsearchothercount36',ran0_180);
					Scoring_QA.Range_function_module.range_function_89(DS2,'v3__prsearchothercount60',ran0_181);		
						
						
					 	 ran_0:=   ran0_1  + ran0_2  + ran0_3  + ran0_4  + ran0_5  + ran0_6  + ran0_7  + ran0_8  + ran0_9  + ran0_10 +
				               ran0_11 + ran0_12 + ran0_13 + ran0_14 + ran0_15 + ran0_16 + ran0_17 + ran0_18 + ran0_19 + ran0_20 +
						           ran0_21 + ran0_22 + ran0_23 + ran0_24 + ran0_25 + ran0_26 + ran0_27 + ran0_28 + ran0_29 + ran0_30 +
				               ran0_31 + ran0_32 + ran0_33  + ran0_37 + ran0_38 + ran0_39 + ran0_40 +
				               ran0_41 + ran0_42 + ran0_43 + ran0_44 + ran0_45 + ran0_46 + ran0_47 + ran0_48 + ran0_49 + ran0_50 +
                       ran0_51 + ran0_52 + ran0_53 + ran0_54 + ran0_55 + ran0_56 + ran0_57 + ran0_58 + ran0_59 + ran0_60 +
                       ran0_61 + ran0_62 + ran0_63 + ran0_64 + ran0_65 + ran0_66 + ran0_67 + ran0_68 + ran0_69 + ran0_70 + 
                       ran0_71 + ran0_72 + ran0_73 + ran0_74 + ran0_75 + ran0_76 + ran0_77 + ran0_78 + ran0_79 + ran0_80 + 
                       ran0_81 + ran0_82 + ran0_83 + ran0_84 + ran0_86 + ran0_87 + ran0_88 + ran0_89 + ran0_90 + 
					             ran0_91 + ran0_92 + ran0_93 + ran0_94 + ran0_95 + ran0_96 + ran0_97 + ran0_98 + ran0_99 + ran0_100 + 
				               ran0_101 + ran0_102 + ran0_103 + ran0_104 + ran0_105 + ran0_106 + ran0_107 + ran0_108 + ran0_109 + ran0_110 + 
											 ran0_111 + ran0_112 + ran0_113 + ran0_114 + ran0_115 + ran0_116 + ran0_117 + ran0_118 + ran0_119 + ran0_120 +
											 ran0_121 + ran0_122 + ran0_123 + ran0_124 + ran0_125 + ran0_126 + ran0_127 + ran0_128 + ran0_129 + ran0_130 +
				               ran0_131 + ran0_132 + ran0_133 + ran0_134 + ran0_135 + ran0_136 + ran0_137 + ran0_138 + ran0_139 + ran0_140 +
				               ran0_141 + ran0_142 + ran0_143 + ran0_144 + ran0_145 + ran0_146 + ran0_147 + ran0_148 + ran0_149  +
                       ran0_151 + ran0_152 + ran0_153 + ran0_154 + ran0_155 + ran0_156 + ran0_157 + ran0_158 + ran0_159 + ran0_160 +
                       ran0_161 + ran0_162 + ran0_163 + ran0_164 + ran0_165 + ran0_166 + ran0_167 + ran0_168 + ran0_169 + ran0_170 + 
                       ran0_171 + ran0_172 + ran0_173 + ran0_174 + ran0_175 + ran0_176 + ran0_177 + ran0_178 + ran0_179 + ran0_180 + 
                       ran0_181;
								 
			
								
								Scoring_QA.Range_function_module.Range_Function_1(DS2,'v3__propnewestsalepurchaseindex',ran1_10);
											
						
											 
											
											 
											 ran_1:=ran1_10;
				
								 Scoring_QA.Range_function_module.range_function_43(DS2,'v3__srcsconfirmidaddrcount',ran2_1);
								
							      	
											 
											 					 ran_2:=ran2_1;
								 
								
								 
								 // Scoring_QA.Range_function_module.Range_Function_5(DS2,'v3__inputaddrmurderindex',ran5_1);
								 // Scoring_QA.Range_function_module.Range_Function_5(DS2,'v3__inputaddrcartheftindex',ran5_2);
								 // Scoring_QA.Range_function_module.Range_Function_5(DS2,'v3__inputaddrburglaryindex',ran5_3);
								 // Scoring_QA.Range_function_module.Range_Function_5(DS2,'v3__inputaddrcrimeindex',ran5_4);
								 // Scoring_QA.Range_function_module.Range_Function_5(DS2,'v3__curraddrmurderindex',ran5_5);
								 // Scoring_QA.Range_function_module.Range_Function_5(DS2,'v3__curraddrcartheftindex',ran5_6);
								 // Scoring_QA.Range_function_module.Range_Function_5(DS2,'v3__curraddrburglaryindex',ran5_7);
								 // Scoring_QA.Range_function_module.Range_Function_5(DS2,'v3__curraddrcrimeindex',ran5_8);
								 // Scoring_QA.Range_function_module.Range_Function_5(DS2,'v3__prevaddrmurderindex',ran5_9);
								 // Scoring_QA.Range_function_module.Range_Function_5(DS2,'v3__prevaddrcartheftindex',ran5_10);
								 // Scoring_QA.Range_function_module.Range_Function_5(DS2,'v3__prevaddrburglaryindex',ran5_11);
								 // Scoring_QA.Range_function_module.Range_Function_5(DS2,'v3__prevaddrcrimeindex',ran5_12);
									
									
										 // ran_5:=ran5_1  + ran5_2  + ran5_3  + ran5_4  + ran5_5  + ran5_6  + ran5_7  + ran5_8  + ran5_9  + ran5_10 +
				                   // ran5_11 + ran5_12;
													 
										 		  
													
										  // Scoring_QA.Range_function_module.Range_Function_6(DS2,'v3__inputcurraddrcrimediff',ran6_1);
								      // Scoring_QA.Range_function_module.Range_Function_6(DS2,'v3__currprevaddrcrimediff',ran6_2);
								 
								 	 // ran_6:=ran6_1+ ran6_2;
									 
									Scoring_QA.Range_function_module.range_function_24(DS2,'v3__derogcount',ran7_1);
								  // RiskView_Attributes_ReportsRange_Function_7(DS2,'v3__derogrecentcount',ran7_2);
									
								 
								 ran_7:=ran7_1; 
							
										  				
				// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__recentupdate',dis1);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__creditbureaurecord',dis2);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__verificationfailure',dis3);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__invalidssn',dis4);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__invalidaddr',dis5);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__invalidphone',dis6);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__verificationfailure',dis7);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__ssnnotfound',dis8);
					Scoring_QA.Range_function_module.range_function_92(DS2,'v3__ssnfoundother',dis9);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__verifiedname',dis10);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__verifiedssn',dis11);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__verifiedphone',dis12);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__verifiedphonefullname',dis13);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__verifiedphonelastname',dis14);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__verifiedaddress',dis15);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__verifieddob',dis16);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__ageriskindicator',dis17);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__phoneother',dis18);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__ssnrecent',dis19);
				  // Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__ssnlowissuedate',dis20);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__ssnhighissuedate',dis21);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__ssnissuestate',dis22);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnissuestate',dis22);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__ssnnonus',dis23);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__ssnissuedpriordob',dis24);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__ssn3years',dis25);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__ssnafter5',dis26);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__ssnproblems',dis27);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__relativesdistanceclosest',dis28);
			    Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputaddrdwelltype',dis29);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputaddrlandusecode',dis30);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputaddrapplicantowned',dis31);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputaddrfamilyowned',dis32);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputaddroccupantowned',dis33);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputaddrnotprimaryres',dis34);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputaddractivephonelist',dis35);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputaddrtaxyr',dis36);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__curraddrtaxyr',dis37);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__curraddrdwelltype',dis38);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__curraddrlandusecode',dis39);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__curraddrapplicantowned',dis40);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__curraddrfamilyowned',dis41);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__curraddroccupantowned',dis42);
	        Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__prevaddrdwelltype',dis43);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__prevaddrlandusecode',dis44);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__prevaddrapplicantowned',dis45);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__prevaddrfamilyowned',dis46);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__prevaddroccupantowned',dis47);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__prevaddrtaxyr',dis48);
			  	Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputcurraddrmatch',dis49);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputcurraddrstatediff',dis50);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputcurrecontrajectory',dis51);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputprevaddrmatch',dis52);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__currprevaddrstatediff',dis53);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__prevcurrecontrajectory',dis54);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__educationattendedcollege',dis55);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__educationprogram2yr',dis56);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__educationprogram4yr',dis57);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__educationprogramgraduate',dis58);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__educationinstitutionprivate',dis59);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__educationinstitutionrating',dis60);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__educationfieldofstudytype',dis61);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__addrstability',dis62);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__statusmostrecent',dis63);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__statusprevious',dis64);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__statusnextprevious',dis65);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__wealthindex',dis66);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__derogseverityindex',dis67);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__bankruptcytype',dis68);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__bankruptcystatus',dis69);
          Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__proflictypecategory',dis70);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__proflicexpiredate',dis71);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputphonestatus',dis72);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputphonepager',dis73);	
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputphonemobile',dis74);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputphonetype',dis75);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputphoneservicetype',dis76);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputareacodechange',dis77);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__invalidphonezip',dis78);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__ssndatedeceased',dis79);
				  // Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputaddrsiccode',dis80);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputaddrvalidation',dis81);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputaddrerrorcode',dis82);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputaddrhighrisk',dis83);	
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputphonehighrisk',dis84);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputaddrprison',dis85);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__curraddrprison',dis86);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__prevaddrprison',dis87);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__historicaladdrprison',dis88);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputzippobox',dis89);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__inputzipcorpmil',dis90);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__donotmail',dis91);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'v3__ssnissued',dis92);
					
					Scoring_QA.Range_function_module.Distinct_function(DS2,'fnamepop',dis94);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'lnamepop',dis95);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'addrpop',dis96);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnlength',dis97);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'dobpop',dis98);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'emailpop',dis99);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ipaddrpop',dis100);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'hphnpop',dis101); 
					
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'addrchanges12',dis103);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'addrchanges180',dis104);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'addrchanges24',dis105);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'addrchanges30',dis106);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'addrchanges36',dis107);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'addrchanges60',dis108);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'addrchanges90',dis109);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'addrperid',dis110);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'addrperid6',dis111);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'addrperssn',dis112);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'addrperssn6',dis113);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'addrval',dis114);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'areacodechange',dis115);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'bankruptcount',dis116);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'bankruptcount12',dis117);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'bankruptcount180',dis118);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'bankruptcount24',dis119);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'bankruptcount30',dis120);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'bankruptcount36',dis121);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'bankruptcount60',dis122);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'bankruptcount90',dis123);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'curraddractivephonelist',dis124);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'curraddrapplicantowned',dis125);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'curraddrdwelltype',dis126);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'curraddrfamilyowned',dis127);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'curraddrnotprimaryres',dis128);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'curraddroccupantowned',dis129);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'curraddrlandusecode',dis130);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'curraddrprevaddrstatediff',dis131);
// Scoring_QA.Range_function_module.distinct_Function_247(DS2,'emailpop',dis132);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'evictioncount',dis133);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'evictioncount12',dis134);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'evictioncount180',dis135);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'evictioncount24',dis136);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'evictioncount30',dis137);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'evictioncount36',dis138);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'evictioncount60',dis139);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'evictioncount90',dis140);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'idperaddr',dis141);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'idperaddr6',dis142);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'idperphone',dis143);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'idperphone6',dis144);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'idpersfduaddr',dis145);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'idperssn',dis146);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'idperssn6',dis147);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputaddractivephonelist',dis148);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputaddrapplicantowned',dis149);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputaddrcurraddrmatch',dis150);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputaddrcurraddrstatediff',dis151);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputaddrfamilyowned',dis152);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputaddrhighrisk',dis153);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputaddrlandusecode',dis154);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputaddrnotprimaryres',dis155);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputaddroccupantowned',dis156);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputaddrprevaddrmatch',dis157);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'curraddroccupantowned',dis158);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputphoneaddrdist',dis159);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputphonehighrisk',dis160);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputphonemobile',dis161);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputphonepager',dis162);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputphonestatus',dis163);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputzipcorpmil',dis164);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'inputzippobox',dis165);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'invalidaddr',dis166);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'invalidphone',dis167);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'invalidphonezip',dis168);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'invalidssn',dis169);
// Scoring_QA.Range_function_module.distinct_Function_247(DS2,'ipaddrpop',dis170);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'lastnameperid',dis171);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'lastnameperssn',dis172);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'lastnames12',dis173);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'lastnames180',dis174);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'lastnames24',dis175);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'lastnames30',dis176);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'lastnames36',dis177);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'lastnames60',dis178);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'lastnames90',dis179);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'lienscount',dis180);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensreleasedcount',dis181);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensreleasedcount12',dis182);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensreleasedcount180',dis183);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensreleasedcount24',dis184);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensreleasedcount30',dis185);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensreleasedcount36',dis186);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensreleasedcount60',dis187);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensreleasedcount90',dis188);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensunreleasedcount',dis189);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensunreleasedcount12',dis190);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensunreleasedcount180',dis191);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensunreleasedcount24',dis192);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensunreleasedcount30',dis193);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensunreleasedcount36',dis194);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensunreleasedcount60',dis195);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'liensunreleasedcount90',dis196);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'mostrecentbankrupttype',dis197);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'nonderogsrccount',dis198);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'nonderogsrccount12',dis199);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'nonderogsrccount180',dis200);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'nonderogsrccount24',dis201);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'nonderogsrccount30',dis202);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'nonderogsrccount36',dis203);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'nonderogsrccount60',dis204);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'nonderogsrccount90',dis205);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'nonusssn',dis206);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'noverifynameaddrphonessn',dis207);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numaircraft',dis208);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numaircraft12',dis209);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numaircraft180',dis210);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numaircraft24',dis211);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numaircraft30',dis212);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numaircraft36',dis213);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numaircraft60',dis214);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numaircraft90',dis215);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numarrests',dis216);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numarrests12',dis217);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numarrests180',dis218);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numarrests24',dis219);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numarrests30',dis220);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numarrests36',dis221);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numarrests60',dis222);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numarrests90',dis223);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numfelonies',dis224);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numfelonies12',dis225);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numfelonies180',dis226);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numfelonies24',dis227);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numfelonies30',dis228);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numfelonies36',dis229);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numfelonies60',dis230);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numfelonies90',dis231);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numsrcsconfirmidaddr',dis232);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numwatercraft',dis233);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numwatercraft12',dis234);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numwatercraft180',dis235);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numwatercraft24',dis236);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numwatercraft30',dis237);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numwatercraft36',dis238);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numwatercraft60',dis239);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'numwatercraft90',dis240);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'phonefullnamematch',dis241);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'phonelastnamematch',dis242);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'phoneother',dis243);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'phoneperaddr',dis244);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'phoneperaddr6',dis245);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'phonetype',dis246);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'prevaddrdwelltype',dis247);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'prevaddrfamilyowned',dis248);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'prevaddrnotprimaryres',dis249);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'prevaddroccupantowned',dis250);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'profliccount',dis251);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'profliccount12',dis252);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'profliccount180',dis253);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'profliccount24',dis254);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'profliccount30',dis255);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'profliccount36',dis256);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'profliccount60',dis257);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'profliccount90',dis258);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proflicexpirecount12',dis259);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proflicexpirecount180',dis260);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proflicexpirecount24',dis261);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proflicexpirecount30',dis262);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proflicexpirecount36',dis263);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proflicexpirecount60',dis264);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proflicexpirecount90',dis265);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'propertyhistoricallyowned',dis266);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proppurchased12',dis267);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proppurchased180',dis268);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proppurchased24',dis269);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proppurchased30',dis270);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proppurchased36',dis271);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proppurchased60',dis272);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'proppurchased90',dis273);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'propsold12',dis274);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'propsold180',dis275);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'propsold24',dis276);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'propsold30',dis277);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'propsold36',dis278);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'propsold60',dis279);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'propsold90',dis280);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'reason1',dis281);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'reason2',dis282);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'reason3',dis283);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'reason4',dis284);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'reason5',dis285);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'reason6',dis286);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'recentssn',dis287);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'score1',dis288);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'scorename1',dis289);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'servicetype',dis290);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'ssn3years',dis291);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'ssnafter5',dis292);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'ssndeceased',dis293);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'ssnfoundother',dis294);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'ssnissued',dis295);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'ssnissuedprior',dis296);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'ssnnotfound',dis297);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'ssnperaddr',dis298);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'ssnperaddr6',dis299);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'ssnpersfduaddr',dis300);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'totalnumberderogs',dis301);
Scoring_QA.Range_function_module.range_Function_293(DS2,'curraddrpriceindval',dis302);
Scoring_QA.Range_function_module.range_Function_293(DS2,'curraddrtaxassessval',dis303);
Scoring_QA.Range_function_module.distinct_Function_248(DS2,'addrstability',dis304);
  Scoring_QA.Range_function_module.distinct_Function_249(DS2,'addrvalerrorcode',dis305);
Scoring_QA.Range_function_module.distinct_Function_251(DS2,'ageriskindicator',dis306);
Scoring_QA.Range_function_module.range_Function_250(DS2,'curraddrassessedvalue',dis307);
Scoring_QA.Range_function_module.range_Function_250(DS2,'curraddrassessmarket',dis308);
Scoring_QA.Range_function_module.range_Function_250(DS2,'curraddrlastsalesamount',dis309);
Scoring_QA.Range_function_module.range_Function_253(DS2,'curraddrautoval',dis310);
Scoring_QA.Range_function_module.range_Function_253(DS2,'curraddrhedval',dis311);
Scoring_QA.Range_function_module.range_function_290(DS2,'curraddrconfscore',dis312);
Scoring_QA.Range_function_module.range_function_295(DS2,'inputaddrconfscore',dis313);
Scoring_QA.Range_function_module.range_Function_255(DS2,'curraddrmedianhomeval',dis314);
Scoring_QA.Range_function_module.range_Function_256(DS2,'curraddrlenofres',dis315);
Scoring_QA.Range_function_module.range_Function_287(DS2,'donotmail',dis316);
Scoring_QA.Range_function_module.range_function_246(DS2,'economictrajectory',dis317);
Scoring_QA.Range_function_module.range_function_246(DS2,'economictrajectory2',dis318);
Scoring_QA.Range_function_module.range_function_263(DS2,'inputaddrassessedvalue',dis319);
Scoring_QA.Range_function_module.range_function_263(DS2,'inputaddrassessmarket',dis320);
Scoring_QA.Range_function_module.range_Function_294(DS2,'inputaddrautoval',dis321);
Scoring_QA.Range_function_module.range_function_264(DS2,'inputaddrcurraddrassesseddiff',dis322);
Scoring_QA.Range_function_module.range_function_264(DS2,'inputaddrcurraddrcrimediff',dis323);
Scoring_QA.Range_function_module.range_function_264(DS2,'inputaddrcurraddrhomevaldiff',dis324);
Scoring_QA.Range_function_module.range_function_264(DS2,'inputaddrcurraddrincomediff',dis325);
Scoring_QA.Range_function_module.range_function_265(DS2,'inputaddrcurraddrdistance',dis326);
Scoring_QA.Range_function_module.range_function_266(DS2,'inputaddrdwelltype',dis327);
Scoring_QA.Range_function_module.range_Function_267(DS2,'inputaddrhedval',dis328);
Scoring_QA.Range_function_module.range_Function_267(DS2,'inputaddrmedianhomeval',dis329);
Scoring_QA.Range_function_module.range_Function_268(DS2,'inputaddrlastsalesamount',dis330);
Scoring_QA.Range_function_module.range_Function_268(DS2,'prevaddrpriceindval',dis331);
Scoring_QA.Range_function_module.range_Function_268(DS2,'prevaddrtaxassessval',dis332);
Scoring_QA.Range_function_module.range_Function_268(DS2,'propertyownedassessedtotal',dis333);
Scoring_QA.Range_function_module.range_Function_269(DS2,'inputaddrlenofres',dis334);
Scoring_QA.Range_function_module.range_function_296(DS2,'inputaddrmedianincome',dis335);
Scoring_QA.Range_function_module.range_Function_271(DS2,'inputaddrpriceindval',dis336);
Scoring_QA.Range_function_module.range_Function_272(DS2,'inputaddrtaxassessval',dis337);

Scoring_QA.Range_function_module.range_Function_274(DS2,'prevaddractivephonenumber',dis339);
Scoring_QA.Range_function_module.range_Function_250(DS2,'prevaddrassessedvalue',dis340);
Scoring_QA.Range_function_module.range_function_262(DS2,'prevaddrassessmarket',dis341);
Scoring_QA.Range_function_module.range_Function_267(DS2,'prevaddrautoval',dis342);
Scoring_QA.Range_function_module.range_Function_297(DS2,'prevaddrconfscore',dis343);
Scoring_QA.Range_function_module.range_Function_276(DS2,'prevaddrhedval',dis344);
Scoring_QA.Range_function_module.range_Function_276(DS2,'prevaddrlastsalesamount',dis345);
Scoring_QA.Range_function_module.range_Function_298(DS2,'prevaddrlenofres',dis346);
Scoring_QA.Range_function_module.range_Function_267(DS2,'prevaddrmedianhomeval',dis347);
Scoring_QA.Range_function_module.range_Function_280(DS2,'ssnprobs',dis348);
Scoring_QA.Range_function_module.range_Function_281(DS2,'statusmostrecent',dis349);
Scoring_QA.Range_function_module.range_Function_281(DS2,'statusnextprevious',dis350);
Scoring_QA.Range_function_module.range_Function_281(DS2,'statusprevious',dis351);
Scoring_QA.Range_function_module.range_Function_282(DS2,'timesincecurraddrfirstseen',dis352);
Scoring_QA.Range_function_module.range_Function_282(DS2,'timesinceinputaddrfirstseen',dis353);
Scoring_QA.Range_function_module.range_Function_282(DS2,'timesincelastname',dis354);
Scoring_QA.Range_function_module.range_Function_282(DS2,'timesinceprevaddrfirstseen',dis355);
Scoring_QA.Range_function_module.range_Function_300(DS2,'timesinceprevaddrlastseen',dis356);
 Scoring_QA.Range_function_module.range_Function_285(DS2,'timesincesubjectphonefirstseen',dis357);
 Scoring_QA.Range_function_module.range_Function_285(DS2,'timesincesubjectphonelastseen',dis358);
 // Scoring_QA.Range_function_module.range_Function_336(DS2,'timesincesubjectphonelastseen',dis358);
 Scoring_QA.Range_function_module.range_Function_283(DS2,'timesincecurraddrlastseen',dis359);
Scoring_QA.Range_function_module.range_Function_283(DS2,'timesinceinputaddrlastseen',dis360);
Scoring_QA.Range_function_module.range_Function_288(DS2,'prevaddrlandusecode',dis361);
Scoring_QA.Range_function_module.range_Function_287(DS2,'recentupdate',dis362);
Scoring_QA.Range_function_module.range_Function_299(DS2,'prevaddrmedianincome',dis363);
Scoring_QA.Range_function_module.range_Function_291(DS2,'curraddrmedianincome',dis364);
Scoring_QA.Range_function_module.range_Function_252(DS2,'curraddrblockindex',dis365);
Scoring_QA.Range_function_module.range_Function_289(DS2,'curraddrcartheftindex',dis366);
Scoring_QA.Range_function_module.range_Function_289(DS2,'curraddrburglaryindex',dis367);
Scoring_QA.Range_function_module.range_Function_252(DS2,'curraddrcountyindex',dis368);
Scoring_QA.Range_function_module.range_Function_289(DS2,'curraddrcrimeindex',dis369);
Scoring_QA.Range_function_module.range_Function_289(DS2,'curraddrmurderindex',dis370);
Scoring_QA.Range_function_module.range_Function_252(DS2,'curraddrtractindex',dis371);
Scoring_QA.Range_function_module.range_Function_252(DS2,'inputaddrblockindex',dis372);
Scoring_QA.Range_function_module.range_Function_289(DS2,'inputaddrburglaryindex',dis373);
Scoring_QA.Range_function_module.range_Function_289(DS2,'inputaddrcartheftindex',dis374);
Scoring_QA.Range_function_module.range_Function_252(DS2,'inputaddrcountyindex',dis375);
Scoring_QA.Range_function_module.range_Function_289(DS2,'inputaddrcrimeindex',dis376);
Scoring_QA.Range_function_module.range_Function_289(DS2,'inputaddrmurderindex',dis377);
Scoring_QA.Range_function_module.range_Function_252(DS2,'inputaddrtractindex',dis378);
Scoring_QA.Range_function_module.range_Function_252(DS2,'prevaddrblockindex',dis379);
Scoring_QA.Range_function_module.range_Function_289(DS2,'prevaddrburglaryindex',dis380);
Scoring_QA.Range_function_module.range_Function_289(DS2,'prevaddrcartheftindex',dis381);
Scoring_QA.Range_function_module.range_Function_252(DS2,'prevaddrcountyindex',dis382);
Scoring_QA.Range_function_module.range_Function_289(DS2,'prevaddrcrimeindex',dis383);
Scoring_QA.Range_function_module.range_Function_289(DS2,'prevaddrmurderindex',dis384);
Scoring_QA.Range_function_module.range_Function_252(DS2,'prevaddrtractindex',dis385);
Scoring_QA.Range_function_module.distinct_Function_301(DS2,'wealthindex',dis386);
Scoring_QA.Range_function_module.range_Function_258(DS2,'curraddrprevaddrassesseddiff',dis387);
Scoring_QA.Range_function_module.range_Function_259(DS2,'curraddrprevaddrcrimediff',dis388);
Scoring_QA.Range_function_module.range_function_292(DS2,'curraddrprevaddrdistance',dis389);
Scoring_QA.Range_function_module.range_Function_286(DS2,'curraddrprevaddrhomevaldiff',dis390);
Scoring_QA.Range_function_module.range_function_261(DS2,'curraddrprevaddrincomediff',dis391);
Scoring_QA.Range_function_module.range_function_279(DS2,'sic',dis392);
Scoring_QA.Range_function_module.range_Function_273(DS2,'mostrecentbankruptstatus',dis393);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'phoneperid',dis394);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'phoneperid6',dis395);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'prevaddractivephonelist',dis396);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'prevaddrapplicantowned',dis397);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'propertyownedtotal',dis398);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'ssnperid',dis399);
Scoring_QA.Range_function_module.distinct_Function_247(DS2,'ssnperid6',dis400);


					
					dis:=  dis2  + dis3  + dis4  + dis5  + dis6    + dis8  + dis9  + dis10 +
				       dis11 + dis12 + dis13 + dis14 + dis15 + dis16  + dis18 + dis19  + dis23 + dis24 + dis25 + dis26+ dis28 + dis29 + dis30 +
				       dis31 + dis32 + dis33 + dis34 + dis35 + dis38 + dis39 + dis40 +
				       dis41 + dis42 + dis43 + dis44 + dis45 + dis46 + dis47 + dis49 + dis50 +
						   dis52 + dis53 +  dis55 + dis56 + dis57 + dis58 + dis59 + dis60 +
               dis61 +  dis63 + dis64 + dis65  + dis67 + dis68  + dis70 + 
                dis72 + dis73 + dis74 + dis75  + dis77 + dis78  + 
               dis81 + dis83 + dis84 + dis85 + dis86 + dis87 + dis88 + dis89 + dis90 + 
					      dis92  + dis94 + dis95 + dis96 + dis97 + dis98 + dis99 + dis100 + 
dis101+dis103+dis104+dis105+dis106+dis107+dis108+dis109+dis110+
dis111+dis112+dis113+dis114+dis115+dis116+dis117+dis118+dis119+dis120+
dis121+dis122+dis123+dis124+dis125+dis126+dis127+dis128+dis129+dis130+
dis131+dis133+dis134+dis135+dis136+dis137+dis138+dis139+dis140+
dis141+dis142+dis143+dis144+dis145+dis146+dis147+dis148+dis149+dis150+
dis151+dis152+dis153+dis154+dis155+dis156+dis157+dis158+dis159+dis160+
dis161+dis162+dis163+dis164+dis165+dis166+dis167+dis168+dis169+
dis171+dis172+dis173+dis174+dis175+dis176+dis177+dis178+dis179+dis180+
dis181+dis182+dis183+dis184+dis185+dis186+dis187+dis188+dis189+dis190+
dis191+dis192+dis193+dis194+dis195+dis196+dis197+dis198+dis199+dis200+
dis201+dis202+dis203+dis204+dis205+dis206+dis207+dis208+dis209+dis210+
dis211+dis212+dis213+dis214+dis215+dis216+dis217+dis218+dis219+dis220+
dis221+dis222+dis223+dis224+dis225+dis226+dis227+dis228+dis229+dis230+
dis231+dis232+dis233+dis234+dis235+dis236+dis237+dis238+dis239+dis240+
dis241+dis242+dis243+dis244+dis245+dis246+dis247+dis248+dis249+dis250+
dis251+dis252+dis253+dis254+dis255+dis256+dis257+dis258+dis259+dis260+
dis261+dis262+dis263+dis264+dis265+dis266+dis267+dis268+dis269+dis270+
dis271+dis272+dis273+dis274+dis275+dis276+dis277+dis278+dis279+dis280+
dis281+dis282+dis283+dis284+dis285+dis286+dis287+dis288+dis289+dis290+
dis291+dis292+dis293+dis294+dis295+dis296+dis297+dis298+dis299+dis300+
dis301+dis302+dis303+dis304+dis305+dis306+dis307+dis308+dis309+dis310+
dis311+dis312+dis313+dis314+dis315+dis316+dis317+dis318+dis319+dis320+
dis321+dis322+dis323+dis324+dis325+dis326+dis327+dis328+dis329+dis330+
dis331+dis332+dis333+dis334+dis335+dis336+dis337+dis339+dis340+
dis341+dis342+dis343+dis344+dis345+dis346+dis347+dis348+dis349+dis350+
dis351+dis352+dis353+dis354+dis355+dis356+dis357+dis358+dis359+dis360+
dis361+dis362+dis363+dis364+dis365+dis366+dis367+dis368+dis369+dis370+
dis371+dis372+dis373+dis374+dis375+dis376+dis377+dis378+dis379+dis380+
dis381+dis382+dis383+dis384+dis385+dis386+dis387+dis388+dis389+dis390+
dis391+dis392+dis393+dis394+dis395+dis396+dis397+dis398+dis399+dis400;
						
				  	// Scoring_QA.Range_function_module.Length_Function(DS2,'v3__inputaddractivephonenumber',len1);
						// Scoring_QA.Range_function_module.Length_Function(DS2,'v3__curraddractivephonenumber',len2);
						// Scoring_QA.Range_function_module.Length_Function(DS2,'v3__prevaddractivephonenumber',len3);
				
			            // len:=len1 + len2 + len3;
				
					 Scoring_QA.Range_function_module.Distinct_function7(DS2,'did',did1);
	 
	 
	 did_stats:=did1;
								
      
			
			result2_stats:= ran + dis + ran_0 + ran_1 +ran_2  + ran_7 + did_stats;
   				
         
                   
					
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__ageoldestrecord',ave1);
      	Scoring_QA.Range_function_module.Average_func2(DS2,'v3__agenewestrecord',ave2);
				Scoring_QA.Range_function_module.Average_func2(DS2,'v3__relativespropownedtaxtotal',ave3);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddrlastsalesprice',ave4);
		    // Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddrtaxvalue',ave5);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddrtaxmarketvalue',ave6);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddravemtax',ave7);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddravemsalesprice',ave8);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddravemhedonic',ave9);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddravemvalue',ave10);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddrmedianincome',ave11);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddrmedianvalue',ave12);
		    // Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddrlastsalesprice',ave13);
		  	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddrtaxvalue',ave14);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddrtaxmarketvalue',ave15);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddravemtax',ave16);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddravemsalesprice',ave17);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddravemhedonic',ave18);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddravemvalue',ave19);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddrmedianincome',ave20);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddrmedianvalue',ave21);
	    	Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddragelastsale',ave22);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddrlastsalesprice',ave23);
				Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddractivephonelist',ave24);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddrtaxvalue',ave25);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddrtaxmarketvalue',ave26);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddravemtax',ave27);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddravmsalesprice',ave28);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddravmhedonic',ave29);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddravmvalue',ave30);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddrmedianincome',ave31);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddrmedianvalue',ave32);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputcurraddrdistance',ave33);
			  // Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputcurraddrtaxdiff',ave34);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputcurraddrincomediff',ave35);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputcurraddrvaluediff',ave36);
      	Scoring_QA.Range_function_module.Average_func2(DS2,'v3__predictedannualincome',ave37);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__currprevaddrdistance',ave38);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__currprevaddrtaxdiff',ave39);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__currprevaddrincomediff',ave40);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__currprevaddrvaluediff',ave41);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputphoneaddrdist',ave42);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__propownedtaxtotal',ave43);
				Scoring_QA.Range_function_module.Average_func2(DS2,'v3__propagenewestsale',ave44);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__ageoldestrecord',ave45);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__agenewestrecord',ave46);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lastnamechangeage',ave47);
				Scoring_QA.Range_function_module.Average_func2(DS2,'v3__ssndeceased',ave48);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__ssndatedeceased',ave49);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__ssnissued',ave50);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddrageoldestrecord',ave51);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddragenewestrecord',ave52);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddrlenofres',ave53);
				Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddragelastsale',ave54);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddrageoldestrecord',ave55);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddragenewestrecord',ave56);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddrlenofres',ave57);
				Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddragelastsale',ave58);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddrageoldestrecord',ave59);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddragenewestrecord',ave60);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddrlenofres',ave61);
			  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__propageoldestpurchase',ave62);
				Scoring_QA.Range_function_module.Average_func2(DS2,'v3__propagenewestpurchase',ave63);
				Scoring_QA.Range_function_module.Average_func2(DS2,'v3__derogage',ave64);
		    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__felonyage',ave65);
				Scoring_QA.Range_function_module.Average_func2(DS2,'v3__arrestage',ave66);
      	Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienfiledage',ave67);
      	Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienreleasedage',ave68);
				Scoring_QA.Range_function_module.Average_func2(DS2,'v3__bankruptcyage',ave69);
      	Scoring_QA.Range_function_module.Average_func2(DS2,'v3__evictionage',ave70);
				Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proflicage',ave71);
      	// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__phoneedaageoldestrecord',ave72);
				// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__phoneedaagenewestrecord',ave73);
				Scoring_QA.Range_function_module.Average_func2(DS2,'v3__phoneotherageoldestrecord',ave74);
		    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__phoneotheragenewestrecord',ave75);
				Scoring_QA.Range_function_module.Average_func2(DS2,'v3__derogcount',ave76);	
				
		
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subprimesolicitedcount01',ave77);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subprimesolicitedcount03',ave78);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subprimesolicitedcount06',ave79);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subprimesolicitedcount12',ave80);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subprimesolicitedcount24',ave81);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subprimesolicitedcount36',ave82);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subprimesolicitedcount60',ave83);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__felonycount',ave84);
					// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__derogcount',ave85);
			    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__felonycount01',ave86);
		  		Scoring_QA.Range_function_module.Average_func2(DS2,'v3__felonycount03',ave87);
			    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__felonycount06',ave88);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__felonycount12',ave89);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__felonycount24',ave90);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__felonycount36',ave91);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__felonycount60',ave92);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__arrestcount',ave93);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__arrestcount01',ave94);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__arrestcount03',ave95);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__arrestcount06',ave96);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__arrestcount12',ave97);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__arrestcount24',ave98);
			    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__arrestcount36',ave99);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__arrestcount60',ave100);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__liencount',ave101);
			    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienfiledcount',ave102);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienfiledcount01',ave103);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienfiledcount03',ave104);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienfiledcount06',ave105);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienfiledcount12',ave106);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienfiledcount24',ave107);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienfiledcount36',ave108);
			    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienfiledcount60',ave109);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienreleasedcount',ave110);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienreleasedcount01',ave111);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienreleasedcount03',ave112);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienreleasedcount06',ave113);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienreleasedcount12',ave114);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienreleasedcount24',ave115);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienreleasedcount36',ave116);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lienreleasedcount60',ave117);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__bankruptcycount',ave118);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__bankruptcycount01',ave119);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__bankruptcycount03',ave120);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__bankruptcycount06',ave121);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__bankruptcycount12',ave122);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__bankruptcycount24',ave123);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__bankruptcycount36',ave124);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__bankruptcycount60',ave125);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__evictioncount',ave126);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__evictioncount01',ave127);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__evictioncount03',ave128);
			    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__evictioncount06',ave129);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__evictioncount12',ave130);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__evictioncount24',ave131);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__evictioncount36',ave132);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__evictioncount60',ave133);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__nonderogcount',ave134);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__nonderogcount01',ave135);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__nonderogcount03',ave136);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__nonderogcount06',ave137);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__nonderogcount12',ave138);
			    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__nonderogcount24',ave139);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__nonderogcount36',ave140);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__nonderogcount60',ave141);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__profliccount',ave142);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__profliccount01',ave143);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__profliccount03',ave144);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__profliccount06',ave145);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__profliccount12',ave146);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__profliccount24',ave147);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__profliccount36',ave148);
			    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__profliccount60',ave149);
					// Scoring_QA.Range_function_module.Average_func2(DS2,'v3__profliccount60',ave150);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proflicexpirecount01',ave151);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proflicexpirecount03',ave152);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proflicexpirecount06',ave153);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proflicexpirecount12',ave154);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proflicexpirecount24',ave155);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proflicexpirecount36',ave156);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proflicexpirecount60',ave157);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchcollectioncount',ave158);
			    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchcollectioncount01',ave159);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchcollectioncount03',ave160);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchcollectioncount06',ave161);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchcollectioncount12',ave162);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchcollectioncount24',ave163);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchcollectioncount36',ave164);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchcollectioncount60',ave165);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchidvfraudcount',ave166);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchidvfraudcount01',ave167);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchidvfraudcount03',ave168);
			    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchidvfraudcount06',ave169);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchidvfraudcount12',ave170);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchidvfraudcount24',ave171);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchidvfraudcount36',ave172);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchidvfraudcount60',ave173);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchothercount',ave174);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchothercount01',ave175);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchothercount03',ave176);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchothercount06',ave177);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchothercount12',ave178);
			    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchothercount24',ave179);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchothercount36',ave180);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prsearchothercount60',ave181);	
					
							 
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subjectaddrcount',ave182);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subjectphonecount',ave183);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subjectssnrecentcount',ave184);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subjectaddrrecentcount',ave185);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subjectphonerecentcount',ave186);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__ssnidentitiescount',ave187);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__ssnaddrcount',ave188);
			    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__ssnidentitiesrecentcount',ave189);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__ssnaddrrecentcount',ave190);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddridentitiescount',ave191);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddrssncount',ave192);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddrphonecount',ave193);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddridentitiesrecentcount',ave194);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddrssnrecentcount',ave195);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddrphonerecentcount',ave196);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__phoneidentitiescount',ave197);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__phoneidentitiesrecentcount',ave198);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__ssnlastnamecount',ave199);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subjectlastnamecount',ave200);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lastnamechangecount01',ave201);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lastnamechangecount03',ave202);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lastnamechangecount06',ave203);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lastnamechangecount12',ave204);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lastnamechangecount24',ave205);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lastnamechangecount36',ave206);
		  		Scoring_QA.Range_function_module.Average_func2(DS2,'v3__lastnamechangecount60',ave207);
			  	Scoring_QA.Range_function_module.Average_func2(DS2,'v3__sfduaddridentitiescount',ave208);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__sfduaddrssncount',ave209);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__relativescount',ave210);
      	  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__relativesbankruptcycount',ave211);
      	  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__relativesfelonycount',ave212);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__relativespropownedcount',ave213);
			 	  // Scoring_QA.Range_function_module.Average_func2(DS2,'v3__inputaddravemconfidence',ave214);
				  // Scoring_QA.Range_function_module.Average_func2(DS2,'v3__curraddravemconfidence',ave215);
				  // Scoring_QA.Range_function_module.Average_func2(DS2,'v3__prevaddravemconfidence',ave216);
		   	  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__addrchangecount01',ave217);
      	  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__addrchangecount03',ave218);
			    Scoring_QA.Range_function_module.Average_func2(DS2,'v3__addrchangecount06',ave219);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__addrchangecount12',ave220);
      	  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__addrchangecount24',ave221);
      	  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__addrchangecount36',ave222);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__addrchangecount60',ave223);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__propownedcount',ave224);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__propownedhistoricalcount',ave225);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proppurchasedcount01',ave226);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proppurchasedcount03',ave227);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proppurchasedcount06',ave228);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proppurchasedcount12',ave229);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proppurchasedcount24',ave230);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proppurchasedcount36',ave231);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__proppurchasedcount60',ave232);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__propsoldcount01',ave233);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__propsoldcount03',ave234);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__propsoldcount06',ave235);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__propsoldcount12',ave236);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__propsoldcount24',ave237);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__propsoldcount36',ave238);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__propsoldcount60',ave239);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__watercraftcount',ave240);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__watercraftcount01',ave241);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__watercraftcount03',ave242);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__watercraftcount06',ave243);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__watercraftcount12',ave244);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__watercraftcount24',ave245);
				  Scoring_QA.Range_function_module.Average_func2(DS2,'v3__watercraftcount36',ave246);
		  		Scoring_QA.Range_function_module.Average_func2(DS2,'v3__watercraftcount60',ave247);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__aircraftcount',ave248);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__aircraftcount01',ave249);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__aircraftcount03',ave250);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__aircraftcount06',ave251);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__aircraftcount12',ave252);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__aircraftcount24',ave253);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__aircraftcount36',ave254);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__aircraftcount60',ave255);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subprimesolicitedcount',ave256);
					Scoring_QA.Range_function_module.Average_func2(DS2,'v3__subjectssncount',ave257);
					
			
      	
      	   avearage:=  ave1  + ave2  + ave3   + ave22  + ave24      + ave37       + ave44   + ave48  +
									 ave54 + ave58 + 
                    ave62 + ave63 + ave64 + ave65 + ave66 + ave67 + ave68 + ave69 + ave70 + 
                   ave71  + ave74 + ave75 + ave76 + ave77 + ave78 + ave79 + ave80 + 
                   ave81 + ave82 + ave83 + ave84 + ave86 + ave87 + ave88 + ave89 + ave90 + 
					         ave91 + ave92 + ave93 + ave94 + ave95 + ave96 + ave97 + ave98 + ave99 + ave100 + 
				           ave101 + ave102 + ave103 + ave104 + ave105 + ave106 + ave107 + ave108 + ave109 + ave110 + 
									 ave111 + ave112 + ave113 + ave114 + ave115 + ave116 + ave117 + ave118 + ave119 + ave120 +
									 ave121 + ave122 + ave123 + ave124 + ave125 + ave126 + ave127 + ave128 + ave129 + ave130 +
				           ave131 + ave132 + ave133 + ave134 + ave135 + ave136 + ave137 + ave138 + ave139 + ave140 +
				           ave141 + ave142 + ave143 + ave144 + ave145 + ave146 + ave147 + ave148 + ave149  +
                   ave151 + ave152 + ave153 + ave154 + ave155 + ave156 + ave157 + ave158 + ave159 + ave160 +
                   ave161 + ave162 + ave163 + ave164 + ave165 + ave166 + ave167 + ave168 + ave169 + ave170 + 
                   ave171 + ave172 + ave173 + ave174 + ave175 + ave176 + ave177 + ave178 + ave179 + ave180 + 
									 ave181 + ave182 + ave183 + ave184 + ave185 + ave186 + ave187 + ave188 + ave189 + ave190 + 
									 ave191 + ave192 + ave193 + ave194 + ave195 + ave196 + ave197 + ave198 + ave199 + ave200 + 
								   ave201 + ave202 + ave203 + ave204 + ave205 + ave206 + ave207 + ave208 + ave209 + ave210 + 
									 ave211 + ave212 + ave213  + ave217 + ave218 + ave219 + ave220 + 
									 ave221 + ave222 + ave223 + ave224 + ave225 + ave226 + ave227 + ave228 + ave229 + ave230 + 
									 ave231 + ave232 + ave233 + ave234 + ave235 + ave236 + ave237 + ave238 + ave239 + ave240 + 
									 ave241 + ave242 + ave243 + ave244 + ave245 + ave246 + ave247 + ave248 + ave249 + ave250 + 
									 ave251 + ave252 + ave253 + ave254 + ave255 + ave256 + ave257;
                   
		
					
								 // Scoring_QA.Range_function_module.Range_Average_Function_0(DS1,'inputcurraddrtaxdiff',ranav0_1);
								 // Scoring_QA.Range_function_module.Range_Average_Function_0(DS1,'inputcurraddrincomediff',ranav0_2);
								 // Scoring_QA.Range_function_module.Range_Average_Function_0(DS1,'inputcurraddrvaluediff',ranav0_3);
								 // Scoring_QA.Range_function_module.Range_Average_Function_0(DS1,'currprevaddrtaxdiff',ranav0_4);
								 // Scoring_QA.Range_function_module.Range_Average_Function_0(DS1,'currprevaddrincomediff',ranav0_5);
								 // Scoring_QA.Range_function_module.Range_Average_Function_0(DS1,'currprevaddrvaluediff',ranav0_6);
								 
											 
											 // ranav0:=ranav0_1  + ranav0_2  + ranav0_3  + ranav0_4  + ranav0_5  + ranav0_6;
											 
								 // Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'v3__inputcurraddrtaxdiff',ranave01);
								 // Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'v3__inputcurraddrincomediff',ranave02);
								 // Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'v3__inputcurraddrvaluediff',ranave03);
								 // Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'v3__currprevaddrtaxdiff',ranave04);
								 // Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'v3__currprevaddrincomediff',ranave05);
								 // Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'v3__currprevaddrvaluediff',ranave06);
								 
											 
											 // ranave0:=ranave01  + ranave02  + ranave03  + ranave04  + ranave05  + ranave06;			
											 
	
			///////////////////////////////////////////////////   new fields of ITA Capone
					
	// Scoring_QA.Range_function_module.Average_func2(DS2,'subjectfirstseen',av1);
// Scoring_QA.Range_function_module.Average_func2(DS2,'datelastupdate',av2);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'recentupdate',av3);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numsrcsconfirmidaddr',av4);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'phonefullnamematch',av5);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'phonelastnamematch',av6);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'ageriskindicator',av7);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'invalidssn',av8);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'invalidphone',av9);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'invalidaddr',av10);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'noverifynameaddrphonessn',av11);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssndeceased',av12);
// Scoring_QA.Range_function_module.Average_Function_4(DS2,'datessndeceased',av13);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssnissued',av14);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'recentssn',av15);
// Scoring_QA.Range_function_module.Average_Function_4(DS2,'lowissuedate',av16);
// Scoring_QA.Range_function_module.Average_Function_4(DS2,'highissuedate',av17);
// Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssnissuestate',av18);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'nonusssn',av19);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssn3years',av20);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssnafter5',av21);
// Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssnprobs',av22);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssnnotfound',av23);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssnfoundother',av24);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssnissuedprior',av25);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'phoneother',av26);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssnperid',av27);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrperid',av28);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'phoneperid',av29);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'idperssn',av30);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrperssn',av31);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'idperaddr',av32);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssnperaddr',av33);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'phoneperaddr',av34);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'idperphone',av35);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssnperid6',av36);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrperid6',av37);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'phoneperid6',av38);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'idperssn6',av39);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrperssn6',av40);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'idperaddr6',av41);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssnperaddr6',av42);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'phoneperaddr6',av43);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'idperphone6',av44);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'lastnameperssn',av45);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'lastnameperid',av46);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'timesincelastname',av47);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'lastnames30',av48);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'lastnames90',av49);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'lastnames180',av50);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'lastnames12',av51);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'lastnames24',av52);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'lastnames36',av53);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'lastnames60',av54);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'idpersfduaddr',av55);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'ssnpersfduaddr',av56);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'timesinceinputaddrfirstseen',av57);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'timesinceinputaddrlastseen',av58);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrlenofres',av59);
// Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrdwelltype',av60);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrlandusecode',av61);

Scoring_QA.Range_function_module.Average_Function_3(DS2,' inputaddrassessedvalue',av62);
// Scoring_QA.Range_function_module.Average_func2(DS2,'inputaddrtaxassessedyr',av63);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrapplicantowned',av64);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrfamilyowned',av65);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddroccupantowned',av66);
// Scoring_QA.Range_function_module.Average_func2(DS2,'inputaddrlastsalesdate',av67);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' inputaddrlastsalesamount',av68);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrnotprimaryres',av69);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddractivephonelist',av70);
// Scoring_QA.Range_function_module.Average_func2(DS2,' inputaddractivephonenumber',av71);

Scoring_QA.Range_function_module.Average_Function_3(DS2,' inputaddrmedianincome',av72);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' inputaddrmedianhomeval',av73);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrmurderindex',av74);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrcartheftindex',av75);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrburglaryindex',av76);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrcrimeindex',av77);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' inputaddrassessmarket',av78);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' inputaddrtaxassessval',av79);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' inputaddrpriceindval',av80);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' inputaddrhedval',av81);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' inputaddrautoval',av82);
Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddrconfscore',av83);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrcountyindex',av84);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrtractindex',av85);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrblockindex',av86);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'timesincecurraddrfirstseen',av87);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'timesincecurraddrlastseen',av88);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrlenofres',av89);
// Scoring_QA.Range_function_module.Average_func2(DS2,'curraddrdwelltype',av90);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrlandusecode',av91);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' curraddrassessedvalue',av92);
// Scoring_QA.Range_function_module.Average_func2(DS2,'curraddrtaxassessedyr',av93);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrapplicantowned',av94);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrfamilyowned',av95);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddroccupantowned',av96);
// Scoring_QA.Range_function_module.Average_func2(DS2,'curraddrlastsalesdate',av97);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' curraddrlastsalesamount',av98);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrnotprimaryres',av99);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddractivephonelist',av100);
// Scoring_QA.Range_function_module.Average_func2(DS2,' curraddractivephonenumber',av101);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' curraddrmedianincome',av102);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' curraddrmedianhomeval',av103);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrmurderindex',av104);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrcartheftindex',av105);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrburglaryindex',av106);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrcrimeindex',av107);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' curraddrassessmarket',av108);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' curraddrtaxassessval',av109);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' curraddrpriceindval',av110);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' curraddrhedval',av111);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' curraddrautoval',av112);
Scoring_QA.Range_function_module.Average_Function_3(DS2,'curraddrconfscore',av113);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrcountyindex',av114);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrtractindex',av115);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrblockindex',av116);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'timesinceprevaddrfirstseen',av117);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'timesinceprevaddrlastseen',av118);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'prevaddrlenofres',av119);
// Scoring_QA.Range_function_module.Average_func2(DS2,'prevaddrdwelltype',av120);
// Scoring_QA.Range_function_module.Average_func2(DS2,'prevaddrlandusecode',av121);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' prevaddrassessedvalue',av122);
// Scoring_QA.Range_function_module.Average_func2(DS2,'prevaddrtaxassessedyr',av123);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'prevaddrapplicantowned',av124);
// Scoring_QA.Range_function_module.Average_func2(DS2,'prevaddrfamilyowned',av125);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'prevaddroccupantowned',av126);
// Scoring_QA.Range_function_module.Average_func2(DS2,'prevaddrlastsalesdate',av127);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' prevaddrlastsalesamount',av128);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'prevaddrnotprimaryres',av129);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'prevaddractivephonelist',av130);
// Scoring_QA.Range_function_module.Average_func2(DS2,' prevaddractivephonenumber',av131);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' prevaddrmedianincome',av132);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' prevaddrmedianhomeval',av133);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'prevaddrmurderindex',av134);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'prevaddrcartheftindex',av135);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'prevaddrburglaryindex',av136);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'prevaddrcrimeindex',av137);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' prevaddrassessmarket',av138);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' prevaddrtaxassessval',av139);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' prevaddrpriceindval',av140);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' prevaddrhedval',av141);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' prevaddrautoval',av142);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'prevaddrconfscore',av143);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'prevaddrcountyindex',av144);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'prevaddrtractindex',av145);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'prevaddrblockindex',av146);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrcurraddrmatch',av147);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrcurraddrdistance',av148);
Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddrcurraddrstatediff',av149);
Scoring_QA.Range_function_module.Average_Function_5(DS2,' inputaddrcurraddrassesseddiff',av150);
Scoring_QA.Range_function_module.Average_Function_5(DS2,' inputaddrcurraddrincomediff',av151);
Scoring_QA.Range_function_module.Average_Function_5(DS2,' inputaddrcurraddrhomevaldiff',av152);
Scoring_QA.Range_function_module.Average_Function_5(DS2,'inputaddrcurraddrcrimediff',av153);
// Scoring_QA.Range_function_module.Average_func2(DS2,'economictrajectory',av154);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrprevaddrmatch',av155);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrprevaddrdistance',av156);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'curraddrprevaddrstatediff',av157);
Scoring_QA.Range_function_module.Average_Function_5(DS2,' curraddrprevaddrassesseddiff',av158);
Scoring_QA.Range_function_module.Average_Function_5(DS2,' curraddrprevaddrincomediff',av159);
Scoring_QA.Range_function_module.Average_Function_5(DS2,' curraddrprevaddrhomevaldiff',av160);
Scoring_QA.Range_function_module.Average_Function_5(DS2,'curraddrprevaddrcrimediff',av161);
// Scoring_QA.Range_function_module.Average_func2(DS2,'economictrajectory2',av162);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrstability',av163);
// Scoring_QA.Range_function_module.Average_Function_4(DS2,'statusmostrecent',av164);
// Scoring_QA.Range_function_module.Average_Function_4(DS2,'statusprevious',av165);
// Scoring_QA.Range_function_module.Average_Function_4(DS2,'statusnextprevious',av166);
// Scoring_QA.Range_function_module.Average_func2(DS2,'timesinceprevaddrdatefirstseen',av167);
// Scoring_QA.Range_function_module.Average_func2(DS2,'timesincenextprevdatefirstseen',av168);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrchanges30',av169);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrchanges90',av170);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrchanges180',av171);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrchanges12',av172);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrchanges24',av173);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrchanges36',av174);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrchanges60',av175);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'propertyownedtotal',av176);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' propertyownedassessedtotal',av177);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'propertyhistoricallyowned',av178);
// Scoring_QA.Range_function_module.Average_func2(DS2,'datefirstpurchase',av179);
// Scoring_QA.Range_function_module.Average_func2(DS2,'datemostrecentpurchase',av180);
// Scoring_QA.Range_function_module.Average_func2(DS2,'datemostrecentsale',av181);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proppurchased30',av182);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proppurchased90',av183);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proppurchased180',av184);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proppurchased12',av185);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proppurchased24',av186);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proppurchased36',av187);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proppurchased60',av188);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'propsold30',av189);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'propsold90',av190);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'propsold180',av191);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'propsold12',av192);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'propsold24',av193);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'propsold36',av194);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'propsold60',av195);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numwatercraft',av196);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numwatercraft30',av197);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numwatercraft90',av198);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numwatercraft180',av199);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numwatercraft12',av200);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numwatercraft24',av201);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numwatercraft36',av202);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numwatercraft60',av203);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numaircraft',av204);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numaircraft30',av205);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numaircraft90',av206);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numaircraft180',av207);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numaircraft12',av208);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numaircraft24',av209);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numaircraft36',av210);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numaircraft60',av211);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'wealthindex',av212);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'totalnumberderogs',av213);
// Scoring_QA.Range_function_module.Average_func2(DS2,'datelastderog',av214);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numfelonies',av215);
// Scoring_QA.Range_function_module.Average_func2(DS2,'datelastconviction',av216);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numfelonies30',av217);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numfelonies90',av218);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numfelonies180',av219);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numfelonies12',av220);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numfelonies24',av221);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numfelonies36',av222);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numfelonies60',av223);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numarrests',av224);
// Scoring_QA.Range_function_module.Average_func2(DS2,'datelastarrest',av225);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numarrests30',av226);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numarrests90',av227);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numarrests180',av228);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numarrests12',av229);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numarrests24',av230);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numarrests36',av231);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'numarrests60',av232);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'lienscount',av233);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensunreleasedcount',av234);
// Scoring_QA.Range_function_module.Average_func2(DS2,'mostrecentunreldate',av235);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensunreleasedcount30',av236);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensunreleasedcount90',av237);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensunreleasedcount180',av238);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensunreleasedcount12',av239);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensunreleasedcount24',av240);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensunreleasedcount36',av241);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensunreleasedcount60',av242);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensreleasedcount',av243);
// Scoring_QA.Range_function_module.Average_func2(DS2,'mostrecentreleaseddate',av244);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensreleasedcount30',av245);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensreleasedcount90',av246);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensreleasedcount180',av247);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensreleasedcount12',av248);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensreleasedcount24',av249);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensreleasedcount36',av250);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'liensreleasedcount60',av251);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'bankruptcount',av252);
// Scoring_QA.Range_function_module.Average_func2(DS2,'mostrecentbankruptdate',av253);
// Scoring_QA.Range_function_module.Average_func2(DS2,'mostrecentbankrupttype',av254);
// Scoring_QA.Range_function_module.Average_func2(DS2,' mostrecentbankruptstatus',av255);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'bankruptcount30',av256);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'bankruptcount90',av257);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'bankruptcount180',av258);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'bankruptcount12',av259);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'bankruptcount24',av260);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'bankruptcount36',av261);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'bankruptcount60',av262);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'evictioncount',av263);
// Scoring_QA.Range_function_module.Average_func2(DS2,'mostrecentevictiondate',av264);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'evictioncount30',av265);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'evictioncount90',av266);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'evictioncount180',av267);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'evictioncount12',av268);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'evictioncount24',av269);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'evictioncount36',av270);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'evictioncount60',av271);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'nonderogsrccount',av272);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'nonderogsrccount30',av273);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'nonderogsrccount90',av274);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'nonderogsrccount180',av275);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'nonderogsrccount12',av276);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'nonderogsrccount24',av277);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'nonderogsrccount36',av278);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'nonderogsrccount60',av279);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'profliccount',av280);
// Scoring_QA.Range_function_module.Average_func2(DS2,'mostrecentproflicdate',av281);
// Scoring_QA.Range_function_module.Average_func2(DS2,'mostrecentproflicexpiredate',av282);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'profliccount30',av283);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'profliccount90',av284);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'profliccount180',av285);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'profliccount12',av286);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'profliccount24',av287);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'profliccount36',av288);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'profliccount60',av289);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proflicexpirecount30',av290);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proflicexpirecount90',av291);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proflicexpirecount180',av292);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proflicexpirecount12',av293);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proflicexpirecount24',av294);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proflicexpirecount36',av295);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'proflicexpirecount60',av296);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrhighrisk',av297);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputphonehighrisk',av298);
// Scoring_QA.Range_function_module.Average_func2(DS2,'sic',av299);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputaddrprison',av300);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputzippobox',av301);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputzipcorpmil',av302);
// Scoring_QA.Range_function_module.Average_func2(DS2,'inputphonestatus',av303);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputphonepager',av304);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputphonemobile',av305);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'timesincesubjectphonefirstseen',av306);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'timesincesubjectphonelastseen',av307);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'invalidphonezip',av308);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'inputphoneaddrdist',av309);
// Scoring_QA.Range_function_module.Average_func2(DS2,'phonetype',av310);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'servicetype',av311);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'areacodechange',av312);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrval',av313);
Scoring_QA.Range_function_module.Average_Function_3(DS2,'addrvalerrorcode',av314);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'donotmail',av315);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'score1',av316);
Scoring_QA.Range_function_module.Average_Function_4(DS2,' scorename1',av317);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'reason1',av318);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'reason2',av319);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'reason3',av320);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'reason4',av321);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'reason5',av322);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'reason6',av323);

Scoring_QA.Range_function_module.Average_Function_3(DS2,'curraddrprevaddrassesseddiff',av324);
Scoring_QA.Range_function_module.Average_Function_3(DS2,'curraddrprevaddrcrimediff',av325);
Scoring_QA.Range_function_module.Average_Function_3(DS2,'curraddrprevaddrhomevaldiff',av326);
Scoring_QA.Range_function_module.Average_Function_3(DS2,'curraddrprevaddrincomediff',av327);
Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddrcurraddrassesseddiff',av328);
Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddrcurraddrcrimediff',av329);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' inputaddrcurraddrhomevaldiff',av330);
Scoring_QA.Range_function_module.Average_Function_3(DS2,' inputaddrcurraddrincomediff',av331);
	
Scoring_QA.Range_function_module.Average_Function_4(DS2,'v3__educationattendedcollege',av332);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'v3__educationfieldofstudytype',av333);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'v3__educationinstitutionprivate',av334);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'v3__educationinstitutionrating',av335);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'v3__educationprogram2yr',av336);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'v3__educationprogram4yr',av337);
Scoring_QA.Range_function_module.Average_Function_4(DS2,'v3__educationprogramgraduate',av338);

	
					 av:= av3 +  av4  + av5  + av6  + av7  + av8  + av9  + av10 +
				        av11 + av12  + av14 + av15  + av19 + av20 +
						    av21  + av23 + av24 + av25 + av26 + av27 + av28 + av29 + av30 +
				        av31 + av32 + av33 + av34 + av35 + av36 + av37 + av38 + av39 + av40 +
				        av41 + av42 + av43 + av44 + av45 + av46 + av47 + av48 + av49 + av50 +
								av51 + av52 + av53 + av54 + av55 + av56 + av57 + av58 + av59  +
                av61 + av62  + av64 + av65 + av66  + av68 + av69 + av70 + 
                av72 + av73 + av74 + av75 + av76 + av77 + av78 + av79 + av80 + 
                av81 + av82 + av83 + av84 + av85 + av86 + av87 + av88 + av89  + 
					      av91 + av92  + av94 + av95 + av96  + av98 + av99 + av100+ 
				          av102 + av103 + av104 + av105 + av106 + av107 + av108 + av109 + av110+ 
						    av111 + av112 + av113 + av114 + av115 + av116 + av117 + av118 + av119 + 
				  	     av122  + av124  + av126  + av128 + av129 + av130+
						     av132 + av133 + av134 + av135	+ av136	+av137	+av138	+av139	+av140	+
av141	+av142	+av143	+av144	+av145	+av146	+av147	+av148	+av149	+av150	+
av151	+av152	+av153		+av155	+av156	+av157	+av158	+av159	+av160	+
av161		+av163		+av169	+av170	+
av171	+av172	+av173	+av174	+av175	+av176	+av177	+av178			
  +av182	+av183	+av184	+av185	+av186	+av187	+av188	+av189	+av190	+
av191	+av192	+av193	+av194	+av195	+av196	+av197	+av198	+av199	+av200	+
av201	+av202	+av203	+av204	+av205	+av206	+av207	+av208	+av209	+av210	+
av211	+av212	+av213		+av215		+av217	+av218	+av219	+av220	+
av221	+av222	+av223	+av224		+av226	+av227	+av228	+av229	+av230	+
av231	+av232	+av233	+av234		+av236	+av237	+av238	+av239	+av240	+
av241	+av242	+av243  	+av245	+av246	+av247	+av248	+av249	+av250	+
av251	+av252				+av256	+av257	+av258	+av259	+av260	+
av261	+av262	+av263		+av265	+av266	+av267	+av268	+av269	+av270	+
av271	+av272	+av273	+av274	+av275	+av276	+av277	+av278	+av279	+av280	+
	av283	+av284	+av285	+av286	+av287	+av288	+av289	+av290	+
av291	+av292	+av293	+av294	+av295	+av296	+av297	+av298		+av300	+
av301	+av302		+av304	+av305	+av306	+av307	+av308	+av309		+
av311	+av312	+av313	+av314	+av315	+av316	+av317	+av318	+av319	+av320	+
av321	+av322	+av323 +av324	+av325	+av326 +av327	+av328	+av329 +av330	+av331 +av332 + av333 + av334 + av335 + av336 + av337 + av338;

				
	 
   result4_stats:=avearage + av;
	 
	
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