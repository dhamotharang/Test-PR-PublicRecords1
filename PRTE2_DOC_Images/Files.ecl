import data_services, OKC_Sexual_Offenders,std, prte2_doc, ut;

EXPORT Files := module

//Base Offender File
export offender_base 	:= prte2_doc.Files.file_offenders_base_plus(trim(image_link,left,right) <> '');

export prep_lookup_images_in := dataset('~thor_200::in::prte_hd_crim_off::lookup::superfile', Layouts.Crim_Pics_Lookup, csv(separator('/'),terminator(['\r\n','\r','\n']),quote('"')));
export lookup_images_in := project(prep_lookup_images_in(std.str.find(column_1,'tmp',1) = 0), transform(Layouts.Crim_Pics_Lookup,
																																																																				self.column_1 := STD.Str.ToUpperCase(fn_ConvertVendorSource(left.column_1));
																																																																				self.column_2	:= 'PHOTOS';
																																																																				self.column_3	:= left.column_1;
																																																																				self := left;
																																																																				));


OKC_Sexual_Offenders.Layout_OKC_Pics_Lookup fixState(lookup_images_in l):= transform
	 self.state_of_origin := if(trim(l.column_1, left, right)<>'', trim(l.column_1, left, right)[1..2],''); //need to populate only the state
	 self.image_file_name := if(regexfind('.JPG|.JPEG|.GIF|.jpg', trim(l.column_3, left, right), 0)<>'',
																													trim(l.column_3, left, right),
																													if(regexfind('.JPG|.JPEG|.GIF|.jpg', trim(l.column_2, left, right), 0)<>'',
																													trim(l.column_2, left, right),
																													''));
	 self := l;
 end;
 	
export Crim_Pics_Lookup := project(lookup_images_in,fixState(left));
 
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