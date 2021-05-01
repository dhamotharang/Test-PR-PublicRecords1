EXPORT fn_dedup_identitydata(inputs):=FUNCTIONMACRO
    IMPORT ut;
    in_srt := sort(inputs , Customer_Id, Customer_State, Customer_Agency_Vertical_Type, Customer_Program, Reason_Description,Date_of_Transaction,Rawlinkid,raw_Full_Name,raw_Title,raw_First_name,
    raw_Middle_Name,raw_Last_Name,raw_Orig_Suffix,SSN,SSN4,Address_Type,Street_1,Street_2,City,State,Zip,Mailing_Street_1,
    Mailing_Street_2,Mailing_City,Mailing_State,Mailing_Zip,County,Contact_Type,phone_number,Cell_Phone,dob,Email_Address,
    Drivers_License_State,Drivers_License,Bank_Routing_Number_1,Bank_Account_Number_1,Bank_Routing_Number_2,Bank_Account_Number_2,
    Ethnicity,Race,Household_ID,Customer_Person_ID,Head_of_Household_indicator,Relationship_Indicator,IP_Address,Device_ID,
    Unique_number,MAC_Address,Serial_Number,Device_Type,Device_identification_Provider,geo_lat,geo_long,source,rin_source, source_rec_id); //transaction_id, Customer_Job_ID,Batch_Record_ID
    new_rec := record
		inputs;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen; 
		unsigned4 dt_vendor_last_reported; 
		unsigned4 dt_vendor_first_reported;
	end;
    {new_rec} RollupUpdate({new_rec} l, {new_rec} r) := 
    transform
        SELF.source_rec_id := if(l.source_rec_id < r.source_rec_id,l.source_rec_id, r.source_rec_id); // leave always previous Unique_Id 
        SELF.process_date := if(l.process_date < r.process_date,l.process_date, r.process_date);        
		SELF.dt_first_seen := ut.EarliestDate(l.Process_Date,r.Process_Date); 
		SELF.dt_last_seen := max(l.Process_Date,r.Process_Date);
		SELF.dt_vendor_last_reported := max(l.FileDate, r.FileDate);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.FileDate, r.FileDate);
		SELF.filedate := ut.EarliestDate(l.FileDate, r.FileDate); // leave always previous Process_Date
		SELF.filename := if(l.FileDate < r.FileDate,l.filename, r.filename); // leave always previous Filename
        SELF := l;
    end;

    in_ddp := rollup( 
        project(in_srt, transform(new_rec, 
            self.dt_first_seen:= left.Process_Date; 
            self.dt_last_seen:= left.Process_Date; 
            self.dt_vendor_last_reported:= left.FileDate; 
            self.dt_vendor_first_reported:= left.FileDate;		 
            self := left))
        ,RollupUpdate(left, right)
        ,Customer_Id, Customer_State, Customer_Agency_Vertical_Type, Customer_Program, 
        Reason_Description,Date_of_Transaction,Rawlinkid,raw_Full_Name,raw_Title,raw_First_name,raw_Middle_Name,raw_Last_Name,
        raw_Orig_Suffix,SSN,SSN4,Address_Type,Street_1,Street_2,City,State,Zip,Mailing_Street_1,Mailing_Street_2,Mailing_City,
        Mailing_State,Mailing_Zip,County,Contact_Type,phone_number,Cell_Phone,dob,Email_Address,Drivers_License_State,
        Drivers_License,Bank_Routing_Number_1,Bank_Account_Number_1,Bank_Routing_Number_2,Bank_Account_Number_2,Ethnicity,
        Race,Household_ID,Customer_Person_ID,Head_of_Household_indicator,Relationship_Indicator,IP_Address,Device_ID,Unique_number,
        MAC_Address,Serial_Number,Device_Type,Device_identification_Provider,geo_lat,geo_long, source, rin_source
    ); //transaction_id ,Customer_Job_ID,  Batch_Record_ID,
                
    return in_ddp;

ENDMACRO;