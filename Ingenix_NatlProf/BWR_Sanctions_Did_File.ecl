// 03/13/2007 - Modified code to fix the Sanc_updte/Sanc_reindte/Sanc_Sancdte 
// date fields to formate correctly as per the bug# 23305. 
Working_file 		:= Ingenix_NatlProf.Sanctions_Code_DID;

Layout_file_out := record
		string4 sanc_updte_yyyy;
		string2 sanc_updte_mm;
		string2 sanc_updte_dd;
		string9 SANC_UPDTE_orig;
		string8 SANC_UPDTE_form;
		string4 SANC_REINDTE_yyyy;
		string2 SANC_REINDTE_mm;
		string2 SANC_REINDTE_dd;
		string9 SANC_REINDTE_orig;
		string8 SANC_REINDTE_form;
		string4 SANC_SANCDTE_yyyy;
		string2 SANC_SANCDTE_mm;
		string2 SANC_SANCDTE_dd;
		string9 SANC_SANCDTE_orig;
		string8 SANC_SANCDTE_form;
		//string8 ;
		//string8 SANC_REINDTE;
		string8 process_date;
		string8 date_first_seen;
		string8 date_last_seen;
		string8	date_first_reported;
		string8 date_last_reported;
		string12 did ;
		//unsigned1 did_score := 0;
		Ingenix_NatlProf.Layout_in_Cleaned_Sanctions;
		unsigned8 source_rec_id;
end;

searchpattern := '^(.*)/(.*)/(.*)$';

