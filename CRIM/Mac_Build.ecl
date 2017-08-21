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
						inkeyname,filedate,outaction,diffing='false',
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

#uniquename(ddo_one)
#uniquename(ddo_two)
#uniquename(ddo_three)
#uniquename(ddo_four)
#uniquename(ddo_five)
#uniquename(ddo_six)
#uniquename(ddo_seven)

#uniquename(bdo_one)
#uniquename(bdo_two)
#uniquename(bdo_three)
#uniquename(bdo_four)
#uniquename(bdo_five)
#uniquename(bdo_six)
#uniquename(bdo_seven)

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


RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(%Address_Key%, inkeyname+'Address','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::address', %do_one%, ,diffing);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(%CityStName_Key%, inkeyname+'CityStName','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::citystname', %do_two%, ,diffing);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(%Name_Key%, inkeyname+'Name','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::name', %do_three%, ,diffing);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(%Phone_Key%, inkeyname+'Phone','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::phone', %do_four%, ,diffing);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(%SSN_Key%, inkeyname+'SSN','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::ssn', %do_five%, ,diffing);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(%StName_Key%,inkeyname+'StName','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::stname', %do_six%, ,diffing);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(%Zip_Key%,inkeyname+'Zip','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::zip', %do_seven%, ,diffing);

RoxieKeyBuild.Mac_SK_Diff(%Address_Key%, inkeyname+'Address','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::address', %ddo_one%, ,diffing);
RoxieKeyBuild.Mac_SK_Diff(%CityStName_Key%, inkeyname+'CityStName','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::citystname', %ddo_two%, ,diffing);
RoxieKeyBuild.Mac_SK_Diff(%Name_Key%, inkeyname+'Name','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::name', %ddo_three%, ,diffing);
RoxieKeyBuild.Mac_SK_Diff(%Phone_Key%, inkeyname+'Phone','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::phone', %ddo_four%, ,diffing);
RoxieKeyBuild.Mac_SK_Diff(%SSN_Key%, inkeyname+'SSN','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::ssn', %ddo_five%, ,diffing);
RoxieKeyBuild.Mac_SK_Diff(%StName_Key%,inkeyname+'StName','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::stname', %ddo_six%, ,diffing);
RoxieKeyBuild.Mac_SK_Diff(%Zip_Key%,inkeyname+'Zip','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::zip', %ddo_seven%, ,diffing);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'Address','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::address', %bdo_one%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'CityStName','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::citystname', %bdo_two%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'Name','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::name', %bdo_three%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'Phone','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::phone', %bdo_four%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'SSN','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::ssn', %bdo_five%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'StName','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::stname', %bdo_six%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'Zip','~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::zip', %bdo_seven%, ,diffing);

outaction := sequential(PARALLEL(%do_one%,
                      %do_two%,
				  %do_three%,
				  if('P' in build_skip_set, 
				     output('AUTOKEY BUILD: Phone key skipped'),
				     %do_four%),
				  if('S' in build_skip_set,
				     output('AUTOKEY BUILD: SSN key skipped'),
				     %do_five%),
				  %do_six%,
				  %do_seven%),
				  PARALLEL(%ddo_one%,
                      %ddo_two%,
				  %ddo_three%,
				  if('P' in build_skip_set, 
				     output('AUTOKEY BUILD: Phone key skipped'),
				     %ddo_four%),
				  if('S' in build_skip_set,
				     output('AUTOKEY BUILD: SSN key skipped'),
				     %ddo_five%),
				  %ddo_six%,
				  %ddo_seven%),
				  PARALLEL(%bdo_one%,
                      %bdo_two%,
				  %bdo_three%,
				  if('P' in build_skip_set, 
				     output('AUTOKEY BUILD: Phone key skipped'),
				     %bdo_four%),
				  if('S' in build_skip_set,
				     output('AUTOKEY BUILD: SSN key skipped'),
				     %bdo_five%),
				  %bdo_six%,
				  %bdo_seven%));

ENDMACRO;

						