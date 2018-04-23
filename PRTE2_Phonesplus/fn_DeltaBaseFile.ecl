import file_compare,std,prte2_phonesplus;

//Original Base Version
file_phonesplus_base_new					:= prte2_phonesplus.files.f_phonesplus_ext;
file_phonesplus_base_father		:= dataset(prte2_phonesplus.Constants.BASE_PREFIX+ 'base_all_father', PRTE2_PhonesPlus.Layouts.Base_ext, flat);



EXPORT fn_DeltaBaseFile(string filedate) := file_compare.Fn_File_Compare(file_phonesplus_base_father,
																																																																									file_phonesplus_base_new,
																																																																									PRTE2_PhonesPlus.Layouts.Base_ext,,PRTE2_PhonesPlus.Layouts.Base_ext,true,,true,true,'PRTE_PHONESPLUS','file_bases',filedate);
																													
