export MAC_Zip_Canb(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,outkey,by_lookup=TRUE,favor_lookup=0,build_skip_set='[]') :=
MACRO
import ut,doxie,autokey;

#uniquename(indata)
%indata% := indataset;

#uniquename(norm)
#uniquename(p)
#uniquename(recs)
canadianphones.layouts.zipb %norm%(%indata% le,integer C) :=
TRANSFORM
	SELF.zip := le.inzip;
	SELF.cname_indic := if(C=1,business_header.CompanyCleanFields(le.inbname, true).indicative,''); 
	SELF.cname_sec := if(C=1,business_header.CompanyCleanFields(le.inbname, true).secondary,'');
	SELF.bdid := le.inbdid;
	SELF.lookups := le.inlookups | ut.bit_set(0,0);
END;
%p% := Normalize(%indata%(inzip != ''),if('C' in build_skip_set ,2,1), %norm%(LEFT,COUNTER));

// Dedup by all fields or by all fields except lookup, preferring the record with the favored lookup
// bit set or otherwise the record with the highest lookup bit set for a set of otherwise identical records

Autokey.Mac_deduprecs(%p%,by_lookup,favor_lookup,%recs%)


outkey := INDEX(%recs%, {%recs%}, inkeyname+'ZipB2'+ '_' + doxie.Version_SuperKey);

ENDMACRO;