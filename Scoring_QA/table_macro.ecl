EXPORT table_macro(ds,table_field,table_field1,result):=macro	

  
	
#uniquename(tble)
%tble% := table(ds);
		
		#uniquename(table_lay)
		%table_lay%:=record		
		string field_name:=%tble%.#expand(table_field);
		real8 total:=%tble%.#expand(table_field1);
		integer total_change:= COUNT(GROUP);
		end;
		
		#uniquename(table_print)
	%table_print%:=	table( %tble%,%table_lay%,#expand(table_field),#expand(table_field1));
	
	result :=%table_print%;
		
		
endmacro;