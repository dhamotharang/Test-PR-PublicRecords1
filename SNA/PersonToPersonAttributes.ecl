import doxie, risk_indicators, mdr, drivers, header, ut, Suppress, SNA;

EXPORT PersonToPersonAttributes( dataset(SNA.Layouts.Layout_PersonToPerson) in_dids, unsigned1 glb, unsigned1 dppa, string50 DataRestrictionMask,
                                                                doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
  isFCRA := false;
  glb_ok := Risk_Indicators.iid_constants.glb_ok(glb, isFCRA);
  dppa_ok := Risk_Indicators.iid_constants.dppa_ok(dppa, isFCRA);


  {SNA.Layouts.Layout_PersonToPerson, UNSIGNED4 global_sid} getAssociates(SNA.Layouts.Layout_PersonToPerson le, sna.Key_Person_Cluster ri, unsigned1 picker ) := TRANSFORM
    self.global_sid := ri.global_sid;
    self.seq := le.seq;
    self.person1 := le.person1;
    self.person2 := le.person2;
    self.associate := ri.associated_did;
    self.associate_degree1 := if( picker=1, ri.degree, le.associate_degree1 );
    self.associate_degree2 := if( picker=2, ri.degree, le.associate_degree2 );
    
    // derive how many paths exist between person1 and associate and between person2 and associate, then add them up.
    // the more total paths there are, the more interesting those networks become. a one degree connection (A->B) is considered to be 0 paths.
    // convert a degree=1.33 to 3 paths from A->B (eg, by way of A->C->B, A->D->B, A->E->B)
    self.connected_associate_paths := le.connected_associate_paths + if( ri.degree=0, 0, round(-1/(1-ri.degree)));

    self := [];
  END;
  
  // get all individuals associated with the 'left' person
  withCluster1_unsuppressed := join( in_dids,      SNA.Key_Person_Cluster, keyed(left.person1=right.cluster_id), getAssociates(left,right,1), atmost(10000) );
  withCluster1 := Suppress.Suppress_ReturnOldLayout(withCluster1_unsuppressed, mod_access, SNA.Layouts.Layout_PersonToPerson, didfield := associate);

  // then filter those down to people who are also associated with the 'right' person
  withCluster2_unsuppressed := join( withCluster1, SNA.Key_Person_Cluster, keyed(left.person2=right.cluster_id) and left.associate = right.associated_did, getAssociates(left,right,2), keep(1) );
  withCluster2 := Suppress.Suppress_ReturnOldLayout(withCluster2_unsuppressed, mod_access, SNA.Layouts.Layout_PersonToPerson, didfield := associate);

  // the three best connected people in the intersection
  interestingPeople := topn( group(sort(withCluster2, seq, -connected_associate_paths), seq ), 3, seq );


  // for all people associated with both the input individuals, get all addresses with which they've been associated
  {SNA.Layouts.Layout_PersonToPerson, unsigned4 global_sid, unsigned6 did} getAddr(SNA.Layouts.Layout_PersonToPerson le, doxie.key_Header ri ) := TRANSFORM
    self.global_sid := ri.global_sid;
    self.did := ri.s_did;
    self.prim_range := ri.prim_range;
    self.prim_name  := ri.prim_name;
    self.sec_range  := ri.sec_range;
    self.zip        := ri.zip;

    self := le;
  end;
  

  intersection_with_addr_unsuppressed := join( withCluster2, doxie.key_header,
    left.associate != 0
    and keyed(left.associate=right.s_did)
    // history mode not supported at this time
    and right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestrictionMask, isFCRA)
    and ( glb_ok or header.isPreGLB(right) )
    and (~mdr.Source_is_DPPA(RIGHT.src) OR (dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa,RIGHT.src)) )
    // we won't use experian dl's/vehicles (requires LN branding)
    and (~(dppa_ok AND (RIGHT.src in mdr.sourcetools.set_Experian_dl or RIGHT.src in mdr.sourcetools.set_Experian_vehicles)))
    and not mdr.Source_is_Utility(RIGHT.src) // rm Utility from NAS
    and not Risk_Indicators.iid_constants.filtered_source(right.src, right.st)
    ,
    getAddr(left,right),
    keep(100), atmost(ut.limits.HEADER_PER_DID)
  );

  intersection_with_addr := Suppress.Suppress_ReturnOldLayout(intersection_with_addr_unsuppressed, mod_access, SNA.Layouts.Layout_PersonToPerson);


  // don't count the same individual at the same address more than once. dedup prior to sorting to make the sort faster
  addr_sorted  := sort( dedup(intersection_with_addr,record), seq, prim_range, prim_name, sec_range, zip, associate );
  addr_deduped := dedup( addr_sorted,           seq, prim_range, prim_name, sec_range, zip, associate );


  layout_addr_info := record
    {addr_deduped} - shared_did_count - best_combined_degree;
    real4 best_combined_degree := min(group, addr_deduped.associate_degree1 + addr_deduped.associate_degree2 );
    unsigned1 shared_did_count := min(255,count(group));
  end;

  intersect_plus := table( addr_deduped, layout_addr_info, person1, person2, associate, associate_degree1, associate_degree2, connected_associate_paths, seq, prim_range, prim_name, sec_range, zip );

  grped := group( sort( intersect_plus, seq, -shared_did_count), seq);
  limited := topn( grped, 3, seq );


  SNA.Layouts.Layout_PersonToPerson3 into3( layout_addr_info le ) := TRANSFORM
    self.prim_range1           := le.prim_range;
    self.prim_name1            := le.prim_name;
    self.sec_range1            := le.sec_range;
    self.zip1                  := le.zip;
    self.shared_did_count1     := le.shared_did_count;
    self.best_combined_degree1 := le.best_combined_degree;
    self := le;
    self := [];
  END;

  into := project( limited, into3(left) );
  
  SNA.Layouts.Layout_PersonToPerson3 roll( SNA.Layouts.Layout_PersonToPerson3 le, SNA.Layouts.Layout_PersonToPerson3 ri ) := TRANSFORM
    pop2 := trim(le.prim_range2)='' and trim(le.prim_name2)='' and trim(le.sec_range2)='' and trim(le.zip2)='' and le.shared_did_count2=0; // second spot is blank
    pop3 := not pop2 and trim(le.prim_range3)='' and trim(le.prim_name3)='' and trim(le.sec_range3)='' and trim(le.zip3)='' and le.shared_did_count3=0; // third spot is bank
    

    self.prim_range2           := if( pop2, ri.prim_range1,           le.prim_range2 );
    self.prim_name2            := if( pop2, ri.prim_name1,            le.prim_name2 );
    self.sec_range2            := if( pop2, ri.sec_range1,            le.sec_range2 );
    self.zip2                  := if( pop2, ri.zip1,                  le.zip2 );
    self.shared_did_count2     := if( pop2, ri.shared_did_count1,     le.shared_did_count2 );
    self.best_combined_degree2 := if( pop2, ri.best_combined_degree1, le.best_combined_degree2 );

    self.prim_range3           := if( pop3, ri.prim_range1,           le.prim_range3 );
    self.prim_name3            := if( pop3, ri.prim_name1,            le.prim_name3 );
    self.sec_range3            := if( pop3, ri.sec_range1,            le.sec_range3 );
    self.zip3                  := if( pop3, ri.zip1,                  le.zip3 );
    self.shared_did_count3     := if( pop3, ri.shared_did_count1,     le.shared_did_count3 );
    self.best_combined_degree3 := if( pop3, ri.best_combined_degree1, le.best_combined_degree3 );

    self := le;
  END;
  rolled := rollup( into, roll(left,right), seq );


  SNA.Layouts.Layout_PersonToPerson3 intoPerson3( interestingPeople le ) := TRANSFORM
    self.connected_associate1_paths := le.connected_associate_paths;
    self.connected_associate1       := le.associate;
    self := le;
    self := [];
  END;

  interestingPeople3 := project( interestingPeople, intoPerson3(left) );
  
  SNA.Layouts.Layout_PersonToPerson3 rollPeople( SNA.Layouts.Layout_PersonToPerson3 le, SNA.Layouts.Layout_PersonToPerson3 ri ) := TRANSFORM
    pop2 := le.connected_associate2=0 and le.connected_associate2_paths=0;
    pop3 := not pop2 and le.connected_associate3=0 and le.connected_associate3_paths=0;
    
    self.connected_associate2_paths := if( pop2, ri.connected_associate1_paths, le.connected_associate2_paths );
    self.connected_associate2       := if( pop2, ri.connected_associate1,       le.connected_associate2 );

    self.connected_associate3_paths := if( pop3, ri.connected_associate1_paths, le.connected_associate3_paths );
    self.connected_associate3       := if( pop3, ri.connected_associate1,       le.connected_associate3 );

    self := le;
  END;
  rolledPeople := rollup( interestingPeople3, rollPeople(left,right), seq );

  SNA.Layouts.Layout_PersonToPerson3 combine_peopleAddr( rolledPeople le, rolled ri ) := TRANSFORM
    self.connected_associate1_paths := le.connected_associate1_paths;
    self.connected_associate1       := le.connected_associate1;
    self.connected_associate2_paths := le.connected_associate2_paths;
    self.connected_associate2       := le.connected_associate2;
    self.connected_associate3_paths := le.connected_associate3_paths;
    self.connected_associate3       := le.connected_associate3;

    self := ri;
  END;
  final := join( rolledPeople, rolled, left.seq=right.seq, combine_peopleAddr(left,right), keep(1) );

  return final;
END;