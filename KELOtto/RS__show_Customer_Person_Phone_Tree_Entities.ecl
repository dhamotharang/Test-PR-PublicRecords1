﻿//HPCC Systems KEL Compiler Version 0.11.6-2
#OPTION('expandSelectCreateRow',true);
IMPORT KEL011 AS KEL;
IMPORT RQ__show_Customer_Person_Phone_Tree_Entities FROM KELOtto;
IMPORT * FROM KEL011.Null;
__RoxieQuery := RQ__show_Customer_Person_Phone_Tree_Entities;
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
