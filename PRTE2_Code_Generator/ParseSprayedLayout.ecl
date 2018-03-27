IMPORT  STD;
EXPORT ParseSprayedLayout(string layoutStr) := Function
	layoutStr1 := layoutStr;
	layoutStr2 := trim(layoutStr1,left,right);
	layoutStr3 := regexreplace('^RECORD', layoutStr2,'', nocase);
	layoutStr4 := regexreplace('end;$', layoutStr3,'', nocase);
	layoutStr5 := trim(layoutStr4,left,right);
	layoutSet  := STD.Str.splitwords(layoutStr5,';');
	layoutDS   := Dataset(layoutSet,{string fieldname});
	layoutRec := Record
		string dataType;
		string fieldName;
	end;
	layoutRec xform(layoutDS l) := transform
	  SELF.dataType := STD.Str.GetNthWord(l.fieldname,1);
	  SELF.fieldName := STD.Str.GetNthWord(l.fieldname,2);
	end;
	mylayout := project(layoutDS,xform(left));
	return mylayout;
End;
