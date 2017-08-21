import header;

first_data.Layout_Redefine_HHID t1(header.Layout_HHID l) := transform
 self := l;
end;

p1 := project(header.File_HHID(did<>0),t1(left));

export Redefine_HHID := p1;