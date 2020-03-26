export MAC_data_phone (indataset,infname,inmname,inlname,
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
import doxie;

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
Autokey.Layout_Phone %proj%(%indata% le) :=
TRANSFORM
  SELF.p7 := ((string)le.inphone)[4..10];
  SELF.p3 := ((string)le.inphone)[1..3];
  SELF.dph_lname := metaphonelib.DMetaPhone1(le.inlname);
  SELF.pfname := datalib.preferredfirst(le.infname);
  SELF.st := le.inst;
  SELF.did := le.indid;
END;
%p% := PROJECT(%indata%, %proj%(LEFT));

%recs% := DEDUP(SORT(%p%((integer)p7<>0),record),record);
  
outkey := %recs%;//INDEX(%recs%, {%recs%}, inkeyname + '_' + doxie.Version_SuperKey);

ENDMACRO;