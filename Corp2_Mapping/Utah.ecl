import Corp2,ut, lib_stringlib, _validate, Address, _control, versioncontrol; 
 export utah:= MODULE;  // ut module has three vendor layouts 

  export Layouts_Raw_Input := MODULE;
       
          export  Busentity:= record
	   	string		Entity_Number;
		string		Entity_ID;
		string		Entity_Type;
		string		License_Type;
		string		Business_Name;
		string		Address;
		string		Address2;
		string		City;
		string		State;
		string		Zip;
		string		Registration_Date;
		string		Expiration_Date;
		string		License_Status;
		string		Home_State;
		string		Status_Reason;
		string	    Last_Renewal_Date;
		string		Date_Status_Changed;
		string		Applicant_Name;
		string		NAICS_Code;
		string	    newline1;
		
     end;
	 
	 	export Principals:= record
		string		Prin_Entity_ID;
		string		Prin_Entity_Type;
		string		Prin_License_Type;	
		string		Prin_Business_Name;	
		string		Prin_Member_Position;
		string		Prin_Full_name;	
		string		Prin_Address;	
		string		Prin_Address2;	
		string		Prin_City;	
		string		Prin_State;
		string		Prin_Zip_Code;	
		string		newlin2;
    end;
	
	
	
	export Businfo := record
		string	Info_Entity_ID;
		string	Info_Entity_Type;
		string	Info_License_Type;
		string	Info_Business_Name;	
		string	Information_Type;
		string	Information;
		string	newline3;
    end;
	 
	
	 export  Busentity_Principals:= record
	    string		Entity_Number;
		string		Entity_ID;
		string		Entity_Type;
		string		License_Type;
		string		Business_Name;
		string		Address;
		string		Address2;
		string		City;
		string		State;
		string		Zip;
		string		Registration_Date;
		string		Expiration_Date;
		string		License_Status;
		string		Home_State;
		string		Status_Reason;
		string	    Last_Renewal_Date;
		string		Date_Status_Changed;
		string		Applicant_Name;
		string		NAICS_Code;
		string	    newline1;
		
		string		Prin_Entity_ID;
		string		Prin_Entity_Type;
		string		Prin_License_Type;	
		string		Prin_Business_Name;	
		string		Prin_Member_Position;
		string		Prin_Full_name;	
		string		Prin_Address;	
		string		Prin_Address2;	
		string		Prin_City;	
		string		Prin_State;
		string		Prin_Zip_Code;	
		string		newlin2;
     end;
	 
	  export  Busentity_Businfo:= record
	      Busentity;
          Businfo;
     end;
	 
	 export  Busentity_Businfo_Principals:= record
	    string		Entity_Number;
		string		Entity_ID;
		string		Entity_Type;
		string		License_Type;
		string		Business_Name;
		string		Address;
		string		Address2;
		string		City;
		string		State;
		string		Zip;
		string		Registration_Date;
		string		Expiration_Date;
		string		License_Status;
		string		Home_State;
		string		Status_Reason;
		string	    Last_Renewal_Date;
		string		Date_Status_Changed;
		string		Applicant_Name;
		string		NAICS_Code;
		string	    newline1;
		
		string		Prin_Entity_ID;
		string		Prin_Entity_Type;
		string		Prin_License_Type;	
		string		Prin_Business_Name;	
		string		Prin_Member_Position;
		string		Prin_Full_name;	
		string		Prin_Address;	
		string		Prin_Address2;	
		string		Prin_City;	
		string		Prin_State;
		string		Prin_Zip_Code;	
		string		newlin2;
		
		string	Info_Entity_ID;
		string	Info_Entity_Type;
		string	Info_License_Type;
		string	Info_Business_Name;	
		string	Information_Type;
		string	Information;
		string	newline3;
     end;
	 
	 
	 


	
  end; // end of Layouts_Raw_Input module
  
   
  export Files_Raw_Input := MODULE;
	
	   																			 
	   export Busentity(string fileDate)   := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Busentity::ut',
														        layouts_Raw_Input.Busentity,CSV(HEADING(1),SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n', '\n'])));
												
	
																
      export Principals(string fileDate)   := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Principals::ut',
   														       layouts_Raw_Input.Principals,CSV(HEADING(1),SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n', '\n'])));
   																
   	  export Businfo(string fileDate)   := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Businfo::ut',
   														       layouts_Raw_Input.Businfo,CSV(HEADING(1),SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n', '\n'])));
   		

																
	 
		
  end;	
  
 
 
  export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
     //StateCode type layout
		
		ForgnStateDescLayout := record,MAXLENGTH(100)
               string code;
               string desc;

        end; 

            

       ForgnStateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstateprovince_table', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
	   
	    
        trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		
       reformatDate(string rDate) := function
	       return  StringLib.StringFindReplace(StringLib.StringFilterOut(rDate,''),'-','');
			
		end;
		
		
	 export FinalcorpFile:= record
	    string15		Entity_Number;
		string9		    Entity_ID;
		string60		Entity_Type;
		string60		License_Type;
		string100		Business_Name;
		string60		Address;
		string60		Address2;
		string40		City;
		string10		State;
		string10		Zip;
		string10		Registration_Date;
		string10		Expiration_Date;
		string40		License_Status;
		string20		Home_State;
		string200		Status_Reason;
		string10	    Last_Renewal_Date;
		string10		Date_Status_Changed;
		string100		Applicant_Name;
		string10		NAICS_Code;
		string1		    newline1;
		string9		    Prin_Entity_ID;
		string60		Prin_Entity_Type;
		string60		Prin_License_Type;	
		string100		Prin_Business_Name;	
		string30		Prin_Member_Position;
		string100		Prin_Full_name;	
		string60		Prin_Address;	
		string60		Prin_Address2;	
		string40		Prin_City;	
		string10		Prin_State;
		string10		Prin_Zip_Code;	
		string1		    newlin2;
		string9		Info_Entity_ID;
		string60	Info_Entity_Type;
		string60	Info_License_Type;
		string100	Info_Business_Name;	
		string60	Information_Type;
		string60	Information;
		
		string60	Information_Type1;
		string60	Information1;
		//string2     str_counter := '';
		
		string1		newline3;
     end;
	 

		
	 	//----------------layouts join for corp-----------------------//
		Layouts_Raw_Input.Busentity_Principals MergeBusentity_Principals(  Layouts_Raw_Input. Busentity  l ,Layouts_Raw_Input.Principals r ) := transform
		    self 					:= l;
		    self					:= r;
		    self                    := [];
			
		end; // end transform 
		
		joinBusentity_Principals := join(Files_Raw_Input.Busentity(fileDate),dedup(Files_Raw_Input.Principals(fileDate),record,all), 
						trim(left.Entity_ID,left,right) = trim(right.Prin_Entity_ID,left,right) and
						trimUpper(trim(right.prin_member_position,left,right)) = 'REGISTERED AGENT' and
						trim(left.Entity_Type,left,right) = trim(right.Prin_Entity_Type,left,right),
						MergeBusentity_Principals(left,right),
						left outer
					); 
							
	Layouts_Raw_Input.Busentity_Businfo_Principals MergeBusentity_Principals_Businfo(  Layouts_Raw_Input.Busentity_Principals  l ,Layouts_Raw_Input.Businfo  r ) := transform
		    self 					:= l;
		    self					:= r;
		    self                    := [];
			
		end; // end transform               

		
		joinBusentity_Principals_Businfo := join(joinBusentity_Principals, dedup(Files_Raw_Input.Businfo(fileDate), record,all), 
						trim(left.Entity_ID,left,right) = trim(right.Info_Entity_ID,left,right)and
						trim(left.Entity_Type,left,right) = trim(right.Info_Entity_Type,left,right),
						MergeBusentity_Principals_Businfo(left,right),
						left outer
					);
	
	sortcorpFile		:= dedup(sort(joinBusentity_Principals_Businfo, entity_id, entity_type, prin_member_position, information_type, -information), entity_id, entity_type, prin_member_position, information_type):persist('thor_data400::persist::input::utah');
	//output(sortcorpFile);
	 
  distcorp 	:= distribute( sortcorpFile,hash64(Entity_Type,Entity_ID))(      
														     lib_stringlib.StringLib.StringFind(trimUpper(Information_Type),'STOCK',1) = 0 and
														    lib_stringlib.StringLib.StringFind(trimUpper(Information_Type),'NAICS CODE',1) = 0 )  :persist('thor_data400::persist::output::utah');
  
   FinalcorpFile	newcorpTransform(distcorp l) := transform
			self			:=l;
			self			:=[];
		end;
		newcorpFile		:= project(distcorp, newcorpTransform(left));
		
		
	   FinalcorpFile Denormcorps(FinalcorpFile L, FinalcorpFile R, INTEGER C) := TRANSFORM
	       // self.str_counter            := (string)c;
			self.Information_Type1		:= IF (C=2, R.Information_Type, l.Information_Type); 
			self.Information1		  	:= IF (C=2, R.Information, l.Information); 
			self 			 			:= L;
		END;
		
		
		dedupNewcorpFile := dedup(sort(newcorpFile, entity_id, entity_type));
		
		
		DenormalizedcorpFile := dedup(sort(denormalize(dedupNewcorpFile, dedupNewcorpFile,
											trim(left.Entity_ID,left,right) = trim(right.Entity_ID,left,right) and
											trim(left.Entity_Type,left,right) = trim(right.Entity_Type,left,right),
											Denormcorps(left,right,COUNTER)),Entity_Type, Entity_ID),Entity_ID,Information_Type1,information1) ;
											
											
		
		DedupDenormalizedcorp := dedup(DenormalizedcorpFile, record,all);	

		
		
   corp2_mapping.Layout_CorpPreClean ut_corpTransform_Business(FinalcorpFile input):=transform
                                                  
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='49-'+trimUpper(input.Entity_Number);
			self.corp_vendor					  :='49';
		    self.corp_state_origin                :='UT';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trimUpper(input.Entity_Number);
			self.corp_for_profit_ind              :=map(trimUpper(input.License_Type)='CORPORATION - DOMESTIC - PROFIT'=>'Y',
    			                                        trimUpper(input.License_Type)='CORPORATION - FOREIGN - PROFIT'=>'Y',
    			                                        trimUpper(input.License_Type)='CORPORATION - DOMESTIC - NON-PROFIT'=>'N',
				                                        trimUpper(input.License_Type)='CORPORATION - FOREIGN - NON-PROFIT'=>'N','');
			
			
			self.corp_foreign_domestic_ind        :=map(lib_stringlib.StringLib.StringFind(trimUpper(input.License_Type),'DOMESTIC',1) <>0=>'D',
			                                            lib_stringlib.StringLib.StringFind(trimUpper(input.License_Type),'FOREIGN',1) <>0=>'F','');
			
		    self.corp_legal_name                  :=if(trimUpper(input.License_Type)<>'',trimUpper(input.Business_Name),'');
			
			self.corp_ln_name_type_cd             :=map(trimUpper(input.License_Type)<>'BUSINESS NAME RESERVATION'=>'07',
			                                            trimUpper(input.License_Type)<>'DBA'=>'02','01');
			
			self.corp_ln_name_type_desc           :=map(trimUpper(input.License_Type)<>'BUSINESS NAME RESERVATION'=>'RESERVED',
			                                             trimUpper(input.License_Type)<>'DBA'=>'DBA','LEGAL');
			self.corp_internal_nbr                :='';
         	self.corp_address1_line1              :=if(trimUpper(input.Address)<>'',trimUpper(input.Address),'');
			self.corp_address1_line2              :=if(trimUpper(input.City)<>'' and trimUpper(input.City)<>'UNKNOWN',trimUpper(input.City),'');
			self.corp_address1_line3              :=if(trimUpper(input.State)<>'' and trimUpper(input.State)<>'NA'  ,trimUpper(input.State),'');
			self.corp_address1_line4              :=if(trimUpper(input.Zip)<>''and (string)((integer)trimUpper(input.Zip)) <> '0' and (string)((integer)trimUpper(input.Zip[6..9])) <> '0',trimUpper(input.Zip),'');
			
			self.corp_address1_type_cd            :=if(self.corp_address1_line1<>''or self.corp_address1_line2<>'' or 
			                                           self.corp_address1_line3<>''  or
												      self.corp_address1_line4<>'','M','');
													   
			self.corp_address1_type_desc          :=if(self.corp_address1_line1<>''or self.corp_address1_line2<>'' or 
			                                           self.corp_address1_line3<>''  or
												      self.corp_address1_line4<>'','MAILING','');
													   			
            self.corp_status_desc                 :=if(trimUpper(input.License_Status)<>'',trimUpper(input.License_Status),'');
		    self.corp_status_date                 :=if(reformatDate(input.Date_Status_Changed) <> ''and (string)((integer)reformatDate(input.Date_Status_Changed)) <> '0' and _validate.date.fIsValid(reformatDate(input.Date_Status_Changed)) and 
														_validate.date.fIsValid((reformatDate(input.Date_Status_Changed) ),_validate.date.rules.DateInPast),reformatDate(input.Date_Status_Changed),if(reformatDate(input.Last_Renewal_Date) <> ''and 
														 (string)((integer)reformatDate(input.Last_Renewal_Date)) <> '0' and _validate.date.fIsValid(reformatDate(input.Last_Renewal_Date) ) and 
														_validate.date.fIsValid((reformatDate(input.Last_Renewal_Date) ),_validate.date.rules.DateInPast),
														reformatDate(input.Last_Renewal_Date),''));
														
			corpstanding                          :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.Status_Reason),'GOOD STANDING',1) <>0 ,
                                                      '', 'Y'); 
			self.corp_standing                    :=corpstanding; 
			
			self.corp_status_comment              :=if(corpstanding='',trimUpper(input.Status_Reason),''); 
		    k                                   :=reformatDate(input.Information1);	    
			d                                    :=reformatDate(input.Information);

			n                                    :=  StringLib.StringFindReplace(StringLib.StringFilterOut(d,'years'), ' ', ' ');	
            n2                                   :=  StringLib.StringFindReplace(StringLib.StringFilterOut(d,'yrs'), ' ', ' ');	
            n1                                   :=if(ut.isNumeric(n), n, if(ut.isNumeric(n2) ,n2,''));
			
			m                                    :=  StringLib.StringFindReplace(StringLib.StringFilterOut(k,'years'), ' ', ' ');	
            m2                                   :=  StringLib.StringFindReplace(StringLib.StringFilterOut(k,'yrs'), ' ', ' ');	
            m1                                   :=if(ut.isNumeric(m), m, if(ut.isNumeric(m2) ,m2,''));
			
			self.corp_term_exist_exp             :=if(trimUpper(input.Information_Type)='DURATION TIME' and trimUpper(input.Information)<>''and d<> ''
			                                        and (string)(integer)d<> '0'and _validate.date.fIsValid(d),
													d,if(reformatDate(input.Expiration_Date) <> ''and (string)((integer)reformatDate(input.Expiration_Date)) <> '0' 
													and _validate.date.fIsValid(reformatDate(input.Expiration_Date)),reformatDate(input.Expiration_Date),
                                                    if(trimUpper(input.Information_Type)='DURATION TIME' and  ut.isNumeric(n1),
												    n1,if(trimUpper(input.Information_Type1)='DURATION TIME' and trimUpper(input.Information1)<>''and k<> ''
			                                        and (string)(integer)k<> '0'and _validate.date.fIsValid(k),
													k,if(reformatDate(input.Expiration_Date) <> ''and (string)((integer)reformatDate(input.Expiration_Date)) <> '0' 
													and _validate.date.fIsValid(reformatDate(input.Expiration_Date)),reformatDate(input.Expiration_Date),
                                                    if(trimUpper(input.Information_Type1)='DURATION TIME' and  ut.isNumeric(m1),
												    m1,''))))));
														
			self.corp_term_exist_cd              :=if(trimUpper(input.Information_Type)='DURATION TIME' and trimUpper(input.Information)<>''and d<> ''
			                                        and (string)(integer)d <> '0'and _validate.date.fIsValid(d) ,
													'D',if(reformatDate(input.Expiration_Date) <> ''and (string)((integer)reformatDate(input.Expiration_Date)) <> '0' 
													and _validate.date.fIsValid(reformatDate(input.Expiration_Date)),'D',
                                                    if(trimUpper(input.Information_Type)='DURATION TIME' and trimUpper(input.Information)='PERPETUAL','P',
												    if(trimUpper(input.Information_Type)='DURATION TIME' and ut.isNumeric(n1),'N',if(trimUpper(input.Information_Type1)='DURATION TIME' and trimUpper(input.Information1)<>''and k<> ''
			                                        and (string)(integer)k <> '0'and _validate.date.fIsValid(k) ,
													'D',if(reformatDate(input.Expiration_Date) <> ''and (string)((integer)reformatDate(input.Expiration_Date)) <> '0' 
													and _validate.date.fIsValid(reformatDate(input.Expiration_Date)),'D',
                                                    if(trimUpper(input.Information_Type1)='DURATION TIME' and trimUpper(input.Information1)='PERPETUAL','P',
												    if(trimUpper(input.Information_Type1)='DURATION TIME' and ut.isNumeric(m1),'N',''))))))));
														
 			self.corp_term_exist_desc            :=if(trimUpper(input.Information_Type)='DURATION TIME' and trimUpper(input.Information)<>''and d<> ''
			                                        and (string)(integer)d <> '0'and _validate.date.fIsValid(d) ,
													'EXPIRATION DATE',if(reformatDate(input.Expiration_Date) <> ''and (string)((integer)reformatDate(input.Expiration_Date)) <> '0' 
													and _validate.date.fIsValid(reformatDate(input.Expiration_Date)),'EXPIRATION DATE',
                                                    if(trimUpper(input.Information_Type)='DURATION TIME' and trimUpper(input.Information)='PERPETUAL','PERPETUAL',
												    if(trimUpper(input.Information_Type)='DURATION TIME' and ut.isNumeric(n1),'NUMBER OF YEARS',if(trimUpper(input.Information_Type1)='DURATION TIME' and trimUpper(input.Information1)<>''and k<> ''
			                                        and (string)(integer)k <> '0'and _validate.date.fIsValid(k) ,
													'EXPIRATION DATE',if(reformatDate(input.Expiration_Date) <> ''and (string)((integer)reformatDate(input.Expiration_Date)) <> '0' 
													and _validate.date.fIsValid(reformatDate(input.Expiration_Date)),'EXPIRATION DATE',
                                                    if(trimUpper(input.Information_Type1)='DURATION TIME' and trimUpper(input.Information1)='PERPETUAL','PERPETUAL',
												    if(trimUpper(input.Information_Type1)='DURATION TIME' and ut.isNumeric(m1),'NUMBER OF YEARS',if(trimUpper(input.Information_Type)='DURATION' and trimUpper(input.Information)<>'','DURATION: '+trimUpper(input.Information),
													if(trimUpper(input.Information_Type1)='DURATION' and trimUpper(input.Information1)<>'','DURATION: '+trimUpper(input.Information1),''))))))))));


			c                                    :=reformatDate(input.Registration_Date);
			self.corp_inc_date                   :=if(c <> ''and (string)(integer)c<> '0' and _validate.date.fIsValid(c) and 
													_validate.date.fIsValid((c),_validate.date.rules.DateInPast),
													c,'');
			f									 := reformatDate(input.Information);
			l                                    := reformatDate(input.Information1);
            self.corp_forgn_date                 :=if((input.Information_Type)<>''and trimUpper(input.Information_Type)='INCORPORATED IN HOME STATE DATE'and f<> ''and (string)(integer)f <> '0' 
			                                        and _validate.date.fIsValid(f) and 
													_validate.date.fIsValid((f),_validate.date.rules.DateInPast),
													f,if((input.Information_Type1)<>''and trimUpper(input.Information_Type1)='INCORPORATED IN HOME STATE DATE'and l<> ''and (string)(integer)l <> '0' 
			                                        and _validate.date.fIsValid(l) and 
													_validate.date.fIsValid((l),_validate.date.rules.DateInPast),
													l,''));
													
  		    self.corp_inc_state                  :=if(input.Home_State='' or trimUpper( input.Home_State) ='UT', 'UT','');
            self.corp_forgn_state_cd             :=if(input.Home_State<>'' and trimUpper( input.Home_State) <>'UT', trimUpper( input.Home_State),'');
			self.corp_orig_org_structure_desc    :=trimUpper(input.License_Type);
			self.corp_naic_code                  :=if(input.NAICS_Code <>'', trimUpper( input.NAICS_Code),'');
			self.corp_entity_desc                :=if(input.Entity_Type <>'', trimUpper( input.Entity_Type),'');
		    self.corp_ra_name                    :=if(input.Prin_Full_name<>'',trimUpper(input.Prin_Full_name),'');
			self.corp_ra_address_line1           :=if( (input.Prin_Address)<>'',trimUpper(input.Prin_Address),'');
			self.corp_ra_address_line2           :=if( (input.Prin_City)<>'',trimUpper(input.Prin_City),'');
			self.corp_ra_address_line3           :=if((input.Prin_State)<>'',trimUpper(input.Prin_State),'');
			self.corp_ra_address_line4           :=if((input.Prin_Zip_Code)<>''and (string)((integer)trimUpper(input.Prin_Zip_Code)) <> '0',trimUpper(input.Prin_Zip_Code),''); 
			self.corp_ra_address_type_desc       :=if( (input.Prin_Address)<>''or
														 (input.Prin_City)<>''or
														 (input.Prin_State)<>''or
														(input.Prin_Zip_Code)<>'' ,'REGISTERED OFFICE','');
														
 			corp_addl1                  		 :=	If(input.Information_Type <>'' and trimUpper(input.Information_Type)<>'NAICS TITLE' and trimUpper(input.Information_Type)<>'ADDITIONAL PRINCIPALS'and  trimUpper(input.Information_Type)<>'NUMBER OF PARTNERS'and  input.Information <>'',trimUpper(input.Information_Type) +': '+ trimUpper(input.Information),
   														If(input.Information_Type1 <>'' and trimUpper(input.Information_Type1)<>'NAICS TITLE' and trimUpper(input.Information_Type1)<>'ADDITIONAL PRINCIPALS'and  trimUpper(input.Information_Type1)<>'NUMBER OF PARTNERS' and input.Information1 <>'',trimUpper(input.Information_Type1) +': '+ trimUpper(input.Information1),''));											
   			
   			corp_addl2        					 :=	If(trimUpper(input.Information_Type)='ADDITIONAL PRINCIPALS' and input.Information <>'','ADDITIONAL PRINCIPALS: '+trimUpper(input.Information),
   													If(trimUpper(input.Information_Type1)='ADDITIONAL PRINCIPALS' and input.Information1 <>'','ADDITIONAL PRINCIPALS: '+trimUpper(input.Information1),''));
   													
   			corp_addl3        					 :=	If(trimUpper(input.Information_Type)='NAICS TITLE' and input.Information <>'','NAICS TITLE: '+trimUpper(input.Information),
   													If(trimUpper(input.Information_Type1)='NAICS TITLE' and input.Information1 <>'','NAICS TITLE: '+trimUpper(input.Information1),''));
   													
   			corp_addl4         					 :=	If(trimUpper(input.Information_Type)='NUMBER OF PARTNERS' and input.Information <>'','NUMBER OF PARTNERS: '+trim(input.Information,left,right),
   													If(trimUpper(input.Information_Type1)='NUMBER OF PARTNERS' and input.Information1 <>'','NUMBER OF PARTNERS: '+trim(input.Information1,left,right),'') );
   			
   			
   			concatFields						 := 	trim(corp_addl1,left,right) + ';' + 
   														trim(corp_addl2,left,right) + ';' +  
   														trim(corp_addl3,left,right) + ';' + 
   														trim(corp_addl4,left,right) ;  
   		
   				
   			tempExp								 := regexreplace('[;]*$',concatFields,'',NOCASE);
   			tempExp2							 := regexreplace('^[;]*',tempExp,'',NOCASE);

			self.corp_addl_info        			 := regexreplace('[;]+',tempExp2,';',NOCASE);
		    self                                 := [];
		
   end;		
	  
	  
	  
	  
	  
	 Corp2.Layout_Corporate_Direct_Stock_In ut_stock1Transform(Corp2.Layout_Corporate_Direct_Stock_In input):=transform,skip(input.stock_addl_info='' and input.stock_shares_issued ='')
			self                                  :=input;
        	self                                  := [];
			
			
	 end; // end of ut_Stock_transform M.R.
	 
	 
	// Stock_TRANSFORM M.R.
	 Corp2.Layout_Corporate_Direct_Stock_In ut_stockTransform(layouts_raw_input.Busentity_Businfo input):=transform
			self.corp_key					      := '49-' +trim(input.Entity_Number, left, right);
			self.corp_vendor				      := '49';
			self.corp_state_origin			      := 'UT';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.Entity_Number, left, right);
			self.stock_addl_info                  :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.Information),'CLASS A COMMON',1) <>0 and
														not lib_stringlib.StringLib.StringFind(trimUpper(input.Information),'CLASS B COMMON',1) <>0  and
														not lib_stringlib.StringLib.StringFind(trimUpper(input.Information),'CLASS B VOTING',1) <>0 and
														not lib_stringlib.StringLib.StringFind(trimUpper(input.Information),'PREFERRED',1) <>0 and
														not lib_stringlib.StringLib.StringFind(trimUpper(input.Information),'STOCK CLASS',1) <>0 and
														not lib_stringlib.StringLib.StringFind(trimUpper(input.Information),'COMMON',1) <>0 ,'',trimUpper(input.Information_Type)+':'+trimUpper(input.Information));

            stocksharesissued                     := if( trimUpper(input.Information)<>''and (trimUpper(input.Information_Type)='STOCK CLASS 1 AMOUNT' or trimUpper(input.Information_Type)='STOCK CLASS 2 AMOUNT'),trimUpper(input.Information),'');
			self.stock_shares_issued              :=if(stocksharesissued<>'0', stocksharesissued,'');
        	self                                  := [];
			
			
	 end; // end of ut_Stock_transform M.R.
	 
	  // contact_TRANSFORM
		 
		 	

		 
			//layouts join for cont
		
		FinalOfficerFile := record
		string15		Entity_Number;
		string9		    Entity_ID;
		string60		Entity_Type;
		string60		License_Type;
		string100		Business_Name;
		string60		Address;
		string60		Address2;
		string40		City;
		string10		State;
		string10		Zip;
		string10		Registration_Date;
		string10		Expiration_Date;
		string40		License_Status;
		string20		Home_State;
		string200		Status_Reason;
		string10	    Last_Renewal_Date;
		string10		Date_Status_Changed;
		string100		Applicant_Name;
		string10		NAICS_Code;
		string1		    newline1;
    
		string9		    Prin_Entity_ID;
		string60		Prin_Entity_Type;
		string60		Prin_License_Type;	
		string100		Prin_Business_Name;	
		string30		Prin_Member_Position;
		string100		Prin_Full_name;	
		string60		Prin_Address;	
		string60		Prin_Address2;	
		string40		Prin_City;	
		string10		Prin_State;
		string10		Prin_Zip_Code;	
		string1		    newlin2;
		string      Title1;
		string      Title2;
		string      Title3;
		string      Title4;
		string      Title5;
        
		end;
		
		

		//layouts join for cont
		
		Layouts_Raw_Input.Busentity_Principals  MergeCont(Layouts_Raw_Input.Busentity l, Layouts_Raw_Input.Principals r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinCont := join(	dedup(Files_Raw_Input.Busentity(fileDate),record,all), dedup(Files_Raw_Input.Principals(fileDate),record,all),
								trim(left.Entity_ID,left,right) = trim(right.Prin_Entity_ID,left,right)and
								trim(left.Entity_Type,left,right) = trim(right.Prin_Entity_Type,left,right)and
								trimUpper(right.Prin_Member_Position)<>'REGISTERED AGENT',
								MergeCont(left,right),
								left outer
							);
							
							
							
       //------- Denormalize above result to get all titles in one record ------------------
	   
	   sortOffFile		:= sort(joinCont,Entity_Type,Entity_ID,Prin_Full_name,	Prin_Address,	Prin_Address2,	Prin_City,	Prin_State,Prin_Zip_Code);
	   
		distofficers 	:= distribute(sortOffFile,hash64(Entity_Type,Entity_ID,Prin_Full_name,	Prin_Address,	Prin_Address2,	Prin_City,	Prin_State,Prin_Zip_Code));
		FinalOfficerFile	newTransform(joinCont l) := transform
			self			:=l;
			self			:=[];
		end;
		newOfficerFile		:= project(distOfficers, newTransform(left));
		
		
	  FinalOfficerFile DenormOfficers(FinalOfficerFile L, FinalOfficerFile R, INTEGER C) := TRANSFORM
		
			self.Title1 	  := IF (C=1, R.Prin_Member_Position,L.TITLE1);                  
			self.title2		  := IF (C=2, R.Prin_Member_Position,L.TITLE2);
			self.title3		  := IF (C=3, R.Prin_Member_Position,L.TITLE3); 
			self.title4		  := IF (C=4, R.Prin_Member_Position,L.TITLE4); 
			self.title5		  := IF (C=5, R.Prin_Member_Position,L.TITLE5);
			
			self 			  := L;
		END;
		dedupNewOfficerFile := dedup(sort(newOfficerFile, Entity_Type,Entity_ID,Prin_Full_name,	Prin_Address,	Prin_Address2,	Prin_City,	Prin_State,Prin_Zip_Code));


		DenormalizedFile := sort(denormalize(dedupNewOfficerFile, dedupNewOfficerFile,
											trim(left.Entity_ID,left,right) = trim(right.Entity_ID,left,right) and
											trim(left.Entity_Type,left,right) = trim(right.Entity_Type,left,right) and
											trim(left.Prin_Full_name,left,right) = trim(right.Prin_Full_name,left,right) and
											trim(left.Prin_Address,left,right) = trim(right.Prin_Address,left,right) and
											trim(left.Prin_Address2,left,right) = trim(right.Prin_Address2,left,right) and
											trim(left.Prin_City,left,right) = trim(right.Prin_City,left,right) and
											trim(left.Prin_State,left,right) = trim(right.Prin_State,left,right) and
											trim(left.Prin_Zip_Code,left,right) = trim(right.Prin_Zip_Code,left,right),
											DenormOfficers(left,right,COUNTER)), Entity_ID,Prin_Full_name,Prin_Member_Position,Prin_Address,Prin_Address2,Prin_City,Prin_State,Prin_Zip_Code) ;
											
											
		
		DedupDenormalized := dedup(DenormalizedFile, RECORD, all);
		 
		 
		
		 // contact_TRANSFORM
		corp2_mapping.Layout_ContPreClean ut_contactTransform(FinalOfficerFile input):=transform,skip(input.Prin_Member_Position='REGISTERED AGENT'or (input.Prin_Full_name='' and input.Prin_Member_Position='' and input.Prin_Address=''and input.Prin_City=''and input.Prin_State=''
		                                                                                                                           and input.Prin_Zip_Code=''))
		    self.dt_first_seen			      :=fileDate;
			self.dt_last_seen			      :=fileDate;
		    self.corp_key					  := '49-' +trim(input.Entity_Number, left, right);
			self.corp_vendor				  := '49';
			self.corp_state_origin			  := 'UT';
			self.corp_process_date			  := fileDate;
			self.corp_orig_sos_charter_nbr    := trim(input.Entity_Number, left, right);
			self.corp_legal_name              :=if(trimUpper(input.Business_Name)<>'',trimUpper(input.Business_Name),'');
            self.cont_name                    :=if(input.Prin_Full_name<>'',trimUpper(input.Prin_Full_name),'');
			self.cont_address_line1           :=if(trimUpper(input.Prin_Address)<>'',trimUpper(input.Prin_Address),'');
			self.cont_address_line2           :=if(trimUpper(input.Prin_City)<>'',trimUpper(input.Prin_City),'');
			self.cont_address_line3           :=if(trimUpper(input.Prin_State)<>'',trimUpper(input.Prin_State),'');
			self.cont_address_line4           :=if(trimUpper(input.Prin_Zip_Code)<>''and (string)((integer)trimUpper(input.Prin_Zip_Code)) <> '0',trimUpper(input.Prin_Zip_Code),''); 
			self.cont_address_type_cd         :=if(input.Prin_Address<>''or input.Prin_City<>''or input.Prin_State<>'' or input.Prin_Zip_Code<>'','T','');
            self.cont_address_type_desc       :=if(input.Prin_Address<>''or input.Prin_City<>''or input.Prin_State<>'' or input.Prin_Zip_Code<>'','CONTACT','');
				
			
			
			concatFields						 := 	trim(input.Title1,left,right) + ',' + 
																					trim(input.Title2,left,right) + ',' +  
																					trim(input.Title3,left,right) + ',' + 
																					trim(input.Title4,left,right) + ',' + 
																					trim(input.Title5,left,right) ;
				
			tempExp								 := regexreplace('[,]*$',concatFields,'',NOCASE);
			tempExp2							 := regexreplace('^[,]*',tempExp,'',NOCASE);
			self.cont_title1_desc         	     := regexreplace('[,]+',tempExp2,',',NOCASE);
													


													  		   
            self                                := [];
			
		 end; // end of contact_transform     
		
	 

	 
	  
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

							
		
				

	
	
		  MapCorp := project(DedupDenormalizedcorp,  ut_corpTransform_Business(left)) ;
		  
		//---------------------------layouts join for stock-----------------------//
		Layouts_Raw_Input. Busentity_Businfo MergeBusentity_Businfo(  Layouts_Raw_Input. Busentity  l ,Layouts_Raw_Input.Businfo  r ) := transform
		    self 					:= l;
		    self					:= r;
		    self                    := [];
			
		end; // end transform 
		
		joinstock := join(	Files_Raw_Input.Busentity(fileDate),Files_Raw_Input.Businfo(fileDate), 
								trim(left.Entity_ID,left,right) = trim(right.Info_Entity_ID,left,right),
								MergeBusentity_Businfo(left,right),
								left outer
							);	  
		  //--------------------------- Explosion Table Logic -----------------------//
		  
		  	   //StateCode join
		
		 corp2_mapping.Layout_CorpPreClean findState(corp2_mapping.Layout_CorpPreClean input, ForgnStateDescLayout r ) := transform
		   
			self.corp_forgn_state_desc  :=r.desc;
			
			self         			    := input;
			self                        := [];
		end; 
		
		// end transform
		
			
		
		
		joinStateType := 	join( MapCorp,ForgnStateTable,
									trim(left.corp_forgn_state_cd,left,right) =  trim(right.code,left,right),
									findState(left,right),
									left outer, lookup
								);
								
								
								
								
								
								
			cleanCorps             := project(joinStateType,CleanCorpNameAddr(left));	
			MapStock 			   := project(joinstock,  ut_stockTransform(left));
			MapStock1 			   := project(MapStock,  ut_stock1Transform(left));
				
			MapCont 			   := project(DedupDenormalized, ut_contactTransform(left));
				
				
			    cleanCont := project(MapCont , CleanContNameAddr(left));
		
/* 		
   				        output(DedupDenormalizedcorp(trim(Entity_Number,left,right) = '6746940-0160'));
   		
   		output(DedupDenormalizedcorp(trim(Entity_Number,left,right) = '6760649-0151'));
   		
   		output(DedupDenormalizedcorp(trim(Entity_Number,left,right) = '6760649-0111'));
   		output(DedupDenormalizedcorp(trim(Entity_Number,left,right) = '6746940-0160'));
*/
		
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_ut'	,dedup(cleanCorps,record,all)	,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_ut'	,dedup(cleanCont,record,all)	,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ut'	,dedup(MapStock1,record,all)	,stock_out,,,pOverwrite);
		                                                                                                                                                      
		 mappedut_Filing := parallel(
				 corp_out	
				,cont_out	
				,stock_out
		);        
		 
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('ut',filedate,pOverwrite := pOverwrite))
			,mappedut_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_ut')				  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_ut')						  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_ut')
			)
		);      
					  
     return result;
  end;   //Function end					 

   
 end;  // end of ut module	
								
								