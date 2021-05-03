import Worldcheck_Bridger;
export Reformat := module 


	export Inputs := module
#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);
		export gwl := Accuity.Files.input.gwl.entity;
		export msb := dataset([],Accuity.Layouts.input.rEntity);//Accuity.Files.input.msb.entity(type != '02');
		export ofac:= dataset([],Accuity.Layouts.input.rEntity);//Accuity.Files.input.ofac.entity(type != '02');
		export geo := Accuity.Files.input.gwl.entity(type IN ['01', '02']);
	end;
//////////////////////////////////////////////////////////////////
//normalize and Reformat Entity Child Records
export normalizd := module
	export gwl := module
		export Alias := 				Accuity.Functions.normAliases(Inputs.gwl);
		export Addresses := 			Accuity.Functions.normAddresses(Inputs.gwl);
	  export Citizenship := 		    Accuity.Functions.normCitizenship(Inputs.gwl);
		export Dob			 := 		Accuity.Functions.normDob(Inputs.gwl);
		export Identifications := 		Accuity.Functions.normIds(Inputs.gwl);
	  export Nationality := 		    Accuity.Functions.normNationality(Inputs.gwl);
		export Phones := 				  	  Accuity.Functions.normPhones(Inputs.gwl);
		export Pob			 := 					Accuity.Functions.normPob(Inputs.gwl);
		export Programs := 				    Accuity.Functions.normPrograms(Inputs.gwl);
		export RoutingCodes := 				Accuity.Functions.normRoutingCodes(Inputs.gwl);
		export Supplemental := 		    Accuity.Functions.normAddl(Inputs.gwl);
end;
	export msb := module
	export Alias := 							Accuity.Functions.normAliases(Inputs.msb);
	export Addresses := 					Accuity.Functions.normAddresses(Inputs.msb);
	export Citizenship := 		    Accuity.Functions.normCitizenship(Inputs.msb);
	export Dob			 := 				Accuity.Functions.normDob(Inputs.msb);
	export Identifications := 		Accuity.Functions.normIds(Inputs.msb);
	export Nationality := 		    Accuity.Functions.normNationality(Inputs.msb);
	export Phones := 				  		Accuity.Functions.normPhones(Inputs.msb);
	export Pob			 := 					Accuity.Functions.normPob(Inputs.msb);
	export Programs := 				  	Accuity.Functions.normPrograms(Inputs.msb);
	export RoutingCodes := 				Accuity.Functions.normRoutingCodes(Inputs.msb);
	export Supplemental := 		  	Accuity.Functions.normAddl(Inputs.msb);
end;
	export ofac := module
		export Alias := 							Accuity.Functions.normAliases(Inputs.ofac);
		export Addresses := 					Accuity.Functions.normAddresses(Inputs.ofac);
	  export Citizenship := 		    Accuity.Functions.normCitizenship(Inputs.ofac);
		export Dob			 := 					Accuity.Functions.normDob(Inputs.ofac);
		export Identifications := 		Accuity.Functions.normIds(Inputs.ofac);
	  export Nationality := 		    Accuity.Functions.normNationality(Inputs.ofac);
		export Phones := 				  		Accuity.Functions.normPhones(Inputs.ofac);
		export Pob			 := 					Accuity.Functions.normPob(Inputs.ofac);
		export Programs := 				  	Accuity.Functions.normPrograms(Inputs.ofac);
		export RoutingCodes := 				Accuity.Functions.normRoutingCodes(Inputs.ofac);
		export Supplemental := 		  	Accuity.Functions.normAddl(Inputs.ofac);
end;
end;

