export layouts := MODULE

EXPORT
newspaper_raw_xml	:= RECORD
    STRING Obituary_ID               {xpath('Property[1]')};
    STRING Obit_Date                 {xpath('Property[2]')};
    STRING Updated_At                {xpath('Property[3]')};
		STRING First_Name                {xpath('Property[4]')};
    STRING Middle_Name               {xpath('Property[5]')};
    STRING Last_Name                 {xpath('Property[6]')};
    STRING Maiden_Name               {xpath('Property[7]')};
    STRING Nick_Name                 {xpath('Property[8]')};
    STRING DOB                       {xpath('Property[9]')};
    STRING DoD                       {xpath('Property[10]')};
    STRING Age                       {xpath('Property[11]')};
    STRING Funeral_Service_in_City   {xpath('Property[12]')};
    STRING Funeral_Service_in_State  {xpath('Property[13]')};
    STRING Service_Location_Zip_Code {xpath('Property[14]')};
    STRING Funeral_Service_Info      {xpath('Property[15]')};
    STRING Obituary_Link             {xpath('Property[16]')};
    STRING Newspaper_Source          {xpath('Property[17]')};
    STRING Newspaper_City            {xpath('Property[18]')};
    STRING Newspaper_Zip_Code        {xpath('Property[19]')};
END;

EXPORT
newspaper_raw	:= RECORD
    STRING Obituary_ID;
    STRING Obit_Date;
    STRING Updated_At;
		STRING First_Name;
    STRING Middle_Name;
    STRING Last_Name;
    STRING Maiden_Name;
    STRING Nick_Name;
    STRING DOB;
    STRING DoD;
    STRING Age;
    STRING Funeral_Service_in_City;
    STRING Funeral_Service_in_State;
    STRING Service_Location_Zip_Code;
    STRING Funeral_Service_Info;
    STRING Obituary_Link;
    STRING Newspaper_Source;
    STRING Newspaper_City;
    STRING Newspaper_Zip_Code;
  END;
	
EXPORT	
obit_xml_in	:= RECORD, MAXLENGTH(21000)
    STRING person_id{xpath('person_id')};
    STRING prefix{xpath('prefix')};
    STRING fname{xpath('first')};
    STRING mname{xpath('middle')};
    STRING lname{xpath('last')};
    STRING suffix{xpath('suffix')};
    STRING gender{xpath('gender')};
    STRING age{xpath('age')};
    STRING birth_month{xpath('birth/month')};
    STRING birth_day{xpath('birth/day')};
    STRING birth_year{xpath('birth/year')};
    STRING death_month{xpath('death/month')};
    STRING death_day{xpath('death/day')};
    STRING death_year{xpath('death/year')};
    STRING location_city{xpath('location/city')};
    STRING location_state{xpath('location/state')};
    STRING companions_name{xpath('companions_name')};
    STRING donation_text{xpath('donation_text')};
    STRING education_text{xpath('education_text')};
    STRING military_text{xpath('military_text')};
    STRING service_text{xpath('service_text')};
    STRING spouses_living_status{xpath('spouses_living_status')};
    STRING spouses_name{xpath('spouses_name')};
    STRING full_obit_text{xpath('text')};
END;

EXPORT
 obit_paragraph_rec := record, maxlength(4194304)
   STRING ObitId;
   STRING ObitParagraph;
 END;

EXPORT
 seqed_obit_paragraph_rec := RECORD
    unsigned seqno := 1;
    obit_paragraph_rec
 END;

EXPORT
obitid_and_sentences_rec := RECORD
  unsigned seqno;
  unsigned sentno:=0;
	STRING ObitId;
  STRING sentence;
END;

EXPORT
tribute_obit_in := RECORD, MAXLENGTH(21000)
     STRING person_id;
     STRING prefix;
     STRING first;
     STRING middle;
     STRING last;
     STRING suffix;
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
     STRING companions_name;
     STRING donation_text;
     STRING education_text;
     STRING military_text;
     STRING service_text;
     STRING spouses_living_status;
     STRING spouses_name;
     STRING full_obit_text;
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

EXPORT
tribute_obit_rec := RECORD,maxlength(21000)
//  STRING obitfile_id;
  STRING person_id;
  STRING prefix;
  STRING first;
  STRING middle;
  STRING last;
  STRING suffix;
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
 END;

export hfs_out_rec := RECORD
	INTEGER seq;
	INTEGER score;
	STRING penalt;
	unsigned6 did;
	STRING tnt;
	STRING glb;
	STRING dppa;
	STRING first_seen;
	STRING last_seen;
	STRING fname;
	STRING mname;
	STRING lname;
	STRING name_suffix;
	STRING dob;
	STRING age;
  unsigned4 dod;
	STRING1 deceased := 'U';
  unsigned1 dead_age;
  STRING1 death_code;
	STRING ssn;
	STRING valid_ssn;
	STRING prim_range;
	STRING predir;
	STRING prim_name;
	STRING suffix;
	STRING postdir;
	STRING unit_desig;
	STRING sec_range;
	STRING city_name;
	STRING st;
	STRING zip;
	STRING zip4;
	STRING county_name;
	STRING phone;
	STRING listed_phone;
	STRING listed_name;
	STRING output_seq_no;
	INTEGER veh_cnt := 0;
	INTEGER dl_cnt := 0;
	INTEGER head_cnt := 0;
	INTEGER crim_cnt := 0;
	INTEGER sex_cnt := 0;
	INTEGER ccw_cnt := 0;
	INTEGER rel_count := 0;
	INTEGER fire_count := 0;
	INTEGER faa_count := 0;
	INTEGER prof_count := 0;
	INTEGER vess_count := 0;
	INTEGER bus_count := 0;
	INTEGER prop_count := 0;
	INTEGER code := 0;
	STRING message := '';
END;

EXPORT
qes_out_rec := record
	unsigned6 did;
  STRING fname;
  STRING mname;
  STRING lname;
  STRING name_suffix;
  STRING prim_range;
  STRING predir;
  STRING prim_name;
  STRING suffix;
  STRING postdir;
  STRING unit_desig;
  STRING sec_range;
  STRING city_name;
  STRING st;
  STRING zip;
  STRING zip4;
  unsigned2 t_score;
  end;

EXPORT Obituary_raw_in := RECORD
		STRING	person_id;  //Changed to reflect what Tributes uses for data processing purposes
		STRING	lname;
		STRING	fname;
		STRING	mname;
		STRING10	DateOfDeath;
		STRING10	DateOfBirth;
		STRING3	Age;
		STRING	name_prefix;
		STRING	name_suffix;
		STRING	City_in;
		STRING	State_in;
		STRING10  create_dt;
		STRING10  update_dt;
		//STRING	ObituaryText;  --Vendor removed this field in updates
	END;
	
EXPORT Obituary_raw_base := RECORD
		STRING8 filedate;
		Obituary_raw_in;
	END;
	
END;