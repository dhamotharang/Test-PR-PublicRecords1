import codes, scrubs;
EXPORT fn_valid_codesv3_property (string code = '', string source = '', string field_name_in = '', string file_name_in = ''):= function
exception := (source = 'O' and field_name_in = 'DOCUMENT_TYPE_CODE') or
							(source = 'O' and field_name_in = 'QUALITY' and code[1] in ['A','B','C', 'D', 'E'] and code[2] in ['', '+', '-']) or
							(file_name_in = 'FARES_1080' and field_name_in = 'DOCUMENT_TYPE_CODE') ;
							
field_name2_in := map(source = 'O' => 'OKCTY',
									    source = 'D' => 'DAYTN',
											source = 'F' => 'FAR_F',
											source = 'S' => 'FAR_S',
											'');
											
return if(exception, 1, Scrubs.fn_valid_codesv3(code, field_name2_in, field_name_in, file_name_in));

end;