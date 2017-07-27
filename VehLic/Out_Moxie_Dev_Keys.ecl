import VehLic,Lib_KeyLib,lib_StringLib;

rMoxieFileForKeybuildLayout
 :=
  record
	VehLic.Layout_Vehreg_ToMike;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

#if(VehLic.BuildType = VehLic.BuildType_Accurint)
  h := dataset('~thor_data400::out::vehicles_moxie',rMoxieFileForKeybuildLayout,flat,__compressed__);
#end
#if(VehLic.BuildType = VehLic.BuildType_Matrix)
  h := dataset('~thor_200::out::matrix_vehicles_moxie',rMoxieFileForKeybuildLayout,flat,__compressed__);
#end

MyFields := record				// Fields needed to build all keys	
	h.orig_state;
	h.VEHICLE_NUMBERxBG1;
	h.ORIG_VIN;
	h.OWNER_1_CUSTOMER_TYPExBG3;
	h.OWN_1_CUSTOMER_NAME;
	h.OWN_1_DRIVER_LICENSE_NUMBER;
	h.OWNER_2_CUSTOMER_TYPE;
	h.OWN_2_CUSTOMER_NAME;
	h.OWN_2_DRIVER_LICENSE_NUMBER;
	h.LICENSE_PLATE_NUMBERxBG4;
	h.REG_1_CUSTOMER_NAME;
	h.REGISTRANT_1_CUSTOMER_TYPExBG5;
	h.REG_1_DRIVER_LICENSE_NUMBER;
	h.REGISTRANT_2_CUSTOMER_TYPE;
	h.REG_2_DRIVER_LICENSE_NUMBER;
	h.own_1_fname;
	h.own_1_mname;
	h.own_1_lname;
	h.own_1_name_suffix;
	h.own_1_did;
	h.own_1_bdid;
	h.own_1_ssn;
	h.own_1_company_name;
	h.own_1_prim_range;
	h.own_1_predir;
	h.own_1_prim_name;
	h.own_1_suffix;
	h.own_1_postdir;
	h.own_1_sec_range;
	h.own_1_p_city_name;
	h.own_1_state_2;
	h.own_1_zip5;
	h.own_2_fname;
	h.own_2_mname;
	h.own_2_lname;
	h.own_2_name_suffix;
	h.own_2_did;
	h.own_2_bdid;
	h.own_2_ssn;
	h.own_2_company_name;
	h.own_2_prim_range;
	h.own_2_predir;
	h.own_2_prim_name;
	h.own_2_suffix;
	h.own_2_postdir;
	h.own_2_sec_range;
	h.own_2_p_city_name;
	h.own_2_state_2;
	h.own_2_zip5;
	h.reg_1_fname;
	h.reg_1_mname;
	h.reg_1_lname;
	h.reg_1_name_suffix;
	h.reg_1_did;
	h.reg_1_bdid;
	h.reg_1_ssn;
	h.reg_1_company_name;
	h.reg_1_prim_range;
	h.reg_1_predir;
	h.reg_1_prim_name;
	h.reg_1_suffix;
	h.reg_1_postdir;
	h.reg_1_sec_range;
	h.reg_1_p_city_name;
	h.reg_1_state_2;
	h.reg_1_zip5;
	h.reg_2_fname;
	h.reg_2_mname;
	h.reg_2_lname;
	h.reg_2_name_suffix;
	h.reg_2_did;
	h.reg_2_bdid;
	h.reg_2_ssn;
	h.reg_2_company_name;
	h.reg_2_prim_range;
	h.reg_2_predir;
	h.reg_2_prim_name;
	h.reg_2_suffix;
	h.reg_2_postdir;
	h.reg_2_sec_range;
	h.reg_2_p_city_name;
	h.reg_2_state_2;
	h.reg_2_zip5;
	string10 reverse_lic_plate := lib_StringLib.StringLib.StringReverse(trim(h.LICENSE_PLATE_NUMBERxBG4));
	string60 lfmname1 := TRIM(h.own_1_lname,right) + ' ' + IF(TRIM(h.own_1_fname,right) = '', ' ',
						 TRIM(h.own_1_fname,right) + ' ') + TRIM(h.own_1_mname,right);
	string60 lfmname2 := TRIM(h.own_2_lname,right) + ' ' + IF(TRIM(h.own_2_fname,right) = '', ' ',
						 TRIM(h.own_2_fname,right) + ' ') + TRIM(h.own_2_mname,right);
	string60 lfmname3 := TRIM(h.reg_1_lname,right) + ' ' + IF(TRIM(h.reg_1_fname,right) = '', ' ',
						 TRIM(h.reg_1_fname,right) + ' ') + TRIM(h.reg_1_mname,right);
	string60 lfmname4 := TRIM(h.reg_2_lname,right) + ' ' + IF(TRIM(h.reg_2_fname,right) = '', ' ',
						 TRIM(h.reg_2_fname,right) + ' ') + TRIM(h.reg_2_mname,right);
	string60 company1 := Lib_KeyLib.KeyLib.CompNameNoSyn(h.own_1_company_name);
	string60 company2 := Lib_KeyLib.KeyLib.CompNameNoSyn(h.own_2_company_name);
	string60 company3 := Lib_KeyLib.KeyLib.CompNameNoSyn(h.reg_1_company_name);
	string60 company4 := Lib_KeyLib.KeyLib.CompNameNoSyn(h.reg_2_company_name);
	string61 nameasis1 := IF(h.OWNER_1_CUSTOMER_TYPExBG3 = 'B', Lib_KeyLib.KeyLib.CompNameNoSyn(h.OWN_1_CUSTOMER_NAME), 
							 Lib_KeyLib.KeyLib.KeylibStripPunctuation(h.OWN_1_CUSTOMER_NAME));	
	string61 nameasis2 := IF(h.OWNER_2_CUSTOMER_TYPE = 'B', Lib_KeyLib.KeyLib.CompNameNoSyn(h.OWN_2_CUSTOMER_NAME), 
							 Lib_KeyLib.KeyLib.KeylibStripPunctuation(h.OWN_2_CUSTOMER_NAME));	
	string61 nameasis3 := IF(h.REGISTRANT_1_CUSTOMER_TYPExBG5 = 'B', Lib_KeyLib.KeyLib.CompNameNoSyn(h.REG_1_CUSTOMER_NAME), 
							 Lib_KeyLib.KeyLib.KeylibStripPunctuation(h.REG_1_CUSTOMER_NAME));	
	string61 nameasis4 := IF(h.REGISTRANT_2_CUSTOMER_TYPE = 'B', Lib_KeyLib.KeyLib.CompNameNoSyn(h.REG_2_CUSTOMER_NAME), 
							 Lib_KeyLib.KeyLib.KeylibStripPunctuation(h.REG_2_CUSTOMER_NAME));	
	h.__filepos;
