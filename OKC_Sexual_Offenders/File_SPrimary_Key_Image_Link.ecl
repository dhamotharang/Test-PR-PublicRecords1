import OKC_Sexual_Offenders;

in_base_file := OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In(trim(image_link,left,right) <> '');

//ds_sprimary_key_image_link := table(in_base_file, OKC_Sexual_Offenders.Layout_SPKey_ImageLink);

OKC_Sexual_Offenders.Layout_SPKey_ImageLink trfProject(in_base_file l) := transform
	self.payload := trim(l.seisint_primary_key,left,right) + '|' + l.image_link;
end;

ds_sprimary_key_image_link := project(in_base_file, trfProject(left));

export File_SPrimary_Key_Image_Link := output(ds_sprimary_key_image_link,,OKC_Sexual_Offenders.Cluster + 'base::OKC_Sex_Offender_SPKey_ImageLink',overwrite);