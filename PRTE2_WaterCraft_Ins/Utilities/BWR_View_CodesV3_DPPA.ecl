IMPORT Codes;

DS := Codes.Key_Codes_V3(file_name='GENERAL' and field_name='DL-PURPOSE');
// OUTPUT(DS,ALL);

DS_Pretty := PROJECT(DS,RECORDOF(DS)-__fpos);
OUTPUT(DS_Pretty,ALL);