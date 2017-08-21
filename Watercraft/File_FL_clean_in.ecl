import Watercraft;
export File_FL_clean_in := 

DATASET(watercraft.Cluster_In + 'in::watercraft_fl', watercraft.layout_FL_clean_in, flat) (~(trim(HULL_ID)  IN ['ARWJB2980478','HBU65124L293' ] ));
    
