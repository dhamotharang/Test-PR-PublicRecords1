StrType field_name_proto(unsigned2 i) := '';
export fn_pretty_hypothesis(StrType s, dataset(layout_classify_hypothesis) hy, field_name_proto fnp) := FUNCTION
  R := RECORD
	  StrType Value := GetRangeOfWords(s,hy.StartPos,hy.StartPos+hy.Len-1);
		StrType ValueType := fnp(hy.TokenType);
	  hy;
	END;
	RETURN table(hy,R);
  END;
