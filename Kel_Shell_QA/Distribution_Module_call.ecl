EXPORT Distribution_Module_call(unique_field, inut_file_records,Tag) := FUNCTIONMACRO

test:=record
	unsigned seq_num;
 recordof(inut_file_records);
end;

Kel_Shell_QA.Data_change_macro2(inut_file_records,test,fileop);

Kel_Shell_QA.Distribution_Module.Dis_Macro(unique_field, fileop, op, op2)

// final_report:=output(op,,'~kel_shell::out::attributes_results_'+ tag,thor);

// final_report_summary_pjt:=project(op2,transform({STRING Accountnumber; STRING Attribute;STRING Category;STRING Distribution_type;STRING Attribute_value; recordof(inut_file_records)},self:=left;));

// final_report_summary:=output(distribute(final_report_summary_pjt,random()),,'~kel_shell::out::attributes_results_Summary_'+ tag,thor,compressed,expire(30));

RETURN op;
ENDMACRO;