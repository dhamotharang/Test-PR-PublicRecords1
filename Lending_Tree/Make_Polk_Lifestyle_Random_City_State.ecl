import Polk;

my_rec := record
 STRING10 seq_num;
 STRING10 clean_prim_range; 
 STRING2  clean_predir;
 STRING28 clean_prim_name;
 STRING4  clean_addr_suffix;
 STRING2  clean_postdir;
 STRING10 clean_unit_desig;
 STRING8  clean_sec_range;
 STRING25 clean_p_city_name;
end;

my_rec pro1(Polk.Layout_Polk_TXL L) := TRANSFORM
 self := L;
end;

trimPolk := project(Polk.File_Polk_TXL,pro1(left));

Lending_Tree.Layout_Polk_Lifestyle_Random_City_State addAddress(Lending_Tree.Layout_Polk_Lifestyle_Random L, my_rec R) := TRANSFORM
 self.addr1 := StringLib.StringCleanSpaces(TRIM(r.clean_prim_range,all) + ' ' + TRIM(r.clean_predir,all) + ' ' + TRIM(r.clean_prim_name,all) + ' ' + 
			   TRIM(r.clean_addr_suffix,all) + ' ' + trim(r.clean_postdir,all));
 self.addr2 := StringLib.StringCleanSpaces(TRIM(r.clean_unit_desig,all) + ' ' + trim(r.clean_sec_range,all));
 self.pk_clean_city := r.clean_p_city_name;
 self := L;
end;

polk_dis := distribute(trimPolk,hash((integer)seq_num));
lt_dis := distribute(Lending_Tree.File_Polk_Lifestyle_Random_TNT,hash((integer)pk_seq_num));

Address_adding := JOIN(lt_dis,Polk_dis,(integer)left.pk_seq_num = (integer)right.seq_num,
					   addAddress(left,right),local);

output(Address_adding,,'LendTree::Polk_Lifestyle_Random_City_State');