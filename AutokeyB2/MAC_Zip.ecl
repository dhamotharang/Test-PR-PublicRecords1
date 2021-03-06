export MAC_Zip (indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,outkey,by_lookup=TRUE,favor_lookup=0) :=
MACRO
import ut,doxie,autokey;

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
AutokeyB2.Layout_Zip %proj%(%indata% le) :=
TRANSFORM
	SELF.zip := (unsigned4)le.inzip;
	SELF.cname_indic := business_header.CompanyCleanFields(le.inbname, true).indicative; 
	SELF.cname_sec := business_header.CompanyCleanFields(le.inbname, true).secondary;
	SELF.bdid := le.inbdid;
	SELF.lookups := le.inlookups | ut.bit_set(0,0);
END;
%p% := PROJECT(%indata%, %proj%(LEFT));

// Dedup by all fields or by all fields except lookup, preferring the record with the favored lookup
// bit set or otherwise the record with the highest lookup bit set for a set of otherwise identical records

Autokey.Mac_deduprecs(%p%(zip<>0),by_lookup,favor_lookup,%recs%)


outkey := INDEX(%recs%, {%recs%}, inkeyname+'ZipB2'+ '_' + doxie.Version_SuperKey);

ENDMACRO;