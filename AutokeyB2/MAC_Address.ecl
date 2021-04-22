export MAC_Address(indataset,inbname,
            infein,
            phone,
            inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
            inlookups,
            inbdid,
            inkeyname,outkey,by_lookup=TRUE,favor_lookup=0) :=
MACRO
import autokey, business_header;
#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)

#uniquename(layout)
%layout% := AutokeyB2.Layout_Address;


%layout%  %proj%(%indata% le) :=
TRANSFORM
  SELF.prim_name := ut.StripOrdinal(le.inprim_name);
  SELF.prim_range := TRIM(ut.CleanPrimRange(le.inprim_range),LEFT);
  SELF.st := le.inst;
  SELF.city_code := HASH((qstring25)le.incity_name);
  SELF.zip := le.inzip;
  SELF.sec_range := le.insec_range;
  SELF.bdid := le.inbdid;
  SELF.cname_indic := business_header.CompanyCleanFields(le.inbname, true).indicative;
  SELF.cname_sec := business_header.CompanyCleanFields(le.inbname, true).secondary;
  SELF.lookups := le.inlookups | ut.bit_set(0,0);
END;
%p% := PROJECT(%indata%(inbname<>''), %proj%(LEFT));

// Dedup by all fields or by all fields except lookup, preferring the record with the favored lookup
// bit set or otherwise the record with the highest lookup bit set for a set of otherwise identical records

Autokey.Mac_deduprecs(%p%(prim_name <> ''),by_lookup,favor_lookup,%recs%)


outkey := INDEX(%recs%, {%recs%}, inkeyname+'AddressB2' + '_' + doxie.Version_SuperKey);

ENDMACRO;
