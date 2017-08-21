//W20071029-154547 Watercraft by State Status
//history_flag is Current, Expired, Historical, or Unknown

output(table(Watercraft.File_Base_Search_Prod,
  {state_origin,history_flag,count(group)},
  state_origin,history_flag),all);

t1:=table(Watercraft.File_Base_Search_Prod,
  {watercraft_key,history_flag,t1count:=count(group)},
  watercraft_key,history_flag);
t2:=table(Watercraft.File_Base_Search_Prod,
  {orig_name_first,orig_name_middle,orig_name_last,orig_name_suffix,orig_address_1,orig_address_2,
   orig_city,orig_state,orig_zip,history_flag,t2count:=count(group)},
  orig_name_first,orig_name_middle,orig_name_last,orig_name_suffix,orig_address_1,orig_address_2,
  orig_city,orig_state,orig_zip,history_flag);

output(table(t1,{(string)t1.t1count,history_flag,count(group)},(string)t1.t1count,history_flag),all);
output(table(t2,{(string)t2.t2count,history_flag,count(group)},(string)t2.t2count,history_flag),all);