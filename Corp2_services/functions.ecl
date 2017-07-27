/*2012-09-26T14:16:15Z (Chris Albee_prod)
Fix 'memory limit exceeded error'. Bug 112105.
*/

IMPORT AutoStandardI;

EXPORT functions := MODULE

	EXPORT fn_penalize_matching_biz( 
		Corp2_services.Layouts.layout_batch_in l, Corp2_services.layouts.layout_AK_payload r ) := 
			FUNCTION

				biz_records_to_compare := 
						MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Biz.full, opt))

							// -----[ INPUT RECORD ]-----
							
							// Company name, fein data:
							EXPORT companyname    := l.comp_name; 
							EXPORT fein           := l.fein; 
							
							// Address data:
							EXPORT predir         := '';
							EXPORT prim_name      := l.prim_name;
							EXPORT prim_range     := l.prim_range;
							EXPORT postdir        := '';
							EXPORT addr_suffix    := '';
							EXPORT sec_range      := l.sec_range;
							EXPORT p_city_name    := l.p_city_name;
							EXPORT st             := l.st;
							EXPORT z5             := l.z5;	
							
							// Phone data:
							EXPORT phone          := IF( TRIM(l.homephone) != '', l.homephone, l.workphone );
							
							// BDID:
							EXPORT bdid           := (STRING)l.bdid;

							// -----[ MATCHING RECORD ]-----

							// Company name, fein data:
							EXPORT cname_field    := r.company_name; 
							EXPORT fein_field     := r.fein; 

							// Address data:						
							EXPORT prange_field   := r.business_prim_range;
							EXPORT predir_field   := '';
							EXPORT pname_field    := r.business_prim_name;
							EXPORT postdir_field  := '';
							EXPORT suffix_field   := '';
							EXPORT sec_range_field:= r.business_sec_range;
							EXPORT city_field     := r.business_city;
							EXPORT city2_field    := '';
							EXPORT state_field    := r.business_state;
							EXPORT zip_field      := r.business_zip;
							EXPORT county_field   := '';
							EXPORT allow_wildcard := FALSE;					
							
							// Phone data:
							EXPORT phone_field    := r.business_phone;
							// BDID:
							EXPORT bdid_field     := (STRING)r.bdid;
							
							EXPORT useGlobalScope := FALSE;
						END;
						
					penalty_score := AutoStandardI.LIBCALL_PenaltyI_Biz.val(biz_records_to_compare);
					
					RETURN IF( TRIM(l.comp_name) != '' AND TRIM(r.company_name) != '', penalty_score, 100 );
					
			END;
			
			
	EXPORT fn_penalize_matching_indv( 
		Corp2_services.Layouts.layout_batch_in l, Corp2_services.layouts.layout_AK_payload r ) := 
			FUNCTION
			
				indv_records_to_compare := 
						MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv.full, opt))

							// -----[ INPUT RECORD ]-----
							
							// Name, ssn data:
							EXPORT lastname       := l.name_last;   
							EXPORT middlename     := l.name_middle; 
							EXPORT firstname      := l.name_first;  
							EXPORT ssn            := l.ssn;
							EXPORT dob            := 0;
							
							// Address data:
							EXPORT predir         := '';
							EXPORT prim_name      := l.prim_name;
							EXPORT prim_range     := l.prim_range;
							EXPORT postdir        := '';
							EXPORT addr_suffix    := '';
							EXPORT sec_range      := l.sec_range;
							EXPORT p_city_name    := l.p_city_name;
							EXPORT st             := l.st;
							EXPORT z5             := l.z5;	
							
							// Phone data:
							EXPORT phone          := IF( TRIM(l.homephone) != '', l.homephone, l.workphone );
							// DID:
							EXPORT did            := (STRING)l.did;

							// -----[ MATCHING RECORD ]-----

							// Name, ssn data:
							EXPORT lname_field    := r.person_lname; 
							EXPORT mname_field    := r.person_mname; 
							EXPORT fname_field    := r.person_fname; 
							EXPORT ssn_field      := r.person_ssn;
							EXPORT dob_field      := '';

							// Address data:						
							EXPORT prange_field   := r.person_prim_range;
							EXPORT predir_field   := '';
							EXPORT pname_field    := r.person_prim_name;
							EXPORT postdir_field  := '';
							EXPORT suffix_field   := '';
							EXPORT sec_range_field:= r.person_sec_range;
							EXPORT city_field     := r.person_city;
							EXPORT city2_field    := '';
							EXPORT state_field    := r.person_state;
							EXPORT zip_field      := r.person_zip;
							EXPORT county_field   := '';
							EXPORT allow_wildcard := FALSE;					
							
							// Phone data:
							EXPORT phone_field    := r.person_phone;
							// DID:
							EXPORT did_field      := (STRING)r.person_did;
							
							EXPORT useGlobalScope := FALSE;
						END;

					penalty_score := AutoStandardI.LIBCALL_PenaltyI_Indv.val(indv_records_to_compare);
					
					RETURN IF( TRIM(l.name_last) != '' AND TRIM(r.person_lname) != '', penalty_score, 100 );

			END;
			
END;
