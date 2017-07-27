import Corp2,ut, lib_stringlib, _validate, Address, _control, versioncontrol;
export AZ := MODULE;
// AZ has four vendor layouts.
	export Layouts_Raw_Input := MODULE;
	
	export COREXT := record
	   
    string4 Record_Id_1000;
		string60 Compacted_Corp_Name;
		string9 File_Number;
		string60 Corporation_Name;
		string30 First_Address_Line1;
		string30 First_Address_Line2;
		string30 First_Address_Line3;
		string20 First_Address_City;
		string2 First_Address_State;
		string9 First_Address_Zip_Code;
		string10 County;
		string8 Amendment_Date;
		string8 Amendment_Publication_Date;
		string8 Annual_Report_Received_Date;
		string2 Status_Code;
		string1 Amendment_Publication_Exception_Cod;
		string2 Fiscal_Month;
		string4 Last_Year_Annual_Report_Filed;
		string2 Prvious_Fiscal_Month;
		string4 Last_Year_Annual_Report_Filed_for_P;
		string8 Extension_Due_Date;
		string8 Date_of_Incorporation;
		string8 Disclosure_Date;
		string8 Date_of_Approval_of_Articles_of_Inc;
		string8 Renewal_Date;
		string140 Comments;
		string1 Corporation_Type_Code;
		string1 Exception_Code;
		string2 Domicile_State;
		string2 Corporation_Life;
		string8 Expiration_Date;
		string1 Dissolution_Code;
		string8 Dissolution_Date;
		string32 Revocation_Comment1;
		string32 Revocation_Comment2;
		string8 Stat_Agent_Appointment_Resign_Date;
		string1 Stat_Agent_Appointment_Resign_Code;
		string8 Date_of_Pub_of_art_of_inc;
		string8 Status_Date;
		string30 Statutory_Agent_Name;
		string30 Statutory_Agent_Address_Line_1;
		string30 Statutory_Agent_Address_Line_2;
		string30 Statutory_Agent_Address_Line_3;
		string20 Statutory_Agent_Address_City;
		string2 Statutory_Agent_Address_State;
		string9 Statutory_Agent_Address_Zip_Code;
		string30 Second_Address_Line1;
		string30 Second_Address_Line2;
		string30 Second_Address_Line3;
		string20 Second_Address_City;
		string2 Second_Address_State;
		string9 Second_Address_Zip_Code;
		string8 Merger_Date;
		string8 Merger_Publication_Date;
		string1 Merger_Publication_Exception_Code;
		string8 Bankruptcy_Date;
		string8 Annual_Report_Returned_Date;
		string2 Annual_Report_Returned_Code;
		string1 Corext_lf;
	
end;
	
	export CHGEXT := record
		string4 Record_Id_2001_2999;
		string60  Chgext_Compacted_Corp_Name;
		string9 File_Number;
		string1 Change_Merge_Code;
		string8 Change_Merge_Date;
		string60 Change_Merge_From_Name;
		string1  Chgext_lf;
	end;
	
	
	
		 
	export FLMEXT := record

		string4 Record_Id_3001_3999;
		string60 Flmext_Compacted_Corp_Name;
		string9 File_Number;
		string11 Microfilm_Location;
		string8 Date_Document_Received;
		string50 Document_Description;
		string1 Flmext_lf;

end;


export COREXT_FLMEXT := record
        COREXT;
		string4 Record_Id_3001_3999;
		string60 Flmext_Compacted_Corp_Name;
		string11 Microfilm_Location;
		string8 Date_Document_Received;
		string50 Document_Description;
		string1 Flmext_lf;

end;


   export OFFEXT := record

   string9 Officer_File_Number;
   string2 Title_Code;
   string30 Officer_Name;
   string30 Officer_Address_Line1;
   string30 Officer_Address_Line2;
   string30 Officer_Address_Line3;
   string20 Officer_Address_City;
   string2 Officer_Address_State;
   string9 Officer_Addr_Zip;
   string1 Offext_lf;
end;


   export COREXT_OFFEXT := record

   COREXT;
   OFFEXT;
