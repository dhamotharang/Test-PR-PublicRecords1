EXPORT Output_Distribution_Report_Module(logical_file_name, unique_field, inut_file_records, Tag) := FUNCTIONMACRO

test:=record
	unsigned seq_num;
 recordof(inut_file_records);
end;

Kel_Shell_QA.Data_change_macro2(inut_file_records,test,fileop);

Kel_Shell_QA.Distribution_Module.Dis_Macro(unique_field, fileop, op, op2)

final_report:=output(op,,'~kel_shell::out::Distribution_Report_'+ tag, CSV(heading(single), quote('"')), overwrite, EXPIRE(30));

final_report_excel := Kel_Shell_QA.Email_Report(logical_file_name,'~kel_shell::out::Distribution_Report_'+ tag , ' Distribution Report ' ,'Dist_Report ', tag  );

final_report_summary_pjt:=project(op2,transform({STRING Accountnumber; STRING Attribute;STRING Category;STRING Distribution_type;STRING Attribute_value; recordof(inut_file_records)},self:=left;));

final_report_summary:=output(distribute(final_report_summary_pjt,random()),,'~kel_shell::out::Distribution_Report_Summary_'+ tag,CSV(heading(single), quote('"')), overwrite, EXPIRE(15));

final_report_summary_excel := Kel_Shell_QA.Email_Report(logical_file_name,'~kel_shell::out::Distribution_Report_Summary_'+ tag , ' Distribution Report Summary' , 'Dist_Summ_Report ',tag  );

seq:=sequential(final_report, final_report_excel);

RETURN seq;

ENDMACRO;