EXPORT Traditional_Stats_Report(logical_file_name, unique_field, inut_file_records, Tag) := FUNCTIONMACRO

test:=record
	unsigned seq_num;
 recordof(inut_file_records);
end;

Kel_Shell_QA.Data_change_macro2(inut_file_records,test,fileop);

Kel_Shell_QA.Distribution_Module.Traditional_Metrics_Macro(unique_field, fileop, op)

result:=project(op,transform( {integer file_cnt;
	                                    string category;
	                                    string attribute;
																			string distribution_type;
																			string attribute_value;
																			string attribute_range;
																			integer8 min_value;
																			integer8 max_value;
																			real8 mid_range;
																			real8 mean;
																			real8 std_dev;},self.file_cnt:=count(inut_file_records);self:=left;
																		))(attribute_value in ['VALID']);

		final_report:=output(result,,'~kel_shell::out::Traditional_Stats_Report_'+ Tag ,CSV(heading(single), quote('"')), overwrite);
		
		final_report_excel := Kel_Shell_QA.Email_Report(logical_file_name, '~kel_shell::out::Traditional_Stats_Report_'+ Tag, ' Traditional Stats Report ',' Traditional Stats Report ',  Tag);
		
		seq:=sequential(final_report, final_report_excel);
		
RETURN seq;			

ENDMACRO;