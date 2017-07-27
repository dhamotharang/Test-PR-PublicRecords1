lBaseKeyName 	:= 'key::moxie.fcra_criminal_offenses.';

rMoxieFileForKeybuildLayout
 :=
  record
	Layout_Moxie_Offenses;
    unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

lMoxieFileForKeybuild := dataset(CrimSrch.Name_Moxie_Offenses_Dev,rMoxieFileForKeybuildLayout,flat);

rSimpleKeysTableRecord
 :=
  record
	lMoxieFileForKeybuild.Offender_Key;
	lMoxieFileForKeybuild.Orig_Offense_Key;
	lMoxieFileForKeybuild.Off_Date;
	lMoxieFileForKeybuild.__filepos;
  end
 ;

lSimpleKeysTable := table(lMoxieFileForKeybuild,rSimpleKeysTableRecord);

A01 := buildindex(lSimpleKeysTable(Offender_Key+Off_date+Orig_Offense_Key<>''),
			{Offender_Key,Off_date,Orig_Offense_Key,(big_endian unsigned8)__filepos},
			lBaseKeyName + 'Offender_Key.Off_Date.Orig_Offense_Key.key',moxie,overwrite);

export Out_Offenses_Keys := A01;