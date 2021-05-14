IMPORT Data_Services,Std,dx_utility,BIPV2,autokey,ut,yellowpages,cellphone,doxie,$;

EXPORT data_key(STRING filedate = (STRING8)Std.Date.Today(), BOOLEAN pIsDeltaBuild = FALSE) := MODULE

daily_DID := DATASET(Data_Services.Data_Location.Prefix('Utility') + 'thor_data400::in::utility::'+filedate[1..8]+'::daily_did', $.Layout_DID_Out, thor);

//If this is delta build then only create a key with today's records, otherwise create a key with full date file

infile_DID		:=	IF(pIsDeltaBuild,daily_DID, $.file_util.full_did_for_index + $.file_supplemental.in_supp);

//cleanup phonetype for delta build
$.mac_clean_daily_phone(infile_DID, p_cleanphone_daily)
//cleanup phonetype for full data build
$.Mac_clean_phone(infile_DID, p_cleanphone_full)

p_cleanphone := IF(pIsDeltaBuild, p_cleanphone_daily, p_cleanphone_full);

//cleanup dates and driver license
$.mac_cleandates(p_cleanphone,p_clean_out)
//convert utility type
$.mac_convert_util_type(p_clean_out, p_out)

//***********************************CODE TO SUPRESS WA CELL PHONES********************************************
//Base search file needs to be reformated before using ut.mac_suppress_by_phonetype because does not accept the casting of did

r_new := RECORD
	$.Layout_DID_Out;
	unsigned6 did_temp;
END;

r_new t_reformat(p_out L) := TRANSFORM
	SELF.did_temp := (unsigned6)L.did;
	SELF := L;
END;
p1 := PROJECT(p_out, t_reformat(LEFT));

//Supress WA Cell Phones
ut.mac_suppress_by_phonetype(p1,work_phone,st,PhSuppressed1,true,did_temp);
ut.mac_suppress_by_phonetype(PhSuppressed1,phone,st,PhSuppressed2_out,true,did_temp);

SHARED PhSuppressed2 := PhSuppressed2_out :persist('~thor_data400::persist::utility::PhSuppressed2');

//If this is delta build then only create a key with today's records, otherwise create a key including the latest 60 days data only

SHARED PhSuppressed2_daily := IF(pIsDeltaBuild, PhSuppressed2, PhSuppressed2(record_date >= $.StartDate));

//If this is delta build then fdid need count the value derived from key_daily_fdid avoid duplicate value,otherwise just set the sequence number
end_fdid := COUNT(dx_utility.key_daily_fdid);

$.Layout_DID_Out t_fdid(PhSuppressed2_daily le, unsigned6 i) :=
TRANSFORM
	SELF.fdid := i + IF(pIsDeltaBuild, end_fdid, 0);
	SELF := le;
END;

SHARED append_fdid := PROJECT(PhSuppressed2_daily, t_fdid(LEFT, COUNTER)):persist('~thor_data400::persist::utility::fdid_daily');

//for full data keys
EXPORT i_DID := PROJECT(PhSuppressed2((unsigned6)did<>0),transform(dx_utility.layouts.i_did, 
self.ssn := '', self.s_did := (unsigned6)left.did, self := left));

EXPORT i_address := PROJECT(PhSuppressed2(trim(prim_name)<>''),transform(dx_utility.layouts.i_address, self.ssn := '', self := left));

//for daily did key

EXPORT i_DID_daily := PROJECT(append_fdid((unsigned6)did<>0),transform(dx_utility.layouts.i_did_daily, 
self.ssn := '', self.s_did := (unsigned6)left.did, self := left));

//for daily fdid key
EXPORT i_fdid_daily := PROJECT(append_fdid,transform(dx_utility.layouts.i_fdid_daily, self.ssn := '', self := left));

//for autokeys
rec_auto :=
RECORD
	$.Layout_DID_Out;
	integer zero := 0;
END;

EXPORT auto_base := PROJECT(append_fdid,transform(rec_auto,self := left));

autokey.MAC_data_address(auto_base,fname,mname,lname,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,v_city_name,zip,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						fdid,
						'',
						k_address)
						
EXPORT i_auto_address := k_address;

autokey.MAC_data_Name(auto_base,fname,mname,lname,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,v_city_name,zip,sec_range,
					  zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						fdid,
						'',
						k_name)

EXPORT i_auto_name := k_name;

autokey.MAC_data_SSN(auto_base,fname,mname,lname,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,v_city_name,zip,sec_range,
						states,
						lname1,lname2,lname3,
						city1,city2,city3,
						rel_fname1,rel_fname2,rel_fname3,
						lookups,
						fdid,
						'',
						k_ssn);

EXPORT i_auto_ssn := k_ssn;

autokey.MAC_data_phone(auto_base,fname,mname,lname,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,v_city_name,zip,sec_range,
						states,
						lname1,lname2,lname3,
						city1,city2,city3,
						rel_fname1,rel_fname2,rel_fname3,
						lookups,
						fdid,
						'',
						k_phone)
						
EXPORT i_auto_phone := k_phone;

autokey.MAC_data_CityStName(auto_base,fname,mname,lname,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,v_city_name,zip,sec_range,
					  zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						fdid,
						'',
						k_citystname)
						
EXPORT i_auto_CityStName := k_citystname;

autokey.MAC_data_StName(auto_base,fname,mname,lname,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,v_city_name,zip,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						fdid,
						'',
						k_stname)
						
EXPORT i_auto_stname := k_stname;

autokey.MAC_data_Zip(auto_base,fname,mname,lname,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,v_city_name,zip,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						fdid,
						'',
						k_zip)
						
EXPORT i_auto_zip := k_zip;

autokey.MAC_data_zipPRLname(auto_base,fname,mname,lname,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,v_city_name,zip,sec_range,
						states,
						lname1,lname2,lname3,
						city1,city2,city3,
						rel_fname1,rel_fname2,rel_fname3,
						zero,
						fdid,
						'',
						k_zipPRLName)

EXPORT i_auto_ZipPRLName := k_zipPRLName;

//**** Filtered Daily Business Utility records from the Utility Business Base file.
bus_base := $.file_util_bus.full_base_for_index;

Base		:=	IF(pIsDeltaBuild,bus_base(record_date = filedate[1..8]), bus_base);

  BIPV2.IDmacros.xf_xLinkIDsToKeyIDs(Base, BasePlusIds);
	
EXPORT i_LinkIds := PROJECT(BasePlusIds(UltID > 0), dx_utility.key_linkIDs.key_rec);

END;


