import tools,address,dca,aid,mdr,TopBusiness_External,Business_Header_SS,business_header,DID_Add;;

export Files_DCAV1(

	 string													pversion
	,dataset(DCA.Layout_DCA_Base	)	pBaseFile	= DCA.File_DCA_Base
) :=
module

	shared dProjInput				:= project(pBaseFile	,transform(layouts.temporary.big,
		self.bdid               							:= left.bdid;
		self.date_vendor_last_reported  			:= (unsigned4)left.process_date;
		self.date_vendor_first_reported  			:= (unsigned4)left.process_date;
		self.rawfields.company_type						:= left.Type_orig     ;			   
		self.rawfields.JV1_num              	:= left.JV1_          ;         
		self.rawfields.JV2_num              	:= left.JV2_          ;         
		self.rawfields.Net_Worth            	:= left.Net_Worth_    ;         
		self.rawfields.DoesImport           	:= left.Import_orig   ;         
		self.rawfields.DoesExport           	:= left.Export_orig  	 ;            
		self.rawfields.address1.PO_Box_Bldg  	:= left.PO_Box_Bldg    ;         
		self.rawfields.address1.Street       	:= left.street         ;         
		self.rawfields.address1.Foreign_PO   	:= left.Foreign_PO     ;         
		self.rawfields.address1.Misc__adr    	:= left.Misc__adr      ;         
		self.rawfields.address1.Postal_Code_1	:= left.Postal_Code_1  ;         
		self.rawfields.address1.City         	:= left.city           ;         
		self.rawfields.address1.State        	:= left.state          ;         
		self.rawfields.address1.Zip          	:= left.zip            ;         
		self.rawfields.address1.Province     	:= left.Province       ;         
		self.rawfields.address1.Postal_Code_2	:= left.Postal_Code_2  ;         
		self.rawfields.address1.Country      	:= left.country        ;         
		self.rawfields.address1.Postal_Code_3	:= left.Postal_Code_3  ;         
		self.rawfields.address2.PO_Box_Bldg  	:= left.PO_Box_Bldg_A  ;         
		self.rawfields.address2.Street       	:= left.StreetA        ;         
		self.rawfields.address2.Foreign_PO   	:= left.Foreign_PO_BoxA;         
		self.rawfields.address2.Misc__adr    	:= left.Misc__adr_A    ;         
		self.rawfields.address2.Postal_Code_1	:= left.Postal_Code_1A ;         
		self.rawfields.address2.City         	:= left.City_A         ;         
		self.rawfields.address2.State        	:= left.State_A        ;         
		self.rawfields.address2.Zip          	:= left.Zip_A          ;         
		self.rawfields.address2.Province     	:= left.Province_A     ;         
		self.rawfields.address2.Postal_Code_2	:= left.Postal_Code_2A ;         
		self.rawfields.address2.Country      	:= left.CountryA       ;         
		self.rawfields.address2.Postal_Code_3	:= left.Postal_Code_3A ;         
		self.rawfields.Name_1             		:= left.Name_1  ;
		self.rawfields.Title_1            		:= left.Title_1 ;
		self.rawfields.code_1             		:= left.code_1  ;
		self.rawfields.Name_2             		:= left.Name_2  ;
		self.rawfields.Title_2            		:= left.Title_2 ;
		self.rawfields.code_2             		:= left.code_2  ;
		self.rawfields.Name_3             		:= left.Name_3  ;
		self.rawfields.Title_3            		:= left.Title_3 ;
		self.rawfields.code_3             		:= left.code_3  ;
		self.rawfields.Name_4             		:= left.Name_4  ;
		self.rawfields.Title_4            		:= left.Title_4 ;
		self.rawfields.code_4             		:= left.code_4  ;
		self.rawfields.Name_5             		:= left.Name_5  ;
		self.rawfields.Title_5            		:= left.Title_5 ;
		self.rawfields.code_5             		:= left.code_5  ;
		self.rawfields.Name_6             		:= left.Name_6  ;
		self.rawfields.Title_6            		:= left.Title_6 ;
		self.rawfields.code_6             		:= left.code_6  ;
		self.rawfields.Name_7             		:= left.Name_7  ;
		self.rawfields.Title_7            		:= left.Title_7 ;
		self.rawfields.code_7             		:= left.code_7  ;
		self.rawfields.Name_8             		:= left.Name_8  ;
		self.rawfields.Title_8            		:= left.Title_8 ;
		self.rawfields.code_8             		:= left.code_8  ;
		self.rawfields.Name_9             		:= left.Name_9  ;
		self.rawfields.Title_9            		:= left.Title_9 ;
		self.rawfields.code_9             		:= left.code_9  ;
		self.rawfields.Name_10            		:= left.Name_10 ;
		self.rawfields.Title_10           		:= left.Title_10	;
		self.rawfields.code_10            		:= left.code_10 	;
		self.physical_address.prim_range	   	:= left.prim_range 	;													 									
		self.physical_address.predir			   	:= left.predir     	;                          
		self.physical_address.prim_name	   		:= left.prim_name  		;                        
		self.physical_address.addr_suffix   	:= left.addr_suffix		;                        
		self.physical_address.postdir		   		:= left.postdir    		;                        
		self.physical_address.unit_desig	   	:= left.unit_desig 	;                          
		self.physical_address.sec_range	   		:= left.sec_range  		;                        
		self.physical_address.p_city_name   	:= left.p_city_name		;                        
		self.physical_address.v_city_name   	:= left.v_city_name		;                        
		self.physical_address.st					   	:= left.st         	;                          
		self.physical_address.zip				   		:= left.z5         		;                        
		self.physical_address.zip4				   	:= left.zip4       	;                          
		self.physical_address.cart				   	:= left.cart       	;                          
		self.physical_address.cr_sort_sz	   	:= left.cr_sort_sz 	;                          
		self.physical_address.lot				   		:= left.lot        		;                        
		self.physical_address.lot_order	   		:= left.lot_order  		;                        
		self.physical_address.dbpc				   	:= left.dpbc       	;                          
		self.physical_address.chk_digit	   		:= left.chk_digit  		;                        
		self.physical_address.rec_type		   	:= left.rec_type   	;                          
		self.physical_address.fips_state    	:= left.county[1..2];                                   
		self.physical_address.fips_county			:= left.county[3..];
		self.physical_address.geo_lat	       	:= left.geo_lat		;			
		self.physical_address.geo_long	      := left.geo_long		;       
		self.physical_address.msa			       	:= left.msa				;     
		self.physical_address.geo_blk	       	:= left.geo_blk		;     
		self.physical_address.geo_match       := left.geo_match	;     
		self.physical_address.err_stat	      := left.err_stat		;			
		self.mailing_address.prim_range	     	:= left.prim_rangeA  	;																					  
		self.mailing_address.predir			     	:= left.predirA      	;                                           
		self.mailing_address.prim_name		    := left.prim_nameA   	;                                           
		self.mailing_address.addr_suffix	    := left.addr_suffixA 	;                                           
		self.mailing_address.postdir			    := left.postdirA     	;                                           
		self.mailing_address.unit_desig	     	:= left.unit_desigA  	;                                           
		self.mailing_address.sec_range		    := left.sec_rangeA   	;                                           
		self.mailing_address.p_city_name	    := left.p_city_nameA 	;                                           
		self.mailing_address.v_city_name	    := left.v_city_nameA 	;                                           
		self.mailing_address.st					     	:= left.stA          	;                                           
		self.mailing_address.zip					    := left.zipA         	;                                           
		self.mailing_address.zip4				     	:= left.zip4A        	;                                           
		self.mailing_address.cart				     	:= left.cartA        	;                                           
		self.mailing_address.cr_sort_sz	     	:= left.cr_sort_szA  	;                                           
		self.mailing_address.lot					    := left.lotA         	;                                           
		self.mailing_address.lot_order		    := left.lot_orderA   	;                                           
		self.mailing_address.dbpc				     	:= left.dpbcA        	;                                           
		self.mailing_address.chk_digit		    := left.chk_digitA   	;                                           
		self.mailing_address.rec_type		     	:= left.rec_typeA    	;                                           
		self.mailing_address.fips_state				:= left.countyA[1..2]	;             
		self.mailing_address.fips_county			:= left.countyA[3..]	;
		self.mailing_address.geo_lat					:= left.geo_latA  		;                                               
		self.mailing_address.geo_long					:= left.geo_longA 		;                                               
		self.mailing_address.msa							:= left.msaA      		;                                               
		self.mailing_address.geo_blk					:= left.geo_blkA  		;                                               
		self.mailing_address.geo_match				:= left.geo_matchA		;                                               
		self.mailing_address.err_stat					:= left.err_statA 		;																			   
		self.rawfields												:= left;
		self																	:= [];
	));

	export dAppendDates := tools.mac_Append_Dates	(dProjInput	,['rawfields.Update_Date'],['clean_dates.Update_Date']);

	export dPrep_Input	:= project(dAppendDates,transform(layouts.temporary.big,
					self.physical_address1 	:=	tools.AID_Helpers.fRawFixLine1(left.rawfields.address1.street);
					self.physical_address2	:=	tools.AID_Helpers.fRawFixLineLast(
																											trim(left.rawfields.address1.city)    
																									+ ', ' + left.rawfields.address1.state   	
																									+ ' '  + left.rawfields.address1.zip[1..5]
																							);
	
					self.mailing_address1 	:=	tools.AID_Helpers.fRawFixLine1(left.rawfields.address2.street);
					self.mailing_address2		:=	tools.AID_Helpers.fRawFixLineLast(
																											trim(left.rawfields.address2.city)    
																									+ ', ' + left.rawfields.address2.state   	
																									+ ' '  + left.rawfields.address2.zip[1..5]
																							);
					self.date_first_seen							:= (unsigned4)left.clean_dates.Update_Date;
					self.date_last_seen								:= (unsigned4)left.clean_dates.Update_Date;
//					self.date_vendor_first_reported		:= (unsigned4)pversion;
//					self.date_vendor_last_reported		:= (unsigned4)pversion;
					self															:= left;
	));
	tools.mac_RedefineFormat(dPrep_Input 		,layouts.temporary.bigchild	,dRedefInput		,40000,,[10,10,20,10]);	//put repeated fields into child datasets for easier manipulation

	export Companies := project		(dPrep_Input	,transform(layouts.temporary.companies_aid_prep	,self := left))							;
	export Contacts	 := normalize	(dRedefInput	,10,transform(layouts.temporary.contacts_aid_prep	,
		self 														:= left;
		self.rawfields.executive.name		:= left.rawfields.executives[counter].name	;
		self.rawfields.executive.title	:= left.rawfields.executives[counter].title	;
		self.rawfields.executive.code		:= left.rawfields.executives[counter].code	;
		self.clean_name									:= if(self.rawfields.executive.name != ''	,Address.CleanPersonFML73_fields(self.rawfields.executive.name).CleanNameRecord	,Address.CleanNameFields('').CleanNameRecord);
		self														:= []
		))(rawfields.executive.name != '') ;

	dupdatecompanies	:= Update_Companies	(pversion,pSplitInput := Companies	);
	dupdatecontacts		:= Update_Contacts	(pversion,pSplitInput := Contacts		);
	
	export build_bases := Build_Base(pversion,pNewBaseCompaniesFile := dupdatecompanies, pNewBaseContactsFile := dupdatecontacts	,pWriteFileOnly := true);

end;