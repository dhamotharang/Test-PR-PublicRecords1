EXPORT compare_function_nonfcra_fpscoresattributes_v2(current_dt,previous_dt) := functionmacro



 file1:= dataset('~foreign::10.241.3.238::sghatti::out::nonfcra_fpscoresattributes_v2_'+previous_dt, RiskView_Attributes_Reports.nonfcra_fpscoresattributes_v2_layout,


 CSV(HEADING(single), QUOTE('"')));

 file2:= dataset('~foreign::10.241.3.238::sghatti::out::nonfcra_fpscoresattributes_v2_'+current_dt, RiskView_Attributes_Reports.nonfcra_fpscoresattributes_v2_layout,


 CSV(HEADING(single), QUOTE('"')));



aa:=join(file1,file2,left.accountnumber=right.accountnumber,inner);



DS1:=join(file1,aa,left.accountnumber=right.accountnumber,inner);

DS2:=join(file2,aa,left.accountnumber=right.accountnumber,inner);
   	    
      	
      	RiskView_Attributes_Reports.Range_func(DS1,'identityageoldest',ra1);
      	RiskView_Attributes_Reports.Range_func(DS1,'identityagenewest',ra2);
				RiskView_Attributes_Reports.Range_func(DS1,'sourcecreditbureauageoldest',ra3);
				RiskView_Attributes_Reports.Range_func(DS1,'sourcecreditbureauagenewest',ra4);
      	RiskView_Attributes_Reports.Range_func(DS1,'sourcecreditbureauagechange',ra5);
				RiskView_Attributes_Reports.Range_func(DS1,'variationaddrchangeage',ra6);
			 	RiskView_Attributes_Reports.Range_func(DS1,'ssnhighissueage',ra7);
      	RiskView_Attributes_Reports.Range_func(DS1,'ssnlowissueage',ra8);
				RiskView_Attributes_Reports.Range_func(DS1,'inputaddrageoldest',ra9);
				RiskView_Attributes_Reports.Range_func(DS1,'inputaddragenewest',ra10);
				RiskView_Attributes_Reports.Range_func(DS1,'curraddrageoldest',ra11);
				RiskView_Attributes_Reports.Range_func(DS1,'curraddragenewest',ra12);
				RiskView_Attributes_Reports.Range_func(DS1,'curraddrlenofres',ra13);
				RiskView_Attributes_Reports.Range_func(DS1,'prevaddrageoldest',ra14);
			 	RiskView_Attributes_Reports.Range_func(DS1,'prevaddragenewest',ra15);
				RiskView_Attributes_Reports.Range_func(DS1,'prevaddrlenofres',ra16);
				
				
	
				
			  	
      	ra:= ra1  + ra2  + ra3  + ra4 + ra5 + ra6 + ra7  + ra8  + ra9  + ra10 +
				     ra11 + ra12 + ra13 + ra14 + ra15 + ra16;
				
				
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'idveraddressassoccount',ra0_1);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'idverssnsourcecount',ra0_2);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'idveraddresssourcecount',ra0_3);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'idverdobsourcecount',ra0_4);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'sourcepublicrecordcount',ra0_5);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'sourcepublicrecordcountyear',ra0_6);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationidentitycount',ra0_7);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationssncount',ra0_8);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'variationssncountnew',ra0_9);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationmsourcesssncount',ra0_10);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationmsourcesssnunrelcount',ra0_11);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationlastnamecount',ra0_12);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationlastnamecountnew',ra0_13);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationaddrcountyear',ra0_14);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationaddrcountnew',ra0_15);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationdobcount',ra0_16);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationdobcountnew',ra0_17);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'variationphonecount',ra0_18);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationphonecountnew',ra0_19);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationsearchssncount',ra0_20);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'variationsearchaddrcount',ra0_21);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'variationsearchphonecount',ra0_22);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchcount',ra0_23);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchcountyear',ra0_24);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchcountmonth',ra0_25);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchcountweek',ra0_26);
		  		RiskView_Attributes_Reports.Range_Function_0(DS1,'searchcountday',ra0_27);
			  	RiskView_Attributes_Reports.Range_Function_0(DS1,'searchunverifiedssncountyear',ra0_28);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchunverifiedaddrcountyear',ra0_29);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchunverifieddobcountyear',ra0_30);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchunverifiedphonecountyear',ra0_31);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchbankingsearchcount',ra0_32);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchbankingsearchcountyear',ra0_33);
			 	  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchbankingsearchcountmonth',ra0_34);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchbankingsearchcountweek',ra0_35);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchbankingsearchcountday',ra0_36);
		   	  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchhighrisksearchcount',ra0_37);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchhighrisksearchcountyear',ra0_38);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'searchhighrisksearchcountmonth',ra0_39);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchhighrisksearchcountweek',ra0_40);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchhighrisksearchcountday',ra0_41);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchfraudsearchcount',ra0_42);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'searchfraudsearchcountyear',ra0_43);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchfraudsearchcountmonth',ra0_44);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchfraudsearchcountweek',ra0_45);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'searchhighrisksearchcountday',ra0_46);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'searchfraudsearchcount',ra0_47);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'searchfraudsearchcountyear',ra0_48);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'searchfraudsearchcountmonth',ra0_49);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'searchfraudsearchcountweek',ra0_50);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchfraudsearchcountday',ra0_51);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchlocatesearchcount',ra0_52);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchlocatesearchcountyear',ra0_53);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchlocatesearchcountmonth',ra0_54);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchlocatesearchcountweek',ra0_55);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchlocatesearchcountday',ra0_56);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'assoccount',ra0_57);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'assocsuspicousidentitiescount',ra0_58);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'assoccreditbureauonlycount',ra0_59);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'assoccreditbureauonlycountnew',ra0_60);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'assoccreditbureauonlycountmonth',ra0_61);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'assochighrisktopologycount',ra0_62);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'correlationssnnamecount',ra0_63);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'correlationssnaddrcount',ra0_64);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'correlationaddrnamecount',ra0_65);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'correlationaddrphonecount',ra0_66);
		  		RiskView_Attributes_Reports.Range_Function_0(DS1,'correlationphonelastnamecount',ra0_67);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divssnidentitycount',ra0_68);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divssnidentitycountnew',ra0_69);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divssnidentitymsourcecount',ra0_70);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divssnidentitymsourceurelcount',ra0_71);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divssnlnamecount',ra0_72);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divssnlnamecountnew',ra0_73);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divssnaddrcount',ra0_74);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divssnaddrcountnew',ra0_75);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divssnaddrmsourcecount',ra0_76);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddridentitycount',ra0_77);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddridentitycountnew',ra0_78);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddridentitymsourcecount',ra0_79);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddrsuspidentitycountnew',ra0_80);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddrssncount',ra0_81);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddrssncountnew',ra0_82);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddrssnmsourcecount',ra0_83);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddrphonecount',ra0_84);
					 RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddrphonecountnew',ra0_85);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'divaddrphonemsourcecount',ra0_86);
		  		RiskView_Attributes_Reports.Range_Function_0(DS1,'divphoneidentitycount',ra0_87);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'divphoneidentitycountnew',ra0_88);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divphoneidentitymsourcecount',ra0_89);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divphoneaddrcount',ra0_90);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divphoneaddrcountnew',ra0_91);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'divsearchssnidentitycount',ra0_92);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divsearchaddridentitycount',ra0_93);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divsearchaddrsuspidentitycount',ra0_94);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'divsearchphoneidentitycount',ra0_95);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchssnsearchcount',ra0_96);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchssnsearchcountyear',ra0_97);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchssnsearchcountmonth',ra0_98);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'searchssnsearchcountweek',ra0_99);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchssnsearchcountday',ra0_100);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchaddrsearchcount',ra0_101);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'searchaddrsearchcountyear',ra0_102);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchaddrsearchcountmonth',ra0_103);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchaddrsearchcountweek',ra0_104);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchaddrsearchcountday',ra0_105);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchphonesearchcount',ra0_106);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchphonesearchcountyear',ra0_107);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchphonesearchcountmonth',ra0_108);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'searchphonesearchcountweek',ra0_109);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'searchphonesearchcountday',ra0_110);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrbusinesscount',ra0_111);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrnbrhdbusinesscount',ra0_112);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrnbrhdsinglefamilycount',ra0_113);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrnbrhdmultifamilycount',ra0_114);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrnbrhdvacantpropcount',ra0_115);
					
					
						
								ra_0:= ra0_1  + ra0_2  + ra0_3  + ra0_4  + ra0_5  + ra0_6  + ra0_7  + ra0_8  + ra0_9  + ra0_10 +
				               ra0_11 + ra0_12 + ra0_13 + ra0_14 + ra0_15 + ra0_16 + ra0_17 + ra0_18 + ra0_19 + ra0_20 +
						           ra0_21 + ra0_22 + ra0_23 + ra0_24 + ra0_25 + ra0_26 + ra0_27 + ra0_28 + ra0_29 + ra0_30 +
				               ra0_31 + ra0_32 + ra0_33 + ra0_34 + ra0_35 + ra0_36 + ra0_37 + ra0_38 + ra0_39 + ra0_40 +
				               ra0_41 + ra0_42 + ra0_43 + ra0_44 + ra0_45       +
                       ra0_51 + ra0_52 + ra0_53 + ra0_54 + ra0_55 + ra0_56 + ra0_57 + ra0_58 + ra0_59 + ra0_60 +
                       ra0_61 + ra0_62 + ra0_63 + ra0_64 + ra0_65 + ra0_66 + ra0_67 + ra0_68 + ra0_69 + ra0_70 + 
                       ra0_71 + ra0_72 + ra0_73 + ra0_74 + ra0_75 + ra0_76 + ra0_77 + ra0_78 + ra0_79 + ra0_80 + 
                       ra0_81 + ra0_82 + ra0_83 + ra0_84 + ra0_85 + ra0_86 + ra0_87 + ra0_88 + ra0_89 + ra0_90 + 
					             ra0_91 + ra0_92 + ra0_93 + ra0_94 + ra0_95 + ra0_96 + ra0_97 + ra0_98 + ra0_99 + ra0_100 + 
				               ra0_101 + ra0_102 + ra0_103 + ra0_104 + ra0_105 + ra0_106 + ra0_107 + ra0_108 + ra0_109 + ra0_110 + 
											 ra0_111 + ra0_112 + ra0_113 + ra0_114 + ra0_115;
								
								RiskView_Attributes_Reports.Range_Function_1(DS1,'inputaddrnbrhdmobilityindex',ra1_1);
								
											
						
											 
											 ra_1:=ra1_1;
				
								 RiskView_Attributes_Reports.Range_Function_2(DS1,'identityrecordcount',ra2_1);
								 RiskView_Attributes_Reports.Range_Function_2(DS1,'identitysourcecount',ra2_2);
								 
								
							      	 ra_2:=ra2_1 + ra2_2;
								 
								
								 
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'inputaddrnbrhdmurderindex',ra5_1);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'inputaddrnbrhdcartheftindex',ra5_2);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'inputaddrnbrhdburglaryindex',ra5_3);
								 RiskView_Attributes_Reports.Range_Function_5(DS1,'inputaddrnbrhdcrimeindex',ra5_4);
								
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
										 
										  
									 
								
				
					RiskView_Attributes_Reports.Distinct_function(DS1,'identityrisklevel',di1);
					RiskView_Attributes_Reports.Distinct_function(DS1,'identityrecentupdate',di2);
					RiskView_Attributes_Reports.Distinct_function(DS1,'identityageriskindicator',di3);
					RiskView_Attributes_Reports.Distinct_function(DS1,'idverrisklevel',di4);
					RiskView_Attributes_Reports.Distinct_function(DS1,'idverssn',di5);
					RiskView_Attributes_Reports.Distinct_function(DS1,'idvername',di6);
					RiskView_Attributes_Reports.Distinct_function(DS1,'idveraddress',di7);
					RiskView_Attributes_Reports.Distinct_function(DS1,'idveraddressnotcurrent',di8);
					RiskView_Attributes_Reports.Distinct_function(DS1,'idverphone',di9);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'idverdriverslicense',di10);
					RiskView_Attributes_Reports.Distinct_function(DS1,'idverdob',di11);				
					RiskView_Attributes_Reports.Distinct_function(DS1,'idverssncreditbureaucount',di12);
					RiskView_Attributes_Reports.Distinct_function(DS1,'idverssncreditbureaudelete',di13);
					RiskView_Attributes_Reports.Distinct_function(DS1,'idveraddrcreditbureaucount',di14);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourcerisklevel',di15);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourcefirstreportingidentity',di16);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourcecreditbureau',di17);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourcecreditbureaucount',di18);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourcepublicrecord',di19);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourceeducation',di20);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourceoccupationallicense',di21);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourcevoterregistration',di22);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourceonlinedirectory',di23);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourcedonotmail',di24);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourceaccidents',di25);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourcebusinessrecords',di26);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourceproperty',di27);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourceassets',di28);
			    RiskView_Attributes_Reports.Distinct_function(DS1,'sourcephonedirectoryassistance',di29);
					RiskView_Attributes_Reports.Distinct_function(DS1,'sourcephonenonpublicdirectory',di30);
					RiskView_Attributes_Reports.Distinct_function(DS1,'variationrisklevel',di31);
					RiskView_Attributes_Reports.Distinct_function(DS1,'variationaddrstability',di32);
					RiskView_Attributes_Reports.Distinct_function(DS1,'assocrisklevel',di33);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'assocdistanceclosest',di34);
					RiskView_Attributes_Reports.Distinct_function(DS1,'validationrisklevel',di35);
					RiskView_Attributes_Reports.Distinct_function(DS1,'validationssnproblems',di36);
					RiskView_Attributes_Reports.Distinct_function(DS1,'validationaddrproblems',di37);
					RiskView_Attributes_Reports.Distinct_function(DS1,'validationphoneproblems',di38);
					RiskView_Attributes_Reports.Distinct_function(DS1,'validationdlproblems',di39);
					RiskView_Attributes_Reports.Distinct_function(DS1,'validationipproblems',di40);
					RiskView_Attributes_Reports.Distinct_function(DS1,'correlationrisklevel',di41);
					RiskView_Attributes_Reports.Distinct_function(DS1,'divrisklevel',di42);
	        RiskView_Attributes_Reports.Distinct_function(DS1,'searchcomponentrisklevel',di43);
					RiskView_Attributes_Reports.Distinct_function(DS1,'componentcharrisklevel',di44);					
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnissuestate',di45);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnnonus',di46);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputphonetype',di47);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ipstate',di48);
			  	RiskView_Attributes_Reports.Distinct_function(DS1,'ipcountry',di49);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ipcontinent',di50);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrtype',di51);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrdwelltype',di52);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrdelivery',di53);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddractivephonelist',di54);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddroccupantowned',di55);					
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrchangeecontrajectory',di56);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrchangeecontrajectoryindex',di57);					
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrdwelltype',di58);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrstatus',di59);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'curraddractivephonelist',di60);					
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrdwelltype',di61);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrstatus',di62);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddroccupantowned',di63);
					
				
					
					di:= di1  + di2  + di3  + di4  + di5  + di6  + di7  + di8  + di9  + di10 +
				       di11 + di12 + di13 + di14 + di15 + di16 + di17 + di18 + di19 + di20 +
						   di21 + di22 + di23 + di24 + di25 + di26 + di27 + di28 + di29 + di30 +
				       di31 + di32 + di33 + di34 + di35 + di36 + di37 + di38 + di39 + di40 +
				       di41 + di42 + di43 + di44 + di45 + di46 + di47 + di48 + di49 + di50 +
						   di51 + di52 + di53 + di54 + di55 + di56 + di57 + di58 + di59 + di60 +
               di61 + di62 + di63;
				
				
						
				  	
				
				
					result1_stats:= ra + di + ra_0 + ra_1 + ra_2 + ra_5  ;
					
		      	// result1_stats;
				///////////////////////////////////////////////////////////////////////////////
				///////////////////////////////////////////////////////////////////////////////
				//////////////////////////////////////////////////////////////////////////////
				

      	
        RiskView_Attributes_Reports.Range_func(DS2,'identityageoldest',ran1);
      	RiskView_Attributes_Reports.Range_func(DS2,'identityagenewest',ran2);
				RiskView_Attributes_Reports.Range_func(DS2,'sourcecreditbureauageoldest',ran3);
				RiskView_Attributes_Reports.Range_func(DS2,'sourcecreditbureauagenewest',ran4);
      	RiskView_Attributes_Reports.Range_func(DS2,'sourcecreditbureauagechange',ran5);
				RiskView_Attributes_Reports.Range_func(DS2,'variationaddrchangeage',ran6);
			 	RiskView_Attributes_Reports.Range_func(DS2,'ssnhighissueage',ran7);
      	RiskView_Attributes_Reports.Range_func(DS2,'ssnlowissueage',ran8);
				RiskView_Attributes_Reports.Range_func(DS2,'inputaddrageoldest',ran9);
				RiskView_Attributes_Reports.Range_func(DS2,'inputaddragenewest',ran10);
				RiskView_Attributes_Reports.Range_func(DS2,'curraddrageoldest',ran11);
				RiskView_Attributes_Reports.Range_func(DS2,'curraddragenewest',ran12);
				RiskView_Attributes_Reports.Range_func(DS2,'curraddrlenofres',ran13);
				RiskView_Attributes_Reports.Range_func(DS2,'prevaddrageoldest',ran14);
			 	RiskView_Attributes_Reports.Range_func(DS2,'prevaddragenewest',ran15);
				RiskView_Attributes_Reports.Range_func(DS2,'prevaddrlenofres',ran16);
				
      	
      	
      	ran:= ran1  + ran2  + ran3  + ran4 + ran5 + ran6  + ran7  + ran8  + ran9  + ran10 +
				     ran11 + ran12 + ran13 + ran14 + ran15 + ran16;
      	
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'idveraddressassoccount',ran0_1);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'idverssnsourcecount',ran0_2);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'idveraddresssourcecount',ran0_3);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'idverdobsourcecount',ran0_4);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'sourcepublicrecordcount',ran0_5);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'sourcepublicrecordcountyear',ran0_6);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationidentitycount',ran0_7);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationssncount',ran0_8);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'variationssncountnew',ran0_9);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationmsourcesssncount',ran0_10);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationmsourcesssnunrelcount',ran0_11);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationlastnamecount',ran0_12);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationlastnamecountnew',ran0_13);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationaddrcountyear',ran0_14);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationaddrcountnew',ran0_15);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationdobcount',ran0_16);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationdobcountnew',ran0_17);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'variationphonecount',ran0_18);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationphonecountnew',ran0_19);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationsearchssncount',ran0_20);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'variationsearchaddrcount',ran0_21);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'variationsearchphonecount',ran0_22);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchcount',ran0_23);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchcountyear',ran0_24);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchcountmonth',ran0_25);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchcountweek',ran0_26);
		  		RiskView_Attributes_Reports.Range_Function_0(DS2,'searchcountday',ran0_27);
			  	RiskView_Attributes_Reports.Range_Function_0(DS2,'searchunverifiedssncountyear',ran0_28);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchunverifiedaddrcountyear',ran0_29);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchunverifieddobcountyear',ran0_30);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchunverifiedphonecountyear',ran0_31);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchbankingsearchcount',ran0_32);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchbankingsearchcountyear',ran0_33);
			 	  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchbankingsearchcountmonth',ran0_34);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchbankingsearchcountweek',ran0_35);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchbankingsearchcountday',ran0_36);
		   	  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchhighrisksearchcount',ran0_37);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchhighrisksearchcountyear',ran0_38);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'searchhighrisksearchcountmonth',ran0_39);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchhighrisksearchcountweek',ran0_40);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchhighrisksearchcountday',ran0_41);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchfraudsearchcount',ran0_42);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'searchfraudsearchcountyear',ran0_43);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchfraudsearchcountmonth',ran0_44);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchfraudsearchcountweek',ran0_45);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'searchhighrisksearchcountday',ran0_46);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'searchfraudsearchcount',ran0_47);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'searchfraudsearchcountyear',ran0_48);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'searchfraudsearchcountmonth',ran0_49);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'searchfraudsearchcountweek',ran0_50);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchfraudsearchcountday',ran0_51);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchlocatesearchcount',ran0_52);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchlocatesearchcountyear',ran0_53);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchlocatesearchcountmonth',ran0_54);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchlocatesearchcountweek',ran0_55);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchlocatesearchcountday',ran0_56);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'assoccount',ran0_57);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'assocsuspicousidentitiescount',ran0_58);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'assoccreditbureauonlycount',ran0_59);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'assoccreditbureauonlycountnew',ran0_60);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'assoccreditbureauonlycountmonth',ran0_61);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'assochighrisktopologycount',ran0_62);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'correlationssnnamecount',ran0_63);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'correlationssnaddrcount',ran0_64);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'correlationaddrnamecount',ran0_65);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'correlationaddrphonecount',ran0_66);
		  		RiskView_Attributes_Reports.Range_Function_0(DS2,'correlationphonelastnamecount',ran0_67);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divssnidentitycount',ran0_68);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divssnidentitycountnew',ran0_69);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divssnidentitymsourcecount',ran0_70);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divssnidentitymsourceurelcount',ran0_71);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divssnlnamecount',ran0_72);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divssnlnamecountnew',ran0_73);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divssnaddrcount',ran0_74);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divssnaddrcountnew',ran0_75);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divssnaddrmsourcecount',ran0_76);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddridentitycount',ran0_77);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddridentitycountnew',ran0_78);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddridentitymsourcecount',ran0_79);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddrsuspidentitycountnew',ran0_80);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddrssncount',ran0_81);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddrssncountnew',ran0_82);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddrssnmsourcecount',ran0_83);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddrphonecount',ran0_84);
					 RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddrphonecountnew',ran0_85);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'divaddrphonemsourcecount',ran0_86);
		  		RiskView_Attributes_Reports.Range_Function_0(DS2,'divphoneidentitycount',ran0_87);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'divphoneidentitycountnew',ran0_88);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divphoneidentitymsourcecount',ran0_89);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divphoneaddrcount',ran0_90);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divphoneaddrcountnew',ran0_91);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'divsearchssnidentitycount',ran0_92);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divsearchaddridentitycount',ran0_93);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divsearchaddrsuspidentitycount',ran0_94);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'divsearchphoneidentitycount',ran0_95);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchssnsearchcount',ran0_96);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchssnsearchcountyear',ran0_97);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchssnsearchcountmonth',ran0_98);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'searchssnsearchcountweek',ran0_99);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchssnsearchcountday',ran0_100);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchaddrsearchcount',ran0_101);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'searchaddrsearchcountyear',ran0_102);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchaddrsearchcountmonth',ran0_103);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchaddrsearchcountweek',ran0_104);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchaddrsearchcountday',ran0_105);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchphonesearchcount',ran0_106);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchphonesearchcountyear',ran0_107);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchphonesearchcountmonth',ran0_108);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'searchphonesearchcountweek',ran0_109);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'searchphonesearchcountday',ran0_110);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrbusinesscount',ran0_111);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrnbrhdbusinesscount',ran0_112);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrnbrhdsinglefamilycount',ran0_113);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrnbrhdmultifamilycount',ran0_114);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrnbrhdvacantpropcount',ran0_115);
						
						
					 	 ran_0:=   ran0_1  + ran0_2  + ran0_3  + ran0_4  + ran0_5  + ran0_6  + ran0_7  + ran0_8  + ran0_9  + ran0_10 +
				               ran0_11 + ran0_12 + ran0_13 + ran0_14 + ran0_15 + ran0_16 + ran0_17 + ran0_18 + ran0_19 + ran0_20 +
						           ran0_21 + ran0_22 + ran0_23 + ran0_24 + ran0_25 + ran0_26 + ran0_27 + ran0_28 + ran0_29 + ran0_30 +
				               ran0_31 + ran0_32 + ran0_33 + ran0_34 + ran0_35 + ran0_36 + ran0_37 + ran0_38 + ran0_39 + ran0_40 +
				               ran0_41 + ran0_42 + ran0_43 + ran0_44 + ran0_45    +
                       ran0_51 + ran0_52 + ran0_53 + ran0_54 + ran0_55 + ran0_56 + ran0_57 + ran0_58 + ran0_59 + ran0_60 +
                       ran0_61 + ran0_62 + ran0_63 + ran0_64 + ran0_65 + ran0_66 + ran0_67 + ran0_68 + ran0_69 + ran0_70 + 
                       ran0_71 + ran0_72 + ran0_73 + ran0_74 + ran0_75 + ran0_76 + ran0_77 + ran0_78 + ran0_79 + ran0_80 + 
                       ran0_81 + ran0_82 + ran0_83 + ran0_84 + ran0_85+ ran0_86 + ran0_87 + ran0_88 + ran0_89 + ran0_90 + 
					             ran0_91 + ran0_92 + ran0_93 + ran0_94 + ran0_95 + ran0_96 + ran0_97 + ran0_98 + ran0_99 + ran0_100 + 
				               ran0_101 + ran0_102 + ran0_103 + ran0_104 + ran0_105 + ran0_106 + ran0_107 + ran0_108 + ran0_109 + ran0_110 + 
											 ran0_111 + ran0_112 + ran0_113 + ran0_114 + ran0_115;
			
						RiskView_Attributes_Reports.Range_Function_1(DS2,'inputaddrnbrhdmobilityindex',ran1_1);
								
								
																	 
											 ran_1:=ran1_1;
				
								
								 RiskView_Attributes_Reports.Range_Function_2(DS2,'identityrecordcount',ran2_1);
								 RiskView_Attributes_Reports.Range_Function_2(DS2,'identitysourcecount',ran2_2);
								
							      	
											 
											 					 ran_2:=ran2_1 + ran2_2;
								 
								
								 
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'inputaddrnbrhdmurderindex',ran5_1);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'inputaddrnbrhdcartheftindex',ran5_2);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'inputaddrnbrhdburglaryindex',ran5_3);
								 RiskView_Attributes_Reports.Range_Function_5(DS2,'inputaddrnbrhdcrimeindex',ran5_4);
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
													 
										 	
											
											
													
										
										  				
					RiskView_Attributes_Reports.Distinct_function(DS2,'identityrisklevel',dis1);
					RiskView_Attributes_Reports.Distinct_function(DS2,'identityrecentupdate',dis2);
					RiskView_Attributes_Reports.Distinct_function(DS2,'identityageriskindicator',dis3);
					RiskView_Attributes_Reports.Distinct_function(DS2,'idverrisklevel',dis4);
					RiskView_Attributes_Reports.Distinct_function(DS2,'idverssn',dis5);
					RiskView_Attributes_Reports.Distinct_function(DS2,'idvername',dis6);
					RiskView_Attributes_Reports.Distinct_function(DS2,'idveraddress',dis7);
					RiskView_Attributes_Reports.Distinct_function(DS2,'idveraddressnotcurrent',dis8);
					RiskView_Attributes_Reports.Distinct_function(DS2,'idverphone',dis9);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'idverdriverslicense',dis10);
					RiskView_Attributes_Reports.Distinct_function(DS2,'idverdob',dis11);				
					RiskView_Attributes_Reports.Distinct_function(DS2,'idverssncreditbureaucount',dis12);
					RiskView_Attributes_Reports.Distinct_function(DS2,'idverssncreditbureaudelete',dis13);
					RiskView_Attributes_Reports.Distinct_function(DS2,'idveraddrcreditbureaucount',dis14);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourcerisklevel',dis15);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourcefirstreportingidentity',dis16);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourcecreditbureau',dis17);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourcecreditbureaucount',dis18);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourcepublicrecord',dis19);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourceeducation',dis20);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourceoccupationallicense',dis21);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourcevoterregistration',dis22);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourceonlinedirectory',dis23);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourcedonotmail',dis24);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourceaccidents',dis25);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourcebusinessrecords',dis26);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourceproperty',dis27);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourceassets',dis28);
			    RiskView_Attributes_Reports.Distinct_function(DS2,'sourcephonedirectoryassistance',dis29);
					RiskView_Attributes_Reports.Distinct_function(DS2,'sourcephonenonpublicdirectory',dis30);
					RiskView_Attributes_Reports.Distinct_function(DS2,'variationrisklevel',dis31);
					RiskView_Attributes_Reports.Distinct_function(DS2,'variationaddrstability',dis32);
					RiskView_Attributes_Reports.Distinct_function(DS2,'assocrisklevel',dis33);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'assocdistanceclosest',dis34);
					RiskView_Attributes_Reports.Distinct_function(DS2,'validationrisklevel',dis35);
					RiskView_Attributes_Reports.Distinct_function(DS2,'validationssnproblems',dis36);
					RiskView_Attributes_Reports.Distinct_function(DS2,'validationaddrproblems',dis37);
					RiskView_Attributes_Reports.Distinct_function(DS2,'validationphoneproblems',dis38);
					RiskView_Attributes_Reports.Distinct_function(DS2,'validationdlproblems',dis39);
					RiskView_Attributes_Reports.Distinct_function(DS2,'validationipproblems',dis40);
					RiskView_Attributes_Reports.Distinct_function(DS2,'correlationrisklevel',dis41);
					RiskView_Attributes_Reports.Distinct_function(DS2,'divrisklevel',dis42);
	        RiskView_Attributes_Reports.Distinct_function(DS2,'searchcomponentrisklevel',dis43);
					RiskView_Attributes_Reports.Distinct_function(DS2,'componentcharrisklevel',dis44);					
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnissuestate',dis45);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnnonus',dis46);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputphonetype',dis47);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ipstate',dis48);
			  	RiskView_Attributes_Reports.Distinct_function(DS2,'ipcountry',dis49);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ipcontinent',dis50);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrtype',dis51);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrdwelltype',dis52);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrdelivery',dis53);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddractivephonelist',dis54);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddroccupantowned',dis55);					
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrchangeecontrajectory',dis56);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrchangeecontrajectoryindex',dis57);					
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrdwelltype',dis58);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrstatus',dis59);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'curraddractivephonelist',dis60);					
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrdwelltype',dis61);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrstatus',dis62);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddroccupantowned',dis63);
					
				
					
					dis:= dis1  + dis2  + dis3  + dis4  + dis5  + dis6  + dis7  + dis8  + dis9  + dis10 +
				       dis11 + dis12 + dis13 + dis14 + dis15 + dis16 + dis17 + dis18 + dis19 + dis20 +
						   dis21 + dis22 + dis23 + dis24 + dis25 + dis26 + dis27 + dis28 + dis29 + dis30 +
				       dis31 + dis32 + dis33 + dis34 + dis35 + dis36 + dis37 + dis38 + dis39 + dis40 +
				       dis41 + dis42 + dis43 + dis44 + dis45 + dis46 + dis47 + dis48 + dis49 + dis50 +
						   dis51 + dis52 + dis53 + dis54 + dis55 + dis56 + dis57 + dis58 + dis59 + dis60 +
               dis61 + dis62 + dis63;
				
				
				
				
								
      
			
			result2_stats:= ran + dis + ran_0 + ran_1 +ran_2 + ran_5 ;
   				
         	// result2_stats;
			/////////////////////////////////////////////////////////////////////////
			/////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////
					
				
				
				  RiskView_Attributes_Reports.Average_func(DS1,'idveraddressassoccount',av1);
					RiskView_Attributes_Reports.Average_func(DS1,'idverssnsourcecount',av2);
					RiskView_Attributes_Reports.Average_func(DS1,'idveraddresssourcecount',av3);
					RiskView_Attributes_Reports.Average_func(DS1,'idverdobsourcecount',av4);
					RiskView_Attributes_Reports.Average_func(DS1,'sourcepublicrecordcount',av5);
					RiskView_Attributes_Reports.Average_func(DS1,'sourcepublicrecordcountyear',av6);
					RiskView_Attributes_Reports.Average_func(DS1,'variationidentitycount',av7);
					RiskView_Attributes_Reports.Average_func(DS1,'variationssncount',av8);
			    RiskView_Attributes_Reports.Average_func(DS1,'variationssncountnew',av9);
					RiskView_Attributes_Reports.Average_func(DS1,'variationmsourcesssncount',av10);
					RiskView_Attributes_Reports.Average_func(DS1,'variationmsourcesssnunrelcount',av11);
					RiskView_Attributes_Reports.Average_func(DS1,'variationlastnamecount',av12);
					RiskView_Attributes_Reports.Average_func(DS1,'variationlastnamecountnew',av13);
					RiskView_Attributes_Reports.Average_func(DS1,'variationaddrcountyear',av14);
					RiskView_Attributes_Reports.Average_func(DS1,'variationaddrcountnew',av15);
					RiskView_Attributes_Reports.Average_func(DS1,'variationdobcount',av16);
					RiskView_Attributes_Reports.Average_func(DS1,'variationdobcountnew',av17);
				  RiskView_Attributes_Reports.Average_func(DS1,'variationphonecount',av18);
					RiskView_Attributes_Reports.Average_func(DS1,'variationphonecountnew',av19);
					RiskView_Attributes_Reports.Average_func(DS1,'variationsearchssncount',av20);
					RiskView_Attributes_Reports.Average_func(DS1,'variationsearchaddrcount',av21);
				  RiskView_Attributes_Reports.Average_func(DS1,'variationsearchphonecount',av22);
					RiskView_Attributes_Reports.Average_func(DS1,'searchcount',av23);
					RiskView_Attributes_Reports.Average_func(DS1,'searchcountyear',av24);
					RiskView_Attributes_Reports.Average_func(DS1,'searchcountmonth',av25);
				  RiskView_Attributes_Reports.Average_func(DS1,'searchcountweek',av26);
		  		RiskView_Attributes_Reports.Average_func(DS1,'searchcountday',av27);
			  	RiskView_Attributes_Reports.Average_func(DS1,'searchunverifiedssncountyear',av28);
					RiskView_Attributes_Reports.Average_func(DS1,'searchunverifiedaddrcountyear',av29);
				  RiskView_Attributes_Reports.Average_func(DS1,'searchunverifieddobcountyear',av30);
      	  RiskView_Attributes_Reports.Average_func(DS1,'searchunverifiedphonecountyear',av31);
      	  RiskView_Attributes_Reports.Average_func(DS1,'searchbankingsearchcount',av32);
				  RiskView_Attributes_Reports.Average_func(DS1,'searchbankingsearchcountyear',av33);
			 	  RiskView_Attributes_Reports.Average_func(DS1,'searchbankingsearchcountmonth',av34);
				  RiskView_Attributes_Reports.Average_func(DS1,'searchbankingsearchcountweek',av35);
				  RiskView_Attributes_Reports.Average_func(DS1,'searchbankingsearchcountday',av36);
		   	  RiskView_Attributes_Reports.Average_func(DS1,'searchhighrisksearchcount',av37);
      	  RiskView_Attributes_Reports.Average_func(DS1,'searchhighrisksearchcountyear',av38);
			    RiskView_Attributes_Reports.Average_func(DS1,'searchhighrisksearchcountmonth',av39);
				  RiskView_Attributes_Reports.Average_func(DS1,'searchhighrisksearchcountweek',av40);
      	  RiskView_Attributes_Reports.Average_func(DS1,'searchhighrisksearchcountday',av41);
      	  RiskView_Attributes_Reports.Average_func(DS1,'searchfraudsearchcount',av42);
				  RiskView_Attributes_Reports.Average_func(DS1,'searchfraudsearchcountyear',av43);
					RiskView_Attributes_Reports.Average_func(DS1,'searchfraudsearchcountmonth',av44);
					RiskView_Attributes_Reports.Average_func(DS1,'searchfraudsearchcountweek',av45);
					// RiskView_Attributes_Reports.Average_func(DS1,'searchhighrisksearchcountday',av46);
					// RiskView_Attributes_Reports.Average_func(DS1,'searchfraudsearchcount',av47);
					// RiskView_Attributes_Reports.Average_func(DS1,'searchfraudsearchcountyear',av48);
					// RiskView_Attributes_Reports.Average_func(DS1,'searchfraudsearchcountmonth',av49);
					// RiskView_Attributes_Reports.Average_func(DS1,'searchfraudsearchcountweek',av50);
					RiskView_Attributes_Reports.Average_func(DS1,'searchfraudsearchcountday',av51);
					RiskView_Attributes_Reports.Average_func(DS1,'searchlocatesearchcount',av52);
					RiskView_Attributes_Reports.Average_func(DS1,'searchlocatesearchcountyear',av53);
					RiskView_Attributes_Reports.Average_func(DS1,'searchlocatesearchcountmonth',av54);
					RiskView_Attributes_Reports.Average_func(DS1,'searchlocatesearchcountweek',av55);
					RiskView_Attributes_Reports.Average_func(DS1,'searchlocatesearchcountday',av56);
					RiskView_Attributes_Reports.Average_func(DS1,'assoccount',av57);
					RiskView_Attributes_Reports.Average_func(DS1,'assocsuspicousidentitiescount',av58);
					RiskView_Attributes_Reports.Average_func(DS1,'assoccreditbureauonlycount',av59);
					RiskView_Attributes_Reports.Average_func(DS1,'assoccreditbureauonlycountnew',av60);
					RiskView_Attributes_Reports.Average_func(DS1,'assoccreditbureauonlycountmonth',av61);
				  RiskView_Attributes_Reports.Average_func(DS1,'assochighrisktopologycount',av62);
					RiskView_Attributes_Reports.Average_func(DS1,'correlationssnnamecount',av63);
					RiskView_Attributes_Reports.Average_func(DS1,'correlationssnaddrcount',av64);
					RiskView_Attributes_Reports.Average_func(DS1,'correlationaddrnamecount',av65);
				  RiskView_Attributes_Reports.Average_func(DS1,'correlationaddrphonecount',av66);
		  		RiskView_Attributes_Reports.Average_func(DS1,'correlationphonelastnamecount',av67);
					RiskView_Attributes_Reports.Average_func(DS1,'divssnidentitycount',av68);
					RiskView_Attributes_Reports.Average_func(DS1,'divssnidentitycountnew',av69);
					RiskView_Attributes_Reports.Average_func(DS1,'divssnidentitymsourcecount',av70);
					RiskView_Attributes_Reports.Average_func(DS1,'divssnidentitymsourceurelcount',av71);
					RiskView_Attributes_Reports.Average_func(DS1,'divssnlnamecount',av72);
					RiskView_Attributes_Reports.Average_func(DS1,'divssnlnamecountnew',av73);
					RiskView_Attributes_Reports.Average_func(DS1,'divssnaddrcount',av74);
					RiskView_Attributes_Reports.Average_func(DS1,'divssnaddrcountnew',av75);
					RiskView_Attributes_Reports.Average_func(DS1,'divssnaddrmsourcecount',av76);
					RiskView_Attributes_Reports.Average_func(DS1,'divaddridentitycount',av77);
				  RiskView_Attributes_Reports.Average_func(DS1,'divaddridentitycountnew',av78);
					RiskView_Attributes_Reports.Average_func(DS1,'divaddridentitymsourcecount',av79);
					RiskView_Attributes_Reports.Average_func(DS1,'divaddrsuspidentitycountnew',av80);
					RiskView_Attributes_Reports.Average_func(DS1,'divaddrssncount',av81);
				  RiskView_Attributes_Reports.Average_func(DS1,'divaddrssncountnew',av82);
					RiskView_Attributes_Reports.Average_func(DS1,'divaddrssnmsourcecount',av83);
					RiskView_Attributes_Reports.Average_func(DS1,'divaddrphonecount',av84);
					 RiskView_Attributes_Reports.Average_func(DS1,'divaddrphonecountnew',av85);
			    RiskView_Attributes_Reports.Average_func(DS1,'divaddrphonemsourcecount',av86);
		  		RiskView_Attributes_Reports.Average_func(DS1,'divphoneidentitycount',av87);
			    RiskView_Attributes_Reports.Average_func(DS1,'divphoneidentitycountnew',av88);
					RiskView_Attributes_Reports.Average_func(DS1,'divphoneidentitymsourcecount',av89);
					RiskView_Attributes_Reports.Average_func(DS1,'divphoneaddrcount',av90);
					RiskView_Attributes_Reports.Average_func(DS1,'divphoneaddrcountnew',av91);
				  RiskView_Attributes_Reports.Average_func(DS1,'divsearchssnidentitycount',av92);
					RiskView_Attributes_Reports.Average_func(DS1,'divsearchaddridentitycount',av93);
					RiskView_Attributes_Reports.Average_func(DS1,'divsearchaddrsuspidentitycount',av94);
					RiskView_Attributes_Reports.Average_func(DS1,'divsearchphoneidentitycount',av95);
					RiskView_Attributes_Reports.Average_func(DS1,'searchssnsearchcount',av96);
					RiskView_Attributes_Reports.Average_func(DS1,'searchssnsearchcountyear',av97);
					RiskView_Attributes_Reports.Average_func(DS1,'searchssnsearchcountmonth',av98);
			    RiskView_Attributes_Reports.Average_func(DS1,'searchssnsearchcountweek',av99);
					RiskView_Attributes_Reports.Average_func(DS1,'searchssnsearchcountday',av100);
					RiskView_Attributes_Reports.Average_func(DS1,'searchaddrsearchcount',av101);
			    RiskView_Attributes_Reports.Average_func(DS1,'searchaddrsearchcountyear',av102);
					RiskView_Attributes_Reports.Average_func(DS1,'searchaddrsearchcountmonth',av103);
					RiskView_Attributes_Reports.Average_func(DS1,'searchaddrsearchcountweek',av104);
					RiskView_Attributes_Reports.Average_func(DS1,'searchaddrsearchcountday',av105);
					RiskView_Attributes_Reports.Average_func(DS1,'searchphonesearchcount',av106);
					RiskView_Attributes_Reports.Average_func(DS1,'searchphonesearchcountyear',av107);
					RiskView_Attributes_Reports.Average_func(DS1,'searchphonesearchcountmonth',av108);
			    RiskView_Attributes_Reports.Average_func(DS1,'searchphonesearchcountweek',av109);
					RiskView_Attributes_Reports.Average_func(DS1,'searchphonesearchcountday',av110);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrbusinesscount',av111);
				  RiskView_Attributes_Reports.Average_func(DS1,'inputaddrnbrhdbusinesscount',av112);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrnbrhdsinglefamilycount',av113);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrnbrhdmultifamilycount',av114);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrnbrhdvacantpropcount',av115);
					RiskView_Attributes_Reports.Average_func(DS1,'identityrecordcount',av116);
				  RiskView_Attributes_Reports.Average_func(DS1,'identitysourcecount',av117);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrnbrhdmedianincome',av118);
      	RiskView_Attributes_Reports.Average_func(DS1,'inputaddrnbrhdmedianvalue',av119);
				RiskView_Attributes_Reports.Average_func(DS1,'addrchangedistance',av120);				
				RiskView_Attributes_Reports.Average_func(DS1,'curraddrmedianincome',av121);
		    RiskView_Attributes_Reports.Average_func(DS1,'curraddrmedianvalue',av122);				
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddrmedianincome',av123);
      	RiskView_Attributes_Reports.Average_func(DS1,'prevaddrmedianvalue',av124);
				RiskView_Attributes_Reports.Average_func(DS1,'identityageoldest',av125);
      	RiskView_Attributes_Reports.Average_func(DS1,'identityagenewest',av126);
				RiskView_Attributes_Reports.Average_func(DS1,'sourcecreditbureauageoldest',av127);
				RiskView_Attributes_Reports.Average_func(DS1,'sourcecreditbureauagenewest',av128);
      	RiskView_Attributes_Reports.Average_func(DS1,'sourcecreditbureauagechange',av129);
				RiskView_Attributes_Reports.Average_func(DS1,'variationaddrchangeage',av130);
			 	RiskView_Attributes_Reports.Average_func(DS1,'ssnhighissueage',av131);
      	RiskView_Attributes_Reports.Average_func(DS1,'ssnlowissueage',av132);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddrageoldest',av133);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddragenewest',av134);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddrageoldest',av135);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddragenewest',av136);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddrlenofres',av137);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddrageoldest',av138);
			 	RiskView_Attributes_Reports.Average_func(DS1,'prevaddragenewest',av139);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddrlenofres',av140);
      	
      	   av:= av1  + av2  + av3  + av4  + av5  + av6  + av7  + av8  + av9  + av10 +
				       av11 + av12 + av13 + av14 + av15 + av16 + av17 + av18 + av19 + av20 +
						   av21 + av22 + av23 + av24 + av25 + av26 + av27 + av28 + av29 + av30 +
				       av31 + av32 + av33 + av34 + av35 + av36 + av37 + av38 + av39 + av40 +
				       av41 + av42 + av43 + av44 + av45  +
						   av51 + av52 + av53 + av54 + av55 + av56 + av57 + av58 + av59 + av60 +
               av61 + av62 + av63 + av64 + av65 + av66 + av67 + av68 + av69 + av70 + 
               av71 + av72 + av73 + av74 + av75 + av76 + av77 + av78 + av79 + av80 + 
               av81 + av82 + av83 + av84 + av85 + av86 + av87 + av88 + av89 + av90 + 
					     av91 + av92 + av93 + av94 + av95 + av96 + av97 + av98 + av99 + av100+ 
				       av101 + av102 + av103 + av104 + av105 + av106 + av107 + av108 + av109 + av110+ 
						   av111 + av112 + av113 + av114 + av115 + av116 + av117 + av118 + av119 + av120+ 
				  	   av121 + av122 + av123 + av124 + av125 + av126 + av127 + av128 + av129 + av130+
						   av131 + av132 + av133 + av134 + av135 + av136 + av137 + av138 + av139 + av140;
					
			    RiskView_Attributes_Reports.Average_func(DS2,'idveraddressassoccount',ave1);
					RiskView_Attributes_Reports.Average_func(DS2,'idverssnsourcecount',ave2);
					RiskView_Attributes_Reports.Average_func(DS2,'idveraddresssourcecount',ave3);
					RiskView_Attributes_Reports.Average_func(DS2,'idverdobsourcecount',ave4);
					RiskView_Attributes_Reports.Average_func(DS2,'sourcepublicrecordcount',ave5);
					RiskView_Attributes_Reports.Average_func(DS2,'sourcepublicrecordcountyear',ave6);
					RiskView_Attributes_Reports.Average_func(DS2,'variationidentitycount',ave7);
					RiskView_Attributes_Reports.Average_func(DS2,'variationssncount',ave8);
			    RiskView_Attributes_Reports.Average_func(DS2,'variationssncountnew',ave9);
					RiskView_Attributes_Reports.Average_func(DS2,'variationmsourcesssncount',ave10);
					RiskView_Attributes_Reports.Average_func(DS2,'variationmsourcesssnunrelcount',ave11);
					RiskView_Attributes_Reports.Average_func(DS2,'variationlastnamecount',ave12);
					RiskView_Attributes_Reports.Average_func(DS2,'variationlastnamecountnew',ave13);
					RiskView_Attributes_Reports.Average_func(DS2,'variationaddrcountyear',ave14);
					RiskView_Attributes_Reports.Average_func(DS2,'variationaddrcountnew',ave15);
					RiskView_Attributes_Reports.Average_func(DS2,'variationdobcount',ave16);
					RiskView_Attributes_Reports.Average_func(DS2,'variationdobcountnew',ave17);
				  RiskView_Attributes_Reports.Average_func(DS2,'variationphonecount',ave18);
					RiskView_Attributes_Reports.Average_func(DS2,'variationphonecountnew',ave19);
					RiskView_Attributes_Reports.Average_func(DS2,'variationsearchssncount',ave20);
					RiskView_Attributes_Reports.Average_func(DS2,'variationsearchaddrcount',ave21);
				  RiskView_Attributes_Reports.Average_func(DS2,'variationsearchphonecount',ave22);
					RiskView_Attributes_Reports.Average_func(DS2,'searchcount',ave23);
					RiskView_Attributes_Reports.Average_func(DS2,'searchcountyear',ave24);
					RiskView_Attributes_Reports.Average_func(DS2,'searchcountmonth',ave25);
				  RiskView_Attributes_Reports.Average_func(DS2,'searchcountweek',ave26);
		  		RiskView_Attributes_Reports.Average_func(DS2,'searchcountday',ave27);
			  	RiskView_Attributes_Reports.Average_func(DS2,'searchunverifiedssncountyear',ave28);
					RiskView_Attributes_Reports.Average_func(DS2,'searchunverifiedaddrcountyear',ave29);
				  RiskView_Attributes_Reports.Average_func(DS2,'searchunverifieddobcountyear',ave30);
      	  RiskView_Attributes_Reports.Average_func(DS2,'searchunverifiedphonecountyear',ave31);
      	  RiskView_Attributes_Reports.Average_func(DS2,'searchbankingsearchcount',ave32);
				  RiskView_Attributes_Reports.Average_func(DS2,'searchbankingsearchcountyear',ave33);
			 	  RiskView_Attributes_Reports.Average_func(DS2,'searchbankingsearchcountmonth',ave34);
				  RiskView_Attributes_Reports.Average_func(DS2,'searchbankingsearchcountweek',ave35);
				  RiskView_Attributes_Reports.Average_func(DS2,'searchbankingsearchcountday',ave36);
		   	  RiskView_Attributes_Reports.Average_func(DS2,'searchhighrisksearchcount',ave37);
      	  RiskView_Attributes_Reports.Average_func(DS2,'searchhighrisksearchcountyear',ave38);
			    RiskView_Attributes_Reports.Average_func(DS2,'searchhighrisksearchcountmonth',ave39);
				  RiskView_Attributes_Reports.Average_func(DS2,'searchhighrisksearchcountweek',ave40);
      	  RiskView_Attributes_Reports.Average_func(DS2,'searchhighrisksearchcountday',ave41);
      	  RiskView_Attributes_Reports.Average_func(DS2,'searchfraudsearchcount',ave42);
				  RiskView_Attributes_Reports.Average_func(DS2,'searchfraudsearchcountyear',ave43);
					RiskView_Attributes_Reports.Average_func(DS2,'searchfraudsearchcountmonth',ave44);
					RiskView_Attributes_Reports.Average_func(DS2,'searchfraudsearchcountweek',ave45);
					// RiskView_Attributes_Reports.Average_func(DS2,'searchhighrisksearchcountday',ave46);
					// RiskView_Attributes_Reports.Average_func(DS2,'searchfraudsearchcount',ave47);
					// RiskView_Attributes_Reports.Average_func(DS2,'searchfraudsearchcountyear',ave48);
					// RiskView_Attributes_Reports.Average_func(DS2,'searchfraudsearchcountmonth',ave49);
					// RiskView_Attributes_Reports.Average_func(DS2,'searchfraudsearchcountweek',ave50);
					RiskView_Attributes_Reports.Average_func(DS2,'searchfraudsearchcountday',ave51);
					RiskView_Attributes_Reports.Average_func(DS2,'searchlocatesearchcount',ave52);
					RiskView_Attributes_Reports.Average_func(DS2,'searchlocatesearchcountyear',ave53);
					RiskView_Attributes_Reports.Average_func(DS2,'searchlocatesearchcountmonth',ave54);
					RiskView_Attributes_Reports.Average_func(DS2,'searchlocatesearchcountweek',ave55);
					RiskView_Attributes_Reports.Average_func(DS2,'searchlocatesearchcountday',ave56);
					RiskView_Attributes_Reports.Average_func(DS2,'assoccount',ave57);
					RiskView_Attributes_Reports.Average_func(DS2,'assocsuspicousidentitiescount',ave58);
					RiskView_Attributes_Reports.Average_func(DS2,'assoccreditbureauonlycount',ave59);
					RiskView_Attributes_Reports.Average_func(DS2,'assoccreditbureauonlycountnew',ave60);
					RiskView_Attributes_Reports.Average_func(DS2,'assoccreditbureauonlycountmonth',ave61);
				  RiskView_Attributes_Reports.Average_func(DS2,'assochighrisktopologycount',ave62);
					RiskView_Attributes_Reports.Average_func(DS2,'correlationssnnamecount',ave63);
					RiskView_Attributes_Reports.Average_func(DS2,'correlationssnaddrcount',ave64);
					RiskView_Attributes_Reports.Average_func(DS2,'correlationaddrnamecount',ave65);
				  RiskView_Attributes_Reports.Average_func(DS2,'correlationaddrphonecount',ave66);
		  		RiskView_Attributes_Reports.Average_func(DS2,'correlationphonelastnamecount',ave67);
					RiskView_Attributes_Reports.Average_func(DS2,'divssnidentitycount',ave68);
					RiskView_Attributes_Reports.Average_func(DS2,'divssnidentitycountnew',ave69);
					RiskView_Attributes_Reports.Average_func(DS2,'divssnidentitymsourcecount',ave70);
					RiskView_Attributes_Reports.Average_func(DS2,'divssnidentitymsourceurelcount',ave71);
					RiskView_Attributes_Reports.Average_func(DS2,'divssnlnamecount',ave72);
					RiskView_Attributes_Reports.Average_func(DS2,'divssnlnamecountnew',ave73);
					RiskView_Attributes_Reports.Average_func(DS2,'divssnaddrcount',ave74);
					RiskView_Attributes_Reports.Average_func(DS2,'divssnaddrcountnew',ave75);
					RiskView_Attributes_Reports.Average_func(DS2,'divssnaddrmsourcecount',ave76);
					RiskView_Attributes_Reports.Average_func(DS2,'divaddridentitycount',ave77);
				  RiskView_Attributes_Reports.Average_func(DS2,'divaddridentitycountnew',ave78);
					RiskView_Attributes_Reports.Average_func(DS2,'divaddridentitymsourcecount',ave79);
					RiskView_Attributes_Reports.Average_func(DS2,'divaddrsuspidentitycountnew',ave80);
					RiskView_Attributes_Reports.Average_func(DS2,'divaddrssncount',ave81);
				  RiskView_Attributes_Reports.Average_func(DS2,'divaddrssncountnew',ave82);
					RiskView_Attributes_Reports.Average_func(DS2,'divaddrssnmsourcecount',ave83);
					RiskView_Attributes_Reports.Average_func(DS2,'divaddrphonecount',ave84);
					 RiskView_Attributes_Reports.Average_func(DS2,'divaddrphonecountnew',ave85);
			    RiskView_Attributes_Reports.Average_func(DS2,'divaddrphonemsourcecount',ave86);
		  		RiskView_Attributes_Reports.Average_func(DS2,'divphoneidentitycount',ave87);
			    RiskView_Attributes_Reports.Average_func(DS2,'divphoneidentitycountnew',ave88);
					RiskView_Attributes_Reports.Average_func(DS2,'divphoneidentitymsourcecount',ave89);
					RiskView_Attributes_Reports.Average_func(DS2,'divphoneaddrcount',ave90);
					RiskView_Attributes_Reports.Average_func(DS2,'divphoneaddrcountnew',ave91);
				  RiskView_Attributes_Reports.Average_func(DS2,'divsearchssnidentitycount',ave92);
					RiskView_Attributes_Reports.Average_func(DS2,'divsearchaddridentitycount',ave93);
					RiskView_Attributes_Reports.Average_func(DS2,'divsearchaddrsuspidentitycount',ave94);
					RiskView_Attributes_Reports.Average_func(DS2,'divsearchphoneidentitycount',ave95);
					RiskView_Attributes_Reports.Average_func(DS2,'searchssnsearchcount',ave96);
					RiskView_Attributes_Reports.Average_func(DS2,'searchssnsearchcountyear',ave97);
					RiskView_Attributes_Reports.Average_func(DS2,'searchssnsearchcountmonth',ave98);
			    RiskView_Attributes_Reports.Average_func(DS2,'searchssnsearchcountweek',ave99);
					RiskView_Attributes_Reports.Average_func(DS2,'searchssnsearchcountday',ave100);
					RiskView_Attributes_Reports.Average_func(DS2,'searchaddrsearchcount',ave101);
			    RiskView_Attributes_Reports.Average_func(DS2,'searchaddrsearchcountyear',ave102);
					RiskView_Attributes_Reports.Average_func(DS2,'searchaddrsearchcountmonth',ave103);
					RiskView_Attributes_Reports.Average_func(DS2,'searchaddrsearchcountweek',ave104);
					RiskView_Attributes_Reports.Average_func(DS2,'searchaddrsearchcountday',ave105);
					RiskView_Attributes_Reports.Average_func(DS2,'searchphonesearchcount',ave106);
					RiskView_Attributes_Reports.Average_func(DS2,'searchphonesearchcountyear',ave107);
					RiskView_Attributes_Reports.Average_func(DS2,'searchphonesearchcountmonth',ave108);
			    RiskView_Attributes_Reports.Average_func(DS2,'searchphonesearchcountweek',ave109);
					RiskView_Attributes_Reports.Average_func(DS2,'searchphonesearchcountday',ave110);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrbusinesscount',ave111);
				  RiskView_Attributes_Reports.Average_func(DS2,'inputaddrnbrhdbusinesscount',ave112);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrnbrhdsinglefamilycount',ave113);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrnbrhdmultifamilycount',ave114);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrnbrhdvacantpropcount',ave115);
					RiskView_Attributes_Reports.Average_func(DS2,'identityrecordcount',ave116);
				  RiskView_Attributes_Reports.Average_func(DS2,'identitysourcecount',ave117);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrnbrhdmedianincome',ave118);
      	RiskView_Attributes_Reports.Average_func(DS2,'inputaddrnbrhdmedianvalue',ave119);
				RiskView_Attributes_Reports.Average_func(DS2,'addrchangedistance',ave120);				
				RiskView_Attributes_Reports.Average_func(DS2,'curraddrmedianincome',ave121);
		    RiskView_Attributes_Reports.Average_func(DS2,'curraddrmedianvalue',ave122);				
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddrmedianincome',ave123);
      	RiskView_Attributes_Reports.Average_func(DS2,'prevaddrmedianvalue',ave124);
				RiskView_Attributes_Reports.Average_func(DS2,'identityageoldest',ave125);
      	RiskView_Attributes_Reports.Average_func(DS2,'identityagenewest',ave126);
				RiskView_Attributes_Reports.Average_func(DS2,'sourcecreditbureauageoldest',ave127);
				RiskView_Attributes_Reports.Average_func(DS2,'sourcecreditbureauagenewest',ave128);
      	RiskView_Attributes_Reports.Average_func(DS2,'sourcecreditbureauagechange',ave129);
				RiskView_Attributes_Reports.Average_func(DS2,'variationaddrchangeage',ave130);
			 	RiskView_Attributes_Reports.Average_func(DS2,'ssnhighissueage',ave131);
      	RiskView_Attributes_Reports.Average_func(DS2,'ssnlowissueage',ave132);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddrageoldest',ave133);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddragenewest',ave134);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddrageoldest',ave135);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddragenewest',ave136);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddrlenofres',ave137);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddrageoldest',ave138);
			 	RiskView_Attributes_Reports.Average_func(DS2,'prevaddragenewest',ave139);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddrlenofres',ave140);
      	
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
				
      	
								
											 
										 
											 
						
	
	
	 RiskView_Attributes_Reports.Range_Average_Function_2(DS1,'addrchangeincomediff',ranav1_1);
		 RiskView_Attributes_Reports.Range_Average_Function_2(DS1,'addrchangevaluediff',ranav1_2);
		 	
			ranav2:=ranav1_1 + ranav1_2;
											 
						
	
	
		 RiskView_Attributes_Reports.Range_Average_Function_2(DS2,'addrchangeincomediff',ranave1_1);
		 RiskView_Attributes_Reports.Range_Average_Function_2(DS2,'addrchangevaluediff',ranave1_2);
		 
	ranave2:=ranave1_1 + ranave1_2;
	
	 result3_stats:=av   + ranav2;
   result4_stats:=avearage  + ranave2 ;
	 
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
   																							,transform(	compare_layout, self.file_version:='nonfcra_fpscoresattributes_v2',
																								                            self.mode:='xml',
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
   																							,transform(	compare_layout, self.file_version:='nonfcra_fpscoresattributes_v2',
																								                            self.mode:='xml',
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