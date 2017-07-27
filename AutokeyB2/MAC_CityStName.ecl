export MAC_CityStName (indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,outkey,by_lookup=TRUE,favor_lookup=0,build_skip_set='[]') :=
MACRO
import ut, doxie,autokey;

#uniquename(indata)
%indata% := indataset;

#uniquename(norm)
#uniquename(p)
#uniquename(recs)
AutokeyB2.Layout_CityStName %norm%(%indata% le,integer C) :=
TRANSFORM
	SELF.city_code := HASH((qstring25)le.incity_name);
	SELF.st := le.inst;
	SELF.bdid := le.inbdid;
	SELF.cname_indic := if(C=1,business_header.CompanyCleanFields(le.inbname, true).indicative,''); 
	SELF.cname_sec := if(C=1,business_header.CompanyCleanFields(le.inbname, true).secondary,'');
	SELF.lookups := le.inlookups | ut.bit_set(0,0);
END;
%p% := Normalize(%indata%(incity_name<>''),if('C' in build_skip_set ,2,1), %norm%(LEFT,Counter));


// Dedup by all fields or by all fields except lookup, preferring the record with the favored lookup
// bit set or otherwise the record with the highest lookup bit set for a set of otherwise identical records

Autokey.Mac_deduprecs(%p%,by_lookup,favor_lookup,%recs%)


outkey := INDEX(%recs%, {%recs%}, inkeyname+'CityStNameB2' + '_' + doxie.Version_SuperKey);

ENDMACRO;