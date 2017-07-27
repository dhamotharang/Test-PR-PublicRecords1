import Corp2,ut, lib_stringlib, _validate, Address,VersionControl;  
export WV :=  MODULE;  // WV module has Four vendor layouts 

   export Layouts_Raw_Input := MODULE;
       
     export   Business  :=record,maxlength(10000000)
			 string	CP_BUSI_UID				;
			 string	CP_FILG_STATE_CD		;
			 string	FILG_STATE_CD			;
			 string	SRC_ACTION_CD			;
			 string	BUS_ID					;
			 string	BUS_DUNS_NBR			;
			 string	BUS_ENTY_ID				;
			 string	FILG_OFC_DUNS_NBR		;
			 string	BUS_CITY_CD				;
			 string	BUS_ST_CD				;
			 string	FILG_CORP_TYP_CD		;
			 string	FILG_CORP_TYPE_DESC		;
			 string	STATUS_CD  				;
			 string STATUS_DESC         	;
			 string	STATUS_DT       		;
			 string	AUTHZD_CAPL_TOT_AMT		;
			 string	PAID_IN_CAPL_AMT		;
			 string	FILG_SIC_corp_CD		;
			 string	FILG_SIC_corp_DESC		;
			 string	FILG_SIC_EXT_CD			;
			 string	FILG_RGTRN_TYPE_CD		;
			 string	FILG_RGTRN_TYPE_DESC	;
			 string	VERN_DT					;
			 string	EXPN_DT					;
			 string	PAID_IN_CAPL_DT			;
			 string	ORIG_FILG_DT			;
			 string	FILG_INCN_DT			;
			 string	SRC_ENTD_DT				;
			 string	SRC_LAST_UPDT_DT		;
			 string	SRC_ENTD_TM				;
			 string	SRC_LAST_UPD_TM			;
			 string	FILG_AGT_APPT_DT		;
			 string	FILG_FED_ID_NBR			;
			 string	FISC_YR_END_DT			;
			 string	FRCH_TAX_BAL_AMT		;
			 string	FRCH_TAX_STAT_CD		;
			 string	FRCH_TAX_STAT_DESC		;
			 string	FRCH_TAX_STAT_DT		;
			 string	FRCH_TAX_PAID_AMT		;
			 string	FRCH_TAX_PAID_DT		;
			 string	TAX_FCTR_PCTG			;
			 string	TAX_PAID_AMT			;
			 string	TAX_CAPL_AMT			;
			 string	TOT_CAPL_AMT			;
			 string	SRC_RECVD_DT			;
			 string	SOS_ANN_RPT_DUE_DT		;
			 string	SOS_RPT_FILD_DT			;
			 string	TAX_BAL_AMT				;
			 string	SOS_RPT_MLD_DT			;
			 string	SOS_RPT_DLQNT_DT		;
			 string	SOS_LAST_RPT_DT			;
			 string	DSBN_CNTRL_CD			;
			 string	FILG_ACTV_AGT_IND		;
			 string	MIN_REQM_MET_IND		;
			 string	FILG_INCN_ST_NM			;
			 string	FILG_INCN_FOR_RGTRN_TXT	;
			 string	FILG_INCN_CTRY_NME		;
			 string CP_SOS_ID_NBR     		;
			 string	SOS_FULL_ID_NBR			;
			 string	PERP_IND				;
			 string	FILG_MISC_DET_TXT		;
			 string	SYS_SRC_CD				;
			 string	CP_STATUS_DT        	;
			 string	CP_VERN_DT				;
			 string	CP_EXPN_DT				;
			 string	CP_PAID_IN_CAPL_DT		;
			 string	CP_ORIG_FILG_DT			;
			 string	CP_FILG_INCN_DT			;
			 string	CP_ENTD_DT				;
			 string	CP_LAST_UPDT_DT			;
			 string	CP_FILG_AGT_APPT_DT		;
			 string	CP_FISC_YR_END_DT		;
			 string	CP_FRCH_TAX_STAT_DT		;
			 string	CP_FRCH_TAX_PAID_DT		;
			 string	CP_SRC_RECVD_DT			;
			 string	CP_SOS_ANN_RPT_DUE_DT	;
			 string	CP_SOS_RPT_FILD_DT		;
			 string	CP_SOS_RPT_MLD_DT		;
			 string	CP_SOS_RPT_DELQ_DT		;
			 string	CP_SOS_LAST_RPT_DT		;
			 string	CPM_EARLIEST_DATA_DT	;
			 string	CPM_LATEST_DATA_DT		;
			 string	CPM_ACCESS_ARRAY		;
			 string	CPM_INS_BATCH_UID     	;
			 string	CPM_INS_RUN_ID       	;
			 string	CPM_INS_BATCH_RUN_DT	;
			 string	CPM_Update_BATCH_UID  	;
			 string	CPM_Update_RUN_ID  		;
			 string	CPM_UPDT_BATCH_RUN_DT	;
			 string	CPS_PARTITION_CD        ;
			 string	CPM_VENDOR_CD			;
	 end; 
	  

	
	
    export Party:=record,maxlength(10000000)
		   string	CP_BUSP_UID				;
		   string	BUSI_CP_BUSI_UID		;
		   string	CP_PARTY_MD5_AK			;
		   string	CP_FILG_STATE_CD1		;
		   string	CP_PARTY_TYPE_CD		;
		   string	CP_PARTY_TYPE_DESC		;
		   string	BUS_ID1					;
		   string	SRC_BUS_PRIN_SEQ_NBR	;
		   string	FILG_INDV_TITLE1_CD		;
		   string	FILG_INDV_TITLE1_DESC	;
		   string	FILG_INDV_TITLE2_CD		;
		   string	FILG_INDV_TITLE2_DESC	;
		   string	FILG_INDV_TITLE3_CD		;
		   string	FILG_INDV_TITLE3_DESC	;
		   string	FILG_INDV_TITLE_DESC	;
		   string	CP_SOS_ID_NBR1          ;
		   string	FILG_FED_ID_NBR1        ;
		   string	FULL_NM					;
		   string	NM_TYPE_CD				;
		   string	NM_TYPE_DESC			;
		   string	CANCL_DT				;
		   string	SRC_NM_EFF_DT			;
		   string	NM_RNEW_DT				;
		   string	MTCH_TYP_CD				;
		   string	OFCR_FILE_NBR			;
		   string	ADDR_TYPE_CD			;
		   string	ADDR_TYPE_DESC			;
		   string	STR_ADR_FULL_TXT		;
		   string	ADDR_LINE1				;
		   string	ADDR_LINE2				;
		   string	ADDR_LINE3				;
		   string	CITY_NM					;
		   string	ST_NM					;
		   string	POST_CD					;
		   string	CNTY_NM					;
		   string	FOR_RGTRN_TXT			;
		   string	CTRY_NM					;
		   string	SRC_ADDR_EFF_DT			;
		   string	CP_ADDR_TYPE_CD			;
		   string	CP_ADDR_TYPE_DESC		;
		   string	CP_CANCL_DT				;
		   string	CP_NM_RNEW_DT			;
		   string	CP_NM_SEQ_NBR			;
		   string	CP_ADDR_SEQ_NBR			;
		   string	CP_SRC_NM_EFF_DT		;
		   string	CP_SRC_ADDR_EFF_DT		;
		   string	STNM_REV_ID				;
		   string	STNM_STATUS_CD			;
		   string	STNM_PERSON_CNT			;
		   string	STNM_FIRM_CNT			;
		   string	STNM1_FIRST_NM			;
		   string	STNM1_MIDDLE_NM			;
		   string	STNM1_LAST_NM			;
		   string	STNM1_CERTS				;
		   string	STNM1_TITLES			;
		   string	STNM1_NM_PRFX			;
		   string	STNM1_NM_SUFX			;
		   string	STNM1_GENDER			;
		   string	STNM1_STND_1_NM			;
		   string	STNM1_STND_2_NM			;
		   string	STNM1_NM_CNF			;
		   string	STNM1_FIRM_NM			;
		   string	STNM1_FIRM_NM_TRLG_TERM	;
		   string	STNM1_FIRM_LOCN			;		
		   string	STNM1_FIRM_CNF			;
		   string	STADDR_STATUS_CD        ;
		   string	STADDR_REV_ID           ;
		   string	STADDR_PRMRY_ADDR       ;
		   string	STADDR_SCNDY_ADDR       ;
		   string	STADDR_PRMRY_RNGE       ;
		   string	STADDR_PRE_DIR          ;
		   string	STADDR_PRMRY_NM         ;
		   string	STADDR_SUFX             ;
		   string	STADDR_POST_DIR         ;
		   string	STADDR_SCNDY_RNGE       ;
		   string	STADDR_UNIT_DSGNTR      ;
		   string	STADDR_RMNDR            ;
		   string	STADDR_RR_NBR           ;
		   string	STADDR_RR_BOX_NBR       ;
		   string	STADDR_PO_BOX_NBR       ;
		   string	STADDR_CITY_FULL_NM     ;
		   string	STADDR_STATE_CD         ;
		   string	STADDR_ZIP5_CD          ;
		   string	STADDR_ZIP4_CD          ;
		   string	STADDR_MTCH_UNSUIT_CD   ;
		   string	STADDR_RCPNT_TYPE_CD    ;
		   string	STADDR_CNTY_CD          ;
		   string	STADDR_FIPS_CD          ;
		   string	STADDR_GEO_MTCH_CD      ;
		   string	STADDR_GEO_LAT          ;
		   string	STADDR_GEO_LON          ;
		   string	STADDR_GEO_MSA_CD       ;
		   string	STADDR_GEO_CENSUS_BLK   ;
		   string	CPM_EARLIEST_DATA_DT1	;
		   string	CPM_LATEST_DATA_DT1		;
		   string	CPM_EFF_DT1				;
		   string	CPM_INACTIVE_DT1		;
		   string	CPM_CURR_FLAG1			;
		   string	CPM_ACCESS_ARRAY1		;
		   string	CPM_INS_BATCH_UID1      ;
		   string	CPM_INS_RUN_ID1         ;
		   string	CPM_INS_BATCH_RUN_DT1	;
		   string	CPM_UPDT_BATCH_UID1     ;
		   string	CPM_UPDT_RUN_ID1        ;
		   string	CPM_UPDT_BATCH_RUN_DT1	;
		   string	CPS_PARTITION_CD1       ;
		   string	CPS_VENDOR_CD1          ;
		   string	CPM_TRAN_TYPE_CD1       ;

    end;
	  
	export Status:=record,maxlength(10000000)
		   string	St_CP_BUSS_UID			;
		   string	St_BUSI_CP_BUSI_UID		;
		   string	St_CP_STATUS_MD5_AK		;
		   string	St_CP_FILG_STATE_CD		;
		   string	St_BUS_ID				;
		   string	St_STATUS_CD			;
		   string	St_STATUS_DESC			;
		   string	St_STATUS_DT			;
		   string	St_SRC_STATUS_SEQ_NBR	;
		   string	St_CP_STATUS_DT			;
		   string	St_CPM_EARLIEST_DATA_DT ;
		   string	St_CPM_LATEST_DATA_DT	;
		   string	St_CPM_EFF_DT			;
		   string	St_CPM_INACTIVE_DT		;
		   string	St_CPM_CURR_FLAG		;
		   string	St_CPM_ACCESS_ARRAY		;
		   string	St_CPM_INS_BATCH_UID    ;
		   string	St_CPM_INS_RUN_ID       ;
		   string	St_CPM_INS_BATCH_RUN_DT ;
		   string	St_CPM_UPDT_BATCH_UID   ;
		   string	St_CPM_UPDT_RUN_ID		;
		   string	St_CPM_UPDT_BATCH_RUN_DT;
		   string	St_CPS_PARTITION_CD     ;
		   string	St_CPM_VENDOR_CD		;
		   string	St_CPM_TRAN_TYPE_CD	    ;


    end;
	export stock:=record,maxlength(10000000)

		   string	s_CP_STOCK_UID		;
		   string	s_BUSI_CP_BUSI_UID	;
		   string	s_CP_FILG_STATE_CD	;
		   string	s_BUS_ID				;
		   string	s_REGN_STK_SEQ_NBR	;
		   string	s_STK_CLASS_CD		;
		   string	s_DOL_VAL				;
		   string	s_AUTHZD_QTY			;
		   string	s_ISS_QTY				;
		   string	s_PAR_VAL				;
		   string	s_PAR_VAL_IND			;
		   string	s_VOTG_RGHT_IND		;
		   string	s_CONVT_IND			;
		   string	s_STK_TYP_CD			;
		   string	s_STK_TYP_DESC		;
		   string	s_CP_DOL_VAL			;
		   string	s_CP_AUTHZD_QTY		;
		   string	s_CP_ISS_QTY			;
		   string	s_CP_PAR_VAL			;
		   string	s_CPM_ACCESS_ARRAY	;
		   string	s_CPM_INS_BATCH_UID   ;
		   string	s_CPM_INS_RUN_ID      ;
		   string	s_CPM_INS_BATCH_RUN_DT;
		   string	s_CPS_PARTITION_CD    ;
		   string	s_CPS_VENDOR_CD       ;
		   string	s_CPM_TRAN_TYPE_CD  	;
	end;    
   end; // end of Layouts_Raw_Input module
   
   	export Files_Raw_Input := MODULE;	
	
		export Business_file (string fileDate)    := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::Business::wv',layouts_Raw_Input.Business  ,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n']),maxlength(10000000))),hash(BUS_ID));
																			 
		export status_file	(string fileDate)     := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::status::wv',layouts_Raw_Input.Status,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n']),maxlength(10000000))),hash(st_BUS_ID));
															 
		export Party_file 	(string fileDate)     := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::party::wv',layouts_Raw_Input.Party,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n']),maxlength(10000000))),hash(BUS_ID1));
														
		export stock_file 	(string fileDate)     := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::stock::wv',layouts_Raw_Input.stock,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n']),maxlength(10000000))),hash(s_BUS_ID));		 					 
	
	end;		

  export Business_Party:=record,maxlength(10000000)
		Layouts_Raw_Input.Business;
		Layouts_Raw_Input.Party;
  end;
  
    export Business_Party_status:=record,maxlength(10000000)
		   Business_Party;
		Layouts_Raw_Input.status;
  end;
    export Business_stock:=record,maxlength(10000000)
		Layouts_Raw_Input.Business;
		Layouts_Raw_Input.stock;
  end;
  
  trimUpper( string s) := function
				return trim(stringlib.StringToUppercase(s),left,right);
	  end;	 
		ForgnStateDescLayout := record,MAXLENGTH(100)
               string code;
               string desc;

         end;
		 ForgnStateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstateprovince_table', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
	
		export Update( string fileDate,string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	    corp2_mapping.Layout_CorpPreClean wv_corpTransform_Business(Business_Party_status input):=transform
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='54-'+trim(input.CP_SOS_ID_NBR,left,right);
			self.corp_vendor					  :='54';
		    self.corp_state_origin                :='WV';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.CP_SOS_ID_NBR,left,right);
			self.corp_ln_name_type_cd             :=If (trimUpper(input.NM_TYPE_DESC)='PRIMARY','01','');
			self.corp_ln_name_type_desc           :=If (trimUpper(input.NM_TYPE_DESC)='PRIMARY','LEGAL','');
		    self.corp_legal_name                  :=If (trimUpper(input.NM_TYPE_DESC)='PRIMARY',trimUpper(input.full_NM),'');
			self.corp_orig_org_structure_cd       :=If(input.FILG_RGTRN_TYPE_CD<> '' AND trim(input.FILG_RGTRN_TYPE_CD,left,right)<>'99' , trim( input.FILG_RGTRN_TYPE_CD ,left,right),'') ;
            self.corp_orig_org_structure_desc     :=map(input.FILG_RGTRN_TYPE_CD ='01'=>'CORPORATION',
														input.FILG_RGTRN_TYPE_CD ='6'=>'DOMESTIC CORPORATION',
														input.FILG_RGTRN_TYPE_CD ='7'=>'FOREIGN CORPORATION',
														input.FILG_RGTRN_TYPE_CD ='8'=>'DOMESTIC LIMITED PARTNERSHIP',
														input.FILG_RGTRN_TYPE_CD ='9'=>'FOREIGN LIMITED PARTNERSHIP',
														input.FILG_RGTRN_TYPE_CD ='11'=>'DOMESTIC LIMITED LIABILITY COMPANY',
														input.FILG_RGTRN_TYPE_CD ='12'=>'FOREIGN LIMITED LIABILITY COMPANY',
														input.FILG_RGTRN_TYPE_CD ='16'=>'FOREIGN LTD LIABILITY PARTNERSHIP',IF(trimUpper(input.FILG_RGTRN_TYPE_DESC)<>'OTHER',trimUpper(input.FILG_RGTRN_TYPE_DESC),'')) ;
			self.corp_for_profit_ind              :=If(input.FILG_CORP_TYP_CD<>'' and trim(input.FILG_CORP_TYP_CD,left,right)<>'98' and trimUpper(input.FILG_CORP_TYPe_desc)<>'NOT AVAILABLE' , 
														if(trim(input.FILG_CORP_TYP_CD,left,right)='01' and trimUpper(input.FILG_CORP_TYPe_desc)='PROFIT','Y',
															if(trim(input.FILG_CORP_TYP_CD,left,right)='02' and trimUpper(input.FILG_CORP_TYPe_desc)='NON-PROFIT','N','')),'');
			self.corp_address1_line1              :=if(input.STR_ADR_FULL_TXT<>''and trimUpper(input.STR_ADR_FULL_TXT)<>'NOT AVAILABLE'and trimUpper(input.CP_PARTY_TYPE_DESC)='BUSINESS', trimUpper(input.STR_ADR_FULL_TXT),'');
			self.corp_address1_line2              :=if(input.CITY_NM<>''and trimUpper(input.CP_PARTY_TYPE_DESC)='BUSINESS',trimUpper(input.CITY_NM), '');
			self.corp_address1_line3              :=if(input.ST_NM<>''and trimUpper(input.CP_PARTY_TYPE_DESC)='BUSINESS',trimUpper(input.ST_NM), '');
			self.corp_address1_line4             :=if((string)(integer)(input.STADDR_ZIP5_CD ) <> '0' and (string)(integer)(input.STADDR_ZIP4_CD ) <> '0' and trimUpper(input.CP_PARTY_TYPE_DESC)='BUSINESS',trim(input.STADDR_ZIP5_CD,left,right)+trim(input.STADDR_ZIP4_CD,left,right),
														if((string)(integer)(input.STADDR_ZIP5_CD ) <> '0'and trimUpper(input.CP_PARTY_TYPE_DESC)='BUSINESS',trim(input.STADDR_ZIP5_CD,left,right),''));
 			self.corp_address1_type_cd            :=if(trimUpper(input.CP_PARTY_TYPE_DESC)='BUSINESS',if(self.corp_address1_line1<>''or self.corp_address1_line2<>'' or 
			                                           self.corp_address1_line3<>''  or
												      self.corp_address1_line4<>'','B',''),'');
   			self.corp_address1_type_desc          :=if(trimUpper(input.CP_PARTY_TYPE_DESC)='BUSINESS',if(self.corp_address1_line1<>''or self.corp_address1_line2<>'' or 
			                                           self.corp_address1_line3<>''  or
												      self.corp_address1_line4<>'','BUSINESS',''),'');											

			self.corp_STATUS_CD                   :=If(input.ST_STATUS_CD<>''and input.ST_STATUS_CD<>'27' ,trim(input.ST_STATUS_CD,left,right),'');
            self.corp_status_desc                 :=map(input.ST_STATUS_CD='01'=>'ACTIVE',
														input.ST_STATUS_CD='10'=>'MERGER',
														input.ST_STATUS_CD='16'=>'INACTIVE/NAME CHANGE',
														input.ST_STATUS_CD='17'=>'VOLUNTARILY DISSOLVED',
														input.ST_STATUS_CD='19'=>'DISSOLUTION BY COURT ORDER',
														input.ST_STATUS_CD='21'=>'VOLUNTARY CANCELLATION-LLC',
														input.ST_STATUS_CD='22'=>'NAME CHANGE',
														input.ST_STATUS_CD='23'=>'REVOCATION-FAILURE TO FILE A/R',
														input.ST_STATUS_CD='25'=>'VOLUNTARY WITHDRAWAL',
														if(trimUpper(input.STATUS_DESC )<>'STATUS NOT PROVIDED'and input.ST_STATUS_CD<>'27' ,trimUpper(input.STATUS_DESC ),''));
		    self.corp_status_date                 :=if(_validate.date.fIsValid(trim(input.ST_STATUS_DT,left,right))and 
			                                         _validate.date.fIsValid(trim(input.ST_STATUS_DT,left,right),_validate.date.rules.DateInPast) and (integer)input.ST_STATUS_DT<>0,trim(input.ST_STATUS_DT,left,right),'');
		    self.corp_term_exist_cd               :=if(_validate.date.fIsValid(trim(input.EXPN_DT,left,right))and (integer)input.EXPN_DT<>0,'D','');   
			self.corp_term_exist_exp              :=if(_validate.date.fIsValid(trim(input.EXPN_DT,left,right))and (integer)input.EXPN_DT<>0,trim(input.EXPN_DT,left,right),'');   
			self.corp_term_exist_desc             :=if(_validate.date.fIsValid(trim(input.EXPN_DT,left,right))and (integer)input.EXPN_DT<>0,'EXPIRATION DATE',''); 
			self.corp_inc_date                    :=If(_validate.date.fIsValid(trim(input.ORIG_FILG_DT ,left,right))and 
			                                         _validate.date.fIsValid(trim(input.ORIG_FILG_DT ,left,right),_validate.date.rules.DateInPast) and (integer)input.ORIG_FILG_DT <>0,trim(input.ORIG_FILG_DT ,left,right),'');
  		    self.corp_inc_state                   :=If(input.FILG_INCN_ST_NM<>'' and trimUpper(input.FILG_INCN_ST_NM)='WV','WV','');
            self.corp_forgn_state_cd              :=If(input.FILG_INCN_ST_NM<>'' and trimUpper(input.FILG_INCN_ST_NM)<>'WV',trimUpper(input.FILG_INCN_ST_NM),
													   if(input.FILG_INCN_ST_NM ='' and input.FILG_INCN_FOR_RGTRN_TXT<>'WV',trimUpper(input.FILG_INCN_FOR_RGTRN_TXT),
														   if(input.FILG_INCN_ST_NM ='' and input.FILG_INCN_FOR_RGTRN_TXT='',trimUpper(input.FILG_INCN_CTRY_NME),'')));
		    self.corp_ra_name                     :=If(trimUpper(input.CP_ADDR_TYPE_DESC)='REGISTERED AGENT ADDRESS',trimUpper(input.FULL_NM),'');
		    self.corp_ra_address_line1            :=if(input.STR_ADR_FULL_TXT<>''and trimUpper(input.STR_ADR_FULL_TXT)<>'NOT AVAILABLE' and trimUpper(input.CP_ADDR_TYPE_DESC)='REGISTERED AGENT ADDRESS', trimUpper(input.STR_ADR_FULL_TXT),'');
			self.corp_ra_address_line2            :=if(input.CITY_NM<>'' and trimUpper(input.CP_ADDR_TYPE_DESC)='REGISTERED AGENT ADDRESS',trimUpper(input.CITY_NM), '');
			self.corp_ra_address_line3            :=if(input.ST_NM<>'' and trimUpper(input.CP_ADDR_TYPE_DESC)='REGISTERED AGENT ADDRESS' ,trimUpper(input.ST_NM), '');
			self.corp_ra_address_line4            :=if((string)(integer)(input.STADDR_ZIP5_CD ) <> '0' and (string)(integer)(input.STADDR_ZIP4_CD ) <> '0' and trimUpper(input.CP_ADDR_TYPE_DESC)='REGISTERED AGENT ADDRESS',trim(input.STADDR_ZIP5_CD,left,right)+trim(input.STADDR_ZIP4_CD,left,right),
														if((string)(integer)(input.STADDR_ZIP5_CD ) <> '0' and trimUpper(input.CP_ADDR_TYPE_DESC)='REGISTERED AGENT ADDRESS',trim(input.STADDR_ZIP5_CD,left,right),'')); 
			self.corp_ra_address_type_desc        :=If(trimUpper(input.CP_ADDR_TYPE_DESC)='REGISTERED AGENT ADDRESS',if(self.corp_ra_address_line1<>'' or self.corp_ra_address_line2<>'' or self.corp_ra_address_line3<>'' or self.corp_ra_address_line4<>'','REGISTERED OFFICE',''),'');
		    self                                  := [];

		
        end; // of wv_corp_transform     .


			
		 // Stock_TRANSFORM 
	     Corp2.Layout_Corporate_Direct_Stock_In wv_stockTransform(Business_stock input):=transform
			self.corp_key					      := '54-'+trim(input.CP_SOS_ID_NBR,left,right);
			self.corp_vendor				      := '54';
			self.corp_state_origin			      := 'WV';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.CP_SOS_ID_NBR,left,right);
			l									  :=length(input.s_PAR_VAL);
			self.stock_par_value                  :=if(input.s_PAR_VAL<>''and trimUpper(input.s_PAR_VAL_IND)<>'N',input.s_PAR_VAL[1..l-2]+'.'+ input.s_PAR_VAL[l-1..],'');
			self.stock_tax_capital                :=If(input.AUTHZD_CAPL_TOT_AMT <>'' and trim(input.AUTHZD_CAPL_TOT_AMT,left,right)<>'29517489',trim(input.AUTHZD_CAPL_TOT_AMT,left,right),'');   
        	self                                  := [];
			
			
		 end; // end of wv_Stock_transform 
	Corp2.Layout_Corporate_Direct_Stock_In wv_stock1Transform(Corp2.Layout_Corporate_Direct_Stock_In input):=transform,skip(input.stock_par_value='' and input.stock_tax_capital='' )
			self                                  :=input;
        	self                                  := [];
			
			
	 end; 
	 
		 
		
		 // contact_TRANSFORM
		 corp2_mapping.Layout_ContPreClean wv_contactTransform(Business_Party input):=transform
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
		    self.corp_key					  := '54-'+trim(input.CP_SOS_ID_NBR,left,right);
			self.corp_vendor				  := '54';
			self.corp_state_origin			  := 'WV';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    := trim(input.CP_SOS_ID_NBR,left,right);
			self.corp_legal_name              :=If (trimUpper(input.NM_TYPE_DESC)='PRIMARY',trimUpper(input.full_NM),'');
            self.cont_name                    :=If(trimUpper(input.CP_PARTY_TYPE_DESC)='OFFICER',trimUpper(input.FULL_NM),'');
			self.cont_type_cd                 :=if(trimUpper(input.CP_ADDR_TYPE_DESC)='OFFICER ADDRESS',(string)(integer)(input.FILG_INDV_TITLE1_CD),'');
            title1							  :=if(input.FILG_INDV_TITLE1_DESC<>'' and trimUpper(input.FILG_INDV_TITLE1_DESC)<>'OTHER', trimUpper(input.FILG_INDV_TITLE1_DESC),'');
            title2							  := if(input.FILG_INDV_TITLE_DESC<>'' and trimUpper(input.FILG_INDV_TITLE_DESC)<>'OTHER', trimUpper(input.FILG_INDV_TITLE_DESC),'');        
            concatFields					  := trim(Title1,left,right) + ';' + trim(Title2,left,right) ;
			tempExp							  := regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2						  := regexreplace('^[;]*',tempExp,'',NOCASE);
			self.cont_type_desc         	  :=If(trimUpper(input.CP_ADDR_TYPE_DESC)='OFFICER ADDRESS',regexreplace('[;]+',tempExp2,';',NOCASE),''); 
            self.cont_address_line1        	  :=if(input.STR_ADR_FULL_TXT<>''and trimUpper(input.STR_ADR_FULL_TXT)<>'NOT AVAILABLE' and trimUpper(input.CP_ADDR_TYPE_DESC)='OFFICER ADDRESS', trimUpper(input.STR_ADR_FULL_TXT),'');
			self.cont_address_line3           :=if(input.CITY_NM<>'' and trimUpper(input.CP_ADDR_TYPE_DESC)='OFFICER ADDRESS',trimUpper(input.CITY_NM), '');
			self.cont_address_line4           :=if(input.ST_NM<>'' and trimUpper(input.CP_ADDR_TYPE_DESC)='OFFICER ADDRESS' ,trimUpper(input.ST_NM), '');
			self.cont_address_line5           :=if((string)(integer)(input.STADDR_ZIP5_CD ) <> '0' and (string)(integer)(input.STADDR_ZIP4_CD ) <> '0' and trimUpper(input.CP_ADDR_TYPE_DESC)='OFFICER ADDRESS',trim(input.STADDR_ZIP5_CD,left,right)+trim(input.STADDR_ZIP4_CD,left,right),
													if((string)(integer)(input.STADDR_ZIP5_CD ) <> '0'and trimUpper(input.CP_ADDR_TYPE_DESC)='OFFICER ADDRESS',trim(input.STADDR_ZIP5_CD,left,right),'')); 
            self                              := [];
			
		 end; // end of wv_contact_transform
		 //---------------------------- Clean corp Name and Addresses ---------------------//

		
		corp2.layout_corporate_direct_corp_in CleanCorpNameAddr(corp2_mapping.Layout_CorpPreClean input) := transform
			string73 tempname 					:= if (input.corp_ra_name = '', '',Address.CleanPersonFML73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix,'');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score,'');
			string182 clean_address1 			:=Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right),left,right), 
																		trim(input.corp_address1_line2,left,right) + ', ' +
																		trim(input.corp_address1_line3,left,right) + ' ' +
																		trim(input.corp_address1_line4,left,right));
			self.corp_addr1_prim_range    		:= clean_address1[1..10];
			self.corp_addr1_predir 	      		:= clean_address1[11..12];
			self.corp_addr1_prim_name 	  		:= clean_address1[13..40];
			self.corp_addr1_addr_suffix   		:= clean_address1[41..44];
			self.corp_addr1_postdir 	    	:= clean_address1[45..46];
			self.corp_addr1_unit_desig 	  		:= clean_address1[47..56];
			self.corp_addr1_sec_range 	  		:= clean_address1[57..64];
			self.corp_addr1_p_city_name	  		:= clean_address1[65..89];
			self.corp_addr1_v_city_name	  		:= clean_address1[90..114];
			self.corp_addr1_state 				:= clean_address1[115..116];
			self.corp_addr1_zip5 		    	:= clean_address1[117..121];
			self.corp_addr1_zip4 		    	:= clean_address1[122..125];
			self.corp_addr1_cart 		    	:= clean_address1[126..129];
			self.corp_addr1_cr_sort_sz 	 		:= clean_address1[130];
			self.corp_addr1_lot 		      	:= clean_address1[131..134];
			self.corp_addr1_lot_order 	  		:= clean_address1[135];
			self.corp_addr1_dpbc 		    	:= clean_address1[136..137];
			self.corp_addr1_chk_digit 	  		:= clean_address1[138];
			self.corp_addr1_rec_type		  	:= clean_address1[139..140];
			self.corp_addr1_ace_fips_st	  		:= clean_address1[141..142];
			self.corp_addr1_county 	  			:= clean_address1[143..145];
			self.corp_addr1_geo_lat 	    	:= clean_address1[146..155];
			self.corp_addr1_geo_long 	    	:= clean_address1[156..166];
			self.corp_addr1_msa 		      	:= clean_address1[167..170];
			self.corp_addr1_geo_blk				:= clean_address1[171..177];
			self.corp_addr1_geo_match 	  		:= clean_address1[178];
			self.corp_addr1_err_stat 	    	:= clean_address1[179..182];
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right),left,right), 
																		trim(input.corp_ra_address_line2,left,right) + ', ' +
																		trim(input.corp_ra_address_line3,left,right) + ' ' +
																		trim(input.corp_ra_address_line4,left,right));
			self.corp_ra_prim_range    			:= clean_address[1..10];
			self.corp_ra_predir 	      		:= clean_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_address[41..44];
			self.corp_ra_postdir 	    		:= clean_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_address[47..56];
			self.corp_ra_sec_range 	  			:= clean_address[57..64];
			self.corp_ra_p_city_name	  		:= clean_address[65..89];
			self.corp_ra_v_city_name	  		:= clean_address[90..114];
			self.corp_ra_state 			      	:= clean_address[115..116];
			self.corp_ra_zip5 		      		:= clean_address[117..121];
			self.corp_ra_zip4 		      		:= clean_address[122..125];
			self.corp_ra_cart 		      		:= clean_address[126..129];
			self.corp_ra_cr_sort_sz 	 		:= clean_address[130];
			self.corp_ra_lot 		      		:= clean_address[131..134];
			self.corp_ra_lot_order 	  			:= clean_address[135];
			self.corp_ra_dpbc 		      		:= clean_address[136..137];
			self.corp_ra_chk_digit 	  			:= clean_address[138];
			self.corp_ra_rec_type		  		:= clean_address[139..140];
			self.corp_ra_ace_fips_st	  		:= clean_address[141..142];
			self.corp_ra_county 	  			:= clean_address[143..145];
			self.corp_ra_geo_lat 	    		:= clean_address[146..155];
			self.corp_ra_geo_long 	    		:= clean_address[156..166];
			self.corp_ra_msa 		      		:= clean_address[167..170];
			self.corp_ra_geo_blk				:= clean_address[171..177];
			self.corp_ra_geo_match 	  			:= clean_address[178];
			self.corp_ra_err_stat 	    		:= clean_address[179..182];
			self								:= input;
			self								:= [];
		end;
		//************************Corp cleaning ends************************************
		
			//******************Cont Cleaning starts.****************
		Corp2.Layout_Corporate_Direct_Cont_In CleanContNameAddr(corp2_mapping.Layout_ContPreClean input) := transform
			// cleaning name
			string73 tempname 				:= if (input.cont_name = '', '',Address.CleanPersonFML73(input.cont_name));
			pname 							:= Address.CleanNameFields(tempName);
			cname 							:= DataLib.companyclean(input.cont_name);
			keepPerson 						:= Corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 					:= Corp2.Rewrite_Common.IsCompany(input.cont_name);
			self.cont_title1				:= if(keepPerson, pname.title, '');
			self.cont_fname1 				:= if(keepPerson, pname.fname, '');
			self.cont_mname1 				:= if(keepPerson, pname.mname, '');
			self.cont_lname1 				:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 			:= if(keepPerson, pname.name_suffix,'');
			self.cont_score1 				:= if(keepPerson, pname.name_score, '');
			self.cont_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 			:= if(keepBusiness, pname.name_score,'');
			string182 clean_address 		:= Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' + 														                        
													trim(input.cont_address_line2,left,right),left,right),														                   
													trim(trim(input.cont_address_line3,left,right) + ', ' +
													trim(input.cont_address_line4,left,right),left,right));
			self.cont_prim_range    		:= clean_address[1..10];
			self.cont_predir 	      		:= clean_address[11..12];
			self.cont_prim_name 	  		:= clean_address[13..40];
			self.cont_addr_suffix   		:= clean_address[41..44];
			self.cont_postdir 	    		:= clean_address[45..46];
			self.cont_unit_desig 	  		:= clean_address[47..56];
			self.cont_sec_range 	  		:= clean_address[57..64];
			self.cont_p_city_name	  		:= clean_address[65..89];
			self.cont_v_city_name	  		:= clean_address[90..114];
			self.cont_state 			    := clean_address[115..116];
			self.cont_zip5 		      		:= clean_address[117..121];
			self.cont_zip4 		      		:= clean_address[122..125];
			self.cont_cart 		      		:= clean_address[126..129];
			self.cont_cr_sort_sz 	 		:= clean_address[130];
			self.cont_lot 		      		:= clean_address[131..134];
			self.cont_lot_order 	  		:= clean_address[135];
			self.cont_dpbc 		      		:= clean_address[136..137];
			self.cont_chk_digit 	  		:= clean_address[138];
			self.cont_rec_type		  		:= clean_address[139..140];
			self.cont_ace_fips_st	  		:= clean_address[141..142];
			self.cont_county 	  			:= clean_address[143..145];
			self.cont_geo_lat 	    		:= clean_address[146..155];
			self.cont_geo_long 	    		:= clean_address[156..166];
			self.cont_msa 		      		:= clean_address[167..170];
			self.cont_geo_blk				:= clean_address[171..177];
			self.cont_geo_match 	  		:= clean_address[178];
			self.cont_err_stat 	    		:= clean_address[179..182];
			self							:= input;
			self							:= [];
		end;
		//************************Cont cleaning ends************************************
		
		//Layout join for Business and party
		
	Business_Party trans_busParty(Layouts_Raw_Input.Business  l,Layouts_Raw_Input.party r):=transform 
		self :=l;
		self :=r;
		self := [];
	end;
	
	join_busParty :=join(Files_Raw_Input.Business_file(fileDate) , Files_Raw_Input.Party_file(fileDate),
	                   (integer)trim(left.BUS_ID,left,right) = (integer)trim(right.BUS_ID1,left,right),
						trans_busParty(left,right),
						left outer,local);
	Business_Party_status  trans_busPartyStatus(Business_Party  l,Layouts_Raw_Input.status r):=transform 
		self :=l;
		self :=r;
		self := [];
	end;
	
	join_busPartyStatus:=join(join_busParty , Files_Raw_Input.status_file(fileDate),
	                   (integer)trim(left.BUS_ID,left,right) = (integer)trim(right.st_BUS_ID,left,right),
						trans_busPartyStatus(left,right),
						left outer,local);
		
	     MapCorp     	:= project(join_busPartyStatus, wv_corpTransform_Business(left)) ;
		 
		corp2_mapping.Layout_CorpPreClean findState(corp2_mapping.Layout_CorpPreClean input, ForgnStateDescLayout r ) := transform
			self.corp_forgn_state_desc  := r.desc;
			self         			    := input;
			self                        := [];
		end; 
		joinStateType   := 	join(MapCorp,ForgnStateTable,
									trim(left.corp_forgn_state_cd,left,right) = trim(right.code,left,right),
									findState(left,right),
									left outer, lookup
								);
								
		

		corp_dst := distribute(joinStateType, hash(corp_key));
		corp_srt := sort(corp_dst, corp_key, -(integer)dt_last_seen ,-(integer)corp_inc_date,corp_inc_state , local);
		 
		  corp2_mapping.Layout_CorpPreClean  roll_it(corp2_mapping.Layout_CorpPreClean l, corp2_mapping.Layout_CorpPreClean r) := transform
				self.dt_first_seen					:= if(l.dt_first_seen = '', r.dt_first_seen, l.dt_first_seen);
				self.corp_process_date              := if(l.corp_process_date = '', r.corp_process_date, l.corp_process_date);
				self.dt_vendor_first_reported		:= if(l.dt_vendor_first_reported = '', r.dt_vendor_first_reported, l.dt_vendor_first_reported);
				self.dt_vendor_last_reported		:= if(l.dt_vendor_last_reported = '', r.dt_vendor_last_reported, l.dt_vendor_last_reported);
				self.corp_ra_dt_first_seen			:= if(l.corp_ra_dt_first_seen = '', r.corp_ra_dt_first_seen, l.corp_ra_dt_first_seen);
				self.corp_ra_dt_last_seen           := if(l.corp_ra_dt_last_seen = '', r.corp_ra_dt_last_seen, l.corp_ra_dt_last_seen);
				self.corp_legal_name   	    		:= if(l.corp_legal_name = '', r.corp_legal_name, l.corp_legal_name);
				self.corp_ln_name_type_desc			:= if(l.corp_ln_name_type_desc= '', r.corp_ln_name_type_desc, l.corp_ln_name_type_desc	);
				self.corp_key               		:= if(l.corp_key= '', r.corp_key, l.corp_key	);
				self.corp_orig_sos_charter_nbr		:= if(l.corp_orig_sos_charter_nbr= '', r.corp_orig_sos_charter_nbr, l.corp_orig_sos_charter_nbr	); 
				self.corp_ln_name_type_cd 			:= if(l.corp_ln_name_type_cd= '', r.corp_ln_name_type_cd, l.corp_ln_name_type_cd	);
				self.corp_orig_org_structure_cd 	:= if(l.corp_orig_org_structure_cd= '', r.corp_orig_org_structure_cd, l.corp_orig_org_structure_cd	);
				self.corp_orig_org_structure_desc	:= if(l.corp_orig_org_structure_desc= '', r.corp_orig_org_structure_desc, l.corp_orig_org_structure_desc	); 
				self.corp_for_profit_ind 		    := if(l.corp_for_profit_ind = '', r.corp_for_profit_ind , l.corp_for_profit_ind );
				self.corp_address1_line1 			:= if(l.corp_address1_line1= '', r.corp_address1_line1, l.corp_address1_line1);
				self.corp_address1_line2			:= if(l.corp_address1_line2= '', r.corp_address1_line2, l.corp_address1_line2	); 
				self.corp_address1_line3 			:= if(l.corp_address1_line3= '', r.corp_address1_line3, l.corp_address1_line3	);
				self.corp_address1_line4 			:= if(l.corp_address1_line4= '', r.corp_address1_line4, l.corp_address1_line4	);
				self.corp_address1_type_cd			:= if(l.corp_address1_type_cd= '', r.corp_address1_type_cd, l.corp_address1_type_cd);
				self.corp_address1_type_desc		:= if(l.corp_address1_type_desc= '', r.corp_address1_type_desc, l.corp_address1_type_desc);
				self.corp_STATUS_cd 				:= if(l.corp_STATUS_cd= '', r.corp_STATUS_cd, l.corp_STATUS_cd);
				self.corp_STATUS_desc 				:= if(l.corp_STATUS_desc= '', r.corp_STATUS_desc, l.corp_STATUS_desc	);
				self.corp_status_date				:= if(l.corp_status_date= '', r.corp_status_date, l.corp_status_date	);
				self.corp_term_exist_cd				:= if(l.corp_term_exist_cd	= '', r.corp_term_exist_cd	, l.corp_term_exist_cd	); 
				self.corp_term_exist_exp			:= if(l.corp_term_exist_exp= '', r.corp_term_exist_exp, l.corp_term_exist_exp);
				self.corp_term_exist_desc 			:= if(l.corp_term_exist_desc = '', r.corp_term_exist_desc , l.corp_term_exist_desc );
				self.corp_forgn_state_cd			:= if(l.corp_forgn_state_cd= '', r.corp_forgn_state_cd, l.corp_forgn_state_cd); 
				self.corp_forgn_state_desc			:= if(l.corp_forgn_state_desc= '', r.corp_forgn_state_desc, l.corp_forgn_state_desc);
				self.corp_ra_name					:= if(l.corp_ra_name= '', r.corp_ra_name, l.corp_ra_name); 
				self.corp_ra_address_line1 			:= if(l.corp_ra_address_line1= '', r.corp_ra_address_line1, l.corp_ra_address_line1);
				self.corp_ra_address_line2 			:= if(l.corp_ra_address_line2= '', r.corp_ra_address_line2, l.corp_ra_address_line2);
				self.corp_ra_address_line3			:= if(l.corp_ra_address_line3= '', r.corp_ra_address_line3, l.corp_ra_address_line3);
				self.corp_ra_address_line4 			:= if(l.corp_ra_address_line4= '', r.corp_ra_address_line4, l.corp_ra_address_line4);
				self.corp_ra_address_type_desc		:= if(l.corp_ra_address_type_desc= '', r.corp_ra_address_type_desc, l.corp_ra_address_type_desc);
				self := l;
			end;

		Roll_Recs := rollup(corp_srt, left.corp_key=right.corp_key and
									  left.dt_last_seen = right.dt_last_seen and
									  left.corp_inc_date = right.corp_inc_date and
									  left.corp_inc_state   = right.corp_inc_state , roll_it(left, right), local);
																		
		 cleanCorps  	:= project(Roll_Recs ,CleanCorpNameAddr(left));
	Business_stock trans_busStock(Layouts_Raw_Input.Business  l,Layouts_Raw_Input.stock r):=transform 
		self :=l;
		self :=r;
		self := [];
	end;
	
	join_busStock :=join(Files_Raw_Input.Business_file(fileDate) , Files_Raw_Input.stock_file(fileDate),
	                   (integer)trim(left.BUS_ID,left,right) = (integer)trim(right.s_BUS_ID,left,right),
						trans_busStock(left,right),
						left outer,local);

		 MapStock 		:= project(join_busStock, wv_stockTransform(left));
		 MapStock1 		:= project(MapStock,  wv_stock1Transform(left));
		 MapCont 		:= project(join_busParty, wv_contactTransform(left));
		 cleanCont   	:= project(MapCont , CleanContNameAddr(left));

		 VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_wv',dedup(cleanCorps,record,all),corp_out,,,pOverwrite);		
		 VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_wv',dedup(cleanCont,record,all),cont_out,,,pOverwrite);
		 VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_wv',dedup(MapStock1 ,record,all),stock_out,,,pOverwrite);
		                                                                                                                                                      
		 mappedut_Filing := parallel(corp_out	
										,cont_out	
										,stock_out
									 );        
		 
		result := sequential(
						if(pshouldspray = true,fSprayFiles('wv',filedate,pOverwrite := pOverwrite))
						,mappedut_Filing
						,parallel(fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp','~thor_data400::in::corp2::'+version+'::corp_wv')				  
									,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont','~thor_data400::in::corp2::'+version+'::cont_wv')						  
									,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock','~thor_data400::in::corp2::'+version+'::stock_wv')
								 )
							);      
					  
       return result;
  end;   //Function end					 

   
 end;
