IMPORT Autokey_batch, BatchServices,SexOffender_Services, LN_PropertyV2_Services, FFD;

EXPORT transforms := MODULE

	EXPORT Autokey_batch.Layouts.rec_inBatchMaster xfm_capitalize_input(Autokey_batch.Layouts.rec_inBatchMaster l) :=
		TRANSFORM
			SELF.name_first  := StringLib.StringToUpperCase(l.name_first);
			SELF.name_middle := StringLib.StringToUpperCase(l.name_middle);
			SELF.name_last   := StringLib.StringToUpperCase(l.name_last);
			SELF.name_suffix := StringLib.StringToUpperCase(l.name_suffix);	
			
			SELF.comp_name   := StringLib.StringToUpperCase(l.comp_name);

			SELF.prim_range  := StringLib.StringToUpperCase(l.prim_range);	
			SELF.predir      := StringLib.StringToUpperCase(l.predir);	
			SELF.prim_name   := StringLib.StringToUpperCase(l.prim_name);	
			SELF.addr_suffix := StringLib.StringToUpperCase(l.addr_suffix);	
			SELF.postdir     := StringLib.StringToUpperCase(l.postdir);	
			SELF.unit_desig  := StringLib.StringToUpperCase(l.unit_desig);	
			SELF.sec_range   := StringLib.StringToUpperCase(l.sec_range);	

			SELF.p_city_name := StringLib.StringToUpperCase(l.p_city_name);	
			SELF.st          := StringLib.StringToUpperCase(l.st);	
			
			SELF             := l;
		END;
		
	EXPORT BatchServices.Layouts.layout_batch_in_for_penalties xfm_prepend_underscore(Autokey_Batch.Layouts.rec_inBatchMaster l) := 
		TRANSFORM

			SELF._acctno      := l.acctno;
											
			SELF._name_first  := l.name_first;
			SELF._name_middle := l.name_middle;
			SELF._name_last   := l.name_last;
			SELF._name_suffix := l.name_suffix;
											
			SELF._prim_range  := l.prim_range;
			SELF._predir      := l.predir;
			SELF._prim_name   := l.prim_name;
			SELF._addr_suffix := l.addr_suffix;
			SELF._postdir     := l.postdir;
			SELF._unit_desig  := l.unit_desig;
			SELF._sec_range   := l.sec_range;
			SELF._p_city_name := l.p_city_name;
			SELF._st          := l.st;
			SELF._z5          := l.z5;
			SELF._zip4        := l.zip4;
											
			SELF._ssn         := l.ssn;
			SELF._dob         := l.dob;
			SELF._homephone   := l.homephone;
			SELF._workphone   := l.workphone;
										
		END;
			
	EXPORT LN_Property := MODULE

		EXPORT BatchServices.Layouts.LN_Property.rec_input_and_matchcodes 
		       xfm_add_matchcodes(LN_PropertyV2_Services.layouts.batch_in l, 
					                    BatchServices.Layouts.LN_Property.rec_acctnos_fids r) := 
			TRANSFORM
				SELF.acctno                      := l.acctno;
				SELF.name_first                  := l.name_first;
				SELF.name_middle                 := l.name_middle;
				SELF.name_last                   := l.name_last;
				SELF.name_suffix                 := l.name_suffix;
				SELF._prim_range                 := l.prim_range;
				SELF._predir                     := l.predir;
				SELF._prim_name                  := l.prim_name;
				SELF._addr_suffix                := l.addr_suffix;
				SELF._postdir                    := l.postdir;
				SELF._unit_desig                 := l.unit_desig;
				SELF._sec_range                  := l.sec_range;
				SELF._p_city_name                := l.p_city_name;
				SELF._st                         := l.st;
				SELF._z5                         := l.z5;
				SELF._zip4                       := l.zip4;		
				SELF.ln_fares_id                 := r.ln_fares_id;
				SELF.assess_prop_addr_match_code := '';
				SELF.assess_mail_addr_match_code := '';
				SELF.assess_ownr_addr_match_code := '';
				SELF.deed_prop_addr_match_code   := '';
				SELF.deed_buyr_addr_match_code   := '';
				SELF.deed_sell_addr_match_code   := '';			
			END;
		
	END;
	
	EXPORT SexOffenderCPS := MODULE

		EXPORT SexOffender_Services.Layouts.batch_out_pre xfm_slim_offenders(SexOffender_Services.Layouts.rec_offender_plus_acctno l) := 
			TRANSFORM
				SELF.acctno          := l.acctno;
				SELF.last_name       := l.lname;
				SELF.first_name      := l.fname;
				SELF.middle_name     := l.mname;
				SELF.name_suffix     := l.name_suffix;
				SELF.address_1       := l.registration_address_1;
				SELF.address_2       := l.registration_address_2;
				SELF.address_3       := l.registration_address_3;
				SELF.date_last_seen  := l.dt_last_reported;
				SELF.ssn             := IF( TRIM(l.ssn) != '', l.ssn, l.ssn_appended );
				SELF.sex             := l.sex;
				SELF.dob             := l.dob;
				SELF.hair_color      := l.hair_color;
				SELF.eye_color       := l.eye_color;
				SELF.scars           := l.scars_marks_tattoos;
				SELF.height          := l.height;
				SELF.weight          := l.weight;
				SELF.race            := l.race;
				SELF.offender_id     := IF( TRIM(l.offender_id) != '', l.offender_id, l.sor_number );
				SELF.state_of_origin := l.orig_state_code;
				
				//FCRA FFD
				offender_statements := PROJECT(L.StatementIds, 
		                        FFD.InitializeConsumerStatementBatch(LEFT, FFD.Constants.RecordType.RS, 'offender', FFD.Constants.DataGroups.SO_MAIN, 0, L.acctno));
      	offender_dispute    := IF(L.isDisputed, 
   	                        ROW(FFD.InitializeConsumerStatementBatch(FFD.Constants.BlankStatementid, FFD.Constants.RecordType.DR, 'offender', FFD.Constants.DataGroups.SO_MAIN, 0, L.acctno)));
				self.statements      := 	offender_statements + 	offender_dispute;								
				SELF                 := l;
				SELF                 := [];
			END;
		
		EXPORT SexOffender_Services.Layouts.layout_inBatchMaster_for_penalties xfm_prepend_underscore(SexOffender_Services.Layouts.batch_in l) := 
			TRANSFORM

				SELF.acctno      := l.acctno;
												
				SELF._name_first  := l.name_first;
				SELF._name_middle := l.name_middle;
				SELF._name_last   := l.name_last;
				SELF._name_suffix := l.name_suffix;
												
				SELF._prim_range  := l.prim_range;
				SELF._predir      := l.predir;
				SELF._prim_name   := l.prim_name;
				SELF._addr_suffix := l.addr_suffix;
				SELF._postdir     := l.postdir;
				SELF._unit_desig  := l.unit_desig;
				SELF._sec_range   := l.sec_range;
				SELF._p_city_name := l.p_city_name;
				SELF._st          := l.st;
				SELF._z5          := l.z5;
				SELF._zip4        := l.zip4;
												
				SELF._ssn         := l.ssn;
				SELF._dob         := l.dob;
											
			END;
			
	END;

END;