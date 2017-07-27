export MAC_Build (indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,outaction,diffing='false',
						build_skip_set='[]') :=
MACRO

#uniquename(x)
#uniquename(Address_Key)
#uniquename(CityStName_Key)
#uniquename(Name_Key)
#uniquename(Phone_Key)
#uniquename(SSN_Key)
#uniquename(StName_Key)
#uniquename(Zip_Key)

#uniquename(do_one)
#uniquename(do_two)
#uniquename(do_three)
#uniquename(do_four)
#uniquename(do_five)
#uniquename(do_six)
#uniquename(do_seven)

%x% := 1;

AutoKey.Keys  (indataset,infname,inmname,inlname,
					inssn,
					indob,
					phone,
					inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
					instates,
					inlname1,inlname2,inlname3,
					incity1,incity2,incity3,
					inrel_fname1,inrel_fname2,inrel_fname3,
					inlookups,
					indid,
					inkeyname,
					%Address_Key%,%CityStName_Key%,%Name_Key%,%Phone_Key%,%SSN_Key%,%StName_Key%,%Zip_Key%)

Cellphone.MAC_SK_BuildProcess_v2(%Address_Key%, '~thor_data400::key::phonesplus::' + Phonesplus.version + '::address',
						  '~thor_data400::key::phonesplus_address', %do_one%, ,diffing)
Cellphone.MAC_SK_BuildProcess_v2(%CityStName_Key%, '~thor_data400::key::phonesplus::' + Phonesplus.version + '::citystname',
						  '~thor_data400::key::phonesplus_citystname', %do_two%, ,diffing)
Cellphone.MAC_SK_BuildProcess_v2(%Name_Key%, '~thor_data400::key::phonesplus::' + Phonesplus.version + '::name',
						  '~thor_data400::key::phonesplus_name', %do_three%, ,diffing)
Cellphone.MAC_SK_BuildProcess_v2(%Phone_Key%, '~thor_data400::key::phonesplus::' + Phonesplus.version + '::phone',
						  '~thor_data400::key::phonesplus_phone', %do_four%, ,diffing)
Cellphone.MAC_SK_BuildProcess_v2(%SSN_Key%, '~thor_data400::key::phonesplus::' + Phonesplus.version + '::ssn',
						  '~thor_data400::key::phonesplus_ssn', %do_five%, ,diffing)
Cellphone.MAC_SK_BuildProcess_v2(%StName_Key%,'~thor_data400::key::phonesplus::' + Phonesplus.version + '::stname',
						  '~thor_data400::key::phonesplus_stname', %do_six%, ,diffing)
Cellphone.MAC_SK_BuildProcess_v2(%Zip_Key%,'~thor_data400::key::phonesplus::' + Phonesplus.version + '::zip',
						  '~thor_data400::key::phonesplus_zip', %do_seven%, ,diffing)

outaction := PARALLEL(%do_one%,
                      %do_two%,
				  %do_three%,
				  if('P' in build_skip_set, 
				     output('AUTOKEY BUILD: Phone key skipped'),
				     %do_four%),
				  if('S' in build_skip_set,
				     output('AUTOKEY BUILD: SSN key skipped'),
				     %do_five%),
				  %do_six%,
				  %do_seven%);

ENDMACRO;

						