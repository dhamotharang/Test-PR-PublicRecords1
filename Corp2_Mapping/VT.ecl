
import Corp2,ut,Corp2_Mapping, lib_stringlib, _validate, Address, _control, versioncontrol; 

 export vt:= MODULE;  // vt module has only one vendor layout
   export Layouts_Raw_Input := MODULE;
       
    export vendor_Data:= record
	    string1 FN_PREFIX;
        string5 FN_SERIAL;
		string1 FN_SUFFIX;
		string1 CORP_TYPE;
		string2 CORP_STATE;
		string2 COUNTRY;
		string60 CORPNAME;
		string1 ABBREV;
		string30 CORP_DESC;
		string4 CORP_FEE;
		string2 FIS_YR_END;
		string35 REG_AGENT;
		string24 RA_STREET;
		string14 REG_CITY;
		string2 REG_STATE;
		string5 REG_ZIP;
		string30 REG_EMAIL;
		string25 CORP_PRES;
		string25 CORP_VP;
		string25 CORP_SEC;
		string25 CORP_TREAS;
		string25 CORP_DIR1;
		string25 CORP_DIR2;
		string25 CORP_DIR3;
		string24 PO_STREET;
		string14 PO_CITY;
		string2 PO_ST;
		string6 PO_ZIP;
		string8 EFF_DATE;
		string8 VT_INC_DTE;
		string8 RV_DTE;
		string8 ID_DTE;
		string8 RS_DTE;
		string8 AD_DTE;
		string8 WD_DTE;
		string8 LA_DTE;
		string1 REJ_FLG;
		string8 REJ_DATE;
		string8 ME_DTE;
		string8 DS_DATE;
		string9 C_SHRS_AUT;
		string9 P_SHRS_AUT;
		string9 C_SHRS_ISS;
		string9 P_SHRS_ISS;
		string9 C_SHRE_VAL;
		string9 P_SHRE_VAL;
		string60 PREV_NAME;
		string8 LAST_UPDTE;
		string2 CATEG1;
		string2 CATEG2;
		string2 CATEG3;
		string1 STATUS;
		string8 APRINT_DTE;
		string1 CHARITABLE;
		string1 EDUCATE;
		string1 SCIENTIFIC;
		string1 IND_ASSOC;
		string1 ANIMAL_HUS;
		string1 FRATERNAL;
		string1 BENEVOLENT;
		string1 RELIGIOUS;
		string1 AGRICULT;
		string1 TRADE_ASSO;
		string1 CULTURAL;
		string1 SOCIAL;
		string1 ELEEMOSY;
		string1 PATRIOTIC;
		string1 ATHLETIC;
		string1 PROF_ASSOC;
		string1 CIVIC;
		string1 POLITICAL;
		string1 HORTICURE;
		string1 COMM_ASSOC;
		string1 LITERARY;
		string1 TAX_EXEMPT;
		string1 PS0;
		string1 PS1_3;
		string1 PS4_9;
		string1 PS10_14;
		string1 PS20_39;
		string1 PS40;
		string1 VS0;
		string1 VS1_3;
		string1 VS4_9;
		string1 VS10_19;
		string1 VS20_39;
		string1 VS40;
		string1 HOME;
		string1 OTHER;
		string1 BUDGET24K;
		string1 BUDGET99K;
		string1 BUDGET299K;
		string1 BUDGET499K;
		string1 BUDGET999K;
		string1 BUDGET29M;
		string1 BUDGET49M;
		string1 BUDGET5M;
		string10 HISTORY;
	end;
	
	export Tradenames_VendorData:= record
	    string7		FILE_NO	;
	    string8		REG_DTE	;
	    string8		RENEW_DATE	;
	    string60	NAME	;
	    string30	DESC	;
	    string1		TRDCRP_PRE	;
	    string5		TRDCRP_SER	;
	    string1		TRDCRP_SUF	;
	    string1		TRDCRP_PR2	;
	    string5		TRDCRP_SE2	;
	    string1		TRDCRP_SU2	;
	    string1		TRDCRP_PR3	;
	    string5		TRDCRP_SE3	;
	    string1		TRDCRP_SU3	;
	    string1		TRDLLC_PR1	;
	    string7		TRDLLC_FN1	;
	    string1		TRDLLC_PR2	;
	    string7		TRDLLC_FN2	;
	    string1		TRDLTD_PR1	;
	    string7		TRDLTD_FN1	;
	    string1		TRDLTD_PR2	;
	    string7		TRDLTD_FN2	;
	    string20	TRD_B_ADD	;
	    string14	TRD_B_CITY	;
	    string2		TRD_B_ST	;
	    string6		TRD_B_ZIP	;
	    string25	TRD_MEM_1	;
	    string20	TRD_MEM1_A	;
	    string14	TRD_MEM1_C	;
	    string2		TRD_MEM1_S	;
	    string6		TRD_MEM1_Z	;
	    string25	TRD_MEM_2	;
	    string20	TRD_MEM2_A	;
	    string14	TRD_MEM2_C	;
	    string2		TRD_MEM2_S	;
	    string6		TRD_MEM2_Z	;
	    string25	TRD_MEM_3	;
	    string25	TRD_MEM_4	;
	    string35	TRD_PROC_N	;
	    string20	TRD_PROC_A	;
	    string14	TRD_PROC_C	;
	    string2		TRD_PROC_S	;
	    string5		TRD_PROC_Z	;
	    string8		T_CESS_DTE	;
	    string2		T_FEE	;
	    string8		LAST_UPDTE	;
	    string1		STATUS	;
	    string8		EXPIRE_DTE	;

	end;
	
	export LLC_VendorData:= record
	    string1		FN_PREFIX;
	    string7		FILE_NO;
	    string1		STATUS;
	    string1		MANGRMANGE;
	    string1		MEMBERLIAB;
	    string1		TLC_COMPNY;
	    string8		TLC_EXPIRE;
	    string2		LLC_STATE;
	    string1		TLC_TYPE;
	    string2		COUNTRY;
	    string60	NAME;
	    string1		ABBREV;
	    string30	LLC_DESC;
	    string4		LLC_FEE;
	    string2		FIS_YR_END;
	    string35	REG_AGENT;
	    string24	REG_STREET;
	    string14	REG_CITY;
	    string2		REG_STATE;
	    string10	REG_ZIP;
	    string30	REG_EMAIL;
	    string24	PO_STREET;
	    string14	PO_CITY;
	    string2		PO_ST;
	    string10	PO_ZIP;
	    string8		VT_INC_DATE	;
	    string8		EFF_DATE  	;
	    string8		TERM_DATE;
	    string8		REINST_DATE;
	    string8		ME_DATE;
	    string8		WD_DTE;
	    string8		LA_DTE;
	    string60	PREV_NAME;
	    string60	COMPANY;
	    string8		LAST_UP;
	    string8		APRINT_;
	    string10	HISTORY;
	    string422	lf1;
	    string422	lf2;
	    string422	lf3;
	    string422	lf4;
	    string422	lf5;
			string1		lf6;
	end;	


   end; // end of Layouts_Raw_Input module
   
	export Files_Raw_Input := MODULE;
	
		export vendor_Data (string fileDate)                       := dataset('~thor_data400::in::corp2::'+fileDate+'::vendor_Data::vt',
		                                                           layouts_Raw_Input.vendor_Data,flat);
	    export Tradenames_VendorData (string fileDate)             := dataset('~thor_data400::in::corp2::'+fileDate+'::Tradenames_VendorData::vt',
		                                                           layouts_Raw_Input.Tradenames_VendorData,flat);
		export LLC_VendorData (string fileDate)                    := dataset('~thor_data400::in::corp2::'+fileDate+'::LLC_VendorData::vt',
		                                                           layouts_Raw_Input.LLC_VendorData,flat);														   
	end;	
 
	  
   export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
        trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
  

		 
		 CountryStateCodeDescLayout := record,MAXLENGTH(250)
               string code;
               string desc;

         end; 

        StateCountryCodeTable:= dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpCountryState_table::vt',  CountryStateCodeDescLayout, CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
	   
  
		 
		 corp2_mapping.Layout_CorpPreClean  vt_corp1Transform_Business(layouts_raw_input.vendor_Data input):=transform,skip(trim(input.CORPNAME,left,right) = '')
		    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='50-'+ trimUpper(input.FN_PREFIX)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor					  :='50';
		    self.corp_state_origin                :='VT';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_ln_name_type_cd             :=if(trim(input.CORPNAME,left,right) <> '','01','');
			self.corp_ln_name_type_desc           :=if(trim(input.CORPNAME,left,right) <> '','LEGAL','');
		    self.corp_legal_name                  :=if(trim(input.CORPNAME,left,right) <> '',trimUpper(input.CORPNAME),'');
			self.corp_anniversary_month           :=map(trim(input.FIS_YR_END,left,right)='01'=>'JANUARY',
														trim(input.FIS_YR_END ,left,right)='02'=>'FEBRUARY',
														trim(input.FIS_YR_END ,left,right)='03'=>'MARCH',
														trim(input.FIS_YR_END ,left,right)='04'=>'APRIL',
														trim(input.FIS_YR_END ,left,right)='05'=>'MAY',
														trim(input.FIS_YR_END ,left,right)='06'=>'JUNE',
														trim(input.FIS_YR_END ,left,right)='07'=>'JULY',
														trim(input.FIS_YR_END ,left,right)='08'=>'AUGUST',
														trim(input.FIS_YR_END ,left,right)='09'=>'SEPTEMBER',
														trim(input.FIS_YR_END ,left,right)='10'=>'OCTOBER',
														trim(input.FIS_YR_END ,left,right)='11'=>'NOVEMBER',
														trim(input.FIS_YR_END ,left,right)='12'=>'DECEMBER','');
            
			self.corp_address1_line1              :=if(trim(input.PO_STREET,left,right) <> '',trimUpper(input.PO_STREET),'');
			self.corp_address1_line2              :=if(trim(input.PO_CITY,left,right) <> '',trimUpper(input.PO_CITY),'');
			self.corp_address1_line3              :=if(trim(input.PO_ST,left,right) <> '',trimUpper(input.PO_ST),''); 
			self.corp_address1_line4              :=if(trim(input.PO_ZIP,left,right) <> '',trimUpper(input.PO_ZIP),''); 
			
			self.corp_address1_type_cd            := if(trim(input.PO_STREET,left,right) <> '' or trim(input.PO_CITY,left,right) <>'' or 
																	trim(input.PO_ST,left,right) <> '' or 
																	trim(input.PO_ZIP,left,right) <> '',
																		'B',
																		''
																  );
			self.corp_address1_type_desc          :=if(trim(input.PO_STREET,left,right) <> '' or trim(input.PO_CITY,left,right) <>'' or 
																	trim(input.PO_ST,left,right) <> '' or 
																	trim(input.PO_ZIP,left,right) <> '',
																		'BUSINESS',
																		''
																  );

		    self.corp_status_cd                   :=if(trim(input.STATUS,left,right)<>'', trimUpper(input.STATUS),'');
            self.corp_status_desc                 :=map(trimUpper(input.STATUS)='A'=>'ACTIVE',
			                                            trimUpper(input.STATUS)='I'=>'INACTIVE',
														trimUpper(input.STATUS)='T'=>'TERMINATED','');

						
			self.corp_inc_date                    :=if((trim(input.CORP_STATE,left,right) <> '' and
			                                           trim(stringlib.StringtoUpperCase(input.CORP_STATE),left,right) ='VT' )AND
			                                           (_validate.date.fIsValid(input.VT_INC_DTE) and 
														_validate.date.fIsValid((input.VT_INC_DTE),_validate.date.rules.DateInPast)),
														input.VT_INC_DTE,'');
            self.corp_forgn_date                  :=if(( trim(stringlib.StringtoUpperCase(input.CORP_STATE),left,right) <>'VT' )AND
			                                           (_validate.date.fIsValid(input.VT_INC_DTE) and 
														_validate.date.fIsValid((input.VT_INC_DTE),_validate.date.rules.DateInPast)),
														input.VT_INC_DTE, if(trim(input.CORP_STATE,left,right) ='' and trim(input.COUNTRY,left,right) <>'' AND
			                                           (_validate.date.fIsValid(input.VT_INC_DTE) and 
														_validate.date.fIsValid((input.VT_INC_DTE),_validate.date.rules.DateInPast)),
														input.VT_INC_DTE,''));
			                                          

  		    self.corp_inc_state                   :=if((trim(input.CORP_STATE,left,right) <> '' and  trimUpper(input.CORP_STATE) <> 'XX' and
			                                           trim(stringlib.StringtoUpperCase(input.CORP_STATE),left,right) ='VT' ),trim(stringlib.StringtoUpperCase(input.CORP_STATE),left,right),'');
            self.corp_forgn_state_cd              :=if((trim(input.CORP_STATE,left,right) <> '' and  trimUpper(input.CORP_STATE) <> 'XX' and
			                                           trim(stringlib.StringtoUpperCase(input.CORP_STATE),left,right) <>'VT' ),trim(stringlib.StringtoUpperCase(input.CORP_STATE),left,right),
													   if(trim(input.CORP_STATE,left,right) ='' and trim(input.COUNTRY,left,right) <> '',trim(input.COUNTRY,left,right),''));
           
		    self.corp_orig_org_structure_cd       :=if(trim(input.CORP_TYPE,left,right) <> '',trimUpper(input.CORP_TYPE),'');
            self.corp_orig_org_structure_desc     :=map(trimUpper(input.CORP_TYPE)= 'F'=>'FOREIGN',
														trimUpper(input.CORP_TYPE)='P'=>'PARTNERSHIP',
														trimUpper(input.CORP_TYPE)='G'=>'GENERAL',
														trimUpper(input.CORP_TYPE)='N'=>'NON-PROFIT',
														trimUpper(input.CORP_TYPE)='D'=>'DOMESTIC',
														'');
			self.corp_orig_bus_type_desc          :=if(trim(input.CORP_DESC,left,right) <> '',trimUpper(input.CORP_DESC),'');
			
			self.corp_ra_email_address            :=if(trim(input.REG_EMAIL,left,right) <> '',trim(input.REG_EMAIL,left,right) ,''); 
			
		    self.corp_ra_name                     :=if(trim(input.REG_AGENT,left,right) <> '',trimUpper(input.REG_AGENT),''); 
			
			self.corp_ra_address_line1            :=if(trim(input.RA_STREET,left,right) <> '',trimUpper(input.RA_STREET),'');
			self.corp_ra_address_line2            :=if(trim(input.REG_CITY,left,right) <> '',trimUpper(input.REG_CITY),'');
			self.corp_ra_address_line3            :=if(trim(input.REG_STATE,left,right) <> '',trimUpper(input.REG_STATE),''); 
			self.corp_ra_address_line4            :=if(trim(input.REG_ZIP,left,right) <> '',trimUpper(input.REG_ZIP),''); 
			
			self.corp_ra_address_type_cd          :=if(trim(input.RA_STREET,left,right) <> '' or trim(input.REG_CITY,left,right) <>'' or 
																	trim(input.REG_STATE,left,right) <> '' or 
																	trim(input.REG_ZIP,left,right) <> '',
																		'G',
																		''
																  );
			self.corp_ra_address_type_desc        :=if(trim(input.RA_STREET,left,right) <> '' or trim(input.REG_CITY,left,right) <>'' or 
																	trim(input.REG_STATE,left,right) <> '' or 
																	trim(input.REG_ZIP,left,right) <> '',
																		'REGISTERED OFFICE',
																		''
																  );
															  
			self                                  := [];
		
         end; // end transform.
		 
		 corp2_mapping.Layout_CorpPreClean  vt_corp2Transform_Business(layouts_raw_input.vendor_Data input):=transform, skip(trim(input.PREV_NAME,left,right) = '')
		    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='50-'+ trimUpper(input.FN_PREFIX)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor					  :='50';
		    self.corp_state_origin                :='VT';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_ln_name_type_cd             :=if(trim(input.PREV_NAME,left,right) <> '','P','');
			self.corp_ln_name_type_desc           :=if(trim(input.PREV_NAME,left,right) <> '','PRIOR','');
		    self.corp_legal_name                  :=if(trim(input.PREV_NAME,left,right) <> '',trimUpper(input.PREV_NAME),'');
			self                                  := [];
		
         end; // end transform.
		 
		 
		corp2_mapping.Layout_CorpPreClean vt_corpTransform_TradenameBusiness(layouts_Raw_Input.Tradenames_VendorData input):=transform,skip(trim(input.FILE_NO ,left, right)=''and (trim(input.NAME,left,right) = ''))
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='50-'+trim(input.FILE_NO ,left, right);
			self.corp_vendor					  :='50';
		    self.corp_state_origin                :='VT';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.FILE_NO ,left, right);										
			self.corp_term_exist_cd               :=if(_validate.date.fIsValid(trim(input.EXPIRE_DTE ,left,right)),'D','');
			self.corp_ln_name_type_cd             :=if(trim(input.NAME,left,right) <> '','04','');
			self.corp_ln_name_type_desc           :=if(trim(input.NAME,left,right) <> '','TRADENAME','');
		    self.corp_legal_name                  :=if(trim(input.NAME,left,right) <> '',trimUpper(input.NAME),'');										  
													  
		    self.corp_term_exist_desc             :=if(_validate.date.fIsValid(trim(input.EXPIRE_DTE,left,right)),'EXPIRATION DATE','');
													  
			self.corp_term_exist_exp              :=if(_validate.date.fIsValid(trim(input.EXPIRE_DTE,left,right)),trim(input.EXPIRE_DTE,left,right),'');
			self.corp_orig_bus_type_desc          :=if(trim(input.DESC,left,right) <> '',trimUpper(input.DESC),'');
			corp_addl_info2                       :=if(trim(input.T_CESS_DTE,left,right)<>''and _validate.date.fIsValid(input.T_CESS_DTE),'CESSATED DATE:'+trim(input.T_CESS_DTE,left,right),'');
			corp_addl_info1                       :=if(trim(input.RENEW_DATE,left,right)<>'' and  _validate.date.fIsValid(input.RENEW_DATE),'RENEWAL DATE:'+trim(input.RENEW_DATE,left,right),'');
			self.corp_addl_info                   :=corp_addl_info1+' '+corp_addl_info2 ;
			self.corp_filing_date                 :=if(_validate.date.fIsValid(input.REG_DTE)	 and 
														_validate.date.fIsValid((input.REG_DTE),_validate.date.rules.DateInPast),trim(input.REG_DTE,left,right),'');
			self.corp_address1_line1              :=if(trim(input.TRD_B_ADD,left,right) <> '',trimUpper(input.TRD_B_ADD),'');
			self.corp_address1_line2              :=if(trim(input.TRD_B_CITY,left,right) <> '',trimUpper(input.TRD_B_CITY),'');
			self.corp_address1_line3              :=if(trim(input.TRD_B_ST,left,right) <> '',trimUpper(input.TRD_B_ST),''); 
			self.corp_address1_line4              :=if(trim(input.TRD_B_ZIP,left,right) <> '',trimUpper(input.TRD_B_ZIP),''); 
			
			self.corp_address1_type_cd            := if(trim(input.TRD_B_ADD,left,right) <> '' or trim(input.TRD_B_CITY,left,right) <>'' or 
																	trim(input.TRD_B_ST,left,right) <> '' or 
																	trim(input.TRD_B_ZIP,left,right) <> '',
																		'B',
																		''
																  );
			self.corp_address1_type_desc          :=if(trim(input.TRD_B_ADD,left,right) <> '' or trim(input.TRD_B_CITY,left,right) <>'' or 
																	trim(input.TRD_B_ST,left,right) <> '' or 
																	trim(input.TRD_B_ZIP,left,right) <> '',
																		'BUSINESS',
																		''
																		);
																		
			self.corp_ra_name                     :=if(trim(input.TRD_PROC_N  ,left,right) <> '',trimUpper(input.TRD_PROC_N),'');	
			self.corp_ra_address_line1            :=if(trim(input.TRD_PROC_A,left,right) <> '',trimUpper(input.TRD_PROC_A),'');
			self.corp_ra_address_line2            :=if(trim(input.TRD_PROC_C,left,right) <> '',trimUpper(input.TRD_PROC_C),'');
			self.corp_ra_address_line3            :=if(trim(input.TRD_PROC_S,left,right) <> '',trimUpper(input.TRD_PROC_S),''); 
			self.corp_ra_address_line4            :=if(trim(input.TRD_PROC_Z,left,right) <> '',trimUpper(input.TRD_PROC_Z),''); 
			
			self.corp_ra_address_type_cd          :=if(trim(input.TRD_PROC_A,left,right) <> '' or trim(input.TRD_PROC_C,left,right) <>'' or 
																	trim(input.TRD_PROC_S,left,right) <> '' or 
																	trim(input.TRD_PROC_Z,left,right) <> '',
																		'G',
																		''
																  );
			self.corp_ra_address_type_desc        :=if(trim(input.TRD_PROC_A,left,right) <> '' or trim(input.TRD_PROC_C,left,right) <>'' or 
																	trim(input.TRD_PROC_S,left,right) <> '' or 
																	trim(input.TRD_PROC_Z,left,right) <> '',
																		'REGISTERED OFFICE',
																		''
																  );
		    
			self                                  := [];

            		
        end; // end transform.
		
		corp2_mapping.Layout_CorpPreClean vt_corpTransform_LLCBusiness(layouts_Raw_Input.LLC_VendorData input):=transform,skip(trim(input.FN_PREFIX,left, right)='' and trim(input.FILE_NO ,left, right)=''and (trim(input.NAME,left,right) = ''))
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='50-'+trim(input.FN_PREFIX,left, right)+trim(input.FILE_NO ,left, right);
			self.corp_vendor					  :='50';
		    self.corp_state_origin                :='VT';
			self.corp_process_date				  := fileDate;                   
     	    self.corp_orig_sos_charter_nbr        :=trim(input.FN_PREFIX,left, right)+trim(input.FILE_NO,left, right); 
			self.corp_ln_name_type_cd             :=if(trim(input.NAME,left,right) <> '','01','');
			self.corp_ln_name_type_desc           :=if(trim(input.NAME,left,right) <> '','LEGAL','');
		    self.corp_legal_name                  :=if(trim(input.NAME,left,right) <> '',trimUpper(input.NAME),'');
			self.corp_anniversary_month           :=map(trim(input.FIS_YR_END ,left,right)='01'=>'JANUARY',
														trim(input.FIS_YR_END ,left,right)='02'=>'FEBRUARY',
														trim(input.FIS_YR_END ,left,right)='03'=>'MARCH',
														trim(input.FIS_YR_END ,left,right)='04'=>'APRIL',
														trim(input.FIS_YR_END ,left,right)='05'=>'MAY',
														trim(input.FIS_YR_END ,left,right)='06'=>'JUNE',
														trim(input.FIS_YR_END ,left,right)='07'=>'JULY',
														trim(input.FIS_YR_END ,left,right)='08'=>'AUGUST',
														trim(input.FIS_YR_END ,left,right)='09'=>'SEPTEMBER',
														trim(input.FIS_YR_END ,left,right)='10'=>'OCTOBER',
														trim(input.FIS_YR_END ,left,right)='11'=>'NOVEMBER',
														trim(input.FIS_YR_END ,left,right)='12'=>'DECEMBER','');

														
		    self.corp_inc_date                    :=if((trim(input.LLC_STATE,left,right) <> '' and
			                                           trim(stringlib.StringtoUpperCase(input.LLC_STATE),left,right) ='VT' )AND
			                                           (_validate.date.fIsValid(input.VT_INC_DATE) and 
														_validate.date.fIsValid((input.VT_INC_DATE),_validate.date.rules.DateInPast)),
														input.VT_INC_DATE,'');
            self.corp_forgn_date                  :=if(( trim(stringlib.StringtoUpperCase(input.LLC_STATE),left,right) <>'VT' )AND
			                                           (_validate.date.fIsValid(input.VT_INC_DATE) and 
														_validate.date.fIsValid((input.VT_INC_DATE),_validate.date.rules.DateInPast)),
														input.VT_INC_DATE, if(trim(input.LLC_STATE,left,right) ='' and trim(input.COUNTRY,left,right) <>'' AND
			                                           (_validate.date.fIsValid(input.VT_INC_DATE) and 
														_validate.date.fIsValid((input.VT_INC_DATE),_validate.date.rules.DateInPast)),
														input.VT_INC_DATE,''));
														
			self.corp_inc_state                   :=if(trim(input.LLC_STATE,left,right) <> '' and  trimUpper(input.LLC_STATE) <> 'XX' and
			                                           trim(stringlib.StringtoUpperCase(input.LLC_STATE),left,right) ='VT','VT','');
            self.corp_forgn_state_cd              :=if((trim(input.LLC_STATE,left,right) <> '' and trimUpper(input.LLC_STATE) <> 'XX' and
			                                           trim(stringlib.StringtoUpperCase(input.LLC_STATE),left,right) <>'VT' ),trim(stringlib.StringtoUpperCase(input.LLC_STATE),left,right),
													   if(trim(input.LLC_STATE,left,right) ='' and trim(input.COUNTRY,left,right) <> '',trim(input.COUNTRY,left,right),''));											
			self.corp_term_exist_cd               :=if(_validate.date.fIsValid(trim(input.TLC_EXPIRE ,left,right)),'D','');
													  
													  
		    self.corp_term_exist_desc             :=if(_validate.date.fIsValid(trim(input.TLC_EXPIRE,left,right)),'EXPIRATION DATE','');
													  
			self.corp_term_exist_exp              :=if(_validate.date.fIsValid(trim(input.TLC_EXPIRE,left,right)),trim(input.TLC_EXPIRE,left,right),'');										   
            self.corp_orig_org_structure_cd       :=if(trim(input.TLC_TYPE,left,right) <> '',trimUpper(input.TLC_TYPE),'');
            self.corp_orig_org_structure_desc     :=map(trimUpper(input.TLC_TYPE)= 'F'=>'FOREIGN LIMITED LIABILITY COMPANY',
														trimUpper(input.TLC_TYPE)='P'=>'PARTNERSHIP LIMITED LIABILITY COMPANY',
														trimUpper(input.TLC_TYPE)='G'=>'GENERAL LIMITED LIABILITY COMPANY',
														trimUpper(input.TLC_TYPE)='N'=>'NON-PROFIT LIMITED LIABILITY COMPANY',
														trimUpper(input.TLC_TYPE)='D'=>'DOMESTIC LIMITED LIABILITY COMPANY',
														'');
														
			self.corp_orig_bus_type_desc          :=if(trim(input.LLC_DESC,left,right) <> '',trimUpper(input.LLC_DESC),'');
			self.corp_addl_info                   :=if(trimUpper(input.MANGRMANGE)='T','MEMBER MANAGED ','');
			self.corp_ra_name                     :=if(trim(input.REG_AGENT,left,right) <> '',trimUpper(input.REG_AGENT),'');	
			self                                  := [];

		
        end; // end transform.
		 
		 // contact_TRANSFORM For single record has different officer names are  associated... 
		 corp2_mapping.Layout_ContPreClean vt_contact1Transform(layouts_raw_input.vendor_Data input):=transform, skip(trim(input.CORP_PRES,left,right) = '')
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
		    self.corp_key					  := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				  := '50';
			self.corp_state_origin			  := 'VT';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    :=trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_legal_name              :=if(trim(input.CORPNAME,left,right) <> '',trimUpper(input.CORPNAME),'');
            self.cont_name                    :=if((lib_stringlib.StringLib.StringFind(input.CORP_PRES,'SAME',1) =0) and (lib_stringlib.StringLib.StringFind(input.CORP_PRES,'NONE',1) =0),trimUpper(input.CORP_PRES),'');
			name                              :=if((lib_stringlib.StringLib.StringFind(input.CORP_PRES,'SAME',1) =0) and (lib_stringlib.StringLib.StringFind(input.CORP_PRES,'NONE',1) =0),trimUpper(input.CORP_PRES),'');
			title1							  := if(trimupper(input.CORP_PRES)=trimupper(input.CORP_VP) or lib_stringlib.StringLib.StringFind(input.CORP_VP,'SAME',1) =1 ,'VICE PRESIDENT','');
			title2							  := if(trimupper(input.CORP_PRES)=trimupper(input.CORP_SEC) or lib_stringlib.StringLib.StringFind(input.CORP_SEC,'SAME',1) =1, 'SECRETARY','');
			title3						      := if(trimupper(input.CORP_PRES)=trimupper(input.CORP_TREAS) or lib_stringlib.StringLib.StringFind(input.CORP_TREAS,'SAME',1) =1,'TREASURER','');
			title4  						  := if(trimupper(input.CORP_PRES)=trimupper(input.CORP_DIR1) or lib_stringlib.StringLib.StringFind(input.CORP_DIR1,'SAME',1) =1,'DIRECTOR','');
			title5							  := if(trimupper(input.CORP_PRES)=trimupper(input.CORP_DIR2) and title4='' or ( lib_stringlib.StringLib.StringFind(input.CORP_DIR2,'SAME',1) =1 and title4=''),'DIRECTOR','');
			title6							  := if(trimupper(input.CORP_PRES)=trimupper(input.CORP_DIR3) and title4='' and title5='' or (lib_stringlib.StringLib.StringFind(input.CORP_DIR3,'SAME',1) =1 and title4='' and title5='') ,'DIRECTOR','');
			title7                            := if(name<>'','PRESIDENT','');
		    concatFields					  := 	trim(Title1,left,right) + ';' + 
																					trim(Title2,left,right) + ';' +  
																					trim(Title3,left,right) + ';' + 
																					trim(Title4,left,right) + ';' + 
																					trim(Title5,left,right)+ ';' + 
																					trim(Title6,left,right)+ ';' + 
																					trim(Title7,left,right);
				
			tempExp													:= regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2												:= regexreplace('^[;]*',tempExp,'',NOCASE);
			cont_title                        :=regexreplace('[;]+',tempExp2,';',NOCASE);
			self.cont_title1_desc         	  :=if(name<>'',cont_title,'');
		    self.cont_type_cd				  := if(name<>'','F','');
		    self.cont_type_desc				  := if(name<>'','OFFICER','');

		    self                              := [];
			
		 end; // end of contact_transform 
		 
		 
		 		 // contact_TRANSFORM
		 corp2_mapping.Layout_ContPreClean vt_contact2Transform(layouts_raw_input.vendor_Data input):=transform, skip(trim(input.CORP_VP,left,right) = '')
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
		    self.corp_key					  := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				  := '50';
			self.corp_state_origin			  := 'VT';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    :=trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_legal_name              :=if(trim(input.CORPNAME,left,right) <> '',trimUpper(input.CORPNAME),'');
            self.cont_name                    :=if((lib_stringlib.StringLib.StringFind(input.CORP_VP,'SAME',1) =0) and(lib_stringlib.StringLib.StringFind(input.CORP_VP,'NONE',1) =0),trimUpper(input.CORP_VP),'');
			name                             :=if((lib_stringlib.StringLib.StringFind(input.CORP_VP,'SAME',1) =0) and(lib_stringlib.StringLib.StringFind(input.CORP_VP,'NONE',1) =0),trimUpper(input.CORP_VP),'');
			title1							  := if(name<>'','VICE PRESIDENT','');
			title2							  := if(trimupper(input.CORP_VP)=trimupper(input.CORP_SEC) or lib_stringlib.StringLib.StringFind(input.CORP_SEC,'SAME',1) =1, 'SECRETARY','');
			title3						      := if(trimupper(input.CORP_VP)=trimupper(input.CORP_TREAS) or lib_stringlib.StringLib.StringFind(input.CORP_TREAS,'SAME',1) =1,'TREASURER','');
			title4  						  := if(trimupper(input.CORP_VP)=trimupper(input.CORP_DIR1) or lib_stringlib.StringLib.StringFind(input.CORP_DIR1,'SAME',1) =1,'DIRECTOR','');
			title5							  := if(trimupper(input.CORP_VP)=trimupper(input.CORP_DIR2) and title4='' or ( lib_stringlib.StringLib.StringFind(input.CORP_DIR2,'SAME',1) =1 and title4=''),'DIRECTOR','');
			title6							  := if(trimupper(input.CORP_VP)=trimupper(input.CORP_DIR3) and title4='' and title5='' or (lib_stringlib.StringLib.StringFind(input.CORP_DIR3,'SAME',1) =1 and title4='' and title5='') ,'DIRECTOR','');
			title7                            := if(trimupper(input.CORP_VP)=trimupper(input.CORP_PRES) or lib_stringlib.StringLib.StringFind(input.CORP_PRES,'SAME',1) =1   ,'PRESIDENT','');
		    concatFields					  := 	trim(Title1,left,right) + ';' + 
																					trim(Title2,left,right) + ';' +  
																					trim(Title3,left,right) + ';' + 
																					trim(Title4,left,right) + ';' + 
																					trim(Title5,left,right)+ ';' + 
																					trim(Title6,left,right)+ ';' + 
																					trim(Title7,left,right);
				
			tempExp													:= regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2												:= regexreplace('^[;]*',tempExp,'',NOCASE);
			cont_title                        :=regexreplace('[;]+',tempExp2,';',NOCASE);
			self.cont_title1_desc         	  :=if(name<>'',cont_title,'');
		    self.cont_type_cd				  := if(name<>'','F','');
		    self.cont_type_desc				  := if(name<>'','OFFICER','');

		    self                              := [];
			
		 end; // end of contact_transform 
		 
		 
		 		 // contact_TRANSFORM
		 corp2_mapping.Layout_ContPreClean vt_contact3Transform(layouts_raw_input.vendor_Data input):=transform, skip(trim(input.CORP_SEC,left,right) = '')
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
		    self.corp_key					  := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				  := '50';
			self.corp_state_origin			  := 'VT';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    :=trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_legal_name              :=if(trim(input.CORPNAME,left,right) <> '',trimUpper(input.CORPNAME),'');
            self.cont_name                    :=if((lib_stringlib.StringLib.StringFind(input.CORP_SEC,'SAME',1) =0) and (lib_stringlib.StringLib.StringFind(input.CORP_SEC,'NONE',1) =0),trimUpper(input.CORP_SEC),'');
			name                             :=if((lib_stringlib.StringLib.StringFind(input.CORP_SEC,'SAME',1) =0) and(lib_stringlib.StringLib.StringFind(input.CORP_SEC,'NONE',1) =0),trimUpper(input.CORP_SEC),'');
			title1							  := if(trimupper(input.CORP_SEC)=trimupper(input.CORP_VP) or lib_stringlib.StringLib.StringFind(input.CORP_VP,'SAME',1) =1 ,'VICE PRESIDENT','');
			title2							  := if(name<>'', 'SECRETARY','');
			title3						      := if(trimupper(input.CORP_SEC)=trimupper(input.CORP_TREAS) or lib_stringlib.StringLib.StringFind(input.CORP_TREAS,'SAME',1) =1,'TREASURER','');
			title4  						  := if(trimupper(input.CORP_SEC)=trimupper(input.CORP_DIR1) or lib_stringlib.StringLib.StringFind(input.CORP_DIR1,'SAME',1) =1,'DIRECTOR','');
			title5							  := if(trimupper(input.CORP_SEC)=trimupper(input.CORP_DIR2) and title4='' or (  lib_stringlib.StringLib.StringFind(input.CORP_DIR2,'SAME',1) =1 and title4=''),'DIRECTOR','');
			title6							  := if(trimupper(input.CORP_SEC)=trimupper(input.CORP_DIR3) and title4='' and title5='' or ( lib_stringlib.StringLib.StringFind(input.CORP_DIR3,'SAME',1) =1 and title4='' and title5='') ,'DIRECTOR','');
			title7                            := if(trimupper(input.CORP_SEC)=trimupper(input.CORP_PRES) or lib_stringlib.StringLib.StringFind(input.CORP_PRES,'SAME',1) =1 ,'PRESIDENT','');
		    concatFields					  := 	trim(Title1,left,right) + ';' + 
																					trim(Title2,left,right) + ';' +  
																					trim(Title3,left,right) + ';' + 
																					trim(Title4,left,right) + ';' + 
																					trim(Title5,left,right)+ ';' + 
																					trim(Title6,left,right)+ ';' + 
																					trim(Title7,left,right);
				
			tempExp													:= regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2												:= regexreplace('^[;]*',tempExp,'',NOCASE);
			cont_title                        :=regexreplace('[;]+',tempExp2,';',NOCASE);
			self.cont_title1_desc         	  :=if(name<>'',cont_title,'');
		    self.cont_type_cd				  := if(name<>'','F','');
		    self.cont_type_desc				  := if(name<>'','OFFICER','');

		    self                              := [];
			
		 end; // end of contact_transform 
		 
		 
		 		 // contact_TRANSFORM
		 corp2_mapping.Layout_ContPreClean vt_contact4Transform(layouts_raw_input.vendor_Data input):=transform, skip(trim(input.CORP_TREAS,left,right) = '')
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
		    self.corp_key					  := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				  := '50';
			self.corp_state_origin			  := 'VT';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    :=trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_legal_name              :=if(trim(input.CORPNAME,left,right) <> '',trimUpper(input.CORPNAME),'');
            self.cont_name                    :=if((lib_stringlib.StringLib.StringFind(input.CORP_TREAS,'SAME',1) =0)   and (lib_stringlib.StringLib.StringFind(input.CORP_TREAS,'NONE',1) =0),trimUpper(input.CORP_TREAS),'');
			name                              :=if((lib_stringlib.StringLib.StringFind(input.CORP_TREAS,'SAME',1) =0)   and (lib_stringlib.StringLib.StringFind(input.CORP_TREAS,'NONE',1) =0),trimUpper(input.CORP_TREAS),'');
			
			title1							  := if(trimupper(input.CORP_TREAS)=trimupper(input.CORP_VP) or lib_stringlib.StringLib.StringFind(input.CORP_VP,'SAME',1) =1 ,'VICE PRESIDENT','');
			title2							  := if(trimupper(input.CORP_TREAS)=trimupper(input.CORP_SEC) or lib_stringlib.StringLib.StringFind(input.CORP_SEC,'SAME',1) =1, 'SECRETARY','');
			title3						      := if(name<>'','TREASURER','');
			title4  						  := if(trimupper(input.CORP_TREAS)=trimupper(input.CORP_DIR1) or lib_stringlib.StringLib.StringFind(input.CORP_DIR1,'SAME',1) =1,'DIRECTOR','');
			title5							  := if(trimupper(input.CORP_TREAS)=trimupper(input.CORP_DIR2) and title4='' or ( lib_stringlib.StringLib.StringFind(input.CORP_DIR2,'SAME',1) =1 and title4=''),'DIRECTOR','');
			title6							  := if(trimupper(input.CORP_TREAS)=trimupper(input.CORP_DIR3) and title4='' and title5='' or (lib_stringlib.StringLib.StringFind(input.CORP_DIR3,'SAME',1) =1 and title4='' and title5='') ,'DIRECTOR','');
			title7                            := if(trimupper(input.CORP_TREAS)=trimupper(input.CORP_PRES) or lib_stringlib.StringLib.StringFind(input.CORP_PRES,'SAME',1) =1   ,'PRESIDENT','');
		    concatFields					  := 	trim(Title1,left,right) + ';' + 
																					trim(Title2,left,right) + ';' +  
																					trim(Title3,left,right) + ';' + 
																					trim(Title4,left,right) + ';' + 
																					trim(Title5,left,right)+ ';' + 
																					trim(Title6,left,right)+ ';' + 
																					trim(Title7,left,right);
				
			tempExp													:= regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2												:= regexreplace('^[;]*',tempExp,'',NOCASE);
			cont_title                        :=regexreplace('[;]+',tempExp2,';',NOCASE);
			self.cont_title1_desc         	  :=if(name<>'',cont_title,'');
		    self.cont_type_cd				  := if(name<>'','F','');
		    self.cont_type_desc				  := if(name<>'','OFFICER','');

		    self                              := [];
			
		 end; // end of contact_transform 
		 
		 		 // contact_TRANSFORM
		 corp2_mapping.Layout_ContPreClean vt_contact5Transform(layouts_raw_input.vendor_Data input):=transform, skip(trim(input.CORP_DIR1,left,right) = '')
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
		    self.corp_key					  := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				  := '50';
			self.corp_state_origin			  := 'VT';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    :=trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_legal_name              :=if(trim(input.CORPNAME,left,right) <> '',trimUpper(input.CORPNAME),'');
            self.cont_name                    :=if((lib_stringlib.StringLib.StringFind(input.CORP_DIR1,'SAME',1) =0)  and (lib_stringlib.StringLib.StringFind(input.CORP_DIR1,'NONE',1) =0),trimUpper(input.CORP_DIR1),'');
			name                              :=if((lib_stringlib.StringLib.StringFind(input.CORP_DIR1,'SAME',1) =0)  and (lib_stringlib.StringLib.StringFind(input.CORP_DIR1,'NONE',1) =0),trimUpper(input.CORP_DIR1),'');
			
			title1							  := if(trimupper(input.CORP_DIR1)=trimupper(input.CORP_VP) or lib_stringlib.StringLib.StringFind(input.CORP_VP,'SAME',1) =1,'VICE PRESIDENT','');
			title2							  := if(trimupper(input.CORP_DIR1)=trimupper(input.CORP_SEC) or  lib_stringlib.StringLib.StringFind(input.CORP_SEC,'SAME',1) =1, 'SECRETARY','');
			title3						      := if(trimupper(input.CORP_DIR1)=trimupper(input.CORP_TREAS) or lib_stringlib.StringLib.StringFind(input.CORP_TREAS,'SAME',1) =1,'TREASURER','');
			title4  						  := if(name<>'' ,'DIRECTOR','');
			title5							  := if(trimupper(input.CORP_DIR1)=trimupper(input.CORP_DIR2) and title4='' or (lib_stringlib.StringLib.StringFind(input.CORP_DIR2,'SAME',1) =1 and title4=''),'DIRECTOR','');
			title6							  := if(trimupper(input.CORP_DIR1)=trimupper(input.CORP_DIR3) and title4='' and title5='' or (lib_stringlib.StringLib.StringFind(input.CORP_DIR3,'SAME',1) =1 and title4='' and title5='') ,'DIRECTOR','');
			title7                            := if(trimupper(input.CORP_DIR1)=trimupper(input.CORP_PRES) or lib_stringlib.StringLib.StringFind(input.CORP_PRES,'SAME',1) =1  ,'PRESIDENT','');
		    concatFields					  := 	trim(Title1,left,right) + ';' + 
																					trim(Title2,left,right) + ';' +  
																					trim(Title3,left,right) + ';' + 
																					trim(Title4,left,right) + ';' + 
																					trim(Title5,left,right)+ ';' + 
																					trim(Title6,left,right)+ ';' + 
																					trim(Title7,left,right);
				
			tempExp													:= regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2												:= regexreplace('^[;]*',tempExp,'',NOCASE);
			cont_title                        :=regexreplace('[;]+',tempExp2,';',NOCASE);
			self.cont_title1_desc         	  :=if(name<>'',cont_title,'');
		    self.cont_type_cd				  := if(name<>'','F','');
		    self.cont_type_desc				  := if(name<>'','OFFICER','');;

		    self                              := [];
			
		 end; // end of contact_transform 
		 
		 
		 		 // contact_TRANSFORM
		 corp2_mapping.Layout_ContPreClean vt_contact6Transform(layouts_raw_input.vendor_Data input):=transform, skip(trim(input.CORP_DIR2,left,right) = '')
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
		    self.corp_key					  := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				  := '50';
			self.corp_state_origin			  := 'VT';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    :=trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_legal_name              :=if(trim(input.CORPNAME,left,right) <> '',trimUpper(input.CORPNAME),'');
            self.cont_name                    :=if((lib_stringlib.StringLib.StringFind(input.CORP_DIR2,'SAME',1) =0)and (lib_stringlib.StringLib.StringFind(input.CORP_DIR2,'NONE',1) =0),trimUpper(input.CORP_DIR2),'');
			name                              :=if((lib_stringlib.StringLib.StringFind(input.CORP_DIR2,'SAME',1) =0)and (lib_stringlib.StringLib.StringFind(input.CORP_DIR2,'NONE',1) =0),trimUpper(input.CORP_DIR2),'');
			
			title1							  := if(trimupper(input.CORP_DIR2)=trimupper(input.CORP_VP) or lib_stringlib.StringLib.StringFind(input.CORP_VP,'SAME',1) =1,'VICE PRESIDENT','');
			title2							  := if(trimupper(input.CORP_DIR2)=trimupper(input.CORP_SEC) or lib_stringlib.StringLib.StringFind(input.CORP_SEC,'SAME',1) =1, 'SECRETARY','');
			title3						      := if(trimupper(input.CORP_DIR2)=trimupper(input.CORP_TREAS) or lib_stringlib.StringLib.StringFind(input.CORP_TREAS,'SAME',1) =1,'TREASURER','');
			title4  						  := if(trimupper(input.CORP_DIR2)=trimupper(input.CORP_DIR1) or lib_stringlib.StringLib.StringFind(input.CORP_DIR1,'SAME',1) =1,'DIRECTOR','');
			title5							  := if(name<>'' and title4='','DIRECTOR','');
			title6							  := if(trimupper(input.CORP_DIR2)=trimupper(input.CORP_DIR3) and title4='' and title5='' or (lib_stringlib.StringLib.StringFind(input.CORP_DIR3,'SAME',1) =1and title4='' and title5='') ,'DIRECTOR','');
			title7                            := if(trimupper(input.CORP_DIR2)=trimupper(input.CORP_PRES) or lib_stringlib.StringLib.StringFind(input.CORP_PRES,'SAME',1) =1 ,'PRESIDENT','');
		    concatFields					  := 	trim(Title1,left,right) + ';' + 
																					trim(Title2,left,right) + ';' +  
																					trim(Title3,left,right) + ';' + 
																					trim(Title4,left,right) + ';' + 
																					trim(Title5,left,right)+ ';' + 
																					trim(Title6,left,right)+ ';' + 
																					trim(Title7,left,right);
				
			tempExp													:= regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2												:= regexreplace('^[;]*',tempExp,'',NOCASE);
			cont_title                        :=regexreplace('[;]+',tempExp2,';',NOCASE);
			self.cont_title1_desc         	  :=if(name<>'',cont_title,'');
		    self.cont_type_cd				  := if(name<>'','F','');
		    self.cont_type_desc				  := if(name<>'','OFFICER','');

		    self                              := [];
			
		 end; // end of contact_transform 
		 
		 
		 
		 corp2_mapping.Layout_ContPreClean vt_contact7Transform(layouts_raw_input.vendor_Data input):=transform, skip(trim(input.CORP_DIR3,left,right) = '')
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
		    self.corp_key					  := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				  := '50';
			self.corp_state_origin			  := 'VT';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    :=trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_legal_name              :=if(trim(input.CORPNAME,left,right) <> '',trimUpper(input.CORPNAME),'');
            self.cont_name                    :=if((lib_stringlib.StringLib.StringFind(input.CORP_DIR3,'SAME',1) =0) and (lib_stringlib.StringLib.StringFind(input.CORP_DIR3,'NONE',1) =0),trimUpper(input.CORP_DIR3),'');
			name                              :=if((lib_stringlib.StringLib.StringFind(input.CORP_DIR3,'SAME',1) =0) and (lib_stringlib.StringLib.StringFind(input.CORP_DIR3,'NONE',1) =0),trimUpper(input.CORP_DIR3),'');    
			
			title1							  := if(trimupper(input.CORP_DIR3)=trimupper(input.CORP_VP) or lib_stringlib.StringLib.StringFind(input.CORP_VP,'SAME',1) =1 ,'VICE PRESIDENT','');
			title2							  := if(trimupper(input.CORP_DIR3)=trimupper(input.CORP_SEC) or lib_stringlib.StringLib.StringFind(input.CORP_SEC,'SAME',1) =1, 'SECRETARY','');
			title3						      := if(trimupper(input.CORP_DIR3)=trimupper(input.CORP_TREAS) or lib_stringlib.StringLib.StringFind(input.CORP_TREAS,'SAME',1) =1,'TREASURER','');
			title4  						  := if(trimupper(input.CORP_DIR3)=trimupper(input.CORP_DIR1) or lib_stringlib.StringLib.StringFind(input.CORP_DIR1,'SAME',1) =1,'DIRECTOR','');
			title5							  := if(trimupper(input.CORP_DIR3)=trimupper(input.CORP_DIR2) and title4='' or ( lib_stringlib.StringLib.StringFind(input.CORP_DIR2,'SAME',1) =1 and title4=''),'DIRECTOR','');
			title6							  := if(name<>'' and title4='' and title5='' or ( lib_stringlib.StringLib.StringFind(input.CORP_DIR3,'SAME',1) =1 and title4='' and title5='') ,'DIRECTOR','');
			title7                            := if(trimupper(input.CORP_DIR3)=trimupper(input.CORP_PRES) or lib_stringlib.StringLib.StringFind(input.CORP_PRES,'SAME',1) =1 ,'PRESIDENT','');
		    concatFields					  := 	trim(Title1,left,right) + ';' + 
																					trim(Title2,left,right) + ';' +  
																					trim(Title3,left,right) + ';' + 
																					trim(Title4,left,right) + ';' + 
																					trim(Title5,left,right)+ ';' + 
																					trim(Title6,left,right)+ ';' + 
																					trim(Title7,left,right);
				
			tempExp													:= regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2												:= regexreplace('^[;]*',tempExp,'',NOCASE);
			cont_title                        :=regexreplace('[;]+',tempExp2,';',NOCASE);
			self.cont_title1_desc         	  :=if(name<>'',cont_title,'');
		    self.cont_type_cd				  := if(name<>'','F','');
		    self.cont_type_desc				  := if(name<>'','OFFICER','');

		    self                              := [];
			
		 end; // end of contact_transform 
		 
		 
		 corp2_mapping.Layout_ContPreClean vt_contactTrade1_Transform(layouts_Raw_Input.Tradenames_VendorData input):=transform, skip(trim(input.FILE_NO,left,right) = ''and trim(input.TRD_MEM_1,left,right) = '')
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
		    self.corp_key					  := '50-'+trim(input.FILE_NO ,left, right);
			self.corp_vendor				  := '50';
			self.corp_state_origin			  := 'VT';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    :=trim(input.FILE_NO ,left, right);
			
			self.corp_legal_name              :=if(trim(input.NAME,left,right) <> '',trimUpper(input.NAME),'');		
			
            self.cont_name                       :=if((lib_stringlib.StringLib.StringFind(input.TRD_MEM_1,'SAME',1) =0) and (lib_stringlib.StringLib.StringFind(input.TRD_MEM_1,'NONE',1) =0),trimUpper(input.TRD_MEM_1),'');
			self.cont_address_line1              :=if(trim(input.TRD_MEM1_A,left,right) <> '',trimUpper(input.TRD_MEM1_A),'');
			self.cont_address_line2              :=if(trim(input.TRD_MEM1_C ,left,right) <> '',trimUpper(input.TRD_MEM1_C ),'');
			self.cont_address_line3              :=if(trim(input.TRD_MEM1_S ,left,right) <> '',trimUpper(input.TRD_MEM1_S ),''); 
			self.cont_address_line4              :=if(trim(input.TRD_MEM1_Z ,left,right) <> '',trimUpper(input.TRD_MEM1_Z ),''); 
		    
		    self.cont_type_cd				  := 'M';
		    self.cont_type_desc				  := 'MEMBER/MANAGER/PARTNER';

		    self                              := [];
			
		 end; // end of contact_transform 
		 
		 corp2_mapping.Layout_ContPreClean vt_contactTrade2_Transform(layouts_Raw_Input.Tradenames_VendorData input):=transform, skip(trim(input.FILE_NO,left,right) = ''and trim(input.TRD_MEM_2,left,right) = '')
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
		    self.corp_key					  := '50-'+trim(input.FILE_NO ,left, right);
			self.corp_vendor				  := '50';
			self.corp_state_origin			  := 'VT';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    :=trim(input.FILE_NO ,left, right);
			
			self.corp_legal_name              :=if(trim(input.NAME,left,right) <> '',trimUpper(input.NAME),'');
			
            self.cont_name                       :=if((lib_stringlib.StringLib.StringFind(input.TRD_MEM_2,'SAME',1) =0)  and (lib_stringlib.StringLib.StringFind(input.TRD_MEM_2,'NONE',1) =0),trimUpper(input.TRD_MEM_2),'');
			self.cont_address_line1              :=if(trim(input.TRD_MEM2_A,left,right) <> '',trimUpper(input.TRD_MEM2_A),'');
			self.cont_address_line2              :=if(trim(input.TRD_MEM2_C ,left,right) <> '',trimUpper(input.TRD_MEM2_C ),'');
			self.cont_address_line3              :=if(trim(input.TRD_MEM2_S ,left,right) <> '',trimUpper(input.TRD_MEM2_S ),''); 
			self.cont_address_line4              :=if(trim(input.TRD_MEM2_Z ,left,right) <> '',trimUpper(input.TRD_MEM2_Z ),''); 
		    
		    self.cont_type_cd				  := 'M';
		    self.cont_type_desc				  := 'MEMBER/MANAGER/PARTNER';

		    self                              := [];
			
		 end; // end of contact_transform 
		 
		 corp2_mapping.Layout_ContPreClean vt_contactTrade3_Transform(layouts_Raw_Input.Tradenames_VendorData input):=transform, skip(trim(input.FILE_NO,left,right) = ''and trim(input.TRD_MEM_3,left,right) = '')
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
		    self.corp_key					  := '50-'+trim(input.FILE_NO ,left, right);
			self.corp_vendor				  := '50';
			self.corp_state_origin			  := 'VT';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    :=trim(input.FILE_NO ,left, right);
			
			self.corp_legal_name              := if(trim(input.NAME,left,right) <> '',trimUpper(input.NAME),'');
			
            self.cont_name                    :=if((lib_stringlib.StringLib.StringFind(input.TRD_MEM_3,'SAME',1) =0)  and (lib_stringlib.StringLib.StringFind(input.TRD_MEM_3,'NONE',1) =0),trimUpper(input.TRD_MEM_3),'');
			
		    
		    self.cont_type_cd				  := 'M';
		    self.cont_type_desc				  := 'MEMBER/MANAGER/PARTNER';

		    self                              := [];
			
		 end; // end of contact_transform 
		 
		 
		corp2_mapping.Layout_ContPreClean vt_contactTrade4_Transform(layouts_Raw_Input.Tradenames_VendorData input):=transform, skip(trim(input.FILE_NO,left,right) = ''and trim(input.TRD_MEM_4,left,right) = '')
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
		    self.corp_key					  := '50-'+trim(input.FILE_NO ,left, right);
			self.corp_vendor				  := '50';
			self.corp_state_origin			  := 'VT';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    :=trim(input.FILE_NO ,left, right);
			
			self.corp_legal_name              :=if(trim(input.NAME,left,right) <> '',trimUpper(input.NAME),'');
			
            self.cont_name                    :=if((lib_stringlib.StringLib.StringFind(input.TRD_MEM_4,'SAME',1) =0)  and trimUpper(input.TRD_MEM_4)<>'NONE' and trimUpper(input.TRD_MEM_4)<>'-NONE ON FILE-',trimUpper(input.TRD_MEM_4),'');
			
		    
		    self.cont_type_cd				  := 'M';
		    self.cont_type_desc				  := 'MEMBER/MANAGER/PARTNER';
			 self                              := [];
			
		 end; // end of contact_transform 
		 
		 
	   	     // AR_transform 
	     Corp2.Layout_Corporate_Direct_AR_In vt_arTransform(layouts_raw_input.vendor_Data  input):=transform, skip(trim(input.LA_DTE,left,right) = '')
			self.corp_key					      := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				      := '50';
			self.corp_state_origin			      := 'VT';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      :=trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
            self.ar_filed_dt                      :=if((_validate.date.fIsValid(input.LA_DTE) and 
														_validate.date.fIsValid((input.LA_DTE),_validate.date.rules.DateInPast)),
														input.LA_DTE,''); 
            self.ar_comment                       :=if((_validate.date.fIsValid(input.LA_DTE) and 
														_validate.date.fIsValid((input.LA_DTE),_validate.date.rules.DateInPast)),
														'ANNUAL REPORT',''); 
			self                                  := [];

	     end; // end of vt_AR_transform 
		
			
	 
		  // Stock_transform 
	     Corp2.Layout_Corporate_Direct_Stock_In vt_stock1Transform(layouts_raw_input.vendor_Data  input):=transform,skip((trim(input.C_SHRS_AUT,left,right) = '' or (integer)trim(input.C_SHRS_AUT,left,right) = 0 ) and 
		                                                                                                                 (trim(input.C_SHRS_ISS,left,right) = '' or (integer)trim(input.C_SHRS_ISS,left,right) = 0) and 
		                                                                                                                 (trim(input.C_SHRE_VAL,left,right) = ''or (integer)trim(input.C_SHRE_VAL,left,right) = 0) )
			self.corp_key					      := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				      := '50';
			self.corp_state_origin			      := 'VT';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      :=trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			CSHRSAUT                              :=if((integer)trim(input.C_SHRS_AUT,left,right) = 0,'',trim(input.C_SHRS_AUT,left, right));
			self.stock_authorized_nbr             :=CSHRSAUT;
            self.stock_type                       :='COMMON';
			CSHRSISS                              :=if((integer)trim(input.C_SHRS_ISS,left,right) = 0,'',trim(input.C_SHRS_ISS,left, right));
			self.stock_shares_issued              :=CSHRSISS;
			CSHREVAL                              :=if((integer)trim(input.C_SHRE_VAL,left,right) = 0,'',trim(input.C_SHRE_VAL,left, right));
			self.stock_par_value                  :=CSHREVAL;
        	self                                  := [];
			
			
		 end; // end of vt_Stock_transform 
		 
		 
		  // Stock_transform 
	     Corp2.Layout_Corporate_Direct_Stock_In vt_stock2Transform(layouts_raw_input.vendor_Data  input):=transform, skip((trim(input.P_SHRS_AUT,left,right) = '' or (integer)trim(input.P_SHRS_AUT,left,right) = 0 ) and 
		                                                                                                                 (trim(input.P_SHRS_ISS,left,right) = '' or (integer)trim(input.P_SHRS_ISS,left,right) = 0) and 
		                                                                                                                 (trim(input.P_SHRE_VAL,left,right) = ''or (integer)trim(input.P_SHRE_VAL,left,right) = 0) )
			self.corp_key					      := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				      := '50';
			self.corp_state_origin			      := 'VT';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      :=trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			PSHRSAUT                              :=if((integer)trim(input.P_SHRS_AUT,left,right) = 0,'',trim(input.P_SHRS_AUT,left, right));
			self.stock_authorized_nbr             :=PSHRSAUT;
            self.stock_type                       :='PREFERRED';
		    PSHRSISS                             :=if((integer)trim(input.P_SHRS_ISS,left,right) = 0,'',trim(input.P_SHRS_ISS,left, right));
			self.stock_shares_issued              :=PSHRSISS;
			PSHREVAL                              :=if((integer)trim(input.P_SHRE_VAL,left,right) = 0,'',trim(input.P_SHRE_VAL,left, right));
			self.stock_par_value                  :=PSHREVAL;
        	self                                  := [];
			
			
		 end; // end of vt_Stock_transform 
		 

		
		 // Event_transform 
		 Corp2.Layout_Corporate_Direct_Event_In vt_event1Transform(layouts_raw_input.vendor_Data  input):=transform, skip(trim(input.RV_DTE,left,right) = '')
			self.corp_key					    := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				    := '50';
			self.corp_state_origin			    := 'VT';
			self.corp_process_date			    := fileDate;
			self.corp_sos_charter_nbr		    := trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			
			self.event_filing_date              :=if((_validate.date.fIsValid(input.RV_DTE) and 
														_validate.date.fIsValid((input.RV_DTE),_validate.date.rules.DateInPast)),
														input.RV_DTE,'');
			                                        
            
			
            self.event_date_type_cd             :=if((_validate.date.fIsValid(input.RV_DTE) and 
														_validate.date.fIsValid((input.RV_DTE),_validate.date.rules.DateInPast)),'FIL','');
            self.event_date_type_desc           :=if((_validate.date.fIsValid(input.RV_DTE) and 
														_validate.date.fIsValid((input.RV_DTE),_validate.date.rules.DateInPast)),'FILING','');
            

            self.event_desc                     :=if((_validate.date.fIsValid(input.RV_DTE) and 
														_validate.date.fIsValid((input.RV_DTE),_validate.date.rules.DateInPast)),'REVOKED','');
            self                                := [];
		
			
			
		 end; // end of vt_Event_transform 
		 Corp2.Layout_Corporate_Direct_Event_In vt_event2Transform(layouts_raw_input.vendor_Data  input):=transform, skip(trim(input.ID_DTE,left,right) = '')
			self.corp_key					    := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				    := '50';
			self.corp_state_origin			    := 'VT';
			self.corp_process_date			    := fileDate;
			self.corp_sos_charter_nbr		    := trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			
			
			self.event_filing_date              :=if( (_validate.date.fIsValid(input.ID_DTE) and 
														_validate.date.fIsValid((input.ID_DTE),_validate.date.rules.DateInPast)),
														input.ID_DTE,'');
			                                        
            
			
            self.event_date_type_cd             :=if( (_validate.date.fIsValid(input.ID_DTE) and 
														_validate.date.fIsValid((input.ID_DTE),_validate.date.rules.DateInPast)),'FIL','');
            self.event_date_type_desc           :=if( (_validate.date.fIsValid(input.ID_DTE) and 
														_validate.date.fIsValid((input.ID_DTE),_validate.date.rules.DateInPast)),'FILING','');
           

            self.event_desc                     :=if((_validate.date.fIsValid(input.ID_DTE) and 
														_validate.date.fIsValid((input.ID_DTE),_validate.date.rules.DateInPast)),
			                                        'INTENT TO DISSOLVE','');
            self                                := [];
		
			
			
		 end; // end of vt_Event_transform 
		 
		 Corp2.Layout_Corporate_Direct_Event_In vt_event3Transform(layouts_raw_input.vendor_Data  input):=transform, skip(trim(input.RS_DTE,left,right) = '')
			self.corp_key					    := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				    := '50';
			self.corp_state_origin			    := 'VT';
			self.corp_process_date			    := fileDate;
			self.corp_sos_charter_nbr		    := trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			
			
			self.event_filing_date              :=if((_validate.date.fIsValid(input.RS_DTE) and 
														_validate.date.fIsValid((input.RS_DTE),_validate.date.rules.DateInPast)),
														input.RS_DTE,'');
			                                        
            
			
            self.event_date_type_cd             :=if((_validate.date.fIsValid(input.RS_DTE) and 
														_validate.date.fIsValid((input.RS_DTE),_validate.date.rules.DateInPast)),'FIL','');
            self.event_date_type_desc           :=if((_validate.date.fIsValid(input.RS_DTE) and 
														_validate.date.fIsValid((input.RS_DTE),_validate.date.rules.DateInPast)),'FILING','');
           

            self.event_desc                     :=if((_validate.date.fIsValid(input.RS_DTE) and 
														_validate.date.fIsValid((input.RS_DTE),_validate.date.rules.DateInPast)),'REINSTATED','');
            self                                := [];
		
			
			
		 end; // end of vt_Event_transform 
		 
		 Corp2.Layout_Corporate_Direct_Event_In vt_event4Transform(layouts_raw_input.vendor_Data  input):=transform, skip(trim(input.AD_DTE,left,right) = '')
			self.corp_key					    := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				    := '50';
			self.corp_state_origin			    := 'VT';
			self.corp_process_date			    := fileDate;
			self.corp_sos_charter_nbr		    := trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.event_filing_date              :=if((_validate.date.fIsValid(input.AD_DTE) and 
														_validate.date.fIsValid((input.AD_DTE),_validate.date.rules.DateInPast)),
														input.AD_DTE,'');
			                                        
            
			
            self.event_date_type_cd             :=if((_validate.date.fIsValid(input.AD_DTE) and 
														_validate.date.fIsValid((input.AD_DTE),_validate.date.rules.DateInPast)),'FIL','');
            self.event_date_type_desc           :=if((_validate.date.fIsValid(input.AD_DTE) and 
														_validate.date.fIsValid((input.AD_DTE),_validate.date.rules.DateInPast)),'FILING','');
           

            self.event_desc                     :=if((_validate.date.fIsValid(input.AD_DTE) and 
														_validate.date.fIsValid((input.AD_DTE),_validate.date.rules.DateInPast)),'ARTICLES OF DISSOLUTION','');
			

            self                                := [];
		
			
			
		 end; // end of vt_Event_transform 
		 
		 Corp2.Layout_Corporate_Direct_Event_In vt_event5Transform(layouts_raw_input.vendor_Data  input):=transform ,skip(trim(input.WD_DTE,left,right) = '')
			self.corp_key					    := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				    := '50';
			self.corp_state_origin			    := 'VT';
			self.corp_process_date			    := fileDate;
			self.corp_sos_charter_nbr		    := trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.event_filing_date              :=if((_validate.date.fIsValid(input.WD_DTE) and 
														_validate.date.fIsValid((input.WD_DTE),_validate.date.rules.DateInPast)),
														input.WD_DTE,'');
			   
            self.event_date_type_cd             :=if((_validate.date.fIsValid(input.WD_DTE) and 
														_validate.date.fIsValid((input.WD_DTE),_validate.date.rules.DateInPast)),'FIL','');
            self.event_date_type_desc           :=if((_validate.date.fIsValid(input.WD_DTE) and 
														_validate.date.fIsValid((input.WD_DTE),_validate.date.rules.DateInPast)),'FILING','');
           

            self.event_desc                     :=if((_validate.date.fIsValid(input.WD_DTE) and 
														_validate.date.fIsValid((input.WD_DTE),_validate.date.rules.DateInPast)),'WITHDRAWN/DISSOLVED','');
			

            self                                := [];
		
			
			
		 end; // end of vt_Event_transform 
		 
		 

		 
		 Corp2.Layout_Corporate_Direct_Event_In vt_event6Transform(layouts_raw_input.vendor_Data  input):=transform,skip(trim(input.ME_DTE,left,right) = '')
			self.corp_key					    := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				    := '50';
			self.corp_state_origin			    := 'VT';
			self.corp_process_date			    := fileDate;
			self.corp_sos_charter_nbr		    := trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.event_filing_date              :=if((_validate.date.fIsValid(input.ME_DTE ) and 
														_validate.date.fIsValid((input.ME_DTE),_validate.date.rules.DateInPast)),
														input.ME_DTE ,'');
			                                        
            
			
            self.event_date_type_cd             :=if((_validate.date.fIsValid(input.ME_DTE) and 
														_validate.date.fIsValid((input.ME_DTE),_validate.date.rules.DateInPast)),'FIL','');
            self.event_date_type_desc           :=if((_validate.date.fIsValid(input.ME_DTE) and 
														_validate.date.fIsValid((input.ME_DTE),_validate.date.rules.DateInPast)),'FILING','');
           

            self.event_desc                     :=if((_validate.date.fIsValid(input.ME_DTE) and 
														_validate.date.fIsValid((input.ME_DTE),_validate.date.rules.DateInPast)),'MERGER','');
			

            self                                := [];
		  
			
			
		 end; // end of vt_Event_transform 
		 
		 
		 Corp2.Layout_Corporate_Direct_Event_In vt_event7Transform(layouts_raw_input.vendor_Data  input):=transform,skip(trim(input.DS_DATE,left,right) = '')
			self.corp_key					    := '50-' +trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			self.corp_vendor				    := '50';
			self.corp_state_origin			    := 'VT';
			self.corp_process_date			    := fileDate;
			self.corp_sos_charter_nbr		    := trim(input.FN_PREFIX,left, right)+'-'+trim(input.FN_SERIAL,left, right)+'-'+trim(input.FN_SUFFIX,left, right);
			
			
			self.event_filing_date              :=if((_validate.date.fIsValid(input.DS_DATE) and 
														_validate.date.fIsValid((input.DS_DATE),_validate.date.rules.DateInPast)),
														input.DS_DATE,'');
			                                        
            
			
            self.event_date_type_cd             :=if((_validate.date.fIsValid(input.DS_DATE) and 
														_validate.date.fIsValid((input.DS_DATE),_validate.date.rules.DateInPast)),'FIL','');
            self.event_date_type_desc           :=if((_validate.date.fIsValid(input.DS_DATE) and 
														_validate.date.fIsValid((input.DS_DATE),_validate.date.rules.DateInPast)),'FILING','');
           

            self.event_desc                     :=if((_validate.date.fIsValid(input.DS_DATE) and 
														_validate.date.fIsValid((input.DS_DATE),_validate.date.rules.DateInPast)),'DISSOLVED LETTER SENT','');
            self                                := [];
		
			
			
		 end; // end of vt_Event_transform 
			
		
		  //---------------------------- Clean corp Name and Addresses ---------------------//
		 corp2.layout_corporate_direct_corp_in CleanCorpNameAddr( corp2_mapping.Layout_CorpPreClean  input) := transform

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
	

			
			string182 clean_address1 			:= Address.CleanAddress182(trim(input.corp_address1_line1,left,right),
																				
														                   trim(trim(input.corp_address1_line2,left,right) + ', ' +
																				trim(input.corp_address1_line3,left,right)+ ' '+trim(input.corp_address1_line4,left,right) ,
																				left,right
																				)
																		   ); 
			self.corp_addr1_prim_range    		:= clean_address1[1..10];
			self.corp_addr1_predir 	      		:= clean_address1[11..12];
			self.corp_addr1_prim_name 	  		:= clean_address1[13..40];
			self.corp_addr1_addr_suffix   		:= clean_address1[41..44];
			self.corp_addr1_postdir 	    	:= clean_address1[45..46];
			self.corp_addr1_unit_desig 	  		:= clean_address1[28..56];
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
			
			
			

			string182 clean_address 			:= Address.CleanAddress182(trim(input.corp_ra_address_line1,left,right),
																				
														                   trim(trim(input.corp_ra_address_line2,left,right) + ', ' +
																				trim(input.corp_ra_address_line3,left,right)+ ' '+trim(input.corp_ra_address_line4,left,right) ,
																				left,right
																				)
																		   );

			self.corp_ra_prim_range    			:= clean_address[1..10];
			self.corp_ra_predir 	      		:= clean_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_address[41..44];
			self.corp_ra_postdir 	    		:= clean_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_address[28..56];
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
		 end; //*********************cleaned corp routine ends********
		
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
			
			string182 clean_address 		:= Address.CleanAddress182(trim(input.cont_address_line1,left,right),
																				
														                   trim(trim(input.cont_address_line2,left,right) + ', ' +
																				trim(input.cont_address_line3,left,right)+ ' '+trim(input.cont_address_line4,left,right) ,
																				left,right
																				)
																		   );

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
		//************************Cont cleaning ends*************************************
		     
			 
			 
			 
		
		  MapCorp1             := project(Files_Raw_Input.vendor_Data(filedate), vt_corp1Transform_Business(left)) ;
		  MapCorp2             := project(Files_Raw_Input.vendor_Data(filedate), vt_corp2Transform_Business(left)) ;
		  MapCorp3             := project(Files_Raw_Input.Tradenames_VendorData(filedate), vt_corpTransform_TradenameBusiness(left)) ;
		  MapCorp4             := project(Files_Raw_Input.LLC_VendorData(filedate), vt_corpTransform_LLCBusiness(left)) ;
		  
		 //*********************ExplosionTable lookupjoin**********
					
		
		 corp2_mapping.Layout_CorpPreClean findState(corp2_mapping.Layout_CorpPreClean input,  CountryStateCodeDescLayout r ) := transform
			self.corp_forgn_state_desc  := r.desc;
			
			self         			    := input;
			self                        := [];
		end; // end transform
		
		
		
		//StateCode join
		joinStateType := join(MapCorp1, StateCountryCodeTable,
								trim(left.corp_forgn_state_cd,left,right) = trim(right.code,left,right),
								findState(left,right),
								left outer, lookup
							  );
							  
				 
				 
	
	   corp2_mapping.Layout_CorpPreClean LLC_findState(corp2_mapping.Layout_CorpPreClean input,  CountryStateCodeDescLayout r ) := transform
			self.corp_forgn_state_desc  := r.desc;
			
			self         			    := input;
			self                        := [];
		end; // end transform
		
		
		
		//StateCode join
		LLC_joinStateType := join(MapCorp4, StateCountryCodeTable,
								trim(left.corp_forgn_state_cd,left,right) = trim(right.code,left,right),
								LLC_findState(left,right),
								left outer, lookup
							  );
        

							  
		corp2_mapping.Layout_CorpPreClean findStateForAdd(corp2_mapping.Layout_CorpPreClean input,  CountryStateCodeDescLayout r ) := transform
			self.corp_address1_line3   := r.code;
			self         			    := input;
			self                        := [];
		end; // end transform
		
		
		
		//StateCode join
		joinStateTypeForAdd := join(joinStateType , StateCountryCodeTable,
								trim(left.corp_address1_line3 ,left,right) = trim(right.code,left,right),
								findStateForAdd(left,right),
								left outer, lookup
							  );					  
 					  
								
		

                MapEvent1 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_event1Transform(left));
				MapEvent2 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_event2Transform(left));
				MapEvent3 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_event3Transform(left));
				MapEvent4 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_event4Transform(left));
				MapEvent5			:= project(Files_Raw_Input.vendor_Data(filedate), vt_event5Transform(left));
				MapEvent6 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_event6Transform(left));
				MapEvent7 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_event7Transform(left));
			    AllEvent            := MapEvent1+MapEvent2+MapEvent3+MapEvent4+MapEvent5+MapEvent6+MapEvent7;
				MapEvent            := sort(AllEvent,corp_key);
				
                MapAR 				:= project(Files_Raw_Input.vendor_Data(filedate), vt_arTransform(left));
				
				MapStock1 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_stock1Transform(left));
				MapStock2 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_stock2Transform(left));
				
				AllStock            :=MapStock1+MapStock2;
				MapStock 			:= sort(AllStock,corp_key);			
				
              
		        AllCorp             :=joinStateTypeForAdd+MapCorp2+MapCorp3+LLC_joinStateType;
				
				Mapcorp             :=sort(AllCorp,corp_key);
		 
		        cleanCorps          := project(Mapcorp,CleanCorpNameAddr(left));
				
				MapCont1 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_contact1Transform(left));
				MapCont2 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_contact2Transform(left));
				MapCont3 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_contact3Transform(left));
				MapCont4 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_contact4Transform(left));
				MapCont5 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_contact5Transform(left));
				MapCont6 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_contact6Transform(left));
				MapCont7 			:= project(Files_Raw_Input.vendor_Data(filedate), vt_contact7Transform(left));
				
				MapCont8 			:= project(Files_Raw_Input.Tradenames_VendorData(filedate), vt_contactTrade1_Transform(left));
				MapCont9 			:= project(Files_Raw_Input.Tradenames_VendorData(filedate), vt_contactTrade2_Transform(left));
				MapCont10 			:= project(Files_Raw_Input.Tradenames_VendorData(filedate), vt_contactTrade3_Transform(left));
				MapCont11 			:= project(Files_Raw_Input.Tradenames_VendorData(filedate), vt_contactTrade4_Transform(left));
				
				
				
				
				AllCont             :=MapCont1+MapCont2+MapCont3+MapCont4+MapCont5+MapCont6+MapCont7+MapCont8+MapCont9+MapCont10+MapCont11;
				Mapcont             :=dedup(sort(AllCont,corp_key),record,all);
				cleanCont           := project(MapCont, CleanContNameAddr(left));
				
			   
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_vt'	,cleanCorps	,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_vt'	,MapEvent 	,event_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_vt'		,MapAR			,ar_out			,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_vt'	,cleanCont	,cont_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_vt'	,MapStock		,stock_out	,,,pOverwrite);
                                    
		 mappedvt_Filing := parallel(                                                                                                                            
				 corp_out	
				,event_out
				,ar_out		
				,cont_out	
				,stock_out
		);        

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('vt',filedate,pOverwrite := pOverwrite))
			,mappedvt_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_vt')				  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_vt')						  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_vt')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_vt')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_vt')
			)
		);      

        return result;
   end;//Function end	
   
	  
 end;  // end of vt module	