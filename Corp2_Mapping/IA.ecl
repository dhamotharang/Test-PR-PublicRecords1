import std, ut,corp2, tools,_control, versioncontrol, corp2_raw_IA, scrubs, scrubs_corp2_mapping_ia_main, scrubs_corp2_mapping_ia_event;

export IA := MODULE; 
						
  export Update(String fileDate, String version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function
		  
		// Vendor Input Files
		//   Distribute on corp_file_no, then sort on the whole record which will result in the files being 
		//   in corp_file_no order since that's the first field in each file.  Then dedup on the whole record.																																		
		dCrpAdd := dedup(sort(distribute(Corp2_Raw_IA.Files(filedate,pUseProd).Input.crpAdd.Logical,hash(corp_file_no)),record,local), record,local) : independent;	
		dCrpAgt := dedup(sort(distribute(Corp2_Raw_IA.Files(filedate,pUseProd).Input.crpAgt.Logical,hash(corp_file_no)),record,local), record,local) : independent;	
		dCrpDes := dedup(sort(distribute(Corp2_Raw_IA.Files(filedate,pUseProd).Input.crpDes.Logical,hash(corp_file_no)),record,local), record,local) : independent;	
		dCrpFil := dedup(sort(distribute(Corp2_Raw_IA.Files(filedate,pUseProd).Input.crpFil.Logical,hash(corp_file_no)),record,local), record,local) : independent;	
		dCrpHis := dedup(sort(distribute(Corp2_Raw_IA.Files(filedate,pUseProd).Input.crpHis.Logical,hash(corp_file_no)),record,local), record,local) : independent;	
		dCrpNam := dedup(sort(distribute(Corp2_Raw_IA.Files(filedate,pUseProd).Input.crpNam.Logical,hash(corp_file_no)),record,local), record,local) : independent;	
		dCrpOff := dedup(sort(distribute(Corp2_Raw_IA.Files(filedate,pUseProd).Input.crpOff.Logical,hash(corp_file_no)),record,local), record,local) : independent;	
		dCrpPrt := dedup(sort(distribute(Corp2_Raw_IA.Files(filedate,pUseProd).Input.crpPrt.Logical,hash(corp_file_no)),record,local), record,local) : independent;	
		dCrpRem := dedup(sort(distribute(Corp2_Raw_IA.Files(filedate,pUseProd).Input.crpRem.Logical,hash(corp_file_no)),record,local), record,local) : independent;	
		dCrpStk := dedup(sort(distribute(Corp2_Raw_IA.Files(filedate,pUseProd).Input.crpStk.Logical,hash(corp_file_no)),record,local), record,local) : independent;	
	
	  state_origin			 := 'IA';
		state_fips	 			 := '19';	
		state_desc	 			 := 'IOWA';			
  
	// Begin File Joining for Mapping Main (Corp)
	//---------------------------------------------------
						
		// Join with dCrpAgt	
		Corp2_Raw_IA.Layouts.joinMaster FilAgtTrf(Corp2_Raw_IA.Layouts.crpFilLayoutIn l, Corp2_Raw_IA.Layouts.crpAgtLayoutIn r ) := transform
			self	:= l;
			self	:= r;
		end; 
		    	
		joinFilAgt	:= join(dCrpFil, dCrpAgt,
							corp2.t2u(left.corp_file_no) = corp2.t2u(right.corp_file_no),
							FilAgtTrf(left,right),
							left outer, local	);
		 
	 // Join with dCrpAdd						
	 Corp2_Raw_IA.Layouts.joinMaster MergeFilAgtAdd(Corp2_Raw_IA.Layouts.joinMaster l, Corp2_Raw_IA.Layouts.crpAddLayoutIn r ) := transform
			self.address_type	:= r.address_type;
			self.name					:= r.name;
			self.address_1		:= r.address_1;
			self.address_2		:= r.address_2;
			self.city					:= r.city;
			self.state				:= r.state;
			self.zip					:= r.zip;
			self.country			:= r.country;
			self 							:= l;
	 end; 
				
		joinFilAgtAdd	:= join(joinFilAgt, dCrpAdd,
								corp2.t2u(left.corp_file_no) = corp2.t2u(right.corp_file_no),
								MergeFilAgtAdd(left,right),
								left outer,local);
		
		// Join with dCrpDes
		Corp2_Raw_IA.Layouts.joinMaster MergeFilAgtAddDes(Corp2_Raw_IA.Layouts.joinMaster l, Corp2_Raw_IA.Layouts.crpDesLayoutIn r ) := transform
			self.ap_type    := r.ap_type;
			self.desc       := r.desc;
			self	          := l;
		end; 
				
		joinFilAgtAddDes := join(joinFilAgtAdd, dCrpDes,
								 corp2.t2u(left.corp_file_no) = corp2.t2u(right.corp_file_no),
								 MergeFilAgtAddDes(left,right),
								 left outer,local );	
		
    // Join with dCrpNam		
		Corp2_Raw_IA.Layouts.joinMaster MergeFilAgtAddDesNam(Corp2_Raw_IA.Layouts.joinMaster l, Corp2_Raw_IA.Layouts.crpNamLayoutIn r ) := transform
			self.name_type					:= r.name_type;
			self.curr_name					:= r.curr_name;
			self.name_mod_flag			:= r.name_mod_flag;
			self.name_frm					  := r.name_frm;
			self.name_status_code		:= r.name_status_code;
			self.name_cert_no				:= r.name_cert_no;
			self.sequence_no				:= r.sequence_no;
			self.old_sequence_no		:= r.old_sequence_no;
			self										:= l;
		end; 
		
		joinFilAgtAddDesNam := join(joinFilAgtAddDes, dCrpNam,
									corp2.t2u(left.corp_file_no) = corp2.t2u(right.corp_file_no),
									MergeFilAgtAddDesNam(left,right),
									left outer,local);	
								
    // Join with dCrpPrt		
		Corp2_Raw_IA.Layouts.joinMaster MergeFilAgtAddDesNamPrt(Corp2_Raw_IA.Layouts.joinMaster l, Corp2_Raw_IA.Layouts.crpPrtLayoutIn r ) := transform
			self.partners					:= r.partners;
			self	                := l;
		end; 
		
		joinFilAgtAddDesNamPrt := join(joinFilAgtAddDesNam, dCrpPrt,
									corp2.t2u(left.corp_file_no) = corp2.t2u(right.corp_file_no),
									MergeFilAgtAddDesNamPrt(left,right),
									left outer,local);
	
	  // Join with dCrpHis		
		Corp2_Raw_IA.Layouts.joinMaster MergeJoinMaster(Corp2_Raw_IA.Layouts.joinMaster l, Corp2_Raw_IA.Layouts.crpHisLayoutIn r ) := transform
			self.type_filing			:= r.type_filing;
			self.date_filed				:= r.date_filed;
			self.time_filed				:= r.time_filed;
			self.date_filing_eff	:= r.date_filing_eff;
			self.time_fiing_eff		:= r.time_fiing_eff;
			self.his_date_expired	:= r.his_date_expired;
			self.total_pages			:= r.total_pages;
			self.book_no					:= r.book_no;
			self.page_no					:= r.page_no;
			self.cert_no					:= r.cert_no;
			self.remarks_flag			:= r.remarks_flag;
			self.merger_file_no		:= r.merger_file_no;
			self.merger_status		:= r.merger_status;
			self.merger_name			:= r.merger_name;
			self.merger_state			:= r.merger_state;
			self									:= l;
		end; 
		
		//Final join file that will be used to map CORP records
		joinMaster := join(joinFilAgtAddDesNamPrt, dCrpHis(corp2.t2u(merger_status) in ['D','A']),
									corp2.t2u(left.corp_file_no) = corp2.t2u(right.corp_file_no),
									MergeJoinMaster(left,right),
									left outer,local);
									
		// Transform joinMaster to Main Common Layout  				
	  Corp2_Mapping.LayoutsCommon.Main corpMasterTrf(Corp2_Raw_IA.Layouts.joinMaster input) := transform
			self.dt_first_seen					    := (integer)fileDate;
			self.dt_last_seen					      := (integer)fileDate;
			self.dt_vendor_first_reported		:= (integer)fileDate;
			self.dt_vendor_last_reported		:= (integer)fileDate;
			self.corp_ra_dt_first_seen			:= (integer)fileDate;
			self.corp_ra_dt_last_seen			  := (integer)fileDate;			
			self.corp_key						        := state_fips + '-' + corp2.t2u(input.corp_file_no);
			self.corp_vendor					      := state_fips;
			self.corp_state_origin				  := state_origin;
			self.corp_process_date				  := fileDate;
			self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.corp_file_no);
			self.corp_legal_name				    := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.curr_name).BusinessName; 	
			self.corp_inc_state							:= state_origin;
			self.corp_addl_info   				  := if(corp2.t2u(input.delin_flag) = 'Y', 'DELINQUENT BIENNIAL REPORT', '');	 
			self.corp_ln_name_type_cd			  := corp2.t2u(input.name_type);
			self.corp_ln_name_type_desc			:= Corp2_Raw_IA.Functions.GetNameTypeDesc(input.name_type);
			self.corp_acres                 := corp2.t2u(input.no_acres);
			self.corp_farm_status_desc      := if (corp2.t2u(input.farm_delin_flag) in ['Y','I','U'],'DELINQUENT AGRICULTURAL REPORT','');
      self.corp_agriculture_flag		  := map (corp2.t2u(input.farm_flag) in ['Y','F'] => 'Y',
			                                        corp2.t2u(input.farm_flag) = 'N'        => 'N',
																							'');
			chapterDesc                     := Corp2_Raw_IA.functions.GetChapterDesc(input.Chapter_No);																				
			self.corp_for_profit_ind        := map (StringLib.StringFind(chapterDesc,'NON-PROFIT', 1) <> 0 => 'N',
																						  StringLib.StringFind(chapterDesc,'PROFIT', 1) <> 0     => 'Y',
																						  '');
			chapterList                     := ['COVER','NON EX','1090DF','1120DF','5480TM','COUNTY'];																			
			self.corp_orig_org_structure_cd := if (corp2.t2u(input.chapter_no) not in chapterList ,corp2.t2u(input.chapter_no) ,'');
			self.corp_orig_org_structure_desc := if (corp2.t2u(input.chapter_no) not in chapterList ,chapterDesc ,'');
			self.corp_country_of_formation  := Corp2_Raw_IA.functions.GetCountryDesc(input.state_of_incorp);			
			self.corp_status_cd	            := corp2.t2u(input.status_code);
			self.corp_status_desc           := Corp2_Raw_IA.functions.GetStatusDesc(self.corp_status_cd, input.dead_code);
      self.corp_name_status_cd        := if (corp2.t2u(input.status_code) in ['A','D'], corp2.t2u(input.status_code), '');
		  self.corp_name_status_desc      := case (self.corp_name_status_cd, 'A' => 'ACTIVE', 'D' => 'INACTIVE', '');
			self.corp_status_date				    := Corp2_Mapping.fValidateDate(input.dead_date,'MM-DD-CCYY').GeneralDate;			
			self.corp_term_exist_cd				  := map (input.date_expired[7..10] = '9999' => 'P',
																							Corp2_Mapping.fValidateDate(input.date_expired,'MM-DD-CCYY').GeneralDate <> '' => 'D',
																				      '');
			self.corp_term_exist_desc			  := map (self.corp_term_exist_cd = 'P' => 'PERPETUAL',
			                                        self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																					  	'');
			self.corp_term_exist_exp			  := if (self.corp_term_exist_cd = 'D' 
																						,Corp2_Mapping.fValidateDate(input.date_expired,'MM-DD-CCYY').GeneralDate
																						,'');		   
			self.corp_forgn_state_cd        := if(corp2.t2u(input.state_of_incorp) not in ['',state_origin]
																						,Corp2_Raw_IA.functions.GetState(input.state_of_incorp), '');
			self.corp_forgn_state_desc      := Corp2_Raw_IA.functions.DecodeState(self.corp_forgn_state_cd);
  		self.corp_name_comment  		 	  := Corp2_Raw_IA.Functions.GetCorpNameComment(input.ap_type, input.name_status_code, input.desc, input.name_cert_no);			
			
			incChapterList := ['490FLC','486AFL','488FLP','487FLP','488FLL','504AFN','490FPL','496CFP','490FPC'];
      self.corp_foreign_domestic_ind  := map (corp2.t2u(input.state_of_incorp) not in ['',state_origin]                                   => 'F',
																							corp2.t2u(input.state_of_incorp) = '' and corp2.t2u(input.chapter_no) in incChapterList     => 'F',
																							corp2.t2u(input.state_of_incorp) = state_origin                                             => 'D',
																							corp2.t2u(input.state_of_incorp) = '' and corp2.t2u(input.chapter_no) not in incChapterList => 'D',
																							'');

			incDate        := Corp2_Mapping.fValidateDate(input.date_incorp,'MM-DD-CCYY').PastDate;
			self.corp_inc_date              := if (corp2.t2u(input.state_of_incorp) in [state_origin,''] and 
																							 corp2.t2u(input.chapter_no) not in incChapterList 
																						 ,incDate ,'' );
			self.corp_forgn_date 						:= if (corp2.t2u(input.state_of_incorp) not in [state_origin,''] 
																						 ,incDate
																						 ,if (corp2.t2u(input.state_of_incorp) = '' and 
																									  corp2.t2u(input.chapter_no) in incChapterList 
																									,incDate ,'') );
			self.corp_authorized_partners   := corp2.t2u(input.partners);	
			self.corp_ra_full_name		      := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.AgtName).BusinessName;
 
			self.corp_address1_type_cd      := if (corp2.t2u(input.address_type) = 'H' and Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).ifAddressExists,'B','');
			self.corp_address1_type_desc    := if (corp2.t2u(input.address_type) = 'H' and Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).ifAddressExists,'BUSINESS','');
			self.corp_address1_line1				:= if (corp2.t2u(input.address_type) = 'H' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).AddressLine1 ,'');
			self.corp_address1_line2				:= if (corp2.t2u(input.address_type) = 'H' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).AddressLine2 ,'');
			self.corp_address1_line3				:= if (corp2.t2u(input.address_type) = 'H' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).AddressLine3 ,'');		
			self.corp_prep_addr1_line1			:= if (corp2.t2u(input.address_type) = 'H' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).PrepAddrLine1	,'');			
			self.corp_prep_addr1_last_line	:= if (corp2.t2u(input.address_type) = 'H' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).PrepAddrLastLine ,'');
			
			self.corp_address2_type_cd      := if (corp2.t2u(input.address_type) = 'M' and Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).ifAddressExists,'M','');			
			self.corp_address2_type_desc    := if (corp2.t2u(input.address_type) = 'M' and Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).ifAddressExists,'MAILING','');																			
			self.corp_address2_line1				:= if (corp2.t2u(input.address_type) = 'M' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).AddressLine1 ,'');
			self.corp_address2_line2				:= if (corp2.t2u(input.address_type) = 'M' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).AddressLine2	,'');
			self.corp_address2_line3				:= if (corp2.t2u(input.address_type) = 'M' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).AddressLine3	,'');			
			self.corp_prep_addr2_line1			:= if (corp2.t2u(input.address_type) = 'M' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).PrepAddrLine1 ,'');			
			self.corp_prep_addr2_last_line	:= if (corp2.t2u(input.address_type) = 'M' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).PrepAddrLastLine	,'');													  
			
			self.corp_ra_address_type_cd    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.AgtAddress_1,input.AgtAddress_2,input.AgtCity,input.AgtState,input.AgtZip).ifAddressExists, 'R', '');			
			self.corp_ra_address_type_desc  := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.AgtAddress_1,input.AgtAddress_2,input.AgtCity,input.AgtState,input.AgtZip).ifAddressExists, 'REGISTERED OFFICE', '');
			self.corp_ra_address_line1			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.AgtAddress_1,input.AgtAddress_2,input.AgtCity,input.AgtState,input.AgtZip).AddressLine1;
			self.corp_ra_address_line2			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.AgtAddress_1,input.AgtAddress_2,input.AgtCity,input.AgtState,input.AgtZip).AddressLine2;
			self.corp_ra_address_line3			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.AgtAddress_1,input.AgtAddress_2,input.AgtCity,input.AgtState,input.AgtZip).AddressLine3;
			self.RA_prep_addr_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.AgtAddress_1,input.AgtAddress_2,input.AgtCity,input.AgtState,input.AgtZip).PrepAddrLine1;
			self.RA_prep_addr_last_line			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.AgtAddress_1,input.AgtAddress_2,input.AgtCity,input.AgtState,input.AgtZip).PrepAddrLastLine;
			
			self.corp_merger_desc           := map(corp2.t2u(input.merger_status) = 'D' and corp2.t2u(input.type_filing) = 'MERG' => 'MERGED - NON-SURVIVOR',
			                                       corp2.t2u(input.merger_status) = 'A' and corp2.t2u(input.type_filing) = 'MERG' => 'MERGED - SURVIVOR',
																						 '');
			self.corp_merger_indicator      := map(corp2.t2u(input.merger_status) = 'D' and corp2.t2u(input.type_filing) = 'MERG' => 'N',
			                                       corp2.t2u(input.merger_status) = 'A' and corp2.t2u(input.type_filing) = 'MERG' => 'S',
																						 '');
			self.corp_merger_id             := corp2.t2u(input.merger_file_no);
			self.corp_merger_name           := map(corp2.t2u(input.merger_status) = 'D' and corp2.t2u(input.type_filing) = 'MERG' => '',
			                                       corp2.t2u(input.merger_status) = 'A' and corp2.t2u(input.type_filing) = 'MERG' => corp2.t2u(input.merger_name),
																						 '');
			self.corp_merger_effective_date	:= Corp2_Mapping.fValidateDate(input.date_filed,'MM-DD-CCYY').GeneralDate;
			self.recordOrigin := 'C';
 			self := [];
	  end; 
		
		MapCorp	:= project(joinMaster, corpMasterTrf(left));
		
		
		//------------------------------------------------
		// Begin Mapping Contacts
		//------------------------------------------------
		
    // Join with dCrpNam		
		Corp2_Raw_IA.Layouts.crpOffLookupsNam joinOffNamFiles(Corp2_Raw_IA.Layouts.crpOffLayoutIn l, Corp2_Raw_IA.Layouts.crpNamLayoutIn r ) := transform
			self 	:= l;
			self	:= r;
			self	:= [];
		end; 
			
		joinOfficerNam := dedup(join(dCrpOff, dCrpNam,
									corp2.t2u(left.corp_file_no) = corp2.t2u(right.corp_file_no),
									joinOffNamFiles(left,right),
									left outer,local),record,local);
	
		
    // Transform joinOfficerNam to Main Common Layout (Contacts)		
		Corp2_Mapping.LayoutsCommon.Main ContTrf(Corp2_Raw_IA.Layouts.crpOffLookupsNam input) := transform
					,skip(corp2.t2u(input.curr_name) = '') // Per Rosemary. Vendor sends a few Contact recs with no corresponding Corp rec
			self.dt_first_seen					    := (integer)fileDate;
			self.dt_last_seen					      := (integer)fileDate;
			self.dt_vendor_first_reported		:= (integer)fileDate;
			self.dt_vendor_last_reported		:= (integer)fileDate;
			self.corp_ra_dt_first_seen			:= (integer)fileDate;
			self.corp_ra_dt_last_seen			  := (integer)fileDate;	
			self.corp_key										:= state_fips + '-' + corp2.t2u(input.corp_file_no);
			self.corp_vendor								:= state_fips;
			self.corp_state_origin					:= state_origin;
			self.corp_inc_state							:= state_origin;
			self.corp_process_date					:= fileDate;
			self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.corp_file_no);
			self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.curr_name).BusinessName;
			self.cont_full_name						  := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.name).BusinessName;
			self.cont_title1_desc				    := Corp2_Raw_IA.Functions.getOfficerDesc(input.officer_type);
			self.cont_addl_info						  := map(corp2.t2u(input.dir_flag)  = 'Y' and corp2.t2u(input.shholder_flag) <> 'Y' => 'DIRECTOR',
																						 corp2.t2u(input.dir_flag) <> 'Y' and corp2.t2u(input.shholder_flag)  = 'Y' => 'SHAREHOLDER',
																						 corp2.t2u(input.dir_flag)  = 'Y' and corp2.t2u(input.shholder_flag)  = 'Y' => 'DIRECTOR AND SHAREHOLDER',
																						 '');
			self.cont_country 		 	        := Corp2_Mapping.fCleanCountry(state_origin,state_desc,input.state,input.country).country;
			
			self.cont_address_type_cd       := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).ifAddressExists,'T','');
			self.cont_address_type_desc     := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).ifAddressExists,'CONTACT','');
			self.cont_address_line1			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).AddressLine1;
			self.cont_address_line2			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).AddressLine2;
			self.cont_address_line3			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).AddressLine3;
			self.cont_prep_addr_line1			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).PrepAddrLine1;
			self.cont_prep_addr_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address_1,input.address_2,input.city,input.state,input.zip,input.country).PrepAddrLastLine;
			self.recordOrigin 						  := 'T';	
			self := [];	
		end;
		
		mapCont	:= project(joinOfficerNam, ContTrf(left));
		
		// End Mapping Contacts
			
		
		// Begin Lookups/File Joining for Events and AR
		//-------------------------------------------------------------------------------
		
		// File Joining for Mapping Events
    srtCrpHis := sort(distribute(dCrpHis,hash(corp2.t2u(cert_no))),corp2.t2u(cert_no),local);
		srtCrpRem := sort(distribute(dCrpRem,hash(corp2.t2u(RemCertNo))),corp2.t2u(RemCertNo),local);
				
		Corp2_Raw_IA.Layouts.AllEventFiles MergeHisRem(Corp2_Raw_IA.Layouts.crpHisLayoutIn l, Corp2_Raw_IA.Layouts.crpRemLayoutIn r ) := transform
			self	:= l;
			self	:= r;
		end; 
		
		joinHisRem := join( srtCrpHis, srtCrpRem,
							corp2.t2u(left.cert_no) = corp2.t2u(right.RemCertNo),
							MergeHisRem(left,right),
							left outer, local);	
		
		srtjoinHisRem := sort(distribute(joinHisRem,hash(corp_file_no)),corp_file_no,local);
		
		Corp2_Raw_IA.Layouts.AllEventFiles MergeFilHisRem(Corp2_Raw_IA.Layouts.crpFilLayoutIn l, Corp2_Raw_IA.Layouts.AllEventFiles r ) := transform
			self	:= l;
			self	:= r;
		end; 
		
		joinFilHisRem := join( dCrpFil, srtjoinHisRem,
								corp2.t2u(left.corp_file_no) = corp2.t2u(right.corp_file_no),
								MergeFilHisRem(left,right),
								left outer, local) : independent;
								
								
		// Transform for Mapping AR
		Corp2_Mapping.LayoutsCommon.AR ARTrf(Corp2_Raw_IA.Layouts.AllEventFiles  input):=transform,
										  skip(corp2.t2u(input.type_filing) not in ['AG','ANNR','BIEN','PMT'])
			self.corp_key									:= state_fips + '-' + corp2.t2u(input.corp_file_no);		
			self.corp_vendor							:= state_fips;		
			self.corp_state_origin				:= state_origin;
			self.corp_process_date				:= fileDate;
			self.corp_sos_charter_nbr			:= corp2.t2u(input.corp_file_no);
  		self.ar_filed_dt					    := Corp2_Mapping.fValidateDate(input.date_filed,'MM-DD-CCYY').PastDate;
			self.ar_type			            := map( corp2.t2u(input.type_filing) = 'AG'   => 'AGRICULTURE REPORT',
																						corp2.t2u(input.type_filing) = 'ANNR' => 'ANNUAL REPORT FILED',
																						corp2.t2u(input.type_filing) = 'BIEN' => 'BIENNIAL REPORT FILED',
																						corp2.t2u(input.type_filing) = 'PMT'  => 'PAYMENT FOR BIENNIAL REPORT',
																						'');
			self.ar_comment     := if(corp2.t2u(input.remarks_flag) = 'Y' ,corp2.t2u(input.remarks) ,'');
															 
			expireDate					:=  Corp2_Mapping.fValidateDate(input.his_date_expired,'MM-DD-CCYY').PastDate;
			self.ar_status  		:= 	if (expireDate <> '' ,'AR REPORT EXPIRED ' + expireDate , '');
			self								:=[];
		end;		
			
		// Transform for Mapping Events
		Corp2_Mapping.LayoutsCommon.Events EventTrf(Corp2_Raw_IA.Layouts.AllEventFiles  input):=transform,
												 skip(corp2.t2u(input.type_filing) in ['AG','ANNR','BIEN','PMT','MERG'])
			self.corp_key									:= state_fips + '-' + corp2.t2u(input.corp_file_no);	
			self.corp_vendor							:= state_fips;		
			self.corp_state_origin				:= state_origin;
			self.corp_process_date				:= fileDate;
			self.corp_sos_charter_nbr			:= corp2.t2u(input.corp_file_no);
			self.event_filing_cd				  := corp2.t2u(input.type_filing);
			self.event_filing_desc				:= Corp2_Raw_IA.Functions.GetFilingDesc(input.type_filing);
			self.event_filing_date				:= Corp2_Mapping.fValidateDate(input.date_filed,'MM-DD-CCYY').PastDate;
			self.event_date_type_cd				:= 'FIL';
			self.event_date_type_desc			:= 'FILING';
			self.event_book_nbr           := corp2.t2u(input.book_no);
			self.event_page_nbr           := corp2.t2u(input.page_no);
			self.event_desc               := if(corp2.t2u(input.remarks_flag) = 'Y' ,corp2.t2u(input.remarks) ,'');
			self								          :=[];
		end;
								
    // Transform for Mapping Stock	  
		Corp2_Mapping.LayoutsCommon.Stock StockTrf(Corp2_Raw_IA.Layouts.crpStkLayoutIn input):=transform
						,skip(corp2.t2u(input.stock_type + input.stock_class + input.number_shares + input.stock_series) = '')
			self.corp_key									:= state_fips + '-' + corp2.t2u(input.corp_file_no);		
			self.corp_vendor							:= state_fips;		
			self.corp_state_origin				:= state_origin;
			self.corp_process_date				:= fileDate;
			self.corp_sos_charter_nbr			:= corp2.t2u(input.corp_file_no);
			self.stock_type						    := map(	corp2.t2u(input.stock_type) = 'C' 		=> 'COMMON',
																						corp2.t2u(input.stock_type) = 'P' 		=> 'PREFERRED',
																						corp2.t2u(input.stock_type) = 'N' 		=> 'VOTING',
																						corp2.t2u(input.stock_type) = 'NV'		=> 'NON-VOTING',
																						corp2.t2u(input.stock_type) = 'CUM' 	=> 'CUMULATIVE',
																						corp2.t2u(input.stock_type) = 'ORG' 	=> 'ORGANIZATIONAL',
																						corp2.t2u(input.stock_type) = 'CONV' 	=> 'CONVERTIBLE',
																						corp2.t2u(input.stock_type) );											
			self.stock_class							:= corp2.t2u(input.stock_class);
			self.stock_shares_issued			:= corp2.t2u(input.number_shares);
			self.stock_stock_series				:= corp2.t2u(input.stock_series);
			self.stock_addl_info			  	:= corp2.t2u(input.stock_series); // from old mapper 
			self													:=[];
		end;
		
		
	//-----------------------------------------------------------//
	// Build the Final Mapped Files
	//-----------------------------------------------------------//
  	mapMain   := dedup(sort(distribute(mapCorp + mapCont,hash(corp_key)), record,local), record,local) : independent;	
		mapEvent	:= dedup(sort(distribute(project(joinFilHisRem, EventTrf(left)),hash(corp_key)), record,local), record,local) : independent;
		mapAR			:= dedup(sort(distribute(project(joinFilHisRem, ARTrf(left)),hash(corp_key)), record,local), record,local) : independent;
		mapStock	:= dedup(sort(distribute(project(dCrpStk, StockTrf(left)),hash(corp_key)), record,local), record,local) : independent;
				
				
