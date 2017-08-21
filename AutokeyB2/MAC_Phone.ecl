/*2016-06-21T22:35:41Z (David Dittman)
DF-16890 Removal of Substring Warnings
*/
export MAC_Phone (indataset,inbname,
						infein,
						inphone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,outkey,by_lookup=TRUE,favor_lookup) :=
MACRO
import doxie,autokey;

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
AutokeyB2.Layout_Phone %proj%(%indata% le) :=
TRANSFORM
  SELF.p7 := ((string)le.inphone)[4..10];
  SELF.p3 := ((string)le.inphone)[1..3];
  SELF.cname_indic := business_header.CompanyCleanFields(le.inbname, true).indicative; 
  SELF.cname_sec := business_header.CompanyCleanFields(le.inbname, true).secondary;
  SELF.st := le.inst;
  SELF.bdid := le.inbdid;
	SELF.lookups := le.inlookups | ut.bit_set(0,0);
END;
%p% := PROJECT(%indata%, %proj%(LEFT));

// Dedup by all fields or by all fields except lookup, preferring the record with the favored lookup
// bit set or otherwise the record with the highest lookup bit set for a set of otherwise identical records

Autokey.Mac_deduprecs(%p%((integer)p7<>0),by_lookup,favor_lookup,%recs%)

  
outkey := INDEX(%recs%, {%recs%}, inkeyname+'PhoneB2' + '_' + doxie.Version_SuperKey);

ENDMACRO;