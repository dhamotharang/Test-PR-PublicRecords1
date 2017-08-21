// KYSO831 / The Kentucky Real Estate Commission / Real Estate //

export layout_KYS0831 := MODULE

export real_estate := RECORD
string Firm_Branch_County_Desc;
string Firm_Name;
string Firm_Branch_Address1;
string Firm_Branch_City;
string Firm_Branch_State;
string Firm_Branch_Zip;
string Broker_Last_Name;
string Broker_First_Name;
string Broker_Middle_Name;
string Licensee_License_Number;
string Licensee_Last_Name;
string Licensee_First_Name;
string Licensee_Middle_Init;
string Licensee_Type;
string Licensee_Home_Address1;
string Licensee_Home_City;
string Licensee_Home_State;
string Licensee_Home_Zip;
END;


export escrow := RECORD
string Firm_Branch_County_Desc;
string Firm_Name;
string Licensee_License_Number;
string Licensee_Last_Name;
string Licensee_First_Name;
string Licensee_Middle_Init;
string Licensee_Type;
string Licensee_Home_Address1;
string Licensee_Home_City;
string Licensee_Home_State;
string Licensee_Home_Zip;
END;

export common := RECORD
string Firm_Branch_County_Number;
string Firm_Branch_County_Desc;
string Firm_Number_Branch_Number;
string Branch_Number;
string Firm_Name;
string Firm_Branch_Address1;
string Firm_Branch_Address2;
string Firm_Branch_City;
string Firm_Branch_State;
string Firm_Branch_Zip;
string Firm_Branch_Zip4;
string Firm_Branch_Cntry;
string Broker_Last_Name;
string Broker_First_Name;
string Broker_Middle_Name;
string Licensee_License_Number;
string Licensee_Last_Name;
string Licensee_First_Name;
string Licensee_Middle_Init;
string Licensee_Type;
string Licensee_Home_Address1;
string Licensee_Home_Address2;
string Licensee_Home_City;
string Licensee_Home_State;
string Licensee_Home_Zip;
string Licensee_Home_Zip4;
string Licensee_Home_Cntry;
string Licensee_Home_Cnty;
string Licensee_Home_County_Desc;
string Future_Use;
string Dircedel;
string Dircelaw;
string Dircenon;
string ln_filetype;
string ln_filedate;
END;

END;
