export MAC_FEIN (indataset,inbname,
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
Autokeyb.Layout_FEIN %proj%(%indata% le) :=
TRANSFORM
  SELF.f1 := ((string)le.infein)[1];
  SELF.f2 := ((string)le.infein)[2];
  SELF.f3 := ((string)le.infein)[3];
  SELF.f4 := ((string)le.infein)[4];
  SELF.f5 := ((string)le.infein)[5];
  SELF.f6 := ((string)le.infein)[6];
  SELF.f7 := ((string)le.infein)[7];
  SELF.f8 := ((string)le.infein)[8];
  SELF.f9 := ((string)le.infein)[9];
  SELF.cname_indic := business_header.CompanyCleanFields(le.inbname, true).indicative; 
  SELF.cname_sec := business_header.CompanyCleanFields(le.inbname, true).secondary;
  SELF.bdid := le.inbdid;
END;
%p% := PROJECT(%indata%((integer)infein<>0), %proj%(LEFT));

%recs% := DEDUP(SORT(%p%,record),record);
  
outkey := INDEX(%recs%, {%recs%}, inkeyname+'FEIN' + '_' + doxie.Version_SuperKey);

ENDMACRO;