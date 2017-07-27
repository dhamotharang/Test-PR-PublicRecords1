/*2010-11-01T14:56:58Z (gwhitaker)
C:\Documents and Settings\gwhitaker\Application Data\LexisNexis\querybuilder\gwhitaker\default\BatchServices\JailBooking_Functions\2010-11-01T14_56_58Z.ecl
*/
import doxie, appriss, autostandardi, address;
DOB_LABEL 				:= PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_DOB.full, opt);
SSN_LABEL 				:= PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_SSN.full, opt);
FULLNAME_LABEL 		:= PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt);
ADDRESS_LABEL 		:= PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, opt);

bk_key_fbi := Appriss.Key_FBI;
bk_key_state_id := Appriss.Key_State_id;
bk_key_dlnumber := Appriss.Key_dl;
out_layout := batchServices.Layouts.JailBooking.rec_acctnos_fids;

EXPORT JailBooking_Functions := module
	EXPORT out_layout getBookingsByFBINumber(DATASET(BatchServices.Layouts.JailBooking.layout_fbi_acct) FBI_Nums) :=
	  FUNCTION
		join_fbi_nbr  := join(FBI_Nums, bk_key_fbi,
	                      keyed(left.fbi_nbr=right.fbi_nbr),
		  									TRANSFORM(out_layout, self.booking_sid := RIGHT.booking_sid, 
												                      self.acctno := LEFT.acctno,
																							self.isDeepDive := FALSE),
			  								limit(batchServices.Constants.JailBooking.MAX_BOOKINGS, SKIP),
				  							INNER);
		RETURN join_fbi_nbr;
	END;
	EXPORT out_layout getBookingsByStateId(DATASET(BatchServices.Layouts.JailBooking.layout_state_id) state_ids) :=
	  FUNCTION
		join_stateId  := join(state_ids, bk_key_state_id,
	                      keyed(left.state_id=right.state_id),
		  									TRANSFORM(out_layout, self.booking_sid := RIGHT.booking_sid, 
												                      self.acctno := LEFT.acctno,
																							self.isDeepDive := FALSE),
			  								limit(batchServices.Constants.JailBooking.MAX_BOOKINGS, SKIP),
				  							INNER);
		RETURN join_stateId;
	END;
		EXPORT out_layout getBookingsByDLnumber(DATASET(BatchServices.Layouts.JailBooking.layout_DLnumber) dlnumbers) :=
	  FUNCTION
		join_dlnumber  := join(dlnumbers, bk_key_dlnumber,
	                      keyed(left.dlnumber=right.dlnumber),
		  									TRANSFORM(out_layout, self.booking_sid := RIGHT.booking_sid, 
												                      self.acctno := LEFT.acctno,
																							self.isDeepDive := FALSE),
			  								limit(batchServices.Constants.JailBooking.MAX_BOOKINGS, SKIP),
				  							INNER);
		RETURN join_dlnumber;
	END;
			// Calculate penalties for various name combinations, and return the lower penalty value.
	EXPORT fullnames_to_compare(BatchServices.Layouts.JailBooking.rec_input_and_matchcodes l, 
													Appriss.Key_Booking r, unsigned i) := 
		FUNCTION
				RETURN  
					// Last name may be blank in the first entity if the entity happens to be a trust.
					MODULE(FULLNAME_LABEL)						
						EXPORT lastname       := l._last_name;       // the 'input' last name
						EXPORT middlename     := l._middle_name;     // the 'input' middle name
						EXPORT firstname      := l._first_name;      // the 'input' first name
						EXPORT allow_wildcard := FALSE;
						EXPORT lname_field    := r.lname; 
						EXPORT mname_field    := r.mname; 
						EXPORT fname_field    := r.fname; 
					END;			
		END;
		
		EXPORT penalize_fullname(BatchServices.Layouts.JailBooking.rec_input_and_matchcodes l, 
		                         Appriss.Key_Booking r) :=
			FUNCTION				
			  //implement 2 name variations if necessary.
				name_1_penalty := AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(fullnames_to_compare(l,r,1));
				//name_2_penalty := AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(fullnames_to_compare(l,r,2));
				
				RETURN MIN(name_1_penalty/*,name_2_penalty*/);

			END;
	EXPORT ssn_to_compare(BatchServices.Layouts.JailBooking.rec_input_and_matchcodes l, 
													Appriss.Key_Booking r, unsigned i) := 
			FUNCTION
			    RETURN  
					MODULE(SSN_LABEL)						
						EXPORT ssn            	:= l._ssn;
						EXPORT allow_wildcard 	:= FALSE;
						EXPORT ssn_field      	:= map(i = 1 => r.ssn,
						                               i = 2 => r.ap_ssn, '');				
					END;			
			END;
		
		// Calculate SSN penalties using both ssn and ap_ssn, and return the lower penalty value.
		EXPORT penalize_ssn(BatchServices.Layouts.JailBooking.rec_input_and_matchcodes l, 
		                         Appriss.Key_Booking r) :=
			FUNCTION								
  			ssn_penalty_1 := AutoStandardI.LIBCALL_PenaltyI_SSN.val(ssn_to_compare(l,r,1));
				ssn_penalty_2 := AutoStandardI.LIBCALL_PenaltyI_SSN.val(ssn_to_compare(l,r,2));
				RETURN MIN(ssn_penalty_1,ssn_penalty_2);
			END;
		
		EXPORT dob_to_compare(BatchServices.Layouts.JailBooking.rec_input_and_matchcodes l, 
													Appriss.Key_Booking r) := 
			FUNCTION
		    	RETURN  
					MODULE(DOB_LABEL)				
	    			EXPORT dob            	:= (UNSIGNED8)l._dob;
						EXPORT allow_wildcard 	:= FALSE;
						EXPORT dob_field      	:= r.date_of_birth;
					END;			
			END;
		EXPORT penalize_dob(BatchServices.Layouts.JailBooking.rec_input_and_matchcodes l, 
		                         Appriss.Key_Booking r) :=
			FUNCTION								
  			dob_penalty := AutoStandardI.LIBCALL_PenaltyI_DOB.val(dob_to_compare(l,r));
				RETURN dob_penalty;
			END;
    // make additional records for other clean name values from 2 types of cleaning.
				EXPORT address_to_compare(BatchServices.Layouts.JailBooking.rec_input_and_matchcodes l, 
		                        Appriss.Key_Booking r,
														unsigned i) :=
			FUNCTION			
				RETURN 
					MODULE(ADDRESS_LABEL)
					
						// The 'input' address:
						EXPORT predir      := map(i = 1 => l._predir,
						                          i = 2 => l._predir_cln, '');	
						EXPORT prim_name   := map(i = 1 => l._prim_name,
						                          i = 2 => l._prim_name_cln, '');	
						EXPORT prim_range  := map(i = 1 => l._prim_range,
						                          i = 2 => l._prim_range_cln, '');	
						EXPORT postdir     := map(i = 1 => l._postdir,
						                          i = 2 => l._postdir_cln, '');	
						EXPORT addr_suffix := map(i = 1 => l._addr_suffix,
  				                            i = 2 => l._addr_suffix_cln, '');	
						EXPORT sec_range   := map(i = 1 => l._sec_range,
				                              i = 2 => l._sec_range_cln, '');	
						EXPORT p_city_name := map(i = 1 => l._p_city_name,
						                          i = 2 => l._p_city_name_cln, '');	
						EXPORT st          := map(i = 1 => l._st,
						                          i = 2 => l._st_cln, '');	
						EXPORT z5          := map(i = 1 => l._z5,
						                          i = 2 => l._z5_cln, '');	
						
						// The address in the matching record:						
						EXPORT allow_wildcard := FALSE;					
						EXPORT city_field     := r.p_city_name;
						EXPORT city2_field    := '';
						EXPORT pname_field    := r.prim_name;
						EXPORT postdir_field  := r.postdir;
						EXPORT prange_field   := r.prim_range;
						EXPORT predir_field   := r.predir;
						EXPORT state_field    := r.state;
						EXPORT suffix_field   := r.addr_suffix;
						EXPORT zip_field      := r.zip5;
						
						EXPORT useGlobalScope := FALSE;
					END;
			END;	
		// Calculate penalty for a pair of addresses.			
		EXPORT penalize_addr(BatchServices.Layouts.JailBooking.rec_input_and_matchcodes l, 
		                         Appriss.Key_Booking r) :=
			FUNCTION			
				addr_penalty_1 :=  AutoStandardI.LIBCALL_PenaltyI_Addr.val(address_to_compare(l,r,1));
				addr_penalty_2 :=  AutoStandardI.LIBCALL_PenaltyI_Addr.val(address_to_compare(l,r,2));
				RETURN MIN(addr_penalty_1,addr_penalty_2);
			END;			
		
		EXPORT fn_generate_names(dataset(BatchServices.Layouts.JailBooking.layout_inJailBookingBatch) inRecs) := FUNCTION
		  inLayout_counter  := record(BatchServices.Layouts.JailBooking.layout_inJailBookingBatch)
  			integer cnt ;
			end;
      inLayout_counter makeNames(inRecs L, integer C) := TRANSFORM
	      vCleanName_fml := address.CleanPersonFML73(trim(l.name_first)+' '+trim(l.name_middle)+' '+trim(l.name_last));
	      vCleanName_lfm := address.CleanPersonFML73(trim(l.name_last)+', '+trim(l.name_first)+' '+trim(l.name_middle));
	      self.cnt := C;	  
  			self.name_last := choose(c, l.name_last, vCleanName_fml[46..65], vCleanName_lfm[46..65],vCleanName_lfm[6..25]);
		    self.name_first := choose(c, l.name_first, vCleanName_fml[6..25], vCleanName_lfm[6..25],vCleanName_lfm[46..65]);
		    self.name_middle := choose(c, l.name_middle, vCleanName_fml[26..45], vCleanName_lfm[26..45], vCleanName_lfm[26..45]);
	      self := l;
 	    END;
      nameRecsNorm  := NORMALIZE(inRecs, BatchServices.Constants.Jailbooking.name_variations, makeNames(LEFT, COUNTER));   
		  //save the first input record and other records that have at least a last or first name after cleaning.
		  nameRecsPre := nameRecsNorm(cnt = 1 or name_last <> '' or name_first<> '');
			nameRecs := project(nameRecsPre,BatchServices.Layouts.JailBooking.layout_inJailBookingBatch);
   		//after we generate name variations remove dups created.
		  sNameRecs := SORT(nameRecs, acctno, name_last, name_first, name_middle);
		  outRecs   := DEDUP(sNameRecs, acctno, name_last, name_first, name_middle);
		  RETURN outRecs;
  	END;
		EXPORT fn_flatten(dataset(BatchServices.layouts.JailBooking.out_normalized) inRecs) := FUNCTION
		// flatten the records for output.
		BatchServices.layouts.JailBooking.out_flat flatten(inRecs l) := transform
  	  self.charge1_booking_sid := L.charges[1].booking_sid;
			self.charge1_site_id := L.charges[1].site_id;
      self.charge1_agency := L.charges[1].agency ;
			self.charge1_charge_seq := L.charges[1].charge_seq;
			self.charge1_agencykey := L.charges[1].agencykey;
			self.charge1_charge_cnt := L.charges[1].charge_cnt;
			self.charge1_charge := L.charges[1].charge;
			self.charge1_description := L.charges[1].description;
			self.charge1_charge_dt := L.charges[1].charge_dt;
			self.charge1_court_dt := L.charges[1].court_dt;
			self.charge1_key_severity := L.charges[1].key_severity;
			self.charge1_bond_amt := L.charges[1].bond_amt;
			self.charge1_disposition_dt := L.charges[1].disposition_dt;
			self.charge1_disposition_text := L.charges[1].disposition_text;
			self.charge1_ncic_offense_class_txt := L.charges[1].ncic_offense_class_txt;
			self.charge1_ncic_offense_cd := L.charges[1].ncic_offense_cd;
			self.charge1_bond_type_txt := L.charges[1].bond_type_txt;
			self.charge2_booking_sid := L.charges[2].booking_sid;
			self.charge2_site_id :=L.charges[2].site_id;
      self.charge2_agency := L.charges[2].agency ;
			self.charge2_charge_seq := L.charges[2].charge_seq;
			self.charge2_agencykey := L.charges[2].agencykey;
			self.charge2_charge_cnt := L.charges[2].charge_cnt;
			self.charge2_charge := L.charges[2].charge;
			self.charge2_description := L.charges[2].description;
			self.charge2_charge_dt := L.charges[2].charge_dt;
			self.charge2_court_dt := L.charges[2].court_dt;
			self.charge2_key_severity := L.charges[2].key_severity;
			self.charge2_bond_amt := L.charges[2].bond_amt;
			self.charge2_disposition_dt := L.charges[2].disposition_dt;
			self.charge2_disposition_text := L.charges[2].disposition_text;
			self.charge2_ncic_offense_class_txt := L.charges[2].ncic_offense_class_txt;
			self.charge2_ncic_offense_cd := L.charges[2].ncic_offense_cd;
			self.charge2_bond_type_txt := L.charges[2].bond_type_txt;
			self.charge3_booking_sid := L.charges[3].booking_sid;
			self.charge3_site_id :=L.charges[3].site_id;
      self.charge3_agency := L.charges[3].agency ;
			self.charge3_charge_seq := L.charges[3].charge_seq;
			self.charge3_agencykey := L.charges[3].agencykey;
			self.charge3_charge_cnt := L.charges[3].charge_cnt;
			self.charge3_charge := L.charges[3].charge;
			self.charge3_description := L.charges[3].description;
			self.charge3_charge_dt := L.charges[3].charge_dt;
			self.charge3_court_dt := L.charges[3].court_dt;
			self.charge3_key_severity := L.charges[3].key_severity;
			self.charge3_bond_amt := L.charges[3].bond_amt;
			self.charge3_disposition_dt := L.charges[3].disposition_dt;
			self.charge3_disposition_text := L.charges[3].disposition_text;
			self.charge3_ncic_offense_class_txt := L.charges[3].ncic_offense_class_txt;
			self.charge3_ncic_offense_cd := L.charges[3].ncic_offense_cd;
			self.charge3_bond_type_txt := L.charges[3].bond_type_txt;
			self.charge4_booking_sid := L.charges[4].booking_sid;
			self.charge4_site_id :=L.charges[4].site_id;
      self.charge4_agency := L.charges[4].agency ;
			self.charge4_charge_seq := L.charges[4].charge_seq;
			self.charge4_agencykey := L.charges[4].agencykey;
			self.charge4_charge_cnt := L.charges[4].charge_cnt;
			self.charge4_charge := L.charges[4].charge;
			self.charge4_description := L.charges[4].description;
			self.charge4_charge_dt := L.charges[4].charge_dt;
			self.charge4_court_dt := L.charges[4].court_dt;
			self.charge4_key_severity := L.charges[4].key_severity;
			self.charge4_bond_amt := L.charges[4].bond_amt;
			self.charge4_disposition_dt := L.charges[4].disposition_dt;
			self.charge4_disposition_text := L.charges[4].disposition_text;
			self.charge4_ncic_offense_class_txt := L.charges[4].ncic_offense_class_txt;
			self.charge4_ncic_offense_cd := L.charges[4].ncic_offense_cd;
			self.charge4_bond_type_txt := L.charges[4].bond_type_txt;
			self.charge5_booking_sid := L.charges[5].booking_sid;
			self.charge5_site_id :=L.charges[5].site_id;
      self.charge5_agency := L.charges[5].agency ;
			self.charge5_charge_seq := L.charges[5].charge_seq;
			self.charge5_agencykey := L.charges[5].agencykey;
			self.charge5_charge_cnt := L.charges[5].charge_cnt;
			self.charge5_charge := L.charges[5].charge;
			self.charge5_description := L.charges[5].description;
			self.charge5_charge_dt := L.charges[5].charge_dt;
			self.charge5_court_dt := L.charges[5].court_dt;
			self.charge5_key_severity := L.charges[5].key_severity;
			self.charge5_bond_amt := L.charges[5].bond_amt;
			self.charge5_disposition_dt := L.charges[5].disposition_dt;
			self.charge5_disposition_text := L.charges[5].disposition_text;
			self.charge5_ncic_offense_class_txt := L.charges[5].ncic_offense_class_txt;
			self.charge5_ncic_offense_cd := L.charges[5].ncic_offense_cd;
			self.charge5_bond_type_txt := L.charges[5].bond_type_txt;
			self := l;
		end;
		  outRecs := project(inRecs, flatten(left));
		  RETURN outRecs;
		END;
		EXPORT fn_upper_input(dataset(BatchServices.Layouts.JailBooking.layout_inJailBookingBatch) inRecs) := FUNCTION
			BatchServices.Layouts.JailBooking.layout_inJailBookingBatch  upperInput(inRecs l) := transform
				self.name_last :=  StringLib.StringToUpperCase(l.name_Last);
				self.name_First :=  StringLib.StringToUpperCase(l.name_First);
				self.name_Middle :=  StringLib.StringToUpperCase(l.name_Middle);
				self.prim_range :=  StringLib.StringToUpperCase(l.prim_range);
				self.prim_name :=  StringLib.StringToUpperCase(l.prim_name);
				self.predir :=  StringLib.StringToUpperCase(l.predir);
				self.postdir :=  StringLib.StringToUpperCase(l.postdir);
				self.addr_suffix :=  StringLib.StringToUpperCase(l.addr_suffix);
				self.unit_desig :=  StringLib.StringToUpperCase(l.unit_desig);
				self.sec_range :=  StringLib.StringToUpperCase(l.sec_range);
				self.p_city_name :=  StringLib.StringToUpperCase(l.p_city_name);
				self.st :=  StringLib.StringToUpperCase(l.st);
				self.dl :=  StringLib.StringToUpperCase(l.dl);
				self.State_ID_Number:=  StringLib.StringToUpperCase(l.State_ID_Number);
				self.fbi_number := StringLib.StringToUpperCase(l.fbi_number);
				self := l;
			end;
		  outRecs := project(inRecs, upperInput(left));
		  RETURN outRecs;
		END;
END; //end of module