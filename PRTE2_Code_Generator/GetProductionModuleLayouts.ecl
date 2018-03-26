import STD;
// Used to search a module in the repository for layout records so as to create infile layouts.
// modulename is the production module to search.

EXPORT GetProductionModuleLayouts(string modulename) := function

	shared ECLAttribute := Record
		string ModuleName{xpath('ModuleName')};
		string Name{xpath('Name')}; 
		string Type{xpath('Type')};
		INTEGER Version{xpath('Version')};
		INTEGER LatestVersion{xpath('LatestVersion')};
		INTEGER SandboxVersion{xpath('SandboxVersion')};
		INTEGER Flags{xpath('Flags')};
		INTEGER Access{xpath('Access')};
		BOOLEAN IsLocked{xpath('IsLocked')};
		BOOLEAN IsCheckedOut{xpath('IsCheckedOut')};
		BOOLEAN IsSandbox{xpath('IsSandbox')};
		BOOLEAN IsOrphaned{xpath('IsOrphaned')};
		INTEGER ResultType{xpath('ResultType')};
		STRING LockedBy{xpath('LockedBy')};
		STRING ModifiedBy{xpath('ModifiedBy')};
		STRING ModifiedDate{xpath('ModifiedDate')};
		STRING Description{xpath('Description')};
		STRING Checksum{xpath('Checksum')};
		STRING Text{xpath('Text')};
	end;
	
	EspStringArray := Record
		string Item{xpath('Item')};
	End;
	
	FindAttributesReq := Record
		string ModuleName{xpath('ModuleName')} := modulename;
		string Regexp{xpath('Regexp')} := ':=(\\t|\\n|\\r| )*record';//':=(\\t|\\n|\\r| )*record';//\\b\\w+\\b(\\t|\\n|\\r| )* //[\\s\\S]+?end;;
		Boolean GetText{xpath('GetText')} := true;
	end;

	FindAttributesResponse := record
		dataset(ECLAttribute) outAttributes{xpath('ECLAttribute')};
	end;

	myds := dataset([{modulename,':=(\t|\n|\r| )*record'}],FindAttributesReq);

	FindAttributeRec := Record
		Dataset(FindAttributesReq) FindAttributes{xpath('FindAttributes')} := myds;
	End;
	
	shared result := SOAPCALL('http://10.241.12.204:8145/WsAttributes',
						'FindAttributes',
						FindAttributesReq,
						Dataset(ECLAttribute),
						xpath('FindAttributesResponse/outAttributes/ECLAttribute')
					);

	shared child_layout := record
		string layout_text;
		string layout_name;
	end;
	
	shared parent_layouts := record
		dataset(child_layout) children;
		string file_name;
		string mod_name;
		integer num_rows;
	end;
	
	child_layout xform_child({string str_layout} l) := transform
		SELF.layout_text := l.str_layout;//regexreplace('//.*?(\\n|\\r)',l.str_layout,'');
		SELF.layout_name := Trim(STD.STr.SplitWords(SELF.layout_text,':=')[1],LEFT,RIGHT);
		
	end;
	
	parent_layouts xform(result l) := transform
		step1 := regexfindset('(export(\\t|\\n|\\r| )*)*\\b\\w+\\b(\\t|\\n|\\r| )*:=(\\t|\\n|\\r| )*record[\\s\\S]+?end;', l.text,nocase);//
		xds := dataset(step1,{string str_layout});
		SELF.num_rows := count(step1);
		SELF.children := project(xds, xform_child(left));
		SELF.mod_name := l.modulename;
		SELF.file_name := l.name;
	end;

	norm_layout := record
		string mod_name;
		string file_name;
		string layout_name;
		string clean_layout;
		string layout_text;
	end;

	norm_layout normx(parent_layouts l, integer c) := transform
		SELF := 	l.children[c];
		TEMP1 := REGEXREPLACE('(export(\\t|\\n|\\r| )*)*\\b\\w+\\b(\\t|\\n|\\r| )*:=(\\t|\\n|\\r| )*record(\\t|\\n|\\r| )*(\\(.+?\\))*', self.layout_text,'',nocase);
		SELF.clean_layout := TRIM(REGEXREPLACE('END;',TEMP1, '',nocase),LEFT,RIGHT);
		self.file_name := l.file_name;
		self.mod_name  := l.mod_name;
	end;

	denormedlayouts := project(result, xform(LEFT));

	normed_layouts := normalize(denormedlayouts, LEFT.NUM_ROWS,  normx(LEFT,COUNTER));

	return normed_layouts;

end;
