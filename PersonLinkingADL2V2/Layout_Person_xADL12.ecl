export Layout_Person_xADL12 := record
				unsigned1		sourceid;
				unsigned6   did;
				string5     ssn5;
				string4     ssn4;
				string8     dob;
				string20    fname;
				string20    mname;
				string20    lname;
				string      MAINNAME := ''; // Concepts always a wordbag
				string 			NAMESSN := ''; // Concepts always a wordbag				
				string5     name_suffix;
				string      FULLNAME := ''; // Concepts always a wordbag				
				string10    phone;
				string25    city;
				string2     state;
				string10    prim_range;
				string28    prim_name;
				string8     sec_range; 
				string5     zip;
				string4     zip4;
				string      ADDR1 := ''; // Concepts always a wordbag
				string3     county;				
				string      LOCALE := ''; // Concepts always a wordbag				
				string      ADDRS := ''; // Concepts always a wordbag		
				unsigned2   Weight:=0;
				unsigned2   Score;
				unsigned6   UniqueID;
end;