export proc_build(string filedate) := function

 do_all := sequential(address_file.proc_build_file,
					   address_file.proc_build_keys(filedate),
					   address_file.Stats_AddressTypes
					   );
 
return do_all;

end;