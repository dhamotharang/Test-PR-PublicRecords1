IMPORT  RoxieKeyBuild,ut,autokey,doxie, header_services,business_header,mdr, aid;

export File_keybuild_BIPv2(

	dataset(paw.layout.Employment_Out_BIPv2	) pPawBase	= paw.File_base_cleanAddr_keybuild_BIPv2
	                                                

) :=
function

	emp_all_full_out_suppress := paw.Prep_Build.applyEmploymentSup(pPawBase);

	File_To_Process_To_Key := paw.Prep_Build.applyEmploymentInj(emp_all_full_out_suppress);
	
	return File_To_Process_To_Key;

end;