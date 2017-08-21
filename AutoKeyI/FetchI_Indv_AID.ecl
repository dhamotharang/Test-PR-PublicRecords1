import ut,doxie,AutoStandardI,autokey,aid;
export FetchI_Indv_AID := module
	export old := module
		export params := module
			export base := interface
				export string fname_value;
				export boolean nicknames;
				export string lname_value;
				export set of string lname_set_value;
				export boolean phonetics;
				export string prange_value;
				export string pname_value;
				export string sec_range_value;
				export boolean addr_loose;
				export string city_value;
				export set of unsigned city_codes_set;
				export string state_value;
				export string5 zip_val;
				export set of integer4 zip_value;
				export string5 city_zip_value;
				export unsigned2 zipradius_value;
				export string2 prev_state_val1;
				export string2 prev_state_val2;
				export string30 other_lname_value1;
				export unsigned4 lookup_value;
				export unsigned4 lookup_value2;
				export boolean FuzzySecRange_value;
				export boolean do_primname_word_match;
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean workHard;
				export boolean noFail := true;
				export boolean L_UseNewPreferredFirst := false;
			end;
		end;
		export do(params.full in_mod) := function

               aid_key := Aid.Indexes.Key_ACE_Lines;

               autokey_address_layout := record				
                 unsigned aid;
                 string6 dph_lname;
                 string20 lname;
                 string20 pfname;
                 string20 fname;
                 unsigned8 states;
                 unsigned4 lname1;
                 unsigned4 lname2;
                 unsigned4 lname3;
                 unsigned4 lookups;
                 unsigned6 did;						
               end;

               f_pplus_aid := dataset([], autokey_address_layout);

               pplus_aid_key := index(f_pplus_aid,{aid,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups},{did},
                                      '~thor_data400::key::phonesplus::aid::test_20100824');
							   				   

			limit_inner := 10000;
			limit_outer := ut.limits.FETCH_LEV2_UNKEYED;

			zips :=set(project(dataset(in_mod.zip_value,{Integer4 zip}),transform({string5 zip},self.zip:=intformat(left.zip,5,1))),zip);
			extended_zips := zips + 
					 IF(in_mod.state_value<>'' AND in_mod.city_value<>'',set(project(dataset(ut.ZipsWithinCity(in_mod.state_value,in_mod.city_value),{Integer4 zip}),transform({string5 zip},self.zip:=intformat(left.zip,5,1))),zip),[]); 

			// Second Lookup bit checks for representative address
			pname_value_word:=trim(in_mod.pname_value)+' ';
			
			aid_set := set(choosen(aid_key(prim_range = in_mod.prange_value, 
			                               if(in_mod.do_primname_word_match,(prim_name[1..length(pname_value_word)]=pname_value_word),prim_name=in_mod.pname_value),
					  	                sec_range=in_mod.sec_range_value or in_mod.sec_range_value='',
						                v_city_name = in_mod.city_value or in_mod.city_value='',
						                in_mod.state_value=st,				   	  
						                zip5 in extended_zips or in_mod.zip_val='')
							   100),
						aid);

		     f_exact := project(pplus_aid_key(keyed(aid in aid_set),
						                  keyed(in_mod.lname_value='' or dph_lname=metaphonelib.DMetaPhone1(in_mod.lname_value)[1..6]), 
					                       keyed(lname in in_mod.lname_set_value  or in_mod.lname_value='' or in_mod.phonetics),
					                       keyed(Functions.PrefFirstMatch(pfname,in_mod.fname_value,in_mod.L_UseNewPreferredFirst) or in_mod.fname_value =''),
				    	                       keyed(fname = in_mod.fname_value or in_mod.fname_value ='' or in_mod.nicknames),
						                  (in_mod.prev_state_val1='' or ut.bit_test(states,ut.St2Code(in_mod.prev_state_val1))),
						                  (in_mod.prev_state_val2='' or ut.bit_test(states,ut.St2Code(in_mod.prev_state_val2))),
						                  (in_mod.other_lname_value1[1]='' or ut.bit_test(lname1,ut.Chr2Code(in_mod.other_lname_value1[1]))),
						                  (in_mod.other_lname_value1[2]='' or ut.bit_test(lname2,ut.Chr2Code(in_mod.other_lname_value1[2]))),
						                  (in_mod.other_lname_value1[3]='' or ut.bit_test(lname3,ut.Chr2Code(in_mod.other_lname_value1[3]))),
						                  (ut.bit_test(lookups, in_mod.lookup_value)),
						                   ut.bit_test(lookups, in_mod.lookup_value2)),
							             transform(AutoKey.layout_fetch, self := left, self := []));
						    
			return f_exact;			    

