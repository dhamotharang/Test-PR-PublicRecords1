EXPORT fn_Addr_A01(dataset(layouts.slim_address) infile) := function


HRI_SIC_slim := record

infile.address_id;

unsigned3 dt_first_seen:= MIN(GROUP,IF(infile.dt_first_seen=0,999999,infile.dt_first_seen));
integer cnt := count(group);

end;

HRI_SIC_table := table(infile, HRI_SIC_slim, address_id,few);

return HRI_SIC_table;

end;