IMPORT  PromoteSupers,prte2_header,header, prte_csv;

EXPORT PROC_BUILD_SSN_BASE := FUNCTION

																 
hdr:=project(prte_csv.ge_header_base.AlphaFinalHeaderDS,
Transform(layouts.Layout_Header_Link,
Self:=Left;
self := []; 
));

unsigned4 minDate (unsigned4 dt1, unsigned4 dt2) := MAP(dt1 = 0 => dt2,dt2 = 0 => dt1,min(dt1,dt2));
unsigned4 first6  (unsigned4 dt)                 := IF(dt > 999999,dt/100,dt);

																				 
bocaTUUnrestricted  := distribute(
                           project(files.Ancillary_Temp(src in constants.TU_sources),
												           transform(Layouts.slimrec,
																	 self.src     := left.src,
															     self.rec_cnt := 1,
																	 self := left, self:=[])),hash(did));
	

	
goodhdr := hdr(ssn<>'' AND ssn[1..5]<>'00000');

slimhdr := sort(distribute(project(goodhdr,
                                   transform(Layouts.slimrec,
																	 	self.src_rank:=1;
																	 self.rec_cnt := 1,
																	 self.dt_first_seen            := first6(left.dt_first_seen),
														       self.dt_last_seen             := first6(left.dt_last_seen),
														       self.dt_vendor_first_reported := first6(left.dt_vendor_first_reported),
														       self.dt_vendor_last_reported  := first6(left.dt_vendor_last_reported),
																	 self:=left, self:=[])),
								hash(did)) + bocaTUUnrestricted,did,ssn,src,local);
								

													 
r1      := rollup(slimhdr,
                   left.did = right.did AND left.ssn = right.ssn,
                   transform(recordof(left),
									           self.dt_first_seen            := minDate(left.dt_first_seen,right.dt_first_seen),
														 self.dt_last_seen             := max(left.dt_last_seen,right.dt_last_seen),
														 self.dt_vendor_first_reported := minDate(left.dt_vendor_first_reported,right.dt_vendor_first_reported),
														 self.dt_vendor_last_reported  := max(left.dt_vendor_last_reported,right.dt_vendor_last_reported),
														 self.rec_cnt                  := 1,
														 self := right,
														 self := left), local);


first := dedup(sort(r1,did,dt_first_seen,dt_vendor_first_reported,local),did,local);
last  := dedup(sort(r1,did,-dt_last_seen,-dt_vendor_last_reported,local),did,local);

//set confirmation flags

hdr_boca_slim    := project(files.Ancillary_Temp,layouts.boca_slimrec): GLOBAL;
EQ_confirmed_ssn := dedup(sort(hdr_boca_slim(src='EQ'),did,ssn,local),did,ssn,local);
BK_confirmed_ssn := dedup(sort(hdr_boca_slim(src='BA'),did,ssn,local),did,ssn,local);
confirmed_ssn    := dedup(sort(EQ_confirmed_ssn + BK_confirmed_ssn,did,ssn,local),did,ssn,local);

rankdata := fn_best_ssn(goodhdr).ranked;

//Add Cluster
seg := distribute(corecheck,hash(did)); 

//	Populating RAKING Logic
j1 := join(r1,seg,
left.did = right.did,
transform(recordof(left),
self.cluster := 'CORE',
self.dob := right.dob, 
// src_boca_header := 'ADL'; // Public Header from Boca found in the Insurance file
self.src_rank := MAP(left.src in ['BX','6X','VD','PD','FD','MD','D$',
'D2','D9','D0','CY','FV','SV','YE',
'FW','BW','DE','BA','ZT','UW'] => 9,
left.src in ['ZK','UT','MW','DS','EN'] => 8,
left.src = 'LI' => 7,
left.src in ['EQ','MI'] => 6,
5),
self.score := left.rec_cnt * self.src_rank; 
self := left), local);


//Add isFirst
j2  := join(j1,first,
               left.did = right.did AND
							 left.ssn = right.ssn,
							 transform(recordof(left),
							           self.isFirst := left.did=right.did AND left.ssn=right.ssn;
												 self := left), left outer, local);
												 

											 
//Add isLast
j3  := join(j2,last,
               left.did = right.did AND
							 left.ssn = right.ssn,
							 transform(recordof(left),
							           self.isLast := left.did=right.did AND left.ssn=right.ssn;
												 self := left), left outer, local);
//Add isConfirmed
j4  := join(j3,confirmed_ssn,
               left.did = right.did AND
							 left.ssn = right.ssn,
							 transform(recordof(left),
							           self.isConfirmed := left.did=right.did AND left.ssn=right.ssn;
												 self := left), left outer, local);

parent  := dedup(sort(project(j4,transform(layouts._main,self:=left,self:=[])),did,local),did,local);
rchild1 := rollup(sort(project(j4,
                              transform(layouts.subject_rec,
																				self._subject._ssndata.isOriginal   := left.isFirst,
																				self._subject._ssndata.isMostRecent := left.isLast,
                        								self._subject.confidence            := 1;                                      
																				self._subject._ssndata:=left,
																				self._subject:=left,
																				//self.isAllSuppress := left.isSuppress,
																				self:=left,
															          self:=[])),
											did,_subject.ssn,local),
							   left.did = right.did AND 
								 left._subject.ssn = right._subject.ssn,
								 transform(recordof(left),
								           self._subject.score := IF(left._subject.ssn = right._subject.ssn, 
														                               left._subject.score + right._subject.score,
																									         right._subject.score),
                           self._subject._ssndata.ssn_ind := IF(left._subject.ssn = right._subject.ssn,
													                                      IF(left._subject._ssndata.ssn_ind='',
																																   right._subject._ssndata.ssn_ind,
																																	 left._subject._ssndata.ssn_ind),
																										 right._subject._ssndata.ssn_ind),
													 self := left,
													 self := right),local);


