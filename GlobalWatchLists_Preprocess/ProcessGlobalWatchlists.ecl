IMPORT _control, GlobalWatchLists, GlobalWatchLists_Preprocess, mdr, ut, std;
#option('multiplePersistInstances',FALSE);

	allsrcs := GlobalWatchLists_Preprocess.ProcessBankOfEngland + 
						 GlobalWatchLists_Preprocess.ProcessDebarredparties + 
						 GlobalWatchLists_Preprocess.ProcessDeniedEntity + 
						 GlobalWatchLists_Preprocess.ProcessDeniedPersons + 
						 GlobalWatchLists_Preprocess.ProcessEUTerroristList +
						 GlobalWatchLists_Preprocess.ProcessForeignAgents + 
						 GlobalWatchLists_Preprocess.ProcessInnovativeSystems + 
						 GlobalWatchLists_Preprocess.ProcessInterpolMostWanted + 
						 GlobalWatchLists_Preprocess.ProcessOFAC + 
						 GlobalWatchLists_Preprocess.ProcessOFAC_PLC +
						 GlobalWatchLists_Preprocess.ProcessOSFICanada + 
						 GlobalWatchLists_Preprocess.ProcessStateDeptForeignTerrorist + 
						 GlobalWatchLists_Preprocess.ProcessStateDeptTerroristExclusion + 
						 GlobalWatchLists_Preprocess.ProcessUnverified +
						 GlobalWatchLists_Preprocess.ProcessWorldBank : PERSIST('~persist::globalwatchlists::raw_common_out');
	
