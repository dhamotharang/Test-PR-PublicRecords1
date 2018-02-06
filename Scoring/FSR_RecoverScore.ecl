layout_eltman:= record
string3 file_name;
Scoring.Layout_in_RecoverScore;
end;

file_in:= dataset('~MZ::in::Eltman', layout_eltman,flat);

  Total := count(file_in);
//Missing Input Data
  Account_No := count(file_in(Account_No =''));
  Debt_Type  := count(file_in(Debt_Type	=''));
  First_Name := count(file_in(First_Name =''));
  Last_Name  := count(file_in(Last_Name  =''));
  Street_Address := count(file_in(Street_Address =''));
  City := 	count(file_in(City  =''));
  State := count(file_in(State =''));
  Zip_Code := count(file_in(Zip_Code=''));
  SSN := count(file_in(SSN =''));
  DOB := count(file_in(DOB =''));
  Home_Phone_No := count(file_in(Home_Phone_No =''));
  Charge_off_Date := count(file_in(Charge_off_Date =''));
  Charge_off_Amount := count(file_in(Charge_off_Amount=''));
  Open_Date := count(file_in(Open_Date =''));
  Current_Balance := count(file_in(Current_Balance =''));
  Total_Amount_Paid :=	count(file_in(Total_Amount_Paid =''));
  Last_Payment_Date :=	count(file_in(Last_Payment_Date =''));
//Duplicate Records  
  Unique_SSN := count(DEDUP(SORT(file_in(SSN <>''), SSN),SSN));
  Unique_Phone:= count(DEDUP(SORT(file_in(Home_Phone_No <>''), Home_Phone_No),Home_Phone_No));
  Unique_Account_No := count(DEDUP(SORT(file_in(Account_No <>''), Account_No),Account_No));

FSR_Format := record
  Total;
  Account_No;
  Debt_Type;
  First_Name;
  Last_Name;
  Street_Address;
  City;
  State;
  Zip_Code;
  SSN;
  DOB;
  Home_Phone_No;
  Charge_off_Date;
  Charge_off_Amount;
  Open_Date;
  Current_Balance;
  Total_Amount_Paid;
  Last_Payment_Date;
  Dupicate_SSN := count(file_in(SSN <>'')) - Unique_SSN;
  Dupicate_Phone := count(file_in(Home_Phone_No <>'')) - Unique_Phone;
  Dupicate_Account_Number := count(file_in(Account_No <>'')) - Unique_Account_No;
end;

file_out := TABLE(file_in, FSR_Format,Total);

output(file_out);