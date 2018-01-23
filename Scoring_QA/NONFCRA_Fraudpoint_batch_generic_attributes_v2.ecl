EXPORT NONFCRA_Fraudpoint_batch_generic_attributes_v2(route,current_dt,previous_dt) := functionmacro



 file1:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V2_BATCH_Generic_FP1109_0_outfile + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V2_Global_Layout,


 thor);

 file2:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V2_BATCH_Generic_FP1109_0_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V2_Global_Layout,

thor);





aa1:=join(file1,file2,left.acctno=right.acctno,inner);

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

   	  	
      	
        Scoring_QA.Range_function_module.range_function_180(DS2,'identityageoldest',ran1);
      	Scoring_QA.Range_function_module.Range_Function_25(DS2,'identityagenewest',ran2);
				Scoring_QA.Range_function_module.range_function_197(DS2,'sourcecreditbureauageoldest',ran3);
				Scoring_QA.Range_function_module.range_function_25(DS2,'sourcecreditbureauagenewest',ran4);
      	Scoring_QA.Range_function_module.range_function_196(DS2,'sourcecreditbureauagechange',ran5);
				Scoring_QA.Range_function_module.Range_Function_199(DS2,'variationaddrchangeage',ran6);
			 	Scoring_QA.Range_function_module.range_function_198(DS2,'ssnhighissueage',ran7);
      	Scoring_QA.Range_function_module.range_function_198(DS2,'ssnlowissueage',ran8);
				Scoring_QA.Range_function_module.range_function_186(DS2,'inputaddrageoldest',ran9);
				Scoring_QA.Range_function_module.range_function_185(DS2,'inputaddragenewest',ran10);
				Scoring_QA.Range_function_module.range_function_175(DS2,'curraddrageoldest',ran11);
				Scoring_QA.Range_function_module.range_function_15(DS2,'curraddragenewest',ran12);
				Scoring_QA.Range_function_module.range_function_176(DS2,'curraddrlenofres',ran13);
				Scoring_QA.Range_function_module.range_function_193(DS2,'prevaddrageoldest',ran14);
			 	Scoring_QA.Range_function_module.range_function_192(DS2,'prevaddragenewest',ran15);
				Scoring_QA.Range_function_module.range_function_193(DS2,'prevaddrlenofres',ran16);
				
      	
      	
      	ran:= ran1  + ran2  + ran3  + ran4 + ran5 + ran6  + ran7  + ran8  + ran9  + ran10 +
				     ran11 + ran12 + ran13 + ran14 + ran15 + ran16;
      	
				  Scoring_QA.Range_function_module.Range_Function_51(DS2,'idveraddressassoccount',ran0_1);
					Scoring_QA.Range_function_module.range_function_184(DS2,'idverssnsourcecount',ran0_2);
					Scoring_QA.Range_function_module.range_function_182(DS2,'idveraddresssourcecount',ran0_3);
					Scoring_QA.Range_function_module.range_function_183(DS2,'idverdobsourcecount',ran0_4);
					Scoring_QA.Range_function_module.range_function_170(DS2,'sourcepublicrecordcount',ran0_5);
					Scoring_QA.Range_function_module.range_function_31(DS2,'sourcepublicrecordcountyear',ran0_6);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'variationidentitycount',ran0_7);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'variationssncount',ran0_8);
			    Scoring_QA.Range_function_module.Range_Function_31(DS2,'variationssncountnew',ran0_9);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'variationmsourcesssncount',ran0_10);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'variationmsourcesssnunrelcount',ran0_11);
					Scoring_QA.Range_function_module.range_function_46(DS2,'variationlastnamecount',ran0_12);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'variationlastnamecountnew',ran0_13);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'variationaddrcountyear',ran0_14);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'variationaddrcountnew',ran0_15);
					Scoring_QA.Range_function_module.Range_Function_51(DS2,'variationdobcount',ran0_16);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'variationdobcountnew',ran0_17);
				  Scoring_QA.Range_function_module.Range_Function_25(DS2,'variationphonecount',ran0_18);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'variationphonecountnew',ran0_19);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'variationsearchssncount',ran0_20);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'variationsearchaddrcount',ran0_21);
				  Scoring_QA.Range_function_module.Range_Function_25(DS2,'variationsearchphonecount',ran0_22);
					Scoring_QA.Range_function_module.range_function_195(DS2,'searchcount',ran0_23);
					Scoring_QA.Range_function_module.Range_Function_51(DS2,'searchcountyear',ran0_24);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchcountmonth',ran0_25);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchcountweek',ran0_26);
		  		Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchcountday',ran0_27);
			  	Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchunverifiedssncountyear',ran0_28);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchunverifiedaddrcountyear',ran0_29);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchunverifieddobcountyear',ran0_30);
      	  Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchunverifiedphonecountyear',ran0_31);
      	  Scoring_QA.Range_function_module.range_function_141(DS2,'searchbankingsearchcount',ran0_32);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchbankingsearchcountyear',ran0_33);
			 	  Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchbankingsearchcountmonth',ran0_34);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchbankingsearchcountweek',ran0_35);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchbankingsearchcountday',ran0_36);
		   	  Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchhighrisksearchcount',ran0_37);
      	  Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchhighrisksearchcountyear',ran0_38);
			    Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchhighrisksearchcountmonth',ran0_39);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchhighrisksearchcountweek',ran0_40);
      	  Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchhighrisksearchcountday',ran0_41);
      	  Scoring_QA.Range_function_module.range_function_141(DS2,'searchfraudsearchcount',ran0_42);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchfraudsearchcountyear',ran0_43);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchfraudsearchcountmonth',ran0_44);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchfraudsearchcountweek',ran0_45);
					// Scoring_QA.Range_function_module.Range_Function_0(DS2,'searchhighrisksearchcountday',ran0_46);
					// Scoring_QA.Range_function_module.Range_Function_0(DS2,'searchfraudsearchcount',ran0_47);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchfraudsearchcountyear',ran0_48);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchfraudsearchcountmonth',ran0_49);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchfraudsearchcountweek',ran0_50);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchfraudsearchcountday',ran0_51);
					Scoring_QA.Range_function_module.range_function_170(DS2,'searchlocatesearchcount',ran0_52);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchlocatesearchcountyear',ran0_53);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchlocatesearchcountmonth',ran0_54);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchlocatesearchcountweek',ran0_55);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchlocatesearchcountday',ran0_56);
					Scoring_QA.Range_function_module.range_function_169(DS2,'assoccount',ran0_57);
					Scoring_QA.Range_function_module.range_function_171(DS2,'assocsuspicousidentitiescount',ran0_58);
					Scoring_QA.Range_function_module.range_function_170(DS2,'assoccreditbureauonlycount',ran0_59);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'assoccreditbureauonlycountnew',ran0_60);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'assoccreditbureauonlycountmonth',ran0_61);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'assochighrisktopologycount',ran0_62);
					Scoring_QA.Range_function_module.range_function_174(DS2,'correlationssnnamecount',ran0_63);
					Scoring_QA.Range_function_module.range_function_173(DS2,'correlationssnaddrcount',ran0_64);
					Scoring_QA.Range_function_module.range_function_172(DS2,'correlationaddrnamecount',ran0_65);
				  Scoring_QA.Range_function_module.range_function_51(DS2,'correlationaddrphonecount',ran0_66);
		  		Scoring_QA.Range_function_module.Range_Function_51(DS2,'correlationphonelastnamecount',ran0_67);
					Scoring_QA.Range_function_module.Range_Function_51(DS2,'divssnidentitycount',ran0_68);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'divssnidentitycountnew',ran0_69);
					Scoring_QA.Range_function_module.Range_Function_51(DS2,'divssnidentitymsourcecount',ran0_70);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'divssnidentitymsourceurelcount',ran0_71);
					Scoring_QA.Range_function_module.Range_Function_51(DS2,'divssnlnamecount',ran0_72);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'divssnlnamecountnew',ran0_73);
					Scoring_QA.Range_function_module.range_function_60(DS2,'divssnaddrcount',ran0_74);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'divssnaddrcountnew',ran0_75);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'divssnaddrmsourcecount',ran0_76);
					Scoring_QA.Range_function_module.range_function_177(DS2,'divaddridentitycount',ran0_77);
				  Scoring_QA.Range_function_module.Range_Function_25(DS2,'divaddridentitycountnew',ran0_78);
					Scoring_QA.Range_function_module.range_function_178(DS2,'divaddridentitymsourcecount',ran0_79);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'divaddrsuspidentitycountnew',ran0_80);
					Scoring_QA.Range_function_module.range_function_179(DS2,'divaddrssncount',ran0_81);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'divaddrssncountnew',ran0_82);
					Scoring_QA.Range_function_module.range_function_60(DS2,'divaddrssnmsourcecount',ran0_83);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'divaddrphonecount',ran0_84);
					 Scoring_QA.Range_function_module.Range_Function_31(DS2,'divaddrphonecountnew',ran0_85);
			    Scoring_QA.Range_function_module.Range_Function_31(DS2,'divaddrphonemsourcecount',ran0_86);
		  		Scoring_QA.Range_function_module.Range_Function_25(DS2,'divphoneidentitycount',ran0_87);
			    Scoring_QA.Range_function_module.Range_Function_31(DS2,'divphoneidentitycountnew',ran0_88);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'divphoneidentitymsourcecount',ran0_89);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'divphoneaddrcount',ran0_90);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'divphoneaddrcountnew',ran0_91);
				  Scoring_QA.Range_function_module.Range_Function_25(DS2,'divsearchssnidentitycount',ran0_92);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'divsearchaddridentitycount',ran0_93);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'divsearchaddrsuspidentitycount',ran0_94);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'divsearchphoneidentitycount',ran0_95);
					Scoring_QA.Range_function_module.range_function_141(DS2,'searchssnsearchcount',ran0_96);
					Scoring_QA.Range_function_module.Range_Function_25(DS2,'searchssnsearchcountyear',ran0_97);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchssnsearchcountmonth',ran0_98);
			    Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchssnsearchcountweek',ran0_99);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchssnsearchcountday',ran0_100);
					Scoring_QA.Range_function_module.range_function_194(DS2,'searchaddrsearchcount',ran0_101);
			    Scoring_QA.Range_function_module.Range_Function_25(DS2,'searchaddrsearchcountyear',ran0_102);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchaddrsearchcountmonth',ran0_103);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchaddrsearchcountweek',ran0_104);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchaddrsearchcountday',ran0_105);
					Scoring_QA.Range_function_module.range_function_171(DS2,'searchphonesearchcount',ran0_106);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchphonesearchcountyear',ran0_107);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchphonesearchcountmonth',ran0_108);
			    Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchphonesearchcountweek',ran0_109);
					Scoring_QA.Range_function_module.Range_Function_31(DS2,'searchphonesearchcountday',ran0_110);
					Scoring_QA.Range_function_module.range_function_187(DS2,'inputaddrbusinesscount',ran0_111);
				  Scoring_QA.Range_function_module.range_function_188(DS2,'inputaddrnbrhdbusinesscount',ran0_112);
					Scoring_QA.Range_function_module.range_function_190(DS2,'inputaddrnbrhdsinglefamilycount',ran0_113);
					Scoring_QA.Range_function_module.range_function_189(DS2,'inputaddrnbrhdmultifamilycount',ran0_114);
					Scoring_QA.Range_function_module.range_function_191(DS2,'inputaddrnbrhdvacantpropcount',ran0_115);
						
						
					 	 ran_0:=   ran0_1  + ran0_2  + ran0_3  + ran0_4  + ran0_5  + ran0_6  + ran0_7  + ran0_8  + ran0_9  + ran0_10 +
				               ran0_11 + ran0_12 + ran0_13 + ran0_14 + ran0_15 + ran0_16 + ran0_17 + ran0_18 + ran0_19 + ran0_20 +
						           ran0_21 + ran0_22 + ran0_23 + ran0_24 + ran0_25 + ran0_26 + ran0_27 + ran0_28 + ran0_29 + ran0_30 +
				               ran0_31 + ran0_32 + ran0_33 + ran0_34 + ran0_35 + ran0_36 + ran0_37 + ran0_38 + ran0_39 + ran0_40 +
				               ran0_41 + ran0_42 + ran0_43 + ran0_44 + ran0_45    + ran0_48 +ran0_49 +ran0_50 +
                       ran0_51 + ran0_52 + ran0_53 + ran0_54 + ran0_55 + ran0_56 + ran0_57 + ran0_58 + ran0_59 + ran0_60 +
                       ran0_61 + ran0_62 + ran0_63 + ran0_64 + ran0_65 + ran0_66 + ran0_67 + ran0_68 + ran0_69 + ran0_70 + 
                       ran0_71 + ran0_72 + ran0_73 + ran0_74 + ran0_75 + ran0_76 + ran0_77 + ran0_78 + ran0_79 + ran0_80 + 
                       ran0_81 + ran0_82 + ran0_83 + ran0_84 + ran0_85+ ran0_86 + ran0_87 + ran0_88 + ran0_89 + ran0_90 + 
					             ran0_91 + ran0_92 + ran0_93 + ran0_94 + ran0_95 + ran0_96 + ran0_97 + ran0_98 + ran0_99 + ran0_100 + 
				               ran0_101 + ran0_102 + ran0_103 + ran0_104 + ran0_105 + ran0_106 + ran0_107 + ran0_108 + ran0_109 + ran0_110 + 
											 ran0_111 + ran0_112 + ran0_113 + ran0_114 + ran0_115;
			
						Scoring_QA.Range_function_module.Range_Function_1(DS2,'inputaddrnbrhdmobilityindex',ran1_1);
								
								
																	 
											 ran_1:=ran1_1;
				
								
								 Scoring_QA.Range_function_module.range_function_77(DS2,'identityrecordcount',ran2_1);
								 Scoring_QA.Range_function_module.range_function_181(DS2,'identitysourcecount',ran2_2);
								
							      	
											 
											 					 ran_2:=ran2_1 + ran2_2;
								 
								
								 
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'inputaddrnbrhdmurderindex',ran5_1);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'inputaddrnbrhdcartheftindex',ran5_2);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'inputaddrnbrhdburglaryindex',ran5_3);
								 Scoring_QA.Range_function_module.Range_Function_5(DS2,'inputaddrnbrhdcrimeindex',ran5_4);
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
													 
										 	
											
											
													
										
										  				
					Scoring_QA.Range_function_module.Distinct_function(DS2,'identityrisklevel',dis1);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'identityrecentupdate',dis2);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'identityageriskindicator',dis3);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'idverrisklevel',dis4);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'idverssn',dis5);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'idvername',dis6);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'idveraddress',dis7);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'idveraddressnotcurrent',dis8);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'idverphone',dis9);
				  Scoring_QA.Range_function_module.Range_Function_31(DS2,'idverdriverslicense',dis10);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'idverdob',dis11);				
					Scoring_QA.Range_function_module.Distinct_function(DS2,'idverssncreditbureaucount',dis12);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'idverssncreditbureaudelete',dis13);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'idveraddrcreditbureaucount',dis14);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourcerisklevel',dis15);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourcefirstreportingidentity',dis16);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourcecreditbureau',dis17);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourcecreditbureaucount',dis18);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourcepublicrecord',dis19);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourceeducation',dis20);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourceoccupationallicense',dis21);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourcevoterregistration',dis22);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourceonlinedirectory',dis23);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourcedonotmail',dis24);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourceaccidents',dis25);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourcebusinessrecords',dis26);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourceproperty',dis27);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourceassets',dis28);
			    Scoring_QA.Range_function_module.Distinct_function(DS2,'sourcephonedirectoryassistance',dis29);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'sourcephonenonpublicdirectory',dis30);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'variationrisklevel',dis31);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'variationaddrstability',dis32);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'assocrisklevel',dis33);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'assocdistanceclosest',dis34);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'validationrisklevel',dis35);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'validationssnproblems',dis36);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'validationaddrproblems',dis37);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'validationphoneproblems',dis38);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'validationdlproblems',dis39);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'validationipproblems',dis40);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'correlationrisklevel',dis41);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'divrisklevel',dis42);
	        Scoring_QA.Range_function_module.Distinct_function(DS2,'searchcomponentrisklevel',dis43);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'componentcharrisklevel',dis44);					
					Scoring_QA.Range_function_module.range_function_116(DS2,'ssnissuestate',dis45);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnnonus',dis46);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputphonetype',dis47);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ipstate',dis48);
			  	Scoring_QA.Range_function_module.Distinct_function(DS2,'ipcountry',dis49);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ipcontinent',dis50);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrtype',dis51);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrdwelltype',dis52);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrdelivery',dis53);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddractivephonelist',dis54);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddroccupantowned',dis55);					
					Scoring_QA.Range_function_module.Distinct_function7(DS2,'addrchangeecontrajectory',dis56);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'addrchangeecontrajectoryindex',dis57);					
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddrdwelltype',dis58);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddrstatus',dis59);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'curraddractivephonelist',dis60);					
					Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddrdwelltype',dis61);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddrstatus',dis62);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'prevaddroccupantowned',dis63);
					
					Scoring_QA.Range_function_module.Distinct_function(DS2,'fnamepop',dis64);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'lnamepop',dis65);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'addrpop',dis66);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnlength',dis67);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'dobpop',dis68);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'emailpop',dis69);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ipaddrpop',dis70);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'hphnpop',dis71);
					
				
					
					dis:= dis1  + dis2  + dis3  + dis4  + dis5  + dis6  + dis7  + dis8  + dis9  + dis10 +
				       dis11 + dis12 + dis13 + dis14 + dis15 + dis16 + dis17 + dis18 + dis19 + dis20 +
						   dis21 + dis22 + dis23 + dis24 + dis25 + dis26 + dis27 + dis28 + dis29 + dis30 +
				       dis31 + dis32 + dis33 + dis34 + dis35 + dis36 + dis37 + dis38 + dis39 + dis40 +
				       dis41 + dis42 + dis43 + dis44 + dis45 + dis46 + dis47 + dis48 + dis49 + dis50 +
						   dis51 + dis52 + dis53 + dis54 + dis55 + dis56 + dis57 + dis58 + dis59 + dis60 +
               dis61 + dis62 + dis63 + dis64 + dis65 + dis66 + dis67 + dis68  + dis69 + dis70 + 
               dis71;
				
				
				
				
								
      
			
			result2_stats:= ran + dis + ran_0 + ran_1 +ran_2 + ran_5 ;
   				
        
			    Scoring_QA.Range_function_module.Average_func(DS2,'idveraddressassoccount',ave1);
					Scoring_QA.Range_function_module.Average_func(DS2,'idverssnsourcecount',ave2);
					Scoring_QA.Range_function_module.Average_func(DS2,'idveraddresssourcecount',ave3);
					Scoring_QA.Range_function_module.Average_func(DS2,'idverdobsourcecount',ave4);
					Scoring_QA.Range_function_module.Average_func(DS2,'sourcepublicrecordcount',ave5);
					Scoring_QA.Range_function_module.Average_func(DS2,'sourcepublicrecordcountyear',ave6);
					Scoring_QA.Range_function_module.Average_func(DS2,'variationidentitycount',ave7);
					Scoring_QA.Range_function_module.Average_func(DS2,'variationssncount',ave8);
			    Scoring_QA.Range_function_module.Average_func(DS2,'variationssncountnew',ave9);
					Scoring_QA.Range_function_module.Average_func(DS2,'variationmsourcesssncount',ave10);
					Scoring_QA.Range_function_module.Average_func(DS2,'variationmsourcesssnunrelcount',ave11);
					Scoring_QA.Range_function_module.Average_func(DS2,'variationlastnamecount',ave12);
					Scoring_QA.Range_function_module.Average_func(DS2,'variationlastnamecountnew',ave13);
					Scoring_QA.Range_function_module.Average_func(DS2,'variationaddrcountyear',ave14);
					Scoring_QA.Range_function_module.Average_func(DS2,'variationaddrcountnew',ave15);
					Scoring_QA.Range_function_module.Average_func(DS2,'variationdobcount',ave16);
					Scoring_QA.Range_function_module.Average_func(DS2,'variationdobcountnew',ave17);
				  Scoring_QA.Range_function_module.Average_func(DS2,'variationphonecount',ave18);
					Scoring_QA.Range_function_module.Average_func(DS2,'variationphonecountnew',ave19);
					Scoring_QA.Range_function_module.Average_func(DS2,'variationsearchssncount',ave20);
					Scoring_QA.Range_function_module.Average_func(DS2,'variationsearchaddrcount',ave21);
				  Scoring_QA.Range_function_module.Average_func(DS2,'variationsearchphonecount',ave22);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchcount',ave23);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchcountyear',ave24);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchcountmonth',ave25);
				  Scoring_QA.Range_function_module.Average_func(DS2,'searchcountweek',ave26);
		  		Scoring_QA.Range_function_module.Average_func(DS2,'searchcountday',ave27);
			  	Scoring_QA.Range_function_module.Average_func(DS2,'searchunverifiedssncountyear',ave28);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchunverifiedaddrcountyear',ave29);
				  Scoring_QA.Range_function_module.Average_func(DS2,'searchunverifieddobcountyear',ave30);
      	  Scoring_QA.Range_function_module.Average_func(DS2,'searchunverifiedphonecountyear',ave31);
      	  Scoring_QA.Range_function_module.Average_func(DS2,'searchbankingsearchcount',ave32);
				  Scoring_QA.Range_function_module.Average_func(DS2,'searchbankingsearchcountyear',ave33);
			 	  Scoring_QA.Range_function_module.Average_func(DS2,'searchbankingsearchcountmonth',ave34);
				  Scoring_QA.Range_function_module.Average_func(DS2,'searchbankingsearchcountweek',ave35);
				  Scoring_QA.Range_function_module.Average_func(DS2,'searchbankingsearchcountday',ave36);
		   	  Scoring_QA.Range_function_module.Average_func(DS2,'searchhighrisksearchcount',ave37);
      	  Scoring_QA.Range_function_module.Average_func(DS2,'searchhighrisksearchcountyear',ave38);
			    Scoring_QA.Range_function_module.Average_func(DS2,'searchhighrisksearchcountmonth',ave39);
				  Scoring_QA.Range_function_module.Average_func(DS2,'searchhighrisksearchcountweek',ave40);
      	  Scoring_QA.Range_function_module.Average_func(DS2,'searchhighrisksearchcountday',ave41);
      	  Scoring_QA.Range_function_module.Average_func(DS2,'searchfraudsearchcount',ave42);
				  Scoring_QA.Range_function_module.Average_func(DS2,'searchfraudsearchcountyear',ave43);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchfraudsearchcountmonth',ave44);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchfraudsearchcountweek',ave45);
					// Scoring_QA.Range_function_module.Average_func(DS2,'searchhighrisksearchcountday',ave46);
					// Scoring_QA.Range_function_module.Average_func(DS2,'searchfraudsearchcount',ave47);
					// Scoring_QA.Range_function_module.Average_func(DS2,'searchfraudsearchcountyear',ave48);
					// Scoring_QA.Range_function_module.Average_func(DS2,'searchfraudsearchcountmonth',ave49);
					// Scoring_QA.Range_function_module.Average_func(DS2,'searchfraudsearchcountweek',ave50);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchfraudsearchcountday',ave51);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchlocatesearchcount',ave52);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchlocatesearchcountyear',ave53);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchlocatesearchcountmonth',ave54);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchlocatesearchcountweek',ave55);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchlocatesearchcountday',ave56);
					Scoring_QA.Range_function_module.Average_func(DS2,'assoccount',ave57);
					Scoring_QA.Range_function_module.Average_func(DS2,'assocsuspicousidentitiescount',ave58);
					Scoring_QA.Range_function_module.Average_func(DS2,'assoccreditbureauonlycount',ave59);
					Scoring_QA.Range_function_module.Average_func(DS2,'assoccreditbureauonlycountnew',ave60);
					Scoring_QA.Range_function_module.Average_func(DS2,'assoccreditbureauonlycountmonth',ave61);
				  Scoring_QA.Range_function_module.Average_func(DS2,'assochighrisktopologycount',ave62);
					Scoring_QA.Range_function_module.Average_func(DS2,'correlationssnnamecount',ave63);
					Scoring_QA.Range_function_module.Average_func(DS2,'correlationssnaddrcount',ave64);
					Scoring_QA.Range_function_module.Average_func(DS2,'correlationaddrnamecount',ave65);
				  Scoring_QA.Range_function_module.Average_func(DS2,'correlationaddrphonecount',ave66);
		  		Scoring_QA.Range_function_module.Average_func(DS2,'correlationphonelastnamecount',ave67);
					Scoring_QA.Range_function_module.Average_func(DS2,'divssnidentitycount',ave68);
					Scoring_QA.Range_function_module.Average_func(DS2,'divssnidentitycountnew',ave69);
					Scoring_QA.Range_function_module.Average_func(DS2,'divssnidentitymsourcecount',ave70);
					Scoring_QA.Range_function_module.Average_func(DS2,'divssnidentitymsourceurelcount',ave71);
					Scoring_QA.Range_function_module.Average_func(DS2,'divssnlnamecount',ave72);
					Scoring_QA.Range_function_module.Average_func(DS2,'divssnlnamecountnew',ave73);
					Scoring_QA.Range_function_module.Average_func(DS2,'divssnaddrcount',ave74);
					Scoring_QA.Range_function_module.Average_func(DS2,'divssnaddrcountnew',ave75);
					Scoring_QA.Range_function_module.Average_func(DS2,'divssnaddrmsourcecount',ave76);
					Scoring_QA.Range_function_module.Average_func(DS2,'divaddridentitycount',ave77);
				  Scoring_QA.Range_function_module.Average_func(DS2,'divaddridentitycountnew',ave78);
					Scoring_QA.Range_function_module.Average_func(DS2,'divaddridentitymsourcecount',ave79);
					Scoring_QA.Range_function_module.Average_func(DS2,'divaddrsuspidentitycountnew',ave80);
					Scoring_QA.Range_function_module.Average_func(DS2,'divaddrssncount',ave81);
				  Scoring_QA.Range_function_module.Average_func(DS2,'divaddrssncountnew',ave82);
					Scoring_QA.Range_function_module.Average_func(DS2,'divaddrssnmsourcecount',ave83);
					Scoring_QA.Range_function_module.Average_func(DS2,'divaddrphonecount',ave84);
					 Scoring_QA.Range_function_module.Average_func(DS2,'divaddrphonecountnew',ave85);
			    Scoring_QA.Range_function_module.Average_func(DS2,'divaddrphonemsourcecount',ave86);
		  		Scoring_QA.Range_function_module.Average_func(DS2,'divphoneidentitycount',ave87);
			    Scoring_QA.Range_function_module.Average_func(DS2,'divphoneidentitycountnew',ave88);
					Scoring_QA.Range_function_module.Average_func(DS2,'divphoneidentitymsourcecount',ave89);
					Scoring_QA.Range_function_module.Average_func(DS2,'divphoneaddrcount',ave90);
					Scoring_QA.Range_function_module.Average_func(DS2,'divphoneaddrcountnew',ave91);
				  Scoring_QA.Range_function_module.Average_func(DS2,'divsearchssnidentitycount',ave92);
					Scoring_QA.Range_function_module.Average_func(DS2,'divsearchaddridentitycount',ave93);
					Scoring_QA.Range_function_module.Average_func(DS2,'divsearchaddrsuspidentitycount',ave94);
					Scoring_QA.Range_function_module.Average_func(DS2,'divsearchphoneidentitycount',ave95);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchssnsearchcount',ave96);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchssnsearchcountyear',ave97);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchssnsearchcountmonth',ave98);
			    Scoring_QA.Range_function_module.Average_func(DS2,'searchssnsearchcountweek',ave99);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchssnsearchcountday',ave100);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchaddrsearchcount',ave101);
			    Scoring_QA.Range_function_module.Average_func(DS2,'searchaddrsearchcountyear',ave102);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchaddrsearchcountmonth',ave103);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchaddrsearchcountweek',ave104);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchaddrsearchcountday',ave105);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchphonesearchcount',ave106);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchphonesearchcountyear',ave107);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchphonesearchcountmonth',ave108);
			    Scoring_QA.Range_function_module.Average_func(DS2,'searchphonesearchcountweek',ave109);
					Scoring_QA.Range_function_module.Average_func(DS2,'searchphonesearchcountday',ave110);
					Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrbusinesscount',ave111);
				  Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrnbrhdbusinesscount',ave112);
					Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrnbrhdsinglefamilycount',ave113);
					Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrnbrhdmultifamilycount',ave114);
					Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrnbrhdvacantpropcount',ave115);
					Scoring_QA.Range_function_module.Average_func(DS2,'identityrecordcount',ave116);
				  Scoring_QA.Range_function_module.Average_func(DS2,'identitysourcecount',ave117);
					Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrnbrhdmedianincome',ave118);
      	Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrnbrhdmedianvalue',ave119);
				Scoring_QA.Range_function_module.Average_func(DS2,'addrchangedistance',ave120);				
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddrmedianincome',ave121);
		    Scoring_QA.Range_function_module.Average_func(DS2,'curraddrmedianvalue',ave122);				
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrmedianincome',ave123);
      	Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrmedianvalue',ave124);
				Scoring_QA.Range_function_module.Average_func(DS2,'identityageoldest',ave125);
      	Scoring_QA.Range_function_module.Average_func(DS2,'identityagenewest',ave126);
				Scoring_QA.Range_function_module.Average_func(DS2,'sourcecreditbureauageoldest',ave127);
				Scoring_QA.Range_function_module.Average_func(DS2,'sourcecreditbureauagenewest',ave128);
      	Scoring_QA.Range_function_module.Average_func(DS2,'sourcecreditbureauagechange',ave129);
				Scoring_QA.Range_function_module.Average_func(DS2,'variationaddrchangeage',ave130);
			 	Scoring_QA.Range_function_module.Average_func(DS2,'ssnhighissueage',ave131);
      	Scoring_QA.Range_function_module.Average_func(DS2,'ssnlowissueage',ave132);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddrageoldest',ave133);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputaddragenewest',ave134);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddrageoldest',ave135);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddragenewest',ave136);
				Scoring_QA.Range_function_module.Average_func(DS2,'curraddrlenofres',ave137);
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrageoldest',ave138);
			 	Scoring_QA.Range_function_module.Average_func(DS2,'prevaddragenewest',ave139);
				Scoring_QA.Range_function_module.Average_func(DS2,'prevaddrlenofres',ave140);
      	
      	   avearage:= ave1  + ave2  + ave3  + ave4  + ave5  + ave6  + ave7  + ave8  + ave9  + ave10 +
				       ave11 + ave12 + ave13 + ave14 + ave15 + ave16 + ave17 + ave18 + ave19 + ave20 +
						   ave21 + ave22 + ave23 + ave24 + ave25 + ave26 + ave27 + ave28 + ave29 + ave30 +
				       ave31 + ave32 + ave33 + ave34 + ave35 + ave36 + ave37 + ave38 + ave39 + ave40 +
				       ave41 + ave42 + ave43 + ave44 + ave45  +
						   ave51 + ave52 + ave53 + ave54 + ave55 + ave56 + ave57 + ave58 + ave59 + ave60 +
               ave61 + ave62 + ave63 + ave64 + ave65 + ave66 + ave67 + ave68 + ave69 + ave70 + 
               ave71 + ave72 + ave73 + ave74 + ave75 + ave76 + ave77 + ave78 + ave79 + ave80 + 
               ave81 + ave82 + ave83 + ave84 + ave85 + ave86 + ave87 + ave88 + ave89 + ave90 + 
					     ave91 + ave92 + ave93 + ave94 + ave95 + ave96 + ave97 + ave98 + ave99 + ave100+ 
				       ave101 + ave102 + ave103 + ave104 + ave105 + ave106 + ave107 + ave108 + ave109 + ave110+ 
						   ave111 + ave112 + ave113 + ave114 + ave115 + ave116 + ave117 + ave118 + ave119 + ave120+ 
				  	   ave121 + ave122 + ave123 + ave124 + ave125 + ave126 + ave127 + ave128 + ave129 + ave130+
						   ave131 + ave132 + ave133 + ave134 + ave135 + ave136 + ave137 + ave138 + ave139 + ave140;
				
      	
								
											 
										 
											 
						
	
	
	 Scoring_QA.Range_function_module.Range_Average_Function_2(DS1,'addrchangeincomediff',ranav1_1);
		 Scoring_QA.Range_function_module.Range_Average_Function_2(DS1,'addrchangevaluediff',ranav1_2);
		 	
			ranav2:=ranav1_1 + ranav1_2;
											 
						
	
	
		 Scoring_QA.Range_function_module.Range_Average_Function_2(DS2,'addrchangeincomediff',ranave1_1);
		 Scoring_QA.Range_function_module.Range_Average_Function_2(DS2,'addrchangevaluediff',ranave1_2);
		 
	ranave2:=ranave1_1 + ranave1_2;
	
   result4_stats:=avearage  + ranave2 ;
	 

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
                                         self.file_version:='FraudPoint_V2';
																				 self.mode:='batch';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='FraudPoint_V2';
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

		  did_results := DATASET([{'FraudPoint_V2','batch','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
											
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.FP_V2_BATCH_Generic_FP1109_0_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.FP_V2_BATCH_Generic_FP1109_0_outfile[2..] + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.FP_V2_BATCH_Generic_FP1109_0_outfile[2..] + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2);

return seq;

endmacro;

	