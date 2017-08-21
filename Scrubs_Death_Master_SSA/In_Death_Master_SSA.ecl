IMPORT	Death_Master, ut;
	STRING	vSSARestrictedFileName	:=	Death_Master.Constants('').Cluster	+ 'in::ssa_deathm_Prepped_SSA';
	SSA_File_Restricted							:=	DATASET(vSSARestrictedFileName,Scrubs_Death_Master_SSA.Layout_Death_Master_SSA,FLAT);	
EXPORT	In_Death_Master_SSA	:=	SSA_File_Restricted;