EXPORT Fn_Combine_FieldValueList(DATASET(Layout_FieldValueList) le, DATASET(Layout_FieldValueList) ri) := FUNCTION
  Layout_FieldValueList cb(Layout_FieldValueList lef) := TRANSFORM
	  SELF.cnt := lef.cnt + ri(val=lef.val)[1].cnt;
	  SELF.val := lef.val;
	END;
	RETURN TOPN(PROJECT(le, cb(LEFT)) & ri(NOT EXISTS(le(val = ri.val))),50,-cnt);
  END;