clean := dedup(sort(rchild1,did,local),did,local);

cleanParent := join(parent,clean,
                    left.did = right.did,
										transform(recordof(left),
										          self:=left),local);
 rchild2 := join(rchild1,rankdata,
                left.did          = right.did AND
								left._subject.ssn = right.ssn,
                              transform(layouts.subject_plus_rec,
                                        self.total_sources     := right.total_sources,
																			  self.dt_last_seen      := first6(right.dt_last_seen),
																				self.in_bureau_and_ssa := right.in_bureau_and_ssa,
																				self.subject._subject  := left._subject,
																				self.subject:=left), left outer, local);
																				
																			
rchild2a := project(rchild2,
                    transform(layouts.subject_plus_rec,
                                       self.subject._subject.score := left.subject._subject.score + 
																				             IF(left.subject._subject._ssndata.ssn_ind='G',50,0) +
																										 IF(left.in_bureau_and_ssa,50,0) +
																										 IF(left.subject._subject._ssndata.isConfirmed,20,0) +
																										 IF(left.subject._subject._ssndata.isMostRecent,10,0) +
																										 IF(left.subject._subject._ssndata.isOriginal,10,0);
																				self:=left));																				

//Set Confidence
child1  := project(iterate(sort(rchild2a,subject.did,-subject._subject.score,-total_sources,-dt_last_seen,-subject._subject.ssn,local),
                                TRANSFORM(layouts.subject_plus_rec,
									                        self.subject._subject.confidence := IF(left.subject.did = right.subject.did, 
														                                                     left.subject._subject.confidence + 
																									                               right.subject._subject.confidence,
																									                               right.subject._subject.confidence);                                       
																					self:=right), local),
										TRANSFORM(layouts.subject_rec,
														  self:=left.subject));

child2  := dedup(sort(project(j4,
                              transform(layouts.other_rec,
																				self._other._ssndata.isOriginal   := left.isFirst,
																				self._other._ssndata.isMostRecent := left.isLast,
																				self._other._ssndata:=left,
                                        self._other:=left,
																				self:=left,
																				self:=[])),
											_other.did,ssn,local),
								 _other.did,ssn,local);

child3  := dedup(sort(project(j4(ssn[1..5]<>'00000'),
                              transform(layouts.src_rec,
                                     									          
																				self._src:=left,
																				self:=left,
																				self:=[])),
											did,ssn,_src.src,local),
								 did,ssn,_src.src,local);


layouts.subject_rec denorm1(layouts.subject_rec l, dataset(layouts.src_rec) r) := TRANSFORM
	self._subject._ssndata.srcs := project(r,
	                                       transform(layouts._src_rec,
                                                                                            
																									 self.ispriortodob := first6(l.dob) > left._src.dt_first_seen and left._src.dt_first_seen > 0,
																				           self:=left._src)),
	self := l;
	self := [],
end;


layouts.other_rec denorm2(layouts.other_rec l, dataset(layouts.src_rec) r) := TRANSFORM
	self._other._ssndata.srcs := project(r,
	                                     transform(layouts._src_rec,
                                                                                            
																								 self.ispriortodob := first6(l.dob) > left._src.dt_first_seen and left._src.dt_first_seen > 0,
																			           self:=left._src));
	self := l;
	self := [],
end;

layouts.subject_rec denorm3(layouts.subject_rec l, dataset(layouts.other_rec) r) := TRANSFORM
	self._subject.other := project(r,transform(layouts._other_rec,self:=left._other));
	self := l;
	self := [],
end;

layouts._main denorm4(layouts._main l, dataset(layouts.subject_rec) r) := TRANSFORM
	self.subject := project(r,transform(layouts._subject_rec,self:=left._subject));
	self := l;
	self := [],
end;

//sources in a subject
d1  := denormalize(child1,child3,
                  left.did = right.did AND
									left._subject.ssn = right.ssn,
									GROUP,
                  denorm1(left,ROWS(right)),local);

//sources in other
d2  := denormalize(child2,child3,
                  left._other.did = right.did AND
									left.ssn = right.ssn,
									GROUP,
                  denorm2(left,ROWS(right)),local)(count(_other._ssndata.srcs)>0);
trec := record
  d2.ssn;
	cnt := count(group);
end;
didcnt := table(sort(distribute(d2,hash(ssn)),ssn,local),trec,ssn,local);

//other in subject
d2a := dedup(sort(distribute(d2,hash(ssn)),ssn,_other.cluster,_other._ssndata.ssn_ind<>'G',_other.did,local),left.ssn=right.ssn,KEEP(20),local);
d3  := denormalize(distribute(d1,hash(_subject.ssn)),d2a,
                  left._subject.ssn = right.ssn AND 
									left.did <> right._other.did,
									GROUP,
                  denorm3(left,ROWS(right)),local);
d3a := join(d3,didcnt,
            left._subject.ssn = right.ssn,
						transform(recordof(left),
						          self._subject.other_cnt := right.cnt - 1,
											self := left), left outer, hash);

//subject in outrec
d4  := denormalize(cleanParent,sort(distribute(d3a,hash(did)),did,(integer) _subject.confidence,local),
                  left.did = right.did,
									GROUP,
                  denorm4(left,ROWS(right)),local);

									
inFile:= d4;

PromoteSupers.MAC_SF_BuildProcess(inFile,constants.SuperName1, writefile);
 
return Writefile;

END;