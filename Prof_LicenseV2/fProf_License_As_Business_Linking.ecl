IMPORT ut, Prof_LicenseV2, Business_Header,Address,MDR,_validate,NID;

EXPORT fProf_License_As_Business_Linking(dataset(Prof_LicenseV2.Layouts_ProfLic.Layout_Base_With_Tiers	) pCompany_Base = Prof_LicenseV2.File_Proflic_Base_Tiers, boolean IsPRCT = false):= function

		//*** We are filtering CNLD (prolic_key[1..1]='C') records from not getting into Business Header linking base 
		File_prolic_base :=  pCompany_Base(business_flag = 'Y' and  trim(company_name) <> '' and prolic_key[1..1]<>'C');

		//*** Identifying people names using the NID name cleaner in "company_name" field and dropping person names from â€œcompany_name" field.
		fCleanNamePrep(DATASET(Prof_LicenseV2.Layouts_ProfLic.Layout_Base_With_Tiers) File_prolic_base ) := FUNCTION																	
						NID.Mac_CleanFullNames(	File_prolic_base 
																		, cleanNames
																		, company_name
																		);													

						return	cleanNames;
		End;
		
		Names			  :=	fCleanNamePrep(File_prolic_base);	
				
		Bus_flags   := ['B', 'U', 'I'];
		
		Prof_LicenseV2.Layouts_ProfLic.Layout_Base_With_Tiers Tprolic_CP(Names L) := transform
				self.company_name 				:= ut.fntrim2upper(l.company_name);
				self											:= l;				
		end;

		Company_Base := IF(IsPRCT, pCompany_Base((unsigned6)bdid <> 0), project(Names (nametype IN Bus_flags),Tprolic_CP(left))) ;

		Business_Header.Layout_Business_Linking.Linking_Interface  x2(Prof_LicenseV2.Layouts_ProfLic.Layout_Base_With_Tiers L, unsigned1 cnt) := transform,
																				 skip(cnt=2 and l.additional_phone = '' 
																						  OR
																						  cnt=3 and l.misc_fax  = ''  
																						 )
				temp_st 					 							 := if(trim(l.source_st)<> '',ut.fntrim2upper(l.source_st),ut.fntrim2upper(l.st));
				temp_License_no	 								 := if(l.license_number <> '', ut.fntrim2upper(l.license_number), ut.fntrim2upper(l.orig_license_number));
				temp_LicenseType_board 					 := if(trim(l.license_type) <> '' or trim(l.profession_or_board)<>'' , 'LTB'+ (string)hash64( ut.fntrim2upper(l.license_type ) + ut.fntrim2upper(l.profession_or_board)),'');	
				temp_company_zip  							 := if(trim(l.company_name) <> '' or trim(l.zip)<>'' ,'CZ'+(string)hash64( ut.fntrim2upper(l.company_name) + trim(l.zip,left,right)),'');		
				temp_vlid 	 										 := if(temp_st <>'' and temp_License_no<>'' and temp_LicenseType_board<>'' ,temp_st +'|'+ temp_License_no +'|'+temp_LicenseType_board ,'');	
				self.vl_id    									 := if(temp_vlid <>'' ,temp_vlid , temp_company_zip) ;
				self.source_record_id            := l.source_rec_id;
			  self.source                      := map( trim(l.VENDOR,left,right) <>'INFOUSA' => MDR.sourceTools.src_Professional_License,
																								 trim(l.VENDOR,left,right) ='INFOUSA'  => MDR.sourceTools.src_AMIDIR,'');// Source file type  
			  self.company_phone               := choose(cnt,ut.cleanPhone(l.phone), ut.CleanPhone(l.additional_phone) ,ut.CleanPhone(l.misc_fax));
			  self.phone_score                 := if((integer)self.company_phone=0,0,1);
				self.phone_type     						 := if(self.phone_score<> 0,if(cnt= 1 or cnt= 2,'T',if(cnt= 3,'F','')),'');
			  self.company_bdid			   	       :=(unsigned6) l.bdid;
			  self.company_rawaid			         := l.RAWAID ;
			  self.company_name 			         := trim(stringlib.stringtouppercase(l.company_name),left,right);
			  self.company_address_type_raw		 := 'CC';
			  self.company_address.prim_range  := l.prim_range;
			  self.company_address.predir      := l.predir;
			  self.company_address.prim_name   := l.prim_name;
			  self.company_address.addr_suffix := l.suffix;
			  self.company_address.postdir     := l.postdir;
			  self.company_address.unit_desig  := l.unit_desig;
			  self.company_address.sec_range   := l.sec_range;
				self.company_address.p_city_name := l.p_city_name;
			  self.company_address.v_city_name := l.v_city_name;
			  self.company_address.st          := l.st;
			  self.company_address.zip         := l.zip;
			  self.company_address.zip4        := l.zip4;
				self.company_address.fips_state  := if(regexfind('[a-z]+',l.ace_fips_st,nocase),'',l.ace_fips_st);
				self.company_address.fips_county := if(regexfind('[a-z]+',l.county,nocase),'',l.county);
			  self.company_address.msa         := l.msa;
			  self.company_address.geo_lat     := l.geo_lat;
			  self.company_address.geo_long    := l.geo_long;
				self.company_url  							 := l.misc_web_site;
				self.current                     := true;
			  self.dt_first_seen               := if(_validate.date.fIsValid(l.date_first_seen),(unsigned4)l.date_first_seen,0);
			  self.dt_last_seen                := if(_validate.date.fIsValid(l.date_last_seen),(unsigned4)l.date_last_seen,0);
				self.contact_did                 := (unsigned6)l.did;
			  self.contact_name.title          := l.title;
        self.contact_name.fname          := l.fname;
        self.contact_name.mname          := l.mname;
        self.contact_name.lname          := l.lname;
	      self.contact_name.name_score     := Business_Header.CleanName(l.fname, l.mname, l.lname, l.name_suffix)[142];
	      self.contact_name.name_suffix  	 := l.name_suffix;	
        self.contact_ssn                 := l.best_ssn;
	      self.contact_dob								 := (unsigned4)l.dob;
	      self.contact_email               := trim(l.misc_email,left,right);
			  self 														 := [];
		end; 
		from_ProfLic      		:= normalize(Company_Base,3,x2(left,counter));
		from_ProfLic_dist 		:= distribute(from_ProfLic ,hash(vl_id,company_name));
		from_ProfLic_sort    	:= sort(from_ProfLic_dist ,vl_id,company_name,-company_address.zip,-company_address.prim_name,-company_address.prim_range,-company_address.v_city_name,-company_address.st,phone_type,contact_name.fname,contact_name.mname,contact_name.lname,contact_name.name_score,contact_name.name_suffix,contact_did,contact_ssn,contact_dob,contact_email,-dt_last_seen,local);
		
	  Business_Header.Layout_Business_Linking.Linking_Interface  x4(Business_Header.Layout_Business_Linking.Linking_Interface  l, Business_Header.Layout_Business_Linking.Linking_Interface  r) := transform
			self := l;
	  end;
		
		from_ProfLic_rollup    := rollup(from_ProfLic_sort,
																							    left.vl_id 							  				= right.vl_id
																			and         left.company_name	  						  = right.company_name
																			and(  (     left.company_address.zip			    =	right.company_address.zip 
																							and left.company_address.prim_name    =	right.company_address.prim_name 
																							and left.company_address.prim_range   = right.company_address.prim_range
																							and left.company_address.v_city_name  = right.company_address.v_city_name
																							and left.company_address.st           = right.company_address.st
																						 )      		OR 
																						 (     right.company_address.zip  			='' 
																						   and right.company_address.prim_name  ='' 
																							 and right.company_address.prim_range	='' 
																							 and right.company_address.v_city_name='' 
																							 and right.company_address.st					=''
																						  )
											                    )
																			 and         left.phone_type                  = right.phone_type
																	 	   and(        left.contact_name.fname					= right.contact_name.fname
																					     and left.contact_name.mname    			= right.contact_name.mname
																					     and left.contact_name.lname   				= right.contact_name.lname
																							 and left.contact_name.name_score     = right.contact_name.name_score
																							 and left.contact_name.name_suffix    = right.contact_name.name_suffix 
																					    
														              )
																			 and         left.contact_did                 = right.contact_did
																			 and         left.contact_ssn                 = right.contact_ssn
																			 and         left.contact_dob                 = right.contact_dob
																			 and         left.contact_email               = right.contact_email
																		  ,x4(left,right),local);
																		
																		
		ProfLic_Interface:=	dedup(from_ProfLic_rollup,except contact_name.name_score,company_rawaid,all);
		return ProfLic_Interface;
end;