export Additional := module
	export gwl := sort(distribute(normalizd.gwl.Citizenship
															 +normalizd.gwl.Dob
															 +normalizd.gwl.Pob
															 +normalizd.gwl.Nationality
															 +normalizd.gwl.Programs
															// +normalizd.gwl.RoutingCodes
															 +normalizd.gwl.Supplemental,hash(id)),id,local);
	export msb := sort(distribute(normalizd.msb.Citizenship
															 +normalizd.msb.Dob
															 +normalizd.msb.Pob
															 +normalizd.msb.Nationality
															 +normalizd.msb.Programs
															// +normalizd.msb.RoutingCodes
															 +normalizd.msb.Supplemental,hash(id)),id,local);
	export ofac:= sort(distribute(normalizd.ofac.Citizenship
															 +normalizd.ofac.Dob
															 +normalizd.ofac.Pob
															 +normalizd.ofac.Nationality
															 +normalizd.ofac.Programs
															// +normalizd.ofac.RoutingCodes
															 +normalizd.ofac.Supplemental,hash(id)),id,local);
end;

//////////////////////////////////////////////////////////////////
//reFormat Entity Parent Records
export Parent := module
//	export GWL:= 	Accuity.Functions.mapEntity(Inputs.gwl(type NOT IN ['01', '02','06']),normalizd.gwl.Supplemental);
	export GWL:= 	Accuity.Functions.mapEntity(Inputs.gwl(type NOT IN ['01', '02']),normalizd.gwl.Supplemental);
	export MSB:= 	Accuity.Functions.mapEntity(Inputs.msb,normalizd.msb.Supplemental);
	export OFAC:= 	Accuity.Functions.mapEntity(Inputs.ofac,normalizd.ofac.Supplemental); 
	export GEO:= 	Accuity.Functions.mapEntity(Inputs.gwl(type IN ['01', '02']),normalizd.gwl.Supplemental);
end;

//////////////////////////////////////////////////////////////////
//Denormalize Entity Child Records
export denormalizd := module
		export gwl := module
			export Alias:= 							Accuity.Functions.denormAliases(normalizd.gwl.Alias);
			export Addresses := 				Accuity.Functions.denormAddresses(normalizd.gwl.Addresses);
			export Identifications := 	Accuity.Functions.denormIds(normalizd.gwl.Identifications);
			export Phones := 				  	Accuity.Functions.denormPhones(normalizd.gwl.Phones);
			export Supplemental := 		  Accuity.Functions.denormAddl(Additional.gwl);
		end;
		export msb := module
			export Alias := 						Accuity.Functions.denormAliases(normalizd.msb.Alias);
			export Addresses := 				Accuity.Functions.denormAddresses(normalizd.msb.Addresses);
			export Identifications := 	Accuity.Functions.denormIds(normalizd.msb.Identifications);
			export Phones := 				  	Accuity.Functions.denormPhones(normalizd.msb.Phones);
			export Supplemental := 		  Accuity.Functions.denormAddl(Additional.msb);
		end;
		export ofac := module
			export Alias := 						Accuity.Functions.denormAliases(normalizd.ofac.Alias);
			export Addresses := 				Accuity.Functions.denormAddresses(normalizd.ofac.Addresses);
			export Identifications := 	Accuity.Functions.denormIds(normalizd.ofac.Identifications);
			export Phones := 				  	Accuity.Functions.denormPhones(normalizd.ofac.Phones);
			export Supplemental := 		  Accuity.Functions.denormAddl(Additional.ofac);
		end;
end;

