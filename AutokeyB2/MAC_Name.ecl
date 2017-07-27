export MAC_Name (indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,outkey,by_lookup=TRUE,favor_lookup=0) :=
MACRO
import ut, doxie,business_header,Autokey;

#uniquename(indata)
%indata% := indataset;

/*
THIS IS LITTLE MORE THAN A PLACE HOLDER...NEED COMPANY NAME WORDS OR PHONETICS, AT LEAST
*/

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
AutokeyB2.Layout_Name %proj%(%indata% le) :=
TRANSFORM
	SELF.cname_indic := business_header.CompanyCleanFields(le.inbname, true).indicative; 
	SELF.cname_sec := business_header.CompanyCleanFields(le.inbname, true).secondary;
	SELF.Bdid := le.inBdid;
	SELF.lookups := le.inlookups | ut.bit_set(0,0);
END;
%p% := PROJECT(%indata%, %proj%(LEFT));

// Dedup by all fields or by all fields except lookup, preferring the record with the favored lookup
// bit set or otherwise the record with the highest lookup bit set for a set of otherwise identical records

Autokey.Mac_deduprecs(%p%(cname_indic<>''),by_lookup,favor_lookup,%recs%)


outkey := INDEX(%recs%, 
{%recs%}, 
inkeyname+'NameB2' + '_' + doxie.Version_SuperKey);

ENDMACRO;