// PAS0868 / Pennsylvania, Commonwealth of  - Prof License / Multiple Professions //
EXPORT files_PAS0868 := MODULE

	//Active - id_900_type_12001_active_format_B
	//         id_900_type_12005_active_format_B
	//         id_900_type_12010_active_format_B
	//         id_900_type_12030_active_format_B
	EXPORT active 		:= 	dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'active', 
																Prof_License_Mari.layout_PAS0868.common,
																CSV(SEPARATOR(','),QUOTE('"')));
	//inactive - id_900_type_12001_inactive_format_B
	//           id_900_type_12005_inactive_format_B
	//           id_900_type_12010_inactive_format_B
	//           id_900_type_12030_inactive_format_B
	EXPORT inactive_1		:=  dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'inactive1', 
																Prof_License_Mari.layout_PAS0868.common,
																CSV(SEPARATOR(','),QUOTE('"')));

	//inactive_2 - id_1200_type_12190_inactive_format_A
	EXPORT inactive_2	:=	dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'inactive2', 
																Prof_License_Mari.layout_PAS0868.common,
																CSV(SEPARATOR(','),QUOTE('"')));

	//inactive_3 - id_1200_type_12150_inactive_format_A
	//             id_1200_type_12200_inactive_format_A
	EXPORT inactive_3:=dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'inactive3', 
																Prof_License_Mari.layout_PAS0868.common,
																CSV(SEPARATOR(','),QUOTE('"')));

	//inactive_4 - id_1200_type_12270_K-N_inactive_format_A
	EXPORT inactive_4:=dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'inactive4', 
																Prof_License_Mari.layout_PAS0868.common,
																CSV(SEPARATOR(','),QUOTE('"')));

END;	