end;
	
  end; // end of Layouts_Raw_Input module78
	
	export Files_Raw_Input := MODULE;
	
		export Corext (string fileDate)             := dataset('~thor_data400::in::corp2::'+fileDate+'::COREXT::az',
														     layouts_Raw_Input.COREXT,flat);
																			 
		export Chgext (string fileDate)             := dataset('~thor_data400::in::corp2::'+fileDate+'::CHGEXT::az',
														     layouts_Raw_Input.CHGEXT,flat);
															 
		export Flmext (string fileDate)             := dataset('~thor_data400::in::corp2::'+fileDate+'::FLMEXT::az',
														     layouts_Raw_Input.FLMEXT,flat);
														
		export Offext (string fileDate)             := dataset('~thor_data400::in::corp2::'+fileDate+'::OFFEXT::az',
		                                                     layouts_Raw_Input.OFFEXT,flat);
		
		
	end;	
		
	
	export Update(string filedate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
	    //StatusCode type layout	
	    StatusCodeLayout := record,MAXLENGTH(100)
			string StatusCode;
			string StatusDesc;
			
		end;							
		  
		  
		StatusCodeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::StatusCodeType_Table::az',StatusCodeLayout,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
		
		//StateCode type layout
		
		ForgnStateDescLayout := record,MAXLENGTH(100)
               string code;
               string desc;

         end; 

            

       ForgnStateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstateprovince_table', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
	
	//corp1 transform
	corp2_mapping.Layout_CorpPreClean AZ_corp1Transform_Business(layouts_raw_input.COREXT  input):=transform
	        self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='04-' +trim(input.FILE_NUMBER, left, right);
			self.corp_vendor					  :='04';
		    self.corp_state_origin                :='AZ';
			self.corp_process_date				  := fileDate;    
			self.corp_orig_sos_charter_nbr        := trim(input.FILE_NUMBER, left, right);
			self.corp_legal_name                  :=if (trim(stringlib.StringtoUpperCase(input.Corporation_Name),left,right)<>'',trim(stringlib.StringtoUpperCase(input.Corporation_Name), left, right),'');
		    
			self.corp_ln_name_type_cd             :='01';
			self.corp_ln_name_type_desc           :='LEGAL';
			
         	
			
			
			
			self.corp_address1_line1              :=if(trim(stringlib.StringtoUpperCase(input.FIRST_ADDRESS_LINE1),left,right)<>'ENTITY DID NOT PROVIDE' 
			                                        and trim(stringlib.StringtoUpperCase(input.FIRST_ADDRESS_LINE1),left,right)<>'NOT REQUIRED'  
													and regexreplace('[X]*$',trim(input.FIRST_ADDRESS_LINE1,left,right),'',NOCASE) <>'',trim(input.FIRST_ADDRESS_LINE1,left,right),'');
			self.corp_address1_line2              :=if(trim(stringlib.StringtoUpperCase(input.FIRST_ADDRESS_LINE2),left,right)<>'COMPANY ADDRESS' 
			                                         and trim(stringlib.StringtoUpperCase(input.FIRST_ADDRESS_LINE2),left,right)<>'NOT REQUIRED'  
													 and regexreplace('[X]*$',trim(input.FIRST_ADDRESS_LINE2,left,right),'',NOCASE) <>'' ,trim(input.FIRST_ADDRESS_LINE2,left,right),'');
			self.corp_address1_line3              :=if( regexreplace('[X]*$',trim(input.FIRST_ADDRESS_LINE3,left,right),'',NOCASE) <>'' 
			                                          and trim(stringlib.StringtoUpperCase(input.FIRST_ADDRESS_LINE3),left,right)<>'NOT REQUIRED' ,trim(input.FIRST_ADDRESS_LINE3,left,right),'');
			self.corp_address1_line4              :=if( regexreplace('[X]*$',trim(input.FIRST_ADDRESS_CITY,left,right),'',NOCASE) <>'' 
			                                          and trim(stringlib.StringtoUpperCase(input.FIRST_ADDRESS_CITY),left,right)<>'NOT REQUIRED' ,trim(input.FIRST_ADDRESS_CITY,left,right),'');
			self.corp_address1_line5              :=if( regexreplace('[X]*$',trim(input.FIRST_ADDRESS_STATE,left,right),'',NOCASE) <>'' 
			                                         and trim(stringlib.StringtoUpperCase(input.FIRST_ADDRESS_STATE),left,right)<>'NOT REQUIRED' ,trim(input.FIRST_ADDRESS_STATE,left,right),'');
			self.corp_address1_line6              :=if( regexreplace('[X]*$',trim(input.FIRST_ADDRESS_ZIP_CODE,left,right),'',NOCASE) <>'' 
			                                          and trim(stringlib.StringtoUpperCase(input.FIRST_ADDRESS_ZIP_CODE),left,right)<>'NOT REQUIRED' ,trim(input.FIRST_ADDRESS_ZIP_CODE,left,right),'');
													  
													  
			self.corp_address1_type_cd            :=if(trim(self.corp_address1_line1,left,right)<>''or trim(self.corp_address1_line2,left,right)<>'' or
			                                           trim(self.corp_address1_line3,left,right)<>'' or trim(self.corp_address1_line4,left,right)<>'' or
												       trim(self.corp_address1_line5,left,right)<>''or trim(self.corp_address1_line6,left,right)<>'', 'B','');
			self.corp_address1_type_desc          :=if(trim(self.corp_address1_line1,left,right)<>''or trim(self.corp_address1_line2,left,right)<>'' or
			                                           trim(self.corp_address1_line3,left,right)<>'' or trim(self.corp_address1_line4,left,right)<>'' or
												       trim(self.corp_address1_line5,left,right)<>''or trim(self.corp_address1_line6,left,right)<>'', 'BUSINESS','');
													   
			 self.corp_address2_line1              :=if(trim(stringlib.StringtoUpperCase(input.Second_Address_Line1),left,right)<>'ENTITY DID NOT PROVIDE' 
			                                        and trim(stringlib.StringtoUpperCase(input.Second_Address_Line1),left,right)<>'NOT REQUIRED'  
													and regexreplace('[X]*$',trim(input.Second_Address_Line1,left,right),'',NOCASE) <>'' ,trim(input.Second_Address_Line1,left,right),'');
			self.corp_address2_line2              :=if(trim(stringlib.StringtoUpperCase(input.Second_Address_Line2),left,right)<>'COMPANY ADDRESS' 
			                                        and trim(stringlib.StringtoUpperCase(input.Second_Address_Line2),left,right)<>'NOT REQUIRED'  
													 and regexreplace('[X]*$',trim(input.Second_Address_Line2,left,right),'',NOCASE) <>'' ,trim(input.Second_Address_Line2,left,right),'');
			self.corp_address2_line3              :=if( regexreplace('[X]*$',trim(input.Second_Address_Line3,left,right),'',NOCASE) <>'' 
			                                          and trim(stringlib.StringtoUpperCase(input.Second_Address_Line3),left,right)<>'NOT REQUIRED'  ,trim(input.Second_Address_Line3,left,right),'');
			self.corp_address2_line4              :=if( regexreplace('[X]*$',trim(input.Second_Address_CITY,left,right),'',NOCASE) <>'' and trim(stringlib.StringtoUpperCase(input.Second_Address_CITY),left,right)<>'NOT REQUIRED' 
			                                        ,trim(input.Second_Address_CITY,left,right),'');
			self.corp_address2_line5              :=if( regexreplace('[X]*$',trim(input.Second_Address_STATE,left,right),'',NOCASE) <>'' and trim(stringlib.StringtoUpperCase(input.Second_Address_STATE),left,right)<>'NOT REQUIRED' 
			                                         ,trim(input.Second_Address_STATE,left,right),'');
			self.corp_address2_line6              :=if( regexreplace('[X]*$',trim(input.Second_Address_ZIP_CODE,left,right),'',NOCASE) <>'' and trim(stringlib.StringtoUpperCase(input.Second_Address_ZIP_CODE),left,right)<>'NOT REQUIRED'  
			                                         ,trim(input.Second_Address_ZIP_CODE,left,right),''); 
													 
													 
			self.corp_address2_type_cd            :=if(trim(self.corp_address2_line1,left,right)<>''or trim(self.corp_address2_line2,left,right)<>'' or
			                                           trim(self.corp_address2_line3,left,right)<>'' or trim(self.corp_address2_line4,left,right)<>'' or
												       trim(self.corp_address2_line5,left,right)<>''or trim(self.corp_address2_line6,left,right)<>'','M','');
													   
			self.corp_address2_type_desc          :=if(trim(self.corp_address2_line1,left,right)<>''or trim(self.corp_address2_line2,left,right)<>'' or
			                                           trim(self.corp_address2_line3,left,right)<>'' or trim(self.corp_address2_line4,left,right)<>'' or
												       trim(self.corp_address2_line5,left,right)<>''or trim(self.corp_address2_line6,left,right)<>'','MAILING','');
													   
		    self.corp_status_cd                   :=trim(input.STATUS_CODE,left,right);
         	self.corp_status_date                 :=if(_validate.date.fIsValid(trim(input.STATUS_DATE,left,right))and 
			                                         _validate.date.fIsValid(trim(input.STATUS_DATE,left,right),_validate.date.rules.DateInPast),trim(input.STATUS_DATE,left,right),'');
			self.corp_term_exist_cd               :=if(trim(input.EXPIRATION_DATE,left,right)<>''and _validate.date.fIsValid(trim(input.EXPIRATION_DATE,left,right)),'D',
													  if(trim(stringlib.StringtoUpperCase(input.CORPORATION_LIFE),left,right) ='PP' , 'P',''));										 
		    self.corp_term_exist_desc             :=if(trim(input.EXPIRATION_DATE,left,right)<>''and _validate.date.fIsValid(trim(input.EXPIRATION_DATE,left,right)),'EXPIRATION',
													  if(trim(stringlib.StringtoUpperCase(input.CORPORATION_LIFE),left,right) ='PP' , 'PERPETUAL',''));	
			self.corp_term_exist_exp              :=if(trim(input.EXPIRATION_DATE,left,right)<>''and _validate.date.fIsValid(trim(input.EXPIRATION_DATE,left,right)),trim(input.EXPIRATION_DATE,left,right),'');
			self.corp_inc_date                    :=if(trim(stringlib.StringtoUpperCase(input.DOMICILE_STATE),left,right) ='AZ'and 
			                                            _validate.date.fIsValid(trim(input.DATE_OF_INCORPORATION,left,right)) and 
														_validate.date.fIsValid(trim(input.DATE_OF_INCORPORATION,left,right),_validate.date.rules.DateInPast)and
														(string)((integer)trim(input.DATE_OF_INCORPORATION,left,right)) <> '0',trim(input.DATE_OF_INCORPORATION,left,right),'');
            self.corp_forgn_date                  :=if(trim(stringlib.StringtoUpperCase(input.DOMICILE_STATE),left,right)<>'AZ'and 
			                                            _validate.date.fIsValid(trim(input.DATE_OF_INCORPORATION,left,right)) and 
														_validate.date.fIsValid(trim(input.DATE_OF_INCORPORATION,left,right),_validate.date.rules.DateInPast)and
														(string)((integer)trim(input.DATE_OF_INCORPORATION,left,right)) <> '0',trim(input.DATE_OF_INCORPORATION,left,right),'');
  		    self.corp_inc_state                   :=if(trim(stringlib.StringtoUpperCase(input.DOMICILE_STATE),left,right)='AZ'
			                                            ,trim(input.DOMICILE_STATE,left,right),'');
            self.corp_forgn_state_cd              :=if(trim(stringlib.StringtoUpperCase(input.DOMICILE_STATE),left,right)<>'AZ'
			                                            ,trim(input.DOMICILE_STATE,left,right),'');
            
		    self.corp_orig_bus_type_cd            :=trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right);
            self.corp_orig_bus_type_desc          :=map(	
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'A'  => 'CLOSE CORPORATION',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'B'  => 'BUSINESS',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'C'  => 'CO-OP',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'D'  => 'NAME REGISTRATION',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'I'  => 'NON-FILING-INSUR',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'L'  => 'LOAN',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'N'  => 'NON-PROFIT',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'P'  => 'PROFIT',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'R'  => 'PROFESSIONAL',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'S'  => 'CORPORATE SOLE',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'T'  => 'TRUST',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'U'  => 'NON FILING C.U.',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'W'  => 'DOMESTIC L.L.C.',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'X'  => 'FOREIGN L.L.C.',
														trim(stringlib.StringtoUpperCase(input.Corporation_Type_Code),left,right)=  'Y'  => 'PROFESSIONAL L.L.C.',
									
									
									
									''
									);
			
			BANKRUPTCYDATE 							:=if(trim(input.BANKRUPTCY_DATE,left,right)<>'','BANKRUPTCY DATE: '+trim(input.BANKRUPTCY_DATE,left,right),'');
			COMMENTS 								:=if(trim(input.COMMENTS,left,right)<>'',trim(input.COMMENTS,left,right),'');
			REVOCATIONCOMMENT1 						:=if(trim(input.REVOCATION_COMMENT1,left,right)<>'',trim(input.REVOCATION_COMMENT1,left,right),'');
			REVOCATIONCOMMENT2 						:=if(trim(input.REVOCATION_COMMENT2,left,right)<>'',trim(input.REVOCATION_COMMENT2,left,right),'');
		    concatFields						  	    := trim(
			                                                trim(BANKRUPTCYDATE,left,right)+';'
															+trim(COMMENTS,left,right)+';'+trim(REVOCATIONCOMMENT1,left,right)+';'+trim(REVOCATIONCOMMENT2,left,right),left,right
														  );
														  
				
			tempExp								    := regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2							    := regexreplace('^[;]*',tempExp,'',NOCASE);
			
			self.corp_addl_info                     := regexreplace('[;]+',tempExp2,';',NOCASE);
			
		    self.corp_ra_name                     	:=if(trim(stringlib.StringtoUpperCase(input.STATUTORY_AGENT_NAME),left,right)<>'',trim(stringlib.StringtoUpperCase(input.STATUTORY_AGENT_NAME),left,right),''); 
		    self.corp_ra_effective_date           	:=if(trim(stringlib.StringtoUpperCase(input.Stat_Agent_Appointment_Resign_Code),left,right) ='A' and _validate.date.fIsValid(trim(input.Stat_Agent_Appointment_Resign_Date,left,right)) and  
			                                         _validate.date.fIsValid(trim(input.Stat_Agent_Appointment_Resign_Date,left,right),_validate.date.rules.DateInPast),
			                                         trim(input.Stat_Agent_Appointment_Resign_Date,left,right) ,''    														
													  );
			self.corp_ra_resign_date              	:=if(trim(stringlib.StringtoUpperCase(input.Stat_Agent_Appointment_Resign_Code),left,right) ='R' and _validate.date.fIsValid(trim(input.Stat_Agent_Appointment_Resign_Date,left,right)) and  
			                                         _validate.date.fIsValid(trim(input.Stat_Agent_Appointment_Resign_Date,left,right),_validate.date.rules.DateInPast),
			                                         trim(input.Stat_Agent_Appointment_Resign_Date,left,right) ,''    														
													  ); 										  
		   self.corp_ra_address_line1            :=if(trim(input.Statutory_Agent_Address_Line_1,left,right)<>''and regexreplace('[X]*$',trim(input.Statutory_Agent_Address_Line_1,left,right),'',NOCASE) <>''  and trim(stringlib.StringtoUpperCase(input.Statutory_Agent_Address_Line_1),left,right)<>'NOT REQUIRED'
			                                        ,trim(input.Statutory_Agent_Address_Line_1,left,right),''); 
			self.corp_ra_address_line2            :=if(trim(input.Statutory_Agent_Address_Line_2,left,right)<>''and regexreplace('[X]*$',trim(input.Statutory_Agent_Address_Line_2,left,right),'',NOCASE) <>''  and trim(stringlib.StringtoUpperCase(input.Statutory_Agent_Address_Line_2),left,right)<>'NOT REQUIRED'  
			                                        ,trim(input.Statutory_Agent_Address_Line_2,left,right),''); 
			self.corp_ra_address_line3            :=if(trim(input. Statutory_Agent_Address_Line_3,left,right)<>''and regexreplace('[X]*$',trim(input.Statutory_Agent_Address_Line_3,left,right),'',NOCASE) <>''  and trim(stringlib.StringtoUpperCase(input.Statutory_Agent_Address_Line_3),left,right)<>'NOT REQUIRED'
			                                        ,trim(input. Statutory_Agent_Address_Line_3,left,right),'');
			self.corp_ra_address_line4            :=if(trim(input.STATUTORY_AGENT_ADDRESS_CITY,left,right)<>'' and regexreplace('[X]*$',trim(input.STATUTORY_AGENT_ADDRESS_CITY,left,right),'',NOCASE) <>'' and trim(stringlib.StringtoUpperCase(input.STATUTORY_AGENT_ADDRESS_CITY),left,right)<>'NOT REQUIRED'   
			                                        ,trim(input.STATUTORY_AGENT_ADDRESS_CITY,left,right),''); 
			self.corp_ra_address_line5            :=if(trim(input.STATUTORY_AGENT_ADDRESS_STATE,left,right)<>''and regexreplace('[X]*$',trim(input.STATUTORY_AGENT_ADDRESS_STATE,left,right),'',NOCASE) <>''  and trim(stringlib.StringtoUpperCase(input.STATUTORY_AGENT_ADDRESS_STATE),left,right)<>'NOT REQUIRED'
			                                        ,trim(input.STATUTORY_AGENT_ADDRESS_STATE,left,right),''); 
			self.corp_ra_address_line6            :=if(trim(input.STATUTORY_AGENT_ADDRESS_ZIP_CODE,left,right)<>''and regexreplace('[X]*$',trim(input.STATUTORY_AGENT_ADDRESS_ZIP_CODE,left,right),'',NOCASE) <>'' and trim(stringlib.StringtoUpperCase(input.STATUTORY_AGENT_ADDRESS_ZIP_CODE),left,right)<>'NOT REQUIRED'
			                                        ,trim(input.STATUTORY_AGENT_ADDRESS_ZIP_CODE,left,right),'');
		    self                                  := [];
		
