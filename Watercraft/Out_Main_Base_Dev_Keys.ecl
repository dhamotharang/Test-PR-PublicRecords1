lBaseKeyName := 'key::moxie.watercraft_main.';

dMoxieFileForKeybuild := Watercraft.File_Base_Main_Dev_Plus;

rSimpleKeysTableRecord
 :=
  record
    dMoxieFileForKeybuild.state_origin;
	dMoxieFileForKeybuild.watercraft_key;
	dMoxieFileForKeybuild.sequence_key;
	dMoxieFileForKeybuild.__filepos;
  end
 ;

dSimpleKeysTable := table(dMoxieFileForKeybuild,rSimpleKeysTableRecord);

k01 := buildindex(dSimpleKeysTable(watercraft_key<>''),{watercraft_key,sequence_key,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'watercraft_key.sequence_key.key',moxie,overwrite);
k02 := buildindex(dSimpleKeysTable(watercraft_key<>''),{state_origin,watercraft_key,sequence_key,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'state_origin.watercraft_key.sequence_key.key',moxie,overwrite);


export Out_Main_Base_Dev_Keys
 := parallel(
			  k01
			 ,k02
			 )
 ;

