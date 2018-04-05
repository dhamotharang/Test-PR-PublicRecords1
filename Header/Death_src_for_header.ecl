IMPORT	MDR, Death_Master;
EXPORT	Death_src_for_header(string st,string src,string date)
					:=
					map(
							src='OBD' => 'OB'
							,src='TRB' => 'TR'
							,src in ['CAL','FLA','GAA','MIC','MNT','NEV','OHI','VGA']
									=> case(st
													,'CA' => 'D0'
													,'CT' => 'D1'
													,'FL' => 'D2'
													,'GA' => 'D3'
													,'KY' => 'D4'
													,'MA' => 'D5'
													,'ME' => 'D6'
													,'MI' => 'D7'
													,'MN' => 'D8'
													,'MT' => 'D9'
													,'NV' => 'D!'
													,'NC' => 'D#'
													,'OH' => 'D@'
													,'VA' =>	MDR.sourceTools.src_Death_VA
													,'')
							,src='SSA' and Death_Master.isDateSSARestricted(date)	=>	MDR.sourceTools.src_Death_Restricted
						  ,src='OKC' =>	MDR.sourceTools.src_OKC_Probate
							,'DE');