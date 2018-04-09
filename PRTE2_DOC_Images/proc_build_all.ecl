EXPORT proc_build_all(string filedate) := function
 do_all := sequential(
																					 fSpray(filedate),
																						Move_Image_Files(filedate),
																						proc_build_base(filedate),
																						proc_build_base_v2(filedate),
																						proc_build_keys(filedate));
 return do_all;
end;