import Data_Services, doxie, ut;

// Uncomment code below when key is built...
Lay_KeyLayout := Record
			Unsigned6 did := 0;   //known as unique_id for online, generated for customers
			Unsigned1 did_score := 0;	    
			Unsigned8 raw_aid := 0;  
			Unsigned6 hhid := 0;
			String	Login_history_id;
			String10	Phone_number;
			String	Unique_id;
			String	Fname;
			String	Lname;
			String	Mname;
			String2	Predir;//Street_pre_direction
			String2	Postdir;//Street_post_direction
			String10	Prim_range;//Street_number
			String28	Prim_name;//Street_name
			String4	Addr_suffix;//Street_suffix
			String8	Sec_range;//Unit_number
			String10	Unit_desig;//Unit_designation
			String5	Zip;//zip5
			String4	Zip4;//zip4
			String25	City;
			String2	St;//state
			String	Alt_phone;
			String	Other_info;
			Unsigned1	Address_contact_type;
			Unsigned1	Feedback_source;
			Unsigned4	date_time_added;
			String	LoginId;//UserId - vendor Field
			String	Companyid;
End;

Lay_KeyLayout xFile_KeyBase (AddressFeedback.File_AddressFeedback_base L) :=  Transform
			Self.Address_contact_type := (Unsigned)L.Address_contact_type;
			Self.Feedback_source := (Unsigned)L.Feedback_source;
			Self.date_time_added  := (Unsigned)L.date_time_added;
			Self.Predir := L.Street_pre_direction;
			Self.Postdir := L.Street_post_direction;
			Self.Prim_range := L.Street_number;
			Self.Prim_name := L.Street_name;
			Self.Addr_suffix := L.Street_suffix;
			Self.Sec_range := L.Unit_number;
			Self.Unit_desig := L.Unit_designation;
			Self.Zip := L.Zip5;
			Self.st := L.state;
			Self := L;
End;


File_KeyBase := Project(AddressFeedback.File_AddressFeedback_base, xFile_KeyBase(Left));


Export Key_AddressFeedback := index(File_KeyBase(Zip<>''),
										  {Prim_name, Zip, Prim_range, Sec_range, did},
										  // {Street_name, Zip5, Street_number, Unit_number, did}, //Fields from base file
										  {File_KeyBase},
										  Data_Services.Data_location.Prefix('AddressFeedback') + 'thor_data400::key::addressFeedback::'+doxie.Version_SuperKey+'::address');