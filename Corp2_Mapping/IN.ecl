import Corp2,ut, lib_stringlib, _validate, Address, _control, versioncontrol;
export in := MODULE;

// IN has seven vendor layouts in a tab delimited format.

 export Layouts_Raw_Input := MODULE; 
	
 export Corp_Agents := record


   string16  Agen_Packet_Number;
   string78  Agen_Name;
   string64  Agen_Address_Line1;
   string64  Agen_Address_Line2;
   string32  Agen_City;
   string2   Agen_State;  
   string8   Agen_Zip_Code;
   string4   Agen_Zip_Extension;
   string10  Agen_Creation_Date;
   string10  Agen_Expiration_Date;
   string10  Agen_Inactive_Date;
   string1   Agen_lf;
end;
	
 export Corp_Corporations:= record
   
   
   string16  Corp_Packet_Number;
   string144 Corp_Name;
   string2   Corp_Entity_Type;
   string2   Corp_Status_Code;
   string2   Corp_Filing_Act;
   string10  Corp_Creation_Date;
   string10  Corp_Expiration_Date;
   string10  Corp_Inactive_Date;
   string64  Corp_Address_Line1;
   string64  Corp_Address_Line2;
   string45  Corp_City;
   string2   Corp_State;
   string8   Corp_Zip_Code;
   string4   Corp_Zip_Extension;
   string2   Corp_Orig_Inc_State;
   string10  Corp_Orig_Inc_Date;
   string16  Corp_Federal_Id;
   string128 Corp_Fictions_Name;
   string1   Corp_Managers;
   string64  Corp_Owner_Name;
   string1   Corp_lf;
   
 end;
 
  export Corp_Filings:= record

   string16  Fili_DCN;
   string16  Fili_Packet_Number;
   string3   Fili_Filing_Type;
   string10  Fili_Entry_Date;
   string10  Fili_Filing_Date;
   string10  Fili_Effective_Date;
   string200 Fili_Comment;
   string1   Fili_Legacy;
   string1   Fili_lf;
   
 end;
 

 export Corp_Mergers:=record

   string16 Merg_Non_Survivor_Packet;
   string16 Merg_Survivor_Packet;
   string10 Merg_Creation_Date;
   string1  Merg_lf; 
   
 end;
 
 export Corp_Names:=record

   string16  Name_Packet_Number;
   string3   Name_Sequence_Number;
   string1   Name_Name_Type;
   string115 Name_Name;
   string10  Name_Creation_Date;
   string32  Name_County;
   string1   Name_lf;
   
 end;

 export Corp_Officers:=record

   string16 offi_Packet_Number;
   string2  offi_Sequence_Number;
   string2  offi_Position_Type;
   string75 offi_Name;
   string64 offi_Address_Line1;
   string64 offi_Address_Line2;
   string45 offi_City;
   string2  offi_State;
   string8  offi_Zip_Code;
   string11 offi_Zip_Extension;
   string10 offi_Creation_Date;
   string1  offi_lf;
   
 end;
 
 export Corp_Reports:=record

   string16 Repo_Packet_Number;
   string4  Repo_Year_Number;
   string16 Repo_Locator;
   string10 Repo_Creation_Date;
   string1  Repo_lf;

 end;
 
 export CorpAgents :=record
	Corp_Agents;
	Corp_Corporations;
 end;
 export Corp_Officers_Corporations:=record
	Corp_Officers;
	Corp_Corporations;
   
 end;
 
	
 end; // end of layouts_raw_input.Corp_Agents  input module
 
	export Files_Raw_Input := MODULE;
	    export CorpAgents (string fileDate)          := dataset('~thor_data400::in::corp2::'+fileDate+'::Corp_Agents::in',
														     layouts_Raw_Input.Corp_Agents,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
																			 
		export CorpCorporations (string fileDate)    := dataset('~thor_data400::in::corp2::'+fileDate+'::Corp_Corporations::in',
														     layouts_Raw_Input.Corp_Corporations,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
															 
		export CorpFilings (string fileDate)         := dataset('~thor_data400::in::corp2::'+fileDate+'::Corp_Filings::in',
														     layouts_Raw_Input.Corp_Filings,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
		
		export CorpMergers (string fileDate)         := dataset('~thor_data400::in::corp2::'+fileDate+'::Corp_Mergers::in',
														     layouts_Raw_Input.Corp_Mergers,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
														
		export CorpNames (string fileDate)           := dataset('~thor_data400::in::corp2::'+fileDate+'::Corp_Names::in',
		                                                     layouts_Raw_Input.Corp_Names,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
	    export CorpOfficers (string fileDate)        := dataset('~thor_data400::in::corp2::'+fileDate+'::Corp_Officers::in',
														     layouts_Raw_Input.Corp_Officers,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
														
		export CorpReports (string fileDate)        := dataset('~thor_data400::in::corp2::'+fileDate+'::Corp_Reports::in',
		                                                     layouts_Raw_Input.Corp_Reports,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
		
	end;	
		
	export Files_PreCleaned := MODULE;
	
		export corpPre    := dataset('~thor_data400::in::corp2::uncleaned::corp_in', corp2_mapping.Layout_CorpPreClean,flat);
		export contactPre := dataset('~thor_data400::in::corp2::uncleaned::cont_in', corp2_mapping.Layout_ContPreClean,flat);


    end;
	

	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
		
		  			
			  
       
		//FilingTypecode  layout
			FilingTypeLayout := record,MAXLENGTH(100)

			string FilingCode;
			string FilingDesc;     
			
		end;							
		  
		  
		FilingTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::FilingType_Table::in',FilingTypeLayout,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
		
		//EntityTypeCode layout
		
			EntityTypeLayout := record,MAXLENGTH(150)

			string EntityCode;
			string EntityDesc;     
			
		end;							
		  
		  
		EntityTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::EntityType_Table::in',EntityTypeLayout,CSV(SEPARATOR(['.']), TERMINATOR(['\r\n', '\n'])));
		
		//StateCode type layout
		
		ForgnStateDescLayout := record,MAXLENGTH(100)
               string code;
               string desc;

        end; 
    
       ForgnStateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstateprovince_table', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
	   
		   reformatDate(string rDate) := function
			
			string2 outMM := if(rDate[2] = '/',
								'0'+ rDate[1],
								rDate[1..2]);
			string2 outDD := if(rDate[length(rDate)-6] = '/',
								'0'+ rDate[length(rDate)-5],
								rDate[length(rDate)-6..length(rDate)-5]);
			string8 newDate := rDate[length(rDate)-3..]+outMM+outDD;	
			return  newDate;	
		end;	
		
		//corp1 transform
		
	    corp2_mapping.Layout_CorpPreClean in_corp1Transform_Business(layouts_raw_input.CorpAgents input):=transform,skip(trim(input.Corp_Name,left,right)='')
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='18-'+trim(input.Corp_Packet_Number,left, right);
			self.corp_vendor					  :='18';
		    self.corp_state_origin                :='IN';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.Corp_Packet_Number, left, right);
			
			self.corp_orig_org_structure_cd       :=if(trim(input.Corp_Entity_Type,left, right)<>'',trim(input.Corp_Entity_Type,left, right),'');
			self.corp_status_cd                   :=if(trim(input.Corp_Status_Code,left, right)<>'',trim(input.Corp_Status_Code,left, right),'');
            self.corp_status_desc                 :=map(trim(input.Corp_Status_Code,left,right)='1'=>'ACTIVE',
                                                        trim(input.Corp_Status_Code,left,right)='2'=>'ADMINISTRATIVELY DISSOLVED',
														trim(input.Corp_Status_Code,left,right)='3'=>'INACTIVE',
														trim(input.Corp_Status_Code,left,right)='4'=>'CANCELLED',
														trim(input.Corp_Status_Code,left,right)='5'=>'VOLUNTARILY DISSOLVED',
														trim(input.Corp_Status_Code,left,right)='6'=>'REVOKED',
														trim(input.Corp_Status_Code,left,right)='7'=>'WITHDRAWN',
														trim(input.Corp_Status_Code,left,right)='8'=>'MERGED',
														trim(input.Corp_Status_Code,left,right)='9'=>'JUDICIALLY DISSOLVED',''
														);
													  
			self.corp_acts						  :=map(trim(input.Corp_Filing_Act,left,right)='1'=>'INDIANA BUSINESS CORPORATION LAW',
                                                        trim(input.Corp_Filing_Act,left,right)='2'=>'INDIANA PROFESSIONAL CORPORATION ACT OF 1983',
														trim(input.Corp_Filing_Act,left,right)='3'=>'INDIANA NONPROFIT CORPORATION ACT OF 1991',
														trim(input.Corp_Filing_Act,left,right)='4'=>'INDIANA BUSINESS FLEXIBILITY ACT',
														trim(input.Corp_Filing_Act,left,right)='5'=>'REVISED UNIFORM LIMITED PARTNERSHIP ACT',
														trim(input.Corp_Filing_Act,left,right)='6'=>'UNIFORM PARTNERSHIP ACT',
														trim(input.Corp_Filing_Act,left,right)='7'=>'INDIANA AGRICULTURAL COOPERATIVE ACT',
														trim(input.Corp_Filing_Act,left,right)='8'=>'INDIANA BUSINESS TRUST ACT OF 1963',
														trim(input.Corp_Filing_Act,left,right)='9'=>'THE INDIANA FINANCIAL INSTITUTIONS ACT',
														trim(input.Corp_Filing_Act,left,right)='10'=>'INDIANA INSURANCE LAW',
														trim(input.Corp_Filing_Act,left,right)='11'=>'MISCELLANEOUS',''
														);	
		     string corpCreationDate               :=reformatDate(input.Corp_Creation_Date);
			 string corpExpirationDate             :=reformatDate(input.Corp_Expiration_Date);
			 string corpInactiveDate               :=reformatDate(input.Corp_Inactive_Date);
			 string corpOrigIncDate                :=reformatDate(input.Corp_Orig_Inc_Date);
			 string agenCreationDate               :=reformatDate(input.Agen_Creation_Date);
			 string agenExpirationDate             :=reformatDate(input.Agen_Expiration_Date);
			
			 
			 self.corp_inc_date                    :=if((trim(input.Corp_Orig_Inc_State,left,right) = '' OR
			                                           trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) ='IN' )AND
			                                           (_validate.date.fIsValid(corpCreationDate) and 
														_validate.date.fIsValid((corpCreationDate),_validate.date.rules.DateInPast)),
														corpCreationDate,'');
            self.corp_forgn_date                  :=if((trim(input.Corp_Orig_Inc_State,left,right) <>'' OR
			                                           trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) <>'IN' )AND
			                                           (_validate.date.fIsValid(corpOrigIncDate) and 
														_validate.date.fIsValid((corpOrigIncDate),_validate.date.rules.DateInPast) )and
														trim(corpOrigIncDate,left,right)<>'18000101',
														corpOrigIncDate,'');
			self.corp_term_exist_cd               :=if((trim(input.Corp_Orig_Inc_State,left,right) ='' OR
			                                           trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) ='IN' )AND
			                                           _validate.date.fIsValid(corpExpirationDate) ,'D',''); 
														
			self.corp_term_exist_exp              :=if((trim(input.Corp_Orig_Inc_State,left,right) ='' OR
			                                           trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) ='IN' )AND
			                                           _validate.date.fIsValid(corpExpirationDate) , corpExpirationDate,''); 
														
			self.corp_term_exist_desc             :=if((trim(input.Corp_Orig_Inc_State,left,right) ='' OR
			                                           trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) ='IN' )AND
			                                           _validate.date.fIsValid(corpExpirationDate) ,'EXPIRATION DATE',''); 
													   
														
			self.corp_forgn_term_exist_cd         :=if((trim(input.Corp_Orig_Inc_State,left,right) <>'' OR
			                                           trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) <>'IN' )AND
			                                           _validate.date.fIsValid(corpExpirationDate) ,'D',''); 
													   
			self.corp_forgn_term_exist_exp        :=if((trim(input.Corp_Orig_Inc_State,left,right) <>'' OR
			                                           trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) <>'IN' )AND
			                                           _validate.date.fIsValid(corpExpirationDate) , corpExpirationDate,''); 
													   
			self.corp_forgn_term_exist_desc       :=if((trim(input.Corp_Orig_Inc_State,left,right) <>'' OR
			                                           trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) <>'IN' )AND
			                                           _validate.date.fIsValid(corpExpirationDate) ,'EXPIRATION DATE','');
													   
													   
			self.corp_status_date                 :=if(_validate.date.fIsValid(corpInactiveDate) and
			                                           _validate.date.fIsValid((corpInactiveDate),_validate.date.rules.DateInPast), corpInactiveDate,''); 
														
			self.corp_ln_name_type_cd             :=if(trim(stringlib.StringtoUpperCase(input.Corp_Name),left,right)<>'','01','');
			self.corp_ln_name_type_desc           :=if(trim(stringlib.StringtoUpperCase(input.Corp_Name),left,right)<>'','LEGAL','');
		    self.corp_legal_name                  :=if(trim(input.Corp_Name,left,right)<>'',trim(stringlib.StringtoUpperCase(input.Corp_Name),left,right),'');
			
			
			self.corp_fed_tax_id                  :=if((trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) ='' OR
			                                           trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) ='IN' ),trim(input.Corp_Federal_Id,left,right),'');
			self.corp_forgn_fed_tax_id            :=if((trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) <>'' OR
			                                           trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) <>'IN' ),trim(input.Corp_Federal_Id,left,right),'');
												   
			self.corp_inc_state                   :=if(trim(input.Corp_Orig_Inc_State,left,right) = '' OR
			                                           trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) = 'IN','IN','');
													   
            self.corp_forgn_state_cd              :=if(trim(input.Corp_Orig_Inc_State,left,right) <> '' OR
			                                           trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right) <>'IN', trim(stringlib.StringtoUpperCase(input.Corp_Orig_Inc_State),left,right),'');
			self.corp_address1_line1              :=if(trim(input. Corp_Address_Line1,left,right)<>'',trim(stringlib.StringtoUpperCase(input. Corp_Address_Line1),left,right),'');
			self.corp_address1_line2              :=if(trim(input. Corp_Address_Line2,left,right)<>'',trim(stringlib.StringtoUpperCase(input. Corp_Address_Line2),left,right),'');
			self.corp_address1_line3              :=if(trim(input.Corp_City,left,right)<>'',trim(stringlib.StringtoUpperCase(input.Corp_City),left,right),'');
			self.corp_address1_line4              :=if(trim(input.Corp_State,left,right)<>'',trim(stringlib.StringtoUpperCase(input.Corp_State),left,right),'');
			ZipCode1                              :=if((string)((integer)trim(input.Corp_Zip_Code,left,right)) <> '0' and trim(input.Corp_Zip_Code,left,right)<>'',trim(input.Corp_Zip_Code,left,right),'');
            ZipExtension1                         :=if((string)((integer)trim(input.Corp_Zip_Extension,left,right)) <> '0' and trim(input.Corp_Zip_Extension,left,right)<>'',trim(input.Corp_Zip_Extension,left,right),'');
			self.corp_address1_line5              :=ZipCode1+ZipExtension1;
			
		    self.corp_ra_name                     :=if(trim(input.Agen_Name,left,right)<>'',trim(stringlib.StringtoUpperCase(input.Agen_Name),left,right),'');
			
		    self.corp_ra_effective_date           :=if(_validate.date.fIsValid(agenCreationDate) and
			                                           _validate.date.fIsValid((agenCreationDate),_validate.date.rules.DateInPast), agenCreationDate,''); 
													   
			self.corp_ra_resign_date              :=if(_validate.date.fIsValid(agenExpirationDate) ,agenExpirationDate,''); 
			
		    self.corp_ra_address_line1            :=if(trim(input.Agen_Address_Line1,left,right)<>'',trim(stringlib.StringtoUpperCase(input.Agen_Address_Line1),left,right),''); 
			self.corp_ra_address_line2            :=if(trim(input.Agen_Address_Line2,left,right)<>'',trim(stringlib.StringtoUpperCase(input.Agen_Address_Line2),left,right),''); 
			self.corp_ra_address_line3            :=if(trim(input.Agen_City,left,right)<>'',trim(stringlib.StringtoUpperCase(input.Agen_City),left,right),''); 
			self.corp_ra_address_line4            :=if(trim(input.Agen_State,left,right)<>'',trim(stringlib.StringtoUpperCase(input.Agen_State),left,right),''); 
			ZipCode2                              :=if((string)((integer)trim(input.Agen_Zip_Code,left,right)) <> '0' and trim(input.Agen_Zip_Code,left,right)<>'',trim(input.Agen_Zip_Code,left,right),'');
			ZipExtension2                         :=if((string)((integer)trim(input.Agen_Zip_Extension,left,right)) <> '0' and trim(input.Agen_Zip_Extension,left,right)<>'',trim(input.Agen_Zip_Extension,left,right),''); 
			self.corp_ra_address_line5            :=ZipCode2+ZipExtension2;
		    self                                  := [];
		
