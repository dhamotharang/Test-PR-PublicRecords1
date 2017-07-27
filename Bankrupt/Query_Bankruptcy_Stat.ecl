Bankruptcy := Bankrupt.File_BK;

// Valid Filer Type Codes
Set_Filer_Types := ['I', 'J'];

// Valid Filing Type Codes
Set_Filing_Types := ['I', 'B'];

// Valid Record Type Codes
Set_Record_Types := ['1D','1F','1X','2D','2F','2X','3D','3F','3X','7D','7F','7X'];

Layout_Bankruptcy_Slim := RECORD
string2  bankruptcy_state;
integer8 Debtor_DID;
integer8 Spouse_DID;
string5           Court_Code;
string2           Record_Type;
string7           Case_Number;
string25          Debtor_Last_Name;
string15          Debtor_First_Name;
string15          Debtor_Middle_Name;
string2           Debtor_Suffix;
string55          Debtor_Company;
string25          Debtor_Aka1_Last_Name;
string15          Debtor_Aka1_First_Name;
string1           Debtor_Aka1_Middle_Initial;
string25          Debtor_Aka2_Last_Name;
string15          Debtor_Aka2_First_Name;
string1           Debtor_Aka2_Middle_Initial;
string10          Debtor_Street_Number;
string25          Debtor_Street_Name;
string10          Debtor_Street_type;
string5           Debtor_Apartment_Number;
string5           Debtor_PO_Box_Number;
string25          Debtor_City;
string2           Debtor_State;
string5           Debtor_Zip_Code;
string4           Debtor_Zip_Plus_4;
string9           Debtor_SSN;
string25          Spouse_Last_Name;
string15          Spouse_First_Name;
string15          Spouse_Middle_Name;
string2           Spouse_Suffix;
string25          Spouse_Aka1_Last_Name;
string15          Spouse_Aka1_First_Name;
string1           Spouse_Aka1_Middle_Initial;
string25          Spouse_Aka2_Last_Name;
string15          Spouse_Aka2_First_Name;
string1           Spouse_Aka2_Middle_Initial;
string10          Spouse_Street_Number;
string25          Spouse_Street_Name;
string10          Spouse_Street_type;
string5           Spouse_Apartment_Number;
string5           Spouse_PO_Box_Number;
string25          Spouse_City;
string2           Spouse_State;
string5           Spouse_Zip_Code;
string4           Spouse_Zip_Plus_4;
string9           Spouse_SSN;
string8           Date_Filed;
string3           Judges_identification;
string1           Filing_Type;
string1           Filer_Type;
string9           Liabilities_Only;
string9           Assets_Only;
string9           Exempt_Only;
string1           Asset_No_Asset_Indicator;
string1           Pro_Se;
string55          Attorney_Name;
string35          Attorney_Street_Address_1;
string35          Attorney_Street_Address_2;
string25          Attorney_City;
string2           Attorney_State;
string5           Attorney_Zip_Code;
string4           Attorney_Zip_Plus_4;
string10          Attorney_Phone_Number;
string55          Trustee_Name;
string35          Trustee_Street_Address_1;
string35          Trustee_Street_Address_2;
string25          Trustee_City;
string2           Trustee_State;
string5           Trustee_Zip_Code;
string4           Trustee_Zip_Plus_4;
string10          Trustee_Phone_Number;
string8           Meeting_Date;
string5           Meeting_Time;
string35          Meeting_Street_Address_1;
string35          Meeting_Street_Address_2;
string25          Meeting_City;
string2           Meeting_State;
string5           Meeting_Zip_Code;
string4           Meeting_Zip_Plus_4;
string8           Disposed_Date;
string8           Date_transmitted;
END;

Layout_Bankruptcy_Slim InitBankruptcy(Bankrupt.Layout_BK L) := TRANSFORM
SELF.bankruptcy_state := L.Court_Code[1..2];
SELF := L;
END;

Bankruptcy_Init := PROJECT(Bankruptcy, InitBankruptcy(LEFT));

Layout_Bankruptcy_Stat := record
Bankruptcy_Init.bankruptcy_state;

INTEGER4  Debtor_DID_Count := SUM(GROUP, IF((INTEGER)Bankruptcy_Init.Debtor_DID<>0,1,0));
INTEGER4  Spouse_DID_Count := SUM(GROUP, IF((INTEGER)Bankruptcy_Init.Spouse_DID<>0,1,0));

