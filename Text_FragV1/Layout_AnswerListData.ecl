import BIPV2;
Layout_Name := RECORD
	STRING30  fname := '';
	STRING30  mname := '';
	STRING30  lname := '';
	STRING10  name_suffix := '';
	STRING120 full_name := '';			
END;
Layout_Address := RECORD
	STRING10  prim_range := '';
	STRING2   predir := '';
	STRING28  prim_name := '';
	STRING4   addr_suffix := '';
	STRING2   postdir := '';
	STRING8   unit_desig := ''; 
	STRING8   sec_range:= '';
	STRING25  city_name := '';
	STRING2   st:= '';
	STRING5   zip5 := '';
	STRING4   zip4 := '';	
	STRING80  line1 := ' ';
	STRING80	csz	:= ' ';
END;

EXPORT Layout_AnswerListData := RECORD
	UNSIGNED6 rid;
	UNSIGNED6 did := 0;
	UNSIGNED6 bdid := 0;
	UNSIGNED2	src := 0;
	UNSIGNED6 doc := 0;
	STRING8 	dt_last_seen := '';
	STRING10  source_doc_type := '';
	STRING62  record_id := '';
	STRING120 company_name := '';	
	Layout_Name name;
	Layout_Address address;
	STRING10  phone := '';
	STRING9   ssn := '';
	STRING9   fein := '';
	STRING8   dob := '';	
	BIPV2.IDlayouts.l_xlink_ids;
END;