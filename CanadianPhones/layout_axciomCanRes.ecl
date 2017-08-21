export layout_axciomCanRes := module

export v1 := record

string Record_ID;
string Phone_Number;
string Province;
string Book_Number;
string Postal_Code;
string Filler1;
string First_Name;
string Middle_Initial;
string Last_Name;
string Generational_Suffix;
string Secondary_Name;
string Filler2;
string Street_Number;
string Street_Directional;
string Street_Name;
string Room_Number;
string Room_Code;
string City;
string Pub_Date;
string Filler3;
string Vanity_City_Name;
string Status_Indicator;
string Latitude;
string Longitude;
string Lat_Long_Level_Applied;
string Record_Type;
string Record_Use_Indicator;
end;

export v2 := record
string Record_ID;
string Book_Number;
string Pub_Date;
string Section_Number;
string Page_Number;
string Status_Code;
string Load_Date;
string Section_Type;
string First_Name;
string Middle_Initial;
string Last_Name;
string Generational_Suffix;
string Primary_Prefix_Title_code;
string Primary_Professional_Suffix_code;
string Street_Number;
//string Street_Directional;
string Street_Name;
string Unit_Number;
string Unit_designator;
// _____Apt_=_Apartment					
// _____Ste_=_Suite					
// _____Lot_=_Lot					
// _____Lwr_=_Lower					
// _____Rm_=_Room					
// _____Flr_=_Floor					
// _____Frnt_=_Front					
// _____Rear_=_Rear					
// _____Brks_=_Barracks					
// _____Bsmt_=_Basement					
// _____Bldg_=_Building					
// _____Ph_=_Penthouse					
// _____Unit_=_Unit					
// _____Upr_=_Upper					
string City;
string Province;
string Postal_Code;
string Area_Code;
string Phone_Number;
string filler;
string Vanity_City_Name;
string Latitude;
string Longitude;
string Lat_Long_Level_Applied;
// _____C_=_By_City					
// _____0_=_No_Errors					
// _____1_=_By_Address					
// _____2_=_By_Intersection					
// _____3_=_By_Point_of_Interest					
// _____4_=_By_Postal_Code					
// _____5_=_By_Muni_Center				
// _____6_=_By_FSA_Center					
// _____7_=_By_Populated_Place_Name					
// _____8_=_By_Closest_Address					
// _____9_=_By_Address_Segment_Centroid					
string Record_Use_Indicator;
// _____B_=_Mailable					
// _____C_=_No_Contact					
// _____M_=_No_Mail					
// _____T_=_Telemarketing_only/No_Address					
string Email;
string Stated_Address;
string Stated_City;
string Stated_Postal_Code;
string filler1;
string filler2;
/*
string EstAge;
// _____A_=_20_-_24				
// _____B_=_25_-_29					
// _____C_=_30_-_34					
// _____D_=_35_-_39					
// _____E_=_40_-_44					
// _____F_=_45_-_49					
// _____G_=_50_-_54					
// _____H_=_55_-_59					
// _____I_=_60_-_64					
// _____J_=_65_-_69					
// _____K_=_70+					
// _____U_=_Unknown					
string EstIncome;
// A=Less_Than_$15,000					
// B=$15,000-19,999					
// C=$20,000-29,999					
// D=$30,000-39,999					
// E=$40,000-49,999					
// F=$50,000-74,999					
// G=$75,000-99,999					
// H=$100,000-124,999					
// I=$125,000+					
// U=Unknown					
string EstHomeValue;
// A=Under_100K					
// B=100K-199K					
// C=200K-299K					
// D=300K-399K					
// E=400K-499K					
// F=500K-599K					
// G=600K-699K					
// H=700K-799K					
// I=800K-899K					
// J=900K-999K					
// K=1M+					
string PresOfChildren;
//Y=Yes					
string HomeOwnerFlag;
// O=Home_Owner					
// R=Renter					
// U=Unknown					
string MaritalStatus;
//Y=Yes					
string Ethnicity;
// A=Arabic					
// B=Chinese					
// C=Hindu					
// D=Hispanic					
// E=Japanese					
// F=Korean					
// G=Russian					
// H=Vietnamese					
string Gender;
// F=Female					
// M=Male					
// U=Unknown					
string Education4Yrs;
// N_=_No					
// Y_=_Yes					
// Blank_=_unknown					
string Religion;
string DwellingCode;
// M=MFDU					
// O=MFDU_with_missing_unit#					
// P=PO_Box					
// R=Rural_Route					
// S=SFDU					
// U=Unknown					
string Verification_Flag;
// C_=_Compiled_Unique					
// U_=_Third_Party_Unique					
*/
end;
end;


