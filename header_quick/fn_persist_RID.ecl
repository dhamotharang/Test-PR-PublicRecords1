import header,_control;

EXPORT fn_persist_RID(dataset(header.Layout_Header) head_in, boolean is_QH = true) := function

temp_rec := record
header.Layout_Header;
unsigned8 persistent_record_ID;
end;

head_append_ID := project(head_in, transform(temp_rec, 
self.persistent_record_ID := hash64(trim(left.fname)+
                                    trim(left.lname)+
									                  trim(left.name_suffix)+ 
								                    trim(left.prim_range)+
								                    trim(left.prim_name)+ 
									                  trim(left.sec_range)+
									                  trim(left.city_name)+
									                  trim(left.st)+
									                  trim(left.zip)+
									                  trim((string8)left.dob)+
									                  trim(left.ssn)+
																	  trim(left.mname)+
  																	trim(left.phone)+ 
									                  trim(if(is_QH and left.src in ['QH', 'WH'], 'EQ', left.src))),
                                    self := left));

return head_append_ID;

end;

