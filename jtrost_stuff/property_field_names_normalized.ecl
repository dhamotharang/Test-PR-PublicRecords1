import ln_propertyv2;

export property_field_names_normalized := function

ds_assr       := ln_propertyv2.File_Assessment(state_code<>'');//attempt to exclude mis-parsed data
ds_deed       := ln_propertyv2.File_Deed(state<>'');//attempt to exclude mis-parsed data
ds_addl_names := ln_propertyv2.file_ln_deed_addlnames;

jtrost_stuff.layout_property_field_names_normalized xform1(ds_assr le) := transform
 self.orig_name := le.assessee_name;
 self.name_field := 'A1';
 self.vendor := if(le.vendor_source_flag in ['F','S'],'F','O');
 self.fares_ct := if(self.vendor='F',1,0);
 self.okc_ct   := if(self.vendor='O',1,0);
 self := le;
end;

jtrost_stuff.layout_property_field_names_normalized xform2(ds_assr le) := transform
 self.orig_name := le.second_assessee_name;
 self.name_field := 'A2';
 self.vendor := if(le.vendor_source_flag in ['F','S'],'F','O');
 self.fares_ct := if(self.vendor='F',1,0);
 self.okc_ct   := if(self.vendor='O',1,0);
 self := le;
end;

jtrost_stuff.layout_property_field_names_normalized xform3(ds_deed le) := transform
 self.orig_name := le.name1;
 self.name_field := 'D2';
 self.vendor := if(le.vendor_source_flag in ['F','S'],'F','O');
 self.fares_ct := if(self.vendor='F',1,0);
 self.okc_ct   := if(self.vendor='O',1,0);
 self := le;
end;

jtrost_stuff.layout_property_field_names_normalized xform4(ds_deed le) := transform
 self.orig_name := le.name2;
 self.name_field := 'D2';
 self.vendor := if(le.vendor_source_flag in ['F','S'],'F','O');
 self.fares_ct := if(self.vendor='F',1,0);
 self.okc_ct   := if(self.vendor='O',1,0);
 self := le;
end;

jtrost_stuff.layout_property_field_names_normalized xform5(ds_deed le) := transform
 self.orig_name := le.seller1;
 self.name_field := 'S1';
 self.vendor := if(le.vendor_source_flag in ['F','S'],'F','O');
 self.fares_ct := if(self.vendor='F',1,0);
 self.okc_ct   := if(self.vendor='O',1,0);
 self := le;
end;

jtrost_stuff.layout_property_field_names_normalized xform6(ds_deed le) := transform
 self.orig_name := le.seller2;
 self.name_field := 'S2';
 self.vendor := if(le.vendor_source_flag in ['F','S'],'F','O');
 self.fares_ct := if(self.vendor='F',1,0);
 self.okc_ct   := if(self.vendor='O',1,0);
 self := le;
end;

jtrost_stuff.layout_property_field_names_normalized xform7(ds_addl_names le) := transform
 self.orig_name := le.name;
 self.name_field := le.buyer_or_seller+le.name_seq;
 self.vendor := 'O';//stats tell us there is only OKC data in this file
 self.fares_ct := if(self.vendor='F',1,0);
 self.okc_ct   := if(self.vendor='O',1,0);
 self := le;
end;

jtrost_stuff.layout_property_field_names_normalized xform8(ds_deed le) := transform
 self.orig_name := le.mailing_care_of;
 self.name_field := 'MC';
 self.vendor := if(le.vendor_source_flag in ['F','S'],'F','O');
 self.fares_ct := if(self.vendor='F',1,0);
 self.okc_ct   := if(self.vendor='O',1,0);
 self := le;
end;

p1 := project(ds_assr(assessee_name<>''),xform1(left));
p2 := project(ds_assr(second_assessee_name<>''),xform2(left));
p3 := project(ds_deed(name1<>''),xform3(left));
p4 := project(ds_deed(name2<>''),xform4(left));
p5 := project(ds_deed(seller1<>''),xform5(left));
p6 := project(ds_deed(seller2<>''),xform6(left));
p7 := project(ds_addl_names(name<>''),xform7(left));
p8 := project(ds_deed(mailing_care_of<>''),xform8(left));

concat0    := (p1+p2+p3+p4+p5+p6+p7+p8) : persist('persist::jtrost_epic_name_research');
//orig_names := dataset('~thor400_20::persist::jtrost_epic_name_research',recordof(concat0),flat);

return concat0;

end;

//EXPORT property_field_names_normalized := concat0;