end; // end corp1 transform. 


//corp2 transform
     corp2_mapping.Layout_CorpPreClean AZ_corp2Transform_Business(layouts_raw_input.CHGEXT  input):=transform 
	        self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='04-' +trim(input.FILE_NUMBER, left, right);
			self.corp_vendor					  :='04';
		    self.corp_state_origin                :='AZ';
			self.corp_process_date				  := fileDate;    
			self.corp_orig_sos_charter_nbr        := trim(input.FILE_NUMBER, left, right);
			self.corp_legal_name                  :=if (trim(stringlib.StringtoUpperCase(input.CHANGE_MERGE_FROM_NAME),left,right)<>'',trim(stringlib.StringtoUpperCase(input.CHANGE_MERGE_FROM_NAME), left, right),'');
			self.corp_ln_name_type_desc           :=map(	
														trim(stringlib.StringtoUpperCase(input.Change_Merge_Code),left,right)=  'M'  => 'NON-SURVIVOR',
														trim(stringlib.StringtoUpperCase(input.Change_Merge_Code),left,right)=  'C'  => 'FORMER','');
														
			self.corp_filing_date                 := if(_validate.date.fIsValid(trim(input.CHANGE_MERGE_DATE,left,right)) and 
														_validate.date.fIsValid(trim(input.CHANGE_MERGE_DATE,left,right),_validate.date.rules.DateInPast)and
														(string)((integer)trim(input.CHANGE_MERGE_DATE,left,right)) <> '0',trim(input.CHANGE_MERGE_DATE,left,right),'');
			
			
	        self                                  := [];
		
	 
	 end;  // end corp2 transform. 

	// AR_TRANSFORM M.R.
		Corp2.Layout_Corporate_Direct_AR_In AZ_arTransform(layouts_raw_input.FLMEXT input):=transform,skip(lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.DOCUMENT_DESCRIPTION),left,right),'ANNUAL', 1) = 0 and
																										   lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.DOCUMENT_DESCRIPTION),left,right),'EXTENSION', 1) = 0  and
																										   lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.DOCUMENT_DESCRIPTION),left,right),'FINANCIAL', 1) = 0 )
													   
			self.corp_key					      := '04-' +trim(input.FILE_NUMBER, left, right);
			self.corp_vendor				      := '04';
			self.corp_state_origin			      := 'AZ';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.FILE_NUMBER, left, right);
			self.ar_microfilm_nbr                 := if(trim(input.MICROFILM_LOCATION, left, right)<>'',trim(input.MICROFILM_LOCATION, left, right),'');
		    self.ar_filed_dt                      :=if( _validate.date.fIsValid(trim(input.DATE_DOCUMENT_RECEIVED,left,right)) and  
			                                          _validate.date.fIsValid(trim(input.DATE_DOCUMENT_RECEIVED,left,right),_validate.date.rules.DateInPast) ,
													  trim(input.DATE_DOCUMENT_RECEIVED,left,right),'');
																  
            self.ar_comment                       :=If(trim(stringlib.StringtoUpperCase(input.DOCUMENT_DESCRIPTION),left,right)<>'',trim(stringlib.StringtoUpperCase(input.DOCUMENT_DESCRIPTION),left,right),'');

           
			self                                  := [] ;

		end; // end of az_AR_transform M.R.
			
		// Stock_TRANSFORM M.R.
		Corp2.Layout_Corporate_Direct_Stock_In AZ_stockTransform(layouts_raw_input.FLMEXT input):=transform,skip(lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.DOCUMENT_DESCRIPTION),left,right),'STOCK', 1) = 0 )
		    self.corp_key					      := '04-' +trim(input.FILE_NUMBER, left, right);
			self.corp_vendor				      := '04';
			self.corp_state_origin			      := 'AZ';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.FILE_NUMBER, left, right);
			MICROFILMLOCATION                     :=if(trim(input.MICROFILM_LOCATION,left,right)<>'','MICROFILM LOCATION:'+trim(input.MICROFILM_LOCATION,left,right),'');
			DOCUMENTDESCRIPTION                   :=if(trim(input.DOCUMENT_DESCRIPTION,left,right)<>'',trim(input.DOCUMENT_DESCRIPTION,left,right),'');
			
			concatFields						  := trim( 
															trim(MICROFILMLOCATION,left,right) + ';' + 
															trim(DOCUMENTDESCRIPTION  ,left,right),left,right
														  );
			
				
			tempExp								  := regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2							  := regexreplace('^[;]*',tempExp,'',NOCASE);
			
	        stock_addl_info                       :=regexreplace('[;]+',tempExp2,';',NOCASE);
			
            self.stock_change_date                :=if(_validate.date.fIsValid(trim(input.DATE_DOCUMENT_RECEIVED,left,right)) and  
			                                          _validate.date.fIsValid(trim(input.DATE_DOCUMENT_RECEIVED,left,right),_validate.date.rules.DateInPast),
			                                          trim(input.DATE_DOCUMENT_RECEIVED,left,right),'');
        	self                                  := [];
			
			
		end; // end of az_Stock_transform M.R.
		
		// Event_TRANSFORM M.R.
		Corp2.Layout_Corporate_Direct_Event_In AZ_eventTransform(layouts_raw_input.COREXT_FLMEXT input):=transform,skip(lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.DOCUMENT_DESCRIPTION),left,right),'ANNUAL', 1) <> 0 or
			                                           lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.DOCUMENT_DESCRIPTION),left,right),'EXTENSION', 1) <> 0  or
													   lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.DOCUMENT_DESCRIPTION),left,right),'FINANCIAL', 1) <> 0 )
			self.corp_key					    := '04-' +trim(input.FILE_NUMBER, left, right);
			self.corp_vendor				    := '04';
			self.corp_state_origin			    := 'AZ';
			self.corp_process_date			    := fileDate;
			self.corp_sos_charter_nbr		    := trim(input.FILE_NUMBER, left, right);
			self.event_filing_date              :=if(trim(input.Date_Document_Received,left,right)<>'' and  _validate.date.fIsValid(trim(input.Date_Document_Received,left,right)) and 
			                                            _validate.date.fIsValid(trim(input.Date_Document_Received,left,right),_validate.date.rules.DateInPast),
			                                          trim(input.Date_Document_Received,left,right),
			                                         '');
			 self.event_filing_desc		        :=if(trim(input.Date_Document_Received,left,right)<>'' and  _validate.date.fIsValid(trim(input.Date_Document_Received,left,right)) and 
			                                            _validate.date.fIsValid(trim(input.Date_Document_Received,left,right),_validate.date.rules.DateInPast),
			                                          'FILING',
			                                        '');
													
           	
            self.event_filing_cd                :=if(trim(input.Date_Document_Received,left,right)<>'' and  _validate.date.fIsValid(trim(input.Date_Document_Received,left,right)) and 
			                                            _validate.date.fIsValid(trim(input.Date_Document_Received,left,right),_validate.date.rules.DateInPast),
			                                          'FIL',
			                                        '');
            self.event_microfilm_nbr            := if(trim(input.MICROFILM_LOCATION, left, right)<>'',trim(input.MICROFILM_LOCATION, left, right),'');
            self.event_desc                     :=if(trim(input.DOCUMENT_DESCRIPTION,left,right)<>'',trim(input.DOCUMENT_DESCRIPTION,left,right),'');
            self                                := [];
		
			
			
		end; // end of az_Event_transform M.R.
		
		
							//layout join for cont
          Layouts_Raw_Input.COREXT_OFFEXT MergeCorextOFFEXT(Layouts_Raw_Input.COREXT l, Layouts_Raw_Input.OFFEXT r ) := transform
			             self 					 := l;
			             self					 := r;
			             self                    := [];
			
		  end; // end transform
		
		joinCorextOffext := join(	Files_Raw_Input.COREXT(fileDate), Files_Raw_Input.OFFEXT(fileDate),
								trim(left.FILE_NUMBER,left,right) = trim(right.Officer_FILE_NUMBER,left,right),
								MergeCorextOFFEXT(left,right),
								left outer
							);
	FinalOfficerFile := record
		layouts_raw_input.COREXT_OFFEXT,
		string      Title1;
		string      Title2;
		string      Title3;
		string      Title4;
		string      Title5;

		end;
						
		  //------- Denormalize above result to get all titles in one record ------------------
	   
	   sortOffFile		:= sort(joinCorextOffext,Officer_File_Number,Officer_Name,Officer_Address_Line1,Officer_Address_Line2,Officer_Address_Line3,Officer_Address_State,Officer_Addr_Zip);
	   
		distofficers 	:= distribute(sortOffFile,hash64(Officer_File_Number,Officer_Name,Officer_Address_Line1,Officer_Address_Line2,Officer_Address_Line3,Officer_Address_State,Officer_Addr_Zip));
		FinalOfficerFile	newTransform(joinCorextOffext l) := transform
			self			:=l;
			self			:=[];
		end;
		newOfficerFile		:= project(distOfficers, newTransform(left));
		dedupNewOfficerFile := dedup(newOfficerFile,Officer_File_Number,Officer_Name,Title_Code, all);
		
		  FinalOfficerFile DenormOfficers(FinalOfficerFile L, FinalOfficerFile R, INTEGER C) := TRANSFORM
		
			        self.Title1 	:= if(C=1, R.Title_Code, L.TITLE1);                  
					self.title2		:= if(C=2, R.Title_Code, L.TITLE2);
					self.title3		:= if(C=3, R.Title_Code, L.TITLE3); 
					self.title4		:= if(C=4, R.Title_Code, L.TITLE4); 
					self.title5		:= if(C=5, R.Title_Code, L.TITLE5); 	
					self 			    := L;	
		END;
		
		DenormalizedFile := denormalize(dedupNewOfficerFile, dedupNewOfficerFile,
		                  					trim(left.Officer_File_Number,left,right) = trim(right.Officer_File_Number,left,right) and
											trim(left.Officer_Name,left,right) = trim(right.Officer_Name,left,right) and
											trim(left.Officer_Address_Line1,left,right) = trim(right.Officer_Address_Line1,left,right) and
											trim(left.Officer_Address_Line2,left,right) = trim(right.Officer_Address_Line2,left,right) and
									        trim(left.Officer_Address_Line3,left,right) = trim(right.Officer_Address_Line3,left,right) and
											trim(left.Officer_Address_State,left,right) = trim(right.Officer_Address_State,left,right) and
											trim(left.Officer_Addr_Zip,left,right) = trim(right.Officer_Addr_Zip,left,right) ,
											DenormOfficers(left,right,COUNTER));
											
			DedupDenormalized := dedup(DenormalizedFile, RECORD,all);
			
		// contact_TRANSFORM
		corp2_mapping.Layout_ContPreClean AZ_contactTransform(FinalOfficerFile  input):=transform
		    self.dt_first_seen			  :=fileDate;
			self.dt_last_seen			  :=fileDate;
		    self.corp_key					  := '04-' +trim(input.FILE_NUMBER, left, right);
			self.corp_vendor				  := '04';
			self.corp_state_origin			  := 'AZ';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    := trim(input.FILE_NUMBER, left, right);
			self.corp_legal_name              :=if (trim(stringlib.StringtoUpperCase(input.Corporation_Name),left,right)<>'',trim(stringlib.StringtoUpperCase(input.Corporation_Name), left, right),'');
			title1												:= map(
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'C' =>'CHAIRMAN',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'CE'=>'CHIEF EXECUTIVE OFFICER',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'D' =>'DIRECTOR',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'DC'=>'DIRECTOR/CHAIRMA',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'H' =>'PRINCIPAL SHAREHOLDER',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'I' =>'INVESTOR',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'M' =>'MANAGER',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'MB'=>'MEMBER',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'O' =>'OTHER OFFICER',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'P' =>'PRESIDENT/CEO',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'R' =>'RESIGNED',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'S' =>'STATUTORY AGENT',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'SE'=>'SECRETARY',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'T' =>'TREASURER',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)= 'TR'=>'TRUSTEE',
													trim(stringlib.StringtoUpperCase(input.Title1),left,right)=  'V'=>'VICE-PRESIDENT',
                                                            ''
									                      );
																						
			title2						             	:=map(
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'C' =>'CHAIRMAN',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'CE'=>'CHIEF EXECUTIVE OFFICER',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'D' =>'DIRECTOR',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'DC'=>'DIRECTOR/CHAIRMA',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'H' =>'PRINCIPAL SHAREHOLDER',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'I' =>'INVESTOR',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'M' =>'MANAGER',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'MB'=>'MEMBER',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'O' =>'OTHER OFFICER',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'P' =>'PRESIDENT/CEO',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'R' =>'RESIGNED',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'S' =>'STATUTORY AGENT',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'SE'=>'SECRETARY',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'T' =>'TREASURER',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)= 'TR'=>'TRUSTEE',
													trim(stringlib.StringtoUpperCase(input.Title2),left,right)=  'V'=>'VICE-PRESIDENT',
                                                            ''
									                      );
			
			title3						             	:=map(
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'C' =>'CHAIRMAN',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'CE'=>'CHIEF EXECUTIVE OFFICER',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'D' =>'DIRECTOR',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'DC'=>'DIRECTOR/CHAIRMA',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'H' =>'PRINCIPAL SHAREHOLDER',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'I' =>'INVESTOR',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'M' =>'MANAGER',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'MB'=>'MEMBER',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'O' =>'OTHER OFFICER',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'P' =>'PRESIDENT/CEO',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'R' =>'RESIGNED',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'S' =>'STATUTORY AGENT',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'SE'=>'SECRETARY',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'T' =>'TREASURER',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)= 'TR'=>'TRUSTEE',
													trim(stringlib.StringtoUpperCase(input.Title3),left,right)=  'V'=>'VICE-PRESIDENT',
                                                            ''
									                      );
														
			title4				            			:=map(
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'C' =>'CHAIRMAN',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'CE'=>'CHIEF EXECUTIVE OFFICER',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'D' =>'DIRECTOR',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'DC'=>'DIRECTOR/CHAIRMA',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'H' =>'PRINCIPAL SHAREHOLDER',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'I' =>'INVESTOR',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'M' =>'MANAGER',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'MB'=>'MEMBER',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'O' =>'OTHER OFFICER',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'P' =>'PRESIDENT/CEO',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'R' =>'RESIGNED',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'S' =>'STATUTORY AGENT',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'SE'=>'SECRETARY',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'T' =>'TREASURER',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)= 'TR'=>'TRUSTEE',
													trim(stringlib.StringtoUpperCase(input.Title4),left,right)=  'V'=>'VICE-PRESIDENT',
                                                            ''
									                      );
														
			title5								          :=map(
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'C' =>'CHAIRMAN',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'CE'=>'CHIEF EXECUTIVE OFFICER',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'D' =>'DIRECTOR',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'DC'=>'DIRECTOR/CHAIRMA',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'H' =>'PRINCIPAL SHAREHOLDER',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'I' =>'INVESTOR',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'M' =>'MANAGER',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'MB'=>'MEMBER',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'O' =>'OTHER OFFICER',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'P' =>'PRESIDENT/CEO',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'R' =>'RESIGNED',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'S' =>'STATUTORY AGENT',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'SE'=>'SECRETARY',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'T' =>'TREASURER',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)= 'TR'=>'TRUSTEE',
													trim(stringlib.StringtoUpperCase(input.Title5),left,right)=  'V'=>'VICE-PRESIDENT',
                                                            ''
									                      );
														  
				
				concatFields									:= 	trim(Title1,left,right) + ';' + 
																					trim(Title2,left,right) + ';' +  
																					trim(Title3,left,right) + ';' + 
																					trim(Title4,left,right) + ';' + 
																					trim(Title5,left,right);
				
			tempExp													:= regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2												:= regexreplace('^[;]*',tempExp,'',NOCASE);
			self.cont_title1_desc         	:= regexreplace('[;]+',tempExp2,';',NOCASE);
            self.cont_name                    :=if(trim(stringlib.StringtoUpperCase(input.Officer_Name),left,right)<>'',trim(input.Officer_Name,left,right),'');
			self.cont_type_cd                 :='F';
         	self.cont_type_desc               :='OFFICER';
			
												 
            self.cont_address_line1           :=if(regexreplace('[!]*$',trim(input.Officer_Address_Line1,left,right),'',NOCASE) <>'' and regexreplace('[.]*$',trim(input.Officer_Address_Line1,left,right),'',NOCASE) <>'' and
			                                     regexreplace('[X]*$',trim(input.Officer_Address_Line1,left,right),'',NOCASE) <>'' and regexreplace('[?]*$',trim(input.Officer_Address_Line1,left,right),'',NOCASE) <>'' and
			                                     trim(input.Officer_Address_Line1,left,right)<>''and trim(stringlib.StringtoUpperCase(input.Officer_Address_Line1),left,right)<>'NOT REQUIRED' 
												 ,trim(input.Officer_Address_Line1,left,right),'');
			self.cont_address_line2           :=if(regexreplace('[!]*$',trim(input.Officer_Address_Line2,left,right),'',NOCASE) <>'' and regexreplace('[.]*$',trim(input.Officer_Address_Line2,left,right),'',NOCASE) <>'' and
			                                       regexreplace('[X]*$',trim(input.Officer_Address_Line2,left,right),'',NOCASE) <>'' and regexreplace('[?]*$',trim(input.Officer_Address_Line2,left,right),'',NOCASE) <>'' and
												   trim(input.Officer_Address_Line2,left,right)<>''and trim(stringlib.StringtoUpperCase(input.Officer_Address_Line2),left,right)<>'NOT REQUIRED' 
												   ,trim(input.Officer_Address_Line2,left,right),'');
			self.cont_address_line3           :=if(regexreplace('[!]*$',trim(input.Officer_Address_Line3,left,right),'',NOCASE) <>'' and regexreplace('[.]*$',trim(input.Officer_Address_Line3,left,right),'',NOCASE) <>'' and
			                                       regexreplace('[X]*$',trim(input.Officer_Address_Line3,left,right),'',NOCASE) <>'' and regexreplace('[?]*$',trim(input.Officer_Address_Line3,left,right),'',NOCASE) <>'' and
												   trim(input.Officer_Address_Line3,left,right)<>''and trim(stringlib.StringtoUpperCase(input.Officer_Address_Line3),left,right)<>'NOT REQUIRED' 
												   ,trim(input.Officer_Address_Line3,left,right),'');
			self.cont_address_line4           :=if(regexreplace('[!]*$',trim(input.Officer_Address_CITY,left,right),'',NOCASE) <>'' and regexreplace('[.]*$',trim(input.Officer_Address_CITY,left,right),'',NOCASE) <>'' and
			                                       regexreplace('[X]*$',trim(input.Officer_Address_CITY,left,right),'',NOCASE) <>'' and regexreplace('[?]*$',trim(input.Officer_Address_CITY,left,right),'',NOCASE) <>'' and
												   trim(input.Officer_Address_CITY,left,right)<>''and trim(stringlib.StringtoUpperCase(input.Officer_Address_CITY),left,right)<>'NOT REQUIRED' 
												   ,trim(input.Officer_Address_CITY,left,right),'');
			self.cont_address_line5           :=if(regexreplace('[!]*$',trim(input.Officer_Address_STATE,left,right),'',NOCASE) <>'' and regexreplace('[.]*$',trim(input.Officer_Address_STATE,left,right),'',NOCASE) <>'' and
			                                       regexreplace('[X]*$',trim(input.Officer_Address_STATE,left,right),'',NOCASE) <>'' and regexreplace('[?]*$',trim(input.Officer_Address_STATE,left,right),'',NOCASE) <>'' and
												   trim(input.Officer_Address_STATE,left,right)<>''and trim(stringlib.StringtoUpperCase(input.Officer_Address_STATE),left,right)<>'NOT REQUIRED' 
												   ,trim(input.Officer_Address_STATE,left,right),'');
			self.cont_address_line6           :=if(regexreplace('[!]*$',trim(input.Officer_Addr_Zip,left,right),'',NOCASE) <>'' and regexreplace('[.]*$',trim(input.Officer_Addr_Zip,left,right),'',NOCASE) <>'' and
			                                       regexreplace('[X]*$',trim(input.Officer_Addr_Zip,left,right),'',NOCASE) <>'' and regexreplace('[?]*$',trim(input.Officer_Addr_Zip,left,right),'',NOCASE) <>'' and
												   trim(input.Officer_Addr_Zip,left,right)<>''and trim(stringlib.StringtoUpperCase(input.Officer_Addr_Zip),left,right)<>'NOT REQUIRED' 
												   ,trim(input.Officer_Addr_Zip,left,right),'');
												   
												   
			self.cont_address_type_cd         :=if(trim(self.cont_address_line1,left,right)<>''or trim(self.cont_address_line2,left,right)<>'' or
			                                     trim(self.cont_address_line3,left,right)<>'' or trim(self.cont_address_line4,left,right)<>'' or
												 trim(self.cont_address_line5,left,right)<>''or trim(self.cont_address_line6,left,right)<>'', 'T','');
         	self.cont_address_type_desc       :=if(trim(self.cont_address_line1,left,right)<>''or trim(self.cont_address_line2,left,right)<>'' or
			                                     trim(self.cont_address_line3,left,right)<>'' or trim(self.cont_address_line4,left,right)<>'' or
												 trim(self.cont_address_line5,left,right)<>''or trim(self.cont_address_line6,left,right)<>'','CONTACT','');									   
            self                              := [];
			
		end; // end of az_contact_transform
		
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
		

		 MapCorp1 := project(Files_Raw_Input.COREXT(fileDate) , AZ_corp1Transform_Business(left)) ;
		 MapCorp2 := project(Files_Raw_Input.CHGEXT(fileDate) , AZ_corp2Transform_Business(left)) ;
		 //Look_up table join
		 
		 corp2_mapping.Layout_CorpPreClean findStatus(corp2_mapping.Layout_CorpPreClean input, StatusCodeLayout r ) := transform
			self.corp_status_desc       := if (trim(input.corp_status_cd,left,right) ='',
												'ACTIVE', r.StatusDesc
											  );
			self         			    := input;
			self                        := [];
		end; // end transform
		
			
		//StatusCode join
		joinStatusType := 	join(	MapCorp1,StatusCodeTable,
									trim(left.corp_status_cd,left,right) = trim(right.StatusCode,left,right),
									findStatus(left,right),
									left outer, lookup
								);	
								
		 corp2_mapping.Layout_CorpPreClean findState(corp2_mapping.Layout_CorpPreClean input, ForgnStateDescLayout r ) := transform
			self.corp_forgn_state_desc  := r.desc;
			self         			    := input;
			self                        := [];
		end; // end transform
		
			
		//StatusCode join
		joinStateType := 	join(	joinStatusType,ForgnStateTable,
									trim(left.corp_forgn_state_cd,left,right) = trim(right.code,left,right),
									findState(left,right),
									left outer, lookup
								);	
	        
                

               
				
			 //Two layouts join	
			 
			Layouts_Raw_Input.COREXT_FLMEXT MergeCorextFlmext(Layouts_Raw_Input.COREXT l, Layouts_Raw_Input.FLMEXT r ) := transform
			    self 					:= l;
			    self					:= r;
			    self                    := [];
			
		    end; // end transform 
		
		joinCorextFlmext := join(	Files_Raw_Input.COREXT(fileDate), Files_Raw_Input.FLMEXT(fileDate),
								trim(left.FILE_NUMBER,left,right) = trim(right.FILE_NUMBER,left,right),
								MergeCorextFlmext(left,right),
								left outer, lookup
							);
							
							
							
				AllCorp :=joinStateType+MapCorp2;
                MapCorp := sort(AllCorp,corp_key);
		        cleanCorps := project(MapCorp,CleanCorpNameAddr(left));			
				
                MapEvent 							:= project(joinCorextFlmext, AZ_eventTransform(left));
                MapAR 								:= project(Files_Raw_Input.FLMEXT(filedate), AZ_arTransform(left));
				MapStock 							:= project(Files_Raw_Input.FLMEXT(filedate), AZ_stockTransform(left));
				
				


				
				MapCont 							:= project(DedupDenormalized, AZ_contactTransform(left));
				
				
			cleanCont := project(MapCont , CleanContNameAddr(left));
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_az'	,cleanCorps	,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_az'	,MapEvent 	,event_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_az'		,MapAR			,ar_out			,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_az'	,cleanCont	,cont_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_az'	,MapStock		,stock_out	,,,pOverwrite);
                                                                                                                                                          
  mappedAZ_Filing := parallel(
		 corp_out	
		,event_out
		,ar_out		
		,cont_out	
		,stock_out
	);        
									 
		
		 result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('az',filedate,pOverwrite := pOverwrite))
			,mappedAZ_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp','~thor_data400::in::corp2::'+version+'::corp_az')			  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont','~thor_data400::in::corp2::'+version+'::cont_az')						  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar','~thor_data400::in::corp2::'+version+'::ar_az')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event','~thor_data400::in::corp2::'+version+'::event_az')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock','~thor_data400::in::corp2::'+version+'::stock_az')
			)							
		);
									
		return result;

	end;					 
	
end; // end of AZ module

		