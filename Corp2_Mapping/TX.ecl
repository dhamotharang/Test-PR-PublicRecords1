 import Corp2,ut, lib_stringlib, _validate, Address,_control, versioncontrol;
 
 export TX := MODULE;
 
    export Layouts_Raw_Input := MODULE;       
				export master := RECORD		
					  string   blob;  
				end;	 
		end; // end of Layouts_Raw_Input module
   
		export Files_Raw_Input := MODULE;
				export Master_02(string fileDate)                   := dataset('~thor_data400::in::corp2::'+filedate+'::master::tx',Layouts_Raw_Input.master,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])))(blob[1..2] = '02');
				export Master_Addr_03(string fileDate)              := dataset('~thor_data400::in::corp2::'+filedate+'::master::tx',Layouts_Raw_Input.master,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])))(blob[1..2] = '03');
				export Register_BusiAgent_05(string fileDate)       := dataset('~thor_data400::in::corp2::'+filedate+'::master::tx',Layouts_Raw_Input.master,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])))(blob[1..2] = '05');
				export RegAgent_PersonalName_06(string fileDate)    := dataset('~thor_data400::in::corp2::'+filedate+'::master::tx',Layouts_Raw_Input.master,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])))(blob[1..2] = '06');
				export charter_BusinessOffi_07(string fileDate)     := dataset('~thor_data400::in::corp2::'+filedate+'::master::tx',Layouts_Raw_Input.master,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])))(blob[1..2] = '07');
				export CharterOffi_PersonalNm_08(string fileDate)   := dataset('~thor_data400::in::corp2::'+filedate+'::master::tx',Layouts_Raw_Input.master,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])))(blob[1..2] = '08');
				export CharterNames_09(string fileDate)             := dataset('~thor_data400::in::corp2::'+filedate+'::master::tx',Layouts_Raw_Input.master,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])))(blob[1..2] = '09');
				export AssociatedEntity_10(string fileDate)         := dataset('~thor_data400::in::corp2::'+filedate+'::master::tx',Layouts_Raw_Input.master,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])))(blob[1..2] = '10');
				export FilingHistory_11(string fileDate)            := dataset('~thor_data400::in::corp2::'+filedate+'::master::tx',Layouts_Raw_Input.master,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])))(blob[1..2] = '11');
				export AuditLog_12(string fileDate)                 := dataset('~thor_data400::in::corp2::'+filedate+'::master::tx',Layouts_Raw_Input.master,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])))(blob[1..2] = '12');
		end;
	
		
		trimUpper(string s) := function
				return trim(stringlib.StringToUppercase(s),left,right);
		end;
		

		export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
			// Rec-02
			export Master_02_rec := Record
					string2   rec_code_02;
					string10  filing_number_02;
					string2   status_id;
					string2   corp_type_id;
					string150 name;
					string2   perpetual_flag;
					string8   creation_date;
					string8   expiration_date;
					string8   inactive_date;
					string8   formation_date;
					string8   report_due_date;
					string11  tax_id;
					string150 dba_name;
					string16  foreign_fein;
					string4   foreign_state;
					string64  foreign_country;
					string8   foreign_formation_date;
					string16  expiration_type;
					string3   nonprofit_subtype_id;
					string2   boc_flag;
					string8   boc_date;
					string70  filler_02;
			end;
		
			Master_02_rec trf_02rec(Layouts_Raw_Input.master l) := transform
					self.rec_code_02                  := l.blob[1..2];	
					self.filing_number_02             := l.blob[3..12];
					self.status_id               	    := l.blob[13..14];
					self.corp_type_id                 := l.blob[15..16];
					self.name                         := l.blob[17..166];
					self.perpetual_flag               := l.blob[167..168];	
					self.creation_date                := l.blob[169..176];	
					self.expiration_date              := l.blob[177..184];	
					self.inactive_date                := l.blob[185..192];	
					self.formation_date               := l.blob[193..200];	
					self.report_due_date              := l.blob[201..208];	
					self.tax_id                       := l.blob[209..219];	
					self.dba_name                     := l.blob[220..369];	
					self.foreign_fein                 := l.blob[370..385];	
					self.foreign_state                := l.blob[386..389];	
					self.foreign_country              := l.blob[390..453];	
					self.foreign_formation_date       := l.blob[454..461];	
					self.expiration_type              := l.blob[462..477];	
					self.nonprofit_subtype_id         := l.blob[478..480];	
					self.boc_flag                     := l.blob[481..482];	
					self.boc_date                     := l.blob[482..490];	
					self.filler_02                    := l.blob[491..548];	
			end;
											
			Master_02_File 					:= project(Files_Raw_Input.Master_02(filedate), trf_02rec(left));
			
			// Rec-03
			export Master_Addr_03_rec := Record
					string2   rec_code_03;
					string10  filing_number_03;
					string50  address1;
					string50  address2;
					string64  city;
					string4   state;
					string9   zip;
					string6   zip_extension;
					string64  country;
					string301 filler; 
			end;																	
			
			Master_Addr_03_rec trf_03rec(Layouts_Raw_Input.master l) := transform
					self.rec_code_03        := l.blob[1..2];	
					self.filing_number_03   := l.blob[3..12];	
					self.address1           := l.blob[13..62];	
					self.address2           := l.blob[63..112];	
					self.city               := l.blob[113..176];	
					self.state              := l.blob[177..180];	
					self.zip                := l.blob[181..189];	
					self.zip_extension      := l.blob[190..195];	
					self.country            := l.blob[196..259];	
					self.filler             := l.blob[260..560];		
			end;
			
			Master_Addr_03_File 			:= project(Files_Raw_Input.Master_Addr_03(filedate), trf_03rec(left));
			
			// Rec-05
			export Register_BusiAgent_05_rec := Record
					string2   BusiAgent_rec_code;
					string10  BusiAgent_filing_number;
					string50  BusiAgent_address1;
					string50  BusiAgent_address2;
					string64  BusiAgent_city; 
					string4   BusiAgent_state;
					string9   BusiAgent_zip;
					string6   BusiAgent_zip_extension;
					string64  BusiAgent_country;
					string8   BusiAgent_inactive_date;
					string150 BusiAgent_business_name;
					string143 BusiAgent_filler;
			end;
																
			Register_BusiAgent_05_rec trf_05rec(Layouts_Raw_Input.master l) := transform
					self.BusiAgent_rec_code           := l.blob[1..2];	
					self.BusiAgent_filing_number      := l.blob[3..12];	
					self.BusiAgent_address1           := l.blob[13..62];	
					self.BusiAgent_address2           := l.blob[63..112];	
					self.BusiAgent_city               := l.blob[113..176];	
					self.BusiAgent_state              := l.blob[177..180];	
					self.BusiAgent_zip                := l.blob[181..189];	
					self.BusiAgent_zip_extension      := l.blob[190..195];	
					self.BusiAgent_country            := l.blob[196..259];
					self.BusiAgent_inactive_date      := l.blob[260..267];
					self.BusiAgent_business_name      := l.blob[268..417];
					self.BusiAgent_filler             := l.blob[418..560];		
			end;
			
			Register_BusiAgent_05 			:= project(Files_Raw_Input.Register_BusiAgent_05(filedate), trf_05rec(left));
																	
      // Rec-06
			export RegAgent_PersonalName_06_rec := Record
					string2   RegAgent_rec_code;
					string10  RegAgent_filing_number;
					string50  RegAgent_address1;
					string50  RegAgent_address2;
					string64  RegAgent_city;
					string4   RegAgent_state;
					string9   RegAgent_zip;
					string6   RegAgent_zip_extension;
					string64  RegAgent_country;
					string8   RegAgent_inactive_date;
					string50  Agent_last_name;
					string50  Agent_first_name;
					string50  Agent_middle_name;
					string6   Agent_suffix;
					string137 RegAgent_filler;
			end;
																	
			RegAgent_PersonalName_06_rec  trf_06rec(Layouts_Raw_Input.master l) := transform
					self.RegAgent_rec_code           := l.blob[1..2];	
					self.RegAgent_filing_number      := l.blob[3..12];	
					self.RegAgent_address1           := l.blob[13..62];	
					self.RegAgent_address2           := l.blob[63..112];	
					self.RegAgent_city               := l.blob[113..176];	
					self.RegAgent_state              := l.blob[177..180];	
					self.RegAgent_zip                := l.blob[181..189];	
					self.RegAgent_zip_extension      := l.blob[190..195];	
					self.RegAgent_country            := l.blob[196..259];
					self.RegAgent_inactive_date      := l.blob[260..267];
					self.agent_last_name    		 := l.blob[268..317];
					self.agent_first_name   		 := l.blob[318..367];
					self.agent_middle_name  		 := l.blob[368..417];
					self.agent_suffix        		 := l.blob[418..423];
					self.RegAgent_filler             := l.blob[424..560];		
			end;
											
			RegAgent_PersonalName_06_File 	:= project(Files_Raw_Input.RegAgent_PersonalName_06(filedate), trf_06rec(left));
			
			// Rec-07			
			export charter_BusinessOffi_07_rec := Record
					string2   BusinessOffi_rec_code;
					string10  BusinessOffi_filing_number;
					string50  BusinessOffi_address1;
					string50  BusinessOffi_address2;
					string64  BusinessOffi_city;
					string4   BusinessOffi_state;
					string9   BusinessOffi_zip;
					string6   BusinessOffi_zip_extension;
					string64  BusinessOffi_country;
					string6   BusinessOffi_officer_id;
					string32  BusinessOffi_officer_title;
					string150 BusinessOffi_business_name;
					string113 BusinessOffi_filler;
			end;
																	
			charter_BusinessOffi_07_rec trf_07rec(Layouts_Raw_Input.master l) := transform
					self.BusinessOffi_rec_code           := l.blob[1..2];	
					self.BusinessOffi_filing_number      := l.blob[3..12];	
					self.BusinessOffi_address1           := l.blob[13..62];	
					self.BusinessOffi_address2           := l.blob[63..112];	
					self.BusinessOffi_city               := l.blob[113..176];	
					self.BusinessOffi_state              := l.blob[177..180];	
					self.BusinessOffi_zip                := l.blob[181..189];	
					self.BusinessOffi_zip_extension      := l.blob[190..195];	
					self.BusinessOffi_country            := l.blob[196..259];
					self.BusinessOffi_officer_id         := l.blob[260..265];
					self.BusinessOffi_officer_title      := l.blob[266..297];
					self.BusinessOffi_business_name      := l.blob[298..447];
					self.BusinessOffi_filler             := l.blob[448..560];		
			end;
			
			charter_BusinessOffi_07_File 	:= project(Files_Raw_Input.charter_BusinessOffi_07(filedate) ,trf_07rec(left));
			
			// Rec-08
			export CharterOffi_PersonalNm_08_rec :=Record
					string2   rec_code;
					string10  filing_number;
					string50  address1;
					string50  address2;
					string64  city;
					string4   state;
					string9   zip;
					string6   zip_extension;
					string64  country;
					string6   officer_id;
					string32  officer_title;
					string50  last_name;
					string50  first_name;
					string50  middle_name;
					string6   suffix;
					string107 filler;
			end;
			
			CharterOffi_PersonalNm_08_rec trf_08rec(Layouts_Raw_Input.master l) := transform
					self.rec_code           := l.blob[1..2];	
					self.filing_number      := l.blob[3..12];	
					self.address1           := l.blob[13..62];	
					self.address2           := l.blob[63..112];	
					self.city               := l.blob[113..176];	
					self.state              := l.blob[177..180];	
					self.zip                := l.blob[181..189];	
					self.zip_extension      := l.blob[190..195];	
					self.country            := l.blob[196..259];
					self.officer_id         := l.blob[260..265];
					self.officer_title      := l.blob[266..297];
					self.last_name    		:= l.blob[298..347];
					self.first_name   		:= l.blob[348..397];
					self.middle_name  		:= l.blob[398..447];
					self.suffix       		:= l.blob[448..453];
					self.filler             := l.blob[454..560];		
			end;
											
			CharterOffi_PersonalNm_08_File 	:= project(Files_Raw_Input.CharterOffi_PersonalNm_08(filedate), trf_08rec(left));
			
		  // Rec-09
			export CharterNames_09_rec :=Record
					string2   rec_code;
					string10  filing_number;
					string6   name_id;
					string150 name;
					string3   name_status_id;
					string3   name_type_id;
					string8   creation_date;
					string8   inactive_date;
					string8   expire_date;
					string8   county_type;
					string11  consent_filing_number;
					string254 selected_county_array;
					string5   reserved;
					string84  filler;
			end;
	
			CharterNames_09_rec trf_09rec(Layouts_Raw_Input.master l) := transform
					self.rec_code               := l.blob[1..2];
					self.filing_number          := l.blob[3..12];
					self.name_id           		:= l.blob[13..18];
					self.name           	    := l.blob[19..168];
					self.name_status_id         := l.blob[169..171];
					self.name_type_id           := l.blob[172..174];
					self.creation_date          := l.blob[175..182];
					self.inactive_date          := l.blob[183..190];
					self.expire_date            := l.blob[191..198];
					self.county_type           	:= l.blob[199..206];
					self.consent_filing_number  := l.blob[207..217];
					self.selected_county_array  := l.blob[218..471];
					self.reserved           	:= l.blob[472..476];
					self.filler           		:= l.blob[477..560];		
			end;
											
		  CharterNames_09_File 			:= project(Files_Raw_Input.CharterNames_09(filedate), trf_09rec(left));
			
			// Rec-10
			export AssociatedEntity_10_rec :=Record
					string2   rec_code;
					string10  filing_number;
					string6   associated_entity_id;
					string150 associated_entity_name;
					string12  entity_filing_number;
					string8   entity_filing_date;
					string64  jurisdiction_country;
					string4   jurisdiction_state;
					string8   inactive_date;
					string4   capacity_id;
					string292 filler;
			end;
				
			AssociatedEntity_10_rec trf_10rec(Layouts_Raw_Input.master l) := transform
					self.rec_code           		:= l.blob[1..2];	
					self.filing_number 				:= l.blob[3..12];
					self.associated_entity_id 		:= l.blob[13..18];
					self.associated_entity_name 	:= l.blob[19..168];
					self.entity_filing_number 		:= l.blob[169..180];
					self.entity_filing_date 	    := l.blob[181..188];
					self.jurisdiction_country 		:= l.blob[189..252];
					self.jurisdiction_state 		:= l.blob[253..256];
					self.inactive_date 				:= l.blob[257..264];
					self.capacity_id 				:= l.blob[265..268];
					self.filler 					:= l.blob[269..560];		
			end;
				
			AssociatedEntity_10_File 		:= project(Files_Raw_Input.AssociatedEntity_10(filedate), trf_10rec(left));
			
			// Rec-11
			export FilingHistory_11_rec :=Record
					string2   rec_code;
					string10  filing_number;
					string12  document_no;
					string12  filing_type_id;
					string96  filing_type;
					string8   entry_date;
					string8   filing_date;
					string8   effective_date;
					string2   effective_cond_flag;
					string8   inactive_date;
					string394 filler;
			end;
					
			FilingHistory_11_rec trf_11rec(Layouts_Raw_Input.master l) := transform
					self.rec_code             := l.blob[1..2];
					self.filing_number        := l.blob[3..12];
					self.document_no          := l.blob[13..24];
					self.filing_type_id       := l.blob[25..36];
					self.filing_type		  := l.blob[37..132];
					self.entry_date			  := l.blob[133..140];
					self.filing_date		  := l.blob[141..148];
					self.effective_date		  := l.blob[149..156];
					self.effective_cond_flag  := l.blob[157..158];
					self.inactive_date		  := l.blob[159..166];
					self.filler				  := l.blob[167..560];
			end;
												
			FilingHistory_11_File 			:= project(Files_Raw_Input.FilingHistory_11(filedate), trf_11rec(left));
			
			// Rec-12
			export AuditLog_12_rec :=Record
					string2   rec_code;
					string10  filing_number;
					string8   audit_date;
					string4   table_id;
					string4   field_id;
					string10  action;
					string300 current_value;
					string222 audit_comment; 
			end;
			
			AuditLog_12_rec trf_12rec(Layouts_Raw_Input.master l) := transform
					self.rec_code       := l.blob[1..2];
					self.filing_number  := l.blob[3..12];
					self.audit_date		:= l.blob[13..20];
					self.table_id		:= l.blob[21..24];
					self.field_id		:= l.blob[25..28];
					self.action			:= l.blob[29..38];
					self.current_value	:= l.blob[39..338];
					self.audit_comment	:= l.blob[339..560];
			end;
		
		  AuditLog_12_File 				:= project(Files_Raw_Input.AuditLog_12(filedate), trf_12rec(left));
		  
			//**************************** Code Tables *******************************************************
			//**** Non Profit Subtype code table ****
			NonProfitSubtypeLayout := record,MAXLENGTH(100)
					string Code;
					string desc;
			end;  
				 
			NonProfitSubtypeTable := dataset('~thor_data400::lookup::corp2::nonprofitsubtype::tx', NonProfitSubtypeLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));

      //**** officer title code table ****
			offi_titleLayout := record,MAXLENGTH(100)
					string Code;
					string desc;
			end;  
	 
			offi_titleTable := dataset('~thor_data400::lookup::corp2::mem_part_offi_title::tx', offi_titleLayout, CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));

      //**** Forgine State description code table ****
			ForgnStateDescLayout := record,MAXLENGTH(100)
					string code;
					string desc;
			end; 

			ForgnStateTable:= dataset('~thor_data400::lookup::corp2::corpstateprovince_table', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
			
			//**** County code table ****
			County_Layout := record, MAXLENGTH(100)
					string Code;
					string desc;
			end;
			
			countyTable := dataset('~thor_data400::lookup::corp2::county::tx', County_Layout, CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
      //**************************** End of Code tables **************************************************

			//*** Join files for pre-corp mappings *************
			Master_02_Addr03 := RECORD
					Master_Addr_03_rec;
					Master_02_rec;
			end;

			Master_02_Addr03_Add05 := RECORD
					Master_02_Addr03;
					Register_BusiAgent_05_rec;
			end;

			charter_BusinessOffi_07_02_rec := RECORD
					Master_02_rec;
					charter_BusinessOffi_07_rec;
			end;

			CharterOffi_PersonalNm_08_02_rec := RECORD
					Master_02_rec;
					CharterOffi_PersonalNm_08_rec;
			end;
			
			
			Master_02_Addr03 Master_Addr03(Master_02_rec l, Master_Addr_03_rec r) := transform
					self 					:= l;
					self					:= r;
					self          := [];
			end; // end transform 
					
			joinMaster_Addr03 := join(Master_02_File, Master_Addr_03_File, 
																trim(left.filing_number_02,left,right) = trim(right.filing_number_03,left,right),
																Master_Addr03(left,right),
																left outer
															 );  

			Master_02_Addr03_Add05 Master_Addr03_Add05(Master_02_Addr03 l, Register_BusiAgent_05_rec r) := transform
					self 					:= l;
					self					:= r;
					self          := [];
			end; // end transform 
					
			joinMaster_Addr03_Add05 := join(joinMaster_Addr03, Register_BusiAgent_05, 
																			trim(left.filing_number_02,left,right) = trim(right.BusiAgent_filing_number,left,right),
																			Master_Addr03_Add05(left,right),
																			left outer
																		 );
			//************** County logic Begin ********************************************************
			// Logic to get the multiple counties from the selected county array.
			CharterNames_09_extended := record
					CharterNames_09_rec;
					string3   County_Cnt  := '';
					string300 County_Name := '';
			end;

			CharterNames_09_extended  trfToExtended(CharterNames_09_File l) := transform
					self := l;
			end;

			CharterNames_09_File_ext := project(CharterNames_09_File, trfToExtended(left));

			Layout_CharterNames_09_Norm :=  record
					CharterNames_09_rec;
					string3 County_code;
					string3 County_cnt;
			end;

			Layout_CharterNames_09_Norm normForCounty(CharterNames_09_File l, integer c) := transform, 
																                skip (l.selected_county_array[c] <> '1')
					self             := l;
					self.county_code := intformat(c,3,0);
					self.county_cnt  := (string)Stringlib.StringFindCount(l.selected_county_array, '1');
			end;

			Norm_CharterNames_09_file :=  normalize(CharterNames_09_File(stringlib.StringToUppercase(trim(county_type)) = 'LIST'), 254, normForCounty(left, counter));
			
			CharterNames_09_extended getCountyName(Norm_CharterNames_09_file l, countyTable r) := transform
					self := l;
					self.County_Name := stringlib.StringToUppercase(trim(r.desc,left,right));		
			end;

			// Join to explode the County description values for a given county codes.
			Norm_CharterNames_09_file_ext := join(Norm_CharterNames_09_file, countyTable, (integer)left.county_code = (integer)right.code,
																            getCountyName(left,right), lookup, left outer);

			CharterNames_09_extended denormCountyNames(CharterNames_09_File_ext l, Norm_CharterNames_09_file_ext r, integer c) := transform
					self.County_Name := if (c = 1, trim(r.county_name,left,right), trim(l.county_name,left,right)+ ';' +trim(r.County_Name,left,right));
					self.County_Cnt  := trim(r.County_Cnt);
					self := l;
			end;

			denorm_CharterNames_09_ext := denormalize(CharterNames_09_File_ext(stringlib.StringToUppercase(trim(county_type)) = 'LIST'), Norm_CharterNames_09_file_ext, 
																                left.filing_number = right.filing_number and 
																                left.name_id = right.name_id, 
																                denormCountyNames(left,right,counter));
			
			CharterNames_09_County_Ext := CharterNames_09_File_ext(stringlib.StringToUppercase(trim(county_type)) <> 'LIST') + denorm_CharterNames_09_ext;
			
			//************** County logic end ********************************************************
			//********************************* Start of Pre-CORP mappings *************************************************
			// Tansform businesses to Corps
			corp2_mapping.Layout_CorpPreClean tx_corpTransform_Business(Master_02_Addr03_Add05 input) := transform
					self.dt_first_seen					   := fileDate;
					self.dt_last_seen					   := fileDate;
					self.dt_vendor_first_reported		   := fileDate;
					self.dt_vendor_last_reported		   := fileDate;
					self.corp_ra_dt_first_seen			   := fileDate;
					self.corp_ra_dt_last_seen			   := fileDate;
					self.corp_key					       := '48-'+trim(input.filing_number_02, left, right);
					self.corp_vendor					   := '48';
					self.corp_state_origin             	   := 'TX';
					self.corp_process_date				   := fileDate;    
					self.corp_orig_sos_charter_nbr     	   := trim(input.filing_number_02, left, right);
					self.corp_ln_name_type_cd              := '01';
					self.corp_ln_name_type_desc            := 'LEGAL';
					self.corp_legal_name                   := if(input.name<>'',trimUpper(input.name),'');
					self.corp_status_cd                    := trim(input.status_id, left, right);
					self.corp_status_desc                  := map(trim(input.status_id,left,right)='01'=>'IN EXISTENCE',
					                                                 trim(input.status_id,left,right)='02'=>'REPORT DUE',
																	 trim(input.status_id,left,right)='03'=>'RA NOTICE SENT',
																	 trim(input.status_id,left,right)='04'=>'FORFEITED RIGHTS',
																	 trim(input.status_id,left,right)='05'=>'DELINQUENT',
																	 trim(input.status_id,left,right)='06'=>'FORFEITED EXISTENCE',
																	 trim(input.status_id,left,right)='07'=>'VOLUNTARILY DISSOLVED',
																	 trim(input.status_id,left,right)='08'=>'INVOLUNTARILY DISSOLVED',
																	 trim(input.status_id,left,right)='09'=>'JUDICIALLY DISSOLVED',
																	 trim(input.status_id,left,right)='10'=>'REVOKED',
																	 trim(input.status_id,left,right)='11'=>'EXPIRED',
																	 trim(input.status_id,left,right)='12'=>'WITHDRAWN',
																	 trim(input.status_id,left,right)='13'=>'MERGED',
																	 trim(input.status_id,left,right)='14'=>'CONVERTED',
																	 trim(input.status_id,left,right)='15'=>'CONSOLIDATED',
																	 trim(input.status_id,left,right)='16'=>'CANCELLED',
																	 trim(input.status_id,left,right)='17'=>'TERMINATED',
																	 trim(input.status_id,left,right)='18'=>'LAW REPEALED',
																	 trim(input.status_id,left,right)='19'=>'STRICKEN',
																	 trim(input.status_id,left,right)='20'=>'DELETED',
													         if(_validate.date.fIsValid(trim(input.inactive_date,left,right)) and 
															 _validate.date.fIsValid(trim(input.inactive_date,left,right),_validate.date.rules.DateInPast),
														       'INACTIVE', ''));
													
					self.corp_status_date              := if(trim(self.corp_status_desc) = 'INACTIVE', 
																									 trim(input.inactive_date,left,right),'');													

					integer duration                   := (integer)trim(input.perpetual_flag,left,right);
					self.corp_term_exist_cd            := if(duration = 0 and trim(input.expiration_type,left,right) <> '','N',
																									 if(duration = 1,'P',
																							        if(trim(input.perpetual_flag) = '' and trim(input.expiration_type,left,right) <> '','N',
																							           if((integer)input.expiration_date <> 0 and 
																								            _validate.date.fIsValid(trim(input.expiration_date,left,right)),'D',''))));  
					self.corp_term_exist_exp           := if(duration = 0 and trim(input.expiration_type,left,right) <> '','N',
																							     if(duration = 1,'P',
																									    if(trim(input.perpetual_flag) = '' and trim(input.expiration_type,left,right) <> '','N',
																							           if((integer)input.expiration_date <> 0 and 
																								            _validate.date.fIsValid(trim(input.expiration_date,left,right)),trim(input.expiration_date,left,right),''))));  
					self.corp_term_exist_desc          := if(duration = 0 and trim(input.expiration_type,left,right) <> '',trim(input.expiration_type,left,right),
																							     if(duration = 1,'PERPETUAL',
																									    if(trim(input.perpetual_flag) = '' and trim(input.expiration_type,left,right) <> '',trim(input.expiration_type,left,right),
																							           if((integer)input.expiration_date <> 0 and 
																								            _validate.date.fIsValid(trim(input.expiration_date,left,right)),'EXPIRATION DATE',''))));

					self.corp_inc_date                 := if(_validate.date.fIsValid(trim(input.creation_date,left,right)) and 
																								   _validate.date.fIsValid(trim(input.creation_date,left,right),_validate.date.rules.DateInPast),
																									 trim(input.creation_date,left,right),''); 
													
					self.corp_state_tax_id             := if(trim(input.tax_id) <> '' and (integer)(input.tax_id) <> 0, trim(input.tax_id,left,right), ''); 
					
					self.corp_forgn_fed_tax_id         := if(length(trim(input.foreign_fein,left,right)) > 2, trim(input.foreign_fein,left,right)[1..2] + '-' + trim(input.foreign_fein,left,right)[3..],'');

					self.corp_addl_info                := if(_validate.date.fIsValid(trim(input.inactive_date,left,right)) and 
																									 _validate.date.fIsValid(trim(input.inactive_date,left,right),_validate.date.rules.DateInPast),
																									 'INACTIVE DATE:'+trim(input.inactive_date,left,right), '');
																									 
					self.corp_forgn_date               := if(_validate.date.fIsValid(trim(input.foreign_formation_date,left,right)) and 
																									 _validate.date.fIsValid(trim(input.foreign_formation_date,left,right),_validate.date.rules.DateInPast),
																									 trim(input.foreign_formation_date,left,right),'');
													
					self.corp_inc_state                := if(trimUpper(input.foreign_state) = 'TX', 'TX', '');

					self.corp_forgn_state_cd           := if(trimUpper(input.foreign_state) not in ['','TX'] and trimUpper(input.foreign_country) <> 'USA', 
					                                         trimUpper(input.foreign_state) + ',' + trimUpper(input.foreign_country),
																							     if(trimUpper(input.foreign_state) not in ['','TX'] and trimUpper(input.foreign_country) = 'USA',
																									    trimUpper(input.foreign_state),''));
					self.corp_orig_bus_type_cd         := if(trim(input.nonprofit_subtype_id) <> '' and (integer)input.nonprofit_subtype_id <> 0, trim(input.nonprofit_subtype_id,left,right),'');
					self.corp_orig_org_structure_cd    := trim(input.corp_type_id ,left,right);
					self.corp_orig_org_structure_desc  := map(trim(input.corp_type_id ,left,right)='01'=>'DOMESTIC FOR-PROFIT CORPORATION',			
														trim(input.corp_type_id ,left,right)='02'=>'FOREIGN FOR-PROFIT CORPORATION',				
														trim(input.corp_type_id ,left,right)='03'=>'DOMESTIC PROFESSIONAL CORPORATION',			
														trim(input.corp_type_id ,left,right)='04'=>'FOREIGN PROFESSIONAL CORPORATION',			
														trim(input.corp_type_id ,left,right)='05'=>'PROFESSIONAL ASSOCIATION',				
														trim(input.corp_type_id ,left,right)='06'=>'DOMESTIC LIMITED LIABILITY COMPANY (LLC)',		
														trim(input.corp_type_id ,left,right)='07'=>'FOREIGN LIMITED LIABILITY COMPANY (LLC)',		
														trim(input.corp_type_id ,left,right)='08'=>'DOMESTIC NONPROFIT CORPORATION',			
														trim(input.corp_type_id ,left,right)='09'=>'FOREIGN NONPROFIT CORPORATION',			
														trim(input.corp_type_id ,left,right)='10'=>'DOMESTIC LIMITED PARTNERSHIP (LP)',			
														trim(input.corp_type_id ,left,right)='11'=>'FOREIGN LIMITED PARTNERSHIP (LP)',			
														trim(input.corp_type_id ,left,right)='12'=>'DOMESTIC LIMITED LIABILITY PARTNERSHIP (LLP)',	
														trim(input.corp_type_id ,left,right)='13'=>'FOREIGN LIMITED LIABILITY PARTNERSHIP (LLP)',		
														trim(input.corp_type_id ,left,right)='14'=>'UNINCORPORATED NONPROFIT ASSOCIATION',		
														trim(input.corp_type_id ,left,right)='15'=>'DEFENSE-BASE DEVELOPMENT AUTHORITY',		
														trim(input.corp_type_id ,left,right)='16'=>'TEXAS STATE FINANCIAL INSTITUTION',			
														trim(input.corp_type_id ,left,right)='17'=>'FOREIGN CORPORATE FIDUCIARY',				
														trim(input.corp_type_id ,left,right)='18'=>'GENERAL PARTNERSHIP MERGED WITH OTHER ENTITY',	
														trim(input.corp_type_id ,left,right)='19'=>'NON-EXISTENT LIMITED PARTNERSHIP DISCLAIMER',	
														trim(input.corp_type_id ,left,right)='20'=>'RE-1999 FOREIGN OR OUT-OF-STATE BANK OR FOREIGN FINANCIAL INSTITUTION',
														trim(input.corp_type_id ,left,right)='21'=>'TRUST CORPORATION',					
														trim(input.corp_type_id ,left,right)='22'=>'ASSUMED NAME ENTITY	',				
														trim(input.corp_type_id ,left,right)='23'=>'FOREIGN FINANCIAL INSTITUTION',
														trim(input.corp_type_id ,left,right)='24'=>'FOREIGN BUSINESS TRUST',
														trim(input.corp_type_id ,left,right)='25'=>'FOREIGN REAL ESTATE INVESTMENT TRUST',
														trim(input.corp_type_id ,left,right)='26'=>'OTHER FOREIGN ENTITY',
														trim(input.corp_type_id ,left,right)='27'=>'FOREIGN PROFESSIONAL ASSOCIATION',			
														trim(input.corp_type_id ,left,right)='99'=>'OTHER ENTITY',''); 

					self.corp_filing_date              := if(_validate.date.fIsValid(input.formation_date) and 
																									 _validate.date.fIsValid(input.formation_date,_validate.date.rules.DateInPast),
																									 trim(input.formation_date,left,right),'');
												 
					self.corp_filing_cd                := if(_validate.date.fIsValid(input.creation_date) and 
																									 _validate.date.fIsValid(input.creation_date,_validate.date.rules.DateInPast),
																									 'C','');
					self.corp_filing_desc              := if(trim(self.corp_filing_cd) = 'C', 'CREATION','');
													
					self.corp_address1_line1           := if(trim(input.address1) <> '',trimUpper(input.address1),'');

					self.corp_address1_line2           := if(trim(input.address2) <> '',trimUpper(input.address2),'');

					self.corp_address1_line3           := if(trim(input.city) <> '',trimUpper(input.city),'');

					self.corp_address1_line4           := if(trim(input.state) <> '',trimUpper(input.state),'');

					self.corp_address1_line5           := if((integer)input.zip <> 0 and trim(input.zip,left,right) <> '',trim(input.zip,left,right),'')+
																							  if((integer)input.zip_extension <> 0 and trim(input.zip_extension,left,right) <> '',trim(input.zip_extension,left,right),'');
												
					self.corp_address1_line6           := if(input.country <>'' and trimUpper(input.country )<>'USA' ,trimUpper(input.country ),'');

					self.corp_address1_type_cd         := if(trim(input.address1,left,right) <> '' or trim(input.address2,left,right) <> '' or trim(input.city,left,right) <> '' or
																									 trim(input.state,left,right) <> '' or trim(input.zip,left,right) <> '','B','');
													 
					self.corp_address1_type_desc       := if(trim(self.corp_address1_type_cd) = 'B','BUSINESS ADDRESS','');

					self.corp_ra_name                  := if(trim(input.BusiAgent_business_name) <> '',trimUpper(input.BusiAgent_business_name),'');
																								
					self.corp_ra_resign_date           := if(_validate.date.fIsValid(input.BusiAgent_inactive_date) and 
																									 _validate.date.fIsValid(input.BusiAgent_inactive_date,_validate.date.rules.DateInPast),
																									 trim(input.BusiAgent_inactive_date,left,right),''); 
					self.corp_ra_address_line1         := if(trim(input.BusiAgent_address1) <> '',trimUpper(input.BusiAgent_address1),'');

					self.corp_ra_address_line2         := if(trim(input.BusiAgent_address2) <> '',trimUpper(input.BusiAgent_address2),'');

					self.corp_ra_address_line3         := if(trim(input.BusiAgent_city) <> '',trimUpper(input.BusiAgent_city),'');

					self.corp_ra_address_line4         := if(trim(input.BusiAgent_state) <> '',trimUpper(input.BusiAgent_state),'');

					self.corp_ra_address_line5         := if((integer)input.BusiAgent_zip <> 0 and trim(input.BusiAgent_zip,left,right) <> '',trim(input.BusiAgent_zip,left,right),'') +
																							  if((integer)input.BusiAgent_zip_extension <> 0 and trim(input.BusiAgent_zip_extension,left,right) <> '',trim(input.BusiAgent_zip_extension,left,right),'');
					self                               := [];
			end; // end transform.
			
			MapPreCorp1 		:= project(joinMaster_Addr03_Add05, tx_corpTransform_Business(left));
			
			// Transform fictitious names for corps
			corp2_mapping.Layout_CorpPreClean tx_corpTransform_Fictitious(CharterNames_09_County_Ext input):=transform
					self.dt_first_seen			   := fileDate;
					self.dt_last_seen			   := fileDate;
					self.dt_vendor_first_reported  := fileDate;
					self.dt_vendor_last_reported   := fileDate;
					self.corp_ra_dt_first_seen	   := fileDate;
					self.corp_ra_dt_last_seen	   := fileDate;
					self.corp_key				   := '48-'+trim(input.filing_number, left, right);
					self.corp_vendor			   := '48';
					self.corp_state_origin         := 'TX';
					self.corp_process_date		   := fileDate;    
					self.corp_orig_sos_charter_nbr := trim(input.filing_number, left, right);
					self.corp_status_cd            := trim(input.name_status_id, left, right);
					self.corp_status_desc          := map(trim(input.name_status_id,left,right)='001'=>'IN USE',
													trim(input.name_status_id,left,right)='002'=>'PRIOR',
													trim(input.name_status_id,left,right)='003'=>'INACTIVE',
													trim(input.name_status_id,left,right)='004'=>'RESERVED',
													trim(input.name_status_id,left,right)='005'=>'REGISTERED',
													trim(input.name_status_id,left,right)='006'=>'EXPIRED',
													trim(input.name_status_id,left,right)='007'=>'WITHDRAWN',
													trim(input.name_status_id,left,right)='008'=>'TERMINATED',
													trim(input.name_status_id,left,right)='009'=>'REVOKED',
													trim(input.name_status_id,left,right)='010'=>'USED',
													trim(input.name_status_id,left,right)='011'=>'ACTIVE',
													trim(input.name_status_id,left,right)='012'=>'EXPIRED',
													trim(input.name_status_id,left,right)='013'=>'ABANDONED',
													trim(input.name_status_id,left,right)='014'=>'ENTITY INACTIVE',
													trim(input.name_status_id,left,right)='015'=>'ENTITY DELETED',
													trim(input.name_status_id,left,right)='016'=>'STRICKEN',
													trim(input.name_status_id,left,right)='017'=>'PEND. FOR REVIEW',
													trim(input.name_status_id,left,right)='018'=>'LOCKED','');
													
					self.corp_ln_name_type_cd      := map(trim(input.name_type_id, left, right)='001'=>'01',
																								trim(input.name_type_id, left, right)='002'=>'02',
																								trim(input.name_type_id, left, right)='003'=>'06',''); 
													 
					self.corp_ln_name_type_desc    := map(trim(input.name_type_id, left, right)='001'=>'LEGAL',
																								trim(input.name_type_id, left, right)='002'=>'FICTITIOUS',
																								trim(input.name_type_id, left, right)='003'=>'ASSUMED','');

					self.corp_legal_name           := if(trim(input.name) <> '',trimUpper(input.name),'');
					self.corp_term_exist_cd        := if(trim(input.expire_date,left,right) <> '' and (integer)input.expire_date <> 0 and _validate.date.fIsValid(input.expire_date),'D','');
					self.corp_term_exist_exp       := if(trim(input.expire_date,left,right) <> '' and (integer)input.expire_date <> 0 and _validate.date.fIsValid(input.expire_date),trim(input.expire_date,left,right),'');
					self.corp_term_exist_desc      := if(trim(input.expire_date,left,right) <> '' and (integer)input.expire_date <> 0 and _validate.date.fIsValid(input.expire_date),'EXPIRATION DATE','');
					self.corp_filing_date          := if(_validate.date.fIsValid(trim(input.creation_date,left,right)) and 
																							 _validate.date.fIsValid(trim(input.creation_date,left,right),_validate.date.rules.DateInPast),
																							 trim(input.creation_date,left,right), '');
					self.corp_filing_cd            := if(_validate.date.fIsValid(input.creation_date) and 
																							 _validate.date.fIsValid(input.creation_date,_validate.date.rules.DateInPast),
																							 'C','');
					self.corp_filing_desc          := if(trim(self.corp_filing_cd) = 'C', 'CREATION','');
					self.corp_name_comment         := if(_validate.date.fIsValid(trim(input.inactive_date,left,right)) and 
																							 _validate.date.fIsValid(trim(input.inactive_date,left,right),_validate.date.rules.DateInPast),
																							 'DBA INACTIVE DATE: '+ trim(input.inactive_date,left,right),'');
					self.corp_addl_info            := if(trim(input.county_type) = '','',
					                                     if(trimUpper(input.county_type) = 'ALL','NAME REGISTERED IN ALL COUNTIES',
																							    if(trimUpper(input.county_type) = 'LIST' and (integer)input.county_cnt > 0,'REGISTERED COUNTIES: ' + trim(input.County_Name),
																									'')));
					self                           := [];
			end; // end transform.
			
			MapPreCorp2		:= project(CharterNames_09_County_Ext, tx_corpTransform_Fictitious(left));
			
			// Transform RA_Name's for corps
			corp2_mapping.Layout_CorpPreClean tx_corpTransform_ra_name(RegAgent_PersonalName_06_rec input) := transform,
			                                    skip(trim(input.agent_first_name,left,right) + 
																					     trim(input.agent_middle_name,left,right) +
																							 trim(input.agent_last_name,left,right) +
																							 trim(input.agent_suffix,left,right) = '')
					self.dt_first_seen				:= fileDate;
					self.dt_last_seen				:= fileDate;
					self.dt_vendor_first_reported	:= fileDate;
					self.dt_vendor_last_reported	:= fileDate;
					self.corp_ra_dt_first_seen		:= fileDate;
					self.corp_ra_dt_last_seen		:= fileDate;
					self.corp_key					:= '48-'+trim(input.RegAgent_filing_number, left, right);
					self.corp_vendor				:= '48';
					self.corp_state_origin          := 'TX';
					self.corp_process_date			:= fileDate;    
					self.corp_orig_sos_charter_nbr  := trim(input.RegAgent_filing_number, left, right);
					self.corp_ln_name_type_cd       := '01';
					self.corp_ln_name_type_desc     := 'LEGAL';

					first_name                  	:= if(trim(input.agent_first_name) <> '', trimUpper(trim(input.agent_first_name,left,right)),'');
					middle_name              		:= if(trim(input.agent_middle_name) <> '', trimUpper(trim(input.agent_middle_name,left,right)),'');
					last_name              			:= if(trim(input.agent_last_name) <> '', trimUpper(trim(input.agent_last_name,left,right)),'');
					suffix              			:= if(trim(input.agent_suffix) <> '', trimUpper(trim(input.agent_suffix,left,right)),'');

					self.corp_ra_name              	:= first_name + ' ' + middle_name + ' ' + last_name + ' ' + suffix;
																									
					self.corp_ra_resign_date       	:= if(_validate.date.fIsValid(input.RegAgent_inactive_date) and 
																							 _validate.date.fIsValid(input.RegAgent_inactive_date,_validate.date.rules.DateInPast),
																							 trim(input.RegAgent_inactive_date,left,right),'');
					self.corp_ra_address_line1      := if(trim(input.RegAgent_address1) <> '',trimUpper(input.RegAgent_address1),'');

					self.corp_ra_address_line2      := if(trim(input.RegAgent_address2) <> '',trimUpper(input.RegAgent_address2),'');

					self.corp_ra_address_line3      := if(trim(input.RegAgent_city) <> '',trimUpper(input.RegAgent_city),'');

					self.corp_ra_address_line4      := if(trim(input.RegAgent_state) <> '',trimUpper(input.RegAgent_state),'');

					self.corp_ra_address_line5      := if((integer)input.RegAgent_zip <> 0 and trim(input.RegAgent_zip,left,right) <> '',trim(input.RegAgent_zip,left,right),'')+
																						 if((integer)input.RegAgent_zip_extension <> 0 and trim(input.RegAgent_zip_extension,left,right) <> '',trim(input.RegAgent_zip_extension,left,right),'');
					self                            := [];		
			end; // end transform.
			
			MapPreCorp3  	:= project(RegAgent_PersonalName_06_File, tx_corpTransform_ra_name(left));
			
			// Transform merger's for Corps
			corp2_mapping.Layout_CorpPreClean tx_corpTransform_merger(AssociatedEntity_10_rec input):=transform
					self.dt_first_seen				:= fileDate;
					self.dt_last_seen				:= fileDate;
					self.dt_vendor_first_reported	:= fileDate;
					self.dt_vendor_last_reported	:= fileDate;
					self.corp_ra_dt_first_seen		:= fileDate;
					self.corp_ra_dt_last_seen		:= fileDate;
					self.corp_key					:= '48-'+trim(input.filing_number, left, right);
					self.corp_vendor				:= '48';
					self.corp_state_origin          := 'TX';
					self.corp_process_date			:= fileDate;    
					self.corp_orig_sos_charter_nbr  := trim(input.filing_number, left, right);
					self.corp_legal_name            := if(trim(input.associated_entity_name) <> '',trimUpper(input.associated_entity_name),'');
					self.corp_ln_name_type_cd       := trim(input.capacity_id, left, right);
					self.corp_ln_name_type_desc     := map(trim(input.capacity_id,left,right)='0001'=>'SURVIVOR',
														 trim(input.capacity_id,left,right)='0002'=>'NON-SURVIVOR',
														 trim(input.capacity_id,left,right)='0003'=>'RESULTING ENTITY',
														 trim(input.capacity_id,left,right)='0004'=>'CONVERTING',
														 trim(input.capacity_id,left,right)='0005'=>'CONVERTED',
														 trim(input.capacity_id,left,right)='0006'=>'ACQUIRING',
														 trim(input.capacity_id,left,right)='0007'=>'ACQUIRED',
																								 '');
					self.corp_forgn_state_cd        := if(trimUpper(input.jurisdiction_state) not in ['','TX'] and trimUpper(input.jurisdiction_country) <> 'USA',
					                                      trimUpper(input.jurisdiction_state)+','+trimUpper(input.jurisdiction_country),
																						    if(trimUpper(input.jurisdiction_state) not in ['','TX'] and trimUpper(input.jurisdiction_country) = 'USA',
																								   trimUpper(input.jurisdiction_state),''));

					self.corp_status_date           := if(_validate.date.fIsValid(trim(input.inactive_date,left,right)) and 
																							  _validate.date.fIsValid(trim(input.inactive_date,left,right), _validate.date.rules.DateInPast),
																							  trim(input.inactive_date,left,right),'');
														
					self.corp_status_desc           := if(_validate.date.fIsValid(trim(input.inactive_date,left,right)) and 
																							  _validate.date.fIsValid(trim(input.inactive_date,left,right), _validate.date.rules.DateInPast),
																							  'INACTIVE',''); 
														
					self.corp_filing_reference_nbr  := trim(input.entity_filing_number, left, right);

					self.corp_filing_date           := if(_validate.date.fIsValid(trim(input.entity_filing_date,left,right)) and 
																							  _validate.date.fIsValid(trim(input.entity_filing_date,left,right), _validate.date.rules.DateInPast), 
																							  trim(input.entity_filing_date,left,right),'');										
					self                            := [];		
			end; // end transform.
			
			MapPreCorp4 		:= project(AssociatedEntity_10_File, tx_corpTransform_merger(left));
			//********************************* End of pre-CORP mappings ******************************************************
			
			//********** ExplosionTable lookups **********
			 corp2_mapping.Layout_CorpPreClean  NonProfit(corp2_mapping.Layout_CorpPreClean input, NonProfitSubtypeLayout r) := transform
					self.corp_orig_bus_type_desc  := trimUpper(r.desc);
					self         			    		    := input;
					self                       		:= [];			
			 end; // end transform
			 
			//NonProfit join
			join_NonProfit := join(MapPreCorp1, NonProfitSubtypeTable,
														 trim(left.corp_orig_bus_type_cd,left,right) = trim(right.code,left,right),
														 NonProfit(left,right),
														 left outer, lookup
			                      );
														
			corp2_mapping.Layout_CorpPreClean getState(corp2_mapping.Layout_CorpPreClean l, ForgnStateDescLayout r) := transform
					self.corp_forgn_state_desc  := trimUpper(r.desc);
					self         			          := l;
					self                        := [];
			end; // end transform
							
			//StateCode join
			joinStateType := join(join_NonProfit, ForgnStateTable,
															trim(left.corp_forgn_state_cd,left,right) = trim(right.code,left,right),
															getState(left,right),
															left outer, lookup
														);
			
			corp2_mapping.Layout_CorpPreClean getForgnState(corp2_mapping.Layout_CorpPreClean l, ForgnStateDescLayout r ) := transform
					self.corp_forgn_state_desc  := trimUpper(r.desc);
					self         			          := l;
					self                        := [];
			end; // end transform
			
				
			//StateCode join
			joinStateType1 := join(MapPreCorp3, ForgnStateTable,
														 trim(left.corp_forgn_state_cd,left,right) = trim(right.code,left,right),
														 getForgnState(left,right),
														 left outer, lookup
														);
						
			MapPreCorp       := joinStateType + MapPreCorp2 + joinStateType1 + MapPreCorp4;
			
			//************************* Start of CORP mapping *************************************************
			corp2.layout_corporate_direct_corp_in CleanCorpNameAddr(corp2_mapping.Layout_CorpPreClean  input) := transform

					string73 tempname 			    := if(trim(input.corp_ra_name) = '', '', Address.CleanPersonFML73(trim(input.corp_ra_name,left,right)));
					
					string182 clean_address 		:= if(trim(input.corp_ra_address_line1) <> '' or
														trim(input.corp_ra_address_line2,left,right) <> '' or
														trim(input.corp_ra_address_line3,left,right) <> '' or
														trim(input.corp_ra_address_line4,left,right) <> '' or
														trim(input.corp_ra_address_line5,left,right) <> '',
														Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' + 														                        
																																				 trim(input.corp_ra_address_line2,left,right),left,right),														                   
																																		trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
																																				 trim(input.corp_ra_address_line4,left,right) + ' ' +
																																				 trim(input.corp_ra_address_line5,left,right),left,right)),
																						'');

					string182 clean_address1 		:= if(trim(input.corp_address1_line1) <> '' or
														trim(input.corp_address1_line2,left,right) <> '' or
														trim(input.corp_address1_line3,left,right) <> '' or
														trim(input.corp_address1_line4,left,right) <> '' or
														trim(input.corp_address1_line5,left,right) <> '',
														Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' + 														                        
																																				 trim(input.corp_address1_line2,left,right),left,right),														                   
																																		trim(trim(input.corp_address1_line3,left,right) + ', ' +
																																				 trim(input.corp_address1_line4,left,right) + ' ' +
																																				 trim(input.corp_address1_line5,left,right),left,right)),
																						'');
					
					pname 								:= Address.CleanNameFields(tempName);
					cname 								:= DataLib.companyclean(trim(input.corp_ra_name,left,right));
					keepPerson 							:= corp2.Rewrite_Common.IsPerson(trim(input.corp_ra_name,left,right));
					keepBusiness 						:= corp2.Rewrite_Common.IsCompany(trim(input.corp_ra_name,left,right));

					self.corp_ra_title1					:= if(keepPerson, pname.title, '');
					self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
					self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
					self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
					self.corp_ra_name_suffix1 	        := if(keepPerson, pname.name_suffix,'');
					self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');

					self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
					self.corp_ra_cname1_score 	        := if(keepBusiness, pname.name_score,'');	

					self.corp_ra_prim_range    	        := clean_address[1..10];
					self.corp_ra_predir 	            := clean_address[11..12];
					self.corp_ra_prim_name 	  	        := clean_address[13..40];
					self.corp_ra_addr_suffix   	        := clean_address[41..44];
					self.corp_ra_postdir 	    	    := clean_address[45..46];
					self.corp_ra_unit_desig 	        := clean_address[47..56];
					self.corp_ra_sec_range 	  	        := clean_address[57..64];
					self.corp_ra_p_city_name	        := clean_address[65..89];
					self.corp_ra_v_city_name	        := clean_address[90..114];
					self.corp_ra_state 			        := clean_address[115..116];
					self.corp_ra_zip5 		            := clean_address[117..121];
					self.corp_ra_zip4 		            := clean_address[122..125];
					self.corp_ra_cart 		            := clean_address[126..129];
					self.corp_ra_cr_sort_sz 	 	    := clean_address[130];
					self.corp_ra_lot 		      	    := clean_address[131..134];
					self.corp_ra_lot_order 	  	        := clean_address[135];
					self.corp_ra_dpbc 		            := clean_address[136..137];
					self.corp_ra_chk_digit 	  	        := clean_address[138];
					self.corp_ra_rec_type		  	    := clean_address[139..140];
					self.corp_ra_ace_fips_st	        := clean_address[141..142];
					self.corp_ra_county 	  		    := clean_address[143..145];
					self.corp_ra_geo_lat 	    	    := clean_address[146..155];
					self.corp_ra_geo_long 	            := clean_address[156..166];
					self.corp_ra_msa 		      	    := clean_address[167..170];
					self.corp_ra_geo_blk				:= clean_address[171..177];
					self.corp_ra_geo_match 	  	        := clean_address[178];
					self.corp_ra_err_stat 	            := clean_address[179..182];
					
					self.corp_addr1_prim_range  		:= clean_address1[1..10];
					self.corp_addr1_predir 	    		:= clean_address1[11..12];
					self.corp_addr1_prim_name 			:= clean_address1[13..40];
					self.corp_addr1_addr_suffix 		:= clean_address1[41..44];
					self.corp_addr1_postdir 	  		:= clean_address1[45..46];
					self.corp_addr1_unit_desig 			:= clean_address1[47..56];
					self.corp_addr1_sec_range 			:= clean_address1[57..64];
					self.corp_addr1_p_city_name			:= clean_address1[65..89];
					self.corp_addr1_v_city_name			:= clean_address1[90..114];
					self.corp_addr1_state 				:= clean_address1[115..116];
					self.corp_addr1_zip5 		    	:= clean_address1[117..121];
					self.corp_addr1_zip4 		    	:= clean_address1[122..125];
					self.corp_addr1_cart 		    	:= clean_address1[126..129];
					self.corp_addr1_cr_sort_sz 			:= clean_address1[130];
					self.corp_addr1_lot 		    	:= clean_address1[131..134];
					self.corp_addr1_lot_order 			:= clean_address1[135];
					self.corp_addr1_dpbc 		    	:= clean_address1[136..137];
					self.corp_addr1_chk_digit 			:= clean_address1[138];
					self.corp_addr1_rec_type			:= clean_address1[139..140];
					self.corp_addr1_ace_fips_st			:= clean_address1[141..142];
					self.corp_addr1_county 	  			:= clean_address1[143..145];
					self.corp_addr1_geo_lat 	  		:= clean_address1[146..155];
					self.corp_addr1_geo_long 	  		:= clean_address1[156..166];
					self.corp_addr1_msa 		    	:= clean_address1[167..170];
					self.corp_addr1_geo_blk				:= clean_address1[171..177];
					self.corp_addr1_geo_match 			:= clean_address1[178];
					self.corp_addr1_err_stat 	  		:= clean_address1[179..182];
					self								:= input;
					self								:= [];
			end; //*********************cleaned corp routine ends********
			
			cleanCorps 		:= project(MapPreCorp, CleanCorpNameAddr(left));
			//********************************* End of CORP mappings *******************************************

			//********************************* Start of pre-CONT mappings ****************************************************
			charter_BusinessOffi_07_02_rec Master_BusinessOffi(Master_02_rec  l ,charter_BusinessOffi_07_rec  r ) := transform
					self 					:= l;
					self					:= r;
					self          := [];			
			end; // end transform 
					
			joinMaster_BusinessOffi := join(Master_02_File, charter_BusinessOffi_07_File, 
																			trim(left.filing_number_02,left,right) = trim(right.BusinessOffi_filing_number,left,right),
																			Master_BusinessOffi(left,right),
																			left outer
																		 );

