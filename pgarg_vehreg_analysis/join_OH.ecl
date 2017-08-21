a := pgarg_vehreg_analysis.File_OHMV(VIN!='') ;
Layout_a :=  record
string25        VIN;
end;

Layout_a tranf_a(a l) := Transform
self := l;
end;

Project_a := Project(a,tranf_a(left));

a_dist := distribute(Project_a,hash(VIN));
a_sort := sort(a_dist,VIN,local);
a_dedup := dedup(a_sort,VIN,local);


//output(Project_a);

//------------------------------------------------------------------------------------
c := VehLic.File_Base_Vehicles_Dev(orig_state='OH'):PERSIST('~thor_dell400_2::persist::File_OH_Vehlic');
b := c(ORIG_VIN!='');
Layout_b :=  record
string25        VIN;
end;

Layout_b tranf_b(b l) := Transform
self.VIN := l.ORIG_VIN;
end;

Project_b := Project(b,tranf_b(left));

b_dist := distribute(Project_b,hash(VIN));
b_sort := sort(b_dist,VIN,local);
b_dedup := dedup(b_sort,VIN,local);

//output(Project_b);
//-------------------------------------------------------------------------------------


join_a_b_with_a := join(a_dedup,b_dedup,left.VIN=right.VIN,left only);

join_a_b_with_b := join(b_dedup,a_dedup,left.VIN=right.VIN,left only);

join_a_b := join(a_dedup,b_dedup,left.VIN=right.VIN);

count(join_a_b);

count(join_a_b_with_a);
output(join_a_b_with_a, ,'~thor_dell400_2::out::join_vin_a_b_with_a',overwrite);

count(join_a_b_with_b);
output(join_a_b_with_b, ,'~thor_dell400_2::out::join_vin_a_b_with_b',overwrite);












/*
a_dist := distribute(a,hash(VIN));
a_sort := sort(a_dist,VIN,local);
a_dedup := dedup(a_sort,VIN,local);
count(a_dedup);

b := VehLic.File_Base_Vehicles_Dev(orig_state='OH'):PERSIST('~thor_dell400_2::persist::File_OH_Vehlic');
b_dist := distribute(b,hash(ORIG_VIN));
b_sort := sort(b_dist,ORIG_VIN,local);
b_dedup := dedup(b_sort,ORIG_VIN,local);
count(b_dedup)

*/