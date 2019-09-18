IMPORT Header,PRTE_CSV,$,NID,doxie,ut, dx_header, prte2_death_master ;
EXPORT pre_keys:= MODULE   

// xHead_Layout :=
// RECORD
	// dx_header.layout_header;
	// string1 	valid_dob := '';
	// unsigned6 hhid := 0;
	// STRING18 	county_name := '';
	// STRING120 listed_name := '';
	// STRING10 	listed_phone := '';
	// unsigned4 dod := 0;
	// STRING1 	death_code := '';
	// unsigned4 lookup_did := 0;
// END;

                        
                            // NB NB NB
                            //
                            // THE FOLLOWING WAS TAKEN FROM Header.With_TNT
                            //
                            // DEPENDING ON HOW THE BUILD EVEOLVES, CONSIDER REFACTORING BACK TO Header.With_TNT
                            //
                            //

                            //Add valid SSN flag

                            jnd_1 := distribute(PRTE2_Header.file_header_base,hash(rid));
                                    
                            header.Layout_Header 	add_sflag(header.Layout_Header le, header.ssn_validities ri) := transform
														 self.valid_ssn := ri.val;
                              self := le;
                              end;

                            jnd_2 := join(jnd_1,distribute(header.ssn_validities,hash(rid)),left.rid=right.rid,add_sflag(left,right),left outer,local);

export header_pre_keybuild					:= join(jnd_2, dedup(sort(PRTE_CSV.Header.dthor_data400__key__header__data(did<>0),record),record),
                                LEFT.did=RIGHT.did AND LEFT.rid=RIGHT.rid,
                                TRANSFORM(PRTE2_Header.layouts.Header_layout_prep_for_keys OR dx_header.layout_header OR {unsigned4 lookup_did,unsigned6 hhid},
																
																self.pfname     := if(RIGHT.pfname='', NID.PreferredFirstVersionedStr(left.fname, NID.version),RIGHT.pfname       ),
                                self.dph_lname  := if(RIGHT.dph_lname='', metaphonelib.DMetaPhone1(left.lname)                ,RIGHT.dph_lname    ),
                                self.yob        := if(RIGHT.yob=0 , left.dob div 10000                                        ,RIGHT.yob          ),
                                self.first_seen := if(RIGHT.dt_first_seen=0,  header.get_header_first_seen(left)              ,RIGHT.dt_first_seen),
                                self.hhid       := LEFT.did;
                                self.last_seen  := if(RIGHT.dt_last_seen=0 ,  header.get_header_last_seen(left)               ,RIGHT.dt_last_seen  ),
                                     tmp_lookups:= if(RIGHT.lookups=0, 
                                                    doxie.lookup_setter(2,	'SEX' )       |
                                                    doxie.lookup_setter(3, 	'CRIM')       |
                                                    doxie.lookup_setter(4, 	'CCW' )       |
                                                    doxie.lookup_setter(3, 	'VEH' )       |
                                                    doxie.lookup_setter(4, 	'DL'  )       |
                                                    doxie.lookup_setter(3, 	'REL' )       |
                                                    doxie.lookup_setter(3, 	'FIRE')       |
                                                    doxie.lookup_setter(3, 	'FAA' )       |
                                                    doxie.lookup_setter(3, 	'VESS')       |
                                                    doxie.lookup_setter(3, 	'PROF')       |
                                                    doxie.lookup_setter(3, 	'BUS' )       | 
                                                    doxie.lookup_setter(3, 	'PROP')       | 
                                                    doxie.lookup_setter(3, 	'BK'  )       |
                                                    doxie.lookup_setter(3, 	'PAW' )       | 
                                                    doxie.lookup_setter(3, 	'BC'  )       | 
                                                    doxie.lookup_setter(3, 	'PROP_ASSES') | 
                                                    doxie.lookup_setter(3, 	'PROP_DEEDS') | 
                                                    doxie.lookup_setter(3, 	'PROV')       | 
                                                    doxie.lookup_setter(3, 	'SANC')       | ut.bit_set(0,0), RIGHT.lookups);  
                                SELF.lookup_did := tmp_lookups;
                                SELF.lookups    := tmp_lookups;
                                SELF:=LEFT,
                                SELF:=RIGHT,
                                SELF:=[]),LEFT OUTER, KEEP(1));

// xHead_Layout getCountyName(with_appends le, Census_data.File_Fips2County ri) :=
// TRANSFORM
	// SELF.county_name := ri.county_name;
	// SELF := le;
// END;
// with_county := JOIN(head, Census_data.File_Fips2County, 
				// LEFT.county = RIGHT.county_fips AND LEFT.st = RIGHT.state_code, 
				// getCountyName(LEFT, RIGHT), lookup, LEFT OUTER);
				
				
// xHead_Layout getDeath(header.Layout_Header le, prte2_death_master.files.Death_Master_Header ri) :=
// TRANSFORM
	// SELF.did := IF(le.did <> 0, le.did, (unsigned6)ri.did);
	// SELF.dod := (unsigned)ri.dod8;
	// SELF.death_code := ri.VorP_code;
	// SELF := le;
// END;

// dedup death by did; many dids have more than one VorP_code - a value in this field means death was verified
// death0:=sort(DISTRIBUTE(prte2_death_master.files.Death_Master_Header((unsigned6)did != 0), HASH((unsigned6)did)),did,local);
// death:=rollup(death0
				// ,left.did=right.did
				// ,transform({death0}
					// ,self.dod8:=max(left.dod8,right.dod8)
					// ,self.VorP_code:=max(left.VorP_code,right.VorP_code)
					// ,self:=left)
				// ,local);

// EXPORT header_pre_keybuild := JOIN( with_appends, death, 
																		// LEFT.did = (unsigned6)RIGHT.did, 
																		// getDeath(LEFT, RIGHT), FULL OUTER, LOCAL);

EXPORT header_FCRA_pre_keybuild  := header_pre_keybuild;
EXPORT header_prep_for_keys      := project(header_pre_keybuild,PRTE2_Header.layouts.Header_layout_prep_for_keys );

END;