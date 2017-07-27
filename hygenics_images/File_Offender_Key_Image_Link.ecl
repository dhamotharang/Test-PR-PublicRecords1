import Hygenics_crim, crim_common;

in_base_file := dataset(Crim_Common.Name_Moxie_Crim_Offender2_Dev +'_new', Hygenics_crim.Layout_Common_Crim_Offender_new, flat)(trim(image_link,left,right) <> '');

	//Keep LN's Original Imagelink Layout
	hygenics_images.Layout_SPKey_ImageLink trfProject(in_base_file l) := transform
		self.payload := trim(l.offender_key,left,right) + '|' + l.image_link;
	end;

	ds_offender_key_image_link := project(in_base_file, trfProject(left));

export File_Offender_Key_Image_Link := output(ds_offender_key_image_link,,'~thor_200::base::hd::Crim_OffKey_ImageLink',overwrite);