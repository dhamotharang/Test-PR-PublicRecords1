export Macro_Isolation(infile,company_name_field,outfile) := macro

	import MDR;
	
	#uniquename(p_month);
	pattern %p_month% := pattern('JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER');
	#uniquename(p_day);
	pattern %p_day% := pattern('[0]?[1-9]|[1-2][0-9]|3[0-1]');
	#uniquename(p_year);
	pattern %p_year% := pattern('[1-2][890][0-9][0-9]');
	#uniquename(p_ws);
	pattern %p_ws% := pattern(' ')+;
	#uniquename(p_word);
	pattern %p_word% := pattern('[^ ]+');
	#uniquename(p_rest);
	pattern %p_rest% := %p_word% (%p_ws% %p_word%)*;
	#uniquename(p_comma);
	pattern %p_comma% := ',';
	#uniquename(p_state);
	pattern %p_state% :=
		pattern('ALASKA|HAWAII|CALIFORNIA|OREGON|WASHINGTON|IDAHO|NEVADA|ARIZONA|NEW MEXICO|COLORADO') or
		pattern('MAINE|NEW HAMPSHIRE|VERMONT|MASSACHUSETTS|RHODE ISLAND|CONNECTICUT|NEW YORK|NEW JERSEY|PENNSYLVANIA|DELAWARE') or
		pattern('MARYLAND|VIRGINIA|DISTRICT OF COLUMBIA|NORTH CAROLINA|SOUTH CAROLINA|GEORGIA|FLORIDA|MISSISSIPPI|ALABAMA|LOUISIANA') or
		pattern('WEST VIRGINIA|OHIO|MICHIGAN|INDIANA|ILLINOIS|KENTUCKY|TENNESSEE|WISCONSIN|ARKANSAS|MISSOURI') or
		pattern('MONTANA|NORTH DAKOTA|SOUTH DAKOTA|MINNESOTA|IOWA|NEBRASKA|KANSAS|OKLAHOMA|TEXAS|WYOMING|UTAH');
	#uniquename(p_phrase);
	pattern %p_phrase% := pattern('DISSOLVED|DELINQUENT|UDT|UAD') or (%p_state% %p_ws% pattern('AUTHORITY RELINQUISHED|AUTHORITY TERMINATED'));
	#uniquename(p_date);
	pattern %p_date% := (%p_month% %p_ws% %p_day% opt(opt(%p_ws%) %p_comma%) %p_ws% %p_year%);
	#uniquename(p_complete);
	pattern %p_complete% := first ((opt(%p_ws%) ((%p_rest% penalty(1)) or (%p_rest% %p_ws% %p_phrase% %p_ws% %p_date%)) opt(%p_ws%)) or (%p_ws% penalty(2))) last;

	#uniquename(temprec);
	%temprec% := record
		infile;
		string derived_status;
		string derived_date;
		string derived_state;
		string derived_type;
	end;
	
	#uniquename(tempparse)
	%tempparse% := parse(infile,stringlib.StringToUpperCase(company_name_field),%p_complete%,transform(%temprec%,
		self.derived_status := matchtext(%p_phrase%),
		self.derived_date := matchtext(%p_date%),
		self.company_name_field := matchtext(%p_rest%),
		self := left,
		self := []),best);
	
	// pattern p_dba := pattern('DBA|A DIVISION OF|FKA|DOING BUSINESS AS|FORMERLY KNOWN AS');
	#uniquename(p_dba);
	pattern %p_dba% := pattern('DBA|DOING BUSINESS AS|D/B/A|D/B/A/|D B A');
	#uniquename(p_other_name);
	pattern %p_other_name% := %p_rest%;
	#uniquename(p_complete_2);
	pattern %p_complete_2% := first ((opt(%p_ws%) ((%p_rest% penalty(1)) or (%p_rest% %p_ws% %p_dba% %p_ws% %p_other_name%)) opt(%p_ws%)) or (%p_ws% penalty(2))) last;
	
	#uniquename(temprec2);
	%temprec2% := record
		%temprec%;
		string derived_other_name;
	end;
	
	#uniquename(tempparse2);
	%tempparse2% := parse(%tempparse%,company_name_field,%p_complete_2%,transform(%temprec2%,
		self.derived_other_name := if(MDR.sourceTools.SourceIsProperty(left.source),'',matchtext(%p_other_name%)),
		self.company_name_field := if(MDR.sourceTools.SourceIsProperty(left.source),left.company_name_field,matchtext(%p_rest%)),
		self := left,
		self := []),best);
	
	#uniquename(tempnormalize2);
	%tempnormalize2% := normalize(%tempparse2%,
		if(left.derived_other_name != '',2,1),
		transform(%temprec%,
			self.company_name_field := choose(counter,
				left.company_name_field,
				left.derived_other_name),
			self := left));
	
	#uniquename(p_an);
	pattern %p_an% := pattern('A|AN');
	#uniquename(p_type);
	pattern %p_type% := pattern('GENERAL PARTNERSHIP|LP|CORP|CORPORATION|LIMITED PARTNERSHIP|PARTNERSHIP|LIMITED LIABILITY COMPANY');
	#uniquename(p_complete_3);
	pattern %p_complete_3% := first ((opt(%p_ws%) ((%p_rest% penalty(1)) or (%p_rest% %p_ws% %p_an% opt(%p_ws% %p_state%) %p_ws% %p_type%)) opt(%p_ws%)) or (%p_ws% penalty(2))) last;
	
	#uniquename(tempparse3);
	%tempparse3% := parse(%tempnormalize2%,company_name_field,%p_complete_3%,transform(%temprec%,
		self.derived_state := matchtext(%p_state%),
		self.derived_type := matchtext(%p_type%),
		self.company_name_field := matchtext(%p_rest%),
		self := left),best);
	
	#uniquename(p_attn);
	pattern %p_attn% := pattern('ATTN');
	#uniquename(p_complete_4);
	pattern %p_complete_4% := first ((opt(%p_ws%) ((%p_rest% penalty(1)) or (%p_rest% %p_ws% %p_attn% %p_ws% %p_other_name%)) opt (%p_ws%)) or (%p_ws% penalty(2))) last;
	
	#uniquename(tempparse4);
	%tempparse4% := parse(%tempparse3%,company_name_field,%p_complete_4%,transform(%temprec%,
		self.company_name_field := matchtext(%p_rest%),
		self := left),best);
	
	outfile := %tempparse4%;

endmacro;
