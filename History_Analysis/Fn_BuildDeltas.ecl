
Import $, STD, history_analysis, PromoteSupers, dops;


Export fn_buildDeltas( string pVersion ) := Function

loadfile := History_Analysis.Files(pVersion).Keysizedhistory_rawdata;

s_keysizedhistory_rec := sort(loadfile, datasetname, superkey, whenlive); // Sorted dataset

g_keysizedhistory_rec := group(s_keysizedhistory_rec, datasetname, superkey); // Grouped Dataset

// Ensures no blank whenlive fields are counted
f_keysizedhistory_rec := g_keysizedhistory_rec( not whenlive = '');

t_previousRec := project( f_keysizedhistory_rec, history_analysis.layouts.BaseRec );

// Transform
history_analysis.layouts.BaseRec CountDeltas( history_analysis.layouts.BaseRec Le, history_analysis.layouts.BaseRec Ri ) := Transform
    NotSameVersion     := if( Le.buildversion[1..8] != Ri.buildversion[1..8], true, false ); // Checks that it is not same version 
    Self.datasetname   := Ri.datasetname;
    Self.prevbuild_version := if( NotSameVersion, Le.buildversion, Le.prevbuild_version ); 
    Self.buildversion  := Ri.buildversion;
    Self.whenlive      := Ri.whenlive;
    Self.updateflag    := Ri.updateflag;
    Self.superkey      := Ri.superkey;
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


PromoteSupers.MAC_SF_BuildProcess(filterIterate, History_Analysis.Filenames(pVersion).BaseDeltas, dsResult, 3,,true);


Return  dsResult;  

End;