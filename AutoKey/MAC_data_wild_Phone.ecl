export MAC_data_wild_Phone(indataset,infname,inmname,inlname,
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
Autokey.Layout_Wild_Phone %proj%(%indata% le) :=
TRANSFORM
  SELF.p7 := le.inphone[4..10];
  SELF.p3 := le.inphone[1..3];
  SELF.lname := le.inlname;
  SELF.fname := le.infname;
  SELF.st := le.inst;
  SELF.did := le.indid;
END;
%p% := PROJECT(%indata%, %proj%(LEFT));

%recs% := DEDUP(SORT(%p%((integer)p7<>0),record),record);
  
outkey := %recs%;//INDEX(%recs%, {%recs%}, inkeyname + '_' + doxie.Version_SuperKey);

ENDMACRO;