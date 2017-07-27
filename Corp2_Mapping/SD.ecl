import Corp2,ut, lib_stringlib, _validate, Address, _control, versioncontrol;
// SD has two vendor layoutsin a tab delimited format.
export sd := MODULE;

 export Layouts_Raw_Input := MODULE;
 
   export    Vender_Main := record
   string2   Main_CORP_TYPE;
   string6   Main_CORP_NR;
   string105 CORP_NAME1;
   string105 CORP_NAME2;
   string30  CORP_ADDRESS1;
   string30  CORP_ADDRESS2;
   string20  CORP_CITY;
   string2   CORP_STATE;
   string10  CORP_ZIP;
   string20  CORP_CNTRY;
   string30  CORP_MADDRESS1;
   string30  CORP_MADDRESS2;
   string20  CORP_MCITY;
   string2   CORP_MSTATE;
   string10  CORP_MZIP;
   string70  AGENT_NAME;
   string30  AGENT_ADDRESS1;
   string30  AGENT_ADDRESS2;
   string20  AGENT_CITY;
   string2   AGENT_STATE;
   string10  AGENT_ZIP;
   string30  AGENT_MADDRESS1;
   string30  AGENT_MADDRESS2;
   string20  AGENT_MCITY;
   string2   AGENT_MSTATE;
   string10  AGENT_MZIP;
   string2   CORP_HOMESTATE;
   string8   CORP_DATE;
   string8   CORP_TERM;
   string1   CORP_ARFLAG;
   string8   CORP_AR1;
   string8   CORP_AR2;
   string8   CORP_AR3;
   string79  CORP_CMT;
   string29  CORP_PART_UNITS;
   string7   AT_ADD;
   string7   AT_UPD;
   string6   Main_AT_TIME;
   string4   Main_AT_TERMID;
   string2   CORP_ACTION;
   string8	 AGENT_ASSIGNDATE;   
   string8   AGENT_RESIGNDATE;
   string8   AGENT_EFFECTDATE;
   string8   CRA_NUM;
   string8   AGENT_USER;
   string8   AGENT_AUDITDATE;
   string7   AGENT_AUDITTIME;   
   string2   Main_lf;

 end;
	
  export Vendor_Subordinate := record
   string2 		Subordinate_CORP_TYPE;
   string6 		Subordinate_CORP_NR;
   string3 		ODI_TYPE;
   string2 		HIST_TYPE;
   string5	 	MAN_NO_DT;
   string7	    MAN_NO_RPT;
   string8 		FILE_AC_DATE;
   string75 	INSTRUMENT;
   string3 		FILE_FEE;
   string3 		PENALTY_FEE;
   string12 	CAPITAL_STOCK;
   string9 		PAR_VALUE;
   string5 		STOCK_CLASS;
   string105 	AC_NAME1;
   string105 	AC_NAME2;
   string58 	ODI_NAME;
   string30 	ODI_ADDRESS1;
   string30 	ODI_ADDRESS2;
   string20 	ODI_CITY;
   string2 		ODI_STATE;
   string10 	ODI_ZIP;
   string7 		AT_ADD_DATE;
   string7 		AT_UPD_DATE;
   string6		Subordinate_AT_TIME;
   string5 		Subordinate_AT_TERMID;
   string2 		ATTACHMENTS;
   string2 		PAGES;
   string2 		Subordinate_lf;
  
 end; 
 
  export Vender_Main_Subordinate := record
    Vender_Main;
    Vendor_Subordinate;
 
  end;
  
  
