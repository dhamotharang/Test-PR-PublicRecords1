//HPCC Systems KEL Compiler Version 0.11.0
#OPTION('expandSelectCreateRow',true);
IMPORT KEL011 AS KEL;
IMPORT RQ__show_Customer_Ip_Address_Entities FROM KELOtto;
IMPORT * FROM KEL011.Null;
__RoxieQuery := RQ__show_Customer_Ip_Address_Entities;
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
