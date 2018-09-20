IMPORT DOXIE, AutoStandardI, header, ut;

rec_batch_in := BatchServices.Layouts.Resident.cln_batch_in;
rec_batch_out := BatchServices.Layouts.Resident.batch_out;
export Residents_Records(dataset(rec_batch_in) batch_in, BatchServices.Interfaces.res_config in_mod ) := FUNCTION
  glb_mod := AutoStandardI.GlobalModule();
  mod_access := doxie.functions.GetGlobalDataAccessModuleTranslated (glb_mod);
  glb_ok :=  mod_access.isValidGLB ();
  dppa_ok := mod_access.isValidDPPA ();

// MultiUnitSearch boolean allows to search data and match whole building where sec_range should be necessary but isn't provided
// MultiUnitSearch is used by Best Address reverse search only
	boolean MultiUnitSearch := in_mod.MultiUnitSearch;

	res_key:=doxie.Key_Header_Address;
	rec_hl := header.Layout_Header and not [lname,fname,mname,name_suffix,dob,dt_first_seen,dt_last_seen];
	Res_rec := record
	  rec_hl;
		rec_batch_out;
	end;
	
	//Need dob to be defined as an integer for Header.Mac_GLBClean_Header
	res_rec_int := record
		Res_rec and not [dob];
		integer dob;
	end;
	
	res_rec_int get_Res(rec_batch_in l, res_key R) :=TRANSFORM
	  self.acctno := l.acctno;
		self.dob := 0;
		self.missing_sec_range := L.missing_sec_range;
		SELF := R;
		self := [];
	END;
	// missing sec range avoids the searching of this data
	// below gathers the data to get the date range at this address
	Res_final_all1 := JOIN(batch_in(missing_sec_range=false),res_key,
										  keyed(left.prim_name = right.prim_name) and
											keyed(left.z5 = right.zip) and
											keyed(left.prim_range = right.prim_range) and
											keyed(left.sec_range = right.sec_range) and 
											left.predir = right.predir and
											left.postdir = right.postdir and
											left.addr_suffix =right.suffix and
											// do not pull historical records, if not necessary 
											(in_mod.MaxPriorRes>0 or right.dt_last_seen >= in_mod.ThresholdDateForCurrentResidency)
											,
										 get_Res(LEFT,RIGHT),LIMIT(0),keep(10000));
	Res_final_all2 := JOIN(batch_in(missing_sec_range=true),res_key,
										  keyed(left.prim_name = right.prim_name) and
											keyed(left.z5 = right.zip) and
											keyed(left.prim_range = right.prim_range) and
											keyed(right.sec_range <> '') and 
											left.predir = right.predir and
											left.postdir = right.postdir and
											left.addr_suffix =right.suffix and
											// do not pull historical records, if not necessary 
											(in_mod.MaxPriorRes>0 or right.dt_last_seen >= in_mod.ThresholdDateForCurrentResidency)
											,
										 get_Res(LEFT,RIGHT),LIMIT(0),keep(10000));
	Res_final_all := if(MultiUnitSearch, Res_final_all1+Res_final_all2, Res_final_all1);
	Header.MAC_GlbClean_Header(Res_final_all,Res_final0, , , mod_access);
	res_final := project(res_final0, transform(Res_rec, self.dob := (string)left.dob, self := left));
	s_res := sort(res_final,acctno,did);
 	s_res did_rolluptrans(s_res l,s_res r) := transform // accumalate the date range
			 self.dt_last_seen := max(r.dt_last_seen,l.dt_last_seen);
			 self.dt_first_seen := ut.min2(r.dt_first_seen,l.dt_first_seen); 
   		 self := l;
 	end;
  roll_dids :=  rollup(s_res,left.did = right.did and left.acctno = right.acctno,did_rolluptrans(LEFT,RIGHT));
	
// check to see if there is a missing sec range by looking at unit desig
	apt_rec := record
		roll_dids.acctno;
		unsigned cnt := count(group);
		unsigned cntapt := count(group,roll_dids.unit_desig = 'APT' and roll_dids.sec_range = '');
	end;
	aptTable := table(roll_dids,apt_rec,acctno);
	// remove rows that are in the ds because there is a missing sec so that we do not pull the best records for them
	// not all rows have the 'APT' in the unit_design when the sec range is blank.
  // *3 is being used to not require half to use this feature but should exclude just one or two instances of the unit_designator 
	filt_dids := join(roll_dids,apttable((cntapt*3) < cnt),
								left.acctno = right.acctno,
								transform(Res_rec,self:=left)); 
	
	// update the incoming records with missing sec range
	upd_batch_in := join(batch_in,apttable((cntapt*3) >= cnt),
												left.acctno = right.acctno,
												transform(rec_batch_in,self.missing_sec_range := if (right.acctno='',left.missing_sec_range,true),
												self := left),
												left outer);