export outputs := module
	export GWL:=Accuity.Functions.linkAge(
				 Accuity.Functions.linkAlias(
					Accuity.Functions.linkAddr(
							Accuity.Functions.linkId(
								Accuity.Functions.linkPhone(
										Accuity.Functions.linkAddl(Parent.GWL,denormalizd.gwl.Supplemental)
							,denormalizd.gwl.Phones)
						,denormalizd.gwl.Identifications)
				,denormalizd.gwl.Addresses)
			,denormalizd.gwl.Alias)
		 ,normalizd.gwl.Dob);
	export MSB:=Accuity.Functions.linkAge(
				 Accuity.Functions.linkAlias(
					Accuity.Functions.linkAddr(
							Accuity.Functions.linkId(
								Accuity.Functions.linkPhone(
										Accuity.Functions.linkAddl(Parent.MSB,denormalizd.msb.Supplemental)
							,denormalizd.msb.Phones)
						,denormalizd.msb.Identifications)
				,denormalizd.msb.Addresses)
			,denormalizd.msb.Alias)
		 ,normalizd.msb.Dob);
	export OFAC:=Accuity.Functions.linkAge(
         Accuity.Functions.linkAlias(
					Accuity.Functions.linkAddr(
							Accuity.Functions.linkId(
								Accuity.Functions.linkPhone(
										Accuity.Functions.linkAddl(Parent.OFAC,denormalizd.ofac.Supplemental)
							,denormalizd.ofac.Phones)
						,denormalizd.ofac.Identifications)
				,denormalizd.ofac.Addresses)
			,denormalizd.ofac.Alias)
		 ,normalizd.ofac.Dob);
		 
	export Geo:=Accuity.Functions.linkAge(
				 Accuity.Functions.linkAlias(
					Accuity.Functions.linkAddr(
							Accuity.Functions.linkId(
								Accuity.Functions.linkPhone(
										Accuity.Functions.linkAddl(Parent.Geo,denormalizd.gwl.Supplemental)
							,denormalizd.gwl.Phones)
						,denormalizd.gwl.Identifications)
				,denormalizd.gwl.Addresses)
			,denormalizd.gwl.Alias)
		 ,normalizd.gwl.Dob);

//export allsources := sort(distribute(dedup(GWL+MSB+OFAC,record,all),hash(id)),id,local)(accuityDataSource in Accuity.Sets.include.source_listID):persist('~hthor::persist::accuity::allsources');
export allsources := 
						PROJECT(
							sort(distribute(dedup(GWL+MSB+OFAC,record,all),hash(id)),id,local)(accuityDataSource in Accuity.Sets.include.source_listID),
							TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp,
													self.comments := IF(LEFT.comments='',GetDisclaimer(LEFT.accuityDataSource),
																						LEFT.comments +
																							IF(GetDisclaimer(LEFT.accuityDataSource)='','',
																								' || ' + GetDisclaimer(LEFT.accuityDataSource)));
													self := LEFT;))
												:persist('~thor::persist::accuity::allsources');
