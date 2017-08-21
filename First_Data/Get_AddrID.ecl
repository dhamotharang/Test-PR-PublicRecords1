import infutor, header;

AddressID(infutor.Layout_DID h) := 
  header.AddressID_Fromparts(h.prim_range,h.predir,h.prim_name,h.addr_suffix,h.postdir,h.sec_range,h.zip,h.st);

first_data.layout_fatrec t_addr_id(infutor.Layout_DID l) := transform
 self.addr_id := AddressID(l);
 self         := l;
end;

export Get_AddrID := project(Infutor.Map_file_infutor_did_new2old,t_addr_id(left));