rMoxieFileForKeybuildLayout
 :=
  record
	Watercraft.Layout_Watercraft_CoastGuard_Base;
    unsigned integer8 __filepos{ virtual(fileposition)};
  end
 ;

export File_Base_Coastguard_Dev_Plus := dataset(Watercraft.Cluster + 'base::watercraft_coastguard',rMoxieFileForKeybuildLayout,flat);