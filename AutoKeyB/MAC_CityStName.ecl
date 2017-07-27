export MAC_CityStName (indataset,inbname,
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
Autokeyb.Layout_CityStName %proj%(%indata% le) :=
TRANSFORM
	SELF.city_code := HASH((qstring25)le.incity_name);
	SELF.st := le.inst;
	SELF.bdid := le.inbdid;
	SELF.cname_indic := business_header.CompanyCleanFields(le.inbname, true).indicative; 
	SELF.cname_sec := business_header.CompanyCleanFields(le.inbname, true).secondary;
END;
%p% := PROJECT(%indata%(incity_name<>''), %proj%(LEFT));

%recs% := dedup( sort (%p% , record), record );
  
outkey := INDEX(%recs%, {%recs%}, inkeyname+'CityStNameB' + '_' + doxie.Version_SuperKey);

ENDMACRO;