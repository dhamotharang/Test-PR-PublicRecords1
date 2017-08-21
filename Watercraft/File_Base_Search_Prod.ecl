import ut;
//Layout with scrub bits added at the end
file_base := dataset(Watercraft.Cluster + 'base::watercraft_search',Watercraft.Layout_Scrubs.Search_Base,thor);

//Layout expected by the keys
export File_Base_Search_Prod := project(file_base,Watercraft.Layout_Watercraft_Search_Base);