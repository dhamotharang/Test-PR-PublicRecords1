export Layouts := Module


  export Sic_vendor_rec:=record
				string20 	UniqueID;
				String6  	Sic_code;
				string100 	Organization;
				string1 	filler;
			end;
			
  export     SIC_Code_Out_layout :=record
		  string20 		UniqueID;
		  String6 	 	Sic_code;
		  string100 	Organization;
          string11 		sic;
		  string50	    sic_Description;
		  string50		Business_Name;
		  string50	    Address;
		  string30		City;
		  string2 		State;
		  string10 		Zip;
		  String10 		Phone;
		  String1 		CDS_Code;
		  String100		CDS_Description;
		  string2   	LF;
  end;
  
end;