end; // end of Layouts_Raw_Input module
	
	export Files_Raw_Input := MODULE;
	
		export VenderMain (string fileDate)             := dataset('~thor_data400::in::corp2::'+fileDate+'::Vender_Main::sd',
														     layouts_Raw_Input.Vender_Main,flat)((integer)trim(Main_CORP_NR, left, right) <> 0, trim(Main_CORP_NR, left, right) <> '' );
																			 
		export VendorSubordinate (string fileDate)      := dataset('~thor_data400::in::corp2::'+fileDate+'::Vendor_Subordinate::sd',
														     layouts_Raw_Input.Vendor_Subordinate,flat)((integer)trim(Subordinate_CORP_NR, left, right) <> 0, trim(Subordinate_CORP_NR, left, right) <> '' );
		
		
	end;	
		
	

	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end;
	
	//StateCode type layout
		
		ForgnStateDescLayout := record,MAXLENGTH(100)
               string code;
               string desc;

         end; 

            

       ForgnStateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstateprovince_table', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
	
	
	//StatusCode type layout	
	    StatusCodeLayout := record,MAXLENGTH(100)
			string StatusCode;
			string StatusDesc;
			
		end;							
		  
		  
		StatusCodeTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::StatusCodeType_Table::sd',StatusCodeLayout,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));


  //CorpFiling type layout	
	    CorpFilingCodeLayout := record,MAXLENGTH(100)
			string CorpCode;
			string CorpDesc;
			
		end;							
		  
		  
		CorpFilingCodeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::CorpFilingType_Table::sd',CorpFilingCodeLayout,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
		
		
		
  //HistCode type layout	
	    HistCodeLayout := record,MAXLENGTH(100)
			string HistCode;
			string HistDesc;
			
		end;							
		  
		  
		HistCodeTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::HistCodeType_Table::sd',HistCodeLayout,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));	
	
	corp2_mapping.Layout_CorpPreClean sd_corp1Transform_Business(layouts_raw_input.Vender_Main input):=transform
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.corp_process_date			      := fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
       	    self.corp_key					      :='46-'+trim(input.Main_CORP_TYPE,left,right)+trim(input.Main_CORP_NR,left,right);
			self.corp_vendor					  :='46';
			self.corp_src_type					  :='SOS';
		    self.corp_state_origin                :='SD';
     	    self.corp_orig_sos_charter_nbr        :=trim(input.Main_CORP_TYPE,left,right)+trim(input.Main_CORP_NR,left,right);
			self.corp_ln_name_type_cd             :='01';
			self.corp_ln_name_type_desc           :='LEGAL';
		    self.corp_legal_name                  :=if(length(trim(input.CORP_NAME1,left,right)) >=105,trim(stringlib.StringtoUpperCase(input.CORP_NAME1),left,right)+trim(stringlib.StringtoUpperCase(input.CORP_NAME2),left,right),trim(stringlib.StringtoUpperCase(input.CORP_NAME1),left,right));			         														   
			self.corp_address1_line1              :=trimUpper(input.CORP_ADDRESS1);
			self.corp_address1_line2              :=trimUpper(input.CORP_ADDRESS2);
			self.corp_address1_line3              :=trimUpper(input.CORP_CITY);
			self.corp_address1_line4              :=if(trimUpper(input.CORP_STATE)<>'XX' and 
													   trimUpper(input.CORP_CNTRY)='',
													   trimUpper(input.CORP_STATE),
													   ''); 			                                           
			self.corp_address1_line5              :=if((integer) input.AGENT_ZIP <> 0,
													   trimUpper(input.AGENT_ZIP),
													   '');
	        self.corp_address1_line6              :=trimUpper(input.CORP_CNTRY);	
			self.corp_address1_type_cd            :=if(trimUpper(input.CORP_ADDRESS1)<>'','B','');
			self.corp_address1_type_desc          :=if(trimUpper(input.CORP_ADDRESS1)<>'','BUSINESS','');
			
            self.corp_address2_line1              :=trimUpper(input.CORP_MADDRESS1);
			self.corp_address2_line2              :=trimUpper(input.CORP_MADDRESS2);
			self.corp_address2_line3              :=trimUpper(input.CORP_MCITY);
			self.corp_address2_line4              :=trimUpper(input.CORP_MSTATE);
			self.corp_address2_line5              :=if((integer) input.AGENT_MZIP <> 0,
													   trimUpper(input.AGENT_MZIP),
													   '');
	        self.corp_address2_type_cd            :=if(trimUpper(input.CORP_MADDRESS1)<>'','M','');
			self.corp_address2_type_desc          :=if(trimUpper(input.CORP_MADDRESS1)<>'','MAILING','');			
		    self.corp_status_cd                   :=if(trim(input.CORP_ACTION,left,right)<>'',trim(input.CORP_ACTION,left,right),'');
         	
		    self.corp_term_exist_cd               :=if(trim(input.CORP_TERM,left,right)<>''and _validate.date.fIsValid(trim(input.CORP_TERM,left,right)),'D','');  
			self.corp_term_exist_exp              :=if(trim(input.CORP_TERM,left,right)<>''and _validate.date.fIsValid(trim(input.CORP_TERM,left,right)),trim(input.CORP_TERM,left,right),'');  
			self.corp_term_exist_desc             :=if(trim(input.CORP_TERM,left,right)<>''and _validate.date.fIsValid(trim(input.CORP_TERM,left,right)),'EXPIRATION DATE',''); 
			
			self.corp_inc_date                    :=if(trim(input.CORP_DATE,left,right)<>''and trim(input.CORP_HOMESTATE,left,right)='SD'and _validate.date.fIsValid(trim(input.CORP_DATE,left,right)) and 
														_validate.date.fIsValid(trim(input.CORP_DATE,left,right),_validate.date.rules.DateInPast)and
														(string)((integer)trim(input.CORP_DATE,left,right)) <> '0',trim(input.CORP_DATE,left,right),'');
            self.corp_forgn_date                  :=if(trim(input.CORP_DATE,left,right)<>''and trim(input.CORP_HOMESTATE,left,right)<>'SD'and _validate.date.fIsValid(trim(input.CORP_DATE,left,right)) and 
														_validate.date.fIsValid(trim(input.CORP_DATE,left,right),_validate.date.rules.DateInPast)and
														(string)((integer)trim(input.CORP_DATE,left,right)) <> '0',trim(input.CORP_DATE,left,right),'');
  		    self.corp_inc_state                   :=if(trim(input.CORP_HOMESTATE,left,right)='SD','SD','');
            self.corp_forgn_state_cd              :=if(trim(input.CORP_HOMESTATE,left,right)<>'SD',trim(input.CORP_HOMESTATE,left,right),'');
            self.corp_orig_bus_type_cd            :=if(trim(input.Main_CORP_TYPE,left,right)<>'',trim(input.Main_CORP_TYPE,left,right),'');
          	
		    self.corp_ra_name                     :=if(trim(input.AGENT_NAME,left,right)<>'',trim(stringlib.StringtoUpperCase(input.AGENT_NAME),left,right), '');
		    self.corp_ra_address_line1            :=if(trimUpper(input.AGENT_ADDRESS1)<>'',
													   trimUpper(input.AGENT_ADDRESS1),
													     if(trimUpper(input.AGENT_MADDRESS1)<>'',
														    trimUpper(input.AGENT_MADDRESS1),
													        ''));
			self.corp_ra_address_line2            :=if(trimUpper(input.AGENT_ADDRESS1)<>'',
													   trimUpper(input.AGENT_ADDRESS2),
													     if(trimUpper(input.AGENT_MADDRESS1)<>'',
														    trimUpper(input.AGENT_MADDRESS2),
													        ''));			 
			self.corp_ra_address_line3            :=if(trimUpper(input.AGENT_ADDRESS1)<>'',
													   trimUpper(input.AGENT_CITY),
													     if(trimUpper(input.AGENT_MADDRESS1)<>'',
														    trimUpper(input.AGENT_MCITY),
													        ''));			 
			self.corp_ra_address_line4            :=if(trimUpper(input.AGENT_ADDRESS1)<>'', 
													    if(trimUpper(input.AGENT_STATE)<>'XX',
													       trimUpper(input.AGENT_STATE),
														   ''),													   
													    if(trimUpper(input.AGENT_MADDRESS1)<>'',
														   if(trimUpper(input.AGENT_MSTATE)<>'XX',
													          trimUpper(input.AGENT_MSTATE),
														      ''),										
													       '')); 
			self.corp_ra_address_line5            :=if(trimUpper(input.AGENT_ADDRESS1)<>'' and 
													  (integer) input.AGENT_ADDRESS1 <> 0,
													   trimUpper(input.AGENT_ZIP),
													     if(trimUpper(input.AGENT_MADDRESS1)<>'' and 
														   (integer) input.AGENT_ADDRESS1 <> 0,
														    trimUpper(input.AGENT_MZIP),
													        ''));
			self.corp_ra_address_line6            :=if(trimUpper(input.CORP_CNTRY)<>'', 
													   trimUpper(input.CORP_CNTRY),
													   '');
			self.corp_ra_address_type_desc        :=if(trimUpper(input.AGENT_ADDRESS1)<>'' and 
													  (integer) input.AGENT_ADDRESS1 <> 0,
													   'REGISTERED OFFICE',
													     if(trimUpper(input.AGENT_MADDRESS1)<>'' and 
														   (integer) input.AGENT_ADDRESS1 <> 0,
														    'MAILING OFFICE',
													        '')); 																								  
			self.corp_ra_effective_date			  := if(_validate.date.fIsValid(trim(input.agent_effectDate,left,right)),
			                                            trim(input.agent_effectDate,left,right),
														'');
			self.corp_ra_resign_date			  := if(_validate.date.fIsValid(trim(input.agent_resignDate,left,right)),
			                                            trim(input.agent_resignDate,left,right),
														'');
			self.corp_ra_addl_info                := if(_validate.date.fIsValid(trim(input.agent_assignDate,left,right)),
			                                            'ASSIGNED DATE: '+
														 input.agent_assignDate[5..6] + '/' +
														 input.agent_assignDate[7..8] + '/' +
														 input.agent_assignDate[1..4],
														'');
			 
		    self                                  := [];
		
