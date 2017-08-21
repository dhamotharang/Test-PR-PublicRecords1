import LN_Property;

#workunit ('name', 'Build Property Keys');

//string16 wuid := '' : stored('wuid'); 

//#stored('wuid','w20051019')

export Out_MoxiePropertyPostKeys := 

sequential(
LN_Property.Out_MoxiePropertyAssessorKeys,

LN_Property.Out_MoxiePropertyDeedsKeys,

LN_Property.Out_MoxiePropertySearchkeys_Fpos,

LN_Property.Out_MoxiePropertySearchKeys_Part1,

LN_Property.Out_MoxiePropertySearchKeys_Part2,

LN_Property.Out_MoxiePropertySupplementalKeys,

LN_Property.Out_MoxiePropertySearchKeys_Part3

): failure(FileServices.sendemail('kgummadi@seisint.com','property Key Build Failure',failmessage));






