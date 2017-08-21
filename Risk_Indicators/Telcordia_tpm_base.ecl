import gong_Neustar, doxie;

f := File_Telcordia_tpm;

gg := gong_Neustar.File_Gong_full(LENGTH(((STRING)(INTEGER)phone10))=10, (INTEGER)z5<>0 and phone10 <> '8052594368' ); /* Temp fix until Query has a perminent solution to the phone number being filtered out*/
g_ddp := DEDUP(SORT(gg,phone10[1..6],z5),phone10[1..6],z5);

xl := 
RECORD
	Layout_telcordia_tpm;
	STRING5 zip;
END;

xl get_zips(gg le, layout_telcordia_tpm ri) :=
TRANSFORM
	SELF.zip := le.z5;
	SELF := ri;
END;


j := JOIN(f, g_ddp,right.phone10[1..3]=left.npa AND right.phone10[4..6]=left.nxx,get_zips(right,left),MANY LOOKUP, left outer);
export Telcordia_tpm_base := j;
