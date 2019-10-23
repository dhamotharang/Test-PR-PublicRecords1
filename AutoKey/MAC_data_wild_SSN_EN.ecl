export MAC_data_wild_SSN_EN(indataset,infname,inmname,inlname,
						inssn,
						invalid_ssn,
						indob,
						inphone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,outkey) :=
MACRO

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
Autokey.Layout_Wild_SSN_EN %proj%(%indata% le) :=
TRANSFORM
  SELF.s1 := le.inssn[1];
  SELF.s2 := le.inssn[2];
  SELF.s3 := le.inssn[3];
  SELF.s4 := le.inssn[4];
  SELF.s5 := le.inssn[5];
  SELF.s6 := le.inssn[6];
  SELF.s7 := le.inssn[7];
  SELF.s8 := le.inssn[8];
  SELF.s9 := le.inssn[9];
  SELF.lname := le.inlname;
  SELF.fname := le.infname;
  SELF.mname := le.inmname;
  SELF.did := le.indid;
	self.valid_ssn := le.invalid_ssn;
END;
%p% := PROJECT(%indata%((integer)inssn<>0), %proj%(LEFT));

%recs% := DEDUP(SORT(%p%,record),record);
  
outkey := %recs%;//INDEX(%recs%, {%recs%}, inkeyname + '_' + doxie.Version_SuperKey);

ENDMACRO;