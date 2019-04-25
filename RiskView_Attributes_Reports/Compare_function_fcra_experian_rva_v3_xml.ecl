EXPORT Compare_function_fcra_experian_rva_v3_xml(current_dt,previous_dt) := functionmacro



file1:= dataset('~foreign::10.241.3.238::sghatti::out::fcra_experian_rva_30_cust_rec_'+previous_dt, RiskView_Attributes_Reports.fcra_experian_rva_v3_xml_layout,


 CSV(HEADING(single), QUOTE('"')));
file2:= dataset('~foreign::10.241.3.238::sghatti::out::fcra_experian_rva_30_cust_rec_'+current_dt, RiskView_Attributes_Reports.fcra_experian_rva_v3_xml_layout,


 CSV(HEADING(single), QUOTE('"')));




	 
   
	   
	
aa:=join(file1,file2,left.accountnumber=right.accountnumber,inner);



DS1:=join(file1,aa,left.accountnumber=right.accountnumber,inner);

DS2:=join(file2,aa,left.accountnumber=right.accountnumber,inner);


	  	
      	RiskView_Attributes_Reports.Range_func(DS1,'ageoldestrecord',ra1);
      	RiskView_Attributes_Reports.Range_func(DS1,'agenewestrecord',ra2);
				RiskView_Attributes_Reports.Range_func(DS1,'iaageoldestrecord',ra3);
      	RiskView_Attributes_Reports.Range_func(DS1,'iaagenewestrecord',ra4);
      	RiskView_Attributes_Reports.Range_func(DS1,'ialenofres',ra5);
				RiskView_Attributes_Reports.Range_func(DS1,'iaagelastsale',ra6);
				RiskView_Attributes_Reports.Range_func(DS1,'caageoldestrecord',ra7);
      	RiskView_Attributes_Reports.Range_func(DS1,'caagenewestrecord',ra8);
				RiskView_Attributes_Reports.Range_func(DS1,'calenofres',ra9);
				RiskView_Attributes_Reports.Range_func(DS1,'paageoldestrecord',ra10);
      	RiskView_Attributes_Reports.Range_func(DS1,'paagenewestrecord',ra11);
				RiskView_Attributes_Reports.Range_func(DS1,'palenofres',ra12);
				RiskView_Attributes_Reports.Range_func(DS1,'paagelastsale',ra13);
				RiskView_Attributes_Reports.Range_func(DS1,'caagelastsale',ra14);
				RiskView_Attributes_Reports.Range_func(DS1,'distinputcurr',ra15);
				RiskView_Attributes_Reports.Range_func(DS1,'propageoldestpurchase',ra16);
      	RiskView_Attributes_Reports.Range_func(DS1,'propagenewestpurchase',ra17);
				// RiskView_Attributes_Reports.Range_func(DS1,'derogage',ra18);
				// RiskView_Attributes_Reports.Range_func(DS1,'felonyage',ra19);
				// RiskView_Attributes_Reports.Range_func(DS1,'lienfiledage',ra20);
				// RiskView_Attributes_Reports.Range_func(DS1,'evictionage',ra21);
				RiskView_Attributes_Reports.Range_func(DS1,'proflicage',ra22);
				RiskView_Attributes_Reports.Range_func(DS1,'inferredminimumage',ra23);
				RiskView_Attributes_Reports.Range_func(DS1,'bestreportedage',ra24);
				RiskView_Attributes_Reports.Range_func(DS1,'phoneedaageoldestrecord',ra25);
				RiskView_Attributes_Reports.Range_func(DS1,'phoneedaagenewestrecord',ra26);
      	RiskView_Attributes_Reports.Range_func(DS1,'phoneotherageoldestrecord',ra27);
      	RiskView_Attributes_Reports.Range_func(DS1,'phoneotheragenewestrecord',ra28);
				
			
      	
				
			  	
      	ra:= ra1  + ra2  + ra3  + ra4  + ra5  + ra6  + ra7  + ra8  + ra9  + ra10 +
				     ra11 + ra12 + ra13 + ra14 + ra15 + ra16 + ra17  + ra22 + ra23 + ra24 + ra25 + ra26 + ra27 + ra28;
      	
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
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddridentitiescount',ra0_11);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrssncount',ra0_12);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrphonecount',ra0_13);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddridentitiesrecentcount',ra0_14);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrssnrecentcount',ra0_15);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrphonerecentcount',ra0_16);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'phoneidentitiescount',ra0_17);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'phoneidentitiesrecentcount',ra0_18);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddravmconfidence',ra0_19);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'curraddravmconfidence',ra0_20);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'prevaddravmconfidence',ra0_21);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount',ra0_22);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount01',ra0_23);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount03',ra0_24);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount06',ra0_25);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount12',ra0_26);
		  		RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount24',ra0_27);
			  	RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount36',ra0_28);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimesolicitedcount60',ra0_29);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfederaltaxfiledcount',ra0_30);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'lientaxotherfiledcount',ra0_31);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienforeclosurefiledcount',ra0_32);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienpreforeclosurefiledcount',ra0_33);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienlandlordtenantfiledcount',ra0_34);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienjudgmentfiledcount',ra0_35);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'liensmallclaimsfiledcount',ra0_36);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienotherfiledcount',ra0_37);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfederaltaxreleasedcount',ra0_38);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'lientaxotherreleasedcount',ra0_39);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienforeclosurereleasedcount',ra0_40);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienpreforeclosurereleasedcount',ra0_41);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienlandlordtenantreleasedcount',ra0_42);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienjudgmentreleasedcount',ra0_43);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'liensmallclaimsreleasedcount',ra0_44);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienotherreleasedcount',ra0_45);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcy_count',ra0_46);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcy_count30',ra0_47);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcy_count90',ra0_48);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcy_count180',ra0_49);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcy_count12',ra0_50);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcy_count24',ra0_51);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcy_count36',ra0_52);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcy_count60',ra0_53);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'eviction_count',ra0_54);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'eviction_count30',ra0_55);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'eviction_count90',ra0_56);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'eviction_count180',ra0_57);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'eviction_count12',ra0_58);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'eviction_count24',ra0_59);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'eviction_count36',ra0_60);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'eviction_count60',ra0_61);

								 
								ra_0:= ra0_1  + ra0_2  + ra0_3  + ra0_4  + ra0_5  + ra0_6  + ra0_7  + ra0_8  + ra0_9  + ra0_10 +
				               ra0_11 + ra0_12 + ra0_13 + ra0_14 + ra0_15 + ra0_16 + ra0_17 + ra0_18 + ra0_19 + ra0_20 +
						           ra0_21 + ra0_22 + ra0_23 + ra0_24 + ra0_25 + ra0_26 + ra0_27 + ra0_28 + ra0_29 + ra0_30 +
				               ra0_31 + ra0_32 + ra0_33 + ra0_34 + ra0_35 + ra0_36 + ra0_37 + ra0_38 + ra0_39 + ra0_40 +
				               ra0_41 + ra0_42 + ra0_43 + ra0_44 + ra0_45 + ra0_46 + ra0_47 + ra0_48 + ra0_49 + ra0_50 +
                       ra0_51 + ra0_52 + ra0_53 + ra0_54 + ra0_55 + ra0_56 + ra0_57 + ra0_58 + ra0_59 + ra0_60 +
                       ra0_61;
								
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
											
							
											 
											 ra_1:=ra1_1  + ra1_2  + ra1_3  + ra1_4  + ra1_5  + ra1_6  + ra1_7  + ra1_8  + ra1_9  + ra1_10;
				
								 
								 
								 RiskView_Attributes_Reports.Range_Function_3(DS1,'felonyage',ra3_1);
								  RiskView_Attributes_Reports.Range_Function_3(DS1,'lienfiledage',ra3_2);
									 RiskView_Attributes_Reports.Range_Function_3(DS1,'lienreleasedage',ra3_3);
								  RiskView_Attributes_Reports.Range_Function_3(DS1,'evictionage',ra3_4);
								 
								 ra_3:=ra3_1+ ra3_2  + ra3_3  + ra3_4;
								 
								 RiskView_Attributes_Reports.Range_Function_4(DS1,'derogage',ra4_1);
								 RiskView_Attributes_Reports.Range_Function_4(DS1,'bankruptcyage',ra4_2);
								 
								 ra_4:=ra4_1+ ra4_2;
				
					RiskView_Attributes_Reports.Distinct_function(DS1,'isrecentupdate',di1);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numsources',di2);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedphonefullname',di3);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedphonelastname',di4);
					RiskView_Attributes_Reports.Distinct_function(DS1,'invalidssn',di5);
					RiskView_Attributes_Reports.Distinct_function(DS1,'invalidphone',di6);
					RiskView_Attributes_Reports.Distinct_function(DS1,'invalidaddr',di7);
					RiskView_Attributes_Reports.Distinct_function(DS1,'invaliddl',di8);
					RiskView_Attributes_Reports.Distinct_function(DS1,'isnover',di9);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'ssndeceased',di10);
					RiskView_Attributes_Reports.Distinct_function(DS1,'deceaseddate',di11);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnvalid',di12);
					RiskView_Attributes_Reports.Distinct_function(DS1,'recentissue',di13);
					RiskView_Attributes_Reports.Distinct_function(DS1,'lowissuedate',di14);
					RiskView_Attributes_Reports.Distinct_function(DS1,'highissuedate',di15);
					RiskView_Attributes_Reports.Distinct_function(DS1,'issuestate',di16);
					RiskView_Attributes_Reports.Distinct_function(DS1,'nonus',di17);
					RiskView_Attributes_Reports.Distinct_function(DS1,'issued3',di18);
					RiskView_Attributes_Reports.Distinct_function(DS1,'issuedage5',di19);
					RiskView_Attributes_Reports.Distinct_function(DS1,'iadwelltype',di20);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ialandusecode',di21);
					RiskView_Attributes_Reports.Distinct_function(DS1,'iaownedbysubject',di22);
					RiskView_Attributes_Reports.Distinct_function(DS1,'iafamilyowned',di23);
					RiskView_Attributes_Reports.Distinct_function(DS1,'iaoccupantowned',di24);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ianotprimaryres',di25);
					RiskView_Attributes_Reports.Distinct_function(DS1,'iaphonelisted',di26);
					RiskView_Attributes_Reports.Distinct_function(DS1,'cadwelltype',di27);
					RiskView_Attributes_Reports.Distinct_function(DS1,'calandusecode',di28);
					RiskView_Attributes_Reports.Distinct_function(DS1,'caownedbysubject',di29);
					RiskView_Attributes_Reports.Distinct_function(DS1,'cafamilyowned',di30);
					RiskView_Attributes_Reports.Distinct_function(DS1,'caoccupantowned',di31);
					RiskView_Attributes_Reports.Distinct_function(DS1,'canotprimaryres',di32);
					RiskView_Attributes_Reports.Distinct_function(DS1,'caphonelisted',di33);
					RiskView_Attributes_Reports.Distinct_function(DS1,'padwelltype',di34);
					RiskView_Attributes_Reports.Distinct_function(DS1,'palandusecode',di35);
					RiskView_Attributes_Reports.Distinct_function(DS1,'paownedbysubject',di36);
					RiskView_Attributes_Reports.Distinct_function(DS1,'pafamilyowned',di37);
					RiskView_Attributes_Reports.Distinct_function(DS1,'paoccupantowned',di38);
					RiskView_Attributes_Reports.Distinct_function(DS1,'paphonelisted',di39);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputcurrmatch',di40);
					RiskView_Attributes_Reports.Distinct_function(DS1,'diffstate',di41);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ecotrajectory',di42);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputprevmatch',di43);
					RiskView_Attributes_Reports.Distinct_function(DS1,'diffstate2',di44);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ecotrajectory2',di45);
					RiskView_Attributes_Reports.Distinct_function(DS1,'mobility_indicator',di46);
					RiskView_Attributes_Reports.Distinct_function(DS1,'statusaddr',di47);
					RiskView_Attributes_Reports.Distinct_function(DS1,'statusaddr2',di48);
					RiskView_Attributes_Reports.Distinct_function(DS1,'statusaddr3',di49);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrchanges30',di50);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrchanges90',di51);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrchanges180',di52);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrchanges12',di53);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrchanges24',di54);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrchanges36',di55);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrchanges60',di56);
					RiskView_Attributes_Reports.Distinct_function(DS1,'property_owned_total',di57);
					RiskView_Attributes_Reports.Distinct_function(DS1,'property_historically_owned',di58);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numpurchase30',di59);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'numpurchase90',di60);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numpurchase180',di61);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numpurchase12',di62);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numpurchase24',di63);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numpurchase36',di64);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numpurchase60',di65);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numsold30',di66);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numsold90',di67);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numsold180',di68);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numsold12',di69);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numsold24',di70);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numsold36',di71);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numsold60',di72);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numwatercraft',di73);	
					RiskView_Attributes_Reports.Distinct_function(DS1,'numwatercraft30',di74);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numwatercraft90',di75);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numwatercraft180',di76);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numwatercraft12',di77);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numwatercraft24',di78);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numwatercraft36',di79);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'numwatercraft60',di80);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numaircraft',di81);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numaircraft30',di82);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numaircraft90',di83);	
					RiskView_Attributes_Reports.Distinct_function(DS1,'numaircraft180',di84);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numaircraft12',di85);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numaircraft24',di86);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numaircraft36',di87);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numaircraft60',di88);
					RiskView_Attributes_Reports.Distinct_function(DS1,'wealth_indicator',di89);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'total_number_derogs',di90);
					RiskView_Attributes_Reports.Distinct_function(DS1,'felonies',di91);
					RiskView_Attributes_Reports.Distinct_function(DS1,'felonies30',di92);
					RiskView_Attributes_Reports.Distinct_function(DS1,'felonies90',di93);
					RiskView_Attributes_Reports.Distinct_function(DS1,'felonies180',di94);
					RiskView_Attributes_Reports.Distinct_function(DS1,'felonies12',di95);
					RiskView_Attributes_Reports.Distinct_function(DS1,'felonies24',di96);
					RiskView_Attributes_Reports.Distinct_function(DS1,'felonies36',di97);
					RiskView_Attributes_Reports.Distinct_function(DS1,'felonies60',di98);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_liens',di99);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'num_unreleased_liens',di100);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_unreleased_liens30',di101);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_unreleased_liens90',di102);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_unreleased_liens180',di103);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_unreleased_liens12',di104);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_unreleased_liens24',di105);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_unreleased_liens36',di106);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_unreleased_liens60',di107);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_released_liens',di108);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_released_liens30',di109);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'num_released_liens90',di110);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_released_liens180',di111);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_released_liens12',di112);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_released_liens24',di113);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_released_liens36',di114);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_released_liens60',di115);	
					RiskView_Attributes_Reports.Distinct_function(DS1,'filing_type',di116);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_nonderogs180',di117);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_nonderogs12',di118);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_nonderogs24',di119);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'num_nonderogs36',di120);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_nonderogs60',di121);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic',di122);
					RiskView_Attributes_Reports.Distinct_function(DS1,'proflic_type',di123);
					RiskView_Attributes_Reports.Distinct_function(DS1,'expire_date_last_proflic',di124);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic30',di125);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic90',di126);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic180',di127);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic12',di128);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic24',di129);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic36',di130);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic60',di131);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic_exp30',di132);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic_exp90',di133);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic_exp180',di134);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic_exp12',di135);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic_exp24',di136);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic_exp36',di137);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_proflic_exp60',di138);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrhighrisk',di139);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'phonehighrisk',di140);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrprison',di141);
					RiskView_Attributes_Reports.Distinct_function(DS1,'zippobox',di142);
					RiskView_Attributes_Reports.Distinct_function(DS1,'zipcorpmil',di143);
					RiskView_Attributes_Reports.Distinct_function(DS1,'phonestatus',di144);
					RiskView_Attributes_Reports.Distinct_function(DS1,'phonepager',di145);
					RiskView_Attributes_Reports.Distinct_function(DS1,'phonemobile',di146);
					RiskView_Attributes_Reports.Distinct_function(DS1,'phonezipmismatch',di147);
					RiskView_Attributes_Reports.Distinct_function(DS1,'phoneaddrdist',di148);
					RiskView_Attributes_Reports.Distinct_function(DS1,'correctedflag',di149);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'securityfreeze',di150);
					RiskView_Attributes_Reports.Distinct_function(DS1,'securityalert',di151);
					RiskView_Attributes_Reports.Distinct_function(DS1,'idtheftflag',di152);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnnotfound',di153);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedname',di154);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedssn',di155);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedphone',di156);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedaddress',di157);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifieddob',di158);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnissuedpriordob',di159);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrtaxyr',di160);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrtaxyr',di161);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationattendedcollege',di162);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationprogram2yr',di163);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationprogram4yr',di164);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationprogramgraduate',di165);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationinstitutionprivate',di166);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationinstitutionrating',di167);
					RiskView_Attributes_Reports.Distinct_function(DS1,'proflictypecategory',di168);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrtaxyr',di169);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'prescreenoptout',di170);
					RiskView_Attributes_Reports.Distinct_function(DS1,'history_date',di171);
					RiskView_Attributes_Reports.Distinct_function(DS1,'errorcode',di172);
					RiskView_Attributes_Reports.Distinct_function(DS1,'disposition',di173);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_nonderogs',di174);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_nonderogs30',di175);
					RiskView_Attributes_Reports.Distinct_function(DS1,'num_nonderogs90',di176);
					
					di:= di1  + di2  + di3  + di4  + di5  + di6  + di7  + di8  + di9  + di10 +
				       di11 + di12 + di13 + di14 + di15 + di16 + di17 + di18 + di19 + di20 +
						   di21 + di22 + di23 + di24 + di25 + di26 + di27 + di28 + di29 + di30 +
				       di31 + di32 + di33 + di34 + di35 + di36 + di37 + di38 + di39 + di40 +
				       di41 + di42 + di43 + di44 + di45 + di46 + di47 + di48 + di49 + di50 +
						   di51 + di52 + di53 + di54 + di55 + di56 + di57 + di58 + di59 + di60 +
               di61 + di62 + di63 + di64 + di65 + di66 + di67 + di68 + di69 + di70 + 
               di71 + di72 + di73 + di74 + di75 + di76 + di77 + di78 + di79 + di80 + 
               di81 + di82 + di83 + di84 + di85 + di86 + di87 + di88 + di89 + di90 + 
					     di91 + di92 + di93 + di94 + di95 + di96 + di97 + di98 + di99 + di100+ 
				       di101 + di102 + di103 + di104 + di105 + di106 + di107 + di108 + di109 + di110+ 
						   di111 + di112 + di113 + di114 + di115 + di116 + di117 + di118 + di119 + di120+ 
				  	   di121 + di122 + di123 + di124 + di125 + di126 + di127 + di128 + di129 + di130+
						   di131 + di132 + di133 + di134 + di135 + di136 + di137 + di138 + di139 + di140+
					     di141 + di142 + di143 + di144 + di145 + di146 + di147 + di148 + di149 + di150+							
						   di151 + di152 + di153 + di154 + di155 + di156 + di157 + di158 + di159 + di160+
					     di161 + di162 + di163 + di164 + di165 + di166 + di167 + di168 + di169 + di170+							
						   di171 + di172 + di173 + di174 + di175 + di176;
				
		      	RiskView_Attributes_Reports.Length_Function(DS1,'iaphonenumber',le1);
						RiskView_Attributes_Reports.Length_Function(DS1,'caphonenumber',le2);
						RiskView_Attributes_Reports.Length_Function(DS1,'paphonenumber',le3);
						
			le:=le1 + le2 + le3;
											 
      	result1_stats:= ra + di + ra_0 + ra_1 + ra_3 + ra_4 + le;
				
		      	// result1_stats;
				///////////////////////////////////////////////////////////////////////////////
				///////////////////////////////////////////////////////////////////////////////
				//////////////////////////////////////////////////////////////////////////////
				

      	RiskView_Attributes_Reports.Range_func(DS2,'ageoldestrecord',ran1);
      	RiskView_Attributes_Reports.Range_func(DS2,'agenewestrecord',ran2);
				RiskView_Attributes_Reports.Range_func(DS2,'iaageoldestrecord',ran3);
      	RiskView_Attributes_Reports.Range_func(DS2,'iaagenewestrecord',ran4);
      	RiskView_Attributes_Reports.Range_func(DS2,'ialenofres',ran5);
				RiskView_Attributes_Reports.Range_func(DS2,'iaagelastsale',ran6);
				RiskView_Attributes_Reports.Range_func(DS2,'caageoldestrecord',ran7);
      	RiskView_Attributes_Reports.Range_func(DS2,'caagenewestrecord',ran8);
				RiskView_Attributes_Reports.Range_func(DS2,'calenofres',ran9);
				RiskView_Attributes_Reports.Range_func(DS2,'paageoldestrecord',ran10);
      	RiskView_Attributes_Reports.Range_func(DS2,'paagenewestrecord',ran11);
				RiskView_Attributes_Reports.Range_func(DS2,'palenofres',ran12);
				RiskView_Attributes_Reports.Range_func(DS2,'paagelastsale',ran13);
				RiskView_Attributes_Reports.Range_func(DS2,'caagelastsale',ran14);
				RiskView_Attributes_Reports.Range_func(DS2,'distinputcurr',ran15);
				RiskView_Attributes_Reports.Range_func(DS2,'propageoldestpurchase',ran16);
      	RiskView_Attributes_Reports.Range_func(DS2,'propagenewestpurchase',ran17);
				// RiskView_Attributes_Reports.Range_func(DS2,'derogage',ran18);
				// RiskView_Attributes_Reports.Range_func(DS2,'felonyage',ran19);
				// RiskView_Attributes_Reports.Range_func(DS2,'lienfiledage',ran20);
				// RiskView_Attributes_Reports.Range_func(DS2,'evictionage',ran21);
				RiskView_Attributes_Reports.Range_func(DS2,'proflicage',ran22);
				RiskView_Attributes_Reports.Range_func(DS2,'inferredminimumage',ran23);
				RiskView_Attributes_Reports.Range_func(DS2,'bestreportedage',ran24);
				RiskView_Attributes_Reports.Range_func(DS2,'phoneedaageoldestrecord',ran25);
				RiskView_Attributes_Reports.Range_func(DS2,'phoneedaagenewestrecord',ran26);
      	RiskView_Attributes_Reports.Range_func(DS2,'phoneotherageoldestrecord',ran27);
      	RiskView_Attributes_Reports.Range_func(DS2,'phoneotheragenewestrecord',ran28);
		
      	
      	
      	ran:= ran1  + ran2  + ran3  + ran4  + ran5  + ran6  + ran7  + ran8  + ran9  + ran10 +
				      ran11 + ran12 + ran13 + ran14 + ran15 + ran16 + ran17  +ran22 + ran23 + ran24 + ran25 + ran26 + ran27 + ran28;
				
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
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddridentitiescount',ran0_11);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrssncount',ran0_12);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrphonecount',ran0_13);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddridentitiesrecentcount',ran0_14);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrssnrecentcount',ran0_15);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrphonerecentcount',ran0_16);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'phoneidentitiescount',ran0_17);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'phoneidentitiesrecentcount',ran0_18);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddravmconfidence',ran0_19);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'curraddravmconfidence',ran0_20);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'prevaddravmconfidence',ran0_21);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount',ran0_22);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount01',ran0_23);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount03',ran0_24);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount06',ran0_25);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount12',ran0_26);
		  		RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount24',ran0_27);
			  	RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount36',ran0_28);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimesolicitedcount60',ran0_29);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfederaltaxfiledcount',ran0_30);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'lientaxotherfiledcount',ran0_31);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienforeclosurefiledcount',ran0_32);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienpreforeclosurefiledcount',ran0_33);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienlandlordtenantfiledcount',ran0_34);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienjudgmentfiledcount',ran0_35);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'liensmallclaimsfiledcount',ran0_36);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienotherfiledcount',ran0_37);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfederaltaxreleasedcount',ran0_38);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'lientaxotherreleasedcount',ran0_39);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienforeclosurereleasedcount',ran0_40);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienpreforeclosurereleasedcount',ran0_41);
      	  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienlandlordtenantreleasedcount',ran0_42);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienjudgmentreleasedcount',ran0_43);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'liensmallclaimsreleasedcount',ran0_44);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienotherreleasedcount',ran0_45);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcy_count',ran0_46);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcy_count30',ran0_47);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcy_count90',ran0_48);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcy_count180',ran0_49);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcy_count12',ran0_50);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcy_count24',ran0_51);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcy_count36',ran0_52);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcy_count60',ran0_53);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'eviction_count',ran0_54);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'eviction_count30',ran0_55);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'eviction_count90',ran0_56);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'eviction_count180',ran0_57);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'eviction_count12',ran0_58);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'eviction_count24',ran0_59);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'eviction_count36',ran0_60);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'eviction_count60',ran0_61);

								 
							ran_0:=   ran0_1 + ran0_2  + ran0_3  + ran0_4  + ran0_5  + ran0_6  + ran0_7  + ran0_8  + ran0_9  + ran0_10 +
				               ran0_11 + ran0_12 + ran0_13 + ran0_14 + ran0_15 + ran0_16 + ran0_17 + ran0_18 + ran0_19 + ran0_20 +
						           ran0_21 + ran0_22 + ran0_23 + ran0_24 + ran0_25 + ran0_26 + ran0_27 + ran0_28 + ran0_29 + ran0_30 +
				               ran0_31 + ran0_32 + ran0_33 + ran0_34 + ran0_35 + ran0_36 + ran0_37 + ran0_38 + ran0_39 + ran0_40 +
				               ran0_41 + ran0_42 + ran0_43 + ran0_44 + ran0_45 + ran0_46 + ran0_47 + ran0_48 + ran0_49 + ran0_50 +
                       ran0_51 + ran0_52 + ran0_53 + ran0_54 + ran0_55 + ran0_56 + ran0_57 + ran0_58 + ran0_59 + ran0_60 +
                       ran0_61;
								
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
											
							
											 
											 ran_1:=ran1_1  + ran1_2  + ran1_3  + ran1_4  + ran1_5  + ran1_6  + ran1_7  + ran1_8  + ran1_9  + ran1_10;
								
								
								 
								 	RiskView_Attributes_Reports.Range_Function_3(DS2,'felonyage',ran3_1);
								  RiskView_Attributes_Reports.Range_Function_3(DS2,'lienfiledage',ran3_2);
									RiskView_Attributes_Reports.Range_Function_3(DS2,'lienreleasedage',ran3_3);
								  RiskView_Attributes_Reports.Range_Function_3(DS2,'evictionage',ran3_4);
								 
								 ran_3:=ran3_1+ ran3_2  + ran3_3  + ran3_4;
								 
								 RiskView_Attributes_Reports.Range_Function_4(DS2,'derogage',ran4_1);
								 RiskView_Attributes_Reports.Range_Function_4(DS2,'bankruptcyage',ran4_2);
								 
								 ran_4:=ran4_1+ ran4_2;
				
					RiskView_Attributes_Reports.Distinct_function(DS2,'isrecentupdate',dis1);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numsources',dis2);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedphonefullname',dis3);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedphonelastname',dis4);
					RiskView_Attributes_Reports.Distinct_function(DS2,'invalidssn',dis5);
					RiskView_Attributes_Reports.Distinct_function(DS2,'invalidphone',dis6);
					RiskView_Attributes_Reports.Distinct_function(DS2,'invalidaddr',dis7);
					RiskView_Attributes_Reports.Distinct_function(DS2,'invaliddl',dis8);
					RiskView_Attributes_Reports.Distinct_function(DS2,'isnover',dis9);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'ssndeceased',dis10);
					RiskView_Attributes_Reports.Distinct_function(DS2,'deceaseddate',dis11);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnvalid',dis12);
					RiskView_Attributes_Reports.Distinct_function(DS2,'recentissue',dis13);
					RiskView_Attributes_Reports.Distinct_function(DS2,'lowissuedate',dis14);
					RiskView_Attributes_Reports.Distinct_function(DS2,'highissuedate',dis15);
					RiskView_Attributes_Reports.Distinct_function(DS2,'issuestate',dis16);
					RiskView_Attributes_Reports.Distinct_function(DS2,'nonus',dis17);
					RiskView_Attributes_Reports.Distinct_function(DS2,'issued3',dis18);
					RiskView_Attributes_Reports.Distinct_function(DS2,'issuedage5',dis19);
					RiskView_Attributes_Reports.Distinct_function(DS2,'iadwelltype',dis20);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ialandusecode',dis21);
					RiskView_Attributes_Reports.Distinct_function(DS2,'iaownedbysubject',dis22);
					RiskView_Attributes_Reports.Distinct_function(DS2,'iafamilyowned',dis23);
					RiskView_Attributes_Reports.Distinct_function(DS2,'iaoccupantowned',dis24);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ianotprimaryres',dis25);
					RiskView_Attributes_Reports.Distinct_function(DS2,'iaphonelisted',dis26);
					RiskView_Attributes_Reports.Distinct_function(DS2,'cadwelltype',dis27);
					RiskView_Attributes_Reports.Distinct_function(DS2,'calandusecode',dis28);
					RiskView_Attributes_Reports.Distinct_function(DS2,'caownedbysubject',dis29);
					RiskView_Attributes_Reports.Distinct_function(DS2,'cafamilyowned',dis30);
					RiskView_Attributes_Reports.Distinct_function(DS2,'caoccupantowned',dis31);
					RiskView_Attributes_Reports.Distinct_function(DS2,'canotprimaryres',dis32);
					RiskView_Attributes_Reports.Distinct_function(DS2,'caphonelisted',dis33);
					RiskView_Attributes_Reports.Distinct_function(DS2,'padwelltype',dis34);
					RiskView_Attributes_Reports.Distinct_function(DS2,'palandusecode',dis35);
					RiskView_Attributes_Reports.Distinct_function(DS2,'paownedbysubject',dis36);
					RiskView_Attributes_Reports.Distinct_function(DS2,'pafamilyowned',dis37);
					RiskView_Attributes_Reports.Distinct_function(DS2,'paoccupantowned',dis38);
					RiskView_Attributes_Reports.Distinct_function(DS2,'paphonelisted',dis39);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputcurrmatch',dis40);
					RiskView_Attributes_Reports.Distinct_function(DS2,'diffstate',dis41);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ecotrajectory',dis42);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputprevmatch',dis43);
					RiskView_Attributes_Reports.Distinct_function(DS2,'diffstate2',dis44);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ecotrajectory2',dis45);
					RiskView_Attributes_Reports.Distinct_function(DS2,'mobility_indicator',dis46);
					RiskView_Attributes_Reports.Distinct_function(DS2,'statusaddr',dis47);
					RiskView_Attributes_Reports.Distinct_function(DS2,'statusaddr2',dis48);
					RiskView_Attributes_Reports.Distinct_function(DS2,'statusaddr3',dis49);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrchanges30',dis50);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrchanges90',dis51);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrchanges180',dis52);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrchanges12',dis53);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrchanges24',dis54);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrchanges36',dis55);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrchanges60',dis56);
					RiskView_Attributes_Reports.Distinct_function(DS2,'property_owned_total',dis57);
					RiskView_Attributes_Reports.Distinct_function(DS2,'property_historically_owned',dis58);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numpurchase30',dis59);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'numpurchase90',dis60);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numpurchase180',dis61);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numpurchase12',dis62);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numpurchase24',dis63);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numpurchase36',dis64);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numpurchase60',dis65);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numsold30',dis66);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numsold90',dis67);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numsold180',dis68);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numsold12',dis69);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numsold24',dis70);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numsold36',dis71);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numsold60',dis72);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numwatercraft',dis73);	
					RiskView_Attributes_Reports.Distinct_function(DS2,'numwatercraft30',dis74);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numwatercraft90',dis75);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numwatercraft180',dis76);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numwatercraft12',dis77);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numwatercraft24',dis78);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numwatercraft36',dis79);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'numwatercraft60',dis80);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numaircraft',dis81);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numaircraft30',dis82);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numaircraft90',dis83);	
					RiskView_Attributes_Reports.Distinct_function(DS2,'numaircraft180',dis84);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numaircraft12',dis85);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numaircraft24',dis86);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numaircraft36',dis87);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numaircraft60',dis88);
					RiskView_Attributes_Reports.Distinct_function(DS2,'wealth_indicator',dis89);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'total_number_derogs',dis90);
					RiskView_Attributes_Reports.Distinct_function(DS2,'felonies',dis91);
					RiskView_Attributes_Reports.Distinct_function(DS2,'felonies30',dis92);
					RiskView_Attributes_Reports.Distinct_function(DS2,'felonies90',dis93);
					RiskView_Attributes_Reports.Distinct_function(DS2,'felonies180',dis94);
					RiskView_Attributes_Reports.Distinct_function(DS2,'felonies12',dis95);
					RiskView_Attributes_Reports.Distinct_function(DS2,'felonies24',dis96);
					RiskView_Attributes_Reports.Distinct_function(DS2,'felonies36',dis97);
					RiskView_Attributes_Reports.Distinct_function(DS2,'felonies60',dis98);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_liens',dis99);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'num_unreleased_liens',dis100);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_unreleased_liens30',dis101);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_unreleased_liens90',dis102);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_unreleased_liens180',dis103);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_unreleased_liens12',dis104);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_unreleased_liens24',dis105);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_unreleased_liens36',dis106);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_unreleased_liens60',dis107);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_released_liens',dis108);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_released_liens30',dis109);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'num_released_liens90',dis110);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_released_liens180',dis111);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_released_liens12',dis112);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_released_liens24',dis113);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_released_liens36',dis114);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_released_liens60',dis115);	
					RiskView_Attributes_Reports.Distinct_function(DS2,'filing_type',dis116);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_nonderogs180',dis117);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_nonderogs12',dis118);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_nonderogs24',dis119);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'num_nonderogs36',dis120);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_nonderogs60',dis121);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic',dis122);
					RiskView_Attributes_Reports.Distinct_function(DS2,'proflic_type',dis123);
					RiskView_Attributes_Reports.Distinct_function(DS2,'expire_date_last_proflic',dis124);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic30',dis125);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic90',dis126);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic180',dis127);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic12',dis128);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic24',dis129);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic36',dis130);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic60',dis131);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic_exp30',dis132);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic_exp90',dis133);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic_exp180',dis134);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic_exp12',dis135);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic_exp24',dis136);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic_exp36',dis137);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_proflic_exp60',dis138);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrhighrisk',dis139);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'phonehighrisk',dis140);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrprison',dis141);
					RiskView_Attributes_Reports.Distinct_function(DS2,'zippobox',dis142);
					RiskView_Attributes_Reports.Distinct_function(DS2,'zipcorpmil',dis143);
					RiskView_Attributes_Reports.Distinct_function(DS2,'phonestatus',dis144);
					RiskView_Attributes_Reports.Distinct_function(DS2,'phonepager',dis145);
					RiskView_Attributes_Reports.Distinct_function(DS2,'phonemobile',dis146);
					RiskView_Attributes_Reports.Distinct_function(DS2,'phonezipmismatch',dis147);
					RiskView_Attributes_Reports.Distinct_function(DS2,'phoneaddrdist',dis148);
					RiskView_Attributes_Reports.Distinct_function(DS2,'correctedflag',dis149);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'securityfreeze',dis150);
					RiskView_Attributes_Reports.Distinct_function(DS2,'securityalert',dis151);
					RiskView_Attributes_Reports.Distinct_function(DS2,'idtheftflag',dis152);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnnotfound',dis153);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedname',dis154);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedssn',dis155);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedphone',dis156);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedaddress',dis157);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifieddob',dis158);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnissuedpriordob',dis159);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrtaxyr',dis160);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrtaxyr',dis161);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationattendedcollege',dis162);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationprogram2yr',dis163);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationprogram4yr',dis164);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationprogramgraduate',dis165);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationinstitutionprivate',dis166);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationinstitutionrating',dis167);
					RiskView_Attributes_Reports.Distinct_function(DS2,'proflictypecategory',dis168);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrtaxyr',dis169);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'prescreenoptout',dis170);
					RiskView_Attributes_Reports.Distinct_function(DS2,'history_date',dis171);
					RiskView_Attributes_Reports.Distinct_function(DS2,'errorcode',dis172);
					RiskView_Attributes_Reports.Distinct_function(DS2,'disposition',dis173);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_nonderogs',dis174);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_nonderogs30',dis175);
					RiskView_Attributes_Reports.Distinct_function(DS2,'num_nonderogs90',dis176);
				
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
						   dis171 + dis172 + dis173 + dis174 + dis175 + dis176; 

          	RiskView_Attributes_Reports.Length_Function(DS2,'iaphonenumber',len1);
						RiskView_Attributes_Reports.Length_Function(DS2,'caphonenumber',len2);
						RiskView_Attributes_Reports.Length_Function(DS2,'paphonenumber',len3);
						
			len:=len1 + len2 + len3;

				
			result2_stats:= ran + dis + ran_0 + ran_1 + ran_3 + ran_4 + len;
   				
         	// result2_stats;
			/////////////////////////////////////////////////////////////////////////
			/////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////
					
				RiskView_Attributes_Reports.Average_func(DS1,'iaassessedvalue',av1);
				RiskView_Attributes_Reports.Average_func(DS1,'ialastsaleamount',av2);
				RiskView_Attributes_Reports.Average_func(DS1,'caassessedvalue',av3);
		// RiskView_Attributes_Reports.Average_func(DS1,'caagelastsale',av4);
      	RiskView_Attributes_Reports.Average_func(DS1,'calastsaleamount',av5);
				RiskView_Attributes_Reports.Average_func(DS1,'paassessedvalue',av6);
		  	RiskView_Attributes_Reports.Average_func(DS1,'palastsaleamount',av7);
		  	RiskView_Attributes_Reports.Average_func(DS1,'assesseddiff',av8);
			 	RiskView_Attributes_Reports.Average_func(DS1,'distcurrprev',av9);
				RiskView_Attributes_Reports.Average_func(DS1,'assesseddiff2',av10);
		   	RiskView_Attributes_Reports.Average_func(DS1,'property_owned_assessed_total',av11);
			 	RiskView_Attributes_Reports.Average_func(DS1,'propagenewestsale',av12);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddrtaxmarketvalue',av13);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmtax',av14);
      	RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmsalesprice',av15);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmhedonic',av16);
      	RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmvalue',av17);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddrtaxmarketvalue',av18);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddravmtax',av19);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddravmsalesprice',av20);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddravmhedonic',av21);
      	RiskView_Attributes_Reports.Average_func(DS1,'curraddravmvalue',av22);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddrtaxmarketvalue',av23);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddravmtax',av24);
      	RiskView_Attributes_Reports.Average_func(DS1,'prevaddravmsalesprice',av25);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddravmhedonic',av26);
      	RiskView_Attributes_Reports.Average_func(DS1,'prevaddravmvalue',av27);
				RiskView_Attributes_Reports.Average_func(DS1,'predictedannualincome',av28);
				RiskView_Attributes_Reports.Average_func(DS1,'propnewestsaleprice',av29);
				RiskView_Attributes_Reports.Average_func(DS1,'lienfederaltaxfiledtotal',av30);
				RiskView_Attributes_Reports.Average_func(DS1,'lientaxotherfiledtotal',av31);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienforeclosurefiledtotal',av32);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienpreforeclosurefiledtotal',av33);
				RiskView_Attributes_Reports.Average_func(DS1,'lienlandlordtenantfiledtotal',av34);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienjudgmentfiledtotal',av35);
				RiskView_Attributes_Reports.Average_func(DS1,'liensmallclaimsfiledtotal',av36);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienotherfiledtotal',av37);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienfederaltaxreleasedtotal',av38);
				RiskView_Attributes_Reports.Average_func(DS1,'lientaxotherreleasedtotal',av39);
				RiskView_Attributes_Reports.Average_func(DS1,'lienforeclosurereleasedtotal',av40);
				RiskView_Attributes_Reports.Average_func(DS1,'lienpreforeclosurereleasedtotal',av41);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienlandlordtenantreleasedtotal',av42);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienjudgmentreleasedtotal',av43);
				RiskView_Attributes_Reports.Average_func(DS1,'liensmallclaimsreleasedtotal',av44);
				RiskView_Attributes_Reports.Average_func(DS1,'lienotherreleasedtotal',av45);
			  RiskView_Attributes_Reports.Average_func(DS1,'ageoldestrecord',av46);
				RiskView_Attributes_Reports.Average_func(DS1,'agenewestrecord',av47);
				RiskView_Attributes_Reports.Average_func(DS1,'iaageoldestrecord',av48);
				RiskView_Attributes_Reports.Average_func(DS1,'iaagenewestrecord',av49);
				RiskView_Attributes_Reports.Average_func(DS1,'iaagelastsale',av50);
				RiskView_Attributes_Reports.Average_func(DS1,'caageoldestrecord',av51);
      	RiskView_Attributes_Reports.Average_func(DS1,'caagenewestrecord',av52);
      	RiskView_Attributes_Reports.Average_func(DS1,'calenofres',av53);
				RiskView_Attributes_Reports.Average_func(DS1,'paageoldestrecord',av54);
      	RiskView_Attributes_Reports.Average_func(DS1,'paagenewestrecord',av55);
				RiskView_Attributes_Reports.Average_func(DS1,'palenofres',av56);
				RiskView_Attributes_Reports.Average_func(DS1,'paagelastsale',av57);
				RiskView_Attributes_Reports.Average_func(DS1,'caagelastsale',av58);
				RiskView_Attributes_Reports.Average_func(DS1,'propageoldestpurchase',av59);
      	RiskView_Attributes_Reports.Average_func(DS1,'propagenewestpurchase',av60);
				RiskView_Attributes_Reports.Average_func(DS1,'derogage',av61);
				RiskView_Attributes_Reports.Average_func(DS1,'felonyage',av62);				
				RiskView_Attributes_Reports.Average_func(DS1,'lienfiledage',av63);
				RiskView_Attributes_Reports.Average_func(DS1,'evictionage',av64);
				RiskView_Attributes_Reports.Average_func(DS1,'proflicage',av65);
				RiskView_Attributes_Reports.Average_func(DS1,'inferredminimumage',av66);
				RiskView_Attributes_Reports.Average_func(DS1,'bestreportedage',av67);
				RiskView_Attributes_Reports.Average_func(DS1,'phoneedaageoldestrecord',av68);
				RiskView_Attributes_Reports.Average_func(DS1,'phoneedaagenewestrecord',av69);
				RiskView_Attributes_Reports.Average_func(DS1,'phoneotherageoldestrecord',av70);
				RiskView_Attributes_Reports.Average_func(DS1,'phoneotheragenewestrecord',av71);
      
      	  RiskView_Attributes_Reports.Average_func(DS1,'subjectaddrcount',av72);
					RiskView_Attributes_Reports.Average_func(DS1,'subjectphonecount',av73);
					RiskView_Attributes_Reports.Average_func(DS1,'subjectssnrecentcount',av74);
					RiskView_Attributes_Reports.Average_func(DS1,'subjectaddrrecentcount',av75);
					RiskView_Attributes_Reports.Average_func(DS1,'subjectphonerecentcount',av76);
					RiskView_Attributes_Reports.Average_func(DS1,'ssnidentitiescount',av77);
					RiskView_Attributes_Reports.Average_func(DS1,'ssnaddrcount',av78);
			    RiskView_Attributes_Reports.Average_func(DS1,'ssnidentitiesrecentcount',av79);
					RiskView_Attributes_Reports.Average_func(DS1,'ssnaddrrecentcount',av80);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddridentitiescount',av81);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrssncount',av82);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrphonecount',av83);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddridentitiesrecentcount',av84);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrssnrecentcount',av85);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddrphonerecentcount',av86);
					RiskView_Attributes_Reports.Average_func(DS1,'phoneidentitiescount',av87);
				  RiskView_Attributes_Reports.Average_func(DS1,'phoneidentitiesrecentcount',av88);
					RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmconfidence',av89);
					RiskView_Attributes_Reports.Average_func(DS1,'curraddravmconfidence',av90);
					RiskView_Attributes_Reports.Average_func(DS1,'prevaddravmconfidence',av91);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimesolicitedcount',av92);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimesolicitedcount01',av93);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimesolicitedcount03',av94);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimesolicitedcount06',av95);
				  RiskView_Attributes_Reports.Average_func(DS1,'subprimesolicitedcount12',av96);
		  		RiskView_Attributes_Reports.Average_func(DS1,'subprimesolicitedcount24',av97);
			  	RiskView_Attributes_Reports.Average_func(DS1,'subprimesolicitedcount36',av98);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimesolicitedcount60',av99);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfederaltaxfiledcount',av100);
      	  RiskView_Attributes_Reports.Average_func(DS1,'lientaxotherfiledcount',av101);
      	  RiskView_Attributes_Reports.Average_func(DS1,'lienforeclosurefiledcount',av102);
				  RiskView_Attributes_Reports.Average_func(DS1,'lienpreforeclosurefiledcount',av103);
      	  RiskView_Attributes_Reports.Average_func(DS1,'lienlandlordtenantfiledcount',av104);
      	  RiskView_Attributes_Reports.Average_func(DS1,'lienjudgmentfiledcount',av105);
				  RiskView_Attributes_Reports.Average_func(DS1,'liensmallclaimsfiledcount',av106);
      	  RiskView_Attributes_Reports.Average_func(DS1,'lienotherfiledcount',av107);
      	  RiskView_Attributes_Reports.Average_func(DS1,'lienfederaltaxreleasedcount',av108);
			    RiskView_Attributes_Reports.Average_func(DS1,'lientaxotherreleasedcount',av109);
				  RiskView_Attributes_Reports.Average_func(DS1,'lienforeclosurereleasedcount',av110);
      	  RiskView_Attributes_Reports.Average_func(DS1,'lienpreforeclosurereleasedcount',av111);
      	  RiskView_Attributes_Reports.Average_func(DS1,'lienlandlordtenantreleasedcount',av112);
				  RiskView_Attributes_Reports.Average_func(DS1,'lienjudgmentreleasedcount',av113);
					RiskView_Attributes_Reports.Average_func(DS1,'liensmallclaimsreleasedcount',av114);
					RiskView_Attributes_Reports.Average_func(DS1,'lienotherreleasedcount',av115);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcy_count',av116);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcy_count30',av117);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcy_count90',av118);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcy_count180',av119);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcy_count12',av120);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcy_count24',av121);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcy_count36',av122);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcy_count60',av123);
					RiskView_Attributes_Reports.Average_func(DS1,'eviction_count',av124);
					RiskView_Attributes_Reports.Average_func(DS1,'eviction_count30',av125);
					RiskView_Attributes_Reports.Average_func(DS1,'eviction_count90',av126);
					RiskView_Attributes_Reports.Average_func(DS1,'eviction_count180',av127);
				  RiskView_Attributes_Reports.Average_func(DS1,'eviction_count12',av128);
					RiskView_Attributes_Reports.Average_func(DS1,'eviction_count24',av129);
					RiskView_Attributes_Reports.Average_func(DS1,'eviction_count36',av130);
					RiskView_Attributes_Reports.Average_func(DS1,'eviction_count60',av131); 
					RiskView_Attributes_Reports.Average_func(DS1,'subjectssncount',av132);
			   
								 
      	   av:= av1  + av2  + av3  + av5  + av6  + av7  + av8  + av9  + av10 +
				        av11 + av12 + av13 + av14 + av15 + av16 + av17 + av18 + av19 + av20 +
						    av21 + av22 + av23 + av24 + av25 + av26 + av27 + av28 + av29 + av30 +
				        av31 + av32 + av33 + av34 + av35 + av36 + av37 + av38 + av39 + av40 +
				        av41 + av42 + av43 + av44 + av45 + av46 + av47 + av48 + av49 + av50 +
								av51 + av52 + av53 + av54 + av55 + av56 + av57 + av58 + av59 + av60 +
                av61 + av62 + av63 + av64 + av65 + av66 + av67 + av68 + av69 + av70 + 
                av71 + av72 + av73 + av74 + av75 + av76 + av77 + av78 + av79 + av80 + 
                av81 + av82 + av83 + av84 + av85 + av86 + av87 + av88 + av89 + av90 + 
					      av91 + av92 + av93 + av94 + av95 + av96 + av97 + av98 + av99 + av100+ 
				       av101 + av102 + av103 + av104 + av105 + av106 + av107 + av108 + av109 + av110+ 
						   av111 + av112 + av113 + av114 + av115 + av116 + av117 + av118 + av119 + av120+ 
				  	   av121 + av122 + av123 + av124 + av125 + av126 + av127 + av128  + av129 + av130+
						   av131 + av132 ;
					
				RiskView_Attributes_Reports.Average_func(DS2,'iaassessedvalue',ave1);
				RiskView_Attributes_Reports.Average_func(DS2,'ialastsaleamount',ave2);
				RiskView_Attributes_Reports.Average_func(DS2,'caassessedvalue',ave3);
		// RiskView_Attributes_Reports.Average_func(DS2,'caagelastsale',ave4);
      	RiskView_Attributes_Reports.Average_func(DS2,'calastsaleamount',ave5);
				RiskView_Attributes_Reports.Average_func(DS2,'paassessedvalue',ave6);
		  	RiskView_Attributes_Reports.Average_func(DS2,'palastsaleamount',ave7);
		  	RiskView_Attributes_Reports.Average_func(DS2,'assesseddiff',ave8);
			 	RiskView_Attributes_Reports.Average_func(DS2,'distcurrprev',ave9);
				RiskView_Attributes_Reports.Average_func(DS2,'assesseddiff2',ave10);
		   	RiskView_Attributes_Reports.Average_func(DS2,'property_owned_assessed_total',ave11);
			 	RiskView_Attributes_Reports.Average_func(DS2,'propagenewestsale',ave12);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddrtaxmarketvalue',ave13);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmtax',ave14);
      	RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmsalesprice',ave15);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmhedonic',ave16);
      	RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmvalue',ave17);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddrtaxmarketvalue',ave18);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddravmtax',ave19);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddravmsalesprice',ave20);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddravmhedonic',ave21);
      	RiskView_Attributes_Reports.Average_func(DS2,'curraddravmvalue',ave22);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddrtaxmarketvalue',ave23);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddravmtax',ave24);
      	RiskView_Attributes_Reports.Average_func(DS2,'prevaddravmsalesprice',ave25);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddravmhedonic',ave26);
      	RiskView_Attributes_Reports.Average_func(DS2,'prevaddravmvalue',ave27);
				RiskView_Attributes_Reports.Average_func(DS2,'predictedannualincome',ave28);
				RiskView_Attributes_Reports.Average_func(DS2,'propnewestsaleprice',ave29);
				RiskView_Attributes_Reports.Average_func(DS2,'lienfederaltaxfiledtotal',ave30);
				RiskView_Attributes_Reports.Average_func(DS2,'lientaxotherfiledtotal',ave31);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienforeclosurefiledtotal',ave32);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienpreforeclosurefiledtotal',ave33);
				RiskView_Attributes_Reports.Average_func(DS2,'lienlandlordtenantfiledtotal',ave34);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienjudgmentfiledtotal',ave35);
				RiskView_Attributes_Reports.Average_func(DS2,'liensmallclaimsfiledtotal',ave36);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienotherfiledtotal',ave37);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienfederaltaxreleasedtotal',ave38);
				RiskView_Attributes_Reports.Average_func(DS2,'lientaxotherreleasedtotal',ave39);
				RiskView_Attributes_Reports.Average_func(DS2,'lienforeclosurereleasedtotal',ave40);
				RiskView_Attributes_Reports.Average_func(DS2,'lienpreforeclosurereleasedtotal',ave41);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienlandlordtenantreleasedtotal',ave42);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienjudgmentreleasedtotal',ave43);
				RiskView_Attributes_Reports.Average_func(DS2,'liensmallclaimsreleasedtotal',ave44);
				RiskView_Attributes_Reports.Average_func(DS2,'lienotherreleasedtotal',ave45);
			  RiskView_Attributes_Reports.Average_func(DS2,'ageoldestrecord',ave46);
				RiskView_Attributes_Reports.Average_func(DS2,'agenewestrecord',ave47);
				RiskView_Attributes_Reports.Average_func(DS2,'iaageoldestrecord',ave48);
				RiskView_Attributes_Reports.Average_func(DS2,'iaagenewestrecord',ave49);
				RiskView_Attributes_Reports.Average_func(DS2,'iaagelastsale',ave50);
				RiskView_Attributes_Reports.Average_func(DS2,'caageoldestrecord',ave51);
      	RiskView_Attributes_Reports.Average_func(DS2,'caagenewestrecord',ave52);
      	RiskView_Attributes_Reports.Average_func(DS2,'calenofres',ave53);
				RiskView_Attributes_Reports.Average_func(DS2,'paageoldestrecord',ave54);
      	RiskView_Attributes_Reports.Average_func(DS2,'paagenewestrecord',ave55);
				RiskView_Attributes_Reports.Average_func(DS2,'palenofres',ave56);
				RiskView_Attributes_Reports.Average_func(DS2,'paagelastsale',ave57);
				RiskView_Attributes_Reports.Average_func(DS2,'caagelastsale',ave58);
				RiskView_Attributes_Reports.Average_func(DS2,'propageoldestpurchase',ave59);
      	RiskView_Attributes_Reports.Average_func(DS2,'propagenewestpurchase',ave60);
				RiskView_Attributes_Reports.Average_func(DS2,'derogage',ave61);
				RiskView_Attributes_Reports.Average_func(DS2,'felonyage',ave62);				
				RiskView_Attributes_Reports.Average_func(DS2,'lienfiledage',ave63);
				RiskView_Attributes_Reports.Average_func(DS2,'evictionage',ave64);
				RiskView_Attributes_Reports.Average_func(DS2,'proflicage',ave65);
				RiskView_Attributes_Reports.Average_func(DS2,'inferredminimumage',ave66);
				RiskView_Attributes_Reports.Average_func(DS2,'bestreportedage',ave67);
				RiskView_Attributes_Reports.Average_func(DS2,'phoneedaageoldestrecord',ave68);
				RiskView_Attributes_Reports.Average_func(DS2,'phoneedaagenewestrecord',ave69);
				RiskView_Attributes_Reports.Average_func(DS2,'phoneotherageoldestrecord',ave70);
				RiskView_Attributes_Reports.Average_func(DS2,'phoneotheragenewestrecord',ave71);
				
      RiskView_Attributes_Reports.Average_func(DS2,'subjectaddrcount',ave72);
					RiskView_Attributes_Reports.Average_func(DS2,'subjectphonecount',ave73);
					RiskView_Attributes_Reports.Average_func(DS2,'subjectssnrecentcount',ave74);
					RiskView_Attributes_Reports.Average_func(DS2,'subjectaddrrecentcount',ave75);
					RiskView_Attributes_Reports.Average_func(DS2,'subjectphonerecentcount',ave76);
					RiskView_Attributes_Reports.Average_func(DS2,'ssnidentitiescount',ave77);
					RiskView_Attributes_Reports.Average_func(DS2,'ssnaddrcount',ave78);
			    RiskView_Attributes_Reports.Average_func(DS2,'ssnidentitiesrecentcount',ave79);
					RiskView_Attributes_Reports.Average_func(DS2,'ssnaddrrecentcount',ave80);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddridentitiescount',ave81);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrssncount',ave82);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrphonecount',ave83);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddridentitiesrecentcount',ave84);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrssnrecentcount',ave85);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddrphonerecentcount',ave86);
					RiskView_Attributes_Reports.Average_func(DS2,'phoneidentitiescount',ave87);
				  RiskView_Attributes_Reports.Average_func(DS2,'phoneidentitiesrecentcount',ave88);
					RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmconfidence',ave89);
					RiskView_Attributes_Reports.Average_func(DS2,'curraddravmconfidence',ave90);
					RiskView_Attributes_Reports.Average_func(DS2,'prevaddravmconfidence',ave91);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimesolicitedcount',ave92);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimesolicitedcount01',ave93);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimesolicitedcount03',ave94);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimesolicitedcount06',ave95);
				  RiskView_Attributes_Reports.Average_func(DS2,'subprimesolicitedcount12',ave96);
		  		RiskView_Attributes_Reports.Average_func(DS2,'subprimesolicitedcount24',ave97);
			  	RiskView_Attributes_Reports.Average_func(DS2,'subprimesolicitedcount36',ave98);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimesolicitedcount60',ave99);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfederaltaxfiledcount',ave100);
      	  RiskView_Attributes_Reports.Average_func(DS2,'lientaxotherfiledcount',ave101);
      	  RiskView_Attributes_Reports.Average_func(DS2,'lienforeclosurefiledcount',ave102);
				  RiskView_Attributes_Reports.Average_func(DS2,'lienpreforeclosurefiledcount',ave103);
      	  RiskView_Attributes_Reports.Average_func(DS2,'lienlandlordtenantfiledcount',ave104);
      	  RiskView_Attributes_Reports.Average_func(DS2,'lienjudgmentfiledcount',ave105);
				  RiskView_Attributes_Reports.Average_func(DS2,'liensmallclaimsfiledcount',ave106);
      	  RiskView_Attributes_Reports.Average_func(DS2,'lienotherfiledcount',ave107);
      	  RiskView_Attributes_Reports.Average_func(DS2,'lienfederaltaxreleasedcount',ave108);
			    RiskView_Attributes_Reports.Average_func(DS2,'lientaxotherreleasedcount',ave109);
				  RiskView_Attributes_Reports.Average_func(DS2,'lienforeclosurereleasedcount',ave110);
      	  RiskView_Attributes_Reports.Average_func(DS2,'lienpreforeclosurereleasedcount',ave111);
      	  RiskView_Attributes_Reports.Average_func(DS2,'lienlandlordtenantreleasedcount',ave112);
				  RiskView_Attributes_Reports.Average_func(DS2,'lienjudgmentreleasedcount',ave113);
					RiskView_Attributes_Reports.Average_func(DS2,'liensmallclaimsreleasedcount',ave114);
					RiskView_Attributes_Reports.Average_func(DS2,'lienotherreleasedcount',ave115);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcy_count',ave116);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcy_count30',ave117);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcy_count90',ave118);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcy_count180',ave119);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcy_count12',ave120);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcy_count24',ave121);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcy_count36',ave122);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcy_count60',ave123);
					RiskView_Attributes_Reports.Average_func(DS2,'eviction_count',ave124);
					RiskView_Attributes_Reports.Average_func(DS2,'eviction_count30',ave125);
					RiskView_Attributes_Reports.Average_func(DS2,'eviction_count90',ave126);
					RiskView_Attributes_Reports.Average_func(DS2,'eviction_count180',ave127);
				  RiskView_Attributes_Reports.Average_func(DS2,'eviction_count12',ave128);
					RiskView_Attributes_Reports.Average_func(DS2,'eviction_count24',ave129);
					RiskView_Attributes_Reports.Average_func(DS2,'eviction_count36',ave130);
					RiskView_Attributes_Reports.Average_func(DS2,'eviction_count60',ave131);    
					RiskView_Attributes_Reports.Average_func(DS2,'subjectssncount',ave132);
			    
								 
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
						   ave131 + ave132;
					
								 			 
	
	
	 result3_stats:=av;
   result4_stats:=avearage;
	 
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
   																							,transform(	compare_layout, self.file_version:='fcra_experian_rva_v3',
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
   																							,transform(	compare_layout, self.file_version:='fcra_experian_rva_v3',
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