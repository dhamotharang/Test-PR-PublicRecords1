export MAC_Zip (indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,outkey) :=
MACRO
import ut,doxie;

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
AutokeyB.Layout_Zip %proj%(%indata% le) :=
TRANSFORM
	SELF.zip := (unsigned4)le.inzip;
	SELF.cname_indic := business_header.CompanyCleanFields(le.inbname, true).indicative; 
	SELF.cname_sec := business_header.CompanyCleanFields(le.inbname, true).secondary;
	SELF.bdid := le.inbdid;
END;
%p% := PROJECT(%indata%, %proj%(LEFT));

%recs% := dedup( sort (%p%(zip<>0) , record), record );
  
outkey := INDEX(%recs%, {%recs%}, inkeyname+'ZipB'+ '_' + doxie.Version_SuperKey);

ENDMACRO;