INTEGER4  Court_Code_Count := SUM(GROUP, IF(Bankruptcy_Init.Court_Code<>'',1,0));
INTEGER4  Court_Code_Blank := SUM(GROUP, IF(Bankruptcy_Init.Court_Code='',1,0));

// Record Type
INTEGER4  Record_Type_Count := SUM(GROUP, IF(Bankruptcy_Init.Record_Type<>'',1,0));
INTEGER4  Record_Type_1D := SUM(GROUP, IF(Bankruptcy_Init.Record_Type='1D',1,0));
INTEGER4  Record_Type_1F := SUM(GROUP, IF(Bankruptcy_Init.Record_Type='1F',1,0));
INTEGER4  Record_Type_1X := SUM(GROUP, IF(Bankruptcy_Init.Record_Type='1X',1,0));
INTEGER4  Record_Type_2D := SUM(GROUP, IF(Bankruptcy_Init.Record_Type='2D',1,0));
INTEGER4  Record_Type_2F := SUM(GROUP, IF(Bankruptcy_Init.Record_Type='2F',1,0));
INTEGER4  Record_Type_2X := SUM(GROUP, IF(Bankruptcy_Init.Record_Type='2X',1,0));
INTEGER4  Record_Type_3D := SUM(GROUP, IF(Bankruptcy_Init.Record_Type='3D',1,0));
INTEGER4  Record_Type_3F := SUM(GROUP, IF(Bankruptcy_Init.Record_Type='3F',1,0));
INTEGER4  Record_Type_3X := SUM(GROUP, IF(Bankruptcy_Init.Record_Type='3X',1,0));
INTEGER4  Record_Type_7D := SUM(GROUP, IF(Bankruptcy_Init.Record_Type='7D',1,0));
INTEGER4  Record_Type_7F := SUM(GROUP, IF(Bankruptcy_Init.Record_Type='7F',1,0));
INTEGER4  Record_Type_7X := SUM(GROUP, IF(Bankruptcy_Init.Record_Type='7X',1,0));
INTEGER4  Record_Type_Other := SUM(GROUP, IF(Bankruptcy_Init.Record_Type<>'' AND
                                               Bankruptcy_Init.Record_Type NOT IN Set_Record_Types,1,0));
INTEGER4  Record_Type_Blank := SUM(GROUP, IF(Bankruptcy_Init.Record_Type='',1,0));

INTEGER4  Case_Number_Count := SUM(GROUP, IF(Bankruptcy_Init.Case_Number<>'',1,0));
INTEGER4  Case_Number_Blank := SUM(GROUP, IF(Bankruptcy_Init.Case_Number='',1,0));

INTEGER4  Debtor_Last_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Last_Name<>'',1,0));
INTEGER4  Debtor_Last_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Last_Name='',1,0));

INTEGER4  Debtor_First_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_First_Name<>'',1,0));
INTEGER4  Debtor_First_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_First_Name='',1,0));

INTEGER4  Debtor_Middle_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Middle_Name<>'',1,0));
INTEGER4  Debtor_Middle_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Middle_Name='',1,0));

INTEGER4  Debtor_Suffix_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Suffix<>'',1,0));
INTEGER4  Debtor_Suffix_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Suffix='',1,0));

INTEGER4  Debtor_Company_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Company<>'',1,0));
INTEGER4  Debtor_Company_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Company='',1,0));

INTEGER4  Debtor_Aka1_Last_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Aka1_Last_Name<>'',1,0));
INTEGER4  Debtor_Aka1_Last_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Aka1_Last_Name='',1,0));

INTEGER4  Debtor_Aka1_First_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Aka1_First_Name<>'',1,0));
INTEGER4  Debtor_Aka1_First_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Aka1_First_Name='',1,0));

INTEGER4  Debtor_Aka1_Middle_Initial_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Aka1_Middle_Initial<>'',1,0));
INTEGER4  Debtor_Aka1_Middle_Initial_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Aka1_Middle_Initial='',1,0));

INTEGER4  Debtor_Aka2_Last_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Aka2_Last_Name<>'',1,0));
INTEGER4  Debtor_Aka2_Last_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Aka2_Last_Name='',1,0));

INTEGER4  Debtor_Aka2_First_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Aka2_First_Name<>'',1,0));
INTEGER4  Debtor_Aka2_First_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Aka2_First_Name='',1,0));

INTEGER4  Debtor_Aka2_Middle_Initial_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Aka2_Middle_Initial<>'',1,0));
INTEGER4  Debtor_Aka2_Middle_Initial_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Aka2_Middle_Initial='',1,0));

