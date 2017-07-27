import ut, lib_stringlib, _validate, Address, corp2, lib_datalib, _control, versioncontrol;

export ME := MODULE;
	
	export Layouts_Raw_Input := MODULE;

		// Maine only has one vendor layout. There is a 1 to many relationship for records to 
		// corporation key (CORP_ID).
        export Corp_Bulk := record
 			string10 	CORP_ID;
			string8	 	INCORP_DATE;
			string8 	QUAL_DATE;
			string8 	FILE_DATE;
			string8 	EXPIRE_DATE;
			string3 	JURISDICTION;
			string13 	AR_DCN;
			string1		RPT_DLNQ_IND;
			string1		RPT_TYPE;
			string1 	MEMBERS_IND;
			string1 	QUASI_IND;
			string1		CLOSE_IND;
			string3 	DIRECTORS_FROM;
			string3 	DIRECTORS_TO;
			string3 	CORP_STATUS;
			string1 	MEETINGS_IND;
			string1 	FDBA;
			string1 	PREEMP_IND;
			string160 	PURPOSE;
			string1 	WORK_PENDING;
			string1 	OVERRIDE_FLAG;
			string8 	PROCESS_DATE;
			string4 	CLERK_ID;
			string8 	WORK_PENDING_DATE;
			string80 	WORK_PENDING_TYPE;
			string1 	FIDUCIARY_IND;
            string1 	PA_IND;
            string50	COOP_NAME;
            string10 	PUBLIC_MUTUAL;
			string4 	NAM_SEQ_NO;
			string1 	SORT_FLD;
			string1 	NAME_TYPE;
			string150 	CORP_NAME;
			string140 	COMPR_NAME;
			string1 	PROTECT_FLAG;
			string1 	ADDR_TYPE;
			string50 	ADDR_NAME;
			string50 	ADDR_1;
			string50	ADDR_2;
			string20 	CITY;
			string3 	STATE;
			string30	COUNTRY;
			string5		ZIP1;
			string4		ZIP2;
			string1 	lf;
        end;
		
	end; // end of Layouts_Raw_Input module
	
	
	
	export Files_Raw_Input := MODULE;
	
		// vendor file definition
		export corp_bulk (string fileDate) := dataset('~thor_data400::in::corp2::'+fileDate+'::corp_bulk::me',
														layouts_Raw_Input.corp_bulk,flat);
	
	end;
	


	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
		TrimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		
		CorpTypeLayout := record,MAXLENGTH(70)
			string typeCode;
			string typeDesc;
		end; 
	
		CorpTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corptype_table::me', CorpTypeLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
	
		CorpStatusLayout := record,MAXLENGTH(70)
			string statusCode;
			string statusDesc;
		end; 
	
		CorpStatusTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstatus::me', CorpStatusLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		

		ForgnStateDescLayout := record,MAXLENGTH(100)
			string code;
			string desc;
		end; 
	
		ForgnStateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstateprovince_table', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));

		
		corp2_mapping.Layout_CorpPreClean ME_corpTransform(Layouts_Raw_Input.Corp_Bulk input, corptypelayout r) := transform

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;
			
			self.corp_key						:= '23-' + trim(input.corp_id,left,right);
			self.corp_vendor					:= '23';
			self.corp_state_origin				:= 'ME';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trim(input.corp_id,left,right);
			self.corp_src_type					:= 'SOS';
			
			NameType							:= trimUpper(input.name_type);
			
			self.corp_legal_name				:= 
													 if(input.corp_name<>'', 
														input.corp_name, 
														 if((input.COOP_NAME)<>'',input.COOP_NAME,'')
													 );
			self.corp_ln_name_type_cd			:= map(	
														NameType = 'L' => '01',
														NameType = 'F' => 'P',
														NameType = 'A' => '06',
														NameType = 'R' => '07',
														''
													   );
													   
			self.corp_ln_name_type_desc			:= if((input.COOP_NAME)<>'','COOPERATIVE',map(	
														NameType = 'L' => 'LEGAL',
														NameType = 'F' => 'PRIOR',
														NameType = 'A' => 'ASSUMED',
														NameType = 'R' => 'RESERVED',
														''
													   ));
			// self.corp_name_comment				:= if(	
														// NameType = 'A' or 
														// NameType = 'R' or
														// NameType = 'F', 
															// input.corp_name, 
															// ''
													  // );

		
			self.corp_filing_date				:= if ( trim(input.file_date,left,right) <> '' and 
														_validate.date.fIsValid(input.file_date) and 
														_validate.date.fIsValid(input.file_date,_validate.date.rules.DateInPast),
															input.file_date,
															if (trim(stringlib.StringtoUpperCase(input.JURISDICTION),left,right) = 'ME' AND 
																trim(input.QUAL_DATE,left,right) <> '' and 
																_validate.date.fIsValid(input.QUAL_DATE) and 
																_validate.date.fIsValid(input.QUAL_DATE,_validate.date.rules.DateInPast), 
																	input.QUAL_DATE,
																	''
																)
														);
														
			self.corp_filing_desc               := if(	trim(input.file_date,left,right) = '' and 
														trim(input.qual_date,left,right) <> '' and 
														_validate.date.fIsValid(input.qual_date) and 
														_validate.date.fIsValid(input.qual_date,_validate.date.rules.DateInPast) and 
														trim(stringlib.StringToUpperCase(input.jurisdiction),left,right) = 'ME',
														'DATE QUALIFIED',
														''
													  );
														
			self.corp_status_cd					:= input.corp_status;

			self.corp_inc_state					:= if ( trim(stringlib.StringToUpperCase(input.JURISDICTION),left,right) = 'ME',
															'ME',
															''
													  );
													  
			self.corp_forgn_state_cd			:= if ( trim(stringlib.StringToUpperCase(input.JURISDICTION),left,right) <> 'ME',
															trim(stringlib.StringToUpperCase(input.JURISDICTION),left,right),
															''
													  );
													 													  
			corp_purpose 						:= if(	trim(stringlib.StringToUpperCase(input.purpose),left,right) <> 'NONE' and 
														trim(input.purpose,left,right) <> '',
															regexreplace('[.]{2,}',trim(stringlib.StringToUpperCase(input.purpose),left,right),' ') ,											
															''
													  );
													  
			self.corp_orig_bus_type_desc		:= corp_purpose;
			
			Title1                                :=if((input.FIDUCIARY_IND)<>'','FIDUCIARY','');
			Title2                                :=if((input.PA_IND)<>'','PROFESSIONAL ASSOCIATION','');
			Title3                                :=if((input.PUBLIC_MUTUAL)<>'','PUBLIC BENEFIT','');
			Title4                                :=map( 														
														trim(stringlib.StringToUpperCase(input.close_ind),left,right) = 'C' => 														
															if((trim(input.DIRECTORS_FROM,left, right)= ''and trim(input.DIRECTORS_TO,left,right) = '') or
																ut.isNumeric(input.DIRECTORS_TO) and ut.isNumeric(input.DIRECTORS_FROM) and (integer)(input.DIRECTORS_TO)<(integer)(input.DIRECTORS_FROM),
																	'MANAGED BY MANAGERS',
																	if(((ut.isNumeric(input.DIRECTORS_FROM) and ut.isNumeric(input.DIRECTORS_TO)) and 
																		 input.DIRECTORS_TO = input.DIRECTORS_FROM) or ut.isNumeric(input.DIRECTORS_FROM) and
																		 not ut.isNumeric(input.DIRECTORS_TO),
																			'MANAGED BY ' + (string)((integer)trim(input.DIRECTORS_FROM,left,right))+ ' MANAGERS',
																			if ((ut.isNumeric(input.DIRECTORS_TO) and not ut.isNumeric(input.DIRECTORS_FROM)),
																				'MANAGED BY' + (string)((integer)trim(input.DIRECTORS_TO,left,right)) +  ' MANAGERS',
																				if(ut.isNumeric(input.DIRECTORS_FROM) and ut.isNumeric(input.DIRECTORS_TO),
																					'MANAGED BY ' +(string)((integer)trim(input.DIRECTORS_FROM,left,right)) +'-'+ (string)((integer)trim(input.DIRECTORS_TO,left,right)) + ' MANAGERS',
																					'')
																				)
																		)
																),
														trim(stringlib.StringToUpperCase(input.cLOSE_IND),left,right) = 'N' => 
															if((trim(input.DIRECTORS_FROM,left, right)= ''and trim(input.DIRECTORS_TO,left,right) = '') or
																ut.isNumeric(input.DIRECTORS_TO) and ut.isNumeric(input.DIRECTORS_FROM) and (integer)(input.DIRECTORS_TO)<(integer)(input.DIRECTORS_FROM),
																	'MANAGED BY DIRECTORS',
																	if(((ut.isNumeric(input.DIRECTORS_FROM) and ut.isNumeric(input.DIRECTORS_TO)) and 
																		 input.DIRECTORS_TO = input.DIRECTORS_FROM) or ut.isNumeric(input.DIRECTORS_FROM) and
																		 not ut.isNumeric(input.DIRECTORS_TO),
																			'MANAGED BY ' + (string)((integer)trim(input.DIRECTORS_FROM,left,right))+ ' DIRECTORS',
																			if ((ut.isNumeric(input.DIRECTORS_TO) and not ut.isNumeric(input.DIRECTORS_FROM)),
																				'MANAGED BY' + (string)((integer)trim(input.DIRECTORS_TO,left,right)) + ' DIRECTORS',
																				if(ut.isNumeric(input.DIRECTORS_FROM) and ut.isNumeric(input.DIRECTORS_TO),
																					'MANAGED BY ' +(string)((integer)trim(input.DIRECTORS_FROM,left,right)) +'-'+ (string)((integer)trim(input.DIRECTORS_TO,left,right)) + ' DIRECTORS',
																					'')
																				)
																		)
																),
														trim(stringlib.StringToUpperCase(input.cLOSE_IND),left,right) = 'Y' => 'MANAGED BY SHAREHOLDERS',
														trim(stringlib.StringToUpperCase(input.cLOSE_IND),left,right) = 'I' and
														trim(stringlib.StringToUpperCase(input.members_IND),left,right) = 'Y' and
														trim(stringlib.StringToUpperCase(input.corp_ID[9..10]),left,right) = 'DC' => 'MANAGED BY MEMBERS',
														''
											   );
			concatFields						  :=trim(trim(Title1,left,right) + ';' + 
																					trim(Title2,left,right) + ';' +  
																					trim(Title3,left,right) + ';' + 
																			trim(Title4,left,right),left,right)  ;
																			
																			
			tempExp								    := regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2							    := regexreplace('^[;]*',tempExp,'',NOCASE);
			
			self.corp_addl_info                     := regexreplace('[;]+',tempExp2,'; ',NOCASE);			
																	
			self.corp_ra_name					:= if (trim(input.ADDR_NAME,left,right) <> '' AND
													trim( stringlib.StringToUpperCase(input.ADDR_TYPE),left,right)= 'C',input.ADDR_NAME,'');
						
			self.corp_ra_address_line1			:= if (trim(input.ADDR_NAME,left,right) <> ''
													AND trim( stringlib.StringToUpperCase(input.ADDR_TYPE),left,right)='C',input.ADDR_1,''); 

			self.corp_ra_address_line2			:= if (trim(input.ADDR_NAME,left,right) <> ''
													AND trim( stringlib.StringToUpperCase(input.ADDR_TYPE),left,right)='C',input.ADDR_2,''); 

			self.corp_ra_address_line3			:= if (trim(input.ADDR_NAME,left,right) <> ''
													AND trim( stringlib.StringToUpperCase(input.ADDR_TYPE),left,right)='C',input.CITY,''); 

			self.corp_ra_address_line4			:= if (trim(input.ADDR_NAME,left,right) <> ''
													AND trim( stringlib.StringToUpperCase(input.ADDR_TYPE),left,right)='C',input.STATE,''); 

			self.corp_ra_address_line5			:= if (trim(input.ADDR_NAME,left,right) <> '' AND 
													   trim(stringlib.StringToUpperCase(input.ADDR_TYPE),left,right) = 'C',
															if (trim(input.ZIP1,left,right) <> '' AND 
																lib_stringlib.stringlib.stringfilterout(trim(Input.zip1,left,right),'9') <> '' AND
																(string)((integer)trim(input.zip1,left,right)) <> '0',
																	input.ZIP1,
																	''
																),
															''
													   );

			self.corp_ra_address_line6			:= if (trim(input.ADDR_NAME,left,right) <> '' AND 
													   trim( stringlib.StringToUpperCase(input.ADDR_TYPE),left,right) = 'C',
															if (trim(input.ZIP2,left,right) <> '' AND 
																lib_stringlib.stringlib.stringfilterout(trim(Input.zip2,left,right),'9') <> '' AND
																(string)((integer)trim(input.zip2,left,right)) <> '0',
																	input.ZIP2,
																	''
																),
															''
														);
			
			self.corp_inc_date                  := if(trim(input.incorp_date,left,right) <> '' and 
														_validate.date.fIsValid(input.incorp_date) and 
														_validate.date.fIsValid(input.incorp_date,_validate.date.rules.DateInPast) and 
														trim(stringlib.StringToUpperCase(input.jurisdiction),left,right) = 'ME',
														input.incorp_date,
														input.QUAL_DATE
													  );
														
			self.corp_term_exist_desc 			:= if ( trim(input.EXPIRE_DATE,left,right) <> '' ,
															input.EXPIRE_DATE,
															''
													   );
			self.corp_forgn_date 				:= if ( trim(stringlib.StringtoUpperCase(input.JURISDICTION),left,right) <> 'ME'AND 
														input.INCORP_DATE<>'' ,
															input.INCORP_DATE,
															input.QUAL_DATE
													   );
													 
													   
			self.corp_orig_org_structure_cd 	:= trim(input.CORP_ID[9..10],left,right);
			self.corp_orig_org_structure_DESC   := r.typeDesc;
			
			self := [];
				
		
		end; // end transform
		
		Corp2.Layout_Corporate_Direct_AR_In ME_arTransform(string fileDate, Layouts_Raw_Input.Corp_Bulk input) := transform
			Self.corp_key 						:= '23-' +trim(input.corp_id, left, right);
			Self.corp_vendor 					:='23';
			Self.corp_state_origin 				:= 'ME';
			Self.corp_process_date 				:= FileDate;
			Self.corp_sos_charter_nbr 			:= trim(input.corp_id,left,right);
			Self.ar_comment						:= if(stringLIB.stringtoUppercase (Input.RPT_DLNQ_IND)='Y',
														'REPORT DELINQUENT',
														''
													  );
			self.ar_report_nbr					:= if(trim (input.AR_DCN, Left, Right) <> '' AND (integer)Input.AR_DCN<>0,
														input.AR_DCN,
														''
													 );
			self								:=[];
		end; // end of AR_transform
		
		Corp2.Layout_Corporate_Direct_Corp_In CleanAddrName(corp2_mapping.Layout_CorpPreClean input) := transform		
			string73 tempname 					:= if (input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');
			

			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' +
																				trim(input.corp_ra_address_line2,left,right),left,right),
																		   trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
																				trim(input.corp_ra_address_line4,left,right) + ' ' +
																				trim(input.corp_ra_address_line5,left,right) +
																				trim(input.corp_ra_address_line6,left,right),left,right)
																		   );
																		   
			string182 reClean_address			:= if (clean_address[179..182] = 'E420',
														Address.CleanAddress182(trim(input.corp_ra_address_line2,left,right),
																				trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
																					 trim(input.corp_ra_address_line4,left,right) + ' ' +
																					 trim(input.corp_ra_address_line5,left,right) +
																					 trim(input.corp_ra_address_line6,left,right),left,right)
																				),
														''
													   );
														
			self.corp_ra_prim_range    			:= if (clean_address[179..182] = 'E420',
															reClean_address[1..10],
															clean_address[1..10]
													   );
			self.corp_ra_predir 	      		:= if (clean_address[179..182] = 'E420',
															reClean_address[11..12],
															clean_address[11..12]
													   );
			self.corp_ra_prim_name 	  			:= if (clean_address[179..182] = 'E420',
															reClean_address[13..40],
															clean_address[13..40]
													   );
			self.corp_ra_addr_suffix   			:= if (clean_address[179..182] = 'E420',
															reClean_address[41..44],
															clean_address[41..44]
													   );
			self.corp_ra_postdir 	    		:= if (clean_address[179..182] = 'E420',
															reClean_address[45..46],
															clean_address[45..46]
													   );
			self.corp_ra_unit_desig 	  		:= if (clean_address[179..182] = 'E420',
															reClean_address[47..56],
															clean_address[47..56]
													   );
			self.corp_ra_sec_range 	  			:= if (clean_address[179..182] = 'E420',
															reClean_address[57..64],
															clean_address[57..64]
													   );
			self.corp_ra_p_city_name	  		:= if (clean_address[179..182] = 'E420',
															reClean_address[65..89],
															clean_address[65..89]
													   );
			self.corp_ra_v_city_name	  		:= if (clean_address[179..182] = 'E420',
															reClean_address[90..114], 
															clean_address[90..114]
													   );
			self.corp_ra_state 			      	:= if (clean_address[179..182] = 'E420',
															reClean_address[115..116], 
															clean_address[115..116]
													   );
			self.corp_ra_zip5 		      		:= if (clean_address[179..182] = 'E420',
															reClean_address[117..121], 
															clean_address[117..121]
													   );
			self.corp_ra_zip4 		      		:= if (clean_address[179..182] = 'E420',
															reClean_address[122..125], 
															clean_address[122..125]
													   );
			self.corp_ra_cart 		      		:= if (clean_address[179..182] = 'E420',
															reClean_address[126..129], 
															clean_address[126..129]
													   );
			self.corp_ra_cr_sort_sz 	 		:= if (clean_address[179..182] = 'E420',
															reClean_address[130], 
															clean_address[130]
													   );
			self.corp_ra_lot 		      		:= if (clean_address[179..182] = 'E420',
															reClean_address[131..134], 
															clean_address[131..134]
													   );
			self.corp_ra_lot_order 	  			:= if (clean_address[179..182] = 'E420',
															reClean_address[135], 
															clean_address[135]
													   );
			self.corp_ra_dpbc 		      		:= if (clean_address[179..182] = 'E420',
															reClean_address[136..137], 
															clean_address[136..137]
													   );
			self.corp_ra_chk_digit 	  			:= if (clean_address[179..182] = 'E420',
															reClean_address[138], 
															clean_address[138]
													   );
			self.corp_ra_rec_type		  		:= if (clean_address[179..182] = 'E420',
															reClean_address[139..140],
															clean_address[139..140]
													   );
			self.corp_ra_ace_fips_st	  		:= if (clean_address[179..182] = 'E420',
															reClean_address[141..142],
															clean_address[141..142]
													   );
			self.corp_ra_county 	  			:= if (clean_address[179..182] = 'E420',
															reClean_address[143..145],
															clean_address[143..145]
															
													  );
			self.corp_ra_geo_lat 	    		:= if (clean_address[179..182] = 'E420',
															reClean_address[146..155],
															clean_address[146..155]
													  );
			self.corp_ra_geo_long 	    		:= if (clean_address[179..182] = 'E420',
															reClean_address[156..166],
															clean_address[156..166]
													  );
			self.corp_ra_msa 		      		:= if (clean_address[179..182] = 'E420',
															reClean_address[167..170],
															clean_address[167..170]
													  );
			self.corp_ra_geo_blk				:= if (clean_address[179..182] = 'E420',
															reClean_address[171..177],
															clean_address[171..177]
													  );
			self.corp_ra_geo_match 	  			:= if (clean_address[179..182] = 'E420',
															reClean_address[178],
															clean_address[178]
													  );
			self.corp_ra_err_stat 	    		:= if (clean_address[179..182] = 'E420',
															reClean_address[179..182],
															clean_address[179..182]
													  );
			self								:= input;
			self 								:= [];
		end;
		
		corp2.Layout_Corporate_Direct_Corp_In findCorpStatus(corp2.Layout_Corporate_Direct_Corp_In input, corpStatusLayout r ) := transform
			self.corp_status_desc	:= r.statusDesc;
			self 					:= input;
			self					:= [];
		end; // end transform
		
		corp2.Layout_Corporate_Direct_Corp_In findCorpType(corp2_mapping.Layout_CorpPreClean input, corpTypeLayout r ) := transform
			self.corp_orig_org_structure_DESC   := r.typeDesc;
			self 								:= input;
			self								:= [];
		end; // end transform
		
		corp2.Layout_Corporate_Direct_Corp_In findCorpStateDesc(corp2.Layout_Corporate_Direct_Corp_In input, ForgnStateDescLayout r ) := transform
			self.corp_forgn_state_desc          := if(trimUpper(input.corp_inc_state) <> 'ME',
			                                          trimUpper(r.desc),
													  ''
												   );
			self 					:= input;
			self					:= [];
		end; // end transform
							
		joinCorpType := join(Files_Raw_Input.CORP_BULK(fileDate), corptypeTable,
							trim(left.CORP_ID[9..10],left,right) = right.typeCode,
							ME_CorpTransform(left,right),
							left outer, lookup);

							
		cleanCorp := project(joinCorpType, CleanAddrName(left));
		
		joinStateDesc := join(cleanCorp, ForgnStateTable,
							trimUpper(left.corp_forgn_state_cd) = trimUpper(right.code),
							FindCorpStateDesc(left,right),
							left outer, lookup);
							
		joinCorpStatus := join(joinStateDesc, corpStatusTable,
							trim(left.corp_status_cd,left,right) = right.statusCode,
							FindCorpStatus(left,right),
							left outer, lookup);
							
						
		MapAR := project(Files_Raw_Input.CORP_BULK(fileDate), ME_arTransform(fileDate,left));
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_me',joinCorpStatus	,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_me'	,MapAR					,ar_out		,,,pOverwrite);

			MapMECorpFiling		:=	parallel(                                                                                                                         
				 corp_out	
				,ar_out
			);

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('me',filedate,pOverwrite := pOverwrite))
			,MapMECorpFiling
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_me')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_me')
			)
		);
	
	return result;
	
	end;					 
	
end; // end of ME module