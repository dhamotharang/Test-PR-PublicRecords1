import hygenics_crim;

export Out_Validate_In_Files
 :=	parallel(
				output(count(Hygenics_Crim.File_In_Arrest_Offender),named('Arrest_Offender_Records')),
				output(count(Hygenics_Crim.File_In_Arrest_Offenses),named('Arrest_Offenses_Records')),
				//output(count(Hygenics_Crim.File_In_DOC_Offender),named('DOC_Offender_Records')),
				//output(count(Hygenics_Crim.File_In_DOC_Offenses),named('DOC_Offenses_Records')),
				output(count(Hygenics_Crim.File_In_Court_Offender),named('Court_Offender_Records')),
				output(count(Hygenics_Crim.File_In_Court_Offenses),named('Court_Offenses_Records'))
			 )
 ;