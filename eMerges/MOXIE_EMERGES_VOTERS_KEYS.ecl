//Do Emerges vote keys first
import emerges, lib_keylib,lib_stringlib;
#workunit ('name', 'Build Emerges Voters Keys ');

h := emerges.file_voters_keybuild;

MyFields := record
   h.file_id;
   string9 ssn := h.best_ssn;
   string12 did := h.did_out;
   string8 dob := h.dob;
   string2 st := lib_stringlib.stringlib.stringtouppercase(h.source_state);
   string2 state := lib_stringlib.stringlib.stringtouppercase(h.source_state);
   string25 city := h.p_city_name;
   string5 z5 := h.zip;
   string25 city_from_zip :='';
   VARSTRING citylist := '';
   h.fname;
   h.mname;
   h.lname;
   h.prim_range;
   h.predir;
   h.prim_name;
   h.suffix;
   h.postdir;
   h.sec_range;
   h.p_city_name;
   h.zip;
   string2 addr_st := lib_stringlib.stringlib.stringtouppercase(h.st);
   h.mail_prim_range;
   h.mail_predir;
   h.mail_prim_name;
   h.mail_addr_suffix;
   h.mail_postdir;
   h.mail_sec_range;
   h.mail_p_city_name;
   h.mail_ace_zip;
   string2 mail_st := lib_stringlib.stringlib.stringtouppercase(h.mail_st);
  string60 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + 
					  TRIM(h.mname,right);
  string60 fmlname := TRIM(h.fname,right) + ' ' + IF(TRIM(h.mname,right) = '', ' ',TRIM(h.mname,right) + ' ') + 
					  TRIM(h.lname,right);
  string45 mfname := TRIM(h.mname,right) + ' ' + TRIM(h.fname,right);
  string6  dph_lname := metaphonelib.DMetaPhone1(h.lname);
  string5 all_zip := '';
  string25 all_city := '';
  string2 all_state := '';

   h.__filepos;
end;

// -- KEY #0
t := table(h,MyFields);

lfmname_rec := record
t.lfmname;
t.__filepos;
end;

lfmname_records := table(t,lfmname_rec);

k1 := BUILDINDEX(lfmname_records(lfmname != ''),,emerges.base_key_name_emerges_vote + 'lfmname.key',moxie,overwrite);

// -- Key #1

dph_lname_rec := record
t.dph_lname;
t.fname;
t.mname;
t.lname;
t.__filepos;
end;

dph_lname_records := table(t,dph_lname_rec);

k2 := BUILDINDEX(dph_lname_records(dph_lname != ''),,emerges.base_key_name_emerges_vote + 'dph_lname.fname.mname.lname.key',moxie,overwrite);

// -- Key #2

st_lfmname_rec := record
t.st;
t.lfmname;
t.__filepos;
end;

st_lfmname_records := table(t,st_lfmname_rec);

k3 := BUILDINDEX(st_lfmname_records(st != '' and lfmname != ''),,emerges.base_key_name_emerges_vote + 'st.lfmname.key',moxie,overwrite);

// -- Key #3
st_dph_lname_rec := record
t.st;
t.dph_lname;
t.fname;
t.mname;
t.lname;
t.__filepos;
end;

st_dph_lname_records := table(t,st_dph_lname_rec);

k4 := BUILDINDEX(st_dph_lname_records(st != '' and dph_lname != ''),,
	emerges.base_key_name_emerges_vote + 'st.dph_lname.fname.mname.lname.key',moxie,overwrite);


////////////////////////////////////////////////////////////////////////////////////////////////
// -- Key #4
////////////////////////////////////////////////////////////////////////////////////////////////

MyFields normzip(t L, integer c) := TRANSFORM
	SELF.all_zip := choose(c,l.zip,l.mail_ace_zip);
	SELF.all_city := choose(c,l.city,l.mail_p_city_name);
	self.all_state := choose(c,l.addr_st,l.mail_st);
	SELF:= L;
END;

zipnorm := normalize(t, 2, normzip(LEFT,counter));

MyFields GetCityList1(zipnorm L) := TRANSFORM
	SELF.citylist := ZipLib.ZipToCities(L.all_zip);
	SELF:= L;
END;

ZipCitiesSet1 := PROJECT(zipnorm, GetCityList1(LEFT));

