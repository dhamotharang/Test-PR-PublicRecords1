import _Validate;

export File_Voters_Cleaned_Super :=
  dataset(VotersV2.Cluster + 'in::Voters::main::Superfile',
					VotersV2.Layouts_Voters.Layout_Voters_Common_new,
					thor); 
//Barb O'Neill removed this code for DOPS-461.  No longer 
//updating base with all data ever received from vendor.  Just
//updating base with current data received.             
	
					// +
	// project(dataset(VotersV2.Cluster + 'in::voters::main::pre_2009::superfile',
									// VotersV2.Layouts_Voters.Layout_Voters_Common,
									// thor),
					// transform(VotersV2.Layouts_Voters.Layout_Voters_Common_new,
		                // self.file_acquired_date := if(_Validate.Date.fIsValid(left.file_acquired_date) and
		                                                 // _Validate.Date.fIsValid(left.file_acquired_date, _Validate.Date.Rules.DateInPast),
		                                              // left.file_acquired_date,
																                  // ''),
										// self.process_date		    := self.file_acquired_date,
										// self.date_first_seen    := self.file_acquired_date,
										// self.date_last_seen     := self.file_acquired_date,
										//Allows 00 in MM and DD, but YYYY00DD is invalid, according to the utility
										// self.dob                := if(_Validate.Date.fIsValid(left.dob, , true, true),
																									// left.dob,
																									// '');
										//Allows 00 in MM and DD, but YYYY00DD is invalid, according to the utility
										// self.regDate            := if(_Validate.Date.fIsValid(left.regDate, , true, true),
																								  // left.regDate,
																									// ''),
										//Validating year and month should be good enough for this field
										// self.LastDateVote       := if(_Validate.Date.fIsValid(left.LastDateVote, _Validate.Date.Rules.MonthValid),
																									// left.LastDateVote,
																									// '');
										// self.gender             := if(left.gender in VotersV2._Flags.valid_gender,
										                              // left.gender,
																									// '');

										// self := left,
										// self := []));