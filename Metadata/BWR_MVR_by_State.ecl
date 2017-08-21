//Edited from MVR.ecl by John J. Bulten 20070418
//MVR by State W20071128-110329

import vehlic;

dDev :=	VehicleV2.file_vehicleV2_party/*(orig_state='AK' OR 
						orig_state='AL' OR orig_state='CO' OR
						orig_state='CT' OR orig_state='DC' OR
						orig_state='DE' OR orig_state='FL' OR
						orig_state='ID' OR orig_state='IL' OR
						orig_state='KY' OR orig_state='LA' OR
						orig_state='MA' OR orig_state='MD' OR
						orig_state='ME' OR orig_state='MI' OR
						orig_state='MN' OR orig_state='MO' OR						
						orig_state='MS' OR orig_state='MT' OR 
						orig_state='NC' OR orig_state='ND' OR
						orig_state='NE' OR orig_state='NM' OR						
						orig_state='NV' OR orig_state='NY' OR 
						orig_state='OH' OR orig_state='OK' OR 
						orig_state='SC' OR orig_state='TN' OR
						orig_state='TX' OR orig_state='UT' OR 
						orig_state='WI' OR orig_state='WY')*/;

rDev
 :=
  record
	dDev.orig_state;
//	dDev.REGISTRATION_EFFECTIVE_DATE;
//	dDev.TITLE_ISSUE_DATE;
//	dDev.FIRST_REGISTRATION_DATE;
//	dDev.PLATE_ISSUE_DATE;
	unsigned8	Total	:=	count(group);
  end
 ;

dDevTable	:=	table(dDev,rDev,orig_state/*,REGISTRATION_EFFECTIVE_DATE,TITLE_ISSUE_DATE,FIRST_REGISTRATION_DATE,PLATE_ISSUE_DATE*/,few);
sortDevTable := sort(dDevTable,orig_state/*,-REGISTRATION_EFFECTIVE_DATE,-TITLE_ISSUE_DATE,-FIRST_REGISTRATION_DATE,-PLATE_ISSUE_DATE*/);

output(sortDevTable,all,named('Vehicle_Coverage_by_State'));

/*export mvr_by_state :=
parallel(
output(choosen(sortDevTable(orig_state='AK'),100)),
output(choosen(sortDevTable(orig_state='AL'),100)),
output(choosen(sortDevTable(orig_state='CO'),100)),
output(choosen(sortDevTable(orig_state='CT'),100)),
output(choosen(sortDevTable(orig_state='DC'),100)),
output(choosen(sortDevTable(orig_state='DE'),100)),
output(choosen(sortDevTable(orig_state='FL'),100)),
output(choosen(sortDevTable(orig_state='ID'),100)),
output(choosen(sortDevTable(orig_state='IL'),100)),
output(choosen(sortDevTable(orig_state='KY'),100)),
output(choosen(sortDevTable(orig_state='LA'),100)),
output(choosen(sortDevTable(orig_state='MA'),100)),
output(choosen(sortDevTable(orig_state='MD'),100)),
output(choosen(sortDevTable(orig_state='ME'),100)),
output(choosen(sortDevTable(orig_state='MI'),100)),
output(choosen(sortDevTable(orig_state='MN'),100)),
output(choosen(sortDevTable(orig_state='MO'),100)),
output(choosen(sortDevTable(orig_state='MS'),100)),
output(choosen(sortDevTable(orig_state='MT'),100)),
output(choosen(sortDevTable(orig_state='NC'),100)),
output(choosen(sortDevTable(orig_state='ND'),100)),
output(choosen(sortDevTable(orig_state='NE'),100)),
output(choosen(sortDevTable(orig_state='NM'),100)),
output(choosen(sortDevTable(orig_state='NV'),100)),
output(choosen(sortDevTable(orig_state='NY'),100)),
output(choosen(sortDevTable(orig_state='OH'),100)),
output(choosen(sortDevTable(orig_state='OK'),100)),
output(choosen(sortDevTable(orig_state='SC'),100)),
output(choosen(sortDevTable(orig_state='TN'),100)),
output(choosen(sortDevTable(orig_state='TX'),100)),
output(choosen(sortDevTable(orig_state='UT'),100)),
output(choosen(sortDevTable(orig_state='WI'),100)),
output(choosen(sortDevTable(orig_state='WY'),100))
);*/