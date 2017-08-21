EXPORT fn_Addr_A02(dataset(layouts.slim_address) infile) := function


USPIS_slim := record

infile.address_id;

unsigned3 dt_first_seen := MIN(GROUP,IF(infile.dt_first_seen=0,999999,infile.dt_first_seen));
unsigned3 dt_last_seen := MIN(GROUP,IF(infile.dt_last_seen=0,0,infile.dt_last_seen));

integer cnt := count(group);

end;

//USPIS_hotlist_table := table(infile(zip <> '' and prim_name <> '' and comments <> ''), USPIS_slim,prim_range,predir,prim_name,suffix,postdir,sec_range,zip,address_id,few);
USPIS_hotlist_table := table(infile, USPIS_slim,address_id,few);

return USPIS_hotlist_table;

end;






