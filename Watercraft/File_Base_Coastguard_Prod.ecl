import ut;
//Layout with scrub bits added at the end
file_base := dataset(Watercraft.Cluster + 'base::watercraft_coastguard',Watercraft.Layout_Scrubs.Coastguard_Base,thor); 

//Layout expected by the keys
export File_Base_Coastguard_Prod := project(file_base,Watercraft.Layout_Watercraft_Coastguard_Base);