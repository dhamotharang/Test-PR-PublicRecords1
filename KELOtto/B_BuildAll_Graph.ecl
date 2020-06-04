//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Address,B_Bank,B_Bank_Account,B_Customer,B_Drivers_License,B_Email,B_Event,B_Internet_Protocol,B_Person,B_Person_Address,B_Person_Bank_Account,B_Person_Drivers_License,B_Person_Email,B_Person_Ip_Address,B_Person_Person,B_Person_Phone,B_Person_S_S_N,B_Phone,B_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_BuildAll_Graph := MODULE
  EXPORT Indexes := DATASET([
    {'Address_UID',B_Address.IDX_Address_UID_Name,B_Address.IDX_Address_UID_Name},
    {'Bank_UID',B_Bank.IDX_Bank_UID_Name,B_Bank.IDX_Bank_UID_Name},
    {'Bank_Account_UID',B_Bank_Account.IDX_Bank_Account_UID_Name,B_Bank_Account.IDX_Bank_Account_UID_Name},
    {'Customer_UID',B_Customer.IDX_Customer_UID_Name,B_Customer.IDX_Customer_UID_Name},
    {'Drivers_License_UID',B_Drivers_License.IDX_Drivers_License_UID_Name,B_Drivers_License.IDX_Drivers_License_UID_Name},
    {'Email_UID',B_Email.IDX_Email_UID_Name,B_Email.IDX_Email_UID_Name},
    {'Event_UID',B_Event.IDX_Event_UID_Name,B_Event.IDX_Event_UID_Name},
    {'Internet_Protocol_UID',B_Internet_Protocol.IDX_Internet_Protocol_UID_Name,B_Internet_Protocol.IDX_Internet_Protocol_UID_Name},
    {'Person_UID',B_Person.IDX_Person_UID_Name,B_Person.IDX_Person_UID_Name},
    {'Person_Address_Location_',B_Person_Address.IDX_Person_Address_Location__Name,B_Person_Address.IDX_Person_Address_Location__Name},
    {'Person_Bank_Account_Account_',B_Person_Bank_Account.IDX_Person_Bank_Account_Account__Name,B_Person_Bank_Account.IDX_Person_Bank_Account_Account__Name},
    {'Person_Drivers_License_License_',B_Person_Drivers_License.IDX_Person_Drivers_License_License__Name,B_Person_Drivers_License.IDX_Person_Drivers_License_License__Name},
    {'Person_Email_Emailof_',B_Person_Email.IDX_Person_Email_Emailof__Name,B_Person_Email.IDX_Person_Email_Emailof__Name},
    {'Person_Ip_Address_Ip_',B_Person_Ip_Address.IDX_Person_Ip_Address_Ip__Name,B_Person_Ip_Address.IDX_Person_Ip_Address_Ip__Name},
    {'Person_Person_From_Person_',B_Person_Person.IDX_Person_Person_From_Person__Name,B_Person_Person.IDX_Person_Person_From_Person__Name},
    {'Person_Phone_Phone_Number_',B_Person_Phone.IDX_Person_Phone_Phone_Number__Name,B_Person_Phone.IDX_Person_Phone_Phone_Number__Name},
    {'Person_S_S_N_Social_',B_Person_S_S_N.IDX_Person_S_S_N_Social__Name,B_Person_S_S_N.IDX_Person_S_S_N_Social__Name},
    {'Phone_UID',B_Phone.IDX_Phone_UID_Name,B_Phone.IDX_Phone_UID_Name},
    {'Social_Security_Number_UID',B_Social_Security_Number.IDX_Social_Security_Number_UID_Name,B_Social_Security_Number.IDX_Social_Security_Number_UID_Name}]
  ,{KEL.typ.str indexName,KEL.typ.str logicalName,KEL.typ.str superName});
  EXPORT BuildAll := PARALLEL(B_Address.BuildAll,B_Bank.BuildAll,B_Bank_Account.BuildAll,B_Customer.BuildAll,B_Drivers_License.BuildAll,B_Email.BuildAll,B_Event.BuildAll,B_Internet_Protocol.BuildAll,B_Person.BuildAll,B_Person_Address.BuildAll,B_Person_Bank_Account.BuildAll,B_Person_Drivers_License.BuildAll,B_Person_Email.BuildAll,B_Person_Ip_Address.BuildAll,B_Person_Person.BuildAll,B_Person_Phone.BuildAll,B_Person_S_S_N.BuildAll,B_Phone.BuildAll,B_Social_Security_Number.BuildAll);
END;
