export MAC_ZipPRLName_Can(indataset,infname,inmname,inlname,
						inbname,	//this is usually the ssn parameter, but i am using it to carry company_name in the cananda build
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
import ut, doxie;

#uniquename(indata)
%indata% := indataset;

#uniquename(proj)
#uniquename(p)
#uniquename(recs)
canadianphones.layouts.ZipPRLName %proj%(%indata% le, string thelname) :=
TRANSFORM
	SELF.zip := le.inzip;
	SELF.prim_range := TRIM(ut.CleanPrimRange(le.inprim_range),LEFT);
	SELF.lname := trim(thelname,LEFT);
	SELF.lookups := le.inlookups | ut.bit_set(0,0);
	SELF.did := le.indid;
END;
set_nulls := ['','0'];
%p% := 
	distribute(
		PROJECT(%indata%(inzip != '' and inprim_range <> '' and (string)inlname not in set_nulls), %proj%(LEFT,(string)LEFT.inlname)) + 
		PROJECT(%indata%(inzip != '' and inprim_range <> '' and (string)inbname not in set_nulls), %proj%(LEFT,(string)LEFT.inbname)),
		hash(did)
	);


Autokey.Mac_deduprecs(%p%,by_lookup,favor_lookup,%recs%)


outkey := INDEX(%recs%, {%recs%}, inkeyname + '_' + doxie.Version_SuperKey);

ENDMACRO;