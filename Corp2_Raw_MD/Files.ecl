import ut, tools, Corp2_Mapping;

EXPORT Files(STRING  pversion             = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.AmendHist, Corp2_Raw_MD.Layouts.AmendHistIn, AmendHist);
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.ARCAmendHist, Corp2_Raw_MD.Layouts.AmendHistIn,ARCAmendHist);
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.BusAddr, Corp2_Raw_MD.Layouts.BusAddrIn, BusAddr);												
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.ARCBusAddr, Corp2_Raw_MD.Layouts.BusAddrIn, ARCBusAddr);
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.BusEntity, Corp2_Raw_MD.Layouts.BusEntityIn, BusEntity);
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.BusNmIndx, Corp2_Raw_MD.Layouts.BusNmIndxIn, BusNmIndx);
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.ARCBusNmIndx, Corp2_Raw_MD.Layouts.BusNmIndxIn, ARCBusNmIndx);
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.BusType, Corp2_Raw_MD.Layouts.BusTypeIn,  BusType);
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.BusComment, Corp2_Raw_MD.Layouts.BusCommentIn, BusComment);
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.EntityStatus, Corp2_Raw_MD.Layouts.EntityStatusIn, EntityStatus);
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.FilingType, Corp2_Raw_MD.Layouts.FilingTypeIn, FilingType);		
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.TradeName, Corp2_Raw_MD.Layouts.TradeNameIn, TradeName);
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.FilmIndx, Corp2_Raw_MD.Layouts.FilmIndxIn, FilmIndx);
		tools.mac_FilesInput(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Input.ReserveName, Corp2_Raw_MD.Layouts.ReserveNameIn, ReserveName);		
			
		// Logical Files
		EXPORT AmendHist_raw        := AmendHist.Logical;
		EXPORT ARCAmendHist_raw     := ARCAmendHist.Logical;
		EXPORT BusAddr_raw       		:= BusAddr.Logical;
		EXPORT ARCBusAddr_raw       := ARCBusAddr.Logical;
		EXPORT BusNmIndx_raw        := BusNmIndx.Logical;
		EXPORT ARCBusNmIndx_raw     := ARCBusNmIndx.Logical;
		EXPORT BusType_raw       		:= BusType.Logical;
		EXPORT BusComment_raw       := BusComment.Logical;
		EXPORT FilingType_raw       := FilingType.Logical;
		EXPORT FilmIndx_raw      	  := FilmIndx.Logical;
		EXPORT BusEntity_raw        := BusEntity.Logical;
		EXPORT EntityStatus_raw     := EntityStatus.Logical;
		EXPORT ReserveName_raw      := ReserveName.Logical;
		EXPORT TradeName_raw        := TradeName.Logical;		
		
		//Removing SpecialChars from all of the raw files by using â€œut.fn_RemoveSpecialCharsâ€ routine
		Corp2_Raw_MD.Layouts.AmendHistOut  AmendHistTrans ( Corp2_Raw_MD.Layouts.AmendHistIn L) := TRANSFORM

			SELF.AmendHistStr := L.AmendHistStr[1..length((>varstring153<)L.AmendHistStr)];

		END;

		AmendFile	:= PROJECT(AmendHist_raw,  AmendHistTrans(LEFT)); 
		
		Corp2_Raw_MD.Layouts.AmendHistLayout AmendHistTransFixed(Corp2_Raw_MD.Layouts.AmendHistOut l) := TRANSFORM

			self.ID_BUS_Prefix		:= ut.fn_RemoveSpecialChars(l.AmendHistStr[1..1]);
			self.ID_BUS						:= ut.fn_RemoveSpecialChars(l.AmendHistStr[2..16]);
			self.cdFilingType			:= ut.fn_RemoveSpecialChars(l.AmendHistStr[18..25]);
			self.tsBusEffective		:= ut.fn_RemoveSpecialChars(l.AmendHistStr[26..51]);
			self.flStock					:= ut.fn_RemoveSpecialChars(l.AmendHistStr[52..52]);
			self.flClose					:= ut.fn_RemoveSpecialChars(l.AmendHistStr[53..53]);
			self.idComments				:= ut.fn_RemoveSpecialChars(l.AmendHistStr[54..61]);
			self.tsLastUpdt				:= ut.fn_RemoveSpecialChars(l.AmendHistStr[62..87]);
			self.tsEffective			:= ut.fn_RemoveSpecialChars(l.AmendHistStr[88..113]);
			self.idFlngNbr				:= ut.fn_RemoveSpecialChars(l.AmendHistStr[114..129]);
			self.cdStatus					:= ut.fn_RemoveSpecialChars(l.AmendHistStr[130..130]);
			self.cdBusType				:= ut.fn_RemoveSpecialChars(l.AmendHistStr[131..132]);
			self.cdFormationType	:= ut.fn_RemoveSpecialChars(l.AmendHistStr[133..140]);
			self.FlChgRA					:= ut.fn_RemoveSpecialChars(l.AmendHistStr[141..141]);
			self.FlChgRAAddr			:= ut.fn_RemoveSpecialChars(l.AmendHistStr[142..142]);
			self.FlChgPO					:= ut.fn_RemoveSpecialChars(l.AmendHistStr[143..143]);
			self.dtStatEffective	:= ut.fn_RemoveSpecialChars(l.AmendHistStr[144..153]);

		end;

		EXPORT AmendOutFile	:= PROJECT(AmendFile, AmendHistTransFixed(LEFT));
		
		Corp2_Raw_MD.Layouts.ARCAmendHistOut  ARCAmendHistTrans ( Corp2_Raw_MD.Layouts.AmendHistIn L) := TRANSFORM

			SELF.ARCAmendHistStr := L.AmendHistStr[1..length((>varstring153<)L.AmendHistStr)];

		END;

		EXPORT ARCAmendFile	:= PROJECT(ARCAmendHist_raw,  ARCAmendHistTrans(LEFT));

		Corp2_Raw_MD.Layouts.AmendHistLayout ARCAmendHistTransFixed(Corp2_Raw_MD.Layouts.ARCAmendHistOut l) := TRANSFORM

			self.ID_BUS_Prefix		:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[1..1]);
			self.ID_BUS						:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[2..16]);
			self.cdFilingType			:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[18..25]);
			self.tsBusEffective		:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[26..51]);
			self.flStock					:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[52..52]);
			self.flClose					:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[53..53]);
			self.idComments				:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[54..61]);
			self.tsLastUpdt				:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[62..87]);
			self.tsEffective			:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[88..113]);
			self.idFlngNbr				:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[114..129]);
			self.cdStatus					:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[130..130]);
			self.cdBusType				:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[131..132]);
			self.cdFormationType	:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[133..140]);
			self.FlChgRA					:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[141..141]);
			self.FlChgRAAddr			:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[142..142]);
			self.FlChgPO					:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[143..143]);
			self.dtStatEffective	:= ut.fn_RemoveSpecialChars(l.ARCAmendHistStr[144..153]);

		end;

		EXPORT ARCAmendOutFile	:= PROJECT(ARCAmendFile, ARCAmendHistTransFixed(LEFT));
		
		Corp2_Raw_MD.Layouts.FilmIndxOut  FilmIndxTrans ( Corp2_Raw_MD.Layouts.FilmIndxIn L) := TRANSFORM

			SELF.FilmIndxStr := L.FilmIndxStr[1..length((>varstring64<)L.FilmIndxStr)];

		END;

		EXPORT FilmIndexOut		:= PROJECT(FilmIndx_raw,  FilmIndxTrans(LEFT));

		Corp2_Raw_MD.Layouts.FilmIndxLayout FilmIndxTransFixed(Corp2_Raw_MD.Layouts.FilmIndxOut l) := TRANSFORM

			self.idFlngNbr			:= ut.fn_RemoveSpecialChars(l.FilmIndxStr[1..16]);
			self.cdVolume				:= ut.fn_RemoveSpecialChars(l.FilmIndxStr[18..22]);
			self.cdStartPage		:= ut.fn_RemoveSpecialChars(l.FilmIndxStr[23..26]);

		end;

		EXPORT FilmIndxOutFile	:= PROJECT(FilmIndexout, FilmIndxTransFixed(LEFT));

		
		Corp2_Raw_MD.Layouts.ReserveNameOut  ReserveNameTrans ( Corp2_Raw_MD.Layouts.ReserveNameIn L) := TRANSFORM

			SELF.ReserveNameStr := L.ReserveNameStr[1..length((>varstring78<)L.ReserveNameStr)];

		END;

		EXPORT ReserveNmOut	 := PROJECT(ReserveName_raw,  ReserveNameTrans(LEFT));

		Corp2_Raw_MD.Layouts.ReserveNameLayout ReserveNameTransFixed( Corp2_Raw_MD.Layouts.ReserveNameOut l) := TRANSFORM

			self.DT_EXPIRATION	:= ut.fn_RemoveSpecialChars(l.ReserveNameStr[1..10]);
			self.TS_EFFECTIVE		:= ut.fn_RemoveSpecialChars(l.ReserveNameStr[11..36]);
			self.TS_LAST_UPDT		:= ut.fn_RemoveSpecialChars(l.ReserveNameStr[37..62]);
			self.ID_BUS_PREFIX	:= ut.fn_RemoveSpecialChars(l.ReserveNameStr[63..63]);
			self.ID_BUS					:= ut.fn_RemoveSpecialChars(l.ReserveNameStr[64..79]);

		end;

		EXPORT ReserveNameOutFile	:= PROJECT( ReserveNmOut, ReserveNameTransFixed(LEFT));

		Corp2_Raw_MD.Layouts.BusAddrLayout BusAddrOutTransFixed(Corp2_Raw_MD.Layouts.BusAddrIn l) := TRANSFORM

			self.ID_BUS_PREFIX  	:= ut.fn_RemoveSpecialChars(l.ID_BUS_PREFIX);
			self.ID_BUS	   				:= ut.fn_RemoveSpecialChars(l.ID_BUS);
			self.ID_ADDRESS  	    := ut.fn_RemoveSpecialChars(l.ID_ADDRESS);
			self.CD_ADDRESS_TYPE  := ut.fn_RemoveSpecialChars(l.CD_ADDRESS_TYPE);
			self.TS_EFFECTIVE	    := ut.fn_RemoveSpecialChars(l.TS_EFFECTIVE);
			self.TS_END	   	 			:= ut.fn_RemoveSpecialChars(l.TS_END);
			self.NM_NAME  	      := ut.fn_RemoveSpecialChars(l.NM_NAME);
			self.AD_LINE1  	      := ut.fn_RemoveSpecialChars(l.AD_LINE1);
			self.AD_LINE2  	      := ut.fn_RemoveSpecialChars(l.AD_LINE2);
			self.AD_LINE3  	      := ut.fn_RemoveSpecialChars(l.AD_LINE3);
			self.AD_LINE4  	      := ut.fn_RemoveSpecialChars(l.AD_LINE4);
			self.AD_CITY  	      := ut.fn_RemoveSpecialChars(l.AD_CITY);
			self.AD_STATE  	      := ut.fn_RemoveSpecialChars(l.AD_STATE);
			self.AD_ZIP     	    := ut.fn_RemoveSpecialChars(l.AD_ZIP);
			self.AD_TELE  	      := ut.fn_RemoveSpecialChars(l.AD_TELE);
			self.AD_FAX	     			:= ut.fn_RemoveSpecialChars(l.AD_FAX);
			self.AD_E_MAIL  	   	:= ut.fn_RemoveSpecialChars(l.AD_E_MAIL);  
			self.TS_LAST_UPDT  	  := ut.fn_RemoveSpecialChars(l.TS_LAST_UPDT);
			self.ID_MAIL_LABEL_YR := ut.fn_RemoveSpecialChars(l.ID_MAIL_LABEL_YR);
			self.AD_COUNTRY  	    := ut.fn_RemoveSpecialChars(l.AD_COUNTRY);

		end;

		EXPORT BusAddrOutFile	:= PROJECT(BusAddr_raw, BusAddrOutTransFixed(LEFT));

		Corp2_Raw_MD.Layouts.BusAddrLayout ARCBusAddrOutTransFixed(Corp2_Raw_MD.Layouts.BusAddrIn l) := TRANSFORM

			self.ID_BUS_PREFIX  	:= ut.fn_RemoveSpecialChars(l.ID_BUS_PREFIX);
			self.ID_BUS	   				:= ut.fn_RemoveSpecialChars(l.ID_BUS);
			self.ID_ADDRESS  	    := ut.fn_RemoveSpecialChars(l.ID_ADDRESS);
			self.CD_ADDRESS_TYPE  := ut.fn_RemoveSpecialChars(l.CD_ADDRESS_TYPE);
			self.TS_EFFECTIVE	    := ut.fn_RemoveSpecialChars(l.TS_EFFECTIVE);
			self.TS_END	   	 			:= ut.fn_RemoveSpecialChars(l.TS_END);
			self.NM_NAME  	      := ut.fn_RemoveSpecialChars(l.NM_NAME);
			self.AD_LINE1  	      := ut.fn_RemoveSpecialChars(l.AD_LINE1);
			self.AD_LINE2  	      := ut.fn_RemoveSpecialChars(l.AD_LINE2);
			self.AD_LINE3  	      := ut.fn_RemoveSpecialChars(l.AD_LINE3);
			self.AD_LINE4  	      := ut.fn_RemoveSpecialChars(l.AD_LINE4);
			self.AD_CITY  	      := ut.fn_RemoveSpecialChars(l.AD_CITY);
			self.AD_STATE  	      := ut.fn_RemoveSpecialChars(l.AD_STATE);
			self.AD_ZIP     	    := ut.fn_RemoveSpecialChars(l.AD_ZIP);
			self.AD_TELE  	      := ut.fn_RemoveSpecialChars(l.AD_TELE);
			self.AD_FAX	     			:= ut.fn_RemoveSpecialChars(l.AD_FAX);
			self.AD_E_MAIL  	   	:= ut.fn_RemoveSpecialChars(l.AD_E_MAIL);  
			self.TS_LAST_UPDT  	  := ut.fn_RemoveSpecialChars(l.TS_LAST_UPDT);
			self.ID_MAIL_LABEL_YR := ut.fn_RemoveSpecialChars(l.ID_MAIL_LABEL_YR);
			self.AD_COUNTRY  	    := ut.fn_RemoveSpecialChars(l.AD_COUNTRY);

		end;

		EXPORT ARCBusAddrOutFile	:= PROJECT(ARCBusAddr_raw, ARCBusAddrOutTransFixed(LEFT));
		
		Corp2_Raw_MD.Layouts.BusCommentLayout BusCommentOutTransFixed( Corp2_Raw_MD.Layouts.BusCommentIn l) := TRANSFORM

			self.ID_COMMENTS	:= ut.fn_RemoveSpecialChars(l.ID_COMMENTS);
			self.ID_SEQ_NUM		:= (integer)ut.fn_RemoveSpecialChars((string)l.ID_SEQ_NUM);
			self.TX_COMMENTS	:= ut.fn_RemoveSpecialChars(l.TX_COMMENTS);
			self.TS_LAST_UPDT	:= ut.fn_RemoveSpecialChars(l.TS_LAST_UPDT);

		end;

		EXPORT BusCommentOutFile	:= PROJECT(BusComment_raw, BusCommentOutTransFixed(LEFT));

		Corp2_Raw_MD.Layouts.BusEntityLayout BusEntityOutTransFixed(Corp2_Raw_MD.Layouts.BusEntityIn l) := TRANSFORM

			self.ID_BUS_PREFIX  			:= ut.fn_RemoveSpecialChars(l.ID_BUS_PREFIX);
			self.ID_BUS	   						:= ut.fn_RemoveSpecialChars(l.ID_BUS);
			self.TS_LAST_UPDT 	  		:= ut.fn_RemoveSpecialChars(l.TS_LAST_UPDT);
			self.ID_FIRST_FL_REQD 		:= ut.fn_RemoveSpecialChars(l.ID_FIRST_FL_REQD);
			self.CD_FED_BUS_TYPE			:= ut.fn_RemoveSpecialChars(l.CD_FED_BUS_TYPE);
			self.CD_ST_OF_FORMATION	  := ut.fn_RemoveSpecialChars(l.CD_ST_OF_FORMATION);
			self.TS_FORMATION         := ut.fn_RemoveSpecialChars(l.TS_FORMATION);
			self.CD_EXEMPT  	        := ut.fn_RemoveSpecialChars(l.CD_EXEMPT);
			self.CD_RETURN_TYPE  	    := ut.fn_RemoveSpecialChars(l.CD_RETURN_TYPE);
			self.CD_BUS_TYPE  	      := ut.fn_RemoveSpecialChars(l.CD_BUS_TYPE);
			self.CD_STATUS  	      	:= ut.fn_RemoveSpecialChars(l.CD_STATUS);
			self.DT_STAT_EFFECTIVE  	:= ut.fn_RemoveSpecialChars(l.DT_STAT_EFFECTIVE);
			self.FL_ARCHIVED					:= ut.fn_RemoveSpecialChars(l.FL_ARCHIVED);

		end;

		EXPORT BusEntityOutFile		:= PROJECT(BusEntity_raw,BusEntityOutTransFixed(LEFT));

		Corp2_Raw_MD.Layouts.EntityStatusLayout EntityStatusOutTransFixed(Corp2_Raw_MD.Layouts.EntityStatusIn l) := TRANSFORM

			self.CD_STATUS  			:= ut.fn_RemoveSpecialChars(l.CD_STATUS);
			self.TX_DESCRIPT   		:= ut.fn_RemoveSpecialChars(l.TX_DESCRIPT);
			self.FL_ACTIVE 	  		:= ut.fn_RemoveSpecialChars(l.FL_ACTIVE);

		end;

		EXPORT EntityStatusOutFile	:= PROJECT(EntityStatus_raw, EntityStatusOutTransFixed(LEFT));

		Corp2_Raw_MD.Layouts.BusTypeLayout BusTypeOutTransFixed(Corp2_Raw_MD.Layouts.BusTypeIn l) := TRANSFORM

			self.CD_BUS_TYPE  		:= ut.fn_RemoveSpecialChars(l.CD_BUS_TYPE);
			self.TX_DESCRIPT   		:= ut.fn_RemoveSpecialChars(l.TX_DESCRIPT);
			self.TS_LAST_UPDT 	  := ut.fn_RemoveSpecialChars(l.TS_LAST_UPDT);
			self.CD_FORM_NO   		:= ut.fn_RemoveSpecialChars(l.CD_FORM_NO);
			self.AM_FILING_FEE 	  := (udecimal)ut.fn_RemoveSpecialChars((string)l.AM_FILING_FEE);

		end;

		EXPORT BusTypeOutFile	:= PROJECT(BusType_raw, BusTypeOutTransFixed(LEFT));

		Corp2_Raw_MD.Layouts.BusNmIndxLayout BusNmIndxOutTransFixed(Corp2_Raw_MD.Layouts.BusNmIndxIn l) := TRANSFORM

			self.ID_BUS_PREFIX  	:=ut.fn_RemoveSpecialChars(l.ID_BUS_PREFIX);
			self.ID_BUS   				:=ut.fn_RemoveSpecialChars(l.ID_BUS);
			self.ID_NAME 	       	:=ut.fn_RemoveSpecialChars(l.ID_NAME);
			self.CD_NAME_TYPE     :=ut.fn_RemoveSpecialChars(l.CD_NAME_TYPE);
			self.TS_EFFECTIVE 	  :=ut.fn_RemoveSpecialChars(l.TS_EFFECTIVE);
			self.TS_END  					:=ut.fn_RemoveSpecialChars(l.TS_END);
			self.NM_NAME   				:=ut.fn_RemoveSpecialChars(l.NM_NAME);
			self.NM_SEARCH 	  		:=ut.fn_RemoveSpecialChars(l.NM_SEARCH); 
			self.NM_COMPRESSED   	:=ut.fn_RemoveSpecialChars(l.NM_COMPRESSED); 
			self.TS_LAST_UPDT   	:=ut.fn_RemoveSpecialChars(l.TS_LAST_UPDT);

		end;

		EXPORT BusNmIndxOutFile	:= PROJECT(BusNmIndx_raw, BusNmIndxOutTransFixed(LEFT));

		Corp2_Raw_MD.Layouts.BusNmIndxLayout ARCBusNmIndxOutTransFixed(Corp2_Raw_MD.Layouts.BusNmIndxIn l) := TRANSFORM

			self.ID_BUS_PREFIX  	:=ut.fn_RemoveSpecialChars(l.ID_BUS_PREFIX);
			self.ID_BUS   				:=ut.fn_RemoveSpecialChars(l.ID_BUS);
			self.ID_NAME 	       	:=ut.fn_RemoveSpecialChars(l.ID_NAME);
			self.CD_NAME_TYPE     :=ut.fn_RemoveSpecialChars(l.CD_NAME_TYPE);
			self.TS_EFFECTIVE 	  :=ut.fn_RemoveSpecialChars(l.TS_EFFECTIVE);
			self.TS_END  					:=ut.fn_RemoveSpecialChars(l.TS_END);
			self.NM_NAME   				:=ut.fn_RemoveSpecialChars(l.NM_NAME);
			self.NM_SEARCH 	  		:=ut.fn_RemoveSpecialChars(l.NM_SEARCH); 
			self.NM_COMPRESSED   	:=ut.fn_RemoveSpecialChars(l.NM_COMPRESSED); 
			self.TS_LAST_UPDT   	:=ut.fn_RemoveSpecialChars(l.TS_LAST_UPDT);

		end;

		EXPORT ARCBusNmIndxOutFile	:= PROJECT(ARCBusNmIndx_raw, ARCBusNmIndxOutTransFixed(LEFT));

		Corp2_Raw_MD.Layouts.TradeNameLayout TradeNameOutTransFixed(Corp2_Raw_MD.Layouts.TradeNameIn l) := TRANSFORM

			self.DT_REGISTRATION  :=ut.fn_RemoveSpecialChars(l.DT_REGISTRATION);
			self.DT_RENEWAL_NOTICE:=ut.fn_RemoveSpecialChars(l.DT_RENEWAL_NOTICE);
			self.DT_EXPIRATION 	  :=ut.fn_RemoveSpecialChars(l.DT_EXPIRATION);
			self.DT_CANCELLED 	  :=ut.fn_RemoveSpecialChars(l.DT_CANCELLED);
			self.TS_LAST_UPDT 	  :=ut.fn_RemoveSpecialChars(l.TS_LAST_UPDT);
			self.ID_BUS_PREFIX  	:=ut.fn_RemoveSpecialChars(l.ID_BUS_PREFIX);
			self.ID_BUS	  				:=ut.fn_RemoveSpecialChars(l.ID_BUS);	

		end;

		EXPORT TradeNameOutFile	:= PROJECT(TradeName_raw, TradeNameOutTransFixed(LEFT));

		Corp2_Raw_MD.Layouts.FilingTypeLayout FilingTypeOutTransFixed(Corp2_Raw_MD.Layouts.FilingTypeIn l) := TRANSFORM

			self.cd_filing_type  :=ut.fn_RemoveSpecialChars(l.cd_filing_type);
			self.tx_filing_type  :=ut.fn_RemoveSpecialChars(l.tx_filing_type);

		end;

		EXPORT FilingTypeOutFile	:= PROJECT(FilingType_raw, FilingTypeOutTransFixed(LEFT));

	END;
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.AmendHist,		Corp2_Raw_MD.Layouts.AmendHistLayoutBase, 	 AmendHist);
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.ARCAmendHist, Corp2_Raw_MD.Layouts.AmendHistLayoutBase, 	 ARCAmendHist);
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.BusAddr, 		  Corp2_Raw_MD.Layouts.BusAddrLayoutBase, 		 BusAddr);
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.ARCBusAddr, 	Corp2_Raw_MD.Layouts.BusAddrLayoutBase, 		 ARCBusAddr);
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.BusEntity,    Corp2_Raw_MD.Layouts.BusEntityLayoutBase, 	 BusEntity);
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.BusNmIndx,    Corp2_Raw_MD.Layouts.BusNmIndxLayoutBase, 	 BusNmIndx);
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.ARCBusNmIndx, Corp2_Raw_MD.Layouts.BusNmIndxLayoutBase,    ARCBusNmIndx);
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.BusType, 		  Corp2_Raw_MD.Layouts.BusTypeLayoutBase,  	   BusType);	
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.BusComment,   Corp2_Raw_MD.Layouts.BusCommentLayoutBase,   BusComment);
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.EntityStatus, Corp2_Raw_MD.Layouts.EntityStatusLayoutBase, EntityStatus);
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.FilingType,   Corp2_Raw_MD.Layouts.FilingTypeLayoutBase, 	 FilingType);	
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.TradeName, 		Corp2_Raw_MD.Layouts.TradeNameLayoutBase, 	 TradeName);
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.FilmIndx, 	  Corp2_Raw_MD.Layouts.FilmIndxLayoutBase, 		 FilmIndx);
		tools.mac_FilesBase(Corp2_Raw_MD.Filenames(pversion, pUseOtherEnvironment).Base.ReserveName,  Corp2_Raw_MD.Layouts.ReserveNameLayoutBase,  ReserveName);	
			
		
	END;

END;