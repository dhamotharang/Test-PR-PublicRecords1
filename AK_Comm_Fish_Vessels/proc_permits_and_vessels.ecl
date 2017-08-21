import ak_comm_fish_vessels;

export proc_permits_and_vessels := function

  do_both := parallel(ak_comm_fish_vessels.proc_permits,ak_comm_fish_vessels.proc_vessels);
  
 return do_both;
 
end;