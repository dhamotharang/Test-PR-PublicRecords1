IMPORT STD ; 
EXPORT fn_document_number(STRING20 doc1_num_in, STRING20 doc2_num_in) := FUNCTION
	tdoc1_0 	:= TRIM(doc1_num_in);
	lenDoc1_0 := LENGTH(tdoc1_0);
	tdoc2_0 	:= TRIM(doc2_num_in);
	lenDoc2_0 := LENGTH(tdoc2_0);
	
	bDoc1Longer := lenDoc1_0 > lenDoc2_0;
 	tdoc1	:= IF(bDoc1Longer, tdoc1_0, tdoc2_0);
	tdoc2 := IF(bDoc1Longer, tdoc2_0, tdoc1_0);
	lenDoc1 := IF(bDoc1Longer, lenDoc1_0, lenDoc2_0);
	lenDoc2 := IF(bDoc1Longer, lenDoc2_0, lenDoc1_0);
	
	minLength := 4;
	lenDiff := lenDoc1 - lenDoc2;
	rtdoc1  := STD.STR.Reverse(tdoc1); 
  rtdoc2  := STD.STR.Reverse(tdoc2);
  
	RETURN MAP( lenDoc2 < minLength	=> FALSE,
						  lenDoc2 >= minLength AND (tdoc2 = tdoc1[1..lenDoc2] OR rtdoc2 = rtdoc1[1..lenDoc2]) => TRUE,
              tdoc1 = tdoc2 OR rtdoc1= rtdoc2=> TRUE, 
             FALSE);

END;