//			sortOfficers1		:= sort(joinMaster_BusinessOffi, BusinessOffi_filing_number, BusinessOffi_business_name, BusinessOffi_officer_title);			
			distOfficers1		:= distribute(joinMaster_BusinessOffi, random());

			NewContOfficers1	:= record
					charter_BusinessOffi_07_02_rec ;
					string Title1;
					string Title2;
					string Title3;
					string Title4;
					string Title5;
					string Title6;
					string Title7;
					string Title8;
					string Title9;
					string Title10;
			end;

			NewContOfficers1 newTransform1(charter_BusinessOffi_07_02_rec l, offi_titleLayout r) := transform
					self.BusinessOffi_officer_title  := if(trim(r.desc) <> '', trimUpper(r.desc), trim(l.BusinessOffi_officer_title));
					self         			    		       := l;
					self                             := [];		
			end; // end transform

			newOfficerFile1		:= join(distOfficers1, offi_titleTable,
																trim(left.BusinessOffi_officer_title,left,right) = trim(right.code,left,right),
																newTransform1(left,right),
																left outer, lookup); 
										
			dedupNewOfficerFile1 := dedup(newOfficerFile1, BusinessOffi_filing_number, BusinessOffi_business_name, BusinessOffi_officer_title, all);	

			NewContOfficers1 DenormOfficers1(NewContOfficers1 L, NewContOfficers1 R, integer C) := transform		
					self.Title1 	:= if(C=1, R.BusinessOffi_officer_title, L.TITLE1);                  
					self.title2		:= if(C=2, R.BusinessOffi_officer_title, L.TITLE2);
					self.title3		:= if(C=3, R.BusinessOffi_officer_title, L.TITLE3); 
					self.title4		:= if(C=4, R.BusinessOffi_officer_title, L.TITLE4); 
					self.title5		:= if(C=5, R.BusinessOffi_officer_title, L.TITLE5); 
					self.title6		:= if(C=6, R.BusinessOffi_officer_title, L.TITLE6); 
					self.title7		:= if(C=7, R.BusinessOffi_officer_title, L.TITLE7); 
					self.title8		:= if(C=8, R.BusinessOffi_officer_title, L.TITLE8); 
					self.title9		:= if(C=9, R.BusinessOffi_officer_title, L.TITLE9); 
					self.title10	:= if(C=10,R.BusinessOffi_officer_title, L.TITLE10); 			
					self 			    := L;						
			end;
										
			DenormalizedcontFile1 	:= denormalize(dedupNewOfficerFile1, dedupNewOfficerFile1,
																			            trim(left.BusinessOffi_filing_number,left,right) = trim(right.BusinessOffi_filing_number,left,right) and
																			            trim(left.BusinessOffi_business_name,left,right) = trim(right.BusinessOffi_business_name,left,right),
																			            DenormOfficers1(left,right,COUNTER));																			
			DedupDenormalizedcont1 := dedup(DenormalizedcontFile1, record, all);
			
			
			// Pre clean Contacts TRANSFORM-1
			corp2_mapping.Layout_ContPreClean tx_contact1Transform(NewContOfficers1 input) := transform,
			                                   skip(trim(input.BusinessOffi_filing_number) = '')
				self.dt_first_seen			     := fileDate;
				self.dt_last_seen			     := fileDate;
				self.corp_key					 := '48-'+trim(input.BusinessOffi_filing_number, left, right);
				self.corp_vendor				 := '48';
				self.corp_state_origin			 := 'TX';
				self.corp_process_date			 := fileDate;
				self.corp_legal_name             := if(trim(input.name) <> '',trimUpper(input.name),'');
				self.corp_orig_sos_charter_nbr   := trim(input.BusinessOffi_filing_number  , left, right);
				self.cont_name                   := if(trim(input.BusinessOffi_business_name) <> '',trimUpper(input.BusinessOffi_business_name),'');
				allTitles							 					 := trimUpper(input.Title1) + ';' + 
																						trimUpper(input.Title2) + ';' +  
																						trimUpper(input.Title3) + ';' + 
																						trimUpper(input.Title4) + ';' + 
																						trimUpper(input.Title5) + ';' + 
																						trimUpper(input.Title6) + ';' + 
																						trimUpper(input.Title7) + ';' + 
																						trimUpper(input.Title8) + ';' + 
																						trimUpper(input.Title9) + ';' + 
																						trimUpper(input.Title10);
								
				work1							 := regexreplace('[;]*$',allTitles,'',NOCASE);
				work2							 := regexreplace('^[;]*',work1,'',NOCASE);
				self.cont_title1_desc            := regexreplace('[;]+',work2,';',NOCASE);
				self.cont_address_line1          := if(trim(input.BusinessOffi_address1) <>'',trimUpper(input.BusinessOffi_address1),'');

				self.cont_address_line2          := if(trim(input.BusinessOffi_address2) <>'',trimUpper(input.BusinessOffi_address2),'');

				self.cont_address_line3          := if(trim(input.BusinessOffi_city) <> '',trimUpper(input.BusinessOffi_city),'');

				self.cont_address_line4          := if(trim(input.BusinessOffi_state) <> '',trimUpper(input.BusinessOffi_state),'');

				self.cont_address_line5          := if((integer)input.BusinessOffi_zip <> 0 and trim(input.BusinessOffi_zip ,left,right)<>'',trim(input.BusinessOffi_zip ,left,right),'')+
																					  if((integer)input.BusinessOffi_zip_extension <> 0 and trim(input.BusinessOffi_zip_extension,left,right)<>'',trim(input.BusinessOffi_zip_extension,left,right),'');
											
				self.cont_address_line6          := if(trimUpper(input.BusinessOffi_country ) not in ['','USA'], trimUpper(input.BusinessOffi_country ),'');            
				self                             := [];			
			end; // end of tx_contact_transform     
			
			MapCont1 		:= project(DedupDenormalizedcont1, tx_contact1Transform(left));
			
			
			CharterOffi_PersonalNm_08_02_rec Master_CharterOffi(Master_02_rec  l, CharterOffi_PersonalNm_08_rec  r ) := transform
					self 					:= l;
					self					:= r;
					self          := [];
			end; // end transform 
					
			joinMaster_CharterOffi := join(Master_02_File, CharterOffi_PersonalNm_08_File, 
																		 trim(left.filing_number_02,left,right) = trim(right.filing_number,left,right),
																		 Master_CharterOffi(left,right),
																		 left outer
																		);	  

