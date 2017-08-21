import doxie_regression,business_header;

f1 := accounting.File_Accounting(price=0,record_count=0,free=0,transaction_type='I',function_name='peopleatwork');

f := f1;//distribute( choosen(f1,10000), random() );

Doxie_Regression.Layout_TestLayout proj(f le,integer c) :=
TRANSFORM
	SELF.seq := c;
  self.firstname := le.fname;
	self.middlename := le.mname;
	self.lastname := le.lname;
	self.addr := le.address;
	self.city := le.city;
	self.state := le.state;
  self.zip := le.zip;
	self.phone := le.phone;
  self.ssn := le.ssn;
  self.dppapurpose := (string)le.dl_purpose;
	self.dob := le.dob;
	self.glbpurpose := (string)le.glb_purpose;
	self.skiprecords := '0';
	self.maxresultsthistime := '5';
	self.function := '';
	self.allownicknames := 'TRUE';
	self.phoneticmatch := 'FALSE';
	self.agelow := '';
	self.agehigh := '';
	self.zipradius := '';
	self.county := '';
END;

p := PROJECT(f, proj(LEFT, COUNTER));

Doxie_Regression.Layout_HFSS_out ft(Doxie_Regression.Layout_TestLayout inn) :=
TRANSFORM
	SELF.seq := inn.seq;
	SElF.code := IF(FAILCODE = 0, -1, FAILCODE);
	SELF.message := FAILMESSAGE;
	SELF := [];
END;
res := soapcall(p, 'http://roxiebatch.br.seisint.com:9856', 'doxie.HeaderFileSearchService', {p}, 
				DATASET(Doxie_Regression.Layout_HFSS_out), PARALLEL(4), onFail(ft(LEFT))) : PERSIST('maltemp::pawss');
				
Fails := dedup(res(code<>0),seq,all);	
FailsNumber := count ( Fails );

output( FailsNumber*100/count(p) , Named('Header_PercentageFailing') );

output ( choosen( Fails,1000 ), Named('Header_Fail_Examples') );


Hits := dedup(table(res(code=0),{seq,unsigned fdid := (unsigned)did}),seq,fdid,all);

output( count( dedup(Hits,seq,all) ), Named('Seqs_Found') );
output( count(Hits)/count( dedup(Hits,seq,all) ), Named('Ave_DIDs_per_seq') );

bh := business_header.Key_Employment_Did;

r := record
  unsigned seq;
	bh;
  end;

r take_bdid(Hits le,bh ri) := transform
  self := le;
  self := ri;
  end;

//j := join( Hits, business_header.File_Business_Contacts(did<>0,bdid<>0),left.fdid=right.did,take_bdid(left,right) );
j := join( Hits, bh((unsigned)bdid<>0),(unsigned)left.fdid=(unsigned)right.sdid,take_bdid(left,right) );

ihits := dedup(sort( j, seq, -score ),seq,all);

output( count(ihits), Named('Seqs_Returning_Businesses') );

ut.MAC_Field_Count(ihits,ihits.score);

pv := join(p,ihits,left.seq=right.seq,transform(left));

output( choosen(sort(j,seq),1000),Named('Contact_Results') );
output( choosen(sort(pv,seq),1000),Named('Queries_Succeeding') );