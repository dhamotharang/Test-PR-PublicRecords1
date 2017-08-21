import EASI2010;

Jury2000 := Census_Data.File_Smart_Jury(fileId = 'uSF3');
census := EASI2010.File_Vendor.census(geogkey='b');

r2000 := RECORD
	Census_Data.Layout_Smart_Jury;
	string13	BGS_2000;
	string13	BGS_2010 := '';
END;

Jury2000x := PROJECT(Jury2000, Transform(r2000,
			self.BGS_2000 := LEFT.STATE + LEFT.COUNTY + LEFT.TRACT[1..3] + '.' + LEFT.TRACT[4..6] + LEFT.BLKGRP;
			self := LEFT;
			));

OUTPUT(count(jury2000x), named('n2000'));
Jury2000Mapped := JOIN(jury2000x, Census_Data.File_Block_Conversion,
					LEFT.BGS_2000 = RIGHT.BGS_2000,
					TRANSFORM(r2000,
						SELF.BGS_2010 := RIGHT.BGS_2010;
						SELF := LEFT));

OUTPUT(count(Jury2000Mapped), named('n2000map'));
OUTPUT(Jury2000Mapped);
Jury2000NotMapped := Jury2000Mapped(BGS_2010='');
OUTPUT(count(Jury2000NotMapped), named('n2000notmapped'));
OUTPUT(Jury2000NotMapped);
Jury2000Keeper := Jury2000Mapped(BGS_2010 <> '');
Jury2010Raw := JOIN(Jury2000Keeper, census, LEFT.BGS_2010 = RIGHT.EASICTRACT,
				TRANSFORM(Census_Data.Layout_Smart_Jury,
					SELF.TRACT := RIGHT.CENTRACT;
					SELF.BLKGRP := RIGHT.BLOCKGRP;
					SELF.age := (string)RIGHT.medage;
					SELF.income := (string)RIGHT.MEDHHINC;
					SELF.home_value := (string)RIGHT.MEDVALOCC;
					SELF := LEFT;
				), LEFT OUTER);
				
Jury2010 := DEDUP(Jury2010Raw,
							stusab,county,tract,blkgrp,age,income,home_value,education);
OUTPUT(count(jury2010), named('n2010'));
OUTPUT(count(jury2010), named('jury2010'));
OUTPUT(jury2010,,'~thor::in::smart_jury_20120606',compressed,overwrite);
