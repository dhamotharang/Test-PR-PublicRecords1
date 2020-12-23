
Import $, STD, history_analysis, PromoteSupers, dops, ut;

Export fn_buildDeltas(dataset(history_analysis.layouts.Layout_dopsservice) loadRawdata) := Function

s_keysizedhistory_rec := sort(loadrawdata, datasetname, superkey, whenlive); // Sorted dataset

g_keysizedhistory_rec := group(s_keysizedhistory_rec, datasetname, superkey); // Grouped Dataset

// Ensures no blank whenlive fields are counted
f_keysizedhistory_rec := g_keysizedhistory_rec( not whenlive = '');

t_previousRec := project( f_keysizedhistory_rec, history_analysis.layouts.BaseRec );

// Transform
history_analysis.layouts.BaseRec CountDeltas( history_analysis.layouts.BaseRec Le, history_analysis.layouts.BaseRec Ri ) := Transform
    NotSameVersion     := if( Le.buildversion[1..8] != Ri.buildversion[1..8], true, false ); // Checks that it is not same version 
    Self.datasetname   := trim(Ri.datasetname,right, whitespace );
    Self.prevbuild_version := trim(if( NotSameVersion, Le.buildversion, Le.prevbuild_version ), right, whitespace ); 
    Self.buildversion  := trim(Ri.buildversion,right, whitespace );
    Self.whenlive      := trim(Ri.whenlive,right, whitespace );
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
iterateCount := iterate(t_previousRec, CountDeltas(left, right));

filterIterate:=  iterateCount( not prevrecord_count = 0 ); // Fitered to remove versions with prevrecord_count of zero

Return  filterIterate;  

End;