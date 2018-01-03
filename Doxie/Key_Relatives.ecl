import doxie, data_services;

r := doxie.File_Relatives_Plus;

doxie.Layout_Relatives_Plus swap(doxie.Layout_Relatives_Plus le) := transform
  self.person1 := le.person2;
  self.person2 := le.person1;
  self := le;
  end;

res := r + project(r,swap(left));

export Key_Relatives := INDEX(res(number_cohabits>=6), 
                              {person1,same_lname,number_cohabits,recent_cohabit,person2},
                              {prim_range,
                                 unsigned1 zero := 0},   //workaround bug 17690 
                              data_services.data_location.prefix() + 'thor_data400::key::relatives_' + version_superkey);