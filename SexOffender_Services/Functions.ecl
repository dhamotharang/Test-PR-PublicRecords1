import sexoffender, AutoStandardI, doxie;

export Functions := module

  //Add functions related to formatting the new sex offender optional code.
	//Do not comment out this function or change to Doxie version
	//this version has special data filtering for sex offenders
	export fnBestIsNewer(string so_date_file, string so_report_date, string best_date) := function
		so_date := if (length(so_report_date)>0,so_report_date,so_date_file);//Use the file date if the report date is missing
		return if (best_date>so_date and length(best_date)>1,true,false);
	end;
	export fnBestIsDifferent(string so_prim_name, string so_prim_range, string so_predir, string so_postdir,
	                        string so_addr_suffix, string so_unit_desig, string so_sec_range, string so_p_city_name,
													string so_st, string so_zip5, string so_zip4,
													string ba_prim_name, string ba_prim_range, string ba_predir, string ba_postdir,
	                        string ba_addr_suffix, string ba_unit_desig, string ba_sec_range, string ba_p_city_name,
													string ba_st, string ba_zip5, string ba_zip4) := function
		prim_name := if(Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(so_prim_name))=Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(ba_prim_name)),true,false);
		prim_range := if(Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(so_prim_range))=Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(ba_prim_range)),true,false);
		predir := if(Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(so_predir))=Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(ba_predir)),true,false);
		postdir := if(Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(so_postdir))=Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(ba_postdir)),true,false);
		addr_suffix := if(Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(so_addr_suffix))=Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(ba_addr_suffix)),true,false);
		unit_desig := if(Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(so_unit_desig))=Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(ba_unit_desig)),true,false);
		sec_range := if(Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(so_sec_range))=Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(ba_sec_range)),true,false);
		p_city_name := if(Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(so_p_city_name))=Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(ba_p_city_name)),true,false);
		st := if(Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(so_st))=Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(ba_st)),true,false);
		zip5 := if(Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(so_zip5))=Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(ba_zip5)),true,false);
		zip4 := if(Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(so_zip4))=Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(ba_zip4)),true,false);
		rtnIsDifferent := if(prim_name and prim_range and predir and postdir and addr_suffix and unit_desig and sec_range and p_city_name and st and zip5 and zip4,false,true); 
		return rtnIsDifferent;
	end;

	export streetAddress1Value(string prim_name, string prim_range, string predir, string addr_suffix, string postdir) :=
				StringLib.StringCleanSpaces (prim_range + ' ' +  predir + ' ' + prim_name + ' ' + addr_suffix + ' ' + postdir);
  
	export stateCityZipValue(string p_city_name, string st, string zip) :=
				StringLib.StringCleanSpaces (p_city_name + ' ' +  st + ' ' + zip);

	export is_zip_only_search(boolean isFCRA = false) := FUNCTION
	    
			SexOffender.MAC_Header_Field_Declare(isFCRA);
			
			return is_zip_only_search;
 	end;
	
	EXPORT penalize_offender(SexOffender_Services.Layouts.layout_inBatchMaster_for_penalties l, 
		                         SexOffender_Services.Layouts.rec_offender_plus_acctno r) :=
		FUNCTION			

			offenders_to_compare := 
				MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv.full, opt))

					// The 'input' name:
					EXPORT lastname       := l._name_last;   
					EXPORT middlename     := l._name_middle; 
					EXPORT firstname      := l._name_first;  
					EXPORT ssn            := l._ssn;
					EXPORT dob            := (INTEGER)l._dob;
					
					// The 'input' address:
					EXPORT predir         := l._predir;
					EXPORT prim_name      := l._prim_name;
					EXPORT prim_range     := l._prim_range;
					EXPORT postdir        := l._postdir;
					EXPORT addr_suffix    := l._addr_suffix;
					EXPORT sec_range      := l._sec_range;
					EXPORT p_city_name    := l._p_city_name;
					EXPORT st             := l._st;
					EXPORT z5             := l._z5;					
		
					// The name in the matching record:
					EXPORT lname_field    := r.lname; 
					EXPORT mname_field    := r.mname; 
					EXPORT fname_field    := r.fname; 
					EXPORT ssn_field      := r.ssn_appended;
					EXPORT dob_field      := r.dob;

					// The address in the matching record:						
					EXPORT allow_wildcard := FALSE;					
					EXPORT city_field     := r.p_city_name;
					EXPORT city2_field    := '';
					EXPORT pname_field    := r.prim_name;
					EXPORT postdir_field  := r.postdir;
					EXPORT prange_field   := r.prim_range;
					EXPORT predir_field   := r.predir;
					EXPORT sec_range_field:= r.sec_range;
					EXPORT state_field    := IF(r.st != r.orig_state_code OR r.orig_state_code = '',
																			IF(r.orig_state_code = l._st,
																				 r.orig_state_code,
																				 l._st),			
																			r.st);
					EXPORT zip_field      := r.zip5;
					
					EXPORT county_field   := '';
					EXPORT DID_field      := '';
					EXPORT phone_field    := '';
					EXPORT suffix_field   := r.addr_suffix;
					
					EXPORT useGlobalScope := FALSE;
				END;
						 
			RETURN AutoStandardI.LIBCALL_PenaltyI_Indv.val(offenders_to_compare);

		END;		
end;
