import STD, PRTE2_CODE_GENERATOR;
// This function returns the fields and datatypes of the layouts used in the keys found in the 
// DOPS key passed in as the only parameter.  
export GetDopsLayoutsFields(string dopskey) := function
	dopslayouts := GetKeyInfo(dopskey);

	layout_rec := record
		string layout_name;
		string field;
	end;

	setLayouts := set(dopslayouts,layout);
	
	combinedSetLayouts := STD.str.CombineWords(setLayouts,'');
	
	combinedSetLayouts2 := regexreplace('\\}', combinedSetLayouts,'END;');
	
	splitSetLayouts := STD.str.SplitWords(combinedSetLayouts2,'END;');
	
	DSLayouts := dataset(splitSetLayouts, {string layout});

	layout_rec xform(DSLayouts l) := transform
		name1 := REGEXFIND('(\\w+\\b)(\\t|\\n|\\r| )*(:=)(\\t|\\n|\\r| )*record', l.layout,1,nocase);
		SELF.layout_name := name1;
		TEMP1 := REGEXREPLACE('(\\b\\w+\\b)*(\\t|\\n|\\r| )*(:=)*(\\t|\\n|\\r| )*record(\\t|\\n|\\r| )*(\\(.+?\\))*', l.layout,'',nocase);//(export(\\t|\\n|\\r| )*)*
		TEMP2 := regexreplace('[\\{\\}]',TEMP1,'');
		SELF.field := TRIM(REGEXREPLACE('END;',TEMP2, '',nocase),LEFT,RIGHT);
	end;

	cleanDopsLayouts := project(DSLayouts, xform(left));

	layouts.parentLayouts xformParents(cleanDopsLayouts l) := transform
		self.layoutName := l.layout_name;
		self.children := GetAllLayoutFields(l.field,l.layout_name);
	end;

	all_parents := project(cleanDopsLayouts,xformParents(left));

	result := normalize(all_parents,Left.children, transform(layouts.layoutRec,self:=right));
	
	return result;
	
end;