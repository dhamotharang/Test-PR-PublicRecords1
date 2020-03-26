export MAC_data_Wild_Address_Loose(indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,outkey) :=
MACRO

import doxie, ut;

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
Autokey.Layout_Wild_Address_Loose %proj%(%indata% le) :=
TRANSFORM
	SELF.prim_name := ut.StripOrdinal(le.inprim_name);
	SELF.prim_range := TRIM(ut.CleanPrimRange(le.inprim_range),LEFT);
	SELF.st := le.inst;
	SELF.city_code := doxie.Make_CityCodes(le.incity_name).tho;
	SELF.zip := le.inzip;
	SELF.sec_range := le.insec_range;

	SELF.lname := le.inlname;
	SELF.fname := le.infname;
	SELF.mname := le.inmname;

	SELF.lookups := le.inlookups | ut.bit_set(0,0);
	SELF.did := le.indid;
END;
%p% := PROJECT(%indata%, %proj%(LEFT));

%recs% := dedup( sort (%p%(prim_name<>'', lname<>''), record), record );
  
outkey := %recs%;//INDEX(%recs%, {%recs%}, inkeyname + '_' + doxie.Version_SuperKey);

ENDMACRO;

