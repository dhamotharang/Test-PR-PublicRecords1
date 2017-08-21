import header,ut,mdr;

export Vehicle_as_header(	dataset(VehicleV2.Layout_Base_Main)		pVehiclemain		=	dataset([],VehicleV2.Layout_Base_Main),
													dataset(VehicleV2.Layout_Base.Party_bip)	pVehicleSearch	=	dataset([],VehicleV2.Layout_Base.Party_bip), 
													boolean pForHeaderBuild=false, boolean pFastHeader = false)	:=
function

	//Exclude Infutor data. BUG ID 146486
	dVehiclesAsSource	:=	header.Files_SeqdSrc(pFastHeader).VH(src NOT IN ['1V','2V']);
	
	header.Layout_New_Records	trans(dVehiclesAsSource	l)	:=
	transform
		self.did											:= if(pFastHeader, l.append_did, 0);
		self.rid											:= 0;
		self.dt_first_seen 						:= l.date_first_seen;
		self.dt_last_seen  						:= l.date_last_seen;
		self.dt_vendor_last_reported	:= l.date_vendor_last_reported;
		self.dt_vendor_first_reported	:= l.date_vendor_first_reported;
		self.dt_nonglb_last_seen      := l.date_last_seen;
		self.rec_type                 := IF(regexfind('R', l.Sequence_Key) and l.history='','1','2');
		self.vendor_id                := l.vehicle_key;
		self.ssn											:= if ((integer)l.orig_ssn=0,'',l.orig_ssn);
		self.dob											:= (integer)l.orig_DOB;
		self.title										:= l.Append_Clean_Name.title;
		self.fname										:= l.Append_Clean_Name.fname;
		self.mname										:= l.Append_Clean_Name.mname;
		self.lname										:= l.Append_Clean_Name.lname;
		self.name_suffix							:= l.Append_Clean_Name.name_suffix;
		self.prim_range								:= l.Append_Clean_Address.prim_range;
		self.predir										:= l.Append_Clean_Address.predir;
		self.prim_name								:= l.Append_Clean_Address.prim_name;
		self.suffix										:= l.Append_Clean_Address.addr_suffix;
		self.postdir									:= l.Append_Clean_Address.postdir;
		self.unit_desig								:= l.Append_Clean_Address.unit_desig;
		self.sec_range								:= l.Append_Clean_Address.sec_range;
		self.city_name								:= l.Append_Clean_Address.v_city_name;
		self.st												:= l.Append_Clean_Address.st;
		self.zip					    				:= l.Append_Clean_Address.zip5;
		self.zip4					    				:= l.Append_Clean_Address.zip4;
		self.county										:= l.Append_Clean_Address.fips_county;
		self.cbsa					   					:= l.Append_Clean_Address.cbsa;
		self.geo_blk				  			  := l.Append_Clean_Address.geo_blk;
		self.phone										:= '';
						 
		self := l;
	end;

	from_vr	:=	project(dVehiclesAsSource(orig_party_type<>'B',append_did	<	VehicleV2.irs_dummy_cutoff),trans(left));
	    
	// do rollup to keep the earliest/latest dates for the record
														
	from_vr_dist	:=	distribute(	from_vr(fname<>'',lname<>''),
																hash(src,vendor_id,fname,lname)
															);

	from_vr_sort	:=	sort(	from_vr_dist,
													src,vendor_id,fname,lname,prim_range,prim_name,sec_range,st,zip,mname,name_suffix,ssn,dob,
													local
												);
										
	header.Layout_New_Records	t_rollup(from_vr_sort le, from_vr_sort ri)	:=
	transform
	 self.dt_first_seen            := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
	 self.dt_last_seen             := max(le.dt_last_seen,ri.dt_last_seen);
	 self.dt_vendor_first_reported := ut.Min2(le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
	 self.dt_vendor_last_reported  := max(le.dt_vendor_last_reported,ri.dt_vendor_last_reported);
	 self.ssn                      := if(le.ssn	<>	'',le.ssn,ri.ssn);
	 self.dob                      := if(le.dob	<>	0,le.dob,ri.dob);
	 self.mname                    := if(le.mname	<>	'',le.mname,ri.mname);
	 self.prim_range               := if(le.prim_range	<>	'',le.prim_range,ri.prim_range);
	 self.dt_nonglb_last_seen      := self.dt_last_seen;
	 self                          := le;
	end;

	from_vr_rollup := rollup(	from_vr_sort,
														left.src         = right.src							and
														left.vendor_id   = right.vendor_id				and
														left.fname       = right.fname						and
														ut.NNEQ(left.mname,right.mname)						and
														left.lname       = right.lname						and
														left.name_suffix = right.name_suffix			and
														ut.NNEQ(left.prim_range,right.prim_range)	and
														left.prim_name   = right.prim_name				and
														left.sec_range   = right.sec_range				and
														left.st          = right.st								and
														left.zip         = right.zip							and
														ut.NNEQ_SSN(left.ssn,right.ssn)						and
														ut.NNEQ_Date(left.dob,right.dob),
														t_rollup(left,right),
														local
													);

	// This is a 'double check' that only correct records are allowed through
		
	VehV2_res	:=	from_vr_rollup(mdr.Source_is_DPPA(src));

	return	VehV2_res;

end;