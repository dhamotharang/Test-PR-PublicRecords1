IMPORT	Death_Master,	Header,	ut;
//	To manually suppress a record add the record in V3 Format to this dataset.
//	This attribute suppresses on DID, SSN and State Death ID.
//	Comment out values on which you don't want to suppress and replace with ''
suppresion_layout := record
String comment;
Header.Layout_Did_Death_MasterV3;
End;

dSuppressRecs	:=	dataset('~thor_data400::in::deathmaster_suppression', 
                          suppresion_layout,CSV(HEADING(1),QUOTE('"'),SEPARATOR('\t')));

EXPORT	File_Death_Master_Suppression	:=	dSuppressRecs;
