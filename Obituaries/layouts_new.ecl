﻿Export layouts_new := MODULE

EXPORT
obit_xml_historical := RECORD, MAXLENGTH(21000)
		STRING person_id{xpath('id')};
	  STRING obit_start_date{xpath('obit_start_date')};	
		STRING row_create{xpath('row_created')};
		STRING row_update{xpath('row_updated')};
		STRING row_deleted{xpath('row_deleted')};
		STRING salutation{xpath('salutation')};
    STRING fname{xpath('first_name')};
    STRING mname{xpath('middle_name')};
    STRING lname{xpath('last_name')};
    STRING maiden_name{xpath('maiden_name')};
		STRING nick_name{xpath('nick_name')};
    STRING date_birth{xpath('date_of_birth')};		
		STRING date_death{xpath('date_of_death')};	
	  STRING age{xpath('age')};	
		STRING gender{xpath('gender')};
		STRING location_city{xpath('current_city')};
    STRING location_state{xpath('current_state')};
		STRING funeral_city{xpath('FuneralServiceInCity')};
		STRING funeral_st{xpath('FuneralServiceInState')};
	  STRING associate_funeral_home{xpath('AssociatedFuneralHome')};	
	  STRING education_text{xpath('education')};
		STRING military_text{xpath('military')};
	  STRING donation_text{xpath('donation')};
    STRING service_text{xpath('funeral_services')};			
		STRING full_obit_text{xpath('obit_text')};
				
END;

EXPORT
layout_reor_tribute := RECORD, MAXLENGTH(21000)
		 STRING8  filedate;
     STRING person_id;
		 STRING1 rec_type;
     STRING prefix;
     STRING fname;
     STRING mname;
     STRING lname;
     STRING name_suffix;
		 // New fields from Newspaper
     STRING Maiden_Name;
     STRING Nick_Name;		 
		 
     STRING gender;
     STRING age;
     STRING birth_month;
     STRING birth_day;
     STRING birth_year;
     STRING death_month;
     STRING death_day;
     STRING death_year;
     STRING location_city;
     STRING location_state;
     STRING spouses_name;
     STRING spouses_living_status;
     STRING companions_name;
     STRING full_obit_text;
     STRING donation_text;
     STRING education_text;
     STRING military_text;
     STRING service_text;
		 
     // New fields from Newspaper
     STRING Obit_Date;
     STRING Updated_Date;
     STRING Funeral_Service_in_City;
     STRING Funeral_Service_in_State;
     STRING Service_Location_Zip_Code;
     STRING Obituary_Link;
     STRING Newspaper_Source;
     STRING Newspaper_City;
     STRING Newspaper_Zip_Code;
		
		 // New fields from tribute history
     STRING RowCreated_Date;
		 STRING RowUpdated_Date;
		 STRING RowDeleted_Date;
		 STRING Salutation;
		 STRING Associated_Funeral_Home;
END;

END;