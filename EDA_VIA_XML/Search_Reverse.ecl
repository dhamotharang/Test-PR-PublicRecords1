import gong;

export Search_Reverse(STRING3 npa_v, STRING3 nxx_v, STRING4 line_v) := FUNCTION

base_results := PROJECT(EDA_VIA_XML.Key_npa_nxx_line(
															KEYED(npa=npa_v),
															KEYED(nxx=nxx_v),
															KEYED(TRIM(line_v)='' OR line=line_v)),
														TRANSFORM(gong.Layout_bscurrent_raw, 
														          self.sequence_number := (string10)left.sequence_number,
																			SELF:=LEFT));
	
EDA_VIA_XML.Layout_Gong_Extended addScore(gong.Layout_bscurrent_raw l) := TRANSFORM
  SELF.score := 100;
	SELF := l;
END;

return PROJECT(base_results, addScore(LEFT));

END;