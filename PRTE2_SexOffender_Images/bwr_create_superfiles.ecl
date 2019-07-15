IMPORT PromoteSupers, roxiekeybuild, PRTE2_Doc_Images,std;


// Input Files
STD.File.CreateSuperFile('~thor_200::in::prte_hd_sex_off::lookup::superfile');
STD.File.CreateSuperFile(Constants.in_prefix_name+ 'varying_sources');
STD.File.CreateSuperFile(Constants.keyname+ 'built::matrix_images');
STD.File.CreateSuperFile(Constants.keyname+ 'delete::matrix_images');
STD.File.CreateSuperFile(Constants.keyname+ 'father::matrix_images');
STD.File.CreateSuperFile(Constants.keyname+ 'grandfather::matrix_images');
STD.File.CreateSuperFile(Constants.keyname+ 'ga::matrix_images');

STD.File.CreateSuperFile(Constants.keyname_v2+ 'built::matrix_images');
STD.File.CreateSuperFile(Constants.keyname_v2+ 'delete::matrix_images');
STD.File.CreateSuperFile(Constants.keyname_v2+ 'father::matrix_images');
STD.File.CreateSuperFile(Constants.keyname_v2+ 'grandfather::matrix_images');
STD.File.CreateSuperFile(Constants.keyname_v2+ 'ga::matrix_images');

//Base Files
promotesupers.mac_create_superfiles(Constants.base_prefix_name + 'matrix_images');
promotesupers.mac_create_superfiles(Constants.base_prefix_name_v2 + 'matrix_images');

//Key Files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte::criminal_images', '::key::sexoffender','matrix_images_did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte::criminal_images_v2', '::key::sexoffender', 'matrix_images_did');

