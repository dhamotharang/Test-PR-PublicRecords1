import doxie,ut,data_services;
res := File_Relative(not(confidence IN ['NOISE','LOW'] OR (type = '2ND DEGREE' AND confidence = 'MEDIUM')));

export Key_Relatives_v3 := INDEX(res, 
{did1},
{res},   
data_services.Data_Location.Relatives+'thor_data400::key::relatives_v3_' + doxie.version_superkey);