export allofac := allsources(accuityDataSource in Accuity.Sets.include.source_ofac);
export allgeo := sort(distribute(dedup(Geo,record,all),hash(id)),id,local);
//source code	
//list id	
//source name
export source_311_1022  := allsources(accuityDataSource='311 1022'); //Section 311
export source_ACB_1040  := allsources(accuityDataSource='ACB 1040'); //AUSTRIAN CENTRAL BANK
export source_ARG_1006  := allsources(accuityDataSource='ARG 1006'); //Argentina
export source_ALL_1180  := allsources(accuityDataSource='ALL 1180'); //*ARAB LEAGUE LIST
export source_AU_27     := allsources(accuityDataSource='AU 27');    //Austrac List
export source_BCW_1074  := allsources(accuityDataSource='BCW 1074'); //Central Bank of the Bahamas - CWL
export source_BEL_1008  := allsources(accuityDataSource='BEL 1008'); //Belgium List
export source_BIS_28    := allsources(accuityDataSource='BIS 28');   //Bureau of Industry and Security
export source_BIT_1086  := allsources(accuityDataSource='BIT 1086'); //BANK OF ITALY UNAUTHORIZED FINANCIAL ACTIVITY LIST
export source_BofE_29   := allsources(accuityDataSource='BofE 29');  //Bank of England List
export source_CAC_1146  := allsources(accuityDataSource='CAC 1146'); //UN CHILDREN AND ARMED CONFLICT LIST
export source_CBI_1054  := allsources(accuityDataSource='CBI 1054'); //CBI INDIA
export source_CBIWN_30  := allsources(accuityDataSource='CBI WN 30');//Central Bank of Ireland Warning Notices
export source_CEL_1082  := allsources(accuityDataSource='CEL 1082'); //CANADIAN ECONOMIC SANCTIONED COUNTRIES LIST
export source_CEL_1082_noncountries  := allsources(accuityDataSource='CEL 1082'); //CANADIAN ECONOMIC SANCTIONED COUNTRIES LIST
export source_CEL_1082_countries     := allgeo(accuityDataSource='CEL 1082'); //CANADIAN ECONOMIC SANCTIONED COUNTRIES LIST
export source_CNA_1044  := allsources(accuityDataSource='CNA 1044'); //CHINESE MINISTRY
export source_CSL_1080  := allsources(accuityDataSource='CSL 1080'); //CANADIAN ECONOMIC UN SANCTIONS LIST
export source_CSO_1062  := allsources(accuityDataSource='CSO 1062'); //CBS OFFSHORE BANKS
export source_CSSF_1114 := allsources(accuityDataSource='CSSF 1114');//LUXEMBOURG CSSF
export source_CWL_32    := allsources(accuityDataSource='CWL 32');   //Cumulative Warning List
export source_DB_1088   := allsources(accuityDataSource='DB 1088');   //GERMAN FEDERAL BANK
export source_DNB_1090  := allsources(accuityDataSource='DNB 1090'); //DUTCH BANK
export source_DTC_1030  := allsources(accuityDataSource='DTC 1030'); //Defense Trade Controls
//export source_ECO_1144  := allsources(accuityDataSource='ECO 1144'); //EXPORT CONTROL ORGANISATION UK - IRAN LIST
//export source_ES_1014   := allsources(accuityDataSource='ES 1014');  //Spain
export source_ESE_1158  := allsources(accuityDataSource='ESE 1158'); //EGYPT FINANCIAL SUPERVISORY AUTHORITY
export source_EU_33     := allsources(accuityDataSource='EU 33');    //European Union List
export source_EUE_1170  := allsources(accuityDataSource='EUE 1170'); //European Union Enhancements List
export source_FBI_35    := allsources(accuityDataSource='FBI 35');   //FBI Most Wanted
export source_FDJ_1152  := allsources(accuityDataSource='FDJ 1152'); //FATF Deficient Jurisdictions List
//export source_FMU_1126  := allsources(accuityDataSource='FMU 1126'); //UKRAINE FINANCIAL MONITORING
export source_FR_1010   := allsources(accuityDataSource='FR 1010');  //France
export source_GO_36     := allsources(accuityDataSource='GO 36');    //World Government Officials List
export source_HK_37     := allsources(accuityDataSource='HK 37');    //Hong Kong Monetary Authority List
export source_HMC_1178  := allgeo(accuityDataSource='HMC 1178'); //*HMT COUNTRY REGIMES
export source_HME_1130  := allsources(accuityDataSource='HME 1130'); //HMT ENHANCEMENT LIST
export source_IA_1134   := allsources(accuityDataSource='IA 1134');  //INKSNA LIST
export source_IND_1048  := allsources(accuityDataSource='IND 1048'); //INDIAN MINISTRY OF HOME AFFAIRS
export source_INTERPOL_38 := allsources(accuityDataSource='INTERPOL 38'); //INTERPOL List
export source_ISA_1164  := allsources(accuityDataSource='ISA 1164'); //*IRAN SANCTIONS ACT
export source_ISN_1052  := allsources(accuityDataSource='ISN 1052'); //BUREAU OF INTERNATIONAL SECURITY & NONPROLIFERATION
export source_ITL_1078  := allsources(accuityDataSource='ITL 1078'); //ISRAELI MOD TERROR LIST
export source_JMF_1066  := allsources(accuityDataSource='JMF 1066'); //JAPAN - MINISTRY OF FINANCE
export source_MEX_1038  := allsources(accuityDataSource='MEX 1038'); //Mexican Administrative Sanctions
export source_MFR_1068  := allsources(accuityDataSource='MFR 1068'); //MAURITIUS FSC REVOCATIONS
//export source_MSB_1036  := allsources(accuityDataSource='MSB 1036'); //Money Services Business (MSB) Agent 
export source_NEP_1156  := allsources(accuityDataSource='NEP 1156'); //NEPAL CREDIT INFORMATION BUREAU
export source_NST_0     := allsources(accuityDataSource='NST * 0');  //NS-SDN
export source_NZ_1140   := allsources(accuityDataSource='NZ 1140');  //NEW ZEALAND POLICE
export source_OCC_39    := allsources(accuityDataSource='OCC 39');   //OCC List
export source_OCF_1122  := allsources(accuityDataSource='OCF 1122'); //OCC Counterfeit List
export source_OCR_1186  := allgeo(accuityDataSource='OCR 1186'); //*OFAC COUNTRY REGIMES
export source_OGO_1072  := allsources(accuityDataSource='OGO 1072'); //Government Officials (OFAC)
export source_OSFI_41   := allsources(accuityDataSource='OSFI 41');  //OSFI Canadian List
export source_PRT_1128  := allsources(accuityDataSource='PRT 1128'); //Sanctioned Airport and Seaport List
export source_RBL_1072  := allsources(accuityDataSource='RBL 1072'); //Restricted or Blocked Locations (OFAC)
export source_REG_1072  := allsources(accuityDataSource='REG 1072'); //Federal Register (OFAC)
export source_RPL_1176  := allsources(accuityDataSource='RPL 1176'); //*RUSSIAN ROSFINMONITORING PUBLIC
export source_RRM_1116  := allsources(accuityDataSource='RRM 1116'); //RUSSIAN ROSFINMONITORING LIST
export source_SAP_1056  := allsources(accuityDataSource='SAP 1056'); //SOUTH AFRICAN POLICE WANTED
export source_SAR_1032  := allsources(accuityDataSource='SAR 1032'); //SAUDI ARABIA - Most Wanted List
export source_SECO_42   := allsources(accuityDataSource='SECO 42');  //Swiss State Secretariat for Economic Affairs
export source_SGP_43    := allsources(accuityDataSource='SGP 43');   //Monetary Authority of Singapore List
export source_SL_1136   := allsources(accuityDataSource='SL 1136');  //SLOVAKIAN LIST
export source_TEL_1028  := allsources(accuityDataSource='TEL 1028'); //Terrorist Exclusion List
export source_TFP_1072  := allsources(accuityDataSource='TFP 1072'); //Accuity Research (OFAC)
export source_TW_1016   := allsources(accuityDataSource='TW 1016');  //Taiwan
//export source_UGO_1120  := allsources(accuityDataSource='UGO 1120'); //U.S. Government Officials
export source_UK_1046   := allsources(accuityDataSource='UK 1046');  //UK HOME OFFICE
export source_UN_44     := allsources(accuityDataSource='UN 44');    //United Nations Sanctions List
export source_UNE_1172  := allsources(accuityDataSource='UNE 1172'); //United Nations Enhancements List
export source_UN        := allsources(accuityDataSource IN ['UN 1064', 'UNT 1064']);  //	*UNITED NATIONS and UN TRAVEL RESTRICTIONS combined per Bridger
//export source_UN_1064   := allsources(entity_added_by[1..stringlib.stringfind(entity_added_by,':',1)-1] = 'UN 1064');  //	*UNITED NATIONS
//export source_UNT_1064  := allsources(entity_added_by[1..stringlib.stringfind(entity_added_by,':',1)-1] = 'UNT 1064'); //UN TRAVEL RESTRICTIONS

export source_USM_45    := allsources(accuityDataSource='USM 45');   //US Marshals
export source_USSD_1072 := allsources(accuityDataSource='USSD 1072');//US State Department (OFAC)
export source_UST_0     := allsources(accuityDataSource='UST 0');    //US Treasury SDN List (OFAC)
export source_WBD_1072  := allsources(accuityDataSource='WBD 1072'); //World Bank Directory (OFAC)
export source_WMDREGS_1072 	:= allsources(accuityDataSource='WMD REGS 1072'); //Weapons of Mass Destruction Regs (OFAC)
export source_WORLDBANK_46 	:= allsources(accuityDataSource='WORLD BANK 46'); //World Bank Debarred List
end;
end;
