EXPORT layout_Person_xADL2 := record
				unsigned6   did;
				string5     ssn5;
				string4     ssn4;
				string			namessn;
				string8     dob;
				string20    fname;
				string20    mname;
				string20    lname;
				string			mainname;
				string			fullname;		
				string5     name_suffix;
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
				string10    phone;
				unsigned6   UniqueID;
END;