EXPORT proc_build_all(string filedate, boolean skipTest=false) := function
 do_all := sequential(fSpray(filedate),
																						Move_Image_Files(filedate),
																						proc_build_base(filedate),
																						proc_build_base_v2(filedate),
																					 fn_DeltaBaseFile(filedate),				//* Added File Compare to flag major changes
																						if(skipTest=true,														//* If Major changes exist, fail build
																									if(fn_CheckBaseFiles(filedate)=true, OUTPUT('Reverify base files'), OUTPUT('No Major Change during File Compare')
																									)),
																						proc_build_keys(filedate)
																						);
 return do_all;
end;

	