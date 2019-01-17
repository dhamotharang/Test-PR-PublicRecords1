export MAC_data_SSN (indataset,infname,inmname,inlname,
						inssn,
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
Autokey.Layout_SSN %proj%(%indata% le) :=
TRANSFORM
  SELF.s1 := ((string)le.inssn)[1];
  SELF.s2 := ((string)le.inssn)[2];
  SELF.s3 := ((string)le.inssn)[3];
  SELF.s4 := ((string)le.inssn)[4];
  SELF.s5 := ((string)le.inssn)[5];
  SELF.s6 := ((string)le.inssn)[6];
  SELF.s7 := ((string)le.inssn)[7];
  SELF.s8 := ((string)le.inssn)[8];
  SELF.s9 := ((string)le.inssn)[9];
  SELF.dph_lname := metaphonelib.DMetaPhone1(le.inlname);
  SELF.pfname := datalib.preferredfirst(le.infname);
  SELF.did := le.indid;
END;
%p% := PROJECT(%indata%((integer)inssn<>0), %proj%(LEFT));

%recs% := DEDUP(SORT(%p%,record),record);
  
outkey := %recs%;//INDEX(%recs%, {%recs%}, inkeyname + '_' + doxie.Version_SuperKey);

ENDMACRO;