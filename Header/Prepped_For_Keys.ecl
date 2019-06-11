import address, doxie, doxie_build, header_services, ut, watchdog, prte, PRTE2_Header;
h := doxie_build.file_header_building; 

t1 := table(h,layout_prep_for_keys);

layout_prep_for_keys add_states(t1 le, header.dids_instates ri) := transform
  self := ri;
  self := le;
  end;

t := join(DISTRIBUTE(t1,HASH(did)),
		DISTRIBUTE(header.dids_instates,HASH(did)),left.did=right.did,add_states(left,right),LOCAL);

layout_prep_for_keys lookupbits(t le, doxie.exp_lookups ri) :=
TRANSFORM
	SELF.lookups := 	  doxie.lookup_setter(ri.sex_cnt,			'SEX') |
					  doxie.lookup_setter(ri.crim_cnt, 		'CRIM') |
					  doxie.lookup_setter(ri.ccw_cnt, 			'CCW') |
					  doxie.lookup_setter(ri.veh_cnt, 			'VEH') |
					  doxie.lookup_setter(ri.dl_cnt, 			'DL') |
					  doxie.lookup_setter(ri.rel_count, 		'REL') |
					  doxie.lookup_setter(ri.fire_count, 		'FIRE') |
					  doxie.lookup_setter(ri.faa_count, 		'FAA') |
					  doxie.lookup_setter(ri.vess_count, 		'VESS') |
					  doxie.lookup_setter(ri.prof_count, 		'PROF') |
					  doxie.lookup_setter(ri.bus_count, 		'BUS') | 
					  doxie.lookup_setter(ri.prop_count, 		'PROP') | 
					  doxie.lookup_setter(ri.bk_count, 		'BK') |
					  doxie.lookup_setter(ri.paw_count, 		'PAW') | 
					  doxie.lookup_setter(ri.bc_count, 		'BC') | 
					  doxie.lookup_setter(ri.prop_asses_count, 	'PROP_ASSES') | 
					  doxie.lookup_setter(ri.prop_deeds_count, 	'PROP_DEEDS') | 
					  doxie.lookup_setter(ri.prov_count, 	'PROV') | 
					  doxie.lookup_setter(ri.sanc_count, 	'SANC') | ut.bit_set(0,0);
	SELF := le;
END;				  

look := JOIN(t, DISTRIBUTE(doxie.exp_lookups,HASH(did)), LEFT.did = RIGHT.did, lookupbits(LEFT, RIGHT), LOCAL);


SlimRec :=
RECORD
	look.rid;
	look.city_name;
	look.zip;
END;
PreMultiCity := TABLE(look, SlimRec);

address.mac_multi_city(PreMultiCity,city_name,zip,PostMultiCity)

//MyFields rejoin (SlimRec L, MyFields R) :=
layout_prep_for_keys rejoin (SlimRec L, layout_prep_for_keys R) :=
TRANSFORM
	SELF := L;
	SELF := R;
END;

j := JOIN(PostMultiCity, look, LEFT.rid = RIGHT.rid, rejoin(LEFT, RIGHT), HASH);

//** Pick up some more SSNs and DOBs
bf := watchdog.File_Best;
bffj := table(bf(ssn<>'' OR dob<>0), {did, ssn, dob});

//myFields PatchSSN(j l, bffj r) := transform
layout_prep_for_keys PatchSSN(j l, bffj r) := transform
	self.ssn := IF(l.ssn<>'',l.ssn,r.ssn);
	self.dob := IF(l.dob<>0,l.dob,r.dob);
	self := l;
end;

jforjoin := distribute(j, hash((integer8)DID));

j2 := join(jforjoin, bffj, 
		left.did = right.did, 
		PatchSSN(left, right), 
		local, left outer, keep(1));

//here j2 is distributed by 'did'
j3_prep := ProcessCompoundNames (j2);

header.mac_mod_sup(j3_prep, j3) ;

// the result is distributed by did;
// if this is changed in the future, the following (at least) should be modified correspondingly:
//   header.key_phonetic_lname
//   doxie.Key_Header_DTS_Address
//   doxie.Key_Header_DTS_FnameSmall
//   doxie.Key_Header_DTS_StreetZipName
#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export Prepped_For_Keys := prte2_header.pre_keys.header_prep_for_keys;
#ELSE
export Prepped_For_Keys := j3 : persist('Prepped_For_Keys');
#END
