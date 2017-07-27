import ut, doxie_crs, header, CriminalRecords_Services, doxie;

r := doxie.relative_records(header.constants.checkRNA);
doxie.MAC_Selection_Declare();
unsigned1 t_age := if(r.dob=0,0,ut.age(r.dob));
re := record
  unsigned1 depth := min(group,r.depth);
  r.p2_sort;
  r.p3_sort;
  r.p4_sort;
  r.person2;
  unsigned1 age := max(group,t_age);
  r.fname;
  r.mname;
  r.lname;
  unsigned2 cnt := count(group);
  boolean relative := max(group,r.isRelative);
  boolean aka := false;
	typeof(r.recent_cohabit)  recent_cohabit  := max(group, r.recent_cohabit);
	typeof(r.number_cohabits) number_cohabits := max(group, r.number_cohabits);
  boolean HasCriminalConviction := false;
  boolean IsSexualOffender := false;
	string relationship := Header.relative_titles.fn_get_str_title(r.titleno);
	string15 relationship_type := r.type;
	string10 relationship_confidence := r.confidence;
  end;
  
re add_cnt(re le,re ri) := transform
  self.cnt := le.cnt+ri.cnt;
  self := le;
  end;  
  
t := group(table(r,re,p2_sort,p3_sort,p4_sort,person2,fname,mname,lname),p2_sort,p3_sort,person2);

st1 := sort(t,fname,lname,-mname);

r_snames := rollup(st1,left.fname=right.fname and left.lname=right.lname and
                     left.mname[1..length(trim(right.mname))]=right.mname,add_cnt(left,right));
					 
st2 := rollup(sort(r_snames,lname,mname,-fname),left.lname=right.lname and left.mname=right.mname and 
                      left.fname[1..length(trim(right.fname))]=right.fname,add_cnt(left,right));

st := sort(st2,-cnt,-age,-lname,-fname);					 

re add_aka(st le, st ri) := transform
  self.aka := le.person2 = ri.person2;
  self := ri;
  end;

iter := iterate(st,add_aka(left,right));
outrec := doxie_crs.layout_relative_summary;
ut.MAC_Slim_Back(iter, outrec, outtemp)

// add crim indicators
recsIn := PROJECT(outtemp,TRANSFORM({outrec,STRING12 UniqueId},SELF.UniqueId:=(STRING)LEFT.person2,SELF:=LEFT,SELF:=[]));
CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
outfile := PROJECT(IF(include_CriminalIndicators_val,recsOut,recsIn),outrec);

export relative_summary := outfile;