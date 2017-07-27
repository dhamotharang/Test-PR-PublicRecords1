BH_File := Business_Header.File_Business_Header;

Layout_BH_Match := record
qstring10 prim_range;
qstring28 prim_name;
unsigned3 zip;
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Base L) := transform
self := L;
end;

Addr_Match_Init := project(BH_File(zip<>0, prim_name <> '', prim_name not in Business_Header.Bad_Address_List,
                              (integer)prim_range <> 0 or 
                                 (prim_name[1..7] = 'PO BOX ' and
                                 (integer)(prim_name[8..LENGTH((string)prim_name)]) <> 0) or
                                 (prim_name[1..3] in ['RR ', 'HC '] and
                                 (integer)(prim_name[4..LENGTH((string)prim_name)]) <> 0)),
                              InitMatchFile(left));

layout_stat := record
Addr_Match_Init.zip;
Addr_Match_Init.prim_name;
Addr_Match_Init.prim_range;
cnt := count(group);
end;

Addr_Stat := table(Addr_Match_Init, layout_stat, zip, prim_name, prim_range);

Addr_Stat_Sort := sort(Addr_Stat(cnt > 1000), -cnt);

output(choosen(Addr_Stat_Sort,1000));