import data_services;

export Key_Smart_Jury := index(file_smart_jury,
															 {stusab,county,tract,blkgrp},
															 {age,income,home_value,education},
															 data_services.data_location.prefix() + 'thor_data400::key::smart_jury_qa');