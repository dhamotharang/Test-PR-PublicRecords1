LN_TU.Layout_clean_addr_record CreateUID(LN_TU.File_In_Base_All L, integer co) := Transform
self.uid := if(co=1,thorlib.node()+1,thorlib.node()+1+co*thorlib.nodes());
self := L;
end;

File_In_Base_All_UID_Project := PROJECT(LN_TU.File_In_Base_All,CreateUID(Left,counter),local);

output(File_In_Base_All_UID_Project, ,'base::ln_tu_File_In_Base_All_UID',overwrite);



