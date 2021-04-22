
Import $, STD, history_analysis, PromoteSupers, ut;


Export Fn_BuildDeltas := Module
    
    ///////////////////////////////Calculate Deltas for Cert /////////////////////////////////////
    Export fn_buildQADeltas(dataset(history_analysis.layouts.Layout_dopsservice) loadRawdata) := Function

    // Ensures no blank whenlive fields are counted and filter out data only in qa
    f_keysizedhistory_rec := loadrawdata( whenQAlive<>'NA', whenQAlive<>'');

    t_previousRec := project( f_keysizedhistory_rec, history_analysis.layouts.BaseRecQA );

    s_keysizedhistory_rec := sort(t_previousRec, datasetname, superkey, updateflag, buildversion, whenQAlive ); // Sorted dataset

    g_keysizedhistory_rec := group(s_keysizedhistory_rec, datasetname, superkey, updateflag ); // Grouped Dataset

    // Transform QA Deltas
    history_analysis.layouts.BaseRecQA CountDeltas( history_analysis.layouts.BaseRecQA Le, history_analysis.layouts.BaseRecQA Ri ) := Transform
        NotSameVersion     := if( Le.buildversion[1..8] != Ri.buildversion[1..8], true, false ); // Checks that it is not same version 
        lessthanversion    := if(Ri.buildversion[1..8] < Le.buildversion[1..8], true, false );
        Self.datasetname   := trim(Ri.datasetname,right, whitespace );
        Self.prevbuild_version := trim(if( NotSameVersion and lessthanversion, Le.prevbuild_version, Le.buildversion ), right, whitespace ); 
        Self.buildversion  := trim(Ri.buildversion,right, whitespace );
        Self.whenQAlive  := trim(Ri.whenQAlive, right, whitespace );
        Self.updateflag    := trim(Ri.updateflag,right, whitespace );
        Self.superkey      := trim(ut.fn_RemoveSpecialChars(Ri.superkey),right, whitespace );
        Self.previous_size := if( NotSameVersion, Le.size, Le.previous_size );
        Self.size          := Ri.size;
        Self.delta_size    := if( Le.datasetname = Ri.datasetname and NotSameVersion, 
                                Ri.size - Le.size, Ri.size - Le.previous_size );
        Self.delta_size_perc  := (Decimal5_2)if( Le.datasetname = Ri.datasetname and NotSameVersion,  // Deltas represented in percentages
                                            ( (Real)self.delta_size / (Real)Le.size ) * 100,
                                            ( (Real)self.delta_size / (Real)Le.size ) * 100); 
        Self.prevrecord_count := if( NotSameVersion, Le.recordcount, Le.prevrecord_count );           
        Self.recordcount      := Ri.recordcount;
        Self.delta_count      := if( Le.datasetname = Ri.datasetname and NotSameVersion,   // Calculated deltas from new record count against previous count
                                    Ri.recordcount - Le.recordcount, Ri.recordcount - Le.prevrecord_count ); 
        Self.delta_count_perc := (Decimal5_2)if( Le.datasetname = Ri.datasetname and NotSameVersion,  // Deltas represented in percentages
                                            ( (Real)self.delta_count / (Real)Le.recordcount) * 100, 
                                            ( (Real)self.delta_count / (Real)Le.prevrecord_count) * 100 );
    End;

    // Iterate and count deltas
    iterateCount := iterate(g_keysizedhistory_rec, CountDeltas(left, right));

    filterIterate:=  iterateCount( not prevrecord_count = 0 ); // Fitered to remove versions with prevrecord_count of zero

    Return  filterIterate;  

    End;

    //////////////////////////////Calculate Deltas for Prod ///////////////////////////////////////////////
    Export fn_buildProdDeltas(dataset(history_analysis.layouts.Layout_dopsservice) loadRawdata) := Function

    // Ensures no blank whenQAlive fields 
    f_keysizedhistory_rec := loadrawdata( whenProdlive<>'NA', whenProdLive<>'');

    t_previousRec := project( f_keysizedhistory_rec, history_analysis.layouts.BaseRecprod );

    s_keysizedhistory_rec := sort(t_previousRec, datasetname, superkey, updateflag, buildversion, whenProdlive ); // Sorted dataset

    g_keysizedhistory_rec := group(s_keysizedhistory_rec, datasetname, superkey, updateflag ); // Grouped Dataset

    // Transform Prod Deltas
    history_analysis.layouts.BaseRecprod CountDeltas( history_analysis.layouts.BaseRecprod Le, history_analysis.layouts.BaseRecprod Ri ) := Transform
        NotSameVersion     := if( Ri.buildversion[1..8] != Le.buildversion[1..8], true, false );
        lessthanversion    := if(Ri.buildversion[1..8] < Le.buildversion[1..8], true, false );
        Self.datasetname   := trim(Ri.datasetname,right, whitespace );
        Self.prevbuild_version := trim(if( NotSameVersion and lessthanversion, Le.prevbuild_version, Le.buildversion ), right, whitespace ); 
        Self.buildversion  := trim(Ri.buildversion,right, whitespace ); 
        Self.whenprodlive  := trim(Ri.whenprodlive, right, whitespace );
        Self.updateflag    := trim(Ri.updateflag,right, whitespace );
        Self.superkey      := trim(ut.fn_RemoveSpecialChars(Ri.superkey),right, whitespace );
        Self.previous_size := if( NotSameVersion, Le.size, Le.previous_size );
        Self.size          := Ri.size;
        Self.delta_size    := if( Le.datasetname = Ri.datasetname and NotSameVersion, 
                                Ri.size - Le.size, Ri.size - Le.previous_size );
        Self.delta_size_perc  := (Decimal5_2)if( Le.datasetname = Ri.datasetname and NotSameVersion,  // Deltas represented in percentages
                                            ( (Real)self.delta_size / (Real)Le.size ) * 100,
                                            ( (Real)self.delta_size / (Real)Le.size ) * 100); 
        Self.prevrecord_count := if( NotSameVersion, Le.recordcount, Le.prevrecord_count );           
        Self.recordcount      := Ri.recordcount;
        Self.delta_count      := if( Le.datasetname = Ri.datasetname and NotSameVersion,   // Calculated deltas from new record count against previous count
                                    Ri.recordcount - Le.recordcount, Ri.recordcount - Le.prevrecord_count ); 
        Self.delta_count_perc := (Decimal5_2)if( Le.datasetname = Ri.datasetname and NotSameVersion,  // Deltas represented in percentages
                                            ( (Real)self.delta_count / (Real)Le.recordcount) * 100, 
                                            ( (Real)self.delta_count / (Real)Le.prevrecord_count) * 100 );
    End;

    // Iterate and count deltas
    iterateCount := iterate(g_keysizedhistory_rec, CountDeltas(left, right));

    filterIterate:=  iterateCount( not prevrecord_count = 0 ); // Fitered to remove versions with prevrecord_count of zero

    Return  filterIterate; 

    End;

End;