export layout_newdata :=
module

	export input :=
	module
	
		export canadianphone :=
		record
			string Record_ID	;
			string Name			;
			string Address	;
			string City			;
			string Province	;
			string Zip_Code	;
			string SIN			;
		
		end;
	
	end;

	export	Response	:=
	module
	
		export	rFDSCanadianPhone_layout	:=
		record
			string	Record_ID;
			string	First_Name;
			string	Middle_Name;
			string	Last_Name;
			string	Company_Name;
			string	Address_Line1;
			string	Address_Line2;
			string	City;
			string	State;
			string	Zip;
			string	Phone_Number;
			string	Publish_Date;
		end;
		
	end;
end;