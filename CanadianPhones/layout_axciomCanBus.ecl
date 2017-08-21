export layout_axciomCanBus := module

export v1 := record
string Record_ID;
string Phone_Number;
string Province;
string Business_Name;
string Street_Number;
string Street_Directional;
string Street_Name;
string City;
string Postal_Code;
string Pub_Date;
string Filler;
string YPHC_1;
string YPHC_2;
string YPHC_3;
string YPHC_4;
string YPHC_5;
string YPHC_6;
string SIC_1;
string SIC_2;
string SIC_3;
string SIC_4;
string Bus_Govt_Indicator;
string Latitude;
string Longitude;
string Lat_Long_Level_Applied;
string Filler1;
string Record_Use_Indicator;
string Filler2;
end;

export v2 := record
string Record_ID;
string Book_Number;
string Pub_Date;
string Business_Name;
string Street_Number;
//string Street_Directional;
string Street_Name;
string Unit_Designator;
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
string Unit_Number;
string City;
string Province;
string Postal_Code;
string Area_Code;
string Phone_Number;
string filler;
string SYPH_1;
string SYPH_2;
string SYPH_3;
string SYPH_4;
string SYPH_5;
string SYPH_6;
string NAICS_1;
string NAICS_2;
string NAICS_3;
string NAICS_4;
string NAICS_5;
string NAICS_6;
string BDC_1;
string BDC_2;
string BDC_3;
string BDC_4;
string BDC_5;
string BDC_6;
string SIC_1;
string SIC_2;
string SIC_3;
string SIC_4;
string SIC_5;
string SIC_6;
string Caption_Counter;
string Caption_1;
string Caption_2;
string Caption_3;
string Caption_4;
string Caption_5;
string Caption_6;
string Vanity_City;
string Bus_Govt_Indicator;
// _____1_=_Business
// _____5_=_Professional
// _____6_=_Unkown
// _____A_=_Generic
// _____B_=_Federal
// _____C_=_Provincial
// _____D_=_County
// _____E_=_Local
// _____F_=_Schools
// _____G_=_Tribal
// _____H_=_Military
// _____I_=_Community_Service
string Latitude;
string Longitude;
string Lat_Long_Level_Applied;
// _____C_=_applied_from_Statistics_Canada_table_in-house
// _____0_=_No_Errors
// _____1_=_By_Address
// _____2_=_By_Intersection
// _____3_=_By_Point_of_Interest
// _____4_=_By_Postal_Code_
// _____5_=_By_Muni_Center
// _____6_=_By_FSA_Center
// _____7_=_By_Populated_Place_Name
// _____8_=_By_Closet_Address
// _____9_=_By_Address_Segment_Centroid
string Record_Use_Indicator;
// _____B_=_Mailable_and_Telemarketable
// _____C_=_No_Contact
// _____M_=_No_Mail
// _____T_=_Telemarketing_Only
string Email;
string STATED_ADDR;
string STATED_CITY;
string STATED_POSTAL_CODE;
string STATED_BUS_NAME;
string Verification_Flag;
//M_=_merchant_submitted_through_MBLM
//B_=_Bulk_Contributor
//C_=_Compiled_Unique
end;
end;









