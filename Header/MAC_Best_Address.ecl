export MAC_Best_Address
(
	infile, 
	did_field, 
	addresses_per_DID, 
	outfile,
	bool_want_street_address = 'false',
	use_exp_out = 'false',
	best_non_DandB_addr = 'false'
) := macro
import MDR;

#uniquename(rfields)
%rfields% := record
unsigned6 did_field;
unsigned6 rid;
string2   source := '';
integer4      dt_first_seen;
integer4      dt_last_seen;
integer4      dt_vendor_last_reported;
integer4      dt_vendor_first_reported;
integer4      dt_nonglb_last_seen;
string1      rec_type;
qstring10      prim_range; // ?5 bytes
string2      predir; // int1 lookup
qstring28      prim_name;
string4      suffix; // int1 lookup
string2      postdir; // int1
qstring10      unit_desig; // int1 lookup
qstring8      sec_range; // ?
qstring25     city_name; // ?int4 lookup?
string2      st; // int1 lookup
qstring5      zip; // udecimal5
qstring4      zip4; // unsigned2
string1      tnt := ' ';
unsigned8 RawAID:=0;
#IF(use_exp_out)
 qstring20    fname;
 qstring20    mname;
 qstring20    lname;
 qstring5     name_suffix;
 qstring9     ssn;
 integer4     dob;
#END
  end;

#uniquename(addr_filt)
#if(bool_want_street_address)
%addr_filt% := infile;
#else
%addr_filt% := infile(address.AddressQuality(prim_range,prim_name,suffix,sec_range,city_name,zip, zip4)=0);
#end

#uniquename(slim)
%rfields% %slim%(infile le) := transform
self := le;
  end;

#uniquename(slim_h)
%slim_h% := distribute(project(%addr_filt%,%slim%(left)),hash(did_field));

#uniquename(tnt_gd)
%tnt_gd% := map(%slim_h%.tnt='Y' => 1,
				%slim_h%.tnt='P' => 2,0);

#uniquename(street_addr)
#if(bool_want_street_address)
%street_addr% := map(
	%slim_h%.prim_name = '' and %slim_h%.prim_range = '' and %slim_h%.city_name = '' and %slim_h%.zip = '' and %slim_h%.st = ''
		=> 0,
    %slim_h%.prim_name = '' => 1, 
	%slim_h%.prim_name[1..7] = 'PO BOX ' or %slim_h%.prim_name[1..3] in ['RR ', 'HC ']
		=> 2, 3);
#else
%street_addr% := 1;
#end

#uniquename(add_score)
%add_score% := map(%slim_h%.zip4 != '' => 4,
				   %slim_h%.prim_range != '' => 3,
				   %slim_h%.sec_range != '' => 2,
				   %slim_h%.prim_name != '' => 1,0);

#uniquename(st_zip)
%st_zip% := if(ziplib.ZipToState2(%slim_h%.zip)=%slim_h%.st,1,0);

#uniquename(srt_h)
#if(bool_want_street_address)
%srt_h% := sort(%slim_h%,did_field,-%street_addr%,-dt_last_seen,rec_type,-%tnt_gd%,-dt_first_seen,
				-dt_vendor_first_reported,-%add_score%,-prim_range,-predir,-prim_name,
				-suffix,-postdir,-unit_desig,-sec_range,-city_name,-zip,-zip4,-%st_zip%,st,local);
#else
%srt_h% := sort(%slim_h%,did_field,               -dt_last_seen,rec_type,-%tnt_gd%,-dt_first_seen,
				-dt_vendor_first_reported,-%add_score%,-prim_range,-predir,-prim_name,
				-suffix,-postdir,-unit_desig,-sec_range,-city_name,-zip,-zip4,-%st_zip%,st,local);
#end
#uniquename(grp)
%grp% := group(%srt_h%,did_field,local);

#uniquename(grp_best_All)
%grp_best_All% := dedup(%grp%,did_field,prim_range,prim_name,zip);

/* This transformation is used to possibly select the 2nd address for a bdid pair. If the most recent address
is from a D&B record, check the second most recent and if the address parts match use it instead. Reason being is
that we are not legally allowed to display the street information from a D&B source, so if a matching address exists
from another source we will use that one instead.
*/

#uniquename(roll_best_non_DandB_addr)
%rfields% %roll_best_non_DandB_addr%(%grp% l, %grp% r) := TRANSFORM
		#uniquename(L_Full_Addr)
	  %L_Full_Addr% := L.prim_range + L.prim_name + L.zip;
		#uniquename(R_Full_Addr)
		%R_Full_Addr% := R.prim_range + R.prim_name + R.zip;
		SELF := IF (L.source != MDR.sourceTools.src_Dunn_Bradstreet, l,  // If source isn't D&B use the first rec (left record)
														 IF( %L_Full_Addr% = %R_Full_Addr%, R, L));  // If the address match, use the second (right) record
		 
END;

#uniquename(grp_best_nonDandB)
%grp_best_nonDandB% := ROLLUP(dedup(%grp%,did_field,prim_range,prim_name,zip,KEEP 2)
														,%roll_best_non_DandB_addr%(LEFT,RIGHT),did_field);

#uniquename(wipe_dble)
%wipe_dble% := IF (best_non_DandB_addr,%grp_best_nonDandB%,%grp_best_All%);

#uniquename(k2)
%k2% := dedup(%wipe_dble%,did_field,keep addresses_per_DID);

#uniquename(enum)
%rfields% %enum%(%rfields% le, %rfields% r) := transform
  self.rec_type := (string1)((integer)le.rec_type+1);
  self := r;
  end;

outfile := iterate(%k2%,%enum%(left,right));

endmacro;