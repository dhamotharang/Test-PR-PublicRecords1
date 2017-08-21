import ut, RoxieKeyBuild, images;

export proc_build_base(string filedate) := function

_all_images :=  Images.Images_FL_dc + 
			 Images.Images_GA    + 
			 Images.Images_MI_dc +
			 Images.Images_ARdc_In + 
			 Images.Images_IL_dc +   
			 Images.Images_KS_dc +   
			 Images.Images_KY_dc +	  
			 Images.Images_NC_dc + 
			 Images.Images_MNdc_In +
			 Images.Images_NJ_dc +		
			 Images.Images_OKdc_In
			 images.File_Sexoffender_Combined;

// Make sure the id's are left justified
Images.Layout_Common trimmer(images.File_Sexoffender_Combined L) :=
TRANSFORM
	SELF.id := TRIM(L.id, ALL);
	SELF := L;
END;

trimmed := PROJECT(_all_images, trimmer(LEFT));

images.Layout_Common get_dids(trimmed l, hygenics_soff.File_idDID R) := transform
	self.did := R.did;
	self := L;
end;

// switched this proc from an output to a persist...need an action for the sequential
// so outputting the first record to force the persist to build...
prebuild := output(choosen(hygenics_soff.proc_build_idDID,1));

withdid_join := join(trimmed,hygenics_soff.File_idDID, left.state = right.state and
					left.rtype = right.rtype and
					left.id = right.id,get_dids(LEFT,RIGHT),left outer,hash);
					
withdid := withdid_join(image_link<>'' and imglength>0);

RoxieKeyBuild.Mac_SF_BuildProcess(withdid,'~images::base::Matrix_Images',
                '~images::base::sexoffender::'+filedate+'::matrix_images_base',do_build,2);
//ut.MAC_SF_BuildProcess(withdid,'~images::base::Matrix_Images',do1,2)

return sequential(prebuild,do_build);
end;