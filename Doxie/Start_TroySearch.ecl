/*
zip_in - the zip to select people from
low_date - the earliest interesting date for the person being in this zip
high_date - the latest interesting date for the person being in this zip
outfile - a label of the results coming out
*/
export Start_TroySearch(zip_in,low_date,high_date,outfile) := MACRO

TheKey := doxie.key_troy;

zs := ziplib.zipswithinradius(zip_in,Radius);

co1 := TheKey(zip IN zs,gender IN [pGender,'U'],age=0 or age>=agelow,
              age<=agehigh,ut.date_overlap(first_seen,last_seen,low_date,high_date)>0,
		    ut.bit_test(states,StCode1),
		    ut.bit_test(states,StCode2),
		    StCode3=0 or ut.bit_test(states,StCode3));

ResultRecord := record
  unsigned6 did;
  unsigned2 score;
  end;

ResultRecord take_did(ResultRecord le, ResultRecord ri) := transform
  self.score := le.score + ri.score;
  self.did := le.did;
  end;

ResultRecord make_first(TheKey ri, string5 req_zip, unsigned4 ldate, unsigned4 hdate) := transform
/*  self.score := IF( low_date<>0 or high_date<>0,
                ut.date_overlap(ri.first_seen,ri.last_seen,ldate,hdate)
                ,1 ) * 20 / ( 1 + ut.zip_Dist((string5)ri.zip,req_zip) ); */
  self.score := radius + 1 - ut.zip_dist((string5)ri.zip,req_zip);			 
  self.did := ri.did;
  end;

co := project(co1,make_first(left,zip_in,low_date,high_date));

outfile := rollup(sort(distribute(co,did),did,local),left.did=right.did,take_did(left,right),local);

  ENDMACRO;