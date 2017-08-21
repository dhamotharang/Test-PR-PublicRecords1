import Scrubs, Scrubs_Watercraft_Search, Orbit3SOA, SALT35, Watercraft, ut, PromoteSupers, tools, std, Suppress;

EXPORT proc_Scrubs_Search (string version, string emailList='') := FUNCTION
#workunit('name', 'Scrubs Watercraft Search Base');
#option('multiplePersistInstances',FALSE);

PrerecordsToScrub := Watercraft.Out_Search_Base_Dev;
recordsToScrub := project(PrerecordsToScrub, Watercraft.Layout_Watercraft_Search_Base);

ScrubsWatercraftSearch:= Scrubs.ScrubsPlus_PassFile(recordsToScrub, 'Watercraft_Search','Scrubs_Watercraft_Search','Scrubs_Watercraft_Search','',version,'david.dittman@lexisnexisrisk.com');

BitmapInfile:=dataset('~thor_data::Scrubs_Watercraft_Search::Scrubs_Bits',Scrubs_Watercraft_Search.Scrubs.bitmap_layout,thor);

 	dbuildbase := project(BitmapInfile, transform(Watercraft.Layout_Scrubs.Search_Base, self := left));
	PromoteSupers.MAC_SF_BuildProcess(Watercraft.Prep_Build.Search_Base_bip(dbuildbase),Watercraft.Cluster + 'base::watercraft_search',SearchBaseFile,2,,true);
	// SearchBaseFile:=output(BitmapInfile,,Watercraft.Cluster + 'base::watercraft_search_Scrubs_Test_20170213',thor);
	
RETURN sequential(ScrubsWatercraftSearch
									,SearchBaseFile
									);

END;