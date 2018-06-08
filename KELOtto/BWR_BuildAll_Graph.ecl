//HPCC Systems KEL Compiler Version 0.11.0
#OPTION('expandSelectCreateRow',true);
IMPORT KEL011 AS KEL;
IMPORT B_Address,B_Customer,B_Event,B_Person,B_Person_Address,B_Person_Event,B_Person_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
PARALLEL(B_Address.BuildAll,B_Customer.BuildAll,B_Event.BuildAll,B_Person.BuildAll,B_Person_Address.BuildAll,B_Person_Event.BuildAll,B_Person_Person.BuildAll);
