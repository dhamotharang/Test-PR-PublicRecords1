import CanadianPhones, autokey;

canadianWP := CanadianPhones.file_CanadianWhitePages;

xl_canadianWP := RECORD
	CanadianPhones.layout_CanadianWhitepages;
	unsigned6 fdid;
END;

xl_canadianWP xpand_canadianWP(canadianWP le,integer cntr) :=  TRANSFORM 
	SELF.fdid := cntr + autokey.did_adder('KROLL'); 
	SELF := le; 
END;

export file_cwp_with_fdid := 
       PROJECT(canadianWP,xpand_canadianWP(LEFT,COUNTER)) : PERSIST('per_file_cwp_with_fdid');

