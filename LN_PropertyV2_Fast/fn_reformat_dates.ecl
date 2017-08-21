import ln_propertyv2, ut, lib_fileservices;

// Property Date Fix- Bug 145096 - Reverse the date format from MMDDYYYY to YYYYMMDD for valid dates
EXPORT fn_reformat_dates := module

export string8 NumericDate( string date ) := FUNCTION
  r_date := if(regexfind('^([0-9]+)$',trim(date))
                  and length(trim(date)) > 7,date,'');
return r_date;
END;

export string8 YearOnly( string date ) := FUNCTION
  yr_date := if(regexfind('^([0-9]+)$',trim(date))
                  and length(trim(date))= 4
                  and date[1..2] in ['17','18','19','20'],trim(date)+ '0000','');
return yr_date;
END;

export string8 fix_date_yr(string date, string1 sep) := FUNCTION
	i := StringLib.StringFind(date, sep, 1);
	string2 month := IF(i = 2, '0' + date[1..1], date[1..2]);
	n := (integer)(date[i+1..i+2]);
	string4 year := (string4)(IF(n < 20, 2000 + n, 1900 + n));
 	return year + month + '00';
END;


export boolean isMMDDYYYY(string date) := FUNCTION
	instr := trim(date);
  result := map(instr = '' => false,
                NumericDate(instr) = '' => false,
	              instr[5..6] not in ['17','18','19','20'] => false,
								instr[5..6] in ['17','18','19','20'] and instr[1..4] = '0000' => true,
								instr[1..2] not in ['01','02','03','04','05','06','07','08','09','10','11','12'] => false,
								// instr[3] not in ['0','1','2','3'] => false,
								// instr[3]='3' and instr[4] not in ['0','1'] => false,
								// instr[1..2] in ['02','04','06','09','11'] and instr[3..4]='31' => false,
								// NOT _Validate.Date.fIsLeapYear((integer)instr[5..8]) and instr[1..2] = '02' and  (integer)instr[3..4] > 28 => false,
								true);
 	return result;
	
END;

export boolean isYYYYDDMM(string date) := FUNCTION
	instr := trim(date);
  result := map(instr = '' => false,
                NumericDate(instr)= '' => false,
	              instr[1..2] not in ['17','18','19','20'] => false,
								instr[1..2] in ['19','20'] and (instr[5..8] = '0000' or trim(instr[3..4]) = '') => false,
								instr[7..8] not in ['01','02','03','04','05','06','07','08','09','10','11','12'] => false,
								// instr[5] not in ['0','1','2','3'] => false,
								// instr[5]='3' and instr[6] not in ['0','1'] => false,
								// instr[7..8] in ['02','04','06','09','11'] and instr[5..6]='31' => false,
								// NOT _Validate.Date.fIsLeapYear((integer)instr[1..4]) and instr[7..8] = '02' and  (integer)instr[5..6] > 28 => false,
								instr[7..8] in ['02','04','06','09','11'] and (integer)instr[5..6] > 12 and (integer)instr[5..6] <31 => true,
								instr[7..8] in ['01','03','05','07','08','10','12'] and (integer)instr[5..6] > 12 and (integer)instr[5..6] <32 => true,
								false);
 	return result;
	
END;

//******************** reformat assessor dates ********************************************************
export assessor_dates(dataset(recordof(LN_PropertyV2.Layout_Property_Common_Model_BASE)) inAssessor) := function

ln_propertyv2.Layout_Property_Common_Model_BASE  xformDates(LN_PropertyV2.Layout_Property_Common_Model_BASE	pInput) := 
transform

TransferYrOnly        := YearOnly(pInput.transfer_date); 
RecordingYrOnly       := YearOnly(pInput.recording_date); 
SaleYrOnly            := YearOnly(pInput.sale_date); 
PriorRecordingYrOnly  := YearOnly(pInput.prior_recording_date); 
PriorTransferYrOnly   := YearOnly(pInput.prior_transfer_date); 