// check to see if there is a missing sec range
	
	dd_dids := dedup(sort(filt_dids,did),did);
	dids := project(dd_dids,doxie.layout_references);
  Residents_all := doxie.best_records(dids, , ,false, includeDOD:=true, modAccess := mod_access);
	res_rec cp_trans(roll_dids l, residents_all r) := transform
		self.gender := map ( r.title = 'MR' => 'M',
												r.title = 'MS' => 'F',
												'');
		self.title := r.title;										
		self.deceased := r.adl_ind = 'DEAD';
    self.current := l.prim_name = r.prim_name and
												l.prim_range = r.prim_range 
  											// this would allow the search to not have sec range and this
												//not to get tossed but still be current
												and ut.NNEQ(l.sec_range,r.sec_range)
												and ~self.deceased      // dead people hopefully aren't current residents
												and l.dt_last_seen > in_mod.ThresholdDateForCurrentResidency;
		// best has most current date so grab it from best if current
		self.dt_last_seen := IF(self.current, r.addr_dt_last_seen, l.dt_last_seen);
	  self.dt_first_seen := l.dt_first_seen;												
		ageatdeath := IF(r.dod <> '' and r.dob <> 0,(((integer)r.dod- (integer)r.dob) div 10000),0); 										
		self.age :=  if (ageatdeath > 0, (string3)ageatdeath,(string3)r.age);	
		self.dob := if(r.dob > 0,(string8)r.dob,'');
		self := r;
		self := l;
	end;
  res_cp := join(roll_dids,residents_all,left.did = right.did,cp_trans(left,right)); 
	// return Residents_all;
	s_res_cp := sort(res_cp,acctno,-current,-dt_last_seen);
	// I need to create an entry that points out that we did not do the search because of the missing sec
	res_rec join_trans(batch_in l,s_res_cp r) := transform
		self.acctno := l.acctno;
		self.missing_sec_range := if (r.acctno = '',l.missing_sec_range,r.missing_sec_range);
		self := r;
	end;
	
	trimed_current1 := if(in_mod.MaxCurrRes <> 0, join(upd_batch_in,s_res_cp(current=true), left.acctno = right.acctno,join_trans(left,right),keep(in_mod.MaxCurrRes)));
	trimed_current2 := join(upd_batch_in,s_res_cp(current=true), left.acctno = right.acctno,join_trans(left,right));
	trimed_current := if(MultiUnitSearch, trimed_current2, trimed_current1);
	
	trimed_prior := if (in_mod.MaxpriorRes <> 0 ,join(upd_batch_in,s_res_cp(current=false), left.acctno = right.acctno,join_trans(left,right),keep(in_mod.MaxpriorRes)));
	
	// I might be able to use dedup,keep to replace the join
	s_res_trim := sort(trimed_current + trimed_prior,acctno,-current,-dt_last_seen);
	final_res_pre_phones := join(upd_batch_in,s_res_trim,left.acctno = right.acctno, join_trans(left,right),left outer);
	
	// **************************************************************************************
	// the changes below are part of best address enhancements to perform reverse search 
	// per requirements, reverse search also needs to include address phone 
	ds_in := project(upd_batch_in,
					 transform(BatchServices.Layouts.RTPhones.rec_batch_RTPhones_input, 
							self.orig_acctno:=left.acctno,
							self.acctno:=left.acctno,
							self.prim_range  := left.prim_range,
							self.prim_name := left.prim_name,
							self.p_city_name := left.p_city_name,
							self.st  := left.st,
							self.zip5 := left.z5,
							self:=[]));							
	gmod := MODULE(PROJECT(glb_mod, BatchServices.RealTimePhones_Params.Params, OPT)) 
		export unsigned8 maxResults := 20; // limited to 100 by RTPhones.rec_batch_RTPhones_input layout
	end;											
	addrOnlyPH := BatchServices.SearchInhouse(gmod,ds_in);
	// left address in the join below comes from best address, so essentially we're only adding phones to current records
	final_res_w_phones := join(final_res_pre_phones,addrOnlyPH,
												left.acctno = right.acctno and
												left.prim_range  = right.prim_range and
												left.prim_name = right.prim_name and
												left.city_name = right.p_city_name and
												left.st  = right.st and
												left.zip = right.zip5,
												transform(recordof(res_rec), 
													addr_phones := right.results((left.sec_range='' or sec_range = left.sec_range) and 
																												(dt_last_seen='' or ut.Age((integer)dt_last_seen * 100) < 5));
													self.phone_address	:= addr_phones[1].phone,
													self := left),
												left outer,
												keep(1));			
	// **************************************************************************************

	final_res := if(in_mod.ReturnAddrPhone, final_res_w_phones, final_res_pre_phones);														

	doxie.Layout_comp_addresses v_trans(final_res l, integer c) := transform
	  self.address_seq_no := c;
	   self := l;
		 self.county_name := '';
		 self.hri_address := [];
		 // self := [];
	end;
	// set the verified flag   
	v_in := dedup(sort(project(final_res(current=true and did <> 0),v_trans(left,counter)),did),did);	
	v_ds := doxie.fn_addLVV(v_in).records;

	final_res_verified:= join( final_res,v_ds, left.did = right.did, 
														transform(res_rec,self.verified := right.tnt = 'V', self := left),
														left outer, keep(1));
														
  s_final := sort(final_res_verified, acctno,-current,-dt_last_seen,record);

	/*--- DEBUG ---*/
	// output(aptTable,named('aptTable'));
	// output(batch_in,named('clnbatchin'));
	// output(Res_final_all,named('resfinalall'));
	// output(res_final,named('resfinal'));
  //output(Residents_all,named('bestrecs'));
	// output(final_res,named('final_res_usedToVerify'));
	// output(v_in,named('v_in'));
	// output(v_ds,named('v_ds'));
	// output(s_final,named('s_final'));
	
	return s_final;
END;