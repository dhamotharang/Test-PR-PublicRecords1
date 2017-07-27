export MAC_Phone2    (indataset,infname,inmname,inlname,
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
						inkeyname,outkey,by_lookup=TRUE,favor_lookup=0) :=
MACRO
import doxie;

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
Autokey.Layout_Phone2 %proj%(%indata% le) :=
TRANSFORM
  SELF.p7 := le.inphone[4..10];
  SELF.p3 := le.inphone[1..3];
  SELF.dph_lname := metaphonelib.DMetaPhone1(le.inlname);
  SELF.pfname := datalib.preferredfirst(le.infname);
  SELF.st := le.inst;
  SELF.did := le.indid;
  SELF.lookups := le.inlookups | ut.bit_set(0,0);
END;
%p% := distribute(PROJECT(%indata%, %proj%(LEFT)),hash(did));

// Dedup by all fields or by all fields except lookup, preferring the record with the favored lookup
// bit set or otherwise the record with the highest lookup bit set for a set of otherwise identical records

Autokey.Mac_deduprecs(%p%((integer)p7<>0),by_lookup,favor_lookup,%recs%)

  
outkey := INDEX(%recs%, {%recs%}, inkeyname + '_' + doxie.Version_SuperKey);

ENDMACRO;
