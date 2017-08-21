import ut;

//***********************************CODE TO SUPRESS WA CELL PHONES********************************************
//Base search file needs to be reformated before using ut.mac_suppress_by_phonetype because does not accept the casting of did
Base_File := Watercraft.File_Base_Search_Dev;

{Watercraft.Layout_Watercraft_Search_Base, UNSIGNED6 did_temp} t_reformat1 (Base_File L):= TRANSFORM
	SELF.did_temp := (UNSIGNED6) L.did;
	SELF := L;
END;

New_File_Base_Search1 := PROJECT(Base_File, t_reformat1(LEFT));

//Supress WA Cell Phones
ut.mac_suppress_by_phonetype(New_File_Base_Search1,phone_1,st,Search_PhSuppressed1,true,did_temp);
ut.mac_suppress_by_phonetype(Search_PhSuppressed1,phone_2,st,Search_PhSuppressed2,true,did_temp);

//Reformat back to the standard format layout of the Base search file 
Watercraft.Layout_Watercraft_Search_Base t_reformat2 (Search_PhSuppressed2 L):= TRANSFORM
	SELF := L;
END;
New_File_Base_Search2 := PROJECT(Search_PhSuppressed2, t_reformat2(LEFT));

export File_Base_Search_Dev_Ph_Supressed := New_File_Base_Search2: persist('persist::watercraft_keybuild');

//************************************************************************************************************											 