date_slash := '^([0-9]+)/([0-9]{2,2})*';

string	v_reformat_transfer_date          := map (TransferYrOnly != '' => TransferYrOnly,
                                                  Regexfind(date_slash, trim(pInput.transfer_date)) => fix_date_yr(pInput.transfer_date,'/'),
                                                  isMMDDYYYY(pInput.transfer_date) => pInput.transfer_date[5..8] + pInput.transfer_date[1..4],
                                                  isYYYYDDMM(pInput.transfer_date) => pInput.transfer_date[1..4] + pInput.transfer_date[7..8] + pInput.transfer_date[5..6],
                                                  '');
                                                        
string  v_reformat_recording_date         := map (RecordingYrOnly != '' => TransferYrOnly,
                                                  Regexfind(date_slash, trim(pInput.recording_date)) => fix_date_yr(pInput.recording_date,'/'),
                                                  isMMDDYYYY(pInput.recording_date) => pInput.recording_date[5..8] + pInput.recording_date[1..4],
                                                  isYYYYDDMM(pInput.recording_date) => pInput.recording_date[1..4] + pInput.recording_date[7..8] + pInput.recording_date[5..6],
                                                  '');
                                                  
string  v_reformat_sale_date               := map (SaleYrOnly != '' => TransferYrOnly,
                                                   Regexfind(date_slash, trim(pInput.sale_date)) => fix_date_yr(pInput.transfer_date,'/'),
                                                   isMMDDYYYY(pInput.sale_date) => pInput.sale_date[5..8] + pInput.sale_date[1..4],
                                                   isYYYYDDMM(pInput.sale_date) => pInput.sale_date[1..4] + pInput.sale_date[7..8] + pInput.sale_date[5..6],
                                                   '');
string	v_reformat_prior_recording_date    := map (PriorRecordingYrOnly != '' => TransferYrOnly,
                                                   Regexfind(date_slash, trim(pInput.prior_recording_date)) => fix_date_yr(pInput.prior_recording_date,'/'),
                                                   isMMDDYYYY(pInput.prior_recording_date) => pInput.prior_recording_date[5..8] + pInput.prior_recording_date[1..4],
                                                   isYYYYDDMM(pInput.prior_recording_date) => pInput.prior_recording_date[1..4] + pInput.prior_recording_date[7..8] + pInput.prior_recording_date[5..6],
                                                   '');
                                                  
string	v_reformat_prior_transfer_date      := map (PriorTransferYrOnly != '' => TransferYrOnly,
                                                    Regexfind(date_slash, trim(pInput.prior_transfer_date)) => fix_date_yr(pInput.prior_transfer_date,'/'),
                                                    isMMDDYYYY(pInput.prior_transfer_date) => pInput.prior_transfer_date[5..8] + pInput.prior_transfer_date[1..4],
                                                    isYYYYDDMM(pInput.prior_transfer_date) => pInput.prior_transfer_date[1..4] + pInput.prior_transfer_date[7..8] + pInput.prior_transfer_date[5..6],
                                                    '');

self.transfer_date									:=	if(v_reformat_transfer_date != '',v_reformat_transfer_date, pInput.transfer_date);                                                 
self.recording_date									:=	if(v_reformat_recording_date != '',v_reformat_recording_date, pInput.recording_date);
self.sale_date                      :=  if(v_reformat_sale_date != '',v_reformat_sale_date, pInput.sale_date);
self.prior_recording_date						:=	if(v_reformat_prior_recording_date != '',v_reformat_prior_recording_date, pInput.prior_recording_date);
self.prior_transfer_date						:=	if(v_reformat_prior_transfer_date != '',v_reformat_prior_transfer_date, pInput.prior_transfer_date);
self := pInput;
end;

ds_reformat_dates :=  project(inAssessor,xformDates(left));

return ds_reformat_dates;
end;


