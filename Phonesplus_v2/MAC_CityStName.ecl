export MAC_CityStName (indataset,infname,inmname,inlname,
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
						inkeyname,outkey,by_lookup=TRUE,favor_lookup=0) :=
MACRO
import ut, doxie;

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
Autokey.Layout_CityStName %proj%(%indata% le) :=
TRANSFORM
	SELF.city_code := HASH((qstring25)le.incity_name);
	SELF.st := le.inst;
	SELF.dph_lname := metaphonelib.DMetaPhone1(le.inlname);
	SELF.lname := le.inlname;
	SELF.pfname := NID.PreferredFirstNew(le.infname);
	SELF.fname := le.infname;
	SELF.dob := (integer)le.indob;
	SELF.states := le.instates;
	SELF.lname1 := le.inlname1;
	SELF.lname2 := le.inlname2;
	SELF.lname3 := le.inlname3;
	SELF.city1 := le.incity1;
	SELF.city2 := le.incity2;
	SELF.city3 := le.incity3;
	SELF.rel_fname1 := le.inrel_fname1;
	SELF.rel_fname2 := le.inrel_fname2;
	SELF.rel_fname3 := le.inrel_fname3;
	SELF.lookups := le.inlookups | ut.bit_set(0,0);
	SELF.did := le.indid;
END;
%p% := distribute(PROJECT(%indata%(incity_name<>''), %proj%(LEFT)),hash(did));

// Dedup by all fields or by all fields except lookup, preferring the record with the favored lookup
// bit set or otherwise the record with the highest lookup bit set for a set of otherwise identical records

Autokey.Mac_deduprecs(%p%,by_lookup,favor_lookup,%recs%)


  
outkey := INDEX(%recs%, {%recs%}, inkeyname + '_' + doxie.Version_SuperKey);

ENDMACRO;