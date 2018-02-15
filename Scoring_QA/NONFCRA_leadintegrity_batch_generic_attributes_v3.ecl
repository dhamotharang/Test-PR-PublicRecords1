EXPORT NONFCRA_leadintegrity_batch_generic_attributes_v3(route ,name,current_dt,previous_dt) := functionmacro



 file1:= dataset(route +'scoringqa::out::nonfcra::'+name+previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V3_Global_Layout,


thor);

 file2:= dataset(route +'scoringqa::out::nonfcra::'+name+current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V3_Global_Layout,


thor);



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
	 
	 

   	  	
	 

   	  		  
      	
      	Scoring_QA.Range_function_module.range_function_72(DS2,'ageoldestrecord',ran1);
      	Scoring_QA.Range_function_module.range_function_71(DS2,'agenewestrecord',ran2);		
				Scoring_QA.Range_function_module.range_function_92(DS2,'ssndeceased',ran3);
       	Scoring_QA.Range_function_module.range_function_137(DS2,'propageoldestpurchase',ran4);
				Scoring_QA.Range_function_module.range_function_64(DS2,'propagenewestpurchase',ran5);
				Scoring_QA.Range_function_module.range_function_73(DS2,'derogage',ran6);
				Scoring_QA.Range_function_module.range_function_127(DS2,'felonyage',ran7);
		   	Scoring_QA.Range_function_module.range_function_120(DS2,'arrestage',ran8);
				Scoring_QA.Range_function_module.Range_Function_134(DS2,'lienfiledage',ran9);
				Scoring_QA.Range_function_module.range_function_127(DS2,'lienreleasedage',ran10);
				Scoring_QA.Range_function_module.range_function_121(DS2,'bankruptcyage',ran11);
				Scoring_QA.Range_function_module.range_function_73(DS2,'evictionage',ran12);
			 	Scoring_QA.Range_function_module.range_function_71(DS2,'proflicage',ran13);		  
      	Scoring_QA.Range_function_module.range_function_83(DS2,'phoneotherageoldestrecord',ran14);
			 	Scoring_QA.Range_function_module.range_function_114(DS2,'phoneotheragenewestrecord',ran15);
				Scoring_QA.Range_function_module.range_function_122(DS2,'curraddragelastsale',ran16);
				Scoring_QA.Range_function_module.range_function_128(DS2,'inputaddragelastsale',ran17);			
				Scoring_QA.Range_function_module.range_function_126(DS2,'curraddrlenofres',ran18);
				Scoring_QA.Range_function_module.range_function_129(DS2,'inputaddragenewestrecord',ran19);
				Scoring_QA.Range_function_module.Range_Function_130(DS2,'inputaddrageoldestrecord',ran20);
				Scoring_QA.Range_function_module.Range_Function_130(DS2,'inputaddrlenofres',ran21);
				Scoring_QA.Range_function_module.Range_Function_133(DS2,'lastnamechangeage',ran22);
				Scoring_QA.Range_function_module.Range_func(DS2,'phoneedaagenewestrecord',ran23);
				Scoring_QA.Range_function_module.range_function_114(DS2,'prevaddragenewestrecord',ran24);
				Scoring_QA.Range_function_module.Range_Function_98(DS2,'prevaddrageoldestrecord',ran25);
				Scoring_QA.Range_function_module.Range_Function_98(DS2,'prevaddrlenofres',ran26);
			  	
      	ran:= ran1  + ran2  + ran3  + ran4  + ran5 + ran6   + ran7  + ran8  + ran9  + ran10 +
				     ran11 + ran12 + ran13 + ran14 + ran15 + ran16 + ran17 + ran18 + ran19 + ran20 + 
						 ran21 + ran22 + ran23 + ran24 + ran25 + ran26;
      	
				  Scoring_QA.Range_function_module.range_function_25(DS2,'subjectssncount',ran0_1);
					Scoring_QA.Range_function_module.range_function_31(DS2,'subjectaddrcount',ran0_2);
					Scoring_QA.Range_function_module.range_function_31(DS2,'subjectphonecount',ran0_3);
					Scoring_QA.Range_function_module.range_function_31(DS2,'subjectssnrecentcount',ran0_4);
					Scoring_QA.Range_function_module.range_function_31(DS2,'subjectaddrrecentcount',ran0_5);
					Scoring_QA.Range_function_module.range_function_31(DS2,'subjectphonerecentcount',ran0_6);
					Scoring_QA.Range_function_module.range_function_71(DS2,'ssnidentitiescount',ran0_7);
					Scoring_QA.Range_function_module.range_function_25(DS2,'ssnaddrcount',ran0_8);
			    Scoring_QA.Range_function_module.range_function_71(DS2,'ssnidentitiesrecentcount',ran0_9);
					Scoring_QA.Range_function_module.range_function_25(DS2,'ssnaddrrecentcount',ran0_10);
					Scoring_QA.Range_function_module.range_function_108(DS2,'inputaddridentitiescount',ran0_11);
					Scoring_QA.Range_function_module.range_function_32(DS2,'inputaddrssncount',ran0_12);
					Scoring_QA.Range_function_module.range_function_40(DS2,'inputaddrphonecount',ran0_13);
					Scoring_QA.Range_function_module.range_function_76(DS2,'inputaddridentitiesrecentcount',ran0_14);
					Scoring_QA.Range_function_module.range_function_25(DS2,'inputaddrssnrecentcount',ran0_15);
					Scoring_QA.Range_function_module.range_function_69(DS2,'inputaddrphonerecentcount',ran0_16);
					Scoring_QA.Range_function_module.range_function_76(DS2,'phoneidentitiescount',ran0_17);
				  Scoring_QA.Range_function_module.range_function_76(DS2,'phoneidentitiesrecentcount',ran0_18);
					Scoring_QA.Range_function_module.range_function_71(DS2,'ssnlastnamecount',ran0_19);
					Scoring_QA.Range_function_module.range_function_25(DS2,'subjectlastnamecount',ran0_20);
					Scoring_QA.Range_function_module.range_function_76(DS2,'lastnamechangecount01',ran0_21);
				  Scoring_QA.Range_function_module.range_function_76(DS2,'lastnamechangecount03',ran0_22);
					Scoring_QA.Range_function_module.range_function_76(DS2,'lastnamechangecount06',ran0_23);
					Scoring_QA.Range_function_module.range_function_76(DS2,'lastnamechangecount12',ran0_24);
					Scoring_QA.Range_function_module.range_function_76(DS2,'lastnamechangecount24',ran0_25);
				  Scoring_QA.Range_function_module.range_function_76(DS2,'lastnamechangecount36',ran0_26);
		  		Scoring_QA.Range_function_module.range_function_76(DS2,'lastnamechangecount60',ran0_27);
			  	Scoring_QA.Range_function_module.range_function_31(DS2,'sfduaddridentitiescount',ran0_28);
					Scoring_QA.Range_function_module.range_function_31(DS2,'sfduaddrssncount',ran0_29);
				  Scoring_QA.Range_function_module.range_function_37(DS2,'relativescount',ran0_30);
      	  Scoring_QA.Range_function_module.range_function_31(DS2,'relativesbankruptcycount',ran0_31);
      	  Scoring_QA.Range_function_module.range_function_31(DS2,'relativesfelonycount',ran0_32);
				  Scoring_QA.Range_function_module.range_function_37(DS2,'relativespropownedcount',ran0_33);
			 	  Scoring_QA.Range_function_module.range_function_131(DS2,'inputaddravmconfidence',ran0_34);
				  Scoring_QA.Range_function_module.range_function_125(DS2,'curraddravmconfidence',ran0_35);
				  Scoring_QA.Range_function_module.range_function_131(DS2,'prevaddravmconfidence',ran0_36);
		   	  Scoring_QA.Range_function_module.range_function_40(DS2,'addrchangecount01',ran0_37);
      	  Scoring_QA.Range_function_module.range_function_40(DS2,'addrchangecount03',ran0_38);
			    Scoring_QA.Range_function_module.range_function_40(DS2,'addrchangecount06',ran0_39);
				  Scoring_QA.Range_function_module.range_function_40(DS2,'addrchangecount12',ran0_40);
      	  Scoring_QA.Range_function_module.range_function_40(DS2,'addrchangecount24',ran0_41);
      	  Scoring_QA.Range_function_module.range_function_40(DS2,'addrchangecount36',ran0_42);
				  Scoring_QA.Range_function_module.range_function_40(DS2,'addrchangecount60',ran0_43);
					Scoring_QA.Range_function_module.range_function_40(DS2,'propownedcount',ran0_44);
					Scoring_QA.Range_function_module.range_function_40(DS2,'propownedhistoricalcount',ran0_45);
					Scoring_QA.Range_function_module.range_function_76(DS2,'proppurchasedcount01',ran0_46);
					Scoring_QA.Range_function_module.range_function_76(DS2,'proppurchasedcount03',ran0_47);
					Scoring_QA.Range_function_module.range_function_76(DS2,'proppurchasedcount06',ran0_48);
					Scoring_QA.Range_function_module.range_function_76(DS2,'proppurchasedcount12',ran0_49);
					Scoring_QA.Range_function_module.range_function_76(DS2,'proppurchasedcount24',ran0_50);
					Scoring_QA.Range_function_module.range_function_76(DS2,'proppurchasedcount36',ran0_51);
					Scoring_QA.Range_function_module.range_function_76(DS2,'proppurchasedcount60',ran0_52);
					Scoring_QA.Range_function_module.range_function_76(DS2,'propsoldcount01',ran0_53);
					Scoring_QA.Range_function_module.range_function_76(DS2,'propsoldcount03',ran0_54);
					Scoring_QA.Range_function_module.range_function_76(DS2,'propsoldcount06',ran0_55);
					Scoring_QA.Range_function_module.range_function_76(DS2,'propsoldcount12',ran0_56);
					Scoring_QA.Range_function_module.range_function_76(DS2,'propsoldcount24',ran0_57);
				  Scoring_QA.Range_function_module.range_function_76(DS2,'propsoldcount36',ran0_58);
					Scoring_QA.Range_function_module.range_function_76(DS2,'propsoldcount60',ran0_59);
					Scoring_QA.Range_function_module.range_function_25(DS2,'watercraftcount',ran0_60);
					Scoring_QA.Range_function_module.range_function_31(DS2,'watercraftcount01',ran0_61);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'watercraftcount03',ran0_62);
					Scoring_QA.Range_function_module.range_function_31(DS2,'watercraftcount06',ran0_63);
					Scoring_QA.Range_function_module.range_function_31(DS2,'watercraftcount12',ran0_64);
					Scoring_QA.Range_function_module.range_function_31(DS2,'watercraftcount24',ran0_65);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'watercraftcount36',ran0_66);
		  		Scoring_QA.Range_function_module.range_function_31(DS2,'watercraftcount60',ran0_67);
					Scoring_QA.Range_function_module.range_function_31(DS2,'aircraftcount',ran0_68);
					Scoring_QA.Range_function_module.range_function_31(DS2,'aircraftcount01',ran0_69);
					Scoring_QA.Range_function_module.range_function_31(DS2,'aircraftcount03',ran0_70);
					Scoring_QA.Range_function_module.range_function_31(DS2,'aircraftcount06',ran0_71);
					Scoring_QA.Range_function_module.range_function_31(DS2,'aircraftcount12',ran0_72);
					Scoring_QA.Range_function_module.range_function_31(DS2,'aircraftcount24',ran0_73);
					Scoring_QA.Range_function_module.range_function_31(DS2,'aircraftcount36',ran0_74);
					Scoring_QA.Range_function_module.range_function_31(DS2,'aircraftcount60',ran0_75);
					Scoring_QA.Range_function_module.range_function_31(DS2,'subprimesolicitedcount',ran0_76);
					Scoring_QA.Range_function_module.range_function_31(DS2,'subprimesolicitedcount01',ran0_77);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'subprimesolicitedcount03',ran0_78);
					Scoring_QA.Range_function_module.range_function_31(DS2,'subprimesolicitedcount06',ran0_79);
					Scoring_QA.Range_function_module.range_function_31(DS2,'subprimesolicitedcount12',ran0_80);
					Scoring_QA.Range_function_module.range_function_31(DS2,'subprimesolicitedcount24',ran0_81);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'subprimesolicitedcount36',ran0_82);
					Scoring_QA.Range_function_module.range_function_31(DS2,'subprimesolicitedcount60',ran0_83);
					Scoring_QA.Range_function_module.range_function_76(DS2,'felonycount',ran0_84);
					// Scoring_QA.Range_function_module.Range_Function_0(DS2,'derogcount',ran0_85);
			    Scoring_QA.Range_function_module.range_function_76(DS2,'felonycount01',ran0_86);
		  		Scoring_QA.Range_function_module.range_function_76(DS2,'felonycount03',ran0_87);
			    Scoring_QA.Range_function_module.range_function_76(DS2,'felonycount06',ran0_88);
					Scoring_QA.Range_function_module.range_function_76(DS2,'felonycount12',ran0_89);
					Scoring_QA.Range_function_module.range_function_76(DS2,'felonycount24',ran0_90);
					Scoring_QA.Range_function_module.range_function_76(DS2,'felonycount36',ran0_91);
				  Scoring_QA.Range_function_module.range_function_76(DS2,'felonycount60',ran0_92);
					Scoring_QA.Range_function_module.range_function_31(DS2,'arrestcount',ran0_93);
					Scoring_QA.Range_function_module.range_function_31(DS2,'arrestcount01',ran0_94);
					Scoring_QA.Range_function_module.range_function_31(DS2,'arrestcount03',ran0_95);
					Scoring_QA.Range_function_module.range_function_31(DS2,'arrestcount06',ran0_96);
					Scoring_QA.Range_function_module.range_function_31(DS2,'arrestcount12',ran0_97);
					Scoring_QA.Range_function_module.range_function_31(DS2,'arrestcount24',ran0_98);
			    Scoring_QA.Range_function_module.range_function_31(DS2,'arrestcount36',ran0_99);
					Scoring_QA.Range_function_module.range_function_31(DS2,'arrestcount60',ran0_100);
					Scoring_QA.Range_function_module.range_function_76(DS2,'liencount',ran0_101);
			    Scoring_QA.Range_function_module.range_function_76(DS2,'lienfiledcount',ran0_102);
					Scoring_QA.Range_function_module.range_function_76(DS2,'lienfiledcount01',ran0_103);
					Scoring_QA.Range_function_module.range_function_76(DS2,'lienfiledcount03',ran0_104);
					Scoring_QA.Range_function_module.range_function_76(DS2,'lienfiledcount06',ran0_105);
					Scoring_QA.Range_function_module.range_function_76(DS2,'lienfiledcount12',ran0_106);
					Scoring_QA.Range_function_module.range_function_76(DS2,'lienfiledcount24',ran0_107);
					Scoring_QA.Range_function_module.range_function_76(DS2,'lienfiledcount36',ran0_108);
			    Scoring_QA.Range_function_module.range_function_76(DS2,'lienfiledcount60',ran0_109);
					Scoring_QA.Range_function_module.range_function_31(DS2,'lienreleasedcount',ran0_110);
					Scoring_QA.Range_function_module.range_function_31(DS2,'lienreleasedcount01',ran0_111);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'lienreleasedcount03',ran0_112);
					Scoring_QA.Range_function_module.range_function_31(DS2,'lienreleasedcount06',ran0_113);
					Scoring_QA.Range_function_module.range_function_31(DS2,'lienreleasedcount12',ran0_114);
					Scoring_QA.Range_function_module.range_function_31(DS2,'lienreleasedcount24',ran0_115);
					Scoring_QA.Range_function_module.range_function_31(DS2,'lienreleasedcount36',ran0_116);
					Scoring_QA.Range_function_module.range_function_31(DS2,'lienreleasedcount60',ran0_117);
					Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcycount',ran0_118);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcycount01',ran0_119);
					Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcycount03',ran0_120);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcycount06',ran0_121);
					Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcycount12',ran0_122);
					Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcycount24',ran0_123);
					Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcycount36',ran0_124);
					Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcycount60',ran0_125);
					Scoring_QA.Range_function_module.range_function_31(DS2,'evictioncount',ran0_126);
					Scoring_QA.Range_function_module.range_function_31(DS2,'evictioncount01',ran0_127);
					Scoring_QA.Range_function_module.range_function_31(DS2,'evictioncount03',ran0_128);
			    Scoring_QA.Range_function_module.range_function_31(DS2,'evictioncount06',ran0_129);
					Scoring_QA.Range_function_module.range_function_31(DS2,'evictioncount12',ran0_130);
					Scoring_QA.Range_function_module.range_function_31(DS2,'evictioncount24',ran0_131);
					Scoring_QA.Range_function_module.range_function_31(DS2,'evictioncount36',ran0_132);
					Scoring_QA.Range_function_module.range_function_31(DS2,'evictioncount60',ran0_133);
					Scoring_QA.Range_function_module.range_function_135(DS2,'nonderogcount',ran0_134);
					Scoring_QA.Range_function_module.range_function_136(DS2,'nonderogcount01',ran0_135);
					Scoring_QA.Range_function_module.range_function_136(DS2,'nonderogcount03',ran0_136);
					Scoring_QA.Range_function_module.range_function_136(DS2,'nonderogcount06',ran0_137);
					Scoring_QA.Range_function_module.range_function_136(DS2,'nonderogcount12',ran0_138);
			    Scoring_QA.Range_function_module.range_function_136(DS2,'nonderogcount24',ran0_139);
					Scoring_QA.Range_function_module.range_function_136(DS2,'nonderogcount36',ran0_140);
					Scoring_QA.Range_function_module.range_function_136(DS2,'nonderogcount60',ran0_141);
					Scoring_QA.Range_function_module.range_function_76(DS2,'profliccount',ran0_142);
					Scoring_QA.Range_function_module.range_function_76(DS2,'profliccount01',ran0_143);
					Scoring_QA.Range_function_module.range_function_76(DS2,'profliccount03',ran0_144);
					Scoring_QA.Range_function_module.range_function_76(DS2,'profliccount06',ran0_145);
					Scoring_QA.Range_function_module.range_function_76(DS2,'profliccount12',ran0_146);
					Scoring_QA.Range_function_module.range_function_76(DS2,'profliccount24',ran0_147);
					Scoring_QA.Range_function_module.range_function_76(DS2,'profliccount36',ran0_148);
			    Scoring_QA.Range_function_module.range_function_76(DS2,'profliccount60',ran0_149);
					// Scoring_QA.Range_function_module.Range_Function_0(DS2,'profliccount60',ran0_150);
					Scoring_QA.Range_function_module.range_function_76(DS2,'proflicexpirecount01',ran0_151);
					Scoring_QA.Range_function_module.range_function_76(DS2,'proflicexpirecount03',ran0_152);
				  Scoring_QA.Range_function_module.range_function_76(DS2,'proflicexpirecount06',ran0_153);
					Scoring_QA.Range_function_module.range_function_76(DS2,'proflicexpirecount12',ran0_154);
					Scoring_QA.Range_function_module.range_function_76(DS2,'proflicexpirecount24',ran0_155);
					Scoring_QA.Range_function_module.range_function_76(DS2,'proflicexpirecount36',ran0_156);
					Scoring_QA.Range_function_module.range_function_76(DS2,'proflicexpirecount60',ran0_157);
					Scoring_QA.Range_function_module.range_function_87(DS2,'prsearchcollectioncount',ran0_158);
			    Scoring_QA.Range_function_module.range_function_138(DS2,'prsearchcollectioncount01',ran0_159);
					Scoring_QA.Range_function_module.range_function_138(DS2,'prsearchcollectioncount03',ran0_160);
					Scoring_QA.Range_function_module.range_function_87(DS2,'prsearchcollectioncount06',ran0_161);
					Scoring_QA.Range_function_module.range_function_87(DS2,'prsearchcollectioncount12',ran0_162);
					Scoring_QA.Range_function_module.range_function_87(DS2,'prsearchcollectioncount24',ran0_163);
					Scoring_QA.Range_function_module.range_function_87(DS2,'prsearchcollectioncount36',ran0_164);
					Scoring_QA.Range_function_module.range_function_87(DS2,'prsearchcollectioncount60',ran0_165);
					Scoring_QA.Range_function_module.range_function_31(DS2,'prsearchidvfraudcount',ran0_166);
					Scoring_QA.Range_function_module.range_function_31(DS2,'prsearchidvfraudcount01',ran0_167);
					Scoring_QA.Range_function_module.range_function_31(DS2,'prsearchidvfraudcount03',ran0_168);
			    Scoring_QA.Range_function_module.range_function_31(DS2,'prsearchidvfraudcount06',ran0_169);
					Scoring_QA.Range_function_module.range_function_31(DS2,'prsearchidvfraudcount12',ran0_170);
					Scoring_QA.Range_function_module.range_function_31(DS2,'prsearchidvfraudcount24',ran0_171);
					Scoring_QA.Range_function_module.range_function_31(DS2,'prsearchidvfraudcount36',ran0_172);
					Scoring_QA.Range_function_module.range_function_31(DS2,'prsearchidvfraudcount60',ran0_173);
					Scoring_QA.Range_function_module.range_function_87(DS2,'prsearchothercount',ran0_174);
					Scoring_QA.Range_function_module.range_function_31(DS2,'prsearchothercount01',ran0_175);
					Scoring_QA.Range_function_module.range_function_25(DS2,'prsearchothercount03',ran0_176);
					Scoring_QA.Range_function_module.range_function_60(DS2,'prsearchothercount06',ran0_177);
					Scoring_QA.Range_function_module.range_function_60(DS2,'prsearchothercount12',ran0_178);
			    Scoring_QA.Range_function_module.range_function_60(DS2,'prsearchothercount24',ran0_179);
					Scoring_QA.Range_function_module.range_function_88(DS2,'prsearchothercount36',ran0_180);
					Scoring_QA.Range_function_module.range_function_89(DS2,'prsearchothercount60',ran0_181);		
						
						
					 	 ran_0:=   ran0_1  + ran0_2  + ran0_3  + ran0_4  + ran0_5  + ran0_6  + ran0_7  + ran0_8  + ran0_9  + ran0_10 +
				               ran0_11 + ran0_12 + ran0_13 + ran0_14 + ran0_15 + ran0_16 + ran0_17 + ran0_18 + ran0_19 + ran0_20 +
						           ran0_21 + ran0_22 + ran0_23 + ran0_24 + ran0_25 + ran0_26 + ran0_27 + ran0_28 + ran0_29 + ran0_30 +
				               ran0_31 + ran0_32 + ran0_33  +ran0_34 + ran0_35 + ran0_36 + ran0_37 + ran0_38 + ran0_39 + ran0_40 +
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
								 
			
								 
								
			
													 
								Scoring_QA.Range_function_module.Range_Function_1(DS2,'inputaddrcountyindex',ran1_1);
								Scoring_QA.Range_function_module.Range_Function_1(DS2,'inputaddrtractindex',ran1_2);
								Scoring_QA.Range_function_module.Range_Function_1(DS2,'inputaddrblockindex',ran1_3);
								Scoring_QA.Range_function_module.Range_Function_1(DS2,'curraddrcountyindex',ran1_4);
								Scoring_QA.Range_function_module.Range_Function_1(DS2,'curraddrtractindex',ran1_5);
							  Scoring_QA.Range_function_module.Range_Function_1(DS2,'curraddrblockindex',ran1_6);
							  Scoring_QA.Range_function_module.Range_Function_1(DS2,'prevaddrcountyindex',ran1_7);
								Scoring_QA.Range_function_module.Range_Function_1(DS2,'prevaddrtractindex',ran1_8);
								Scoring_QA.Range_function_module.Range_Function_1(DS2,'prevaddrblockindex',ran1_9);
								Scoring_QA.Range_function_module.Range_Function_1(DS2,'propnewestsalepurchaseindex',ran1_10);
											
						
											 
											
											 
											 ran_1:=ran1_1  + ran1_2  + ran1_3  + ran1_4  + ran1_5  + ran1_6  + ran1_7  + ran1_8  + ran1_9  + ran1_10;
				
								 Scoring_QA.Range_function_module.Range_Function_31(DS2,'srcsconfirmidaddrcount',ran2_1);
								
							      	
											 
											 					 ran_2:=ran2_1;
								 
								
								 
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'inputaddrmurderindex',ran5_1);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'inputaddrcartheftindex',ran5_2);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'inputaddrburglaryindex',ran5_3);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'inputaddrcrimeindex',ran5_4);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'curraddrmurderindex',ran5_5);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'curraddrcartheftindex',ran5_6);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'curraddrburglaryindex',ran5_7);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'curraddrcrimeindex',ran5_8);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'prevaddrmurderindex',ran5_9);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'prevaddrcartheftindex',ran5_10);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'prevaddrburglaryindex',ran5_11);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'prevaddrcrimeindex',ran5_12);
									
									
										 ran_5:=ran5_1  + ran5_2  + ran5_3  + ran5_4  + ran5_5  + ran5_6  + ran5_7  + ran5_8  + ran5_9  + ran5_10 +
				                   ran5_11 + ran5_12;
													 
													
										  Scoring_QA.Range_function_module.Range_Function_132(DS2,'inputcurraddrcrimediff',ran6_1);
								      Scoring_QA.Range_function_module.Range_Function_6(DS2,'currprevaddrcrimediff',ran6_2);
								 
								 	 ran_6:=ran6_1+ ran6_2;
									 
									Scoring_QA.Range_function_module.range_function_25(DS2,'derogcount',ran7_1);
								  // RiskView_Attributes_ReportsRange_Function_7(DS2,'derogrecentcount',ran7_2);
									
								 
								 ran_7:=ran7_1; 
							
										  				
				// Scoring_QA.Range_function_module.Distinct_function(DS2,'addrpop',dis1);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'creditbureaurecord',dis2);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verificationfailure',dis3);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'invalidssn',dis4);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'invalidaddr',dis5);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'invalidphone',dis6);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'addrstability',dis7);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnnotfound',dis8);
					Scoring_QA.Range_function_module.range_function_92(DS2,'ssnfoundother',dis9);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedname',dis10);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedssn',dis11);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedphone',dis12);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedphonefullname',dis13);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedphonelastname',dis14);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedaddress',dis15);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifieddob',dis16);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ageriskindicator',dis17);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'phoneother',dis18);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnrecent',dis19);
				  Scoring_QA.Range_function_module.range_function_139(DS2,'ssnlowissuedate',dis20);
					Scoring_QA.Range_function_module.range_function_139(DS2,'ssnhighissuedate',dis21);
					Scoring_QA.Range_function_module.range_function_116(DS2,'ssnissuestate',dis22);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnnonus',dis23);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnissuedpriordob',dis24);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssn3years',dis25);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnafter5',dis26);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnproblems',dis27);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'relativesdistanceclosest',dis28);
			    Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrdwelltype',dis29);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrlandusecode',dis30);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrapplicantowned',dis31);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrfamilyowned',dis32);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddroccupantowned',dis33);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrnotprimaryres',dis34);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddractivephonelist',dis35);
					Scoring_QA.Range_function_module.range_function_34(DS2,'inputaddrtaxyr',dis36);
					Scoring_QA.Range_function_module.range_function_34(DS2,'curraddrtaxyr',dis37);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddrdwelltype',dis38);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddrlandusecode',dis39);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddrapplicantowned',dis40);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddrfamilyowned',dis41);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddroccupantowned',dis42);
	        Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddrdwelltype',dis43);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddrlandusecode',dis44);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddrapplicantowned',dis45);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddrfamilyowned',dis46);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddroccupantowned',dis47);
					Scoring_QA.Range_function_module.range_function_34(DS2,'prevaddrtaxyr',dis48);
			  	Scoring_QA.Range_function_module.Distinct_function(DS2,'inputcurraddrmatch',dis49);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputcurraddrstatediff',dis50);
					Scoring_QA.Range_function_module.Distinct_function4(DS2,'inputcurrecontrajectory',dis51);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputprevaddrmatch',dis52);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'currprevaddrstatediff',dis53);
					Scoring_QA.Range_function_module.Distinct_function2(DS2,'prevcurrecontrajectory',dis54);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'educationattendedcollege',dis55);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationprogram2yr',dis56);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationprogram4yr',dis57);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationprogramgraduate',dis58);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationinstitutionprivate',dis59);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'educationinstitutionrating',dis60);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationfieldofstudytype',dis61);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'addrstability',dis62);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'statusmostrecent',dis63);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'statusprevious',dis64);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'statusnextprevious',dis65);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'wealthindex',dis66);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'derogseverityindex',dis67);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'bankruptcytype',dis68);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'bankruptcystatus',dis69);
          Scoring_QA.Range_function_module.Distinct_function(DS2,'proflictypecategory',dis70);
					Scoring_QA.Range_function_module.Distinct_function3(DS2,'proflicexpiredate',dis71);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputphonestatus',dis72);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputphonepager',dis73);	
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputphonemobile',dis74);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputphonetype',dis75);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'inputphoneservicetype',dis76);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputareacodechange',dis77);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'invalidphonezip',dis78);
					Scoring_QA.Range_function_module.Distinct_function3(DS2,'ssndatedeceased',dis79);
				  // Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrsiccode',dis80);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrvalidation',dis81);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrerrorcode',dis82);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrhighrisk',dis83);	
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputphonehighrisk',dis84);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrprison',dis85);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddrprison',dis86);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddrprison',dis87);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'historicaladdrprison',dis88);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputzippobox',dis89);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'inputzipcorpmil',dis90);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'donotmail',dis91);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnissued',dis92);							
					Scoring_QA.Range_function_module.Distinct_function(DS2,'historydate',dis93);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'fnamepop',dis94);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'lnamepop',dis95);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'addrpop',dis96);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnlength',dis97);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'dobpop',dis98);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'emailpop',dis99);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ipaddrpop',dis100);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'hphnpop',dis101);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddractivephonenumber',dis102);
					Scoring_QA.Range_function_module.range_function_123(DS2,'curraddragenewestrecord',dis103);
					Scoring_QA.Range_function_module.range_function_124(DS2,'curraddrageoldestrecord',dis104);
					
					
					dis:=   dis2  + dis3  + dis4  + dis5  + dis6 + dis7  + dis8  + dis9  + dis10 +
				       dis11 + dis12 + dis13 + dis14 + dis15 + dis16 +dis17 + dis18 + dis19  + dis20 +
							 dis21 + dis22 + dis23 + dis24 + dis25 + dis26+ dis28 + dis29 + dis30 +
				       dis31 + dis32 + dis33 + dis34 + dis35 + dis36 + dis37 + dis38 + dis39 + dis40 +
				       dis41 + dis42 + dis43 + dis44 + dis45 + dis46 + dis47 + dis48 + dis49 + dis50 + 
							 dis51 + dis52 + dis53 + dis54 + dis55 + dis56 + dis57 + dis58 + dis59 + dis60 +
               dis61 + dis63 + dis64 + dis65  + dis67 + dis68  + dis69 + dis70 + 
               dis71 + dis72 + dis73 + dis74 + dis75  + dis77 + dis78  + dis79 +
               dis81 + dis83 + dis84 + dis85 + dis86 + dis87 + dis88 + dis89 + dis90 + 
					     dis91 + dis92 + dis93 + dis94 + dis95 + dis96 + dis97 + dis98 + dis99 + dis100 + 
				       dis101  + dis103 + dis104;  
				
						
				  	Scoring_QA.Range_function_module.Length_Function(DS2,'inputaddractivephonenumber',len1);
						Scoring_QA.Range_function_module.Length_Function(DS2,'curraddractivephonenumber',len2);
						Scoring_QA.Range_function_module.Length_Function(DS2,'prevaddractivephonenumber',len3);
				
			            len:=len1 + len2 + len3;
				
					 Scoring_QA.Range_function_module.Distinct_function7(DS2,'did',did1);
	 
	 					
				 
	 did_stats:=did1;
								
      
			
			result2_stats:= ran + dis + ran_0 + ran_1 +ran_2  + ran_5 +ran_6 +ran_7 + did_stats + len;
   				
         
                   
					
					
      	Scoring_QA.Range_function_module.Average_func(DS2,'ageoldestrecord',ave1);
      	Scoring_QA.Range_function_module.Average_func(DS2,'agenewestrecord',ave2);
				Scoring_QA.Range_function_module.Average_func(DS2,'relativespropownedtaxtotal',ave3);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrlastsalesprice',ave4);
		    Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrtaxvalue',ave5);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrtaxmarketvalue',ave6);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputaddravmtax',ave7);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputaddravmsalesprice',ave8);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddravmhedonic',ave9);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputaddravmvalue',ave10);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrmedianincome',ave11);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrmedianvalue',ave12);
		    Scoring_QA.Range_function_module.Average_func(DS2,'curraddrlastsalesprice',ave13);
		  	Scoring_QA.Range_function_module.Average_func(DS2,'curraddrtaxvalue',ave14);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddrtaxmarketvalue',ave15);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddravmtax',ave16);
      	Scoring_QA.Range_function_module.Average_func(DS2,'curraddravmsalesprice',ave17);
      	Scoring_QA.Range_function_module.Average_func(DS2,'curraddravmhedonic',ave18);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddravmvalue',ave19);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddrmedianincome',ave20);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddrmedianvalue',ave21);
	    	Scoring_QA.Range_function_module.Average_func(DS2,'prevaddragelastsale',ave22);
      	Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrlastsalesprice',ave23);
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddractivephonelist',ave24);
      	Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrtaxvalue',ave25);
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrtaxmarketvalue',ave26);
      	Scoring_QA.Range_function_module.Average_func(DS2,'prevaddravmtax',ave27);
      	Scoring_QA.Range_function_module.Average_func(DS2,'prevaddravmsalesprice',ave28);
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddravmhedonic',ave29);
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddravmvalue',ave30);
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrmedianincome',ave31);
      	Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrmedianvalue',ave32);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputcurraddrdistance',ave33);
			  // Scoring_QA.Range_function_module.Average_func(DS2,'inputcurraddrtaxdiff',ave34);
      	// Scoring_QA.Range_function_module.Average_func(DS2,'inputcurraddrincomediff',ave35);
				// Scoring_QA.Range_function_module.Average_func(DS2,'inputcurraddrvaluediff',ave36);
      	Scoring_QA.Range_function_module.Average_func(DS2,'predictedannualincome',ave37);
				Scoring_QA.Range_function_module.Average_func(DS2,'currprevaddrdistance',ave38);
				// Scoring_QA.Range_function_module.Average_func(DS2,'currprevaddrtaxdiff',ave39);
				// Scoring_QA.Range_function_module.Average_func(DS2,'currprevaddrincomediff',ave40);
				// Scoring_QA.Range_function_module.Average_func(DS2,'currprevaddrvaluediff',ave41);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputphoneaddrdist',ave42);
				Scoring_QA.Range_function_module.Average_func(DS2,'propownedtaxtotal',ave43);
				Scoring_QA.Range_function_module.Average_func(DS2,'propagenewestsale',ave44);
				// Scoring_QA.Range_function_module.Average_func(DS2,'ageoldestrecord',ave45);
				// Scoring_QA.Range_function_module.Average_func(DS2,'agenewestrecord',ave46);
				Scoring_QA.Range_function_module.Average_func(DS2,'lastnamechangeage',ave47);
				Scoring_QA.Range_function_module.Average_func(DS2,'ssndeceased',ave48);
				// Scoring_QA.Range_function_module.Average_func(DS2,'ssndatedeceased',ave49);
				// Scoring_QA.Range_function_module.Average_func(DS2,'ssnissued',ave50);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrageoldestrecord',ave51);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputaddragenewestrecord',ave52);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrlenofres',ave53);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddragelastsale',ave54);
      	Scoring_QA.Range_function_module.Average_func(DS2,'curraddrageoldestrecord',ave55);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddragenewestrecord',ave56);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddrlenofres',ave57);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddragelastsale',ave58);
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrageoldestrecord',ave59);
      	Scoring_QA.Range_function_module.Average_func(DS2,'prevaddragenewestrecord',ave60);
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrlenofres',ave61);
			  Scoring_QA.Range_function_module.Average_func(DS2,'propageoldestpurchase',ave62);
				Scoring_QA.Range_function_module.Average_func(DS2,'propagenewestpurchase',ave63);
				Scoring_QA.Range_function_module.Average_func(DS2,'derogage',ave64);
		    Scoring_QA.Range_function_module.Average_func(DS2,'felonyage',ave65);
				Scoring_QA.Range_function_module.Average_func(DS2,'arrestage',ave66);
      	Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledage',ave67);
      	Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedage',ave68);
				Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcyage',ave69);
      	Scoring_QA.Range_function_module.Average_func(DS2,'evictionage',ave70);
				Scoring_QA.Range_function_module.Average_func(DS2,'proflicage',ave71);
      	Scoring_QA.Range_function_module.Average_func(DS2,'phoneedaageoldestrecord',ave72);
				Scoring_QA.Range_function_module.Average_func(DS2,'phoneedaagenewestrecord',ave73);
				Scoring_QA.Range_function_module.Average_func(DS2,'phoneotherageoldestrecord',ave74);
		    Scoring_QA.Range_function_module.Average_func(DS2,'phoneotheragenewestrecord',ave75);
				Scoring_QA.Range_function_module.Average_func(DS2,'derogcount',ave76);
				
      		Scoring_QA.Range_function_module.Average_func(DS2,'subprimesolicitedcount01',ave77);
				  Scoring_QA.Range_function_module.Average_func(DS2,'subprimesolicitedcount03',ave78);
					Scoring_QA.Range_function_module.Average_func(DS2,'subprimesolicitedcount06',ave79);
					Scoring_QA.Range_function_module.Average_func(DS2,'subprimesolicitedcount12',ave80);
					Scoring_QA.Range_function_module.Average_func(DS2,'subprimesolicitedcount24',ave81);
				  Scoring_QA.Range_function_module.Average_func(DS2,'subprimesolicitedcount36',ave82);
					Scoring_QA.Range_function_module.Average_func(DS2,'subprimesolicitedcount60',ave83);
					Scoring_QA.Range_function_module.Average_func(DS2,'felonycount',ave84);
					// Scoring_QA.Range_function_module.Average_func(DS2,'derogcount',ave85);
			    Scoring_QA.Range_function_module.Average_func(DS2,'felonycount01',ave86);
		  		Scoring_QA.Range_function_module.Average_func(DS2,'felonycount03',ave87);
			    Scoring_QA.Range_function_module.Average_func(DS2,'felonycount06',ave88);
					Scoring_QA.Range_function_module.Average_func(DS2,'felonycount12',ave89);
					Scoring_QA.Range_function_module.Average_func(DS2,'felonycount24',ave90);
					Scoring_QA.Range_function_module.Average_func(DS2,'felonycount36',ave91);
				  Scoring_QA.Range_function_module.Average_func(DS2,'felonycount60',ave92);
					Scoring_QA.Range_function_module.Average_func(DS2,'arrestcount',ave93);
					Scoring_QA.Range_function_module.Average_func(DS2,'arrestcount01',ave94);
					Scoring_QA.Range_function_module.Average_func(DS2,'arrestcount03',ave95);
					Scoring_QA.Range_function_module.Average_func(DS2,'arrestcount06',ave96);
					Scoring_QA.Range_function_module.Average_func(DS2,'arrestcount12',ave97);
					Scoring_QA.Range_function_module.Average_func(DS2,'arrestcount24',ave98);
			    Scoring_QA.Range_function_module.Average_func(DS2,'arrestcount36',ave99);
					Scoring_QA.Range_function_module.Average_func(DS2,'arrestcount60',ave100);
					Scoring_QA.Range_function_module.Average_func(DS2,'liencount',ave101);
			    Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount',ave102);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount01',ave103);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount03',ave104);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount06',ave105);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount12',ave106);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount24',ave107);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount36',ave108);
			    Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount60',ave109);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount',ave110);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount01',ave111);
				  Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount03',ave112);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount06',ave113);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount12',ave114);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount24',ave115);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount36',ave116);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount60',ave117);
					Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount',ave118);
				  Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount01',ave119);
					Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount03',ave120);
				  Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount06',ave121);
					Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount12',ave122);
					Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount24',ave123);
					Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount36',ave124);
					Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount60',ave125);
					Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount',ave126);
					Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount01',ave127);
					Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount03',ave128);
			    Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount06',ave129);
					Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount12',ave130);
					Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount24',ave131);
					Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount36',ave132);
					Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount60',ave133);
					Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount',ave134);
					Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount01',ave135);
					Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount03',ave136);
					Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount06',ave137);
					Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount12',ave138);
			    Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount24',ave139);
					Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount36',ave140);
					Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount60',ave141);
					Scoring_QA.Range_function_module.Average_func(DS2,'profliccount',ave142);
					Scoring_QA.Range_function_module.Average_func(DS2,'profliccount01',ave143);
					Scoring_QA.Range_function_module.Average_func(DS2,'profliccount03',ave144);
					Scoring_QA.Range_function_module.Average_func(DS2,'profliccount06',ave145);
					Scoring_QA.Range_function_module.Average_func(DS2,'profliccount12',ave146);
					Scoring_QA.Range_function_module.Average_func(DS2,'profliccount24',ave147);
					Scoring_QA.Range_function_module.Average_func(DS2,'profliccount36',ave148);
			    Scoring_QA.Range_function_module.Average_func(DS2,'profliccount60',ave149);
					// Scoring_QA.Range_function_module.Average_func(DS2,'profliccount60',ave150);
					Scoring_QA.Range_function_module.Average_func(DS2,'proflicexpirecount01',ave151);
					Scoring_QA.Range_function_module.Average_func(DS2,'proflicexpirecount03',ave152);
				  Scoring_QA.Range_function_module.Average_func(DS2,'proflicexpirecount06',ave153);
					Scoring_QA.Range_function_module.Average_func(DS2,'proflicexpirecount12',ave154);
					Scoring_QA.Range_function_module.Average_func(DS2,'proflicexpirecount24',ave155);
					Scoring_QA.Range_function_module.Average_func(DS2,'proflicexpirecount36',ave156);
					Scoring_QA.Range_function_module.Average_func(DS2,'proflicexpirecount60',ave157);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchcollectioncount',ave158);
			    Scoring_QA.Range_function_module.Average_func(DS2,'prsearchcollectioncount01',ave159);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchcollectioncount03',ave160);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchcollectioncount06',ave161);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchcollectioncount12',ave162);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchcollectioncount24',ave163);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchcollectioncount36',ave164);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchcollectioncount60',ave165);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchidvfraudcount',ave166);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchidvfraudcount01',ave167);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchidvfraudcount03',ave168);
			    Scoring_QA.Range_function_module.Average_func(DS2,'prsearchidvfraudcount06',ave169);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchidvfraudcount12',ave170);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchidvfraudcount24',ave171);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchidvfraudcount36',ave172);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchidvfraudcount60',ave173);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchothercount',ave174);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchothercount01',ave175);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchothercount03',ave176);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchothercount06',ave177);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchothercount12',ave178);
			    Scoring_QA.Range_function_module.Average_func(DS2,'prsearchothercount24',ave179);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchothercount36',ave180);
					Scoring_QA.Range_function_module.Average_func(DS2,'prsearchothercount60',ave181);	
					
							 
					Scoring_QA.Range_function_module.Average_func(DS2,'subjectaddrcount',ave182);
					Scoring_QA.Range_function_module.Average_func(DS2,'subjectphonecount',ave183);
					Scoring_QA.Range_function_module.Average_func(DS2,'subjectssnrecentcount',ave184);
					Scoring_QA.Range_function_module.Average_func(DS2,'subjectaddrrecentcount',ave185);
					Scoring_QA.Range_function_module.Average_func(DS2,'subjectphonerecentcount',ave186);
					Scoring_QA.Range_function_module.Average_func(DS2,'ssnidentitiescount',ave187);
					Scoring_QA.Range_function_module.Average_func(DS2,'ssnaddrcount',ave188);
			    Scoring_QA.Range_function_module.Average_func(DS2,'ssnidentitiesrecentcount',ave189);
					Scoring_QA.Range_function_module.Average_func(DS2,'ssnaddrrecentcount',ave190);
					Scoring_QA.Range_function_module.Average_func(DS2,'inputaddridentitiescount',ave191);
					Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrssncount',ave192);
					Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrphonecount',ave193);
					Scoring_QA.Range_function_module.Average_func(DS2,'inputaddridentitiesrecentcount',ave194);
					Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrssnrecentcount',ave195);
					Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrphonerecentcount',ave196);
					Scoring_QA.Range_function_module.Average_func(DS2,'phoneidentitiescount',ave197);
				  Scoring_QA.Range_function_module.Average_func(DS2,'phoneidentitiesrecentcount',ave198);
					Scoring_QA.Range_function_module.Average_func(DS2,'ssnlastnamecount',ave199);
					Scoring_QA.Range_function_module.Average_func(DS2,'subjectlastnamecount',ave200);
					Scoring_QA.Range_function_module.Average_func(DS2,'lastnamechangecount01',ave201);
				  Scoring_QA.Range_function_module.Average_func(DS2,'lastnamechangecount03',ave202);
					Scoring_QA.Range_function_module.Average_func(DS2,'lastnamechangecount06',ave203);
					Scoring_QA.Range_function_module.Average_func(DS2,'lastnamechangecount12',ave204);
					Scoring_QA.Range_function_module.Average_func(DS2,'lastnamechangecount24',ave205);
				  Scoring_QA.Range_function_module.Average_func(DS2,'lastnamechangecount36',ave206);
		  		Scoring_QA.Range_function_module.Average_func(DS2,'lastnamechangecount60',ave207);
			  	Scoring_QA.Range_function_module.Average_func(DS2,'sfduaddridentitiescount',ave208);
					Scoring_QA.Range_function_module.Average_func(DS2,'sfduaddrssncount',ave209);
				  Scoring_QA.Range_function_module.Average_func(DS2,'relativescount',ave210);
      	  Scoring_QA.Range_function_module.Average_func(DS2,'relativesbankruptcycount',ave211);
      	  Scoring_QA.Range_function_module.Average_func(DS2,'relativesfelonycount',ave212);
				  Scoring_QA.Range_function_module.Average_func(DS2,'relativespropownedcount',ave213);
			 	  Scoring_QA.Range_function_module.Average_func(DS2,'inputaddravmconfidence',ave214);
				  Scoring_QA.Range_function_module.Average_func(DS2,'curraddravmconfidence',ave215);
				  Scoring_QA.Range_function_module.Average_func(DS2,'prevaddravmconfidence',ave216);
		   	  Scoring_QA.Range_function_module.Average_func(DS2,'addrchangecount01',ave217);
      	  Scoring_QA.Range_function_module.Average_func(DS2,'addrchangecount03',ave218);
			    Scoring_QA.Range_function_module.Average_func(DS2,'addrchangecount06',ave219);
				  Scoring_QA.Range_function_module.Average_func(DS2,'addrchangecount12',ave220);
      	  Scoring_QA.Range_function_module.Average_func(DS2,'addrchangecount24',ave221);
      	  Scoring_QA.Range_function_module.Average_func(DS2,'addrchangecount36',ave222);
				  Scoring_QA.Range_function_module.Average_func(DS2,'addrchangecount60',ave223);
					Scoring_QA.Range_function_module.Average_func(DS2,'propownedcount',ave224);
					Scoring_QA.Range_function_module.Average_func(DS2,'propownedhistoricalcount',ave225);
					Scoring_QA.Range_function_module.Average_func(DS2,'proppurchasedcount01',ave226);
					Scoring_QA.Range_function_module.Average_func(DS2,'proppurchasedcount03',ave227);
					Scoring_QA.Range_function_module.Average_func(DS2,'proppurchasedcount06',ave228);
					Scoring_QA.Range_function_module.Average_func(DS2,'proppurchasedcount12',ave229);
					Scoring_QA.Range_function_module.Average_func(DS2,'proppurchasedcount24',ave230);
					Scoring_QA.Range_function_module.Average_func(DS2,'proppurchasedcount36',ave231);
					Scoring_QA.Range_function_module.Average_func(DS2,'proppurchasedcount60',ave232);
					Scoring_QA.Range_function_module.Average_func(DS2,'propsoldcount01',ave233);
					Scoring_QA.Range_function_module.Average_func(DS2,'propsoldcount03',ave234);
					Scoring_QA.Range_function_module.Average_func(DS2,'propsoldcount06',ave235);
					Scoring_QA.Range_function_module.Average_func(DS2,'propsoldcount12',ave236);
					Scoring_QA.Range_function_module.Average_func(DS2,'propsoldcount24',ave237);
				  Scoring_QA.Range_function_module.Average_func(DS2,'propsoldcount36',ave238);
					Scoring_QA.Range_function_module.Average_func(DS2,'propsoldcount60',ave239);
					Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount',ave240);
					Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount01',ave241);
				  Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount03',ave242);
					Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount06',ave243);
					Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount12',ave244);
					Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount24',ave245);
				  Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount36',ave246);
		  		Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount60',ave247);
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount',ave248);
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount01',ave249);
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount03',ave250);
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount06',ave251);
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount12',ave252);
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount24',ave253);
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount36',ave254);
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount60',ave255);
					Scoring_QA.Range_function_module.Average_func(DS2,'subprimesolicitedcount',ave256);
					Scoring_QA.Range_function_module.Average_func(DS2,'subjectssncount',ave257);
								
				
      	
      	   avearage:= ave1  + ave2  + ave3  + ave4  + ave5  + ave6  + ave7  + ave8  + ave9  + ave10 +
				           ave11 + ave12 + ave13 + ave14 + ave15 + ave16 + ave17 + ave18 + ave19 + ave20 +
						       ave21 + ave22 + ave23 + ave24 + ave25 + ave26 + ave27 + ave28 + ave29 + ave30 +
				           ave31 + ave32 + ave33      + ave37 + ave38      + ave42 + ave43 + ave44  + ave47 + ave48  +
									 ave51 + ave52 + ave53 + ave54 + ave55 + ave56 + ave57 + ave58 + ave59 + ave60 +
                   ave61 + ave62 + ave63 + ave64 + ave65 + ave66 + ave67 + ave68 + ave69 + ave70 + 
                   ave71 + ave72 + ave73 + ave74 + ave75 + ave76 + ave77 + ave78 + ave79 + ave80 + 
                   ave81 + ave82 + ave83 + ave84  + ave86 + ave87 + ave88 + ave89 + ave90 + 
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
									 ave211 + ave212 + ave213 + ave214 + ave215 + ave216 + ave217 + ave218 + ave219 + ave220 + 
									 ave221 + ave222 + ave223 + ave224 + ave225 + ave226 + ave227 + ave228 + ave229 + ave230 + 
									 ave231 + ave232 + ave233 + ave234 + ave235 + ave236 + ave237 + ave238 + ave239 + ave240 + 
									 ave241 + ave242 + ave243 + ave244 + ave245 + ave246 + ave247 + ave248 + ave249 + ave250 + 
									 ave251 + ave252 + ave253 + ave254 + ave255 + ave256 + ave257;

					
	
											 
								 Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'inputcurraddrtaxdiff',ranave01);
								 Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'inputcurraddrincomediff',ranave02);
								 Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'inputcurraddrvaluediff',ranave03);
								 Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'currprevaddrtaxdiff',ranave04);
								 Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'currprevaddrincomediff',ranave05);
								 Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'currprevaddrvaluediff',ranave06);
								 
											 
											 ranave0:=ranave01  + ranave02  + ranave03  + ranave04  + ranave05  + ranave06;			 
	
	
	 
   result4_stats:=avearage + ranave0 ;
	 
	
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
                                         self.file_version:='leadintegrity_generic_v3';
																				 self.mode:='batch';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='leadintegrity_generic_v3';
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

		  did_results := DATASET([{'leadintegrity_generic_v3','batch','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
											
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ name + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ name + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ name + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2);

return seq;

endmacro;

	