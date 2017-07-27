import ut, RoxieKeyBuild, images;

export proc_build_base(string filedate) := function

	_all_images := hygenics_images.File_DOC_Images_Combined.DOC_Concat_All +
					hygenics_images.File_Arrest_Images_Combined.ARR_Concat_All;

	// Make sure the id's are left justified
	Images.Layout_Common trimmer(Images.Layout_Common L) := TRANSFORM
		SELF.id := TRIM(L.id, ALL);
		SELF := L;
	END;

	trimmed := PROJECT(_all_images, trimmer(LEFT));

	images.Layout_Common get_dids(trimmed l, hygenics_images.File_idDID R) := transform
		self.did := R.did;
		self := L;
	end;

	// switched this proc from an output to a persist...need an action for the sequential
	// so outputting the first record to force the persist to build...
	prebuild := output(choosen(hygenics_images.proc_build_idDID,1));

	withdid_join := join(trimmed, hygenics_images.File_idDID, 
						left.state = right.state and
						left.rtype = right.rtype and
						left.id = right.id,
						get_dids(LEFT,RIGHT), left outer, hash);
						
	withdid := withdid_join(image_link<>'' and imglength>0);

RoxieKeyBuild.Mac_SF_BuildProcess(withdid,'~criminal_images::base::Matrix_Images',
                '~criminal_images::base::criminal::'+filedate+'::matrix_images_base', do_build, 2);

return sequential(prebuild, do_build);

end;