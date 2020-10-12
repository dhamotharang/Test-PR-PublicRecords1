EXPORT descriptive_Stats_Report(unique_field, inut_file_records) := FUNCTIONMACRO

test:=record
	unsigned seq_num;
 recordof(inut_file_records);
end;

Kel_Shell_QA.Data_change_macro2(inut_file_records,test,fileop);

Kel_Shell_QA.Distribution_Module.Traditional_Metrics_Macro(unique_field, fileop, op)

result:=project(op,transform( { string wuid; 
                                      string logical_file_name;
                                      integer file_cnt;
	                                    string category;
	                                    string attribute;
																			string distribution_type;
																			string attribute_value;
																			string attribute_range;
																			integer8 min_value;
																			integer8 max_value;
																			real8 mid_range;
																			real8 mean;
																			real8 std_dev;},self.wuid:=WORKUNIT;
																			                self.logical_file_name:=workunit;
																			                self.file_cnt:=count(inut_file_records);self:=left;
																		))(attribute_value in ['VALID']);

		final_report:=output(result,named('Descriptive_Stats_Report'));

RETURN final_report;			

ENDMACRO;