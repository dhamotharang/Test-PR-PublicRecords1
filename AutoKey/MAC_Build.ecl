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

ut.MAC_SK_BuildProcess_v2(%Address_Key%, inkeyname+'Address', %do_one%, ,diffing)
ut.MAC_SK_BuildProcess_v2(%CityStName_Key%, inkeyname+'CityStName', %do_two%, ,diffing)
ut.MAC_SK_BuildProcess_v2(%Name_Key%, inkeyname+'Name', %do_three%, ,diffing)
ut.MAC_SK_BuildProcess_v2(%Phone_Key%, inkeyname+'Phone', %do_four%, ,diffing)
ut.MAC_SK_BuildProcess_v2(%SSN_Key%, inkeyname+'SSN', %do_five%, ,diffing)
ut.MAC_SK_BuildProcess_v2(%StName_Key%,inkeyname+'StName', %do_six%, ,diffing)
ut.MAC_SK_BuildProcess_v2(%Zip_Key%,inkeyname+'Zip', %do_seven%, ,diffing)

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

						