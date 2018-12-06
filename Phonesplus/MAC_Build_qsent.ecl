export MAC_Build_qsent (indataset, pversion, infname,inmname,inlname,
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

import standard;

#uniquename(x)
#uniquename(Address_Key)
#uniquename(CityStName_Key)
#uniquename(Name_Key)
#uniquename(Phone_Key)
#uniquename(Phone_Key2)
#uniquename(SSN_Key)
#uniquename(SSN_Key2)
#uniquename(StName_Key)
#uniquename(Zip_Key)
#uniquename(ZipPRLname_Key)

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
					%Address_Key%,%CityStName_Key%,%Name_Key%,%Phone_Key%,%Phone_Key2%,%SSN_Key%,%SSN_Key2%,%StName_Key%,%Zip_Key%,%ZipPRLname_Key%
					,4,true,0,Phonesplus_v2)

Cellphone.MAC_SK_BuildProcess_v2(%Address_Key%, '~thor_data400::key::qsent::' + pversion + '::address',
						  '~thor_data400::key::qsent_address', %do_one%, ,diffing)
Cellphone.MAC_SK_BuildProcess_v2(%CityStName_Key%, '~thor_data400::key::qsent::' + pversion + '::citystname',
						  '~thor_data400::key::qsent_citystname', %do_two%, ,diffing)
Cellphone.MAC_SK_BuildProcess_v2(%Name_Key%, '~thor_data400::key::qsent::' + pversion + '::name',
						  '~thor_data400::key::qsent_name', %do_three%, ,diffing)
Cellphone.MAC_SK_BuildProcess_v2(%Phone_Key%, '~thor_data400::key::qsent::' + pversion + '::phone',
						  '~thor_data400::key::qsent_phone', %do_four%, ,diffing)
Cellphone.MAC_SK_BuildProcess_v2(%SSN_Key%, '~thor_data400::key::qsent::' + pversion + '::ssn',
						  '~thor_data400::key::qsent_ssn', %do_five%, ,diffing)
Cellphone.MAC_SK_BuildProcess_v2(%StName_Key%,'~thor_data400::key::qsent::' + pversion + '::stname',
						  '~thor_data400::key::qsent_stname', %do_six%, ,diffing)
Cellphone.MAC_SK_BuildProcess_v2(%Zip_Key%,'~thor_data400::key::qsent::' + pversion + '::zip',
						  '~thor_data400::key::qsent_zip', %do_seven%, ,diffing)

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

						