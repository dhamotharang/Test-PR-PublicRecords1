import Data_Services, ut, STD;
EXPORT fn_Inputstats  := module

dInbase := Files_eCrash.DS_BASE_ECRASH ( regexreplace('-',sent_to_hpcc_datetime[1..10],'') = ut.getDateOffset(-1,mod_Utilities.StrSysDate));


rec := record
dInbase.sent_to_hpcc_datetime;
integer count_ := count(group);
end;

dInstats := table(dInbase,rec,sent_to_hpcc_datetime,few);

dInstats1 := sort(dInstats,sent_to_hpcc_datetime);

rec1 := record
decimal2 hrsapart := 0.0;
string14 sent_to_hpcc_datetime;
string5 time := '';
integer count_;
string missed_flag := 'N';
string delay_flag := 'N';

end;

dInstats2 := project ( dInstats1,transform(rec1,self.sent_to_hpcc_datetime := STD.Str.FilterOut( regexreplace('-|:|',left.sent_to_hpcc_datetime,''), ' '),self := left));


dInstats3 := project(dInstats2,transform( rec1 ,self.time := map ( (integer) left.sent_to_hpcc_datetime[9..10] = 00 => '12AM',
                                                                   (integer) left.sent_to_hpcc_datetime[9..10] < 12 => (integer) left.sent_to_hpcc_datetime[9..10] + 'AM', 
                                                                   (integer) left.sent_to_hpcc_datetime[9..10] > 12  => (integer) left.sent_to_hpcc_datetime[9..10] - 12 + 'PM' ,
																																   (integer) left.sent_to_hpcc_datetime[9..10] + 'PM' ),self := left)); 
//ut.SecondsApart

rec2 := record
string5 time;
decimal2 hrsapart := 0.0;
integer count_;
string missed_flag := 'N';
string delay_flag := 'N';
end;

rec1 droll( rec1 l,rec1 r) := transform
self.hrsapart :=   if ( l.sent_to_hpcc_datetime <> '' and r.sent_to_hpcc_datetime <> '',ut.SecondsApart( l.sent_to_hpcc_datetime,r.sent_to_hpcc_datetime)/3600 ,0.0);
self.missed_flag := if ( self.hrsapart <> 3 and self.hrsapart > 5,'Y','N');
self.delay_flag   := if ( self.hrsapart <> 3 and self.hrsapart <= 5 ,'Y','N');
self := r;
end;

dInstats4 := iterate( dInstats3,droll(left,right));


dInstats5 := project( dInstats4 , transform(rec2, self := left));

mail_data := record, maxlength(10000000)
	 string mail_text;
  end;


header_ := dataset([{'-----------------------------------------------------------'},
                    {'sent to hpcc date time , hours apart , recordcount, missedflag'},
										          {'-----------------------------------------------------------\n'}],mail_data );

mail_data convertToString(rec2 L) := TRANSFORM
	  SELF.mail_text := '------------------------------------------------------------------------------------------------------------------------------------------------' +
		                     '\n'+ '              ' + L.time + '          ' + L.hrsapart + '        ' + L.count_ + '        ' +  L.missed_flag +  '        ' + L.delay_flag + 
		                 
										             '------------------------------------------------------------------------------------------------------------------------------------------------' +     	
																      '\n';	                
  END;
  
	stringRecs := header_ + project(dInstats5, convertToString(LEFT));

  mail_data convertToText(mail_data L, mail_data R) := TRANSFORM
	  SELF.mail_text := trim(L.mail_text) + trim(R.mail_text);
  END;

  textDs := ROLLUP(stringRecs, 1=1, convertToText(LEFT, RIGHT));

   attachment := textDs[1].mail_text;

export sentemail := if ( count(dInstats5 ( missed_flag = 'Y')) > 0 or count(dInstats5 ( count_ = 0)) > 1, 
                                           FileServices.SendEmail ( 'DataDevelopment-InsRiskeCrash@lexisnexisrisk.com; bipin.jha@lexisnexisrisk.com ; Sai.Nagula@lexisnexis.com ;sudhir.kasavajjala@lexisnexis.com',
                                                                        'MISSING ECRASH FILES PROCESSED '+ut.getDateOffset(-1,mod_Utilities.StrSysDate),
																																				'Previous 8 sent date time file counts for '+ut.getDateOffset(-1,mod_Utilities.StrSysDate) + '.Please look into it' +'\n\n'+ textDs[1].mail_text
																																		),	
																																				 
																							FileServices.SendEmail ( 'sudhir.kasavajjala@lexisnexis.com',
                                                                        ' ECRASH FILES PROCESSED '+ut.getDateOffset(-1,mod_Utilities.StrSysDate),
																																				' ECRASH FILES PROCESSED ON '+ut.getDateOffset(-1,mod_Utilities.StrSysDate) + '.Please look into it' +'\n\n'+ textDs[1].mail_text
																																			)
																																				 
													);
													
													
end;
																																				 
																																				 
																																			
																																			
																																				