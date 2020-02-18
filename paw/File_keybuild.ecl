IMPORT  RoxieKeyBuild,ut,autokey,doxie, header_services,business_header,mdr, aid;

export File_keybuild(

	dataset(paw.layout.Employment_Out	) pPawBase	= paw.File_base_cleanAddr_keybuild

) :=
function

	emp_all_full_out_suppress := paw.Prep_Build.applyEmploymentSup(pPawBase);

	File_To_Process_To_Key := paw.Prep_Build.applyEmploymentInj(emp_all_full_out_suppress);
	
		
	//===================================================================
	// convert to old layout for keys
	// -----------------------------------------
	dTooldlayout := project(File_To_Process_To_Key
		,transform(
			 paw.Layout.Employment_Out
			,self					:= left;
		)
	);

	return dTooldlayout;

end;