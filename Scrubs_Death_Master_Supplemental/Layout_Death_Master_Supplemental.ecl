IMPORT	Header, ut;
EXPORT	Layout_Death_Master_Supplemental	:=	Header.layout_death_master_supplemental AND NOT 
	[
		ScrubsBits1, 
		ScrubsBits2, 
		ScrubsBits3
	];