end; // end  corp1 transform.
     
	 
	 
	 //corp2 transform
	   corp2_mapping.Layout_CorpPreClean in_corp2Transform_Business(layouts_raw_input.Corp_Corporations input):=transform,skip(trim(input.Corp_Fictions_Name,left,right)='')
     	    self.dt_first_seen					  :=fileDate;
     	  	self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='18-'+trim(input.Corp_Packet_Number,left, right);
			self.corp_vendor					  :='18';
		    self.corp_state_origin                :='IN';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.Corp_Packet_Number, left, right);
			self.corp_ln_name_type_cd             :=if(trim(input.Corp_Fictions_Name,left,right)<>'','02','');
			self.corp_ln_name_type_desc           :=if(trim(input.Corp_Fictions_Name,left,right)<>'','FOREIGN DBA','');
		    self.corp_legal_name                  :=if(trim(input.Corp_Fictions_Name,left,right)<>'',trim(stringlib.StringtoUpperCase(input.Corp_Fictions_Name),left,right),'');											
			
            self                                  := [];
		
end; // end  corp2 transform.


	 //corp3 transform
	   corp2_mapping.Layout_CorpPreClean in_corp3Transform_Business(layouts_raw_input.Corp_Names input):=transform,skip(trim(input.Name_Name,left,right)='')
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='18-'+trim(input.Name_Packet_Number,left, right);
			self.corp_vendor					  :='18';
		    self.corp_state_origin                :='IN';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.Name_Packet_Number, left, right);
		    self.corp_ln_name_type_cd             :=map(trim(input.Name_Name_Type,left,right)='1'=>'06',
			                                            trim(input.Name_Name_Type,left,right)='5'=>'p',''
														);
			self.corp_ln_name_type_desc           :=map(trim(input.Name_Name_Type,left,right)='1'=>'ASSUMED',
			                                            trim(input.Name_Name_Type,left,right)='5'=>'PRIOR',''
														);	
		    self.corp_legal_name                  :=if(trim(input.Name_Name,left,right)<>'',trim(stringlib.StringtoUpperCase(input.Name_Name),left,right),'');											
			
			string nameCreationDate               :=reformatDate(input.Name_Creation_Date);
			self.corp_inc_date                    :=if(_validate.date.fIsValid(nameCreationDate) and
			                                           _validate.date.fIsValid((nameCreationDate),_validate.date.rules.DateInPast) ,nameCreationDate,'');
														
			self.corp_inc_county                  :=trim(stringlib.StringtoUpperCase(input.Name_County),left,right);	
            self                                  := [];
		
