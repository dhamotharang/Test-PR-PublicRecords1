export MAC_Name (indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,outkey) :=
MACRO
import ut, doxie,business_header;

#uniquename(indata)
%indata% := indataset;

/*
THIS IS LITTLE MORE THAN A PLACE HOLDER...NEED COMPANY NAME WORDS OR PHONETICS, AT LEAST
*/

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
AutokeyB.Layout_Name %proj%(%indata% le) :=
TRANSFORM
	SELF.cname_indic := business_header.CompanyCleanFields(le.inbname, true).indicative; 
	SELF.cname_sec := business_header.CompanyCleanFields(le.inbname, true).secondary;
	SELF.Bdid := le.inBdid;
END;
%p% := PROJECT(%indata%, %proj%(LEFT));

%recs% := dedup( sort (%p%(cname_indic<>'') , record), record );
  
outkey := INDEX(%recs%, 
{%recs%}, 
inkeyname+'NameB' + '_' + doxie.Version_SuperKey);

ENDMACRO;