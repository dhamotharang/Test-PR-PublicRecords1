export Layout_OR_Statewide := module

export payload := record
string unparsed_rec;
end;

export adrfil := record //address file
string4 Law_Agency;
string8 Law_Number;
string30 Description;
string4 OUCR_Code;
string1 Penalty_Class;
string3 Penalty_Code;
string4 Law_Code;
string4 Financial_Agency;
string1 Law_Type;
string7 Record_Change_Date;
string5 Record_Change_Time;
string10 User_Id;
string7 Date_Effective;
string9 Use_Count;
string3 Court_Location;
end;

export amtfil := record //amounts for sentences and judgements
string1 Court_Type;
string3 Court_Location;
string10 Case_Number;
string3 Record_Type;
string5 Amount_Id;
string3 Related_Record_Type;
string5 Related_Record_Id;
string4 Amount_Type;
string4 Amount_Modifier;
string1 Amount_Unit;
string11 Dollars;
string9 Non_Dollars;
string5 Related_Jgm_Amount_Id;
string9 Related_Receivable_Number;
string3 Related_Receivable_Sequence;
string1 Judgment_Flag;
string7 Record_Changed_Date;
string5 Record_Changed_Time;
string10 User_Id;
string10 Command_Name;
end;

export atyfil := record //attorney file
string4 Agency;
string3 Person_Type_Code;
string6 Bar_BPST_Number;
string30 Name;
string30 Business_Name;
string38 Address_Line_1;
string38 Address_Line_2;
string16 City;
string2 State;
string10 Zip_Code;
string3 Phone_Area_Code;
string7 Phone_Number;
string3 Fax_Area_Code;
string7 Fax_Phone_Number;
string7 Date_Admitted_to_Bar;
string4 Attorney_Bar_Status;
string7 Bar_Status_Date;
string9 Social_Security_Number;
string3 Judge_Initals;
string4 Court_Box_Number;
string7 Record_Changed_Date;
string5 Record_Changed_Time;
string10 User_Id;
string10 Command_Name;
string7 Display_Only_Date;
string1 Display_Only_Flag;
string9 Use_Count;
end;

export casfil := record //case file
string1 Court_Type;
string3 Court_Location;
string10 Case_Number;
string3 Record_Type;
string3 Related_Party_Side;
string5 Related_Party_Id;
string2 Case_Class;
string2 Case_Type;
string4 Case_Status;
string10 Master_Case_Number;
string3 Master_Case_Type;
string7 Date_Case_Filed;
string7 Date_Case_Started;
string7 Initial_Entry_Date;
string2 Case_Origin;
string4 Starting_Instrument;
string10 District_Attorney_Number;
string4 Previous_Court;
string10 Previous_Case_Number;
string4 Previous_Decision;
string4 Termination_Stage;
string4 Termination_Type;
string1 Inre_Case;
string1 Exrel_Case;
string11 Amount_Prayed_For;
string7 Record_Changed_Date;
string5 Record_Changed_Time;
string1 Security_Control_Code_1;
string1 Security_Control_Code_2;
string1 Security_Control_Code_3;
string1 Security_Control_Code_4;
string1 Security_Control_Code_5;
string1 Security_Control_Code_6;
string1 Security_Control_Code_7;
string1 Security_Control_Code_8;
string1 Security_Control_Code_9;
string1 Security_Control_Code_10;
string1 SecurityAuthorization_Required;
string10 User_Id;
string10 Command_Name;
end;

export cmtfil := record //comments file
string1 Court_Type;
string3 Court_Location;
string10 Case_Number;
string3 Related_Record_Type;
string9 Related_Record_Id;
string7 Record_Changed_Date;
string5 Record_Changed_Time;
string10 User_Id;
string10 Command_Name;
string50 Comment_Line;
end;

