
Import $, STD, history_analysis;


Export fn_buildDeltas := Function

keydsizedhistory := History_Analysis.files.Keysizedhistory_report;

s_keysizedhistory_rec := Sort(keydsizedhistory, datasetname, superkey, whenlive); // Sorted dataset

g_keysizedhistory_rec := Group(s_keysizedhistory_rec, datasetname, superkey); // Grouped Dataset

// Ensures no blank whenlive fields are counted
f_keysizedhistory_rec := g_keysizedhistory_rec( Not whenlive = '');

t_previousRec := Project( f_keysizedhistory_rec, history_analysis.layouts.BaseRec );


// Transform
history_analysis.layouts.BaseRec CountDeltas( history_analysis.layouts.BaseRec Le, history_analysis.layouts.BaseRec Ri ) := Transform
    NotSameVersion     := if( Le.build_version[1..8] != Ri.build_version[1..8], true, false ); // Checks that it is not same version 
    Self.datasetname   := Ri.datasetname;
    Self.prevbuild_version := if( NotSameVersion, Le.build_version, Le.prevbuild_version ); 
    Self.build_version := Ri.build_version;
    Self.whenlive      := Ri.whenlive;
    Self.updateflag    := Ri.updateflag;
    Self.superkey      := Ri.superkey;
    Self.previous_size := if( NotSameVersion, Le.size, Le.previous_size );
    Self.size          := Ri.size;
    Self.delta_size    := if( Le.datasetname = Ri.datasetname AND NotSameVersion, 
                              Ri.size - Le.size, Ri.size - Le.previous_size );
    Self.delta_size_perc  := (Decimal5_2)if( Le.datasetname = Ri.datasetname AND NotSameVersion,  // Deltas represented in percentages
                                         ( (Real)Self.delta_size / (Real)Le.size ) * 100,
                                         ( (Real)Self.delta_size / (Real)Le.size ) * 100); 
    Self.prevrecord_count := if( NotSameVersion, Le.recordcount, Le.prevrecord_count );           
    Self.recordcount      := Ri.recordcount;
    Self.delta_count      := if( Le.datasetname = Ri.datasetname AND NotSameVersion,   // Calculated deltas from new record count against previous count
                                 Ri.recordcount - Le.recordcount, Ri.recordcount - Le.prevrecord_count ); 
    Self.delta_count_perc := (Decimal5_2)if( Le.datasetname = Ri.datasetname AND NotSameVersion,  // Deltas represented in percentages
                                         ( (Real)Self.delta_count / (Real)Le.recordcount) * 100, 
                                         ( (Real)Self.delta_count / (Real)Le.prevrecord_count) * 100 );
End;

// Iterate and count deltas
iterateCount := Iterate(t_previousRec, CountDeltas(Left, Right));

Return iterateCount( NOT prevrecord_count = 0 ); // Fitered to remove versions with prevrecord_count of zero


End;