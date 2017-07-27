/*
instream - an existing set of results from startsearch or a previous andsearch
zip_set - the zipcodes to select people from
low_date - the earliest interesting date for the person being in this zip.
           Zero implies 'or earlier' and the score is higher close to the given date
high_date - the latest interesting date for the person being in this zip
           Zero implies 'or later'  and the score is higher closer to the given date
weight - significance to attach, increase to indicate a definate knowledge that the
         person was living there, or increase to counterbalance a short time-span
outfile - a label of the results coming out
*/

export And_MoveInSearch(instream,zip_set,low_date,high_date,weight='1',outfile) := MACRO

#uniquename(date_score)
%date_score%(unsigned4 cand) :=
  MAP( low_date=0 and high_date=0 =>1,
       low_date=0 and cand > high_date => 0,
       low_date=0 => weight*( 1 + 12 div (high_date-cand+1)),
       high_date=0 and cand < low_date => 0,
       high_date=0 => weight*( 1 + 12 div (cand-low_date+1)),
       low_date <= cand and high_date>= cand =>weight , 0);

#uniquename(score_movin)
ResultRecord %score_movin%(doxie.keytype_troy ri) := transform
  self.score := %date_score%(ri.first_seen);
  self.did := ri.did;
  end;


#uniquename(cands)
%cands% := dedup(sort(distribute(project(TheKey(zip IN zip_set,gender IN ['M','U'],%date_score%(first_seen)<>0),%score_movin%(left)),did),did,local),did,local);

outfile := join(instream,%cands%,left.did=right.did,take_did(left,right),local);

  ENDMACRO;