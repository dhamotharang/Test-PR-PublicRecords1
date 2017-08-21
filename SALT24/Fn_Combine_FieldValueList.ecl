export Fn_Combine_FieldValueList(dataset(Layout_FieldValueList) le, dataset(Layout_FieldValueList) ri) := FUNCTION
  Layout_FieldValueList cb(Layout_FieldValueList lef) := transform
	  self.cnt := lef.cnt + ri(val=lef.val)[1].cnt;
	  self.val := lef.val;
	end;
	return choosen(project(le, cb(left)) + ri(not exists(le(val = ri.val))),50);
  END;
