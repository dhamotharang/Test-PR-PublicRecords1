import doxie;

// doxie.MAC_Header_Field_Declare()
export AutoKey_Search(ftype, res) :=
MACRO

ds := dataset([],doxie_build.AutoKey_Layout);
doxie_build.AutoKeys(ds, TRIM(ftype), ssn_key, phone_key, addr_key, stfl_key, city_key)

justID :=
RECORD
	ds.id;
END;

ssn_fetch := ssn_key(keyed(ssn=ssn_value));
justID ssn2id(ssn_fetch le) :=
TRANSFORM
	SELF := le;
END;
ssn_proj := PROJECT(ssn_fetch, ssn2id(LEFT));

phone_fetch := 
LIMIT(LIMIT(phone_key(	keyed(p7=IF(length(trim(phone_value))=10,phone_value[4..10],(STRING7)phone_value)),
						keyed(p3=phone_value[1..3] OR length(trim(phone_value)) <> 10)), 
			100000, FAIL(203, doxie.ErrorCodes(203)), keyed)
		,9000, FAIL(203, doxie.ErrorCodes(203)));

justID phone2id(phone_fetch le) :=
TRANSFORM
	SELF := le;
END;
phone_proj := PROJECT(phone_fetch, phone2id(LEFT));

addr_fetch := 
LIMIT(LIMIT(addr_key(pname_value != '',
				   keyed(prim_name=pname_value), 
				   keyed(prange_value = '' OR (string10)prange_value=prim_range),
				   keyed(hash((string25)city_value)=city_code OR city_value=''), 
				   keyed((string2)state_value=state OR state_value=''), 
				   wild(zip),
				   zip_value=[] or (integer4)zip IN zip_value,
				   keyed(sec_range_value='' or (string8)sec_range_value=sec_range),
				   fname_value='' or pfname=datalib.preferredfirst(fname_value),
				   lname_value='' or metaphonelib.DMetaPhone1(lname_value)=metaphonelib.DMetaPhone1(lname_value)), 
			100000, FAIL(203, doxie.ErrorCodes(203)), keyed)
		,9000, FAIL(203, doxie.ErrorCodes(203)));


justID addr2id(addr_fetch le) :=
TRANSFORM
	SELF := le;
END;
addr_proj := PROJECT(addr_fetch, addr2id(LEFT));

pfe(string20 l, string20 r) := l[1..length(trim(datalib.preferredfirst(r)))]=(string20)datalib.preferredfirst(r);

state_fetch := 
LIMIT(LIMIT(stfl_key( lname_value != '',
					keyed(dph_lname=metaphonelib.DMetaPhone1(lname_value)[1..6]),
					keyed((lname=(string20)lname_value OR phonetics)),
					keyed(pfe(pfname,fname_value) OR fname_value=''),
					keyed(fname[1..length(trim(fname_value))]=(STRING20)fname_value OR nicknames), 
					keyed((state=(string2)state_value or state_value='')),
					keyed(mname_value='' or (string1)mname_value[1]=minit),
					keyed(yob>=(unsigned2)find_year_low AND 
							yob<=IF((unsigned2)find_year_high != 0, (unsigned2)find_year_high, (unsigned2)0xFFFF)),
					keyed(ssn_value='' or (unsigned2)ssn_value=s4),
					find_month=0 or (dob div 100) % 100=find_month,
					find_day=0 or dob % 100=find_day,
					zip_value=[] or (integer4)zip IN zip_value), 
			100000, FAIL(203, doxie.ErrorCodes(203)), keyed)
		,9000, FAIL(203, doxie.ErrorCodes(203)));
		
justID state2id(state_fetch le) :=
TRANSFORM
	SELF := le;
END;
state_proj := PROJECT(state_fetch, state2id(LEFT));

city_fetch := 
LIMIT(LIMIT(city_key(city_value != '',
			  keyed(city_code=hash((string25)city_value)),
			  keyed(state=(STRING2)state_value OR state_value=''),   
			  keyed(dph_lname=(string6)metaphonelib.DMetaPhone1(lname_value) OR lname_value=''),
				keyed(lname=(STRING20)lname_value OR phonetics OR lname_value=''),
			  keyed(pfe(pfname,fname_value) OR fname_value=''),
				keyed(fname[1..length(trim(fname_value))]=(string20)fname_value OR nicknames),
			  find_year_low=0 or yob>=find_year_low,find_year_high=0 or yob<=find_year_high), 
			100000, FAIL(203, doxie.ErrorCodes(203)), keyed)
		,9000, FAIL(203, doxie.ErrorCodes(203)));

justID city2id(city_fetch le) :=
TRANSFORM
	SELF := le;
END;
city_proj := PROJECT(city_fetch, city2id(LEFT));

res := DEDUP(MAP(	length(trim(ssn_value))=9 				=> ssn_proj,
					phone_value <> '' 						=> phone_proj,
					pname_value <>'' and 
					  (prange_value<>'' or lname_value='') 	=> addr_proj,
					city_value='' 							=> state_proj,
					city_proj)
			 , all);

ENDMACRO;