// !!! Compare to autokey.MAC_Zip

export MAC_Zip_Can (indataset,infname,inmname,inlname, inzip,
						// inprim_name,inprim_range,inst,incity_name, insec_range,
						// instates,
						// inlname1,inlname2,inlname3,
						// incity1,incity2,incity3,
						// inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,outkey,by_lookup=TRUE,favor_lookup=0) :=MACRO
import ut,doxie;
#uniquename(indata)
%indata% := indataset;

// looks like we can use private layouts
#uniquename (proj)
/*
#uniquename (layout)
%layout% := record
  string6 zip;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned6 did;
	unsigned4 lookups; // what do we need it for?
end;
*/
CanadianPhones.layouts.zip %proj% (indataset L) := TRANSFORM
	SELF.zip := L.inzip;
	SELF.dph_lname := metaphonelib.DMetaPhone1 (L.inlname);
	SELF.lname := L.inlname;
	SELF.pfname := datalib.preferredfirst (L.infname);
	SELF.fname := L.infname;
	SELF.minit := L.inmname [1];
	SELF.did := L.indid;
	SELF.lookups := L.inlookups | ut.bit_set(0,0);
END;

#uniquename(p)
#uniquename(recs)
%p% := Distribute(PROJECT(%indata% (inzip != ''), %proj%(LEFT)),hash(did));

// Dedup by all fields or by all fields except lookup, preferring the record with the favored lookup
// bit set or otherwise the record with the highest lookup bit set for a set of otherwise identical records
//%recs% := %p%;
Autokey.Mac_deduprecs(%p%,by_lookup,favor_lookup,%recs%)
  
outkey := INDEX(%recs%, {%recs%}, inkeyname + '_' + doxie.Version_SuperKey);

ENDMACRO;