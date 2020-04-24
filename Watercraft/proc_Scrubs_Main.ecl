import Scrubs, Scrubs_Watercraft_Base, Orbit3SOA, SALT35, ut, Watercraft, PromoteSupers, tools, std, Suppress, data_services;

EXPORT proc_Scrubs_Main (string version, string emailList='') := FUNCTION
#workunit('name', 'Scrubs Watercraft Main Base');
#option('multiplePersistInstances',FALSE);

recordsToScrub := Watercraft.Persist_Main_Joined;


ScrubsWatercraftMain:= Scrubs.ScrubsPlus_PassFile(recordsToScrub,'Watercraft_Base','Scrubs_Watercraft_Base','Scrubs_Watercraft_Base','',version,emailList);

BitmapInfile:=dataset(data_services.data_location.prefix()+'thor_data::Scrubs_Watercraft_Base::Scrubs_Bits',Scrubs_Watercraft_Base.Scrubs.bitmap_layout,thor);

 //append bitmap to base
 	dbuildbase := project(BitmapInfile, transform(Watercraft.Layout_Scrubs.Main_Base, self := left));
	PromoteSupers.MAC_SF_BuildProcess(Watercraft.Prep_Build.Main_Base(dbuildbase),Watercraft.Cluster + 'base::watercraft_main',MainBaseFile,2,,true);
	
RETURN sequential(ScrubsWatercraftMain
									
									,MainBaseFile);

END;