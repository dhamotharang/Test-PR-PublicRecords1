import corp2_mapping, corp2_raw_ct, tools, ut;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
  
	//----------------------
	// Input File Versions
	//----------------------
	EXPORT Input := MODULE
		
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.BusFiling,  Corp2_Raw_CT.Layouts.tmpFilingLay,  BusFiling);
	  tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.BusMaster,  Corp2_Raw_CT.Layouts.tmpMasterLay,  BusMaster);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.BusMerger,  Corp2_Raw_CT.Layouts.tmpMergerLay,  BusMerger,);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.BusOther,   Corp2_Raw_CT.Layouts.tmpOtherLay,   BusOther);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.BusReserve, Corp2_Raw_CT.Layouts.tmpReserveLay, BusReserve);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.Corps,      Corp2_Raw_CT.Layouts.tmpCorpsLay,   Corps);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.DlmlPart,   Corp2_Raw_CT.Layouts.tmpDlmlPartLay,DlmlPart);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.DlmtCorp,   Corp2_Raw_CT.Layouts.tmpDlmtCorpLay,DlmtCorp);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.DlmtPart,   Corp2_Raw_CT.Layouts.tmpDlmtPartLay,DlmtPart);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.FilmIndx,   Corp2_Raw_CT.Layouts.tmpFilmIndxLay,FilmIndx);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.FlmlPart,   Corp2_Raw_CT.Layouts.tmpFlmlPartLay,FlmlPart);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.FlmtCorp,   Corp2_Raw_CT.Layouts.tmpFlmtCorpLay,FlmtCorp);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.FlmtPart,   Corp2_Raw_CT.Layouts.tmpFlmtPartLay,FlmtPart);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.ForStat,    Corp2_Raw_CT.Layouts.tmpForStatLay, ForStat);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.General,    Corp2_Raw_CT.Layouts.tmpGeneralpLay,General);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.NameChg,    Corp2_Raw_CT.Layouts.tmpNameChngLay,NameChg);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.Prncipal,   Corp2_Raw_CT.Layouts.tmpPrncipalLay,Prncipal);
		tools.mac_FilesInput(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Input.Stock,      Corp2_Raw_CT.Layouts.tmpStockLay,   Stock);
    
		//------------------------------------------------------------------------------------------------
		// Each Vendor Input file needs to have invalid characters [\\x00|.] cleaned & 
		//      be parsed into into the input layouts
		//------------------------------------------------------------------------------------------------
		
		//-----------------
		// BusFiling file
		//-----------------
	  BusFiling_Raw  := BusFiling.logical;
		
		Corp2_Raw_CT.Layouts.tmpFilingLay cleanFiling(Corp2_Raw_CT.Layouts.tmpFilingLay input):= transform
			self.tmpField		:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
	
	  clnFiling		:= project(BusFiling_Raw,cleanFiling(left));		
	
		Corp2_Raw_CT.Layouts.BusFilingLayoutIN formatFiling(Corp2_Raw_CT.Layouts.tmpFilingLay input) :=  transform
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
		
		EXPORT fBusFiling := project(clnFiling,formatFiling(left));
		
		//-----------------
		// BusMaster file
		//-----------------
	  BusMaster_Raw  := BusMaster.logical;
		
		Corp2_Raw_CT.Layouts.tmpMasterLay cleanMaster(Corp2_Raw_CT.Layouts.tmpMasterLay input):= transform
				self.tmpField		:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnMaster		:= project(BusMaster_Raw,cleanMaster(left));
		
		Corp2_Raw_CT.Layouts.BusMasterLayoutIN formatMaster(Corp2_Raw_CT.Layouts.tmpMasterLay input) :=  transform
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
											
		EXPORT fBusMaster  := project(clnMaster,formatMaster(left));
	
	  //-----------------
		// BusMerger file
		//-----------------
	  BusMerger_Raw  := BusMerger.logical;
	  
		Corp2_Raw_CT.Layouts.tmpMergerLay cleanMerger(Corp2_Raw_CT.Layouts.tmpMergerLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnMerger		:= project(BusMerger_Raw,cleanMerger(left));

		Corp2_Raw_CT.Layouts.BusMergerLayoutIN formatMerger(Corp2_Raw_CT.Layouts.tmpMergerLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBusFlng		:= input.tmpField[3..12];
				self.idSurvBus		:= input.tmpField[13..19];
				self.idTermBus		:= input.tmpField[20..26];
				self.idSeqNbr			:= input.tmpField[27..30];
				self.dtFiling			:= input.tmpField[31..38];
		end;
		
		EXPORT fBusMerger := project(clnMerger,formatMerger(left));
		
	  //-----------------
		// BusOther file
		//-----------------
	  BusOther_Raw  := BusOther.logical;
		
		Corp2_Raw_CT.Layouts.tmpOtherLay cleanOther(Corp2_Raw_CT.Layouts.tmpOtherLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnOther := project(BusOther_Raw,cleanOther(left));
		
		Corp2_Raw_CT.Layouts.BusOtherLayoutIN formatOther(Corp2_Raw_CT.Layouts.tmpOtherLay input) :=  transform
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
		
		EXPORT fBusOther := project(clnOther,formatOther(left));
		
	  //-----------------
		// BusReserve file
		//-----------------
	  BusReserve_Raw  := BusReserve.logical;
		
		Corp2_Raw_CT.Layouts.tmpReserveLay cleanReserve(Corp2_Raw_CT.Layouts.tmpReserveLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnReserve := project(BusReserve_Raw,cleanReserve(left));
		
		Corp2_Raw_CT.Layouts.BusReserveLayoutIN formatReserve(Corp2_Raw_CT.Layouts.tmpReserveLay input) :=  transform
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
		
		EXPORT fBusReserve := project(clnReserve,formatReserve(left));
		
	  //-----------------
		// Corps file
		//-----------------
	  Corps_Raw  := Corps.logical;		
		
		Corp2_Raw_CT.Layouts.tmpCorpsLay cleanCorp(Corp2_Raw_CT.Layouts.tmpCorpsLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnCorp	:= project(Corps_Raw,cleanCorp(left));
		
		Corp2_Raw_CT.Layouts.CorpsLayoutIN formatCorp(Corp2_Raw_CT.Layouts.tmpCorpsLay input) :=  transform
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
		  	
		EXPORT fCorps := project(clnCorp,formatCorp(left));
		
		//-----------------
	  // DlmtPart file
		//-----------------
	  DlmtPart_Raw  := DlmtPart.logical;
		
		Corp2_Raw_CT.Layouts.tmpDlmtPartLay cleanDlmtPart(Corp2_Raw_CT.Layouts.tmpDlmtPartLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnDlmtPart	:= project(DlmtPart_Raw,cleanDlmtPart(left));
			
		Corp2_Raw_CT.Layouts.DlmtPartLayoutIN formatDlmtPart(Corp2_Raw_CT.Layouts.tmpDlmtPartLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus				:= input.tmpField[3..9];
				self.dtTerm				:= input.tmpField[10..17];
				self.dtRptDue			:= input.tmpField[18..25];
				self.cdRptStat		:= input.tmpField[26..26];
		end;
		
  	EXPORT fDlmtPart := project(clnDlmtPart,formatDlmtPart(left));
		
		//-----------------
	  // FlmtPart file
		//-----------------
	  FlmtPart_Raw  := FlmtPart.logical;
		
		Corp2_Raw_CT.Layouts.tmpFlmtPartLay cleanFlmtPart(Corp2_Raw_CT.Layouts.tmpFlmtPartLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnFlmtPart	:= project(FlmtPart_Raw,cleanFlmtPart(left));
		
		Corp2_Raw_CT.Layouts.FlmtPartLayoutIN formatFlmtPart(Corp2_Raw_CT.Layouts.tmpFlmtPartLay input) :=  transform
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
	
		EXPORT fFlmtPart := project(clnFlmtPart,formatFlmtPart(left));
			
		//-----------------
	  // DlmtCorp file
		//-----------------
	  DlmtCorp_Raw  := DlmtCorp.logical;	
																	
		Corp2_Raw_CT.Layouts.tmpDlmtCorpLay cleanDlmtCorp(Corp2_Raw_CT.Layouts.tmpDlmtCorpLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnDlmtCorp		:= project(DlmtCorp_Raw,cleanDlmtCorp(left));
		
		Corp2_Raw_CT.Layouts.DlmtCorpLayoutIN formatDlmtCorp(Corp2_Raw_CT.Layouts.tmpDlmtCorpLay input) :=  transform
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
		
		EXPORT fDlmtCorp := project(clnDlmtCorp,formatDlmtCorp(left));
		
		//-----------------
	  // FlmtCorp file
		//-----------------
	  FlmtCorp_Raw  := FlmtCorp.logical;	
		
		Corp2_Raw_CT.Layouts.tmpFlmtCorpLay cleanFlmtCorp(Corp2_Raw_CT.Layouts.tmpFlmtCorpLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnFlmtCorp		:= project(FlmtCorp_Raw,cleanFlmtCorp(left));
		
		Corp2_Raw_CT.Layouts.FlmtCorpLayoutIN formatFlmtCorp(Corp2_Raw_CT.Layouts.tmpFlmtCorpLay input) :=  transform
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
			
		EXPORT fFlmtCorp := project(clnFlmtCorp,formatFlmtCorp(left));
		
		//-----------------
	  // NameChg file
		//-----------------
	  NameChg_Raw  := NameChg.logical;	
		
		Corp2_Raw_CT.Layouts.tmpNameChngLay cleanNameChng(Corp2_Raw_CT.Layouts.tmpNameChngLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnNameChng		:= project(NameChg_Raw,cleanNameChng(left));
		
		Corp2_Raw_CT.Layouts.NameChgLayoutIN formatNameChng(Corp2_Raw_CT.Layouts.tmpNameChngLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus				:= input.tmpField[3..9];
				self.idBusFlng		:= input.tmpField[10..19];
				self.dtChanged		:= input.tmpField[20..27];
				self.nmOld				:= input.tmpField[28..127];
				self.nmNew				:= input.tmpField[128..227];
				self.nmOldSearch	:= input.tmpField[228..327];
		end;
		
		EXPORT fNameChg := project(clnNameChng,formatNameChng(left));

		//-----------------
	  // FilmIndx file
		//-----------------
	  FilmIndx_Raw  := FilmIndx.logical;
								
		Corp2_Raw_CT.Layouts.tmpFilmIndxLay cleanFilmIndx(Corp2_Raw_CT.Layouts.tmpFilmIndxLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnFilmIndx	:= project(FilmIndx_Raw,cleanFilmIndx(left));
		
		Corp2_Raw_CT.Layouts.FilmIndxLayoutIN formatFilmIndx(Corp2_Raw_CT.Layouts.tmpFilmIndxLay input) :=  transform
				self.recno				:= input.tmpField[1..2];
				self.idFlngNbr		:= input.tmpField[3..12];
				self.cdMfFlngType	:= input.tmpField[13..13];
				self.cdVolume			:= input.tmpField[14..18];
				self.cdStartPage	:= input.tmpField[19..22];
				self.idImgObj			:= input.tmpField[23..48];
				self.idImgFldr		:= input.tmpField[49..56];
				self.qtPages			:= input.tmpField[57..61];
		end;
		
		EXPORT fFilmIndx := project(clnFilmIndx,formatFilmIndx(left));

		//-----------------
	  // Stock file
		//-----------------
	  Stock_Raw  := Stock.logical;

		Corp2_Raw_CT.Layouts.tmpStockLay cleanStock(Corp2_Raw_CT.Layouts.tmpStockLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnStock  := project(Stock_Raw,cleanStock(left));
		
		Corp2_Raw_CT.Layouts.StockLayoutIN formatStock(Corp2_Raw_CT.Layouts.tmpStockLay input) :=  transform
				self.recno        := input.tmpField[1..2];
				self.idBus        := input.tmpField[3..9];
				self.idSeqNbr     := input.tmpField[10..13];
				self.amShares     := input.tmpField[14..24];
				self.filler1			:= input.tmpField[25..25];
				self.cdShareCls   := input.tmpField[26..55];
				self.amParValue		:= input.tmpField[56..65];
		end;
			
		EXPORT fStock := project(clnStock,formatStock(left));		
		
		//-----------------
	  // Prncipal file
		//-----------------
	  Prncipal_Raw  := Prncipal.logical;		
		
		Corp2_Raw_CT.Layouts.tmpPrncipalLay cleanPrncipal(Corp2_Raw_CT.Layouts.tmpPrncipalLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnPrncipal	:= project(Prncipal_Raw,cleanPrncipal(left));
		
		Corp2_Raw_CT.Layouts.PrncipalLayoutIN formatPrncipal(Corp2_Raw_CT.Layouts.tmpPrncipalLay input) :=  transform
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
		
		EXPORT fPrncipal  := project(clnPrncipal,formatPrncipal(left));
														
		//-----------------
	  // DlmlPart file
		//-----------------
	  DlmlPart_Raw  := DlmlPart.logical;	
																		
		Corp2_Raw_CT.Layouts.tmpDlmlPartLay cleanDlmlPart(Corp2_Raw_CT.Layouts.tmpDlmlPartLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnDlmlPart		:= project(DlmlPart_Raw,cleanDlmlPart(left));
		
		Corp2_Raw_CT.Layouts.DlmlPartLayoutIN formatDlmlPart(Corp2_Raw_CT.Layouts.tmpDlmlPartLay input) :=  transform
				self.recNo				:= input.tmpField[1..2];
				self.idBus				:= input.tmpField[3..9];
				self.cdRptStat		:= input.tmpField[10..10];
				self.dtRptDue    	:= input.tmpField[11..18];
				self.dtDissolve		:= input.tmpField[19..26];
				self.dtIntent			:= input.tmpField[27..34];
				self.flIntentAgt	:= input.tmpField[35..35];
				self.flIntentRpt	:= input.tmpField[36..36];
		end;
		
		EXPORT fDlmlPart := project(clnDlmlPart,formatDlmlPart(left));
	
	  //-----------------
	  // FlmlPart file
		//-----------------
	  FlmlPart_Raw  := FlmlPart.logical;															
																
		Corp2_Raw_CT.Layouts.tmpFlmlPartLay cleanFlmlPart(Corp2_Raw_CT.Layouts.tmpFlmlPartLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnFlmlPart		:= project(FlmlPart_Raw,cleanFlmlPart(left));
		
		Corp2_Raw_CT.Layouts.FlmlPartLayoutIN formatFlmlPart(Corp2_Raw_CT.Layouts.tmpFlmlPartLay input) :=  transform
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
				
		EXPORT fFlmlPart := project(clnFlmlPart,formatFlmlPart(left));
		
		//-----------------
	  // General file
		//-----------------
	  General_Raw  := General.logical;														
						
		Corp2_Raw_CT.Layouts.tmpGeneralpLay cleanGeneral(Corp2_Raw_CT.Layouts.tmpGeneralpLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnGeneral		:= project(General_Raw,cleanGeneral(left));
		
		Corp2_Raw_CT.Layouts.GeneralLayoutIN formatGeneral(Corp2_Raw_CT.Layouts.tmpGeneralpLay input) :=  transform
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
		
		EXPORT fGeneral := project(clnGeneral,formatGeneral(left));
		
		//-----------------
	  // ForStat file
		//-----------------
	  ForStat_Raw  := ForStat.logical;
														
		Corp2_Raw_CT.Layouts.tmpForStatLay cleanForStat(Corp2_Raw_CT.Layouts.tmpForStatLay input):= transform
				self.tmpField			:=	regexreplace('[\\x00|.]',input.tmpField,' ');
		end;
		
		clnForStat		:= project(ForStat_Raw,cleanForStat(left));
		
		Corp2_Raw_CT.Layouts.ForStatLayoutIN formatForStat(Corp2_Raw_CT.Layouts.tmpForStatLay input) :=  transform
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
		
		EXPORT fForStat := project(clnForStat,formatForStat(left));		
	
	END;	
	
	
	//----------------------
	// Base File Versions
	//----------------------
	EXPORT Base := MODULE

		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.BusFiling,  Corp2_Raw_CT.Layouts.BusFilingLayoutBASE,  BusFiling);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.BusMaster,  Corp2_Raw_CT.Layouts.BusMasterLayoutBASE,  BusMaster);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.BusMerger,  Corp2_Raw_CT.Layouts.BusMergerLayoutBASE,  BusMerger);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.BusOther,   Corp2_Raw_CT.Layouts.BusOtherLayoutBASE,   BusOther);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.BusReserve, Corp2_Raw_CT.Layouts.BusReserveLayoutBASE, BusReserve);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.Corps,      Corp2_Raw_CT.Layouts.CorpsLayoutBASE,      Corps);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.DlmlPart,   Corp2_Raw_CT.Layouts.DlmlPartLayoutBASE,   DlmlPart);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.DlmtCorp,   Corp2_Raw_CT.Layouts.DlmtCorpLayoutBASE,   DlmtCorp);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.DlmtPart,   Corp2_Raw_CT.Layouts.DlmtPartLayoutBASE,   DlmtPart);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.FilmIndx,   Corp2_Raw_CT.Layouts.FilmIndxLayoutBASE,   FilmIndx);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.FlmlPart,   Corp2_Raw_CT.Layouts.FlmlPartLayoutBASE,   FlmlPart);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.FlmtCorp,   Corp2_Raw_CT.Layouts.FlmtCorpLayoutBASE,   FlmtCorp);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.FlmtPart,   Corp2_Raw_CT.Layouts.FlmtPartLayoutBASE,   FlmtPart);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.ForStat,    Corp2_Raw_CT.Layouts.ForStatLayoutBASE,    ForStat);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.General,    Corp2_Raw_CT.Layouts.GeneralLayoutBASE,    General);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.NameChg,    Corp2_Raw_CT.Layouts.NameChgLayoutBASE,    NameChg);
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.Prncipal,   Corp2_Raw_CT.Layouts.PrncipalLayoutBASE,   Prncipal);		
		tools.mac_FilesBase(Corp2_Raw_CT.Filenames(pversion, pUseOtherEnvironment).Base.Stock,      Corp2_Raw_CT.Layouts.StockLayoutBASE,      Stock);
	
	END;

END;