end; // end  corp3 transform.

	   // AR_TRANSFORM M.R.

		Corp2.Layout_Corporate_Direct_AR_In in_arTransform(layouts_raw_input.Corp_Reports  input):=transform
			self.corp_key					      := '18-' +trim(input.Repo_Packet_Number, left, right);
			self.corp_vendor				      := '18';
			self.corp_state_origin			      := 'IN';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.Repo_Packet_Number, left, right);
			self.ar_year                          := trim(input.Repo_Year_Number, left, right);
			self.ar_microfilm_nbr                 :=trim(input.Repo_Locator, left, right);
			ArNewDate                             :=reformatDate(input.Repo_Creation_Date);	
            self.ar_filed_dt                      :=if(_validate.date.fIsValid(ArNewDate) and 
			                                         _validate.date.fIsValid((ArNewDate),_validate.date.rules.DateInPast)
			                                             
														,ArNewDate,''); 
			self                                  := [];

		end; // end of in_AR_transform M.R.
		
		
		
		
		// Event1_TRANSFORM M.R.		
		

		

		Corp2.Layout_Corporate_Direct_Event_In in_event1Transform(layouts_raw_input.Corp_Filings input):=transform
			self.corp_key					    := '18-' +trim(input.Fili_Packet_Number, left, right);
			self.corp_vendor				    := '18';
			self.corp_state_origin			    := 'IN';
			self.corp_process_date			    := fileDate;
			self.corp_sos_charter_nbr		    := trim(input.Fili_Packet_Number, left, right);
			EventNewDate1                       :=reformatDate(input.Fili_Filing_Date);	
			self.event_filing_date              :=if(_validate.date.fIsValid(EventNewDate1) and 
			                                         _validate.date.fIsValid((EventNewDate1),_validate.date.rules.DateInPast),
			                                           EventNewDate1 ,'');
            self.event_filing_cd                :=trim(input.Fili_Filing_Type,left, right);
            self.event_filing_reference_nbr     :=trim(input.Fili_DCN, left, right);
			
            self                                := [];
		
			
			
		end; // end of in_Event1_transform M.R.
		
		
		
	// Event2_TRANSFORM M.R.		
		

		

		Corp2.Layout_Corporate_Direct_Event_In in_event2Transform(layouts_raw_input.Corp_Mergers input):=transform
			self.corp_key					    := '18-' +trim(input.Merg_Survivor_Packet, left, right);
			self.corp_vendor				    := '18';
			self.corp_state_origin			    := 'IN';
			self.corp_process_date			    := fileDate;
			self.corp_sos_charter_nbr		    := trim(input.Merg_Survivor_Packet, left, right);
			EventNewDate2                       :=reformatDate(input.Merg_Creation_Date);	
			self.event_filing_date              :=if(_validate.date.fIsValid(EventNewDate2 ) and 
			                                         _validate.date.fIsValid(EventNewDate2 ,_validate.date.rules.DateInPast)
			                                              and EventNewDate2  <>'',
														EventNewDate2 ,'');
           
            self.event_filing_reference_nbr     :=trim(input.Merg_Survivor_Packet, left, right);
			self.event_date_type_cd             :=if(trim(input.Merg_Creation_Date ,left,right)<>'','MER','');
            self.event_date_type_desc           :=if(trim(input.Merg_Creation_Date,left,right)<>'','MERGER','');
            self                                := [];
		
			
		end; // end of in_Event2_transform M.R.
		
		
		
		
		// contact_TRANSFORM

		corp2_mapping.Layout_ContPreClean in_contactTransform(layouts_raw_input.Corp_Officers_Corporations  input):=transform
		    self.dt_first_seen			  :=fileDate;
			self.dt_last_seen			  :=fileDate;
		    self.corp_key					  := '18-' +trim(input.Offi_Packet_Number, left,right);
			self.corp_vendor				  := '18';
			self.corp_state_origin			  := 'IN';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    := trim(input.Offi_Packet_Number ,left,right);
			self.corp_legal_name              :=if(trim(input.Corp_Name,left,right)<>'',trim(stringlib.StringtoUpperCase(input.Corp_Name),left,right),'');
			
			self.cont_title1_desc             :=map(trim(input.offi_Position_Type,left,right)='1'=>'PRESIDENT',
                                                    trim(input.offi_Position_Type,left,right)='2'=>'VICE PRESIDENT',
                                                    trim(input.offi_Position_Type,left,right)='3'=>'SECRETARY',
                                                    trim(input.offi_Position_Type,left,right)='4'=>'TREASURER',
                                                    trim(input.offi_Position_Type,left,right)='5'=>'INCORPORATOR',
                                                    trim(input.offi_Position_Type,left,right)='6'=>'NEW FILING OFFICER',
                                                    trim(input.offi_Position_Type,left,right)='7'=>'GENERAL PARTNER',
                                                    trim(input.offi_Position_Type,left,right)='8'=>'DIRECTOR',
                                                    trim(input.offi_Position_Type,left,right)='9'=>'OTHER',
                                                    trim(input.offi_Position_Type,left,right)='10'=>'MANAGE',
                                                    trim(input.offi_Position_Type,left,right)='11'=>'PARTNER',
                                                    trim(input.offi_Position_Type,left,right)='12'=>'CEO',
                                                    trim(input.offi_Position_Type,left,right)='13'=>'TRUSTEE',''
													  );
			self.cont_type_cd                 :=if(trim(input.offi_Position_Type,left,right)<>'','F','');
			self.cont_type_desc               :=if(trim(input.offi_Position_Type,left,right)<>'','OFFICER','');										  
            self.cont_name                    :=if(trim(input.offi_Name,left,right)<>'',trim(stringlib.StringtoUpperCase(input.offi_Name),left,right),'');
			
            self.cont_address_line1           :=if(trim(input.offi_Address_Line1,left,right)<>'',trim(stringlib.StringtoUpperCase(input.offi_Address_Line1),left,right),'');
			self.cont_address_line2           :=if(trim(input.offi_Address_Line2,left,right)<>'',trim(stringlib.StringtoUpperCase(input.offi_Address_Line2),left,right),'');
			self.cont_address_line3           :=if(trim(input.offi_City,left,right)<>'',trim(stringlib.StringtoUpperCase(input.offi_City),left,right),'');
			self.cont_address_line4           :=if(trim(input.offi_State,left,right)<>'',trim(stringlib.StringtoUpperCase(input.offi_State),left,right),'');
			ZipCode                           :=if((string)((integer)trim(input.offi_Zip_Code,left,right)) <> '0' and trim(input.offi_Zip_Code,left,right)<>'',trim(input.offi_Zip_Code,left,right),'');
            ZipExtension                      :=if((string)((integer)trim(input.offi_Zip_Extension,left,right)) <> '0' and trim(input.offi_Zip_Extension,left,right)<>'',trim(input.offi_Zip_Extension,left,right),'');
			self.cont_address_line5           :=ZipCode+ZipExtension;
			
			ContNewDate                       :=reformatDate(input.offi_Creation_Date);	
			ContNewDate1                      :=if(_validate.date.fIsValid(ContNewDate) and 
			                                         _validate.date.fIsValid((ContNewDate),_validate.date.rules.DateInPast),
			                                             ContNewDate ,'');
			self.cont_filing_date             :=ContNewDate1;  
			self.cont_filing_cd               :=if(ContNewDate1<>'','C','');
			self.cont_filing_desc             :=if(ContNewDate1<>'','CREATION','');    
			
            self                              := [];
			
		end; // end of in_contact_transform     
		
		
		
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
												trim(input.corp_address1_line5,left,right),left,right));

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
			
			
			
			
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' + 														                        
												trim(input.corp_ra_address_line2,left,right),left,right),														                   
												trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
												trim(input.corp_ra_address_line4,left,right) + ' ' +
												trim(input.corp_ra_address_line5,left,right),left,right));

												
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
											trim(input.cont_address_line5,left,right),left,right));

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
		//layouts join for cont
		
		Layouts_Raw_Input.Corp_Officers_Corporations MergeCont(Layouts_Raw_Input.Corp_Officers l, Layouts_Raw_Input.Corp_Corporations r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinCorpOfficers := join(	Files_Raw_Input.CorpOfficers(fileDate), Files_Raw_Input.CorpCorporations(fileDate),
								trim(left.offi_Packet_Number,left,right) = trim(right.Corp_Packet_Number,left,right),
								MergeCont(left,right),
								left outer
							);
							
							
		//layouts join for corp
		
		Layouts_Raw_Input.CorpAgents MergeCorpAgents(Layouts_Raw_Input.Corp_Agents l, Layouts_Raw_Input.Corp_Corporations r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinCorpAgents := join(	Files_Raw_Input.CorpAgents(fileDate), Files_Raw_Input.CorpCorporations(fileDate),
								trim(left.Agen_Packet_Number,left,right) = trim(right.Corp_Packet_Number,left,right),
								MergeCorpAgents(left,right),
								left outer
							);
							
       
							
		//layouts join for event	
		
		
		 MapEvent1 							:= project(Files_Raw_Input.CorpFilings(filedate), in_event1Transform(left));
		 MapEvent2 							:= project(Files_Raw_Input.CorpMergers(filedate), in_event2Transform(left));
		 MapCorp1                            := project(joinCorpAgents,in_corp1Transform_Business(left)) ;
		 MapCorp2                            := project(Files_Raw_Input.CorpCorporations(filedate),in_corp2Transform_Business(left)) ;
		 MapCorp3                            := project(Files_Raw_Input.CorpNames(filedate),in_corp3Transform_Business(left)) ;
		//--------------------------- Explosion Table Logic -----------------------//
		 //for corp 
		 corp2_mapping.Layout_CorpPreClean findState(corp2_mapping.Layout_CorpPreClean input, ForgnStateDescLayout r ) := transform
			self.corp_forgn_state_desc  := r.desc;
			self         			    := input;
			self                        := [];
		end; 
		
		// end transform
		
			
		//StatusCode join
		
		joinStateType := 	join(	MapCorp1,ForgnStateTable,
									trim(left.corp_forgn_state_cd,left,right) =  trim(right.code,left,right),
									findState(left,right),
									left outer, lookup
								);
								
		 
								
		corp2_mapping.Layout_CorpPreClean EntityTypeCode(corp2_mapping.Layout_CorpPreClean input, EntityTypeLayout r ) := transform
			      self.corp_orig_org_structure_desc    := trim(stringlib.StringtoUpperCase(r.EntityDesc),left,right);
			      self         			               := input;
			      self                                 := [];
		 end; // end transform
		
		//FilingCode join
		 joinEntityType :=join(joinStateType,EntityTypeTable,
									trim(left.corp_orig_org_structure_cd,left,right) = trim(right.EntityCode,left,right),
									EntityTypeCode(left,right),
									left outer, lookup
								);
								
           //for event 
		 Corp2.Layout_Corporate_Direct_Event_In FilingTypeCode(Corp2.Layout_Corporate_Direct_Event_In input, FilingTypeLayout r ) := transform
			      self.event_Filing_desc    := r.FilingDesc;
			      self         			    := input;
			      self                      := [];
		 end; // end transform
		
		//FilingCode join
		 joinFilingType :=join(MapEvent1,FilingTypeTable,
									trim(left.event_filing_cd,left,right) = trim(right.FilingCode,left,right),
									FilingTypeCode(left,right),
									left outer, lookup
								);

		        AllEvent :=joinFilingType+MapEvent2;
				//MapEvent := sort(AllEvent,corp_key);
				
				
		        AllCorp := joinEntityType+MapCorp2+ MapCorp3;
                MapCorp := sort(AllCorp,corp_key);
		
		        cleanCorps := project(MapCorp,CleanCorpNameAddr(left));			
				
               
                MapAR 								:= project(Files_Raw_Input.CorpReports(filedate), in_arTransform(left));
				
				
				MapCont 							:= project(joinCorpOfficers, in_contactTransform(left));
			    cleanCont                           := project(MapCont , CleanContNameAddr(left));
		
		
		
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_in'	,cleanCorps	,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_in'	,AllEvent		,event_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_in'		,MapAR			,ar_out			,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_in'	,cleanCont	,cont_out		,,,pOverwrite);
		                                                                                                                                                      
		 mapped_in_Filing := parallel(
				 corp_out	
				,event_out
				,ar_out		
				,cont_out	

		);        

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('in',filedate,pOverwrite := pOverwrite))
			,mapped_in_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_in')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_in')						  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_in')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_in')
			)							
		);
	 
		return result;
	end;					 
	
end; // end of in module

		