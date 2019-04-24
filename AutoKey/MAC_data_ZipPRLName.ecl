export MAC_data_ZipPRLName(indataset,infname,inmname,inlname,
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
						inkeyname,outkey,by_lookup=TRUE,favor_lookup=1) :=
MACRO
import ut;

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
Autokey.Layout_ZipPRLName %proj%(%indata% le) :=
TRANSFORM
	SELF.zip := (unsigned4)le.inzip;
	SELF.prim_range := TRIM(ut.CleanPrimRange(le.inprim_range),LEFT);
	SELF.lname := trim(le.inlname,LEFT);
	SELF.lookups := le.inlookups | ut.bit_set(0,0);
	SELF.did := le.indid;
END;
%p% := distribute(PROJECT(%indata%((unsigned4)inzip > 0 and inprim_range <> ''), %proj%(LEFT)),hash(did));


Autokey.Mac_deduprecs(%p%,by_lookup,favor_lookup,%recs%)

outkey := %recs%;//INDEX(%recs%, {%recs%}, inkeyname + '_' + doxie.Version_SuperKey);

ENDMACRO;