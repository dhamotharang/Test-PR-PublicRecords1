export MAC_Phone (indataset,inbname,
						infein,
						inphone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,outkey) :=
MACRO
import doxie;

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
AutokeyB.Layout_Phone %proj%(%indata% le) :=
TRANSFORM
  SELF.p7 := le.inphone[4..10];
  SELF.p3 := le.inphone[1..3];
  SELF.cname_indic := business_header.CompanyCleanFields(le.inbname, true).indicative; 
  SELF.cname_sec := business_header.CompanyCleanFields(le.inbname, true).secondary;
  SELF.st := le.inst;
  SELF.bdid := le.inbdid;
END;
%p% := PROJECT(%indata%, %proj%(LEFT));

%recs% := DEDUP(SORT(%p%((integer)p7<>0),record),record);
  
outkey := INDEX(%recs%, {%recs%}, inkeyname+'PhoneB' + '_' + doxie.Version_SuperKey);

ENDMACRO;