end;

t := table(h,MyFields);

// Simple keys. One key entry per record.
did_rec := record
	t.orig_state;
	t.VEHICLE_NUMBERxBG1;
	t.LICENSE_PLATE_NUMBERxBG4;
	t.ORIG_VIN;
	t.__filepos;
end;

lic_rec := record
	t.reverse_lic_plate;
	t.orig_state;
	t.__filepos;
end;

did_records := table(t,did_rec);
lic_records := table(t(reverse_lic_plate<>''),lic_rec);

k01	:= BUILDINDEX(	did_records,{orig_state,VEHICLE_NUMBERxBG1,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'state_origin.vehicle_number.key_' + vehlic.version_development,moxie,overwrite);
k02	:= BUILDINDEX(	did_records,{VEHICLE_NUMBERxBG1,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'vehicle_number.key_' + vehlic.version_development,moxie,overwrite);
k03	:= BUILDINDEX(	did_records,{LICENSE_PLATE_NUMBERxBG4,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'lic_plate.key_' + vehlic.version_development,moxie,overwrite);
k04	:= BUILDINDEX(	did_records,{orig_state,LICENSE_PLATE_NUMBERxBG4,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'state_origin.lic_plate.key_' + vehlic.version_development,moxie,overwrite);
k05	:= BUILDINDEX(	did_records,{ORIG_VIN,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'vin.key_' + vehlic.version_development,moxie,overwrite);
k06	:= BUILDINDEX(	lic_records,{reverse_lic_plate,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'reverse_lic_plate.key_' + vehlic.version_development,moxie,overwrite);
k07	:= BUILDINDEX(	lic_records,{orig_state,reverse_lic_plate,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'state_origin.reverse_lic_plate.key_' + vehlic.version_development,moxie,overwrite);

// Simple keys, but 4 entries per record.
ssn_rec := record
	string9 ssn :='';
	string12 did :='';
	string12 bdid :='';
	string13 dl_number :='';
	t.__filepos;
end;

ssn_rec use_ssn(MyFields l, unsigned1 cnt) := TRANSFORM
  self.ssn := choose(cnt, l.own_1_ssn, l.own_2_ssn, l.reg_1_ssn, l.reg_2_ssn);
  self.did := choose(cnt, l.own_1_did, l.own_2_did, l.reg_1_did, l.reg_2_did);
  self.bdid := choose(cnt, l.own_1_bdid, l.own_2_bdid, l.reg_1_bdid, l.reg_2_bdid);
  self.dl_number := choose(cnt, l.OWN_1_DRIVER_LICENSE_NUMBER, l.OWN_2_DRIVER_LICENSE_NUMBER,
								l.REG_1_DRIVER_LICENSE_NUMBER, l.REG_2_DRIVER_LICENSE_NUMBER);
  self := l;
end;


n := NORMALIZE(t,4,use_ssn(left,counter));
ssn_duped := DEDUP(n((integer)ssn<>0),ssn,__filepos,all);
did_duped := DEDUP(n(did<>''),did,__filepos,all);
bdid_duped := DEDUP(n(bdid<>''),bdid,__filepos,all);
dl_duped := DEDUP(n(dl_number<>''),dl_number,__filepos,all);

k08	:= BUILDINDEX(	ssn_duped,{ssn,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'ssn.key_' + vehlic.version_development,moxie,overwrite);
k09	:= BUILDINDEX(	did_duped,{did,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'did.key_' + vehlic.version_development,moxie,overwrite);
k26	:= BUILDINDEX(	bdid_duped,{bdid,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'bdid.key_' + vehlic.version_development,moxie,overwrite);
k10	:= BUILDINDEX(	dl_duped,{dl_number,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'dl_number.key_' + vehlic.version_development,moxie,overwrite);

// lfmname keys. These are little different than Unix keys.
// I don't build keys, if any part is blank.
lfmname_rec := record
	// lfmname key is 60 long here because the old Moxie keys used to be. No other reason.
	string5 z5 := '';
	string60 lfmname  :='';
	string2 st :='';
	string25 city :='';
	varstring		ZipToCityList :='';
	t.__filepos;
end;

lfmname_rec use_lfmname(MyFields l, unsigned1 cnt) := TRANSFORM
	self.z5 := choose(cnt, l.own_1_zip5, l.own_2_zip5, l.reg_1_zip5, l.reg_2_zip5,
						   l.own_1_zip5, l.own_2_zip5, l.reg_1_zip5, l.reg_2_zip5);
	self.lfmname := choose(cnt, l.lfmname1, l.lfmname2, l.lfmname3, l.lfmname4, 
								l.company1, l.company2, l.company3, l.company4);
	self.st := choose(cnt, l.own_1_state_2, l.own_2_state_2, l.reg_1_state_2, l.reg_2_state_2,
						   l.own_1_state_2, l.own_2_state_2, l.reg_1_state_2, l.reg_2_state_2);
	self.city := choose(cnt, l.own_1_p_city_name,l.own_2_p_city_name,l.reg_1_p_city_name,l.reg_2_p_city_name,
							 l.own_1_p_city_name,l.own_2_p_city_name,l.reg_1_p_city_name,l.reg_2_p_city_name);
    self.ZipToCityList := ZipLib.ZipToCities(self.z5);
	self := l;
end;

lfmname_n := NORMALIZE(t,8,use_lfmname(left,counter));
lfmname_duped := DEDUP(lfmname_n(lfmname<>''),lfmname,__filepos,all);
lfmname_st_duped := DEDUP(lfmname_n(lfmname<>'' AND (st<>'')),st,lfmname,__filepos,all);

k11	:= BUILDINDEX(	lfmname_duped,{lfmname,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'lfmname.key_' + vehlic.version_development,moxie,overwrite);
k12	:= BUILDINDEX(	lfmname_st_duped,{st,lfmname,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'st.lfmname.key_' + vehlic.version_development,moxie,overwrite);

lfmname_rec2 := record
	// lfmname key is 60 long here because the old Moxie keys used to be. No other reason.
	string5 z5 := '';
	string60 lfmname  :='';
	string2 st :='';
	string25 city :='';
	t.__filepos;
end;

lfmname_rec2 tNormalize_lfmname_Cities(lfmname_rec pInput,integer pCounter)
 :=
  transform
	self.city	:= if(pCounter=1,pInput.City,stringlib.stringextract(pInput.ZipToCityList,pCounter));
	self		:= pInput;
  end
 ;
 
lfmname_st_city_duped 		:= DEDUP(lfmname_n(lfmname<>'' AND (st<>'') AND (city<>'')),st,city,lfmname,__filepos,all);
lfmname_st_city_NormCity	:= normalize(lfmname_st_city_duped,
										 (integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
										 tNormalize_lfmname_Cities(left,counter)
										);
lfmname_st_city_duped_NormCityDist		:= distribute(lfmname_st_city_NormCity,hash(st,city,lfmname,__filepos));
lfmname_st_city_duped_NormCitySort		:= sort(lfmname_st_city_duped_NormCityDist,st,city,lfmname,__filepos, local);
lfmname_st_city_duped_NormCityDeDup		:= dedup(lfmname_st_city_duped_NormCitySort,st,city,lfmname,__filepos,local);

k20 := BUILDINDEX(lfmname_st_city_duped_NormCityDeDup,{st,city,lfmname,(big_endian unsigned8 )__filepos},
					VehLic.base_key_name + 'st.city.lfmname.key_' + vehlic.version_development,moxie,overwrite);

// Nameasis keys. Very similar than 'lfmname' keys
nameasis_rec := record
	// nameasis keys is 61 long, because old Moxie keys used to be.
	string5 z5 := '';
	string61 nameasis := '';
	string10 cn := '';
	string80 cn_source := '';
	string2	 st := '';
	string25 city := '';
	varstring		ZipToCityList :='';
	t.__filepos;
end;

nameasis_rec use_nameasis(MyFields l, unsigned1 cnt) := TRANSFORM
	self.z5 := choose(cnt, l.own_1_zip5, l.own_2_zip5, l.reg_1_zip5, l.reg_2_zip5);
	self.nameasis := choose(cnt, l.nameasis1, l.nameasis2, l.nameasis3, l.nameasis4);
	self.st := choose(cnt, l.own_1_state_2, l.own_2_state_2, l.reg_1_state_2, l.reg_2_state_2);
	self.city := choose(cnt, l.own_1_p_city_name,l.own_2_p_city_name,l.reg_1_p_city_name,l.reg_2_p_city_name);
	self.cn_source := Lib_KeyLib.KeyLib.GongDacName(self.nameasis);
	self.cn := '';
	self := l;
end;

nameasis_n := NORMALIZE(t,4,use_nameasis(left,counter));
nameasis_duped := DEDUP(nameasis_n(nameasis<>''),nameasis,__filepos,all);
nameasis_st_duped := DEDUP(nameasis_n(nameasis<>'' AND (st<>'')),st,nameasis,__filepos,all);

k13	:= BUILDINDEX(	nameasis_duped,{nameasis,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'nameasis.key_' + vehlic.version_development,moxie,overwrite);
k14	:= BUILDINDEX(	nameasis_st_duped,{st,nameasis,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'st.nameasis.key_' + vehlic.version_development,moxie,overwrite);

nameasis_rec tcn_from_cn_source1(nameasis_rec pInput, unsigned1 pCounter)
 :=
  transform
	self.cn	:= choose(pCounter,
					  pInput.cn_source[01..10],
					  pInput.cn_source[11..20],
					  pInput.cn_source[21..30],
					  pInput.cn_source[31..40],
					  pInput.cn_source[41..50],
					  pInput.cn_source[51..60],
					  pInput.cn_source[61..70],
					  pInput.cn_source[71..80]
					 );
	self	:= pInput;
  end
 ;

cn_from_nameasis1			:= normalize(nameasis_duped,8,tcn_from_cn_source1(left,counter));
cn_from_nameasis1_dedup 	:= dedup(cn_from_nameasis1(cn<>''),cn,__filepos,all);
cn_st_from_nameasis1		:= normalize(nameasis_st_duped,8,tcn_from_cn_source1(left,counter));
cn_st_from_nameasis1_dedup	:= dedup(cn_st_from_nameasis1(cn<>''),st,cn,__filepos,all);

k23 := buildindex(	cn_from_nameasis1_dedup,{cn,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'cn.key_' + vehlic.version_development,moxie,overwrite);
k24 := buildindex(	cn_st_from_nameasis1_dedup,{st,cn,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'st.cn.key_' + vehlic.version_development,moxie,overwrite);

nameasis_rec2 := record
	// nameasis keys is 61 long, because old Moxie keys used to be.
	string5 z5 := '';
	string61 nameasis := '';
	string10 cn := '';
	string80 cn_source := '';
	string2	 st := '';
	string25 city := '';
	t.__filepos;
end;

nameasis_rec2 tNormalize_nameasis_Cities(nameasis_rec pInput,integer pCounter)
 :=
  transform
	self.city		:= if(pCounter=1,pInput.City,stringlib.stringextract(pInput.ZipToCityList,pCounter));
	self		:= pInput;
  end
 ;
 
nameasis_st_city_duped 			:= DEDUP(nameasis_n(nameasis<>'' AND (st<>'') AND (city<>'')),st,city,nameasis,__filepos,all);
nameasis_duped_NormCity			:= normalize(nameasis_st_city_duped,
										 (integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
										 tNormalize_nameasis_Cities(left,counter)
										);
nameasis_duped_NormCityDist		:= distribute(nameasis_duped_NormCity,hash(st,city,nameasis,__filepos));
nameasis_duped_NormCitySort		:= sort(nameasis_duped_NormCityDist,st,city,nameasis,__filepos, local);
nameasis_duped_NormCityDeDup	:= dedup(nameasis_duped_NormCitySort,st,city,nameasis,__filepos,local);

k21 := BUILDINDEX(nameasis_duped_NormCityDeDup,{st,city,nameasis,(big_endian unsigned8 )__filepos},
					VehLic.base_key_name + 'st.city.nameasis.key_' + vehlic.version_development,moxie,overwrite);

nameasis_rec2 tcn_from_cn_source2(nameasis_rec2 pInput, unsigned1 pCounter)
 :=
  transform
	self.cn	:= choose(pCounter,
					  pInput.cn_source[01..10],
					  pInput.cn_source[11..20],
					  pInput.cn_source[21..30],
					  pInput.cn_source[31..40],
					  pInput.cn_source[41..50],
					  pInput.cn_source[51..60],
					  pInput.cn_source[61..70],
					  pInput.cn_source[71..80]
					 );
	self	:= pInput;
  end
 ;

cn_st_city_from_nameasis		:= normalize(nameasis_duped_NormCityDeDup,8,tcn_from_cn_source2(left,counter));
cn_st_city_from_nameasis_dedup	:= dedup(cn_st_city_from_nameasis(cn<>''),st,city,cn,__filepos,all);

k25 := BUILDINDEX(cn_st_city_from_nameasis_dedup,{st,city,cn,(big_endian unsigned8 )__filepos},
					VehLic.base_key_name + 'st.city.cn.key_' + vehlic.version_development,moxie,overwrite);

// 2 Address keys
address_rec := record
	string5 z5 := '';
	string28 street_name := '';
	string4 suffix := '';
	string2 predir :='';
	string2 postdir :='';
	string10 prim_range :='';
	string8 sec_range :='';
	t.__filepos;
end;

address_rec use_address(MyFields l, unsigned1 cnt) := TRANSFORM
	self.z5 := choose(cnt, l.own_1_zip5,l.own_2_zip5,l.reg_1_zip5,l.reg_2_zip5);
	self.street_name := choose(cnt, l.own_1_prim_name, l.own_2_prim_name, l.reg_1_prim_name, l.reg_2_prim_name);
	self.suffix := choose(cnt, l.own_1_suffix, l.own_2_suffix, l.reg_1_suffix, l.reg_2_suffix);
	self.predir := choose(cnt, l.own_1_predir, l.own_2_predir, l.reg_1_predir, l.reg_2_predir);
	self.postdir := choose(cnt, l.own_1_postdir, l.own_2_postdir, l.reg_1_postdir, l.reg_2_postdir);
	self.prim_range := choose(cnt, l.own_1_prim_range, l.own_2_prim_range, l.reg_1_prim_range, l.reg_2_prim_range);
	self.sec_range := choose(cnt, l.own_1_sec_range, l.own_2_sec_range, l.reg_1_sec_range, l.reg_2_sec_range);
	self := l;
end;

address_n := NORMALIZE(t,4,use_address(left,counter));
address_duped := DEDUP(address_n(z5<>''),z5,street_name,suffix,predir,postdir,prim_range,sec_range,__filepos,all);

k15	:= BUILDINDEX(	address_duped,{z5,street_name,suffix,predir,postdir,prim_range,sec_range,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'z5.street_name.suffix.predir.postdir.prim_range.sec_range.key_' + vehlic.version_development,moxie,overwrite);
k16	:= BUILDINDEX(	address_duped,{z5,street_name,prim_range,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'z5.prim_name.prim_range.key_' + vehlic.version_development,moxie,overwrite);

// This part needs some optimizing.
// Add dedupe after the first Normalize.
ph_rec := record
	string5 z5;
	string2 st;
	string25 city;
	string20 lname;
	string20 fname;
	string20 mname;
	string6 dph_lname1 := '';
    string6 dph_lname2 := '';
	t.__filepos;
end;
	
ph_rec use_ph(MyFields l, unsigned1 cnt) := TRANSFORM
	self.z5 := choose(cnt, l.own_1_zip5,l.own_2_zip5,l.reg_1_zip5,l.reg_2_zip5);
	self.st := choose(cnt, l.own_1_state_2, l.own_2_state_2, l.reg_1_state_2, l.reg_2_state_2);
	self.city := choose(cnt, l.own_1_p_city_name,l.own_2_p_city_name,l.reg_1_p_city_name,l.reg_2_p_city_name);
	self.lname := choose(cnt, l.own_1_lname,l.own_2_lname,l.reg_1_lname,l.reg_2_lname);
	self.fname := choose(cnt, l.own_1_fname,l.own_2_fname,l.reg_1_fname,l.reg_2_fname);
	self.mname := choose(cnt, l.own_1_mname,l.own_2_mname,l.reg_1_mname,l.reg_2_mname);
	self.dph_lname1 := metaphonelib.DMetaPhone1(self.lname);
	self.dph_lname2 := metaphonelib.DMetaPhone2(self.lname);
	self := l;
end;

ph_n := NORMALIZE(t,4,use_ph(left,counter));

ph_rec2 := record
	ph_n.z5;
	ph_n.st;
	ph_n.city;
	varstring		ZipToCityList := ZipLib.ZipToCities(ph_n.z5);
	ph_n.lname;
	ph_n.fname;
	ph_n.mname;
	string6 ph_lname :='';
	t.__filepos;
end;

ph_rec2 use_ph2(ph_n l, unsigned1 cnt) := TRANSFORM
	self.ph_lname := choose(cnt, l.dph_lname1, l.dph_lname2);
	self.ZipToCityList := ZipLib.ZipToCities(l.z5);
	self := l;
end;

ph_n2 := NORMALIZE(ph_n,2,use_ph2(left,counter));
ph_duped := DEDUP(ph_n2(ph_lname<>''),z5,st,city,lname,fname,mname,ph_lname,__filepos,all);

k17	:= BUILDINDEX( ph_duped,{z5,ph_lname,fname,mname,lname,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'zip.dph_lname.fname.mname.lname.key_' + vehlic.version_development,moxie,overwrite);
k18	:= BUILDINDEX( ph_duped,{st,ph_lname,fname,mname,lname,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'st.dph_lname.fname.mname.lname.key_' + vehlic.version_development,moxie,overwrite);
k19	:= BUILDINDEX( ph_duped,{ph_lname,fname,mname,lname,(big_endian unsigned8 )__filepos},
			VehLic.base_key_name + 'dph_lname.fname.mname.lname.key_' + vehlic.version_development,moxie,overwrite);

ph_rec3 := record
	ph_n.z5;
	ph_n.st;
	ph_n.city;
	ph_n.lname;
	ph_n.fname;
	ph_n.mname;
	string6 ph_lname :='';
	t.__filepos;
end;

ph_rec3 tNormalize_ph_duped_Cities(ph_rec2 pInput,integer pCounter)
 :=
  transform
	self.city	:= if(pCounter=1,pInput.City,stringlib.stringextract(pInput.ZipToCityList,pCounter));
	self		:= pInput;
  end
 ;
 
dph_duped_NormCity			:= normalize(ph_duped,
										 (integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
										 tNormalize_ph_duped_Cities(left,counter)
										);
dph_duped_NormCityDist		:= distribute(dph_duped_NormCity,hash(st,city,ph_lname,fname,mname,lname,__filepos));
dph_duped_NormCitySort		:= sort(dph_duped_NormCityDist,st,city,ph_lname,fname,mname,lname,__filepos, local);
dph_duped_NormCityDeDup		:= dedup(dph_duped_NormCitySort,st,city,ph_lname,fname,mname,lname,__filepos,local);

k22 := BUILDINDEX(dph_duped_NormCityDeDup,{st,city,ph_lname,fname,mname,lname,(big_endian unsigned8 )__filepos},
					VehLic.base_key_name + 'st.city.dph_lname.fname.mname.lname.key_' + vehlic.version_development,moxie,overwrite);

/*Cannot do this as part of job because size of file must be calculated...  oh, well...
//begin fpos.data.key
unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(vehlic.Layout_Vehreg_ToMike) * count(h) : global;
headersize := sizeof(vehlic.Layout_Vehreg_ToMike) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},'key::moxie.vehicles.fpos.data.key');
k23 := buildindex(dfile,moxie,overwrite);
//end fpos.data.key
*/
export Out_Moxie_Dev_Keys
 := 
  parallel
   (
	k01,
	k02,
	k03,
	k04,
	k05,
	k06,
	k07,
	k08,
	k09,
	k10,
	k11,
	k12,
	k13,
	k14,
	k15,
	k16,
	k17,
	k18,
	k19,
	k20,
	k21,
	k22,
	k23,
	k24,
	k25,
	K26
   )
 ;