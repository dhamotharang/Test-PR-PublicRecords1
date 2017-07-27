//HPCC Systems KEL Compiler Version 0.8.2
#OPTION('expandSelectCreateRow',true);
IMPORT KEL08a AS KEL;
IMPORT B_Business,B_Tradeline,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
PARALLEL(B_Business().BuildAll,B_Tradeline().BuildAll);
