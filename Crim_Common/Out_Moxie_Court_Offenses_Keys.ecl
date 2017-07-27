// When called will produce the key(s) for the Moxie court offenses
lBaseKeyName 	:= 'key::moxie.court_offenses.';

rMoxieFileForKeybuildLayout
 :=
  record
	Layout_Moxie_Court_Offenses;
    unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

dMoxieFileForKeybuild
 := dataset(Crim_Common.Name_Moxie_Court_Offenses_Dev,rMoxieFileForKeybuildLayout,flat);

rSimpleKeysTableRecord
 :=
  record
	dMoxieFileForKeybuild.Offender_Key;
	dMoxieFileForKeybuild.Off_Comp;
	dMoxieFileForKeybuild.Off_Date;
	dMoxieFileForKeybuild.__filepos;
  end
 ;

tSimpleKeysTable := table(dMoxieFileForKeybuild,rSimpleKeysTableRecord);

export Out_Moxie_Court_Offenses_Keys 
 := buildindex(tSimpleKeysTable(Offender_Key<>''),
				{Offender_Key,Off_Comp,Off_date,(big_endian unsigned8)__filepos},
				lBaseKeyName + 'Offender_Key.Off_Comp.Off_Date.key',moxie,overwrite);