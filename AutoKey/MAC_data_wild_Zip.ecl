export MAC_data_wild_Zip(indataset,infname,inmname,inlname,
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
import ut,doxie;

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
Autokey.Layout_Wild_Zip %proj%(%indata% le) :=
TRANSFORM
	SELF.zip := (unsigned4)le.inzip;
	SELF.lname := le.inlname;
	SELF.fname := le.infname;
	SELF.minit := le.inmname[1];
	SELF.yob := doxie.DOBTools((integer)le.indob).year_in;
	SELF.s4 := (unsigned)(((string)le.inssn)[6..9]);
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
%p% := PROJECT(%indata%, %proj%(LEFT));

%recs% := dedup( sort (%p%(zip<>0) , record), record );
  
outkey := %recs%;//INDEX(%recs%, {%recs%}, inkeyname + '_' + doxie.Version_SuperKey);

ENDMACRO;

