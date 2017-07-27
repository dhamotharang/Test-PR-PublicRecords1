wither_file := wither_and_die.File_Wither_and_Die_In;

wither_stat_layout := record
	wither_file.bus_st;
	integer4 cnt := count(group);
end;

stats := table(wither_file, wither_stat_layout, bus_st, few);

output(stats);