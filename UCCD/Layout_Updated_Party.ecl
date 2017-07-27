export Layout_Updated_Party := record

unsigned6 	 bdid := 0;
unsigned6 	 did := 0;

unsigned4    dt_first_seen;
unsigned4    dt_last_seen;
unsigned4 	 dt_vendor_first_reported;
unsigned4 	 dt_vendor_last_reported;
string1 		 record_type := 'H';  //current/historical

string10 phone10;
STRING18 address1_county_name := '';

uccd.Layout_UCC_Party_In;
end;