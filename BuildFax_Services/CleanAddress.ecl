IMPORT Address, ut, doxie;

export Layout_BuildFax.cleanaddr_rec CleanAddress(DATASET(Layout_BuildFax.seq_input_rec) addrin) := FUNCTION
		
    
    Layout_BuildFax.cleanaddr_rec CleanAddr(Layout_BuildFax.seq_input_rec l) := TRANSFORM
		
		AddressLine1 (string9 House, string20 street, string5 apt) := 
		                       Address.Addr1FromComponents(TRIM(House),'', TRIM(Street), '', '', IF(Apt<>'',constants.DefaultUnitDesig,''), TRIM(Apt)); 
		
    AddressLine2 (string20 city,string2 state, string5 zip)    := 
		                       Address.Addr2FromComponents(TRIM(City),TRIM(State),TRIM(Zip)); 	
													 

    Line1 := AddressLine1(l.house, l.street, l.apt);
  	Line2 := AddressLine2(l.city, l.st, l.zip);
		
		Clean_1 := doxie.cleanaddress182 (Line1,Line2);
	  Error_Code := Clean_1[179..182];
	
	// Checking to see if error code is E216, only in this case we want to standardize the city name from ST to SAINT.
	// For any other error code we do not want to touch the city name.

	  Standard_addr_second_line:=if(Error_Code = constants.E216Error,Address.SpecialCaseHandler.StandardizeCityName(Line2),Line2);
	  Clean_2:=doxie.cleanaddress182(Line1,Standard_addr_second_line);
	  Clean  :=if(Error_Code = constants.E216Error,Clean_2,Clean_1);

		self.address.prim_range 	:= clean [1..10];
    self.address.predir     	:= clean [11..12];
    self.address.prim_name  	:= clean [13..40];
    self.address.addr_suffix 	:= clean [41..44];
    self.address.postdir   	  := clean [45..46];
    self.address.unit_desig 	:= clean [47..56];
    self.address.sec_range  	:= IF(clean[139] IN constants.ValidAptType OR clean[179] = constants.ErrorInd,clean [57..64],'');
    self.address.city     	  := stringLib.stringToUpperCase(TRIM(l.city));
    self.address.st         	:= stringLib.stringToUpperCase(TRIM(l.st));
    self.address.zip   			  := clean [117..121];  
    self.address.zip4 				:= clean [122..125];
		self.errorcode          	:= IF(clean[179]=constants.ErrorInd,clean [179..182],'');
		self.input := l;
  END;
		
    RETURN PROJECT(addrin,cleanAddr(left));
END;