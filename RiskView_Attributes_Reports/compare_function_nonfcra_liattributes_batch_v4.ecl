EXPORT compare_function_nonfcra_liattributes_batch_v4(current_dt,previous_dt) := functionmacro



 file1:= dataset('~foreign::10.241.3.238::sghatti::out::nonfcra_liattributes_batch_v40_'+previous_dt, RiskView_Attributes_Reports.nonfcra_liattributes_batch_v4_layout,


 CSV(HEADING(single), QUOTE('"')));

 file2:= dataset('~foreign::10.241.3.238::sghatti::out::nonfcra_liattributes_batch_v40_'+current_dt, RiskView_Attributes_Reports.nonfcra_liattributes_batch_v4_layout,


 CSV(HEADING(single), QUOTE('"')));



aa1:=join(file1,file2,left.accountnumber=right.accountnumber,inner);

aa:=aa1(accountnumber<>'');


DS1:=join(file1,aa,left.accountnumber=right.accountnumber,inner);

DS2:=join(file2,aa,left.accountnumber=right.accountnumber,inner);
   	    
      	
      	RiskView_Attributes_Reports.Range_func(DS1,'ageoldestrecord',ra1);
      	RiskView_Attributes_Reports.Range_func(DS1,'agenewestrecord',ra2);
				RiskView_Attributes_Reports.Range_func(DS1,'lastnamechangeage',ra3);
				// RiskView_Attributes_Reports.Range_func(DS1,'ssndeceased',ra4);
      	// RiskView_Attributes_Reports.Range_func(DS1,'ssndatedeceased',ra5);
				// RiskView_Attributes_Reports.Range_func(DS1,'ssnissued',ra6);
		   	RiskView_Attributes_Reports.Range_func(DS1,'inputaddrageoldestrecord',ra7);
      	RiskView_Attributes_Reports.Range_func(DS1,'inputaddragenewestrecord',ra8);
				RiskView_Attributes_Reports.Range_func(DS1,'inputaddrlenofres',ra9);
				RiskView_Attributes_Reports.Range_func(DS1,'inputaddragelastsale',ra10);
			 	RiskView_Attributes_Reports.Range_func(DS1,'curraddrageoldestrecord',ra11);
				RiskView_Attributes_Reports.Range_func(DS1,'curraddragenewestrecord',ra12);
				RiskView_Attributes_Reports.Range_func(DS1,'curraddrlenofres',ra13);
			 	RiskView_Attributes_Reports.Range_func(DS1,'curraddragelastsale',ra14);
			 	RiskView_Attributes_Reports.Range_func(DS1,'prevaddrageoldestrecord',ra15);
				RiskView_Attributes_Reports.Range_func(DS1,'prevaddragenewestrecord',ra16);
				RiskView_Attributes_Reports.Range_func(DS1,'prevaddrlenofres',ra17);
			 	RiskView_Attributes_Reports.Range_func(DS1,'propageoldestpurchase',ra18);
				RiskView_Attributes_Reports.Range_func(DS1,'propagenewestpurchase',ra19);
				RiskView_Attributes_Reports.Range_func(DS1,'derogage',ra20);
				RiskView_Attributes_Reports.Range_func(DS1,'felonyage',ra21);
		   	RiskView_Attributes_Reports.Range_func(DS1,'arrestage',ra22);
				RiskView_Attributes_Reports.Range_func(DS1,'lienfiledage',ra23);
				RiskView_Attributes_Reports.Range_func(DS1,'lienreleasedage',ra24);
				RiskView_Attributes_Reports.Range_func(DS1,'bankruptcyage',ra25);
				RiskView_Attributes_Reports.Range_func(DS1,'evictionage',ra26);
			 	RiskView_Attributes_Reports.Range_func(DS1,'proflicage',ra27);
		   	RiskView_Attributes_Reports.Range_func(DS1,'phoneedaageoldestrecord',ra28);
				RiskView_Attributes_Reports.Range_func(DS1,'phoneedaagenewestrecord',ra29);
      	RiskView_Attributes_Reports.Range_func(DS1,'phoneotherageoldestrecord',ra30);
			 	RiskView_Attributes_Reports.Range_func(DS1,'phoneotheragenewestrecord',ra31);
				// RiskView_Attributes_Reports.Range_func(DS1,'phoneotheragenewestrecord',ra32);
				RiskView_Attributes_Reports.Range_func(DS1,'addrmostrecentstatediff',ra33);
				RiskView_Attributes_Reports.Range_func(DS1,'businessassociationage',ra34);
				RiskView_Attributes_Reports.Range_func(DS1,'accidentage',ra35);
	
				
			  	
      	ra:= ra1  + ra2  + ra3     + ra7  + ra8  + ra9  + ra10 +
				     ra11 + ra12 + ra13 + ra14 + ra15 + ra16 + ra17 + ra18 + ra19 + ra20 +
						 ra21 + ra22 + ra23 + ra24 + ra25 + ra26 + ra27 + ra28 + ra29 + ra30 + 
           	 ra31 + ra33 + ra34 + ra35;
				
				
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'subjectssncount',ra0_1);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subjectaddrcount',ra0_2);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subjectphonecount',ra0_3);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subjectssnrecentcount',ra0_4);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subjectaddrrecentcount',ra0_5);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subjectphonerecentcount',ra0_6);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'ssnidentitiescount',ra0_7);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'ssnaddrcount',ra0_8);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'ssnidentitiesrecentcount',ra0_9);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'ssnaddrrecentcount',ra0_10);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddridentitiescount',ra0_11);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrssncount',ra0_12);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrphonecount',ra0_13);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddridentitiesrecentcount',ra0_14);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrssnrecentcount',ra0_15);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrphonerecentcount',ra0_16);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'phoneidentitiescount',ra0_17);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'phoneidentitiesrecentcount',ra0_18);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'ssnlastnamecount',ra0_19);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subjectlastnamecount',ra0_20);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lastnamechangecount01',ra0_21);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'lastnamechangecount03',ra0_22);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lastnamechangecount06',ra0_23);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lastnamechangecount12',ra0_24);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lastnamechangecount24',ra0_25);
				  // RiskView_Attributes_Reports.Range_Function_0(DS1,'lastnamechangecount36',ra0_26);
		  		RiskView_Attributes_Reports.Range_Function_0(DS1,'lastnamechangecount60',ra0_27);
			  	RiskView_Attributes_Reports.Range_Function_0(DS1,'sfduaddridentitiescount',ra0_28);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'sfduaddrssncount',ra0_29);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'relativescount',ra0_30);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'relativesbankruptcycount',ra0_31);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'relativesfelonycount',ra0_32);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'relativespropownedcount',ra0_33);
			 	  // RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddravmconfidence',ra0_34);
				  // RiskView_Attributes_Reports.Range_Function_0(DS1,'curraddravmconfidence',ra0_35);
				  // RiskView_Attributes_Reports.Range_Function_0(DS1,'prevaddravmconfidence',ra0_36);
		   	  RiskView_Attributes_Reports.Range_Function_0(DS1,'addrchangecount01',ra0_37);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'addrchangecount03',ra0_38);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'addrchangecount06',ra0_39);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'addrchangecount12',ra0_40);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'addrchangecount24',ra0_41);
      	  // RiskView_Attributes_Reports.Range_Function_0(DS1,'addrchangecount36',ra0_42);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'addrchangecount60',ra0_43);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propownedcount',ra0_44);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propownedhistoricalcount',ra0_45);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'proppurchasedcount01',ra0_46);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'proppurchasedcount03',ra0_47);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'proppurchasedcount06',ra0_48);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'proppurchasedcount12',ra0_49);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'proppurchasedcount24',ra0_50);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'proppurchasedcount36',ra0_51);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'proppurchasedcount60',ra0_52);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propsoldcount01',ra0_53);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propsoldcount03',ra0_54);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propsoldcount06',ra0_55);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propsoldcount12',ra0_56);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propsoldcount24',ra0_57);
				  // RiskView_Attributes_Reports.Range_Function_0(DS1,'propsoldcount36',ra0_58);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propsoldcount60',ra0_59);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount',ra0_60);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount01',ra0_61);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount03',ra0_62);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount06',ra0_63);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount12',ra0_64);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount24',ra0_65);
				  // RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount36',ra0_66);
		  		RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount60',ra0_67);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount',ra0_68);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount01',ra0_69);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount03',ra0_70);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount06',ra0_71);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount12',ra0_72);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount24',ra0_73);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount36',ra0_74);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount60',ra0_75);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount',ra0_76);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount01',ra0_77);
				  // RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount03',ra0_78);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount06',ra0_79);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount12',ra0_80);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount24',ra0_81);
				  // RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount36',ra0_82);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount60',ra0_83);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount',ra0_84);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'derogcount',ra0_85);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount01',ra0_86);
		  		RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount03',ra0_87);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount06',ra0_88);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount12',ra0_89);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount24',ra0_90);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount36',ra0_91);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount60',ra0_92);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'arrestcount',ra0_93);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'arrestcount01',ra0_94);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'arrestcount03',ra0_95);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'arrestcount06',ra0_96);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'arrestcount12',ra0_97);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'arrestcount24',ra0_98);
			    // RiskView_Attributes_Reports.Range_Function_0(DS1,'arrestcount36',ra0_99);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'arrestcount60',ra0_100);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'liencount',ra0_101);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount',ra0_102);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount01',ra0_103);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount03',ra0_104);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount06',ra0_105);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount12',ra0_106);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount24',ra0_107);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount36',ra0_108);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount60',ra0_109);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount',ra0_110);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount01',ra0_111);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount03',ra0_112);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount06',ra0_113);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount12',ra0_114);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount24',ra0_115);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount36',ra0_116);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount60',ra0_117);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount',ra0_118);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount01',ra0_119);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount03',ra0_120);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount06',ra0_121);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount12',ra0_122);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount24',ra0_123);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount36',ra0_124);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount60',ra0_125);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount',ra0_126);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount01',ra0_127);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount03',ra0_128);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount06',ra0_129);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount12',ra0_130);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount24',ra0_131);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount36',ra0_132);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount60',ra0_133);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount',ra0_134);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount01',ra0_135);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount03',ra0_136);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount06',ra0_137);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount12',ra0_138);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount24',ra0_139);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount36',ra0_140);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount60',ra0_141);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount',ra0_142);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount01',ra0_143);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount03',ra0_144);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount06',ra0_145);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount12',ra0_146);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount24',ra0_147);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount36',ra0_148);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount60',ra0_149);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount60',ra0_150);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'proflicexpirecount01',ra0_151);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'proflicexpirecount03',ra0_152);
				  // RiskView_Attributes_Reports.Range_Function_0(DS1,'proflicexpirecount06',ra0_153);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'proflicexpirecount12',ra0_154);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'proflicexpirecount24',ra0_155);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'proflicexpirecount36',ra0_156);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'proflicexpirecount60',ra0_157);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchcollectioncount',ra0_158);
			    // RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchcollectioncount01',ra0_159);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchcollectioncount03',ra0_160);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchcollectioncount06',ra0_161);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchcollectioncount12',ra0_162);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchcollectioncount24',ra0_163);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchcollectioncount36',ra0_164);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchcollectioncount60',ra0_165);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchidvfraudcount',ra0_166);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchidvfraudcount01',ra0_167);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchidvfraudcount03',ra0_168);
			    // RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchidvfraudcount06',ra0_169);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchidvfraudcount12',ra0_170);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchidvfraudcount24',ra0_171);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchidvfraudcount36',ra0_172);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchidvfraudcount60',ra0_173);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchothercount',ra0_174);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchothercount01',ra0_175);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchothercount03',ra0_176);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchothercount06',ra0_177);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchothercount12',ra0_178);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchothercount24',ra0_179);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchothercount36',ra0_180);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchothercount60',ra0_181);
					
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchlocatecount',ra0_182);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchlocatecount01',ra0_183);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchlocatecount03',ra0_184);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchlocatecount06',ra0_185);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchlocatecount12',ra0_186);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchlocatecount24',ra0_187);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchpersonalfinancecount',ra0_188);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchpersonalfinancecount01',ra0_189);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchpersonalfinancecount03',ra0_190);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchpersonalfinancecount06',ra0_191);		
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchpersonalfinancecount12',ra0_192);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchpersonalfinancecount24',ra0_193);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchidentityssns',ra0_194);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchidentityaddrs',ra0_195);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchidentityphones',ra0_196);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchssnidentities',ra0_197);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchaddridentities',ra0_198);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'prsearchphoneidentities',ra0_199);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount',ra0_200);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount01',ra0_201);		
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount03',ra0_202);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount06',ra0_203);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount12',ra0_204);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount24',ra0_205);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount60',ra0_206);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrvacantpropcount',ra0_207);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrbusinesscount',ra0_208);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrsinglefamilycount',ra0_209);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrmultifamilycount',ra0_210);	
					RiskView_Attributes_Reports.Range_Function_0(DS1,'businessinputaddrcount',ra0_211);	
					RiskView_Attributes_Reports.Range_Function_0(DS1,'accidentcount',ra0_212);
					
					RiskView_Attributes_Reports.Range_Function_0(DS1,'sourceordersourcecount',ra0_213);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'sourceorderagelastorder',ra0_214);		
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationidentitycount',ra0_215);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationmsourcesssncount',ra0_216);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationmsourcesssnunrelcount',ra0_217);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationdobcount',ra0_218);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationdobcountnew',ra0_219);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchunverifiedssncountyear',ra0_220);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'searchunverifiedaddrcountyear',ra0_221);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchunverifieddobcountyear',ra0_222);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchunverifiedphonecountyear',ra0_223);	
					RiskView_Attributes_Reports.Range_Function_0(DS1,'assocsuspicousidentitiescount',ra0_224);	
					RiskView_Attributes_Reports.Range_Function_0(DS1,'assoccreditbureauonlycount',ra0_225);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'assoccreditbureauonlycountnew',ra0_226);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'assoccreditbureauonlycountmonth',ra0_227);		
					RiskView_Attributes_Reports.Range_Function_0(DS1,'assochighrisktopologycount',ra0_228);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divssnidentitymsourcecount',ra0_229);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divssnidentitymsourceurelcount',ra0_230);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divssnlnamecountnew',ra0_231);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divssnaddrmsourcecount',ra0_232);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddridentitycount',ra0_233);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddridentitycountnew',ra0_234);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddridentitymsourcecount',ra0_235);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddrsuspidentitycountnew',ra0_236);	
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddrssncount',ra0_237);	
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddrssncountnew',ra0_238);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddrssnmsourcecount',ra0_239);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchssnsearchcount',ra0_240);		
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchaddrsearchcount',ra0_241);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchphonesearchcount',ra0_242);

						
								ra_0:= ra0_1  + ra0_2  + ra0_3  + ra0_4  + ra0_5  + ra0_6  + ra0_7  + ra0_8  + ra0_9  + ra0_10 +
				                 ra0_13  +  ra0_16 + ra0_17 + ra0_18 + ra0_19 + ra0_20 +
						           ra0_21 + ra0_22 + ra0_23 + ra0_24 + ra0_25 + ra0_27 + ra0_28 + ra0_29 + ra0_30 +
				               ra0_31 + ra0_32 + ra0_33  + ra0_37 + ra0_38 + ra0_39 + ra0_40 +
				               ra0_41 +  ra0_43 + ra0_44 + ra0_45 + ra0_46 + ra0_47 + ra0_48 + ra0_49 + ra0_50 +
                        ra0_52 + ra0_53 + ra0_54 + ra0_55 + ra0_56 + ra0_57  + ra0_59 + ra0_60 +
                       ra0_61 + ra0_62 + ra0_63 + ra0_64 + ra0_65  + ra0_67 + ra0_68 + ra0_69 + ra0_70 + 
                       ra0_71 + ra0_72 + ra0_73  + ra0_75  + ra0_84 + ra0_86 + ra0_87 + ra0_88 + ra0_89 + ra0_90 + 
					              ra0_92 + ra0_93 + ra0_94 + ra0_95 + ra0_96 + ra0_97 + ra0_98 + ra0_100 + 
				               ra0_101 + ra0_102 + ra0_103 + ra0_104 + ra0_105 + ra0_106 + ra0_107  + ra0_109 + ra0_110 + 
											 ra0_111 + ra0_112 + ra0_113 + ra0_114 + ra0_115  + ra0_117 + ra0_118 + ra0_119 + ra0_120 +
											 ra0_121 + ra0_122 + ra0_123  + ra0_125 + ra0_126 + ra0_127 + ra0_128 + ra0_129 + ra0_130 +
				               ra0_131  + ra0_133 + ra0_134 + ra0_135 + ra0_136 + ra0_137 + ra0_138 + ra0_139  +
				               ra0_141 + ra0_142 + ra0_143 + ra0_144 + ra0_145 + ra0_146 + ra0_147  + ra0_149  +
                        ra0_174 + ra0_175 + ra0_176 + ra0_177 + ra0_178 + ra0_179  + 
                       ra0_182 + ra0_183 + ra0_184 + ra0_185 + ra0_186 + ra0_187 + ra0_188 + ra0_189 + ra0_190 +
                       ra0_191 + ra0_192 + ra0_193 + ra0_194 + ra0_195 + ra0_196 + ra0_197 + ra0_198 + ra0_199 + ra0_200 +
                       ra0_201 + ra0_202 + ra0_203 + ra0_204 + ra0_205 + ra0_206 + ra0_207 + ra0_208 + ra0_209 + ra0_210 + 
                    ra0_211 + ra0_212 + ra0_213 + ra0_214 + ra0_215 + ra0_216 + ra0_217 + ra0_218 + ra0_219 + ra0_220 + 
										ra0_221 + ra0_222 + ra0_223 + ra0_224 + ra0_225 + ra0_226 + ra0_227 + ra0_228 + ra0_229 + ra0_230 + 
										ra0_231 + ra0_232 + ra0_233 + ra0_234 + ra0_235 + ra0_236 + ra0_237 + ra0_238 + ra0_239 + ra0_240 + 
										ra0_241 + ra0_242;
								
								RiskView_Attributes_Reports.Range_Function_1(DS1,'inputaddrcountyindex',ra1_1);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'inputaddrtractindex',ra1_2);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'inputaddrblockindex',ra1_3);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'curraddrcountyindex',ra1_4);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'curraddrtractindex',ra1_5);
							  RiskView_Attributes_Reports.Range_Function_1(DS1,'curraddrblockindex',ra1_6);
							  RiskView_Attributes_Reports.Range_Function_1(DS1,'prevaddrcountyindex',ra1_7);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'prevaddrtractindex',ra1_8);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'prevaddrblockindex',ra1_9);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'propnewestsalepurchaseindex',ra1_10);
								
								RiskView_Attributes_Reports.Range_Function_1(DS1,'inputaddrmobilityindex',ra1_11);
											
						
											 
											 ra_1:=ra1_1  + ra1_2  + ra1_3  + ra1_4  + ra1_5  + ra1_6  + ra1_7  + ra1_8  + ra1_9  + ra1_10 + ra1_11;
				
								 RiskView_Attributes_Reports.Range_Function_2(DS1,'srcsconfirmidaddrcount',ra2_1);
								
							      	 ra_2:=ra2_1;
								 
								
								 
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'inputaddrmurderindex',ra5_1);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'inputaddrcartheftindex',ra5_2);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'inputaddrburglaryindex',ra5_3);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'inputaddrcrimeindex',ra5_4);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'curraddrmurderindex',ra5_5);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'curraddrcartheftindex',ra5_6);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'curraddrburglaryindex',ra5_7);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'curraddrcrimeindex',ra5_8);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'prevaddrmurderindex',ra5_9);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'prevaddrcartheftindex',ra5_10);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'prevaddrburglaryindex',ra5_11);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'prevaddrcrimeindex',ra5_12);
									
									
										 ra_5:=ra5_1  + ra5_2  + ra5_3  + ra5_4  + ra5_5  + ra5_6  + ra5_7  + ra5_8  + ra5_9  + ra5_10 +
				                   ra5_11 + ra5_12;
										 
										  // RiskView_Attributes_Reports.Range_Function_6(DS1,'inputcurraddrcrimediff',ra6_1);
								      // RiskView_Attributes_Reports.Range_Function_6(DS1,'currprevaddrcrimediff',ra6_2);
								 
								 	 // ra_6:=ra6_1+ ra6_2;
									 
									 RiskView_Attributes_Reports.Range_Function_7(DS1,'derogcount',ra7_1);
								  RiskView_Attributes_Reports.Range_Function_7(DS1,'derogrecentcount',ra7_2);
									
								 
								 ra_7:=ra7_1 + ra7_2;
				
					RiskView_Attributes_Reports.Distinct_function(DS1,'recentupdate',di1);
					RiskView_Attributes_Reports.Distinct_function(DS1,'creditbureaurecord',di2);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verificationfailure',di3);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'invalidssn',di4);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'invalidaddr',di5);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'invalidphone',di6);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'verificationfailure',di7);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnnotfound',di8);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnfoundother',di9);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedname',di10);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedssn',di11);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedphone',di12);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedphonefullname',di13);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedphonelastname',di14);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedaddress',di15);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifieddob',di16);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ageriskindicator',di17);
					RiskView_Attributes_Reports.Distinct_function(DS1,'phoneother',di18);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnrecent',di19);
				  // RiskView_Attributes_Reports.Distinct_function(DS1,'ssnlowissuedate',di20);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'ssnhighissuedate',di21);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnissuestate',di22);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnnonus',di23);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'ssnissuedpriordob',di24);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssn3years',di25);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnafter5',di26);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnproblems',di27);
					RiskView_Attributes_Reports.Distinct_function(DS1,'relativesdistanceclosest',di28);
			    RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrdwelltype',di29);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrlandusecode',di30);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrapplicantowned',di31);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrfamilyowned',di32);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddroccupantowned',di33);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrnotprimaryres',di34);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddractivephonelist',di35);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrtaxyr',di36);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrtaxyr',di37);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrdwelltype',di38);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrlandusecode',di39);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrapplicantowned',di40);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrfamilyowned',di41);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddroccupantowned',di42);
	        RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrdwelltype',di43);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrlandusecode',di44);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrapplicantowned',di45);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrfamilyowned',di46);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddroccupantowned',di47);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrtaxyr',di48);
			  	// RiskView_Attributes_Reports.Distinct_function(DS1,'inputcurraddrmatch',di49);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'inputcurraddrstatediff',di50);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'inputcurrecontrajectory',di51);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'inputprevaddrmatch',di52);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'currprevaddrstatediff',di53);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'prevcurrecontrajectory',di54);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'educationattendedcollege',di55);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationprogram2yr',di56);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationprogram4yr',di57);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationprogramgraduate',di58);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationinstitutionprivate',di59);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'educationinstitutionrating',di60);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationfieldofstudytype',di61);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrstability',di62);
					RiskView_Attributes_Reports.Distinct_function(DS1,'statusmostrecent',di63);
					RiskView_Attributes_Reports.Distinct_function(DS1,'statusprevious',di64);
					RiskView_Attributes_Reports.Distinct_function(DS1,'statusnextprevious',di65);
					RiskView_Attributes_Reports.Distinct_function(DS1,'wealthindex',di66);
					RiskView_Attributes_Reports.Distinct_function(DS1,'derogseverityindex',di67);
					RiskView_Attributes_Reports.Distinct_function(DS1,'bankruptcytype',di68);
					RiskView_Attributes_Reports.Distinct_function(DS1,'bankruptcystatus',di69);
          RiskView_Attributes_Reports.Distinct_function(DS1,'proflictypecategory',di70);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'proflicexpiredate',di71);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'inputphonestatus',di72);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'inputphonepager',di73);	
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputphonemobile',di74);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputphonetype',di75);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputphoneservicetype',di76);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputareacodechange',di77);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'invalidphonezip',di78);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'ssndatedeceased',di79);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrsiccode',di80);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrvalidation',di81);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrerrorcode',di82);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrhighrisk',di83);	
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputphonehighrisk',di84);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrprison',di85);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrprison',di86);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrprison',di87);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'historicaladdrprison',di88);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'inputzippobox',di89);
				  // RiskView_Attributes_Reports.Distinct_function(DS1,'inputzipcorpmil',di90);
					RiskView_Attributes_Reports.Distinct_function(DS1,'donotmail',di91);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'ssnissued',di92);
					
					RiskView_Attributes_Reports.Distinct_function(DS1,'historydate',di93);
					RiskView_Attributes_Reports.Distinct_function(DS1,'fnamepop',di94);
					RiskView_Attributes_Reports.Distinct_function(DS1,'lnamepop',di95);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'addrpop',di96);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnlength',di97);
					RiskView_Attributes_Reports.Distinct_function(DS1,'dobpop',di98);
					RiskView_Attributes_Reports.Distinct_function(DS1,'emailpop',di99);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ipaddrpop',di100);
					RiskView_Attributes_Reports.Distinct_function(DS1,'hphnpop',di101);
					
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrhistoricalmatch',di102);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrmostrecentstatediff',di103);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrrecentecontrajectory',di104);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrrecentecontrajectoryindex',di105);
					RiskView_Attributes_Reports.Distinct_function(DS1,'assetowner',di106);
					RiskView_Attributes_Reports.Distinct_function(DS1,'propertyowner',di107);
					RiskView_Attributes_Reports.Distinct_function(DS1,'propnewestsaleprice',di108);
					RiskView_Attributes_Reports.Distinct_function(DS1,'businessactiveassociation',di109);
					RiskView_Attributes_Reports.Distinct_function(DS1,'businessinactiveassociation',di110);
					RiskView_Attributes_Reports.Distinct_function(DS1,'businesstitle',di111);
					RiskView_Attributes_Reports.Distinct_function(DS1,'recentactivityindex',di112);
					RiskView_Attributes_Reports.Distinct_function(DS1,'voterregistrationrecord',di113);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrdelivery',di114);
					
					RiskView_Attributes_Reports.Distinct_function(DS1,'aircraftowner',di115);
					RiskView_Attributes_Reports.Distinct_function(DS1,'proflicexpired',di116);
					RiskView_Attributes_Reports.Distinct_function(DS1,'onlinedirectory',di117);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputphoneproblems',di118);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrcorrectional',di119);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrcorrectional',di120);
					RiskView_Attributes_Reports.Distinct_function(DS1,'historicaladdrcorrectional',di121);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrproblems',di122);
					RiskView_Attributes_Reports.Distinct_function(DS1,'identityrisklevel',di123);
					RiskView_Attributes_Reports.Distinct_function(DS1,'idverrisklevel',di124);
					RiskView_Attributes_Reports.Distinct_function(DS1,'idverssncreditbureaucount',di125);
					RiskView_Attributes_Reports.Distinct_function(DS1,'idverssncreditbureaudelete',di126);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourcerisklevel',di127);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourcewatchlist',di128);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourceorderactivity',di129);
					RiskView_Attributes_Reports.Distinct_function(DS1,'variationrisklevel',di130);
					RiskView_Attributes_Reports.Distinct_function(DS1,'searchvelocityrisklevel',di131);
					RiskView_Attributes_Reports.Distinct_function(DS1,'assocrisklevel',di132);
					RiskView_Attributes_Reports.Distinct_function(DS1,'validationrisklevel',di133);
					RiskView_Attributes_Reports.Distinct_function(DS1,'correlationrisklevel',di134);
					RiskView_Attributes_Reports.Distinct_function(DS1,'divrisklevel',di135);
					RiskView_Attributes_Reports.Distinct_function(DS1,'searchcomponentrisklevel',di136);
					RiskView_Attributes_Reports.Distinct_function(DS1,'componentcharrisklevel',di137);
					
					
					di:= di1  + di2  + di3        + di8  + di9  + di10 +
				       di11 + di12  + di15 + di16 + di17 + di18 + di19 + 
						    di22 + di23  + di25 + di26 + di27 + di28 + di29  +
				       di31 + di32 + di33 + di34 + di35 + di36 + di37 + di38 + di40 +
				       di41 + di42 + di43  + di45 + di46 + di47 + di48 
						   + di55 + di56 + di57 + di58 + di59 + di60 +
               di61 + di62 + di63 + di64 + di65 + di66 + di67 + di68 + di69 + di70 + 
                 di74 + di75 + di76 + di77 + di80 + 
               di81 + di82 + di83 + di84  + 
					     di91  + di93 + di94 + di95 + di96 + di97 + di98 + di99 + di100 + 
				       di101  + di102 + di103 + di104 + di105 + di106 + di107 + di108 + di109 + di110 + 
							 di111 + di112 + di113 + di114 + di115+ di116 + di117 + di118 + di119 + di120 + 
										di121 + di122 + di123 + di124 + di125 + di126 + di127 + di128 + di129 + di130 + 
										di131 + di132 + di133 + di134 + di135 + di136 + di137;
				
				
						
				
				
					result1_stats:= ra + di + ra_0 + ra_1 + ra_2 + ra_5  + ra_7 ;
					
		      	// result1_stats;
				///////////////////////////////////////////////////////////////////////////////
				///////////////////////////////////////////////////////////////////////////////
				//////////////////////////////////////////////////////////////////////////////
				

      	
      	RiskView_Attributes_Reports.Range_func(DS2,'ageoldestrecord',ran1);
      	RiskView_Attributes_Reports.Range_func(DS2,'agenewestrecord',ran2);
				RiskView_Attributes_Reports.Range_func(DS2,'lastnamechangeage',ran3);
				// RiskView_Attributes_Reports.Range_func(DS2,'ssndeceased',ran4);
      	// RiskView_Attributes_Reports.Range_func(DS2,'ssndatedeceased',ran5);
				// RiskView_Attributes_Reports.Range_func(DS2,'ssnissued',ran6);
		   	RiskView_Attributes_Reports.Range_func(DS2,'inputaddrageoldestrecord',ran7);
      	RiskView_Attributes_Reports.Range_func(DS2,'inputaddragenewestrecord',ran8);
				RiskView_Attributes_Reports.Range_func(DS2,'inputaddrlenofres',ran9);
				RiskView_Attributes_Reports.Range_func(DS2,'inputaddragelastsale',ran10);
			 	RiskView_Attributes_Reports.Range_func(DS2,'curraddrageoldestrecord',ran11);
				RiskView_Attributes_Reports.Range_func(DS2,'curraddragenewestrecord',ran12);
				RiskView_Attributes_Reports.Range_func(DS2,'curraddrlenofres',ran13);
			 	RiskView_Attributes_Reports.Range_func(DS2,'curraddragelastsale',ran14);
			 	RiskView_Attributes_Reports.Range_func(DS2,'prevaddrageoldestrecord',ran15);
				RiskView_Attributes_Reports.Range_func(DS2,'prevaddragenewestrecord',ran16);
				RiskView_Attributes_Reports.Range_func(DS2,'prevaddrlenofres',ran17);
			 	RiskView_Attributes_Reports.Range_func(DS2,'propageoldestpurchase',ran18);
				RiskView_Attributes_Reports.Range_func(DS2,'propagenewestpurchase',ran19);
				RiskView_Attributes_Reports.Range_func(DS2,'derogage',ran20);
				RiskView_Attributes_Reports.Range_func(DS2,'felonyage',ran21);
		   	RiskView_Attributes_Reports.Range_func(DS2,'arrestage',ran22);
				RiskView_Attributes_Reports.Range_func(DS2,'lienfiledage',ran23);
				RiskView_Attributes_Reports.Range_func(DS2,'lienreleasedage',ran24);
				RiskView_Attributes_Reports.Range_func(DS2,'bankruptcyage',ran25);
				RiskView_Attributes_Reports.Range_func(DS2,'evictionage',ran26);
			 	RiskView_Attributes_Reports.Range_func(DS2,'proflicage',ran27);
		   	RiskView_Attributes_Reports.Range_func(DS2,'phoneedaageoldestrecord',ran28);
				RiskView_Attributes_Reports.Range_func(DS2,'phoneedaagenewestrecord',ran29);
      	RiskView_Attributes_Reports.Range_func(DS2,'phoneotherageoldestrecord',ran30);
			 	RiskView_Attributes_Reports.Range_func(DS2,'phoneotheragenewestrecord',ran31);
				RiskView_Attributes_Reports.Range_func(DS2,'addrmostrecentstatediff',ran32);
				RiskView_Attributes_Reports.Range_func(DS2,'businessassociationage',ran33);
				RiskView_Attributes_Reports.Range_func(DS2,'accidentage',ran34);
      	
      	
      	ran:= ran1  + ran2  + ran3       + ran7  + ran8  + ran9  + ran10 +
				     ran11 + ran12 + ran13 + ran14 + ran15 + ran16 + ran17 + ran18 + ran19 + ran20 +
						 ran21 + ran22 + ran23 + ran24 + ran25 + ran26 + ran27 + ran28 + ran29 + ran30 + 
						 ran31 + ran32 + ran33 + ran34;
      	
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'subjectssncount',ran0_1);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subjectaddrcount',ran0_2);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subjectphonecount',ran0_3);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subjectssnrecentcount',ran0_4);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subjectaddrrecentcount',ran0_5);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subjectphonerecentcount',ran0_6);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'ssnidentitiescount',ran0_7);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'ssnaddrcount',ran0_8);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'ssnidentitiesrecentcount',ran0_9);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'ssnaddrrecentcount',ran0_10);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddridentitiescount',ran0_11);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrssncount',ran0_12);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrphonecount',ran0_13);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddridentitiesrecentcount',ran0_14);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrssnrecentcount',ran0_15);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrphonerecentcount',ran0_16);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'phoneidentitiescount',ran0_17);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'phoneidentitiesrecentcount',ran0_18);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'ssnlastnamecount',ran0_19);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subjectlastnamecount',ran0_20);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lastnamechangecount01',ran0_21);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'lastnamechangecount03',ran0_22);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lastnamechangecount06',ran0_23);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lastnamechangecount12',ran0_24);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lastnamechangecount24',ran0_25);
				  // RiskView_Attributes_Reports.Range_Function_0(DS2,'lastnamechangecount36',ran0_26);
		  		RiskView_Attributes_Reports.Range_Function_0(DS2,'lastnamechangecount60',ran0_27);
			  	RiskView_Attributes_Reports.Range_Function_0(DS2,'sfduaddridentitiescount',ran0_28);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'sfduaddrssncount',ran0_29);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'relativescount',ran0_30);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'relativesbankruptcycount',ran0_31);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'relativesfelonycount',ran0_32);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'relativespropownedcount',ran0_33);
			 	  // RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddravmconfidence',ran0_34);
				  // RiskView_Attributes_Reports.Range_Function_0(DS2,'curraddravmconfidence',ran0_35);
				  // RiskView_Attributes_Reports.Range_Function_0(DS2,'prevaddravmconfidence',ran0_36);
		   	  RiskView_Attributes_Reports.Range_Function_0(DS2,'addrchangecount01',ran0_37);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'addrchangecount03',ran0_38);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'addrchangecount06',ran0_39);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'addrchangecount12',ran0_40);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'addrchangecount24',ran0_41);
      	  // RiskView_Attributes_Reports.Range_Function_0(DS2,'addrchangecount36',ran0_42);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'addrchangecount60',ran0_43);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propownedcount',ran0_44);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propownedhistoricalcount',ran0_45);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'proppurchasedcount01',ran0_46);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'proppurchasedcount03',ran0_47);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'proppurchasedcount06',ran0_48);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'proppurchasedcount12',ran0_49);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'proppurchasedcount24',ran0_50);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'proppurchasedcount36',ran0_51);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'proppurchasedcount60',ran0_52);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propsoldcount01',ran0_53);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propsoldcount03',ran0_54);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propsoldcount06',ran0_55);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propsoldcount12',ran0_56);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propsoldcount24',ran0_57);
				  // RiskView_Attributes_Reports.Range_Function_0(DS2,'propsoldcount36',ran0_58);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propsoldcount60',ran0_59);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount',ran0_60);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount01',ran0_61);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount03',ran0_62);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount06',ran0_63);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount12',ran0_64);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount24',ran0_65);
				  // RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount36',ran0_66);
		  		RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount60',ran0_67);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount',ran0_68);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount01',ran0_69);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount03',ran0_70);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount06',ran0_71);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount12',ran0_72);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount24',ran0_73);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount36',ran0_74);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount60',ran0_75);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount',ran0_76);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount01',ran0_77);
				  // RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount03',ran0_78);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount06',ran0_79);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount12',ran0_80);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount24',ran0_81);
				  // RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount36',ran0_82);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount60',ran0_83);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount',ran0_84);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'derogcount',ran0_85);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount01',ran0_86);
		  		RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount03',ran0_87);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount06',ran0_88);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount12',ran0_89);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount24',ran0_90);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount36',ran0_91);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount60',ran0_92);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'arrestcount',ran0_93);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'arrestcount01',ran0_94);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'arrestcount03',ran0_95);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'arrestcount06',ran0_96);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'arrestcount12',ran0_97);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'arrestcount24',ran0_98);
			    // RiskView_Attributes_Reports.Range_Function_0(DS2,'arrestcount36',ran0_99);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'arrestcount60',ran0_100);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'liencount',ran0_101);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount',ran0_102);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount01',ran0_103);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount03',ran0_104);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount06',ran0_105);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount12',ran0_106);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount24',ran0_107);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount36',ran0_108);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount60',ran0_109);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount',ran0_110);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount01',ran0_111);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount03',ran0_112);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount06',ran0_113);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount12',ran0_114);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount24',ran0_115);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount36',ran0_116);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount60',ran0_117);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount',ran0_118);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount01',ran0_119);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount03',ran0_120);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount06',ran0_121);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount12',ran0_122);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount24',ran0_123);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount36',ran0_124);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount60',ran0_125);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount',ran0_126);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount01',ran0_127);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount03',ran0_128);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount06',ran0_129);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount12',ran0_130);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount24',ran0_131);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount36',ran0_132);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount60',ran0_133);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount',ran0_134);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount01',ran0_135);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount03',ran0_136);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount06',ran0_137);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount12',ran0_138);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount24',ran0_139);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount36',ran0_140);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount60',ran0_141);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount',ran0_142);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount01',ran0_143);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount03',ran0_144);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount06',ran0_145);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount12',ran0_146);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount24',ran0_147);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount36',ran0_148);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount60',ran0_149);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount60',ran0_150);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'proflicexpirecount01',ran0_151);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'proflicexpirecount03',ran0_152);
				  // RiskView_Attributes_Reports.Range_Function_0(DS2,'proflicexpirecount06',ran0_153);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'proflicexpirecount12',ran0_154);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'proflicexpirecount24',ran0_155);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'proflicexpirecount36',ran0_156);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'proflicexpirecount60',ran0_157);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchcollectioncount',ran0_158);
			    // RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchcollectioncount01',ran0_159);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchcollectioncount03',ran0_160);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchcollectioncount06',ran0_161);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchcollectioncount12',ran0_162);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchcollectioncount24',ran0_163);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchcollectioncount36',ran0_164);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchcollectioncount60',ran0_165);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchidvfraudcount',ran0_166);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchidvfraudcount01',ran0_167);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchidvfraudcount03',ran0_168);
			    // RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchidvfraudcount06',ran0_169);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchidvfraudcount12',ran0_170);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchidvfraudcount24',ran0_171);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchidvfraudcount36',ran0_172);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchidvfraudcount60',ran0_173);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchothercount',ran0_174);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchothercount01',ran0_175);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchothercount03',ran0_176);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchothercount06',ran0_177);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchothercount12',ran0_178);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchothercount24',ran0_179);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchothercount36',ran0_180);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchothercount60',ran0_181);		
					
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchlocatecount',ran0_182);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchlocatecount01',ran0_183);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchlocatecount03',ran0_184);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchlocatecount06',ran0_185);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchlocatecount12',ran0_186);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchlocatecount24',ran0_187);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchpersonalfinancecount',ran0_188);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchpersonalfinancecount01',ran0_189);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchpersonalfinancecount03',ran0_190);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchpersonalfinancecount06',ran0_191);		
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchpersonalfinancecount12',ran0_192);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchpersonalfinancecount24',ran0_193);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchidentityssns',ran0_194);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchidentityaddrs',ran0_195);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchidentityphones',ran0_196);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchssnidentities',ran0_197);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchaddridentities',ran0_198);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'prsearchphoneidentities',ran0_199);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount',ran0_200);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount01',ran0_201);		
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount03',ran0_202);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount06',ran0_203);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount12',ran0_204);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount24',ran0_205);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount60',ran0_206);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrvacantpropcount',ran0_207);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrbusinesscount',ran0_208);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrsinglefamilycount',ran0_209);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrmultifamilycount',ran0_210);	
					RiskView_Attributes_Reports.Range_Function_0(DS2,'businessinputaddrcount',ran0_211);	
					RiskView_Attributes_Reports.Range_Function_0(DS2,'accidentcount',ran0_212);	
					
					RiskView_Attributes_Reports.Range_Function_0(DS2,'sourceordersourcecount',ran0_213);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'sourceorderagelastorder',ran0_214);		
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationidentitycount',ran0_215);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationmsourcesssncount',ran0_216);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationmsourcesssnunrelcount',ran0_217);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationdobcount',ran0_218);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationdobcountnew',ran0_219);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchunverifiedssncountyear',ran0_220);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'searchunverifiedaddrcountyear',ran0_221);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchunverifieddobcountyear',ran0_222);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchunverifiedphonecountyear',ran0_223);	
					RiskView_Attributes_Reports.Range_Function_0(DS2,'assocsuspicousidentitiescount',ran0_224);	
					RiskView_Attributes_Reports.Range_Function_0(DS2,'assoccreditbureauonlycount',ran0_225);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'assoccreditbureauonlycountnew',ran0_226);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'assoccreditbureauonlycountmonth',ran0_227);		
					RiskView_Attributes_Reports.Range_Function_0(DS2,'assochighrisktopologycount',ran0_228);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divssnidentitymsourcecount',ran0_229);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divssnidentitymsourceurelcount',ran0_230);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divssnlnamecountnew',ran0_231);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divssnaddrmsourcecount',ran0_232);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddridentitycount',ran0_233);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddridentitycountnew',ran0_234);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddridentitymsourcecount',ran0_235);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddrsuspidentitycountnew',ran0_236);	
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddrssncount',ran0_237);	
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddrssncountnew',ran0_238);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddrssnmsourcecount',ran0_239);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchssnsearchcount',ran0_240);		
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchaddrsearchcount',ran0_241);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchphonesearchcount',ran0_242);
						
						
					 
								ran_0:= ran0_1  + ran0_2  + ran0_3  + ran0_4  + ran0_5  + ran0_6  + ran0_7  + ran0_8  + ran0_9  + ran0_10 +
				                 ran0_13  +  ran0_16 + ran0_17 + ran0_18 + ran0_19 + ran0_20 +
						           ran0_21 + ran0_22 + ran0_23 + ran0_24 + ran0_25 + ran0_27 + ran0_28 + ran0_29 + ran0_30 +
				               ran0_31 + ran0_32 + ran0_33  + ran0_37 + ran0_38 + ran0_39 + ran0_40 +
				               ran0_41 +  ran0_43 + ran0_44 + ran0_45 + ran0_46 + ran0_47 + ran0_48 + ran0_49 + ran0_50 +
                        ran0_52 + ran0_53 + ran0_54 + ran0_55 + ran0_56 + ran0_57  + ran0_59 + ran0_60 +
                       ran0_61 + ran0_62 + ran0_63 + ran0_64 + ran0_65  + ran0_67 + ran0_68 + ran0_69 + ran0_70 + 
                       ran0_71 + ran0_72 + ran0_73  + ran0_75  + ran0_84 + ran0_86 + ran0_87 + ran0_88 + ran0_89 + ran0_90 + 
					              ran0_92 + ran0_93 + ran0_94 + ran0_95 + ran0_96 + ran0_97 + ran0_98 + ran0_100 + 
				               ran0_101 + ran0_102 + ran0_103 + ran0_104 + ran0_105 + ran0_106 + ran0_107 + ran0_109 + ran0_110 + 
											 ran0_111 + ran0_112 + ran0_113 + ran0_114 + ran0_115  + ran0_117 + ran0_118 + ran0_119 + ran0_120 +
											 ran0_121 + ran0_122 + ran0_123  + ran0_125 + ran0_126 + ran0_127 + ran0_128 + ran0_129 + ran0_130 +
				               ran0_131  + ran0_133 + ran0_134 + ran0_135 + ran0_136 + ran0_137 + ran0_138 + ran0_139 +
				               ran0_141 + ran0_142 + ran0_143 + ran0_144 + ran0_145 + ran0_146 + ran0_147 + ran0_149 + 
                        ran0_174 + ran0_175 + ran0_176 + ran0_177 + ran0_178 + ran0_179  + 
                       ran0_182 + ran0_183 + ran0_184 + ran0_185 + ran0_186 + ran0_187 + ran0_188 + ran0_189 + ran0_190 +
                       ran0_191 + ran0_192 + ran0_193 + ran0_194 + ran0_195 + ran0_196 + ran0_197 + ran0_198 + ran0_199 + ran0_200 +
                       ran0_201 + ran0_202 + ran0_203 + ran0_204 + ran0_205 + ran0_206 + ran0_207 + ran0_208 + ran0_209 + ran0_210 + 
                       ran0_211 + ran0_212 + ran0_213 + ran0_214 + ran0_215 + ran0_216 + ran0_217 + ran0_218 + ran0_219 + ran0_220 + 
										ran0_221 + ran0_222 + ran0_223 + ran0_224 + ran0_225 + ran0_226 + ran0_227 + ran0_228 + ran0_229 + ran0_230 + 
										ran0_231 + ran0_232 + ran0_233 + ran0_234 + ran0_235 + ran0_236 + ran0_237 + ran0_238 + ran0_239 + ran0_240 + 
										ran0_241 + ran0_242;
								 
			
									RiskView_Attributes_Reports.Range_Function_1(DS2,'inputaddrcountyindex',ran1_1);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'inputaddrtractindex',ran1_2);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'inputaddrblockindex',ran1_3);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'curraddrcountyindex',ran1_4);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'curraddrtractindex',ran1_5);
							  RiskView_Attributes_Reports.Range_Function_1(DS2,'curraddrblockindex',ran1_6);
							  RiskView_Attributes_Reports.Range_Function_1(DS2,'prevaddrcountyindex',ran1_7);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'prevaddrtractindex',ran1_8);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'prevaddrblockindex',ran1_9);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'propnewestsalepurchaseindex',ran1_10);
								
								RiskView_Attributes_Reports.Range_Function_1(DS2,'inputaddrmobilityindex',ran1_11);
											
						
											 
											
											 
											 ran_1:=ran1_1  + ran1_2  + ran1_3  + ran1_4  + ran1_5  + ran1_6  + ran1_7  + ran1_8  + ran1_9  + ran1_10 + ran1_11;
				
								 RiskView_Attributes_Reports.Range_Function_2(DS2,'srcsconfirmidaddrcount',ran2_1);
								
							      	
											 
											 					 ran_2:=ran2_1;
								 
								
								 
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'inputaddrmurderindex',ran5_1);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'inputaddrcartheftindex',ran5_2);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'inputaddrburglaryindex',ran5_3);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'inputaddrcrimeindex',ran5_4);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'curraddrmurderindex',ran5_5);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'curraddrcartheftindex',ran5_6);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'curraddrburglaryindex',ran5_7);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'curraddrcrimeindex',ran5_8);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'prevaddrmurderindex',ran5_9);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'prevaddrcartheftindex',ran5_10);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'prevaddrburglaryindex',ran5_11);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'prevaddrcrimeindex',ran5_12);
									
									
										 ran_5:=ran5_1  + ran5_2  + ran5_3  + ran5_4  + ran5_5  + ran5_6  + ran5_7  + ran5_8  + ran5_9  + ran5_10 +
				                   ran5_11 + ran5_12;
													 
										 		  
													
										  // RiskView_Attributes_Reports.Range_Function_6(DS2,'inputcurraddrcrimediff',ran6_1);
								      // RiskView_Attributes_Reports.Range_Function_6(DS2,'currprevaddrcrimediff',ran6_2);
								 
								 	 // ran_6:=ran6_1+ ran6_2;
									 
							RiskView_Attributes_Reports.Range_Function_7(DS2,'derogcount',ran7_1);
						 RiskView_Attributes_Reports.Range_Function_7(DS2,'derogrecentcount',ran7_2);
									
								 
								 ran_7:=ran7_1 + ran7_2; 
										  				
					RiskView_Attributes_Reports.Distinct_function(DS2,'recentupdate',dis1);
					RiskView_Attributes_Reports.Distinct_function(DS2,'creditbureaurecord',dis2);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verificationfailure',dis3);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'invalidssn',dis4);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'invalidaddr',dis5);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'invalidphone',dis6);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'verificationfailure',dis7);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnnotfound',dis8);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnfoundother',dis9);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedname',dis10);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedssn',dis11);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedphone',dis12);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedphonefullname',dis13);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedphonelastname',dis14);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedaddress',dis15);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifieddob',dis16);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ageriskindicator',dis17);
					RiskView_Attributes_Reports.Distinct_function(DS2,'phoneother',dis18);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnrecent',dis19);
				  // RiskView_Attributes_Reports.Distinct_function(DS2,'ssnlowissuedate',dis20);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'ssnhighissuedate',dis21);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnissuestate',dis22);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnnonus',dis23);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'ssnissuedpriordob',dis24);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssn3years',dis25);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnafter5',dis26);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnproblems',dis27);
					RiskView_Attributes_Reports.Distinct_function(DS2,'relativesdistanceclosest',dis28);
			    RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrdwelltype',dis29);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrlandusecode',dis30);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrapplicantowned',dis31);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrfamilyowned',dis32);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddroccupantowned',dis33);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrnotprimaryres',dis34);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddractivephonelist',dis35);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrtaxyr',dis36);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrtaxyr',dis37);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrdwelltype',dis38);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrlandusecode',dis39);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrapplicantowned',dis40);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrfamilyowned',dis41);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddroccupantowned',dis42);
	        RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrdwelltype',dis43);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrlandusecode',dis44);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrapplicantowned',dis45);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrfamilyowned',dis46);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddroccupantowned',dis47);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrtaxyr',dis48);
			  	// RiskView_Attributes_Reports.Distinct_function(DS2,'inputcurraddrmatch',dis49);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'inputcurraddrstatediff',dis50);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'inputcurrecontrajectory',dis51);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'inputprevaddrmatch',dis52);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'currprevaddrstatediff',dis53);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'prevcurrecontrajectory',dis54);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'educationattendedcollege',dis55);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationprogram2yr',dis56);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationprogram4yr',dis57);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationprogramgraduate',dis58);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationinstitutionprivate',dis59);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'educationinstitutionrating',dis60);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationfieldofstudytype',dis61);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrstability',dis62);
					RiskView_Attributes_Reports.Distinct_function(DS2,'statusmostrecent',dis63);
					RiskView_Attributes_Reports.Distinct_function(DS2,'statusprevious',dis64);
					RiskView_Attributes_Reports.Distinct_function(DS2,'statusnextprevious',dis65);
					RiskView_Attributes_Reports.Distinct_function(DS2,'wealthindex',dis66);
					RiskView_Attributes_Reports.Distinct_function(DS2,'derogseverityindex',dis67);
					RiskView_Attributes_Reports.Distinct_function(DS2,'bankruptcytype',dis68);
					RiskView_Attributes_Reports.Distinct_function(DS2,'bankruptcystatus',dis69);
          RiskView_Attributes_Reports.Distinct_function(DS2,'proflictypecategory',dis70);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'proflicexpiredate',dis71);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'inputphonestatus',dis72);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'inputphonepager',dis73);	
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputphonemobile',dis74);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputphonetype',dis75);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputphoneservicetype',dis76);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputareacodechange',dis77);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'invalidphonezip',dis78);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'ssndatedeceased',dis79);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrsiccode',dis80);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrvalidation',dis81);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrerrorcode',dis82);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrhighrisk',dis83);	
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputphonehighrisk',dis84);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrprison',dis85);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrprison',dis86);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrprison',dis87);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'historicaladdrprison',dis88);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'inputzippobox',dis89);
				  // RiskView_Attributes_Reports.Distinct_function(DS2,'inputzipcorpmil',dis90);
					RiskView_Attributes_Reports.Distinct_function(DS2,'donotmail',dis91);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'ssnissued',dis92);
					
					RiskView_Attributes_Reports.Distinct_function(DS2,'historydate',dis93);
					RiskView_Attributes_Reports.Distinct_function(DS2,'fnamepop',dis94);
					RiskView_Attributes_Reports.Distinct_function(DS2,'lnamepop',dis95);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'addrpop',dis96);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnlength',dis97);
					RiskView_Attributes_Reports.Distinct_function(DS2,'dobpop',dis98);
					RiskView_Attributes_Reports.Distinct_function(DS2,'emailpop',dis99);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ipaddrpop',dis100);
					RiskView_Attributes_Reports.Distinct_function(DS2,'hphnpop',dis101);
					
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrhistoricalmatch',dis102);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrmostrecentstatediff',dis103);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrrecentecontrajectory',dis104);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrrecentecontrajectoryindex',dis105);
					RiskView_Attributes_Reports.Distinct_function(DS2,'assetowner',dis106);
					RiskView_Attributes_Reports.Distinct_function(DS2,'propertyowner',dis107);
					RiskView_Attributes_Reports.Distinct_function(DS2,'propnewestsaleprice',dis108);
					RiskView_Attributes_Reports.Distinct_function(DS2,'businessactiveassociation',dis109);
					RiskView_Attributes_Reports.Distinct_function(DS2,'businessinactiveassociation',dis110);
					RiskView_Attributes_Reports.Distinct_function(DS2,'businesstitle',dis111);
					RiskView_Attributes_Reports.Distinct_function(DS2,'recentactivityindex',dis112);
					RiskView_Attributes_Reports.Distinct_function(DS2,'voterregistrationrecord',dis113);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrdelivery',dis114);
					
				RiskView_Attributes_Reports.Distinct_function(DS2,'aircraftowner',dis115);
					RiskView_Attributes_Reports.Distinct_function(DS2,'proflicexpired',dis116);
					RiskView_Attributes_Reports.Distinct_function(DS2,'onlinedirectory',dis117);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputphoneproblems',dis118);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrcorrectional',dis119);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrcorrectional',dis120);
					RiskView_Attributes_Reports.Distinct_function(DS2,'historicaladdrcorrectional',dis121);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrproblems',dis122);
					RiskView_Attributes_Reports.Distinct_function(DS2,'identityrisklevel',dis123);
					RiskView_Attributes_Reports.Distinct_function(DS2,'idverrisklevel',dis124);
					RiskView_Attributes_Reports.Distinct_function(DS2,'idverssncreditbureaucount',dis125);
					RiskView_Attributes_Reports.Distinct_function(DS2,'idverssncreditbureaudelete',dis126);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourcerisklevel',dis127);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourcewatchlist',dis128);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourceorderactivity',dis129);
					RiskView_Attributes_Reports.Distinct_function(DS2,'variationrisklevel',dis130);
					RiskView_Attributes_Reports.Distinct_function(DS2,'searchvelocityrisklevel',dis131);
					RiskView_Attributes_Reports.Distinct_function(DS2,'assocrisklevel',dis132);
					RiskView_Attributes_Reports.Distinct_function(DS2,'validationrisklevel',dis133);
					RiskView_Attributes_Reports.Distinct_function(DS2,'correlationrisklevel',dis134);
					RiskView_Attributes_Reports.Distinct_function(DS2,'divrisklevel',dis135);
					RiskView_Attributes_Reports.Distinct_function(DS2,'searchcomponentrisklevel',dis136);
					RiskView_Attributes_Reports.Distinct_function(DS2,'componentcharrisklevel',dis137);
					
					
					dis:= dis1  + dis2  + dis3        + dis8  + dis9  + dis10 +
				       dis11 + dis12  + dis15 + dis16 + dis17 + dis18 + dis19 + 
						    dis22 + dis23  + dis25 + dis26 + dis27 + dis28 + dis29  +
				       dis31 + dis32 + dis33 + dis34 + dis35 + dis36 + dis37 + dis38 + dis40 +
				       dis41 + dis42 + dis43  + dis45 + dis46 + dis47 + dis48 
						   + dis55 + dis56 + dis57 + dis58 + dis59 + dis60 +
               dis61 + dis62 + dis63 + dis64 + dis65 + dis66 + dis67 + dis68 + dis69 + dis70 + 
                 dis74 + dis75 + dis76 + dis77 + dis80 + 
               dis81 + dis82 + dis83 + dis84  + 
					     dis91  + dis93 + dis94 + dis95 + dis96 + dis97 + dis98 + dis99 + dis100 + 
				       dis101  + dis102 + dis103 + dis104 + dis105 + dis106 + dis107 + dis108 + dis109 + dis110 + 
							 dis111 + dis112 + dis113 + dis114 + dis115+ dis116 + dis117 + dis118 + dis119 + dis120 + 
										dis121 + dis122 + dis123 + dis124 + dis125 + dis126 + dis127 + dis128 + dis129 + dis130 + 
										dis131 + dis132 + dis133 + dis134 + dis135 + dis136 + dis137;
					
					
				
						
				  	
				
				
								
      
			
			result2_stats:= ran + dis + ran_0 + ran_1 +ran_2 + ran_5  + ran_7 ;
   				
         	// result2_stats;
			/////////////////////////////////////////////////////////////////////////
			/////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////
					
				RiskView_Attributes_Reports.Average_func(DS1,'ageoldestrecord',av1);
      	RiskView_Attributes_Reports.Average_func(DS1,'agenewestrecord',av2);
				RiskView_Attributes_Reports.Average_func(DS1,'relativespropownedtaxtotal',av3);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddrlastsalesprice',av4);
		    RiskView_Attributes_Reports.Average_func(DS1,'inputaddrtaxvalue',av5);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddrtaxmarketvalue',av6);
      	// RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmtax',av7);
      	// RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmsalesprice',av8);
				// RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmhedonic',av9);
      	RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmvalue',av10);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddrmedianincome',av11);
      	RiskView_Attributes_Reports.Average_func(DS1,'inputaddrmedianvalue',av12);
		    RiskView_Attributes_Reports.Average_func(DS1,'curraddrlastsalesprice',av13);
		  	RiskView_Attributes_Reports.Average_func(DS1,'curraddrtaxvalue',av14);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddrtaxmarketvalue',av15);
				// RiskView_Attributes_Reports.Average_func(DS1,'curraddravmtax',av16);
      	// RiskView_Attributes_Reports.Average_func(DS1,'curraddravmsalesprice',av17);
      	// RiskView_Attributes_Reports.Average_func(DS1,'curraddravmhedonic',av18);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddravmvalue',av19);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddrmedianincome',av20);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddrmedianvalue',av21);
	    	RiskView_Attributes_Reports.Average_func(DS1,'prevaddragelastsale',av22);
      	RiskView_Attributes_Reports.Average_func(DS1,'prevaddrlastsalesprice',av23);
				// RiskView_Attributes_Reports.Average_func(DS1,'prevaddractivephonelist',av24);
      	RiskView_Attributes_Reports.Average_func(DS1,'prevaddrtaxvalue',av25);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddrtaxmarketvalue',av26);
      	// RiskView_Attributes_Reports.Average_func(DS1,'prevaddravmtax',av27);
      	// RiskView_Attributes_Reports.Average_func(DS1,'prevaddravmsalesprice',av28);
				// RiskView_Attributes_Reports.Average_func(DS1,'prevaddravmhedonic',av29);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddravmvalue',av30);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddrmedianincome',av31);
      	RiskView_Attributes_Reports.Average_func(DS1,'prevaddrmedianvalue',av32);
				// RiskView_Attributes_Reports.Average_func(DS1,'inputcurraddrdistance',av33);
			  // RiskView_Attributes_Reports.Average_func(DS1,'inputcurraddrtaxdiff',av34);
      	// RiskView_Attributes_Reports.Average_func(DS1,'inputcurraddrincomediff',av35);
				// RiskView_Attributes_Reports.Average_func(DS1,'inputcurraddrvaluediff',av36);
      	// RiskView_Attributes_Reports.Average_func(DS1,'predictedannualincome',av37);
				// RiskView_Attributes_Reports.Average_func(DS1,'currprevaddrdistance',av38);
				// RiskView_Attributes_Reports.Average_func(DS1,'currprevaddrtaxdiff',av39);
				// RiskView_Attributes_Reports.Average_func(DS1,'currprevaddrincomediff',av40);
				// RiskView_Attributes_Reports.Average_func(DS1,'currprevaddrvaluediff',av41);
      	// RiskView_Attributes_Reports.Average_func(DS1,'inputphoneaddrdist',av42);
				RiskView_Attributes_Reports.Average_func(DS1,'propownedtaxtotal',av43);
				RiskView_Attributes_Reports.Average_func(DS1,'propagenewestsale',av44);
				// RiskView_Attributes_Reports.Average_func(DS1,'ageoldestrecord',av45);
				// RiskView_Attributes_Reports.Average_func(DS1,'agenewestrecord',av46);
				RiskView_Attributes_Reports.Average_func(DS1,'lastnamechangeage',av47);
				// RiskView_Attributes_Reports.Average_func(DS1,'ssndeceased',av48);
				// RiskView_Attributes_Reports.Average_func(DS1,'ssndatedeceased',av49);
				// RiskView_Attributes_Reports.Average_func(DS1,'ssnissued',av50);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddrageoldestrecord',av51);
      	RiskView_Attributes_Reports.Average_func(DS1,'inputaddragenewestrecord',av52);
      	RiskView_Attributes_Reports.Average_func(DS1,'inputaddrlenofres',av53);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddragelastsale',av54);
      	RiskView_Attributes_Reports.Average_func(DS1,'curraddrageoldestrecord',av55);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddragenewestrecord',av56);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddrlenofres',av57);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddragelastsale',av58);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddrageoldestrecord',av59);
      	RiskView_Attributes_Reports.Average_func(DS1,'prevaddragenewestrecord',av60);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddrlenofres',av61);
			  RiskView_Attributes_Reports.Average_func(DS1,'propageoldestpurchase',av62);
				RiskView_Attributes_Reports.Average_func(DS1,'propagenewestpurchase',av63);
				RiskView_Attributes_Reports.Average_func(DS1,'derogage',av64);
		    RiskView_Attributes_Reports.Average_func(DS1,'felonyage',av65);
				RiskView_Attributes_Reports.Average_func(DS1,'arrestage',av66);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienfiledage',av67);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedage',av68);
				RiskView_Attributes_Reports.Average_func(DS1,'bankruptcyage',av69);
      	RiskView_Attributes_Reports.Average_func(DS1,'evictionage',av70);
				RiskView_Attributes_Reports.Average_func(DS1,'proflicage',av71);
      	RiskView_Attributes_Reports.Average_func(DS1,'phoneedaageoldestrecord',av72);
				RiskView_Attributes_Reports.Average_func(DS1,'phoneedaagenewestrecord',av73);
				RiskView_Attributes_Reports.Average_func(DS1,'phoneotherageoldestrecord',av74);
		    RiskView_Attributes_Reports.Average_func(DS1,'phoneotheragenewestrecord',av75);				
				RiskView_Attributes_Reports.Average_func(DS1,'derogcount',av76);				
				
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmvalue12',av77);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmvalue60',av78);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddravmvalue12',av79);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddravmvalue60',av80);
				RiskView_Attributes_Reports.Average_func(DS1,'addrmostrecentdistance',av81);
				RiskView_Attributes_Reports.Average_func(DS1,'addrmostrecentmoveage',av82);
				RiskView_Attributes_Reports.Average_func(DS1,'estimatedannualincome',av83);				
				RiskView_Attributes_Reports.Average_func(DS1,'businessassociationage',av84);
				RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedtotal',av85);
				RiskView_Attributes_Reports.Average_func(DS1,'accidentage',av86);
				RiskView_Attributes_Reports.Average_func(DS1,'lienfiledtotal',av87);
				
				  RiskView_Attributes_Reports.Average_func(DS1,'subjectssncount',av88);
					RiskView_Attributes_Reports.Average_func(DS1,'subjectaddrcount',av89);
					RiskView_Attributes_Reports.Average_func(DS1,'subjectphonecount',av90);
					RiskView_Attributes_Reports.Average_func(DS1,'subjectssnrecentcount',av91);
					RiskView_Attributes_Reports.Average_func(DS1,'subjectaddrrecentcount',av92);
					RiskView_Attributes_Reports.Average_func(DS1,'subjectphonerecentcount',av93);
					RiskView_Attributes_Reports.Average_func(DS1,'ssnidentitiescount',av94);
					RiskView_Attributes_Reports.Average_func(DS1,'ssnaddrcount',av95);
			    RiskView_Attributes_Reports.Average_func(DS1,'ssnidentitiesrecentcount',av96);
					RiskView_Attributes_Reports.Average_func(DS1,'ssnaddrrecentcount',av97);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrphonecount',av98);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrphonerecentcount',av99);
					RiskView_Attributes_Reports.Average_func(DS1,'phoneidentitiescount',av100);
				  RiskView_Attributes_Reports.Average_func(DS1,'phoneidentitiesrecentcount',av101);
					RiskView_Attributes_Reports.Average_func(DS1,'ssnlastnamecount',av102);
					RiskView_Attributes_Reports.Average_func(DS1,'subjectlastnamecount',av103);
					RiskView_Attributes_Reports.Average_func(DS1,'lastnamechangecount01',av104);
				  RiskView_Attributes_Reports.Average_func(DS1,'lastnamechangecount03',av105);
					RiskView_Attributes_Reports.Average_func(DS1,'lastnamechangecount06',av106);
					RiskView_Attributes_Reports.Average_func(DS1,'lastnamechangecount12',av107);
					RiskView_Attributes_Reports.Average_func(DS1,'lastnamechangecount24',av108);
					RiskView_Attributes_Reports.Average_func(DS1,'lastnamechangecount60',av109);
			  	RiskView_Attributes_Reports.Average_func(DS1,'sfduaddridentitiescount',av110);
					RiskView_Attributes_Reports.Average_func(DS1,'sfduaddrssncount',av111);
				  RiskView_Attributes_Reports.Average_func(DS1,'relativescount',av112);
      	  RiskView_Attributes_Reports.Average_func(DS1,'relativesbankruptcycount',av113);
      	  RiskView_Attributes_Reports.Average_func(DS1,'relativesfelonycount',av114);
				  RiskView_Attributes_Reports.Average_func(DS1,'relativespropownedcount',av115);
			 	  RiskView_Attributes_Reports.Average_func(DS1,'addrchangecount01',av116);
      	  RiskView_Attributes_Reports.Average_func(DS1,'addrchangecount03',av117);
			    RiskView_Attributes_Reports.Average_func(DS1,'addrchangecount06',av118);
				  RiskView_Attributes_Reports.Average_func(DS1,'addrchangecount12',av119);
      	  RiskView_Attributes_Reports.Average_func(DS1,'addrchangecount24',av120);
      	   RiskView_Attributes_Reports.Average_func(DS1,'addrchangecount60',av121);
					RiskView_Attributes_Reports.Average_func(DS1,'propownedcount',av122);
					RiskView_Attributes_Reports.Average_func(DS1,'propownedhistoricalcount',av123);
					RiskView_Attributes_Reports.Average_func(DS1,'proppurchasedcount01',av124);
					RiskView_Attributes_Reports.Average_func(DS1,'proppurchasedcount03',av125);
					RiskView_Attributes_Reports.Average_func(DS1,'proppurchasedcount06',av126);
					RiskView_Attributes_Reports.Average_func(DS1,'proppurchasedcount12',av127);
					RiskView_Attributes_Reports.Average_func(DS1,'proppurchasedcount24',av128);
					RiskView_Attributes_Reports.Average_func(DS1,'proppurchasedcount60',av129);
					RiskView_Attributes_Reports.Average_func(DS1,'propsoldcount01',av130);
					RiskView_Attributes_Reports.Average_func(DS1,'propsoldcount03',av131);
					RiskView_Attributes_Reports.Average_func(DS1,'propsoldcount06',av132);
					RiskView_Attributes_Reports.Average_func(DS1,'propsoldcount12',av133);
					RiskView_Attributes_Reports.Average_func(DS1,'propsoldcount24',av134);
				  RiskView_Attributes_Reports.Average_func(DS1,'propsoldcount60',av135);
					RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount',av136);
					RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount01',av137);
				  RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount03',av138);
					RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount06',av139);
					RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount12',av140);
					RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount24',av141);
				  RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount60',av142);
					RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount',av143);
					RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount01',av144);
					RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount03',av145);
					RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount06',av146);
					RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount12',av147);
					RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount24',av148);
					RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount60',av149);
					RiskView_Attributes_Reports.Average_func(DS1,'felonycount',av150);					
			    RiskView_Attributes_Reports.Average_func(DS1,'felonycount01',av151);
		  		RiskView_Attributes_Reports.Average_func(DS1,'felonycount03',av152);
			    RiskView_Attributes_Reports.Average_func(DS1,'felonycount06',av153);
					RiskView_Attributes_Reports.Average_func(DS1,'felonycount12',av154);
					RiskView_Attributes_Reports.Average_func(DS1,'felonycount24',av155);
					RiskView_Attributes_Reports.Average_func(DS1,'felonycount60',av156);
					RiskView_Attributes_Reports.Average_func(DS1,'arrestcount',av157);
					RiskView_Attributes_Reports.Average_func(DS1,'arrestcount01',av158);
					RiskView_Attributes_Reports.Average_func(DS1,'arrestcount03',av159);
					RiskView_Attributes_Reports.Average_func(DS1,'arrestcount06',av160);
					RiskView_Attributes_Reports.Average_func(DS1,'arrestcount12',av161);
					RiskView_Attributes_Reports.Average_func(DS1,'arrestcount24',av162);
			    RiskView_Attributes_Reports.Average_func(DS1,'arrestcount60',av163);
					RiskView_Attributes_Reports.Average_func(DS1,'liencount',av164);
			    RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount',av165);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount01',av166);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount03',av167);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount06',av168);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount12',av169);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount24',av170);					
			    RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount60',av171);
					RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount',av172);
					RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount01',av173);
				  RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount03',av174);
					RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount06',av175);
					RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount12',av176);
					RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount24',av177);					
					RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount60',av178);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount',av179);
				  RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount01',av180);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount03',av181);
				  RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount06',av182);					
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchlocatecount01',av183);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchlocatecount03',av184);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchlocatecount06',av185);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchlocatecount12',av186);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchlocatecount24',av187);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchpersonalfinancecount',av188);
			    RiskView_Attributes_Reports.Average_func(DS1,'prsearchpersonalfinancecount01',av189);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchpersonalfinancecount03',av190);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchpersonalfinancecount06',av191);		
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchpersonalfinancecount12',av192);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchpersonalfinancecount24',av193);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchidentityssns',av194);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchidentityaddrs',av195);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchidentityphones',av196);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchssnidentities',av197);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchaddridentities',av198);
			    RiskView_Attributes_Reports.Average_func(DS1,'prsearchphoneidentities',av199);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount',av200);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount01',av201);		
					RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount03',av202);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount06',av203);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount12',av204);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount24',av205);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount60',av206);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrvacantpropcount',av207);
			    RiskView_Attributes_Reports.Average_func(DS1,'inputaddrbusinesscount',av208);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrsinglefamilycount',av209);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrmultifamilycount',av210);	
					RiskView_Attributes_Reports.Average_func(DS1,'businessinputaddrcount',av211);	
					RiskView_Attributes_Reports.Average_func(DS1,'accidentcount',av212);
					
					RiskView_Attributes_Reports.Average_func(DS1,'sourceordersourcecount',av213);
					RiskView_Attributes_Reports.Average_func(DS1,'sourceorderagelastorder',av214);		
					RiskView_Attributes_Reports.Average_func(DS1,'variationidentitycount',av215);
					RiskView_Attributes_Reports.Average_func(DS1,'variationmsourcesssncount',av216);
					RiskView_Attributes_Reports.Average_func(DS1,'variationmsourcesssnunrelcount',av217);
					RiskView_Attributes_Reports.Average_func(DS1,'variationdobcount',av218);
					RiskView_Attributes_Reports.Average_func(DS1,'variationdobcountnew',av219);
					RiskView_Attributes_Reports.Average_func(DS1,'searchunverifiedssncountyear',av220);
			    RiskView_Attributes_Reports.Average_func(DS1,'searchunverifiedaddrcountyear',av221);
					RiskView_Attributes_Reports.Average_func(DS1,'searchunverifieddobcountyear',av222);
					RiskView_Attributes_Reports.Average_func(DS1,'searchunverifiedphonecountyear',av223);	
					RiskView_Attributes_Reports.Average_func(DS1,'assocsuspicousidentitiescount',av224);	
					RiskView_Attributes_Reports.Average_func(DS1,'assoccreditbureauonlycount',av225);
					RiskView_Attributes_Reports.Average_func(DS1,'assoccreditbureauonlycountnew',av226);
					RiskView_Attributes_Reports.Average_func(DS1,'assoccreditbureauonlycountmonth',av227);		
					RiskView_Attributes_Reports.Average_func(DS1,'assochighrisktopologycount',av228);
					RiskView_Attributes_Reports.Average_func(DS1,'divssnidentitymsourcecount',av229);
					RiskView_Attributes_Reports.Average_func(DS1,'divssnidentitymsourceurelcount',av230);
					RiskView_Attributes_Reports.Average_func(DS1,'divssnlnamecountnew',av231);
					RiskView_Attributes_Reports.Average_func(DS1,'divssnaddrmsourcecount',av232);
					RiskView_Attributes_Reports.Average_func(DS1,'divaddridentitycount',av233);
			    RiskView_Attributes_Reports.Average_func(DS1,'divaddridentitycountnew',av234);
					RiskView_Attributes_Reports.Average_func(DS1,'divaddridentitymsourcecount',av235);
					RiskView_Attributes_Reports.Average_func(DS1,'divaddrsuspidentitycountnew',av236);	
					RiskView_Attributes_Reports.Average_func(DS1,'divaddrssncount',av237);	
					RiskView_Attributes_Reports.Average_func(DS1,'divaddrssncountnew',av238);
					RiskView_Attributes_Reports.Average_func(DS1,'divaddrssnmsourcecount',av239);
					RiskView_Attributes_Reports.Average_func(DS1,'searchssnsearchcount',av240);		
					RiskView_Attributes_Reports.Average_func(DS1,'searchaddrsearchcount',av241);
					RiskView_Attributes_Reports.Average_func(DS1,'searchphonesearchcount',av242);					
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount12',av243);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount24',av244);					
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount60',av245);
					RiskView_Attributes_Reports.Average_func(DS1,'evictioncount',av246);
					RiskView_Attributes_Reports.Average_func(DS1,'evictioncount01',av247);
					RiskView_Attributes_Reports.Average_func(DS1,'evictioncount03',av248);
			    RiskView_Attributes_Reports.Average_func(DS1,'evictioncount06',av249);
					RiskView_Attributes_Reports.Average_func(DS1,'evictioncount12',av250);
					RiskView_Attributes_Reports.Average_func(DS1,'evictioncount24',av251);					
					RiskView_Attributes_Reports.Average_func(DS1,'evictioncount60',av252);
					RiskView_Attributes_Reports.Average_func(DS1,'nonderogcount',av253);
					RiskView_Attributes_Reports.Average_func(DS1,'nonderogcount01',av254);
					RiskView_Attributes_Reports.Average_func(DS1,'nonderogcount03',av255);
					RiskView_Attributes_Reports.Average_func(DS1,'nonderogcount06',av256);
					RiskView_Attributes_Reports.Average_func(DS1,'nonderogcount12',av257);
			    RiskView_Attributes_Reports.Average_func(DS1,'nonderogcount24',av258);					
					RiskView_Attributes_Reports.Average_func(DS1,'nonderogcount60',av259);
					RiskView_Attributes_Reports.Average_func(DS1,'profliccount',av260);
					RiskView_Attributes_Reports.Average_func(DS1,'profliccount01',av261);
					RiskView_Attributes_Reports.Average_func(DS1,'profliccount03',av262);
					RiskView_Attributes_Reports.Average_func(DS1,'profliccount06',av263);
					RiskView_Attributes_Reports.Average_func(DS1,'profliccount12',av264);
					RiskView_Attributes_Reports.Average_func(DS1,'profliccount24',av265);					
			    RiskView_Attributes_Reports.Average_func(DS1,'profliccount60',av266);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchothercount',av267);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchothercount01',av268);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchothercount03',av269);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchothercount06',av270);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchothercount12',av271);
			    RiskView_Attributes_Reports.Average_func(DS1,'prsearchothercount24',av272);
					RiskView_Attributes_Reports.Average_func(DS1,'prsearchlocatecount',av273);
					RiskView_Attributes_Reports.Average_func(DS1,'srcsconfirmidaddrcount',av274);
					RiskView_Attributes_Reports.Average_func(DS1,'derogrecentcount',av275);
      	
      	   av:= av1  + av2  + av3  + av4  + av5  + av6   + av10 +
				           av11 + av12 + av13 + av14 + av15  + av19 + av20 +
						       av21 + av22 + av23  + av25 + av26 + av30 +
				           av31 + av32  + av43 + av44   + av47 + 
									 av51 + av52 + av53 + av54 + av55 + av56 + av57 + av58 + av59 + av60 +
                   av61 + av62 + av63 + av64 + av65 + av66 + av67 + av68 + av69 + av70 + 
                   av71 + av72 + av73 + av74 + av75 + av76+ av77 + av78 + av79 + av80 + 
                   av81 + av82 + av83 + av84 + av85 + av86 + av87 + av88 + av89 + av90 + 
					         av91 + av92 + av93 + av94 + av95 + av96 + av97 + av98 + av99 + av100 + 
				           av101 + av102 + av103 + av104 + av105 + av106 + av107 + av108 + av109 + av110 + 
									 av111 + av112 + av113 + av114 + av115 + av116 + av117 + av118 + av119 + av120 +
									 av121 + av122 + av123 + av124 + av125 + av126 + av127 + av128 + av129 + av130 +
				           av131 + av132 + av133 + av134 + av135 + av136 + av137 + av138 + av139 + av140 +
				           av141 + av142 + av143 + av144 + av145 + av146 + av147 + av148 + av149 + av150 +
                   av151 + av152 + av153 + av154 + av155 + av156 + av157 + av158 + av159 + av160 +
                   av161 + av162 + av163 + av164 + av165 + av166 + av167 + av168 + av169 + av170 + 
                   av171 + av172 + av173 + av174 + av175 + av176 + av177 + av178 + av179 + av180 + 
									 av181 + av182 + av183 + av184 + av185 + av186 + av187 + av188 + av189 + av190 + 
									 av191 + av192 + av193 + av194 + av195 + av196 + av197 + av198 + av199 + av200 + 
								   av201 + av202 + av203 + av204 + av205 + av206 + av207 + av208 + av209 + av210 + 
									 av211 + av212 + av213 + av214 + av215 + av216 + av217 + av218 + av219 + av220 + 
									 av221 + av222 + av223 + av224 + av225 + av226 + av227 + av228 + av229 + av230 + 
									 av231 + av232 + av233 + av234 + av235 + av236 + av237 + av238 + av239 + av240 + 
									 av241 + av242 + av243 + av244 + av245 + av246 + av247 + av248 + av249 + av250 + 
									 av251 + av252 + av253 + av254 + av255 + av256 + av257 + av258 + av259 + av260 +
									 av261 + av262 + av263 + av264 + av265 + av266 + av267 + av268 + av269 + av270 +
									 av271 + av272 + av273 + av274 + av275;
					
				RiskView_Attributes_Reports.Average_func(DS2,'ageoldestrecord',ave1);
      	RiskView_Attributes_Reports.Average_func(DS2,'agenewestrecord',ave2);
				RiskView_Attributes_Reports.Average_func(DS2,'relativespropownedtaxtotal',ave3);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddrlastsalesprice',ave4);
		    RiskView_Attributes_Reports.Average_func(DS2,'inputaddrtaxvalue',ave5);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddrtaxmarketvalue',ave6);
      	// RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmtax',ave7);
      	// RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmsalesprice',ave8);
				// RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmhedonic',ave9);
      	RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmvalue',ave10);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddrmedianincome',ave11);
      	RiskView_Attributes_Reports.Average_func(DS2,'inputaddrmedianvalue',ave12);
		    RiskView_Attributes_Reports.Average_func(DS2,'curraddrlastsalesprice',ave13);
		  	RiskView_Attributes_Reports.Average_func(DS2,'curraddrtaxvalue',ave14);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddrtaxmarketvalue',ave15);
				// RiskView_Attributes_Reports.Average_func(DS2,'curraddravmtax',ave16);
      	// RiskView_Attributes_Reports.Average_func(DS2,'curraddravmsalesprice',ave17);
      	// RiskView_Attributes_Reports.Average_func(DS2,'curraddravmhedonic',ave18);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddravmvalue',ave19);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddrmedianincome',ave20);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddrmedianvalue',ave21);
	    	RiskView_Attributes_Reports.Average_func(DS2,'prevaddragelastsale',ave22);
      	RiskView_Attributes_Reports.Average_func(DS2,'prevaddrlastsalesprice',ave23);
				// RiskView_Attributes_Reports.Average_func(DS2,'prevaddractivephonelist',ave24);
      	RiskView_Attributes_Reports.Average_func(DS2,'prevaddrtaxvalue',ave25);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddrtaxmarketvalue',ave26);
      	// RiskView_Attributes_Reports.Average_func(DS2,'prevaddravmtax',ave27);
      	// RiskView_Attributes_Reports.Average_func(DS2,'prevaddravmsalesprice',ave28);
				// RiskView_Attributes_Reports.Average_func(DS2,'prevaddravmhedonic',ave29);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddravmvalue',ave30);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddrmedianincome',ave31);
      	RiskView_Attributes_Reports.Average_func(DS2,'prevaddrmedianvalue',ave32);
				// RiskView_Attributes_Reports.Average_func(DS2,'inputcurraddrdistance',ave33);
			  // RiskView_Attributes_Reports.Average_func(DS2,'inputcurraddrtaxdiff',ave34);
      	// RiskView_Attributes_Reports.Average_func(DS2,'inputcurraddrincomediff',ave35);
				// RiskView_Attributes_Reports.Average_func(DS2,'inputcurraddrvaluediff',ave36);
      	// RiskView_Attributes_Reports.Average_func(DS2,'predictedannualincome',ave37);
				// RiskView_Attributes_Reports.Average_func(DS2,'currprevaddrdistance',ave38);
				// RiskView_Attributes_Reports.Average_func(DS2,'currprevaddrtaxdiff',ave39);
				// RiskView_Attributes_Reports.Average_func(DS2,'currprevaddrincomediff',ave40);
				// RiskView_Attributes_Reports.Average_func(DS2,'currprevaddrvaluediff',ave41);
      	// RiskView_Attributes_Reports.Average_func(DS2,'inputphoneaddrdist',ave42);
				RiskView_Attributes_Reports.Average_func(DS2,'propownedtaxtotal',ave43);
				RiskView_Attributes_Reports.Average_func(DS2,'propagenewestsale',ave44);
				// RiskView_Attributes_Reports.Average_func(DS2,'ageoldestrecord',ave45);
				// RiskView_Attributes_Reports.Average_func(DS2,'agenewestrecord',ave46);
				RiskView_Attributes_Reports.Average_func(DS2,'lastnamechangeage',ave47);
				// RiskView_Attributes_Reports.Average_func(DS2,'ssndeceased',ave48);
				// RiskView_Attributes_Reports.Average_func(DS2,'ssndatedeceased',ave49);
				// RiskView_Attributes_Reports.Average_func(DS2,'ssnissued',ave50);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddrageoldestrecord',ave51);
      	RiskView_Attributes_Reports.Average_func(DS2,'inputaddragenewestrecord',ave52);
      	RiskView_Attributes_Reports.Average_func(DS2,'inputaddrlenofres',ave53);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddragelastsale',ave54);
      	RiskView_Attributes_Reports.Average_func(DS2,'curraddrageoldestrecord',ave55);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddragenewestrecord',ave56);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddrlenofres',ave57);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddragelastsale',ave58);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddrageoldestrecord',ave59);
      	RiskView_Attributes_Reports.Average_func(DS2,'prevaddragenewestrecord',ave60);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddrlenofres',ave61);
			  RiskView_Attributes_Reports.Average_func(DS2,'propageoldestpurchase',ave62);
				RiskView_Attributes_Reports.Average_func(DS2,'propagenewestpurchase',ave63);
				RiskView_Attributes_Reports.Average_func(DS2,'derogage',ave64);
		    RiskView_Attributes_Reports.Average_func(DS2,'felonyage',ave65);
				RiskView_Attributes_Reports.Average_func(DS2,'arrestage',ave66);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienfiledage',ave67);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedage',ave68);
				RiskView_Attributes_Reports.Average_func(DS2,'bankruptcyage',ave69);
      	RiskView_Attributes_Reports.Average_func(DS2,'evictionage',ave70);
				RiskView_Attributes_Reports.Average_func(DS2,'proflicage',ave71);
      	RiskView_Attributes_Reports.Average_func(DS2,'phoneedaageoldestrecord',ave72);
				RiskView_Attributes_Reports.Average_func(DS2,'phoneedaagenewestrecord',ave73);
				RiskView_Attributes_Reports.Average_func(DS2,'phoneotherageoldestrecord',ave74);
		    RiskView_Attributes_Reports.Average_func(DS2,'phoneotheragenewestrecord',ave75);
				RiskView_Attributes_Reports.Average_func(DS2,'derogcount',ave76);
				
				 RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmvalue12',ave77);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmvalue60',ave78);
				 RiskView_Attributes_Reports.Average_func(DS2,'curraddravmvalue12',ave79);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddravmvalue60',ave80);
				RiskView_Attributes_Reports.Average_func(DS2,'addrmostrecentdistance',ave81);
				RiskView_Attributes_Reports.Average_func(DS2,'addrmostrecentmoveage',ave82);
				RiskView_Attributes_Reports.Average_func(DS2,'estimatedannualincome',ave83);
				
				RiskView_Attributes_Reports.Average_func(DS2,'businessassociationage',ave84);
				RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedtotal',ave85);
				RiskView_Attributes_Reports.Average_func(DS2,'accidentage',ave86);
				
				RiskView_Attributes_Reports.Average_func(DS2,'lienfiledtotal',ave87);
					RiskView_Attributes_Reports.Average_func(DS2,'subjectssncount',ave88);
					RiskView_Attributes_Reports.Average_func(DS2,'subjectaddrcount',ave89);
					RiskView_Attributes_Reports.Average_func(DS2,'subjectphonecount',ave90);
					RiskView_Attributes_Reports.Average_func(DS2,'subjectssnrecentcount',ave91);
					RiskView_Attributes_Reports.Average_func(DS2,'subjectaddrrecentcount',ave92);
					RiskView_Attributes_Reports.Average_func(DS2,'subjectphonerecentcount',ave93);
					RiskView_Attributes_Reports.Average_func(DS2,'ssnidentitiescount',ave94);
					RiskView_Attributes_Reports.Average_func(DS2,'ssnaddrcount',ave95);
			    RiskView_Attributes_Reports.Average_func(DS2,'ssnidentitiesrecentcount',ave96);
					RiskView_Attributes_Reports.Average_func(DS2,'ssnaddrrecentcount',ave97);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrphonecount',ave98);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrphonerecentcount',ave99);
					RiskView_Attributes_Reports.Average_func(DS2,'phoneidentitiescount',ave100);
				  RiskView_Attributes_Reports.Average_func(DS2,'phoneidentitiesrecentcount',ave101);
					RiskView_Attributes_Reports.Average_func(DS2,'ssnlastnamecount',ave102);
					RiskView_Attributes_Reports.Average_func(DS2,'subjectlastnamecount',ave103);
					RiskView_Attributes_Reports.Average_func(DS2,'lastnamechangecount01',ave104);
				  RiskView_Attributes_Reports.Average_func(DS2,'lastnamechangecount03',ave105);
					RiskView_Attributes_Reports.Average_func(DS2,'lastnamechangecount06',ave106);
					RiskView_Attributes_Reports.Average_func(DS2,'lastnamechangecount12',ave107);
					RiskView_Attributes_Reports.Average_func(DS2,'lastnamechangecount24',ave108);
					RiskView_Attributes_Reports.Average_func(DS2,'lastnamechangecount60',ave109);
			  	RiskView_Attributes_Reports.Average_func(DS2,'sfduaddridentitiescount',ave110);
					RiskView_Attributes_Reports.Average_func(DS2,'sfduaddrssncount',ave111);
				  RiskView_Attributes_Reports.Average_func(DS2,'relativescount',ave112);
      	  RiskView_Attributes_Reports.Average_func(DS2,'relativesbankruptcycount',ave113);
      	  RiskView_Attributes_Reports.Average_func(DS2,'relativesfelonycount',ave114);
				  RiskView_Attributes_Reports.Average_func(DS2,'relativespropownedcount',ave115);
			 	  RiskView_Attributes_Reports.Average_func(DS2,'addrchangecount01',ave116);
      	  RiskView_Attributes_Reports.Average_func(DS2,'addrchangecount03',ave117);
			    RiskView_Attributes_Reports.Average_func(DS2,'addrchangecount06',ave118);
				  RiskView_Attributes_Reports.Average_func(DS2,'addrchangecount12',ave119);
      	  RiskView_Attributes_Reports.Average_func(DS2,'addrchangecount24',ave120);
      	   RiskView_Attributes_Reports.Average_func(DS2,'addrchangecount60',ave121);
					RiskView_Attributes_Reports.Average_func(DS2,'propownedcount',ave122);
					RiskView_Attributes_Reports.Average_func(DS2,'propownedhistoricalcount',ave123);
					RiskView_Attributes_Reports.Average_func(DS2,'proppurchasedcount01',ave124);
					RiskView_Attributes_Reports.Average_func(DS2,'proppurchasedcount03',ave125);
					RiskView_Attributes_Reports.Average_func(DS2,'proppurchasedcount06',ave126);
					RiskView_Attributes_Reports.Average_func(DS2,'proppurchasedcount12',ave127);
					RiskView_Attributes_Reports.Average_func(DS2,'proppurchasedcount24',ave128);
					RiskView_Attributes_Reports.Average_func(DS2,'proppurchasedcount60',ave129);
					RiskView_Attributes_Reports.Average_func(DS2,'propsoldcount01',ave130);
					RiskView_Attributes_Reports.Average_func(DS2,'propsoldcount03',ave131);
					RiskView_Attributes_Reports.Average_func(DS2,'propsoldcount06',ave132);
					RiskView_Attributes_Reports.Average_func(DS2,'propsoldcount12',ave133);
					RiskView_Attributes_Reports.Average_func(DS2,'propsoldcount24',ave134);
				  RiskView_Attributes_Reports.Average_func(DS2,'propsoldcount60',ave135);
					RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount',ave136);
					RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount01',ave137);
				  RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount03',ave138);
					RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount06',ave139);
					RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount12',ave140);
					RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount24',ave141);
				  RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount60',ave142);
					RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount',ave143);
					RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount01',ave144);
					RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount03',ave145);
					RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount06',ave146);
					RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount12',ave147);
					RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount24',ave148);
					RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount60',ave149);
					RiskView_Attributes_Reports.Average_func(DS2,'felonycount',ave150);					
			    RiskView_Attributes_Reports.Average_func(DS2,'felonycount01',ave151);
		  		RiskView_Attributes_Reports.Average_func(DS2,'felonycount03',ave152);
			    RiskView_Attributes_Reports.Average_func(DS2,'felonycount06',ave153);
					RiskView_Attributes_Reports.Average_func(DS2,'felonycount12',ave154);
					RiskView_Attributes_Reports.Average_func(DS2,'felonycount24',ave155);
					RiskView_Attributes_Reports.Average_func(DS2,'felonycount60',ave156);
					RiskView_Attributes_Reports.Average_func(DS2,'arrestcount',ave157);
					RiskView_Attributes_Reports.Average_func(DS2,'arrestcount01',ave158);
					RiskView_Attributes_Reports.Average_func(DS2,'arrestcount03',ave159);
					RiskView_Attributes_Reports.Average_func(DS2,'arrestcount06',ave160);
					RiskView_Attributes_Reports.Average_func(DS2,'arrestcount12',ave161);
					RiskView_Attributes_Reports.Average_func(DS2,'arrestcount24',ave162);
			    RiskView_Attributes_Reports.Average_func(DS2,'arrestcount60',ave163);
					RiskView_Attributes_Reports.Average_func(DS2,'liencount',ave164);
			    RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount',ave165);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount01',ave166);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount03',ave167);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount06',ave168);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount12',ave169);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount24',ave170);					
			    RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount60',ave171);
					RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount',ave172);
					RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount01',ave173);
				  RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount03',ave174);
					RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount06',ave175);
					RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount12',ave176);
					RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount24',ave177);					
					RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount60',ave178);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount',ave179);
				  RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount01',ave180);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount03',ave181);
				  RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount06',ave182);					
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchlocatecount01',ave183);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchlocatecount03',ave184);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchlocatecount06',ave185);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchlocatecount12',ave186);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchlocatecount24',ave187);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchpersonalfinancecount',ave188);
			    RiskView_Attributes_Reports.Average_func(DS2,'prsearchpersonalfinancecount01',ave189);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchpersonalfinancecount03',ave190);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchpersonalfinancecount06',ave191);		
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchpersonalfinancecount12',ave192);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchpersonalfinancecount24',ave193);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchidentityssns',ave194);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchidentityaddrs',ave195);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchidentityphones',ave196);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchssnidentities',ave197);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchaddridentities',ave198);
			    RiskView_Attributes_Reports.Average_func(DS2,'prsearchphoneidentities',ave199);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount',ave200);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount01',ave201);		
					RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount03',ave202);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount06',ave203);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount12',ave204);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount24',ave205);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount60',ave206);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrvacantpropcount',ave207);
			    RiskView_Attributes_Reports.Average_func(DS2,'inputaddrbusinesscount',ave208);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrsinglefamilycount',ave209);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrmultifamilycount',ave210);	
					RiskView_Attributes_Reports.Average_func(DS2,'businessinputaddrcount',ave211);	
					RiskView_Attributes_Reports.Average_func(DS2,'accidentcount',ave212);
					
					RiskView_Attributes_Reports.Average_func(DS2,'sourceordersourcecount',ave213);
					RiskView_Attributes_Reports.Average_func(DS2,'sourceorderagelastorder',ave214);		
					RiskView_Attributes_Reports.Average_func(DS2,'variationidentitycount',ave215);
					RiskView_Attributes_Reports.Average_func(DS2,'variationmsourcesssncount',ave216);
					RiskView_Attributes_Reports.Average_func(DS2,'variationmsourcesssnunrelcount',ave217);
					RiskView_Attributes_Reports.Average_func(DS2,'variationdobcount',ave218);
					RiskView_Attributes_Reports.Average_func(DS2,'variationdobcountnew',ave219);
					RiskView_Attributes_Reports.Average_func(DS2,'searchunverifiedssncountyear',ave220);
			    RiskView_Attributes_Reports.Average_func(DS2,'searchunverifiedaddrcountyear',ave221);
					RiskView_Attributes_Reports.Average_func(DS2,'searchunverifieddobcountyear',ave222);
					RiskView_Attributes_Reports.Average_func(DS2,'searchunverifiedphonecountyear',ave223);	
					RiskView_Attributes_Reports.Average_func(DS2,'assocsuspicousidentitiescount',ave224);	
					RiskView_Attributes_Reports.Average_func(DS2,'assoccreditbureauonlycount',ave225);
					RiskView_Attributes_Reports.Average_func(DS2,'assoccreditbureauonlycountnew',ave226);
					RiskView_Attributes_Reports.Average_func(DS2,'assoccreditbureauonlycountmonth',ave227);		
					RiskView_Attributes_Reports.Average_func(DS2,'assochighrisktopologycount',ave228);
					RiskView_Attributes_Reports.Average_func(DS2,'divssnidentitymsourcecount',ave229);
					RiskView_Attributes_Reports.Average_func(DS2,'divssnidentitymsourceurelcount',ave230);
					RiskView_Attributes_Reports.Average_func(DS2,'divssnlnamecountnew',ave231);
					RiskView_Attributes_Reports.Average_func(DS2,'divssnaddrmsourcecount',ave232);
					RiskView_Attributes_Reports.Average_func(DS2,'divaddridentitycount',ave233);
			    RiskView_Attributes_Reports.Average_func(DS2,'divaddridentitycountnew',ave234);
					RiskView_Attributes_Reports.Average_func(DS2,'divaddridentitymsourcecount',ave235);
					RiskView_Attributes_Reports.Average_func(DS2,'divaddrsuspidentitycountnew',ave236);	
					RiskView_Attributes_Reports.Average_func(DS2,'divaddrssncount',ave237);	
					RiskView_Attributes_Reports.Average_func(DS2,'divaddrssncountnew',ave238);
					RiskView_Attributes_Reports.Average_func(DS2,'divaddrssnmsourcecount',ave239);
					RiskView_Attributes_Reports.Average_func(DS2,'searchssnsearchcount',ave240);		
					RiskView_Attributes_Reports.Average_func(DS2,'searchaddrsearchcount',ave241);
					RiskView_Attributes_Reports.Average_func(DS2,'searchphonesearchcount',ave242);					
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount12',ave243);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount24',ave244);					
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount60',ave245);
					RiskView_Attributes_Reports.Average_func(DS2,'evictioncount',ave246);
					RiskView_Attributes_Reports.Average_func(DS2,'evictioncount01',ave247);
					RiskView_Attributes_Reports.Average_func(DS2,'evictioncount03',ave248);
			    RiskView_Attributes_Reports.Average_func(DS2,'evictioncount06',ave249);
					RiskView_Attributes_Reports.Average_func(DS2,'evictioncount12',ave250);
					RiskView_Attributes_Reports.Average_func(DS2,'evictioncount24',ave251);					
					RiskView_Attributes_Reports.Average_func(DS2,'evictioncount60',ave252);
					RiskView_Attributes_Reports.Average_func(DS2,'nonderogcount',ave253);
					RiskView_Attributes_Reports.Average_func(DS2,'nonderogcount01',ave254);
					RiskView_Attributes_Reports.Average_func(DS2,'nonderogcount03',ave255);
					RiskView_Attributes_Reports.Average_func(DS2,'nonderogcount06',ave256);
					RiskView_Attributes_Reports.Average_func(DS2,'nonderogcount12',ave257);
			    RiskView_Attributes_Reports.Average_func(DS2,'nonderogcount24',ave258);					
					RiskView_Attributes_Reports.Average_func(DS2,'nonderogcount60',ave259);
					RiskView_Attributes_Reports.Average_func(DS2,'profliccount',ave260);
					RiskView_Attributes_Reports.Average_func(DS2,'profliccount01',ave261);
					RiskView_Attributes_Reports.Average_func(DS2,'profliccount03',ave262);
					RiskView_Attributes_Reports.Average_func(DS2,'profliccount06',ave263);
					RiskView_Attributes_Reports.Average_func(DS2,'profliccount12',ave264);
					RiskView_Attributes_Reports.Average_func(DS2,'profliccount24',ave265);					
			    RiskView_Attributes_Reports.Average_func(DS2,'profliccount60',ave266);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchothercount',ave267);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchothercount01',ave268);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchothercount03',ave269);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchothercount06',ave270);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchothercount12',ave271);
			    RiskView_Attributes_Reports.Average_func(DS2,'prsearchothercount24',ave272);
					RiskView_Attributes_Reports.Average_func(DS2,'prsearchlocatecount',ave273);
					RiskView_Attributes_Reports.Average_func(DS2,'srcsconfirmidaddrcount',ave274);
					RiskView_Attributes_Reports.Average_func(DS2,'derogrecentcount',ave275);
      	
      	   avearage:= ave1  + ave2  + ave3  + ave4  + ave5  + ave6   + ave10 +
				           ave11 + ave12 + ave13 + ave14 + ave15  + ave19 + ave20 +
						       ave21 + ave22 + ave23  + ave25 + ave26 + ave30 +
				           ave31 + ave32  + ave43 + ave44   + ave47 + 
									 ave51 + ave52 + ave53 + ave54 + ave55 + ave56 + ave57 + ave58 + ave59 + ave60 +
                   ave61 + ave62 + ave63 + ave64 + ave65 + ave66 + ave67 + ave68 + ave69 + ave70 + 
                   ave71 + ave72 + ave73 + ave74 + ave75 + ave76+ ave77 + ave78 + ave79 + ave80 + 
                   ave81 + ave82 + ave83 + ave84 + ave85 + ave86 + ave87 + ave88 + ave89 + ave90 + 
					         ave91 + ave92 + ave93 + ave94 + ave95 + ave96 + ave97 + ave98 + ave99 + ave100 + 
				           ave101 + ave102 + ave103 + ave104 + ave105 + ave106 + ave107 + ave108 + ave109 + ave110 + 
									 ave111 + ave112 + ave113 + ave114 + ave115 + ave116 + ave117 + ave118 + ave119 + ave120 +
									 ave121 + ave122 + ave123 + ave124 + ave125 + ave126 + ave127 + ave128 + ave129 + ave130 +
				           ave131 + ave132 + ave133 + ave134 + ave135 + ave136 + ave137 + ave138 + ave139 + ave140 +
				           ave141 + ave142 + ave143 + ave144 + ave145 + ave146 + ave147 + ave148 + ave149 + ave150 +
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
									 ave251 + ave252 + ave253 + ave254 + ave255 + ave256 + ave257 + ave258 + ave259 + ave260 +
									 ave261 + ave262 + ave263 + ave264 + ave265 + ave266 + ave267 + ave268 + ave269 + ave270 +
									 ave271 + ave272 + ave273 + ave274 + ave275;
				
      
					
								 // RiskView_Attributes_Reports.Range_Average_Function_0(DS1,'inputcurraddrtaxdiff',ranav0_1);
								 // RiskView_Attributes_Reports.Range_Average_Function_0(DS1,'inputcurraddrincomediff',ranav0_2);
								 // RiskView_Attributes_Reports.Range_Average_Function_0(DS1,'inputcurraddrvaluediff',ranav0_3);
								 // RiskView_Attributes_Reports.Range_Average_Function_0(DS1,'currprevaddrtaxdiff',ranav0_4);
								 // RiskView_Attributes_Reports.Range_Average_Function_0(DS1,'currprevaddrincomediff',ranav0_5);
								 // RiskView_Attributes_Reports.Range_Average_Function_0(DS1,'currprevaddrvaluediff',ranav0_6);
								 
											 
											 // ranav0:= ranav0_5  + ranav0_6;
											 
								 // RiskView_Attributes_Reports.Range_Average_Function_0(DS2,'inputcurraddrtaxdiff',ranave0_1);
								 // RiskView_Attributes_Reports.Range_Average_Function_0(DS2,'inputcurraddrincomediff',ranave0_2);
								 // RiskView_Attributes_Reports.Range_Average_Function_0(DS2,'inputcurraddrvaluediff',ranave0_3);
								 // RiskView_Attributes_Reports.Range_Average_Function_0(DS2,'currprevaddrtaxdiff',ranave0_4);
								 // RiskView_Attributes_Reports.Range_Average_Function_0(DS2,'currprevaddrincomediff',ranave0_5);
								 // RiskView_Attributes_Reports.Range_Average_Function_0(DS2,'currprevaddrvaluediff',ranave0_6);
								 
								  RiskView_Attributes_Reports.Range_Average_Function_0(DS2,'addrmostrecenttaxdiff',ranave0_4);
								 RiskView_Attributes_Reports.Range_Average_Function_0(DS2,'addrmostrecentincomediff',ranave0_5);
								 RiskView_Attributes_Reports.Range_Average_Function_0(DS2,'addrmostrecentvaluediff',ranave0_6);
								 
											 
											 // ranave0:=  ranave0_5  + ranave0_6;			 
											 
									RiskView_Attributes_Reports.Range_Average_Function_1(DS1,'addrmostrecentcrimediff',ranav1_1);
	ranav1:=ranav1_1 ;
											 
											 RiskView_Attributes_Reports.Range_Average_Function_1(DS2,'addrmostrecentcrimediff',ranave1_1);
	ranave1:=ranave1_1 ;
	
	 result3_stats:=av + ranav1;
   result4_stats:=avearage  + ranave1;
	 
	 //////////////////////////////////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////////////////////////////////
	 //////////////////////////////////////////////////////////////////////////////////
	 
    compare_layout := RECORD
		  string file_version;
			string mode;
      string field_name;
      string distribution_type;
			decimal20_4 p_file_count;
      decimal20_4 c_file_count;
      decimal20_4 file_count_diff;
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
	
								
            END;				
     	 compare_result1:= join(result2_stats,result1_stats,
				                                        // left.file_version = right.file_version and
      	                                        left.field_name = right.field_name and
         									                      left.distribution_type = right.distribution_type and
         																	      left.attribute_value = right.attribute_value //and
         									                      // left.Count1 = right.Count1
   																							,transform(	compare_layout, self.file_version:='li_v4',
																								                            self.mode:='batch',
																								                            self.field_name:=if(left.field_name='',right.field_name,left.field_name),
                  			 			                                              self.distribution_type:=if(left.distribution_type='',right.distribution_type,left.distribution_type),
																																						self.p_file_count:=count(file1),
																																						self.c_file_count:=count(file2),
																																						self.file_count_diff:=count(file2)-count(file1) ,
               																														  self.attribute_value:=if(left.attribute_value='',right.attribute_value,left.attribute_value),
      																																		  self.p_frequency:=right.Count1,
                  			 			                                              self.c_frequency:=left.Count1,
               																														  self.frequency_diff:=left.Count1-right.Count1,
																																						self.perc_frequency_diff:=if(right.Count1!= 0 and left.Count1=0,1,(left.Count1-right.Count1)/left.Count1),
   																																					self.p_proportion:=right.Count1/count(DS1),
                  			 			                                              self.c_proportion:=left.Count1/count(DS2),
               																														  self.proportion_diff:=(left.Count1/count(DS2))-(right.Count1/count(DS1)),
																																						self.abs_proportion_diff:=abs((left.Count1/count(DS2))-(right.Count1/count(DS1))),
																																						self.perc_proportion_diff:=if(right.Count1!= 0 and left.Count1=0,1,((left.Count1/count(DS2))-(right.Count1/count(DS1)))/(left.Count1/count(DS2)))
																																				
																																						
      																						                        ),full outer
      																																											 );

