export fnOverrideFilingStatus(dataset(recordof(liensv2.file_liens_main)) in_ds) := function

 satisfied_set := [
  'DISMISSED JUDGMENT'
 ,'DISMISSED SUITS'
 ,'SATISFACTIONS'
 ,'SATISFIED JUDGMENT'
 ,'VACATED JUDGMENT'
 ,'FEDERAL TAX RELEASE'
 ,'ILLINOIS TAX RELEASE'
 ,'STATE TAX RELEASE'
 ];

 r1 := record
  string2 source_from_tmsid;
  boolean is_satisfied;
  in_ds;
 end;

 r1 xform1(in_ds le) := transform 
  self.source_from_tmsid := le.tmsid[1..2];
  self.is_satisfied      := false;
  self                   := le;
 end;

 p1 := project(in_ds,xform1(left));

 impacted_sources     := p1(source_from_tmsid in ['CJ','CL']);
 non_impacted_sources := project(p1(source_from_tmsid not in ['CJ','CL']),recordof(in_ds));

 r1 xform2(impacted_sources le) := transform
  self.is_satisfied := le.filing_type_desc in satisfied_set;
  self              := le;
 end;

 p2      := project(impacted_sources,xform2(left));
 p2_dist := sort(distribute(p2,hash(tmsid)),tmsid,local);

 r1 xform3(r1 le, r1 ri) := transform
  self.is_satisfied := if(le.is_satisfied=true,le.is_satisfied,ri.is_satisfied);
  self              := le;
 end;

 p3 := rollup(p2_dist,left.tmsid=right.tmsid,xform3(left,right),local);
 is_closed     := p3(is_satisfied=true);
 is_not_closed := p3(is_satisfied=false);//tmsid's for those impacted sources which do not have a released status

 recordof(in_ds) xform4(r1 le, r1 ri) := transform
  self.filing_status := row({le.filing_status[1].filing_status,'UPDATES MAY BE PRESENT ELSEWHERE IN THIS REPORT; CHECK THE COURT FOR THE CURRENT STATUS'},liensv2.Layout_liens_main_module.layout_filing_status); 
  self               := le;
 end;

 changed_records   := join(p2_dist,is_not_closed,left.tmsid=right.tmsid,xform4(left,right),local);
 unchanged_records := join(p2_dist,is_closed,left.tmsid=right.tmsid,transform({recordof(in_ds)},self:=left),local);

 concat := changed_records + unchanged_records + non_impacted_sources;

//moved bug 77059 to here
 recordof(in_ds) xform5(recordof(in_ds) le) := transform
  self.filing_status := row({le.filing_status[1].filing_status, if(stringlib.stringtouppercase(trim(le.filing_status[1].filing_status_desc,left,right))in ['OPEN','NOT UPDATED'], 'UPDATES MAY BE PRESENT ELSEWHERE IN THIS REPORT; CHECK THE COURT FOR THE CURRENT STATUS', le.filing_status[1].filing_status_desc)},liensv2.Layout_liens_main_module.layout_filing_status);
	self := le;
 end;
	
 p4 := project(concat,xform5(left));	 
			 
 return p4;

end;