//******************** reformat first_seen/last_seen ********************************************************
export search_first_last_seen(dataset(recordof(LN_PropertyV2.layout_property_common_model_base)) inAssessor,
                              // dataset(recordof(LN_PropertyV2.layout_deed_mortgage_property_search_mod)) inSearch_repl,
                              dataset(recordof(LN_PropertyV2.Layout_DID_Out)) inSearch) 
                              := function


inLNAssessor1 := inAssessor(isMMDDYYYY(recording_date));
inLNAssessor2 := inAssessor(isYYYYDDMM(recording_date));

valid_century := ['17','18','19','20'];
valid_month   := ['00','01','02','03','04','05','06','07','08','09','10','11','12'];

// dsSearch := inSearch_repl + inSearch;

dSearchFixDates_Assessor_1	:=	join(	inSearch, inLNAssessor1 ,
															left.ln_fares_id 	=		right.ln_fares_id	and
															left.process_date	=		right.process_date and 
														  (ut.CleanSpacesAndUpper(left.nameasis) = ut.CleanSpacesAndUpper(right.assessee_name) or
                               ut.CleanSpacesAndUpper(left.nameasis) = ut.CleanSpacesAndUpper(right.second_assessee_name)),
															transform(	recordof(inSearch),
																					self.dt_first_seen	:=	if(trim((string)left.dt_first_seen)[1..2] not in valid_century and (string)left.dt_first_seen <> '',
																																			(unsigned3)(right.recording_date[5..8] + right.recording_date[1..2]),
																																				left.dt_first_seen);
																					
																					self.dt_last_seen		:= 	if(trim((string)left.dt_last_seen)[1..2] not in valid_century and (string)left.dt_last_seen <> '',
																																			(unsigned3)(right.recording_date[5..8] + right.recording_date[1..2]),
																																				left.dt_last_seen);
																					self						:=	left;
																				),
															left outer,
															lookup
														);


dSearchFixDates_Assessor_2	:=	join(	dSearchFixDates_Assessor_1, inLNAssessor2,
																					left.ln_fares_id 	=		right.ln_fares_id	and
																					left.process_date	=		right.process_date and 
																					(ut.CleanSpacesAndUpper(left.nameasis) = ut.CleanSpacesAndUpper(right.assessee_name) or
                                           ut.CleanSpacesAndUpper(left.nameasis) = ut.CleanSpacesAndUpper(right.second_assessee_name)),
																					transform(	recordof(inSearch),
																					self.dt_first_seen	:=	if(trim((string)left.dt_first_seen)[1..2] in valid_century and (trim((string)left.dt_first_seen)[5..6] not in valid_month and trim((string)left.dt_first_seen)[5..6] != '')
                                                                           and (string)left.dt_first_seen <> '',
                                                                                  (unsigned3)(right.recording_date[1..4] + right.recording_date[7..8]),
																																			if(trim((string)left.dt_first_seen)[1..2] in valid_century and trim((string)left.dt_first_seen)[4..6] = '', 0,
																																			if(isYYYYDDMM(right.recording_date), (unsigned3)(right.recording_date[1..4] + right.recording_date[7..8]), 
                                                                                                  left.dt_first_seen)));
																					
																					self.dt_last_seen		:= 	if(trim((string)left.dt_last_seen)[1..2] in valid_century and (trim((string)left.dt_last_seen)[5..6] not in valid_month and trim((string)left.dt_last_seen)[5..6] != '')
                                                                          and (string)left.dt_last_seen <> '',
                                                                                (unsigned3)(right.recording_date[1..4] + right.recording_date[7..8]),
																																		 if(trim((string)left.dt_last_seen)[1..2] in valid_century and trim((string)left.dt_last_seen)[4..6] = '', 0,
																																		 if(isYYYYDDMM(right.recording_date), (unsigned3)(right.recording_date[1..4] + right.recording_date[7..8]), 
                                                                                    left.dt_last_seen)));
																					self						:=	left;
																				),
															left outer,
															lookup
														);



return dSearchFixDates_Assessor_2;

end;
end;