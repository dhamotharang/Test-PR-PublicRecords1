import doxie,ut,data_services;
res := relationship.File_Relative(not(confidence IN ['NOISE','LOW']));

resNeutral := functions_output.convertTitledToKey(res);

export Key_Relatives_v3 := INDEX(resNeutral, 
{did1},
{resNeutral},   
data_services.Data_Location.Relatives+'thor_data400::key::relatives_v3_' + doxie.version_superkey);