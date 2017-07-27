import Corp2, _validate, Address, lib_stringlib, _control, versioncontrol;

export MD := MODULE;
	
	export Layouts_Raw_Input := MODULE;

		export BusAddrLayout := record
			string2 	state_origin;
			string8 	process_date;
			// string1 	ID_BUS_PREFIX;
			string17 	ID_Key;
			string16 	ID_ADDRESS;
			string1 	CD_ADDRESS_TYPE;
			string8 	TS_EFFECTIVE;
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
			string64 	AD_E_MAIL;   
			string8 	TS_LAST_UPDT;
			string4 	ID_MAIL_LABEL_YR;
			string40 	AD_COUNTRY;
			string182 clean_business_address;
			string73 	pname;
			integer2 	is_company_flag;
			string250 cname;
		end;
		
		export AmendHistIn :=RECORD
			EBCDIC STRING154 AmendHistStr;
		END;
		
		export BusNmIndxLayout := record
			string2		state_origin;
			string8		process_date;
			// string1		ID_BUS_PREFIX;
			string17	ID_Key;
			string16	ID_NAME;
			string2		CD_NAME_TYPE;
			string8		TS_EFFECTIVE;
			string8		TS_END;
			string250 NM_NAME;
			string100 NM_SEARCH;
			string150 NM_COMPRESSED;
			string8		TS_LAST_UPDT;
			string73	pname;
			integer2	is_company_flag;
			string250	cname;
		end;
		
		export BusTypeLayout := record
			string2 	CD_BUS_TYPE;
			integer2 	junk;
			string40 	TX_DESCRIPT;
			string26 	TS_LAST_UPDT;
			string3 	CD_FORM_NO;
			udecimal7 AM_FILING_FEE;
		end;
		
		export BusCommentLayout := record
			string8 		ID_COMMENTS;
			integer2 		ID_SEQ_NUM;
			integer2 		junk1;
			string1024 	TX_COMMENTS;
			string26 		TS_LAST_UPDT;
		end;
		
		export FilingTypeLayout := record
			string8 		CD_FILING_TYPE;
			string60 		TX_FILING_TYPE;
		end;

		export FilmIndxIn :=RECORD
			EBCDIC STRING65 FilmIndxStr;
		END;
		
		export BusEntityLayout :=record
			// string1 		ID_BUS_PREFIX;
			string17 		ID_Key;
			string26 		TS_LAST_UPDT;
			string4 		ID_FIRST_FL_REQD;
			string6 		CD_FED_BUS_TYPE;
			string2 		CD_ST_OF_FORMATION;
			string26 		TS_FORMATION;
			string3 		CD_EXEMPT;
			string1 		CD_RETURN_TYPE;
			string2 		CD_BUS_TYPE;
			string1 		CD_STATUS;
			string10 		DT_STAT_EFFECTIVE;
		end;

		export EntityStatusLayout := record
			string1 		CD_STATUS;
			integer2 		junk1;
			string50 		TX_DESCRIPT;
			string1 		FL_ACTIVE;
		end;
		
		export ReserveNameIn :=RECORD
			EBCDIC STRING79 ReserveNameStr;
		END;
	
		export TradeNameLayout := record
			string10 		DT_REGISTRATION;
			string10 		DT_RENEWAL_NOTICE;
			string10 		DT_EXPIRATION;
			string10 		DT_CANCELLED;
			string26 		TS_LAST_UPDT;
			// string1 		ID_BUS_PREFIX;
			string17 		ID_Key;
		end;
		
	end; 
	
	export Files_Raw_Input := MODULE;
		export AmendHistFile(string filedate)			:= Dataset('~thor_data400::in::corp2::'+fileDate+'::AmendHist::md', Layouts_Raw_Input.AmendHistIn, flat);
		export BusAddrFile(string filedate)				:= Dataset('~thor_data400::in::corp2::'+fileDate+'::BusAddr_clean::md', Layouts_Raw_Input.BusAddrLayout, flat);
		export BusNmIndxFile(string filedate)			:= Dataset('~thor_data400::in::corp2::'+fileDate+'::BusNmIndx_clean::md', Layouts_Raw_Input.BusNmIndxLayout, flat);		
		export BusTypeFile(string filedate)				:= Dataset('~thor_data400::in::corp2::'+fileDate+'::BusType_clean::md', Layouts_Raw_Input.BusTypeLayout, flat);	
		export BusCommentFile(string filedate)		:= Dataset('~thor_data400::in::corp2::'+fileDate+'::BusComment_clean::md', Layouts_Raw_Input.BusCommentLayout, flat);	
		export FilingTypeFile(string filedate)		:= Dataset('~thor_data400::in::corp2::'+fileDate+'::FilingType_clean::md', Layouts_Raw_Input.FilingTypeLayout, flat);	
		export FilmIndxFile(string filedate)			:= Dataset('~thor_data400::in::corp2::'+fileDate+'::FilmIndx::md', Layouts_Raw_Input.FilmIndxIn, flat);	
		export BusEntityFile(string filedate)			:= Dataset('~thor_data400::in::corp2::'+fileDate+'::BusEntity::md', Layouts_Raw_Input.BusEntityLayout, flat);
		export EntityStatusFile(string filedate)	:= Dataset('~thor_data400::in::corp2::'+fileDate+'::EntityStatus::md', Layouts_Raw_Input.EntityStatusLayout, flat);
		export ReserveNameFile(string filedate)		:= Dataset('~thor_data400::in::corp2::'+fileDate+'::ReserveName::md', Layouts_Raw_Input.ReserveNameIn, flat);		
		export TradeNameFile(string filedate)			:= Dataset('~thor_data400::in::corp2::'+fileDate+'::TradeName::md', Layouts_Raw_Input.TradeNameLayout, flat);				
	end;
		

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
		reformatDate(string inDate) := function
			string8 clean_inDate := trim(regexreplace('-',inDate,''),left,right);
			return clean_inDate;	
		end;	
		
				
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;

		AmendHistLayout := record
			// string1 	idBusPrefix;
			string17 	idKey;
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
	
		AmendHistOut := RECORD, MAXLENGTH(680)
			STRING AmendHistStr;
		END;
	
		AmendHistOut  AmendHistTrans ( Layouts_Raw_Input.AmendHistIn L) := TRANSFORM
			SELF.AmendHistStr := L.AmendHistStr[1..length((>varstring153<)L.AmendHistStr)];
		END;

		AmendHistLayout AmendHistTransFixed( AmendHistOut l) := TRANSFORM
				// self.idBusPrefix		:= l.AmendHistStr[1..1];
				self.idKey					:= l.AmendHistStr[1..17];
				self.cdFilingType		:= l.AmendHistStr[18..25];
				self.tsBusEffective	:= l.AmendHistStr[26..51];
				self.flStock				:= l.AmendHistStr[52..52];
				self.flClose				:= l.AmendHistStr[53..53];
				self.idComments			:= l.AmendHistStr[54..61];
				self.tsLastUpdt			:= l.AmendHistStr[62..87];
				self.tsEffective		:= l.AmendHistStr[88..113];
				self.idFlngNbr			:= l.AmendHistStr[114..129];
				self.cdStatus				:= l.AmendHistStr[130..130];
				self.cdBusType			:= l.AmendHistStr[131..132];
				self.cdFormationType:= l.AmendHistStr[133..140];
				self.FlChgRA				:= l.AmendHistStr[141..141];
				self.FlChgRAAddr		:= l.AmendHistStr[142..142];
				self.FlChgPO				:= l.AmendHistStr[143..143];
				self.dtStatEffective:= l.AmendHistStr[144..153];
		end;

		Amendout	:= PROJECT( Files_Raw_Input.AmendHistFile(fileDate),  AmendHistTrans(LEFT));  
		AmendFile	:= PROJECT( Amendout, AmendHistTransFixed(LEFT));
		
		FilmIndxLayout := record
			string16	idFlngNbr;
			string5		cdVolume;
			string4		cdStartPage;
		end;
	
		FilmIndxOut := RECORD, MAXLENGTH(680)
			STRING FilmIndxStr;
		END;
	
		FilmIndxOut  FilmIndxTrans ( Layouts_Raw_Input.FilmIndxIn L) := TRANSFORM
			SELF.FilmIndxStr := L.FilmIndxStr[1..length((>varstring64<)L.FilmIndxStr)];
		END;

		FilmIndxLayout FilmIndxTransFixed( FilmIndxOut l) := TRANSFORM
				self.idFlngNbr			:= l.FilmIndxStr[1..16];
				self.cdVolume				:= l.FilmIndxStr[18..22];
				self.cdStartPage		:= l.FilmIndxStr[23..26];
		end;

		FilmIndexout		:= PROJECT( Files_Raw_Input.FilmIndxFile(fileDate),  FilmIndxTrans(LEFT));  
		FilmIndxFile		:= PROJECT( FilmIndexout, FilmIndxTransFixed(LEFT));
		
		ReserveNameLayout := record
			string10 		DT_EXPIRATION;
			string26 		TS_EFFECTIVE;
			string26 		TS_LAST_UPDT;
			// string1 		ID_BUS_PREFIX;
			string17 		ID_Key;
		end;
	
		ReserveNameOut := RECORD, MAXLENGTH(680)
			STRING ReserveNameStr;
		END;
	
		ReserveNameOut  ReserveNameTrans ( Layouts_Raw_Input.ReserveNameIn L) := TRANSFORM
			SELF.ReserveNameStr := L.ReserveNameStr[1..length((>varstring78<)L.ReserveNameStr)];
		END;

		ReserveNameLayout ReserveNameTransFixed( ReserveNameOut l) := TRANSFORM
				self.DT_EXPIRATION	:= l.ReserveNameStr[1..10];
				self.TS_EFFECTIVE		:= l.ReserveNameStr[11..36];
				self.TS_LAST_UPDT		:= l.ReserveNameStr[37..62];
				// self.ID_BUS_PREFIX	:= l.ReserveNameStr[63..63];
				self.ID_Key					:= l.ReserveNameStr[63..79];
		end;

		ReserveNmout		:= PROJECT( Files_Raw_Input.ReserveNameFile(fileDate),  ReserveNameTrans(LEFT));  
		ReserveNameFile	:= PROJECT( ReserveNmout, ReserveNameTransFixed(LEFT));	
		
		PopAmendLookups	:= record
			string17 	idKey;
			string8		cdFilingType;
			string26	tsBusEffective;	
			string8		idComments;		
			string16	idFlngNbr;
			string60	FilingDesc;
		end;
		
		AmendWithComment := record
			PopAmendLookups;
			string1024 	TX_COMMENTS;
		end;	
		
		AmendWithFilmIndx := record
			AmendWithComment;
			string5		cdVolume;
			string4		cdStartPage;
		end;				
		
		PopBusEntityLookups := record
			layouts_raw_input.BusEntityLayout;
			string50 statusDesc;
			string40 BusTypeDesc;
		end;	
		
		EntityWithName := record
			PopBusEntityLookups;
			string2		CD_NAME_TYPE;
			string250 NM_NAME;
		end;

		EntityWithRAAddr := record
			EntityWithName;
			string251 AGT_NM_NAME;
			string40 	AGT_AD_LINE1;
			string40 	AGT_AD_LINE2;
			string40 	AGT_AD_LINE3;
			string40 	AGT_AD_LINE4;
			string40 	AGT_AD_CITY;
			string2 	AGT_AD_STATE;
			string9 	AGT_AD_ZIP;
		END;
			
		EntityWithAddr := record
			EntityWithRAAddr;
			string40 	AD_LINE1;
			string40 	AD_LINE2;
			string40 	AD_LINE3;
			string40 	AD_LINE4;
			string40 	AD_CITY;
			string2 	AD_STATE;
			string9 	AD_ZIP;
			string40 	AD_COUNTRY;
			string1	  CD_ADDRESS_TYPE;
		END;

		NmIndxWithRes := record
			string10 		DT_EXPIRATION;
			EntityWithAddr;
		end;
		
		NmIndxWithTrade := record
			string10 		DT_REGISTRATION;
			string10 		DT_EXPIRATION;
			string10 		DT_CANCELLED;
			EntityWithAddr;
		end;
		
		corp2_mapping.Layout_CorpPreClean corpMasterTransform(EntityWithAddr input) := transform,skip(
																																																	trimUpper(input.ID_Key[1..1]) = 'R' or
																																																	trimUpper(input.ID_Key[1..1]) = 'T'
																																																	)

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '24-' + trimUpper(input.ID_Key);
				self.corp_vendor								:= '24';
				self.corp_state_origin					:= 'MD';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.ID_Key);
				self.corp_src_type							:= 'SOS';	
				
				self.corp_legal_name						:= if (trim(input.nm_Name,left,right)<>'',
																								trimUpper(input.nm_Name),
																								''
																							); 
				cleanNameType										:= trimUpper(input.CD_NAME_TYPE);
				
        self.corp_ln_name_type_cd				:= map(	cleanNameType = 'CR' => '01',
																								cleanNameType = 'GP' => '01',
																								cleanNameType = 'LC' => '01',
																								cleanNameType = 'LL' => '01',
																								cleanNameType = 'LP' => '01',
																								cleanNameType = 'OT' => '01',
																								cleanNameType = 'OU' => '01',
																								cleanNameType = 'OX' => '04',
																								cleanNameType = 'RG' => '09',
																								cleanNameType = 'RV' => '07',
																								cleanNameType = 'TA' => '04',
																								cleanNameType = 'TX' => '04',
																								cleanNameType = 'UN' => '01',
																								''
																							 );
																							 
        self.corp_ln_name_type_DESC			:= map(	cleanNameType = 'CR' => 'LEGAL',
																								cleanNameType = 'GP' => 'LEGAL',
																								cleanNameType = 'LC' => 'LEGAL',
																								cleanNameType = 'LL' => 'LEGAL',
																								cleanNameType = 'LP' => 'LEGAL',
																								cleanNameType = 'OT' => 'LEGAL',
																								cleanNameType = 'OU' => 'LEGAL',
																								cleanNameType = 'OX' => 'TRADENAME',
																								cleanNameType = 'RG' => 'REGISTERED',
																								cleanNameType = 'RV' => 'RESERVED',
																								cleanNameType = 'TA' => 'TRADENAME',
																								cleanNameType = 'TX' => 'TRADENAME',
																								cleanNameType = 'UN' => 'LEGAL',
																								''
																							 );																							 
																								

				cleanType												:= trimUpper(input.CD_BUS_TYPE);
				typeDesc												:= trimUpper(input.BusTypeDesc);	
				
				self.corp_orig_bus_type_cd			:= if (	trim(typeDesc,left,right)<>'',
																									cleanType,
																									''
																							);
				self.corp_orig_bus_type_desc		:=	typeDesc;
				
				cleanBusPrefix									:= trimUpper(input.ID_Key[1..1]);
				
				self.corp_orig_org_structure_cd	:= cleanBusPrefix;
				self.corp_orig_org_structure_desc	:= map(	cleanBusPrefix = 'A' => 'DOMESTIC LIMITED LIABILITY PARTNERSHIP',
																									cleanBusPrefix = 'B' => 'BUSINESS TRUST',
																									cleanBusPrefix = 'C' => 'GENERAL PARTNERSHIP',
																									cleanBusPrefix = 'D' => 'DOMESTIC CORPORATION',
																									cleanBusPrefix = 'E' => 'FOREIGN LIMITED LIABILITY PARTNERSHIP',
																									cleanBusPrefix = 'F' => 'FOREIGN CORPORATION',
																									cleanBusPrefix = 'L' => 'UNINCORPORATED ENTITY',
																									cleanBusPrefix = 'M' => 'DOMESTIC LIMITED PARTNERSHIP OR DOMESTIC LIMITED LIABILITY PARTNERSHIP',
																									cleanBusPrefix = 'P' => 'FOREIGN LIMITED PARTNERSHIP OR FOREIGN LIMITED LIABILITY PARTNERSHIP',
																									cleanBusPrefix = 'R' => 'REGISTERED NAME',
																									cleanBusPrefix = 'T' => 'TRADE NAME',
																									cleanBusPrefix = 'U' => 'UNCLASSIFIED ENTITY',
																									cleanBusPrefix = 'V' => 'RESERVED NAME',
																									cleanBusPrefix = 'W' => 'DOMESTIC LIMITED LIABILITY COMPANY',
																									cleanBusPrefix = 'Z' => 'FOREIGN LIMITED LIABILITY COMPANY',
																									''
																								);
																									
					
				cleanStatus											:= trimUpper(input.cd_Status);
				statusDesc											:= trimUpper(input.StatusDesc); 

				self.corp_status_desc						:= statusDesc; 

				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
																							
				cleanStatusDate									:= reformatDate(input.dt_stat_effective);

				self.corp_status_date						:= if(	_validate.date.fIsValid(cleanStatusDate),
																									cleanStatusDate,
																									''
																							);	
				
				cleanIncDate										:= reformatDate(input.TS_FORMATION[1..10]);
				
        self.corp_inc_date							:= if ((trimUpper(input.CD_ST_OF_FORMATION) = 'MD' or 
																								trimUpper(input.CD_ST_OF_FORMATION) = '') and
																								_validate.date.fIsValid(cleanIncDate),
																									cleanIncDate,
																									''
																							 );
																							 
        self.corp_forgn_date						:= if (	trimUpper(input.CD_ST_OF_FORMATION) <> 'MD' and 
																								trimUpper(input.CD_ST_OF_FORMATION) <> '' and
																								_validate.date.fIsValid(cleanIncDate),
																									cleanIncDate,
																									''
																							 );																							 
																							 																							 
        self.corp_inc_state							:= if (	trimUpper(input.CD_ST_OF_FORMATION) = 'MD' or 
																								trimUpper(input.CD_ST_OF_FORMATION) = '',
																									'MD',
																									''
																							 );	
																							 
        self.corp_forgn_state_cd				:= if (	trimUpper(input.CD_ST_OF_FORMATION) <> 'MD' and 
																								trimUpper(input.CD_ST_OF_FORMATION) <> '',
																									trimUpper(input.CD_ST_OF_FORMATION),
																									''
																							 );	
																							 
        self.corp_forgn_state_desc			:= if (	trimUpper(input.CD_ST_OF_FORMATION) <> 'MD' and 
																								trimUpper(input.CD_ST_OF_FORMATION) <> '',
																									corp2_mapping.Functions.Decode_state(trimUpper(input.CD_ST_OF_FORMATION)),
																									''
																							 );																								 

				self.corp_address1_line1				:= trimUpper(input.ad_line2);
				self.corp_address1_line2				:= trimUpper(input.ad_line3);
				self.corp_address1_line3				:= trimUpper(input.ad_line4);
				self.corp_address1_line5				:= if(trimUpper(input.AD_CITY) <> '',
																							if(trimUpper(input.AD_STATE) <> '',
																									if ((string)(integer)input.AD_ZIP<>'0',
																												trim(	trimUpper(input.AD_CITY) + ', ' + 
																															trimUpper(input.AD_STATE) + ' ' + 
																															trimUpper(input.AD_ZIP),
																															left,right
																														),
																												trim(	trimUpper(input.AD_CITY) + ', ' + 
																															trimUpper(input.AD_STATE),left,right)
																											),
																									trimUpper(input.AD_CITY)
																								),
																							''
																							);
        self.corp_address1_line6				:= if(	trimUpper(input.ad_Country) <> 'USA' and
																								trimUpper(input.ad_Country) <> 'UNITED STATES',
																									trimUpper(input.ad_Country),
																									''
																							);
				cleanAddrType										:= trimUpper(input.CD_ADDRESS_TYPE);																	
				self.corp_address1_type_cd			:= map(	cleanAddrType = 'P' => 'B',
																								cleanAddrType = 'A' => 'B',
																								cleanAddrType = 'F' => 'F',
																								cleanAddrType = 'T' => 'B',
																								''
																							 );
																							 
				self.corp_address1_type_desc		:= map(	cleanAddrType = 'P' => 'BUSINESS',
																								cleanAddrType = 'A' => 'BUSINESS',
																								cleanAddrType = 'F' => 'FILING',
																								cleanAddrType = 'T' => 'BUSINESS',
																								''
																							 );

				self.corp_ra_title_desc					:= if(trimUpper(input.AGT_NM_NAME)<>'',
																								'REGISTERED OFFICE',
																								''
																							);
				self.corp_ra_name								:= trimUpper(input.AGT_NM_NAME);
				self.corp_ra_address_line1 			:= trimUpper(input.AGT_AD_LINE1);
				self.corp_ra_address_line2			:= trimUpper(input.AGT_AD_LINE2);
				self.corp_ra_address_line3			:= trimUpper(input.AGT_AD_LINE3);
				self.corp_ra_address_line4			:= trimUpper(input.AGT_AD_LINE4);
				self.corp_ra_address_line5			:= if(trimUpper(input.AGT_AD_CITY) <> '',
																							if(trimUpper(input.AGT_AD_STATE) <> '',
																									if ((string)(integer)input.AGT_AD_ZIP<>'0',
																												trim(	trimUpper(input.AGT_AD_CITY) + ', ' + 
																															trimUpper(input.AGT_AD_STATE) + ' ' + 
																															trimUpper(input.AGT_AD_ZIP),
																															left,right
																														),
																												trim(	trimUpper(input.AGT_AD_CITY) + ', ' + 
																															trimUpper(input.AGT_AD_STATE),left,right)
																											),
																									trimUpper(input.AGT_AD_CITY)
																								),
																							''
																							);

				self 														:= [];
						
			end;

		corp2_mapping.Layout_CorpPreClean corpReservedTransform(NmIndxWithRes input) := transform

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '24-' + trimUpper(input.ID_Key);
				self.corp_vendor								:= '24';
				self.corp_state_origin					:= 'MD';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.ID_Key);
				self.corp_src_type							:= 'SOS';	
				
				self.corp_legal_name						:= if (trim(input.nm_Name,left,right)<>'',
																								trimUpper(input.nm_Name),
																								''
																							); 
				cleanNameType										:= trimUpper(input.CD_NAME_TYPE);
				
        self.corp_ln_name_type_cd				:= map(	cleanNameType = 'CR' => '01',
																								cleanNameType = 'GP' => '01',
																								cleanNameType = 'LC' => '01',
																								cleanNameType = 'LL' => '01',
																								cleanNameType = 'LP' => '01',
																								cleanNameType = 'OT' => '01',
																								cleanNameType = 'OU' => '01',
																								cleanNameType = 'OX' => '04',
																								cleanNameType = 'RG' => '09',
																								cleanNameType = 'RV' => '07',
																								cleanNameType = 'TA' => '04',
																								cleanNameType = 'TX' => '04',
																								cleanNameType = 'UN' => '01',
																								''
																							 );
																							 
        self.corp_ln_name_type_DESC			:= map(	cleanNameType = 'CR' => 'LEGAL',
																								cleanNameType = 'GP' => 'LEGAL',
																								cleanNameType = 'LC' => 'LEGAL',
																								cleanNameType = 'LL' => 'LEGAL',
																								cleanNameType = 'LP' => 'LEGAL',
																								cleanNameType = 'OT' => 'LEGAL',
																								cleanNameType = 'OU' => 'LEGAL',
																								cleanNameType = 'OX' => 'TRADENAME',
																								cleanNameType = 'RG' => 'REGISTERED',
																								cleanNameType = 'RV' => 'RESERVED',
																								cleanNameType = 'TA' => 'TRADENAME',
																								cleanNameType = 'TX' => 'TRADENAME',
																								cleanNameType = 'UN' => 'LEGAL',
																								''
																							 );																							 
																								

				cleanType												:= trimUpper(input.CD_BUS_TYPE);
				typeDesc												:= trimUpper(input.BusTypeDesc);	
				
				self.corp_orig_bus_type_cd			:= if (	trim(typeDesc,left,right)<>'',
																									cleanType,
																									''
																							);
				self.corp_orig_bus_type_desc		:=	typeDesc;
				
				cleanBusPrefix									:= trimUpper(input.ID_Key[1..1]);
				
				self.corp_orig_org_structure_cd	:= cleanBusPrefix;
				self.corp_orig_org_structure_desc	:= map(	cleanBusPrefix = 'A' => 'DOMESTIC LIMITED LIABILITY PARTNERSHIP',
																									cleanBusPrefix = 'B' => 'BUSINESS TRUST',
																									cleanBusPrefix = 'C' => 'GENERAL PARTNERSHIP',
																									cleanBusPrefix = 'D' => 'DOMESTIC CORPORATION',
																									cleanBusPrefix = 'E' => 'FOREIGN LIMITED LIABILITY PARTNERSHIP',
																									cleanBusPrefix = 'F' => 'FOREIGN CORPORATION',
																									cleanBusPrefix = 'L' => 'UNINCORPORATED ENTITY',
																									cleanBusPrefix = 'M' => 'DOMESTIC LIMITED PARTNERSHIP OR DOMESTIC LIMITED LIABILITY PARTNERSHIP',
																									cleanBusPrefix = 'P' => 'FOREIGN LIMITED PARTNERSHIP OR FOREIGN LIMITED LIABILITY PARTNERSHIP',
																									cleanBusPrefix = 'R' => 'REGISTERED NAME',
																									cleanBusPrefix = 'T' => 'TRADE NAME',
																									cleanBusPrefix = 'U' => 'UNCLASSIFIED ENTITY',
																									cleanBusPrefix = 'V' => 'RESERVED NAME',
																									cleanBusPrefix = 'W' => 'DOMESTIC LIMITED LIABILITY COMPANY',
																									cleanBusPrefix = 'Z' => 'FOREIGN LIMITED LIABILITY COMPANY',
																									''
																								);
																									
					
				cleanStatus											:= trimUpper(input.cd_Status);
				statusDesc											:= trimUpper(input.StatusDesc); 

				self.corp_status_desc						:= statusDesc; 

				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
																							
				cleanStatusDate									:= reformatDate(input.dt_stat_effective);

				self.corp_status_date						:= if(	_validate.date.fIsValid(cleanStatusDate),
																									cleanStatusDate,
																									''
																							);	
				
				cleanIncDate										:= reformatDate(input.TS_FORMATION[1..10]);
				
        self.corp_inc_date							:= if ((trimUpper(input.CD_ST_OF_FORMATION) = 'MD' or 
																								trimUpper(input.CD_ST_OF_FORMATION) = '') and
																								_validate.date.fIsValid(cleanIncDate),
																									cleanIncDate,
																									''
																							 );
																							 
        self.corp_forgn_date						:= if (	trimUpper(input.CD_ST_OF_FORMATION) <> 'MD' and 
																								trimUpper(input.CD_ST_OF_FORMATION) <> '' and
																								_validate.date.fIsValid(cleanIncDate),
																									cleanIncDate,
																									''
																							 );																							 
																							 																							 
        self.corp_inc_state							:= if (	trimUpper(input.CD_ST_OF_FORMATION) = 'MD' or 
																								trimUpper(input.CD_ST_OF_FORMATION) = '',
																									'MD',
																									''
																							 );	
																							 
        self.corp_forgn_state_cd				:= if (	trimUpper(input.CD_ST_OF_FORMATION) <> 'MD' and 
																								trimUpper(input.CD_ST_OF_FORMATION) <> '',
																									trimUpper(input.CD_ST_OF_FORMATION),
																									''
																							 );	
																							 
        self.corp_forgn_state_desc			:= if (	trimUpper(input.CD_ST_OF_FORMATION) <> 'MD' and 
																								trimUpper(input.CD_ST_OF_FORMATION) <> '',
																									corp2_mapping.Functions.Decode_state(trimUpper(input.CD_ST_OF_FORMATION)),
																									''
																							 );																								 

				self.corp_address1_line1				:= trimUpper(input.ad_line2);
				self.corp_address1_line2				:= trimUpper(input.ad_line3);
				self.corp_address1_line3				:= trimUpper(input.ad_line4);
				self.corp_address1_line5				:= if(trimUpper(input.AD_CITY) <> '',
																							if(trimUpper(input.AD_STATE) <> '',
																									if ((string)(integer)input.AD_ZIP<>'0',
																												trim(	trimUpper(input.AD_CITY) + ', ' + 
																															trimUpper(input.AD_STATE) + ' ' + 
																															trimUpper(input.AD_ZIP),
																															left,right
																														),
																												trim(	trimUpper(input.AD_CITY) + ', ' + 
																															trimUpper(input.AD_STATE),left,right)
																											),
																									trimUpper(input.AD_CITY)
																								),
																							''
																							);
        self.corp_address1_line6				:= if(	trimUpper(input.ad_Country) <> 'USA' and
																								trimUpper(input.ad_Country) <> 'UNITED STATES',
																									trimUpper(input.ad_Country),
																									''
																							);
				cleanAddrType										:= trimUpper(input.CD_ADDRESS_TYPE);																	
				self.corp_address1_type_cd			:= map(	cleanAddrType = 'P' => 'B',
																								cleanAddrType = 'A' => 'B',
																								cleanAddrType = 'F' => 'F',
																								cleanAddrType = 'T' => 'B',
																								''
																							 );
																							 
				self.corp_address1_type_desc		:= map(	cleanAddrType = 'P' => 'BUSINESS',
																								cleanAddrType = 'A' => 'BUSINESS',
																								cleanAddrType = 'F' => 'FILING',
																								cleanAddrType = 'T' => 'BUSINESS',
																								''
																							 );

				self.corp_ra_title_desc					:= if(trimUpper(input.AGT_NM_NAME)<>'',
																								'REGISTERED OFFICE',
																								''
																							);
				self.corp_ra_name								:= trimUpper(input.AGT_NM_NAME);
				self.corp_ra_address_line1 			:= trimUpper(input.AGT_AD_LINE1);
				self.corp_ra_address_line2			:= trimUpper(input.AGT_AD_LINE2);
				self.corp_ra_address_line3			:= trimUpper(input.AGT_AD_LINE3);
				self.corp_ra_address_line4			:= trimUpper(input.AGT_AD_LINE4);
				self.corp_ra_address_line5			:= if(trimUpper(input.AGT_AD_CITY) <> '',
																							if(trimUpper(input.AGT_AD_STATE) <> '',
																									if ((string)(integer)input.AGT_AD_ZIP<>'0',
																												trim(	trimUpper(input.AGT_AD_CITY) + ', ' + 
																															trimUpper(input.AGT_AD_STATE) + ' ' + 
																															trimUpper(input.AGT_AD_ZIP),
																															left,right
																														),
																												trim(	trimUpper(input.AGT_AD_CITY) + ', ' + 
																															trimUpper(input.AGT_AD_STATE),left,right)
																											),
																									trimUpper(input.AGT_AD_CITY)
																								),
																							''
																							);
																								
				cleanExpireDate									:= reformatDate(input.DT_EXPIRATION);
				self.corp_term_exist_cd					:= if(	_validate.date.fIsValid(cleanExpireDate),
																									'D',
																									''
																							);	
				self.corp_term_exist_desc				:= if(	_validate.date.fIsValid(cleanExpireDate),
																									'EXPIRATION',
																									''
																							);
																							
				self.corp_term_exist_exp				:= if(	_validate.date.fIsValid(cleanExpireDate),
																									cleanExpireDate,
																									''
																							);																							

				self 														:= [];
						
			end;


		corp2_mapping.Layout_CorpPreClean corpTradeNameTransform(NmIndxWithTrade input) := transform

				self.dt_first_seen							:= fileDate;
				self.dt_last_seen								:= fileDate;
				self.dt_vendor_first_reported		:= fileDate;
				self.dt_vendor_last_reported		:= fileDate;
				self.corp_ra_dt_first_seen			:= fileDate;
				self.corp_ra_dt_last_seen				:= fileDate;			
				self.corp_key										:= '24-' + trimUpper(input.ID_Key);
				self.corp_vendor								:= '24';
				self.corp_state_origin					:= 'MD';
				self.corp_process_date					:= fileDate;
				self.corp_orig_sos_charter_nbr	:= trimUpper(input.ID_Key);
				self.corp_src_type							:= 'SOS';	
				
				self.corp_legal_name						:= if (trim(input.nm_Name,left,right)<>'',
																								trimUpper(input.nm_Name),
																								''
																							); 
				cleanNameType										:= trimUpper(input.CD_NAME_TYPE);
				
        self.corp_ln_name_type_cd				:= map(	cleanNameType = 'CR' => '01',
																								cleanNameType = 'GP' => '01',
																								cleanNameType = 'LC' => '01',
																								cleanNameType = 'LL' => '01',
																								cleanNameType = 'LP' => '01',
																								cleanNameType = 'OT' => '01',
																								cleanNameType = 'OU' => '01',
																								cleanNameType = 'OX' => '04',
																								cleanNameType = 'RG' => '09',
																								cleanNameType = 'RV' => '07',
																								cleanNameType = 'TA' => '04',
																								cleanNameType = 'TX' => '04',
																								cleanNameType = 'UN' => '01',
																								''
																							 );
																							 
        self.corp_ln_name_type_DESC			:= map(	cleanNameType = 'CR' => 'LEGAL',
																								cleanNameType = 'GP' => 'LEGAL',
																								cleanNameType = 'LC' => 'LEGAL',
																								cleanNameType = 'LL' => 'LEGAL',
																								cleanNameType = 'LP' => 'LEGAL',
																								cleanNameType = 'OT' => 'LEGAL',
																								cleanNameType = 'OU' => 'LEGAL',
																								cleanNameType = 'OX' => 'TRADENAME',
																								cleanNameType = 'RG' => 'REGISTERED',
																								cleanNameType = 'RV' => 'RESERVED',
																								cleanNameType = 'TA' => 'TRADENAME',
																								cleanNameType = 'TX' => 'TRADENAME',
																								cleanNameType = 'UN' => 'LEGAL',
																								''
																							 );																							 
																								

				cleanType												:= trimUpper(input.CD_BUS_TYPE);
				typeDesc												:= trimUpper(input.BusTypeDesc);	
				
				self.corp_orig_bus_type_cd			:= if (	trim(typeDesc,left,right)<>'',
																									cleanType,
																									''
																							);
				self.corp_orig_bus_type_desc		:=	typeDesc;
				
				cleanBusPrefix									:= trimUpper(input.ID_Key[1..1]);
				
				self.corp_orig_org_structure_cd	:= cleanBusPrefix;
				self.corp_orig_org_structure_desc	:= map(	cleanBusPrefix = 'A' => 'DOMESTIC LIMITED LIABILITY PARTNERSHIP',
																									cleanBusPrefix = 'B' => 'BUSINESS TRUST',
																									cleanBusPrefix = 'C' => 'GENERAL PARTNERSHIP',
																									cleanBusPrefix = 'D' => 'DOMESTIC CORPORATION',
																									cleanBusPrefix = 'E' => 'FOREIGN LIMITED LIABILITY PARTNERSHIP',
																									cleanBusPrefix = 'F' => 'FOREIGN CORPORATION',
																									cleanBusPrefix = 'L' => 'UNINCORPORATED ENTITY',
																									cleanBusPrefix = 'M' => 'DOMESTIC LIMITED PARTNERSHIP OR DOMESTIC LIMITED LIABILITY PARTNERSHIP',
																									cleanBusPrefix = 'P' => 'FOREIGN LIMITED PARTNERSHIP OR FOREIGN LIMITED LIABILITY PARTNERSHIP',
																									cleanBusPrefix = 'R' => 'REGISTERED NAME',
																									cleanBusPrefix = 'T' => 'TRADE NAME',
																									cleanBusPrefix = 'U' => 'UNCLASSIFIED ENTITY',
																									cleanBusPrefix = 'V' => 'RESERVED NAME',
																									cleanBusPrefix = 'W' => 'DOMESTIC LIMITED LIABILITY COMPANY',
																									cleanBusPrefix = 'Z' => 'FOREIGN LIMITED LIABILITY COMPANY',
																									''
																								);
																									
					
				cleanStatus											:= trimUpper(input.cd_Status);
				statusDesc											:= trimUpper(input.StatusDesc); 

				self.corp_status_desc						:= statusDesc; 

				self.corp_status_cd							:= if (	trim(statusDesc,left,right)<>'',
																									cleanStatus,
																									''
																							);
																							
				cleanStatusDate									:= reformatDate(input.dt_stat_effective);

				self.corp_status_date						:= if(	_validate.date.fIsValid(cleanStatusDate),
																									cleanStatusDate,
																									''
																							);	
				
				cleanIncDate										:= reformatDate(input.TS_FORMATION[1..10]);
				
        self.corp_inc_date							:= if ((trimUpper(input.CD_ST_OF_FORMATION) = 'MD' or 
																								trimUpper(input.CD_ST_OF_FORMATION) = '') and
																								_validate.date.fIsValid(cleanIncDate),
																									cleanIncDate,
																									''
																							 );
																							 
        self.corp_forgn_date						:= if (	trimUpper(input.CD_ST_OF_FORMATION) <> 'MD' and 
																								trimUpper(input.CD_ST_OF_FORMATION) <> '' and
																								_validate.date.fIsValid(cleanIncDate),
																									cleanIncDate,
																									''
																							 );																							 
																							 																							 
        self.corp_inc_state							:= if (	trimUpper(input.CD_ST_OF_FORMATION) = 'MD' or 
																								trimUpper(input.CD_ST_OF_FORMATION) = '',
																									'MD',
																									''
																							 );	
																							 
        self.corp_forgn_state_cd				:= if (	trimUpper(input.CD_ST_OF_FORMATION) <> 'MD' and 
																								trimUpper(input.CD_ST_OF_FORMATION) <> '',
																									trimUpper(input.CD_ST_OF_FORMATION),
																									''
																							 );	
																							 
        self.corp_forgn_state_desc			:= if (	trimUpper(input.CD_ST_OF_FORMATION) <> 'MD' and 
																								trimUpper(input.CD_ST_OF_FORMATION) <> '',
																									corp2_mapping.Functions.Decode_state(trimUpper(input.CD_ST_OF_FORMATION)),
																									''
																							 );																								 

				self.corp_address1_line1				:= trimUpper(input.ad_line2);
				self.corp_address1_line2				:= trimUpper(input.ad_line3);
				self.corp_address1_line3				:= trimUpper(input.ad_line4);
				self.corp_address1_line5				:= if(trimUpper(input.AD_CITY) <> '',
																							if(trimUpper(input.AD_STATE) <> '',
																									if ((string)(integer)input.AD_ZIP<>'0',
																												trim(	trimUpper(input.AD_CITY) + ', ' + 
																															trimUpper(input.AD_STATE) + ' ' + 
																															trimUpper(input.AD_ZIP),
																															left,right
																														),
																												trim(	trimUpper(input.AD_CITY) + ', ' + 
																															trimUpper(input.AD_STATE),left,right)
																											),
																									trimUpper(input.AD_CITY)
																								),
																							''
																							);
        self.corp_address1_line6				:= if(	trimUpper(input.ad_Country) <> 'USA' and
																								trimUpper(input.ad_Country) <> 'UNITED STATES',
																									trimUpper(input.ad_Country),
																									''
																							);
				cleanAddrType										:= trimUpper(input.CD_ADDRESS_TYPE);																	
				self.corp_address1_type_cd			:= map(	cleanAddrType = 'P' => 'B',
																								cleanAddrType = 'A' => 'B',
																								cleanAddrType = 'F' => 'F',
																								cleanAddrType = 'T' => 'B',
																								''
																							 );
																							 
				self.corp_address1_type_desc		:= map(	cleanAddrType = 'P' => 'BUSINESS',
																								cleanAddrType = 'A' => 'BUSINESS',
																								cleanAddrType = 'F' => 'FILING',
																								cleanAddrType = 'T' => 'BUSINESS',
																								''
																							 );

				self.corp_ra_title_desc					:= if(trimUpper(input.AGT_NM_NAME)<>'',
																								'REGISTERED OFFICE',
																								''
																							);
				self.corp_ra_name								:= trimUpper(input.AGT_NM_NAME);
				self.corp_ra_address_line1 			:= trimUpper(input.AGT_AD_LINE1);
				self.corp_ra_address_line2			:= trimUpper(input.AGT_AD_LINE2);
				self.corp_ra_address_line3			:= trimUpper(input.AGT_AD_LINE3);
				self.corp_ra_address_line4			:= trimUpper(input.AGT_AD_LINE4);
				self.corp_ra_address_line5			:= if(trimUpper(input.AGT_AD_CITY) <> '',
																							if(trimUpper(input.AGT_AD_STATE) <> '',
																									if ((string)(integer)input.AGT_AD_ZIP<>'0',
																												trim(	trimUpper(input.AGT_AD_CITY) + ', ' + 
																															trimUpper(input.AGT_AD_STATE) + ' ' + 
																															trimUpper(input.AGT_AD_ZIP),
																															left,right
																														),
																												trim(	trimUpper(input.AGT_AD_CITY) + ', ' + 
																															trimUpper(input.AGT_AD_STATE),left,right)
																											),
																									trimUpper(input.AGT_AD_CITY)
																								),
																							''
																							);
																								
				cleanExpireDate									:= reformatDate(input.DT_EXPIRATION);
				self.corp_term_exist_cd					:= if(	_validate.date.fIsValid(cleanExpireDate),
																									'D',
																									''
																							);	
				self.corp_term_exist_desc				:= if(	_validate.date.fIsValid(cleanExpireDate),
																									'EXPIRATION',
																									''
																							);
																							
				self.corp_term_exist_exp				:= if(	_validate.date.fIsValid(cleanExpireDate),
																									cleanExpireDate,
																									''
																							);
																				
				cleanFilingDate									:= reformatDate(input.DT_REGISTRATION);
        self.corp_filing_date						:= if(	_validate.date.fIsValid(cleanFilingDate),
																									cleanFilingDate,
																									''
																							);	
																							
				cleanCancelledDate							:= reformatDate(input.DT_CANCELLED);
        self.corp_addl_info							:= if(	_validate.date.fIsValid(cleanCancelledDate),
																									'CANCELLED DATE: ' + cleanCancelledDate,
																									''
																							);																								

				self 														:= [];
						
			end;
			
		Corp2.Layout_Corporate_Direct_Event_In EventTransform(AmendWithFilmIndx input):=transform
																								
			self.corp_key											:= '24-' + trimUpper(input.idKey);	
			self.corp_vendor									:= '24';		
		
			self.corp_state_origin						:= 'MD';
			self.corp_process_date						:= fileDate;

			self.corp_sos_charter_nbr					:= trimUpper(input.idKey);
	
			self.event_filing_cd							:= trimUpper(input.cdFilingType);
			
			self.event_filing_desc						:= trimUpper(input.filingDesc);
			
			cleanDate													:= reformatDate(input.tsBusEffective);
			self.event_filing_date						:= if ( cleanDate <> '' and
																								_validate.date.fIsValid(cleanDate) and
																								_validate.date.fIsValid(cleanDate,_validate.date.rules.DateInPast),
																									cleanDate,
																									''
																								);  
																								
      self.event_date_type_cd						:= if ( cleanDate <> '' and
																								_validate.date.fIsValid(cleanDate) and
																								_validate.date.fIsValid(cleanDate,_validate.date.rules.DateInPast),
																									'FIL',
																									''
																								); 	
																								
      self.event_date_type_desc					:= if ( cleanDate <> '' and
																								_validate.date.fIsValid(cleanDate) and
																								_validate.date.fIsValid(cleanDate,_validate.date.rules.DateInPast),
																									'FILING',
																									''
																								); 	
																								
			self.event_microfilm_nbr					:= trimUpper(input.cdVolume);
			
			self.event_start									:= trimUpper(input.cdStartPage);
			
			self.event_desc										:= trimUpper(input.TX_Comments);
			
			self															:=[];
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
																																				trim(input.corp_address1_line2,left,right) + ' ' +
																																				trim(input.corp_address1_line3,left,right),left,right),
																																	trim(input.corp_address1_line5,left,right)
																																 );			
			
			string182 clean_ra_address 			:= Address.CleanAddress182(	trim(	trim(input.corp_ra_address_line1,left,right) + ' ' +
																																				trim(input.corp_ra_address_line2,left,right) + ' ' +
																																				trim(input.corp_ra_address_line3,left,right) + ' ' +
																																				trim(input.corp_ra_address_line4,left,right),left,right),
																																	trim(input.corp_ra_address_line5,left,right)
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
		
		
			PopBusEntityLookups findStatusDesc(layouts_raw_input.BusEntityLayout input, layouts_raw_input.EntityStatusLayout r ) := transform
				self.StatusDesc			:= r.TX_DESCRIPT;
				self         		  	:= input;
				self                := [];
			end; 
			
			PopBusEntityLookups findBusTypeDesc(PopBusEntityLookups input, layouts_raw_input.BusTypeLayout r ) := transform
				self.BusTypeDesc		:= r.TX_DESCRIPT;
				self         		  	:= input;
				self                := [];
			end; 			
		
			PopBusStatus := join(	Files_Raw_Input.BusEntityFile(fileDate), Files_Raw_Input.EntityStatusFile(fileDate),
														trimUpper(left.cd_status) = trimUpper(right.cd_status),
														findStatusDesc(left,right),
														left outer, lookup
													);	
													
			PopBusType	 := join(	PopBusStatus, Files_Raw_Input.BusTypeFile(fileDate),
														trimUpper(left.CD_BUS_TYPE) = trimUpper(right.CD_BUS_TYPE),
														findBusTypeDesc(left,right),
														left outer, lookup
													);
													
			EntityWithName MergeEntity2Name(PopBusEntityLookups l, Layouts_Raw_Input.BusNmIndxLayout r ) := transform
				self							:= l;
				self							:= r;
			end; 
		
			joinEntityWithName := join(	PopBusType, files_raw_input.BusNmIndxFile(fileDate),
																	trim(left.id_Key,left,right) = trim(right.id_Key,left,right),
																	MergeEntity2Name(left,right),
																	left outer
																);														
													
      RegisteredAddr 	:= Files_Raw_Input.BusAddrFile(fileDate)(CD_ADDRESS_TYPE='R');
			CorpAddress			:= Files_Raw_Input.BusAddrFile(fileDate)(	CD_ADDRESS_TYPE<>'R' and
																																CD_ADDRESS_TYPE<>'L' and
																																CD_ADDRESS_TYPE<>'M');
																																
	
			EntityWithRAAddr MergeEntity2RAAddr(EntityWithName l, Layouts_Raw_Input.BusAddrLayout r ) := transform
				self							:= l;
				self.AGT_NM_NAME 	:= r.NM_NAME;
				SELF.AGT_AD_LINE1	:= r.AD_LINE1;
				SELF.AGT_AD_LINE2	:= r.AD_LINE2;
				SELF.AGT_AD_LINE3	:= r.AD_LINE3;
				SELF.AGT_AD_LINE4	:= r.AD_LINE4;
				self.AGT_AD_CITY	:= r.AD_CITY;
				self.AGT_AD_STATE	:= r.AD_STATE;
				self.AGT_AD_ZIP		:= r.AD_ZIP;
			end; 
		
			joinEntityWithRAAddr := join(	joinEntityWithName, RegisteredAddr,
																			trim(left.id_Key,left,right) = trim(right.id_Key,left,right),
																			MergeEntity2RAAddr(left,right),
																			left outer
																		);																																
		
			EntityWithAddr MergeEntity2Addr(EntityWithRAAddr l, Layouts_Raw_Input.BusAddrLayout r ) := transform
				self							:= l;
				self.ad_line1			:= if(r.ad_line1 = r.nm_name,
																	'',
																	r.ad_line1
																);
 				self							:= r;
			end; 
		
			joinEntityWithAddr := join(	joinEntityWithRAAddr, CorpAddress,
																	trim(left.id_key,left,right) = trim(right.id_key,left,right),
																	MergeEntity2Addr(left,right),
																	left outer
																);
																
      ReservedNames			:= joinEntityWithAddr(id_key[1..1]='R');
			TradeNames				:= joinEntityWithAddr(id_key[1..1]='T');
			
			NmIndxWithRes MergeNmIndx2Res(EntityWithAddr l, ReserveNameLayout r ) := transform
				self							:= l;
				self							:= r;
			end; 
		
			joinNameIndxWithRes := join(ReservedNames, ReserveNameFile,
																	trim(left.id_key,left,right) = trim(right.id_key,left,right),
																	MergeNmIndx2Res(left,right),
																	left outer
																);	
																
			NmIndxWithTrade MergeNmIndx2Trade(EntityWithAddr l, Layouts_Raw_Input.TradeNameLayout r ) := transform
				self							:= l;
				self							:= r;
			end; 
		
			joinNameIndxWithTrade := join(TradeNames, Files_Raw_Input.TradeNameFile(fileDate),
																	trim(left.id_key,left,right) = trim(right.id_key,left,right),
																	MergeNmIndx2Trade(left,right),
																	left outer
																);																	
																
			mapCorpMaster			:= project(joinEntityWithAddr, corpMasterTransform(left));
			mapCorpReserved		:= project(joinNameIndxWithRes, corpReservedTransform(left));
			mapCorpTradeName	:= project(joinNameIndxWithTrade, corpTradeNameTransform(left));
			
			mapCorp 					:= dedup(mapCorpMaster + mapCorpReserved + mapCorpTradeName,Record);
			
			cleanCorps				:= project(mapCorp, CleanCorpAddrName(left));			
			
			PopAmendLookups findFilingDesc(AmendHistLayout input, layouts_raw_input.FilingTypeLayout r ) := transform
				self.FilingDesc			:= r.TX_FILING_TYPE;
				self         		  	:= input;
				self                := [];
			end; 
		
			PopFilingType := join(AmendFile, Files_Raw_Input.FilingTypeFile(fileDate),
														trimUpper(left.cdFilingType) = trimUpper(right.cd_filing_type),
														findFilingDesc(left,right),
														left outer, lookup
													);			
			
			AmendWithComment MergeAmend2Comments(PopAmendLookups l, Layouts_Raw_Input.BusCommentLayout r ) := transform
				self							:= l;
				self							:= r;
			end; 
		
			joinAmendWithComment := join(	PopFilingType, Files_Raw_Input.BusCommentFile(fileDate),
																		trim(left.IdComments,left,right) = trim(right.ID_COMMENTS,left,right),
																		MergeAmend2Comments(left,right),
																		left outer
																	);
																	
			AmendWithFilmIndx MergeAmend2FilmIndx(AmendWithComment l, FilmIndxLayout r ) := transform
				self							:= l;
				self							:= r;
			end; 
		
			joinAmendWithFilmIndx := join(joinAmendWithComment, FilmIndxFile,
																		trim(left.idFlngNbr,left,right) = trim(right.idFlngNbr,left,right),
																		MergeAmend2FilmIndx(left,right),
																		left outer
																	);		
																	
			mapEvent					:= project(joinAmendWithFilmIndx, EventTransform(left));																	
																																	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_md'	,cleanCorps	,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_md'	,MapEvent 	,event_out	,,,pOverwrite);

			MapMDCorpFiling		:=	parallel(                                                                                                                         
				 corp_out	
				,event_out
			);

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('md',filedate,pOverwrite := pOverwrite))
			,MapMDCorpFiling
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_md')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_md')
			)
		);
																	
		return result;
	end;
end;