//FARES by State W20080207-131911

t:=table(ln_propertyv2.File_Search(vendor_source_flag[1]='F'),{vendor_source_flag,st});

//Sources are DAYTN, FAR_F, FAR_S, OKCTY

output(choosen(table(t,{st,count(group)},st),all));