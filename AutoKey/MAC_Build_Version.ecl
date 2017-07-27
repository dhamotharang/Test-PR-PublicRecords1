export MAC_Build_version (indataset,infname,inmname,inlname,
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
						inkeyname,inlogical,outaction,diffing='false',
						build_skip_set='[]',
						useAllLookups = 'false',//older sets of autokeys are accustomed to having no lookup field in ssn and phone key
						rep_addr=4, by_lookup = TRUE,favor_lookup_person=0
						) :=
MACRO

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

#uniquename(do_one)
#uniquename(do_two)
#uniquename(do_three)
#uniquename(do_four)
#uniquename(do_four2)
#uniquename(do_five)
#uniquename(do_five2)
#uniquename(do_six)
#uniquename(do_seven)

#uniquename(mv_one)
#uniquename(mv_two)
#uniquename(mv_three)
#uniquename(mv_four)
#uniquename(mv_four2)
#uniquename(mv_five)
#uniquename(mv_five2)
#uniquename(mv_six)
#uniquename(mv_seven)

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
					%Address_Key%,%CityStName_Key%,%Name_Key%,%Phone_Key%,%Phone_Key2%,
					%SSN_Key%,%SSN_Key2%,%StName_Key%,%Zip_Key%,rep_addr,by_lookup,favor_lookup_person)

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Address_Key%, '',inlogical+'Address', %do_one%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%CityStName_Key%,'', inlogical+'CityStName', %do_two%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Name_Key%,'', inlogical+'Name', %do_three%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Phone_Key%,'', inlogical+'Phone', %do_four%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Phone_Key2%,'', inlogical+'Phone2', %do_four2%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%SSN_Key%,'', inlogical+'SSN', %do_five%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%SSN_Key2%,'', inlogical+'SSN2', %do_five2%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%StName_Key%,'',inlogical+'StName', %do_six%, ,diffing);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%Zip_Key%,'',inlogical+'Zip', %do_seven%, ,diffing);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'Address',inlogical+'Address',%mv_one%,,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'CityStName',inlogical+'CityStName',%mv_two%,,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'Name',inlogical+'Name',%mv_three%,,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'Phone',inlogical+'Phone',%mv_four%,,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'Phone2',inlogical+'Phone2',%mv_four2%,,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'SSN',inlogical+'SSN',%mv_five%,,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'SSN2',inlogical+'SSN2',%mv_five2%,,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'StName',inlogical+'StName',%mv_six%,,diffing);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(inkeyname+'Zip',inlogical+'Zip',%mv_seven%,,diffing);

outaction := SEQUENTIAL(
				PARALLEL(%do_one%,
                      %do_two%,
				  %do_three%,
				  if('P' in build_skip_set, 
				     output('AUTOKEY BUILD: Phone key skipped'),
				     if(useAllLookups, %do_four2%, %do_four%)),
				  if('S' in build_skip_set,
				     output('AUTOKEY BUILD: SSN key skipped'),
				     if(useAllLookups, %do_five2%, %do_five%)),
				  %do_six%,
				  %do_seven%),
				  PARALLEL(%mv_one%,
                      %mv_two%,
				  %mv_three%,
				  if('P' in build_skip_set, 
				     output('AUTOKEY MOVE: Phone key skipped'),
				     if(useAllLookups, %mv_four2%, %mv_four%)),
				  if('S' in build_skip_set,
				     output('AUTOKEY MOVE: SSN key skipped'),
				     if(useAllLookups, %mv_five2%, %mv_five%)),
				  %mv_six%,
				  %mv_seven%));



ENDMACRO;

						