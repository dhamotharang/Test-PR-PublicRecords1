import ut,doxie;

export FN_Tra_Penalty_Address(
    string predir_field ='',string prange_field = '' ,string pname_field = '' ,string suffix_field = '' ,
		string postdir_field = '' ,string sec_range_field = '' ,string city_field = '' ,string state_field = '' ,
		string zip_field = '0' 
		,string  ref_predir  = '' ,string  ref_prange  = '' ,string  ref_pname  = '' ,string  ref_suffix  = '' ,
		string  ref_postdir  = '' ,string  ref_sec_range  = '' ,string  ref_city  = '' ,string  ref_state  = '' ,
		string  ref_zip ='0'
		) := FUNCTION

doxie.MAC_Header_Field_Declare()

city_pen(string field) := map(
	ref_city='' or field=ref_city => 0, 
	field='' => 3,
	ut.stringsimilar(field,ref_city)<3 => 1,	 
	5
);

RETURN city_pen(city_field) +
IF (ref_state='' or state_field=ref_state,0,10) +
MAP ((unsigned4)ref_zip= 0 or ref_zip=zip_field or 
		 (unsigned3) zip_field = (unsigned4)ref_zip => 0,
     (unsigned4)zip_field=0 => 2
		 ,3) +
			
MAP ( ref_predir='' or predir_field=ref_predir => 0,1) +
MAP ( ref_postdir='' or postdir_field=ref_postdir => 0,1) +
MAP ( ref_suffix='' or suffix_field=ref_suffix => 0,1) +
MAP (ref_pname='' or ut.StripOrdinal(pname_field)=ref_pname => 0,
     pname_field='' => 8, 
     ut.stringsimilar(ref_pname,pname_field)) +
MAP ((unsigned8)ref_prange=0 or (unsigned8)prange_field=(unsigned8)ref_prange => 0,
     (unsigned8)prange_field=0 => 2, 
     ut.stringsimilar(ref_prange,prange_field));
END;