import Ingenix_NatlProf, ut, doxie, autokey;

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

export key_sanctions_fdid := index(DS,{fdid},{sanc_id},
                        '~thor_data400::key::ingenix_sanctions_fdids_' + doxie.Version_SuperKey);

