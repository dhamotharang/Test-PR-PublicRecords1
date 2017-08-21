EXPORT mac_landflipOutputFOFile(FO) := MACRO

	IMPORT landflip;

	#uniquename(filename)
	string %filename% := '' : stored('filename');

	//Project records with FO into layout without FO
	#uniquename(pLandflipRec)
	%pLandflipRec%	:=	PROJECT(landflip.mapping_landflipFORecs(field_office = FO), landflip.layout_landflipRec);

	OUTPUT(%pLandflipRec%
	     ,
			 , '~thor_data400::out::LANDFLIP_RPT_' + FO + '_' + %filename% + '.txt'
			 , CSV(SEPARATOR('|'), TERMINATOR('\n'), QUOTE(''))
			 , OVERWRITE
			 );

ENDMACRO;