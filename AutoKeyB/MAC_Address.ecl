export MAC_Address(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,outkey) :=
MACRO

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)

#uniquename(layout)
%layout% := AutokeyB.Layout_Address;

  
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

END;
%p% := PROJECT(%indata%(inbname<>''), %proj%(LEFT));

%recs% := dedup( sort (%p%(prim_name <> ''), record), record );
  
outkey := INDEX(%recs%, {%recs%}, inkeyname+'AddressB' + '_' + doxie.Version_SuperKey);

ENDMACRO;