EXPORT Layout_Comparison_Macro2(src_file_pjt, desti_file, src_logical_file, desti_logical_file):= FUNCTIONMACRO

  RULES:=Kel_Shell_Entity_QA.Rules;
	
  src_filtered_lay:=nothor(STD.STr.SplitWords(trim(Kel_Shell_Entity_QA.Get_layout(src_logical_file),left,right),' ')); 
  desti_filtered_lay:=nothor(STD.STr.SplitWords(trim(Kel_Shell_Entity_QA.Get_layout(desti_logical_file),left,right),' '));
 
	source_file_rules_jn:= join(rules,project(source_file_pjt,transform({recordof(source_file_pjt)},self.seq:=1;self:=left;)), 
									left.seq=right.seq, left outer);
									
	destination_file_rules_jn:= join(rules,project(desti_file,transform({integer seq;recordof(desti_file)},self.seq:=1;self:=left;)), 
									left.seq=right.seq, left outer);							

	output_lay:= RECORD
		string unique_id;
		string field;
		string result;
	END;

 src_projected:=project(source_file_rules_jn,transform(output_lay, 
                              self.unique_id:=(string)left.uid;
                              self.field:=trim(left.src_field,left,right);
                              self.result:=Kel_Shell_Entity_QA.SRC_test(ROW(left, recordof(source_file_rules_jn)), trim(left.src_field,left,right), src_filtered_lay);
   													 ));
														 
 desti_projected:=project(destination_file_rules_jn,transform(output_lay, 
                              self.unique_id:=(string)left.ultid;
															self.field:=trim(left.desti_field,left,right);
															self.result:=Kel_Shell_Entity_QA.DESTI_test(ROW(left, recordof(destination_file_rules_jn)), trim(left.desti_field,left,right), desti_filtered_lay);

   													 ));

	output_result_lay:= RECORD
		string src_unique_id;
		string desti_unique_id;
		string src_field;
		string desti_field;
		Boolean src_result;
		Boolean Desti_result;
	END;

	result:= join(src_projected,desti_projected,left.unique_id=right.unique_id, 
																							transform(output_result_lay,
																												 self.src_unique_id:=left.unique_id;
																												 self.desti_unique_id:=right.unique_id;
																												 self.src_field:=left.field;
																												 self.desti_field:=right.field;  
																												 self.src_result:= STD.Date.IsValidDate((integer)left.result);
																												 self.Desti_result:= STD.Date.IsValidDate((integer)right.result);
																												));

	final_result:=project(result,transform({recordof(result);string result;}, self.result:= if(left.src_result and left.Desti_result = TRUE,'PASS','FAIL'); self:=left;));

	RETURN dedup(final_result,all);

ENDMACRO;