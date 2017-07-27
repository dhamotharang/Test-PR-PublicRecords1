import images;

myrec := record, maxlength(images.MaxLength_FullImage)
	images.Layout_Common;
	unsigned8 __filepos { virtual (fileposition)};
end;

export File_Images := dataset('~images::base::matrix_images', myrec, flat)(state not in Sex_Offenders_Not_Updating);
