/*
THE GENERAL IDEA HERE IS THAT WE CAN USE THE BEST FILE TO FIND OBVIOUS PRIM_NAME PATCHES.
IF TWO RECORDS MATCH EXACTLY ON COMPANY NAME, PRIM_RANGE, ZIP,
	AND THEY PARTIALLY MATCH ON PRIM_NAME,
	AND ONE HAS A VALID ZIP 4 AND THE OTHER DOESNT,
  THEN THE LATTER SHOULD PROBABLY USE THE FORMER'S PRIM_NAME AS ITS OWN DERIVED PRIM NAME
*/
import bipv2_Best, ut;
EXPORT fn_derive_pn(
	dataset(bipv2.CommonBase.layout) h
) := FUNCTION
// GET THE BEST INDEX INTO A USABLE FORMAT
// NOTE THAT SINCE WE USE BEST HERE, WE ARE USING LAST MONTHS DATA.  WE COULD LIKELY USE THE INPUT HEADER FILE HERE INSTEAD.
b := choosen(bipv2_Best.Key_LinkIds.key_static, all)(proxid <> 0);// records with proxid = 0 are for SELE Best and are not needed here
hr := bipv2.CommonBase.Layout;
bfr := {hr.proxid, hr.company_name, hr.prim_range, hr.prim_name, typeof(hr.prim_name) prim_name_derived, hr.sec_range, hr.v_city_name, hr.st, hr.zip, hr.zip4};
bf :=
project(
  b,
  transform(
    bfr,
    self.company_name   :=  left.company_name[1].company_name;
    ca := left.company_address[1];
    self.prim_range := ca.company_prim_range;
    self.prim_name := ca.company_prim_name;
		self.prim_name_derived := '';
    self.sec_range := ca.company_sec_range;
    self.v_city_name := ca.address_v_city_name;
    self.st := ca.company_st;
    self.zip := ca.company_zip5;
    self.zip4 := ca.company_zip4;
    self := left;
  )
)(length(trim(company_name, all)) > 5);//>5 is to be on the safe side with our matches by company name
// JOIN BEST TO ITSELF TO FIND THE DERIVED PRIM NAMES
bf_clean :=   bf(zip4 <> '');
bf_unclean := bf(zip4 = '');
jprd :=
join(
	bf_clean,
	bf_unclean,
	left.company_name = right.company_name and
	left.prim_range <> '' and left.prim_range = right.prim_range and
	left.zip <> '' and left.zip = right.zip and
	left.prim_name <> right.prim_name and
	(
	  length(trim(left.prim_name)) >= 3 and
	  length(trim(right.prim_name)) >= 3 and
		(
	    left.prim_name[1..3] = right.prim_name[1..3] or
		  stringlib.stringfind(left.prim_name, trim(right.prim_name), 1) > 0 or
		  stringlib.stringfind(right.prim_name, trim(left.prim_name), 1) > 0 or
			(length(trim(left.prim_name)) >= 5 and ut.withineditn(left.prim_name, right.prim_name, 1))
		)
	)
	,
	transform(
		bfr,
		self.prim_name_derived := left.prim_name,
		self:= right
	),
	hash
) : persist('~persist::bipv2.fn_derive_pn.jprd', expire(7));
// jpr := dedup(jprd, all);
// PUT THESE 0NTO THE INPUT HEADER FILE
// h_try  := h(zip4 = '');
// h_skip := h(zip4 <> '');
rh2 := {recordof(h) or {typeof(h.prim_name) prim_name_derived := ''}};//should be flexible enough to span a layout change and then the prim_name_derived part of this can be removed
put :=
join(
	h,
	dedup(jprd, proxid, prim_range, prim_name, all), //this ensures we dont create dups as long as it matches the join blocking criteria.
	left.proxid = right.proxid and
	left.prim_range = right.prim_range and
	left.prim_name = right.prim_name and
	left.zip4 = '' and
	((left.zip <> '' and left.zip = right.zip) or (left.v_city_name <> '' and left.v_city_name = right.v_city_name))
	,transform(
		rh2,
		self.prim_name_derived := if(right.prim_name_derived <> '', right.prim_name_derived, left.prim_name),
		self := left
	)
	,smart
	,left outer
	,keep(1) //likely not necessary given dedup, all on RHS above, but doesnt hurt anything
);
// + project(h_skip, transform(rh2, );
return put;
// import lksd;
// lksd.o(bf)
// lksd.o(jpr)
// lksd.ec(jpr)
//output the most common derived combinations for review
/*
t := table(jpr, {jpr.prim_range, jpr.prim_name_derived, jpr.zip, jpr.company_name, cnt := count(group)}, prim_range, prim_name_derived, zip, company_name);
s := sort(t(cnt > 1), -cnt);
lksd.oc(s)
a :=
join(
	jpr,
	s,
	left.prim_range = right.prim_range and
	left.prim_name_derived = right.prim_name_derived and
	left.company_name = right.company_name and
	left.zip = right.zip,
	transform(
		{jpr, s.cnt},
		self.cnt := right.cnt,
		self := left
	)
	,hash
);
f := sort(a, -cnt, prim_range, prim_name_derived, company_name);
lksd.o(f)
*/
END;