INTEGER4  Debtor_Street_Number_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Street_Number<>'',1,0));
INTEGER4  Debtor_Street_Number_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Street_Number='',1,0));

INTEGER4  Debtor_Street_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Street_Name<>'',1,0));
INTEGER4  Debtor_Street_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Street_Name='',1,0));

INTEGER4  Debtor_Street_type_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Street_type<>'',1,0));
INTEGER4  Debtor_Street_type_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Street_type='',1,0));

INTEGER4  Debtor_Apartment_Number_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Apartment_Number<>'',1,0));
INTEGER4  Debtor_Apartment_Number_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Apartment_Number='',1,0));

INTEGER4  Debtor_PO_Box_Number_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_PO_Box_Number<>'',1,0));
INTEGER4  Debtor_PO_Box_Number_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_PO_Box_Number='',1,0));

INTEGER4  Debtor_City_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_City<>'',1,0));
INTEGER4  Debtor_City_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_City='',1,0));

INTEGER4  Debtor_State_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_State<>'',1,0));
INTEGER4  Debtor_State_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_State='',1,0));

INTEGER4  Debtor_Zip_Code_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Zip_Code<>'',1,0));
INTEGER4  Debtor_Zip_Code_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Zip_Code='',1,0));

INTEGER4  Debtor_Zip_Plus_4_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Zip_Plus_4<>'',1,0));
INTEGER4  Debtor_Zip_Plus_4_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_Zip_Plus_4='',1,0));

INTEGER4  Debtor_SSN_Count := SUM(GROUP, IF(Bankruptcy_Init.Debtor_SSN<>'',1,0));
INTEGER4  Debtor_SSN_Blank := SUM(GROUP, IF(Bankruptcy_Init.Debtor_SSN='',1,0));

INTEGER4  Spouse_Last_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Last_Name<>'',1,0));
INTEGER4  Spouse_Last_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Last_Name='',1,0));

INTEGER4  Spouse_First_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_First_Name<>'',1,0));
INTEGER4  Spouse_First_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_First_Name='',1,0));

INTEGER4  Spouse_Middle_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Middle_Name<>'',1,0));
INTEGER4  Spouse_Middle_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Middle_Name='',1,0));

INTEGER4  Spouse_Suffix_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Suffix<>'',1,0));
INTEGER4  Spouse_Suffix_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Suffix='',1,0));

INTEGER4  Spouse_Aka1_Last_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Aka1_Last_Name<>'',1,0));
INTEGER4  Spouse_Aka1_Last_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Aka1_Last_Name='',1,0));

INTEGER4  Spouse_Aka1_First_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Aka1_First_Name<>'',1,0));
INTEGER4  Spouse_Aka1_First_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Aka1_First_Name='',1,0));

INTEGER4  Spouse_Aka1_Middle_Initial_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Aka1_Middle_Initial<>'',1,0));
INTEGER4  Spouse_Aka1_Middle_Initial_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Aka1_Middle_Initial='',1,0));

INTEGER4  Spouse_Aka2_Last_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Aka2_Last_Name<>'',1,0));
INTEGER4  Spouse_Aka2_Last_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Aka2_Last_Name='',1,0));

INTEGER4  Spouse_Aka2_First_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Aka2_First_Name<>'',1,0));
INTEGER4  Spouse_Aka2_First_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Aka2_First_Name='',1,0));

INTEGER4  Spouse_Aka2_Middle_Initial_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Aka2_Middle_Initial<>'',1,0));
INTEGER4  Spouse_Aka2_Middle_Initial_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Aka2_Middle_Initial='',1,0));

INTEGER4  Spouse_Street_Number_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Street_Number<>'',1,0));
INTEGER4  Spouse_Street_Number_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Street_Number='',1,0));

INTEGER4  Spouse_Street_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Street_Name<>'',1,0));
INTEGER4  Spouse_Street_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Street_Name='',1,0));

INTEGER4  Spouse_Street_type_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Street_type<>'',1,0));
INTEGER4  Spouse_Street_type_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Street_type='',1,0));

INTEGER4  Spouse_Apartment_Number_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Apartment_Number<>'',1,0));
INTEGER4  Spouse_Apartment_Number_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Apartment_Number='',1,0));

INTEGER4  Spouse_PO_Box_Number_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_PO_Box_Number<>'',1,0));
INTEGER4  Spouse_PO_Box_Number_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_PO_Box_Number='',1,0));

