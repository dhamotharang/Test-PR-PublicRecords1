﻿EXPORT Output_Distribution_Report_Module(unique_field, inut_file_records) := FUNCTIONMACRO

test:=record
	unsigned seq_num;
 recordof(inut_file_records);
end;

Kel_Shell_QA.Data_change_macro2(inut_file_records,test,fileop);

Kel_Shell_QA.Distribution_Module.Dis_Macro(unique_field, fileop, op, op2)

final_report:=output(op);

final_report_summary_pjt:=project(op2,transform({STRING Accountnumber; STRING Attribute;STRING Category;STRING Distribution_type;STRING Attribute_value; recordof(inut_file_records)},self:=left;));

final_report_summary:=output(op2);

seq:=sequential(final_report, final_report_summary);

RETURN seq;

ENDMACRO;