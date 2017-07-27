import Watercraft, Lib_FileServices, doxie_build;

#workunit('name','Watercraft Build ' + Watercraft.Version_Development);

leMailTarget := 'tkirk@seisint.com,cmorton@seisint.com,dqi@seisint.com';

sequential
 (
	parallel
	 (
		Watercraft.Out_Coastguard_Base_Dev,
		Watercraft.Out_Main_Base_Dev,
		Watercraft.Out_Search_Base_Dev
	 ),
	Lib_FileServices.FileServices.SendEmail(leMailTarget,'Watercraft Build 1 of 4','Watercraft Build - Data Complete'),
	parallel
	 (
		Watercraft.Out_Search_Base_Dev_Stats,
		Watercraft.Out_Main_Base_Dev_Stats,
		Watercraft.Out_Coastguard_Base_Dev_Stats
	 ),
	Lib_FileServices.FileServices.SendEmail(leMailTarget,'Watercraft Build 2 of 4','Watercraft Build - Stats Complete'),
	parallel
	 (
		Watercraft.Out_Search_Base_Dev_Keys,
		Watercraft.Out_Main_Base_Dev_Keys,
		Watercraft.Out_Coastguard_Base_Dev_Keys
	 ),
	Lib_FileServices.FileServices.SendEmail(leMailTarget,'Watercraft Build 3 of 4','Watercraft Build - Keys Complete'),
	doxie_build.proc_build_watercraft_keys,
	Lib_FileServices.FileServices.SendEmail(leMailTarget,'Watercraft Build 4 of 4','Watercraft Build - Roxie Keys Complete')
  )
	
