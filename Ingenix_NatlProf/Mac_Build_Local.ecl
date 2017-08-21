export MAC_Build_Local (indataset,infname,inmname,inlname,
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
						inkeyname,filename, filedate,outaction,diffing='false',
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
					%Address_Key%,%CityStName_Key%,%Name_Key%,%Phone_Key%,%Phone_Key2%,%SSN_Key%,%SSN_Key2%,%StName_Key%,%Zip_Key%,%ZipPRLname_Key%);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Address_Key%, inkeyname+'Address','~thor_data400::key::' + filename + '::'+filedate+'::address_auto', %do_one%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%CityStName_Key%, inkeyname+'CityStName','~thor_data400::key::'+ filename + '::'+filedate+'::CityStName_auto', %do_two%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Name_Key%, inkeyname+'Name','~thor_data400::key::'+ filename + '::'+filedate+'::Name_auto', %do_three%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Phone_Key%, inkeyname+'Phone','~thor_data400::key::'+ filename + '::'+filedate+'::Phone_auto', %do_four%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%SSN_Key%, inkeyname+'SSN','~thor_data400::key::'+ filename + '::'+filedate+'::SSN_auto', %do_five%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%StName_Key%,inkeyname+'StName','~thor_data400::key::'+ filename + '::'+filedate+'::StName_auto', %do_six%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Zip_Key%,inkeyname+'Zip','~thor_data400::key::'+ filename + '::'+filedate+'::Zip_auto', %do_seven%, ,diffing);

#uniquename(b_one)
#uniquename(b_two)
#uniquename(b_three)
#uniquename(b_four)
#uniquename(b_five)
#uniquename(b_six)
#uniquename(b_seven)

RoxieKeyBuild.Mac_SK_Move_To_Built_v2(inkeyname+'Address','~thor_data400::key::'+ filename + '::'+filedate+'::address_auto', %b_one%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2(inkeyname+'CityStName','~thor_data400::key::'+ filename + '::'+filedate+'::CityStName_auto', %b_two%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2(inkeyname+'Name','~thor_data400::key::'+ filename + '::'+filedate+'::Name_auto', %b_three%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2(inkeyname+'Phone','~thor_data400::key::'+ filename + '::'+filedate+'::Phone_auto', %b_four%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2(inkeyname+'SSN','~thor_data400::key::'+ filename + '::'+filedate+'::SSN_auto', %b_five%, ,diffing)
RoxieKeyBuild.Mac_SK_Move_To_Built_v2(inkeyname+'StName','~thor_data400::key::'+ filename + '::'+filedate+'::StName_auto', %b_six%, ,diffing);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2(inkeyname+'Zip','~thor_data400::key::'+ filename + '::'+filedate+'::Zip_auto', %b_seven%, ,diffing);

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
				  PARALLEL(%b_one%,
                      %b_two%,
				  %b_three%,
				  if('P' in build_skip_set, 
				     output('AUTOKEY BUILD: Phone key skipped'),
				     %b_four%),
				  if('S' in build_skip_set,
				     output('AUTOKEY BUILD: SSN key skipped'),
				     %b_five%),
				  %b_six%,
				  %b_seven%)
				  );

ENDMACRO;