export crgfil := record //charges file
string1 Court_Type;
string3 Court_Location;
string10 Case_Number;
string3 Record_Type;
string5 Charge_Id;
string5 Previous_Charge_Id;
string5 Charge_Count;
string7 Incident_Date;
string7 Citation_Issue_Date;
string4 Law_Agency;
string8 Law_Number;
string4 Law_Code;
string4 Charge_Modifier_Agency;
string8 Charge_Modifier_Number;
string10 Citation_Number;
string4 Original_Agency;
string10 Original_Agency_Report_No;
string6 BPST_Number;
string2 License_Plate_State;
string8 License_Plate_Number;
string1 Accident_Related;
string1 Employment_Related;
string4 Charge_Status;
string7 Charge_Status_Date;
string7 Record_Changed_Date;
string5 Record_Changed_Time;
string10 User_Id;
string10 Command_Name;
end;

export evtfil := record //events file
string1 Court_Type;
string3 Court_Location;
string10 Case_Number;
string3 Record_Type;
string4 Event_Type;
string5 Event_Id_Number;
string4 Event_Code;
string7 Date_Event_Entered;
string7 Date_Event_Filed;
string7 Date_Event_Scheduled;
string5 Time_Event_Scheduled;
string4 Calendar_Sequence;
string4 Scheduled_Event_Room;
string5 Estimated_Trial_Length;
string1 Estimated_Length_Units;
string4 Event_Status;
string7 Event_Status_Date;
string4 Court_Action;
string7 Court_Action_Date;
string1 Print_Calendar;
string1 Print_Notice;
string3 Event_Control_Code;
string4 Case_Status;
string7 Petition_Control_Number;
string7 Record_Changed_Date;
string5 Record_Changed_Time;
string10 User_Id;
string10 Command_Name;
end;

export finfil := record //financial transactions file
string1 Court_Type;
string3 Court_Location;
string10 Case_Number;
string4 General_Ledger_Id;
string3 Transaction_Type;
string9 Transaction_Number;
string7 Transaction_Date;
string3 Adjusted_Transaction_Type;
string9 Adjusted_Transaction_Number;
string3 Initials;
string10 Workstation_Id;
string7 Entry_Date;
string5 Entry_Time;
string1 Add_Void_Status;
string1 Display_Code;
string4 Payment_Form;
string7 Alternate_Receipt_Number;
string7 Disbursement_Date;
string7 Original_Payment_Date;
string1 Associated_Court_Type;
string3 Associated_Court_Location;
string10 Associated_Case_Number;
string7 Receivable_Due_Date;
string1 Partial_Payment_Priority;
string1 Time_Payment_Schedule_Status;
string1 Joint_Several_Status;
string4 Adjustment_Code;
string7 Record_Changed_Date;
string5 Record_Changed_Time;
string10 User_Id;
string10 Command_Name;
end;

export fnafil := record //financial transactions amounts
string1 Court_Type;
string3 Court_Location;
string10 Case_Number;
string4 General_Ledger_Id;
string3 Transaction_Type;
string9 Transaction_Number;
string7 Transaction_Date;
string3 Orig_Transaction_Type;
string4 Transaction_Code;
string1 Transaction_Code_Type;
string4 Agency;
string1 Process_Code;
string1 Accounts_Receivable_Code;
string1 Add_Void_Status;
string9 Financial_Amount;
string9 Financial_Amount_Offset;
string1 Disbursement_Control;
string7 Check_Number;
string3 Financial_Amount_Number;
string7 Receivable_Sequence_Number;
string1 Journal_Posting_Status;
string7 Record_Entered_Date;
string5 Record_Entered_Time;
string7 Record_Changed_Date;
string5 Record_Changed_Time;
string10 User_Id;
string10 Command_Name;
end;

export mnyfil := record // many relationships file
string1 Court_Type;
string3 Court_Location;
string10 Case_Number;
string3 Master_Record_Type;
string9 Master_Record_Id;
string3 Related_Record_Type;
string9 Related_Record_Id;
string3 _Relationship;
string4 Decision_Status;
string7 Record_Changed_Date;
string5 Record_Changed_Time;
string10 User_Id;
string10 Command_Name;
end;

