/*
instream - an existing set of results from startsearch or a previous andsearch
zip_in - the zipcodes to select people from
low_date - the earliest interesting date for the person being in this zip
high_date - the latest interesting date for the person being in this zip
outfile - a label of the results coming out
*/

export And_TroySearch_not_in_zip(instream,zip_in,low_date,high_date,Radius,outfile) := MACRO

#uniquename(zs)
%zs% := ziplib.zipswithinradius(zip_in,Radius);
#uniquename(tk)
%Tk% := TheKey(zip not IN %zs%,gender IN ['M','U',' ',''],age=0 or age>=agelow,age<=agehigh,ut.date_overlap(first_seen,last_seen,low_date,high_date)>0); //,
//              ut.bit_test(states,StCode1),
//		    ut.bit_test(states,StCode2),
//		    StCode3=0 or ut.bit_test(states,StCode3));

#uniquename(pjt)
%pjt% := project(%Tk%,make_first(left,zip_in,low_date,high_date));

#uniquename(cands)
%cands% := rollup(sort(distribute(%pjt%,did),did,local),left.did=right.did,take_did(left,right),local);

outfile := join(instream,%cands%(score>0),left.did=right.did,take_did(left,right),local);

  ENDMACRO;