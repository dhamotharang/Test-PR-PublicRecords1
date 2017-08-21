import	ut;

Name_Count_DS0 := dataset(name_count_file, layout_name_count, flat);

//remove binary's & leading spaces
recordof(Name_Count_DS0) x1(Name_Count_DS0 le) := transform
 self.name := ut.CleanSpacesAndUpper(regexreplace('[^ -~]+',stringlib.stringcleanspaces(le.name),''));
 self      := le;
end;

p1 := sort(project(Name_Count_DS0,x1(left))(name<>''),name);

recordof(p1) x2(p1 le, p1 ri) := transform
 self.male_cnt   := le.male_cnt  +ri.male_cnt;
 self.female_cnt := le.female_cnt+ri.female_cnt;
 self.fname_cnt  := le.fname_cnt +ri.fname_cnt;
 self.lname_cnt  := le.lname_cnt +ri.lname_cnt;
 self            := le;
end;

p2 := rollup(p1,left.name=right.name,x2(left,right));

idl_header.layout_name_count_exp x3(p2 le) := transform
 self.pct_fname     := le.fname_cnt/(le.fname_cnt+le.lname_cnt);
 self.pct_lname     := le.lname_cnt/(le.fname_cnt+le.lname_cnt);
 self.pct_male      := le.male_cnt/(le.male_cnt+le.female_cnt);
 self.pct_female    := le.female_cnt/(le.male_cnt+le.female_cnt);
 self.gender_cnt    := le.male_cnt+le.female_cnt;
 self.placement_cnt := le.fname_cnt+le.lname_cnt;
 self               := le;
end;

p3 := project(p2,x3(left));

export Name_Count_DS := p3;