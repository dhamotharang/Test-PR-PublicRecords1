//count how many unique numbers are in an ssn
export fn_count_unique_numbers_in_an_ssn(string9 in_ssn) := function
 
 string1 v1 := in_ssn[1];
 string1 v2 := in_ssn[2];
 string1 v3 := in_ssn[3];
 string1 v4 := in_ssn[4];
 string1 v5 := in_ssn[5];
 string1 v6 := in_ssn[6];
 string1 v7 := in_ssn[7];
 string1 v8 := in_ssn[8];
 string1 v9 := in_ssn[9];
 
 integer v9_found := if(v9<>v8 and v9<>v7 and v9<>v6 and v9<>v5 and v9<>v4 and v9<>v3 and v9<>v2 and v9<>v1,1,0);
 integer v8_found := if(           v8<>v7 and v8<>v6 and v8<>v5 and v8<>v4 and v8<>v3 and v8<>v2 and v8<>v1,1,0);
 integer v7_found := if(                      v7<>v6 and v7<>v5 and v7<>v4 and v7<>v3 and v7<>v2 and v7<>v1,1,0);
 integer v6_found := if(                                 v6<>v5 and v6<>v4 and v6<>v3 and v6<>v2 and v6<>v1,1,0);
 integer v5_found := if(                                            v5<>v4 and v5<>v3 and v5<>v2 and v5<>v1,1,0);
 integer v4_found := if(                                                       v4<>v3 and v4<>v2 and v4<>v1,1,0);
 integer v3_found := if(                                                                  v3<>v2 and v3<>v1,1,0);
 integer v2_found := if(                                                                             v2<>v1,1,0);
 integer v1_found := 1;
 
 integer total := sum(v1_found+v2_found+v3_found+v4_found+v5_found+v6_found+v7_found+v8_found+v9_found);
 
 return total;

end;