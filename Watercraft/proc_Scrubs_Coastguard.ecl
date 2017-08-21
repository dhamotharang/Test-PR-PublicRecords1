import Scrubs, Scrubs_Watercraft_Coastguard, Orbit3SOA, SALT35, ut, Watercraft, PromoteSupers, tools, std;

EXPORT proc_Scrubs_Coastguard (string version, string emailList='') := FUNCTION
#workunit('name', 'Scrubs Watercraft Coastguard Base');
#option('multiplePersistInstances',FALSE);

//F := Scrubs_Watercraft_Coastguard.In_Watercraft_Coastguard;
recordsToScrub	:= Watercraft.Out_Coastguard_Base_Dev;

ScrubsWatercraftCoastguard:= Scrubs.ScrubsPlus_PassFile(recordsToScrub,'Watercraft_Coastguard','Scrubs_Watercraft_Coastguard','Scrubs_Watercraft_Coastguard','',version,emailList);

BitmapInfile:=dataset('~thor_data::Scrubs_Watercraft_Coastguard::Scrubs_Bits',Scrubs_Watercraft_Coastguard.Scrubs.bitmap_layout,thor);

dbuildbase := project(BitmapInfile, transform(Watercraft.Layout_Scrubs.Coastguard_Base, self := left));
	PromoteSupers.MAC_SF_BuildProcess(dbuildbase,Watercraft.Cluster + 'base::watercraft_coastguard',CoastguardBaseFile,2,,true);
	// CoastguardBaseFile:=output(BitmapInfile,,Watercraft.Cluster + 'base::watercraft_coastguard_Scrubs_Test_20170206',thor,overwrite);

RETURN sequential(ScrubsWatercraftCoastguard
									,CoastguardBaseFile);

END;