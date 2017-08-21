import vehlic, ut;

d0         :=         dataset('~thor_data400::in::vehreg_experian_updating',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d1         :=         dataset('~thor_data400::in::vehreg_experian_updating_01',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d2         :=         dataset('~thor_data400::in::vehreg_experian_updating_02',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d3         :=         dataset('~thor_data400::in::vehreg_experian_updating_03',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d4         :=         dataset('~thor_data400::in::vehreg_experian_updating_04',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d5         :=         dataset('~thor_data400::in::vehreg_experian_updating_05',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d6         :=         dataset('~thor_data400::in::vehreg_experian_updating_06',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d7         :=         dataset('~thor_data400::in::vehreg_experian_updating_07',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d8         :=         dataset('~thor_data400::in::vehreg_experian_updating_08',vehlic.Layout_Experian_Updating_Full_premerge,flat);
 
experian_in := d1+d2+d3+d4+d5+d6+d7+d8+d0;


vehlic.Layout_Experian_Updating_Full t_map_premerge_to_expanded(vehlic.Layout_Experian_Updating_Full_premerge l) := transform
 self := l;
 self := [];
end;

dExperianPremergeExpanded := project(experian_in,t_map_premerge_to_expanded(left));

experian_concat := dExperianPremergeExpanded+vehlic.File_Experian_Updating_Full;

export File_Experian_in := experian_concat;