end; // end corp1 transform.

//corp2 transform. 
corp2_mapping.Layout_CorpPreClean sd_corp2Transform_Business(layouts_raw_input.Vendor_Subordinate input):=transform,skip(trim(stringlib.StringtoUpperCase(input.HIST_TYPE),left,right)<>'NC')
            self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
       	    self.corp_key					      :='46-'+trim(input.Subordinate_CORP_TYPE,left,right)+trim(input.Subordinate_CORP_NR,left,right);
			self.corp_vendor					  :='46';
			self.corp_src_type					  :='SOS';
		    self.corp_state_origin                :='SD';
     	    self.corp_orig_sos_charter_nbr        :=trim(input.Subordinate_CORP_TYPE,left,right)+trim(input.Subordinate_CORP_NR,left,right);
			self.corp_ln_name_type_cd             :='P';
			self.corp_ln_name_type_desc           :='PRIOR';
		    self.corp_legal_name                  :=trim(stringlib.StringtoUpperCase(input.AC_NAME1),left,right)+trim(stringlib.StringtoUpperCase(input.AC_NAME2));
			self                                  := [];
		
end; // end corp2 transform.

	// AR_TRANSFORM M.R.
		Corp2.Layout_Corporate_Direct_AR_In sd_arTransform(layouts_raw_input.Vendor_Subordinate input):=transform,skip(trim(stringlib.StringtoUpperCase(input.HIST_TYPE),left,right) <>'AR')
       	    self.corp_key					      :='46-'+trim(input.Subordinate_CORP_TYPE,left,right)+trim(input.Subordinate_CORP_NR,left,right);
			self.corp_vendor				      := '46';
			self.corp_state_origin			      := 'SD';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      :=trim(input.Subordinate_CORP_TYPE,left,right)+trim(input.Subordinate_CORP_NR,left,right);
			self.ar_report_nbr                    :=trim(input.MAN_NO_RPT,left,right);
            self.ar_filed_dt                      :=if(_validate.date.fIsValid(trim(input.FILE_AC_DATE,left,right)) and 
			                                            _validate.date.fIsValid(trim(input.FILE_AC_DATE,left,right),_validate.date.rules.DateInPast), trim(input.FILE_AC_DATE,left,right),'');
			self.ar_type                          :=trim(input.HIST_TYPE,left,right) ;
            self.ar_comment                       :=trim(input.INSTRUMENT,left,right) ;
			self                                  := [];

		end; // end of sd_AR_transform M.R.
		
			
		// Stock_TRANSFORM M.R.
		Corp2.Layout_Corporate_Direct_Stock_In sd_stockTransform(layouts_raw_input.Vender_Main_Subordinate input):=transform
			
       	    self.corp_key					      :='46-'+trim(input.Subordinate_CORP_TYPE,left,right)+trim(input.Subordinate_CORP_NR,left,right);
			self.corp_vendor				      := '46';
			self.corp_state_origin			      := 'SD';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.Subordinate_CORP_TYPE,left,right)+trim(input.Subordinate_CORP_NR,left,right);
			self.stock_type                       :='COM';
			integer stocktotalcapital             :=if ((integer)trim(input.CAPITAL_STOCK,left, right)= 0 or trim(input.CAPITAL_STOCK,left, right) = '', 0, (integer)trim(input.CAPITAL_STOCK,left, right) ) ;

			self.stock_total_capital              :=(string)stocktotalcapital ;
					
            decimal9_5 parvalue                   := if ((integer)trim(input.par_value,left, right)= 0 or trim(input.par_value, left, right) = '', 0, 
                                                            (unsigned6)trim(input.par_value, left, right)/100000);
		   
			self.stock_par_value                  :=(string)parvalue;
			// Following removed per Rosemary.
			// self.stock_addl_info                  :=if(trim(input.CORP_PART_UNITS,left, right)<>'',trim(input.CORP_PART_UNITS,left, right),'');
        	self                                  := [];
			
			
		end; // end of sd_Stock_transform M.R.
		
		// Event_TRANSFORM M.R.
		Corp2.Layout_Corporate_Direct_Event_In sd_eventTransform(layouts_raw_input.Vendor_Subordinate input):=transform,
										skip(trimUpper(input.HIST_TYPE) in ['AR',''])
			
       	    self.corp_key					    :='46-'+trim(input.Subordinate_CORP_TYPE,left,right)+trim(input.Subordinate_CORP_NR,left,right);
			self.corp_vendor				    := '46';
			self.corp_state_origin			    := 'SD';
			self.corp_process_date			    := fileDate;
			self.corp_sos_charter_nbr		    := trim(input.Subordinate_CORP_TYPE,left,right)+trim(input.Subordinate_CORP_NR,left,right);
			self.event_filing_date              :=if(trim(input.FILE_AC_DATE,left,right)<>'' and  _validate.date.fIsValid(trim(input.FILE_AC_DATE,left,right)) and 
			                                            _validate.date.fIsValid(trim(input.FILE_AC_DATE,left,right),_validate.date.rules.DateInPast),
			                                          trim(input.FILE_AC_DATE,left,right),
			                                         '');
            self.event_date_type_cd             :=if(trim(input.FILE_AC_DATE,left,right)<>'' and  _validate.date.fIsValid(trim(input.FILE_AC_DATE,left,right)) and 
			                                            _validate.date.fIsValid(trim(input.FILE_AC_DATE,left,right),_validate.date.rules.DateInPast), 'FIL',
			                                        '');
													
            self.event_date_type_desc           :=if(trim(input.FILE_AC_DATE,left,right)<>'' and  _validate.date.fIsValid(trim(input.FILE_AC_DATE,left,right)) and 
			                                            _validate.date.fIsValid(trim(input.FILE_AC_DATE,left,right),_validate.date.rules.DateInPast), 'FILING',
			                                        '');
			self.event_filing_reference_nbr	    := trim(input.MAN_NO_RPT,left,right);
			self.event_filing_cd                :=if(trim(input.HIST_TYPE,left,right)<>'',trim(input.HIST_TYPE,left,right),'');	
			
             INSTRUMENT                         :=if(trim(input.INSTRUMENT,left,right)<>'',trim(input.INSTRUMENT,left,right),'');
			 FILINGFEE                         :=if(trim(input.FILE_FEE,left,right)<>''and (string)((integer)trim(input.FILE_FEE,left,right)) <> '0', 'FILING-FEE:'+trim(input.FILE_FEE,left,right),'');
			 ATTACHMENTS                        :=if(trim(input.ATTACHMENTS,left,right)<>'', 'ATTACHMENTS:'+trim(input.ATTACHMENTS,left,right),'');
			 PAGES                              :=if(trim(input.PAGES,left,right)<>'', 'PAGES:'+trim(input.PAGES,left,right),'');

			
            self.event_desc                     :=INSTRUMENT+' '+FILINGFEE+' '+ATTACHMENTS+' '+PAGES;
            self                                := [];
		
			
			
		end; // end of sd_Event_transform M.R.
		
		// contact_TRANSFORM
		corp2_mapping.Layout_ContPreClean sd_contactTransform(layouts_raw_input.Vender_Main_Subordinate input):=transform,skip(trim(input.ODI_TYPE,left,right) ='')
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
       	    self.corp_key					  :='46-'+trim(input.Subordinate_CORP_TYPE,left,right)+trim(input.Subordinate_CORP_NR,left,right);
			self.corp_vendor				  :='46';
			self.corp_state_origin			  :='SD';
			self.corp_process_date			  :=fileDate;
			self.corp_orig_sos_charter_nbr    :=trim(input.Main_CORP_TYPE,left,right)+trim(input.Main_CORP_NR,left,right);
			self.corp_legal_name              :=if(length(trim(input.CORP_NAME1,left,right)) >=105,trim(stringlib.StringtoUpperCase(input.CORP_NAME1),left,right)+trim(stringlib.StringtoUpperCase(input.CORP_NAME2),left,right), trim(stringlib.StringtoUpperCase(input.CORP_NAME1),left,right));
			self.cont_type_cd                 :=trim(input.ODI_TYPE,left,right);
			self.cont_type_desc               :=trim(input.ODI_TYPE,left,right);
			//self.cont_title1_desc             :='';
            self.cont_name                    :=if(trim(input.ODI_NAME,left,right)<>'',trim(stringlib.StringtoUpperCase(input.ODI_NAME),left,right), '');
			self.cont_address_line1           :=if(trim(input.ODI_ADDRESS1,left,right)<>'',trim(stringlib.StringtoUpperCase(input.ODI_ADDRESS1),left,right),'');
			self.cont_address_line2           :=if(trim(input.ODI_ADDRESS2,left,right)<>'',trim(stringlib.StringtoUpperCase(input.ODI_ADDRESS2),left,right),'');
			self.cont_address_line3           :=if(trim(input.ODI_CITY,left,right)<>''and regexreplace('[.]*$',trim(input.ODI_CITY,left,right),'',NOCASE)<>'',trim(stringlib.StringtoUpperCase(input.ODI_CITY),left,right),'');
			self.cont_address_line4           :=if(trim(input.ODI_STATE,left,right)<>''and 
			                                           trim(stringlib.StringtoUpperCase(input.ODI_STATE),left,right)<>'XX' ,trim(stringlib.StringtoUpperCase(input.ODI_STATE),left,right),'');
			self.cont_address_line5           :=if(trim(input.ODI_ZIP,left,right)<>'',trim(input.ODI_ZIP,left,right),'');
										   
			self.cont_address_type_cd         :=if(trim(input.ODI_ADDRESS1,left,right)<>''or trim(input.ODI_ADDRESS2,left,right)<>''or
			                                           trim(input.ODI_CITY,left,right)<>'' or trim(input.ODI_STATE,left,right)<>'' or trim(input.ODI_ZIP,left,right)<>'','T','');
			self.cont_address_type_desc       :=if(trim(input.ODI_ADDRESS1,left,right)<>''or trim(input.ODI_ADDRESS2,left,right)<>''or
			                                           trim(input.ODI_CITY,left,right)<>'' or trim(input.ODI_STATE,left,right)<>'' or trim(input.ODI_ZIP,left,right)<>'','CONTACT','');
            self                              := [];
			
		end; // end of sd_contact_transform     
		
		
		
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
	

			
			string182 clean_address1 			:= Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' + 														                        
												trim(input.corp_address1_line2,left,right),left,right),														                   
												trim(trim(input.corp_address1_line3,left,right) + ', ' +
												trim(input.corp_address1_line4,left,right) + ' ' +
												trim(input.corp_address1_line5,left,right) +
												trim(input.corp_address1_line6,left,right),left,right));

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
			
			
			string182 clean_address2 			:= Address.CleanAddress182(trim(trim(input.corp_address2_line1,left,right) + ' ' + 														                        
												trim(input.corp_address2_line2,left,right),left,right),														                   
												trim(trim(input.corp_address2_line3,left,right) + ', ' +
												trim(input.corp_address2_line4,left,right) + ' ' +
												trim(input.corp_address2_line5,left,right) +
												trim(input.corp_address2_line6,left,right),left,right));
			self.corp_addr2_prim_range    		:= clean_address2[1..10];
			self.corp_addr2_predir 	      		:= clean_address2[11..12];
			self.corp_addr2_prim_name 	  		:= clean_address2[13..40];
			self.corp_addr2_addr_suffix   		:= clean_address2[41..44];
			self.corp_addr2_postdir 	    	:= clean_address2[45..46];
			self.corp_addr2_unit_desig 	  		:= clean_address2[47..56];
			self.corp_addr2_sec_range 	  		:= clean_address2[57..64];
			self.corp_addr2_p_city_name	  		:= clean_address2[65..89];
			self.corp_addr2_v_city_name	  		:= clean_address2[90..114];
			self.corp_addr2_state 				:= clean_address2[115..116];
			self.corp_addr2_zip5 		    	:= clean_address2[117..121];
			self.corp_addr2_zip4 		    	:= clean_address2[122..125];
			self.corp_addr2_cart 		    	:= clean_address2[126..129];
			self.corp_addr2_cr_sort_sz 	 		:= clean_address2[130];
			self.corp_addr2_lot 		      	:= clean_address2[131..134];
			self.corp_addr2_lot_order 	  		:= clean_address2[135];
			self.corp_addr2_dpbc 		    	:= clean_address2[136..137];
			self.corp_addr2_chk_digit 	  		:= clean_address2[138];
			self.corp_addr2_rec_type		  	:= clean_address2[139..140];
			self.corp_addr2_ace_fips_st	  		:= clean_address2[141..142];
			self.corp_addr2_county 	  			:= clean_address2[143..145];
			self.corp_addr2_geo_lat 	    	:= clean_address2[146..155];
			self.corp_addr2_geo_long 	    	:= clean_address2[156..166];
			self.corp_addr2_msa 		      	:= clean_address2[167..170];
			self.corp_addr2_geo_blk				:= clean_address2[171..177];
			self.corp_addr2_geo_match 	  		:= clean_address2[178];
			self.corp_addr2_err_stat 	    	:= clean_address2[179..182];
												
						
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' + 														                        
												trim(input.corp_ra_address_line2,left,right),left,right),														                   
												trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
												trim(input.corp_ra_address_line4,left,right) + ' ' +
												trim(input.corp_ra_address_line5,left,right) +
												trim(input.corp_ra_address_line6,left,right),left,right));
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
		
		
		     //*********************cleaned corp routine ends********
			 
			 
			 
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
											trim(input.cont_address_line4,left,right) + ' ' +
											trim(input.cont_address_line5,left,right) +
											trim(input.cont_address_line6,left,right),left,right));

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
		

		 MapCorp1 := project(Files_Raw_Input.VenderMain(fileDate) , sd_corp1Transform_Business(left)) ;
		 MapCorp2 := project(Files_Raw_Input.VendorSubordinate(fileDate) , sd_corp2Transform_Business(left)) ;
		 MapEvent := project(Files_Raw_Input.VendorSubordinate(filedate), sd_eventTransform(left));
		 
		 
		 
		//---------------------------layouts join for cont-----------------------//
		
		Layouts_Raw_Input.Vender_Main_Subordinate MergeCont(Layouts_Raw_Input.Vender_Main l, Layouts_Raw_Input.Vendor_Subordinate r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinMainSubordinate := join(Files_Raw_Input.VenderMain(fileDate),Files_Raw_Input.VendorSubordinate(fileDate),
								trim((trim(left.Main_CORP_TYPE,left,right)+trim(left.Main_CORP_NR,left,right)),left,right) = trim((trim(right.Subordinate_CORP_TYPE,left,right)+trim(right.Subordinate_CORP_NR,left,right)),left,right),
								MergeCont(left,right),
								left outer
							);
							
							
		 
		 //--------------------------- Explosion Table Logic -----------------------//
		 
		 //for event
		Corp2.Layout_Corporate_Direct_Event_In findHist(Corp2.Layout_Corporate_Direct_Event_In input,  HistCodeLayout r ) := transform
			self.event_filing_desc      := trim(stringlib.StringtoUpperCase(r.Histdesc),left,right); 
			self         			    := input;
			self                        := [];
		end; 
		
		// end transform
		
			
		//HistCode join
		
		joinHistType := 	join(MapEvent,HistCodeTypeTable,
									trim(left.event_filing_cd,left,right) = trim(right.Histcode,left,right),
									findHist(left,right),
									left outer, lookup
								);
		 
		
		 //FOR CORP
		 
		 corp2_mapping.Layout_CorpPreClean findStatus(corp2_mapping.Layout_CorpPreClean input, StatusCodeLayout r ) := transform
			self.corp_status_desc       := r.Statusdesc;
			self         			    := input;
			self                        := [];
		end; 
		
		// end transform
		
			
		//StatusCode join
		
		joinStatusType :=join(MapCorp1,StatusCodeTypeTable,
									trim(left.corp_status_cd,left,right) =  trim(right.Statuscode,left,right),
									findStatus(left,right),
									left outer, lookup
								);
								
	   //StateCode join
		
		 corp2_mapping.Layout_CorpPreClean findState(corp2_mapping.Layout_CorpPreClean input, ForgnStateDescLayout r ) := transform
			self.corp_forgn_state_desc  := r.desc;
			self         			    := input;
			self                        := [];
		end; 
		
		// end transform
		
			
		
		
		joinStateType := 	join(joinStatusType,ForgnStateTable,
									trim(left.corp_forgn_state_cd,left,right) =  trim(right.code,left,right),
									findState(left,right),
									left outer, lookup
								);
								
								
									
		corp2_mapping.Layout_CorpPreClean FilingTypeCode(corp2_mapping.Layout_CorpPreClean input, CorpFilingCodeLayout r ) := transform
			      self.corp_orig_bus_type_desc         := trim(stringlib.StringtoUpperCase(r.CorpDesc),left,right);
			      self         			               := input;
			      self                                 := [];
		 end; // end transform
		
		//FilingCode join
		 joinFilingType :=join(joinStateType,CorpFilingCodeTable,
									trim(left.corp_orig_bus_type_cd,left,right) = trim(right.CorpCode,left,right),
									FilingTypeCode(left,right),
									left outer, lookup
								);
								
				 AllCorp:=joinFilingType +MapCorp2;				
				 MapCorp := sort(AllCorp,corp_key);
		        cleanCorps := project(MapCorp,CleanCorpNameAddr(left));						
		       					
				
               
                MapAR 								:= project(Files_Raw_Input.VendorSubordinate(filedate), sd_arTransform(left));
				MapStock 							:= project(joinMainSubordinate, sd_stockTransform(left));
				MapCont 							:= project(joinMainSubordinate, sd_contactTransform(left));
			    cleanCont                           := project(MapCont , CleanContNameAddr(left));
		
		
		
		
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_sd'	,cleanCorps		,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_sd'	,joinHistType ,event_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_sd'		,MapAR				,ar_out			,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_sd'	,cleanCont		,cont_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_sd'	,MapStock			,stock_out	,,,pOverwrite);
                                                                                                                                                         
		 mappedsd_Filing := parallel(
				 corp_out	
				,event_out
				,ar_out		
				,cont_out	
				,stock_out
		);        

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('sd',filedate,pOverwrite := pOverwrite))
			,mappedsd_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_sd')				  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_sd')						  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_sd')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_sd')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_sd')
			)
		);
		 
		return result;
	end;					 
	
end; // end of sd module

		