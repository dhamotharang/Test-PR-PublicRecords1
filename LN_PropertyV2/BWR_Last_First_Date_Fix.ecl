import ln_propertyv2, ut;

EXPORT BWR_Last_First_Date_Fix(string filedate) := function
#workunit('name','Property Date Fix- Bug 145096 ' + filedate);

inLNAssessor			:=	LN_PropertyV2.File_Assessment;

inLNAssessor1 := inLNAssessor ( trim(recording_date)[1..2] not in ['17','18','19','20'] and recording_date <> ''
                                        and length(trim(recording_date)) > 7 
                                        // and (length(trim(recording_date)) < 6 
                                        // and length(trim(recording_date)) > 2)
                                        );
inLNAssessor2 := inLNAssessor1 ( trim(recording_date)[1..2] in ['01','02','03','04','05','06','07','08','09','10','11','12'] and recording_date <> ''
                                        );

inLNAssessor3 := inLNAssessor1 ( trim(recording_date)[1..4] = '0000' and trim(recording_date)[5..6] in ['17','18','19','20'] and recording_date <> '');

combine_LNAssessor := inLNAssessor2 + inLNAssessor3;

inSearch := LN_propertyv2.File_Search_DID;

dSearchFixDates_Assessor	:=	join(	inSearch, combine_LNAssessor,
															left.ln_fares_id 	=		right.ln_fares_id	and
															left.process_date	=		right.process_date and 
															ut.fnTrim2Upper(left.nameasis) = ut.fnTrim2Upper(right.assessee_name),
															transform(	LN_PropertyV2.Layout_DID_Out,
																					self.dt_first_seen	:=	if(trim((string)left.dt_first_seen)[1..2] not in ['17','18','19','20'] and (string)left.dt_first_seen <> '',
																																			(unsigned3)(right.recording_date[5..8] + right.recording_date[1..2]),
																																				left.dt_first_seen);
																					
																					self.dt_last_seen		:= 	if(trim((string)left.dt_last_seen)[1..2] not in ['17','18','19','20'] and (string)left.dt_last_seen <> '',
																																			(unsigned3)(right.recording_date[5..8] + right.recording_date[1..2]),
																																				left.dt_last_seen);
																					self						:=	left;
																				),
															left outer,
															lookup
														);


dSearchFixDates_SecondAssessor	:=	join(	dSearchFixDates_Assessor, combine_LNAssessor,
																					left.ln_fares_id 	=		right.ln_fares_id	and
																					left.process_date	=		right.process_date and 
																					ut.fnTrim2Upper(left.nameasis) = ut.fnTrim2Upper(right.second_assessee_name),
																					transform(	LN_PropertyV2.Layout_DID_Out,
																					self.dt_first_seen	:=	if(trim((string)left.dt_first_seen)[1..2] not in ['17','18','19','20'] and (string)left.dt_first_seen <> '',
																																			(unsigned3)(right.recording_date[5..8] + right.recording_date[1..2]),
																																				left.dt_first_seen);
																					
																					self.dt_last_seen		:= 	if(trim((string)left.dt_last_seen)[1..2] not in ['17','18','19','20'] and (string)left.dt_last_seen <> '',
																																			(unsigned3)(right.recording_date[5..8] + right.recording_date[1..2]),
																																				left.dt_last_seen);
																					self						:=	left;
																				),
															left outer,
															lookup
														);


dsSearchFix := output(dSearchFixDates_SecondAssessor,,'~thor_data400::base::ln_propertyv2::search_fix_' + filedate,overwrite);

return dsSearchFix;

end;