compare_result2:= join(result4_stats,result3_stats,
				                                        // left.file_version = right.file_version and
      	                                        left.field_name = right.field_name and
         									                      left.distribution_type = right.distribution_type and
         																	      left.attribute_value = right.attribute_value //and
         									                      // left.Count1 = right.Count1
   																							,transform(	compare_layout, self.file_version:='li_v4',
																								                            self.mode:='batch',
																								                            self.field_name:=if(left.field_name='',right.field_name,left.field_name),
                  			 			                                              self.distribution_type:=if(left.distribution_type='',right.distribution_type,left.distribution_type),
																																						self.p_file_count:=count(file1),
																																						self.c_file_count:=count(file2),
																																						self.file_count_diff:=count(file2)-count(file1) ,
               																														  self.attribute_value:=if(left.attribute_value='',right.attribute_value,left.attribute_value),
      																																		  self.p_frequency:=count(ds1),
                  			 			                                              self.c_frequency:=count(ds2),
               																														  self.frequency_diff:=count(ds2)-count(ds1),
																																						self.perc_frequency_diff:=(count(ds2)-count(ds1))/count(ds1),
   																																					self.p_proportion:=right.Count1,
                  			 			                                              self.c_proportion:=left.Count1,
               																														  self.proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,(left.Count1-right.Count1)/left.Count1),
																																						self.abs_proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,abs((left.Count1-right.Count1)/left.Count1)),
																																						self.perc_proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,((left.Count1-right.Count1)/left.Count1)/left.Count1)
																																						
      																						                        ),full outer
      																																											 );
         										compare_result:=compare_result1 + compare_result2;																														 
				// compare_result_filter1:=compare_result(abs_proportion_diff>=0.01);										
			  // compare_result_filter2:=sort(compare_result_filter1,-abs_proportion_diff);										

return choosen(compare_result,all);


endmacro;