EXPORT ProcessGlobalWatchlists(string filedate) := FUNCTION
	
	rOutLayout RemoveBadCharsfromAddresANDNames(rOutLayout L) := TRANSFORM	
		v_addr_clean							:= regexreplace('[^ -~]', L.addr_clean, '');
	  self.addr_1 							:= regexreplace('[^ -~]', L.addr_1, '') ;
		self.addr_2 							:= regexreplace('[^ -~]', L.addr_2, '');
		self.addr_3 							:= regexreplace('[^ -~]', L.addr_3, '');
		self.orig_address_line_1 	:= regexreplace('[^ -~]', L.orig_address_line_1, '');
		self.orig_address_line_2 	:= regexreplace('[^ -~]', L.orig_address_line_2, '');
		self.orig_address_line_3 	:= regexreplace('[^ -~]', L.orig_address_line_3, '');
		self.remarks_1 						:= regexreplace('[^ -~]', L.remarks_1, '');
		self.remarks_2 						:= regexreplace('[^ -~]', L.remarks_2, '');
		self.remarks_3 						:= regexreplace('[^ -~]', L.remarks_3, '');
		self.remarks_4 						:= regexreplace('[^ -~]', L.remarks_4, '');
		self.remarks_5 						:= regexreplace('[^ -~]', L.remarks_5, '');
		self.remarks_6 						:= regexreplace('[^ -~]', L.remarks_6, '');
		self.remarks_7 						:= regexreplace('[^ -~]', L.remarks_7, '');
		self.remarks_8 						:= regexreplace('[^ -~]', L.remarks_8, '');
		self.remarks_9 						:= regexreplace('[^ -~]', L.remarks_9, '');
		self.orig_pty_name 				:= regexreplace('[^ -~]', L.orig_pty_name, '');
		self.pname_clean 					:= regexreplace('[^ -~]',L.pname_clean, '');
		//self.addr_clean :1: regexreplace('[^ -~]', L.addr_clean, '');
		self.addr_clean 					:= if(v_addr_clean[179..180] <> 'E5' 
																			and v_addr_clean[179..182] <> 'E213'
																			and v_addr_clean[179..182] <> 'E101'
																		,v_addr_clean
																		,'');
		self.cname_clean 					:= regexreplace('[^ -~]', L.cname_clean, '');
		self.orig_first_name 			:= if(L.orig_giv_designator = 'I' and TRIM(L.orig_first_name, left, right) <> ''
																		,regexreplace(' BEN$| BIN$| AL$| EL$', TRIM(L.orig_first_name, left, right), '')
																		,if(L.orig_giv_designator = 'I'
																				and TRIM(L.orig_first_name, left, right) = ''
																				and TRIM(L.orig_last_name) = ''
																			,TRIM(L.pname_clean[6..25], left, right)
																				+ ' '
																				+ TRIM(regexreplace('^BEN$|^BIN$| BEN$| BIN$|^AL$| AL$|^EL$| EL$', TRIM(L.pname_clean[26..45], left, right), ''), left, right)                                                                      
																			,''));
		self.orig_last_name 			:= if(L.orig_giv_designator = 'I' and TRIM(L.orig_last_name, left, right) <> ''
																		,regexreplace(' BEN$| BIN$| AL$| EL$', TRIM(L.orig_last_name, left, right), '')
																		,if(L.orig_giv_designator = 'I'
																				and TRIM(L.orig_first_name, left, right) = ''
																				and TRIM(L.orig_last_name) = ''
																			,TRIM(L.pname_clean[46..65], left, right)
																				+ ' '
																				+ TRIM(regexreplace('^BEN$|^BIN$| BEN$| BIN$|^AL$| AL$|^EL$| EL$', TRIM(L.pname_clean[66..70], left, right), ''), left, right)                                                                      
																			,''));

		self := L;
	END;
	
	pCleanNameAddr	:=  SORT(PROJECT(allsrcs, RemoveBadCharsfromAddresANDNames(left)),pty_key);
	
		//Function to parse out remarks and address fields to fit output layout
	get_remaining (string removestring, string fullstring) := function

		remaining1 := MAP(regexfind('[()?:/]',removestring) => trim(fullstring[length(removestring)+1..],left,right),
                  trim(regexreplace(removestring,fullstring,''),left,right));
		remaining2 := IF(remaining1[1..3] = '| |', remaining1[4..],
										IF(remaining1[1..1] = '|',remaining1[2..],remaining1));

	return remaining2;
	end;

	parse_addr (string paddress) := function

		out_addr   :=   map(regexfind('^([-)(A-Z0-9\\.,:;?/ ]+)[0-9]*[ ]|(.*)',paddress[1..50])   => regexreplace('^([-)(A-Z0-9\\.,:;?/ ]+)[0-9]*[ ]|(.*)',paddress[1..50],'$1'), 
												regexfind('^([-)(A-Z0-9\\.,:;?/ ]+)[0-9]*[ ]([-A-Z0-9\\.,/ ]*)+$',paddress[1..50]) => regexreplace('^([-)(A-Z0-9\\.,:;?/ ]+)[0-9]*[ ]([-A-Z0-9\\., ]*)+$',paddress[1..50],'$1'),'');
	return out_addr;
	end;
	
		parse_remark (string premark) := function
		
		out_remark   :=   map(regexfind('^([-â€™#)(A-Z0-9\\.,:;?/ ]+)[-A-Z0-9]*[ ]|(.*)',premark[1..75])   => regexreplace('^([-â€™#)(A-Z0-9\\.,:;?/ ]+)[-A-Z0-9]*[ ]|(.*)',premark[1..75],'$1'), 
                          regexfind('^([-â€™#)(A-Z0-9\\.,:;?/ ]+)[ ]([-A-Z0-9\\.,:/â€ ]*)+$',premark[1..75]) => regexreplace('^([-â€™#)(A-Z0-9\\.,:;?/ ]+)[ ]([-A-Z0-9\\.,:/â€ ]*)+$',premark[1..75],'$1'),'');

	return out_remark;
	end;
	
	//Project into final GWL layout and append FIN history
	GlobalWatchLists.Layout_GlobalWatchLists xformFinalLayout(pCleanNameAddr L) := TRANSFORM
	//Parse Address fields to fit output
		TempConcatAddr	:= STD.Str.FindReplace(REGEXREPLACE('^TELEPHONE:(.*)|^\\+[0-9](.*)',STD.Str.ToUpperCase(STD.Str.CleanSpaces(L.addr_1+'|'+L.addr_2+'|'+L.addr_3+'|')),''),'#','');
		tempAddr_1			:= MAP(regexfind('[|]',TempConcatAddr[51..51],0) <> '' and TempConcatAddr[51..51] =' ' => TempConcatAddr[1..50],
														regexfind('[|]',TempConcatAddr[51..51],0) <> '' and TempConcatAddr[50..50] =' ' => TempConcatAddr[1..50],
														regexfind('[|]',TempConcatAddr[51..51],0) = '' and TempConcatAddr[51..51] <>' ' => TempConcatAddr[1..50],
														regexfind('[|]',TempConcatAddr[51..51],0) = '' and TempConcatAddr[50..50] <>' ' => TempConcatAddr[1..50],
														parse_addr(TempConcatAddr));
		x2							:= get_remaining(tempAddr_1, TempConcatAddr);
		tempAddr_2			:= MAP(regexfind('[|]',x2[51..51],0) <> '' and x2[51..51] =' ' => x2[1..50],
														regexfind('[|]',x2[51..51],0) <> '' and x2[50..50] =' ' => x2[1..50],
														regexfind('[|]',x2[51..51],0) = '' and x2[51..51] <>' ' => x2[1..50],
														regexfind('[|]',x2[51..51],0) = '' and x2[50..50] <>' ' => x2[1..50],
														parse_addr(x2));
		x3							:= get_remaining(tempAddr_2, x2);
		tempAddr_3			:= MAP(regexfind('[|]',x3[51..51],0) <> '' and x3[51..51] =' ' => x3[1..50],
														regexfind('[|]',x3[51..51],0) <> '' and x3[50..50] =' ' => x3[1..50],
														regexfind('[|]',x3[51..51],0) = '' and x3[51..51] <>' ' => x3[1..50],
														regexfind('[|]',x3[51..51],0) = '' and x3[50..50] <>' ' => x3[1..50],
														parse_addr(x3));
		x4							:= get_remaining(tempAddr_3,x3);
		tempAddr_4			:= MAP(regexfind('[|]',x4[51..51],0) <> '' and x4[51..51] =' ' => x4[1..50],
														regexfind('[|]',x4[51..51],0) <> '' and x4[50..50] =' ' => x4[1..50],
														regexfind('[|]',x4[51..51],0) = '' and x4[51..51] <>' ' => x4[1..50],
														regexfind('[|]',x4[51..51],0) = '' and x4[50..50] <>' ' => x4[1..50],
														parse_addr(x4));
		x5							:= get_remaining(tempAddr_4,x4);
		tempAddr_5			:= MAP(regexfind('[|]',x5[51..51],0) <> '' and x5[51..51] =' ' => x5[1..50],
														regexfind('[|]',x5[51..51],0) <> '' and x5[50..50] =' ' => x5[1..50], 
														regexfind('[|]',x5[51..51],0) = '' and x5[51..51] <>' ' => x5[1..50],
														regexfind('[|]',x5[51..51],0) = '' and x5[50..50] <>' ' => x5[1..50],
														parse_addr(x5));
		x6							:= get_remaining(tempAddr_5,x5);
		tempAddr_6			:= MAP(regexfind('[|]',x6[51..51],0) <> '' and x6[51..51] =' ' => x6[1..50],
														regexfind('[|]',x6[51..51],0) <> '' and x6[50..50] =' ' => x6[1..50],
														regexfind('[|]',x6[51..51],0) = '' and x6[51..51] <>' ' => x6[1..50],
														regexfind('[|]',x6[51..51],0) = '' and x6[50..50] <>' ' => x6[1..50],
														parse_addr(x6));
		x7							:= get_remaining(tempAddr_6,x6);
		tempAddr_7			:= MAP(regexfind('[|]',x7[51..51],0) <> '' and x7[51..51] =' ' => x7[1..50],
														regexfind('[|]',x7[51..51],0) <> '' and x7[50..50] =' ' => x7[1..50],
														regexfind('[|]',x7[51..51],0) = '' and x7[51..51] <>' ' => x7[1..50],
														regexfind('[|]',x7[51..51],0) = '' and x7[50..50] <>' ' => x7[1..50],
														parse_addr(x7));
		x8							:= get_remaining(tempAddr_7,x7);
		tempAddr_8			:= MAP(regexfind('[|]',x8[51..51],0) <> '' and x8[51..51] =' ' => x8[1..50],
														regexfind('[|]',x8[51..51],0) <> '' and x8[50..50] =' ' => x8[1..50],
														regexfind('[|]',x8[51..51],0) = '' and x8[51..51] <>' ' => x8[1..50],
														regexfind('[|]',x8[51..51],0) = '' and x8[50..50] <>' ' => x8[1..50],
														parse_addr(x8));
		x9							:= get_remaining(tempAddr_8,x8);
		tempAddr_9			:= MAP(regexfind('[|]',x9[51..51],0) <> '' and x9[51..51] =' ' => x9[1..50],
														regexfind('[|]',x9[51..51],0) <> '' and x9[50..50] =' ' => x9[1..50],
														regexfind('[|]',x9[51..51],0) = '' and x9[51..51] <>' ' => x9[1..50],
														regexfind('[|]',x9[51..51],0) = '' and x9[50..50] <>' ' => x9[1..50],
														parse_addr(x9));
		x10							:= get_remaining(tempAddr_9,x9);
		tempAddr_10			:= MAP(regexfind('[|]',x10[51..51],0) <> '' and x10[51..51] =' ' => x10[1..50],
														regexfind('[|]',x10[51..51],0) <> '' and x10[50..50] =' ' => x10[1..50], 
														regexfind('[|]',x10[51..51],0) = '' and x10[51..51] <>' ' => x10[1..50],
														regexfind('[|]',x10[51..51],0) = '' and x10[50..50] <>' ' => x10[1..50],
														parse_addr(x10));
		self.addr_1			:= REGEXREPLACE('[|]',tempAddr_1,'');
		self.addr_2			:= REGEXREPLACE('[|]',tempAddr_2,'');
		self.addr_3			:= REGEXREPLACE('[|]',tempAddr_3,'');
		self.addr_4			:= REGEXREPLACE('[|]',tempAddr_4,'');
		self.addr_5			:= REGEXREPLACE('[|]',tempAddr_5,'');
		self.addr_6			:= REGEXREPLACE('[|]',tempAddr_6,'');
		self.addr_7			:= REGEXREPLACE('[|]',tempAddr_7,'');
		self.addr_8			:= REGEXREPLACE('[|]',tempAddr_8,'');
		self.addr_9			:= REGEXREPLACE('[|]',tempAddr_9,'');
		self.addr_10		:= REGEXREPLACE('[|]',tempAddr_10,'');
		
		//Parse Remarks fields to fit output
		TempConcatRemark	:= STD.Str.ToUpperCase(TRIM(REGEXREPLACE('[| |]{2,}',
																															REGEXREPLACE('^[| |]+',STD.Str.FindReplace(STD.Str.CleanSpaces(L.remarks_1+'|'+L.remarks_2+'|'+L.remarks_3+'|'+
																																																																							L.remarks_4+'|'+L.remarks_5+'|'+L.remarks_6+'|'+
																																																																							L.remarks_7+'|'+L.remarks_8+'|'+L.remarks_9+'|'),'+','')
																																					,'')
																															,' |')
																																			
																										,left,right));
		tempRemark_1			:= MAP(regexfind('[|]',TempConcatRemark[76..76],0) <> '' and TempConcatRemark[76..76] =' ' => TempConcatRemark[1..75],
                             regexfind('[|]',TempConcatRemark[76..76],0) <> '' and TempConcatRemark[75..75] =' ' => TempConcatRemark[1..75],
														 regexfind('[|]',TempConcatRemark[76..76],0) = '' and TempConcatRemark[76..76] <>' ' => TempConcatRemark[1..75],
														 regexfind('[|]',TempConcatRemark[76..76],0) = '' and TempConcatRemark[75..75] <>' ' => TempConcatRemark[1..75],
                             parse_remark(TempConcatRemark));
		remain2						:= get_remaining(tempRemark_1, TempConcatRemark);
		tempRemark_2			:= MAP(regexfind('[|]',remain2[76..76],0) <> '' and remain2[76..76] =' ' => remain2[1..75],
														regexfind('[|]',remain2[76..76],0) <> '' and remain2[75..75] =' ' => remain2[1..75],
														regexfind('[|]',remain2[76..76],0) = '' and remain2[76..76] <>' ' => remain2[1..75],
														regexfind('[|]',remain2[76..76],0) = '' and remain2[75..75] <>' ' => remain2[1..75],
														parse_remark(remain2));
		remain3						:= get_remaining(tempRemark_2, remain2);
		tempRemark_3			:= MAP(regexfind('[|]',remain3[76..76],0) <> '' and remain3[76..76] =' ' => remain3[1..75],
														regexfind('[|]',remain3[76..76],0) <> '' and remain3[75..75] =' ' => remain3[1..75],
														regexfind('[|]',remain3[76..76],0) = '' and remain3[76..76] <>' ' => remain3[1..75],
														regexfind('[|]',remain3[76..76],0) = '' and remain3[75..75] <>' ' => remain3[1..75],
														parse_remark(remain3));
		remain4						:= get_remaining(tempRemark_3,remain3);
		tempRemark_4			:= MAP(regexfind('[|]',remain4[76..76],0) <> '' and remain4[76..76] =' ' => remain4[1..75],
														regexfind('[|]',remain4[76..76],0) <> '' and remain4[75..75] =' ' => remain4[1..75],
														regexfind('[|]',remain4[76..76],0) = '' and remain4[76..76] <>' ' => remain4[1..75],
														regexfind('[|]',remain4[76..76],0) = '' and remain4[75..75] <>' ' => remain4[1..75],
														parse_remark(remain4));
		remain5						:= get_remaining(tempRemark_4,remain4);
		tempRemark_5			:= MAP(regexfind('[|]',remain5[76..76],0) <> '' and remain5[76..76] =' ' => remain5[1..75],
														regexfind('[|]',remain5[76..76],0) <> '' and remain5[75..75] =' ' => remain5[1..75],
														regexfind('[|]',remain5[76..76],0) = '' and remain5[76..76] <>' ' => remain5[1..75],
														regexfind('[|]',remain5[76..76],0) = '' and remain5[75..75] <>' ' => remain5[1..75],
														parse_remark(remain5));
		remain6						:= get_remaining(tempRemark_5,remain5);
		tempRemark_6			:= MAP(regexfind('[|]',remain6[76..76],0) <> '' and remain6[76..76] =' ' => remain6[1..75],
														regexfind('[|]',remain6[76..76],0) <> '' and remain6[75..75] =' ' => remain6[1..75],
														regexfind('[|]',remain6[76..76],0) = '' and remain6[76..76] <>' ' => remain6[1..75],
														regexfind('[|]',remain6[76..76],0) = '' and remain6[75..75] <>' ' => remain6[1..75],
														parse_remark(remain6));
		remain7						:= get_remaining(tempRemark_6,remain6);
		tempRemark_7			:= MAP(regexfind('[|]',remain7[76..76],0) <> '' and remain7[76..76] =' ' => remain7[1..75],
														regexfind('[|]',remain7[76..76],0) <> '' and remain7[75..75] =' ' => remain7[1..75],
														regexfind('[|]',remain7[76..76],0) = '' and remain7[76..76] <>' ' => remain7[1..75],
														regexfind('[|]',remain7[76..76],0) = '' and remain7[75..75] <>' ' => remain7[1..75],
														parse_remark(remain7));
		remain8						:= get_remaining(tempRemark_7,remain7);
		tempRemark_8			:= MAP(regexfind('[|]',remain8[76..76],0) <> '' and remain8[76..76] =' ' => remain8[1..75],
														regexfind('[|]',remain8[76..76],0) <> '' and remain8[75..75] =' ' => remain8[1..75],
														regexfind('[|]',remain8[76..76],0) = '' and remain8[76..76] <>' ' => remain8[1..75],
														regexfind('[|]',remain8[76..76],0) = '' and remain8[75..75] <>' ' => remain8[1..75],
														parse_remark(remain8));
		remain9						:= get_remaining(tempRemark_8,remain8);
		tempRemark_9			:= MAP(regexfind('[|]',remain9[76..76],0) <> '' and remain9[76..76] =' ' => remain9[1..75],
														regexfind('[|]',remain9[76..76],0) <> '' and remain9[75..75] =' ' => remain9[1..75],
														regexfind('[|]',remain9[76..76],0) = '' and remain9[76..76] <>' ' => remain9[1..75],
														regexfind('[|]',remain9[76..76],0) = '' and remain9[75..75] <>' ' => remain9[1..75],
														parse_remark(remain9));
		remain10					:= get_remaining(tempRemark_9,remain9);
		tempRemark_10			:= MAP(regexfind('[|]',remain10[76..76],0) <> '' and remain10[76..76] =' ' => remain10[1..75],
														regexfind('[|]',remain10[76..76],0) <> '' and remain10[75..75] =' ' => remain10[1..75],
														regexfind('[|]',remain10[76..76],0) = '' and remain10[76..76] <>' ' => remain10[1..75],
														regexfind('[|]',remain10[76..76],0) = '' and remain10[75..75] <>' ' => remain10[1..75],
														parse_remark(remain10));
		remain11					:= get_remaining(tempRemark_10,remain10);
		tempRemark_11			:= MAP(regexfind('[|]',remain11[76..76],0) <> '' and remain11[76..76] =' ' => remain11[1..75],
														regexfind('[|]',remain11[76..76],0) <> '' and remain11[75..75] =' ' => remain11[1..75],
														regexfind('[|]',remain11[76..76],0) = '' and remain11[76..76] <>' ' => remain11[1..75],
														regexfind('[|]',remain11[76..76],0) = '' and remain11[75..75] <>' ' => remain11[1..75],
														parse_remark(remain11));
		remain12					:= get_remaining(tempRemark_11,remain11);
		tempRemark_12			:= MAP(regexfind('[|]',remain12[76..76],0) <> '' and remain12[76..76] =' ' => remain12[1..75],
														regexfind('[|]',remain12[76..76],0) <> '' and remain12[75..75] =' ' => remain12[1..75],
														regexfind('[|]',remain12[76..76],0) = '' and remain12[76..76] <>' ' => remain12[1..75],
														regexfind('[|]',remain12[76..76],0) = '' and remain12[75..75] <>' ' => remain12[1..75],
														parse_remark(remain12));
		remain13					:= get_remaining(tempRemark_12,remain12);
		tempRemark_13			:= MAP(regexfind('[|]',remain13[76..76],0) <> '' and remain13[76..76] =' ' => remain13[1..75],
														regexfind('[|]',remain13[76..76],0) <> '' and remain13[75..75] =' ' => remain13[1..75],
														regexfind('[|]',remain13[76..76],0) = '' and remain13[76..76] <>' ' => remain13[1..75],
														regexfind('[|]',remain13[76..76],0) = '' and remain13[75..75] <>' ' => remain13[1..75],
														parse_remark(remain13));
		remain14					:= get_remaining(tempRemark_13,remain13);
		tempRemark_14			:= MAP(regexfind('[|]',remain14[76..76],0) <> '' and remain14[76..76] =' ' => remain14[1..75],
														regexfind('[|]',remain14[76..76],0) <> '' and remain14[75..75] =' ' => remain14[1..75],
														regexfind('[|]',remain14[76..76],0) = '' and remain14[76..76] <>' ' => remain14[1..75],
														regexfind('[|]',remain14[76..76],0) = '' and remain14[75..75] <>' ' => remain14[1..75],
														parse_remark(remain14));
		remain15					:= get_remaining(tempRemark_14,remain14);
		tempRemark_15			:= MAP(regexfind('[|]',remain15[76..76],0) <> '' and remain15[76..76] =' ' => remain15[1..75],
														regexfind('[|]',remain15[76..76],0) <> '' and remain15[75..75] =' ' => remain15[1..75],
														regexfind('[|]',remain15[76..76],0) = '' and remain15[76..76] <>' ' => remain15[1..75],
														regexfind('[|]',remain15[76..76],0) = '' and remain15[75..75] <>' ' => remain15[1..75],
														parse_remark(remain15));
		remain16					:= get_remaining(tempRemark_15,remain15);
		tempRemark_16			:= MAP(regexfind('[|]',remain16[76..76],0) <> '' and remain16[76..76] =' ' => remain16[1..75],
														regexfind('[|]',remain16[76..76],0) <> '' and remain16[75..75] =' ' => remain16[1..75],
														regexfind('[|]',remain16[76..76],0) = '' and remain16[76..76] <>' ' => remain16[1..75],
														regexfind('[|]',remain16[76..76],0) = '' and remain16[75..75] <>' ' => remain16[1..75],
														parse_remark(remain16));
		remain17						:= get_remaining(tempRemark_16, remain16);
		tempRemark_17			:= MAP(regexfind('[|]',remain17[76..76],0) <> '' and remain17[76..76] =' ' => remain17[1..75],
														regexfind('[|]',remain17[76..76],0) <> '' and remain17[75..75] =' ' => remain17[1..75],
														regexfind('[|]',remain17[76..76],0) = '' and remain17[76..76] <>' ' => remain17[1..75],
														regexfind('[|]',remain17[76..76],0) = '' and remain17[75..75] <>' ' => remain17[1..75],
														parse_remark(remain17));
		remain18						:= get_remaining(tempRemark_17, remain17);
		tempRemark_18			:= MAP(regexfind('[|]',remain18[76..76],0) <> '' and remain18[76..76] =' ' => remain18[1..75],
														regexfind('[|]',remain18[76..76],0) <> '' and remain18[75..75] =' ' => remain18[1..75],
														regexfind('[|]',remain18[76..76],0) = '' and remain18[76..76] <>' ' => remain18[1..75],
														regexfind('[|]',remain18[76..76],0) = '' and remain18[75..75] <>' ' => remain18[1..75],
														parse_remark(remain18));
		remain19						:= get_remaining(tempRemark_18,remain18);
		tempRemark_19			:= MAP(regexfind('[|]',remain19[76..76],0) <> '' and remain19[76..76] =' ' => remain19[1..75],
														regexfind('[|]',remain19[76..76],0) <> '' and remain19[75..75] =' ' => remain19[1..75],
														regexfind('[|]',remain19[76..76],0) = '' and remain19[76..76] <>' ' => remain19[1..75],
														regexfind('[|]',remain19[76..76],0) = '' and remain19[75..75] <>' ' => remain19[1..75],
														parse_remark(remain19));
		remain20						:= get_remaining(tempRemark_19,remain19);
		tempRemark_20			:= MAP(regexfind('[|]',remain20[76..76],0) <> '' and remain20[76..76] =' ' => remain20[1..75],
														regexfind('[|]',remain20[76..76],0) <> '' and remain20[75..75] =' ' => remain20[1..75], 
														regexfind('[|]',remain20[76..76],0) = '' and remain20[76..76] <>' ' => remain20[1..75],
														regexfind('[|]',remain20[76..76],0) = '' and remain20[75..75] <>' ' => remain20[1..75],
														parse_remark(remain20));
		remain21						:= get_remaining(tempRemark_20,remain20);
		tempRemark_21			:= MAP(regexfind('[|]',remain21[76..76],0) <> '' and remain21[76..76] =' ' => remain21[1..75],
														regexfind('[|]',remain21[76..76],0) <> '' and remain21[75..75] =' ' => remain21[1..75],
														regexfind('[|]',remain21[76..76],0) = '' and remain21[76..76] <>' ' => remain21[1..75],
														regexfind('[|]',remain21[76..76],0) = '' and remain21[75..75] <>' ' => remain21[1..75],
														parse_remark(remain21));
		remain22						:= get_remaining(tempRemark_21,remain21);
		tempRemark_22			:= MAP(regexfind('[|]',remain22[76..76],0) <> '' and remain22[76..76] =' ' => remain22[1..75],
														regexfind('[|]',remain22[76..76],0) <> '' and remain22[75..75] =' ' => remain22[1..75], 
														parse_remark(remain22));
		remain23						:= get_remaining(tempRemark_22,remain22);
		tempRemark_23			:= MAP(regexfind('[|]',remain23[76..76],0) <> '' and remain23[76..76] =' ' => remain23[1..75],
														regexfind('[|]',remain23[76..76],0) <> '' and remain23[75..75] =' ' => remain23[1..75],
														regexfind('[|]',remain23[76..76],0) = '' and remain23[76..76] <>' ' => remain23[1..75],
														regexfind('[|]',remain23[76..76],0) = '' and remain23[75..75] <>' ' => remain23[1..75],
														parse_remark(remain23));
		remain24						:= get_remaining(tempRemark_23,remain23);
		tempRemark_24			:= MAP(regexfind('[|]',remain24[76..76],0) <> '' and remain24[76..76] =' ' => remain24[1..75],
														regexfind('[|]',remain24[76..76],0) <> '' and remain24[75..75] =' ' => remain24[1..75], 
														regexfind('[|]',remain24[76..76],0) = '' and remain24[76..76] <>' ' => remain24[1..75],
														regexfind('[|]',remain24[76..76],0) = '' and remain24[75..75] <>' ' => remain24[1..75],
														parse_remark(remain24));
		remain25					:= get_remaining(tempRemark_24,remain24);
		tempRemark_25			:= MAP(regexfind('[|]',remain25[76..76],0) <> '' and remain25[76..76] =' ' => remain25[1..75],
														regexfind('[|]',remain25[76..76],0) <> '' and remain25[75..75] =' ' => remain25[1..75],
														regexfind('[|]',remain25[76..76],0) = '' and remain25[76..76] <>' ' => remain25[1..75],
														regexfind('[|]',remain25[76..76],0) = '' and remain25[75..75] <>' ' => remain25[1..75],
														parse_remark(remain25));
		remain26					:= get_remaining(tempRemark_25,remain25);
		tempRemark_26			:= MAP(regexfind('[|]',remain26[76..76],0) <> '' and remain26[76..76] =' ' => remain26[1..75],
														regexfind('[|]',remain26[76..76],0) <> '' and remain26[75..75] =' ' => remain26[1..75],
														regexfind('[|]',remain26[76..76],0) = '' and remain26[76..76] <>' ' => remain26[1..75],
														regexfind('[|]',remain26[76..76],0) = '' and remain26[75..75] <>' ' => remain26[1..75],
														parse_remark(remain26));
		remain27					:= get_remaining(tempRemark_26,remain26);
		tempRemark_27			:= MAP(regexfind('[|]',remain27[76..76],0) <> '' and remain27[76..76] =' ' => remain27[1..75],
														regexfind('[|]',remain27[76..76],0) <> '' and remain27[75..75] =' ' => remain27[1..75],
														regexfind('[|]',remain27[76..76],0) = '' and remain27[76..76] <>' ' => remain27[1..75],
														regexfind('[|]',remain27[76..76],0) = '' and remain27[75..75] <>' ' => remain27[1..75],
														parse_remark(remain27));
		remain28					:= get_remaining(tempRemark_27,remain27);
		tempRemark_28			:= MAP(regexfind('[|]',remain28[76..76],0) <> '' and remain28[76..76] =' ' => remain28[1..75],
														regexfind('[|]',remain28[76..76],0) <> '' and remain28[75..75] =' ' => remain28[1..75],
														regexfind('[|]',remain28[76..76],0) = '' and remain28[76..76] <>' ' => remain28[1..75],
														regexfind('[|]',remain28[76..76],0) = '' and remain28[75..75] <>' ' => remain28[1..75],
														parse_remark(remain28));
		remain29					:= get_remaining(tempRemark_28,remain28);
		tempRemark_29			:= MAP(regexfind('[|]',remain29[76..76],0) <> '' and remain29[76..76] =' ' => remain29[1..75],
														regexfind('[|]',remain29[76..76],0) <> '' and remain29[75..75] =' ' => remain29[1..75],
														regexfind('[|]',remain29[76..76],0) = '' and remain29[76..76] <>' ' => remain29[1..75],
														regexfind('[|]',remain29[76..76],0) = '' and remain29[75..75] <>' ' => remain29[1..75],
														parse_remark(remain29));
		remain30					:= get_remaining(tempRemark_29,remain29);
		tempRemark_30			:= MAP(regexfind('[|]',remain30[76..76],0) <> '' and remain30[76..76] =' ' => remain30[1..75],
														regexfind('[|]',remain30[76..76],0) <> '' and remain30[75..75] =' ' => remain30[1..75],
														regexfind('[|]',remain30[76..76],0) = '' and remain30[76..76] <>' ' => remain30[1..75],
														regexfind('[|]',remain30[76..76],0) = '' and remain30[75..75] <>' ' => remain30[1..75],
														parse_remark(remain30));
		self.remarks_1	:= REGEXREPLACE('[|]',tempRemark_1,'');
		self.remarks_2	:= REGEXREPLACE('[|]',tempRemark_2,'');
		self.remarks_3	:= REGEXREPLACE('[|]',tempRemark_3,'');
		self.remarks_4	:= REGEXREPLACE('[|]',tempRemark_4,'');
		self.remarks_5	:= REGEXREPLACE('[|]',tempRemark_5,'');
		self.remarks_6	:= REGEXREPLACE('[|]',tempRemark_6,'');
		self.remarks_7	:= REGEXREPLACE('[|]',tempRemark_7,'');
		self.remarks_8	:= REGEXREPLACE('[|]',tempRemark_8,'');
		self.remarks_9	:= REGEXREPLACE('[|]',tempRemark_9,'');
		self.remarks_10	:= REGEXREPLACE('[|]',tempRemark_10,'');
		self.remarks_11	:= REGEXREPLACE('[|]',tempRemark_11,'');
		self.remarks_12	:= REGEXREPLACE('[|]',tempRemark_12,'');
		self.remarks_13	:= REGEXREPLACE('[|]',tempRemark_13,'');
		self.remarks_14	:= REGEXREPLACE('[|]',tempRemark_14,'');
		self.remarks_15	:= REGEXREPLACE('[|]',tempRemark_15,'');
		self.remarks_16	:= REGEXREPLACE('[|]',tempRemark_16,'');
		self.remarks_17	:= REGEXREPLACE('[|]',tempRemark_17,'');
		self.remarks_18	:= REGEXREPLACE('[|]',tempRemark_18,'');
		self.remarks_19	:= REGEXREPLACE('[|]',tempRemark_19,'');
		self.remarks_20	:= REGEXREPLACE('[|]',tempRemark_20,'');
		self.remarks_21	:= REGEXREPLACE('[|]',tempRemark_21,'');
		self.remarks_22	:= REGEXREPLACE('[|]',tempRemark_22,'');
		self.remarks_23	:= REGEXREPLACE('[|]',tempRemark_23,'');
		self.remarks_24	:= REGEXREPLACE('[|]',tempRemark_24,'');
		self.remarks_25	:= REGEXREPLACE('[|]',tempRemark_25,'');
		self.remarks_26	:= REGEXREPLACE('[|]',tempRemark_26,'');
		self.remarks_27	:= REGEXREPLACE('[|]',tempRemark_27,'');
		self.remarks_28	:= REGEXREPLACE('[|]',tempRemark_28,'');
		self.remarks_29	:= REGEXREPLACE('[|]',tempRemark_29,'');
		self.remarks_30	:= REGEXREPLACE('[|]',tempRemark_30,'');
		self.cname	:= L.cname_clean;
		self.title	:= L.pname_clean[1..5];
		self.fname	:= L.pname_clean[6..25];
		self.mname	:= L.pname_clean[26..45];
		self.lname	:= L.pname_clean[46..65];
		self.suffix	:= L.pname_clean[66..70];
		self.a_score := L.pname_clean[71..73];
		self.prim_range 	:=  L.addr_clean[1..10];
    self.predir 			:= 	L.addr_clean[11..12];
    self.prim_name 		:= 	L.addr_clean[13..40];
    self.addr_suffix 	:= 	L.addr_clean[41..44];
    self.postdir 			:= 	L.addr_clean[45..46];
    self.unit_desig 	:= 	L.addr_clean[47..56];
    self.sec_range 		:= 	L.addr_clean[57..64];
    self.p_city_name 	:= 	L.addr_clean[65..89];
    self.v_city_name 	:= 	L.addr_clean[90..114];
    self.st 					:= 	L.addr_clean[115..116];
    self.zip 					:= 	L.addr_clean[117..121];
    self.zip4 				:= 	L.addr_clean[122..125];
    self.cart 				:= 	L.addr_clean[126..129];
    self.cr_sort_sz 	:= 	L.addr_clean[130];
    self.lot 					:= 	L.addr_clean[131..134];
    self.lot_order 		:= 	L.addr_clean[135];
    self.dpbc 				:= 	L.addr_clean[136..137];
    self.chk_digit 		:= 	L.addr_clean[138];
    self.record_type 	:= 	L.addr_clean[139..140];
		self.ace_fips_st 	:= 	L.addr_clean[141..142];
    self.county 			:= 	L.addr_clean[143..145];
    self.geo_lat 			:= 	L.addr_clean[146..155];
    self.geo_long 		:= 	L.addr_clean[156..166];
    self.msa 					:= 	L.addr_clean[167..170];
    self.geo_blk 			:= 	L.addr_clean[171..177];
    self.geo_match 		:= 	L.addr_clean[178];
    self.err_stat 		:= 	L.addr_clean[179..182];
		self.entity_id	:=			L.orig_entity_id;
		self.first_name	:=		L.orig_first_name;
		self.last_name	:=		L.orig_last_name;
		self.title_1	:=		L.orig_title_1;
		self.title_2	:=		L.orig_title_2;
		self.title_3	:=		L.orig_title_3;
		self.title_4	:=		L.orig_title_4;
		self.title_5	:=		L.orig_title_5;
		self.title_6	:=		L.orig_title_6;
		self.title_7	:=		L.orig_title_7;
		self.title_8	:=		L.orig_title_8;
		self.title_9	:=		L.orig_title_9;
		self.title_10	:=		L.orig_title_10;
		self.aka_id	:=			L.orig_aka_id;
		self.aka_type	:=			L.orig_aka_type;
		self.aka_category	:=			L.orig_aka_category;
		self.giv_designator	:=			L.orig_giv_designator;
		self.entity_type	:=			L.orig_entity_type;
		self.address_id	:=			L.orig_address_id;
		self.address_line_1	:=		L.orig_address_line_1;
		self.address_line_2	:=		L.orig_address_line_2;
		self.address_line_3	:=		L.orig_address_line_3;
		self.address_city	:=			L.orig_address_city;
		self.address_state_province	:=			L.orig_address_state_province;
		self.address_postal_code	:=			L.orig_address_postal_code;
		self.address_country	:=			L.orig_address_country;
		self.remarks	:=		L.orig_remarks;
		self.call_sign	:=			L.orig_call_sign;
		self.vessel_type	:=			L.orig_vessel_type;
		self.tonnage	:=			L.orig_tonnage;
		self.gross_registered_tonnage	:=			L.orig_gross_registered_tonnage;
		self.vessel_flag	:=			L.orig_vessel_flag;
		self.vessel_owner	:=		L.orig_vessel_owner;
		self.sanctions_program_1	:=			L.orig_sanctions_program_1;
		self.sanctions_program_2	:=			L.orig_sanctions_program_2;
		self.sanctions_program_3	:=			L.orig_sanctions_program_3;
		self.sanctions_program_4	:=			L.orig_sanctions_program_4;
		self.sanctions_program_5	:=			L.orig_sanctions_program_5;
		self.sanctions_program_6	:=			L.orig_sanctions_program_6;
		self.sanctions_program_7	:=			L.orig_sanctions_program_7;
		self.sanctions_program_8	:=			L.orig_sanctions_program_8;
		self.sanctions_program_9	:=			L.orig_sanctions_program_9;
		self.sanctions_program_10	:=			L.orig_sanctions_program_10;
		self.passport_details	:=		L.orig_passport_details;
		self.ni_number_details	:=		L.orig_ni_number_details;
		self.id_id_1	:=			L.orig_id_id_1;
		self.id_id_2	:=			L.orig_id_id_2;
		self.id_id_3	:=			L.orig_id_id_3;
		self.id_id_4	:=			L.orig_id_id_4;
		self.id_id_5	:=			L.orig_id_id_5;
		self.id_id_6	:=			L.orig_id_id_6;
		self.id_id_7	:=			L.orig_id_id_7;
		self.id_id_8	:=			L.orig_id_id_8;
		self.id_id_9	:=			L.orig_id_id_9;
		self.id_id_10	:=			L.orig_id_id_10;
		self.id_type_1	:=			L.orig_id_type_1;
		self.id_type_2	:=			L.orig_id_type_2;
		self.id_type_3	:=			L.orig_id_type_3;
		self.id_type_4	:=			L.orig_id_type_4;
		self.id_type_5	:=			L.orig_id_type_5;
		self.id_type_6	:=			L.orig_id_type_6;
		self.id_type_7	:=			L.orig_id_type_7;
		self.id_type_8	:=			L.orig_id_type_8;
		self.id_type_9	:=			L.orig_id_type_9;
		self.id_type_10	:=			L.orig_id_type_10;
		self.id_number_1	:=			ut.CleanSpacesAndUpper(L.orig_id_number_1);
		self.id_number_2	:=			ut.CleanSpacesAndUpper(L.orig_id_number_2);
		self.id_number_3	:=			ut.CleanSpacesAndUpper(L.orig_id_number_3);
		self.id_number_4	:=			ut.CleanSpacesAndUpper(L.orig_id_number_4);
		self.id_number_5	:=			ut.CleanSpacesAndUpper(L.orig_id_number_5);
		self.id_number_6	:=			ut.CleanSpacesAndUpper(L.orig_id_number_6);
		self.id_number_7	:=			ut.CleanSpacesAndUpper(L.orig_id_number_7);
		self.id_number_8	:=			ut.CleanSpacesAndUpper(L.orig_id_number_8);
		self.id_number_9	:=			ut.CleanSpacesAndUpper(L.orig_id_number_9);
		self.id_number_10	:=			ut.CleanSpacesAndUpper(L.orig_id_number_10);
		self.id_country_1	:=			L.orig_id_country_1;
		self.id_country_2	:=			L.orig_id_country_2;
		self.id_country_3	:=			L.orig_id_country_3;
		self.id_country_4	:=			L.orig_id_country_4;
		self.id_country_5	:=			L.orig_id_country_5;
		self.id_country_6		:=			L.orig_id_country_6;
		self.id_country_7	:=			L.orig_id_country_7;
		self.id_country_8	:=			L.orig_id_country_8;
		self.id_country_9	:=			L.orig_id_country_9;
		self.id_country_10	:=			L.orig_id_country_10;
		self.id_issue_date_1	:=			L.orig_id_issue_date_1;
		self.id_issue_date_2	:=			L.orig_id_issue_date_2;
		self.id_issue_date_3	:=			L.orig_id_issue_date_3;
		self.id_issue_date_4	:=			L.orig_id_issue_date_4;
		self.id_issue_date_5	:=			L.orig_id_issue_date_5;
		self.id_issue_date_6	:=			L.orig_id_issue_date_6;
		self.id_issue_date_7	:=			L.orig_id_issue_date_7;
		self.id_issue_date_8	:=			L.orig_id_issue_date_8;
		self.id_issue_date_9	:=			L.orig_id_issue_date_9;
		self.id_issue_date_10	:=			L.orig_id_issue_date_10;
		self.id_expiration_date_1	:=			L.orig_id_expiration_date_1;
		self.id_expiration_date_2	:=			L.orig_id_expiration_date_2;
		self.id_expiration_date_3	:=			L.orig_id_expiration_date_3;
		self.id_expiration_date_4	:=			L.orig_id_expiration_date_4;
		self.id_expiration_date_5	:=			L.orig_id_expiration_date_5;
		self.id_expiration_date_6	:=			L.orig_id_expiration_date_6;
		self.id_expiration_date_7	:=			L.orig_id_expiration_date_7;
		self.id_expiration_date_8	:=			L.orig_id_expiration_date_8;
		self.id_expiration_date_9	:=			L.orig_id_expiration_date_9;
		self.id_expiration_date_10	:=			L.orig_id_expiration_date_10;
		self.nationality_id_1	:=			L.orig_nationality_id_1;
		self.nationality_id_2	:=			L.orig_nationality_id_2;
		self.nationality_id_3	:=			L.orig_nationality_id_3;
		self.nationality_id_4	:=			L.orig_nationality_id_4;
		self.nationality_id_5	:=			L.orig_nationality_id_5;
		self.nationality_id_6	:=			L.orig_nationality_id_6;
		self.nationality_id_7	:=			L.orig_nationality_id_7;
		self.nationality_id_8	:=			L.orig_nationality_id_8;
		self.nationality_id_9	:=			L.orig_nationality_id_9;
		self.nationality_id_10	:=			L.orig_nationality_id_10;
		self.nationality_1	:=			L.orig_nationality_1;
		self.nationality_2	:=			L.orig_nationality_2;
		self.nationality_3	:=			L.orig_nationality_3;
		self.nationality_4	:=			L.orig_nationality_4;
		self.nationality_5	:=			L.orig_nationality_5;
		self.nationality_6	:=			L.orig_nationality_6;
		self.nationality_7	:=			L.orig_nationality_7;
		self.nationality_8	:=			L.orig_nationality_8;
		self.nationality_9	:=			L.orig_nationality_9;
		self.nationality_10	:=			L.orig_nationality_10;
		self.primary_nationality_flag_1	:=			L.orig_primary_nationality_flag_1;
		self.primary_nationality_flag_2	:=			L.orig_primary_nationality_flag_2;
		self.primary_nationality_flag_3	:=			L.orig_primary_nationality_flag_3;
		self.primary_nationality_flag_4	:=			L.orig_primary_nationality_flag_4;
		self.primary_nationality_flag_5	:=			L.orig_primary_nationality_flag_5;
		self.primary_nationality_flag_6	:=			L.orig_primary_nationality_flag_6;
		self.primary_nationality_flag_7	:=			L.orig_primary_nationality_flag_7;
		self.primary_nationality_flag_8	:=			L.orig_primary_nationality_flag_8;
		self.primary_nationality_flag_9	:=			L.orig_primary_nationality_flag_9;
		self.primary_nationality_flag_10	:=			L.orig_primary_nationality_flag_10;
		self.citizenship_id_1	:=			L.orig_citizenship_id_1;
		self.citizenship_id_2	:=			L.orig_citizenship_id_2;
		self.citizenship_id_3	:=			L.orig_citizenship_id_3;
		self.citizenship_id_4	:=			L.orig_citizenship_id_4;
		self.citizenship_id_5	:=			L.orig_citizenship_id_5;
		self.citizenship_id_6	:=			L.orig_citizenship_id_6;
		self.citizenship_id_7	:=			L.orig_citizenship_id_7;
		self.citizenship_id_8	:=			L.orig_citizenship_id_8;
		self.citizenship_id_9	:=			L.orig_citizenship_id_9;
		self.citizenship_id_10	:=			L.orig_citizenship_id_10;
		self.citizenship_1	:=			L.orig_citizenship_1;
		self.citizenship_2	:=			L.orig_citizenship_2;
		self.citizenship_3	:=			L.orig_citizenship_3;
		self.citizenship_4	:=			L.orig_citizenship_4;
		self.citizenship_5	:=			L.orig_citizenship_5;
		self.citizenship_6	:=			L.orig_citizenship_6;
		self.citizenship_7	:=			L.orig_citizenship_7;
		self.citizenship_8	:=			L.orig_citizenship_8;
		self.citizenship_9	:=			L.orig_citizenship_9;
		self.citizenship_10	:=			L.orig_citizenship_10;
		self.primary_citizenship_flag_1	:=			L.orig_primary_citizenship_flag_1;
		self.primary_citizenship_flag_2	:=			L.orig_primary_citizenship_flag_2;
		self.primary_citizenship_flag_3	:=			L.orig_primary_citizenship_flag_3;
		self.primary_citizenship_flag_4	:=			L.orig_primary_citizenship_flag_4;
		self.primary_citizenship_flag_5	:=			L.orig_primary_citizenship_flag_5;
		self.primary_citizenship_flag_6	:=			L.orig_primary_citizenship_flag_6;
		self.primary_citizenship_flag_7	:=			L.orig_primary_citizenship_flag_7;
		self.primary_citizenship_flag_8	:=			L.orig_primary_citizenship_flag_8;
		self.primary_citizenship_flag_9	:=			L.orig_primary_citizenship_flag_9;
		self.primary_citizenship_flag_10	:=			L.orig_primary_citizenship_flag_10;
		self.dob_id_1	:=			L.orig_dob_id_1;
		self.dob_id_2	:=			L.orig_dob_id_2;
		self.dob_id_3	:=			L.orig_dob_id_3;
		self.dob_id_4	:=			L.orig_dob_id_4;
		self.dob_id_5	:=			L.orig_dob_id_5;
		self.dob_id_6	:=			L.orig_dob_id_6;
		self.dob_id_7	:=			L.orig_dob_id_7;
		self.dob_id_8	:=			L.orig_dob_id_8;
		self.dob_id_9	:=			L.orig_dob_id_9;
		self.dob_id_10	:=			L.orig_dob_id_10;
		self.dob_1	:=				L.orig_dob_1;
		self.dob_2	:=			L.orig_dob_2;
		self.dob_3	:=			L.orig_dob_3;
		self.dob_4	:=			L.orig_dob_4;
		self.dob_5	:=			L.orig_dob_5;
		self.dob_6	:=			L.orig_dob_6;
		self.dob_7	:=			L.orig_dob_7;
		self.dob_8	:=			L.orig_dob_8;
		self.dob_9	:=			L.orig_dob_9;
		self.dob_10	:=			L.orig_dob_10;
		self.primary_dob_flag_1	:=			L.orig_primary_dob_flag_1;
		self.primary_dob_flag_2	:=			L.orig_primary_dob_flag_2;
		self.primary_dob_flag_3	:=			L.orig_primary_dob_flag_3;
		self.primary_dob_flag_4	:=			L.orig_primary_dob_flag_4;
		self.primary_dob_flag_5	:=			L.orig_primary_dob_flag_5;
		self.primary_dob_flag_6	:=			L.orig_primary_dob_flag_6;
		self.primary_dob_flag_7	:=			L.orig_primary_dob_flag_7;
		self.primary_dob_flag_8	:=			L.orig_primary_dob_flag_8;
		self.primary_dob_flag_9	:=			L.orig_primary_dob_flag_9;
		self.primary_dob_flag_10	:=			L.orig_primary_dob_flag_10;
		self.pob_id_1	:=			L.orig_pob_id_1;
		self.pob_id_2	:=			L.orig_pob_id_2;
		self.pob_id_3	:=			L.orig_pob_id_3;
		self.pob_id_4	:=			L.orig_pob_id_4;
		self.pob_id_5	:=			L.orig_pob_id_5;
		self.pob_id_6	:=			L.orig_pob_id_6;
		self.pob_id_7	:=			L.orig_pob_id_7;
		self.pob_id_8	:=			L.orig_pob_id_8;
		self.pob_id_9	:=			L.orig_pob_id_9;
		self.pob_id_10	:=			L.orig_pob_id_10;
		self.pob_1	:=			L.orig_pob_1;
		self.pob_2	:=			L.orig_pob_2;
		self.pob_3	:=			L.orig_pob_3;
		self.pob_4	:=			L.orig_pob_4;
		self.pob_5	:=			L.orig_pob_5;
		self.pob_6	:=			L.orig_pob_6;
		self.pob_7	:=			L.orig_pob_7;
		self.pob_8	:=			L.orig_pob_8;
		self.pob_9	:=			L.orig_pob_9;
		self.pob_10	:=			L.orig_pob_10;
		self.country_of_birth_1	:=			L.orig_country_of_birth_1;
		self.country_of_birth_2	:=			L.orig_country_of_birth_2;
		self.country_of_birth_3	:=			L.orig_country_of_birth_3;
		self.country_of_birth_4	:=			L.orig_country_of_birth_4;
		self.country_of_birth_5	:=			L.orig_country_of_birth_5;
		self.country_of_birth_6	:=			L.orig_country_of_birth_6;
		self.country_of_birth_7	:=			L.orig_country_of_birth_7;
		self.country_of_birth_8	:=			L.orig_country_of_birth_8;
		self.country_of_birth_9	:=			L.orig_country_of_birth_9;
		self.country_of_birth_10	:=			L.orig_country_of_birth_10;
		self.primary_pob_flag_1	:=			L.orig_primary_pob_flag_1;
		self.primary_pob_flag_2	:=			L.orig_primary_pob_flag_2;
		self.primary_pob_flag_3	:=			L.orig_primary_pob_flag_3;
		self.primary_pob_flag_4	:=			L.orig_primary_pob_flag_4;
		self.primary_pob_flag_5	:=			L.orig_primary_pob_flag_5;
		self.primary_pob_flag_6	:=			L.orig_primary_pob_flag_6;
		self.primary_pob_flag_7	:=			L.orig_primary_pob_flag_7;
		self.primary_pob_flag_8	:=			L.orig_primary_pob_flag_8;
		self.primary_pob_flag_9	:=			L.orig_primary_pob_flag_9;
		self.primary_pob_flag_10	:=			L.orig_primary_pob_flag_10;
		self.language_1	:=			L.orig_language_1;
		self.language_2	:=			L.orig_language_2;
		self.language_3	:=			L.orig_language_3;
		self.language_4	:=			L.orig_language_4;
		self.language_5	:=			L.orig_language_5;
		self.language_6	:=			L.orig_language_6;
		self.language_7	:=			L.orig_language_7;
		self.language_8	:=			L.orig_language_8;
		self.language_9	:=			L.orig_language_9;
		self.language_10	:=			L.orig_language_10;
		self.membership_1	:=		L.orig_membership_1;
		self.membership_2	:=		L.orig_membership_2;
		self.membership_3	:=		L.orig_membership_3;
		self.membership_4	:=		L.orig_membership_4;
		self.membership_5	:=		L.orig_membership_5;
		self.membership_6	:=		L.orig_membership_6;
		self.membership_7	:=		L.orig_membership_7;
		self.membership_8	:=		L.orig_membership_8;
		self.membership_9	:=		L.orig_membership_9;
		self.membership_10	:=		L.orig_membership_10;
		self.position_1	:=		L.orig_position_1;
		self.position_2	:=		L.orig_position_2;
		self.position_3	:=		L.orig_position_3;
		self.position_4	:=		L.orig_position_4;
		self.position_5	:=		L.orig_position_5;
		self.position_6	:=		L.orig_position_6;
		self.position_7	:=		L.orig_position_7;
		self.position_8	:=		L.orig_position_8;
		self.position_9	:=		L.orig_position_9;
		self.position_10	:=		L.orig_position_10;
		self.occupation_1	:=		L.orig_occupation_1;
		self.occupation_2	:=		L.orig_occupation_2;
		self.occupation_3	:=		L.orig_occupation_3;
		self.occupation_4	:=		L.orig_occupation_4;
		self.occupation_5	:=		L.orig_occupation_5;
		self.occupation_6	:=		L.orig_occupation_6;
		self.occupation_7	:=		L.orig_occupation_7;
		self.occupation_8	:=		L.orig_occupation_8;
		self.occupation_9	:=		L.orig_occupation_9;
		self.occupation_10	:=		L.orig_occupation_10;
		self.date_added_to_list	:=			L.orig_date_added_to_list;
		self.date_last_updated	:=			L.orig_date_last_updated;
		self.effective_date	:=			L.orig_effective_date;
		self.expiration_date	:=			L.orig_expiration_date;
		self.gender	:=			L.orig_gender;
		self.grounds	:=		L.orig_grounds;
		self.subj_to_common_pos_2001_931_cfsp_fl	:=			L.orig_subj_to_common_pos_2001_931_cfsp_flag;
		self.federal_register_citation_1	:=			L.orig_federal_register_citation_1;
		self.federal_register_citation_2	:=			L.orig_federal_register_citation_2;
		self.federal_register_citation_3	:=			L.orig_federal_register_citation_3;
		self.federal_register_citation_4	:=			L.orig_federal_register_citation_4;
		self.federal_register_citation_5	:=			L.orig_federal_register_citation_5;
		self.federal_register_citation_6	:=			L.orig_federal_register_citation_6;
		self.federal_register_citation_7	:=			L.orig_federal_register_citation_7;
		self.federal_register_citation_8	:=			L.orig_federal_register_citation_8;
		self.federal_register_citation_9	:=			L.orig_federal_register_citation_9;
		self.federal_register_citation_10	:=			L.orig_federal_register_citation_10;
		self.federal_register_citation_date_1	:=			L.orig_federal_register_citation_date_1;
		self.federal_register_citation_date_2	:=			L.orig_federal_register_citation_date_2;
		self.federal_register_citation_date_3	:=			L.orig_federal_register_citation_date_3;
		self.federal_register_citation_date_4	:=			L.orig_federal_register_citation_date_4;
		self.federal_register_citation_date_5	:=			L.orig_federal_register_citation_date_5;
		self.federal_register_citation_date_6	:=			L.orig_federal_register_citation_date_6;
		self.federal_register_citation_date_7	:=			L.orig_federal_register_citation_date_7;
		self.federal_register_citation_date_8	:=			L.orig_federal_register_citation_date_8;
		self.federal_register_citation_date_9	:=			L.orig_federal_register_citation_date_9;
		self.federal_register_citation_date_10	:=			L.orig_federal_register_citation_date_10;
		self.license_requirement	:=		L.license_requirement;
		self.license_review_policy	:=		L.license_review_policy;
		self.subordinate_status	:=		L.orig_subordinate_status;
		self.height	:=			L.orig_height;
		self.weight	:=			L.orig_weight;
		self.physique	:=			L.orig_physique;
		self.hair_color	:=			L.orig_hair_color;
		self.eyes	:=			L.orig_eyes;
		self.complexion	:=			L.orig_complexion;
		self.race	:=			L.orig_race;
		self.scars_marks	:=		L.orig_scars_marks;
		self.photo_file	:=			L.orig_photo_file;
		self.offenses	:=		L.orig_offenses;
		self.ncic	:=			L.orig_ncic;
		self.warrant_by	:=		L.orig_warrant_by;
		self.caution	:=		L.orig_caution;
		self.reward	:=		L.orig_reward;
		self.type_of_denial	:=			L.orig_type_of_denial;
		self.linked_with_1	:=			L.orig_linked_with_1;
		self.linked_with_2	:=			L.orig_linked_with_2;
		self.linked_with_3	:=			L.orig_linked_with_3;
		self.linked_with_4	:=			L.orig_linked_with_4;
		self.linked_with_5	:=			L.orig_linked_with_5;
		self.linked_with_6	:=			L.orig_linked_with_6;
		self.linked_with_7	:=			L.orig_linked_with_7;
		self.linked_with_8	:=			L.orig_linked_with_8;
		self.linked_with_9	:=			L.orig_linked_with_9;
		self.linked_with_10	:=			L.orig_linked_with_10;
		self.linked_with_id_1	:=			L.orig_linked_with_id_1;
		self.linked_with_id_2	:=			L.orig_linked_with_id_2;
		self.linked_with_id_3	:=			L.orig_linked_with_id_3;
		self.linked_with_id_4	:=			L.orig_linked_with_id_4;
		self.linked_with_id_5	:=			L.orig_linked_with_id_5;
		self.linked_with_id_6	:=			L.orig_linked_with_id_6;
		self.linked_with_id_7	:=			L.orig_linked_with_id_7;
		self.linked_with_id_8	:=			L.orig_linked_with_id_8;
		self.linked_with_id_9	:=			L.orig_linked_with_id_9;
		self.linked_with_id_10	:=			L.orig_linked_with_id_10;
		self.listing_information	:=		L.orig_listing_information;
		self.foreign_principal	:=		L.orig_foreign_principal;
		self.nature_of_service	:=			L.orig_nature_of_service;
		self.	activities	:=		L.orig_activities;
		self.finances	:=		L.orig_finances;
		self.registrant_terminated_flag	:=			L.orig_registrant_terminated_flag;
		self.foreign_principal_terminated_flag	:=			L.orig_foreign_principal_terminated_flag;
		self.short_form_terminated_flag	:=			L.orig_short_form_terminated_flag;
		self := L;
		self := [];
	END;
	
	pSourceCombined	:= SORT(PROJECT(pCleanNameAddr, xformFinalLayout(left)),pty_key)(orig_pty_name <> '' or orig_vessel_name <> '');
	
	//srt history files for append
	dsSrtFIN_GWL 		:= SORT(GlobalWatchLists_Preprocess.Files.dsInnovativeSystemsFIN_GWL, pty_key);
	//dsSrtCFT	:= SORT(GlobalWatchLists_Preprocess.Files.dsInnovativeSystemsCFT, pty_key); //New update file received
	
	//OFAC file output is not used in this graph
	concatFiles			:= pSourceCombined + dsSrtFIN_GWL;	
	
	//DF-26191: Append Global_SIDs
	addGlobalSID		:= mdr.macGetGlobalSID(concatFiles, 'GlobalWatchList', 'source', 'global_sid');
	
	dsGWLFinalOut	:= output(addGlobalSID,,'~thor_data400::in::globalwatchlists_'+filedate,overwrite);
	
	RETURN dsGWLFinalOut;

END;