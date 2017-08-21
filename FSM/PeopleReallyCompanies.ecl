f := person_names;

sfirst := datalib.companyclean('abc '+f.fname)[41..120]<>'';
slast := datalib.companyclean('abc '+f.lname)[41..120]<>'';

// either both bad or one bad with low ssn count
//plain_bad := sfirst and slast or ( sfirst or slast ) and f.ssn_cnt * 20 < f.cnt;
plain_bad := sfirst and slast;// or ( sfirst or slast ) and f.ssn_cnt * 20 < f.cnt and f.cnt > 10;

// check for city - bad lname

j1 := join( f(slast,~plain_bad,cnt>10,dob_cnt=0,ssn_cnt=0),fsm.Cities(cnt>10000),left.fname=right.city_name,transform(left),lookup );


j := f( plain_bad );

export PeopleReallyCompanies := j+j1 : persist('fsm::notreallypeople');