export pidfil := record //party ID file
string1 Court_Type;
string3 Court_Location;
string10 Case_Number;
string3 Party_Side;
string5 Party_Id;
string1 Sex;
string3 Height;
string3 Weight;
string3 Hair;
string3 Eyes;
string3 Race;
//string9 SSN;
string10 Drivers_License_Number;
string2 Drivers_License_State;
string7 Arrest_Date;
//string10 Booking_Number;
//string10 SID;
//string10 Control_Number;
//string10 DHRCSNBR;
//string10 FBI;
string2 crlf;
end;


export ptyfil := record //party file
string1 Court_Type;
string3 Court_Location;
string10 Case_Number;
string3 Party_Side;
string5 Party_Id;
string30 Name;
string1 Business_Name_Flag;
string7 Date_of_Birth;
string3 Party_Role;
string1 Name_Flag;
string1 Judgment_Flag;
string4 Custody_Status;
string7 Custody_Date;
string3 Related_Party_Side;
string5 Related_Party_Id;
string4 Agency;
string6 Bar_BPST_Number;
string3 Initials;
string4 Person_Status_on_Case;
string7 Record_Changed_Date;
string5 Record_Changed_Time;
string10 User_Id;
string10 Command_Name;
string2 Case_Class;
string2 Case_Type;
string1 Return_Address_Flag;
string1 Trust_Flag;
string1 Receivable_Flag;
string6 Vendor_Number;
string7 Account_Number;
string4 General_Ledger_Id;
end;

export sntfil := record //sentence file
string1 Court_Type;
string3 Court_Location;
string10 Case_Number;
string3 Record_Type;
string5 Charge_Id;
string5 Sentence_Id;
string4 Decision_Type;
string7 Decision_Date;
string1 Financial_System_Flag;
string7 Due_Date;
string4 Decision_Status;
string7 Decision_Status_Date;
string7 Record_Changed_Date;
string5 Record_Changed_Time;
string10 User_Id;
string10 Command_Name;
end;

export smtfil := record //summary of financial transactions
string1 Court_Type;
string3 Court_Location;
string10 Case_Number;
string4 Transaction_Code;
string1 Summary_Sequence;
string20 Financial_Description;
string11 Summary_Amount_1;
string11 Summary_Amount_2;
string11 Summary_Amount_3;
string11 Inactive_Money_4;
string11 Override_Money_5;
string1 Summary_Flag;
end;

export jgmfil := record //judgement file
string1 Court_Type;
string3 Court_Location;
string10 Case_Number;
string3 Record_Type;
string5 Charge_Id;
string5 Judgment_Id;
string4 Decision_Type;
string7 Decision_Date;
string7 Date_Sentence_Judgment_Entered;
string5 Decision_Entered_Time;
string4 Decision_Status;
string7 Decision_Status_Date;
string4 Volume;
string4 Decision_Page_Number;
string5 Sentence_Id;
string1 Financial_System;
string7 Record_Changed_Date;
string5 Record_Changed_Time;
string10 User_Id;
string10 Command_Name;
end;

export lawfil := record //law file
string4 Law_Agency;
string8 Law_Number;
string30 Description;
string4 OUCR_Code;
string1 Penalty_Class;
string3 Penalty_Code;
string4 Law_Code;
string4 Financial_Agency;
string1 Law_Type;
string7 Record_Change_Date;
string5 Record_Change_Time;
string10 User_Id;
string7 Date_Effective;
string9 Use_Count;
string3 Court_Location;
end;

export tblfil := record //code table file
string4 Table_Type;
string4 Table_Key;
string25 Abbreviated_Description;
string50 Full_Description;
string3 Record_Type;
string3 Event_Control_Code;
string1 Security_Authorization_Required;
string9 Usage_Count;
string7 Record_Changed_Date;
string10 User_Id;
string7 Display_Only_Date;
string1 Display_Only_Flag;
string10 Alternate_Key;
string1 Flag_1;
string1 Flag_2;
string1 Flag_3;
string1 Flag_4;
string1 Flag_5;
string1 Flag_6;
string1 Flag_7;
string1 Flag_8;
string1 Flag_9;
string1 Flag_10;
end;

end;





