import business_header,header,gong_Neustar,fcra, ut;

EXPORT Phone_Table_v2 (boolean isFCRA = false, boolean gongFilter=false) := FUNCTION

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
	integer did_ct;
	integer did_ct_c6;	
	//CCPA-22 add did/global_sid/record_sid
	UNSIGNED6 did := 0;
	UNSIGNED4 global_sid := 0;
	UNSIGNED8 record_sid := 0;
END;


rec slimg(gong_Neustar.File_History_Full_Prepped_for_Keys le) := TRANSFORM
	SELF.dt_first_seen := (unsigned3)(le.dt_first_seen[1..6]);
	SELF.isCurrent := le.current_record_flag='Y';
	SELF.potDisconnect := ~SELF.isCurrent;
	SELF.zip5 := le.z5;
	SELF.zip4 := le.z4;
	SELF.lname := le.name_last;
///// bug 42318 - v city and p city swapped
	SELF.city := le.v_city_name;
	self.state := le.st;
	SELF := le;
	self := [];
END;

sysdate := ut.GetDate[1..6] + '31';
allowedBellIdForFCRA := ['LSS','LSI','LSP','NEU'];	// cjs

//good_phns := gong_Neustar.File_GongHistory(goodphone(phone10));
// cjs Filter out non FCRA phones
good_phns := IF(gongFilter,
				gong_Neustar.File_Gong_History_FullEx(goodphone(phone10),bell_id in allowedBellIdForFCRA),
				gong_Neustar.File_Gong_History_FullEx(goodphone(phone10)));
gg := project(good_phns, slimg(LEFT));

all_phones := DEDUP(SORT(DISTRIBUTE(gg,HASH(phone10)),RECORD, LOCAL),RECORD, LOCAL);

// count the number of DID's that have been associated with each phone10
did_slim := RECORD
	good_phns.phone10;	
	good_phns.did;
	dt_first_seen := MIN(GROUP,IF(good_phns.dt_first_seen='0',999999,(unsigned3)good_phns.dt_first_seen[1..6]));
	dt_last_seen := MAX(GROUP,(unsigned3)good_phns.dt_last_seen[1..6]);
END;
good_phns_distr := distribute(good_phns(current_record_flag='Y' or ut.DaysApart(sysdate, dt_first_seen[1..6]+'31') < 365), hash(phone10));
d_did := TABLE(good_phns_distr(did<>0), did_slim, phone10, did, LOCAL);


did_stats := record
	d_did.phone10;
	did_ct := count(group);
	did_ct_c6 := count(group, ut.DaysApart(sysdate, ((string)d_did.dt_first_seen)[1..6]+'31') < 183);
end;
did_counts := table(d_did, did_stats, phone10, local);

with_did_counts := join(all_phones, did_counts, left.phone10 = right.phone10,
				transform(rec, self.did_ct := right.did_ct, self.did_ct_c6 := right.did_ct_c6, self := left), 
				left outer, local, keep(1));

// Get telcordia info on company.  A means "for all npa nxx"
rec addBusType(rec le, layout_telcordia_tpm ri) := TRANSFORM
	SELF.company_type := ri.company_type;
	SELF.company_type_A := ri.tb = 'A';
	SELF.nxx_type := ri.nxx_type;
	SELF := le;
END;
with_cotype := JOIN(with_did_counts, File_Telcordia_tpm, 
                    LEFT.phone10[1..6]=(RIGHT.npa+RIGHT.nxx) AND RIGHT.tb IN [LEFT.phone10[7],'A'], 
                    addBusType(LEFT,RIGHT), many lookup, left outer);


//----------------[ Biz Header Indicators ]-----------
//Layout_Business_Header_Base
// any hint of a business
rec check_biz(rec le, business_header.file_business_header ri) := transform
	SELF.isaCompany := (INTEGER)ri.phone<>0;
	self := le;
end;

//bheader := IF (IsFCRA,
//               business_header.File_Business_Header (phone != 0, ~fcra.Restricted_BusHeader_Src(source, vendor_id[1..2])),
//               business_header.File_Business_Header (phone != 0));
bheader := DEDUP(SORT(
							DISTRIBUTE(
							IF (IsFCRA,
               business_header.File_Business_Header (phone != 0, ~fcra.Restricted_BusHeader_Src(source, vendor_id[1..2])),
               business_header.File_Business_Header (phone != 0))
							 ,hash((string10)phone))
							 ,phone,local),phone,local);
with_busflag := join (with_cotype,bheader,
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

  p_name := IF(gongFilter, 'phone_table_FCRA_gong_v2',
		IF (IsFCRA, 'phone_table_FCRA_v2', 'phone_table_v2')); 
  iter := ITERATE (outf, iterator(LEFT,RIGHT)) : persist ('~thor::persist::' + p_name);

  RETURN iter;
END;