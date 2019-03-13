import ut;
EXPORT fn_Agency_DE := function

 agency_new    := dataset(ut.foreign_prod+'thor_data400::in::ecrash::agency'
													 ,FLAccidents_Ecrash.Layout_Infiles.agency
													 ,csv(terminator(['|\n', '\n']), separator('|\t|'),quote('"')))(Agency_ID != 'Agency_ID') ;
													 
	agency_old   := dataset(ut.foreign_prod+'thor_data400::in::ecrash::agency.'+ut.getDateOffset(-1,ut.GetDate)+'.csv'
													 ,FLAccidents_Ecrash.Layout_Infiles.agency
													 ,csv(terminator(['|\n', '\n']), separator('|\t|'),quote('"')),opt)(Agency_ID != 'Agency_ID') ;
													 
		
	rec := record
	FLAccidents_Ecrash.Layout_Infiles.agency;
	string deflagup := '';
	end;
	
	rec map2deflag ( agency_new l ,agency_old r ) := transform
	self.deflagup := if ( l.drivers_exchange_flag = '0' and r.drivers_exchange_flag = '1','Y','N');
	self := l;
	end;
													 
	agency_diff := Join ( distribute( agency_new, hash(agency_id)),
	                        distribute( agency_old, hash(agency_id)),
													left.agency_id=right.agency_id,
													map2deflag(left,right),
													local
												);
												
		mail_to := if ( count(agency_old) > 0 , if ( count(agency_diff ( deflagup = 'Y')) > 0, FileServices.SendEmail( 'Sai.Nagula@lexisnexis.com; hari.velappan@lexisnexis.com; Sudhir.Kasavajjala@lexisnexis.com' ,'DE Flag modified on Agency file dated '+ut.Getdate,'DE Flag turned on for Agency id '+agency_diff ( deflagup = 'Y')[1].agency_id + ' Agency Name ' +agency_diff ( deflagup = 'Y')[1].agency_name  ),
		                                                             Output('Agency file not modified')),
																			Output('Agency file '+ut.getDateOffset(-2,ut.GetDate)+' is missing') 
											);
											
		return mail_to;
		end;
													 
		