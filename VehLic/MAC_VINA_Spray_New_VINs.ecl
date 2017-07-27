export MAC_VINA_Spray_New_VINs(pDateTimeStamp)
 :=
  macro

zDo
 :=
  sequential
   (
	lib_fileservices.FileServices.sprayfixed('10.150.12.240',
											 '/data_999/vin_stuff/processed/' + pDateTimeStamp + '/vina_info.d00',
											 420,
											 'thor_dell400_2',
											 '~thor_data400::in::vehreg_vina_info_' + pDateTimeStamp,
											 ,
											 ,
											 ,
											 false,		// do not overwrite
											 true		// replicate
											),
	lib_fileservices.FileServices.StartSuperFileTransaction(),
	lib_fileservices.FileServices.AddSuperFile('~thor_data400::in::vehreg_vina_info_all',
											   '~thor_data400::in::vehreg_vina_info_' + pDateTimeStamp
											  ),
	lib_fileservices.FileServices.FinishSuperFileTransaction()
   )
 ;

zDo;

  endmacro
 ;