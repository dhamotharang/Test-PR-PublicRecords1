import data_services, OKC_Sexual_Offenders,std, prte2_sexoffender, ut, prte2_doc_images,std;

EXPORT Files := module

//Base Offender File
export sexoffender_base 	:= prte2_sexOffender.Files.SexOffender_base(trim(image_link,left,right) <> '');

export prep_lookup_images_in := dataset('~thor_200::in::prte_hd_sex_off::lookup::superfile', Layouts.lookup_raw, csv(separator('/'),terminator(['\r\n','\r','\n']),quote('"')));
export SexOff_Pics_Lookup := project(prep_lookup_images_in(std.str.find(column_2,'tmp',1) = 0), transform(Layouts.Sex_Offender_Pics_Lookup,
																																																																				self.filler := 'PHOTOS';
																																																																				self.state_of_origin	:= trim(left.column_2, left, right)[1..2];
																																																																				self.image_file_name	:= if(regexfind('.JPG|.JPEG|.GIF|.jpg', trim(left.column_2, left, right), 0) <>'',
																																																																																															trim(left.column_2, left, right),
																																																																																															trim(left.column_2, left, right));
																																																																				self := left;
																																																																				));
 	

export Images_base										:=  dataset(Constants.base_prefix_name+ 'matrix_images', Layouts.matrix_images, flat);
export Images_base_reformat	:=  dataset(Constants.base_prefix_name+ 'matrix_images', Layouts.matrix_images_reformat, flat);
export Images_base_v2				  	:=  dataset(Constants.base_prefix_name_v2+ 'matrix_images', Layouts.matrix_images_v2, flat);


export all_images 							:= Images_base(did != 0, imglength != 0);
export all_images_len 			:= Images_base(imglength != 0);
export all_images_v2 				:= Images_base_v2(did != 0, imglength != 0);
export all_images_len_v2 := Images_base_v2(imglength != 0);

export keyfile_did							:= PROJECT(all_images, layouts.key_did);
export keyfile_id								:= PROJECT(all_images_len, Layouts.Key_id);
export keyfile_did_v2				:= project(all_images_v2, layouts.key_did_v2);
export keyfile_id_v2				 := PROJECT(all_images_len_v2, Layouts.Key_id_v2);

end;