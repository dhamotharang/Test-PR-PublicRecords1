export layout_SANCTN_keybase := module 


//-------------------------------------------------------------------------
//Parent Layouts
export layout_SANCTN_partyFull := record
	STRING8   BATCH_NUMBER:='';
	STRING8   INCIDENT_NUMBER:='';
	STRING8   PARTY_NUMBER:='';
	STRING1   RECORD_TYPE:='';
	STRING45  PARTY_NAME:='';
	STRING45  PARTY_POSITION:='';
	STRING45  PARTY_VOCATION:='';
	STRING70  PARTY_FIRM:='';
	STRING45  inADDRESS:='';
	STRING45  inCITY:='';
	STRING20  inSTATE:='';
	STRING10  inZIP:='';
	STRING11  SSNUMBER:='';
	STRING10  FINES_LEVIED:='';
	STRING10  RESTITUTION:='';
	STRING1   OK_FOR_FCR:='';
	string5        	title := '';
	string20       	fname := '';
	string20       	mname := '';
	string20       	lname := '';
	string45        cname := '';
	string10       	prim_range := '';
	string2        	predir := '';
	string28       	prim_name := '';
	string4        	addr_suffix := '';
	string2        	postdir := '';
	string10       	unit_desig := '';
	string8        	sec_range := '';
	string25       	p_city_name := '';
	string25       	v_city_name := '';
	string2        	state := '';
	string5        	zip5 := '';
	string4        	zip4 := '';
	string4        	cart := '';
	string1        	cr_sort_sz := '';
	string4        	lot := '';
	string1        	lot_order := '';
	string2        	dpbc := '';
	string1        	chk_digit := '';
	string2        	rec_type := '';
	string2        	ace_fips_st := '';
	string3        	ace_fips_county := '';
	string10       	geo_lat := '';
	string11       	geo_long := '';
	string4        	msa := '';
	string7        	geo_blk := '';
	string1        	geo_match := '';
	string4        	err_stat := '';
	string5        	name_suffix := '';
	string3        	name_score := '';
	unsigned6 		did := 0;
	string3 		did_score := '';
end;

export layout_SANCTN_incidentFull := record
	STRING8  BATCH_NUMBER;
	STRING8  INCIDENT_NUMBER;
	STRING8  PARTY_NUMBER;
	STRING1  RECORD_TYPE;
	STRING8  AG_CODE;
	STRING20 CASE_NUMBER;
	string8  incident_date_clean := '';
	STRING90 JURISDICTION;
	STRING70 SOURCE_DOCUMENT;
	STRING70 ADDITIONAL_INFO;
	STRING70 AGENCY;
	STRING10 ALLEGED_AMOUNT;
	STRING10 ESTIMATED_LOSS;
	string8  fcr_date_clean := '';
	STRING1  OK_FOR_FCR;

end;


end;
















