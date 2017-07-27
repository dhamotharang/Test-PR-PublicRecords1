import ingenix_natlprof, doxie, ut, autokey;

f := Ingenix_NatlProf.file_sanctions_cleaned_dided_dates;

xl := RECORD
	f;
	unsigned6 fdid;
	zero := 0;
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('SANC'))| ut.bit_set(0,0);
END;

xl xpand(f le,integer cntr) :=  TRANSFORM 
	SELF.fdid := cntr + autokey.did_adder('SANC'); 
	SELF := le; 
END;
DS := PROJECT(f,xpand(LEFT,COUNTER));

DS_TIN := DS(SANC_TIN<>'');

export key_sanctions_taxid := 
       index(DS_TIN,{l_taxid := (string10)SANC_TIN},{fdid},
	        '~thor_data400::key::ingenix_sanctions_taxid_' + Doxie.Version_SuperKey);