INTEGER4  Spouse_City_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_City<>'',1,0));
INTEGER4  Spouse_City_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_City='',1,0));

INTEGER4  Spouse_State_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_State<>'',1,0));
INTEGER4  Spouse_State_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_State='',1,0));

INTEGER4  Spouse_Zip_Code_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Zip_Code<>'',1,0));
INTEGER4  Spouse_Zip_Code_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Zip_Code='',1,0));

INTEGER4  Spouse_Zip_Plus_4_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Zip_Plus_4<>'',1,0));
INTEGER4  Spouse_Zip_Plus_4_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_Zip_Plus_4='',1,0));

INTEGER4  Spouse_SSN_Count := SUM(GROUP, IF(Bankruptcy_Init.Spouse_SSN<>'',1,0));
INTEGER4  Spouse_SSN_Blank := SUM(GROUP, IF(Bankruptcy_Init.Spouse_SSN='',1,0));

INTEGER4  Date_Filed_Count := SUM(GROUP, IF(Bankruptcy_Init.Date_Filed<>'',1,0));
INTEGER4  Date_Filed_Blank := SUM(GROUP, IF(Bankruptcy_Init.Date_Filed='',1,0));

INTEGER4  Judges_identification_Count := SUM(GROUP, IF(Bankruptcy_Init.Judges_identification<>'',1,0));
INTEGER4  Judges_identification_Blank := SUM(GROUP, IF(Bankruptcy_Init.Judges_identification='',1,0));

// Filing Type
INTEGER4  Filing_Type_Count := SUM(GROUP, IF(Bankruptcy_Init.Filing_Type<>'',1,0));
INTEGER4  Filing_Type_I:= SUM(GROUP, IF(Bankruptcy_Init.Filing_Type='I',1,0));
INTEGER4  Filing_Type_B:= SUM(GROUP, IF(Bankruptcy_Init.Filing_Type='B',1,0));
INTEGER4  Filing_Type_Other:= SUM(GROUP, IF(Bankruptcy_Init.Filing_Type<>'' AND
                                             (Bankruptcy_Init.Filing_Type NOT IN Set_Filing_Types),1,0));
INTEGER4  Filing_Type_Blank:= SUM(GROUP, IF(Bankruptcy_Init.Filing_Type='',1,0));

// Filer Type
INTEGER4  Filer_Type_Count := SUM(GROUP, IF(Bankruptcy_Init.Filer_Type<>'',1,0));
INTEGER4  Filer_Type_I := SUM(GROUP, IF(Bankruptcy_Init.Filer_Type='I',1,0));
INTEGER4  Filer_Type_J := SUM(GROUP, IF(Bankruptcy_Init.Filer_Type='J',1,0));
INTEGER4  Filer_Type_Other := SUM(GROUP, IF(Bankruptcy_Init.Filer_Type<>'' AND
                                              Bankruptcy_Init.Filer_Type NOT IN Set_Filer_Types,1,0));
INTEGER4  Filer_Type_Blank := SUM(GROUP, IF(Bankruptcy_Init.Filer_Type='',1,0));


INTEGER4  Liabilities_Only_Count := SUM(GROUP, IF(Bankruptcy_Init.Liabilities_Only<>'',1,0));
INTEGER4  Liabilities_Only_Blank := SUM(GROUP, IF(Bankruptcy_Init.Liabilities_Only='',1,0));

INTEGER4  Assets_Only_Count := SUM(GROUP, IF(Bankruptcy_Init.Assets_Only<>'',1,0));
INTEGER4  Assets_Only_Blank := SUM(GROUP, IF(Bankruptcy_Init.Assets_Only='',1,0));

INTEGER4  Exempt_Only_Count := SUM(GROUP, IF(Bankruptcy_Init.Exempt_Only<>'',1,0));
INTEGER4  Exempt_Only_Blank := SUM(GROUP, IF(Bankruptcy_Init.Exempt_Only='',1,0));

INTEGER4  Asset_No_Asset_Indicator_Count := SUM(GROUP, IF(Bankruptcy_Init.Asset_No_Asset_Indicator<>'',1,0));
INTEGER4  Asset_No_Asset_Indicator_Y := SUM(GROUP, IF(Bankruptcy_Init.Asset_No_Asset_Indicator='Y',1,0));
INTEGER4  Asset_No_Asset_Indicator_N := SUM(GROUP, IF(Bankruptcy_Init.Asset_No_Asset_Indicator='N',1,0));
INTEGER4  Asset_No_Asset_Indicator_Other := SUM(GROUP, IF(Bankruptcy_Init.Asset_No_Asset_Indicator<>'' AND
                                               Bankruptcy_Init.Asset_No_Asset_Indicator NOT IN ['Y','N'],1,0));
