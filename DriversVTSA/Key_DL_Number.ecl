import doxie;
export Key_DL_Number := INDEX(Key_prep_DL_number(dl_number <> ''), 
			{typeof(Key_prep_DL_number.dl_number) s_dl := Key_prep_DL_number.dl_number},
				{Key_prep_DL_number}, 
				constants.cluster + 'key::dl_VTSA::'+doxie.Version_SuperKey+'::dl_number');

