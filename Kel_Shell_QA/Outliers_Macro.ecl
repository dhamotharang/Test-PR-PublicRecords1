EXPORT Outliers_Macro(unique_field, inut_file_records, Tag) := FUNCTIONMACRO

test:=record
	unsigned seq_num;
 recordof(inut_file_records);
end;

Kel_Shell_QA.Data_change_macro2(inut_file_records,test,fileop);

Kel_Shell_QA.Distribution_Module.Outliers_Metrics_Macro(unique_field, fileop, op)

#uniquename(report_lay)
%report_lay% :=record
%Outliers%.Attribute;
%Outliers%.Category;
%Outliers%.Distribution_type;
%Outliers%.Result;
INTEGER Result_Cnt:=COUNT(GROUP);
DECIMAL10_2 Result_Perc:=(COUNT(GROUP)/COUNT(inut_file_records))*100;
end;

#uniquename(report)
%report% :=	table(op,%report_lay%,Attribute,Category,Distribution_type,Result);		 							 

result := sort(project(%report%,transform({%report_lay%; integer Crictical_flag;},
                                        self.Crictical_flag:= if(left.Result ='FAIL' and left.Result_Perc>=10,1,0);
																				self:=left;
																				)),-Crictical_flag);
																				
RETURN result;

ENDMACRO;
