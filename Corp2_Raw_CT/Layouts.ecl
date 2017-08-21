EXPORT Layouts := module
	 
	 //-----------------------------------------------------------
   // Raw Input Files before Cleaning/Parsing
	 //-----------------------------------------------------------
		EXPORT tmpMasterLay   := record 	string1158 tmpfield; 	end;
		EXPORT tmpFilingLay   := record 	string125  tmpfield; 	end;
		EXPORT tmpMergerLay   := record 	string40   tmpfield; 	end;	
		EXPORT tmpOtherLay    := record 	string134  tmpfield; 	end;															
		EXPORT tmpReserveLay  := record 	string360  tmpfield; 	end;	
		EXPORT tmpCorpsLay    := record 	string165  tmpfield; 	end;	
		EXPORT tmpDlmtPartLay := record 	string28   tmpfield;	end;
		EXPORT tmpFlmtPartLay := record 	string335  tmpfield;	end;		
		EXPORT tmpDlmtCorpLay := record 	string46   tmpfield; 	end;		
		EXPORT tmpFlmtCorpLay := record 	string352  tmpfield; 	end;	
		EXPORT tmpNameChngLay := record 	string329  tmpfield;	end;		
		EXPORT tmpFilmIndxLay := record 	string64   tmpfield;	end;			
		EXPORT tmpStockLay    := record 	string67   tmpfield; 	end;															
		EXPORT tmpPrncipalLay := record 	string513  tmpfield;	end;	
		EXPORT tmpDlmlPartLay := record 	string38   tmpfield; 	end;	
		EXPORT tmpFlmlPartLay := record 	string151  tmpfield;  end;		
		EXPORT tmpGeneralpLay := record 	string228  tmpfield; 	end;															
		EXPORT tmpForStatLay  := record 	string326  tmpfield; 	end;	
		
	 //-----------------------------------------------------------
   // Parsed Input files
	 //-----------------------------------------------------------
		EXPORT BusMasterLayoutIN := RECORD
				string2 		recNo;
				string7 		idBus;
				string1     cdSubtype;
				string2			cdStatus;
				string40	  adStr1;
				string40	  adStr2;
				string40	  adStr3;
				string30	  adCity;
				string2	    adState;
				string5	    adZip5;
				string4	    adZip4;
				string40    adCntry;
				string1	  	cdAgtType;
				string40    adAgtBusStr1;
				string40    adAgtBusStr2;
				string40    adAgtBusStr3;
				string30    adAgtBusCity;
				string2    	adAgtBusState;
				string5    	adAgtBusZip5;
				string4    	adAgtBusZip4;
				string40    adAgtBusCntry;
				string40    adAgtResStr1;
				string40    adAgtResStr2;
				string40    adAgtResStr3;
				string30    adAgtResCity;
				string2    	adAgtResState;
				string5    	adAgtResZip5;
				string4    	adAgtResZip4;
				string40    adAgtResCntry;
				string40    adMailStr1;
				string40    adMailStr2;
				string40    adMailStr3;
				string30    adMailCity;
				string2    	adMailState;
				string5    	adMailZip5;
				string4    	adMailZip4;
				string40    adMailCntry;
				string8	    dtAgtResign;
				string1	    flAddlPrinc;
				string9	    idFedNbr;
				string8	    dtOrigin;
				string1	    cdCnvt;
				string11	  amTotShares;
				string1			filler1;
				string100	  nmName;
				string100	  nmSearch;
				string100	  nmAgt;
		END;
		
		EXPORT BusFilingLayoutIN := RECORD
				string2 		recNo;
				string7 		idBus;
				string10		idBusFlng;
				string15		txCertif;
				string8			dtFiling;
				string8			tmFiling;
				string8			dtHist;
				string5			qtPages;
				string1			filler;
				string26		tmStamp;
				string1			flPhysFlng;
				string8			cdTransType;
				string1			flNmChg;
				string1			flShareChg;
				string1			flRestate;
				string1			flAmendFile;
				string1			flFinalCert;
				string1			flCharBus;
				string1			flPlanAcq;
				string1			flStkHolder;
				string8			dtEffect;
				string8			tmEffect;
		 END;

		EXPORT BusMergerLayoutIN := RECORD
				string2 		recNo;
				string10 		idBusFlng;
				string7     idSurvBus;
				string7			idTermBus;
				string4 	  idSeqNbr;
				string8 		dtFiling;
		END;

		EXPORT BusOtherLayoutIN := RECORD
				string2 		recNo;
				string7 		idBus;
				string1     cdBusType;
				string1			cdOrigin;
				string1 	  cdRptStat;
				string8 		dtRptDue;
				string8 		dtDissolve;
				string8 		dtIntent;		
				string2			cdCategory;
				string6			cdStateTo;
				string6			cdStateFrom;
				string1			flOrganized;
				string8			dtOrgMtg;
				string1			flIntentOrg;
				string1			flIntentAgt;
				string1			flIntentRpt;
				string70		txComments;
		END;

		EXPORT BusReserveLayoutIN := RECORD
				string2 		recNo;
				string7 		idBus;
				string8     dtExp;
				string40	  adStr1;
				string40	  adStr2;
				string40	  adStr3;
				string30	  adCity;
				string2	    adState;
				string5	    adZip5;
				string4	    adZip4;
				string40    adCntry;
				string40		nmApplc;
				string100		nmNameExp;
		END;

		EXPORT CorpsLayoutIN := RECORD
				string2 		recNo;
				string7 		idBus;
				string1     cdBusType;
				string1			cdOrigin;	
				string1     cdCitizen;
				string6			cdPlOfForm;
				string1			cdRptStat;
				string8			dtRptDue;
				string8			dtOrgMtg;
				string8			dtComncBus;
				string8			dtDissolve;
				string8			dtIntent;
				string1			flOrganized;
				string1			flIntentOrg;
				string1			flIntentAgt;
				string1			flIntentRpt;
				string100		nmForeign;
		END;
				
		EXPORT DlmtPartLayoutIN := RECORD
				string2 		recNo;
				string7 		idBus;
				string8     dtTerm;
				string8			dtRptDue;	
				string1     cdRptStat;
		END;
						
		EXPORT FlmtPartLayoutIN := RECORD
				string2			recNo;
				string7			idBus;        
				string6			cdPlOfForm; 
				string8			dtComncBus;  
				string40		adStr1;       
				string40		adStr2;       
				string40		adStr3;       
				string30		adCity;       
				string2			adState;         
				string5			adZip5;       
				string4			adZip4;       
				string40		adCntry;      
				string100		nmForeign;    
				string8			dtRptDue;    
				string1			cdRptStat;
		END;

		EXPORT DlmtCorpLayoutIN := RECORD
				string2			recNo;
				string7			idBus;  
				string8     dtTerm;
				string8			dtRptDue;	
				string1     cdRptStat;
				string8			dtDissolve;
				string8			dtIntent;
				string1			flIntentAgt;
				string1			flIntentRpt;
		END;

		EXPORT FlmtCorpLayoutIN := RECORD
				string2			recNo;
				string7			idBus; 
				string6			cdPlOfForm; 
				string8			dtComncBus; 
				string40		adStr1;       
				string40		adStr2;       
				string40		adStr3;       
				string30		adCity;       
				string2			adState;         
				string5			adZip5;       
				string4			adZip4;       
				string40		adCntry;
				string100		nmForeign;    
				string8			dtRptDue;    
				string1			cdRptStat;
				string8			dtDissolve;
				string8			dtIntent;
				string1			flIntentRpt;
		END;
												
		EXPORT NameChgLayoutIN := RECORD
				string2 		recNo;
				string7 		idBus;
				string10 		idBusFlng;
				string8			dtChanged;
				string100		nmOld;
				string100		nmNew;
				string100		nmOldSearch;
		END;
														
		EXPORT FilmIndxLayoutIN := RECORD
				string2	 		recno;
				string10		idFlngNbr;
				string1			cdMfFlngType;
				string5			cdVolume;
				string4			cdStartPage;
				string26		idImgObj;
				string8			idImgFldr;
				string5			qtPages;
		END;
																
		EXPORT StockLayoutIN := RECORD
				string2			recno;         
				string7			idBus;         
				string4			idSeqNbr;     
				string11		amShares;      
				string1			filler1;
				string30		cdShareCls;   
				string10		amParValue;
		END;

		EXPORT PrncipalLayoutIN := RECORD
				string2			recno;         
				string7			idBus; 
				string4			idSeqNbr;
				string40		nmName;
				string40		txTitle;
				string40    adBusStr1;
				string40    adBusStr2;
				string40    adBusStr3;
				string30    adBusCity;
				string2    	adBusState;
				string5    	adBusZip5;
				string4    	adBusZip4;
				string40    adBusCntry;	
				string40    adResStr1;
				string40    adResStr2;
				string40    adResStr3;
				string30    adResCity;
				string2    	adResState;
				string5    	adResZip5;
				string4    	adResZip4;
				string40    adResCntry;
				string8			dtTermEND;
				string8			dtTermStr;
		END;

		EXPORT DlmlPartLayoutIN := RECORD
				string2 		recNo;
				string7 		idBus;
				string1     cdRptStat;
				string8			dtRptDue;    
				string8			dtDissolve;
				string8			dtIntent;
				string1			flIntentAgt;	
				string1			flIntentRpt;		
		END;
																						
		EXPORT FlmlPartLayoutIN := RECORD
				string2			recNo;
				string7			idBus; 
				string6			cdPlOfForm; 
				string8			dtComncBus; 
				string1			flIntentRpt;
				string8			dtRptDue; 
				string1			cdRptStat;
				string8			dtDissolve;
				string8			dtIntent;
				string100		nmForeign;
		END;

		EXPORT GeneralLayoutIN := RECORD
				string2	 		recno;
				string7			idBus;               
				string8			dtCanOpnLaw;       
				string8			dtDissolve;          
				string40		adAgtMailStr1;     
				string40		adAgtMailStr2;     
				string40		adAgtMailStr3;     
				string30		adAgtMailCity;     
				string2			adAgtMailSt;       
				string5			adAgtMailZip5;     
				string4			adAgtMailZip4;     
				string40		adAgtMailCntry;
		END;

		EXPORT ForStatLayoutIN := RECORD
				string2			recNo;
				string7			idBus; 
				string6			cdPlOfForm; 
				string8			dtComncBus; 
				string40		adStr1;       
				string40		adStr2;       
				string40		adStr3;       
				string30		adCity;       
				string2			adState;         
				string5			adZip5;       
				string4			adZip4;       
				string40		adCntry;
				string100		nmForeign;    
		END;
   
	 //-----------------------------------------------------------
   // Base Files
	 //-----------------------------------------------------------
		EXPORT BusMasterLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			BusMasterLayoutIN;
	  END;
		
	  EXPORT BusFilingLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			BusFilingLayoutIN;
	  END;
		
		 EXPORT BusMergerLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			BusMergerLayoutIN;
	  END;
		
		EXPORT BusOtherLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			BusOtherLayoutIN;
	  END;
		
	  EXPORT BusReserveLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			BusReserveLayoutIN;
	  END;
		
		EXPORT CorpsLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			CorpsLayoutIN;
	  END;
		
		EXPORT DlmtPartLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			DlmtPartLayoutIN;
	  END;
		
	  EXPORT FlmtPartLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			FlmtPartLayoutIN;
	  END;
														
	  EXPORT DlmtCorpLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			DlmtCorpLayoutIN;
	  END;
	
	  EXPORT FlmtCorpLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			FlmtCorpLayoutIN;
	  END;
		
		EXPORT NameChgLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			NameChgLayoutIN;
	  END;
		
		EXPORT FilmIndxLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			FilmIndxLayoutIN;
	  END;
																					
	  EXPORT StockLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			StockLayoutIN;
	  END;
																					
	  EXPORT PrncipalLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			PrncipalLayoutIN;
	  END;
		
		EXPORT DlmlPartLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			DlmlPartLayoutIN;
	  END;
																										
	  EXPORT FlmlPartLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			FlmlPartLayoutIN;
	  END;
																												
	  EXPORT GeneralLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			GeneralLayoutIN;
	  END;
																														
	  EXPORT ForStatLayoutBASE := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			ForStatLayoutIN;
	  END;
		

 	 //-----------------------------------------------------------
   // Temporary Files
	 //-----------------------------------------------------------
	 EXPORT	normalizedMaster := record
				BusMasterLayoutIN;
				string40	normRAAddr1;
				string40	normRAAddr2;
				string40	normRAAddr3;
				string30 	normRACity;
				string2 	normRAState;
				string5 	normRAZip5;
				string4		normRAZip4;
				string40 	normRACountry;
				string		normRAAddrType;
				string    normRAAddrDesc;	
				string6		cdPlOfForm := '';
		end;

		EXPORT TempLay_MergerRecs := RECORD
				string7  SurvOrTermID;
				string1  SurvOrTermFlag;
				string8  dtFiling;
		END;
		
		EXPORT TempLay_MasterWithMerger := record
		   normalizedMaster;
			 TempLay_MergerRecs;
		end;
		
		EXPORT	normalizedBusFiling := record
				BusFilingLayoutIN;
				string	normEventDate;
				string	normType;
		end;
		
		//Layouts for Joins with the Normalized Master file
		EXPORT TempLay_CorpWithMaster     := record	 CorpsLayoutIN;	    normalizedMaster;	 end;
		EXPORT TempLay_OtherWithMaster    := record	 BusOtherLayoutIN;	normalizedMaster;	 end;		
		EXPORT TempLay_DLMTPartWithMaster := record  DLMTPartLayoutIN;	normalizedMaster;	 end;
	  EXPORT TempLay_FLMTPartWithMaster := record	 FLMTPartLayoutIN;	normalizedMaster;	 end;
		EXPORT TempLay_DLMTCorpWithMaster := record	 DLMTCorpLayoutIN;	normalizedMaster;	 end;
		EXPORT TempLay_FLMTCorpWithMaster := record	 FLMTCorpLayoutIN;	normalizedMaster;	 end;
		EXPORT TempLay_DLMLPartWithMaster := record	 DLMLPartLayoutIN;	normalizedMaster;	 end;
		EXPORT TempLay_FLMLPartWithMaster := record	 FLMLPartLayoutIN;	normalizedMaster;	 end;
		EXPORT TempLay_GeneralWithMaster  := record	 GeneralLayoutIN;		normalizedMaster;	 end;
		EXPORT TempLay_ForStatWithMaster  := record  ForStatLayoutIN;   normalizedMaster;	 end;
		EXPORT TempLay_BusResvWithMaster  := record  BusReserveLayoutIN;normalizedMaster;  end;
		EXPORT TempLay_NameChgWithMaster  := record  NameChgLayoutIN;   normalizedMaster;  end;
		
		
		EXPORT TempLay_FilmIndxWithBusFiling := record 
			FilmIndxLayoutIN;  
			normalizedBusFiling; 
		end;
	 
		EXPORT TempLay_OfficerLayout := record
				PrncipalLayoutIN;
				normalizedMaster;
				string40    nmCorpName;
				string40		txTitle1     := '';
				string40		txTitle2     := '';
				string40		txTitle3     := '';
				string40		txTitle4     := '';
				string40		txTitle5     := '';
				string40    normAddr1		 := '';
				string40    normAddr2	 	 := '';
				string40    normAddr3		 := '';
				string30    normCity		 := '';
				string2     normState		 := '';	
				string5     normZip5		 := '';
				string4     normZip4		 := '';
				string40    normCountry	 := '';
				string1     normAddrType := '';
				string11    normAddrDesc := '';
		end;			
		
END;