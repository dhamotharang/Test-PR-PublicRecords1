EXPORT FCRA_RiskView_xml_generic_attributes_v4 (route,current_dt,previous_dt) := functionmacro

import Scoring_Project_Macros;

 file1_2:= dataset(route + scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_XML_Generic_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_Generic_Attributes_V4_Global_Layout,


thor);

 file2_2:= dataset(route + scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_XML_Generic_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_Generic_Attributes_V4_Global_Layout,


thor);


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
	 
	 

   	  	

      	Scoring_QA.Range_function_module.range_function_242(DS2,'ageoldestrecord',ran1);
      	Scoring_QA.Range_function_module.range_function_51(DS2,'agenewestrecord',ran2);
				Scoring_QA.Range_function_module.range_function_56(DS2,'ssnagedeceased',ran3);
      	Scoring_QA.Range_function_module.range_function_70(DS2,'ssnlowissueage',ran4);
      	Scoring_QA.Range_function_module.range_function_70(DS2,'ssnhighissueage',ran5);
				Scoring_QA.Range_function_module.range_function_58(DS2,'inputaddrageoldestrecord',ran6);
      	Scoring_QA.Range_function_module.range_function_27(DS2,'inputaddragenewestrecord',ran7);
      	Scoring_QA.Range_function_module.range_function_21(DS2,'inputaddrlenofres',ran8);
				Scoring_QA.Range_function_module.range_function_57(DS2,'inputaddragelastsale',ran9);
				Scoring_QA.Range_function_module.range_function_29(DS2,'inferredminimumage',ran10);
      	Scoring_QA.Range_function_module.range_function_18(DS2,'bestreportedage',ran11);
				Scoring_QA.Range_function_module.range_function_21(DS2,'curraddrageoldestrecord',ran12);
				Scoring_QA.Range_function_module.range_function_27(DS2,'curraddragenewestrecord',ran13);
      	Scoring_QA.Range_function_module.range_function_21(DS2,'curraddrlenofres',ran14);
      	Scoring_QA.Range_function_module.range_function_42(DS2,'curraddragelastsale',ran15);
				Scoring_QA.Range_function_module.range_function_20(DS2,'prevaddrageoldestrecord',ran16);
      	Scoring_QA.Range_function_module.range_function_20(DS2,'prevaddragenewestrecord',ran17);
      	Scoring_QA.Range_function_module.range_function_244(DS2,'prevaddrlenofres',ran18);
				Scoring_QA.Range_function_module.range_function_20(DS2,'prevaddragelastsale',ran19);
				Scoring_QA.Range_function_module.range_function_50(DS2,'addrmostrecentmoveage',ran20);
				Scoring_QA.Range_function_module.range_function_42(DS2,'propageoldestpurchase',ran21);
      	Scoring_QA.Range_function_module.range_function_42(DS2,'propagenewestpurchase',ran22);
				Scoring_QA.Range_function_module.range_function_42(DS2,'propagenewestsale',ran23);
				Scoring_QA.Range_function_module.range_function_53(DS2,'businessassociationage',ran24);
				Scoring_QA.Range_function_module.range_function_67(DS2,'proflicage',ran25);
				Scoring_QA.Range_function_module.range_function_64(DS2,'phoneedaageoldestrecord',ran26);
      	Scoring_QA.Range_function_module.range_function_63(DS2,'phoneedaagenewestrecord',ran27);
      	Scoring_QA.Range_function_module.range_function_64(DS2,'phoneotherageoldestrecord',ran28);
				Scoring_QA.Range_function_module.range_function_64(DS2,'phoneotheragenewestrecord',ran29);
				
		    	Scoring_QA.Range_function_module.range_function_54(DS2,'curraddravmvalue',ran30);
					Scoring_QA.Range_function_module.range_function_54(DS2,'curraddravmvalue12',ran31);
					Scoring_QA.Range_function_module.range_function_54(DS2,'curraddravmvalue60',ran32);
					Scoring_QA.Range_function_module.range_function_54(DS2,'curraddrlastsalesprice',ran33);
					// Scoring_QA.Range_function_module.range_function_55(DS2,'did',ran34);
					Scoring_QA.Range_function_module.range_function_59(DS2,'inputaddravmvalue',ran35);
					Scoring_QA.Range_function_module.range_function_59(DS2,'inputaddravmvalue12',ran36);
					Scoring_QA.Range_function_module.range_function_59(DS2,'inputaddravmvalue60',ran37);
					Scoring_QA.Range_function_module.range_function_59(DS2,'inputaddrlastsalesprice',ran38);
					Scoring_QA.Range_function_module.range_function_59(DS2,'inputaddrtaxmarketvalue',ran39);
					Scoring_QA.Range_function_module.range_function_59(DS2,'lienfiledtotal',ran40);
					Scoring_QA.Range_function_module.range_function_40(DS2,'lienfederaltaxfiledtotal',ran41);
					// Scoring_QA.Range_function_module.range_function_35(DS2,'lienfederaltaxfiledtotal',ran42);
					Scoring_QA.Range_function_module.range_function_35(DS2,'lienfederaltaxreleasedtotal',ran43);
					Scoring_QA.Range_function_module.range_function_35(DS2,'lienforeclosurefiledtotal',ran44);
				  Scoring_QA.Range_function_module.range_function_35(DS2,'lienjudgmentfiledtotal',ran45);					
			    Scoring_QA.Range_function_module.range_function_35(DS2,'lienlandlordtenantfiledtotal',ran46);
				  Scoring_QA.Range_function_module.range_function_35(DS2,'lienotherfiledtotal',ran47);
			    Scoring_QA.Range_function_module.range_function_35(DS2,'lienotherreleasedtotal',ran48);					
					// Scoring_QA.Range_function_module.range_function_35(DS2,'lienpreforeclosurefiledtotal',ran49);
					// Scoring_QA.Range_function_module.range_function_35(DS2,'lienpreforeclosurereleasedtotal',ran50);					
			    Scoring_QA.Range_function_module.range_function_35(DS2,'liensmallclaimsfiledtotal',ran51);
      		Scoring_QA.Range_function_module.range_function_35(DS2,'liensmallclaimsreleasedtotal',ran52);	
			    Scoring_QA.Range_function_module.range_function_35(DS2,'lientaxotherfiledtotal',ran53);
			    Scoring_QA.Range_function_module.range_function_35(DS2,'lientaxotherreleasedtotal',ran54);					
					Scoring_QA.Range_function_module.range_function_35(DS2,'lienforeclosurereleasedtotal',ran55);
				  Scoring_QA.Range_function_module.range_function_35(DS2,'lienjudgmentreleasedtotal',ran56);
					Scoring_QA.Range_function_module.range_function_35(DS2,'lienlandlordtenantreleasedtotal',ran57);				
					Scoring_QA.Range_function_module.range_function_243(DS2,'prevaddravmvalue',ran58);
					Scoring_QA.Range_function_module.range_function_65(DS2,'prevaddrlastsalesprice',ran59);
					Scoring_QA.Range_function_module.range_function_56(DS2,'prevaddrtaxmarketvalue',ran60);
					Scoring_QA.Range_function_module.range_function_56(DS2,'prevaddrtaxvalue',ran61);
      		Scoring_QA.Range_function_module.range_function_68(DS2,'propnewestsaleprice',ran62);
					Scoring_QA.Range_function_module.range_function_35(DS2,'propownedtaxtotal',ran63);
													Scoring_QA.Range_function_module.range_function_45(DS2,'subjectaddrcount',ran64);
      	
      	ran:= ran1  + ran2  + ran3  + ran4  + ran5  + ran6  + ran7  + ran8  + ran9  + ran10 +
				      ran11 + ran12 + ran13 + ran14 + ran15 + ran16 + ran17 + ran18 + ran19 + ran20 +
						  ran21 + ran22 + ran23 + ran24 + ran25 + ran26 + ran27 + ran28 + ran29+ ran30 + 
							ran31 + ran32 + ran33  + ran35 + ran36 + ran37 + ran38 + ran39+ ran40  + 
							ran41  + ran43 + ran44 + ran45 + ran46  + ran47 + ran48 + 
						 ran51 + ran52 + ran53 + ran54 + ran55 + ran56  + ran57 + ran58 + ran59 + ran60 +
						 ran61 + ran62 + ran63 + ran64;
				
				  Scoring_QA.Range_function_module.range_function_26(DS2,'aircraftcount',ran0_1);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'addrchangecount01',ran0_2);
					Scoring_QA.Range_function_module.range_function_31(DS2,'addrchangecount03',ran0_3);
					Scoring_QA.Range_function_module.range_function_31(DS2,'addrchangecount06',ran0_4);
					Scoring_QA.Range_function_module.range_function_31(DS2,'addrchangecount12',ran0_5);
					Scoring_QA.Range_function_module.range_function_31(DS2,'addrchangecount24',ran0_6);
					Scoring_QA.Range_function_module.range_function_31(DS2,'addrchangecount60',ran0_7);
					Scoring_QA.Range_function_module.range_function_43(DS2,'propownedcount',ran0_8);
			    Scoring_QA.Range_function_module.range_function_43(DS2,'propownedhistoricalcount',ran0_9);
					Scoring_QA.Range_function_module.range_function_54(DS2,'proppurchasedcount01',ran0_10);
					Scoring_QA.Range_function_module.range_function_54(DS2,'proppurchasedcount03',ran0_11);
					Scoring_QA.Range_function_module.range_function_54(DS2,'proppurchasedcount06',ran0_12);
					Scoring_QA.Range_function_module.range_function_54(DS2,'proppurchasedcount12',ran0_13);
					Scoring_QA.Range_function_module.range_function_54(DS2,'proppurchasedcount24',ran0_14);
					Scoring_QA.Range_function_module.range_function_54(DS2,'proppurchasedcount60',ran0_15);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'propsoldcount01',ran0_16);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'propsoldcount03',ran0_17);
				  Scoring_QA.Range_function_module.Range_Function_25(DS2,'propsoldcount06',ran0_18);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'propsoldcount12',ran0_19);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'propsoldcount24',ran0_20);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'propsoldcount60',ran0_21);
				  Scoring_QA.Range_function_module.range_function_26(DS2,'watercraftcount',ran0_22);
					Scoring_QA.Range_function_module.range_function_26(DS2,'watercraftcount01',ran0_23);
					Scoring_QA.Range_function_module.range_function_26(DS2,'watercraftcount03',ran0_24);
					Scoring_QA.Range_function_module.range_function_26(DS2,'watercraftcount06',ran0_25);
				  Scoring_QA.Range_function_module.range_function_26(DS2,'watercraftcount12',ran0_26);
		  		Scoring_QA.Range_function_module.range_function_26(DS2,'watercraftcount24',ran0_27);
			  	Scoring_QA.Range_function_module.range_function_26(DS2,'watercraftcount60',ran0_28);
					
				Scoring_QA.Range_function_module.Range_Function_51(DS2,'subjectssncount',ran0_29);
				// Scoring_QA.Range_function_module.Range_Function_0(DS2,'subjectaddrcount',ran0_30);
      	Scoring_QA.Range_function_module.Range_Function_25(DS2,'subjectphonecount',ran0_31);
      	Scoring_QA.Range_function_module.Range_Function_40(DS2,'subjectssnrecentcount',ran0_32);
				Scoring_QA.Range_function_module.Range_Function_40(DS2,'subjectaddrrecentcount',ran0_33);
      	Scoring_QA.Range_function_module.Range_Function_40(DS2,'subjectphonerecentcount',ran0_34);
      	Scoring_QA.Range_function_module.range_function_46(DS2,'ssnidentitiescount',ran0_35);
				Scoring_QA.Range_function_module.range_function_45(DS2,'ssnaddrcount',ran0_36);
      	Scoring_QA.Range_function_module.Range_Function_56(DS2,'ssnidentitiesrecentcount',ran0_37);
      	Scoring_QA.Range_function_module.range_function_25(DS2,'ssnaddrrecentcount',ran0_38);
				Scoring_QA.Range_function_module.range_function_60(DS2,'inputaddrphonecount',ran0_39);
				Scoring_QA.Range_function_module.range_function_61(DS2,'inputaddrphonerecentcount',ran0_40);
      	Scoring_QA.Range_function_module.range_function_31(DS2,'phoneidentitiescount',ran0_41);
      	Scoring_QA.Range_function_module.range_function_31(DS2,'phoneidentitiesrecentcount',ran0_42);
				  Scoring_QA.Range_function_module.range_function_26(DS2,'aircraftcount01',ran0_43);
					Scoring_QA.Range_function_module.range_function_26(DS2,'aircraftcount03',ran0_44);
					Scoring_QA.Range_function_module.range_function_26(DS2,'aircraftcount06',ran0_45);
					Scoring_QA.Range_function_module.range_function_26(DS2,'aircraftcount12',ran0_46);
					Scoring_QA.Range_function_module.range_function_26(DS2,'aircraftcount24',ran0_47);
					Scoring_QA.Range_function_module.range_function_26(DS2,'aircraftcount60',ran0_48);
					// Scoring_QA.Range_function_module.Range_Function_0(DS2,'derogcount',ran0_49);
					// Scoring_QA.Range_function_module.Range_Function_0(DS2,'derogrecentcount',ran0_50);
					Scoring_QA.Range_function_module.range_function_40(DS2,'felonycount',ran0_51);
					Scoring_QA.Range_function_module.range_function_40(DS2,'felonycount01',ran0_52);
					Scoring_QA.Range_function_module.range_function_40(DS2,'felonycount03',ran0_53);
					Scoring_QA.Range_function_module.range_function_40(DS2,'felonycount06',ran0_54);
					Scoring_QA.Range_function_module.range_function_40(DS2,'felonycount12',ran0_55);
					Scoring_QA.Range_function_module.range_function_40(DS2,'felonycount24',ran0_56);
					Scoring_QA.Range_function_module.range_function_40(DS2,'felonycount60',ran0_57);
				  Scoring_QA.Range_function_module.range_function_40(DS2,'liencount',ran0_58);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienfiledcount',ran0_59);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienfiledcount01',ran0_60);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienfiledcount03',ran0_61);
				  Scoring_QA.Range_function_module.range_function_26(DS2,'lienfiledcount06',ran0_62);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienfiledcount12',ran0_63);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienfiledcount24',ran0_64);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienfiledcount60',ran0_65);
				  Scoring_QA.Range_function_module.Range_Function_25(DS2,'lienreleasedcount',ran0_66);
		  		Scoring_QA.Range_function_module.range_function_26(DS2,'lienreleasedcount01',ran0_67);
			  	Scoring_QA.Range_function_module.range_function_26(DS2,'lienreleasedcount03',ran0_68);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienreleasedcount06',ran0_69);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienreleasedcount12',ran0_70);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienreleasedcount24',ran0_71);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienreleasedcount60',ran0_72);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienfederaltaxfiledcount',ran0_73);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lientaxotherfiledcount',ran0_74);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienforeclosurefiledcount',ran0_75);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienlandlordtenantfiledcount',ran0_76);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienjudgmentfiledcount',ran0_77);
				  Scoring_QA.Range_function_module.range_function_26(DS2,'liensmallclaimsfiledcount',ran0_78);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienotherfiledcount',ran0_79);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienfederaltaxreleasedcount',ran0_80);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lientaxotherreleasedcount',ran0_81);
				  Scoring_QA.Range_function_module.range_function_26(DS2,'lienforeclosurereleasedcount',ran0_82);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienlandlordtenantreleasedcount',ran0_83);
					Scoring_QA.Range_function_module.range_function_26(DS2,'lienjudgmentreleasedcount',ran0_84);
					Scoring_QA.Range_function_module.range_function_26(DS2,'liensmallclaimsreleasedcount',ran0_85);
				  Scoring_QA.Range_function_module.range_function_26(DS2,'lienotherreleasedcount',ran0_86);
		  		Scoring_QA.Range_function_module.range_function_51(DS2,'bankruptcycount',ran0_87);
			    Scoring_QA.Range_function_module.range_function_51(DS2,'bankruptcycount01',ran0_88);
					Scoring_QA.Range_function_module.range_function_51(DS2,'bankruptcycount03',ran0_89);
					Scoring_QA.Range_function_module.range_function_51(DS2,'bankruptcycount06',ran0_90);
					Scoring_QA.Range_function_module.range_function_51(DS2,'bankruptcycount12',ran0_91);
				  Scoring_QA.Range_function_module.range_function_51(DS2,'bankruptcycount24',ran0_92);
					Scoring_QA.Range_function_module.range_function_51(DS2,'bankruptcycount60',ran0_93);
					Scoring_QA.Range_function_module.range_function_25(DS2,'evictioncount',ran0_94);
					Scoring_QA.Range_function_module.range_function_25(DS2,'evictioncount01',ran0_95);
					Scoring_QA.Range_function_module.range_function_25(DS2,'evictioncount03',ran0_96);
					Scoring_QA.Range_function_module.range_function_25(DS2,'evictioncount06',ran0_97);
					Scoring_QA.Range_function_module.range_function_25(DS2,'evictioncount12',ran0_98);
			    Scoring_QA.Range_function_module.range_function_25(DS2,'evictioncount24',ran0_99);
					Scoring_QA.Range_function_module.range_function_25(DS2,'evictioncount60',ran0_100);
					Scoring_QA.Range_function_module.range_function_47(DS2,'nonderogcount01',ran0_101);
				  Scoring_QA.Range_function_module.range_function_47(DS2,'nonderogcount03',ran0_102);
					Scoring_QA.Range_function_module.range_function_47(DS2,'nonderogcount06',ran0_103);
					Scoring_QA.Range_function_module.range_function_47(DS2,'nonderogcount12',ran0_104);
					Scoring_QA.Range_function_module.range_function_47(DS2,'nonderogcount24',ran0_105);
					Scoring_QA.Range_function_module.range_function_47(DS2,'nonderogcount60',ran0_106);
					// Scoring_QA.Range_function_module.Range_Function_0(DS2,'profliccount',ran0_107);
					// Scoring_QA.Range_function_module.Range_Function_0(DS2,'profliccount01',ran0_108);
			    // Scoring_QA.Range_function_module.Range_Function_0(DS2,'profliccount03',ran0_109);
					// Scoring_QA.Range_function_module.Range_Function_0(DS2,'profliccount06',ran0_110);
					Scoring_QA.Range_function_module.range_function_54(DS2,'profliccount12',ran0_111);
				  Scoring_QA.Range_function_module.range_function_54(DS2,'profliccount24',ran0_112);
					Scoring_QA.Range_function_module.range_function_54(DS2,'profliccount60',ran0_113);
					Scoring_QA.Range_function_module.range_function_40(DS2,'subprimeofferrequestcount',ran0_114);
					Scoring_QA.Range_function_module.range_function_40(DS2,'subprimeofferrequestcount01',ran0_115);
					Scoring_QA.Range_function_module.range_function_40(DS2,'subprimeofferrequestcount03',ran0_116);
					Scoring_QA.Range_function_module.range_function_40(DS2,'subprimeofferrequestcount06',ran0_117);
					Scoring_QA.Range_function_module.range_function_40(DS2,'subprimeofferrequestcount12',ran0_118);
			    Scoring_QA.Range_function_module.range_function_40(DS2,'subprimeofferrequestcount24',ran0_119);
					Scoring_QA.Range_function_module.range_function_40(DS2,'subprimeofferrequestcount60',ran0_120);
								 
							ran_0:=   ran0_1 + ran0_2  + ran0_3  + ran0_4  + ran0_5  + ran0_6  + ran0_7  + ran0_8  + ran0_9  + ran0_10 +
				               ran0_11 + ran0_12 + ran0_13 + ran0_14 + ran0_15 + ran0_16 + ran0_17 + ran0_18 + ran0_19 + ran0_20 +
						           ran0_21 + ran0_22 + ran0_23 + ran0_24 + ran0_25 + ran0_26 + ran0_27 + ran0_28 + ran0_29 + 
				               ran0_31 + ran0_32 + ran0_33 + ran0_34 + ran0_35 + ran0_36 + ran0_37 + ran0_38 + ran0_39 + ran0_40 +
				               ran0_41 + ran0_42 + ran0_43 + ran0_44 + ran0_45 + ran0_46 + ran0_47 + ran0_48  +
                       ran0_51 + ran0_52 + ran0_53 + ran0_54 + ran0_55 + ran0_56 + ran0_57 + ran0_58 + ran0_59 + ran0_60 +
                       ran0_61 + ran0_62 + ran0_63 + ran0_64 + ran0_65 + ran0_66 + ran0_67 + ran0_68 + ran0_69 + ran0_70 + 
                       ran0_71 + ran0_72 + ran0_73 + ran0_74 + ran0_75 + ran0_76 + ran0_77 + ran0_78 + ran0_79 + ran0_80 + 
                       ran0_81 + ran0_82 + ran0_83 + ran0_84 + ran0_85 + ran0_86 + ran0_87 + ran0_88 + ran0_89 + ran0_90 + 
					             ran0_91 + ran0_92 + ran0_93 + ran0_94 + ran0_95 + ran0_96 + ran0_97 + ran0_98 + ran0_99 + ran0_100 + 
				               ran0_101 + ran0_102 + ran0_103 + ran0_104 + ran0_105 + ran0_106  + 
											 ran0_111 + ran0_112 + ran0_113 + ran0_114 + ran0_115 + ran0_116 + ran0_117 + ran0_118 + ran0_119 + ran0_120;
								
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
								
								 Scoring_QA.Range_function_module.range_function_46(DS2,'srcsconfirmidaddrcount',ran2_1);
								 
								 ran_2:=ran2_1;
								 
								 	Scoring_QA.Range_function_module.Range_Function_3(DS2,'felonyage',ran3_1);
								  Scoring_QA.Range_function_module.range_function_62(DS2,'lienfiledage',ran3_2);
									Scoring_QA.Range_function_module.Range_Function_3(DS2,'lienreleasedage',ran3_3);
								  Scoring_QA.Range_function_module.Range_Function_3(DS2,'evictionage',ran3_4);
								 
								 ran_3:=ran3_1+ ran3_2  + ran3_3  + ran3_4;
								 
								 Scoring_QA.Range_function_module.range_function_53(DS2,'derogage',ran4_1);
								 Scoring_QA.Range_function_module.Range_Function_17(DS2,'bankruptcyage',ran4_2);
								 
								 ran_4:=ran4_1+ ran4_2;
				
				          Scoring_QA.Range_function_module.range_function_40(DS2,'derogcount',ran7_1);
								  Scoring_QA.Range_function_module.range_function_40(DS2,'derogrecentcount',ran7_2);
									
								 
								 ran_7:=ran7_1+ ran7_2;
								 
					Scoring_QA.Range_function_module.Distinct_function(DS2,'recentupdate',dis1);
					Scoring_QA.Range_function_module.range_function_56(DS2,'invaliddl',dis2);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verificationfailure',dis3);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnnotfound',dis4);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedname',dis5);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedssn',dis6);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedphone',dis7);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedaddress',dis8);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifieddob',dis9);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'aircraftowner',dis10);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'invaliddl',dis11);
					// Scoring_QA.Range_function_module.Distinct_function(DS2,'verificationfailure',dis12);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnrecent',dis13);
					Scoring_QA.Range_function_module.Distinct_function2(DS2,'ssnissuestate',dis14);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnnonus',dis15);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssn3years',dis16);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnafter5',dis17);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnproblems',dis18);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrhistoricalmatch',dis19);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrdwelltype',dis20);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrdelivery',dis21);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrapplicantowned',dis22);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrfamilyowned',dis23);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddroccupantowned',dis24);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrmortgagetype',dis25);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrnotprimaryres',dis26);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddractivephonelist',dis27);
					Scoring_QA.Range_function_module.range_function_34(DS2,'inputaddrtaxyr',dis28);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddrdwelltype',dis29);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddrapplicantowned',dis30);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddrfamilyowned',dis31);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddroccupantowned',dis32);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddrmortgagetype',dis33);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddractivephonelist',dis34);
					Scoring_QA.Range_function_module.range_function_34(DS2,'curraddrtaxyr',dis35);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddrdwelltype',dis36);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddrapplicantowned',dis37);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddrfamilyowned',dis38);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddroccupantowned',dis39);
					Scoring_QA.Range_function_module.range_function_34(DS2,'prevaddrtaxyr',dis40);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'addrmostrecentstatediff',dis41);
					Scoring_QA.Range_function_module.Distinct_function4(DS2,'addrrecentecontrajectory',dis42);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'addrrecentecontrajectoryindex',dis43);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationattendedcollege',dis44);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationprogram2yr',dis45);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationprogram4yr',dis46);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationprogramgraduate',dis47);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationinstitutionprivate',dis48);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationfieldofstudytype',dis49);
					Scoring_QA.Range_function_module.range_function_55(DS2,'educationinstitutionrating',dis50);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'statusmostrecent',dis51);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'statusprevious',dis52);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'statusnextprevious',dis53);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'propertyowner',dis54);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'assetowner',dis55);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'watercraftowner',dis56);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'wealthindex',dis57);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'businessactiveassociation',dis58);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'businessinactiveassociation',dis59);
				  Scoring_QA.Range_function_module.Distinct_function4(DS2,'businesstitle',dis60);
					Scoring_QA.Range_function_module.range_function_55(DS2,'derogseverityindex',dis61);
					Scoring_QA.Range_function_module.Distinct_function5(DS2,'bankruptcytype',dis62);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'bankruptcystatus',dis63);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'recentactivityindex',dis64);
					Scoring_QA.Range_function_module.range_function_56(DS2,'voterregistrationrecord',dis65);
					Scoring_QA.Range_function_module.range_function_54(DS2,'proflictype',dis66);
					Scoring_QA.Range_function_module.range_function_55(DS2,'proflictypecategory',dis67);
					Scoring_QA.Range_function_module.range_function_56(DS2,'proflicexpired',dis68);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inquirycollectionsrecent',dis69);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inquirypersonalfinancerecent',dis70);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inquiryotherrecent',dis71);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'highriskcreditactivity',dis72);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputphonemobile',dis73);	
					Scoring_QA.Range_function_module.range_function_56(DS2,'inputphonehighrisk',dis74);
					Scoring_QA.Range_function_module.range_function_55(DS2,'inputphoneproblems',dis75);
					Scoring_QA.Range_function_module.range_function_56(DS2,'emailaddress',dis76);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrhighrisk',dis77);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddrcorrectional',dis78);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddrcorrectional',dis79);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'historicaladdrcorrectional',dis80);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrproblems',dis81);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'securityfreeze',dis82);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'securityalert',dis83);	
					Scoring_QA.Range_function_module.Distinct_function(DS2,'idtheftflag',dis84);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'consumerstatement',dis85);
					Scoring_QA.Range_function_module.range_function_56(DS2,'prescreenoptout',dis86);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'historydate',dis87);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'fnamepop',dis88);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'lnamepop',dis89);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'addrpop',dis90);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnlength',dis91);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'dobpop',dis92);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'emailpop',dis93);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ipaddrpop',dis94);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'hphnpop',dis95);
					Scoring_QA.Range_function_module.range_function_44(DS2,'errorcode',dis96);
				
					dis:= dis1  + dis2  + dis3  + dis4  + dis5  + dis6  + dis7  + dis8  + dis9  + dis10 +
				         dis13 + dis14 + dis15 + dis16 + dis17 + dis18 + dis19 + dis20 +
						    dis21 + dis22 + dis23 + dis24 + dis25 + dis26 + dis27 + dis28 + dis29 + dis30 +
				        dis31 + dis32 + dis33 + dis34 + dis35 + dis36 + dis37 + dis38 + dis39 + dis40 +
				        dis41 + dis42 + dis43 + dis44 + dis45 + dis46 + dis47 + dis48 + dis49 + dis50 +
						    dis51 + dis52 + dis53 + dis54 + dis55 + dis56 + dis57 + dis58 + dis59 + dis60 +
                dis61 + dis62 + dis63 + dis64 + dis65 + dis66 + dis67 + dis68 + dis69 + dis70 + 
                dis71 + dis72 + dis73 + dis74 + dis75 + dis76 + dis77 + dis78 + dis79 + dis80 + 
                dis81 + dis82 + dis83 + dis84 + dis85 + dis86  + dis87 + dis88 + dis89 + dis90 + 
					      dis91 + dis92 + dis93 + dis94 + dis95 + dis96 ;


							 Scoring_QA.Range_function_module.Length_Function(DS2,'did',len1);
							
      len:=len1;
			
				 Scoring_QA.Range_function_module.Distinct_function7(DS2,'did',did1);
	 
	 
	 did_stats:=did1;
	 
			result2_stats:= ran + dis + ran_0 + ran_1 +ran_2 + ran_3 + ran_4 + ran_7 + did_stats;
   				

      	  
					
				Scoring_QA.Range_function_module.Average_func(DS2,'ageoldestrecord',ave1);
      	Scoring_QA.Range_function_module.Average_func(DS2,'agenewestrecord',ave2);
      	Scoring_QA.Range_function_module.Average_func(DS2,'ssnagedeceased',ave3);
				Scoring_QA.Range_function_module.Average_func(DS2,'ssnlowissueage',ave4);
      	Scoring_QA.Range_function_module.Average_func(DS2,'ssnhighissueage',ave5);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrageoldestrecord',ave6);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputaddragenewestrecord',ave7);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrlenofres',ave8);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddragelastsale',ave9);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrlastsalesprice',ave10);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrtaxvalue',ave11);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrtaxmarketvalue',ave12);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputaddravmvalue',ave13);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddravmvalue12',ave14);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputaddravmvalue60',ave15);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddrageoldestrecord',ave16);
      	Scoring_QA.Range_function_module.Average_func(DS2,'curraddragenewestrecord',ave17);
      	Scoring_QA.Range_function_module.Average_func(DS2,'curraddrlenofres',ave18);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddragelastsale',ave19);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddrlastsalesprice',ave20);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddrtaxvalue',ave21);
      	Scoring_QA.Range_function_module.Average_func(DS2,'curraddrtaxmarketvalue',ave22);
      	Scoring_QA.Range_function_module.Average_func(DS2,'curraddravmvalue',ave23);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddravmvalue12',ave24);
      	Scoring_QA.Range_function_module.Average_func(DS2,'curraddravmvalue60',ave25);
				Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledtotal',ave26);
      	Scoring_QA.Range_function_module.Average_func(DS2,'lienfederaltaxfiledtotal',ave27);
      	Scoring_QA.Range_function_module.Average_func(DS2,'lientaxotherfiledtotal',ave28);
				Scoring_QA.Range_function_module.Average_func(DS2,'lienforeclosurefiledtotal',ave29);
				Scoring_QA.Range_function_module.Average_func(DS2,'lienlandlordtenantfiledtotal',ave30);
				Scoring_QA.Range_function_module.Average_func(DS2,'lienjudgmentfiledtotal',ave31);
      	Scoring_QA.Range_function_module.Average_func(DS2,'liensmallclaimsfiledtotal',ave32);
      	Scoring_QA.Range_function_module.Average_func(DS2,'lienotherfiledtotal',ave33);
				Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedtotal',ave34);
      	Scoring_QA.Range_function_module.Average_func(DS2,'lienfederaltaxreleasedtotal',ave35);
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrageoldestrecord',ave36);
      	Scoring_QA.Range_function_module.Average_func(DS2,'prevaddragenewestrecord',ave37);
      	Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrlenofres',ave38);
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddragelastsale',ave39);
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrlastsalesprice',ave40);
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrtaxvalue',ave41);
      	Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrtaxmarketvalue',ave42);
      	Scoring_QA.Range_function_module.Average_func(DS2,'prevaddravmvalue',ave43);
				Scoring_QA.Range_function_module.Average_func(DS2,'addrmostrecentdistance',ave44);
				Scoring_QA.Range_function_module.Average_func(DS2,'addrmostrecentmoveage',ave45);
				Scoring_QA.Range_function_module.Average_func(DS2,'propownedtaxtotal',ave46);
				Scoring_QA.Range_function_module.Average_func(DS2,'propnewestsaleprice',ave47);
				Scoring_QA.Range_function_module.Average_func(DS2,'propageoldestpurchase',ave48);
				Scoring_QA.Range_function_module.Average_func(DS2,'propagenewestpurchase',ave49);
				Scoring_QA.Range_function_module.Average_func(DS2,'propagenewestsale',ave50);
				Scoring_QA.Range_function_module.Average_func(DS2,'lientaxotherreleasedtotal',ave51);
      	Scoring_QA.Range_function_module.Average_func(DS2,'lienforeclosurereleasedtotal',ave52);
      	Scoring_QA.Range_function_module.Average_func(DS2,'lienlandlordtenantreleasedtotal',ave53);
				Scoring_QA.Range_function_module.Average_func(DS2,'lienjudgmentreleasedtotal',ave54);
      	Scoring_QA.Range_function_module.Average_func(DS2,'liensmallclaimsreleasedtotal',ave55);
				Scoring_QA.Range_function_module.Average_func(DS2,'lienotherreleasedtotal',ave56);
				Scoring_QA.Range_function_module.Average_func(DS2,'proflicage',ave57);
				Scoring_QA.Range_function_module.Average_func(DS2,'phoneedaageoldestrecord',ave58);
				Scoring_QA.Range_function_module.Average_func(DS2,'phoneedaagenewestrecord',ave59);
      	Scoring_QA.Range_function_module.Average_func(DS2,'phoneotherageoldestrecord',ave60);
				Scoring_QA.Range_function_module.Average_func(DS2,'phoneotheragenewestrecord',ave61);
			  Scoring_QA.Range_function_module.Average_func(DS2,'businessassociationage',ave62);
				
				Scoring_QA.Range_function_module.Average_func(DS2,'derogcount',ave63);
				Scoring_QA.Range_function_module.Average_func(DS2,'derogrecentcount',ave64);
			  Scoring_QA.Range_function_module.Average_func(DS2,'derogage',ave65);
				
      	 Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount',ave66);
		  		Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount01',ave67);
			  	Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount03',ave68);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount06',ave69);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount12',ave70);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount24',ave71);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedcount60',ave72);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfederaltaxfiledcount',ave73);
					Scoring_QA.Range_function_module.Average_func(DS2,'lientaxotherfiledcount',ave74);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienforeclosurefiledcount',ave75);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienlandlordtenantfiledcount',ave76);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienjudgmentfiledcount',ave77);
				  Scoring_QA.Range_function_module.Average_func(DS2,'liensmallclaimsfiledcount',ave78);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienotherfiledcount',ave79);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfederaltaxreleasedcount',ave80);
					Scoring_QA.Range_function_module.Average_func(DS2,'lientaxotherreleasedcount',ave81);
				  Scoring_QA.Range_function_module.Average_func(DS2,'lienforeclosurereleasedcount',ave82);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienlandlordtenantreleasedcount',ave83);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienjudgmentreleasedcount',ave84);
					Scoring_QA.Range_function_module.Average_func(DS2,'liensmallclaimsreleasedcount',ave85);
				  Scoring_QA.Range_function_module.Average_func(DS2,'lienotherreleasedcount',ave86);
		  		// Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount',ave87);
			    // Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount01',ave88);
					// Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount03',ave89);
					// Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount06',ave90);
					// Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount12',ave91);
				  // Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount24',ave92);
					// Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcycount60',ave93);
					Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount',ave94);
					Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount01',ave95);
					Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount03',ave96);
					Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount06',ave97);
					Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount12',ave98);
			    Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount24',ave99);
					Scoring_QA.Range_function_module.Average_func(DS2,'evictioncount60',ave100);
					Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount01',ave101);
				  Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount03',ave102);
					Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount06',ave103);
					Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount12',ave104);
					Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount24',ave105);
					Scoring_QA.Range_function_module.Average_func(DS2,'nonderogcount60',ave106);
					Scoring_QA.Range_function_module.Average_func(DS2,'profliccount',ave107);
					Scoring_QA.Range_function_module.Average_func(DS2,'profliccount01',ave108);
			    Scoring_QA.Range_function_module.Average_func(DS2,'profliccount03',ave109);
					Scoring_QA.Range_function_module.Average_func(DS2,'profliccount06',ave110);
					Scoring_QA.Range_function_module.Average_func(DS2,'profliccount12',ave111);
				  Scoring_QA.Range_function_module.Average_func(DS2,'profliccount24',ave112);
					Scoring_QA.Range_function_module.Average_func(DS2,'profliccount60',ave113);
					Scoring_QA.Range_function_module.Average_func(DS2,'subprimeofferrequestcount',ave114);
					Scoring_QA.Range_function_module.Average_func(DS2,'subprimeofferrequestcount01',ave115);
					Scoring_QA.Range_function_module.Average_func(DS2,'subprimeofferrequestcount03',ave116);
					Scoring_QA.Range_function_module.Average_func(DS2,'subprimeofferrequestcount06',ave117);
					Scoring_QA.Range_function_module.Average_func(DS2,'subprimeofferrequestcount12',ave118);
			    Scoring_QA.Range_function_module.Average_func(DS2,'subprimeofferrequestcount24',ave119);
					Scoring_QA.Range_function_module.Average_func(DS2,'subprimeofferrequestcount60',ave120);					
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount',ave121);
				  Scoring_QA.Range_function_module.Average_func(DS2,'addrchangecount01',ave122);
					Scoring_QA.Range_function_module.Average_func(DS2,'addrchangecount03',ave123);
					Scoring_QA.Range_function_module.Average_func(DS2,'addrchangecount06',ave124);
					Scoring_QA.Range_function_module.Average_func(DS2,'addrchangecount12',ave125);
					Scoring_QA.Range_function_module.Average_func(DS2,'addrchangecount24',ave126);
					Scoring_QA.Range_function_module.Average_func(DS2,'addrchangecount60',ave127);
					Scoring_QA.Range_function_module.Average_func(DS2,'propownedcount',ave128);
			    Scoring_QA.Range_function_module.Average_func(DS2,'propownedhistoricalcount',ave129);
					Scoring_QA.Range_function_module.Average_func(DS2,'proppurchasedcount01',ave130);
					Scoring_QA.Range_function_module.Average_func(DS2,'proppurchasedcount03',ave131);
					Scoring_QA.Range_function_module.Average_func(DS2,'proppurchasedcount06',ave132);
					Scoring_QA.Range_function_module.Average_func(DS2,'proppurchasedcount12',ave133);
					Scoring_QA.Range_function_module.Average_func(DS2,'proppurchasedcount24',ave134);
					Scoring_QA.Range_function_module.Average_func(DS2,'proppurchasedcount60',ave135);
					Scoring_QA.Range_function_module.Average_func(DS2,'propsoldcount01',ave136);
					Scoring_QA.Range_function_module.Average_func(DS2,'propsoldcount03',ave137);
				  Scoring_QA.Range_function_module.Average_func(DS2,'propsoldcount06',ave138);
					Scoring_QA.Range_function_module.Average_func(DS2,'propsoldcount12',ave139);
					Scoring_QA.Range_function_module.Average_func(DS2,'propsoldcount24',ave140);
					Scoring_QA.Range_function_module.Average_func(DS2,'propsoldcount60',ave141);
				  Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount',ave142);
					Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount01',ave143);
					Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount03',ave144);
					Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount06',ave145);
				  Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount12',ave146);
		  		Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount24',ave147);
			  	Scoring_QA.Range_function_module.Average_func(DS2,'watercraftcount60',ave148);					
				Scoring_QA.Range_function_module.Average_func(DS2,'subjectssncount',ave149);
				Scoring_QA.Range_function_module.Average_func(DS2,'subjectaddrcount',ave150);
      	Scoring_QA.Range_function_module.Average_func(DS2,'subjectphonecount',ave151);
      	Scoring_QA.Range_function_module.Average_func(DS2,'subjectssnrecentcount',ave152);
				Scoring_QA.Range_function_module.Average_func(DS2,'subjectaddrrecentcount',ave153);
      	Scoring_QA.Range_function_module.Average_func(DS2,'subjectphonerecentcount',ave154);
      	Scoring_QA.Range_function_module.Average_func(DS2,'ssnidentitiescount',ave155);
				Scoring_QA.Range_function_module.Average_func(DS2,'ssnaddrcount',ave156);
      	Scoring_QA.Range_function_module.Average_func(DS2,'ssnidentitiesrecentcount',ave157);
      	Scoring_QA.Range_function_module.Average_func(DS2,'ssnaddrrecentcount',ave158);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrphonecount',ave159);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrphonerecentcount',ave160);
      	Scoring_QA.Range_function_module.Average_func(DS2,'phoneidentitiescount',ave161);
      	Scoring_QA.Range_function_module.Average_func(DS2,'phoneidentitiesrecentcount',ave162);
				  Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount01',ave163);
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount03',ave164);
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount06',ave165);
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount12',ave166);
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount24',ave167);
					Scoring_QA.Range_function_module.Average_func(DS2,'aircraftcount60',ave168);
					Scoring_QA.Range_function_module.Average_func(DS2,'felonycount',ave169);
					Scoring_QA.Range_function_module.Average_func(DS2,'felonycount01',ave170);
					Scoring_QA.Range_function_module.Average_func(DS2,'felonycount03',ave171);
					Scoring_QA.Range_function_module.Average_func(DS2,'felonycount06',ave172);
					Scoring_QA.Range_function_module.Average_func(DS2,'felonycount12',ave173);
					Scoring_QA.Range_function_module.Average_func(DS2,'felonycount24',ave174);
					Scoring_QA.Range_function_module.Average_func(DS2,'felonycount60',ave175);
				  Scoring_QA.Range_function_module.Average_func(DS2,'liencount',ave176);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount',ave177);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount01',ave178);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount03',ave179);
				  Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount06',ave180);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount12',ave181);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount24',ave182);
					Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledcount60',ave183);
					
					Scoring_QA.Range_function_module.Average_func(DS2,'srcsconfirmidaddrcount',ave184);
									Scoring_QA.Range_function_module.Average_func(DS2,'felonyage',ave185);
								  Scoring_QA.Range_function_module.Average_func(DS2,'lienfiledage',ave186);
									Scoring_QA.Range_function_module.Average_func(DS2,'lienreleasedage',ave187);
								  Scoring_QA.Range_function_module.Average_func(DS2,'evictionage',ave188);
								  Scoring_QA.Range_function_module.Average_func(DS2,'bankruptcyage',ave189);
									Scoring_QA.Range_function_module.Average_func(DS2,'bestreportedage',ave190);
									Scoring_QA.Range_function_module.Average_func(DS2,'inferredminimumage',ave191);
									
									Scoring_QA.Range_function_module.Average_func(DS2,'inquiryotherrecent',ave192);
									Scoring_QA.Range_function_module.Average_func(DS2,'inquirycollectionsrecent',ave193);
									Scoring_QA.Range_function_module.Average_func(DS2,'inquirypersonalfinancerecent',ave194);
				
      	avearage:= ave1  + ave2  + ave3  + ave4  + ave5  + ave6  + ave7  + ave8  + ave9  + ave10 +
				           ave11 + ave12 + ave13 + ave14 + ave15 + ave16 + ave17 + ave18 + ave19 + ave20 +
						       ave21 + ave22 + ave23 + ave24 + ave25 + ave26 + ave27 + ave28 + ave29 + ave30 +
				           ave31 + ave32 + ave33 + ave34 + ave35 + ave36 + ave37 + ave38 + ave39 + ave40 +
				           ave41 + ave42 + ave43 + ave44 + ave45 + ave46 + ave47 + ave48 + ave49 + ave50 +
									 ave51 + ave52 + ave53 + ave54 + ave55 + ave56 + ave57 + ave58 + ave59 + ave60 +
                   ave61 + ave62 + ave63 + ave64 + ave65 + ave66 + ave67 + ave68 + ave69 + ave70 + 
                   ave71 + ave72 + ave73 + ave74 + ave75 + ave76 + ave77 + ave78 + ave79 + ave80 + 
                   ave81 + ave82 + ave83 + ave84 + ave85 + ave86 + ave94 + ave95 + ave96 + ave97 + ave98 + ave99 + ave100 + 
				           ave101 + ave102 + ave103 + ave104 + ave105 + ave106 + ave107 + ave108 + ave109 + ave110 + 
									 ave111 + ave112 + ave113 + ave114 + ave115 + ave116 + ave117 + ave118 + ave119 + ave120 +
									 ave121 + ave122 + ave123 + ave124 + ave125 + ave126 + ave127 + ave128 + ave129 + ave130 +
				           ave131 + ave132 + ave133 + ave134 + ave135 + ave136 + ave137 + ave138 + ave139 + ave140 +
				           ave141 + ave142 + ave143 + ave144 + ave145 + ave146 + ave147 + ave148 + ave149 + ave150 +
                   ave151 + ave152 + ave153 + ave154 + ave155 + ave156 + ave157 + ave158 + ave159 + ave160 +
                   ave161 + ave162 + ave163 + ave164 + ave165 + ave166 + ave167 + ave168 + ave169 + ave170 + 
                   ave171 + ave172 + ave173 + ave174 + ave175 + ave176 + ave177 + ave178 + ave179 + ave180 + 
									 ave181 + ave182 + ave183 + ave184 + ave185 + ave186 + ave187 + ave188 + ave189 + ave190  + ave191 +
									 ave192 + ave193  + ave194;
					
					
								 Scoring_QA.Range_function_module.Range_Average_Function_0(DS1,'addrmostrecenttaxdiff',ranav0_1);
											 
											 ranav0:=ranav0_1;	
											 
									Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'addrmostrecenttaxdiff',ranave0_1);
											 
											 ranave0:=ranave0_1;				 
	

   result4_stats:=avearage + ranave0;
	 
	 
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