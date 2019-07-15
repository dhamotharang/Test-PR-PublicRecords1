import file_compare,std,prte2_SexOffender_Images;

//Original Base Version
file_images_base_new					:= prte2_sexoffender_images.Files.Images_base;
file_images_base_father		:= dataset(prte2_sexoffender_images.Constants.base_prefix_name+ 'matrix_images_father', prte2_sexoffender_images.Layouts.matrix_images, flat);

//Original Refomatted Version
file_images_base_v2_new				:= prte2_sexoffender_images.Files.Images_base_v2;
file_images_base_v2_father	:= dataset(prte2_sexoffender_images.Constants.base_prefix_name_v2+ 'matrix_images_father', prte2_sexoffender_images.Layouts.matrix_images_v2, flat);


EXPORT fn_DeltaBaseFiles(string filedate) := 
ordered(
file_compare.Fn_File_Compare(file_images_base_father,
																													file_images_base_new,
																													prte2_sexoffender_images.Layouts.matrix_images,,prte2_sexoffender_images.Layouts.matrix_images,true,,true,true,'PRTE_SEXOFFENDER_IMAGES','file_base_images',filedate),
																													
file_compare.Fn_File_Compare(file_images_base_v2_father,
																													file_images_base_v2_new,
																													prte2_sexoffender_images.Layouts.matrix_images_v2,,prte2_sexoffender_images.Layouts.matrix_images_v2,true,,true,true,'PRTE_SEXOFFENDER_IMAGES','file_base_images_v2',filedate)
																													
);