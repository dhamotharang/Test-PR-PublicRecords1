VehLic_VISF.Layout_In_addresses tnew(VehLic_VISF.File_In_addresses l) := Transform
self := l;
end;

export Transform_addresses := Project(VehLic_VISF.File_In_addresses,tnew(left));