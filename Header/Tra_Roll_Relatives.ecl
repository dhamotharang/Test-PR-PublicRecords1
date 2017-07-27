export layout_relatives Tra_Roll_Relatives(layout_relatives lef, layout_relatives rig) := transform
  self.same_lname := lef.same_lname or rig.same_lname;
  self.number_cohabits := lef.number_cohabits+rig.number_cohabits +
                          MAP ( lef.zip=rig.zip or lef.zip<=0 or rig.zip<=0 => 0,
                                lef.zip div 100 =rig.zip div 100=>1,
                                lef.zip div 10000 = rig.zip div 10000=>2,
                                3 );
  self.recent_cohabit := if ( lef.recent_cohabit > rig.recent_cohabit, lef.recent_cohabit, rig.recent_cohabit );
  self := lef;
  end;