//			sortOfficers		:= sort(joinMaster_CharterOffi, filing_number,first_name, middle_name, last_name,suffix, officer_title);			
			distofficers		:= distribute(joinMaster_CharterOffi, random());

			NewContOfficers	:= record
					CharterOffi_PersonalNm_08_02_rec ;
					string Title1;
					string Title2;
					string Title3;
					string Title4;
					string Title5;
					string Title6;
					string Title7;
					string Title8;
					string Title9;
					string Title10;					
			end;
		
			NewContOfficers newTransform(CharterOffi_PersonalNm_08_02_rec l, offi_titleLayout r) := transform
					self.officer_title    := if(trim(r.desc) <> '', trimUpper(r.desc), l.officer_title);
					self         			    := l;
					self                  := [];		
			end; // end transform

			newOfficerFile		:= join(distofficers, offi_titleTable,
																trim(left.officer_title,left,right) = trim(right.code,left,right),
																newTransform(left,right),
																left outer, lookup); 
										
			dedupNewOfficerFile := dedup(newOfficerFile,filing_number,first_name,
																				middle_name,last_name,suffix,all);	
			
			NewContOfficers DenormOfficers(NewContOfficers L, NewContOfficers R, integer C) := transform		
					self.Title1 	:= if(C=1, R.officer_title, L.TITLE1);                  
					self.title2		:= if(C=2, R.officer_title, L.TITLE2);
					self.title3		:= if(C=3, R.officer_title, L.TITLE3); 
					self.title4		:= if(C=4, R.officer_title, L.TITLE4); 
					self.title5		:= if(C=5, R.officer_title, L.TITLE5); 
					self.title6		:= if(C=6, R.officer_title, L.TITLE6); 
					self.title7		:= if(C=7, R.officer_title, L.TITLE7); 
					self.title8		:= if(C=8, R.officer_title, L.TITLE8); 
					self.title9		:= if(C=9, R.officer_title, L.TITLE9); 
					self.title10	:= if(C=10,R.officer_title, L.TITLE10); 			
					self 			    := L;						
			end;
										
			DenormalizedcontFile 	:= denormalize(dedupNewOfficerFile,dedupNewOfficerFile,
																								trim(left.filing_number,left,right) = trim(right.filing_number,left,right) and
																								trim(left.first_name,left,right) = trim(right.first_name,left,right) and
																								trim(left.middle_name,left,right) = trim(right.middle_name,left,right) and
																								trim(left.last_name,left,right) = trim(right.last_name,left,right) and
																								trim(left.suffix,left,right) = trim(right.suffix,left,right) , 
																								DenormOfficers(left,right,COUNTER));																		
			DedupDenormalizedcont := dedup(DenormalizedcontFile, record,all);
					
			
			// Pre clean Contacts TRANSFORM-2
			corp2_mapping.Layout_ContPreClean tx_contact2Transform(NewContOfficers input) := transform,
			                                   skip(trim(input.filing_number) = '')
					self.dt_first_seen			      := fileDate;
					self.dt_last_seen			      := fileDate;
					self.corp_key					  := '48-'+trim(input.filing_number, left, right);
					self.corp_vendor				  := '48';
					self.corp_state_origin			  := 'TX';
					self.corp_process_date			  := fileDate;
					self.corp_orig_sos_charter_nbr    := trim(input.filing_number, left, right);
					self.corp_legal_name           	  := if(trim(input.name) <> '',trimUpper(input.name),'');
					first_name                  	  := if(trim(input.first_name) <> '', trimUpper(input.first_name),'');
					middle_name              		  := if(trim(input.middle_name) <> '',trimUpper(input.middle_name),'');
					last_name              			  := if(trim(input.last_name) <> '',trimUpper(input.last_name),'');
					suffix              			  := if(trim(input.suffix) <> '',trimUpper(input.suffix),'');
					self.cont_name                    := first_name + ' ' + middle_name + ' ' + last_name + ' ' + suffix;
					allTitles						  := trimUpper(input.Title1) + ';' + 
														 trimUpper(input.Title2) + ';' +  
														 trimUpper(input.Title3) + ';' + 
														 trimUpper(input.Title4) + ';' + 
														 trimUpper(input.Title5) + ';' + 
														 trimUpper(input.Title6) + ';' + 
														 trimUpper(input.Title7) + ';' + 
														 trimUpper(input.Title8) + ';' + 
														 trimUpper(input.Title9) + ';' + 
														 trimUpper(input.Title10);
							
					work1						   := regexreplace('[;]*$',allTitles,'',NOCASE);
					work2						   := regexreplace('^[;]*',work1,'',NOCASE);
					self.cont_title1_desc          := regexreplace('[;]+',work2,';',NOCASE);
					self.cont_address_line1        := if(trim(input.address1) <> '',trimUpper(input.address1),'');

					self.cont_address_line2        := if(trim(input.address2) <> '',trimUpper(input.address2),'');

					self.cont_address_line3        := if(trim(input.city) <> '',trimUpper(input.city),'');

					self.cont_address_line4        := if(trim(input.state) <> '',trimUpper(input.state),'');

					self.cont_address_line5        := if((integer)input.zip <> 0 and trim(input.zip ,left,right)<>'',trim(input.zip ,left,right),'')+
																						if((integer)input.zip_extension <> 0 and trim(input.zip_extension,left,right)<>'',trim(input.zip_extension,left,right),'');
												
					self.cont_address_line6        := if(trim(input.country) <> '' and trimUpper(input.country ) <> 'USA', trimUpper(input.country ),'');
					self                           := [];
			end; // end of tx_contact_transform     
			
			MapCont2 		:= project(DedupDenormalizedcont, tx_contact2Transform(left));
			
			MapCont     := MapCont1 + MapCont2 ;
			//********************************* End of pre-CONT mappings ****************************************************
			
			//************************** Start of Cont mappings *************************************************************
			Corp2.Layout_Corporate_Direct_Cont_In CleanContNameAddr(corp2_mapping.Layout_ContPreClean input) := transform
					// cleaning name
					string73 tempname 		  := if (trim(input.cont_name) = '', '', Address.CleanPersonFML73(trim(input.cont_name,left,right)));

					string182 clean_address   := if(trim(input.cont_address_line1) <> '' or
																				trim(input.cont_address_line2,left,right) <> '' or
																				trim(input.cont_address_line3,left,right) <> '' or
																				trim(input.cont_address_line4,left,right) <> '' or
																				trim(input.cont_address_line5,left,right) <> '',
																				Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' + 														                        
																																		 trim(input.cont_address_line2,left,right),left,right),														                   
																																trim(trim(input.cont_address_line3,left,right) + ', ' +
																																		 trim(input.cont_address_line4,left,right) + ' ' +
																																		 trim(input.cont_address_line5,left,right),left,right)),
																					'');

					pname 							:= Address.CleanNameFields(tempName);
					cname 							:= DataLib.companyclean(input.cont_name);
					keepPerson 						:= Corp2.Rewrite_Common.IsPerson(input.cont_name);
					keepBusiness 					:= Corp2.Rewrite_Common.IsCompany(input.cont_name);

					self.cont_title1				:= if(keepPerson, pname.title, '');
					self.cont_fname1 				:= if(keepPerson, pname.fname, '');
					self.cont_mname1 				:= if(keepPerson, pname.mname, '');
					self.cont_lname1 				:= if(keepPerson, pname.lname, '');
					self.cont_name_suffix1 	        := if(keepPerson, pname.name_suffix,'');
					self.cont_score1 				:= if(keepPerson, pname.name_score, '');

					self.cont_cname1 				:= if(keepBusiness, cname[1..70],'');
					self.cont_cname1_score 	        := if(keepBusiness, pname.name_score,'');	

					self.cont_prim_range            := clean_address[1..10];
					self.cont_predir 	            := clean_address[11..12];
					self.cont_prim_name 	        := clean_address[13..40];
					self.cont_addr_suffix           := clean_address[41..44];
					self.cont_postdir 	    		:= clean_address[45..46];
					self.cont_unit_desig 	  		:= clean_address[47..56];
					self.cont_sec_range 	  		:= clean_address[57..64];
					self.cont_p_city_name	  		:= clean_address[65..89];
					self.cont_v_city_name	  		:= clean_address[90..114];
					self.cont_state 			  	:= clean_address[115..116];
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
			
			cleanCont 	:= project(MapCont, CleanContNameAddr(left));
			//************************Cont cleaning ends*************************************

			
			//********************************* Start of EVENT mappings *************************************************
			// Event_TRANSFORM M.R.
			Corp2.Layout_Corporate_Direct_Event_In tx_event1Transform(FilingHistory_11_rec input) := transform
					self.corp_key					     := '48-'+trim(input.filing_number, left, right);
					self.corp_vendor				     := '48';
					self.corp_state_origin			     := 'TX';
					self.corp_process_date			     := fileDate;
					self.corp_sos_charter_nbr		     := trim(input.filing_number, left, right);
					self. event_filing_reference_nbr := if(trim(input.document_no) <> '',trim(input.document_no,left, right),'');

					self.event_filing_date           := if(_validate.date.fIsValid(trim(input.filing_date,left,right)) and 
																								 _validate.date.fIsValid(trim(input.filing_date,left,right),_validate.date.rules.DateInPast),
																								 trim(input.filing_date,left,right),'');

					self.event_filing_desc           := if(trim(input.filing_type) <> '',trimUpper(input.filing_type),'');
					self                             := [];
			end; // end of tx_Event_transform M.R.
			
			MapEvent1 	:= project(FilingHistory_11_File, tx_event1Transform(left));
			
			 
			// Event_TRANSFORM M.R.
			Corp2.Layout_Corporate_Direct_Event_In tx_event2Transform(CharterNames_09_rec input) := transform,
																					 skip(trim(input.consent_filing_number) = '')
					self.corp_key					 := '48-'+trim(input.filing_number, left, right);
					self.corp_vendor				 := '48';
					self.corp_state_origin			 := 'TX';
					self.corp_process_date			 := fileDate;
					self.corp_sos_charter_nbr		 := trim(input.filing_number, left, right);
					self.event_filing_reference_nbr  := if(trim(input.consent_filing_number) <> '',trim(input.consent_filing_number,left,right),'');
					self.event_filing_desc           := if(trim(input.consent_filing_number) <> '','CONSENT TO USE NAME','');
					self.event_filing_date           := if(_validate.date.fIsValid(trim(input.inactive_date,left,right)) and 
																								 _validate.date.fIsValid(trim(input.inactive_date,left,right),_validate.date.rules.DateInPast),
																								 trim(input.inactive_date,left,right),'');
					self                             := [];
			end; // end of tx_Event_transform M.R.
			 
			MapEvent2 	:= project(CharterNames_09_File, tx_event2Transform(left));
			
			
			// Event_TRANSFORM M.R.
			Corp2.Layout_Corporate_Direct_Event_In tx_event3Transform(AssociatedEntity_10_rec input) := transform,
			                                    skip (trim(input.entity_filing_number) = '' and (integer)input.entity_filing_date = 0)  
					self.corp_key					    := '48-'+trim(input.filing_number, left, right);
					self.corp_vendor				    := '48';
					self.corp_state_origin			    := 'TX';
					self.corp_process_date			    := fileDate;
					self.corp_sos_charter_nbr		    := trim(input.filing_number, left, right);
					self.event_filing_reference_nbr     := if(trim(input.entity_filing_number) <> '',trim(input.entity_filing_number,left, right),'');

					self.event_filing_date              := if(_validate.date.fIsValid(trim(input.entity_filing_date,left,right)) and 
																								_validate.date.fIsValid(trim(input.entity_filing_date,left,right),_validate.date.rules.DateInPast),
																								trim(input.entity_filing_date,left,right),'');

					self.event_filing_desc              := if(trim(input.entity_filing_number) <> '' and trim(input.entity_filing_date) <> '',
																								map(trim(input.capacity_id,left,right)='0001'=>'MERGER',
																										trim(input.capacity_id,left,right)='0002'=>'MERGER',
																										trim(input.capacity_id,left,right)='0003'=>'MERGER',
																										trim(input.capacity_id,left,right)='0004'=>'CONVERSION',
																										trim(input.capacity_id,left,right)='0005'=>'CONVERSION',
																										trim(input.capacity_id,left,right)='0006'=>'ACQUISITION',
																										trim(input.capacity_id,left,right)='0007'=>'ACQUISITION',
																										''),
																								'');
					self                                := [];
			end; // end of tx_Event_transform M.R.
			
			MapEvent3 	:= project(AssociatedEntity_10_File, tx_event3Transform(left));

			MapEvent    := MapEvent1 + Mapevent2 + MapEvent3;
			//********************************* End of EVENT mappings ************************************************
			
			//********************************* Start of Annual Report mappings *******************************************
			// AR_TRANSFORM M.R.
			Corp2.Layout_Corporate_Direct_AR_In tx_arTransform(Master_02_rec input) := transform,
			                                    skip(trim(input.report_due_date) = '' or (integer)input.report_due_date = 0)
					self.corp_key					:= '48-'+trim(input.filing_number_02, left, right);
					self.corp_vendor				:= '48';
					self.corp_state_origin			:= 'TX';
					self.corp_process_date			:= fileDate;
					self.corp_sos_charter_nbr		:= trim(input.filing_number_02, left, right);
					self.ar_due_dt                  := if(_validate.date.fIsValid(trim(input.report_due_date,left,right)),
																						trim(input.report_due_date,left,right),''); 						 
					self                            := [];
			end; // end of tx_AR_transform M.R.
			
			MapAR 			:= project(Master_02_File, tx_arTransform(left));
			//********************************* End of Annual Report mappings *******************************************
					
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_tx'	,cleanCorps									,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_tx'	,dedup(MapEvent,record,all) ,event_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_tx'		,MapAR											,ar_out			,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_tx'	,cleanCont									,cont_out		,,,pOverwrite);

	mappedtx_Filing := 
	parallel(
		 corp_out	
		,event_out
		,ar_out		
		,cont_out	
	);        

		                                                                                                                                                      
		result := 
		sequential(
			if(pshouldspray = true,fSprayFiles('tx',filedate,pOverwrite := pOverwrite))
			,mappedtx_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp','~thor_data400::in::corp2::'+version+'::corp_tx'	)				  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont','~thor_data400::in::corp2::'+version+'::cont_tx'	)
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar','~thor_data400::in::corp2::'+version+'::ar_tx'		)
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event','~thor_data400::in::corp2::'+version+'::event_tx')
			)
		);
				  
    return result;

    end; //Update Function end	   
 end;  // end of tx module	