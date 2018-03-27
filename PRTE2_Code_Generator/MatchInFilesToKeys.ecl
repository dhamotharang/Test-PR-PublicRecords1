import prte2_code_generator, STD;
EXPORT MatchInFilesToKeys(Dataset(Layouts.layout_list_rec) infile, Dataset(layouts.superkeyrecs) keys) := Function
// infile := prte2_code_generator.GetInFileLayouts('DOCKeys', 'DOC', 'DOCKeys');

// keys := prte2_code_generator.GetKeyInfo(	'DOCKeys');

rec := record
	layouts.layout_list_rec;
	integer matches;
end;

rec_fields := record
	string datatype;
	string fieldname;
	string filename;
end;

rec_fields xform_files(infile l, Layouts.layoutRec r ) := transform
	self.datatype := r.datatype;
	self.fieldname := r.fieldname;
	self.filename := l.layout_Name;
end;
norm := normalize(infile, left.allfields, xform_files(left, right));
// output(norm);

Layouts.superkeyrecs updateKeys(keys l) := transform
	 SetFullLayout := STD.Str.SplitWords(l.full_layout, ',');
	 
   DSFields := Dataset(SetFullLayout, {string fieldname});
	 joinedDS := join(DSFields,norm, left.fieldname = right.fieldname);
	 MyOutRec := Record
			joinedDS;
			GrpCount := Count(Group);
	 end;
	 myTable := Table(joinedDS, MyOutRec, filename);
	 sortedTable := sort(myTable, -GrpCount);
	 self.best_file_match := sortedTable[1].filename;
	 self := l;
end;

result := Project(keys, updateKeys(left));
return result;

end;