//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_IA_Main.Scrubs;        // IA scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_IA'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_IA'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_IA'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_IA_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
	
	  //Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_IA_Main').SubmitStats;
		
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_IA_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_IA Report' //subject
																																	 ,'Scrubs CorpMain_IA Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpIAMainScrubsReport.csv'
																																	);		
																																 																													
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 	 <> 0 or
																							dt_vendor_last_reported_invalid 	 <> 0 or
																							dt_first_seen_invalid 			       <> 0 or
																							dt_last_seen_invalid 			         <> 0 or
																							corp_ra_dt_first_seen_invalid 		 <> 0 or
																							corp_ra_dt_last_seen_invalid 			 <> 0 or
																							corp_key_invalid 			             <> 0 or
																							corp_vendor_invalid 			         <> 0 or
																							corp_state_origin_invalid 			   <> 0 or
																							corp_process_date_invalid 			   <> 0 or
																							corp_inc_state_invalid 			       <> 0 or
																							corp_forgn_date_invalid 			     <> 0 or
																							corp_inc_date_invalid 			       <> 0 or
																							corp_term_exist_exp_invalid 			 <> 0 or
																							corp_merger_effective_date_invalid <> 0 or
																							corp_status_date_invalid      		 <> 0 or
																							corp_orig_sos_charter_nbr_invalid  <> 0 or
																							corp_legal_name_invalid 			     <> 0 or
																							corp_foreign_domestic_ind_invalid  <> 0 or
																							corp_for_profit_ind_invalid 			 <> 0 or
																							corp_ln_name_type_cd_invalid 			 <> 0 or
																							corp_forgn_state_desc_invalid      <> 0 or
																							corp_orig_org_structure_cd_invalid <> 0 or
																							cont_title1_desc_invalid           <> 0 or
																							corp_status_cd_invalid             <> 0 );

		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 	 = 0 and
																								dt_vendor_last_reported_invalid 	 = 0 and
																								dt_first_seen_invalid 			       = 0 and
																								dt_last_seen_invalid 			         = 0 and
																								corp_ra_dt_first_seen_invalid 		 = 0 and
																								corp_ra_dt_last_seen_invalid 			 = 0 and
																								corp_key_invalid 			             = 0 and
																								corp_vendor_invalid 			         = 0 and
																								corp_state_origin_invalid 			   = 0 and
																								corp_process_date_invalid 			   = 0 and
																								corp_inc_state_invalid 			       = 0 and
																								corp_forgn_date_invalid 			     = 0 and
																								corp_inc_date_invalid 			       = 0 and
																								corp_term_exist_exp_invalid 			 = 0 and
																								corp_merger_effective_date_invalid = 0 and
																								corp_status_date_invalid      		 = 0 and
																								corp_orig_sos_charter_nbr_invalid  = 0 and
																								corp_legal_name_invalid 			     = 0 and
																								corp_foreign_domestic_ind_invalid  = 0 and
																								corp_for_profit_ind_invalid 			 = 0 and
																								corp_ln_name_type_cd_invalid 			 = 0 and
																								corp_forgn_state_desc_invalid      = 0 and
																							  corp_orig_org_structure_cd_invalid = 0 and
																							  cont_title1_desc_invalid           = 0 and
																								corp_status_cd_invalid             = 0 );																								 																	
		
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_IA_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
											 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_IA_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
											 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						         count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_IA_Main.Threshold_Percent.CORP_KEY      					 	=> true,
											 count(Main_GoodRecords) = 0																																																																																				              => true,
											 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_ia',overwrite,__compressed__,named('Sample_Rejected_MainRecs_IA'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_IA'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainIAScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.IA - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues
																		,Main_SubmitStats);	
																		
	//--------------------------------------------------------------------	
  // Scrubs for Event
  //--------------------------------------------------------------------
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_IA_Event.Scrubs;        // IA scrubs module
		Event_N := Event_S.FromNone(Event_F); 									// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile);// Pass the expanded error flags into the Expanded module

	//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_IA'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_IA'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_IA'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats						:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_IA_Event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);
		
    //Submits Profile's stats to Orbit
    Event_SubmitStats         := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_IA_Event').SubmitStats;
		
		Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_IA_Event').CompareToProfile_with_Examples;
		
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpEvent_IA Report' //subject
																																	 ,'Scrubs CorpEvent_IA Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpIAEventScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );		
																																 
		Event_BadRecords := Event_T.ExpandedInFile(	corp_key_invalid  		         <> 0 or
																								corp_sos_charter_nbr_invalid   <> 0 or
																								event_filing_cd_invalid		     <> 0 or
																								event_filing_date_invalid 		 <> 0 );	

		Event_GoodRecords	:= Event_T.ExpandedInFile(corp_key_invalid  		         = 0 and
																								corp_sos_charter_nbr_invalid   = 0 and
																								event_filing_cd_invalid		     = 0 and
																								event_filing_date_invalid 		 = 0 );																					 																	
		
		Event_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Event_N.ExpandedInFile(corp_sos_charter_nbr_invalid<>0)),count(Event_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_IA_Event.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Event_N.ExpandedInFile(corp_key_invalid<>0)),					   count(Event_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_IA_Event.Threshold_Percent.CORP_KEY      						=> true,
													 count(Event_GoodRecords) = 0																																																																																				        => true,
													 false );

		Event_ApprovedRecords := project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));		
		
		Event_RejFile_Exists			:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' + state_origin),true,false);			
	  Event_ALL									:= sequential(IF(count(Event_BadRecords)<> 0
																						 ,if(poverwrite
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_IA',overwrite,__compressed__,named('Sample_Rejected_Event_Recs_IA'+filedate))
																								,sequential (IF(Event_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin)),
																														 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin,__compressed__,named('Sample_Rejected_Event_Recs_IA'+filedate)))))
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventIAScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_SendEmailFile, OUTPUT('CORP2_MAPPING.IA - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues
																					 ,Event_SubmitStats);
																					 
		//-------------------- Version Control -----------------------------------------------------//	
	  VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_ia'	    ,Main_ApprovedRecords  ,main_out,,,pOverwrite);		
    VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ia'	    ,Event_ApprovedRecords,event_out,,,pOverwrite);
	  VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_ia'		    ,MapAR		            ,ar_out		,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ia'	    ,MapStock             ,stock_out,,,pOverwrite);
		
	  VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_ia'	,MapMain     ,write_fail_main	,,,pOverwrite);		
	  VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::event_ia'	,MapEvent    ,write_fail_event,,,pOverwrite);	
		
	  mapIA:= sequential(if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
											  // ,Corp2_Raw_IA.Build_Bases(filedate,version,pUseProd).All  // determined building of bases is not needed
												,main_out
												,event_out
												,ar_out
												,stock_out										
												,IF(Main_FailBuild <> true or Event_FailBuild <> true
														,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_IA')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_IA')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_IA')																		 
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_IA')
																				,if (count(Main_BadRecords) <> 0 or  count(Event_BadRecords) <> 0 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords),count(mapStock)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords),count(mapStock)).MappingSuccess																				 
																						 )	 
																			)
														 ,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																				 ,write_fail_event
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,IF(Main_IsScrubErrors or Event_IsScrubErrors
														,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,false,Event_IsScrubErrors,false).FieldsInvalidPerScrubs)
												,Event_All
												,Main_All	
										);
															
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-31) and ut.date_math(filedate,31),true,false);
    return sequential (if (isFileDateValid
														,mapIA
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.IA failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End IA Module
