rMoxieFileForKeybuildLayout
 :=
  record
	Watercraft.Layout_Watercraft_Main_Base;
    unsigned integer8 __filepos{ virtual(fileposition)};
  end
 ;

export File_Base_Main_Dev_Plus := dataset(Watercraft.Cluster + 'base::watercraft_main_' + Watercraft.Version_Development,rMoxieFileForKeybuildLayout,flat);
