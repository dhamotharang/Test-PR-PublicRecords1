import	Address;
titles :=
 '\\b(MR|MRS|MS|MMS|MISS|DR|REV|RABBI|REVEREND|MSGR|PROF|FR|LT COL|COL|LCOL|LTCOL|LTC|CH|LT GEN|LT CDR|LCDR|LT CMDR|MAJ|SFC|SRTA|APCO|CAPT|CPT|SGT|SSG|MSG|MGR|CPL|CPO|SHRF|SMSG|SMSGT|SIR)\\b';
EXPORT fn_valid_fname(string s, string src) :=
			NOT s in ['NFN','NMN','NMI','NT','DE','ASS','BASTARD']
			AND NOT Address.Persons.IsSureSuffix(s)
			AND NOT REGEXFIND(titles, s);