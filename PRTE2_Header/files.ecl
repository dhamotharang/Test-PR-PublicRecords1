IMPORT header,doxie,Infutor,doxie_build,Relationship,NID,PRTE,PRTE_CSV,ut,infutor,watchdog,data_services, aid_build, dx_header;
        
        
EXPORT files := MODULE


// EXPORT personrecs := // 10.121.145.93 /data/prct/infiles/dev_16/PRCT_PersonRecs__20170314
// dataset(data_services.Data_location.prefix('PRTE')+PRTE2_Header.constants.filename_prct_personrecs
        // ,prte2_header.layout_prte_manual_raw.main
        // ,CSV(HEADING(1), SEPARATOR([',','\t']), TERMINATOR(['\n','\r\n','\n\r'])   ))(link_dob<>'link_dob');

// EXPORT file_headers_base         := prte2_header.file_header_base;
EXPORT file_header_building      := prte2_header.file_header_base;
EXPORT file_headers              := dedup(sort(PRTE2_Header.file_header_base,did,rid),did,rid);
// EXPORT file_old_ptre_header_in   := project(dedup(PRTE.Get_payload.header,record,all),Header.Layout_New_Records);


// output(PRTE.Get_Header_Base.payload,,'~prte::base::header::payload',compressed);
EXPORT file_headers2             := PRTE.Get_Header_Base.payload;
// EXPORT file_headers2             := dataset('~prte::base::header::payload',prte_csv.ge_header_base.layout_payload,flat);;
EXPORT File_FCRA_header_building := PRTE2_Header.file_header_base;

// EXPORT File_HHID         := dedup(sort(distribute(project(file_headers,transform({header.File_HHID},
                            // SELF.hhid:=LEFT.did,
                            // SELF.hhid_relat:=LEFT.did,
                            // SELF.addr_id:=x'',
                            // SELF:=LEFT,
                            // SELF:=[],)),hash32(lname,did)),lname,did,local),lname,did,local);
														
EXPORT File_HHID         := dedup(sort(distribute(project(file_headers,transform({header.File_HHID},
                            SELF.hhid:=LEFT.did,
                            SELF.hhid_relat:=LEFT.did,
                            SELF.addr_id:=x'',
                            SELF:=LEFT,
                            SELF:=[],)),hash32(lname,did)),lname,did,local),lname,did,local);
                            
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
                                TRANSFORM(PRTE2_Header.layouts.Header_layout_prep_for_keys OR {file_headers} OR {unsigned4 lookup_did,unsigned6 hhid},
                                
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
EXPORT header_FCRA_prep_for_keys := project(header_pre_keybuild,PRTE2_Header.layouts.Header_layout_prep_for_keys );

//Need to for Law Enforcement Project
EXPORT header_preprocess_std				:= dataset('~prte::persist::header::standardized', AID_BUILD.layouts.rFinal, thor );
std_header_preprocess_dist 					:= DISTRIBUTE(header_preprocess_std, HASH32(rawaid));
std_header_preprocess_srt 					:= SORT(std_header_preprocess_dist,RawAID,geo_match,-err_stat[1],LOCAL);
EXPORT std_header_preprocess_dedup	:= 	DEDUP(std_header_preprocess_srt,record,all,LOCAL);

END;