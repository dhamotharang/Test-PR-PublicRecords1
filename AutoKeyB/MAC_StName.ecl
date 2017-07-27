export MAC_StName (indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,outkey) :=
MACRO

import ut, doxie;

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
AutokeyB.Layout_StName %proj%(%indata% le) :=
TRANSFORM
	SELF.st := le.inst;
	SELF.cname_indic := business_header.CompanyCleanFields(le.inbname, true).indicative; 
	SELF.cname_sec := business_header.CompanyCleanFields(le.inbname, true).secondary;
	SELF.bdid := le.inbdid;
END;
%p% := PROJECT(%indata%(inst<>'',inbname<>''), %proj%(LEFT));

%recs% := dedup( sort (%p%, record), record );
  
outkey := INDEX(%recs%, {%recs%}, inkeyname+'StNameB'+ '_' + doxie.Version_SuperKey);

ENDMACRO;