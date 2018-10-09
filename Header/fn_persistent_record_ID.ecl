import header;

EXPORT fn_persistent_record_ID(dataset(header.Layout_Header) head_in, boolean is_QH = false) := function

head_append_PID := project(head_in, transform(header.Layout_Header,
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

return head_append_PID;

end;