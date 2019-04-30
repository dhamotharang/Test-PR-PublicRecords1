Import _Control, Corp2, Corp2_Raw_UT, Scrubs, Scrubs_Corp2_Mapping_UT_Main, Tools, UT, VersionControl, std ,lib_stringlib;
Export Utah 	:= Module

	Export Update(String filedate, string version, boolean pShouldSpray = Corp2_mapping._Dataset().bShouldSpray, boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) := Function
		
		state_origin	 := 'UT';
		state_fips	 	 := '49';
		state_desc	 	 := 'UTAH';
		
		Busentity  		 := dedup(sort(distribute(Corp2_Raw_UT.Files(filedate,pUseProd).Input.Busentity.Logical,hash(Entity_ID,Entity_Type)),record,local),record,local) : independent;
		Principals 		 := dedup(sort(distribute(Corp2_Raw_UT.Files(filedate,pUseProd).Input.Principals.Logical,hash(Prin_Entity_ID,Prin_Entity_Type)),record,local),record,local) : independent;
		Businfo  	 		 := dedup(sort(distribute(Corp2_Raw_UT.Files(filedate,pUseProd).Input.Businfo.Logical,hash(Info_Entity_ID,Info_Entity_Type)),record,local),record,local) : independent; 
		
		Perpetual_List := ['PEPETUAL','PEPRETUAL','PEREPETUAL','PERPECTUAL','PERPERUAL','PERPETUAL','PERPETUALL',
											 'PERPETUALY','PERPETURAL','PERPETYAL','PERPTUAL','PERTETUAL','PETPETUAL'];
											 
		OrgStruc_List  := ['BUSINESS NAME RESERVATION','CORPORATE NAME REGISTRATION','DBA',
											 'DBA - REAL ESTATE INV. TRUST','TRADEMARK RESERVATION','TRADEMARK'];
											 
		P_List  			 := ['CORPORATION - DOMESTIC - PROFIT','CORPORATION - FOREIGN - PROFIT',
											 'CORPORATION - TRIBAL - PROFIT','LLC - LOW-PROFIT'];
											 
		N_List  			 := ['CORPORATION - DOMESTIC - NON-PROFIT','CORPORATION - FOREIGN - NON-PROFIT',
											 'CORPORATION - TRIBAL - NON-PROFIT','LLC - LOW-NON-PROFIT'];
		
		joinBusentity_Principals := join(Busentity,Principals, 		
																		 corp2.t2u(left.Entity_ID) 						 = corp2.t2u(right.Prin_Entity_ID) and
																		 corp2.t2u(left.Entity_Type)					 = corp2.t2u(right.Prin_Entity_Type)and																					
																		 corp2.t2u(right.prin_member_position) = 'REGISTERED AGENT',
																		 transform(Corp2_Raw_UT.Layouts.Busentity_Principals,
																							 self  := left;
																							 self	 := right;
																		          ),
																		 left outer,local); 

		joinBusentity_Principals_Businfo := join(joinBusentity_Principals ,Businfo, 
																						 corp2.t2u(left.Entity_ID) 		= corp2.t2u(right.Info_Entity_ID)and
																						 corp2.t2u(left.Entity_Type)  = corp2.t2u(right.Info_Entity_Type),
																						 transform(Corp2_Raw_UT.Layouts.Busentity_Businfo_Principals,
																						           self 	:= left;
																											 self		:= right;
																										   ),
																						 left outer,local); 

		Corp2_Mapping.LayoutsCommon.Main 		ut_corpTransform_Business(Corp2_Raw_UT.Layouts.Busentity_Businfo_Principals input):=transform

			self.dt_vendor_first_reported		 	  :=(integer)fileDate;
			self.dt_vendor_last_reported		 	  :=(integer)fileDate;
			self.dt_first_seen							 	  :=(integer)fileDate;
			self.dt_last_seen								 	  :=(integer)fileDate;
			self.corp_ra_dt_first_seen			 	  :=(integer)fileDate;
			self.corp_ra_dt_last_seen				 	  :=(integer)fileDate;		
			self.corp_key					      				:=state_fips + '-' + corp2.t2u(input.Entity_Number);
			self.corp_vendor					  				:=state_fips;
			self.corp_state_origin              :=state_origin;
			self.corp_process_date				 			:=fileDate;    
			self.corp_orig_sos_charter_nbr      :=corp2.t2u(input.Entity_Number);
			self.corp_legal_name                :=Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.Business_Name).BusinessName;
			self.corp_orig_org_structure_desc   :=map(corp2.t2u(input.License_Type)  in OrgStruc_List =>'',
																								corp2.t2u(input.License_Type)
																								);
			self.corp_ln_name_type_cd           :=Corp2_Raw_UT.Functions.fGetName_cd(input.License_Type);
			self.corp_ln_name_type_desc         :=Corp2_Raw_UT.Functions.fGetName_desc(input.License_Type);
			self.corp_for_profit_ind            :=map(corp2.t2u(input.License_Type) in P_List		=>'Y',
																								corp2.t2u(input.License_Type) in N_List 	=>'N','');
			self.corp_foreign_domestic_ind      :=map(Regexfind('DOMESTIC',input.License_Type,nocase)=>'D',
																								Regexfind('FOREIGN',input.License_Type,nocase)=>'F','');
			self.corp_entity_desc               :=map(Regexfind('NAME RESERVATION',input.Entity_Type,nocase)=>'',
																								Regexfind('DBA',input.Entity_Type,nocase)=>'',
																								Regexfind('TRADEMARK',input.Entity_Type,nocase)=>'',
																								corp2.t2u( input.Entity_Type));																					
			temp_city                           := if(corp2.t2u(input.city) in ['SCLC','SLC'],'SALT LAKE CITY',corp2.t2u(input.city)); 																					
			self.corp_address1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address,input.address2,temp_city,input.State,input.Zip).AddressLine1;
			self.corp_address1_line2				 		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address,input.address2,temp_city,input.State,input.Zip).AddressLine2;
			self.corp_address1_line3				 		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address,input.address2,temp_city,input.State,input.Zip).AddressLine3;
			self.corp_prep_addr1_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address,input.address2,temp_city,input.State,input.Zip).PrepAddrLine1;
			self.corp_prep_addr1_last_line			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address,input.address2,temp_city,input.State,input.Zip).PrepAddrLastLine;
			self.corp_address1_type_cd					:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address,input.address2,temp_city,input.State,input.Zip).ifAddressExists,
																								'M','');
			self.corp_address1_type_desc				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address,input.address2,temp_city,input.State,input.Zip).ifAddressExists,
																								'MAILING','');	
			self.corp_inc_date                  :=if(corp2.t2u(input.Home_State) in [state_origin,''],Corp2_Mapping.fValidateDate(input.Registration_Date,'CCYY-MM-DD').PastDate ,'');
			self.corp_forgn_date                :=if(corp2.t2u(input.Home_State) not in [state_origin,''],Corp2_Mapping.fValidateDate(input.Registration_Date,'CCYY-MM-DD').PastDate ,'');
			n                                   :=StringLib.StringFindReplace(StringLib.StringFindReplace(corp2.t2u(input.Information),'YEARS', ''), 'YRS', '');	
			self.corp_term_exist_cd     				:=map(corp2.t2u(input.Information_Type)='DURATION TIME' and ut.isNumeric(n) =>'N',	
																							  corp2.t2u(input.Information_Type)='DURATION TIME' and corp2.t2u(input.Information) in Perpetual_List =>'P',
																							  corp2.t2u(input.Information_Type)='DURATION TIME' and Corp2_Mapping.fValidateDate(input.Information,'CCYY-MM-DD').PastDate<>''=>'D',
																							  corp2_Mapping.fValidateDate(input.Expiration_Date,'CCYY-MM-DD').GeneralDate <>''=> 'D',
																							 '');
			self.corp_term_exist_exp    			  :=map(corp2.t2u(input.Information_Type)='DURATION TIME' and ut.isNumeric(n) => n,	
																								corp2_Mapping.fValidateDate(input.Expiration_Date,'CCYY-MM-DD').GeneralDate <>''=>Corp2_Mapping.fValidateDate(input.Expiration_Date,'CCYY-MM-DD').GeneralDate,
																								corp2.t2u(input.Information_Type)='DURATION TIME' and Corp2_Mapping.fValidateDate(input.Information,'CCYY-MM-DD').PastDate<>''=>Corp2_Mapping.fValidateDate(input.Information,'CCYY-MM-DD').PastDate,
																								'');
			self.corp_term_exist_desc  					:=map(self.corp_term_exist_cd='N' =>'NUMBER OF YEARS',	
																								self.corp_term_exist_cd='P' =>'PERPETUAL',
																								self.corp_term_exist_cd='D'=>'EXPIRATION DATE',
																								'' );
			self.corp_inc_state                 := state_origin;
			self.corp_forgn_state_cd            := if(corp2.t2u(input.Home_State) not in [state_origin,''], Corp2_Raw_UT.Functions.Get_State_Code( input.Home_State),'');		
			self.corp_forgn_state_desc          := if(corp2.t2u(input.Home_State) not in [state_origin,''],Corp2_Raw_UT.Functions.fGetStateDesc(input.Home_State),'');	
			self.corp_status_desc               := corp2.t2u(input.License_Status);			
			self.corp_last_renewal_date         := Corp2_Mapping.fValidateDate(input.Last_Renewal_Date,'CCYY-MM-DD').GeneralDate;
			TStatus_Reason                   		:= if(corp2.t2u(input.Status_Reason)<>'GOOD STANDING',corp2.t2u(input.Status_Reason),''); 
			TLast_renewal_date                  := if(self.corp_last_renewal_date<>'', 'LAST RENEWAL DATE: ' + input.Last_Renewal_Date[6..7] + '/'+ input.Last_Renewal_Date[9..10] + '/'+ input.Last_Renewal_Date[1..4],''); //mm/dd/yyyy per CI
			self.corp_status_comment            := if(trim(TStatus_Reason) <>'' and  trim(TLast_renewal_date) <> '' , TStatus_Reason +'; '+ TLast_renewal_date ,if(trim(TLast_renewal_date) <> '' ,TLast_renewal_date ,TStatus_Reason));
			self.corp_standing									:= if(corp2.t2u(input.Status_Reason)='GOOD STANDING','Y','');
			self.corp_status_date               := Corp2_Mapping.fValidateDate(input.Date_Status_Changed,'CCYY-MM-DD').PastDate;
			self.corp_ra_full_name              := Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.Prin_Full_name).BusinessName;
			temp_prin_city                      := if(corp2.t2u(input.Prin_City) in ['SCLC','SLC'],'SALT LAKE CITY',corp2.t2u(input.Prin_City)) ; 																					
			self.corp_ra_address_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).AddressLine1;
			self.corp_ra_address_line2				 	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).AddressLine2;
			self.corp_ra_address_line3				 	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).AddressLine3;
			self.ra_prep_addr_line1							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).PrepAddrLine1;
			self.ra_prep_addr_last_line					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).PrepAddrLastLine;
			self.corp_ra_address_type_cd				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).ifAddressExists,
																								'R','');
			self.corp_ra_address_type_desc			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).ifAddressExists,
																								'REGISTERED OFFICE','');
			self.corp_addl_info        	 			  := Corp2_Raw_UT.Functions.fGet_addl_info(input.Information_Type,input.Information);
			self.corp_additional_principals     := map(corp2.t2u(input.Information_Type)='ADDITIONAL PRINCIPALS' and corp2.t2u(input.Information)in ['YES','Y']=>'Y',
			                                           corp2.t2u(input.Information_Type)='ADDITIONAL PRINCIPALS' and corp2.t2u(input.Information)in ['NO','N']=>'N','');
			self.corp_nbr_of_partners	    			:=If(corp2.t2u(input.Information_Type)='NUMBER OF PARTNERS' and  trim(input.Information) <>'0',trim(input.Information),'');
			self.corp_filing_date               :=If(corp2.t2u(input.Information_Type)='INCORPORATED IN HOME STATE DATE' and  trim(input.Information) <>'', 
																							 Corp2_Mapping.fValidateDate(input.Information,'CCYY-MM-DD').PastDate,'');
			self.corp_filing_desc               := if(self.corp_filing_date<>'' ,'HOME STATE','');																				 
			self.corp_naic_code                 := trim(input.NAICS_Code);
			self.corp_naics_desc			    		  := If(corp2.t2u(input.Information_Type)='NAICS TITLE' ,corp2.t2u(input.Information),'');
			self.recordOrigin									  := 'C';			
			self                                := [];

		end;

		MapCorp := project(joinBusentity_Principals_Businfo,ut_corpTransform_Business(left));
		
		//layouts join for Contacts
		joinCont := join( Busentity, Principals,
											corp2.t2u(left.Entity_ID) 					 = corp2.t2u(right.Prin_Entity_ID)and
											corp2.t2u(left.Entity_Type) 				 = corp2.t2u(right.Prin_Entity_Type)and
											corp2.t2u(right.Prin_Member_Position)<>'REGISTERED AGENT',
											transform( Corp2_Raw_UT.Layouts.Busentity_Principals,
																 self 	:= left;
																 self		:= right;
																),
											left outer,local); 										
				
		ds_OfficerFileWithTitles		:= project(joinCont,transform(Corp2_Raw_UT.Layouts.OfficerFileWithTitles ,self:=left;self:=[];)); 

		//------- Denormalize above result to get all titles in one record ------------------
		Corp2_Raw_UT.Layouts.OfficerFileWithTitles DenormOfficers(Corp2_Raw_UT.Layouts.OfficerFileWithTitles L, Corp2_Raw_UT.Layouts.OfficerFileWithTitles R, INTEGER C) := TRANSFORM

			self.Title1 	  := IF (C=1, R.Prin_Member_Position,L.TITLE1);                  
			self.title2		  := IF (C=2, R.Prin_Member_Position,L.TITLE2);
			self.title3		  := IF (C=3, R.Prin_Member_Position,L.TITLE3); 
			self.title4		  := IF (C=4, R.Prin_Member_Position,L.TITLE4); 
			self.title5		  := IF (C=5, R.Prin_Member_Position,L.TITLE5);			
			self 			 			:= L;

		END;

		DenormalizedFile := denormalize(ds_OfficerFileWithTitles, ds_OfficerFileWithTitles,
																		corp2.t2u(left.Entity_ID)		   = corp2.t2u(right.Entity_ID) and
																		corp2.t2u(left.Entity_Type) 	 = corp2.t2u(right.Entity_Type) and
																		corp2.t2u(left.Prin_Full_name) = corp2.t2u(right.Prin_Full_name) and
																		corp2.t2u(left.Prin_Address) 	 = corp2.t2u(right.Prin_Address) and
																		corp2.t2u(left.Prin_Address2)  = corp2.t2u(right.Prin_Address2) and
																		corp2.t2u(left.Prin_City)			 = corp2.t2u(right.Prin_City) and
																		corp2.t2u(left.Prin_State) 		 = corp2.t2u(right.Prin_State) and
																		corp2.t2u(left.Prin_Zip_Code)  = corp2.t2u(right.Prin_Zip_Code),
																		DenormOfficers(left,right,COUNTER));
												
		DedupDenormalized := dedup(sort(distribute(DenormalizedFile,hash(Entity_ID,Entity_Type)),RECORD,local),record,local);

		Corp2_Mapping.LayoutsCommon.Main ut_contactTransform(Corp2_Raw_UT.Layouts.OfficerFileWithTitles  input, integer ctr):=transform,
		skip(corp2.t2u(input.Entity_Number)='' or corp2.t2u(input.Prin_Full_name)='')

			self.dt_vendor_first_reported		  := (integer)fileDate;
			self.dt_vendor_last_reported		 	:= (integer)fileDate;
			self.dt_first_seen							 	:= (integer)fileDate;
			self.dt_last_seen								 	:= (integer)fileDate;
			self.corp_ra_dt_first_seen			 	:= (integer)fileDate;
			self.corp_ra_dt_last_seen				 	:= (integer)fileDate;		
			self.corp_key					  					:= state_fips + '-' + corp2.t2u(input.Entity_Number);			
			self.corp_process_date				 		:= fileDate;    
			self.corp_vendor				  				:= state_fips;
			self.corp_state_origin			  		:= state_origin;
			self.corp_inc_state               := state_origin;
			self.corp_orig_sos_charter_nbr    := corp2.t2u(input.Entity_Number);
			self.corp_legal_name              := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.Business_Name).BusinessName;
			self.Cont_full_name               := choose(ctr,Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.Prin_Full_name).BusinessName
																								  ,Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.Applicant_Name).BusinessName);
			self.cont_type_cd                 := if(corp2.t2u(input.Applicant_Name)<>'' or corp2.t2u(input.Prin_Member_Position)<>'','T','');
			self.cont_type_desc               := if(corp2.t2u(input.Applicant_Name)<>'' or corp2.t2u(input.Prin_Member_Position)<>'','CONTACT','');
			temp_prin_city                    := if(corp2.t2u(input.Prin_City) in ['SCLC','SLC'],'SALT LAKE CITY',corp2.t2u(input.Prin_City)); 																					
			self.cont_address_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).AddressLine1;
			self.cont_address_line2				 		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).AddressLine2;
			self.cont_address_line3				 		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).AddressLine3;
			self.cont_prep_addr_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).PrepAddrLine1;
			self.cont_prep_addr_last_line			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).PrepAddrLastLine;
			self.cont_address_type_cd					:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).ifAddressExists,
																						 'T','');
			self.cont_address_type_desc				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Prin_Address,input.Prin_Address2,temp_prin_city,input.Prin_State,input.Prin_Zip_Code).ifAddressExists,
																							'CONTACT','');		
			concatFields						 					:= corp2.t2u(input.Title1) + ',' + corp2.t2u(input.Title2) + ',' +  
																					 corp2.t2u(input.Title3) + ',' + corp2.t2u(input.Title4) + ',' + corp2.t2u(input.Title5) ;
			tempExp								 						:= regexreplace('[,]*$',concatFields,'',NOCASE);
			tempExp2							 						:= regexreplace('^[,]*',tempExp,'',NOCASE);
			self.cont_title1_desc         	  := regexreplace('[,]+',tempExp2,',',NOCASE);								 
			self.recordOrigin									:= 'T';			
			self                              := [];

		end;

		MapCont 		:= normalize(DedupDenormalized,if(corp2.t2u(left.Prin_Full_name)<>'' and corp2.t2u(left.Applicant_Name)<>'' ,2,1),ut_contactTransform(left,counter));
		
		Corp2_Mapping.LayoutsCommon.Main legalNameFix_Trans(Corp2_Mapping.LayoutsCommon.Main  l):= transform
			
			self.corp_legal_name :=if(Corp2_Mapping.fSpecialChars(l.corp_legal_name)='FOUND', Corp2_Raw_UT.Functions.fix_ForeignChar(l.corp_legal_name), l.corp_legal_name);
			self								 :=l;
			
		end;
		
	  legalNameFix := project(MapCorp +  MapCont, legalNameFix_Trans(left)) ;
		
		mapMain 		 := dedup(sort(distribute(legalNameFix,hash(corp_key)),
															 record,local),
													record,local):independent;

		joinstock := join( Busentity,Businfo, 
											 corp2.t2u(left.Entity_ID) = corp2.t2u(right.Info_Entity_ID),
											 transform(Corp2_Raw_UT.Layouts.Busentity_Businfo,
																 self 	:= left;
																 self		:= right;
																),
											left outer,local); 

		corp2_Mapping.LayoutsCommon.STOCK ut_stockTransform(Corp2_Raw_UT.Layouts.Busentity_Businfo  input):=	transform,
		skip(corp2.t2u(input.Entity_Number)='')

			self.corp_key					     			 := state_fips + '-' + corp2.t2u(input.Entity_Number);
			self.corp_vendor				      	 := state_fips;
			self.corp_state_origin			     := state_origin;
			self.corp_process_date			     := fileDate;
			self.corp_sos_charter_nbr		     := trim(input.Entity_Number, left, right);
			self.stock_stock_description     := if(Regexfind('AMOUNT',input.Information_Type,nocase),
			                                        map((string)(integer)corp2.t2u(input.Information) ='0'=> '',
																									 StringLib.StringFind(trim(input.Information,left,right),'.',1)<>0 =>corp2.t2u(input.Information_Type)+':'+ trim(input.Information,left,right), //78.89
																							     StringLib.StringFind(trim(input.Information,left,right),',',1)<>0 =>corp2.t2u(input.Information_Type)+':'+ trim(input.Information,left,right), //50,000,000
																									 corp2.t2u(input.Information_Type)+':'+ (string)(integer)trim(input.Information,left,right)
																									),
																						'');
			//overload																			 
			self.stock_shares_issued         :=if(Regexfind('AMOUNT',input.Information_Type,nocase) ,
			                                        map((string)(integer)corp2.t2u(input.Information) ='0'=> '',
																									 StringLib.StringFind(trim(input.Information,left,right),'.',1)<>0 =>trim(input.Information,left,right),
																							     StringLib.StringFind(trim(input.Information,left,right),',',1)<>0 =>trim(input.Information,left,right),
																									 (string)(integer)trim(input.Information,left,right)
																									),
																						'');
			self.stock_addl_info             :=if((Regexfind('TYPE',input.Information_Type,nocase) and Regexfind('PREFERRED',input.Information,nocase)) OR 
																						(Regexfind('TYPE',input.Information_Type,nocase) and Regexfind('CLASS',input.Information,nocase)) OR 
																						(Regexfind('TYPE',input.Information_Type,nocase) and Regexfind('COMMON',input.Information,nocase)) ,
																						corp2.t2u(input.Information_Type)+':'+corp2.t2u(input.Information),'');			
			self                             := [];

		end; 

		dsStock 	:= project(joinstock,ut_stockTransform(left))(corp2.t2u(stock_addl_info+stock_shares_issued+stock_stock_description)<> '');
		MapStock 	:= dedup(sort(distribute(dsStock ,hash(corp_key)),record,local),record,local);

		//=============================================SCRUB LOGIC====================================================

		F := mapMain ;
		S := Scrubs_Corp2_Mapping_UT_Main.Scrubs;	// UT scrubs module
		N := S.FromNone(F); 											// Generate the error flags
		T := S.FromBits(N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		U := S.FromExpanded(N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary				:= output(U.SummaryStats, named('Main_ErrorSummary_UT'+filedate));
		Main_ScrubErrorReport 	:= output(choosen(U.AllErrors, 1000), named('Main_ScrubErrorReport_UT'+filedate));
		Main_SomeErrorValues		:= output(choosen(U.BadValues, 1000), named('Main_SomeErrorValues_UT'+filedate));
		Main_IsScrubErrors		 	:= IF(count(U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats					:= U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps			:= output(N.BitmapInfile,,'~thor_data::corp_UT_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap		:= output(T);
		
		//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		Main_AlertsCSVTemplate	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
		Main_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert				:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment		:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile						:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs Corp_UT Report' //subject
																																 ,'Scrubs Corp_UT Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpUTMainScrubsReport.csv'
																														);

		Main_BadRecords					:= N.ExpandedInFile(dt_vendor_first_reported_Invalid 			<>0 or
																								dt_vendor_last_reported_Invalid 			<>0 or
																								dt_first_seen_Invalid 								<>0 or
																								dt_last_seen_Invalid 									<>0 or
																								corp_ra_dt_first_seen_Invalid 				<>0 or
																								corp_ra_dt_last_seen_Invalid 					<>0 or
																								corp_key_Invalid 											<>0 or
																								corp_vendor_Invalid 									<>0 or
																								corp_state_origin_Invalid 					 	<>0 or
																								corp_process_date_Invalid						  <>0 or
																								corp_orig_sos_charter_nbr_Invalid 		<>0 or
																								corp_legal_name_Invalid 							<>0 or
																								corp_ln_name_type_cd_Invalid 					<>0 or
																								corp_ln_name_type_desc_Invalid 				<>0 or
																								corp_inc_state_Invalid 								<>0 or
																								corp_inc_date_Invalid 								<>0 or
																								corp_foreign_domestic_ind_Invalid 		<>0 or
																								corp_forgn_state_cd_Invalid         	<>0 or
																								corp_forgn_state_desc_Invalid         <>0 or
																								corp_orig_org_structure_desc_Invalid  <>0 
																							);
																																					
		Main_GoodRecords				:= N.ExpandedInFile(dt_vendor_first_reported_Invalid 			= 0 and
																								dt_vendor_last_reported_Invalid 			= 0 and
																								dt_first_seen_Invalid 								= 0 and
																								dt_last_seen_Invalid 									= 0 and
																								corp_ra_dt_first_seen_Invalid 				= 0 and
																								corp_ra_dt_last_seen_Invalid 					= 0 and
																								corp_key_Invalid 											= 0 and
																								corp_vendor_Invalid 									= 0 and
																								corp_state_origin_Invalid 					 	= 0 and
																								corp_process_date_Invalid						  = 0 and
																								corp_orig_sos_charter_nbr_Invalid 		= 0 and
																								corp_legal_name_Invalid 							= 0 and
																								corp_ln_name_type_cd_Invalid 					= 0 and
																								corp_ln_name_type_desc_Invalid 				= 0 and
																								corp_inc_state_Invalid 								= 0 and
																								corp_inc_date_Invalid 								= 0 and
																								corp_foreign_domestic_ind_Invalid 		= 0 and
																								corp_forgn_state_cd_Invalid         	= 0 and 
																								corp_forgn_state_desc_Invalid        	= 0 and
																								corp_orig_org_structure_desc_Invalid  = 0 
																							 );

		Main_FailBuild					:= map( Corp2_Mapping.fCalcPercent(count(N.ExpandedInFile(corp_key_invalid<>0)),count(N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_UT_Main.Threshold_Percent.CORP_KEY										 => true,
																		Corp2_Mapping.fCalcPercent(count(N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_UT_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		Corp2_Mapping.fCalcPercent(count(N.ExpandedInFile(corp_legal_name_invalid<>0)),count(N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_UT_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		count(Main_GoodRecords) = 0																																																																																						 => true,																		
																		false
																	);

		Main_ApprovedRecords		:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
	  Main_RejFile_Exists		  := IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_ALL		 						:= sequential(IF(count(Main_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_UT',overwrite,__compressed__,named('Sample_Rejected_MainRecs_UT'+filedate))
																									,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																															 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_UT'+filedate))
																															 )
																									)
																				     )
																					,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainUTScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.UT - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues																					
																				//,Main_AlertsCSVTemplate
																					,Main_SubmitStats
																				);		
		//==========================================VERSION CONTROL====================================================

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_UT',Main_ApprovedRecords,main_out,,,pOverwrite);		
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::Stock_ut', mapStock, stock_out,,,pOverwrite);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' + state_origin ,F	,write_fail_main  ,,,pOverwrite); 

		mapUt:= sequential( if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											  //,Corp2_Raw_UT.Build_Bases(filedate,version,pUseProd).All // Determined building of bases is not needed
												,main_out
												,stock_out										
												,IF(Main_FailBuild <> true
														,sequential(fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_UT')																		 
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_UT')
																				,if (count(Main_BadRecords) <> 0  
																						 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,,count(mapStock)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,,count(mapStock)).MappingSuccess																				 													 
																						 )
																			  ,IF(Main_IsScrubErrors
																						,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,false,false,false).FieldsInvalidPerScrubs																				 
																						)				 
																			 )
														 ,sequential( write_fail_main
																				 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																				)
													 )
											,Main_All	
										);
										
		//Validating the filedate entered is within 30 days		
		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		result		 			:= if(isFileDateValid
													,mapUT
													,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																			 ,FAIL('Corp2_Mapping.UT failed. An invalid filedate was passed in as a parameter.')
																			)
												 );
		return result;

	End;  //  Update Function 

End; // Module