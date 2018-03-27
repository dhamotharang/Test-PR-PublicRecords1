import prte2, std, PRTE2_CODE_GENERATOR;
// This function reads each of the in files it finds on the landing zone and creates a 
// layout that matches the fields listed in the first line.
// dopskey is the name the set of keys is found under on the DOPS page.
// modName is the name of the old module and is used to find layouts with matching field names.
// filename is a part of the file name or names to be searched for.

EXPORT GetInFileLayouts(string dopsKey, string modName, string filename ):=  FUNCTION
	
	stringLayout := record
		string name;
		string layout
	end;

	layout_concat_rec := record
		string field_rec;
	end;

	
	
	layout_concat_rec xform_layout(Layouts.layoutRec l) := transform
		self.field_rec := l.dataType + ' ' + l.fieldName +';';
	end;
	
	Layouts.layout_list_rec createList(string dops, string mod, string filename) := transform
	   self.allFields := CreateLayoutForInFile(dops, mod,filename);
	   self.layout_name := std.str.splitwords(filename,'.')[1];
	   temp1 := project(self.allFields, xform_layout(left));
	   temp2 := set(temp1, field_rec);
	   temp3 := self.layout_name + ' := RECORD\n' + STD.STR.CombineWords(temp2,'\n') + 'END;\n';
	   self.layout_concat := temp3;
	end;

	IP   := prte2._Constants().sServerIP;
	
	DIR := prte2._Constants().sDirectory;
	
	FILEFILTER := '*' + filename + '*';
	
	files := FileServices.remotedirectory(IP, DIR, FILEFILTER);
	
	all_layouts := project(files, createList(dopsKey, modName,left.name));

	return all_layouts;
END;