INTEGER4  Asset_No_Asset_Indicator_Blank := SUM(GROUP, IF(Bankruptcy_Init.Asset_No_Asset_Indicator='',1,0));

INTEGER4  Pro_Se_Count := SUM(GROUP, IF(Bankruptcy_Init.Pro_Se<>'',1,0));
INTEGER4  Pro_Se_Blank := SUM(GROUP, IF(Bankruptcy_Init.Pro_Se='',1,0));

INTEGER4  Attorney_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Attorney_Name<>'',1,0));
INTEGER4  Attorney_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Attorney_Name='',1,0));

INTEGER4  Attorney_Street_Address_1_Count := SUM(GROUP, IF(Bankruptcy_Init.Attorney_Street_Address_1<>'',1,0));
INTEGER4  Attorney_Street_Address_1_Blank := SUM(GROUP, IF(Bankruptcy_Init.Attorney_Street_Address_1='',1,0));

INTEGER4  Attorney_Street_Address_2_Count := SUM(GROUP, IF(Bankruptcy_Init.Attorney_Street_Address_2<>'',1,0));
INTEGER4  Attorney_Street_Address_2_Blank := SUM(GROUP, IF(Bankruptcy_Init.Attorney_Street_Address_2='',1,0));

INTEGER4  Attorney_City_Count := SUM(GROUP, IF(Bankruptcy_Init.Attorney_City<>'',1,0));
INTEGER4  Attorney_City_Blank := SUM(GROUP, IF(Bankruptcy_Init.Attorney_City='',1,0));

INTEGER4  Attorney_State_Count := SUM(GROUP, IF(Bankruptcy_Init.Attorney_State<>'',1,0));
INTEGER4  Attorney_State_Blank := SUM(GROUP, IF(Bankruptcy_Init.Attorney_State='',1,0));

INTEGER4  Attorney_Zip_Code_Count := SUM(GROUP, IF(Bankruptcy_Init.Attorney_Zip_Code<>'',1,0));
INTEGER4  Attorney_Zip_Code_Blank := SUM(GROUP, IF(Bankruptcy_Init.Attorney_Zip_Code='',1,0));

INTEGER4  Attorney_Zip_Plus_4_Count := SUM(GROUP, IF(Bankruptcy_Init.Attorney_Zip_Plus_4<>'',1,0));
INTEGER4  Attorney_Zip_Plus_4_Blank := SUM(GROUP, IF(Bankruptcy_Init.Attorney_Zip_Plus_4='',1,0));

INTEGER4  Attorney_Phone_Number_Count := SUM(GROUP, IF(Bankruptcy_Init.Attorney_Phone_Number<>'',1,0));
INTEGER4  Attorney_Phone_Number_Blank := SUM(GROUP, IF(Bankruptcy_Init.Attorney_Phone_Number='',1,0));

INTEGER4  Trustee_Name_Count := SUM(GROUP, IF(Bankruptcy_Init.Trustee_Name<>'',1,0));
INTEGER4  Trustee_Name_Blank := SUM(GROUP, IF(Bankruptcy_Init.Trustee_Name='',1,0));

INTEGER4  Trustee_Street_Address_1_Count := SUM(GROUP, IF(Bankruptcy_Init.Trustee_Street_Address_1<>'',1,0));
INTEGER4  Trustee_Street_Address_1_Blank := SUM(GROUP, IF(Bankruptcy_Init.Trustee_Street_Address_1='',1,0));

INTEGER4  Trustee_Street_Address_2_Count := SUM(GROUP, IF(Bankruptcy_Init.Trustee_Street_Address_2<>'',1,0));
INTEGER4  Trustee_Street_Address_2_Blank := SUM(GROUP, IF(Bankruptcy_Init.Trustee_Street_Address_2='',1,0));

INTEGER4  Trustee_City_Count := SUM(GROUP, IF(Bankruptcy_Init.Trustee_City<>'',1,0));
INTEGER4  Trustee_City_Blank := SUM(GROUP, IF(Bankruptcy_Init.Trustee_City='',1,0));

