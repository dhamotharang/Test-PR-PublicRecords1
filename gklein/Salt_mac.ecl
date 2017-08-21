

#workunit('name','FCRA Key5 ')
Import SALT28,gklein;
layout_example:= gklein.layout_fcra_keys.Key5;  /* reference to file layout*/
file_example:= gklein.file_FCRA_Keys.Key5; 
SALT28.MAC_Default_SPC(file_example, ss_spc);   /*SALT macro output*/
output(ss_spc,all);   /*SALT macro output*/




