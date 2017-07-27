import ut;
string field_name_proto(unsigned2 i) := '';
export fn_pretty_hypothesis(string s, dataset(layout_classify_hypothesis) hy, field_name_proto fnp) := FUNCTION
  R := RECORD
	  string Value := ut.Words(s,hy.StartPos,hy.StartPos+hy.Len-1);
		string ValueType := fnp(hy.TokenType);
	  hy;
	END;
	RETURN table(hy,R);
  END;
