﻿//HPCC Systems KEL Compiler Version 0.11.6-2
#OPTION('expandSelectCreateRow',true);
IMPORT KEL011 AS KEL;
IMPORT RQ__show_Customer_Phone FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
__RoxieQuery := RQ__show_Customer_Phone;
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
