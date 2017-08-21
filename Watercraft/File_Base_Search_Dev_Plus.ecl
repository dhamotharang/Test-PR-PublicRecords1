rMoxieFileForKeybuildLayout
 :=
  record
	Watercraft.Layout_Watercraft_Search_Base;
    unsigned integer8 __filepos{ virtual(fileposition)};
  end
 ;

export File_Base_Search_Dev_Plus := dataset(Watercraft.Cluster + 'base::watercraft_search',rMoxieFileForKeybuildLayout,flat);