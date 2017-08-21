/* W20080208-145639
Sales Tax (CA, TX)
*/

// CALBUS stats
b := calbus.File_Calbus_Base;

layout_stats := record
   total_cnt := count(group);
   START_DATE_min    := min(group, b.START_DATE);
   START_DATE_max    := max(group, b.START_DATE);
   dt_first_seen_min := min(group, b.dt_first_seen);
   dt_last_seen_max  := max(group, b.dt_last_seen);   
end;

out_stats := table(b, layout_stats, few);

output(out_stats,named('CALBUS_STATS'));

// TXBUS stats
b2 := Txbus.File_Txbus_Base(trim(Outlet_Permit_Issue_Date) <> '');

layout_stats2 := record
   total_cnt := count(group);
   Outlet_Permit_Issue_Date_min  := min(group, b2.Outlet_Permit_Issue_Date);
   Outlet_Permit_Issue_Date_max  := max(group, b2.Outlet_Permit_Issue_Date);
   Outlet_First_Sales_Date_min   := min(group, b2.Outlet_First_Sales_Date);
   Outlet_First_Sales_Date_max   := max(group, b2.Outlet_First_Sales_Date);
   dt_first_seen_min := min(group, b2.dt_first_seen);
   dt_last_seen_max  := max(group, b2.dt_last_seen);   
end;

out_stats2 := table(b2, layout_stats2, few);

output(out_stats2, named('TXBUS_STATUS'));