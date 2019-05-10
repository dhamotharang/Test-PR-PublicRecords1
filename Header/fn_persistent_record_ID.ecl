import header;

EXPORT fn_persistent_record_ID(head_in, is_QH = false) := functionmacro

#UNIQUENAME(head_append_PID);
%head_append_PID% := project(head_in, transform({head_in},
self.persistent_record_ID := HASH64(StringLib.Data2String(HASHMD5(
									trim(left.fname)+','+
                                    trim(left.lname)+','+
                                    trim(left.mname)+','+
									trim(left.name_suffix)+ ','+
							        trim(left.prim_range)+','+
							        trim(left.predir)+ ','+
							        trim(left.prim_name)+ ','+
							        trim(left.suffix)+','+
							        trim(left.postdir)+','+
							        trim(left.unit_desig)+ ','+
							        trim(left.sec_range)+','+
							        trim(left.city_name)+','+
							        trim(left.st)+','+
							        trim(left.zip)+','+
							        trim(left.zip4)+','+
									trim((string8)left.dob)+','+
									trim(left.ssn)+','+
									trim(left.phone)+','+ 
									trim(if(is_QH and left.src in ['QH', 'WH'], 'EQ', left.src))+','))),
                                    self := left));

return %head_append_PID%;

endmacro;