IMPORT ut;

EXPORT CheckDailyProductExtractCounts(INTEGER8 Day) := FUNCTION

		// today     := '20131010';//ut.GetDate;
		today 		:= (STRING)Day;
		senderID	:= 'Arjun.Mudunuru@lexisnexis.com';
		IVEmail		:= 'Arjun.Mudunuru@lexisnexis.com,sanjay.narla@lexisnexis.com';

		diffday(string8 d) := case(	ut.Weekday((unsigned)d),  'SUNDAY' => 1,
																													'MONDAY' => 2,
																													'TUESDAY' => 3,
																													'WEDNESDAY' => 4,
																													'THURSDAY' => 5,
																													'FRIDAY' => 6,
																													'SATURDAY' => 7,
														 7);

		day_of_week := diffday(today);

		day_of_week_txt := MAP(day_of_week=1 => 'Sunday',
													 day_of_week=2 => 'Monday',
													 day_of_week=3 => 'Tuesday',
													 day_of_week=4 => 'Wednesday',
													 day_of_week=5 => 'Thursday',
													 day_of_week=6 => 'Friday',
													 day_of_week=7 => 'Saturday',
													 '');

		//----------------------------------------------------------------------------------------------



		// Datasets for all three products


		fn_cc := '~insurview::extract::input::cc::';
		fn_clua := '~insurview::extract::input::clua::';
		fn_ncf := '~insurview::extract::input::ncf::';

		lay := record
		 string230 edits;
		 string1 termination 
		end;


		txl_cc 		:= dataset(fn_cc+today,lay,CSV(SEPARATOR(''), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(4096)));
		txl_clue 	:= dataset(fn_clua+today,lay,thor);
		txl_NCF   := dataset(fn_ncf+today,lay,thor);

		//------------------------------------------------------------------------------------------


		//Counts across all three products
		cc_cnt 		 := count(txl_cc(StringLib.StringFind(edits, 'RI51',1) >0));
		clue_cnt 	 := count(txl_clue(StringLib.StringFind(edits, 'RI51',1) >0));
		NCF_cnt    := count(txl_NCF(StringLib.StringFind(edits, 'RI51',1) >0));

		//----------------------------------------------------------------------------------------

		// Get average counts for last nine weeks

		set of string datelist := [ut.date_math(today,-7),ut.date_math(today,-14),ut.date_math(today,-21),
															 ut.date_math(today,-28),ut.date_math(today,-35),ut.date_math(today,-42),
															 ut.date_math(today,-49),ut.date_math(today,-56),ut.date_math(today,-63)];



		archive_cc 		:= dataset(fn_cc+datelist[1],lay,CSV(SEPARATOR(''), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(4096)),opt)+dataset(fn_cc+datelist[2],lay,CSV(SEPARATOR(''), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(4096)),opt)+dataset(fn_cc+datelist[3],lay,CSV(SEPARATOR(''), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(4096)),opt)+
										 dataset(fn_cc+datelist[4],lay,CSV(SEPARATOR(''), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(4096)),opt)+dataset(fn_cc+datelist[5],lay,CSV(SEPARATOR(''), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(4096)),opt)+dataset(fn_cc+datelist[6],lay,CSV(SEPARATOR(''), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(4096)),opt)+
										 dataset(fn_cc+datelist[7],lay,CSV(SEPARATOR(''), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(4096)),opt)+dataset(fn_cc+datelist[8],lay,CSV(SEPARATOR(''), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(4096)),opt)+dataset(fn_cc+datelist[9],lay,CSV(SEPARATOR(''), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(4096)),opt);

		archive_clua 	:= dataset(fn_clua+datelist[1],lay,thor,opt)+dataset(fn_clua+datelist[2],lay,thor,opt)+dataset(fn_clua+datelist[3],lay,thor,opt)+
										 dataset(fn_clua+datelist[4],lay,thor,opt)+dataset(fn_clua+datelist[5],lay,thor,opt)+dataset(fn_clua+datelist[6],lay,thor,opt)+
										 dataset(fn_clua+datelist[7],lay,thor,opt)+dataset(fn_clua+datelist[8],lay,thor,opt)+dataset(fn_clua+datelist[9],lay,thor,opt);

		archive_NCF   := dataset(fn_ncf+datelist[1],lay,thor,opt)+dataset(fn_ncf+datelist[2],lay,thor,opt)+dataset(fn_ncf+datelist[3],lay,thor,opt)+
										 dataset(fn_ncf+datelist[4],lay,thor,opt)+dataset(fn_ncf+datelist[5],lay,thor,opt)+dataset(fn_ncf+datelist[6],lay,thor,opt)+
										 dataset(fn_ncf+datelist[7],lay,thor,opt)+dataset(fn_ncf+datelist[8],lay,thor,opt)+dataset(fn_ncf+datelist[9],lay,thor,opt);



		cc_cnt_avg_1   := round((count(archive_cc(Edits[7..10] = 'RI51'))))/9;
		clua_cnt_avg_1 := round((count(archive_clua(Edits[7..10] = 'RI51'))))/1;
		ncf_cnt_avg_1  := round((count(archive_NCF(Edits[7..10] = 'RI51'))))/9;

		//-------------------------------------------------------------------------------------------


		// Logic to decide on bad counts
		threshold_pct := 0.3;
		// cc_cnt_avg    := cc_cnt_avg_1-(cc_cnt_avg_1*threshold_pct);

		cc_cnt_avg  := MAP(day_of_week_txt = 'Saturday' => 115000,
												 day_of_week_txt = 'Sunday' => 70000,
												 325000);

		clua_cnt_avg  := MAP(day_of_week_txt = 'Saturday' => 200000,
												 day_of_week_txt = 'Sunday' => 115000,
												 620000);//clua_cnt_avg_1-(clua_cnt_avg_1*threshold_pct);
												 
		// ncf_cnt_avg   := ncf_cnt_avg_1-(ncf_cnt_avg_1*threshold_pct);

		ncf_cnt_avg  := MAP(day_of_week_txt = 'Saturday' => 125000,
												 day_of_week_txt = 'Sunday' => 30000,
												 350000);

		boolean flg_bad_cc      := if(cc_cnt <= cc_cnt_avg, true,false);
		boolean flg_bad_clue    := if(clue_cnt <= clua_cnt_avg, true,false);
		boolean flg_bad_ncf     := if(ncf_cnt <= ncf_cnt_avg, true,false);


		string cc_msg      := 'Stats for CC for '+today+'('+trim(day_of_week_txt)+')'+'\n'
													+'Report Count for CC : '+(string) cc_cnt+'\n'
													+'Expected Report Count for CC: '+(string) cc_cnt_avg;

		string clua_msg    := 'Stats for CLUA for '+today+'('+trim(day_of_week_txt)+')'+'\n'
													+'Report Count for CLUA : '+(string) clue_cnt+'\n'
													+'Expected Report Count for CLUA: '+(string) clua_cnt_avg;


		string ncf_msg      := 'Stats for NCF for '+today+'('+trim(day_of_week_txt)+')'+'\n'
													+'Report Count for NCF : '+(string) ncf_cnt+'\n'
													+'Expected Report Count for NCF: '+(string) ncf_cnt_avg;
																 

		string Body  := cc_msg+'\n'+
										''+'\n'+
										clua_msg+'\n'+
										''+'\n'+
										ncf_msg;                                    
										 
		bademail   := FileServices.SendEmail(IVEmail, 'Bad Counts for ' + today,Body, , , );
		goodemail  := FileServices.SendEmail(IVEmail, 'Good Counts for ' + today,Body, , , );

		// IntermediateStats := if(flg_bad_cc or flg_bad_clue or flg_bad_ncf,bademail,goodemail);
		
		IntermediateStats := if(flg_bad_cc or flg_bad_clue or flg_bad_ncf,sequential(bademail,FAIL('Bad counts for '+ today)),goodemail);

		Return IntermediateStats;
		
END;