MyFields NormCityList1(MyFields L, INTEGER C) := TRANSFORM
	SELF.city_from_zip := IF ( C = 1, l.all_city, Stringlib.StringExtract(L.citylist, C ));
	SELF := L;
END;

ZipCitySet1 := NORMALIZE(ZipCitiesSet1, (INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst1(LEFT, COUNTER));
zcs_dist1 := distribute(ZipCitySet1(st != '' and city_from_zip != '' and st = all_state), hash(city_from_zip,st,lfmname,__filepos));
zcs_srtd1 := sort(zcs_dist1, city_from_zip, st, lfmname, __filepos, local);
City_d1 := DEDUP(zcs_srtd1, city_from_zip, st, lfmname, __filepos, local);


st_city_lfmname_records := table(City_d1,{st,city_from_zip,lfmname,(big_endian unsigned8 )__filepos});

k5 := BUILDINDEX(st_city_lfmname_records(st != '' and city_from_zip != ''),,emerges.base_key_name_emerges_vote + 'st.city.lfmname.key',
			moxie,overwrite);


////////////////////////////////////////////////////////////////////////////////////////////////
// -- Key #5
////////////////////////////////////////////////////////////////////////////////////////////////
st_city_dph_lname_rec := record
ZipCitySet1.st;
ZipCitySet1.city_from_zip;
ZipCitySet1.dph_lname;
ZipCitySet1.fname;
ZipCitySet1.mname;
ZipCitySet1.lname;
ZipCitySet1.__filepos;
end;

st_city_dph_lname_records := table(ZipCitySet1(st != '' and city_from_zip != '' and st = all_state),st_city_dph_lname_rec);

zcs_dist2 := distribute(st_city_dph_lname_records, hash(city_from_zip,st,dph_lname,fname,mname,lname,__filepos));
zcs_srtd2 := sort(zcs_dist2, city_from_zip,st,dph_lname,fname,mname,lname, __filepos, local);
City_d2 := DEDUP(zcs_srtd2, city_from_zip,st,dph_lname,fname,mname,lname, __filepos, local);

k6 := BUILDINDEX(City_d2(st != '' and city_from_zip != ''),,
			emerges.base_key_name_emerges_vote + 'st.city.dph_lname.fname.mname.lname.key',
			moxie,overwrite);

// -- Key #6
z5_lfmname_rec := record
t.z5;
t.lfmname;
t.__filepos;
end;

z5_lfmname_records := table(t,z5_lfmname_rec);

k7 := BUILDINDEX(z5_lfmname_records(z5 != '' and lfmname != ''),,emerges.base_key_name_emerges_vote + 'z5.lfmname.key',moxie,overwrite);

// -- Key #7
z5_dph_lname_rec := record
t.z5;
t.dph_lname;
t.fname;
t.mname;
t.lname;
t.__filepos;
end;

z5_dph_lname_records := table(t,z5_dph_lname_rec);

k8 := BUILDINDEX(z5_dph_lname_records(z5 != '' and dph_lname != ''),,
	emerges.base_key_name_emerges_vote + 'z5.dph_lname.fname.mname.lname.key',moxie,overwrite);

// -- Key #8
dob_lfmname_rec := record
t.dob;
t.lfmname;
t.__filepos;
end;

dob_lfmname_records := table(t,dob_lfmname_rec);

k9 := BUILDINDEX(dob_lfmname_records(dob != '' and lfmname != ''),,emerges.base_key_name_emerges_vote + 'dob.lfmname.key',moxie,overwrite);

// -- Key #9
dob_fmlname_rec := record
t.dob;
t.fmlname;
t.__filepos;
end;

dob_fmlname_records := table(t,dob_fmlname_rec);

k10 := BUILDINDEX(dob_fmlname_records(dob != '' and fmlname != ''),,emerges.base_key_name_emerges_vote + 'dob.fmlname.key',moxie,overwrite);

// -- Key #10
mfname_dob_rec := record
t.mfname;
t.dob;
t.__filepos;
end;

mfname_dob_records := table(t,mfname_dob_rec);

k11 := BUILDINDEX(mfname_dob_records(mfname != '' and dob != ''),,emerges.base_key_name_emerges_vote + 'mfname.dob.key',moxie,overwrite);

// -- Key #11
ssn_rec := record
t.ssn;
t.__filepos;
end;

ssn_records := table(t,ssn_rec);

k12 := BUILDINDEX(ssn_records(ssn != ''),,emerges.base_key_name_emerges_vote + 'ssn.key',moxie,overwrite);

// -- Key #12
state_type_lfmname_rec := record
t.state;
t.file_id;
t.lfmname;
t.__filepos;
end;

state_type_lfmname_records := table(t,state_type_lfmname_rec);

k13 := BUILDINDEX(state_type_lfmname_records(state != '' and file_id != ''),,emerges.base_key_name_emerges_vote + 'state.type.lfmname.key',
		moxie,overwrite);

// -- Key #13
did_rec := record
t.did;
t.__filepos;
end;

did_records := table(t,did_rec);

k14 := BUILDINDEX(did_records(did != ''),,emerges.base_key_name_emerges_vote + 'did.key',moxie,overwrite);


// -- Key #14
z5_address_rec := record
t.z5;
t.prim_name;
t.suffix;
t.predir;
t.postdir;
t.prim_range;
t.sec_range;
t.lfmname;
t.ssn;
t.__filepos;
end;

z5_address_rec Norm_z5_addr(MyFields L, integer C) := transform
	self.lfmname := L.lfmname;
	self.ssn := L.ssn;
	self.z5 := CHOOSE(C, L.zip, L.mail_ace_zip);
	self.prim_name := CHOOSE(C, L.prim_name, L.mail_prim_name);
	self.predir := CHOOSE(C, L.predir , L.mail_predir );
	self.postdir := CHOOSE(C, L.postdir , L.mail_postdir );
	self.prim_range := CHOOSE(C, L.prim_range , L.mail_prim_range );
	self.sec_range := CHOOSE(C, L.sec_range , L.mail_sec_range );
	self.suffix := CHOOSE(C, L.suffix , L.mail_addr_suffix );
	self.__filepos := L.__filepos;
end;

z5_address_records := NORMALIZE(t, 2,Norm_z5_addr(LEFT, COUNTER));

k15 := BUILDINDEX(z5_address_records(z5 != '' and prim_name != ''),,emerges.base_key_name_emerges_vote + 
			'z5.prim_name.suffix.predir.postdir.prim_range.sec_range.lfmname.ssn.key', moxie, overwrite);
k16 := BUILDINDEX(z5_address_records(z5 != '' and prim_name != ''),{z5,prim_name,suffix,predir,postdir,prim_range,sec_range,(big_endian unsigned8 )__filepos},emerges.base_key_name_emerges_vote + 
			'z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key', moxie, overwrite);

// -- Key #15
z5_address_lname_rec := record
t.z5;
string28 street_name;
t.predir;
t.postdir;
t.prim_range;
t.lname;
t.__filepos;
end;

z5_address_lname_rec Norm_z5_addr_lname(MyFields L, integer C) := transform
	self.z5 := CHOOSE(C, L.zip, L.mail_ace_zip);
	self.street_name := CHOOSE(C, L.prim_name, L.mail_prim_name);
	self.predir := CHOOSE(C, L.predir , L.mail_predir );
	self.postdir := CHOOSE(C, L.postdir , L.mail_postdir );
	self.prim_range := CHOOSE(C, L.prim_range , L.mail_prim_range );
	self.lname := L.lname;
	self.__filepos := L.__filepos;
end;

z5_address_lname_records := NORMALIZE(t, 2,Norm_z5_addr_lname(LEFT, COUNTER));

k17 := BUILDINDEX(z5_address_lname_records(z5 != '' and street_name != ''),,emerges.base_key_name_emerges_vote + 
			'z5.street_name.predir.postdir.prim_range.lname.key', moxie, overwrite);

/////////////////////////////////////////		
// Build Fpos key		
/////////////////////////////////////////		
unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(emerges.layout_voters_out) * count(h) : global;
headersize := sizeof(emerges.layout_voters_out) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},emerges.base_key_name_emerges_vote + 'fpos.data.key');

k18 := buildindex(dfile,moxie,overwrite);
			
			


export MOXIE_EMERGES_VOTERS_KEYS := sequential(parallel(k1,k2,k3,k4,k5,k6,k7,k8,k9),parallel(k10,k11,k12,k13,k14,k15,k16,k17,k18));