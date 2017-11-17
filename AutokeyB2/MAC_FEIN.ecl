export MAC_FEIN (indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,outkey,by_lookup=TRUE,favor_lookup=0) :=
MACRO
import autokey;
#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
AutokeyB2.Layout_FEIN %proj%(%indata% le) :=
TRANSFORM
	fein_use := stringlib.stringfilterout((string)le.infein,'-');
  SELF.f1 := fein_use[1];
  SELF.f2 := fein_use[2];
  SELF.f3 := fein_use[3];
  SELF.f4 := fein_use[4];
  SELF.f5 := fein_use[5];
  SELF.f6 := fein_use[6];
  SELF.f7 := fein_use[7];
  SELF.f8 := fein_use[8];
  SELF.f9 := fein_use[9];
  SELF.cname_indic := business_header.CompanyCleanFields(le.inbname, true).indicative; 
  SELF.cname_sec := business_header.CompanyCleanFields(le.inbname, true).secondary;
  SELF.bdid := le.inbdid;
	SELF.lookups := le.inlookups | ut.bit_set(0,0);
END;
%p% := PROJECT(%indata%((integer)stringlib.stringfilterout((string)infein,'-')<>0), %proj%(LEFT));

// Dedup by all fields or by all fields except lookup, preferring the record with the favored lookup
// bit set or otherwise the record with the highest lookup bit set for a set of otherwise identical records

Autokey.Mac_deduprecs(%p%,by_lookup,favor_lookup,%recs%)


  
outkey := INDEX(%recs%, {%recs%}, inkeyname+'FEIN2' + '_' + doxie.Version_SuperKey);

ENDMACRO;