export Layouts := module

	export CompanyLayoutIn 									:= record
			string id;
			string comptype;
			string compseq;
			string name;
			string standing;
			string status;
			string country;
			string state;
			string type1;
			string raname;
			string raaddr1;
			string raaddr2;
			string raaddr3;
			string raaddr4;
			string racity;
			string rastate;
			string razip;
			string poaddr1;
			string poaddr2;
			string poaddr3;
			string poaddr4;
			string pocity;
			string postate;
			string pozip;
			string filedate;
			string orgdate;
			string authdate;
			string recorddate;
			string raresdte;
			string expdte;
			string rendte;
			string numofcr;
			string numofshr;
			string mangnum;
			string applname;
			string appltitl;
			string parpre;
			string parcomno;
			string parcom;
			string parpreno;
			string profit; 
			string recordnumber;
	end;

	export CompanyLayoutBase 								:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		CompanyLayoutIn;
	end;

	export InitialOfficersLayoutIn					:= record
		string id;
		string type1;
		string initialofficername;
		string dateadded;
		string recordnumber;
	end;

	export InitialOfficersLayoutBase				:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		InitialOfficersLayoutIn;
	end;

	export OfficerLayoutIn 									:= record
		string id;
		string comptype;
		string compseq;
		string type1;
		string fname;
		string mname;
		string lname;
		string chgdate;
		string recordnumber;
	end;

	export OfficerLayoutBase 								:= record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		OfficerLayoutIn;
	end;

	export TempCompanyLayoutIn 							:= record
			string id;
			string comptype;
			string compseq;
			string name;
			string standing;
			string status;
			string country;
			string state;
			string type1;
			string raname;
			string raaddr1;
			string raaddr2;
			string raaddr3;
			string raaddr4;
			string racity;
			string rastate;
			string razip;
			string racountry;			//new derived field
			string poaddr1;
			string poaddr2;
			string poaddr3;
			string poaddr4;
			string pocity;
			string postate;
			string pozip;
			string pocountry;			//new derived field
			string filedate;
			string orgdate;
			string authdate;
			string recorddate;
			string raresdte;
			string expdte;
			string rendte;
			string numofcr;
			string numofshr;
			string mangnum;
			string applname;
			string appltitl;
			string parpre;
			string parcomno;
			string parcom;
			string parpreno;
			string profit; 
			string recordnumber;
			string filingdate;
			string filingdesc;
	end;
	
	export TempCompanyOfficerLayoutIn 			:= record
		TempCompanyLayoutIn			- [type1];
		OfficerLayoutIn 				- [id,recordnumber];
	end;

	export TempCompanyInitOfficersLayoutIn	:= record
		TempCompanyLayoutIn 		- [type1];
		InitialOfficersLayoutIn - [id,recordnumber];
	end;

end;
