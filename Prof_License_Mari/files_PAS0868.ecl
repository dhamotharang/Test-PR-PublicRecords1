// PAS0868 / Pennsylvania, Commonwealth of  - Prof License / Multiple Professions //
EXPORT files_PAS0868 := MODULE

	//Active - id_900_type_12001_active_format_B
	//         id_900_type_12005_active_format_B
	//         id_900_type_12010_active_format_B
	//         id_900_type_12030_active_format_B
	EXPORT active 		:= 	dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'active', 
																Prof_License_Mari.layout_PAS0868.active,
																THOR);
	//inactive - id_900_type_12001_inactive_format_B
	//           id_900_type_12005_inactive_format_B
	//           id_900_type_12010_inactive_format_B
	//           id_900_type_12030_inactive_format_B
	EXPORT inactive		:=  dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'inactive', 
																Prof_License_Mari.layout_PAS0868.inactive,
																THOR);
	//active_1 - id_1200_type_12001_active_format_B
	//           id_1200_type_12270_A-E_active_format_B
	//           id_1200_type_12270_F-J_active_format_B
	//           id_1200_type_12270_K-N_active_format_B
	//           id_1200_type_12270_O-T_active_format_B
	//           id_1200_type_12270_U-Z_active_format_B
	//           id_1200_type_12310_active_format_B
	EXPORT active_1		:= 	dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'active_1', 
																Prof_License_Mari.layout_PAS0868.active_1,
																THOR);

	//inactive_1 - id_1200_type_12001_inactive_format_B
	//             id_1200_type_12270_A-E_inactive_format_B
	//             id_1200_type_12270_F-J_inactive_format_B
	//             id_1200_type_12270_K-N_inactive_format_B
	//             id_1200_type_12270_O-T_inactive_format_B
	//             id_1200_type_12270_U-Z_inactive_format_B
	//             id_1200_type_12310_inactive_format_B
	EXPORT inactive_1	:= 	dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'inactive_1', 
																Prof_License_Mari.layout_PAS0868.inactive_1,
																THOR);

	//active_2 - id_1200_type_12190_active_format_A
	EXPORT active_2		:= 	dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'active_2', 
																Prof_License_Mari.layout_PAS0868.active_2,
																THOR);

	//inactive_2 - id_1200_type_12190_inactive_format_A
	EXPORT inactive_2	:=	dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'inactive_2', 
																Prof_License_Mari.layout_PAS0868.inactive_2,
																THOR);

	//active_3 - id_1200_type_12150_active_format_A
	//           id_1200_type_12200_active_format_A
	EXPORT active_3:= 	dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'active_3', 
																Prof_License_Mari.layout_PAS0868.active_3,
																THOR);

	//inactive_3 - id_1200_type_12150_inactive_format_A
	//             id_1200_type_12200_inactive_format_A
	EXPORT inactive_3:=dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'inactive_3', 
																Prof_License_Mari.layout_PAS0868.inactive_3,
																THOR)
											 ;

	//inactive_4 - id_1200_type_12270_K-N_inactive_format_A
	EXPORT inactive_4:=dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PAS0868' + '::' + 'using' + '::' + 'inactive_4', 
																Prof_License_Mari.layout_PAS0868.inactive_4,
																THOR)
											 ;

END;	