export Layout_ClickData_Out := record
	String30 AcctNo;
	unsigned4 record_id;
	string1   source;
	string12	ADL;
	string12  HHID;
	string3	Best_Address_Score;
	string100	Best_Addr1;
	string25	Best_City;
	string2	Best_State;
	string10	Best_Zip;
	string3	Best_Name_score;
	string5		Best_Title;
	string20	Best_Fname;
	string20	Best_Mname;
	string20	Best_Lname;
	string5	Best_Suffix;
	string3	Best_Phone_score;
	string10	Best_Phone;
	string8	Best_DOB;
	string6	Best_Addr_Date;
	string6 Best_Addr_Date_first_seen;
	string4	Num_Header_Recs;
	string8	EDA_Connect;
	string8	EDA_Disconnect;
	string3 score;
	string3	score_any_ssn;
  string3	score_any_addr;
  string3	score_any_dob;
	string3 score_any_phn;
  string3	score_any_fzzy;	
end;

