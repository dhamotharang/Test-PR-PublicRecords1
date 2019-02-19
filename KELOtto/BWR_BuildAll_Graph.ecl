//HPCC Systems KEL Compiler Version 0.11.0
#OPTION('expandSelectCreateRow',true);
IMPORT KEL011 AS KEL;
IMPORT B_Address,B_Bank,B_Bank_Account,B_Customer,B_Drivers_License,B_Email,B_Event,B_Internet_Protocol,B_Person,B_Person_Address,B_Person_Bank_Account,B_Person_Drivers_License,B_Person_Email,B_Person_Event,B_Person_Ip_Address,B_Person_Person,B_Person_Phone,B_Person_S_S_N,B_Phone,B_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
PARALLEL(B_Address.BuildAll,B_Bank.BuildAll,B_Bank_Account.BuildAll,B_Customer.BuildAll,B_Drivers_License.BuildAll,B_Email.BuildAll,B_Event.BuildAll,B_Internet_Protocol.BuildAll,B_Person.BuildAll,B_Person_Address.BuildAll,B_Person_Bank_Account.BuildAll,B_Person_Drivers_License.BuildAll,B_Person_Email.BuildAll,B_Person_Event.BuildAll,B_Person_Ip_Address.BuildAll,B_Person_Person.BuildAll,B_Person_Phone.BuildAll,B_Person_S_S_N.BuildAll,B_Phone.BuildAll,B_Social_Security_Number.BuildAll);
