import header,doxie,ut,data_services;
import doxie; 
r := doxie.File_Relatives_Plus;

doxie.Layout_Relatives_Plus swap(doxie.Layout_Relatives_Plus le) := transform
  self.person1 := le.person2;
  self.person2 := le.person1;
  self := le;
  end;

res := r + project(r,swap(left));

export Key_Relatives_v2 := INDEX(res(number_cohabits>=6), 
{person1,same_lname,number_cohabits,recent_cohabit,person2},
{res},   
data_services.Data_Location.Relatives+'thor_data400::key::relativesv2_' + 
doxie.version_superkey);

