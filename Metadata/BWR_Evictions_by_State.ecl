//Evictions by State W20070801-160148
//unlawdetyn = Y for eviction, N for other lien

output(choosen(table(bankrupt.File_Evictions_Daily,{orig_state,count(group)},orig_state),all));
