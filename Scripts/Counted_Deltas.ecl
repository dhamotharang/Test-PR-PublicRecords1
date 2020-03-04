
Import $, STD;

keydsizedhistory := $.History_Analysis.Keysizedhistory_report;
master_build := $.History_Analysis.Master_Build_Frequence_Report;
orbit_build := $.History_Analysis.Orbit_buildinstance;


Export Counted_Deltas := Module

Shared s_keysizedhistory_rec := Sort(keydsizedhistory, datasetname, superkey, whenlive); // Sorted dataset

Shared g_keysizedhistory_rec := Group(s_keysizedhistory_rec, datasetname, superkey); // Grouped Dataset

// Ensures no blank whenlive fields are counted
Shared f_keysizedhistory_rec := g_keysizedhistory_rec( Not whenlive = '');

// slice into two files made up from one file
// then compare accross files
previousRec := Record
    f_keysizedhistory_rec.datasetname;
    String10   prevbuild_version := '';
    f_keysizedhistory_rec.build_version;
    f_keysizedhistory_rec.whenlive;
    f_keysizedhistory_rec.superkey;
    f_keysizedhistory_rec.size;
    Integer8 delta_size := (Integer8)0;
    Decimal5_2 size_perc := (Decimal5_2)0;
    Integer8 prevrecordcount := (Integer8)0;
    f_keysizedhistory_rec.recordcount;
    Integer8 deltas_count := (Integer8)0;
    Decimal5_2 delta_perc := (Decimal5_2)0;
End;

Export t_previousRec := Project( f_keysizedhistory_rec, previousRec );

newRec := Record
    f_keysizedhistory_rec.datasetname;
    String10   prevbuild_version := '';
    f_keysizedhistory_rec.build_version;
    f_keysizedhistory_rec.whenlive;
    f_keysizedhistory_rec.superkey;
    f_keysizedhistory_rec.size;
    Integer8 delta_size := (Integer8)0;
    Decimal5_2 size_perc := (Decimal5_2)0;
    Integer8 prevrecordcount := (Integer8)0;
    f_keysizedhistory_rec.recordcount;
    Integer8 deltas_count := (Integer8)0;
    Decimal5_2 delta_perc := (Decimal5_2)0;
End;

Export t_newRec := Project( f_keysizedhistory_rec, newRec );

// Out record set layout
OutRec := Record
    String25   datasetname;
    String10   prevbuild_version;
    String10   build_version;
    String25   whenlive;
    String60   superkey;
    Integer8   size;    
    Integer8   delta_size;
    Decimal5_2 size_perc;
    Integer8   prevrecordcount;
    Integer8   recordcount;
    Integer8   deltas_count;
    Decimal5_2 delta_perc;
End;

// Transform
OutRec CountDeltas( t_previousRec Le, t_newRec Ri ) := Transform
    NotSameVersion     := if( Le.build_version[1..8] != Ri.build_version[1..8], true, false ); // Checks that it is not same version 
    Self.datasetname   := Ri.datasetname;
    Self.prevbuild_version := if( NotSameVersion, Le.build_version, Le.prevbuild_version ); 
    Self.build_version := Ri.build_version;
    Self.whenlive      := Ri.whenlive;
    Self.superkey      := Ri.superkey;
    Self.size          := Ri.size;
    Self.delta_size    := if( Le.datasetname = Ri.datasetname AND NotSameVersion, 
                              Ri.size - Le.size, Ri.size - Le.size );
    Self.size_perc     := (Decimal5_2)if( Le.datasetname = Ri.datasetname AND NotSameVersion,  // Percetaages of changes in deltas 
                                         ( (Real)Self.delta_size / (Real)Le.size ) * 100,
                                         ( (Real)Self.delta_size / (Real)Le.size ) * 100); 
    Self.prevrecordcount := if( NotSameVersion, Le.recordcount, Le.prevrecordcount );           
    Self.recordcount   := Ri.recordcount;
    Self.deltas_count  := if( Le.datasetname = Ri.datasetname AND NotSameVersion,
                              Ri.recordcount - Le.recordcount, Ri.recordcount - Le.prevrecordcount ); // Calculate deltas from previous version to new 
    Self.delta_perc := (Decimal5_2)if( Le.datasetname = Ri.datasetname AND NotSameVersion,  // 
                                    ( (Real)Self.deltas_count / (Real)Le.recordcount) * 100, 
                                    ( (Real)Self.deltas_count / (Real)Le.prevrecordcount) * 100 );
End;

// Iterate
Export Main := Iterate(t_previousRec, CountDeltas(Left, Right));

End;