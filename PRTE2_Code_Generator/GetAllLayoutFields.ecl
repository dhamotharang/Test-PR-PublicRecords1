import STD, PRTE2_CODE_GENERATOR;
// Used to split a layout in string format into data types and field names.

EXPORT GetAllLayoutFields(String SetLayouts, string layoutName) :=  function

	normedSet := SetLayouts;

	cleanedSplit := STD.STr.SplitWords(SetLayouts,';');
	
	cleanedDS := Dataset(cleanedSplit,{string str_layout});

	layouts.layoutRec cleanLayouts(cleanedDS l) := transform
		SELF.dataType := std.str.tolowercase(STD.Str.GetNthWord(l.str_layout,1));
		temp1 := STD.Str.GetNthWord(l.str_layout,2);
		temp2 := STD.Str.SplitWords(temp1,':');
		SELF.fieldName := std.str.tolowercase(temp2[1]);
		self.layoutName := layoutName;
	end;	
	
	BOOLEAN IsValidLayout(string str) := Function
		return map (
			STD.Str.CountWords(str,' ') <2 => false,
			STD.Str.GetNthWord(str,2) = ':=' => false,
			STD.Str.GetNthWord(str,2) = '-' => false,
			RegExFind('\\(',STD.Str.GetNthWord(str,1),nocase) = TRUE => false,
			RegExFind('//',STD.Str.GetNthWord(str,1),nocase) = TRUE => false,
			RegExFind('[\\.,]',STD.Str.GetNthWord(str,1),nocase) = TRUE => false,
			true);
	end;

	allfieldsDS :=project (cleanedDS(IsValidLayout(str_layout)),cleanLayouts(left));

	allfieldsDeduped := dedup(allfieldsDS, record,all);

	return allfieldsDeduped;
end;