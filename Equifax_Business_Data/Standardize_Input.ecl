IMPORT  _Validate,  tools,  ut, MDR, std;

export  Standardize_Input :=  MODULE;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- map fields
	// -- do any conversions/validations
	//////////////////////////////////////////////////////////////////////////////////////
EXPORT fPreProcess(DATASET(Equifax_Business_Data.Layouts.Sprayed_Input) pRawInput, string pversion) := FUNCTION
	  
		// Normalize on the two sets of address fields:  Physical and Mailing Addresses
		Equifax_Business_Data.Layouts.Base NormTrf(Equifax_Business_Data.Layouts.Sprayed_Input L, unsigned1 cnt) := transform
			,skip ((cnt=2 and L.EFX_SECADR+L.EFX_SECCTY+L.EFX_SECSTAT+L.EFX_SECZIP = '')
			       or (cnt=2 and L.EFX_SECADR+L.EFX_SECCTY+L.EFX_SECSTAT+L.EFX_SECZIP = 
						 L.EFX_ADDRESS+L.EFX_CITY+L.EFX_STATE+L.EFX_ZIPCODE)
						 or (cnt=3 and L.EFX_LEGAL_NAME = '')
			       or (cnt=3 and L.EFX_LEGAL_NAME = L.EFX_NAME)
						 or (cnt=4 and L.EFX_LEGAL_NAME = '')
			       or (cnt=4 and L.EFX_LEGAL_NAME = L.EFX_NAME)
						 or (cnt=4 and L.EFX_SECADR+L.EFX_SECCTY+L.EFX_SECSTAT+L.EFX_SECZIP = '')
			       or (cnt=4 and L.EFX_SECADR+L.EFX_SECCTY+L.EFX_SECSTAT+L.EFX_SECZIP = 
						 L.EFX_ADDRESS+L.EFX_CITY+L.EFX_STATE+L.EFX_ZIPCODE)
						 or (L.EFX_ID = 'EFX_ID'))
		
        isPoBox := REGEXFIND('PO BOX|P.O. BOX|P O BOX|P M B [0-9]+ BOX |P OBOX|PB BOX|PCS [0-9]+ BOX |PFC [0-9]+ BOX |PMB [0-9]+ BOX |PMB BOX|PO MBOX|PO OFFICE BOX|POM BOX|PONBOX|POO BOX|POP BOX|POST BOX|POST OFFICEBOX|POSTAGE BOX|POSTAL BOX|POSTBOX|POSTXBOX|POTBOX|PPP BOX|PSC [0-9]+ BOX|UAM BOX|UCSF BOX|UNIT [0-9]+ BOX',
       				              L.EFX_ADDRESS,NOCASE);		
		
        SELF.NormCompany_Name   := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_NAME)  
																							,ut.CleanSpacesAndUpper(L.EFX_NAME)  
																							,ut.CleanSpacesAndUpper(L.EFX_LEGAL_NAME)
																							,ut.CleanSpacesAndUpper(L.EFX_LEGAL_NAME));
			  SELF.NormCompany_Type := choose(cnt ,if(L.EFX_NAME != L.EFX_LEGAL_NAME, 'D', 'L')
				                                    ,if(L.EFX_NAME != L.EFX_LEGAL_NAME, 'D', 'L')
																						,'L'
																						,'L');
				SELF.Norm_Address   := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_ADDRESS)
																					,ut.CleanSpacesAndUpper(L.EFX_SECADR) 
				                                  ,ut.CleanSpacesAndUpper(L.EFX_ADDRESS)
																					,ut.CleanSpacesAndUpper(L.EFX_SECADR));																												 
				SELF.NormAddress_Type   := choose(cnt ,if(isPoBox,'M','P') 
																							,'M'
																							,if(isPoBox,'M','P')
																							,'M');
																							
				SELF.Norm_City	  := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_CITY)    
																				,ut.CleanSpacesAndUpper(L.EFX_SECCTY)
																				,ut.CleanSpacesAndUpper(L.EFX_CITY)    
																				,ut.CleanSpacesAndUpper(L.EFX_SECCTY));																					
																				
				SELF.Norm_Ctryisocd    := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_CTRYISOCD) 
																						 ,ut.CleanSpacesAndUpper(L.EFX_SECCTRYISOCD)
																						 ,ut.CleanSpacesAndUpper(L.EFX_CTRYISOCD) 
																						 ,ut.CleanSpacesAndUpper(L.EFX_SECCTRYISOCD));
																																							
				tempState  := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_STATE)    
																			 ,ut.CleanSpacesAndUpper(L.EFX_SECSTAT)
																			 ,ut.CleanSpacesAndUpper(L.EFX_STATE)    
																			 ,ut.CleanSpacesAndUpper(L.EFX_SECSTAT));		
		
				SELF.Norm_StateC2  := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_STATEC)    
																				 ,ut.CleanSpacesAndUpper(L.EFX_STATEC2)
																				 ,ut.CleanSpacesAndUpper(L.EFX_STATEC)    
																				 ,ut.CleanSpacesAndUpper(L.EFX_STATEC2));
        		
			  tempCorrectedState := IF(SELF.NORM_CTRYISOCD = 'USA' 
			                                and EFX_STATE_TABLE.STATE(tempState) != ' '
			                                and EFX_STATE_TABLE.STATE(tempState) != 'INVALID', tempState,
																			EFX_STATEC_TABLE.STATEC(SELF.norm_StateC2));
																			
			  correctedState := IF(tempCorrectedState != '' AND tempCorrectedState != 'INVALID', tempCorrectedState, tempState);																																				
	  
        SELF.Norm_State := correctedState;
				
				SELF.Norm_Zip    := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_ZIPCODE) 
																			 ,ut.CleanSpacesAndUpper(L.EFX_SECZIP)
																			 ,ut.CleanSpacesAndUpper(L.EFX_ZIPCODE) 
																			 ,ut.CleanSpacesAndUpper(L.EFX_SECZIP));
				SELF.Norm_Zip4  := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_ZIP4) 
																			,ut.CleanSpacesAndUpper(L.EFX_SECZIP4)
																			,ut.CleanSpacesAndUpper(L.EFX_ZIP4) 
																			,ut.CleanSpacesAndUpper(L.EFX_SECZIP4));
				SELF.Norm_Lat   := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_LAT)  
																			,ut.CleanSpacesAndUpper(L.EFX_SECLAT)
																			,ut.CleanSpacesAndUpper(L.EFX_LAT)  
																			,ut.CleanSpacesAndUpper(L.EFX_SECLAT));  
				SELF.Norm_Lon := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_LON)
																		,ut.CleanSpacesAndUpper(L.EFX_SECLON)
																		,ut.CleanSpacesAndUpper(L.EFX_LON)
																		,ut.CleanSpacesAndUpper(L.EFX_SECLON));  															 
				SELF.Norm_Geoprec	  := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_GEOPREC)    
																					,ut.CleanSpacesAndUpper(L.EFX_SECGEOPREC)
																					,ut.CleanSpacesAndUpper(L.EFX_GEOPREC)    
																					,ut.CleanSpacesAndUpper(L.EFX_SECGEOPREC));
				SELF.Norm_Region  := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_REGION)    
																				,ut.CleanSpacesAndUpper(L.EFX_SECREGION)
																				,ut.CleanSpacesAndUpper(L.EFX_REGION)    
																				,ut.CleanSpacesAndUpper(L.EFX_SECREGION));
				SELF.Norm_Ctrynum  := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_CTRYNUM) 
																				 ,ut.CleanSpacesAndUpper(L.EFX_SECCTRYNUM)
																				 ,ut.CleanSpacesAndUpper(L.EFX_CTRYNUM) 
																				 ,ut.CleanSpacesAndUpper(L.EFX_SECCTRYNUM));
				SELF.Norm_Ctryname  := choose(cnt ,ut.CleanSpacesAndUpper(L.EFX_CTRYNAME) 
																					,ut.CleanSpacesAndUpper(L.EFX_SECCTRYNAME)
																					,ut.CleanSpacesAndUpper(L.EFX_CTRYNAME) 
																					,ut.CleanSpacesAndUpper(L.EFX_SECCTRYNAME));																		
				SELF.Norm_Geo_Precision := choose(cnt ,ut.CleanSpacesAndUpper(EFX_GEOPREC_TABLE.GEOPREC(L.EFX_GEOPREC))
				                                      ,ut.CleanSpacesAndUpper(EFX_GEOPREC_TABLE.GEOPREC(L.EFX_SECGEOPREC))
																							,ut.CleanSpacesAndUpper(EFX_GEOPREC_TABLE.GEOPREC(L.EFX_GEOPREC))
				                                      ,ut.CleanSpacesAndUpper(EFX_GEOPREC_TABLE.GEOPREC(L.EFX_SECGEOPREC)));
		    
				SELF.Exploded_Desc_Corporate_Amount_Precision := ut.CleanSpacesAndUpper(EFX_CORPAMOUNTPREC_TABLE.CORPAMOUNTPREC(L.EFX_CORPAMOUNTPREC));
				SELF.Exploded_Desc_Location_Amount_Precision := ut.CleanSpacesAndUpper(EFX_CORPAMOUNTPREC_TABLE.CORPAMOUNTPREC(L.EFX_LOCAMOUNTPREC));
		    SELF.Exploded_Desc_Public_Co_Indicator := ut.CleanSpacesAndUpper(EFX_PUBLIC_TABLE.PUBLIC(L.EFX_PUBLIC));
		    SELF.Exploded_Desc_Stock_Exchange := ut.CleanSpacesAndUpper(EFX_STKEXC_TABLE.STKEXC(L.EFX_STKEXC));
		    SELF.Exploded_Desc_Telemarketablity_Score := ut.CleanSpacesAndUpper(EFX_MRKT_TELESCORE_TABLE.MRKT_TELESCORE(L.EFX_MRKT_TELESCORE));
		    SELF.Exploded_Desc_Telemarketablity_Total_Indicator := ut.CleanSpacesAndUpper(EFX_MRKT_TOTALIND_TABLE.MRKT_TOTALIND(L.EFX_MRKT_TOTALIND));
		    SELF.Exploded_Desc_Telemarketablity_Total_Score := ut.CleanSpacesAndUpper(EFX_MRKT_TOTALSCORE_TABLE.MRKT_TOTALSCORE(L.EFX_MRKT_TOTALSCORE));
		    SELF.Exploded_Desc_Government1057_Entity := ut.CleanSpacesAndUpper(EFX_GOV1057_TABLE.GOV1057(L.EFX_GOV1057));			
		    SELF.Exploded_Desc_Merchant_Type := ut.CleanSpacesAndUpper(EFX_MERCTYPE_TABLE.MERCTYPE(L.EFX_MERCTYPE));			
				
				SELF.Exploded_Desc_Busstatcd := ut.CleanSpacesAndUpper(EFX_BUSSTATCD_TABLE.BUSSTATCD(L.EFX_BUSSTATCD));
				SELF.Exploded_Desc_CMSA := ut.CleanSpacesAndUpper(EFX_CMSA_TABLE.CMSA(L.EFX_CMSA));
				SELF.Exploded_Desc_Corpamountcd := ut.CleanSpacesAndUpper(EFX_CORPAMOUNTCD_TABLE.CORPAMOUNTCD(L.EFX_CORPAMOUNTCD)); 
				SELF.Exploded_Desc_Corpamounttp := ut.CleanSpacesAndUpper(EFX_CORPAMOUNTTP_TABLE.CORPAMOUNTTP(L.EFX_CORPAMOUNTTP));
				SELF.Exploded_Desc_Corpempcd := ut.CleanSpacesAndUpper(EFX_CORPEMPCD_TABLE.CORPEMPCD(L.EFX_CORPEMPCD));
				SELF.Exploded_Desc_Ctrytelcd := ut.CleanSpacesAndUpper(EFX_CTRYTELCD_TABLE.CTRYTELCD(L.EFX_CTRYTELCD)); 
				SELF			              := L;
				SELF 									  := [];
			end;
			
	  NormInput	:= Normalize(pRawInput, 4, NormTrf(left, counter));	
		

		Equifax_Business_Data.Layouts.Base tPreProcess(Equifax_Business_Data.Layouts.Base L) := TRANSFORM

			date_created := ut.date_slashed_MMDDYYYY_to_YYYYMMDD(L.EFX_DATE_CREATED);
			
			SELF.EFX_ID := ut.CleanSpacesAndUpper(L.EFX_ID);
			
			SELF.record_type := 'C';		
			SELF.rcid := 0;
			SELF.source := MDR.sourceTools.src_Equifax_Business_Data;	
		
			SELF.EFX_NAME :=  ut.CleanSpacesAndUpper(L.EFX_NAME);
			SELF.EFX_LEGAL_NAME :=  ut.CleanSpacesAndUpper(L.EFX_LEGAL_NAME);
			SELF.EFX_ADDRESS :=  ut.CleanSpacesAndUpper(L.EFX_ADDRESS);
			SELF.EFX_CITY :=  ut.CleanSpacesAndUpper(L.EFX_CITY);
			SELF.EFX_STATE :=  ut.CleanSpacesAndUpper(L.EFX_STATE);

			SELF.EFX_STATEC := ut.CleanSpacesAndUpper(L.EFX_STATEC);
			SELF.EFX_ZIPCODE := ut.CleanSpacesAndUpper(L.EFX_ZIPCODE);
			SELF.EFX_ZIP4 := ut.CleanSpacesAndUpper(L.EFX_ZIP4);;
			SELF.EFX_LAT := ut.CleanSpacesAndUpper(L.EFX_LAT);
			SELF.EFX_LON := ut.CleanSpacesAndUpper(L.EFX_LON);
			SELF.EFX_GEOPREC := ut.CleanSpacesAndUpper(L.EFX_GEOPREC);
			SELF.EFX_REGION :=  ut.CleanSpacesAndUpper(L.EFX_REGION);
			SELF.EFX_CTRYISOCD :=  ut.CleanSpacesAndUpper(L.EFX_CTRYISOCD);

			SELF.EFX_CTRYNUM := ut.CleanSpacesAndUpper(L.EFX_CTRYNUM);
			SELF.EFX_CTRYNAME :=  ut.CleanSpacesAndUpper(L.EFX_CTRYNAME);
			SELF.EFX_COUNTYNM :=  ut.CleanSpacesAndUpper(L.EFX_COUNTYNM);

			SELF.EFX_COUNTY := ut.CleanSpacesAndUpper(L.EFX_COUNTY);
			SELF.EFX_CMSA := ut.CleanSpacesAndUpper(L.EFX_CMSA);
			SELF.EFX_CMSADESC :=  ut.CleanSpacesAndUpper(L.EFX_CMSADESC);
			SELF.EFX_SOHO :=  ut.CleanSpacesAndUpper(L.EFX_SOHO);
			SELF.EFX_BIZ :=  ut.CleanSpacesAndUpper(L.EFX_BIZ);
			SELF.EFX_RES :=  ut.CleanSpacesAndUpper(L.EFX_RES);
			SELF.EFX_CMRA :=  ut.CleanSpacesAndUpper(L.EFX_CMRA);
			SELF.EFX_CONGRESS :=  ut.CleanSpacesAndUpper(L.EFX_CONGRESS);
			SELF.EFX_SECADR :=  ut.CleanSpacesAndUpper(L.EFX_SECADR);
			SELF.EFX_SECCTY :=  ut.CleanSpacesAndUpper(L.EFX_SECCTY);
			SELF.EFX_SECSTAT :=  ut.CleanSpacesAndUpper(L.EFX_SECSTAT);

			SELF.EFX_STATEC2 := ut.CleanSpacesAndUpper(L.EFX_STATEC2);
			SELF.EFX_SECZIP := ut.CleanSpacesAndUpper(L.EFX_SECZIP);
			SELF.EFX_SECZIP4 := ut.CleanSpacesAndUpper(L.EFX_SECZIP4);
			SELF.EFX_SECLAT := ut.CleanSpacesAndUpper(L.EFX_SECLAT);
			SELF.EFX_SECLON := ut.CleanSpacesAndUpper(L.EFX_SECLON);
			SELF.EFX_SECGEOPREC := ut.CleanSpacesAndUpper(L.EFX_SECGEOPREC);
			SELF.EFX_SECREGION :=  ut.CleanSpacesAndUpper(L.EFX_SECREGION);
			SELF.EFX_SECCTRYISOCD :=  ut.CleanSpacesAndUpper(L.EFX_SECCTRYISOCD);

			SELF.EFX_SECCTRYNUM := ut.CleanSpacesAndUpper(L.EFX_SECCTRYNUM);
			SELF.EFX_SECCTRYNAME :=  ut.CleanSpacesAndUpper(L.EFX_SECCTRYNAME);

			SELF.EFX_CTRYTELCD := ut.CleanSpacesAndUpper(L.EFX_CTRYTELCD);
			SELF.EFX_PHONE := ut.CleanPhone(L.EFX_PHONE);
			SELF.EFX_FAXPHONE := ut.CleanPhone(L.EFX_FAXPHONE);
			
			SELF.EFX_BUSSTAT :=  ut.CleanSpacesAndUpper(L.EFX_BUSSTAT);

			SELF.EFX_BUSSTATCD := ut.CleanSpacesAndUpper(L.EFX_BUSSTATCD);
			SELF.EFX_WEB :=  ut.CleanSpacesAndUpper(L.EFX_WEB);

			SELF.EFX_YREST := ut.CleanSpacesAndUpper(L.EFX_YREST);
			SELF.EFX_CORPEMPCNT := ut.CleanSpacesAndUpper(L.EFX_CORPEMPCNT);
			SELF.EFX_LOCEMPCNT := ut.CleanSpacesAndUpper(L.EFX_LOCEMPCNT);
			SELF.EFX_CORPEMPCD :=  ut.CleanSpacesAndUpper(L.EFX_CORPEMPCD);
			SELF.EFX_LOCEMPCD :=  ut.CleanSpacesAndUpper(L.EFX_LOCEMPCD);

			SELF.EFX_CORPAMOUNT := ut.CleanSpacesAndUpper(L.EFX_CORPAMOUNT);
			SELF.EFX_CORPAMOUNTCD :=  ut.CleanSpacesAndUpper(L.EFX_CORPAMOUNTCD);
			SELF.EFX_CORPAMOUNTTP :=  ut.CleanSpacesAndUpper(L.EFX_CORPAMOUNTTP);
			SELF.EFX_CORPAMOUNTPREC :=  ut.CleanSpacesAndUpper(L.EFX_CORPAMOUNTPREC);
			SELF.EFX_LOCAMOUNT := ut.CleanSpacesAndUpper(L.EFX_LOCAMOUNT);
			SELF.EFX_LOCAMOUNTCD :=  ut.CleanSpacesAndUpper(L.EFX_LOCAMOUNTCD);
			SELF.EFX_LOCAMOUNTTP :=  ut.CleanSpacesAndUpper(L.EFX_LOCAMOUNTTP);
      		
			SELF.EFX_LOCAMOUNTPREC :=  ut.CleanSpacesAndUpper(L.EFX_LOCAMOUNTPREC);
			SELF.EFX_PUBLIC := ut.CleanSpacesAndUpper(L.EFX_PUBLIC);
			SELF.EFX_STKEXC :=  ut.CleanSpacesAndUpper(L.EFX_STKEXC);
			SELF.EFX_TCKSYM :=  ut.CleanSpacesAndUpper(L.EFX_TCKSYM);

			SELF.EFX_PRIMSIC := ut.CleanSpacesAndUpper(L.EFX_PRIMSIC);
			SELF.EFX_SECSIC1 := ut.CleanSpacesAndUpper(L.EFX_SECSIC1);
			SELF.EFX_SECSIC2 := ut.CleanSpacesAndUpper(L.EFX_SECSIC2);
			SELF.EFX_SECSIC3 := ut.CleanSpacesAndUpper(L.EFX_SECSIC3);
			SELF.EFX_SECSIC4 := ut.CleanSpacesAndUpper(L.EFX_SECSIC4);
			SELF.EFX_PRIMSICDESC :=  ut.CleanSpacesAndUpper(L.EFX_PRIMSICDESC);
			SELF.EFX_SECSICDESC1 :=  ut.CleanSpacesAndUpper(L.EFX_SECSICDESC1);
			SELF.EFX_SECSICDESC2 :=  ut.CleanSpacesAndUpper(L.EFX_SECSICDESC2);
			SELF.EFX_SECSICDESC3 :=  ut.CleanSpacesAndUpper(L.EFX_SECSICDESC3);
			SELF.EFX_SECSICDESC4 :=  ut.CleanSpacesAndUpper(L.EFX_SECSICDESC4);

			SELF.EFX_PRIMNAICSCODE := ut.CleanSpacesAndUpper(L.EFX_PRIMNAICSCODE);
			SELF.EFX_SECNAICS1 := ut.CleanSpacesAndUpper(L.EFX_SECNAICS1);
			SELF.EFX_SECNAICS2 := ut.CleanSpacesAndUpper(L.EFX_SECNAICS2);;
			SELF.EFX_SECNAICS3 := ut.CleanSpacesAndUpper(L.EFX_SECNAICS3);
			SELF.EFX_SECNAICS4 := ut.CleanSpacesAndUpper(L.EFX_SECNAICS4);
			SELF.EFX_PRIMNAICSDESC :=  ut.CleanSpacesAndUpper(L.EFX_PRIMNAICSDESC);
			SELF.EFX_SECNAICSDESC1 :=  ut.CleanSpacesAndUpper(L.EFX_SECNAICSDESC1);
			SELF.EFX_SECNAICSDESC2 :=  ut.CleanSpacesAndUpper(L.EFX_SECNAICSDESC2);
			SELF.EFX_SECNAICSDESC3 :=  ut.CleanSpacesAndUpper(L.EFX_SECNAICSDESC3);
			SELF.EFX_SECNAICSDESC4 :=  ut.CleanSpacesAndUpper(L.EFX_SECNAICSDESC4);
			SELF.EFX_DEAD :=  ut.CleanSpacesAndUpper(L.EFX_DEAD);
		  SELF.EFX_DEADDT := ut.CleanSpacesAndUpper(L.EFX_DEADDT);
			SELF.EFX_MRKT_TELEVER :=  ut.CleanSpacesAndUpper(L.EFX_MRKT_TELEVER);

			SELF.EFX_MRKT_TELESCORE := ut.CleanSpacesAndUpper(L.EFX_MRKT_TELESCORE);
			SELF.EFX_MRKT_TOTALSCORE := ut.CleanSpacesAndUpper(L.EFX_MRKT_TOTALSCORE);
			SELF.EFX_MRKT_TOTALIND :=  ut.CleanSpacesAndUpper(L.EFX_MRKT_TOTALIND);
			SELF.EFX_MRKT_VACANT :=  ut.CleanSpacesAndUpper(L.EFX_MRKT_VACANT);
			SELF.EFX_MRKT_SEASONAL :=  ut.CleanSpacesAndUpper(L.EFX_MRKT_SEASONAL);
			SELF.EFX_MBE :=  ut.CleanSpacesAndUpper(L.EFX_MBE);
			SELF.EFX_WBE :=  ut.CleanSpacesAndUpper(L.EFX_WBE);
			SELF.EFX_MWBE :=  ut.CleanSpacesAndUpper(L.EFX_MWBE);
			SELF.EFX_SDB :=  ut.CleanSpacesAndUpper(L.EFX_SDB);
			SELF.EFX_HUBZONE :=  ut.CleanSpacesAndUpper(L.EFX_HUBZONE);
			SELF.EFX_DBE :=  ut.CleanSpacesAndUpper(L.EFX_DBE);
			SELF.EFX_VET :=  ut.CleanSpacesAndUpper(L.EFX_VET);
			SELF.EFX_DVET :=  ut.CleanSpacesAndUpper(L.EFX_DVET);
			SELF.EFX_8a :=  ut.CleanSpacesAndUpper(L.EFX_8a);
			SELF.EFX_8aEXPDT := ut.CleanSpacesAndUpper(L.EFX_8aEXPDT);
			SELF.EFX_DIS :=  ut.CleanSpacesAndUpper(L.EFX_DIS);
			SELF.EFX_SBE :=  ut.CleanSpacesAndUpper(L.EFX_SBE);
			SELF.EFX_BUSSIZE :=  ut.CleanSpacesAndUpper(L.EFX_BUSSIZE);
			SELF.EFX_LBE :=  ut.CleanSpacesAndUpper(L.EFX_LBE);
			SELF.EFX_GOV :=  ut.CleanSpacesAndUpper(L.EFX_GOV);
			SELF.EFX_FGOV :=  ut.CleanSpacesAndUpper(L.EFX_FGOV);
			SELF.EFX_GOV1057 :=  ut.CleanSpacesAndUpper(L.EFX_GOV1057);      
			SELF.EFX_NONPROFIT :=  ut.CleanSpacesAndUpper(L.EFX_NONPROFIT);      	
			SELF.EFX_MERCTYPE :=  ut.CleanSpacesAndUpper(L.EFX_MERCTYPE);		
			SELF.EFX_HBCU :=  ut.CleanSpacesAndUpper(L.EFX_HBCU);
			SELF.EFX_GAYLESBIAN :=  ut.CleanSpacesAndUpper(L.EFX_GAYLESBIAN);
			SELF.EFX_WSBE :=  ut.CleanSpacesAndUpper(L.EFX_WSBE);
			SELF.EFX_VSBE :=  ut.CleanSpacesAndUpper(L.EFX_VSBE);
			SELF.EFX_DVSBE :=  ut.CleanSpacesAndUpper(L.EFX_DVSBE);
			SELF.EFX_MWBESTATUS :=  ut.CleanSpacesAndUpper(L.EFX_MWBESTATUS);
			SELF.EFX_NMSDC :=  ut.CleanSpacesAndUpper(L.EFX_NMSDC);
			SELF.EFX_WBENC :=  ut.CleanSpacesAndUpper(L.EFX_WBENC);
			SELF.EFX_CA_PUC :=  ut.CleanSpacesAndUpper(L.EFX_CA_PUC);
			SELF.EFX_TX_HUB :=  ut.CleanSpacesAndUpper(L.EFX_TX_HUB);
			SELF.EFX_TX_HUBCERTNUM :=  ut.CleanSpacesAndUpper(L.EFX_TX_HUBCERTNUM);
			SELF.EFX_GSAX :=  ut.CleanSpacesAndUpper(L.EFX_GSAX);
			SELF.EFX_CALTRANS :=  ut.CleanSpacesAndUpper(L.EFX_CALTRANS);
			SELF.EFX_EDU :=  ut.CleanSpacesAndUpper(L.EFX_EDU);
			SELF.EFX_MI :=  ut.CleanSpacesAndUpper(L.EFX_MI);
			SELF.EFX_ANC :=  ut.CleanSpacesAndUpper(L.EFX_ANC);
			SELF.AT_CERT1 :=  ut.CleanSpacesAndUpper(L.AT_CERT1);
			SELF.AT_CERT2 :=  ut.CleanSpacesAndUpper(L.AT_CERT2);
			SELF.AT_CERT3 :=  ut.CleanSpacesAndUpper(L.AT_CERT3);
			SELF.AT_CERT4 :=  ut.CleanSpacesAndUpper(L.AT_CERT4);
			SELF.AT_CERT5 :=  ut.CleanSpacesAndUpper(L.AT_CERT5);
			SELF.AT_CERT6 :=  ut.CleanSpacesAndUpper(L.AT_CERT6);
			SELF.AT_CERT7 :=  ut.CleanSpacesAndUpper(L.AT_CERT7);
			SELF.AT_CERT8 :=  ut.CleanSpacesAndUpper(L.AT_CERT8);
			SELF.AT_CERT9 :=  ut.CleanSpacesAndUpper(L.AT_CERT9);
			SELF.AT_CERT10 :=  ut.CleanSpacesAndUpper(L.AT_CERT10);
			SELF.AT_CERTDESC1 :=  ut.CleanSpacesAndUpper(L.AT_CERTDESC1);
			SELF.AT_CERTDESC2 :=  ut.CleanSpacesAndUpper(L.AT_CERTDESC2);
			SELF.AT_CERTDESC3 :=  ut.CleanSpacesAndUpper(L.AT_CERTDESC3);
			SELF.AT_CERTDESC4 :=  ut.CleanSpacesAndUpper(L.AT_CERTDESC4);
			SELF.AT_CERTDESC5 :=  ut.CleanSpacesAndUpper(L.AT_CERTDESC5);
			SELF.AT_CERTDESC6 :=  ut.CleanSpacesAndUpper(L.AT_CERTDESC6);
			SELF.AT_CERTDESC7 :=  ut.CleanSpacesAndUpper(L.AT_CERTDESC7);
			SELF.AT_CERTDESC8 :=  ut.CleanSpacesAndUpper(L.AT_CERTDESC8);
			SELF.AT_CERTDESC9 :=  ut.CleanSpacesAndUpper(L.AT_CERTDESC9);
			SELF.AT_CERTDESC10 :=  ut.CleanSpacesAndUpper(L.AT_CERTDESC10);
			SELF.AT_CERTSRC1 :=  ut.CleanSpacesAndUpper(L.AT_CERTSRC1);
			SELF.AT_CERTSRC2 :=  ut.CleanSpacesAndUpper(L.AT_CERTSRC2);
			SELF.AT_CERTSRC3 :=  ut.CleanSpacesAndUpper(L.AT_CERTSRC3);
			SELF.AT_CERTSRC4 :=  ut.CleanSpacesAndUpper(L.AT_CERTSRC4);
			SELF.AT_CERTSRC5 :=  ut.CleanSpacesAndUpper(L.AT_CERTSRC5);
			SELF.AT_CERTSRC6 :=  ut.CleanSpacesAndUpper(L.AT_CERTSRC6);
			SELF.AT_CERTSRC7 :=  ut.CleanSpacesAndUpper(L.AT_CERTSRC7);
			SELF.AT_CERTSRC8 :=  ut.CleanSpacesAndUpper(L.AT_CERTSRC8);
			SELF.AT_CERTSRC9 :=  ut.CleanSpacesAndUpper(L.AT_CERTSRC9);
			SELF.AT_CERTSRC10 :=  ut.CleanSpacesAndUpper(L.AT_CERTSRC10);
			SELF.AT_CERTLEV1 :=  ut.CleanSpacesAndUpper(L.AT_CERTLEV1);
			SELF.AT_CERTLEV2 :=  ut.CleanSpacesAndUpper(L.AT_CERTLEV2);
			SELF.AT_CERTLEV3 :=  ut.CleanSpacesAndUpper(L.AT_CERTLEV3);
			SELF.AT_CERTLEV4 :=  ut.CleanSpacesAndUpper(L.AT_CERTLEV4);
			SELF.AT_CERTLEV5 :=  ut.CleanSpacesAndUpper(L.AT_CERTLEV5);
			SELF.AT_CERTLEV6 :=  ut.CleanSpacesAndUpper(L.AT_CERTLEV6);
			SELF.AT_CERTLEV7 :=  ut.CleanSpacesAndUpper(L.AT_CERTLEV7);
			SELF.AT_CERTLEV8 :=  ut.CleanSpacesAndUpper(L.AT_CERTLEV8);
			SELF.AT_CERTLEV9 :=  ut.CleanSpacesAndUpper(L.AT_CERTLEV9);
			SELF.AT_CERTLEV10 :=  ut.CleanSpacesAndUpper(L.AT_CERTLEV10);
			SELF.AT_CERTNUM1 :=  ut.CleanSpacesAndUpper(L.AT_CERTNUM1);
			SELF.AT_CERTNUM2 :=  ut.CleanSpacesAndUpper(L.AT_CERTNUM2);
			SELF.AT_CERTNUM3 :=  ut.CleanSpacesAndUpper(L.AT_CERTNUM3);
			SELF.AT_CERTNUM4 :=  ut.CleanSpacesAndUpper(L.AT_CERTNUM4);
			SELF.AT_CERTNUM5 :=  ut.CleanSpacesAndUpper(L.AT_CERTNUM5);
			SELF.AT_CERTNUM6 :=  ut.CleanSpacesAndUpper(L.AT_CERTNUM6);
			SELF.AT_CERTNUM7 :=  ut.CleanSpacesAndUpper(L.AT_CERTNUM7);
			SELF.AT_CERTNUM8 :=  ut.CleanSpacesAndUpper(L.AT_CERTNUM8);
			SELF.AT_CERTNUM9 :=  ut.CleanSpacesAndUpper(L.AT_CERTNUM9);
			SELF.AT_CERTNUM10 :=  ut.CleanSpacesAndUpper(L.AT_CERTNUM10);
			SELF.AT_CERTEXP1 := ut.CleanSpacesAndUpper(L.AT_CERTEXP1);
			SELF.AT_CERTEXP2 := ut.CleanSpacesAndUpper(L.AT_CERTEXP2);
			SELF.AT_CERTEXP3 := ut.CleanSpacesAndUpper(L.AT_CERTEXP3);
			SELF.AT_CERTEXP4 := ut.CleanSpacesAndUpper(L.AT_CERTEXP4);
			SELF.AT_CERTEXP5 := ut.CleanSpacesAndUpper(L.AT_CERTEXP5);
			SELF.AT_CERTEXP6 := ut.CleanSpacesAndUpper(L.AT_CERTEXP6);
			SELF.AT_CERTEXP7 := ut.CleanSpacesAndUpper(L.AT_CERTEXP7);
			SELF.AT_CERTEXP8 := ut.CleanSpacesAndUpper(L.AT_CERTEXP8);
			SELF.AT_CERTEXP9 := ut.CleanSpacesAndUpper(L.AT_CERTEXP9);
			SELF.AT_CERTEXP10 := ut.CleanSpacesAndUpper(L.AT_CERTEXP10);
			SELF.EFX_EXTRACT_DATE := ut.CleanSpacesAndUpper(L.EFX_EXTRACT_DATE);
			SELF.EFX_MERCHANT_ID :=  ut.CleanSpacesAndUpper(L.EFX_MERCHANT_ID);

			SELF.EFX_PROJECT_ID := ut.CleanSpacesAndUpper(L.EFX_PROJECT_ID);
			SELF.EFX_FOREIGN :=  ut.CleanSpacesAndUpper(L.EFX_FOREIGN);
			SELF.Record_Update_Refresh_Date := ut.CleanSpacesAndUpper(L.Record_Update_Refresh_date);
																								
			SELF.EFX_DATE_CREATED := ut.CleanSpacesAndUpper(L.EFX_DATE_CREATED);
			SELF.process_date                       := STD.Date.CurrentDate(TRUE);
			
 		 	SELF.dt_first_seen											:= IF(_validate.date.fIsValid(date_created)
			                                              AND date_created[1..4] >= '2001' 
																										AND date_created[1..4] <= SELF.process_date[1..4],(UNSIGNED4)date_created, 0);
			SELF.dt_last_seen												:= IF(_validate.date.fIsValid(date_created)
			                                              AND date_created[1..4] >= '2001' 
																										AND date_created[1..4] <= SELF.process_date[1..4],(UNSIGNED4)date_created, 0);
			SELF.dt_vendor_first_reported						:= IF(_validate.date.fIsValid(pversion[1..8]), (UNSIGNED4)pversion[1..8], 0);
			SELF.dt_vendor_last_reported						:= IF(_validate.date.fIsValid(pversion[1..8]), (UNSIGNED4)pversion[1..8], 0);
			

			SELF :=  L;

			SELF := [];
		END;

		RETURN PROJECT(NormInput, tPreProcess(LEFT));

	END;

	EXPORT fAll( DATASET(Equifax_Business_Data.Layouts.Sprayed_Input) pRawFileInput
							,STRING  pversion
							,STRING  pPersistname = Equifax_Business_Data.Persistnames().StandardizeInput
	           ) := FUNCTION
						 
		dPreprocess	:= fPreProcess(pRawFileInput, pversion) : PERSIST(pPersistname);

		RETURN dPreprocess;
	
	END;

END;
