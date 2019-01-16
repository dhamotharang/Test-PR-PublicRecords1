export MAC_data_address(indataset,infname,inmname,inlname,
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
						inkeyname,outkey,by_lookup=TRUE,rep_Addr=4) :=
MACRO

import NID;

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(proj2)
#uniquename(p)
#uniquename(pre_p)
#uniquename(recs)
#uniquename(get_candidates)
Autokey.Layout_Address %proj%(%indata% le) :=
TRANSFORM
	SELF.prim_name := ut.StripOrdinal(le.inprim_name);
	SELF.prim_range := TRIM(ut.CleanPrimRange(le.inprim_range),LEFT);
	SELF.st := le.inst;
	SELF.city_code := doxie.Make_CityCodes(le.incity_name).tho; 
	SELF.zip := le.inzip;
	SELF.sec_range := le.insec_range;

	SELF.dph_lname := metaphonelib.DMetaPhone1(le.inlname);
	SELF.lname := le.inlname;
	SELF.pfname := NID.PreferredFirstVersionedStr(le.infname, NID.version);
	SELF.fname := le.infname;

	SELF.states := le.instates;
	SELF.lname1 := le.inlname1;
	SELF.lname2 := le.inlname2;
	SELF.lname3 := le.inlname3;
	SELF.lookups := le.inlookups | ut.bit_set(0,0);
	SELF.did := le.indid;
END;
%pre_p% := distribute(PROJECT(%indata%, %proj%(LEFT)),hash(did));


Autokey.Layout_Address  %proj2%(%pre_p% l, %pre_p% r) := 
TRANSFORM
	
	self.lookups:= if(~(l.did=r.did and l.prim_name=r.prim_name and
	l.prim_range= r.prim_range and
	l.st=r.st and 
	l.city_code = r.city_code and
	l.zip =r.zip),r.lookups + ut.bit_set(0,Rep_Addr),r.lookups);
	self := r;
END;

// set the representative address bit on the first record of a set of records with the same
// address, making sure that this first record has the highest lookup value before the rep 
// addr bit is set, so that when address only is searched the representative address record
// is the one for which there are no other causes for exclusion

%p% := iterate(sort(%pre_p%,did,
	-prim_name,-prim_range,
	-st,-city_code,-zip,-sec_range,-lname,-fname,-states,-lname1,-lname1,-lname3,
	-lookups,local),%proj2%(left,right),local);


											 
#uniquename(deduped_p)
Autokey.Mac_deduprecs(%p%(prim_name <> ''),by_lookup,Rep_Addr,%deduped_p%)

// Within each did dedup records where there exists another record with all the same populated fields
// but that has more fields populated. Prefer the favored lookup and from there the lookup bits in descending
// order when deduping across different lookup values within a did

%recs% := ungroup(dedup(
sort(group(sort(%deduped_p%,did,if(ut.bit_test(lookups,rep_addr),0,1),-lookups,local),did,
if(by_lookup=TRUE,lookups,did), local),
-prim_name,-prim_range,-st,-sec_range,-dph_lname,-lname,-pfname,-fname,-states,-lname1,-lname2,-lname3),
left.prim_name=right.prim_name and left.prim_range=right.prim_range and 
(left.st=right.st or right.st='') and
(left.city_code=right.city_code or right.city_code=0) and
(left.sec_range=right.sec_range or right.sec_range='' ) and
(left.dph_lname=right.dph_lname or right.dph_lname='') and
(left.lname=right.lname or right.lname='' ) and
(left.pfname=right.pfname  or right.pfname='') and
(left.fname=right.fname or right.fname='') and
(left.states=right.states or right.states=0) and
(left.lname1 =right.lname1 or right.lname1=0) and
(left.lname2 =right.lname2 or right.lname2=0) and
(left.lname3 =right.lname3 or right.lname3=0))); 



  
outkey := %recs%;//INDEX(%recs%, {%recs%}, inkeyname + '_' + doxie.Version_SuperKey);

ENDMACRO;