Layout_file_out xform(Working_file l) := transform
		//###################SANC_UPDTE starts#################################
		self.SANC_UPDTE_yyyy 		:= if(trim(l.SANC_UPDTE,left,right)!='' and l.SANC_UPDTE[7..7]='-' and l.SANC_UPDTE[8..8]='0','20'+l.SANC_UPDTE[8..9],
																  if(trim(l.SANC_UPDTE,left,right)!='' and l.SANC_UPDTE[7..7]='-' and l.SANC_UPDTE[8..8]!='0','19'+l.SANC_UPDTE[8..9],
																		 regexfind(searchpattern, l.SANC_UPDTE, 3))
															   );
		self.SANC_UPDTE_mm      := map( l.SANC_UPDTE[4..6]='JAN'=>'01',
																		l.SANC_UPDTE[4..6]='FEB'=>'02',
																		l.SANC_UPDTE[4..6]='MAR'=>'03',
																		l.SANC_UPDTE[4..6]='APR'=>'04',
																		l.SANC_UPDTE[4..6]='MAY'=>'05',
																		l.SANC_UPDTE[4..6]='JUN'=>'06',
																		l.SANC_UPDTE[4..6]='JUL'=>'07',
																		l.SANC_UPDTE[4..6]='AUG'=>'08',
																		l.SANC_UPDTE[4..6]='SEP'=>'09',
																		l.SANC_UPDTE[4..6]='OCT'=>'10',
																		l.SANC_UPDTE[4..6]='NOV'=>'11',
																		l.SANC_UPDTE[4..6]='DEC'=>'12',
																		regexfind(searchpattern, l.SANC_UPDTE, 1));
		self.SANC_UPDTE_dd      := if(trim(l.SANC_UPDTE,left,right)!='' and L.SANC_UPDTE[3..3] = '-',l.SANC_UPDTE[1..2],regexfind(searchpattern, l.SANC_UPDTE, 2));
		self.SANC_UPDTE_form	  := self.SANC_UPDTE_yyyy+self.SANC_UPDTE_mm+self.SANC_UPDTE_dd;	
		self.SANC_UPDTE_orig    := l.SANC_UPDTE;	
		//#####################SANC_UPDTE ends###################################

		//###################SANC_REINDTE starts#################################	
		self.SANC_REINDTE_yyyy  := if(trim(l.SANC_REINDTE,left,right)!='' and l.SANC_REINDTE[7..7]='-' and l.SANC_REINDTE[8..8]='0','20'+l.SANC_REINDTE[8..9],
																	 if(trim(l.SANC_REINDTE,left,right)!='' and l.SANC_REINDTE[7..7]='-' and l.SANC_REINDTE[8..8]!='0','19'+l.SANC_REINDTE[8..9],
															        regexfind(searchpattern, l.SANC_REINDTE, 3))
													        );
		self.SANC_REINDTE_mm 		:= map( l.SANC_REINDTE[4..6]='JAN'=>'01',
																		l.SANC_REINDTE[4..6]='FEB'=>'02',
																		l.SANC_REINDTE[4..6]='MAR'=>'03',
																		l.SANC_REINDTE[4..6]='APR'=>'04',
																		l.SANC_REINDTE[4..6]='MAY'=>'05',
																		l.SANC_REINDTE[4..6]='JUN'=>'06',
																		l.SANC_REINDTE[4..6]='JUL'=>'07',
																		l.SANC_REINDTE[4..6]='AUG'=>'08',
																		l.SANC_REINDTE[4..6]='SEP'=>'09',
																		l.SANC_REINDTE[4..6]='OCT'=>'10',
																		l.SANC_REINDTE[4..6]='NOV'=>'11',
																		l.SANC_REINDTE[4..6]='DEC'=>'12',
																	  regexfind(searchpattern, l.SANC_REINDTE, 1));
		self.SANC_REINDTE_dd 		:= if(trim(l.SANC_REINDTE,left,right)!=''and L.SANC_REINDTE[3..3] = '-',l.SANC_REINDTE[1..2],regexfind(searchpattern, l.SANC_REINDTE, 2)) ;
		self.SANC_REINDTE_form	:= self.SANC_REINDTE_yyyy+self.SANC_REINDTE_mm+self.SANC_REINDTE_dd;	
		self.SANC_REINDTE_orig 	:= l.SANC_REINDTE;	
		//#####################SANC_REINDTE ends###################################

		//#####################SANC_SANCDTE starts################################
		self.SANC_SANCDTE_yyyy  := if(trim(l.SANC_SANCDTE,left,right)!='' and l.SANC_SANCDTE[7..7]='-' and l.SANC_SANCDTE[8..8]='0','20'+l.SANC_SANCDTE[8..9],
																	if(trim(l.SANC_SANCDTE,left,right)!='' and l.SANC_SANCDTE[7..7]='-' and l.SANC_SANCDTE[8..8]!='0','19'+l.SANC_SANCDTE[8..9],
																		 regexfind(searchpattern, l.SANC_SANCDTE, 3))
																 );
		self.SANC_SANCDTE_mm    := map( l.SANC_SANCDTE[4..6]='JAN'=>'01',
																		l.SANC_SANCDTE[4..6]='FEB'=>'02',
																		l.SANC_SANCDTE[4..6]='MAR'=>'03',
																		l.SANC_SANCDTE[4..6]='APR'=>'04',
																		l.SANC_SANCDTE[4..6]='MAY'=>'05',
																		l.SANC_SANCDTE[4..6]='JUN'=>'06',
																		l.SANC_SANCDTE[4..6]='JUL'=>'07',
																		l.SANC_SANCDTE[4..6]='AUG'=>'08',
																		l.SANC_SANCDTE[4..6]='SEP'=>'09',
																		l.SANC_SANCDTE[4..6]='OCT'=>'10',
																		l.SANC_SANCDTE[4..6]='NOV'=>'11',
																		l.SANC_SANCDTE[4..6]='DEC'=>'12',
																	 regexfind(searchpattern, l.SANC_SANCDTE, 1));
		self.SANC_SANCDTE_dd 		:= if(trim(l.SANC_SANCDTE,left,right)!=''and L.SANC_SANCDTE[3..3] = '-',l.SANC_SANCDTE[1..2],regexfind(searchpattern, l.SANC_SANCDTE, 2)) ;
		self.SANC_SANCDTE_form	:= self.SANC_SANCDTE_yyyy+self.SANC_SANCDTE_mm+self.SANC_SANCDTE_dd;	
		self.SANC_SANCDTE_orig 	:= l.SANC_SANCDTE;
		//#####################SANC_SANCDTE ends##################################
				
		self.date_first_seen 		 := if(trim(self.SANC_UPDTE_form,left,right)!='',self.SANC_UPDTE_form,
																	 if(trim(self.SANC_REINDTE_form,left,right)!='',self.SANC_REINDTE_form,
																			self.SANC_SANCDTE_form)
																	);
		self.date_last_seen 		 := map(self.SANC_UPDTE_form>self.SANC_REINDTE_form 		and self.SANC_UPDTE_form			> self.SANC_SANCDTE_form => self.SANC_UPDTE_form,
																	  self.SANC_REINDTE_form>self.SANC_UPDTE_form 		and self.SANC_REINDTE_form		> self.SANC_SANCDTE_form => self.SANC_REINDTE_form,
																	  self.SANC_SANCDTE_form>self.SANC_REINDTE_form 	and self.SANC_SANCDTE_form		> self.SANC_UPDTE_form => self.SANC_SANCDTE_form,''
																	 );
		self.process_date        := l.processdate;
		self.date_first_reported := l.processdate;
		self.date_last_reported  := l.processdate;
		self := l;
end;

file_out := PROJECT(Working_file,XFORM(LEFT));

layout_sanctions_DID_RecID xform_final(file_out l) := transform
		self := l;
end;

export BWR_Sanctions_Did_File := Project(file_out,xform_final(left));