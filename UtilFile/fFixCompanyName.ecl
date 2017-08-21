export fFixCompanyName := module
			//*** Function that makes the company name by concatenating the given name fields in the FMLS order.
		export fMakeCompanyName(string lname, string fname, string mname, string sname) := function
			string100 cname	:=	if(length(trim(fname,left,right)) = 20, trim(fname) + trim(mname), 
															if(trim(fname) <> '', trim(fname)+ ' '+ trim(mname), trim(mname))) + 
													if(length(trim(mname,left,right)) = 20, trim(lname), 
															if(trim(mname) <> '',' '+ trim(lname),trim(lname))) + 
													if(length(trim(lname,left,right)) = 25, trim(sname), 
															if(trim(lname) <> '', ' '+trim(sname), trim(sname)));

			string100 out_cname := if ((StringLib.StringFind(trim(lname,left,right), trim(fname,left,right),1) > 0 and length(trim(fname)) > 5) or
																 (StringLib.StringFind(trim(lname,left,right), trim(fname,left,right) + ' ' + trim(mname,left,right),1) > 0  and length(trim(fname) + trim(mname)) > 5) or
																 (StringLib.StringFind(trim(lname,left,right), trim(fname,left,right) + trim(mname,left,right),1) > 0  and length(trim(fname) + trim(mname)) > 5)
																	,trim(lname,left,right), cname);
			return stringlib.StringToUpperCase(trim(out_cname,left,right));
		end;
		
		//*** Function that makes the company name by concatenating the given name fields in the LFMS order.
		export fMakeCompanyName1(string lname, string fname, string mname, string sname) := function
			string100 cname	:=	if(length(trim(lname,left,right)) = 25, trim(lname) + trim(fname), 
														 if(trim(lname) <> '', trim(lname)+ ' '+ trim(fname), trim(fname))) + 
													if(length(trim(fname,left,right)) = 20, trim(mname), 
														 if(trim(fname) <> '',' '+ trim(mname),trim(mname))) + 
													if(length(trim(mname,left,right)) = 20, trim(sname), 
														 if(trim(mname) <> '', ' '+trim(sname), trim(sname)));
														 
			string100 out_cname := if ((StringLib.StringFind(trim(lname,left,right), trim(fname,left,right),1) > 0 and length(trim(fname)) > 5) or
													 (StringLib.StringFind(trim(lname,left,right), trim(fname,left,right) + ' ' + trim(mname,left,right),1) > 0  and length(trim(fname) + trim(mname)) > 5) or
													 (StringLib.StringFind(trim(lname,left,right), trim(fname,left,right) + trim(mname,left,right),1) > 0  and length(trim(fname) + trim(mname)) > 5)
														,trim(lname,left,right), cname);
			return stringlib.StringToUpperCase(trim(out_cname,left,right));
			//return trim(cname,left,right);
		end;
		
		export STRING pPatternINC := 
		 '( I NC$| IN C$| I N C$)';
		 
		export STRING pPatternLLP := 
		 '( L LP$| LL P$| L L P$)';
		 
		export STRING pPatternLLC := 
		 '( L LC$| LL C$| L L C$)';
		 
		export STRING pPatternMAN := 
		 '( MANA GEMENT| MANAGE MENT| MAN AGEMENT| MANA GEMEN)';

		export STRING pPatternCorp := 
		 '( C ORP| COR P| CO RP)';
		 
		export string pPatternENT := 
		'( ENTE RPRISE| ENT ERPRISE)';

		export string pPatternLMT := 
		'( LIMIT ED| LIMI TED| L IMITED)';

		export string pPatternCON := 
		'( CONSTRUCTI ON| CONSTR UCTION| CO NSTRUCTION)'; 

		export string pPatternRES := 
		'( RESIDENTI AL| RESIDENT IAL| RESID ENTIAL)';
		
		export string pPatternINS := 
		'( INSUR ANCE| INS URANCE| IN SURANCE)';

		export string pPatternPRO := 
		'( PROP ERTIES| PROPERT IES| PRO PERTIES)';

		export string pPatternAPT := 
		'( APARTMEN T| APARTME NT| APARTM ENT| APART MENT| AP ARTMENT)'; 

		export STRING pLFMPattern := 
		'( LIMIT$| LIMITE$| LIMITED$| MILLS$| MGMT$| MANAGE$| MANAGEMENT$| LEASIN$| LEASING$' +
		'| COMPAN$| COMPANY$| CORPOR$| CORPORATION$| PROPER$| PROPERTY$| PROPERTIES$| PARTNE$| PARTNER$' +
		'| AUTH$| CONSTR$| CONSTRUCTION$| INC$| LLP$| LLLP$| LLC$| LP$| ASSOCI$)';

		 
		export BOOLEAN IsStrFound( STRING pPattern
											 ,STRING pStr ) := regexfind(pPattern,StringLib.StringToUpperCase(Trim(pStr,LEFT,RIGHT)));
		
		export FixBrokenWords(string inStr):= function
			fixedWord := map(IsStrFound(pPatternINC, inStr)  => regexReplace(pPatternINC,StringLib.StringToUpperCase(Trim(inStr,LEFT,RIGHT)),' INC'),
											 IsStrFound(pPatternLLP, inStr)  => regexReplace(pPatternLLP,StringLib.StringToUpperCase(Trim(inStr,LEFT,RIGHT)),' LLP'),
											 IsStrFound(pPatternLLC, inStr)  => regexReplace(pPatternLLC,StringLib.StringToUpperCase(Trim(inStr,LEFT,RIGHT)),' LLC'),
											 IsStrFound(pPatternCorp, inStr) => regexReplace(pPatternCorp,StringLib.StringToUpperCase(Trim(inStr,LEFT,RIGHT)),' CORP'),
											 IsStrFound(pPatternMAN, inStr)  => regexReplace(pPatternMAN,StringLib.StringToUpperCase(Trim(inStr,LEFT,RIGHT)),' MANAGEMENT'),
											 IsStrFound(pPatternENT, inStr)  => regexReplace(pPatternENT,StringLib.StringToUpperCase(Trim(inStr,LEFT,RIGHT)),' ENTERPRISE'),
											 IsStrFound(pPatternLMT, inStr)  => regexReplace(pPatternLMT,StringLib.StringToUpperCase(Trim(inStr,LEFT,RIGHT)),' LIMITED'),
											 IsStrFound(pPatternCON, inStr)  => regexReplace(pPatternCON,StringLib.StringToUpperCase(Trim(inStr,LEFT,RIGHT)),' CONSTRUCTION'),
											 IsStrFound(pPatternRES, inStr)  => regexReplace(pPatternRES,StringLib.StringToUpperCase(Trim(inStr,LEFT,RIGHT)),' RESIDENTIAL'),
											 IsStrFound(pPatternINS, inStr)  => regexReplace(pPatternINS,StringLib.StringToUpperCase(Trim(inStr,LEFT,RIGHT)),' INSURANCE'),
											 IsStrFound(pPatternPRO, inStr)  => regexReplace(pPatternPRO,StringLib.StringToUpperCase(Trim(inStr,LEFT,RIGHT)),' PROPERTIES'),
											 IsStrFound(pPatternAPT, inStr)  => regexReplace(pPatternAPT,StringLib.StringToUpperCase(Trim(inStr,LEFT,RIGHT)),' APARTMENT'),
											 inStr);
			return(fixedWord);
		end;

end;