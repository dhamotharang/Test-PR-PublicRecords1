import ut, tools, Corp2_Raw_TX;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	EXPORT Input := MODULE
	
	// Input File Version
	// --------------------
		tools.mac_FilesInput(Corp2_Raw_TX.Filenames(pversion, pUseOtherEnvironment).Input.Corp, Corp2_Raw_TX.Layouts.RawLayoutIN,
		                     Corp, 'CSV',,pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '');	
		
		// Extract by record type into separate files
		EXPORT f02_raw := Corp.logical(blob[1..2] = '02');
		EXPORT f03_raw := Corp.logical(blob[1..2] = '03');	
		EXPORT f05_raw := Corp.logical(blob[1..2] = '05');	
		EXPORT f06_raw := Corp.logical(blob[1..2] = '06');
		EXPORT f07_raw := Corp.logical(blob[1..2] = '07');
		EXPORT f08_raw := Corp.logical(blob[1..2] = '08');	
		EXPORT f09_raw := Corp.logical(blob[1..2] = '09');	
		EXPORT f10_raw := Corp.logical(blob[1..2] = '10');	
		EXPORT f11_raw := Corp.logical(blob[1..2] = '11');	
		EXPORT f12_raw := Corp.logical(blob[1..2] = '12');
	  
	
		// Parse each record type into it's own layout
			
		// f02_Master  
		Corp2_Raw_TX.Layouts.Master_02_layout f02_fmt(Corp2_Raw_TX.Layouts.RawLayoutIN l) :=  transform
			self.rec_code                     := l.blob[1..2];	
			self.filing_number                := l.blob[3..12];
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
		
		EXPORT f02 := project(f02_raw, f02_fmt(left));

    // f03_Master_Addr	
		Corp2_Raw_TX.Layouts.MastAddr_03_layout f03_fmt(Corp2_Raw_TX.Layouts.RawLayoutIN l) :=  transform
			self.rec_code        							:= l.blob[1..2];	
			self.filing_number     						:= l.blob[3..12];	
			self.address1           					:= l.blob[13..62];	
			self.address2           					:= l.blob[63..112];	
			self.city               					:= l.blob[113..176];	
			self.state              					:= l.blob[177..180];	
			self.zip                					:= l.blob[181..189];	
			self.zip_extension      					:= l.blob[190..195];	
			self.country            					:= l.blob[196..259];	
			self.filler            						:= l.blob[260..560];		
		end;		
			
		EXPORT f03 := project(f03_raw, f03_fmt(left));
		
		// f05_Register_BusiAgent
		Corp2_Raw_TX.Layouts.RegBusAgent_05_layout f05_fmt(Corp2_Raw_TX.Layouts.RawLayoutIN l) :=  transform
			self.rec_code                     := l.blob[1..2];	
			self.filing_number                := l.blob[3..12];	
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
			
		EXPORT f05 := project(f05_raw, f05_fmt(left));
		
		// f06_RegAgent_PersonalName
		Corp2_Raw_TX.Layouts.RA_PersName_06_layout f06_fmt(Corp2_Raw_TX.Layouts.RawLayoutIN l) :=  transform
			self.rec_code                    := l.blob[1..2];	
			self.filing_number               := l.blob[3..12];	
			self.RegAgent_address1           := l.blob[13..62];	
			self.RegAgent_address2           := l.blob[63..112];	
			self.RegAgent_city               := l.blob[113..176];	
			self.RegAgent_state              := l.blob[177..180];	
			self.RegAgent_zip                := l.blob[181..189];	
			self.RegAgent_zip_extension      := l.blob[190..195];	
			self.RegAgent_country            := l.blob[196..259];
			self.RegAgent_inactive_date      := l.blob[260..267];
			self.agent_last_name    		     := l.blob[268..317];
			self.agent_first_name   		     := l.blob[318..367];
			self.agent_middle_name  		     := l.blob[368..417];
			self.agent_suffix        		     := l.blob[418..423];
			self.RegAgent_filler             := l.blob[424..560];		
		end;
			
		EXPORT f06 := project(f06_raw, f06_fmt(left));
		
		// f07_charter_BusinessOffi
		Corp2_Raw_TX.Layouts.Chart_BusOff_07_layout f07_fmt(Corp2_Raw_TX.Layouts.RawLayoutIN l) :=  transform
			self.rec_code           					:= l.blob[1..2];	
			self.filing_number                := l.blob[3..12];	
			self.BusinessOffi_address1        := l.blob[13..62];	
			self.BusinessOffi_address2        := l.blob[63..112];	
			self.BusinessOffi_city            := l.blob[113..176];	
			self.BusinessOffi_state           := l.blob[177..180];	
			self.BusinessOffi_zip             := l.blob[181..189];	
			self.BusinessOffi_zip_extension   := l.blob[190..195];	
			self.BusinessOffi_country         := l.blob[196..259];
			self.BusinessOffi_officer_id      := l.blob[260..265];
			self.BusinessOffi_officer_title   := l.blob[266..297];
			self.BusinessOffi_business_name   := l.blob[298..447];
			self.BusinessOffi_filler          := l.blob[448..560];		
		end;
		
		EXPORT f07 := project(f07_raw, f07_fmt(left));
		
		// f08_CharterOffi_PersonalNm	
		Corp2_Raw_TX.Layouts.ChartOff_Pers_08_layout f08_fmt(Corp2_Raw_TX.Layouts.RawLayoutIN l) :=  transform
			self.rec_code           					:= l.blob[1..2];	
			self.filing_number       					:= l.blob[3..12];	
			self.address1          					 	:= l.blob[13..62];	
			self.address2          					 	:= l.blob[63..112];	
			self.city              						:= l.blob[113..176];	
			self.state              					:= l.blob[177..180];	
			self.zip                					:= l.blob[181..189];	
			self.zip_extension      					:= l.blob[190..195];	
			self.country            					:= l.blob[196..259];
			self.officer_id         					:= l.blob[260..265];
			self.officer_title      					:= l.blob[266..297];
			self.last_name    								:= l.blob[298..347];
			self.first_name   								:= l.blob[348..397];
			self.middle_name  								:= l.blob[398..447];
			self.suffix       								:= l.blob[448..453];
			self.filler            						:= l.blob[454..560];		
		end;
		
		EXPORT f08 := project(f08_raw, f08_fmt(left));
		
		// f09_CharterNames	
		Corp2_Raw_TX.Layouts.CharterNames_09_layout f09_fmt(Corp2_Raw_TX.Layouts.RawLayoutIN l) :=  transform
			self.rec_code               			:= l.blob[1..2];
			self.filing_number         				:= l.blob[3..12];
			self.name_id           						:= l.blob[13..18];
			self.name           	    				:= l.blob[19..168];
			self.name_status_id         			:= l.blob[169..171];
			self.name_type_id           			:= l.blob[172..174];
			self.creation_date          			:= l.blob[175..182];
			self.inactive_date          			:= l.blob[183..190];
			self.expire_date            			:= l.blob[191..198];
			self.county_type           				:= l.blob[199..206];
			self.consent_filing_number  			:= l.blob[207..217];
			self.selected_county_array  			:= l.blob[218..471];
			self.reserved           					:= l.blob[472..476];
			self.filler           						:= l.blob[477..560];		
		end;
			
		EXPORT f09 := project(f09_raw, f09_fmt(left));
		
		// f10_AssociatedEntity	
		Corp2_Raw_TX.Layouts.AssocEnt_10_layout f10_fmt(Corp2_Raw_TX.Layouts.RawLayoutIN l) :=  transform
			self.rec_code           					:= l.blob[1..2];	
			self.filing_number				:= l.blob[3..12];
			self.associated_entity_id 				:= l.blob[13..18];
			self.associated_entity_name 			:= l.blob[19..168];
			self.entity_filing_number 				:= l.blob[169..180];
			self.entity_filing_date 	    		:= l.blob[181..188];
			self.jurisdiction_country 				:= l.blob[189..252];
			self.jurisdiction_state 					:= l.blob[253..256];
			self.inactive_date				:= l.blob[257..264];
			self.capacity_id 									:= l.blob[265..268];
			self.filler 											:= l.blob[269..560];		
		end;
		
		EXPORT f10 := project(f10_raw, f10_fmt(left));
		
		// f11_FilingHistory	
		Corp2_Raw_TX.Layouts.FilingHist_11_layout f11_fmt(Corp2_Raw_TX.Layouts.RawLayoutIN l) :=  transform
			self.rec_code             				:= l.blob[1..2];
			self.filing_number        				:= l.blob[3..12];
			self.document_no          				:= l.blob[13..26];
			self.filing_type_id       				:= l.blob[27..38];
			self.filing_type		  						:= l.blob[39..134];
			self.entry_date			  						:= l.blob[135..142];
			self.filing_date		  						:= l.blob[143..150];
			self.effective_date		  					:= l.blob[151..158];
			self.effective_cond_flag  				:= l.blob[159..160];
			self.inactive_date		  					:= l.blob[161..168];
			self.filler				  							:= l.blob[169..560];
		end;
		
		EXPORT f11 := project(f11_raw, f11_fmt(left));
		
		// This file is sent by the vendor, but is not currently being used by the mapper
		// f12_AuditLog
		Corp2_Raw_TX.Layouts.AuditLog_12_layout f12_fmt(Corp2_Raw_TX.Layouts.RawLayoutIN l) :=  transform
			self.rec_code       							:= l.blob[1..2];
			self.filing_number  							:= l.blob[3..12];
			self.audit_date										:= l.blob[13..20];
			self.table_id											:= l.blob[21..24];
			self.field_id											:= l.blob[25..28];
			self.action												:= l.blob[29..38];
			self.current_value								:= l.blob[39..338];
			self.audit_comment								:= l.blob[339..560];
		end;
		
		EXPORT f12 := project(f12_raw, f12_fmt(left));

  END;

END;

