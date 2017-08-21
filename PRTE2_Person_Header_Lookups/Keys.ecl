IMPORT  doxie,mdr, PRTE2_Person_Header_Lookups;

EXPORT keys := MODULE

	EXPORT key_header_lookups_v2 := INDEX(
		FILES.File_Did_Lookups_v2, 
		{did}, 
		{FILES.File_Did_Lookups_v2}, 
		'~prte::key::header_lookups_v2_'+doxie.Version_SuperKey );

END;
