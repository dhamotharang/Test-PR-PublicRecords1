IMPORT Header,PRTE_CSV,$,NID,doxie,ut;
EXPORT pre_keys:= MODULE                           
                            // NB NB NB
                            //
                            // THE FOLLOWING WAS TAKEN FROM Header.With_TNT
                            //
                            // DEPENDING ON HOW THE BUILD EVEOLVES, CONSIDER REFACTORING BACK TO Header.With_TNT
                            //
                            //

                            //Add valid SSN flag

                            jnd_1 := distribute(PRTE2_Header.file_header_base,hash(rid));
                                    
                            header.Layout_Header add_sflag(header.Layout_Header le, header.ssn_validities ri) := transform
                              self.valid_ssn := ri.val;
                              self := le;
                              end;

                            jnd_2 := join(jnd_1,distribute(header.ssn_validities,hash(rid)),left.rid=right.rid,add_sflag(left,right),left outer,local);


EXPORT header_pre_keybuild := join(jnd_2, dedup(sort(PRTE_CSV.Header.dthor_data400__key__header__data(did<>0),record),record),
                                LEFT.did=RIGHT.did AND LEFT.rid=RIGHT.rid,
                                TRANSFORM(PRTE2_Header.layouts.Header_layout_prep_for_keys OR {$.files.file_headers} OR {unsigned4 lookup_did,unsigned6 hhid},
                                
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

EXPORT header_FCRA_pre_keybuild  := header_pre_keybuild;
EXPORT header_prep_for_keys      := project(header_pre_keybuild,PRTE2_Header.layouts.Header_layout_prep_for_keys );

END;