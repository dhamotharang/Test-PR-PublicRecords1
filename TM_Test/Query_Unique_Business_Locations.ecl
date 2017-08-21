bh_best := Business_Header.File_Business_Header_Best(state='CA');


//Unique Business Locations
output(count(bh_best(true)), named('Total_Unique_BDID'));
output(count(bh_best(prim_name <> '', zip <> 0)), named('Total_Unique_BDID_Nonblank_ADDR'));
output(count(bh_best(prim_name <> '', zip <> 0,
           prim_name[1..7] <> 'PO BOX')), named('Total_Unique_BDID_Not_POBOX_ADDR'));
output(count(bh_best(prim_name <> '', zip <> 0,
           prim_name[1..7] <> 'PO BOX', prim_name[1..3] not in ['RR ', 'HC '])), named('Total_Unique_BDID_Not_POBOX_RR_ADDR'));