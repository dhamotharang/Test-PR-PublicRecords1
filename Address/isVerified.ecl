import ut;
export boolean isVerified(string1 tnt, string10 phone = '', string10 listedphone = '', boolean useTNTonly = false) := 
	tnt in ['B','V'] and
	(useTNTonly OR ut.NNEQ_Phone(phone, listedphone));


/*
this is the code from esp
if (stricmp(tnt,"B")==0 || stricmp(tnt,"V")==0)
{
//if Phone10!=ListingPhone!=NULL then mark as not verified.
if(!phone10 || !*phone10 || !listingPhone || !*listingPhone
|| strncmp(phone10,listingPhone,10)==0)
verified = true;
}*/