import ut,doxie,AutoStandardI,autokey,AutokeyI,lib_metaphone;
export FetchI_Indv_StName := module
	export old := module
		export params := module
			export base := interface
				export string fname_value;
				export boolean nicknames;
				export string mname_value;
				export string lname_value;
				export set of string lname_set_value;
				export boolean phonetics;
				export string city_value;
				export string state_value;
				export set of integer4 zip_value;
				export unsigned find_year_high;
				export unsigned find_year_low;
				export unsigned find_month;
				export unsigned find_day;
				export string9 ssn_value;
				export string2 prev_state_val1;
				export string2 prev_state_val2;
				export string30 other_lname_value1;
				export string25 other_city_value;
				export string30 rel_fname_value1;
				export string rel_fname_value2;
				export unsigned4 lookup_value;
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean workHard;
				export boolean noFail := true;
			end;
		end;
		export do(params.full in_mod) := function

			i := autokey.Key_StName(in_mod.autokey_keyname_root);

			AutoKey.layout_fetch xt(i r) := TRANSFORM
																							SELF := r;
																			 END;

			smok(string mst) := mst='' or ut.bit_test(i.states,ut.St2Code(mst));

		  // enable 'starts with' matching on the input fname *and* safeguard against invalid subrange exception
			castFname := trim(ut.cast2keyfield(i.fname,in_mod.fname_value));

			f := 
				project(
						 i(in_mod.lname_value != '' AND in_mod.state_value <> '' AND in_mod.city_value='' AND in_mod.zip_value=[] AND
						   length(trim(in_mod.ssn_value)) <= 4,
						keyed(dph_lname=metaphonelib.DMetaPhone1(in_mod.lname_value)[1..6]),
						keyed((lname in in_mod.lname_set_value OR (in_mod.phonetics and in_mod.workHard))),
						keyed(AutoKeyI.Functions.PrefFirstMatch(pfname,in_mod.fname_value) OR (LENGTH(TRIM(in_mod.fname_value))<2 and in_mod.workHard)),
						keyed(fname[1..length(castFname)]= castFname OR (in_mod.nicknames AND LENGTH(TRIM(in_mod.fname_value))>=2)),
						keyed((st=in_mod.state_value)),
						//wild(minit),  // todo: get rid of
						keyed(in_mod.mname_value='' or in_mod.workHard or (string1)in_mod.mname_value[1]=minit ),
						keyed(yob>=(unsigned2)in_mod.find_year_low AND 
								yob<=IF((unsigned2)in_mod.find_year_high != 0, (unsigned2)in_mod.find_year_high, (unsigned2)0xFFFF)),
						keyed(in_mod.ssn_value='' or (unsigned2)in_mod.ssn_value=s4),
						in_mod.find_month=0 or ((dob div 100) % 100) in [0, 1, in_mod.find_month],
						in_mod.find_day=0 or (dob % 100) in [0, 1, in_mod.find_day],
						//zip_value=[] or zip IN zip_value,
						in_mod.prev_state_val1='' or ut.bit_test(states,ut.St2Code(in_mod.prev_state_val1)),
						in_mod.prev_state_val2='' or ut.bit_test(states,ut.St2Code(in_mod.prev_state_val2)),
						in_mod.other_lname_value1[1]='' or ut.bit_test(lname1,ut.Chr2Code(in_mod.other_lname_value1[1])),
						in_mod.other_lname_value1[2]='' or ut.bit_test(lname2,ut.Chr2Code(in_mod.other_lname_value1[2])),
						in_mod.other_lname_value1[3]='' or ut.bit_test(lname3,ut.Chr2Code(in_mod.other_lname_value1[3])),
						in_mod.other_city_value[1]='' or ut.bit_test(city1,ut.Chr2Code(in_mod.other_city_value[1])),
						in_mod.other_city_value[2]='' or ut.bit_test(city2,ut.Chr2Code(in_mod.other_city_value[2])),
						in_mod.other_city_value[3]='' or ut.bit_test(city3,ut.Chr2Code(in_mod.other_city_value[3])),
						in_mod.rel_fname_value1[1]='' or ut.bit_test(rel_fname1,ut.Chr2Code(in_mod.rel_fname_value1[1])),
						in_mod.rel_fname_value1[2]='' or ut.bit_test(rel_fname2,ut.Chr2Code(in_mod.rel_fname_value1[2])),
						in_mod.rel_fname_value1[3]='' or ut.bit_test(rel_fname3,ut.Chr2Code(in_mod.rel_fname_value1[3])),
						in_mod.rel_fname_value2[1]='' or ut.bit_test(rel_fname1,ut.Chr2Code(in_mod.rel_fname_value2[1])),
						in_mod.rel_fname_value2[2]='' or ut.bit_test(rel_fname2,ut.Chr2Code(in_mod.rel_fname_value2[2])),
						in_mod.rel_fname_value2[3]='' or ut.bit_test(rel_fname3,ut.Chr2Code(in_mod.rel_fname_value2[3])),
						ut.bit_test(lookups, in_mod.lookup_value)
						 )
					, xt(LEFT));
					
			nofail := in_mod.nofail;
			
			AutoKey.mac_Limits(f,f_ret)	
			
			RETURN f_ret;
		end;
	end;
	export new := module
		export params := module
			export base := interface(
				AutoStandardI.InterfaceTranslator.fname_value.params,
				AutoStandardI.InterfaceTranslator.nicknames.params,
				AutoStandardI.InterfaceTranslator.mname_value.params,
				AutoStandardI.InterfaceTranslator.lname_value.params,
				AutoStandardI.InterfaceTranslator.lname_set_value.params,
				AutoStandardI.InterfaceTranslator.phonetics.params,
				AutoStandardI.InterfaceTranslator.city_value.params,
				AutoStandardI.InterfaceTranslator.state_value.params,
				AutoStandardI.InterfaceTranslator.zip_value.params,
				AutoStandardI.InterfaceTranslator.find_year_high.params,
				AutoStandardI.InterfaceTranslator.find_year_low.params,
				AutoStandardI.InterfaceTranslator.find_month.params,
				AutoStandardI.InterfaceTranslator.find_day.params,
				AutoStandardI.InterfaceTranslator.ssn_value.params,
				AutoStandardI.InterfaceTranslator.prev_state_val1.params,
				AutoStandardI.InterfaceTranslator.prev_state_val2.params,
				AutoStandardI.InterfaceTranslator.other_lname_value1.params,
				AutoStandardI.InterfaceTranslator.other_city_value.params,
				AutoStandardI.InterfaceTranslator.rel_fname_value1.params,
				AutoStandardI.InterfaceTranslator.rel_fname_value2.params,
				AutoStandardI.InterfaceTranslator.lookup_value.params)
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean workHard;
				export boolean noFail := true;
			end;
		end;
		export do(params.full in_mod) := function
			tempmod := module(old.params.full)
				export string autokey_keyname_root := in_mod.autokey_keyname_root;
				export boolean workHard := in_mod.workHard;
				export boolean noFail := in_mod.noFail;
				export string fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
				export string mname_value := AutoStandardI.InterfaceTranslator.mname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.mname_value.params));
				export boolean nicknames := AutoStandardI.InterfaceTranslator.nicknames.val(project(in_mod,AutoStandardI.InterfaceTranslator.nicknames.params));
				export string lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
				export set of string lname_set_value := AutoStandardI.InterfaceTranslator.lname_set_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_set_value.params));
				export boolean phonetics := AutoStandardI.InterfaceTranslator.phonetics.val(project(in_mod,AutoStandardI.InterfaceTranslator.phonetics.params));
				export string city_value := AutoStandardI.InterfaceTranslator.city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
				export string state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
				export set of integer4 zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params));
				export string9 ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));
				export unsigned find_year_high := AutoStandardI.InterfaceTranslator.find_year_high.val(project(in_mod,AutoStandardI.InterfaceTranslator.find_year_high.params));
				export unsigned find_year_low := AutoStandardI.InterfaceTranslator.find_year_low.val(project(in_mod,AutoStandardI.InterfaceTranslator.find_year_low.params));
				export unsigned find_month := AutoStandardI.InterfaceTranslator.find_month.val(project(in_mod,AutoStandardI.InterfaceTranslator.find_month.params));
				export unsigned find_day := AutoStandardI.InterfaceTranslator.find_day.val(project(in_mod,AutoStandardI.InterfaceTranslator.find_day.params));
				export string2 prev_state_val1 := AutoStandardI.InterfaceTranslator.prev_state_val1.val(project(in_mod,AutoStandardI.InterfaceTranslator.prev_state_val1.params));
				export string2 prev_state_val2 := AutoStandardI.InterfaceTranslator.prev_state_val2.val(project(in_mod,AutoStandardI.InterfaceTranslator.prev_state_val2.params));
				export string30 other_lname_value1 := AutoStandardI.InterfaceTranslator.other_lname_value1.val(project(in_mod,AutoStandardI.InterfaceTranslator.other_lname_value1.params));
				export string25 other_city_value := AutoStandardI.InterfaceTranslator.other_city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.other_city_value.params));
				export string30 rel_fname_value1 := AutoStandardI.InterfaceTranslator.rel_fname_value1.val(project(in_mod,AutoStandardI.InterfaceTranslator.rel_fname_value1.params));
				export string rel_fname_value2 := AutoStandardI.InterfaceTranslator.rel_fname_value2.val(project(in_mod,AutoStandardI.InterfaceTranslator.rel_fname_value2.params));
				export unsigned4 lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value.params));
			end;
			return old.do(tempmod);
		end;
	end;
end;
