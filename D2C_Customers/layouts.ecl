EXPORT layouts := module

    EXPORT rConsumers := record  //consumers file
        unsigned1 Record_Type := 1;
        unsigned6 LexID;
        string60  Best_Name;
        string200 Best_Address;
        unsigned4 Best_DOB;
        unsigned1 Derived_Age;
        unsigned4 Date_of_Death;
        string1   Report_Candidate;
    END;
    
    EXPORT rAddressHist := record
        unsigned1 Record_Type := 2;
        unsigned6 LexID;
        string200 Address;
        unsigned4 Date_First_Seen;
        unsigned4 Date_Last_Seen;
    END;
    
    EXPORT rAkas := record
        unsigned1 Record_Type := 3;
        unsigned6 LexID;
        string5   Title;
        string60  Name;
    END;
    
    EXPORT lRelativesSlim := record
        unsigned6 LexID1;
        unsigned6 LexID2;
        boolean   isanylnamematch;
    END;

    EXPORT rRelatives := record
        unsigned1 Record_Type := 4;
        unsigned1 Type;
        lRelativesSlim;
        string1   Association := 'A';
    END;
    
    EXPORT rBankruptcy := record
        unsigned1 Record_Type := 5;
        unsigned6 LexID;
        string200 Debtor_Name;
        string160 Filing_Address;
        unsigned4 Date_Filed;
        string40  Court_Location;
        string12  Filing_Status;
        string3   Chapter;
        unsigned4 Disposition_Date;
        string35  Disposition_Status;
        string50  Trustee_Name;
        string90  Trustee_Address;
    END;
    
    EXPORT rCWP := record  //concealed_weapon_permits
        unsigned1 Record_Type := 6;
        unsigned6 LexID;
        string90  Name;
        string200 Address;
        string2   Permit_State;
        string46  Permit_Type;
        string1   Gender;
        string2   Ethnicity;  //race
        unsigned4 Registration_Date;
        unsigned4 Expiration_Date;
    END;
    
    EXPORT rCrims := record
        unsigned1 Record_Type := 7;
        unsigned6 LexID;
        string60  Name;
        string200 Address;
        string30  County_Of_Origin;
        string25  Offense_State;
        string45  Source;
        string35  Case_Number;
        string10  Doc_Number;
        string9   Fbi_Number;
        string50  Arresting_Agency;
        string75  Arrest_Type;
        string40  Court_Description;
        string125 Court_Offense;
        string30  Court_Plea;
        string80  Court_Disposition;
        string5   Court_Level; //Court Level/Degree
        unsigned4 Court_Disposition_Date;
        unsigned4 Court_Filing_Date;
    END;

    EXPORT rCivil := record
        unsigned1 Record_Type := 8;
        // unsigned6 LexID; not available
        string60  Name;
        string200 Address;
        string2   state_origin;
        string35  case_number;
        string60  case_type;
        string10  case_type_code;
        string30  entity_type_description_1_orig;
        string1   entity_nm_format_1;
        string60  court;
        string10  court_code;
        unsigned4 Court_Disposition_Date;
        unsigned4 Court_Filing_Date;
    END;
    
    EXPORT rEmails := record
        unsigned1 Record_Type := 9;
        unsigned6 LexID;
        string100 Email_Address;
    END;
    
    EXPORT rAircraft := record
        unsigned1 Record_Type := 10;
        unsigned6 LexID;
        string60  Name;
        string200 Address;
        string30  Serial_Number;
        string8   Aircraft_Number;
        string1   Record_Status;// (Active/Historical/Unknown)
        string150 Description;
        unsigned4 Last_Action_Date;
        string30  Manufacturer_Name;
        string13  Type_of_Aircraft;
        string20  Model;
    END;
    
    EXPORT rAirmen := record
        unsigned1 Record_Type := 11;
        unsigned6 LexID;
        string60  Name;
        string10  Record_Status;// (Active/Historical/Unknown)
        string200 Address;
        string20  Class;
        unsigned4 Expiration_Date; 
        string2   Region;
        string99  Ratings;
    END;
    
    EXPORT rHunting := record //hunting_fishing_permits
        unsigned1 Record_Type := 12;
        unsigned6 LexID;
        string    Name;
        string    Address;
        string    Gender;
        unsigned4 License_Date;
        string    License_Type;
        string    Home_State;
        string    License_State;
    END;
    
    EXPORT rLiens := record  //Liens & Judgments
        unsigned1 Record_Type := 13;
        unsigned6 LexID;
        string    Name;
        string    Address;
        unsigned4 Original_Filing_Date;
        string    Creditors;
        string    Eviction;
        string    Filing_Number;
        string    Filing_Location;
        string    Filing_Type;
        string    Amount;
        string    Book_Page;
        unsigned4 Release_Date;
    END;
    
    EXPORT rUCC := record
        unsigned1 Record_Type := 14;
        unsigned6 LexID;
        string    Debtor;
        string    Address;
        string    Secured_Name;
        string    Secured_Address;
        string    Filing_Type;
        unsigned4 Original_Filing_Date;
        string    Original_Filing_Number;
        string    Filing_Jurisdiction;
        string    Filing_Agency;
        string    Filing_Agency_Address;
        string    Filing_Status;
        unsigned4 Expiration_Date;
    END;

    EXPORT rPeople_At_Work := record
        unsigned1 Record_Type := 15;
        unsigned6 LexID;
        string    Company;
        string    Address;
        string    Phone;
        string    Title;
        unsigned4 Date_First_Seen;
        unsigned4 Date_Last_Seen;
    END;
    
    EXPORT rPhones := record
        unsigned1 Record_Type := 16;
        unsigned6 LexID;
        string    Name;
        string    Address;
        string    Phone;
        string    Phone_Type;
        string    Phone_Product;// (Directory Assistance or PhonesPlus)
    END;
    
    EXPORT rProfessional_Licenses := record
        unsigned1 Record_Type := 17;
        unsigned6 LexID;
        string20  License_Number;
        string2   License_State;
        string60  License_Type;
        string60  Profession_Board;
        unsigned4 Issue_Date;
        unsigned4 Expiration_Date;
        string45  License_Status;
    END;
    
    EXPORT rSex_Offenders := record
        unsigned1 Record_Type := 18;
        unsigned6 LexID;
        string60  Name;
        string900 akas := '';
        string200 Address;
        string3   Height;
        string3   Weight;
        string30  Race;
        string900 Offense;
        string50  Offender_Status;
        unsigned4 Date_Last_Reported;
        string200 Scars;//Marks/tattoos
        unsigned4 Adjudication_Date; //Conviction Date
        string30  DOC_Number;
        string30  FBI_Number;
        string30  NCIC_Number;
        string30  Sex_Offender_Registry_ID;
    END;
    
    EXPORT rVoter_Registration := record
        unsigned1 Record_Type := 19;
        unsigned6 LexID;
        string    Name;
        string    Resident_Address;
        string    Gender;
        string    Ethnicity;
        unsigned4 Last_Vote_Date;
        unsigned4 Registration_Date;
        string    State_of_registration;
        string    Status;
    END;
    
    EXPORT rDeeds_Mortgages := record
        unsigned1 Record_Type := 20;
        unsigned6 LexID;
        string2   State;
        string18  County;
        string45  APN;
        string200 Property_Address;
        string200 Owner_Address;
        string60  Owner_Name;
        string60  Seller_Name;
        string20  Document_Number;
        string3   Document_Type;
        string10  Recorder_Book;
        string10  Recorder_Page;
        unsigned4 Recording_Date;
        unsigned4 Sale_Date;
        string11  Sale_Price;
        string11  Loan_Amount;
        string5   Loan_Type;
        string5   Interest_Rate;
        string5   Term;
        unsigned4 Due_Date;
        string60  Lender;
        string1   Lender_Type;
        string1   Rate_Change;
        string60  Title_Company;
        string4   Type_Financing;
        string15  Adjustable_Index;
        string4   Change_Index;
        string3   Property_Use;
        string4   Land_Use;
        string10  Lot_Size;
        string100 Legal_Description;
    END;
    
    EXPORT rTax_Assessments := record
        unsigned1 Record_Type := 21;
        unsigned6 LexID;
        string2   State;
        string30  County;
        string45  APN;
        string200 Property_Address;
        string200 Owner_Address;
        string80  Owner_Name;
        string4   Tax_Year;
        string13  Tax_Amount;
        string11  Total_Assessed_Value;
        string11  Assessed_Improvement_Value;
        string11  Assessed_Land_Value;
        string4   Assessment_Year;
        string11  Total_Market_Value;
        string11  Market_Improvement_Value;
        string11  Market_Land_Value;
        string4   Market_Value_Year;
        string20  Document_Number;
        string25  Document_Type;
        string10  Recorder_Book;
        string10  Recorder_Page;
        unsigned4 Recording_Date;
        unsigned4 Sale_Date;
        string11  Sale_Price;        
        string1   Exemption;
        string1   Land_Use;
        string40  Subdivision_Name;
        unsigned2 Year_Built;        
        string5   Stories;
        string5   Bedrooms;
        string5   Baths;
        string5   Total_Rooms;
        string1   Fireplace_Indicator;
        string3   Garage_Type;
        string5   Garage_Size;
        string3   Pool_Spa;
        string5   Style;
        string3   Air_Conditioning;
        string3   Heating;
        string3   Construction;
        string3   Basement;
        string3   Exterior_Walls;
        string3   Foundation;
        string5   Roof;
        string1   Elevator;
        string20  Property_Lot_Size;
        string9   Building_Area;
        string250 Legal_Description;
    END;

    EXPORT rStudent := RECORD
      unsigned1 record_type:=22;
      unsigned6 LexID;
      string2   CLASS;
      string50  COLLEGE_NAME;
      string18  COLLEGE_MAJOR;
    END;

    EXPORT rForeclosure := RECORD
        unsigned1 record_type:=23;
        unsigned6 LexID;
        string    Owner;
        string    Lender;
        string200 Site_Address;
        string2   Deed_Type;
        unsigned4 Recording_Date;
        string    Attorney;
        string    Plaintiff1;
        string    Plaintiff2;
        string    title_company;
        unsigned4 filing_date;
        unsigned4 auction_date;
        unsigned4 date_of_default;
    END;

    EXPORT lIteration:=RECORD
        UNSIGNED6 did;
        STRING1 came_from;
    END;

END;