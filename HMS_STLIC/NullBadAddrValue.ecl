import 	ut;
	
export string NullBadAddrValue(string fieldname) := Function
		NullBadAddr := 	if(
														REGEXFIND('NOT AVAILABLE|NO STREET ADDRESS|CONFIDENTIAL|RETIRED|NOT IN PRACTICE|NOT PRACTICING|NO ADDRESS|NONE ON FILE|NOT REPORTED|UNEMPLOY|STUDENT|SELF EMPLOYED|ADDR NOT REGISTERED|NEED POSTAL|RECENTLY SOLD', fieldname)
														,''
														, 
															if(
																				REGEXFIND('[*]', fieldname)
																				,regexreplace('--',regexreplace('[*]',fieldname,'')
																				, 
																					fieldname
																			
																		)

														,if(trim(Stringlib.StringToUpperCase(fieldname),left,right) in ['NR','NA','N/A','X','.','/'] and length(trim(fieldname))<=3,'',fieldname))
												
										);
		return NullBadAddr;
END;