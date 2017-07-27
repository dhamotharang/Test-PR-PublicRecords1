export AutoKey_Gen (indata, infiletype, infieldset, 
				fname_field, mname_field, lname_field, ssn_field, phone_field,
				prim_name_field, prim_range_field, sec_range_field, city_field,
				state_field, zip_field,
				dob_field, id_field, executer) :=
MACRO


doxie_build.AutoKey_Layout xpand(indata le) :=
TRANSFORM
	SELF.zip := (string5)le.zip_field;
	SELF.prim_name := le.prim_name_field;
	SELF.prim_range := le.prim_range_field;
	SELF.city := le.city_field;
	SELF.city_code := hash(SELF.city);
	SELF.state := le.state_field;
	SELF.lname := le.lname_field;
	SELF.dph_lname := metaphonelib.DMetaPhone1(SELF.lname);
	SELF.mname := le.mname_field;
	SELF.minit := SELF.mname[1];
	SELF.fname := le.fname_field;
	SELF.pfname := datalib.preferredfirst(SELF.fname);
#if('S' IN infieldset)
	SELF.ssn := (string9)le.ssn_field;
	SELF.s4 := (unsigned2)(SELF.ssn[6..9]);
#end
#if('P' IN infieldset)
	SELF.phone10 := le.phone_field;
#end
#if('D' IN infieldset)
	SELF.dob := (unsigned4)le.dob_field;
	unsigned2 yob := (unsigned)SELF.dob div 10000;
#end
	SELF.sec_range := le.sec_range_field;
	SELF.id := (STRING)le.id_field;
END;
proj := PROJECT(indata, xpand(LEFT));

doxie_build.AutoKeys(proj, infiletype, ssn_key, phone_key, addr_key, stfl_key, city_key)

ssn_build := sequential( buildindex(ssn_key,'~thor_data400::key::auto'+infiletype+'_ssn'+thorlib.WUID()),
					FileServices.StartSuperFileTransaction(),
						FileServices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_ssn_Delete', '~thor_data400::key::auto'+infiletype+'_ssn_Father',,true),
						FileServices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_ssn_Father', '~thor_data400::key::auto'+infiletype+'_ssn_QA',, true),
						FileServices.ClearSuperFile('~thor_data400::key::auto'+infiletype+'_ssn_QA'),					
						fileservices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_ssn_QA','~thor_data400::key::auto'+infiletype+'_ssn'+thorlib.WUID()),
					FileServices.FinishSuperFileTransaction(),
					FileServices.ClearSuperFile('~thor_data400::key::auto'+infiletype+'_ssn_Delete',true));					
					
phone_build := sequential( buildindex(phone_key,'~thor_data400::key::auto'+infiletype+'_phone'+thorlib.WUID()),
					FileServices.StartSuperFileTransaction(),
						FileServices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_phone_Delete', '~thor_data400::key::auto'+infiletype+'_phone_Father',,true),
						FileServices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_phone_Father', '~thor_data400::key::auto'+infiletype+'_phone_QA',, true),
						FileServices.ClearSuperFile('~thor_data400::key::auto'+infiletype+'_phone_QA'),					
						fileservices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_phone_QA','~thor_data400::key::auto'+infiletype+'_phone'+thorlib.WUID()),
					FileServices.FinishSuperFileTransaction(),
					FileServices.ClearSuperFile('~thor_data400::key::auto'+infiletype+'_phone_Delete',true));
					
addr_build := sequential( buildindex(addr_key,'~thor_data400::key::auto'+infiletype+'_addr'+thorlib.WUID()),
					FileServices.StartSuperFileTransaction(),
						FileServices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_addr_Delete', '~thor_data400::key::auto'+infiletype+'_addr_Father',,true),
						FileServices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_addr_Father', '~thor_data400::key::auto'+infiletype+'_addr_QA',, true),
						FileServices.ClearSuperFile('~thor_data400::key::auto'+infiletype+'_addr_QA'),					
						fileservices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_addr_QA','~thor_data400::key::auto'+infiletype+'_addr'+thorlib.WUID()),
					FileServices.FinishSuperFileTransaction(),
					FileServices.ClearSuperFile('~thor_data400::key::auto'+infiletype+'_addr_Delete',true));
					
stfl_build := sequential( buildindex(stfl_key,'~thor_data400::key::auto'+infiletype+'_stfl'+thorlib.WUID()),
					FileServices.StartSuperFileTransaction(),
						FileServices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_stfl_Delete', '~thor_data400::key::auto'+infiletype+'_stfl_Father',,true),
						FileServices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_stfl_Father', '~thor_data400::key::auto'+infiletype+'_stfl_QA',, true),
						FileServices.ClearSuperFile('~thor_data400::key::auto'+infiletype+'_stfl_QA'),					
						fileservices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_stfl_QA','~thor_data400::key::auto'+infiletype+'_stfl'+thorlib.WUID()),
					FileServices.FinishSuperFileTransaction(),
					FileServices.ClearSuperFile('~thor_data400::key::auto'+infiletype+'_stfl_Delete',true));
					
city_build := sequential( buildindex(city_key,'~thor_data400::key::auto'+infiletype+'_city'+thorlib.WUID()),
					FileServices.StartSuperFileTransaction(),
						FileServices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_city_Delete', '~thor_data400::key::auto'+infiletype+'_city_Father',,true),
						FileServices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_city_Father', '~thor_data400::key::auto'+infiletype+'_city_QA',, true),
						FileServices.ClearSuperFile('~thor_data400::key::auto'+infiletype+'_city_QA'),					
						fileservices.AddSuperFile('~thor_data400::key::auto'+infiletype+'_city_QA','~thor_data400::key::auto'+infiletype+'_city'+thorlib.WUID()),
					FileServices.FinishSuperFileTransaction(),
					FileServices.ClearSuperFile('~thor_data400::key::auto'+infiletype+'_city_Delete',true));

executer := parallel(
				 ssn_build,
				 phone_build,
				 addr_build,
				 stfl_build,
				 city_build);

ENDMACRO;