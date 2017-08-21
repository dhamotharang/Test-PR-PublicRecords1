export Layout_in_HospitalAffiliation := Module

export raw := record
  string HospitalID;
  string Name;
  string Address;
  string City;
  string State;
  string Zip; /* Enter your record definition here*/
  string ExtZip;
  string Latitude;
  string Longitude;
  string PhoneNumber;
  string AHAIDNumber;
  string MedicareProviderID;
  string TaxID;
  string ServiceCodeDescription;
  string TotalBeds;
	end;




export raw_srctype := 

{ 
  string  FILETYP;
	string	ProcessDate;
	string	HospitalID;
	string	HospitalName;
	string	Address;
	string 	City;
	string	State;
	string	Zip;
	string	Extzip;
	string	Latitude;
	string	Longitude;
	string	PhoneNumber;
	string	AHAIDNumber;
	string	MedicareProviderID;
	string	TaxID;
	string	ServiceCodeDescription;
	string	TotalBeds;
};

end;