INTEGER4  Trustee_State_Count := SUM(GROUP, IF(Bankruptcy_Init.Trustee_State<>'',1,0));
INTEGER4  Trustee_State_Blank := SUM(GROUP, IF(Bankruptcy_Init.Trustee_State='',1,0));

INTEGER4  Trustee_Zip_Code_Count := SUM(GROUP, IF(Bankruptcy_Init.Trustee_Zip_Code<>'',1,0));
INTEGER4  Trustee_Zip_Code_Blank := SUM(GROUP, IF(Bankruptcy_Init.Trustee_Zip_Code='',1,0));

INTEGER4  Trustee_Zip_Plus_4_Count := SUM(GROUP, IF(Bankruptcy_Init.Trustee_Zip_Plus_4<>'',1,0));
INTEGER4  Trustee_Zip_Plus_4_Blank := SUM(GROUP, IF(Bankruptcy_Init.Trustee_Zip_Plus_4='',1,0));

INTEGER4  Trustee_Phone_Number_Count := SUM(GROUP, IF(Bankruptcy_Init.Trustee_Phone_Number<>'',1,0));
INTEGER4  Trustee_Phone_Number_Blank := SUM(GROUP, IF(Bankruptcy_Init.Trustee_Phone_Number='',1,0));

INTEGER4  Meeting_Date_Count := SUM(GROUP, IF(Bankruptcy_Init.Meeting_Date<>'',1,0));
INTEGER4  Meeting_Date_Blank := SUM(GROUP, IF(Bankruptcy_Init.Meeting_Date='',1,0));

INTEGER4  Meeting_Time_Count := SUM(GROUP, IF(Bankruptcy_Init.Meeting_Time<>'',1,0));
INTEGER4  Meeting_Time_Blank := SUM(GROUP, IF(Bankruptcy_Init.Meeting_Time='',1,0));

INTEGER4  Meeting_Street_Address_1_Count := SUM(GROUP, IF(Bankruptcy_Init.Meeting_Street_Address_1<>'',1,0));
INTEGER4  Meeting_Street_Address_1_Blank := SUM(GROUP, IF(Bankruptcy_Init.Meeting_Street_Address_1='',1,0));

INTEGER4  Meeting_Street_Address_2_Count := SUM(GROUP, IF(Bankruptcy_Init.Meeting_Street_Address_2<>'',1,0));
INTEGER4  Meeting_Street_Address_2_Blank := SUM(GROUP, IF(Bankruptcy_Init.Meeting_Street_Address_2='',1,0));

INTEGER4  Meeting_City_Count := SUM(GROUP, IF(Bankruptcy_Init.Meeting_City<>'',1,0));
INTEGER4  Meeting_City_Blank := SUM(GROUP, IF(Bankruptcy_Init.Meeting_City='',1,0));

INTEGER4  Meeting_State_Count := SUM(GROUP, IF(Bankruptcy_Init.Meeting_State<>'',1,0));
INTEGER4  Meeting_State_Blank := SUM(GROUP, IF(Bankruptcy_Init.Meeting_State='',1,0));

INTEGER4  Meeting_Zip_Code_Count := SUM(GROUP, IF(Bankruptcy_Init.Meeting_Zip_Code<>'',1,0));
INTEGER4  Meeting_Zip_Code_Blank := SUM(GROUP, IF(Bankruptcy_Init.Meeting_Zip_Code='',1,0));

INTEGER4  Meeting_Zip_Plus_4_Count := SUM(GROUP, IF(Bankruptcy_Init.Meeting_Zip_Plus_4<>'',1,0));
INTEGER4  Meeting_Zip_Plus_4_Blank := SUM(GROUP, IF(Bankruptcy_Init.Meeting_Zip_Plus_4='',1,0));

INTEGER4  Disposed_Date_Count := SUM(GROUP, IF(Bankruptcy_Init.Disposed_Date<>'',1,0));
INTEGER4  Disposed_Date_Blank := SUM(GROUP, IF(Bankruptcy_Init.Disposed_Date='',1,0));

INTEGER4  Date_transmitted_Count := SUM(GROUP, IF(Bankruptcy_Init.Date_transmitted<>'',1,0));
INTEGER4  Date_transmitted_Blank := SUM(GROUP, IF(Bankruptcy_Init.Date_transmitted='',1,0));

INTEGER4  Total:= COUNT(GROUP);
END;

Bankruptcy_Stat := TABLE(Bankruptcy_Init, Layout_Bankruptcy_Stat, bankruptcy_state, FEW);

OUTPUT(Bankruptcy_Stat);