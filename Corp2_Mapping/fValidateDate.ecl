import _validate,lib_stringlib,ut,corp2;
export fValidateDate(string pDate,string format = 'MM/DD/CCYY') := module
		//********************************************************************
		//ValidateDate : Three formats are accepted:
		//								 1) MM/DD/CCYY (the default format)
		//								 2) MM-DD-CCYY  e.g. 10-01-2016
		//								 2) CCYYMMDD		e.g. 20150430
		//								 3) MMM_DD_CCYY e.g. JAN 4 2015 or JANUARY 4 2015
		//								 4) DD_MMM_CCYY e.g. 07-NOV-2015 or '07-NOVEMBER-2015'
		//								 5) MM/DD/YY 		e.g. 8/2/15
		//								 6) MM-DD-YY 		e.g. 8-2-15		
		//								 7) CCYY-MM-DD 	e.g. 2016-10-01
		//
		//							 	 Based upon the input format, the input is converted to 
		//						 	 	 the ccyymmdd format.  Then the date is either checked
		//						     to see if it is valid "past" date or if the date is 
		//							   just a valid "general" date.
		//******************************************************************** 
		InDate			  := corp2.t2u(pDate);
		NoOfBlanks 		:= stringlib.stringfindcount(InDate,' ');
		Ck4Time				:= stringlib.stringfindcount(InDate,'T');

		Time_pos   		:= map(Ck4Time 	 <> 0 => StringLib.StringFind(InDate,'T',1),
												 NoOfBlanks = 0 => 0,
												 NoOfBlanks = 1 => StringLib.StringFind(InDate,' ',1),
												 NoOfBlanks = 2 => StringLib.StringFind(InDate,' ',2), //checking for blanks in a date:  e.g. 03/ 3/2016 07:02:46
												 0
												 );
 
		DateTrimmed		:= map(format = 'MMDDCCYY'											=> InDate[5..8]+InDate[1..2]+InDate[3..4],
												 format = 'MM/DD/CCYY' 	and time_pos <> 0	=> InDate[1..time_pos-1],
												 format = 'MM-DD-CCYY' 	and time_pos <> 0	=> stringlib.stringfindreplace(InDate[1..time_pos-1],'-','/'),
												 format = 'MM-DD-CCYY' 	and time_pos =  0	=> stringlib.stringfindreplace(InDate,'-','/'),
												 format = 'CCYYMMDD' 		and time_pos <> 0	=> InDate[1..time_pos-1],
												 format = 'MMM_DD_CCYY'										=> InDate,								 												//e.g. JAN 4 2015
												 format = 'DD_MMM_CCYY'										=> InDate,								 												//e.g. 07-NOV-2015
												 format = 'MM/DD/YY'		and time_pos <> 0	=> InDate[1..time_pos-1],
												 format = 'MM-DD-YY'											=> stringlib.stringfindreplace(InDate,'-','/'),	 	//e.g. 8-2-2015
												 format = 'CCYY-MM-DD'  and time_pos <> 0	=> InDate[1..time_pos-1],  												//e.g. 2106-10-01
												 InDate
												);

		//********************************************************************
		//This function translates those dates that contains the word for the 
		//month into its associated of a digit. e.g. JAN to 01.
		//********************************************************************
		fConvertMonth(string mm) := function
			
			return map(stringlib.stringfind(mm,'JANUARY',1) 	<> 0 	=> regexreplace('JANUARY',mm,'01'),
								 stringlib.stringfind(mm,'JAN',1) 			<> 0	=> regexreplace('JAN',mm,'01'),
								 stringlib.stringfind(mm,'FEBRUARY',1)  <> 0 	=> regexreplace('FEBRUARY',mm,'02'),
								 stringlib.stringfind(mm,'FEB',1) 	 		<> 0	=> regexreplace('FEB',mm,'02'),
								 stringlib.stringfind(mm,'MARCH',1)	 	  <> 0	=> regexreplace('MARCH',mm,'03'),
								 stringlib.stringfind(mm,'MAR',1) 	 		<> 0	=> regexreplace('MAR',mm,'03'),
								 stringlib.stringfind(mm,'APRIL',1) 		<> 0 	=> regexreplace('APRIL',mm,'04'),
								 stringlib.stringfind(mm,'APR',1)  		  <> 0	=> regexreplace('APR',mm,'04'),
								 stringlib.stringfind(mm,'MAY',1)  		  <> 0	=> regexreplace('MAY',mm,'05'),
								 stringlib.stringfind(mm,'JUNE',1)  		<> 0	=> regexreplace('JUNE',mm,'06'),
								 stringlib.stringfind(mm,'JUN',1)  		  <> 0	=> regexreplace('JUN',mm,'06'),
								 stringlib.stringfind(mm,'JULY',1)			<> 0	=> regexreplace('JULY',mm,'07'),
								 stringlib.stringfind(mm,'JUL',1)  		  <> 0	=> regexreplace('JUL',mm,'07'),
								 stringlib.stringfind(mm,'AUGUST',1)    <> 0	=> regexreplace('AUGUST',mm,'08'),
								 stringlib.stringfind(mm,'AUG',1)       <> 0 	=> regexreplace('AUG',mm,'08'),
								 stringlib.stringfind(mm,'SEPTEMBER',1) <> 0	=> regexreplace('SEPTEMBER',mm,'09'),
								 stringlib.stringfind(mm,'SEP',1) 		  <> 0	=> regexreplace('SEP',mm,'09'),
								 stringlib.stringfind(mm,'OCTOBER',1)   <> 0	=> regexreplace('OCTOBER',mm,'10'),
								 stringlib.stringfind(mm,'OCT',1) 		  <> 0	=> regexreplace('OCT',mm,'10'),
								 stringlib.stringfind(mm,'NOVEMBER',1)  <> 0 	=> regexreplace('NOVEMBER',mm,'11'),
								 stringlib.stringfind(mm,'NOV',1)		    <> 0	=> regexreplace('NOV',mm,'11'),
								 stringlib.stringfind(mm,'DECEMBER',1)  <> 0 	=> regexreplace('DECEMBER',mm,'12'),
								 stringlib.stringfind(mm,'DEC',1) 	    <> 0	=> regexreplace('DEC',mm,'12'),
								 ''
								);
		end;

		//********************************************************************
		//This function translates those dates that contains the word for the 
		//month into its associated of a digit. e.g. JAN 4 2015 => 01/04/2015
		//********************************************************************
		fConvert_MMM_DD_CCYY_Date(string s) := function
		  sDate := stringlib.stringfilterout(s,'.,');
			MM 	  := corp2.t2u(stringlib.stringgetnthword(sDate,1));
			DD	  := corp2.t2u(stringlib.stringgetnthword(sDate,2));
			CCYY  := corp2.t2u(stringlib.stringgetnthword(sDate,3));
		
			fixed_MM := fConvertMonth(mm);
			
			return if(fixed_MM <> '',fixed_MM+'/'+DD+'/'+CCYY,MM+'/'+DD+'/'+CCYY);
		end;

		//********************************************************************
		//This function translates those dates that contains the word for the 
		//month into its associated of a digit. e.g. 07-NOV-2015 => 11/07/2015
		//********************************************************************
		fConvert_DD_MMM_CCYY_Date(string s) := function
			sDate := stringlib.stringfindreplace(s, '-',' ');
			MM 	  := corp2.t2u(stringlib.stringgetnthword(sDate,2));
			DD	  := corp2.t2u(stringlib.stringgetnthword(sDate,1));
			CCYY  := corp2.t2u(stringlib.stringgetnthword(sDate,3));
		
			fixed_MM := fConvertMonth(mm);
			
			return if(fixed_MM <> '',fixed_MM+'/'+DD+'/'+CCYY,MM+'/'+DD+'/'+CCYY);
		end;
		
		//********************************************************************
		//This function translates those dates with a MM/DD/YY format to a
		//CCYYMMDD format e.g. 8/2/16 => 08/02/2016
		//********************************************************************
		fConvert_MM_DD_YY_Date(string s) := function
			sDate := stringlib.stringfindreplace(s, '/',' ');
			MM 	  := corp2.t2u(stringlib.stringgetnthword(sDate,1));
			DD	  := corp2.t2u(stringlib.stringgetnthword(sDate,2));
			CCYY 	:= ut.Date_YY_to_YYYY((unsigned)(stringlib.stringgetnthword(sDate,3)));
			
			return MM+'/'+DD+'/'+CCYY;
		end;
		
		shared DateCCYYMMDD := map(format = 'MMDDCCYY'		=> DateTrimmed,
															 format = 'MM/DD/CCYY'  => ut.date_slashed_MMDDYYYY_to_YYYYMMDD(DateTrimmed),
															 format = 'MM-DD-CCYY'  => ut.date_slashed_MMDDYYYY_to_YYYYMMDD(DateTrimmed),		
															 format = 'CCYYMMDD'	  => DateTrimmed,
															 format = 'MMM_DD_CCYY' => ut.date_slashed_MMDDYYYY_to_YYYYMMDD(fConvert_MMM_DD_CCYY_Date(DateTrimmed)),
															 format = 'DD_MMM_CCYY' => ut.date_slashed_MMDDYYYY_to_YYYYMMDD(fConvert_DD_MMM_CCYY_Date(DateTrimmed)),
															 format = 'MM/DD/YY'		=> ut.date_slashed_MMDDYYYY_to_YYYYMMDD(fConvert_MM_DD_YY_Date(DateTrimmed)),
															 format = 'MM-DD-YY'		=> ut.date_slashed_MMDDYYYY_to_YYYYMMDD(fConvert_MM_DD_YY_Date(DateTrimmed)),
															 format = 'CCYY-MM-DD'	=> stringlib.stringfilterout(DateTrimmed,'-'),															 
															 DateTrimmed
														  );
		export PastDate			:= if(DateCCYYMMDD <> '' and _validate.date.fisvalid(DateCCYYMMDD) and _validate.date.fIsValid(DateCCYYMMDD,_validate.date.rules.DateInPast)
																	 ,DateCCYYMMDD
																	 ,''
														 );
		export GeneralDate	:= if(DateCCYYMMDD <> '' and _validate.date.fisvalid(DateCCYYMMDD)
																	 ,DateCCYYMMDD
																	 ,''
														 );																	 
end;