import Data_Services, doxie, ut;

// Uncomment code below when key is built...
Lay_KeyLayout := AddressFeedback.Layouts.Lay_key;

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


Export Key_AddressFeedback := index(File_KeyBase(Prim_name <>'' and Prim_range <>'' and st <>''),
										  {Prim_name, Zip, Prim_range, Sec_range, did},
										  // {Street_name, Zip5, Street_number, Unit_number, did}, //Fields from base file
										  {File_KeyBase},
										  Data_Services.Data_location.Prefix('AddressFeedback') + 'thor_data400::key::addressFeedback::'+doxie.Version_SuperKey+'::address');