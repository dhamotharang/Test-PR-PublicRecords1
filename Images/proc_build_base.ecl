import ut;

_all_images :=  //Images.Images_CT_dc +
			 //Images.Images_FL_dc + 
			 //Images.Images_FL_dl + 
			 Images.Images_GA    + 
			 //Images.Images_MI_dc +
			 //Images.Images_PA_dc +
			 //Images.Images_ARdc_In + // taken out for missing source cjm20050508
			 //Images.Images_IL_dc +   // same
			 //Images.Images_KS_dc +   // same
			 //Images.Images_KY_dc +	  // same
			 Images.Images_NC_dc + 
			 Images.Images_MNdc_In +
			 //Images.Images_NJ_dc +		// same
			 //Images.Images_OKdc_In +	// same
			 images.File_Sexoffender_Combined;

// Make sure the id's are left justified
Images.Layout_Common trimmer(Images.Layout_Common L) :=
TRANSFORM
	SELF.id := TRIM(L.id, ALL);
	SELF := L;
END;

trimmed := PROJECT(_all_images, trimmer(LEFT));

images.Layout_Common get_dids(trimmed l, images.File_idDID R) := transform
	self.did := R.did;
	self := L;
end;


pre := proc_build_idDID;

withdid := join(trimmed,images.File_idDID, left.state = right.state and
					left.rtype = right.rtype and
					left.id = right.id,get_dids(LEFT,RIGHT),left outer,hash);
					


ut.MAC_SF_BuildProcess(withdid,'~images::base::Matrix_Images',do1,2)

export proc_build_base := sequential(pre,do1);