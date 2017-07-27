import civil_court,lib_stringlib, ut;

//layouts have changed with Date first reported and Date last reported instead of process date

civil_court.Layout_Moxie_Matter tMatterInToOut(civil_court.Layout_In_Matter pInput)
  := transform
 self.dt_first_reported := pInput.process_date;
 self.dt_last_reported  := pInput.process_date;
 self.case_type_code := if(pInput.case_type = '' and pInput.vendor = '22', '', pInput.case_type_code); //bugzilla 19528 cng W20070925-141837dataland
 self:= pInput;
 end;

dInAsOut		:= project(civil_court.File_In_Matter,tMatterInToOut(left));

//Rollup to set Date first reported and Date last reported

//Populate the last non blank value found in the fields

civil_court.Layout_Moxie_Matter tRollup(civil_court.Layout_Moxie_Matter L, civil_court.Layout_Moxie_Matter R)
 := transform
  self.dt_first_reported := 		if(L.dt_first_reported < R.dt_first_reported, L.dt_first_reported , R.dt_first_reported );
  self.dt_last_reported  := 		if(R.dt_last_reported  > L.dt_last_reported,  R.dt_last_reported , L.dt_last_reported );
  self.case_type_code := 			if((R.dt_last_reported > L.dt_last_reported AND R.case_type<>''),  R.case_type_code , L.case_type_code );
  self.case_type := 				if((R.dt_last_reported > L.dt_last_reported AND R.case_type<>''),  R.case_type , L.case_type );
  self.case_title := 				if(R.dt_last_reported > L.dt_last_reported,  R.case_title , L.case_title );
  self.case_cause_code := 			if((R.dt_last_reported > L.dt_last_reported AND R.case_cause<>''),  R.case_cause_code , L.case_cause_code );
  self.case_cause := 				if((R.dt_last_reported > L.dt_last_reported AND R.case_cause<>''),  R.case_cause , L.case_cause );
  self.parent_case_key := 			if((R.dt_last_reported > L.dt_last_reported AND R.parent_case_key<>''),  R.parent_case_key , L.parent_case_key );
  self.manner_of_filing_code := 	if((R.dt_last_reported > L.dt_last_reported AND R.manner_of_filing<>''), R.manner_of_filing_code , L.manner_of_filing_code );
  self.manner_of_filing := 			if((R.dt_last_reported > L.dt_last_reported AND R.manner_of_filing<>''), R.manner_of_filing , L.manner_of_filing );
  self.manner_of_judgmt_code := 	if((R.dt_last_reported > L.dt_last_reported AND R.manner_of_judgmt<>''), R.manner_of_judgmt_code , L.manner_of_judgmt_code );
  self.manner_of_judgmt := 			if((R.dt_last_reported > L.dt_last_reported AND R.manner_of_judgmt<>''), R.manner_of_judgmt , L.manner_of_judgmt );
  self.judgmt_date := 				if((R.dt_last_reported > L.dt_last_reported AND R.judgmt_date<>''), R.judgmt_date , L.judgmt_date );
  self.judgmt_type_code := 			if((R.dt_last_reported > L.dt_last_reported AND R.judgmt_type<>''), R.judgmt_type_code , L.judgmt_type_code );
  self.judgmt_type := 				if((R.dt_last_reported > L.dt_last_reported AND R.judgmt_type<>''), R.judgmt_type , L.judgmt_type );
  self.judgmt_disposition_date := 	if((R.dt_last_reported > L.dt_last_reported AND R.judgmt_disposition_date<>''), R.judgmt_disposition_date , L.judgmt_disposition_date );
  self.judgmt_disposition_code := 	if((R.dt_last_reported > L.dt_last_reported AND R.judgmt_disposition<>''), R.judgmt_disposition_code , L.judgmt_disposition_code );
  self.judgmt_disposition := 		if((R.dt_last_reported > L.dt_last_reported AND R.judgmt_disposition<>''), R.judgmt_disposition , L.judgmt_disposition );
  self.disposition_date := 			if((R.dt_last_reported > L.dt_last_reported AND R.disposition_date<>''), R.disposition_date , L.disposition_date );
  self.disposition_code := 			if((R.dt_last_reported > L.dt_last_reported AND R.disposition_description<>''), R.disposition_code , L.disposition_code );
  self.disposition_description := 	if((R.dt_last_reported > L.dt_last_reported AND R.disposition_description<>''), R.disposition_description , L.disposition_description );
  self.suit_amount := 				if((R.dt_last_reported > L.dt_last_reported AND R.suit_amount<>''), R.suit_amount , L.suit_amount );
  self.award_amount := 				if((R.dt_last_reported > L.dt_last_reported AND R.award_amount<>''), R.award_amount , L.award_amount );
  
  self.court_code := 				if((R.dt_last_reported > L.dt_last_reported AND R.court<>''), R.court_code , L.court_code );
  self.court := 					if((R.dt_last_reported > L.dt_last_reported AND R.court<>''), R.court , L.court );
  self.case_number := 				if((R.dt_last_reported > L.dt_last_reported AND R.case_number<>''), R.case_number , L.case_number );
  self.filing_date := 				if((R.dt_last_reported > L.dt_last_reported AND R.filing_date<>''), R.filing_date , L.filing_date );
  self := R;
end;

dInAsOutDist	:= distribute(dInAsOut,hash(vendor,state_origin,case_key));

dInAsOutSorted	:= 
	sort(dInAsOutDist,
			vendor,
			state_origin,
			source_file,
			case_key,
		dt_last_reported,local);
					   
dInAsOutRollup := 
	rollup(dInAsOutSorted,
 	  tRollup(left, right),
		vendor,
		state_origin,
		source_file,
		case_key,
	  local);
					   					   				   
export Out_Moxie_Matter := output(dInAsOutRollup,,civil_court.Name_Moxie_Matter_Dev,__compressed__,overwrite);