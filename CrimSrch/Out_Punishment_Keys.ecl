lBaseKeyName 	:= 'key::moxie.fcra_criminal_punishment.';

rMoxieFileForKeybuildLayout
 :=
  record
	Layout_Moxie_Punishment;
    unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

lMoxieFileForKeybuild := dataset(CrimSrch.Name_Moxie_Punishment_Dev,rMoxieFileForKeybuildLayout,flat);

rSimpleKeysTableRecord
 :=
  record
	lMoxieFileForKeybuild.Offender_Key;
	lMoxieFileForKeybuild.Orig_Offense_Key;
	lMoxieFileForKeybuild.Event_Date;
	lMoxieFileForKeybuild.__filepos;
  end
 ;

lSimpleKeysTable := table(lMoxieFileForKeybuild,rSimpleKeysTableRecord);

A01 := buildindex(lSimpleKeysTable(Orig_Offense_Key+Offender_Key+Event_Date<>''),
			{Orig_Offense_Key,Offender_Key,Event_Date,(big_endian unsigned8)__filepos},
			lBaseKeyName + 'Offense_Key.Offender_Key.Event_Date.key',moxie,overwrite);
A02 := buildindex(lSimpleKeysTable(Offender_Key+Event_date<>''),
			{Offender_Key,Event_date,(big_endian unsigned8)__filepos},
			lBaseKeyName + 'Offender_Key.Event_Date.key',moxie,overwrite);

export Out_Punishment_Keys := parallel(A01,A02);