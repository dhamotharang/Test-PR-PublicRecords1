import ut;
//Layout with scrub bits added at the end
file_base := dataset(Watercraft.Cluster + 'base::watercraft_main',Watercraft.Layout_Scrubs.Main_Base,thor);

//Layout expected by the keys
export File_Base_Main_Prod := project(file_base,Watercraft.Layout_Watercraft_Main_Base);