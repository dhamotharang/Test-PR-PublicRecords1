/* *****************************************************************************************************
PRTE2_Common_DevOnly.IDLHeader_ApartmentBuildings_File
PRCT DEV ONLY version which for now will just use foreign references to read the key...
***************************************************************************************************** */
import _control, data_services;

export IDLHeader_ApartmentBuildings_File := module

	export ApartmentBuildings_Layout := RECORD
	  string5 zip;
	  string10 prim_range;
	  string28 prim_name;
	  string2 predir;
	  integer4 apt_cnt;
	  integer4 did_cnt;
	END;

	export location := Data_Services.Data_Location.Prefix('IDL_Header');	// Boca always needs foreign APROD

	shared preFix    := location + 'thor_data400::key::';
	shared buildDate := thorlib.wuid()[2..9];

	export sfile_apt_key_base   	:= prefix + 'ApartmentBuilding::base';
	export sfile_apt_key_father		:= prefix + 'ApartmentBuilding::father';
	export file_apt_key    				:= prefix + buildDate + '::ApartmentBuilding';

	// Index dataset
	export key := index(ApartmentBuildings_Layout,	sfile_apt_key_base);

	/*-------------------- updateAptSuperFile ----------------------------------------------------*/
	export updateAptSuperFile(string baseSuperFile, string fatherSuperFile, string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([baseSuperFile, fatherSuperFile], inFile, true)
							);
		return action;
	END;

	/*-------------------- updateAptSuperFile ----------------------------------------------------*/
	t1 := updateAptSuperFile(sfile_apt_key_base, 				sfile_apt_key_father, 			file_apt_key);

	export updateAllSF := sequential(t1);

end;