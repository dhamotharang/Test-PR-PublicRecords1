import risk_indicators;

export getAreaCodeSplit(string10 phone10, boolean reverse = false) := function
	
	validPhone := if((LENGTH(Stringlib.StringFilter(phone10,'0123456789'))=10), true, false);
	o := risk_indicators.Key_AreaCode_Change(validphone, keyed(phone10[1..3]=old_NPA), keyed(phone10[4..6]=old_NXX));
		
	acsplit := project(o, TRANSFORM(risk_indicators.Layout_AreaCode_Change_plus, SELF:=LEFT));
	empty_set := dataset([{''}], risk_indicators.Layout_AreaCode_Change_plus);
	
	x := record
		string1 areacodesplitflag := '';
		string8 areacodesplitdate := '';
		string3 altareacode := '';
		string1 areacodesplitflag12blank := '';
	end;
	
	x fill_output(acsplit le) := transform
		self.areacodesplitflag := if(le.old_NPA<>'', 'Y', 'N');
		self.areacodesplitdate := le.permissive_start;
		self.altareacode := if(phone10[1..3]=le.old_NPA, le.new_NPA, le.old_NPA);
		self.areacodesplitflag12blank := map(self.areacodesplitflag='Y' and ~le.reverse_flag => '1',  // normal hit
									  self.areacodesplitflag='Y' and le.reverse_flag => '2',  // reverse hit
									  '');
	end;
	
	temp := if(count(acsplit)=0, empty_set, acsplit);
	ret := project(temp, fill_output(left));											   
	
	return ret;
end;
												   