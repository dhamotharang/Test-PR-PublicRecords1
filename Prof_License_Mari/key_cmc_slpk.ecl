import doxie_files, doxie, ut, Data_Services, fcra;


base_file := Prof_License_Mari.file_mari_search;

KeyName 			:= 'thor_data400::key::proflic_mari::';

export key_cmc_slpk := 	index(base_file
																	,{CMC_SLPK,AFFIL_TYPE_CD,STD_SOURCE_UPD}
																	,{base_file} - enh_did_src
																	,Data_Services.Data_location.Prefix('mari')+ KeyName+ doxie.Version_SuperKey+'::cmc_slpk');


