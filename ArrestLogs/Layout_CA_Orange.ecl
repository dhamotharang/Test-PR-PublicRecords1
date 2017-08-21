export Layout_CA_Orange := module
	
	export Original := record
		string ID;
		string Name;
		string DOB;
		string Sex;
		string Race;
		string Height;
		string Weight;
		string Hair_Color;
		string Eye_Color;
		string Occupation;
		string Next_Appearance_Dt;
		string Next_Appearance_Court;
		string Housing_Location;
		string Custody_Status;
		string Bail_Amt;
		string Arrest_on;
		string Booked_on;
		string Warrant_Case_Num;
		string Bail_Amt2;
		string Jurisdiction;
		string Arrest_Agency;
		string Num_of_Charges;
		string Case_Num;
		string Cnt;
		string Degree;
		string Code;
		string Section;
		string Description;
		string Alias;
		end;
		
	export New := record
		string	ID;
		string	Name;
		string	DOB;
		string	Next_Appearance_Dt;
		string	Sex;
		string	Next_Appearance_Court;
		string	Race;
		string	Custody_Status;
		string	Height;
		string	Bail_Amt;
		string	Weight;
		string	Arrest_on;
		string	Hair_Color;
		string	Eye_Color;
		string	Release_Type;
		string	Occupation;
		string	Release_Dt;
		end;

end;