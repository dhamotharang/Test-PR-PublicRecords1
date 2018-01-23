EXPORT FCRA_RiskView_xml_Experian_attributes_v3(route,current_dt,previous_dt) := functionmacro


file1_2:= dataset(route + scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_XML_Experian_outfile + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Experian_Attributes_V3_Global_Layout,

thor);
file2_2:= dataset(route + scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_XML_Experian_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Experian_Attributes_V3_Global_Layout,

thor);
 	   file1 := file1_2(errorcode='');
file2 := file2_2(errorcode='');

aa1:=join(file1,file2,left.accountnumber=right.accountnumber,inner);

aa:=aa1(accountnumber<>'');

DS1:=join(file1,aa,left.accountnumber=right.accountnumber,inner);

DS2:=join(file2,aa,left.accountnumber=right.accountnumber,inner);

  
/*    	  		pfc := count(ds1);
      cfc := count(ds2);
   	 
      fcd :=cfc-pfc;
   pf:=count(Missing_values);
   cf:=count(Missing_values);
   
   pd:=if(pfc!= 0 and cfc=0,1,cf/cfc);
   abd:=abs(pd);
   ppd:=if(pfc!= 0 and cfc=0,1,(cf/cfc)*100);
   	 
   	 
   
      	  	
*/

      	Scoring_QA.Range_function_module.range_function_215(DS2,'ageoldestrecord',ran1);
      	Scoring_QA.Range_function_module.range_function_71(DS2,'agenewestrecord',ran2);
				Scoring_QA.Range_function_module.Range_func(DS2,'iaageoldestrecord',ran3);
      	Scoring_QA.Range_function_module.range_function_71(DS2,'iaagenewestrecord',ran4);
      	Scoring_QA.Range_function_module.range_function_224(DS2,'ialenofres',ran5);
				Scoring_QA.Range_function_module.Range_Function_163(DS2,'iaagelastsale',ran6);
				Scoring_QA.Range_function_module.range_function_219(DS2,'caageoldestrecord',ran7);
      	Scoring_QA.Range_function_module.range_function_25(DS2,'caagenewestrecord',ran8);
				Scoring_QA.Range_function_module.range_function_221(DS2,'calenofres',ran9);
				Scoring_QA.Range_function_module.Range_func(DS2,'paageoldestrecord',ran10);
      	Scoring_QA.Range_function_module.range_function_232(DS2,'paagenewestrecord',ran11);
				Scoring_QA.Range_function_module.range_function_233(DS2,'palenofres',ran12);
				Scoring_QA.Range_function_module.range_function_227(DS2,'paagelastsale',ran13);
				Scoring_QA.Range_function_module.range_function_218(DS2,'caagelastsale',ran14);
				Scoring_QA.Range_function_module.range_function_225(DS2,'distinputcurr',ran15);
				Scoring_QA.Range_function_module.range_function_237(DS2,'propageoldestpurchase',ran16);
      	Scoring_QA.Range_function_module.range_function_237(DS2,'propagenewestpurchase',ran17);
				// Scoring_QA.Range_function_module.Range_func(DS2,'derogage',ran18);
				// Scoring_QA.Range_function_module.Range_func(DS2,'felonyage',ran19);
				// Scoring_QA.Range_function_module.Range_func(DS2,'lienfiledage',ran20);
				// Scoring_QA.Range_function_module.Range_func(DS2,'evictionage',ran21);
				Scoring_QA.Range_function_module.range_function_236(DS2,'proflicage',ran22);
				Scoring_QA.Range_function_module.range_function_228(DS2,'inferredminimumage',ran23);
				Scoring_QA.Range_function_module.range_function_217(DS2,'bestreportedage',ran24);
				Scoring_QA.Range_function_module.range_function_234(DS2,'phoneedaageoldestrecord',ran25);
				Scoring_QA.Range_function_module.range_function_218(DS2,'phoneedaagenewestrecord',ran26);
      	Scoring_QA.Range_function_module.range_function_149(DS2,'phoneotherageoldestrecord',ran27);
      	Scoring_QA.Range_function_module.range_function_111(DS2,'phoneotheragenewestrecord',ran28);
				Scoring_QA.Range_function_module.range_function_220(DS2,'caassessedvalue',ran29);
				Scoring_QA.Range_function_module.range_function_220(DS2,'iaassessedvalue',ran30);
				Scoring_QA.Range_function_module.range_function_35(DS2,'lienfederaltaxfiledtotal',ran31);
		
      	
      	
      	ran:= ran1  + ran2  + ran3  + ran4  + ran5  + ran6  + ran7  + ran8  + ran9  + ran10 +
				      ran11 + ran12 + ran13 + ran14 + ran15 + ran16 + ran17 + 
							ran22 + ran23 + ran24 + ran25 + ran26 + ran27 + ran28 + ran29 + ran30 +
							ran31;
				
				  Scoring_QA.Range_function_module.Range_Function_25(DS2,'subjectssncount',ran0_1);
					Scoring_QA.Range_function_module.range_function_239(DS2,'subjectaddrcount',ran0_2);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'subjectphonecount',ran0_3);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'subjectssnrecentcount',ran0_4);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'subjectaddrrecentcount',ran0_5);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'subjectphonerecentcount',ran0_6);
					Scoring_QA.Range_function_module.Range_Function_0(DS2,'ssnidentitiescount',ran0_7);
					Scoring_QA.Range_function_module.range_function_238(DS2,'ssnaddrcount',ran0_8);
			    Scoring_QA.Range_function_module.Range_Function_31(DS2,'ssnidentitiesrecentcount',ran0_9);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'ssnaddrrecentcount',ran0_10);
					Scoring_QA.Range_function_module.range_function_230(DS2,'inputaddridentitiescount',ran0_11);
					Scoring_QA.Range_function_module.range_function_138(DS2,'inputaddrssncount',ran0_12);
					Scoring_QA.Range_function_module.range_function_25(DS2,'inputaddrphonecount',ran0_13);
					Scoring_QA.Range_function_module.range_function_25(DS2,'inputaddridentitiesrecentcount',ran0_14);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'inputaddrssnrecentcount',ran0_15);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'inputaddrphonerecentcount',ran0_16);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'phoneidentitiescount',ran0_17);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'phoneidentitiesrecentcount',ran0_18);
					Scoring_QA.Range_function_module.range_function_229(DS2,'inputaddravmconfidence',ran0_19);
					Scoring_QA.Range_function_module.range_function_222(DS2,'curraddravmconfidence',ran0_20);
					Scoring_QA.Range_function_module.range_function_235(DS2,'prevaddravmconfidence',ran0_21);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'subprimesolicitedcount',ran0_22);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'subprimesolicitedcount01',ran0_23);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'subprimesolicitedcount03',ran0_24);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'subprimesolicitedcount06',ran0_25);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'subprimesolicitedcount12',ran0_26);
		  		Scoring_QA.Range_function_module.Range_Function_31(DS2,'subprimesolicitedcount24',ran0_27);
			  	Scoring_QA.Range_function_module.Range_Function_31(DS2,'subprimesolicitedcount36',ran0_28);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'subprimesolicitedcount60',ran0_29);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'lienfederaltaxfiledcount',ran0_30);
      	  Scoring_QA.Range_function_module.Range_Function_25(DS2,'lientaxotherfiledcount',ran0_31);
      	  Scoring_QA.Range_function_module.Range_Function_31(DS2,'lienforeclosurefiledcount',ran0_32);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'lienpreforeclosurefiledcount',ran0_33);
      	  Scoring_QA.Range_function_module.Range_Function_31(DS2,'lienlandlordtenantfiledcount',ran0_34);
      	  Scoring_QA.Range_function_module.Range_Function_31(DS2,'lienjudgmentfiledcount',ran0_35);
				  Scoring_QA.Range_function_module.Range_Function_25(DS2,'liensmallclaimsfiledcount',ran0_36);
      	  Scoring_QA.Range_function_module.Range_Function_31(DS2,'lienotherfiledcount',ran0_37);
      	  Scoring_QA.Range_function_module.Range_Function_31(DS2,'lienfederaltaxreleasedcount',ran0_38);
			    Scoring_QA.Range_function_module.Range_Function_31(DS2,'lientaxotherreleasedcount',ran0_39);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'lienforeclosurereleasedcount',ran0_40);
      	  Scoring_QA.Range_function_module.Range_Function_31(DS2,'lienpreforeclosurereleasedcount',ran0_41);
      	  Scoring_QA.Range_function_module.Range_Function_31(DS2,'lienlandlordtenantreleasedcount',ran0_42);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'lienjudgmentreleasedcount',ran0_43);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'liensmallclaimsreleasedcount',ran0_44);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'lienotherreleasedcount',ran0_45);
					Scoring_QA.Range_function_module.range_function_25(DS2,'bankruptcy_count',ran0_46);
					Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcy_count30',ran0_47);
					Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcy_count90',ran0_48);
					Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcy_count180',ran0_49);
					Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcy_count12',ran0_50);
					Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcy_count24',ran0_51);
					Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcy_count36',ran0_52);
					Scoring_QA.Range_function_module.range_function_31(DS2,'bankruptcy_count60',ran0_53);
					Scoring_QA.Range_function_module.range_function_51(DS2,'eviction_count',ran0_54);
					Scoring_QA.Range_function_module.range_function_31(DS2,'eviction_count30',ran0_55);
					Scoring_QA.Range_function_module.range_function_31(DS2,'eviction_count90',ran0_56);
					Scoring_QA.Range_function_module.range_function_31(DS2,'eviction_count180',ran0_57);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'eviction_count12',ran0_58);
					Scoring_QA.Range_function_module.range_function_31(DS2,'eviction_count24',ran0_59);
					Scoring_QA.Range_function_module.range_function_31(DS2,'eviction_count36',ran0_60);
					Scoring_QA.Range_function_module.range_function_31(DS2,'eviction_count60',ran0_61);

								 
							ran_0:=   ran0_1 + ran0_2  + ran0_3  + ran0_4  + ran0_5  + ran0_6  + ran0_7  + ran0_8  + ran0_9  + ran0_10 +
				               ran0_11 + ran0_12 + ran0_13 + ran0_14 + ran0_15 + ran0_16 + ran0_17 + ran0_18 + ran0_19 + ran0_20 +
						           ran0_21 + ran0_22 + ran0_23 + ran0_24 + ran0_25 + ran0_26 + ran0_27 + ran0_28 + ran0_29 + ran0_30 +
				               ran0_31 + ran0_32 + ran0_33 + ran0_34 + ran0_35 + ran0_36 + ran0_37 + ran0_38 + ran0_39 + ran0_40 +
				               ran0_41 + ran0_42 + ran0_43 + ran0_44 + ran0_45 + ran0_46 + ran0_47 + ran0_48 + ran0_49 + ran0_50 +
                       ran0_51 + ran0_52 + ran0_53 + ran0_54 + ran0_55 + ran0_56 + ran0_57 + ran0_58 + ran0_59 + ran0_60 +
                       ran0_61;
								
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
								
								
								 
								 	Scoring_QA.Range_function_module.Range_Function_3(DS2,'felonyage',ran3_1);
								  Scoring_QA.Range_function_module.range_function_231(DS2,'lienfiledage',ran3_2);
									Scoring_QA.Range_function_module.Range_Function_31(DS2,'lienreleasedage',ran3_3);
								  Scoring_QA.Range_function_module.range_function_224(DS2,'evictionage',ran3_4);
								 
								 ran_3:=ran3_1+ ran3_2  + ran3_3  + ran3_4;
								 
								 Scoring_QA.Range_function_module.range_function_224(DS2,'derogage',ran4_1);
								 Scoring_QA.Range_function_module.range_function_216(DS2,'bankruptcyage',ran4_2);
								 
								 ran_4:=ran4_1+ ran4_2;
				
					Scoring_QA.Range_function_module.Distinct_function(DS2,'isrecentupdate',dis1);
					Scoring_QA.Range_function_module.range_function_47(DS2,'numsources',dis2);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedphonefullname',dis3);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedphonelastname',dis4);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'invalidssn',dis5);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'invalidphone',dis6);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'invalidaddr',dis7);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'invaliddl',dis8);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'isnover',dis9);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'ssndeceased',dis10);
					Scoring_QA.Range_function_module.range_function_245(DS2,'deceaseddate',dis11);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnvalid',dis12);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'recentissue',dis13);
					Scoring_QA.Range_function_module.range_function_226(DS2,'lowissuedate',dis14);
					Scoring_QA.Range_function_module.range_function_226(DS2,'highissuedate',dis15);
					Scoring_QA.Range_function_module.range_function_116(DS2,'issuestate',dis16);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'nonus',dis17);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'issued3',dis18);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'issuedage5',dis19);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'iadwelltype',dis20);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ialandusecode',dis21);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'iaownedbysubject',dis22);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'iafamilyowned',dis23);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'iaoccupantowned',dis24);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ianotprimaryres',dis25);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'iaphonelisted',dis26);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'cadwelltype',dis27);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'calandusecode',dis28);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'caownedbysubject',dis29);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'cafamilyowned',dis30);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'caoccupantowned',dis31);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'canotprimaryres',dis32);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'caphonelisted',dis33);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'padwelltype',dis34);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'palandusecode',dis35);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'paownedbysubject',dis36);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'pafamilyowned',dis37);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'paoccupantowned',dis38);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'paphonelisted',dis39);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputcurrmatch',dis40);
					Scoring_QA.Range_function_module.Distinct_function5(DS2,'diffstate',dis41);
					Scoring_QA.Range_function_module.range_function_246(DS2,'ecotrajectory',dis42);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputprevmatch',dis43);
					Scoring_QA.Range_function_module.Distinct_function5(DS2,'diffstate2',dis44);
					Scoring_QA.Range_function_module.range_function_246(DS2,'ecotrajectory2',dis45);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'mobility_indicator',dis46);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'statusaddr',dis47);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'statusaddr2',dis48);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'statusaddr3',dis49);
					Scoring_QA.Range_function_module.range_function_31(DS2,'addrchanges30',dis50);
					Scoring_QA.Range_function_module.range_function_31(DS2,'addrchanges90',dis51);
					Scoring_QA.Range_function_module.range_function_25(DS2,'addrchanges180',dis52);
					Scoring_QA.Range_function_module.range_function_25(DS2,'addrchanges12',dis53);
					Scoring_QA.Range_function_module.range_function_51(DS2,'addrchanges24',dis54);
					Scoring_QA.Range_function_module.range_function_47(DS2,'addrchanges36',dis55);
					Scoring_QA.Range_function_module.range_function_43(DS2,'addrchanges60',dis56);
					Scoring_QA.Range_function_module.range_function_25(DS2,'property_owned_total',dis57);
					Scoring_QA.Range_function_module.range_function_25(DS2,'property_historically_owned',dis58);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numpurchase30',dis59);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'numpurchase90',dis60);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numpurchase180',dis61);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numpurchase12',dis62);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numpurchase24',dis63);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numpurchase36',dis64);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numpurchase60',dis65);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numsold30',dis66);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numsold90',dis67);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numsold180',dis68);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numsold12',dis69);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numsold24',dis70);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numsold36',dis71);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numsold60',dis72);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numwatercraft',dis73);	
					Scoring_QA.Range_function_module.range_function_31(DS2,'numwatercraft30',dis74);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numwatercraft90',dis75);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numwatercraft180',dis76);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numwatercraft12',dis77);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numwatercraft24',dis78);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numwatercraft36',dis79);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'numwatercraft60',dis80);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numaircraft',dis81);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'numaircraft30',dis82);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'numaircraft90',dis83);	
					Scoring_QA.Range_function_module.range_function_31(DS2,'numaircraft180',dis84);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numaircraft12',dis85);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numaircraft24',dis86);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numaircraft36',dis87);
					Scoring_QA.Range_function_module.range_function_31(DS2,'numaircraft60',dis88);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'wealth_indicator',dis89);
				  Scoring_QA.Range_function_module.range_function_51(DS2,'total_number_derogs',dis90);
					Scoring_QA.Range_function_module.range_function_31(DS2,'felonies',dis91);
					Scoring_QA.Range_function_module.range_function_31(DS2,'felonies30',dis92);
					Scoring_QA.Range_function_module.range_function_31(DS2,'felonies90',dis93);
					Scoring_QA.Range_function_module.range_function_31(DS2,'felonies180',dis94);
					Scoring_QA.Range_function_module.range_function_31(DS2,'felonies12',dis95);
					Scoring_QA.Range_function_module.range_function_31(DS2,'felonies24',dis96);
					Scoring_QA.Range_function_module.range_function_31(DS2,'felonies36',dis97);
					Scoring_QA.Range_function_module.range_function_31(DS2,'felonies60',dis98);
					Scoring_QA.Range_function_module.range_function_51(DS2,'num_liens',dis99);
				  Scoring_QA.Range_function_module.range_function_51(DS2,'num_unreleased_liens',dis100);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_unreleased_liens30',dis101);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_unreleased_liens90',dis102);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_unreleased_liens180',dis103);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_unreleased_liens12',dis104);
					Scoring_QA.Range_function_module.range_function_25(DS2,'num_unreleased_liens24',dis105);
					Scoring_QA.Range_function_module.range_function_25(DS2,'num_unreleased_liens36',dis106);
					Scoring_QA.Range_function_module.range_function_51(DS2,'num_unreleased_liens60',dis107);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_released_liens',dis108);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_released_liens30',dis109);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'num_released_liens90',dis110);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_released_liens180',dis111);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_released_liens12',dis112);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_released_liens24',dis113);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_released_liens36',dis114);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_released_liens60',dis115);	
					Scoring_QA.Range_function_module.Distinct_function(DS2,'filing_type',dis116);
					Scoring_QA.Range_function_module.range_function_25(DS2,'num_nonderogs180',dis117);
					Scoring_QA.Range_function_module.range_function_51(DS2,'num_nonderogs12',dis118);
					Scoring_QA.Range_function_module.range_function_51(DS2,'num_nonderogs24',dis119);
				  Scoring_QA.Range_function_module.range_function_51(DS2,'num_nonderogs36',dis120);
					Scoring_QA.Range_function_module.range_function_51(DS2,'num_nonderogs60',dis121);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic',dis122);
					Scoring_QA.Range_function_module.range_function_119(DS2,'proflic_type',dis123);
					Scoring_QA.Range_function_module.range_function_245(DS2,'expire_date_last_proflic',dis124);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic30',dis125);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic90',dis126);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic180',dis127);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic12',dis128);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic24',dis129);
				  Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic36',dis130);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic60',dis131);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic_exp30',dis132);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic_exp90',dis133);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic_exp180',dis134);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic_exp12',dis135);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic_exp24',dis136);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic_exp36',dis137);
					Scoring_QA.Range_function_module.range_function_31(DS2,'num_proflic_exp60',dis138);
					Scoring_QA.Range_function_module.range_function_31(DS2,'addrhighrisk',dis139);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'phonehighrisk',dis140);
					Scoring_QA.Range_function_module.range_function_31(DS2,'addrprison',dis141);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'zippobox',dis142);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'zipcorpmil',dis143);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'phonestatus',dis144);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'phonepager',dis145);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'phonemobile',dis146);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'phonezipmismatch',dis147);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'phoneaddrdist',dis148);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'correctedflag',dis149);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'securityfreeze',dis150);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'securityalert',dis151);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'idtheftflag',dis152);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnnotfound',dis153);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedname',dis154);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedssn',dis155);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedphone',dis156);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifiedaddress',dis157);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'verifieddob',dis158);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnissuedpriordob',dis159);
				  Scoring_QA.Range_function_module.range_function_223(DS2,'inputaddrtaxyr',dis160);
					Scoring_QA.Range_function_module.range_function_223(DS2,'prevaddrtaxyr',dis161);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationattendedcollege',dis162);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationprogram2yr',dis163);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationprogram4yr',dis164);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationprogramgraduate',dis165);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationinstitutionprivate',dis166);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'educationinstitutionrating',dis167);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'proflictypecategory',dis168);
					Scoring_QA.Range_function_module.range_function_223(DS2,'curraddrtaxyr',dis169);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'prescreenoptout',dis170);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'history_date',dis171);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'errorcode',dis172);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'disposition',dis173);
					Scoring_QA.Range_function_module.range_function_47(DS2,'num_nonderogs',dis174);
					Scoring_QA.Range_function_module.range_function_25(DS2,'num_nonderogs30',dis175);
					Scoring_QA.Range_function_module.range_function_25(DS2,'num_nonderogs90',dis176);
					
					 Scoring_QA.Range_function_module.Distinct_function(DS2,'fnamepop',dis177);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'lnamepop',dis178);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'addrpop',dis179);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnlength',dis180);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'dobpop',dis181);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'emailpop',dis182);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ipaddrpop',dis183);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'hphnpop',dis184);
				
					dis:= dis1  + dis2  + dis3  + dis4  + dis5  + dis6  + dis7  + dis8  + dis9  + dis10 +
				        dis11 + dis12 + dis13 + dis14 + dis15 + dis16 + dis17 + dis18 + dis19 + dis20 +
						    dis21 + dis22 + dis23 + dis24 + dis25 + dis26 + dis27 + dis28 + dis29 + dis30 +
				        dis31 + dis32 + dis33 + dis34 + dis35 + dis36 + dis37 + dis38 + dis39 + dis40 +
				        dis41 + dis42 + dis43 + dis44 + dis45 + dis46 + dis47 + dis48 + dis49 + dis50 +
						    dis51 + dis52 + dis53 + dis54 + dis55 + dis56 + dis57 + dis58 + dis59 + dis60 +
                dis61 + dis62 + dis63 + dis64 + dis65 + dis66 + dis67 + dis68 + dis69 + dis70 + 
                dis71 + dis72 + dis73 + dis74 + dis75 + dis76 + dis77 + dis78 + dis79 + dis80 + 
                dis81 + dis82 + dis83 + dis84 + dis85 + dis86 + dis87 + dis88 + dis89 + dis90 + 
					      dis91 + dis92 + dis93 + dis94 + dis95 + dis96 + dis97 + dis98 + dis99 + dis100+ 
				       dis101 + dis102 + dis103 + dis104 + dis105 + dis106 + dis107 + dis108 + dis109 + dis110+ 
						   dis111 + dis112 + dis113 + dis114 + dis115 + dis116 + dis117 + dis118 + dis119 + dis120+ 
				  	   dis121 + dis122 + dis123 + dis124 + dis125 + dis126 + dis127 + dis128 + dis129 + dis130+
						   dis131 + dis132 + dis133 + dis134 + dis135 + dis136 + dis137 + dis138 + dis139 + dis140+
					     dis141 + dis142 + dis143 + dis144 + dis145 + dis146 + dis147 + dis148 + dis149 + dis150+							
						   dis151 + dis152 + dis153 + dis154 + dis155 + dis156 + dis157 + dis158 + dis159 + dis160+
					     dis161 + dis162 + dis163 + dis164 + dis165 + dis166 + dis167 + dis168 + dis169 + dis170+							
						   dis171 + dis172 + dis173 + dis174 + dis175 + dis176 + dis177 + dis178 + dis179 + dis180+
									 dis181 +  dis182 + dis183 + dis184 ;
    

          	Scoring_QA.Range_function_module.Length_Function(DS2,'iaphonenumber',len1);
						Scoring_QA.Range_function_module.Length_Function(DS2,'caphonenumber',len2);
						Scoring_QA.Range_function_module.Length_Function(DS2,'paphonenumber',len3);
						
			len:=len1 + len2 + len3;

				
			result2_stats:= ran + dis + ran_0 + ran_1 + ran_3 + ran_4 + len;
   				
      
      	  
					
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'iaassessedvalue',ave1);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'ialastsaleamount',ave2);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'caassessedvalue',ave3);
		// Scoring_QA.Range_function_module.Average_func(DS2,'caagelastsale',ave4);
      	Scoring_QA.Range_function_module.Average_Function_3(DS2,'calastsaleamount',ave5);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'paassessedvalue',ave6);
		  	Scoring_QA.Range_function_module.Average_Function_3(DS2,'palastsaleamount',ave7);
		  	Scoring_QA.Range_function_module.Average_Function_4(DS2,'assesseddiff',ave8);
			 	Scoring_QA.Range_function_module.Average_Function_4(DS2,'distcurrprev',ave9);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'assesseddiff2',ave10);
		   	Scoring_QA.Range_function_module.Average_Function_3(DS2,'property_owned_assessed_total',ave11);
			 	Scoring_QA.Range_function_module.Average_Function_3(DS2,'propagenewestsale',ave12);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddrtaxmarketvalue',ave13);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddravmtax',ave14);
      	Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddravmsalesprice',ave15);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddravmhedonic',ave16);
      	Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddravmvalue',ave17);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'curraddrtaxmarketvalue',ave18);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'curraddravmtax',ave19);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'curraddravmsalesprice',ave20);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'curraddravmhedonic',ave21);
      	Scoring_QA.Range_function_module.Average_Function_3(DS2,'curraddravmvalue',ave22);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'prevaddrtaxmarketvalue',ave23);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'prevaddravmtax',ave24);
      	Scoring_QA.Range_function_module.Average_Function_3(DS2,'prevaddravmsalesprice',ave25);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'prevaddravmhedonic',ave26);
      	Scoring_QA.Range_function_module.Average_Function_3(DS2,'prevaddravmvalue',ave27);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'predictedannualincome',ave28);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'propnewestsaleprice',ave29);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienfederaltaxfiledtotal',ave30);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'lientaxotherfiledtotal',ave31);
      	Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienforeclosurefiledtotal',ave32);
      	Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienpreforeclosurefiledtotal',ave33);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienlandlordtenantfiledtotal',ave34);
      	Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienjudgmentfiledtotal',ave35);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'liensmallclaimsfiledtotal',ave36);
      	Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienotherfiledtotal',ave37);
      	Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienfederaltaxreleasedtotal',ave38);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'lientaxotherreleasedtotal',ave39);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienforeclosurereleasedtotal',ave40);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienpreforeclosurereleasedtotal',ave41);
      	Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienlandlordtenantreleasedtotal',ave42);
      	Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienjudgmentreleasedtotal',ave43);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'liensmallclaimsreleasedtotal',ave44);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienotherreleasedtotal',ave45);
			  Scoring_QA.Range_function_module.Average_Function_4(DS2,'ageoldestrecord',ave46);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'agenewestrecord',ave47);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'iaageoldestrecord',ave48);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'iaagenewestrecord',ave49);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'iaagelastsale',ave50);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'caageoldestrecord',ave51);
      	Scoring_QA.Range_function_module.Average_Function_4(DS2,'caagenewestrecord',ave52);
      	Scoring_QA.Range_function_module.Average_Function_4(DS2,'calenofres',ave53);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'paageoldestrecord',ave54);
      	Scoring_QA.Range_function_module.Average_Function_4(DS2,'paagenewestrecord',ave55);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'palenofres',ave56);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'paagelastsale',ave57);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'caagelastsale',ave58);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'propageoldestpurchase',ave59);
      	Scoring_QA.Range_function_module.Average_Function_4(DS2,'propagenewestpurchase',ave60);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'derogage',ave61);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'felonyage',ave62);				
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienfiledage',ave63);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'evictionage',ave64);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'proflicage',ave65);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'inferredminimumage',ave66);
				Scoring_QA.Range_function_module.Average_Function_3(DS2,'bestreportedage',ave67);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'phoneedaageoldestrecord',ave68);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'phoneedaagenewestrecord',ave69);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'phoneotherageoldestrecord',ave70);
				Scoring_QA.Range_function_module.Average_Function_4(DS2,'phoneotheragenewestrecord',ave71);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'subjectaddrcount',ave72);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'subjectphonecount',ave73);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'subjectssnrecentcount',ave74);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'subjectaddrrecentcount',ave75);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'subjectphonerecentcount',ave76);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'ssnidentitiescount',ave77);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'ssnaddrcount',ave78);
			    Scoring_QA.Range_function_module.Average_Function_3(DS2,'ssnidentitiesrecentcount',ave79);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'ssnaddrrecentcount',ave80);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddridentitiescount',ave81);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddrssncount',ave82);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddrphonecount',ave83);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddridentitiesrecentcount',ave84);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddrssnrecentcount',ave85);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddrphonerecentcount',ave86);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'phoneidentitiescount',ave87);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'phoneidentitiesrecentcount',ave88);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'inputaddravmconfidence',ave89);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'curraddravmconfidence',ave90);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'prevaddravmconfidence',ave91);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'subprimesolicitedcount',ave92);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'subprimesolicitedcount01',ave93);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'subprimesolicitedcount03',ave94);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'subprimesolicitedcount06',ave95);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'subprimesolicitedcount12',ave96);
		  		Scoring_QA.Range_function_module.Average_Function_3(DS2,'subprimesolicitedcount24',ave97);
			  	Scoring_QA.Range_function_module.Average_Function_3(DS2,'subprimesolicitedcount36',ave98);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'subprimesolicitedcount60',ave99);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienfederaltaxfiledcount',ave100);
      	  Scoring_QA.Range_function_module.Average_Function_3(DS2,'lientaxotherfiledcount',ave101);
      	  Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienforeclosurefiledcount',ave102);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienpreforeclosurefiledcount',ave103);
      	  Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienlandlordtenantfiledcount',ave104);
      	  Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienjudgmentfiledcount',ave105);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'liensmallclaimsfiledcount',ave106);
      	  Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienotherfiledcount',ave107);
      	  Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienfederaltaxreleasedcount',ave108);
			    Scoring_QA.Range_function_module.Average_Function_3(DS2,'lientaxotherreleasedcount',ave109);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienforeclosurereleasedcount',ave110);
      	  Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienpreforeclosurereleasedcount',ave111);
      	  Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienlandlordtenantreleasedcount',ave112);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienjudgmentreleasedcount',ave113);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'liensmallclaimsreleasedcount',ave114);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'lienotherreleasedcount',ave115);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'bankruptcy_count',ave116);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'bankruptcy_count30',ave117);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'bankruptcy_count90',ave118);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'bankruptcy_count180',ave119);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'bankruptcy_count12',ave120);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'bankruptcy_count24',ave121);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'bankruptcy_count36',ave122);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'bankruptcy_count60',ave123);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'eviction_count',ave124);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'eviction_count30',ave125);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'eviction_count90',ave126);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'eviction_count180',ave127);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'eviction_count12',ave128);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'eviction_count24',ave129);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'eviction_count36',ave130);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'eviction_count60',ave131);    
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'subjectssncount',ave132);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'addrchanges12',ave133);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'addrchanges180',ave134);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'addrchanges24',ave135);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'addrchanges30',ave136);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'addrchanges36',ave137);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'addrchanges60',ave138);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'addrchanges90',ave139);
				  Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrhighrisk',ave140);
					Scoring_QA.Range_function_module.Average_Function_4(DS2,'addrprison',ave141);
					Scoring_QA.Range_function_module.Average_Function_4(DS2,'bankruptcyage',ave142);
					Scoring_QA.Range_function_module.Average_Function_4(DS2,'distinputcurr',ave143);					
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'felonies',ave144);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'felonies12',ave145);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'felonies180',ave146);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'felonies24',ave147);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'felonies30',ave148);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'felonies36',ave149); 
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'felonies60',ave150);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'felonies90',ave151);
					Scoring_QA.Range_function_module.Average_Function_4(DS2,'ialenofres',ave152); 
					Scoring_QA.Range_function_module.Average_Function_4(DS2,'lienreleasedage',ave153); 
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_liens',ave154);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_nonderogs',ave155);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_nonderogs12',ave156);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_nonderogs180',ave157);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_nonderogs24',ave158);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_nonderogs30',ave159);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_nonderogs36',ave160);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_nonderogs60',ave161);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_nonderogs90',ave162);					
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic',ave163);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic_exp12',ave164);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic_exp180',ave165);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic_exp24',ave166);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic_exp30',ave167);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic_exp36',ave168);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic_exp60',ave169);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic_exp90',ave170);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic12',ave171);					
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic180',ave172);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic24',ave173);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic30',ave174);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic36',ave175);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic60',ave176);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_proflic90',ave177);					
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_released_liens',ave178);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_released_liens12',ave179);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_released_liens180',ave180);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_released_liens24',ave181);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_released_liens30',ave182);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_released_liens36',ave183);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_released_liens60',ave184);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_released_liens90',ave185);					
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_unreleased_liens',ave186);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_unreleased_liens12',ave187);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_unreleased_liens180',ave188);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_unreleased_liens24',ave189);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_unreleased_liens30',ave190);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_unreleased_liens36',ave191);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_unreleased_liens60',ave192);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'num_unreleased_liens90',ave193);					
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numaircraft',ave194);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numaircraft12',ave195);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numaircraft180',ave196);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'numaircraft24',ave197);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'numaircraft30',ave198);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numaircraft36',ave199);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numaircraft60',ave200);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numaircraft90',ave201);											
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numpurchase12',ave202);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numpurchase180',ave203);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numpurchase24',ave204);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'numpurchase30',ave205);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'numpurchase36',ave206);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numpurchase60',ave207);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numpurchase90',ave208);				
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numsold12',ave209);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numsold180',ave210);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numsold24',ave211);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'numsold30',ave212);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'numsold36',ave213);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numsold60',ave214);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numsold90',ave215);					
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numsources',ave216);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numwatercraft',ave217);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numwatercraft12',ave218);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numwatercraft180',ave219);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numwatercraft24',ave220);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'numwatercraft30',ave221);
				  Scoring_QA.Range_function_module.Average_Function_3(DS2,'numwatercraft36',ave222);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numwatercraft60',ave223);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'numwatercraft90',ave224);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'property_historically_owned',ave225);
					Scoring_QA.Range_function_module.Average_Function_3(DS2,'property_owned_total',ave226);
														
								 
      	   avearage:= ave1  + ave2  + ave3  + ave5  + ave6  + ave7  + ave8  + ave9  + ave10 +
				        ave11 + ave12 + ave13 + ave14 + ave15 + ave16 + ave17 + ave18 + ave19 + ave20 +
						    ave21 + ave22 + ave23 + ave24 + ave25 + ave26 + ave27 + ave28 + ave29 + ave30 +
				        ave31 + ave32 + ave33 + ave34 + ave35 + ave36 + ave37 + ave38 + ave39 + ave40 +
				        ave41 + ave42 + ave43 + ave44 + ave45 + ave46 + ave47 + ave48 + ave49 + ave50 +
								ave51 + ave52 + ave53 + ave54 + ave55 + ave56 + ave57 + ave58 + ave59 + ave60 +
                ave61 + ave62 + ave63 + ave64 + ave65 + ave66 + ave67 + ave68 + ave69 + ave70 + 
                ave71 + ave72 + ave73 + ave74 + ave75 + ave76 + ave77 + ave78 + ave79 + ave80 + 
                ave81 + ave82 + ave83 + ave84 + ave85 + ave86 + ave87 + ave88 + ave89 + ave90 + 
					      ave91 + ave92 + ave93 + ave94 + ave95 + ave96 + ave97 + ave98 + ave99 + ave100+ 
				        ave101 + ave102 + ave103 + ave104 + ave105 + ave106 + ave107 + ave108 + ave109 + ave110+ 
						    ave111 + ave112 + ave113 + ave114 + ave115 + ave116 + ave117 + ave118 + ave119 + ave120+ 
				  	    ave121 + ave122 + ave123 + ave124 + ave125 + ave126 + ave127 + ave128 + ave129 + ave130+
						    ave131 + ave132 + ave133 + ave134 + ave135 + ave136 + ave137 + ave138 + ave139 + ave140 +
				           ave141 + ave142 + ave143 + ave144 + ave145 + ave146 + ave147 + ave148 + ave149 + ave150 +
                   ave151 + ave152 + ave153 + ave154 + ave155 + ave156 + ave157 + ave158 + ave159 + ave160 +
                   ave161 + ave162 + ave163 + ave164 + ave165 + ave166 + ave167 + ave168 + ave169 + ave170 + 
                   ave171 + ave172 + ave173 + ave174 + ave175 + ave176 + ave177 + ave178 + ave179 + ave180 + 
									 ave181 + ave182 + ave183 + ave184 + ave185 + ave186 + ave187 + ave188 + ave189 + ave190 + 
									 ave191 + ave192 + ave193 + ave194 + ave195 + ave196 + ave197 + ave198 + ave199 + ave200 + 
								   ave201 + ave202 + ave203 + ave204 + ave205 + ave206 + ave207 + ave208 + ave209 + ave210 + 
									 ave211 + ave212 + ave213 + ave214 + ave215 + ave216 + ave217 + ave218 + ave219 + ave220 + 
									 ave221 + ave222 + ave223 + ave224 + ave225 + ave226;
				
								 			 
	
	

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
																				 self.mode:='xml';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='RiskView_Experian_attributes_v3';
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

		  // did_results := DATASET([{'RiskView_Experian_attributes_v3','xml','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    // ], compare_layout);
   	
											
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_XML_Experian_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_XML_Experian_outfile[2..] + current_dt;
		
		// FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_XML_Experian_outfile + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 // SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 // res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,res,res1);

return seq;

endmacro;