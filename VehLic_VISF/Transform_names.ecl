VehLic_VISF.Layout_In_names tnew(VehLic_VISF.File_In_names l) := Transform
self := l;
end;

export Transform_names := Project(VehLic_VISF.File_In_names,tnew(left));