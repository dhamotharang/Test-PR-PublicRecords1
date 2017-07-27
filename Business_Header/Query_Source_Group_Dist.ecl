import ut;

// Initialize match file
BH_File := dataset('TEMP::BH_Basic_Match_Clean', Business_Header.Layout_Business_Header_Temp, thor);

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
string2   source;           // Source file type
qstring34 source_group;     // Source id for group
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self.source := if(L.source = 'SB', 'E', L.source);  // SEC Broker file uses CIK as key
self := L;
end;

ID_Match_Init := project(BH_File(source in ['B','BR','C','D','DC','E','IA','ID','SB'], source_group <> ''), InitMatchFile(left));


layout_stuffs := record
ID_Match_Init.source;
ID_Match_Init.source_group;
cnt := count(group);
end;

id_stat := table(ID_Match_Init, layout_stuffs, source, source_group); 

count(id_stat);

id_stat_sort := sort(id_stat(cnt > 1000), -cnt);

output(choosen(id_stat_sort, 1000));


