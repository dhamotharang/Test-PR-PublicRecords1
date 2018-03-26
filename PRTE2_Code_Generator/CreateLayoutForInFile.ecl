import std, workman, PRTE2_CODE_GENERATOR, prte2;

// This function reads the header (first line) of a file passed as a parameter and attempts to
// create a record layout for it.
// dopskey is the name the set of keys is found under on the DOPS page.
// modName is the name of the old module and is used to find layouts with matching field names.
// filename is a part of the file name or names to be searched for.
EXPORT CreateLayoutForInFile(string DopsKey, string ModuleName,string sprayedFile = '') := function 

	shared layoutRec := Record
		string dataType;
		string fieldName;
	end;

	RecStruct := {STRING line};

	IP   := prte2._Constants().sServerIP;
	
	file := prte2._Constants().sDirectory + sprayedFile;

	DS1  := DATASET(STD.File.ExternalLogicalFileName(IP,file),
			RecStruct, CSV(HEADING(0), SEPARATOR('~~~~~~\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));

	layoutSet  := STD.Str.splitwords(DS1[1].line,'\t');
	
	layoutDS   := Dataset(layoutSet,{string fieldname});

	SHARED infileFields := PROJECT (layoutDS,transform(layoutRec, self.fieldName := LEFT.fieldname, self.dataType := 'STRING'));

	layouts.layoutRec xforminfile(infileFields l) := transform
		self.fieldName := l.fieldName;
		self.dataType := '@unknown@';
	end;

	SHARED infileFieldsReset := Project(infileFields(fieldName!=''), xforminfile(left), ORDERED(TRUE));

	dopsFields := GetDopsLayoutsFields(DopsKey);

	normed_layouts := GetProductionModuleLayouts(ModuleName);

	layouts.parentLayouts xformModParents(normed_layouts l) := transform
		self.layoutName := l.layout_name;
		self.children := GetAllLayoutFields(l.clean_layout,l.layout_name);
	end;

	all_mod_parents := project(normed_layouts,xformModParents(left));

	mod_result := normalize(all_mod_parents,Left.children, transform(layouts.layoutRec,self:=right));

	header_normed_layouts := GetProductionModuleLayouts('Header');

	all_header_parents := project(header_normed_layouts,xformModParents(left));

	header_result := normalize(all_header_parents,Left.children, transform(layouts.layoutRec,self:=right));

	layouts.layoutRec xformjoin(infileFieldsReset l, dopsFields r) := transform
		self.dataType := if (l.dataType = '@unknown@' or l.dataType = '',r.dataType,l.dataType);
		self.fieldName := l.fieldName;
	end;

	joinDops := join(infileFieldsReset, dopsFields, std.str.touppercase( left.fieldName ) =  std.str.touppercase( right.fieldName ), xformjoin(left,right), LEFT OUTER,LOOKUP, STABLE);

	joinMod := join(joinDops, mod_result, std.str.touppercase( left.fieldName ) =  std.str.touppercase( right.fieldName ), xformjoin(left,right), LEFT OUTER, LOOKUP,STABLE);

	all_layouts1 := if(count(joinMod(dataType = '')) = 0, 
						joinMod, 
						join(joinMod, header_result, std.str.touppercase( left.fieldName ) =  std.str.touppercase( right.fieldName ), 
							xformjoin(left,right), LEFT OUTER, LOOKUP,STABLE)
					);
		
	SetLayoutNames := Set(dopsFields(layoutname !=''),layoutName);

	embeddedLayouts := dopsFields(dataType in SetLayoutNames);
	
	all_layouts2 := if (count(all_layouts1(dataType = '')) = 0, 
						all_layouts1,
						join(all_layouts1, dopsFields(layoutName in SetLayoutNames), 
							STD.STr.EndsWith(std.str.touppercase( left.fieldName ), std.str.touppercase( right.fieldName )), 
							xformjoin(left,right), LEFT OUTER, ALL,STABLE)
					);

	dopsFields(layoutName in SetLayoutNames);

	return all_layouts2;

end;
