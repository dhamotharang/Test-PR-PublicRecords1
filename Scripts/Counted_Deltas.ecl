
Import $;

keydsizedhistory := $.History_Analysis.Keysizedhistory_report;
master_build := $.History_Analysis.Master_Build_Frequence_Report;
orbit_build := $.History_Analysis.Orbit_buildinstance;


Export Counted_Deltas := Module

Shared s_keysizedhistory_rec := Sort(keydsizedhistory, datasetname, superkey, whenlive); // Sorted dataset

Shared g_keysizedhistory_rec := Group(s_keysizedhistory_rec, datasetname, superkey); // Grouped Dataset

// Ensures no blank whenlive fields are counted
Shared f_keysizedhistory_rec := g_keysizedhistory_rec( Not whenlive = '');


// Out record set layout
OutRec := Record
String25   datasetname;  
Unsigned8  build_version;
Qstring25  whenlive;
String1    clusterflag;
String1    updateflag;
Qstring60  superkey;
String10   templatelogicalkey;
Unsigned8  size;
Integer8   recordcount;
Integer8   deltas;
End;

// Transform
OutRec CountDeltas( f_keysizedhistory_rec Le, f_keysizedhistory_rec Ri ) := Transform
    Self.datasetname   := Le.datasetname;
    Self.build_version := Le.build_version;
    Self.whenlive      := Le.whenlive;
    Self.clusterflag   := Le.clusterflag;
    Self.updateflag    := Le.updateflag;
    Self.superkey      := Le.superkey;
    Self.templatelogicalkey := Le.templatelogicalkey;
    Self.size          := Le.size;
    Self.recordcount   := Le.recordcount;
    Self.deltas        := Le.recordcount + Ri.recordcount;
End;

// project
Export deltas_calculated := Project(f_keysizedhistory_rec, CountDeltas(Left, Right));

End;