import business_header,header,gong,fcra;

EXPORT Phone_Table (boolean isFCRA = false) := FUNCTION

goodphone(string10 s) := (INTEGER)s<>0 AND LENGTH(Stringlib.stringfilter(s,'0123456789'))=10;

// get all phone numbers and associated zip's
rec := RECORD
	STRING10	phone10;
	BOOLEAN 	isCurrent;
	unsigned3 dt_first_seen;
	STRING20 	lname;
	string28 	prim_name;
	STRING10 	prim_range;
	string25 	city;
	string2  	state;
	STRING5  	zip5;
	STRING4  	zip4;
	boolean  	potDisconnect := false;
	BOOLEAN  	isaCompany := false;
	STRING1  	company_type := '';
	BOOLEAN  	company_type_A := false;
	string4  	sic_code := '';
	string120 company_name := '';
	unsigned3 hri_dt_first_seen := 0;
	STRING2 	nxx_type := '';
END;

rec slimg(gong.File_Gong_History_Full le) := TRANSFORM
	SELF.dt_first_seen := (unsigned3)(le.dt_first_seen[1..6]);
	SELF.isCurrent := le.current_record_flag='Y';
	SELF.potDisconnect := ~SELF.isCurrent;
	SELF.zip5 := le.z5;
	SELF.zip4 := le.z4;
	SELF.lname := le.name_last;
	SELF.city := le.p_city_name;
	self.state := le.st;
	SELF := le;
END;
gg := project(gong.File_Gong_History_Full(goodphone(phone10)), slimg(LEFT));

all_phones := DEDUP(SORT(DISTRIBUTE(gg,HASH(phone10)),RECORD, LOCAL),RECORD, LOCAL);

// Get telcordia info on company.  A means "for all npa nxx"
rec addBusType(rec le, layout_telcordia_tpm ri) := TRANSFORM
	SELF.company_type := ri.company_type;
	SELF.company_type_A := ri.tb = 'A';
	SELF.nxx_type := ri.nxx_type;
	SELF := le;
END;
with_cotype := JOIN(all_phones, File_Telcordia_tpm, 
                    LEFT.phone10[1..6]=(RIGHT.npa+RIGHT.nxx) AND RIGHT.tb IN [LEFT.phone10[7],'A'], 
                    addBusType(LEFT,RIGHT), many lookup, left outer);


//----------------[ Biz Header Indicators ]-----------
//Layout_Business_Header_Base
// any hint of a business
rec check_biz(rec le, business_header.file_business_header ri) := transform
	SELF.isaCompany := (INTEGER)ri.phone<>0;
	self := le;
end;

bheader := IF (IsFCRA,
               business_header.File_Business_Header (phone != 0, ~fcra.Restricted_BusHeader_Src(source, vendor_id[1..2])),
               business_header.File_Business_Header (phone != 0));

with_busflag := join (with_cotype,distribute(bheader,hash((string10)phone)),
                      left.phone10 = (string10)right.phone,
                      check_biz(LEFT,RIGHT),local, left outer, keep(1));

// any High risk business
hribphones := hri_business_phones (IsFCRA);

rec check_hri(rec le, hribphones ri) := TRANSFORM
	SELF.sic_code := ri.sic_code;
	SELF.company_name := ri.company_name;
	SELF.hri_dt_first_seen := ri.dt_first_seen;
	SELF := le;
END;
with_hribus := JOIN(with_busflag, distribute(hribphones, hash((STRING10)phone)),
                    left.phone10 = (STRING10)right.phone,
                    check_hri(LEFT,RIGHT),local, left outer);

// only keep 1 record for phone-at-address-with-sic####
rec roller(rec le, rec ri) := TRANSFORM
	SELF.isaCompany := le.isaCompany OR ri.isaCompany;
	// prefer the non-All version of telcordia
	SELF.company_type := IF(le.company_type_A, ri.company_type, le.company_type);
	SELF.company_type_A := le.company_type_A AND ri.company_type_A;
	// if there is a current phone-at-address, then we're current
	SELF.isCurrent := le.isCurrent OR ri.isCurrent;
	SELF.nxx_type := IF(le.company_type_A, ri.nxx_type, le.nxx_type);
	SELF := IF(le.isCurrent, le, ri);
END;
s := GROUP(SORT(with_hribus,phone10,lname,zip5,prim_name,prim_range,city,state,sic_code,-isCurrent,LOCAL),phone10,LOCAL);
outf := ROLLUP(s,roller(LEFT,RIGHT),phone10,lname,zip5,prim_name,prim_range,city,state,sic_code);


rec iterator(rec le, rec ri) := TRANSFORM
	SELF.potDisconnect := ~(le.isCurrent OR ri.isCurrent);
	SELF := ri;
END;

  p_name := IF (IsFCRA, 'maltemp::phone_table_FCRA', 'maltemp::phone_table'); 
  iter := ITERATE (outf, iterator(LEFT,RIGHT)) : persist (p_name);

  RETURN iter;
END;