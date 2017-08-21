EXPORT Layouts := module

	export AmendHistIn :=RECORD

		EBCDIC STRING154 AmendHistStr;

	END;

	export AmendHistLayoutBase :=RECORD

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		AmendHistIn;

	END;

	EXPORT AmendHistOut := RECORD, MAXLENGTH(680)

		STRING AmendHistStr;

	END;

	EXPORT ARCAmendHistOut := RECORD, MAXLENGTH(680)

		STRING ARCAmendHistStr;

	END;

	export FilmIndxIn :=RECORD

		EBCDIC STRING65 FilmIndxStr;

	END;
	
	export FilmIndxLayoutBase :=RECORD

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;     
		FilmIndxIn;

	END;
	
	EXPORT FilmIndxOut := RECORD, MAXLENGTH(680)

		STRING FilmIndxStr;

	END;

	export ReserveNameIn :=RECORD

		EBCDIC STRING79 ReserveNameStr;

	END;

	export ReserveNameLayoutBase :=RECORD

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		ReserveNameIn;

	END;

	EXPORT ReserveNameOut := RECORD, MAXLENGTH(680)

		STRING ReserveNameStr;

	END;

	export BusCommentIn:=record

		ebcdic string8 ID_COMMENTS;
		integer2 ID_SEQ_NUM;
		integer2 junk1;
		ebcdic string1024 TX_COMMENTS;
		ebcdic string26 TS_LAST_UPDT;

	end;

	export BusCommentLayoutBase:=record

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		BusCommentIn;

	end;

	export FilingTypeIn:=record

		ebcdic string8 CD_FILING_TYPE;
		ebcdic string60 TX_FILING_TYPE;

	end;

	export FilingTypeLayoutBase:=record

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		FilingTypeIn;
		
	end;

	export BusTypeIn:=record

		ebcdic string2 CD_BUS_TYPE;
		integer2 junk;
		ebcdic string40 TX_DESCRIPT;
		ebcdic string26 TS_LAST_UPDT;
		ebcdic string3 CD_FORM_NO;
		decimal7 AM_FILING_FEE;

	end;

	export BusTypeLayoutBase:=record

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		BusTypeIn;

	end;

	export BusAddrIn:= record

		ebcdic string1  ID_BUS_PREFIX;
		ebcdic string16 ID_BUS;
		ebcdic string16 ID_ADDRESS;
		ebcdic string1  CD_ADDRESS_TYPE;
		ebcdic string26 TS_EFFECTIVE;
		integer2        junk12;
		ebcdic string27 TS_END;
		ebcdic string251 NM_NAME;
		integer1        junk3;
		ebcdic string40 AD_LINE1;
		integer2        junk4;
		ebcdic string40 AD_LINE2;
		integer2        junk5;
		ebcdic string40 AD_LINE3;
		integer2        junk6;
		ebcdic string40 AD_LINE4;
		integer2        junk7;
		ebcdic string40 AD_CITY;
		ebcdic string2  AD_STATE;
		ebcdic string9  AD_ZIP;
		integer2        junk8;
		ebcdic string16 AD_TELE;
		integer2        junk9;
		ebcdic string16 AD_FAX;
		integer2        junk10;
		ebcdic string28 AD_E_MAIL;  
		ebcdic string26 TS_LAST_UPDT;
		ebcdic string4  ID_MAIL_LABEL_YR;
		integer2        junk11;   
		ebcdic string40 AD_COUNTRY;

	end;

	export BusAddrLayoutBase:= record

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		BusAddrIn;

	end;

	export BusNmIndxIn:=record

		ebcdic string1   ID_BUS_PREFIX;
		ebcdic string16  ID_BUS;
		ebcdic string16  ID_NAME;
		ebcdic string2   CD_NAME_TYPE;
		ebcdic string26  TS_EFFECTIVE;
		ebcdic string26  TS_END;
		ebcdic string1   filler3;
		integer2         junk1;
		ebcdic string250 NM_NAME;
		integer2         junk2;
		ebcdic string100 NM_SEARCH;
		integer2         junk3;
		ebcdic string150 NM_COMPRESSED;
		ebcdic string26  TS_LAST_UPDT;

	end;

	export BusNmIndxLayoutBase:=record

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		BusNmIndxIn;

	end;

	export TradeNameIn:=record

		ebcdic string10 DT_REGISTRATION;
		ebcdic string10 DT_RENEWAL_NOTICE;
		ebcdic string1  junk1;
		ebcdic string10 DT_EXPIRATION;
		ebcdic string1  junk2;
		ebcdic string10 DT_CANCELLED;
		ebcdic string1  junk3;
		ebcdic string26 TS_LAST_UPDT;
		ebcdic string1  ID_BUS_PREFIX;
		ebcdic string16 ID_BUS;

	end;

	export TradeNameLayoutBase:=record

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		TradeNameIn;

	end;

	export BusEntityIn:=record 

		ebcdic string1  ID_BUS_PREFIX;
		ebcdic string16 ID_BUS;
		ebcdic string26 TS_LAST_UPDT;
		ebcdic string4  ID_FIRST_FL_REQD;
		ebcdic string6  CD_FED_BUS_TYPE;
		ebcdic string2  CD_ST_OF_FORMATION;
		ebcdic string26 TS_FORMATION;
		ebcdic string1  junk;
		ebcdic string3  CD_EXEMPT;
		ebcdic string1  CD_RETURN_TYPE;
		ebcdic string2  CD_BUS_TYPE;
		ebcdic string1  CD_STATUS;
		ebcdic string10 DT_STAT_EFFECTIVE;
		ebcdic string1  filer;
		ebcdic string1  FL_ARCHIVED;  //flag that idicates where to use archive files

	end;

	export BusEntityLayoutBase:=record 

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		BusEntityIn;

	end;

	export EntityStatusIn:=record

		ebcdic string1 CD_STATUS;
		integer2 junk1;
		ebcdic string50 TX_DESCRIPT;
		ebcdic string1  FL_ACTIVE;

	end;

	export EntityStatusLayoutBase:=record

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		EntityStatusIn;	

	end;

	export AmendHistLayout := record

		string1 	id_Bus_Prefix;
		string16 	ID_BUS;
		string8		cdFilingType;
		string26	tsBusEffective;
		string1		flStock;
		string1		flClose;
		string8		idComments;
		string26	tsLastUpdt;
		string26	tsEffective;
		string16	idFlngNbr;
		string1		cdStatus;
		string2		cdBusType;
		string8		cdFormationType;
		string1		FlChgRA;
		string1		FlChgRAAddr;
		string1		FlChgPO;
		string10	dtStatEffective;

	end;

	export FilmIndxLayout := record

		string16	idFlngNbr;
		string5		cdVolume;
		string4		cdStartPage;

	end;

	export ReserveNameLayout := record

		string10 		DT_EXPIRATION;
		string26 		TS_EFFECTIVE;
		string26 		TS_LAST_UPDT;
		string1 		ID_BUS_PREFIX;
		string16 		ID_BUS;

	end;

	export BusAddrLayout := RECORD

		string1 	ID_BUS_PREFIX;
		string16 	ID_BUS;
		string16 	ID_ADDRESS;
		string1	  CD_ADDRESS_TYPE;
		string26 	TS_EFFECTIVE;
		string27 	TS_END;
		string251 NM_NAME;
		string40 	AD_LINE1;
		string40 	AD_LINE2;
		string40 	AD_LINE3;
		string40 	AD_LINE4;
		string40 	AD_CITY;
		string2 	AD_STATE;
		string9 	AD_ZIP;
		string16 	AD_TELE;
		string16 	AD_FAX;
		string28 	AD_E_MAIL;  
		string26 	TS_LAST_UPDT;
		string4 	ID_MAIL_LABEL_YR;
		string40 	AD_COUNTRY;

	end;

	export BusCommentLayout := RECORD

		string8 	 ID_COMMENTS;
		integer2 	 ID_SEQ_NUM;
		string1024 TX_COMMENTS;
		string26 	 TS_LAST_UPDT;

	end;

	export BusEntityLayout := RECORD

		string1 	ID_BUS_PREFIX;
		string16 	ID_BUS;
		string26 	TS_LAST_UPDT;
		string4 	ID_FIRST_FL_REQD;
		string6 	CD_FED_BUS_TYPE;
		string2 	CD_ST_OF_FORMATION;
		string26 	TS_FORMATION;
		string3 	CD_EXEMPT;
		string1 	CD_RETURN_TYPE;
		string2 	CD_BUS_TYPE;
		string1 	CD_STATUS;
		string10 	DT_STAT_EFFECTIVE;
		string1	  FL_ARCHIVED;

	end;

	export EntityStatusLayout := RECORD

		string1 	CD_STATUS;
		string50 	TX_DESCRIPT;
		string1 	FL_ACTIVE;

	end;

	export BusTypeLayout := RECORD

		string2 		CD_BUS_TYPE;
		string40 		TX_DESCRIPT;
		string26 		TS_LAST_UPDT;
		string3 		CD_FORM_NO;
		udecimal7 	AM_FILING_FEE;

	end;

	export BusNmIndxLayout := RECORD

		string1   ID_BUS_PREFIX;
		string16  ID_BUS;
		string16  ID_NAME;
		string2 	CD_NAME_TYPE;		 
		string26  TS_EFFECTIVE;
		string26  TS_END;
		string250 NM_NAME;
		string100 NM_SEARCH;
		string150 NM_COMPRESSED;
		string26  TS_LAST_UPDT;

	end;

	export TradeNameLayout := RECORD

		string10 DT_REGISTRATION;
		string10 DT_RENEWAL_NOTICE;
		string10 DT_EXPIRATION;
		string10 DT_CANCELLED;
		string26 TS_LAST_UPDT;
		string1  ID_BUS_PREFIX;
		string16 ID_BUS;

	end;

	export FilingTypeLayout := RECORD

		string8  CD_FILING_TYPE;
		string60 TX_FILING_TYPE;

	end;

	export Temp_EntityWithLookups := record

		BusEntityLayout;
		string50 statusDesc;
		string40 BusTypeDesc;

	end;	

	export Temp_EntityWithName := record

		Temp_EntityWithLookups;
		BusNmIndxLayout - ID_BUS_PREFIX-ID_BUS-TS_LAST_UPDT;
		string26  Nm_TS_EFFECTIVE;
		string26  Nm_TS_END;
		

	end;
  
	export Temp_EntityWithName_trade := record

		Temp_EntityWithName;
		TradeNameLayout -ID_BUS_PREFIX-ID_BUS;

	end;
	
 	export Temp_EntityNameTrade_Addr := record
   
   		Temp_EntityWithName_trade;
   		BusAddrLayout -ID_BUS_PREFIX-ID_BUS;
   		string250 Addr_name;
			string26  Addr_TS_EFFECTIVE;
			string26  Addr_TS_End;
   
  END;

  export Temp_EntityNameTrade_AddrReserve := record
   
   		Temp_EntityNameTrade_Addr;  
   		ReserveNameLayout-ID_BUS_PREFIX-ID_BUS;
   
  end;
	
  export Temp_ContNameAddr := record
   
		string1 	ID_BUS_PREFIX;
		string16 	ID_BUS;
		string16 	ID_ADDRESS;
		string1	  CD_ADDRESS_TYPE;
		string26 	TS_EFFECTIVE;
		string251 NM_NAME;
		string251 Addr_NAME;
		string2 	CD_NAME_TYPE;
		string40 	AD_LINE1;
		string40 	AD_LINE2;
		string40 	AD_LINE3;
		string40 	AD_LINE4;
		string40 	AD_CITY;
		string2 	AD_STATE;
		string9 	AD_ZIP;
   
  end;
	
	export Temp_EntityWithAmend  := record

		BusEntityLayout;
		AmendHistLayout-ID_BUS_PREFIX-ID_BUS;

	End;

	export Temp_AmendHistWithFilingDesc:=record

		Temp_EntityWithAmend;
		string	FilingDesc;

	end;

	export Temp_AmendWithComment := record

		Temp_AmendHistWithFilingDesc;
		BusCommentLayout;

	end;

	export Temp_AmendCommentWithFilmIndx:= record

		Temp_AmendWithComment;
		FilmIndxLayout;

	end;
	
end;