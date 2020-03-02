
Import $;

keydsizedhistory := $.History_Analysis.Keysizedhistory_report;
master_build := $.History_Analysis.Master_Build_Frequence_Report;
orbit_build := $.History_Analysis.Orbit_buildinstance;


Export Counted_Deltas := Module

Shared s_keysizedhistory_rec := Sort(keydsizedhistory, datasetname, superkey, whenlive); // Sorted dataset

Shared g_keysizedhistory_rec := Group(s_keysizedhistory_rec, datasetname, superkey); // Grouped Dataset

// Ensures no blank whenlive fields are counted
Shared f_keysizedhistory_rec := g_keysizedhistory_rec( Not whenlive = '');


previousRec := Record
    f_keysizedhistory_rec.recordcount;
    f_keysizedhistory_rec.datasetname;
    f_keysizedhistory_rec.build_version;
    f_keysizedhistory_rec.whenlive;
    f_keysizedhistory_rec.superkey;
    Integer8 deltas := [];
End;

Export t_previousRec := Project( f_keysizedhistory_rec, previousRec );

newRec := Record
    f_keysizedhistory_rec.recordcount;
    f_keysizedhistory_rec.datasetname;
    f_keysizedhistory_rec.build_version;
    f_keysizedhistory_rec.whenlive;
    f_keysizedhistory_rec.superkey;
    Integer8 deltas := []; 
End;
Export t_newRec := Project( f_keysizedhistory_rec, newRec );

// Out record set layout
OutRec := Record
Integer8   recordcount;
String25   datasetname;  
Unsigned8  build_version;
Qstring25  whenlive;
Qstring60  superkey;
Integer8   deltas;
End;

// Transform
OutRec CountDeltas( t_previousRec Le, t_newRec Ri ) := Transform
    Self.recordcount   := Le.recordcount;
    Self.datasetname   := Le.datasetname;
    Self.build_version := Le.build_version;
    Self.whenlive      := Le.whenlive;
    Self.superkey      := Le.superkey;
    Self.deltas        := if( Le.datasetname = Ri.datasetname AND 
                              Le.build_version != Ri.build_version, // Break
                              Ri.recordcount - Le.recordcount, Le.recordcount );
End;

// Iterate
Export Main := Iterate(t_previousRec, CountDeltas(Left, Right));

End;