/*			
                                                       keyed(dph_lname=metaphonelib.DMetaPhone1(in_mod.lname_value)[1..6] or in_mod.lname_value=''),
											keyed(lname in in_mod.lname_set_value  or in_mod.lname_value=''),
											keyed(Functions.PrefFirstMatch(pfname,in_mod.fname_value,in_mod.L_UseNewPreferredFirst) or in_mod.fname_value =''),
											keyed(fname = in_mod.fname_value or in_mod.fname_value =''),
											in_mod.prev_state_val1='' or ut.bit_test(states,ut.St2Code(in_mod.prev_state_val1)),
											in_mod.prev_state_val2='' or ut.bit_test(states,ut.St2Code(in_mod.prev_state_val2)),
											in_mod.other_lname_value1[1]='' or ut.bit_test(lname1,ut.Chr2Code(in_mod.other_lname_value1[1])),
											in_mod.other_lname_value1[2]='' or ut.bit_test(lname2,ut.Chr2Code(in_mod.other_lname_value1[2])),
											in_mod.other_lname_value1[3]='' or ut.bit_test(lname3,ut.Chr2Code(in_mod.other_lname_value1[3])),
											ut.bit_test(lookups, in_mod.lookup_value),
											ut.bit_test(lookups, in_mod.lookup_value2));
			f_fuzzy :=
				 project(
							 i(
					 keyed(if(in_mod.do_primname_word_match,(prim_name[1..length(pname_value_word)]=(pname_value_word)),prim_name=in_mod.pname_value)),
					 keyed((in_mod.workHard and (in_mod.prange_value = '' OR in_mod.addr_loose)) OR in_mod.prange_value=prim_range),
					 keyed(in_mod.state_value=st OR (in_mod.state_value='' and in_mod.workHard)), 
					 keyed(city_code in in_mod.city_codes_set OR (in_mod.city_codes_set = [] and in_mod.workHard)), 
					 keyed(zip in extended_zips or in_mod.zip_val=''),
					 keyed(in_mod.sec_range_value='' or in_mod.sec_range_value=sec_range or (in_mod.lname_value <> '' and in_mod.FuzzySecRange_value )),
					 keyed(in_mod.lname_value='' or dph_lname=metaphonelib.DMetaPhone1(in_mod.lname_value)[1..6]),
					 keyed(lname in in_mod.lname_set_value  or in_mod.lname_value='' or in_mod.phonetics),
					 keyed(Functions.PrefFirstMatch(pfname,in_mod.fname_value,in_mod.L_UseNewPreferredFirst) or in_mod.fname_value =''),
					 keyed(fname = in_mod.fname_value or in_mod.fname_value ='' or in_mod.nicknames),
						in_mod.prev_state_val1='' or ut.bit_test(states,ut.St2Code(in_mod.prev_state_val1)),
						in_mod.prev_state_val2='' or ut.bit_test(states,ut.St2Code(in_mod.prev_state_val2)),
						in_mod.other_lname_value1[1]='' or ut.bit_test(lname1,ut.Chr2Code(in_mod.other_lname_value1[1])),
						in_mod.other_lname_value1[2]='' or ut.bit_test(lname2,ut.Chr2Code(in_mod.other_lname_value1[2])),
						in_mod.other_lname_value1[3]='' or ut.bit_test(lname3,ut.Chr2Code(in_mod.other_lname_value1[3])),
						ut.bit_test(lookups, in_mod.lookup_value),
						ut.bit_test(lookups, in_mod.lookup_value2))

							, AutoKey.layout_fetch);				 

			boolean addr_search :=	in_mod.pname_value != ''; 
			
			nofail := in_mod.nofail;

			Autokey.mac_Limits(f_exact,f_ret_exact)	

			doxie.mac_FetchLimitLimitSkipFail (f_fuzzy, limit_inner, limit_outer, EXISTS (f_ret_exact) or in_mod.nofail, 203, false, true, f_ret_fuzzy)

												
			RETURN IF (addr_search, IF (exists (f_ret_fuzzy), f_ret_fuzzy, f_ret_exact));
			*/
			
		end;
	end;
	export new := module
		export params := module
			export base := interface(
				AutoStandardI.InterfaceTranslator.fname_value.params,
				AutoStandardI.InterfaceTranslator.nicknames.params,
				AutoStandardI.InterfaceTranslator.lname_value.params,
				AutoStandardI.InterfaceTranslator.lname_set_value.params,
				AutoStandardI.InterfaceTranslator.phonetics.params,
				AutoStandardI.InterfaceTranslator.prange_value.params,
				AutoStandardI.InterfaceTranslator.pname_value.params,
				AutoStandardI.InterfaceTranslator.sec_range_value.params,
				AutoStandardI.InterfaceTranslator.addr_loose.params,
				AutoStandardI.InterfaceTranslator.city_value.params,
				AutoStandardI.InterfaceTranslator.city_codes_set.params,
				AutoStandardI.InterfaceTranslator.state_value.params,
				AutoStandardI.InterfaceTranslator.zip_val.params,
				AutoStandardI.InterfaceTranslator.zip_value.params,
				AutoStandardI.InterfaceTranslator.city_zip_value.params,
				AutoStandardI.InterfaceTranslator.zipradius_value.params,
				AutoStandardI.InterfaceTranslator.prev_state_val1.params,
				AutoStandardI.InterfaceTranslator.prev_state_val2.params,
				AutoStandardI.InterfaceTranslator.other_lname_value1.params,
				AutoStandardI.InterfaceTranslator.lookup_value.params,
				AutoStandardI.InterfaceTranslator.lookup_value2.params,
				AutoStandardI.InterfaceTranslator.FuzzySecRange_value.params,
				AutoStandardI.InterfaceTranslator.do_primname_word_match.params)
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean workHard;
				export boolean noFail := true;
				export boolean L_UseNewPreferredFirst := false;
			end;
		end;
		export do(params.full in_mod) := function
			tempmod := module(old.params.full)
				export string autokey_keyname_root := in_mod.autokey_keyname_root;
				export boolean workHard := in_mod.workHard;
				export boolean noFail := in_mod.noFail;
				export string fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
				export boolean nicknames := AutoStandardI.InterfaceTranslator.nicknames.val(project(in_mod,AutoStandardI.InterfaceTranslator.nicknames.params));
				export string lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
				export set of string lname_set_value := AutoStandardI.InterfaceTranslator.lname_set_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_set_value.params));
				export boolean phonetics := AutoStandardI.InterfaceTranslator.phonetics.val(project(in_mod,AutoStandardI.InterfaceTranslator.phonetics.params));
				export string prange_value := AutoStandardI.InterfaceTranslator.prange_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_value.params));
				export string pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.pname_value.params));
				export string sec_range_value := AutoStandardI.InterfaceTranslator.sec_range_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.sec_range_value.params));
				export boolean addr_loose := AutoStandardI.InterfaceTranslator.addr_loose.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_loose.params));
				export string city_value := AutoStandardI.InterfaceTranslator.city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
				export set of unsigned city_codes_set := AutoStandardI.InterfaceTranslator.city_codes_set.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_codes_set.params));
				export string state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
				export string5 zip_val := AutoStandardI.InterfaceTranslator.zip_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_val.params));
				export set of integer4 zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params));
				export string5 city_zip_value := AutoStandardI.InterfaceTranslator.city_zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_zip_value.params));
				export unsigned2 zipradius_value := AutoStandardI.InterfaceTranslator.zipradius_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zipradius_value.params));
				export string2 prev_state_val1 := AutoStandardI.InterfaceTranslator.prev_state_val1.val(project(in_mod,AutoStandardI.InterfaceTranslator.prev_state_val1.params));
				export string2 prev_state_val2 := AutoStandardI.InterfaceTranslator.prev_state_val2.val(project(in_mod,AutoStandardI.InterfaceTranslator.prev_state_val2.params));
				export string30 other_lname_value1 := AutoStandardI.InterfaceTranslator.other_lname_value1.val(project(in_mod,AutoStandardI.InterfaceTranslator.other_lname_value1.params));
				export unsigned4 lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value.params));
				export unsigned4 lookup_value2 := AutoStandardI.InterfaceTranslator.lookup_value2.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value2.params));
				export boolean FuzzySecRange_value := AutoStandardI.InterfaceTranslator.FuzzySecRange_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.FuzzySecRange_value.params));
				export boolean do_primname_word_match := AutoStandardI.InterfaceTranslator.do_primname_word_match.val(project(in_mod,AutoStandardI.InterfaceTranslator.do_primname_word_match.params));
				export boolean L_UseNewPreferredFirst := in_mod.L_UseNewPreferredFirst;
			end;
			return old.do(tempmod);
		end;
	end;
end;
