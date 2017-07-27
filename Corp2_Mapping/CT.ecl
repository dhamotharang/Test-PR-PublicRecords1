import Corp2, _validate, Address, lib_stringlib, ut, _control, versioncontrol;

export CT := MODULE;
	
	export Layouts_Raw_Input := MODULE;

		export BusFilingLay := record
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
		end;

		export BusMasterLay := record
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
		end;

		export BusMergerLay := record
				string2 		recNo;
				string10 		idBusFlng;
				string7     idSurvBus;
				string7			idTermBus;
				string4 	  idSeqNbr;
				string8 		dtFiling;
		end;

		export BusOtherLay := record
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
		end;

		export BusReserveLay := record
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
		end;

		export CorpLay := record
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
		end;

		export DlmtPartLay := record
				string2 		recNo;
				string7 		idBus;
				string8     dtTerm;
				string8			dtRptDue;	
				string1     cdRptStat;
		end;

		export FlmtPartLay := record
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
		end;

		export DlmtCorpLay := record
				string2			recNo;
				string7			idBus;  
				string8     dtTerm;
				string8			dtRptDue;	
				string1     cdRptStat;
				string8			dtDissolve;
				string8			dtIntent;
				string1			flIntentAgt;
				string1			flIntentRpt;
		end;

		export FlmtCorpLay := record
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
		end;

		export NameChgLay := record
				string2 		recNo;
				string7 		idBus;
				string10 		idBusFlng;
				string8			dtChanged;
				string100		nmOld;
				string100		nmNew;
				string100		nmOldSearch;
		end;

		export FilmIndxLay := record
				string2	 		recno;
				string10		idFlngNbr;
				string1			cdMfFlngType;
				string5			cdVolume;
				string4			cdStartPage;
				string26		idImgObj;
				string8			idImgFldr;
				string5			qtPages;
		end;

		export StockLay := record
				string2			recno;         
				string7			idBus;         
				string4			idSeqNbr;     
				string11		amShares;      
				string1			filler1;
				string30		cdShareCls;   
				string10		amParValue;
		end;

		export PrincipalLay := record
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
				string8			dtTermEnd;
				string8			dtTermStr;
		end;

		export DlmlPartLay := record
				string2 		recNo;
				string7 		idBus;
				string1     cdRptStat;
				string8			dtRptDue;    
				string8			dtDissolve;
				string8			dtIntent;
				string1			flIntentAgt;	
				string1			flIntentRpt;		
		end;

		export FlmlPartLay := record
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
		end;

		export GeneralLay := record
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
		end;

		export ForStatLay := record
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
		end;
		
	end;

	export Files_Raw_Input := MODULE;
	
		export BusFiling(string filedate) 			:= dataset('~thor_data400::in::corp2::'+filedate+'::busfiling::ct',Layouts_Raw_Input.BusFilingLay,flat);

		export BusMaster(string filedate) 			:= dataset('~thor_data400::in::corp2::'+filedate+'::busmaster::ct',Layouts_Raw_Input.BusMasterLay,flat);

		export BusMerger(string filedate) 			:= dataset('~thor_data400::in::corp2::'+filedate+'::busmergr::ct',Layouts_Raw_Input.BusMergerLay,flat);

		export BusOther(string filedate)	 			:= dataset('~thor_data400::in::corp2::'+filedate+'::busother::ct',Layouts_Raw_Input.BusOtherLay,flat);

		export BusReserve(string filedate) 			:= dataset('~thor_data400::in::corp2::'+filedate+'::busrsvr::ct',Layouts_Raw_Input.BusReserveLay,flat);

		export Corp_raw(string filedate) 						:= dataset('~thor_data400::in::corp2::'+filedate+'::corp::ct',Layouts_Raw_Input.CorpLay,flat);

		export DlmtPart(string filedate) 				:= dataset('~thor_data400::in::corp2::'+filedate+'::dlmtpart::ct',Layouts_Raw_Input.DlmtPartLay,flat);

		export FlmtPart(string filedate) 				:= dataset('~thor_data400::in::corp2::'+filedate+'::flmtpart::ct',Layouts_Raw_Input.FlmtPartLay,flat);

		export DlmtCorp(string filedate) 				:= dataset('~thor_data400::in::corp2::'+filedate+'::dlmtcorp::ct',Layouts_Raw_Input.DlmtCorpLay,flat);

		export FlmtCorp(string filedate) 				:= dataset('~thor_data400::in::corp2::'+filedate+'::flmtcorp::ct',Layouts_Raw_Input.FlmtCorpLay,flat);

		export NameChg(string filedate) 				:= dataset('~thor_data400::in::corp2::'+filedate+'::namechng::ct',Layouts_Raw_Input.NameChgLay,flat);

		export FilmIndx(string filedate) 				:= dataset('~thor_data400::in::corp2::'+filedate+'::filmindx::ct',Layouts_Raw_Input.FilmIndxLay,flat);

		export Stock(string filedate) 					:= dataset('~thor_data400::in::corp2::'+filedate+'::stock::ct',Layouts_Raw_Input.StockLay,flat);

		export Principal(string filedate) 			:= dataset('~thor_data400::in::corp2::'+filedate+'::prncipal::ct',Layouts_Raw_Input.PrincipalLay,flat);

		export DlmlPart(string filedate) 				:= dataset('~thor_data400::in::corp2::'+filedate+'::dlmlpart::ct',Layouts_Raw_Input.DlmlPartLay,flat);

		export FlmlPart(string filedate) 				:= dataset('~thor_data400::in::corp2::'+filedate+'::flmlpart::ct',Layouts_Raw_Input.FlmlPartLay,flat);
		
		export General(string filedate) 				:= dataset('~thor_data400::in::corp2::'+filedate+'::generalp::ct',Layouts_Raw_Input.GeneralLay,flat);

		export ForStat(string filedate) 				:= dataset('~thor_data400::in::corp2::'+filedate+'::forstat::ct',Layouts_Raw_Input.ForStatLay,flat);

	end;
	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray,boolean pOverwrite = false) := function
		tmpMasterLay := record 
			string1158 tmpfield; 
		end;
		
		Decode_StatusCode(string code) := case
			(code,
				'AC' 	=> 'ACTIVE',
				'CN' 	=> 'CANCELLED',
				'CS' 	=> 'CONSOLIDATED',
				'CV' 	=> 'CONVERTED',
				'ER' 	=> 'EXPIRED RESERVATION',
				'M' 	=> 'MERGED',
				'D' 	=> 'DISABLED',
				'EX' 	=> 'EXPIRED',
				'FF' 	=> 'FORFEITED',
				'RC' 	=> 'RESERVED CANCEL',
				'RD' 	=> 'REDOMESTICATED',
				'RG' 	=> 'REGISTERED',
				'RN' 	=> 'RENUNCIATED',
				'RS' 	=> 'EXPIRED RESERVATION',
				'RV' 	=> 'REVOKED',
				'WD' 	=> 'WITHDRAWN',
				''
			);
														
		tmpMasterLay cleanMaster(tmpMasterLay input):= transform
				self.tmpField		:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.BusMasterLay formatMaster(tmpMasterLay input) :=  transform
				self.recNo 					:= input.tmpField[1..2];
				self.idBus 					:= input.tmpField[3..9];
				self.cdSubtype 			:= input.tmpField[10..10];
				self.cdStatus 			:= input.tmpField[11..12];
				self.adStr1 				:= input.tmpField[13..52];
				self.adStr2 				:= input.tmpField[53..92];
				self.adStr3 				:= input.tmpField[93..132];
				self.adCity 				:= input.tmpField[133..162];
				self.adState 				:= input.tmpField[163..164];
				self.adZip5 				:= input.tmpField[165..169];
				self.adZip4 				:= input.tmpField[170..173];
				self.adCntry 				:= input.tmpField[174..213];
				self.cdAgtType 			:= input.tmpField[214..214];
				self.adAgtBusStr1 	:= input.tmpField[215..254];
				self.adAgtBusStr2 	:= input.tmpField[255..294];
				self.adAgtBusStr3 	:= input.tmpField[295..334];
				self.adAgtBusCity 	:= input.tmpField[335..364];
				self.adAgtBusState 	:= input.tmpField[365..366];
				self.adAgtBusZip5 	:= input.tmpField[367..371];
				self.adAgtBusZip4 	:= input.tmpField[372..375];
				self.adAgtBusCntry 	:= input.tmpField[376..415];
				self.adAgtResStr1 	:= input.tmpField[416..455];
				self.adAgtResStr2 	:= input.tmpField[456..495];
				self.adAgtResStr3 	:= input.tmpField[496..535];
				self.adAgtResCity 	:= input.tmpField[536..565];
				self.adAgtResState 	:= input.tmpField[566..567];
				self.adAgtResZip5 	:= input.tmpField[568..572];
				self.adAgtResZip4 	:= input.tmpField[573..576];
				self.adAgtResCntry 	:= input.tmpField[577..616];
				self.adMailStr1 		:= input.tmpField[617..656];
				self.adMailStr2 		:= input.tmpField[657..696];
				self.adMailStr3 		:= input.tmpField[697..736];
				self.adMailCity 		:= input.tmpField[737..766];
				self.adMailState 		:= input.tmpField[767..768];
				self.adMailZip5 		:= input.tmpField[769..773];
				self.adMailZip4 		:= input.tmpField[774..777];
				self.adMailCntry 		:= input.tmpField[778..817];
				self.dtAgtResign 		:= input.tmpField[818..825];
				self.flAddlPrinc 		:= input.tmpField[826..826];
				self.idFedNbr 			:= input.tmpField[827..835];
				self.dtOrigin 			:= input.tmpField[836..843];
				self.cdCnvt 				:= input.tmpField[844..844];
				self.amTotShares 		:= input.tmpField[845..855];
				self.filler1 				:= input.tmpField[856..856];
				self.nmName 				:= input.tmpField[857..956];
				self.nmSearch 			:= input.tmpField[957..1056];
				self.nmAgt 					:= input.tmpField[1057..1156];
		end;
											
											
		tmpMasterFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpBusMaster::ct',tmpMasterLay,flat);
		clnMasterFile		:= project(tmpMasterFile,cleanMaster(left));
		finalMasterFile := project(clnMasterFile,formatMaster(left));
														
		
		tmpFilingLay := record 
			string125 tmpfield; 
		end;															
														
		tmpFilingLay cleanFiling(tmpFilingLay input):= transform
				self.tmpField		:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.BusFilingLay formatFiling(tmpFilingLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus				:= input.tmpField[3..9];
				self.idBusFlng		:= input.tmpField[10..19];
				self.txCertif			:= input.tmpField[20..34];
				self.dtFiling			:= input.tmpField[35..42];
				self.tmFiling			:= input.tmpField[43..50];
				self.dtHist				:= input.tmpField[51..58];
				self.qtPages			:= input.tmpField[59..63];
				self.filler				:= input.tmpField[64..64];
				self.tmStamp			:= input.tmpField[65..90];
				self.flPhysFlng		:= input.tmpField[91..91];
				self.cdTransType	:= input.tmpField[92..99];
				self.flNmChg			:= input.tmpField[100..100];
				self.flShareChg		:= input.tmpField[101..101];
				self.flRestate		:= input.tmpField[102..102];
				self.flAmendFile	:= input.tmpField[103..103];
				self.flFinalCert	:= input.tmpField[104..104];
				self.flCharBus		:= input.tmpField[105..105];
				self.flPlanAcq		:= input.tmpField[106..106];
				self.flStkHolder	:= input.tmpField[107..107];
				self.dtEffect			:= input.tmpField[108..115];
				self.tmEffect			:= input.tmpField[116..123];
		end;
		
		tmpFilingFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpBusFiling::ct',tmpFilingLay,flat);
		clnFilingFile		:= project(tmpFilingFile,cleanFiling(left));
		finalFilingFile := project(clnFilingFile,formatFiling(left));
														

		tmpMergerLay := record 
			string40 tmpfield; 
		end;															
														
		tmpMergerLay cleanMerger(tmpMergerLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.BusMergerLay formatMerger(tmpMergerLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBusFlng		:= input.tmpField[3..12];
				self.idSurvBus		:= input.tmpField[13..19];
				self.idTermBus		:= input.tmpField[20..26];
				self.idSeqNbr			:= input.tmpField[27..30];
				self.dtFiling			:= input.tmpField[31..38];
		end;
		
		tmpMergerFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpbusmergr::ct',tmpMergerLay,flat);
		clnMergerFile		:= project(tmpMergerFile,cleanMerger(left));
		finalMergerFile := project(clnMergerFile,formatMerger(left));
														
		
		tmpOtherLay := record 
			string134 tmpfield; 
		end;															
														
		tmpOtherLay cleanOther(tmpOtherLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.BusOtherLay formatOther(tmpOtherLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus				:= input.tmpField[3..9];
				self.cdBusType		:= input.tmpField[10..10];
				self.cdOrigin			:= input.tmpField[11..11];
				self.cdRptStat		:= input.tmpField[12..12];
				self.dtRptDue			:= input.tmpField[13..20];
				self.dtDissolve		:= input.tmpField[21..28];
				self.dtIntent			:= input.tmpField[29..36];
				self.cdCategory		:= input.tmpField[37..38];
				self.cdStateTo		:= input.tmpField[39..44];
				self.cdStateFrom	:= input.tmpField[45..50];
				self.flOrganized	:= input.tmpField[51..51];
				self.dtOrgMtg			:= input.tmpField[52..59];
				self.flIntentOrg	:= input.tmpField[60..60];
				self.flIntentAgt	:= input.tmpField[61..61];
				self.flIntentRpt	:= input.tmpField[62..62];
				self.txComments		:= input.tmpField[63..132];
		end;
		
		tmpOtherFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpbusother::ct',tmpOtherLay,flat);
		clnOtherFile		:= project(tmpOtherFile,cleanOther(left));
		finalOtherFile := project(clnOtherFile,formatOther(left));
														
		
		tmpReserveLay := record 
			string360 tmpfield; 
		end;															
														
		tmpReserveLay cleanReserve(tmpReserveLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.BusReserveLay formatReserve(tmpReserveLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus				:= input.tmpField[3..9];
				self.dtExp				:= input.tmpField[10..17];
				self.adStr1				:= input.tmpField[18..57];
				self.adStr2				:= input.tmpField[58..97];
				self.adStr3				:= input.tmpField[98..137];
				self.adCity				:= input.tmpField[138..167];
				self.adState			:= input.tmpField[168..169];
				self.adZip5				:= input.tmpField[170..174];
				self.adZip4				:= input.tmpField[175..178];
				self.adCntry			:= input.tmpField[179..218];
				self.nmApplc			:= input.tmpField[219..258];
				self.nmNameExp		:= input.tmpField[259..358];
		end;
		
		tmpReserveFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpbusrsvr::ct',tmpReserveLay,flat);
		clnReserveFile		:= project(tmpReserveFile,cleanReserve(left));
		finalReserveFile 	:= project(clnReserveFile,formatReserve(left));
														
		
		tmpCorpLay := record 
			string165 tmpfield; 
		end;															
														
		tmpCorpLay cleanCorp(tmpCorpLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.CorpLay formatCorp(tmpCorpLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus				:= input.tmpField[3..9];
				self.cdBusType		:= input.tmpField[10..10];
				self.cdOrigin			:= input.tmpField[11..11];
				self.cdCitizen		:= input.tmpField[12..12];
				self.cdPlOfForm		:= input.tmpField[13..18];
				self.cdRptStat		:= input.tmpField[19..19];
				self.dtRptDue			:= input.tmpField[20..27];
				self.dtOrgMtg			:= input.tmpField[28..35];
				self.dtComncBus		:= input.tmpField[36..43];
				self.dtDissolve		:= input.tmpField[44..51];
				self.dtIntent			:= input.tmpField[52..59];
				self.flOrganized	:= input.tmpField[60..60];
				self.flIntentOrg	:= input.tmpField[61..61];
				self.flIntentAgt	:= input.tmpField[62..62];
				self.flIntentRpt	:= input.tmpField[63..63];
				self.nmForeign		:= input.tmpField[64..163];
		end;
		
		tmpCorpFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpCorp::ct',tmpCorpLay,flat);
		clnCorpFile		:= project(tmpCorpFile,cleanCorp(left));
		finalCorpFile := project(clnCorpFile,formatCorp(left));
														
		
				
		tmpDlmtPartLay := record 
			string28 tmpfield; 
		end;															
														
		tmpDlmtPartLay cleanDlmtPart(tmpDlmtPartLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.DlmtPartLay formatDlmtPart(tmpDlmtPartLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus				:= input.tmpField[3..9];
				self.dtTerm				:= input.tmpField[10..17];
				self.dtRptDue			:= input.tmpField[18..25];
				self.cdRptStat		:= input.tmpField[26..26];
		end;
		
		tmpDlmtPartFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpDlmtPart::ct',tmpDlmtPartLay,flat);
		clnDlmtPartFile		:= project(tmpDlmtPartFile,cleanDlmtPart(left));
		finalDlmtPartFile := project(clnDlmtPartFile,formatDlmtPart(left));
														
		
				
		tmpFlmtPartLay := record 
			string335 tmpfield; 
		end;															
														
		tmpFlmtPartLay cleanFlmtPart(tmpFlmtPartLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.FlmtPartLay formatFlmtPart(tmpFlmtPartLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus        := input.tmpField[3..9];
				self.cdPlOfForm 	:= input.tmpField[10..15];
				self.dtComncBus  	:= input.tmpField[16..23];
				self.adStr1       := input.tmpField[24..63];
				self.adStr2       := input.tmpField[64..103];
				self.adStr3       := input.tmpField[104..143];
				self.adCity       := input.tmpField[144..173];
				self.adState      := input.tmpField[174..175];
				self.adZip5       := input.tmpField[176..180];
				self.adZip4       := input.tmpField[181..184];
				self.adCntry      := input.tmpField[185..224];
				self.nmForeign    := input.tmpField[225..324];
				self.dtRptDue    	:= input.tmpField[325..332];
				self.cdRptStat		:= input.tmpField[333..333];
		end;
		
		tmpFlmtPartFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpFlmtPart::ct',tmpFlmtPartLay,flat);
		clnFlmtPartFile		:= project(tmpFlmtPartFile,cleanFlmtPart(left));
		finalFlmtPartFile := project(clnFlmtPartFile,formatFlmtPart(left));
														
		
				
		tmpDlmtCorpLay := record 
			string46 tmpfield; 
		end;															
														
		tmpDlmtCorpLay cleanDlmtCorp(tmpDlmtCorpLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.DlmtCorpLay formatDlmtCorp(tmpDlmtCorpLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus  			:= input.tmpField[3..9];
				self.dtTerm				:= input.tmpField[10..17];
				self.dtRptDue			:= input.tmpField[18..25];
				self.cdRptStat		:= input.tmpField[26..26];
				self.dtDissolve		:= input.tmpField[27..34];
				self.dtIntent			:= input.tmpField[35..42];
				self.flIntentAgt	:= input.tmpField[43..43];
				self.flIntentRpt	:= input.tmpField[44..44];
		end;
		
		tmpDlmtCorpFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpDlmtCorp::ct',tmpDlmtCorpLay,flat);
		clnDlmtCorpFile		:= project(tmpDlmtCorpFile,cleanDlmtCorp(left));
		finalDlmtCorpFile := project(clnDlmtCorpFile,formatDlmtCorp(left));
														
		
				
		tmpFlmtCorpLay := record 
			string352 tmpfield; 
		end;															
														
		tmpFlmtCorpLay cleanFlmtCorp(tmpFlmtCorpLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.FlmtCorpLay formatFlmtCorp(tmpFlmtCorpLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus 				:= input.tmpField[3..9];
				self.cdPlOfForm 	:= input.tmpField[10..15];
				self.dtComncBus 	:= input.tmpField[16..23];
				self.adStr1       := input.tmpField[24..63];
				self.adStr2       := input.tmpField[64..103];
				self.adStr3       := input.tmpField[104..143];
				self.adCity       := input.tmpField[144..173];
				self.adState      := input.tmpField[174..175];
				self.adZip5       := input.tmpField[176..180];
				self.adZip4       := input.tmpField[181..184];
				self.adCntry			:= input.tmpField[185..224];
				self.nmForeign    := input.tmpField[225..324];
				self.dtRptDue    	:= input.tmpField[325..332];
				self.cdRptStat		:= input.tmpField[333..333];
				self.dtDissolve		:= input.tmpField[334..341];
				self.dtIntent			:= input.tmpField[342..349];
				self.flIntentRpt	:= input.tmpField[350..350];
		end;
		
		tmpFlmtCorpFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpFlmtCorp::ct',tmpFlmtCorpLay,flat);
		clnFlmtCorpFile		:= project(tmpFlmtCorpFile,cleanFlmtCorp(left));
		finalFlmtCorpFile := project(clnFlmtCorpFile,formatFlmtCorp(left));
														
		
				
		tmpNameChngLay := record 
			string329 tmpfield; 
		end;															
														
		tmpNameChngLay cleanNameChng(tmpNameChngLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.NameChgLay formatNameChng(tmpNameChngLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus				:= input.tmpField[3..9];
				self.idBusFlng		:= input.tmpField[10..19];
				self.dtChanged		:= input.tmpField[20..27];
				self.nmOld				:= input.tmpField[28..127];
				self.nmNew				:= input.tmpField[128..227];
				self.nmOldSearch	:= input.tmpField[228..327];
		end;
		
		tmpNameChngFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpNameChng::ct',tmpNameChngLay,flat);
		clnNameChngFile		:= project(tmpNameChngFile,cleanNameChng(left));
		finalNameChngFile := project(clnNameChngFile,formatNameChng(left));
														
		
				
		tmpFilmIndxLay := record 
			string64 tmpfield; 
		end;															
														
		tmpFilmIndxLay cleanFilmIndx(tmpFilmIndxLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.FilmIndxLay formatFilmIndx(tmpFilmIndxLay input) :=  transform
				self.recno				:= input.tmpField[1..2];
				self.idFlngNbr		:= input.tmpField[3..12];
				self.cdMfFlngType	:= input.tmpField[13..13];
				self.cdVolume			:= input.tmpField[14..18];
				self.cdStartPage	:= input.tmpField[19..22];
				self.idImgObj			:= input.tmpField[23..48];
				self.idImgFldr		:= input.tmpField[49..56];
				self.qtPages			:= input.tmpField[57..61];
		end;
		
		tmpFilmIndxFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpFilmIndx::ct',tmpFilmIndxLay,flat);
		clnFilmIndxFile		:= project(tmpFilmIndxFile,cleanFilmIndx(left));
		finalFilmIndxFile := project(clnFilmIndxFile,formatFilmIndx(left));
														
		
				
				
		tmpStockLay := record 
			string67 tmpfield; 
		end;															
														
		tmpStockLay cleanStock(tmpStockLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.StockLay formatStock(tmpStockLay input) :=  transform
				self.recno        := input.tmpField[1..2];
				self.idBus        := input.tmpField[3..9];
				self.idSeqNbr     := input.tmpField[10..13];
				self.amShares     := input.tmpField[14..24];
				self.filler1			:= input.tmpField[25..25];
				self.cdShareCls   := input.tmpField[26..55];
				self.amParValue		:= input.tmpField[56..65];
		end;
		
		tmpStockFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpStock::ct',tmpStockLay,flat);
		clnStockFile		:= project(tmpStockFile,cleanStock(left));
		finalStockFile := project(clnStockFile,formatStock(left));
														
		
				
				
		tmpPrncipalLay := record 
			string513 tmpfield; 
		end;															
														
		tmpPrncipalLay cleanPrncipal(tmpPrncipalLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.PrincipalLay formatPrncipal(tmpPrncipalLay input) :=  transform
				self.recno        := input.tmpField[1..2];
				self.idBus 				:= input.tmpField[3..9];
				self.idSeqNbr			:= input.tmpField[10..13];
				self.nmName				:= input.tmpField[14..53];
				self.txTitle			:= input.tmpField[54..93];
				self.adBusStr1		:= input.tmpField[94..133];
				self.adBusStr2		:= input.tmpField[134..173];
				self.adBusStr3		:= input.tmpField[174..213];
				self.adBusCity		:= input.tmpField[214..243];
				self.adBusState		:= input.tmpField[244..245];
				self.adBusZip5		:= input.tmpField[246..250];
				self.adBusZip4		:= input.tmpField[251..254];
				self.adBusCntry		:= input.tmpField[255..294];
				self.adResStr1		:= input.tmpField[295..334];
				self.adResStr2		:= input.tmpField[335..374];
				self.adResStr3		:= input.tmpField[375..414];
				self.adResCity		:= input.tmpField[415..444];
				self.adResState		:= input.tmpField[445..446];
				self.adResZip5		:= input.tmpField[447..451];
				self.adResZip4		:= input.tmpField[452..455];
				self.adResCntry		:= input.tmpField[456..495];
				self.dtTermEnd		:= input.tmpField[496..503];
				self.dtTermStr		:= input.tmpField[504..511];
		end;
		
		tmpPrncipalFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpPrncipal::ct',tmpPrncipalLay,flat);
		clnPrncipalFile		:= project(tmpPrncipalFile,cleanPrncipal(left));
		finalPrncipalFile := project(clnPrncipalFile,formatPrncipal(left));
														
		
				
				
		tmpDlmlPartLay := record 
			string38 tmpfield; 
		end;															
														
		tmpDlmlPartLay cleanDlmlPart(tmpDlmlPartLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.DlmlPartLay formatDlmlPart(tmpDlmlPartLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus				:= input.tmpField[3..9];
				self.cdRptStat		:= input.tmpField[10..10];
				self.dtRptDue    	:= input.tmpField[11..18];
				self.dtDissolve		:= input.tmpField[19..26];
				self.dtIntent			:= input.tmpField[27..34];
				self.flIntentAgt	:= input.tmpField[35..35];
				self.flIntentRpt	:= input.tmpField[36..36];
		end;
		
		tmpDlmlPartFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpDlmlPart::ct',tmpDlmlPartLay,flat);
		clnDlmlPartFile		:= project(tmpDlmlPartFile,cleanDlmlPart(left));
		finalDlmlPartFile := project(clnDlmlPartFile,formatDlmlPart(left));
														
		
				
				
		tmpFlmlPartLay := record 
			string151 tmpfield; 
		end;															
														
		tmpFlmlPartLay cleanFlmlPart(tmpFlmlPartLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.FlmlPartLay formatFlmlPart(tmpFlmlPartLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus 				:= input.tmpField[3..9];
				self.cdPlOfForm 	:= input.tmpField[10..15];
				self.dtComncBus 	:= input.tmpField[16..23];
				self.flIntentRpt	:= input.tmpField[24..24];
				self.dtRptDue 		:= input.tmpField[25..32];
				self.cdRptStat		:= input.tmpField[33..33];
				self.dtDissolve		:= input.tmpField[34..41];
				self.dtIntent			:= input.tmpField[42..49];
				self.nmForeign		:= input.tmpField[50..149];
		end;
		
		tmpFlmlPartFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpFlmlPart::ct',tmpFlmlPartLay,flat);
		clnFlmlPartFile		:= project(tmpFlmlPartFile,cleanFlmlPart(left));
		finalFlmlPartFile := project(clnFlmlPartFile,formatFlmlPart(left));
														
		
		tmpGeneralpLay := record 
			string228 tmpfield; 
		end;															
														
		tmpGeneralpLay cleanGeneralp(tmpGeneralpLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.GeneralLay formatGeneralp(tmpGeneralpLay input) :=  transform
				self.recno					:= input.tmpField[1..2];
				self.idBus        	:= input.tmpField[3..9];
				self.dtCanOpnLaw  	:= input.tmpField[10..17];
				self.dtDissolve   	:= input.tmpField[18..25];
				self.adAgtMailStr1  := input.tmpField[26..65];
				self.adAgtMailStr2  := input.tmpField[66..105];
				self.adAgtMailStr3  := input.tmpField[106..145];
				self.adAgtMailCity  := input.tmpField[146..175];
				self.adAgtMailSt    := input.tmpField[176..177];
				self.adAgtMailZip5  := input.tmpField[178..182];
				self.adAgtMailZip4  := input.tmpField[183..186];
				self.adAgtMailCntry	:= input.tmpField[187..226];
		end;
		
		tmpGeneralpFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpGeneralp::ct',tmpGeneralpLay,flat);
		clnGeneralpFile		:= project(tmpGeneralpFile,cleanGeneralp(left));
		finalGeneralpFile := project(clnGeneralpFile,formatGeneralp(left));
														
		
		tmpForStatLay := record 
			string326 tmpfield; 
		end;															
														
		tmpForStatLay cleanForStat(tmpForStatLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		Layouts_Raw_Input.ForStatLay formatForStat(tmpForStatLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus 				:= input.tmpField[3..9];
				self.cdPlOfForm 	:= input.tmpField[10..15];
				self.dtComncBus 	:= input.tmpField[16..23];
				self.adStr1       := input.tmpField[24..63];
				self.adStr2       := input.tmpField[64..103];
				self.adStr3       := input.tmpField[104..143];
				self.adCity       := input.tmpField[144..173];
				self.adState      := input.tmpField[174..175];
				self.adZip5       := input.tmpField[176..180];
				self.adZip4       := input.tmpField[181..184];
				self.adCntry			:= input.tmpField[185..224];
				self.nmForeign    := input.tmpField[225..324];
		end;
		
		tmpForStatFile		:= dataset('~thor_data400::in::corp2::'+fileDate+'::tmpForStat::ct',tmpForStatLay,flat);
		clnForStatFile		:= project(tmpForStatFile,cleanForStat(left));
		finalForStatFile := project(clnForStatFile,formatForStat(left));
														
			reformatDate(string inDate) := function
				string clean_inDate := trim(regexreplace('00:00:00',inDate,''),left,right);
				string8 newDate := trim(regexreplace('-',clean_inDate,''),left,right);	
				return newDate;	
			end;
		
			reformatDate2(string inDate) := function
				string8 clean_inDate := trim(regexreplace('/',inDate,''),left,right);
				string8 newDate := clean_inDate[5..8] + clean_inDate[1..2] + clean_inDate[3..4];
				return newDate;	
			end;		
		
			trimUpper(string s) := function
				return trim(stringlib.StringToUppercase(s),left,right);
			end;
				
			
			//---------------------- Code to normalize the master file in order to keep all RA addresses ----------------
			
			normalizedMaster := record
				Layouts_Raw_Input.BusMasterLay;
				string40	Address1;
				string40	Address2;
				string40	Address3;
				string30 	City;
				string2 	State;
				string5 	Zip5;
				string4		Zip4;
				string40 	Country;
				string1		AddrType;
				string10  AddrDesc;			
			end;

			normalizedMaster normalizeMaster(Layouts_Raw_Input.BusMasterLay l, unsigned1 cnt) := transform
				self.Address1		:= choose(cnt,l.adAgtBusStr1,l.adAgtResStr1);
				self.Address2	 	:= choose(cnt,l.adAgtBusStr2,l.adAgtResStr2);
				self.Address3		:= choose(cnt,l.adAgtBusStr3,l.adAgtResStr3);
				self.City				:= choose(cnt,l.adAgtBusCity,l.adAgtResCity);
				self.State			:= choose(cnt,l.adAgtBusState,l.adAgtResState);		
				self.Zip5				:= choose(cnt,l.adAgtBusZip5,l.adAgtResZip5);
				self.Zip4				:= choose(cnt,l.adAgtBusZip4,l.adAgtResZip4);
				self.Country		:= choose(cnt,l.adAgtBusCntry,l.adAgtResCntry);
				self.AddrType		:= choose(cnt,'B','M');
				self.AddrDesc		:= choose(cnt,'BUSINESS','MAILING');			
				self 						:= l;
			end;

			NormalizeBusMaster	:= normalize(Files_Raw_Input.BusMaster(fileDate), 2, normalizeMaster(left, counter));
			
			CorpWithMaster := record
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
				string40		Address1;
				string40		Address2;
				string40		Address3;
				string30 		City;
				string2 		State;
				string5 		Zip5;
				string4			Zip4;
				string40 		Country;
				string1			AddrType;
				string10  	AddrDesc;		
				string9	    idFedNbr;
				string8	    dtOrigin;
				string100	  nmName;
				string100	  nmAgt;
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
				string30		stateDesc;
		end;
		
		OtherWithMaster := record
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
				string40		Address1;
				string40		Address2;
				string40		Address3;
				string30 		City;
				string2 		State;
				string5 		Zip5;
				string4			Zip4;
				string40 		Country;
				string1			AddrType;
				string10  	AddrDesc;		
				string9	    idFedNbr;
				string8	    dtOrigin;
				string100	  nmName;
				string100	  nmAgt;
				string1			cdBusType;
				string1			cdOrigin;
				string8 		dtRptDue;
				string8 		dtDissolve;
				string2			cdCategory;
				string6			cdStateTo;
				string30		stateToDesc;
				string6			cdStateFrom;
				string30		stateFromDesc;
				string70		txComments;
		end;		
			
		DLMTPartWithMaster := record
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
				string40		Address1;
				string40		Address2;
				string40		Address3;
				string30 		City;
				string2 		State;
				string5 		Zip5;
				string4			Zip4;
				string40 		Country;
				string1			AddrType;
				string10  	AddrDesc;		
				string9	    idFedNbr;
				string8	    dtOrigin;
				string100	  nmName;
				string100	  nmAgt;
				string8     dtTerm;
				string8			dtRptDue;	
				string1     cdRptStat;
			end;

			FLMTPartWithMaster :=  record
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
				string40		Address1;
				string40		Address2;
				string40		Address3;
				string30 		City;
				string2 		State;
				string5 		Zip5;
				string4			Zip4;
				string40 		Country;
				string1			AddrType;
				string10  	AddrDesc;		
				string9	    idFedNbr;
				string8	    dtOrigin;
				string100	  nmName;
				string100	  nmAgt;
				string2 		recNo;
				string7 		idBus;
				string1     cdSubtype;
				string2			cdStatus;			
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
				string30		stateDesc;				
			end;
			
		DLMTCorpWithMaster := record
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
				string40		Address1;
				string40		Address2;
				string40		Address3;
				string30 		City;
				string2 		State;
				string5 		Zip5;
				string4			Zip4;
				string40 		Country;
				string1			AddrType;
				string10  	AddrDesc;		
				string9	    idFedNbr;
				string8	    dtOrigin;
				string100	  nmName;
				string100	  nmAgt;	
				string8     dtTerm;
				string8			dtRptDue;	
				string1     cdRptStat;
				string8			dtDissolve;
			end;
			
		FLMTCorpWithMaster := record
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
				string40		Address1;
				string40		Address2;
				string40		Address3;
				string30 		City;
				string2 		State;
				string5 		Zip5;
				string4			Zip4;
				string40 		Country;
				string1			AddrType;
				string10  	AddrDesc;		
				string9	    idFedNbr;
				string8	    dtOrigin;
				string100	  nmName;
				string100	  nmAgt;				
				string6			cdPlOfForm; 
				string8			dtComncBus; 
				string100		nmForeign;    
				string8			dtRptDue;    
				string1			cdRptStat;
				string8			dtDissolve;
				string8			dtIntent;
				string1			flIntentRpt;
				string30		stateDesc;	
			end;
			
			DLMLPartWithMaster := record
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
				string40		Address1;
				string40		Address2;
				string40		Address3;
				string30 		City;
				string2 		State;
				string5 		Zip5;
				string4			Zip4;
				string40 		Country;
				string1			AddrType;
				string10  	AddrDesc;		
				string9	    idFedNbr;
				string8	    dtOrigin;
				string100	  nmName;
				string100	  nmAgt;
				string8			dtDissolve;
			end;
			
			FLMLPartWithMaster := record
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
				string40		Address1;
				string40		Address2;
				string40		Address3;
				string30 		City;
				string2 		State;
				string5 		Zip5;
				string4			Zip4;
				string40 		Country;
				string1			AddrType;
				string10  	AddrDesc;		
				string9	    idFedNbr;
				string8	    dtOrigin;
				string100	  nmName;
				string100	  nmAgt;
				string6			cdPlOfForm; 
				string8			dtComncBus; 
				string1			flIntentRpt;
				string8			dtRptDue; 
				string1			cdRptStat;
				string8			dtDissolve;
				string8			dtIntent;
				string100		nmForeign;
				string30		stateDesc;
			end;
			
			GeneralWithMaster := record
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
				string40		Address1;
				string40		Address2;
				string40		Address3;
				string30 		City;
				string2 		State;
				string5 		Zip5;
				string4			Zip4;
				string40 		Country;
				string1			AddrType;
				string10  	AddrDesc;		
				string9	    idFedNbr;
				string8	    dtOrigin;
				string100	  nmName;
				string100	  nmAgt;
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
			end;
			
			ForStatWithMaster := record
				string2 		recNo;
				string7 		idBus;
				string1     cdSubtype;
				string2			cdStatus;
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
				string40		Address1;
				string40		Address2;
				string40		Address3;
				string30 		City;
				string2 		State;
				string5 		Zip5;
				string4			Zip4;
				string40 		Country;
				string1			AddrType;
				string10  	AddrDesc;		
				string9	    idFedNbr;
				string8	    dtOrigin;
				string100	  nmName;
				string100	  nmAgt;
				string6			cdPlOfForm;
				string30		stateDesc;
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
		end;

		FilingWithFilm := record
				string7			idBus;
				string2	 		recno;
				string10		idFlngNbr;
				string1			cdMfFlngType;
				string5			cdVolume;
				string4			cdStartPage;
				string26		idImgObj;
				string8			idImgFldr;
				string5			qtPages;
		end;			
				
				
			//------- join Principal with BusMaster to get corporation name for corp_legal_name ------------------
			
			PrincipalWithCorpName := record
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
				string8			dtTermEnd;
				string8			dtTermStr;
				string100		nmCorpName;
		end;			
		
			PrincipalWithCorpName MergePrincipalWithCorpName(Layouts_Raw_Input.PrincipalLay l, normalizedMaster r ) := transform
				self.nmCorpName := r.nmName;
				self 						:= l;
				self						:= r;			
			end; 
	
			joinPrincipal2CorpName	:= join(Files_Raw_Input.Principal(fileDate),NormalizeBusMaster,
																			trim(left.idBus, left, right) = trim(right.idBus,left,right),
																			MergePrincipalWithCorpName(left,right),
																			left outer
																			);
																			
			FinalOfficerFile := record
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
				string8			dtTermEnd;
				string8			dtTermStr;
				string100		nmCorpName;
				string40		txTitle1;
				string40		txTitle2;
				string40		txTitle3;
				string40		txTitle4;
				string40		txTitle5;
		end;			
																			
										
			//------- Denormalize above result to get all titles in one record ------------------	
		
			sortOffFile		:= sort(joinPrincipal2CorpName,idBus,nmName,adBusStr1);		

			distofficers 	:= distribute(sortOffFile,hash64(idBus,nmName,adBusStr1));

			FinalOfficerFile	newTransform(PrincipalWithCorpName l) := transform
				self			:=l;
				self			:=[];
			end;
	
			newOfficerFile		:= project(distOfficers, newTransform(left));

			FinalOfficerFile DenormOfficers(FinalOfficerFile L, FinalOfficerFile R, INTEGER C) := TRANSFORM
				self.txTitle1 	:= IF (C=1, R.txTitle,L.txTitle1);                  
				self.txTitle2		:= IF (C=2, R.txTitle,L.txTitle2);
				self.txTitle3		:= IF (C=3, R.txTitle,L.txTitle3); 
				self.txTitle4		:= IF (C=4, R.txTitle,L.txTitle4); 
				self.txTitle5		:= IF (C=5, R.txTitle,L.txTitle5); 
				self 						:= L;
			END;

	
			dedupNewOfficerFile := dedup(sort(newOfficerFile,idBus,nmName,adBusStr1,txTitle), idBus,nmName,adBusStr1,txTitle);
	
				
			DenormalizedFile := sort(denormalize(dedupNewOfficerFile, dedupNewOfficerFile,
																					trim(left.idBus,left,right) 		= trim(right.idBus,left,right) and
																					trim(left.nmName,left,right) 		= trim(right.nmName,left,right) and
																					trim(left.adBusStr1,left,right) = trim(right.adBusStr1,left,right) and
																					trim(left.adResStr1,left,right) = trim(right.adResStr1,left,right),
																					DenormOfficers(left,right,COUNTER)),
																idBus,nmName,adBusStr1,adResStr1,txTitle);
		
			DedupDenormalized := dedup(DenormalizedFile, RECORD, EXCEPT idSeqNbr, dtTermEnd, dtTermStr, txTitle, nmCorpName);			
	
			corp2_mapping.Layout_CorpPreClean corpMasterTransform(CorpWithMaster input) := transform,skip(
																																																			trimUpper(input.Address1) = '' and
																																																			trimUpper(input.Address2) = '' and
																																																			trimUpper(input.Address3) = '' and
																																																			trimUpper(input.City) = '' and
																																																			trimUpper(input.State) = '' and
																																																			trimUpper(input.Zip5) = '' and
																																																			trimUpper(input.Zip4) = '' and
																																																			trimUpper(input.Country) = '' and
																																																			trimUpper(input.AddrType) = 'M' or (input.cdSubType<>'C'))

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);
				self.corp_src_type							:= 'SOS';	
																							
				self.corp_orig_org_structure_cd	:= 'C';
				self.corp_orig_org_structure_desc	:= 'CORPORATION';
					
				cleanStatus											:= trimUpper(input.cdStatus);
				statusDesc											:= Decode_StatusCode(cleanStatus); 

				self.corp_status_desc						:= statusDesc; 

				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
				
				self.corp_address1_line1				:= if (	trimUpper(input.adStr1)<>'NONE',
																									trimUpper(input.adStr1),
																									''
																							);
				self.corp_address1_line2				:= trimUpper(input.adStr2);
				self.corp_address1_line3				:= trimUpper(input.adCity);
				self.corp_address1_line4				:= trimUpper(input.adState);
				self.corp_address1_line5				:= if (	length(trim(input.adZip5,left,right)) = 5,
																									if (length(trim(input.adZip4,left,right)) = 4,
																												trim(input.adZip5,left,right) + trim(input.adZip4,left,right),
																												trim(input.adZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address1_type_cd			:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'B',
																									''
																							 );
																							 
				self.corp_address1_type_desc		:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'BUSINESS',
																									''
																							 );

				self.corp_address2_line1				:= if (	trimUpper(input.adMailStr1)<>'NONE',
																									trimUpper(input.adMailStr1),
																									''
																							);
				self.corp_address2_line2				:= trimUpper(input.adMailStr2);
				self.corp_address2_line3				:= trimUpper(input.adMailStr3);
				self.corp_address2_line4				:= trimUpper(input.adMailCity);
				self.corp_address2_line5				:= trimUpper(input.adMailState);
				self.corp_address2_line6				:= if (	length(trim(input.adMailZip5,left,right)) = 5,
																									if (length(trim(input.adMailZip4,left,right)) = 4,
																												trim(input.adMailZip5,left,right) + trim(input.adMailZip4,left,right),
																												trim(input.adMailZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address2_type_cd			:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'M',
																									''
																							 );
				self.corp_address2_type_desc		:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'MAILING',
																									''
																							 );
				cleanAgtType										:= trimUpper(input.cdAgtType);
				AgtDesc													:= map(	cleanAgtType ='B' => 'BUSINESS',
																								cleanAgtType ='I' => 'INDIVIDUAL',
																								cleanAgtType ='S' => 'SECRETARY OF STATE',
																								''
																							);
				self.corp_ra_title_cd						:= if (	AgtDesc <> '',
																									cleanAgtType,
																									''
																							 );
				self.corp_ra_title_desc					:= AgtDesc;
				self.corp_ra_name								:= trimUpper(input.nmAgt);
				self.corp_ra_address_line1 			:= trimUpper(input.Address1);
				self.corp_ra_address_line2			:= trimUpper(input.Address2);
				self.corp_ra_address_line3			:= trimUpper(input.Address3);
				self.corp_ra_address_line4			:= trimUpper(input.City);
				self.corp_ra_address_line5			:= trimUpper(input.State);
				self.corp_ra_address_line6			:= if (	length(trim(input.Zip5,left,right)) = 5,
																									if (length(trim(input.Zip4,left,right)) = 4,
																												trim(input.Zip5,left,right) + trim(input.Zip4,left,right),
																												trim(input.Zip5,left,right)
																											),
																									''
																								);
		    self.corp_ra_address_type_cd		:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or 
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'' or 
																								trim(input.Country,left,right) <> '',
																									input.AddrType,
																									''
																							);
		    self.corp_ra_address_type_desc	:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'' or 
																								trim(input.Country,left,right) <> '',
																									input.AddrDesc,
																									''
																							);
				self.corp_fed_tax_id						:= trimUpper(input.idFedNbr);
				self.corp_inc_date							:= if(	_validate.date.fIsValid(input.dtOrigin) and
																								_validate.date.fIsValid(input.dtOrigin,_validate.date.rules.DateInPast),
																									input.dtOrigin,
																									''
																							);
				self.corp_legal_name						:= if (trim(input.nmForeign,left,right)<>'',
																								trimUpper(input.nmForeign),
																								trimUpper(input.nmName)
																							); 
																							
				self.corp_addl_info							:= map(	trimUpper(input.cdBusType) = 'N' => 'NON-STOCK',
																								trimUpper(input.cdBusType) = 'S' => 'STOCK',
																								''
																							);
				self.corp_entity_desc						:= map(	trimUpper(input.cdOrigin)='R' => 'REGULAR',
																								trimUpper(input.cdOrigin)='S' => 'SPECIALTY CHARTER',
																								''
																							);
				self.corp_foreign_domestic_ind	:= map(	trimUpper(input.cdCitizen)='D' => 'DOMESTIC',
																								trimUpper(input.cdCitizen)='F' => 'FOREIGN',
																								''
																							);
				self.corp_inc_state							:= if(	trimUpper(input.cdPlOfForm) = 'CT' or 
																								trimUpper(input.cdPlOfForm) = '',
																									'CT',
																									''
																							);
				self.corp_forgn_state_cd				:= if(	trimUpper(input.cdPlOfForm) <> 'CT',
																									trimUpper(input.cdPlOfForm),
																									''
																							);
				self.corp_forgn_state_desc			:= if(	trimUpper(input.cdPlOfForm) <> 'CT',
																									if (trimUpper(input.stateDesc) <> '',
																												trimUpper(input.stateDesc),
																												trimUpper(input.cdPlOfForm)
																											),
																									''
																							);

				self.corp_status_date						:= if(	_validate.date.fIsValid(input.dtDissolve),
																									input.dtDissolve,
																									''
																							);																															
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				self 														:= [];
						
			end; 
			
			corp2_mapping.Layout_CorpPreClean corpOtherTransform(OtherWithMaster input) := transform,skip(input.cdSubType<>'O')

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);
				self.corp_src_type							:= 'SOS';	
				self.corp_inc_state							:= 'CT';				
																							
				self.corp_orig_org_structure_desc	:= 'OTHER BUSINESS';
				self.corp_orig_org_structure_cd	:= trimUpper(input.cdSubType);
				
				cleanStatus											:= trimUpper(input.cdStatus);
				statusDesc											:= Decode_StatusCode(cleanStatus); 
				
				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
				self.corp_status_desc						:= statusDesc;

				self.corp_address1_line1				:= if (	trimUpper(input.adStr1)<>'NONE',
																									trimUpper(input.adStr1),
																									''
																							);
				self.corp_address1_line2				:= trimUpper(input.adStr2);
				self.corp_address1_line3				:= trimUpper(input.adCity);
				self.corp_address1_line4				:= trimUpper(input.adState);
				self.corp_address1_line5				:= if (	length(trim(input.adZip5,left,right)) = 5,
																									if (length(trim(input.adZip4,left,right)) = 4,
																												trim(input.adZip5,left,right) + trim(input.adZip4,left,right),
																												trim(input.adZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address1_type_cd			:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'B',
																									''
																							 );
																							 
				self.corp_address1_type_desc		:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'BUSINESS',
																									''
																							 );

				self.corp_address2_line1				:= if (	trimUpper(input.adMailStr1)<>'NONE',
																									trimUpper(input.adMailStr1),
																									''
																							);
				self.corp_address2_line2				:= trimUpper(input.adMailStr2);
				self.corp_address2_line3				:= trimUpper(input.adMailStr3);
				self.corp_address2_line4				:= trimUpper(input.adMailCity);
				self.corp_address2_line5				:= trimUpper(input.adMailState);
				self.corp_address2_line6				:= if (	length(trim(input.adMailZip5,left,right)) = 5,
																									if (length(trim(input.adMailZip4,left,right)) = 4,
																												trim(input.adMailZip5,left,right) + trim(input.adMailZip4,left,right),
																												trim(input.adMailZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address2_type_cd			:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'M',
																									''
																							 );
				self.corp_address2_type_desc		:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'MAILING',
																									''
																							 );
				cleanAgtType										:= trimUpper(input.cdAgtType);
				AgtDesc													:= map(	cleanAgtType ='B' => 'BUSINESS',
																								cleanAgtType ='I' => 'INDIVIDUAL',
																								cleanAgtType ='S' => 'SECRETARY OF STATE',
																								''
																							);
				self.corp_ra_title_cd						:= if (	AgtDesc <> '',
																									cleanAgtType,
																									''
																							 );
				self.corp_ra_title_desc					:= AgtDesc;
				self.corp_ra_name								:= trimUpper(input.nmAgt);
				self.corp_ra_address_line1 			:= trimUpper(input.Address1);
				self.corp_ra_address_line2			:= trimUpper(input.Address2);
				self.corp_ra_address_line3			:= trimUpper(input.Address3);
				self.corp_ra_address_line4			:= trimUpper(input.City);
				self.corp_ra_address_line5			:= trimUpper(input.State);
				self.corp_ra_address_line6			:= if (	length(trim(input.Zip5,left,right)) = 5,
																									if (length(trim(input.Zip4,left,right)) = 4,
																												trim(input.Zip5,left,right) + trim(input.Zip4,left,right),
																												trim(input.Zip5,left,right)
																											),
																									''
																								);
		    self.corp_ra_address_type_cd		:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or 
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',																								
																									input.AddrType,
																									''
																							);
		    self.corp_ra_address_type_desc	:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',
																									input.AddrDesc,
																									''
																							);
				self.corp_fed_tax_id						:= trimUpper(input.idFedNbr);
				self.corp_inc_date							:= if(	_validate.date.fIsValid(input.dtOrigin) and
																								_validate.date.fIsValid(input.dtOrigin,_validate.date.rules.DateInPast),
																									input.dtOrigin,
																									''
																							);
				self.corp_legal_name						:= trimUpper(input.nmName); 
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				self.corp_entity_desc						:= map(	trimUpper(input.cdOrigin) = 'R' => 'REGULAR',
																								trimUpper(input.cdOrigin) = 'S' => 'SPECIALTY CHARTER',
																								''
																							 );
				self.corp_status_date							:= if(	_validate.date.fIsValid(input.dtDissolve),
																										input.dtDissolve,
																										''
																								);
	
				self.corp_orig_bus_type_cd			:= trimUpper(input.cdCategory);
				self.corp_orig_bus_type_desc		:= map(	trimUpper(input.cdCategory) = 'BK' => 'BANK',
																								trimUpper(input.cdCategory) = 'CU' => 'CREDIT UNION',
																								trimUpper(input.cdCategory) = 'IN' => 'INSURANCE',
																								trimUpper(input.cdCategory) = 'R'  => 'RELIGIOUS',
																								trimUpper(input.cdCategory) = 'C'  => 'CEMETERY',
																								''
																							);
																							
				BusType													:= map(	trimUpper(input.cdBusType) = 'N' => 'NON-STOCK',
																								trimUpper(input.cdBusType) = 'S' => 'STOCK',
																								''
																							 );
				stateTo													:= if (trim(input.cdStateTo,left,right) <> '',
																									'TO STATE OF ' + input.stateToDesc,
																									''
																							 );
				stateFrom												:= if (trim(input.cdStateFrom,left,right) <> '',
																									'FROM STATE OF ' + input.stateFromDesc,
																									''
																							 );	
        																							 
				concatFields										:= 	trim(BusType,left,right) + ';' + 
																						stateTo + ';' +  
																						stateFrom + ';' + 
																						trimUpper(input.txComments);
																		
				
				tempExp													:= regexreplace('[;]*$',concatFields,'',NOCASE);
				tempExp2												:= regexreplace('^[;]*',tempExp,'',NOCASE);
				self.corp_addl_info							:= regexreplace('[;]+',tempExp2,';',NOCASE);  													
				self 														:= [];
						
			end; 
	
			corp2_mapping.Layout_CorpPreClean corpDLMTPartTransform(DLMTPartWithMaster input) := transform,skip(input.cdSubType<>'D')

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);
				self.corp_src_type							:= 'SOS';	
				self.corp_inc_state							:= 'CT';				
																							
				self.corp_orig_org_structure_desc	:= 'DOMESTIC LIMITED PARTNERSHIP';
				self.corp_orig_org_structure_cd	:= trimUpper(input.cdSubType);
				
				cleanStatus											:= trimUpper(input.cdStatus);
				statusDesc											:= Decode_StatusCode(cleanStatus); 
				
				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
				self.corp_status_desc						:= statusDesc;
			
				self.corp_address1_line1				:= if (	trimUpper(input.adStr1)<>'NONE',
																									trimUpper(input.adStr1),
																									''
																							);
				self.corp_address1_line2				:= trimUpper(input.adStr2);
				self.corp_address1_line3				:= trimUpper(input.adCity);
				self.corp_address1_line4				:= trimUpper(input.adState);
				self.corp_address1_line5				:= if (	length(trim(input.adZip5,left,right)) = 5,
																									if (length(trim(input.adZip4,left,right)) = 4,
																												trim(input.adZip5,left,right) + trim(input.adZip4,left,right),
																												trim(input.adZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address1_type_cd			:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'B',
																									''
																							 );
																							 
				self.corp_address1_type_desc		:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'BUSINESS',
																									''
																							 );

				self.corp_address2_line1				:= if (	trimUpper(input.adMailStr1)<>'NONE',
																									trimUpper(input.adMailStr1),
																									''
																							);
				self.corp_address2_line2				:= trimUpper(input.adMailStr2);
				self.corp_address2_line3				:= trimUpper(input.adMailStr3);
				self.corp_address2_line4				:= trimUpper(input.adMailCity);
				self.corp_address2_line5				:= trimUpper(input.adMailState);
				self.corp_address2_line6				:= if (	length(trim(input.adMailZip5,left,right)) = 5,
																									if (length(trim(input.adMailZip4,left,right)) = 4,
																												trim(input.adMailZip5,left,right) + trim(input.adMailZip4,left,right),
																												trim(input.adMailZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address2_type_cd			:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'M',
																									''
																							 );
				self.corp_address2_type_desc		:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'MAILING',
																									''
																							 );
				cleanAgtType										:= trimUpper(input.cdAgtType);
				AgtDesc													:= map(	cleanAgtType ='B' => 'BUSINESS',
																								cleanAgtType ='I' => 'INDIVIDUAL',
																								cleanAgtType ='S' => 'SECRETARY OF STATE',
																								''
																							);
				self.corp_ra_title_cd						:= if (	AgtDesc <> '',
																									cleanAgtType,
																									''
																							 );
				self.corp_ra_title_desc					:= AgtDesc;
				self.corp_ra_name								:= trimUpper(input.nmAgt);
				self.corp_ra_address_line1 			:= trimUpper(input.Address1);
				self.corp_ra_address_line2			:= trimUpper(input.Address2);
				self.corp_ra_address_line3			:= trimUpper(input.Address3);
				self.corp_ra_address_line4			:= trimUpper(input.City);
				self.corp_ra_address_line5			:= trimUpper(input.State);
				self.corp_ra_address_line6			:= if (	length(trim(input.Zip5,left,right)) = 5,
																									if (length(trim(input.Zip4,left,right)) = 4,
																												trim(input.Zip5,left,right) + trim(input.Zip4,left,right),
																												trim(input.Zip5,left,right)
																											),
																									''
																								);
		    self.corp_ra_address_type_cd		:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or 
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',																								
																									input.AddrType,
																									''
																							);
		    self.corp_ra_address_type_desc	:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',
																									input.AddrDesc,
																									''
																							);
				self.corp_fed_tax_id						:= trimUpper(input.idFedNbr);
				self.corp_inc_date							:= if(	_validate.date.fIsValid(input.dtOrigin) and
																								_validate.date.fIsValid(input.dtOrigin,_validate.date.rules.DateInPast),
																									input.dtOrigin,
																									''
																							);
				self.corp_legal_name						:= trimUpper(input.nmName); 
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				
        self.corp_term_exist_cd					:= if(	_validate.date.fIsValid(input.dtTerm),
																									'D',
																									''
																							);
				self.corp_term_exist_exp				:= if(	_validate.date.fIsValid(input.dtTerm),
																									input.dtTerm,
																									''
																							);
				self.corp_term_exist_desc				:= if(	_validate.date.fIsValid(input.dtTerm),
																									'EXPIRATION DATE',
																									''
																							);
				self 														:= [];
						
			end; 	

			corp2_mapping.Layout_CorpPreClean corpFLMTPartTransform(FLMTPartWithMaster input) := transform,skip(input.cdSubType<>'F')

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);
				self.corp_src_type							:= 'SOS';	
																							
				self.corp_orig_org_structure_desc	:= 'FOREIGN LIMITED PARTNERSHIP';
				self.corp_orig_org_structure_cd	:= trimUpper(input.cdSubType);
				
				cleanStatus											:= trimUpper(input.cdStatus);
				statusDesc											:= Decode_StatusCode(cleanStatus); 
				
				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
				self.corp_status_desc						:= statusDesc;
			
				self.corp_address1_line1				:= if (	trimUpper(input.adStr1)<>'NONE',
																									trimUpper(input.adStr1),
																									''
																							);
				self.corp_address1_line2				:= trimUpper(input.adStr2);
				self.corp_address1_line3				:= trimUpper(input.adCity);
				self.corp_address1_line4				:= trimUpper(input.adState);
				self.corp_address1_line5				:= if (	length(trim(input.adZip5,left,right)) = 5,
																									if (length(trim(input.adZip4,left,right)) = 4,
																												trim(input.adZip5,left,right) + trim(input.adZip4,left,right),
																												trim(input.adZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address1_type_cd			:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'B',
																									''
																							 );
																							 
				self.corp_address1_type_desc		:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'BUSINESS',
																									''
																							 );

				self.corp_address2_line1				:= if (	trimUpper(input.adMailStr1)<>'NONE',
																									trimUpper(input.adMailStr1),
																									''
																							);
				self.corp_address2_line2				:= trimUpper(input.adMailStr2);
				self.corp_address2_line3				:= trimUpper(input.adMailStr3);
				self.corp_address2_line4				:= trimUpper(input.adMailCity);
				self.corp_address2_line5				:= trimUpper(input.adMailState);
				self.corp_address2_line6				:= if (	length(trim(input.adMailZip5,left,right)) = 5,
																									if (length(trim(input.adMailZip4,left,right)) = 4,
																												trim(input.adMailZip5,left,right) + trim(input.adMailZip4,left,right),
																												trim(input.adMailZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address2_type_cd			:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'M',
																									''
																							 );
				self.corp_address2_type_desc		:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'MAILING',
																									''
																							 );
				cleanAgtType										:= trimUpper(input.cdAgtType);
				AgtDesc													:= map(	cleanAgtType ='B' => 'BUSINESS',
																								cleanAgtType ='I' => 'INDIVIDUAL',
																								cleanAgtType ='S' => 'SECRETARY OF STATE',
																								''
																							);
				self.corp_ra_title_cd						:= if (	AgtDesc <> '',
																									cleanAgtType,
																									''
																							 );
				self.corp_ra_title_desc					:= AgtDesc;
				self.corp_ra_name								:= trimUpper(input.nmAgt);
				self.corp_ra_address_line1 			:= trimUpper(input.Address1);
				self.corp_ra_address_line2			:= trimUpper(input.Address2);
				self.corp_ra_address_line3			:= trimUpper(input.Address3);
				self.corp_ra_address_line4			:= trimUpper(input.City);
				self.corp_ra_address_line5			:= trimUpper(input.State);
				self.corp_ra_address_line6			:= if (	length(trim(input.Zip5,left,right)) = 5,
																									if (length(trim(input.Zip4,left,right)) = 4,
																												trim(input.Zip5,left,right) + trim(input.Zip4,left,right),
																												trim(input.Zip5,left,right)
																											),
																									''
																								);
		    self.corp_ra_address_type_cd		:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or 
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',																								
																									input.AddrType,
																									''
																							);
		    self.corp_ra_address_type_desc	:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',
																									input.AddrDesc,
																									''
																							);
				self.corp_fed_tax_id						:= trimUpper(input.idFedNbr);
				self.corp_inc_date							:= if(	_validate.date.fIsValid(input.dtOrigin) and
																								_validate.date.fIsValid(input.dtOrigin,_validate.date.rules.DateInPast),
																									input.dtOrigin,
																									''
																							);
				self.corp_legal_name						:= trimUpper(input.nmName); 
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				
				self.corp_inc_state							:= if(	trimUpper(input.cdPlOfForm) = 'CT' or 
																								trimUpper(input.cdPlOfForm) = '',
																									'CT',
																									''
																							);
				self.corp_forgn_state_cd				:= if(	trimUpper(input.cdPlOfForm) <> 'CT',
																									trimUpper(input.cdPlOfForm),
																									''
																							);
				self.corp_forgn_state_desc			:= if(	trimUpper(input.cdPlOfForm) <> 'CT',
																									if (trimUpper(input.stateDesc) <> '',
																												trimUpper(input.stateDesc),
																												trimUpper(input.cdPlOfForm)
																											),
																									''
																							);				
				

				self 														:= [];
						
			end; 	
			
			corp2_mapping.Layout_CorpPreClean corpDLMTCorpTransform(DLMTCorpWithMaster input) := transform,skip(input.cdSubType<>'G')

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);
				self.corp_src_type							:= 'SOS';	
				self.corp_inc_state							:= 'CT';				
																							
				self.corp_orig_org_structure_desc	:= 'DOMESTIC LIMITED LIABILITY COMPANY';
				self.corp_orig_org_structure_cd	:= trimUpper(input.cdSubType);
				
				cleanStatus											:= trimUpper(input.cdStatus);
				statusDesc											:= Decode_StatusCode(cleanStatus); 
				
				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
																							
				self.corp_status_date							:= if(	_validate.date.fIsValid(input.dtDissolve),
																										input.dtDissolve,
																										''
																								);																							
				self.corp_status_desc						:= statusDesc;

				self.corp_address1_line1				:= if (	trimUpper(input.adStr1)<>'NONE',
																									trimUpper(input.adStr1),
																									''
																							);
				self.corp_address1_line2				:= trimUpper(input.adStr2);
				self.corp_address1_line3				:= trimUpper(input.adCity);
				self.corp_address1_line4				:= trimUpper(input.adState);
				self.corp_address1_line5				:= if (	length(trim(input.adZip5,left,right)) = 5,
																									if (length(trim(input.adZip4,left,right)) = 4,
																												trim(input.adZip5,left,right) + trim(input.adZip4,left,right),
																												trim(input.adZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address1_type_cd			:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'B',
																									''
																							 );
																							 
				self.corp_address1_type_desc		:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'BUSINESS',
																									''
																							 );

				self.corp_address2_line1				:= if (	trimUpper(input.adMailStr1)<>'NONE',
																									trimUpper(input.adMailStr1),
																									''
																							);
				self.corp_address2_line2				:= trimUpper(input.adMailStr2);
				self.corp_address2_line3				:= trimUpper(input.adMailStr3);
				self.corp_address2_line4				:= trimUpper(input.adMailCity);
				self.corp_address2_line5				:= trimUpper(input.adMailState);
				self.corp_address2_line6				:= if (	length(trim(input.adMailZip5,left,right)) = 5,
																									if (length(trim(input.adMailZip4,left,right)) = 4,
																												trim(input.adMailZip5,left,right) + trim(input.adMailZip4,left,right),
																												trim(input.adMailZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address2_type_cd			:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'M',
																									''
																							 );
				self.corp_address2_type_desc		:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'MAILING',
																									''
																							 );
				cleanAgtType										:= trimUpper(input.cdAgtType);
				AgtDesc													:= map(	cleanAgtType ='B' => 'BUSINESS',
																								cleanAgtType ='I' => 'INDIVIDUAL',
																								cleanAgtType ='S' => 'SECRETARY OF STATE',
																								''
																							);
				self.corp_ra_title_cd						:= if (	AgtDesc <> '',
																									cleanAgtType,
																									''
																							 );
				self.corp_ra_title_desc					:= AgtDesc;
				self.corp_ra_name								:= trimUpper(input.nmAgt);
				self.corp_ra_address_line1 			:= trimUpper(input.Address1);
				self.corp_ra_address_line2			:= trimUpper(input.Address2);
				self.corp_ra_address_line3			:= trimUpper(input.Address3);
				self.corp_ra_address_line4			:= trimUpper(input.City);
				self.corp_ra_address_line5			:= trimUpper(input.State);
				self.corp_ra_address_line6			:= if (	length(trim(input.Zip5,left,right)) = 5,
																									if (length(trim(input.Zip4,left,right)) = 4,
																												trim(input.Zip5,left,right) + trim(input.Zip4,left,right),
																												trim(input.Zip5,left,right)
																											),
																									''
																								);
		    self.corp_ra_address_type_cd		:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or 
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',																								
																									input.AddrType,
																									''
																							);
		    self.corp_ra_address_type_desc	:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',
																									input.AddrDesc,
																									''
																							);
				self.corp_fed_tax_id						:= trimUpper(input.idFedNbr);
				self.corp_inc_date							:= if(	_validate.date.fIsValid(input.dtOrigin) and
																								_validate.date.fIsValid(input.dtOrigin,_validate.date.rules.DateInPast),
																									input.dtOrigin,
																									''
																							);
				self.corp_legal_name						:= trimUpper(input.nmName); 
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				
        self.corp_term_exist_cd					:= if(	_validate.date.fIsValid(input.dtTerm),
																									'D',
																									''
																							);
				self.corp_term_exist_exp				:= if(	_validate.date.fIsValid(input.dtTerm),
																									input.dtTerm,
																									''
																							);
				self.corp_term_exist_desc				:= if(	_validate.date.fIsValid(input.dtTerm),
																									'EXPIRATION DATE',
																									''
																							);
				self 														:= [];
						
			end; 
			


			corp2_mapping.Layout_CorpPreClean corpFLMTCorpTransform(FLMTCorpWithMaster input) := transform,skip(input.cdSubType<>'H')

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);
				self.corp_src_type							:= 'SOS';	
																							
				self.corp_orig_org_structure_desc	:= 'FOREIGN LIMITED LIABILITY COMPANY';
				self.corp_orig_org_structure_cd	:= trimUpper(input.cdSubType);
				
				cleanStatus											:= trimUpper(input.cdStatus);
				statusDesc											:= Decode_StatusCode(cleanStatus); 
				
				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
																							
				self.corp_status_date							:= if(	_validate.date.fIsValid(input.dtDissolve),
																										input.dtDissolve,
																										''
																								);																							
				self.corp_status_desc						:= statusDesc;

				self.corp_address1_line1				:= if (	trimUpper(input.adStr1)<>'NONE',
																									trimUpper(input.adStr1),
																									''
																							);
				self.corp_address1_line2				:= trimUpper(input.adStr2);
				self.corp_address1_line3				:= trimUpper(input.adCity);
				self.corp_address1_line4				:= trimUpper(input.adState);
				self.corp_address1_line5				:= if (	length(trim(input.adZip5,left,right)) = 5,
																									if (length(trim(input.adZip4,left,right)) = 4,
																												trim(input.adZip5,left,right) + trim(input.adZip4,left,right),
																												trim(input.adZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address1_type_cd			:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'B',
																									''
																							 );
																							 
				self.corp_address1_type_desc		:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'BUSINESS',
																									''
																							 );

				self.corp_address2_line1				:= if (	trimUpper(input.adMailStr1)<>'NONE',
																									trimUpper(input.adMailStr1),
																									''
																							);
				self.corp_address2_line2				:= trimUpper(input.adMailStr2);
				self.corp_address2_line3				:= trimUpper(input.adMailStr3);
				self.corp_address2_line4				:= trimUpper(input.adMailCity);
				self.corp_address2_line5				:= trimUpper(input.adMailState);
				self.corp_address2_line6				:= if (	length(trim(input.adMailZip5,left,right)) = 5,
																									if (length(trim(input.adMailZip4,left,right)) = 4,
																												trim(input.adMailZip5,left,right) + trim(input.adMailZip4,left,right),
																												trim(input.adMailZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address2_type_cd			:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'M',
																									''
																							 );
				self.corp_address2_type_desc		:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'MAILING',
																									''
																							 );
				cleanAgtType										:= trimUpper(input.cdAgtType);
				AgtDesc													:= map(	cleanAgtType ='B' => 'BUSINESS',
																								cleanAgtType ='I' => 'INDIVIDUAL',
																								cleanAgtType ='S' => 'SECRETARY OF STATE',
																								''
																							);
				self.corp_ra_title_cd						:= if (	AgtDesc <> '',
																									cleanAgtType,
																									''
																							 );
				self.corp_ra_title_desc					:= AgtDesc;
				self.corp_ra_name								:= trimUpper(input.nmAgt);
				self.corp_ra_address_line1 			:= trimUpper(input.Address1);
				self.corp_ra_address_line2			:= trimUpper(input.Address2);
				self.corp_ra_address_line3			:= trimUpper(input.Address3);
				self.corp_ra_address_line4			:= trimUpper(input.City);
				self.corp_ra_address_line5			:= trimUpper(input.State);
				self.corp_ra_address_line6			:= if (	length(trim(input.Zip5,left,right)) = 5,
																									if (length(trim(input.Zip4,left,right)) = 4,
																												trim(input.Zip5,left,right) + trim(input.Zip4,left,right),
																												trim(input.Zip5,left,right)
																											),
																									''
																								);
		    self.corp_ra_address_type_cd		:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or 
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',																								
																									input.AddrType,
																									''
																							);
		    self.corp_ra_address_type_desc	:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',
																									input.AddrDesc,
																									''
																							);
				self.corp_fed_tax_id						:= trimUpper(input.idFedNbr);
				self.corp_inc_date							:= if(	_validate.date.fIsValid(input.dtOrigin) and
																								_validate.date.fIsValid(input.dtOrigin,_validate.date.rules.DateInPast),
																									input.dtOrigin,
																									''
																							);
				self.corp_legal_name						:= trimUpper(input.nmName); 
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				
				self.corp_inc_state							:= if(	trimUpper(input.cdPlOfForm) = 'CT' or 
																								trimUpper(input.cdPlOfForm) = '',
																									'CT',
																									''
																							);
				self.corp_forgn_state_cd				:= if(	trimUpper(input.cdPlOfForm) <> 'CT',
																									trimUpper(input.cdPlOfForm),
																									''
																							);
				self.corp_forgn_state_desc			:= if(	trimUpper(input.cdPlOfForm) <> 'CT',
																									if (trimUpper(input.stateDesc) <> '',
																												trimUpper(input.stateDesc),
																												trimUpper(input.cdPlOfForm)
																											),
																									''
																							);				
				

				self 														:= [];
						
			end;
		
			corp2_mapping.Layout_CorpPreClean corpDLMLPartTransform(DLMLPartWithMaster input) := transform,skip(input.cdSubType<>'I')

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);
				self.corp_src_type							:= 'SOS';	
				self.corp_inc_state							:= 'CT';				
																							
				self.corp_orig_org_structure_desc	:= 'DOMESTIC LIMITED LIABILITY PARTNERSHIP';
				self.corp_orig_org_structure_cd	:= trimUpper(input.cdSubType);
				
				cleanStatus											:= trimUpper(input.cdStatus);
				statusDesc											:= Decode_StatusCode(cleanStatus); 
				
				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
																							
				self.corp_status_date							:= if(	_validate.date.fIsValid(input.dtDissolve),
																										input.dtDissolve,
																										''
																								);
																								
				self.corp_status_desc						:= statusDesc;
			
				self.corp_address1_line1				:= if (	trimUpper(input.adStr1)<>'NONE',
																									trimUpper(input.adStr1),
																									''
																							);
				self.corp_address1_line2				:= trimUpper(input.adStr2);
				self.corp_address1_line3				:= trimUpper(input.adCity);
				self.corp_address1_line4				:= trimUpper(input.adState);
				self.corp_address1_line5				:= if (	length(trim(input.adZip5,left,right)) = 5,
																									if (length(trim(input.adZip4,left,right)) = 4,
																												trim(input.adZip5,left,right) + trim(input.adZip4,left,right),
																												trim(input.adZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address1_type_cd			:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'B',
																									''
																							 );
																							 
				self.corp_address1_type_desc		:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'BUSINESS',
																									''
																							 );

				self.corp_address2_line1				:= if (	trimUpper(input.adMailStr1)<>'NONE',
																									trimUpper(input.adMailStr1),
																									''
																							);
				self.corp_address2_line2				:= trimUpper(input.adMailStr2);
				self.corp_address2_line3				:= trimUpper(input.adMailStr3);
				self.corp_address2_line4				:= trimUpper(input.adMailCity);
				self.corp_address2_line5				:= trimUpper(input.adMailState);
				self.corp_address2_line6				:= if (	length(trim(input.adMailZip5,left,right)) = 5,
																									if (length(trim(input.adMailZip4,left,right)) = 4,
																												trim(input.adMailZip5,left,right) + trim(input.adMailZip4,left,right),
																												trim(input.adMailZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address2_type_cd			:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'M',
																									''
																							 );
				self.corp_address2_type_desc		:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'MAILING',
																									''
																							 );
				cleanAgtType										:= trimUpper(input.cdAgtType);
				AgtDesc													:= map(	cleanAgtType ='B' => 'BUSINESS',
																								cleanAgtType ='I' => 'INDIVIDUAL',
																								cleanAgtType ='S' => 'SECRETARY OF STATE',
																								''
																							);
				self.corp_ra_title_cd						:= if (	AgtDesc <> '',
																									cleanAgtType,
																									''
																							 );
				self.corp_ra_title_desc					:= AgtDesc;
				self.corp_ra_name								:= trimUpper(input.nmAgt);
				self.corp_ra_address_line1 			:= trimUpper(input.Address1);
				self.corp_ra_address_line2			:= trimUpper(input.Address2);
				self.corp_ra_address_line3			:= trimUpper(input.Address3);
				self.corp_ra_address_line4			:= trimUpper(input.City);
				self.corp_ra_address_line5			:= trimUpper(input.State);
				self.corp_ra_address_line6			:= if (	length(trim(input.Zip5,left,right)) = 5,
																									if (length(trim(input.Zip4,left,right)) = 4,
																												trim(input.Zip5,left,right) + trim(input.Zip4,left,right),
																												trim(input.Zip5,left,right)
																											),
																									''
																								);
		    self.corp_ra_address_type_cd		:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or 
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',																								
																									input.AddrType,
																									''
																							);
		    self.corp_ra_address_type_desc	:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',
																									input.AddrDesc,
																									''
																							);
				self.corp_fed_tax_id						:= trimUpper(input.idFedNbr);
				self.corp_inc_date							:= if(	_validate.date.fIsValid(input.dtOrigin) and
																								_validate.date.fIsValid(input.dtOrigin,_validate.date.rules.DateInPast),
																									input.dtOrigin,
																									''
																							);
				self.corp_legal_name						:= trimUpper(input.nmName); 
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				self 														:= [];
						
			end; 
					
			corp2_mapping.Layout_CorpPreClean corpFLMLPartTransform(FLMLPartWithMaster input) := transform,skip(input.cdSubType<>'J')

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);
				self.corp_src_type							:= 'SOS';	
																							
				self.corp_orig_org_structure_desc	:= 'FOREIGN LIMITED LIABILITY PARTNERSHIP';
				self.corp_orig_org_structure_cd	:= trimUpper(input.cdSubType);
				
				cleanStatus											:= trimUpper(input.cdStatus);
				statusDesc											:= Decode_StatusCode(cleanStatus); 
				
				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
																							
				self.corp_status_date							:= if(	_validate.date.fIsValid(input.dtDissolve),
																										input.dtDissolve,
																										''
																								);																							
				self.corp_status_desc						:= statusDesc;

				self.corp_address1_line1				:= if (	trimUpper(input.adStr1)<>'NONE',
																									trimUpper(input.adStr1),
																									''
																							);
				self.corp_address1_line2				:= trimUpper(input.adStr2);
				self.corp_address1_line3				:= trimUpper(input.adCity);
				self.corp_address1_line4				:= trimUpper(input.adState);
				self.corp_address1_line5				:= if (	length(trim(input.adZip5,left,right)) = 5,
																									if (length(trim(input.adZip4,left,right)) = 4,
																												trim(input.adZip5,left,right) + trim(input.adZip4,left,right),
																												trim(input.adZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address1_type_cd			:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'B',
																									''
																							 );
																							 
				self.corp_address1_type_desc		:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'BUSINESS',
																									''
																							 );

				self.corp_address2_line1				:= if (	trimUpper(input.adMailStr1)<>'NONE',
																									trimUpper(input.adMailStr1),
																									''
																							);
				self.corp_address2_line2				:= trimUpper(input.adMailStr2);
				self.corp_address2_line3				:= trimUpper(input.adMailStr3);
				self.corp_address2_line4				:= trimUpper(input.adMailCity);
				self.corp_address2_line5				:= trimUpper(input.adMailState);
				self.corp_address2_line6				:= if (	length(trim(input.adMailZip5,left,right)) = 5,
																									if (length(trim(input.adMailZip4,left,right)) = 4,
																												trim(input.adMailZip5,left,right) + trim(input.adMailZip4,left,right),
																												trim(input.adMailZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address2_type_cd			:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'M',
																									''
																							 );
				self.corp_address2_type_desc		:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'MAILING',
																									''
																							 );
				cleanAgtType										:= trimUpper(input.cdAgtType);
				AgtDesc													:= map(	cleanAgtType ='B' => 'BUSINESS',
																								cleanAgtType ='I' => 'INDIVIDUAL',
																								cleanAgtType ='S' => 'SECRETARY OF STATE',
																								''
																							);
				self.corp_ra_title_cd						:= if (	AgtDesc <> '',
																									cleanAgtType,
																									''
																							 );
				self.corp_ra_title_desc					:= AgtDesc;
				self.corp_ra_name								:= trimUpper(input.nmAgt);
				self.corp_ra_address_line1 			:= trimUpper(input.Address1);
				self.corp_ra_address_line2			:= trimUpper(input.Address2);
				self.corp_ra_address_line3			:= trimUpper(input.Address3);
				self.corp_ra_address_line4			:= trimUpper(input.City);
				self.corp_ra_address_line5			:= trimUpper(input.State);
				self.corp_ra_address_line6			:= if (	length(trim(input.Zip5,left,right)) = 5,
																									if (length(trim(input.Zip4,left,right)) = 4,
																												trim(input.Zip5,left,right) + trim(input.Zip4,left,right),
																												trim(input.Zip5,left,right)
																											),
																									''
																								);
		    self.corp_ra_address_type_cd		:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or 
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',																								
																									input.AddrType,
																									''
																							);
		    self.corp_ra_address_type_desc	:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',
																									input.AddrDesc,
																									''
																							);
				self.corp_fed_tax_id						:= trimUpper(input.idFedNbr);
				self.corp_inc_date							:= if(	_validate.date.fIsValid(input.dtOrigin) and
																								_validate.date.fIsValid(input.dtOrigin,_validate.date.rules.DateInPast),
																									input.dtOrigin,
																									''
																							);
				self.corp_legal_name						:= trimUpper(input.nmName); 
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				
				self.corp_inc_state							:= if(	trimUpper(input.cdPlOfForm) = 'CT' or 
																								trimUpper(input.cdPlOfForm) = '',
																									'CT',
																									''
																							);
				self.corp_forgn_state_cd				:= if(	trimUpper(input.cdPlOfForm) <> 'CT',
																									trimUpper(input.cdPlOfForm),
																									''
																							);
				self.corp_forgn_state_desc			:= if(	trimUpper(input.cdPlOfForm) <> 'CT',
																									if (trimUpper(input.stateDesc) <> '',
																												trimUpper(input.stateDesc),
																												trimUpper(input.cdPlOfForm)
																											),
																									''
																							);				
				

				self 														:= [];
						
			end;

			corp2_mapping.Layout_CorpPreClean corpGeneralTransform(GeneralWithMaster input) := transform,skip(input.cdSubType<>'K')

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);
				self.corp_src_type							:= 'SOS';	
				self.corp_inc_state							:= 'CT';				
																							
				self.corp_orig_org_structure_desc	:= 'GENERAL PARTNERSHIP';
				self.corp_orig_org_structure_cd	:= trimUpper(input.cdSubType);
				
				cleanStatus											:= trimUpper(input.cdStatus);
				statusDesc											:= Decode_StatusCode(cleanStatus); 
				
				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
																							
				self.corp_status_date							:= if(	_validate.date.fIsValid(input.dtDissolve),
																										input.dtDissolve,
																										''
																								);																							
				self.corp_status_desc						:= statusDesc;

				self.corp_address1_line1				:= if (	trimUpper(input.adStr1)<>'NONE',
																									trimUpper(input.adStr1),
																									''
																							);
				self.corp_address1_line2				:= trimUpper(input.adStr2);
				self.corp_address1_line3				:= trimUpper(input.adCity);
				self.corp_address1_line4				:= trimUpper(input.adState);
				self.corp_address1_line5				:= if (	length(trim(input.adZip5,left,right)) = 5,
																									if (length(trim(input.adZip4,left,right)) = 4,
																												trim(input.adZip5,left,right) + trim(input.adZip4,left,right),
																												trim(input.adZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address1_type_cd			:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'B',
																									''
																							 );
																							 
				self.corp_address1_type_desc		:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'BUSINESS',
																									''
																							 );

				self.corp_address2_line1				:= if (	trimUpper(input.adMailStr1)<>'NONE',
																									trimUpper(input.adMailStr1),
																									''
																							);
				self.corp_address2_line2				:= trimUpper(input.adMailStr2);
				self.corp_address2_line3				:= trimUpper(input.adMailStr3);
				self.corp_address2_line4				:= trimUpper(input.adMailCity);
				self.corp_address2_line5				:= trimUpper(input.adMailState);
				self.corp_address2_line6				:= if (	length(trim(input.adMailZip5,left,right)) = 5,
																									if (length(trim(input.adMailZip4,left,right)) = 4,
																												trim(input.adMailZip5,left,right) + trim(input.adMailZip4,left,right),
																												trim(input.adMailZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address2_type_cd			:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'M',
																									''
																							 );
				self.corp_address2_type_desc		:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'MAILING',
																									''
																							 );

				self.corp_ra_title_desc					:= 'REGISTERED OFFICE';
				self.corp_ra_name								:= trimUpper(input.nmAgt);
				self.corp_ra_address_line1 			:= trimUpper(input.AdAgtMailStr1);
				self.corp_ra_address_line2			:= trimUpper(input.AdAgtMailStr2);
				self.corp_ra_address_line3			:= trimUpper(input.AdAgtMailStr3);
				self.corp_ra_address_line4			:= trimUpper(input.AdAgtMailCity);
				self.corp_ra_address_line5			:= trimUpper(input.AdAgtMailSt);
				self.corp_ra_address_line6			:= if (	length(trim(input.AdAgtMailZip5,left,right)) = 5,
																									if (length(trim(input.AdAgtMailZip4,left,right)) = 4,
																												trim(input.AdAgtMailZip5,left,right) + trim(input.AdAgtMailZip4,left,right),
																												trim(input.AdAgtMailZip5,left,right)
																											),
																									''
																								);
	
				self.corp_fed_tax_id						:= trimUpper(input.idFedNbr);
				self.corp_inc_date							:= if(	_validate.date.fIsValid(input.dtOrigin) and
																								_validate.date.fIsValid(input.dtOrigin,_validate.date.rules.DateInPast),
																									input.dtOrigin,
																									''
																							);
				self.corp_legal_name						:= trimUpper(input.nmName); 
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				
				self.corp_term_exist_cd					:= if(	_validate.date.fIsValid(input.dtCanOpnLaw),
																									'D',
																									''
																							);
				self.corp_term_exist_exp				:= if(	_validate.date.fIsValid(input.dtCanOpnLaw),
																									input.dtCanOpnLaw,
																									''
																							);
				self.corp_term_exist_desc				:= if(	_validate.date.fIsValid(input.dtCanOpnLaw),
																									'EXPIRATION DATE',
																									''
																							);
				self 														:= [];
						
			end;
	
			corp2_mapping.Layout_CorpPreClean corpDomStatTransform(normalizedMaster input) := transform,skip(input.cdSubType<>'L')

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);
				self.corp_src_type							:= 'SOS';	
				self.corp_inc_state							:= 'CT';				
																							
				self.corp_orig_org_structure_desc	:= 'COMESTIC STATUTORY TRUST';
				self.corp_orig_org_structure_cd	:= trimUpper(input.cdSubType);
				
				cleanStatus											:= trimUpper(input.cdStatus);
				statusDesc											:= Decode_StatusCode(cleanStatus); 
				
				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
																						
				self.corp_status_desc						:= statusDesc;
										
			
				self.corp_address1_line1				:= if (	trimUpper(input.adStr1)<>'NONE',
																									trimUpper(input.adStr1),
																									''
																							);
				self.corp_address1_line2				:= trimUpper(input.adStr2);
				self.corp_address1_line3				:= trimUpper(input.adCity);
				self.corp_address1_line4				:= trimUpper(input.adState);
				self.corp_address1_line5				:= if (	length(trim(input.adZip5,left,right)) = 5,
																									if (length(trim(input.adZip4,left,right)) = 4,
																												trim(input.adZip5,left,right) + trim(input.adZip4,left,right),
																												trim(input.adZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address1_type_cd			:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'B',
																									''
																							 );
																							 
				self.corp_address1_type_desc		:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'BUSINESS',
																									''
																							 );

				self.corp_address2_line1				:= if (	trimUpper(input.adMailStr1)<>'NONE',
																									trimUpper(input.adMailStr1),
																									''
																							);
				self.corp_address2_line2				:= trimUpper(input.adMailStr2);
				self.corp_address2_line3				:= trimUpper(input.adMailStr3);
				self.corp_address2_line4				:= trimUpper(input.adMailCity);
				self.corp_address2_line5				:= trimUpper(input.adMailState);
				self.corp_address2_line6				:= if (	length(trim(input.adMailZip5,left,right)) = 5,
																									if (length(trim(input.adMailZip4,left,right)) = 4,
																												trim(input.adMailZip5,left,right) + trim(input.adMailZip4,left,right),
																												trim(input.adMailZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address2_type_cd			:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'M',
																									''
																							 );
				self.corp_address2_type_desc		:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'MAILING',
																									''
																							 );

				cleanAgtType										:= trimUpper(input.cdAgtType);
				AgtDesc													:= map(	cleanAgtType ='B' => 'BUSINESS',
																								cleanAgtType ='I' => 'INDIVIDUAL',
																								cleanAgtType ='S' => 'SECRETARY OF STATE',
																								''
																							);
				self.corp_ra_title_cd						:= if (	AgtDesc <> '',
																									cleanAgtType,
																									''
																							 );
				self.corp_ra_title_desc					:= AgtDesc;
				self.corp_ra_name								:= trimUpper(input.nmAgt);
				self.corp_ra_address_line1 			:= trimUpper(input.Address1);
				self.corp_ra_address_line2			:= trimUpper(input.Address2);
				self.corp_ra_address_line3			:= trimUpper(input.Address3);
				self.corp_ra_address_line4			:= trimUpper(input.City);
				self.corp_ra_address_line5			:= trimUpper(input.State);
				self.corp_ra_address_line6			:= if (	length(trim(input.Zip5,left,right)) = 5,
																									if (length(trim(input.Zip4,left,right)) = 4,
																												trim(input.Zip5,left,right) + trim(input.Zip4,left,right),
																												trim(input.Zip5,left,right)
																											),
																									''
																								);
		    self.corp_ra_address_type_cd		:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or 
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',																								
																									input.AddrType,
																									''
																							);
		    self.corp_ra_address_type_desc	:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',
																									input.AddrDesc,
																									''
																							);
	
				self.corp_fed_tax_id						:= trimUpper(input.idFedNbr);
				self.corp_inc_date							:= if(	_validate.date.fIsValid(input.dtOrigin) and
																								_validate.date.fIsValid(input.dtOrigin,_validate.date.rules.DateInPast),
																									input.dtOrigin,
																									''
																							);
				self.corp_legal_name						:= trimUpper(input.nmName); 
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				self														:= [];
			end;

			corp2_mapping.Layout_CorpPreClean corpForStatTransform(ForStatWithMaster input) := transform,skip(input.cdSubType<>'M')

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);
				self.corp_src_type							:= 'SOS';	
																							
				self.corp_orig_org_structure_desc	:= 'FOREIGN STATUTORY TRUST';
				self.corp_orig_org_structure_cd	:= trimUpper(input.cdSubType);
				
				cleanStatus											:= trimUpper(input.cdStatus);
				statusDesc											:= Decode_StatusCode(cleanStatus); 
				
				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
																					
				self.corp_status_desc						:= statusDesc;
			
				self.corp_address1_line1				:= if (	trimUpper(input.adStr1)<>'NONE',
																									trimUpper(input.adStr1),
																									''
																							);
				self.corp_address1_line2				:= trimUpper(input.adStr2);
				self.corp_address1_line3				:= trimUpper(input.adCity);
				self.corp_address1_line4				:= trimUpper(input.adState);
				self.corp_address1_line5				:= if (	length(trim(input.adZip5,left,right)) = 5,
																									if (length(trim(input.adZip4,left,right)) = 4,
																												trim(input.adZip5,left,right) + trim(input.adZip4,left,right),
																												trim(input.adZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address1_type_cd			:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'B',
																									''
																							 );
																							 
				self.corp_address1_type_desc		:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'BUSINESS',
																									''
																							 );

				self.corp_address2_line1				:= if (	trimUpper(input.adMailStr1)<>'NONE',
																									trimUpper(input.adMailStr1),
																									''
																							);
				self.corp_address2_line2				:= trimUpper(input.adMailStr2);
				self.corp_address2_line3				:= trimUpper(input.adMailStr3);
				self.corp_address2_line4				:= trimUpper(input.adMailCity);
				self.corp_address2_line5				:= trimUpper(input.adMailState);
				self.corp_address2_line6				:= if (	length(trim(input.adMailZip5,left,right)) = 5,
																									if (length(trim(input.adMailZip4,left,right)) = 4,
																												trim(input.adMailZip5,left,right) + trim(input.adMailZip4,left,right),
																												trim(input.adMailZip5,left,right)
																											),
																									''
																								);
																									
				self.corp_address2_type_cd			:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'M',
																									''
																							 );
				self.corp_address2_type_desc		:= if (	trim(input.adMailStr1,left,right) <> '' or
																								trim(input.adMailStr2,left,right) <> '' or
																								trim(input.adMailStr3,left,right) <> '' or
																								trim(input.adMailCity,left,right) <> '' or
																								trim(input.adMailState,left,right) <> '' or
																								trim(input.adMailZip5,left,right) <> '',
																									'MAILING',
																									''
																							 );
				cleanAgtType										:= trimUpper(input.cdAgtType);
				AgtDesc													:= map(	cleanAgtType ='B' => 'BUSINESS',
																								cleanAgtType ='I' => 'INDIVIDUAL',
																								cleanAgtType ='S' => 'SECRETARY OF STATE',
																								''
																							);
				self.corp_ra_title_cd						:= if (	AgtDesc <> '',
																									cleanAgtType,
																									''
																							 );
				self.corp_ra_title_desc					:= AgtDesc;
				self.corp_ra_name								:= trimUpper(input.nmAgt);
				self.corp_ra_address_line1 			:= trimUpper(input.Address1);
				self.corp_ra_address_line2			:= trimUpper(input.Address2);
				self.corp_ra_address_line3			:= trimUpper(input.Address3);
				self.corp_ra_address_line4			:= trimUpper(input.City);
				self.corp_ra_address_line5			:= trimUpper(input.State);
				self.corp_ra_address_line6			:= if (	length(trim(input.Zip5,left,right)) = 5,
																									if (length(trim(input.Zip4,left,right)) = 4,
																												trim(input.Zip5,left,right) + trim(input.Zip4,left,right),
																												trim(input.Zip5,left,right)
																											),
																									''
																								);
		    self.corp_ra_address_type_cd		:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or 
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',																								
																									input.AddrType,
																									''
																							);
		    self.corp_ra_address_type_desc	:= if(	trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or
																								trim(input.Address3,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip5,left,right) <>'',
																									input.AddrDesc,
																									''
																							);
				self.corp_fed_tax_id						:= trimUpper(input.idFedNbr);
				self.corp_inc_date							:= if(	_validate.date.fIsValid(input.dtOrigin) and
																								_validate.date.fIsValid(input.dtOrigin,_validate.date.rules.DateInPast),
																									input.dtOrigin,
																									''
																							);
				self.corp_legal_name						:= trimUpper(input.nmName); 
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				
				self.corp_inc_state							:= if(	trimUpper(input.cdPlOfForm) = 'CT' or 
																								trimUpper(input.cdPlOfForm) = '',
																									'CT',
																									''
																							);
				self.corp_forgn_state_cd				:= if(	trimUpper(input.cdPlOfForm) <> 'CT',
																									trimUpper(input.cdPlOfForm),
																									''
																							);
				self.corp_forgn_state_desc			:= if(	trimUpper(input.cdPlOfForm) <> 'CT',
																									if (trimUpper(input.stateDesc) <> '',
																												trimUpper(input.stateDesc),
																												trimUpper(input.cdPlOfForm)
																											),
																									''
																							);				
				

				self 														:= [];
						
			end;
	
			corp2_mapping.Layout_CorpPreClean corpReserveTransform(Layouts_Raw_Input.BusReserveLay input) := transform,skip(trim(input.nmNameExp,left,right)='')

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);
				self.corp_src_type							:= 'SOS';	
				
				self.corp_inc_state							:= 'CT';
				self.corp_term_exist_cd					:= if(	_validate.date.fIsValid(input.dtExp),
																									'D',
																									''
																							);
				self.corp_term_exist_exp				:= if(	_validate.date.fIsValid(input.dtExp),
																									input.dtExp,
																									''
																							);																								
				self.corp_term_exist_desc				:= if(	_validate.date.fIsValid(input.dtExp),
																									'EXPIRATION DATE',
																									''
																							);
				self.corp_legal_name						:= trimUpper(input.nmNameExp); 
				self.corp_ln_name_type_cd				:= '07';
				self.corp_ln_name_type_desc			:= 'RESERVED';	
				self 														:= [];
						
			end; 
		
			corp2_mapping.Layout_CorpPreClean NameChgTransform(Layouts_Raw_Input.NameChgLay input) := transform,skip(trim(input.nmOld,left,right)='')

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);
				self.corp_src_type							:= 'SOS';	
				self.corp_inc_state							:= 'CT';				
								
				self.corp_legal_name						:= trimUpper(input.nmOld); 
				self.corp_ln_name_type_desc			:= 'PRIOR';
				self.corp_ln_name_type_cd				:= 'P';
				self 														:= [];
						
		end; 		
		
		Corp2.Layout_Corporate_Direct_Event_In EventFilingTransform(Layouts_Raw_Input.BusFilingLay input):=transform,skip(trimUpper(input.cdTransType)='CFRN'		or
																																																											trimUpper(input.cdTransType)='CFRS' 	or
																																																											trimUpper(input.cdTransType)='CRLC' 	or
																																																											trimUpper(input.cdTransType)='CRLCF' 	or
																																																											trimUpper(input.cdTransType)='CRLLP' 	or
																																																											trimUpper(input.cdTransType)='CRLLPF' or
																																																											trimUpper(input.cdTransType)='CRLP' 	or
																																																											trimUpper(input.cdTransType)='CRLPF' 	or
																																																											trimUpper(input.cdTransType)='CRN'    or
																																																											trimUpper(input.cdTransType)='CRS'		or
																																																											trimUpper(input.flNmChg) = 'Y')
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);
			
			self.event_filing_desc						:= trimUpper(input.txCertif);

			self.event_filing_date						:= if ( input.dtFiling <> '' and
																								_validate.date.fIsValid(input.dtFiling) and
																								_validate.date.fIsValid(input.dtFiling,_validate.date.rules.DateInPast),
																									input.dtFiling,
																									''
																								);  
			self.event_filing_reference_nbr		:=	input.idBusFlng;
			
			self															:=[];

		end;		

		Corp2.Layout_Corporate_Direct_Event_In EventNameChgTransform(Layouts_Raw_Input.NameChgLay input):=transform,skip(trimUpper(input.nmOld)='')
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);
			
			self.event_filing_date						:= if ( input.dtChanged <> '' and
																								_validate.date.fIsValid(input.dtChanged) and
																								_validate.date.fIsValid(input.dtChanged,_validate.date.rules.DateInPast),
																									input.dtChanged,
																									''
																								);  
			self.event_filing_reference_nbr		:=	input.idBusFlng;
			self.event_filing_desc						:= 'AMEND NAME';
			
			self															:=[];

		end;
		
		Corp2.Layout_Corporate_Direct_Event_In EventMergerTransform(Layouts_Raw_Input.BusMergerLay input):=transform
																								
			self.corp_key											:= '09-' + trimUpper(input.idSurvBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idSurvBus);
			
			self.event_filing_date						:= if ( input.dtFiling <> '' and
																								_validate.date.fIsValid(input.dtFiling) and
																								_validate.date.fIsValid(input.dtFiling,_validate.date.rules.DateInPast),
																									input.dtFiling,
																									''
																								);  
			self.event_filing_reference_nbr		:=	input.idBusFlng;
			self.event_filing_desc						:= if (trim(input.idSurvBus,left,right) <> '',
																									if (trim(input.idTermBus,left,right) <> '',
																												'SURVIVING CORPORATION: ' + 
																												trimUpper(input.idSurvBus) + 
																												'; MERGED CORPORATION: ' + 
																												trimUpper(input.idTermBus),
																												'SURVIVING CORPORATION: ' + 
																												trimUpper(input.idSurvBus)
																											),
																									if (trim(input.idTermBus,left,right) <> '',	
																												'MERGED CORPORATION: ' + 
																												trimUpper(input.idTermBus),
																												''
																											)
																									);
      self.event_date_type_cd						:= 'MER';
			self.event_date_type_desc					:= 'MERGER';
			self															:=[];

		end;		
	
		Corp2.Layout_Corporate_Direct_Event_In EventFilmTransform(FilingWithFilm input):=transform
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);
  
			self.event_filing_reference_nbr		:= input.idFlngNbr;
			self.event_roll										:= trimUpper(input.cdMfFlngType);
			self.event_frame									:= input.cdVolume;
			self.event_start									:= input.cdStartPage;
			self															:=[];

		end;		
			
		

		Corp2.Layout_Corporate_Direct_AR_In ARFilingTransform(Layouts_Raw_Input.BusFilingLay input):=transform,skip(trimUpper(input.cdTransType)<>'CFRN' 	and
																																																								trimUpper(input.cdTransType)<>'CFRS' 	and
																																																								trimUpper(input.cdTransType)<>'CRLC' 	and
																																																								trimUpper(input.cdTransType)<>'CRLCF' and
																																																								trimUpper(input.cdTransType)<>'CRLLP' and
																																																								trimUpper(input.cdTransType)<>'CRLLPF'and
																																																								trimUpper(input.cdTransType)<>'CRLP' 	and
																																																								trimUpper(input.cdTransType)<>'CRLPF' and
																																																								trimUpper(input.cdTransType)<>'CRN'   and
																																																								trimUpper(input.cdTransType)<>'CRS')
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);
			
			yrIndex														:= lib_stringlib.StringLib.StringFind(input.txCertif,'(', 1);
			
			self.ar_year											:= if (yrIndex <> 0,
																									trimUpper(input.txCertif)[yrIndex+1..yrIndex+4],
																									''
																							);

			self.ar_filed_dt									:= if ( input.dtFiling <> '' and
																								_validate.date.fIsValid(input.dtFiling) and
																								_validate.date.fIsValid(input.dtFiling,_validate.date.rules.DateInPast),
																									input.dtFiling,
																									''
																								);  
			self.ar_report_nbr								:=	input.idBusFlng;
			
			self															:=[];

		end;		
		
		Corp2.Layout_Corporate_Direct_AR_In ARCorpTransform(Layouts_Raw_Input.CorpLay input):=transform,skip(	trim(input.dtRptDue,left,right)='' and
																																																					trim(input.dtOrgMtg,left,right)='')
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);

			self.ar_due_dt										:= if ( input.dtRptDue <> '' and
																								_validate.date.fIsValid(input.dtRptDue), 
																									input.dtRptDue,
																									''
																								);  
			self.ar_comment										:=	if ( input.dtOrgMtg <> '' and
																								_validate.date.fIsValid(input.dtOrgMtg), 
																									'ORGANIZATION MEETING: ' + input.dtOrgMtg,
																									''
																								); 
			
			self															:=[];

		end;		
		
		Corp2.Layout_Corporate_Direct_AR_In ARDLMTPartTransform(Layouts_Raw_Input.DLMTPartLay input):=transform,skip(	trim(input.dtRptDue,left,right)='')
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);

			self.ar_due_dt										:= if ( input.dtRptDue <> '' and
																								_validate.date.fIsValid(input.dtRptDue), 
																									input.dtRptDue,
																									''
																								);  
			self															:=[];

		end;						
		
		Corp2.Layout_Corporate_Direct_AR_In ARFLMTPartTransform(Layouts_Raw_Input.FLMTPartLay input):=transform,skip(	trim(input.dtRptDue,left,right)='')
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);

			self.ar_due_dt										:= if ( input.dtRptDue <> '' and
																								_validate.date.fIsValid(input.dtRptDue), 
																									input.dtRptDue,
																									''
																								);  
			self															:=[];

		end;	

		
		Corp2.Layout_Corporate_Direct_AR_In ARDLMTCorpTransform(Layouts_Raw_Input.DLMTCorpLay input):=transform,skip(	trim(input.dtRptDue,left,right)='')
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);

			self.ar_due_dt										:= if ( input.dtRptDue <> '' and
																								_validate.date.fIsValid(input.dtRptDue), 
																									input.dtRptDue,
																									''
																								);  
			self															:=[];

		end;	

		Corp2.Layout_Corporate_Direct_AR_In ARFLMTCorpTransform(Layouts_Raw_Input.FLMTCorpLay input):=transform,skip(	trim(input.dtRptDue,left,right)='')
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);

			self.ar_due_dt										:= if ( input.dtRptDue <> '' and
																								_validate.date.fIsValid(input.dtRptDue), 
																									input.dtRptDue,
																									''
																								);  
			self															:=[];

		end;	

		Corp2.Layout_Corporate_Direct_AR_In ARBusOtherTransform(Layouts_Raw_Input.BusOtherLay input):=transform,skip(	trim(input.dtRptDue,left,right)='')
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);

			self.ar_due_dt										:= if ( input.dtRptDue <> '' and
																								_validate.date.fIsValid(input.dtRptDue), 
																									input.dtRptDue,
																									''
																								);  
			self															:=[];

		end;
		
		Corp2.Layout_Corporate_Direct_AR_In ARDLMLPartTransform(Layouts_Raw_Input.DLMLPartLay input):=transform,skip(	trim(input.dtRptDue,left,right)='')
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);

			self.ar_due_dt										:= if ( input.dtRptDue <> '' and
																								_validate.date.fIsValid(input.dtRptDue), 
																									input.dtRptDue,
																									''
																								);  
			self															:=[];

		end;		
		
		Corp2.Layout_Corporate_Direct_AR_In ARFLMLPartTransform(Layouts_Raw_Input.FLMLPartLay input):=transform,skip(	trim(input.dtRptDue,left,right)='')
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);

			self.ar_due_dt										:= if ( input.dtRptDue <> '' and
																								_validate.date.fIsValid(input.dtRptDue), 
																									input.dtRptDue,
																									''
																								);  
			self															:=[];

		end;		
				
		Corp2.Layout_Corporate_Direct_Stock_In StockTransform(Layouts_Raw_Input.StockLay input):=transform
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);
			
			self.stock_shares_issued					:= if ((string)(integer)input.amShares<>'0',
																									input.amShares,
																									''
																							); 
			
			self.stock_type										:= if(	trimUpper(input.cdShareCls)='NO DATA FROM CONVERSION',
																									'NO DATA FROM CONVRSN',
																									trimUpper(input.cdShareCls)
																							);
			self.stock_par_value							:= if (	trim(input.amParValue,left,right)='',
																									'0.00',
																									regexreplace(' 00',trim(input.amParValue,left,right),'.00',NOCASE)
																							);
			self.stock_authorized_nbr					:= if (	ut.isNumeric(input.cdShareCls),
																									(string)(integer)input.cdShareCls,
																									''
																							);
			
			self															:=[];

		end;
		
		Corp2.Layout_Corporate_Direct_Stock_In StockMasterTransform(Layouts_Raw_Input.BusMasterLay input):=transform
																								
			self.corp_key											:= '09-' + trimUpper(input.idBus);	
			self.corp_vendor									:= '09';		
		
			self.corp_state_origin						:= 'CT';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idBus);
			
			self.stock_shares_issued					:= (string)(integer)input.amTotShares; 
			
			self.stock_convert_ind						:= map(	trimUpper(input.cdCnvt) ='Y' => 'YES',
																								trimUpper(input.cdCnvt) ='N' => 'NO',
																								''
																							);
		
			self															:=[];

		end;		
		
		
		corp2_mapping.Layout_ContPreClean ContLegalTransform(FinalOfficerFile input) := transform,skip(trim(input.nmCorpName,left,right)='')
				self.dt_first_seen							:=fileDate;
				self.dt_last_seen								:=fileDate;
				
				self.corp_key										:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);				

				self.corp_legal_name						:= trimUpper(input.nmCorpName);
				
				concatFields										:= 	trimUpper(input.txTitle1) + ';' + 
																						trimUpper(input.txTitle2) + ';' +  
																						trimUpper(input.txTitle3) + ';' + 
																						trimUpper(input.txTitle4) + ';' + 
																						trimUpper(input.txTitle5);
																		
				
				tempExp													:= regexreplace('[;]*$',concatFields,'',NOCASE);
				tempExp2												:= regexreplace('^[;]*',tempExp,'',NOCASE);
				self.cont_title1_desc           := regexreplace('[;]+',tempExp2,';',NOCASE);  
									  
				self.cont_name									:= trimUpper(input.nmName);	
				self.cont_address_line1					:= if (	trimUpper(input.adBusStr1)<>'NONE',
																									trimUpper(input.adBusStr1),
																									''
																							);
				self.cont_address_line2					:= trimUpper(input.adBusStr2);
				self.cont_address_line3					:= trimUpper(input.adBusStr3);
				self.cont_address_line4					:= trimUpper(input.adBusCity);
				self.cont_address_line5					:= trimUpper(input.adBusState);
				self.cont_address_line6					:= if (	length(trim(input.adBusZip5,left,right)) = 5,
																									if (length(trim(input.adBusZip4,left,right)) = 4,
																												trim(input.adBusZip5,left,right) + trim(input.adBusZip4,left,right),
																												trim(input.adBusZip5,left,right)
																											),
																									''
																								);
																									
				self.cont_address_type_cd				:= if (	trim(input.adBusStr1,left,right) <> '' or
																								trim(input.adBusStr2,left,right) <> '' or
																								trim(input.adBusStr3,left,right) <> '' or
																								trim(input.adBusCity,left,right) <> '' or
																								trim(input.adBusState,left,right) <> '' or
																								trim(input.adBusZip5,left,right) <> '',
																									'B',
																									''
																							 );
																							 
				self.cont_address_type_desc			:= if (	trim(input.adBusStr1,left,right) <> '' or
																								trim(input.adBusStr2,left,right) <> '' or
																								trim(input.adBusStr3,left,right) <> '' or
																								trim(input.adBusCity,left,right) <> '' or
																								trim(input.adBusState,left,right) <> '' or
																								trim(input.adBusZip5,left,right) <> '',
																									'BUSINESS',
																									''
																							 );		
        self.cont_effective_date				:= if ( input.dtTermEnd<> '' and
																								_validate.date.fIsValid(input.dtTermEnd),
																									input.dtTermEnd,
																									''
																								);  																							
				self 														:= [];
						
		end;	
		
		corp2_mapping.Layout_ContPreClean ContReserveTransform(layouts_raw_input.BusReserveLay input) := transform,skip(trim(input.nmApplc,left,right)='' or
																																																			trim(input.nmNameExp,left,right)='')
				self.dt_first_seen							:=fileDate;
				self.dt_last_seen							:=fileDate;
				
				self.corp_key									:= '09-' + trimUpper(input.idBus);
				self.corp_vendor								:= '09';
				self.corp_state_origin					:= 'CT';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.idBus);				

				self.corp_legal_name						:= trimUpper(input.nmNameExp);
									  
				self.cont_name									:= trimUpper(input.nmApplc);	
				self.cont_type_cd							:= '01';
				self.cont_type_desc						:= 'RESERVER';
				
				self.cont_address_line1				:= if (	trimUpper(input.adStr1)<>'NONE',
																									trimUpper(input.adStr1),
																									''
																							);
				self.cont_address_line2					:= trimUpper(input.adStr2);
				self.cont_address_line3					:= trimUpper(input.adStr3);
				self.cont_address_line4					:= trimUpper(input.adCity);
				self.cont_address_line5					:= trimUpper(input.adState);
				self.cont_address_line6					:= if (	length(trim(input.adZip5,left,right)) = 5,
																									if (length(trim(input.adZip4,left,right)) = 4,
																												trim(input.adZip5,left,right) + trim(input.adZip4,left,right),
																												trim(input.adZip5,left,right)
																											),
																									''
																								);
																									
				self.cont_address_type_cd				:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adStr3,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'T',
																									''
																							 );
																							 
				self.cont_address_type_desc			:= if (	trim(input.adStr1,left,right) <> '' or
																								trim(input.adStr2,left,right) <> '' or
																								trim(input.adStr3,left,right) <> '' or
																								trim(input.adCity,left,right) <> '' or
																								trim(input.adState,left,right) <> '' or
																								trim(input.adZip5,left,right) <> '',
																									'CONTACT',
																									''
																							 );		
				self 														:= [];
						
		end;	
		
		Corp2.Layout_Corporate_Direct_Corp_In CleanCorpAddrName(corp2_mapping.Layout_CorpPreClean input) := transform		
			string73 tempname 							:= if(input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			pname 													:= Address.CleanNameFields(tempName);
			cname 													:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 											:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 										:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1							:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 						:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 						:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 						:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 						:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 						:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');
			
			string182 clean_address 				:= Address.CleanAddress182(	trim(	trim(input.corp_address1_line1,left,right) + ' ' +
																																				trim(input.corp_address1_line2,left,right),left,right),
																																	trim(	trim(input.corp_address1_line3,left,right) + ', ' +
																																				trim(input.corp_address1_line4,left,right) + ' ' +
																																				trim(input.corp_address1_line5,left,right),
																																				left,right
																																			)
																																);			
			
			string182 clean_ra_address 			:= Address.CleanAddress182(	trim(	trim(input.corp_ra_address_line1,left,right) + ' ' +
																																				trim(input.corp_ra_address_line2,left,right),left,right),
																																	trim(	trim(input.corp_ra_address_line3,left,right) + ', ' +
																																				trim(input.corp_ra_address_line4,left,right) + ' ' +
																																				trim(input.corp_ra_address_line5,left,right),
																																				left,right
																																			)
																																);	
																				
			self.corp_ra_prim_range    			:= clean_ra_address[1..10];
			self.corp_ra_predir 	      		:= clean_ra_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_ra_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_ra_address[41..44];
			self.corp_ra_postdir 	    			:= clean_ra_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_ra_address[47..56];
			self.corp_ra_sec_range 	  			:= clean_ra_address[57..64];
			self.corp_ra_p_city_name	  		:= clean_ra_address[65..89];
			self.corp_ra_v_city_name	  		:= clean_ra_address[90..114];
			self.corp_ra_state 			    		:= clean_ra_address[115..116];
			self.corp_ra_zip5 		      		:= clean_ra_address[117..121];
			self.corp_ra_zip4 		      		:= clean_ra_address[122..125];
			self.corp_ra_cart 		      		:= clean_ra_address[126..129];
			self.corp_ra_cr_sort_sz 	 			:= clean_ra_address[130];
			self.corp_ra_lot 		      			:= clean_ra_address[131..134];
			self.corp_ra_lot_order 	  			:= clean_ra_address[135];
			self.corp_ra_dpbc 		      		:= clean_ra_address[136..137];
			self.corp_ra_chk_digit 	  			:= clean_ra_address[138];
			self.corp_ra_rec_type		  			:= clean_ra_address[139..140];
			self.corp_ra_ace_fips_st	  		:= clean_ra_address[141..142];
			self.corp_ra_county 	  				:= clean_ra_address[143..145];
			self.corp_ra_geo_lat 	    			:= clean_ra_address[146..155];
			self.corp_ra_geo_long 	    		:= clean_ra_address[156..166];
			self.corp_ra_msa 		      			:= clean_ra_address[167..170];
			self.corp_ra_geo_blk						:= clean_ra_address[171..177];
			self.corp_ra_geo_match 	  			:= clean_ra_address[178];
			self.corp_ra_err_stat 	    		:= clean_ra_address[179..182];
														
			self.corp_addr1_prim_range  		:= clean_address[1..10];
			self.corp_addr1_predir 	    		:= clean_address[11..12];
			self.corp_addr1_prim_name 			:= clean_address[13..40];
			self.corp_addr1_addr_suffix  	 	:= clean_address[41..44];
			self.corp_addr1_postdir 	   		:= clean_address[45..46];
			self.corp_addr1_unit_desig 			:= clean_address[47..56];
			self.corp_addr1_sec_range 			:= clean_address[57..64];
			self.corp_addr1_p_city_name			:= clean_address[65..89];
			self.corp_addr1_v_city_name			:= clean_address[90..114];
			self.corp_addr1_state 			    := clean_address[115..116];
			self.corp_addr1_zip5 		      	:= clean_address[117..121];
			self.corp_addr1_zip4 		      	:= clean_address[122..125];
			self.corp_addr1_cart 		     		:= clean_address[126..129];
			self.corp_addr1_cr_sort_sz 	 		:= clean_address[130];
			self.corp_addr1_lot 		      	:= clean_address[131..134];
			self.corp_addr1_lot_order 			:= clean_address[135];
			self.corp_addr1_dpbc 		     		:= clean_address[136..137];
			self.corp_addr1_chk_digit 			:= clean_address[138];
			self.corp_addr1_rec_type		  	:= clean_address[139..140];
			self.corp_addr1_ace_fips_st			:= clean_address[141..142];
			self.corp_addr1_county 	  			:= clean_address[143..145];
			self.corp_addr1_geo_lat 	    	:= clean_address[146..155];
			self.corp_addr1_geo_long 	   		:= clean_address[156..166];
			self.corp_addr1_msa 		      	:= clean_address[167..170];
			self.corp_addr1_geo_blk					:= clean_address[171..177];
			self.corp_addr1_geo_match 	  	:= clean_address[178];
			self.corp_addr1_err_stat 	    	:= clean_address[179..182];
			self														:= input;
			self 														:= [];
		end;	
		
		
	
		Corp2.Layout_Corporate_Direct_Cont_In CleanContAddrName(corp2_mapping.Layout_ContPreClean input) := transform		
			string73 tempname 							:= if(input.cont_name = '', '', Address.CleanPersonFML73(input.cont_name));
			pname 													:= Address.CleanNameFields(tempName);
			cname 													:= DataLib.companyclean(input.cont_name);
			keepPerson 											:= corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 										:= corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1								:= if(keepPerson, pname.title, '');
			self.cont_fname1 								:= if(keepPerson, pname.fname, '');
			self.cont_mname1 								:= if(keepPerson, pname.mname, '');
			self.cont_lname1 								:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 					:= if(keepPerson, pname.name_suffix, '');
			self.cont_score1 								:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 								:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 					:= if(keepBusiness, pname.name_score, '');
		
			string182 clean_address 				:= Address.CleanAddress182(	trim(	trim(input.cont_address_line1,left,right) + ' ' +
																																				trim(input.cont_address_line2,left,right),left,right),
																																	trim(	trim(input.cont_address_line3,left,right) + ', ' +
																																				trim(input.cont_address_line4,left,right) + ' ' +
																																				trim(input.cont_address_line5,left,right),
																																				left,right
																																			)
																																	);	
																				
			self.cont_prim_range    				:= clean_address[1..10];
			self.cont_predir 	      				:= clean_address[11..12];
			self.cont_prim_name 	  				:= clean_address[13..40];
			self.cont_addr_suffix   				:= clean_address[41..44];
			self.cont_postdir 	  		  		:= clean_address[45..46];
			self.cont_unit_desig 	  				:= clean_address[47..56];
			self.cont_sec_range 	  				:= clean_address[57..64];
			self.cont_p_city_name	  				:= clean_address[65..89];
			self.cont_v_city_name	 					:= clean_address[90..114];
			self.cont_state 			      		:= clean_address[115..116];
			self.cont_zip5 		      				:= clean_address[117..121];
			self.cont_zip4 		 	     				:= clean_address[122..125];
			self.cont_cart 		    	  			:= clean_address[126..129];
			self.cont_cr_sort_sz 	 					:= clean_address[130];
			self.cont_lot 		      				:= clean_address[131..134];
			self.cont_lot_order 	  				:= clean_address[135];
			self.cont_dpbc 		   		   			:= clean_address[136..137];
			self.cont_chk_digit 	  				:= clean_address[138];
			self.cont_rec_type		  				:= clean_address[139..140];
			self.cont_ace_fips_st	  				:= clean_address[141..142];
			self.cont_county 	 	 						:= clean_address[143..145];
			self.cont_geo_lat 	    				:= clean_address[146..155];
			self.cont_geo_long 	    				:= clean_address[156..166];
			self.cont_msa 		      				:= clean_address[167..170];
			self.cont_geo_blk								:= clean_address[171..177];
			self.cont_geo_match 	  				:= clean_address[178];
			self.cont_err_stat 	    				:= clean_address[179..182];

			self														:= input;
			self 														:= [];
		end;				
		
		StateCodeLayout := record 
			string StateCode; 
			string StateDesc; 
		end; 
		
		StateCodeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::StateCodeTable', StateCodeLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		
		PopFlmtLookups := record
			string2			recNo;
			string7			idBus;        
			string6			cdPlOfForm; 
			string30		stateDesc;
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
		end;		
		
		PopFlmtLookups findFlmtStateCodeDesc(layouts_raw_input.FlmtPartLay input, StateCodeLayout r ) := transform
			self.stateDesc			:= r.StateDesc;
			self         		  	:= input;
			self                := [];
		end; 
	
		PopFlmtPart := join(	Files_Raw_Input.FlmtPart(fileDate), StateCodeTable,
													trim(left.cdPlOfForm,left,right) = right.StateCode,
													findFlmtStateCodeDesc(left,right),
													left outer, lookup
												);
												
		PopFlmlLookups := record										
			string2			recNo;
			string7			idBus; 
			string6			cdPlOfForm; 
			string30		stateDesc;
			string8			dtComncBus; 
			string1			flIntentRpt;
			string8			dtRptDue; 
			string1			cdRptStat;
			string8			dtDissolve;
			string8			dtIntent;
			string100		nmForeign;
		end;												
												
		PopFlmlLookups findFlmlStateCodeDesc(layouts_raw_input.FlmlPartLay input, StateCodeLayout r ) := transform
			self.stateDesc			:= r.StateDesc;
			self         		  	:= input;
			self                := [];
		end; 
	
		PopFlmlPart := join(	Files_Raw_Input.FlmlPart(fileDate), StateCodeTable,
													trim(left.cdPlOfForm,left,right) = right.StateCode,
													findFlmlStateCodeDesc(left,right),
													left outer, lookup
												);		
		
					
									
		MasterTypeO		:= NormalizeBusMaster(cdSubtype='O');
		
		PopOtherLookups := record
				string2			recNo;
				string7			idBus; 
				string1			cdBusType;
				string1			cdOrigin;
				string8 		dtRptDue;
				string8 		dtDissolve;
				string2			cdCategory;
				string6			cdStateTo;
				string30		stateToDesc;
				string6			cdStateFrom;
				string30		stateFromDesc;
				string70		txComments;
		end;		
		
		PopOtherLookups findOtherStateToCodeDesc(layouts_raw_input.BusOtherLay input, StateCodeLayout r ) := transform
			self.stateToDesc		:= r.StateDesc;
			self         		  	:= input;
			self                := [];
		end; 
	
		PopOtherStateTo := join(	Files_Raw_Input.BusOther(fileDate), StateCodeTable,
															trim(left.cdStateTo,left,right) = right.StateCode,
															findOtherStateToCodeDesc(left,right),
															left outer, lookup
														);		
														
		PopOtherLookups findOtherStateFromCodeDesc(PopOtherLookups input, StateCodeLayout r ) := transform
			self.stateFromDesc		:= r.StateDesc;
			self         		  	:= input;
			self                := [];
		end; 
	
		PopOtherStateFrom := join(PopOtherStateTo, StateCodeTable,
															trim(left.cdStateFrom,left,right) = right.StateCode,
															findOtherStateFromCodeDesc(left,right),
															left outer, lookup
														);															
			
											
		OtherWithMaster MergeOther2Master(PopOtherLookups l, normalizedMaster r ) := transform
			self	:= l;
			self 	:= r;
		end; 
		
		joinOtherWithMaster := join(PopOtherStateFrom, MasterTypeO,
																trim(left.idBus,left,right) = trim(right.idBus,left,right),
																MergeOther2Master(left,right),
																left outer
															);	
															
		MasterTypeC		:= NormalizeBusMaster(cdSubtype='C');
		
		PopCorpLookups := record
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
				string30		stateDesc;
		end;															
															
		PopCorpLookups findCorpStateCodeDesc(Layouts_Raw_Input.CorpLay input, StateCodeLayout r ) := transform
			self.stateDesc			:= r.StateDesc;
			self         		  	:= input;
			self                := [];
		end; 
	
		PopCorpFile := join(Files_Raw_Input.Corp_raw(fileDate), StateCodeTable,
												trim(left.cdPlOfForm,left,right) = right.StateCode,
												findCorpStateCodeDesc(left,right),
												left outer, lookup
											  );															
															
		CorpWithMaster MergeCorp2Master(PopCorpLookups l, normalizedMaster r ) := transform
			self	:= l;
			self 	:= r;
		end; 
		
		joinCorpWithMaster := join(	PopCorpFile, MasterTypeC,
																trim(left.idBus,left,right) = trim(right.idBus,left,right),
																MergeCorp2Master(left,right),
																left outer
															);	
															
		MasterTypeD		:= NormalizeBusMaster(cdSubtype='D');															
															
		DLMTPartWithMaster MergeDLMTPart2Master(Layouts_Raw_Input.DlmtPartLay l, normalizedMaster r ) := transform
			self	:= l;
			self 	:= r;
		end; 
		
		joinDLMTPartWithMaster := join(	Files_Raw_Input.DlmtPart(fileDate), MasterTypeD,
																		trim(left.idBus,left,right) = trim(right.idBus,left,right),
																		MergeDLMTPart2Master(left,right),
																		left outer
																	);
																	
		MasterTypeF		:= NormalizeBusMaster(cdSubtype='F');																	
																	
		PopFLMTPartLookups := record
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
				string30		stateDesc;
		end;															
															
		PopFlmtLookups findFLMTPartStateCodeDesc(Layouts_Raw_Input.FLMTPartLay input, StateCodeLayout r ) := transform
			self.stateDesc			:= r.StateDesc;
			self         		  	:= input;
			self                := [];
		end; 
	
		PopFLMTPartFile := join(Files_Raw_Input.FLMTPart(fileDate), StateCodeTable,
														trim(left.cdPlOfForm,left,right) = right.StateCode,
														findFLMTPartStateCodeDesc(left,right),
														left outer, lookup
														);																		
																	
		FLMTPartWithMaster MergeFLMTPart2Master(PopFlmtLookups l, normalizedMaster r ) := transform
			self	:= l;
			self 	:= r;
		end; 
		
		joinFLMTPartWithMaster := join(	PopFLMTPartFile, MasterTypeF,
																		trim(left.idBus,left,right) = trim(right.idBus,left,right),
																		MergeFLMTPart2Master(left,right),
																		left outer
																	);
																	
		MasterTypeG		:= NormalizeBusMaster(cdSubtype='G');															
															
		DLMTCorpWithMaster MergeDLMTCorp2Master(Layouts_Raw_Input.DlmtCorpLay l, normalizedMaster r ) := transform
			self	:= l;
			self 	:= r;
		end; 
		
		joinDLMTCorpWithMaster := join(	Files_Raw_Input.DlmtCorp(fileDate), MasterTypeG,
																		trim(left.idBus,left,right) = trim(right.idBus,left,right),
																		MergeDLMTCorp2Master(left,right),
																		left outer
																	);	
																	
		MasterTypeH		:= NormalizeBusMaster(cdSubtype='H');

		PopFLMTCorpLookups := record
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
				string30		stateDesc;
		end;															
													
		PopFLMTCorpLookups findFLMTCorpStateCodeDesc(Layouts_Raw_Input.FLMTCorpLay input, StateCodeLayout r ) := transform
			self.stateDesc			:= r.StateDesc;
			self         		  	:= input;
			self                := [];
		end; 
	
		PopFLMTCorpFile := join(Files_Raw_Input.FLMTCorp(fileDate), StateCodeTable,
														trim(left.cdPlOfForm,left,right) = right.StateCode,
														findFLMTCorpStateCodeDesc(left,right),
														left outer, lookup
														);																		
																	
		FLMTCorpWithMaster MergeFLMTCOrp2Master(PopFLMTCorpLookups l, normalizedMaster r ) := transform
			self	:= l;
			self 	:= r;
		end; 
		
		joinFLMTCorpWithMaster := join(	PopFLMTCorpFile, MasterTypeH,
																		trim(left.idBus,left,right) = trim(right.idBus,left,right),
																		MergeFLMTCOrp2Master(left,right),
																		left outer
																	);	
																	
																	
		MasterTypeI		:= NormalizeBusMaster(cdSubtype='I');															
															
		DLMLPartWithMaster MergeDLMLPart2Master(Layouts_Raw_Input.DlmlPartLay l, normalizedMaster r ) := transform
			self	:= l;
			self 	:= r;
		end; 
		
		joinDLMLPartWithMaster := join(	Files_Raw_Input.DlmlPart(fileDate), MasterTypeI,
																		trim(left.idBus,left,right) = trim(right.idBus,left,right),
																		MergeDLMLPart2Master(left,right),
																		left outer
																	);	
																	
		MasterTypeJ		:= NormalizeBusMaster(cdSubtype='J');
		
		PopFLMLPartLookups := record
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
				string30		stateDesc;	
		end;															
													
		PopFLMLPartLookups findFLMLPartStateCodeDesc(Layouts_Raw_Input.FLMLpartLay input, StateCodeLayout r ) := transform
			self.stateDesc			:= r.StateDesc;
			self         		  	:= input;
			self                := [];
		end; 
	
		PopFLMLPartFile := join(Files_Raw_Input.FLMLPart(fileDate), StateCodeTable,
														trim(left.cdPlOfForm,left,right) = right.StateCode,
														findFLMLPartStateCodeDesc(left,right),
														left outer, lookup
														);																		
																	
		FLMLPartWithMaster MergeFLMLPart2Master(PopFLMLPartLookups l, normalizedMaster r ) := transform
			self	:= l;
			self 	:= r;
		end; 
		
		joinFLMLPartWithMaster := join(	PopFLMLPartFile, MasterTypeJ,
																		trim(left.idBus,left,right) = trim(right.idBus,left,right),
																		MergeFLMLPart2Master(left,right),
																		left outer
																	);
																	
		MasterTypeK		:= NormalizeBusMaster(cdSubtype='K');															
															
		GeneralWithMaster MergeGeneral2Master(Layouts_Raw_Input.GeneralLay l, normalizedMaster r ) := transform
			self	:= l;
			self 	:= r;
		end; 
		
		joinGeneralWithMaster := join(	Files_Raw_Input.General(fileDate), MasterTypeK,
																		trim(left.idBus,left,right) = trim(right.idBus,left,right),
																		MergeGeneral2Master(left,right),
																		left outer
																	);		
																	
		MasterTypeL		:= NormalizeBusMaster(cdSubtype='L');	
		
		MasterTypeM		:= NormalizeBusMaster(cdSubtype='M');	
		
		PopForStatLookups := record
			string2			recNo;
			string7			idBus; 
			string6			cdPlOfForm; 
			string30		stateDesc;
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
		end;
		
		PopForStatLookups findForStatStateCodeDesc(layouts_raw_input.ForStatLay input, StateCodeLayout r ) := transform
			self.stateDesc			:= r.StateDesc;
			self         		  	:= input;
			self                := [];
		end; 
	
		PopForStat	 := join(	Files_Raw_Input.ForStat(fileDate), StateCodeTable,
													trim(left.cdPlOfForm,left,right) = right.StateCode,
													findForStatStateCodeDesc(left,right),
													left outer, lookup
												);	
		
		ForStatWithMaster MergeForStat2Master(PopForStatLookups l, normalizedMaster r ) := transform
			self	:= l;
			self 	:= r;
		end; 
		
		joinForStatWithMaster := join(	PopForStat, MasterTypeM,
																		trim(left.idBus,left,right) = trim(right.idBus,left,right),
																		MergeForStat2Master(left,right),
																		left outer
																	);		
		
// map corp records
		mapCorp						:= dedup(project(joinCorpWithMaster, corpMasterTransform(left)),RECORD,ALL);
		mapOther					:= dedup(project(joinOtherWithMaster, corpOtherTransform(left)),RECORD,ALL);
		mapDLMTPart				:= dedup(project(joinDLMTPartWithMaster, corpDLMTPartTransform(left)),RECORD,ALL);
		mapFLMTPart				:= dedup(project(joinFLMTPartWithMaster, corpFLMTPartTransform(left)),RECORD,ALL);
		mapDLMTCorp				:= dedup(project(joinDLMTCorpWithMaster, corpDLMTCorpTransform(left)),RECORD,ALL);
		mapFLMTCorp				:= dedup(project(joinFLMTCorpWithMaster, corpFLMTCorpTransform(left)),RECORD,ALL);
		mapDLMLPart				:= dedup(project(joinDLMLPartWithMaster, corpDLMLPartTransform(left)),RECORD,ALL);
		mapFLMLPart				:= dedup(project(joinFLMLPartWithMaster, corpFLMLPartTransform(left)),RECORD,ALL);
		mapGeneral				:= dedup(project(joinGeneralWithMaster, corpGeneralTransform(left)),RECORD,ALL);
		mapDomStat				:= dedup(project(MasterTypeL, corpDomStatTransform(left)),RECORD,ALL);
		mapForStat				:= dedup(project(joinForStatWithMaster, corpForStatTransform(left)),RECORD,ALL);
		mapReserve				:= dedup(project(Files_Raw_Input.BusReserve(fileDate), corpReserveTransform(left)),RECORD,ALL);
		mapNameChg				:= dedup(project(Files_Raw_Input.NameChg(fileDate), NameChgTransform(left)),RECORD,ALL);
		
		mapCorpFiles			:= mapOther + mapDLMTPart + mapFLMTPart + mapCorp + mapDLMTCorp + mapFLMTCorp + 
													mapDLMLPart + mapFLMLPart + mapGeneral + mapDomStat + mapForStat + mapReserve +
													mapNameChg;
													
		cleanCorps				:= project(mapCorpFiles, CleanCorpAddrName(left));
 
// map event records 

		FilingWithFilm MergeFiling2Film(Layouts_Raw_Input.BusFilingLay l, Layouts_Raw_Input.FilmIndxLay r ) := transform
			self	:= l;
			self 	:= r;
		end; 
		
		joinFilingWithFilm	:= join(	Files_Raw_Input.BusFiling(fileDate), Files_Raw_Input.FilmIndx(fileDate),
																	trim(left.idBusFlng,left,right) = trim(right.idFlngNbr,left,right),
																	MergeFiling2Film(left,right),
																	left outer
																);
																	
		mapEventMain		:= project(Files_Raw_Input.BusFiling(fileDate), EventFilingTransform(left));
		mapNameChgEvent	:= project(Files_Raw_Input.NameChg(fileDate), EventNameChgTransform(left));
		mapMergerEvent	:= project(Files_Raw_Input.BusMerger(fileDate), EventMergerTransform(left));
		mapFilmEvent		:= project(joinFilingWithFilm, EventFilmTransform(left));
		
		mapEvent				:= mapEventMain + mapNameChgEvent + mapMergerEvent;

// map stock records 		
		mapStockFile		:= project(Files_Raw_Input.Stock(fileDate), StockTransform(left));	
		mapStockMaster	:= project(Files_Raw_Input.BusMaster(fileDate), StockMasterTransform(left));	
		
		mapStock				:= mapStockFile + mapStockMaster;
		
// map contact records
		mapLegalCont		:= project(DedupDenormalized, ContLegalTransform(left));
		mapReserveCont  := project(Files_Raw_Input.BusReserve(fileDate), ContReserveTransform(left));
		
		mapContact			:= mapLegalCont + mapReserveCont;
		
		cleanConts			:= project(mapContact, CleanContAddrName(left));
		
//map AR records
		mapARFiling			:= project(Files_Raw_Input.BusFiling(fileDate), ARFilingTransform(left));
		mapARCorp				:= project(Files_Raw_Input.Corp_raw(fileDate), ARCorpTransform(left));
		mapARDLMTPart		:= project(Files_Raw_Input.DLMTPart(fileDate), ARDLMTPartTransform(left));
		mapARFLMTPart		:= project(Files_Raw_Input.FLMTPart(fileDate), ARFLMTPartTransform(left));		
		mapARDLMTCorp		:= project(Files_Raw_Input.DLMTCorp(fileDate), ARDLMTCorpTransform(left));
		mapARFLMTCorp		:= project(Files_Raw_Input.FLMTCorp(fileDate), ARFLMTCorpTransform(left));
		mapARBusOther		:= project(Files_Raw_Input.BusOther(fileDate), ARBusOtherTransform(left));	
		mapARDLMLPart		:= project(Files_Raw_Input.DLMLPart(fileDate), ARDLMLPartTransform(left));
		mapARFLMLPart		:= project(Files_Raw_Input.FLMLPart(fileDate), ARFLMLPartTransform(left));		
		
		mapAR						:= mapARFiling + mapARCorp;

	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::BusMaster::ct'		,finalMasterFile(idBus<>'0000000')	,fixMaster		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::BusFiling::ct'		,finalFilingFile										,fixFiling		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::BusMergr::ct'		,finalMergerFile										,fixMerger		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::BusOther::ct'		,finalOtherFile											,fixOther			,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::BusRsvr::ct'			,finalReserveFile										,fixReserve		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::Corp::ct'				,finalCorpFile											,fixCorp			,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::DlmtPart::ct'		,finalDlmtPartFile									,fixDlmtPart	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::FlmtPart::ct'		,finalFlmtPartFile									,fixFlmtPart	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::DlmtCorp::ct'		,finalDlmtCorpFile									,fixDlmtCorp	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::FlmtCorp::ct'		,finalFlmtCorpFile									,fixFlmtCorp	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::NameChng::ct'		,finalNameChngFile									,fixNameChng	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::FilmIndx::ct'		,finalFilmIndxFile									,fixFilmIndx	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::Stock::ct'				,finalStockFile											,fixStock			,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::Prncipal::ct'		,finalPrncipalFile									,fixPrncipal	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::DlmlPart::ct'		,finalDlmlPartFile									,fixDlmlPart	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::FlmlPart::ct'		,finalFlmlPartFile									,fixFlmlPart	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::Generalp::ct'		,finalGeneralpFile									,fixGeneralp	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+fileDate+'::ForStat::ct'			,finalForStatFile										,fixForStat		,,,pOverwrite);		


	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_ct'	,cleanCorps		,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ct'	,MapStock			,stock_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_ct'		,MapAR				,ar_out			,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_ct'	,cleanConts		,cont_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ct'	,MapEvent			,event_out	,,,pOverwrite);
                                                                                                                                                         
		PreprocessCT := parallel(
			 fixMaster	                                                                                                                                 
			,fixFiling	
			,fixMerger	
			,fixOther		
			,fixReserve	
			,fixCorp		
			,fixDlmtPart
			,fixFlmtPart
			,fixDlmtCorp
			,fixFlmtCorp
			,fixNameChng
			,fixFilmIndx
			,fixStock		
			,fixPrncipal
			,fixDlmlPart
			,fixFlmlPart
			,fixGeneralp
			,fixForStat	
		);

		mapCTFiling := parallel(
			 corp_out			
			,stock_out		
			,ar_out				
			,cont_out			
			,event_out		
		);
		

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('ct',filedate,pOverwrite := pOverwrite))
			,PreprocessCT
			,mapCTFiling
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_ct')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_ct')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_ct')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_ct')														  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_ct')
			)							
		);
		
		return result;
	end;					 	
end;