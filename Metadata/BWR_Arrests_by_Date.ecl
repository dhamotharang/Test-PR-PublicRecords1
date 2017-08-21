//Arrests by Date 20071112-172456

t1:=arrestlogs.file_TX_Montgomery;

output(table(t1,{book_dt,count(group)},book_dt),all);
output(table(t1,{disp_dt,count(group)},disp_dt),all);