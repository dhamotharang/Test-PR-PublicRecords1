export Lookup_OR_Crim_Data := module

/*
Contains lookups for the following:

Criminal Court Case Type/Status descriptions:
*/

export Case_Type_lookup (string case_type) := case(case_type
											,'APCR' => 'Appeal Criminal'
											,'APDS' => 'Appeal Death Sentence'
											,'APHC' => 'Appeal Habeas Corpus'
											,'APJL' => 'Appeal Juvenile Delinquency'
											,'APJV' => 'Appeal Juvenile'
											,'APPC' => 'Appeal Post Conviction'
											,'APPR' => 'Appeal Parol Review'
											,'APTR' => 'Appeal Traffic'
											,'JUDF' => 'Juvenile Delinquency: Felony'
											,'JUDI' => 'Juvenile Delinquency: Infraction'
											,'JUDM' => 'Juvenile Delinquency: Misdemeanor'
											,'JUDV' => 'Juvenile Delinquency: Violation'
											,'JUJU' => 'Juvenile'
											,'JUOT' => 'Juvenile Other'
											,'JURM' => 'Juvenile Remand'
											,'JUSO' => 'Juvenile Status Offense'
											,'OFEX' => 'Offense Extradition'
											,'OFFE' => 'Offense Felony I'
											,'OFIF' => 'Offense Infraction'
											,'OFMI' => 'Offense Misdemeanor I'
											,'OFOT' => 'Offense Other'
											,'OFVI' => 'Offense Violation'
											,'');

export race_description_lookup (string race_code) := case(race_code
											,'AIN' => 'American Indian'
											,'ASN' => 'Asian'
											,'BLK' => 'Black'
											,'CAU' => 'Caucasian'
											,'HSP' => 'Hispanic'
											,'OTH' => 'Other'
											,'');

export eye_description_lookup (string eye_code) := case(eye_code
											,'BLK' => 'Black'
											,'BLU' => 'Blue'
											,'BRO' => 'Brown'
											,'GRN' => 'Green'
											,'GRY' => 'Gray'
											,'HAZ' => 'Hazel'
											,'MAR' => 'Maroon'
											,'MUL' => 'Multicolored'
											,'PNK' => 'Pink'
											,'VIO' => 'Violet'
											,'XXX' => 'Unknown'
											,'');

export hair_description_lookup (string hair_code) := case(hair_code
											,'BLD' => 'Bald'
											,'BLK' => 'Black'
											,'BLN' => 'Blond'
											,'BRO' => 'Brown'
											,'GRY' => 'Gray'
											,'RED' => 'Red'
											,'SDY' => 'Sandy'
											,'WHI' => 'White'
											,'');

export snt_jgmt_units_lookup (string unit_type_code) := case(unit_type_code
											,'$' => 'Dollar amount'
											,'C' => 'Custody Units'
											,'D' => 'Day(s)'
											,'H' => 'Hour(s)'
											,'L' => 'Life'
											,'M' => 'Month(s)'
											,'W' => 'Weekend(s)'
											,'Y' => 'Year(s)'
											,'');

export snt_jgmt_status_lookup (string snt_code_code) := case(snt_code_code
											,'DISC' => 'Discharged'
											,'JGDS' => 'Jgm Dismissd'
											,'JGSA' => 'Jgm Set-Aside'
											,'RVRS' => 'Reversed'
											,'SAPR' => 'Part Satis Jgm'
											,'SATF' => 'Satisfied'
											,'SETA' => 'Set Aside'
											,'SLRP' => 'Sale Real Property'
											,'SUPR' => 'Superseded'
											,'USAT' => 'Unsatisfied'
											,'VCTD' => 'Vacated'
											,'VOID' => 'Void'
											,'');

end;
