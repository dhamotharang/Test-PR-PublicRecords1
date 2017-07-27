import civil_court,lib_stringlib;

//layouts have changed with Date first reported and Date last reported instead of process date

civil_court.Layout_Moxie_Party tPartyInToOut(civil_court.Layout_In_Party pInput)
 := transform
 self.dt_first_reported := pInput.process_date;
 self.dt_last_reported := pInput.process_date;
 self:= pInput;
 end;
 
dInAsOut := project(civil_court.File_In_Party, tPartyInToOut(left));


//Rollup to set Date first reported and Date last reported

//Populate the last non blank value found in the fields

civil_court.Layout_Moxie_Party tRollup(civil_court.Layout_Moxie_Party L, civil_court.Layout_Moxie_Party R)
 := transform
  self.dt_first_reported := 		if(L.dt_first_reported < R.dt_first_reported, L.dt_first_reported , R.dt_first_reported );
  self.dt_last_reported  := 		if(R.dt_last_reported  > L.dt_last_reported,  R.dt_last_reported , L.dt_last_reported );
  self.case_type_code := 			if((R.dt_last_reported > L.dt_last_reported AND R.case_type<>''),  R.case_type_code , L.case_type_code );
  self.case_type := 				if((R.dt_last_reported > L.dt_last_reported AND R.case_type<>''),  R.case_type , L.case_type );
  self.case_title := 				if(R.dt_last_reported > L.dt_last_reported,  R.case_title , L.case_title );
  self.ruled_for_against_code := 	if((R.dt_last_reported > L.dt_last_reported AND R.ruled_for_against<>''),  R.ruled_for_against_code , L.ruled_for_against_code );
  self.ruled_for_against := 		if((R.dt_last_reported > L.dt_last_reported AND R.ruled_for_against<>''),  R.ruled_for_against , L.ruled_for_against );
  self.parent_case_key := 			if((R.dt_last_reported > L.dt_last_reported AND R.parent_case_key<>''),  R.parent_case_key , L.parent_case_key );
  self.court_code := 				if((R.dt_last_reported > L.dt_last_reported AND R.court<>''), R.court_code , L.court_code );
  self.court := 					if((R.dt_last_reported > L.dt_last_reported AND R.court<>''), R.court , L.court );
  self.case_number := 				if((R.dt_last_reported > L.dt_last_reported), R.case_number , L.case_number );
  self := R;
end;

dInAsOutDist	:= distribute(dInAsOut,hash(vendor,state_origin,case_key));

dInAsOutSorted	:= 
	sort(dInAsOutDist,
				vendor,
				source_file,
				state_origin,
				case_key,
				prim_range1,
				predir1,
				prim_name1,
				addr_suffix1,
				postdir1,
				sec_range1,
				zip1,
				st1,
				v_city_name1,
				e1_fname1,
				e1_mname1,
				e1_lname1,
				e1_suffix1,
				e1_cname1,
				e1_fname2,
				e1_mname2,
				e1_lname2,
				e1_suffix2,
				e1_cname2,
				dt_last_reported,
	local);
					   
dInAsOutRollup := 
	rollup(dInAsOutSorted,
				tRollup(left, right),
				vendor,
				state_origin,
				source_file,
				case_key,
				prim_range1,
				predir1,
				prim_name1,
				addr_suffix1,
				postdir1,
				sec_range1,
				zip1,
				st1,
				v_city_name1,
				e1_fname1,
				e1_mname1,
				e1_lname1,
				e1_suffix1,
				e1_cname1,
				e1_fname2,
				e1_mname2,
				e1_lname2,
				e1_suffix2,
				e1_cname2,
	local);
					   
export Out_Moxie_Party := output(dInAsOutRollup,,civil_court.Name_Moxie_Party_Dev,overwrite);