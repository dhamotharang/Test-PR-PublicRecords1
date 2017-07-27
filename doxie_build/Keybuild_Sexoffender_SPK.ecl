import doxie, sexoffender;

f := doxie_build.file_so_Enh_keybuilding;

lo := doxie.Layout_SexOffender_SearchPerson;


SexOffender.Layout_out_Alt makeAddresses(f le) :=
TRANSFORM
	SELF := le;
	SELF.addrscore := 0;
END;

doxie.Layout_SexOffender_Name makeNames(f le) :=
TRANSFORM
	SELF := le;
END;

lo final_layout(f le) :=
TRANSFORM
	SELF.Addresses := [];
	// SELF.names := [];
	SELF := le;
END;
p := PROJECT(f, final_layout(LEFT));

all_dist := DISTRIBUTE(f,HASH(seisint_primary_key));
Base_Recs := PROJECT(DEDUP(SORT(all_dist,seisint_primary_key,local),seisint_primary_key,local),final_layout(LEFT));
Name_Recs := DEDUP(SORT(all_dist,seisint_primary_key,fname,lname,local),
																	seisint_primary_key,fname,lname,local);
																	
f adder_roll(f le, f ri) :=
TRANSFORM
	// hierarchy here is important
	test(STRING1 s) := le.alt_type=s OR ri.alt_type=s;
	
	SELF.alt_type := MAP(test('S')	=> 'S',
											 test('B')	=> 'B',
											 test('V')	=> 'V',
											 test('C')	=> 'C',
											 test('P')	=> 'P',
											 test('P')	=> 'P',
											 test('R')	=> 'R',
											 // just to keep it deterministic
											 IF(le.alt_type<ri.alt_type,le.alt_type,ri.alt_type));
	SELF.alt_glb := IF(le.alt_glb+ri.alt_glb=2,1,0);
	SELF.alt_dppa := IF(le.alt_dppa+ri.alt_dppa=2,1,0);
	SELF.src	:= IF(le.src<ri.src,le.src,ri.src);	// again, just to keep deterministic
	SELF := le;
END;
																	
Address_Recs := ROLLUP(SORT(all_dist(alt_prim_name<>'' OR alt_zip<>'' OR alt_type='S'),
													 seisint_primary_key,alt_type,alt_prim_name,alt_prim_range,alt_zip,LOCAL),
												adder_roll(LEFT,RIGHT),
														seisint_primary_key,alt_type,alt_prim_name,alt_prim_range,alt_zip,LOCAL);

lo Add_Names(lo le, f ri) :=
TRANSFORM
	// SELF.names := le.names+PROJECT(ri,makeNames(ri));  TODO: get rid of this activity
	SELF := le;
END;
Names_Added := DENORMALIZE(Base_Recs,Name_Recs,LEFT.seisint_primary_key=RIGHT.seisint_primary_key,
																								Add_Names(LEFT,RIGHT),LOCAL);

lo Add_Addresses(lo le, f ri) :=
TRANSFORM
	SELF.addresses := le.addresses+PROJECT(ri,makeAddresses(ri));
	SELF := le;
END;
Addresses_Added := DENORMALIZE(Names_Added,Address_Recs,LEFT.seisint_primary_key=RIGHT.seisint_primary_key,
																								Add_Addresses(LEFT,RIGHT),LOCAL);

export Keybuild_Sexoffender_SPK := Addresses_Added : PERSIST('persist::so_mainkey');