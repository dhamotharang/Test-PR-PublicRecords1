export layouts := MODULE

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
   string ObitId;
   string ObitParagraph;
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
	string ObitId;
  string sentence;
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
		 string8  filedate;
     STRING person_id;
		 string1 rec_type;
     STRING prefix;
     STRING fname;
     STRING mname;
     STRING lname;
     STRING name_suffix;
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

EXPORT
tribute_obit_rec := RECORD,maxlength(21000)
//  string obitfile_id;
  string person_id;
  string prefix;
  string first;
  string middle;
  string last;
  string suffix;
  string gender;
  string age;
  string birth_month;
  string birth_day;
  string birth_year;
  string death_month;
  string death_day;
  string death_year;
  string location_city;
  string location_state;
  string spouses_name;
  string spouses_living_status;
  string companions_name;
  string full_obit_text;
  string donation_text;
  string education_text;
  string military_text;
  string service_text;
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
	string1 deceased := 'U';
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
  string fname;
  string mname;
  string lname;
  string name_suffix;
  string prim_range;
  string predir;
  string prim_name;
  string suffix;
  string postdir;
  string unit_desig;
  string sec_range;
  string city_name;
  string st;
  string zip;
  string zip4;
  unsigned2 t_score;
  end;

EXPORT Obituary_raw_in := RECORD
		string	person_id;  //Changed to reflect what Tributes uses for data processing purposes
		string	lname;
		string	fname;
		string	mname;
		string10	DateOfDeath;
		string10	DateOfBirth;
		string3	Age;
		string	name_prefix;
		string	name_suffix;
		string	City_in;
		string	State_in;
		string10  create_dt;
		string10  update_dt;
		//string	ObituaryText;  --Vendor removed this field in updates
	END;
	
EXPORT Obituary_raw_base := RECORD
		string8 filedate;
		Obituary_raw_in;
	END;
	
END;