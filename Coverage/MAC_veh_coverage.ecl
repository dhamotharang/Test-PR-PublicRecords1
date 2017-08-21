export MAC_veh_coverage(re_run=true,debug=true,best_cov_rep,r2,r3) := macro
	import VehicleV2, lib_stringlib;

	real	mthreshld		:=	0.25;
	real	ythreshld		:=	1.0;
	string6 bottomDate		:=	'190102';
	string6 currentYYYYMM	:=	StringLib.GetDateYYYYMMDD()[1..6];
	string6 topDate			:=	currentYYYYMM;

//\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\	SECTION	I

/////////////////////////	step	1	SELECT collumns
	 r_dates := record
		 string2	State_Origin				:=	VehicleV2.file_vehicleV2_party.State_Origin;
		 string2 	Source_Code 		        :=  VehicleV2.file_vehicleV2_party.Source_Code;
		 string6	Reg_First_Date				:=	VehicleV2.file_vehicleV2_party.Reg_First_Date[1..6];
		 string6	Reg_Earliest_Effective_Date	:=	VehicleV2.file_vehicleV2_party.Reg_Earliest_Effective_Date[1..6];
		 string6	Reg_Latest_Effective_Date	:=	VehicleV2.file_vehicleV2_party.Reg_Latest_Effective_Date[1..6];
		 string6	Ttl_Earliest_Issue_Date		:=	VehicleV2.file_vehicleV2_party.Ttl_Earliest_Issue_Date[1..6];
		 string6	Ttl_Latest_Issue_Date		:=	VehicleV2.file_vehicleV2_party.Ttl_Latest_Issue_Date[1..6];
	   end;

#if(re_run)
	ds_dates := dataset('~thor_data400::persist::vehcoverage_Reg_DATES',recordof(r_dates),flat);
#else
	ds_dates:=table(VehicleV2.file_vehicleV2_party,r_dates)	: persist('~thor_data400::persist::vehcoverage_Reg_DATES');
#end
	/////////////////////////	step	2	COUNT vehicles per state
	 r_vehicle_cnt	:= record
		ds_dates.State_Origin;
		ds_dates.Source_Code;
		stateCNT	:=	count(group);
	  end;

#if(re_run)
	ds_vehicle_cnt := distribute(
					dataset('~thor_data400::persist::vehcoverage_Reg_DATES_cnt',recordof(r_vehicle_cnt),flat)
					,hash(State_Origin,Source_Code));
#else
	ds_vehicle_cnt:=table(ds_dates, r_vehicle_cnt
					 ,State_Origin
					 ,Source_Code
					 ,local)
					 : persist('~thor_data400::persist::vehcoverage_Reg_DATES_cnt');
#end

	/////////////////////////	step	3	NORMALIZE dates
	r_dates_normed	:= record
		string2		State_Origin;
		string2   Source_Code;
		qstring27	field;
		qstring6	YYYYMM;
	end;

	r_dates_normed NormIt(ds_dates L, integer C)	:= transform
		self		:=	L;
		self.field	:=	map(C=1		=>	'Reg_First_Date'
							,C=2	=>	'Reg_Earliest_Effective_Date'
							,C=3	=>	'Reg_Latest_Effective_Date'
							,C=4	=>	'Ttl_Earliest_Issue_Date'
							,C=5	=>	'Ttl_Latest_Issue_Date'
							,''
							);
		self.YYYYMM	:=	map(C=1		=>	L.Reg_First_Date
							,C=2	=>	L.Reg_Earliest_Effective_Date
							,C=3	=>	L.Reg_Latest_Effective_Date
							,C=4	=>	L.Ttl_Earliest_Issue_Date
							,C=5	=>	L.Ttl_Latest_Issue_Date
							,''
							);
	end;

#if(re_run)
	ds_dates_normed := dataset('~thor_data400::persist::vehcoverage_Reg_DATES_norm',r_dates_normed,flat);
#else
	ds_dates_normed:=distribute(
							normalize(
									ds_dates
									,5
									,NormIt(left,counter))
														(
														/*YYYYMM<>''*/
														)
							,hash(State_Origin,Source_Code, YYYYMM[1..4])
					)
					: persist('~thor_data400::persist::vehcoverage_Reg_DATES_norm')
					;
#end
	/////////////////////////	step	4	COUNT entries per month and year
	r_mthly_cnt	:= record
		ds_dates_normed;
		DATEcnt	:=	count(group);
	end;

	ds_mthly_cnt:=distribute(table(ds_dates_normed
						,r_mthly_cnt
						,State_Origin
						,Source_Code
						,field
						,YYYYMM
						,local
						),hash(State_Origin,Source_Code))
						: persist('~thor_data400::persist::vehcoverage_Reg_DATES_norm_mthly')
						;


	r_yrly_cnt	:= record
		ds_dates_normed.State_Origin;
		ds_dates_normed.Source_Code;
		ds_dates_normed.field;
		YYYY	:=	ds_dates_normed.YYYYMM[1..4];
		y1		:=	count(group,ds_dates_normed.YYYYMM[1..4]);
	end;

	ds_yrly_cnt:=distribute(table(ds_dates_normed
						,r_yrly_cnt
						,State_Origin
						,Source_Code
						,field
						,YYYYMM[1..4]
						,local
						),hash(State_Origin,Source_Code))
						: persist('~thor_data400::persist::vehcoverage_Reg_DATES_norm_yrly')
						;
	/////////////////////////	step	5	JOIN counts, compute average and distribution
	r_state_stats1	:= record
				ds_mthly_cnt;
				ds_vehicle_cnt.stateCNT;
	end;

	r_state_stats1	join_counts1(ds_mthly_cnt L, ds_vehicle_cnt R)	:=	transform
		self			:=	L;
		self.stateCNT	:=	R.stateCNT;
	end;

	ds_state_stats1	:=	join(ds_mthly_cnt, ds_vehicle_cnt
							,	left.State_Origin=right.State_Origin
							and left.Source_Code = right.Source_Code
							,join_counts1(left,right)
							,local
							,lookup
							)
							;

	r_state_counts	:= record
				ds_state_stats1;
				ds_yrly_cnt.y1;
	end;

	r_state_counts	join_counts(ds_state_stats1 L, ds_yrly_cnt R)	:=	transform
		self	:=	L;
		self.y1	:=	R.y1;
	end;

#if(re_run)
	ds_state_counts := dataset('~thor_data400::persist::vehcoverage_Reg_DATES_norm_stats',r_state_counts,flat);
#else
	ds_state_counts	:=	join(ds_state_stats1, ds_yrly_cnt
							,	left.State_Origin=right.State_Origin
							and left.Source_Code = right.Source_Code
							and left.field=right.field
							and left.YYYYMM[1..4]=right.YYYY
							,join_counts(left,right)
							,local
							,lookup
							)
							: persist('~thor_data400::persist::vehcoverage_Reg_DATES_norm_stats')
							;
#end

	f_AVG:=round(AVE(group,ds_state_counts.DATEcnt));

	r_mm := record
		State_Origin	:= ds_state_counts.State_Origin;
		Source_Code   := ds_state_counts.Source_Code;
		field			:= ds_state_counts.field;
		field_AVG		:= f_AVG;
	end;

	ds_mm:=table(ds_state_counts(
								YYYYMM<>''
								,YYYYMM between bottomDate and topDate
								),r_mm,State_Origin,Source_Code,field,local);

	r_all := record
		State_Origin	:= ds_state_counts.State_Origin;
		Source_Code   := ds_state_counts.Source_Code;
		field			:= ds_state_counts.field;
		YYYYMM			:= ds_state_counts.YYYYMM;
		DATEcnt			:= ds_state_counts.DATEcnt;
		y1				:= ds_state_counts.y1;
		field_AVG		:= ds_mm.field_AVG;
		real	m1		:=	0;
	end;

	r_all j_all (r_state_counts L, r_mm R):= transform
		self.field_AVG	:=R.field_AVG;
		self.m1			:=L.DATEcnt / R.field_AVG;
		self			:=L;
	end;

	ds_all:=join(ds_state_counts, ds_mm
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					,j_all(left,right)
					,local
					)
					: persist('~thor_data400::persist::vehcoverage_Reg_DATES_norm_m1')
					;
	//\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\	SECTION	II	BUILD FORWARD LOOKING COLUMNS
	r_m2:=record
		ds_all;
		qstring6	YYYYMM2;
		real		m2;
	end;

	r_m2 j12(r_all l,r_all r) :=transform	
		self.YYYYMM2	:=r.YYYYMM;
		self.m2			:=r.m1;
		self			:=l;
	end;

	ds_m2:=join(ds_all,ds_all
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					,j12(left,right)
					,left outer
					,local
			);

	ds_trimmedM2:=dedup(sort(ds_m2,State_Origin,Source_Code,field,YYYYMM,YYYYMM2,local),State_Origin,Source_Code,field,YYYYMM,local);
	///////////////////////////////////////////////////////////////////////////////
	r_m3:=record
		ds_trimmedM2;
		qstring6	YYYYMM3;
		real		m3;
	end;

	r_m3 j23(r_m2 l,r_m2 r) :=transform	
		self.YYYYMM3	:=r.YYYYMM2;
		self.m3			:=r.m2;
		self			:=l;
	end;

	ds_m3:=join(ds_trimmedM2,ds_trimmedM2
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					and left.YYYYMM2<right.YYYYMM2
					,j23(left,right)
					,left outer
					,local
			);

	ds_trimmedM3:=dedup(sort(ds_m3,State_Origin,Source_Code,field,YYYYMM,YYYYMM2,YYYYMM3,local),State_Origin,Source_Code,field,YYYYMM,local);
	///////////////////////////////////////////////////////////////////////////////
	r_m4:=record
		ds_trimmedM3;
		qstring6	YYYYMM4;
		real		m4;
	end;

	r_m4 j34(r_m3 l,r_m3 r) :=transform	
		self.YYYYMM4	:=r.YYYYMM3;
		self.m4			:=r.m3;
		self			:=l;
	end;

	ds_m4:=join(ds_trimmedM3,ds_trimmedM3
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					and left.YYYYMM2<right.YYYYMM2
					and left.YYYYMM3<right.YYYYMM3
					,j34(left,right)
					,left outer
					,local
			);

	ds_trimmedM4:=dedup(sort(ds_m4,State_Origin,Source_Code,field,YYYYMM,YYYYMM2,YYYYMM3,YYYYMM4,local),State_Origin,Source_Code,field,YYYYMM,local);
	///////////////////////////////////////////////////////////////////////////////
	r_m5:=record
		ds_trimmedM4;
		qstring6	YYYYMM5;
		real		m5;
	end;

	r_m5 j45(r_m4 l,r_m4 r) :=transform	
		self.YYYYMM5	:=r.YYYYMM4;
		self.m5			:=r.m4;
		self			:=l;
	end;

	ds_m5:=join(ds_trimmedM4,ds_trimmedM4
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					and left.YYYYMM2<right.YYYYMM2
					and left.YYYYMM3<right.YYYYMM3
					and left.YYYYMM4<right.YYYYMM4
					,j45(left,right)
					,left outer
					,local
			);

	ds_trimmedM5:=dedup(sort(ds_m5,State_Origin,Source_Code,field,YYYYMM,YYYYMM2,YYYYMM3,YYYYMM4,YYYYMM5,local),State_Origin,Source_Code,field,YYYYMM,local);
	///////////////////////////////////////////////////////////////////////////////
	r_m6:=record
		ds_trimmedM5;
		qstring6	YYYYMM6;
		real		m6;
	end;

	r_m6 j56(r_m5 l,r_m5 r) :=transform	
		self.YYYYMM6	:=r.YYYYMM5;
		self.m6			:=r.m5;
		self			:=l;
	end;

	ds_m6:=join(ds_trimmedM5,ds_trimmedM5
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					and left.YYYYMM2<right.YYYYMM2
					and left.YYYYMM3<right.YYYYMM3
					and left.YYYYMM4<right.YYYYMM4
					and left.YYYYMM5<right.YYYYMM5
					,j56(left,right)
					,left outer
					,local
			);

	ds_trimmedM6:=dedup
					(
					sort
						(
						ds_m6
						,State_Origin
						,Source_Code
						,field
						,YYYYMM
						,YYYYMM2
						,YYYYMM3
						,YYYYMM4
						,YYYYMM5
						,YYYYMM6
						,local
						)
					,State_Origin
					,Source_Code
					,field
					,YYYYMM
					,local
					);
	///////////////////////////////////////////////////////////////////////////////
	r_y2:=record
		ds_trimmedM6;
		string4	YYYY2;
		integer	Y2;
	end;

	r_y2 jy12(r_m6 l,r_m6 r) :=transform	
		self.YYYY2	:=r.YYYYMM[1..4];
		self.y2		:=r.y1;
		self		:=l;
	end;

	ds_y2:=join(ds_trimmedM6,ds_trimmedM6
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM[1..4]<right.YYYYMM[1..4]
					,jy12(left,right)
					,left outer
					,local
			);


	ds_trimmedY2:=dedup
					(
					sort
						(
						ds_y2
						,State_Origin
						,Source_Code
						,field
						,YYYYMM
						,YYYYMM2
						,YYYYMM3
						,YYYYMM4
						,YYYYMM5
						,YYYYMM6
						,YYYY2
						,local
						)
					,State_Origin
					,Source_Code
					,field
					,YYYYMM
					,local
					);
	///////////////////////////////////////////////////////////////////////////////
	r_y3:=record
		ds_trimmedy2;
		qstring4	YYYY3;
		integer		Y3;
	end;

	r_y3 jy23(r_y2 l,r_y2 r) :=transform	
		self.YYYY3	:=r.YYYY2;
		self.Y3		:=r.y2;
		self		:=l;
	end;

	ds_y3:=join(ds_trimmedY2,ds_trimmedY2
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM[1..4]<right.YYYYMM[1..4]
					and left.YYYY2<right.YYYY2
					,jy23(left,right)
					,left outer
					,local
			);


	ds_trimmedY3:=dedup
					(
					sort
						(
						ds_y3
						,State_Origin
						,Source_Code
						,field
						,YYYYMM
						,YYYYMM2
						,YYYYMM3
						,YYYYMM4
						,YYYYMM5
						,YYYYMM6
						,YYYY2
						,YYYY3
						,local
					)
					,State_Origin
					,Source_Code
					,field
					,YYYYMM
					,local
					);
	///////////////////////////////////////////////////////////////////////////////
	r_y4:=record
		ds_trimmedy3;
		qstring4	YYYY4;
		integer		Y4;
	end;

	r_y4 jy34(r_y3 l,r_y3 r) :=transform	
		self.YYYY4	:=r.YYYY3;
		self.Y4		:=r.y3;
		self		:=l;
	end;

	ds_y4:=join(ds_trimmedY3,ds_trimmedY3
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM[1..4]<right.YYYYMM[1..4]
					and left.YYYY2<right.YYYY2
					and left.YYYY3<right.YYYY3
					,jy34(left,right)
					,left outer
					,local
			);


	ds_trimmedY4:=dedup
					(
					sort
						(
						ds_y4
						,State_Origin
						,Source_Code
						,field
						,YYYYMM
						,YYYYMM2
						,YYYYMM3
						,YYYYMM4
						,YYYYMM5
						,YYYYMM6
						,YYYY2
						,YYYY3
						,YYYY4
						,local
					)
					,State_Origin
					,Source_Code
					,field
					,YYYYMM
					,local
					);
	///////////////////////////////////////////////////////////////////////////////
	r_y5:=record
		ds_trimmedy4;
		qstring4	YYYY5;
		integer		Y5;
	end;

	r_y5 jy45(r_y4 l,r_y4 r) :=transform	
		self.YYYY5	:=r.YYYY4;
		self.Y5		:=r.y4;
		self		:=l;
	end;

	ds_y5:=join(ds_trimmedY4,ds_trimmedY4
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM[1..4]<right.YYYYMM[1..4]
					and left.YYYY2<right.YYYY2
					and left.YYYY3<right.YYYY3
					and left.YYYY4<right.YYYY4
					,jy45(left,right)
					,left outer
					,local
			);


	ds_trimmedY5:=dedup
					(
					sort
						(
						ds_y5
						,State_Origin
						,Source_Code
						,field
						,YYYYMM
						,YYYYMM2
						,YYYYMM3
						,YYYYMM4
						,YYYYMM5
						,YYYYMM6
						,YYYY2
						,YYYY3
						,YYYY4
						,YYYY5
						,local
					)
					,State_Origin
					,Source_Code
					,field
					,YYYYMM
					,local
					);
	///////////////////////////////////////////////////////////////////////////////
	r_y6:=record
		ds_trimmedy5;
		qstring4	YYYY6;
		integer		Y6;
	end;

	r_y6 jy56(r_y5 l,r_y5 r) :=transform	
		self.YYYY6	:=r.YYYY5;
		self.Y6		:=r.y5;
		self		:=l;
	end;

	ds_y6:=join(ds_trimmedY5,ds_trimmedY5
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM[1..4]<right.YYYYMM[1..4]
					and left.YYYY2<right.YYYY2
					and left.YYYY3<right.YYYY3
					and left.YYYY4<right.YYYY4
					and left.YYYY5<right.YYYY5
					,jy56(left,right)
					,left outer
					,local
			);


	ds_trimmedY6:=dedup
					(
					sort
						(
						ds_y6
						,State_Origin
						,Source_Code
						,field
						,YYYYMM
						,YYYYMM2
						,YYYYMM3
						,YYYYMM4
						,YYYYMM5
						,YYYYMM6
						,YYYY2
						,YYYY3
						,YYYY4
						,YYYY5
						,YYYY6
						,local
					)
					,State_Origin
					,Source_Code
					,field
					,YYYYMM
					,local
					);
	///////////////////////////////////////////////////////////////////////////////
	r_y7:=record
		ds_trimmedy6;
		qstring4	YYYY7;
		integer		Y7;
	end;

	r_y7 jy67(r_y6 l,r_y6 r) :=transform	
		self.YYYY7	:=r.YYYY6;
		self.Y7		:=r.y6;
		self		:=l;
	end;

	ds_y7:=join(ds_trimmedY6,ds_trimmedY6
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM[1..4]<right.YYYYMM[1..4]
					and left.YYYY2<right.YYYY2
					and left.YYYY3<right.YYYY3
					and left.YYYY4<right.YYYY4
					and left.YYYY5<right.YYYY5
					and left.YYYY6<right.YYYY6
					,jy67(left,right)
					,left outer
					,local
			);


	ds_trimmedY7:=dedup
					(
					sort
						(
						ds_y7
						,State_Origin
						,Source_Code
						,field
						,YYYYMM
						,YYYYMM2
						,YYYYMM3
						,YYYYMM4
						,YYYYMM5
						,YYYYMM6
						,YYYY2
						,YYYY3
						,YYYY4
						,YYYY5
						,YYYY6
						,YYYY7
						,local
					)
					,State_Origin
					,Source_Code
					,field
					,YYYYMM
					,local
					);
	///////////////////////////////////////////////////////////////////////////////
	r_y8:=record
		ds_trimmedy7;
		qstring4	YYYY8;
		integer		Y8;
	end;

	r_y8 jy78(r_y7 l,r_y7 r) :=transform	
		self.YYYY8	:=r.YYYY7;
		self.Y8		:=r.y7;
		self		:=l;
	end;

	ds_y8:=join(ds_trimmedY7,ds_trimmedY7
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM[1..4]<right.YYYYMM[1..4]
					and left.YYYY2<right.YYYY2
					and left.YYYY3<right.YYYY3
					and left.YYYY4<right.YYYY4
					and left.YYYY5<right.YYYY5
					and left.YYYY6<right.YYYY6
					and left.YYYY7<right.YYYY7
					,jy78(left,right)
					,left outer
					,local
			);


	ds_trimmedY8:=dedup
					(
					sort
						(
						ds_y8
						,State_Origin
						,Source_Code
						,field
						,YYYYMM
						,YYYYMM2
						,YYYYMM3
						,YYYYMM4
						,YYYYMM5
						,YYYYMM6
						,YYYY2
						,YYYY3
						,YYYY4
						,YYYY5
						,YYYY6
						,YYYY7
						,YYYY8
						,local
					)
					,State_Origin
					,Source_Code
					,field
					,YYYYMM
					,local
					);
	///////////////////////////////////////////////////////////////////////////////
	r_y9:=record
		ds_trimmedy8;
		qstring4	YYYY9;
		integer		Y9;
	end;

	r_y9 jy89(r_y8 l,r_y8 r) :=transform	
		self.YYYY9	:=r.YYYY8;
		self.Y9		:=r.y8;
		self		:=l;
	end;

	ds_y9:=join(ds_trimmedY8,ds_trimmedY8
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM[1..4]<right.YYYYMM[1..4]
					and left.YYYY2<right.YYYY2
					and left.YYYY3<right.YYYY3
					and left.YYYY4<right.YYYY4
					and left.YYYY5<right.YYYY5
					and left.YYYY6<right.YYYY6
					and left.YYYY7<right.YYYY7
					and left.YYYY8<right.YYYY8
					,jy89(left,right)
					,left outer
					,local
			);


	ds_trimmedY9:=dedup
					(
					sort
						(
						ds_y9
						,State_Origin
						,Source_Code
						,field
						,YYYYMM
						,YYYYMM2
						,YYYYMM3
						,YYYYMM4
						,YYYYMM5
						,YYYYMM6
						,YYYY2
						,YYYY3
						,YYYY4
						,YYYY5
						,YYYY6
						,YYYY7
						,YYYY8
						,YYYY9
						,local
					)
					,State_Origin
					,Source_Code
					,field
					,YYYYMM
					,local
					);
	///////////////////////////////////////////////////////////////////////////////
	r_y10:=record
		ds_trimmedy9;
		qstring4	YYYY10;
		integer		Y10;
	end;

	r_y10 jy910(r_y9 l,r_y9 r) :=transform	
		self.YYYY10	:=r.YYYY9;
		self.Y10		:=r.y9;
		self		:=l;
	end;

	ds_y10:=join(ds_trimmedY9,ds_trimmedY9
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM[1..4]<right.YYYYMM[1..4]
					and left.YYYY2<right.YYYY2
					and left.YYYY3<right.YYYY3
					and left.YYYY4<right.YYYY4
					and left.YYYY5<right.YYYY5
					and left.YYYY6<right.YYYY6
					and left.YYYY7<right.YYYY7
					and left.YYYY8<right.YYYY8
					and left.YYYY9<right.YYYY9
					,jy910(left,right)
					,left outer
					,local
			);


	ds_trimmedY10:=dedup
					(
					sort
						(
						ds_y10
						,State_Origin
						,Source_Code
						,field
						,YYYYMM
						,YYYYMM2
						,YYYYMM3
						,YYYYMM4
						,YYYYMM5
						,YYYYMM6
						,YYYY2
						,YYYY3
						,YYYY4
						,YYYY5
						,YYYY6
						,YYYY7
						,YYYY8
						,YYYY9
						,YYYY10
						,local
					)
					,State_Origin
					,Source_Code
					,field
					,YYYYMM
					,local
					);
	///////////////////////////////////////////////////////////////////////////////
	r_y11:=record
		ds_trimmedy10;
		qstring4	YYYY11;
		integer		Y11;
	end;

	r_y11 jy1011(r_y10 l,r_y10 r) :=transform	
		self.YYYY11	:=r.YYYY10;
		self.Y11		:=r.y10;
		self		:=l;
	end;

	ds_y11:=join(ds_trimmedY10,ds_trimmedY10
					,	left.State_Origin=right.State_Origin
					and left.Source_Code = right.Source_Code
					and left.field=right.field
					and left.YYYYMM[1..4]<right.YYYYMM[1..4]
					and left.YYYY2<right.YYYY2
					and left.YYYY3<right.YYYY3
					and left.YYYY4<right.YYYY4
					and left.YYYY5<right.YYYY5
					and left.YYYY6<right.YYYY6
					and left.YYYY7<right.YYYY7
					and left.YYYY8<right.YYYY8
					and left.YYYY9<right.YYYY9
					and left.YYYY10<right.YYYY10
					,jy1011(left,right)
					,left outer
					,local
			);


	///////////////////////////////////////////////////////////////////////////
#if(re_run)
	ds_trimmedY11 := dataset('~thor_data400::persist::vehcoverage_Reg_DATES_norm_y11',r_y11,flat);
#else
	ds_trimmedY11:=dedup
					(
					sort
						(
						ds_y11
						,State_Origin
						,Source_Code
						,field
						,YYYYMM
						,YYYYMM2
						,YYYYMM3
						,YYYYMM4
						,YYYYMM5
						,YYYYMM6
						,YYYY2
						,YYYY3
						,YYYY4
						,YYYY5
						,YYYY6
						,YYYY7
						,YYYY8
						,YYYY9
						,YYYY10
						,YYYY11
						,local
					)
					,State_Origin
					,Source_Code
					,field
					,YYYYMM
					,local
					)
					: persist('~thor_data400::persist::vehcoverage_Reg_DATES_norm_y11')
					;
#end

	ds_stats:=table(ds_trimmedY11
								(
								// any filter
								)
						,{
						State_Origin
						,Source_Code
						,field
						,YYYYMM
						,DATEcnt
						,y1
						,y2
						,y3
						,y4
						,y5
						,y6
						,y7
						,y8
						,y9
						,y10
						,y11
						,m1
						,m2
						,m3
						,m4
						,m5
						,m6
						},local);
	//\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\	SECTION	III	REPORT

	/////////////////////////	step	6	filter and REPORT
	r_stats	:= record
		ds_stats;
	end;

	ds_TBLstats:=table(ds_stats,r_stats,local);

	ds_srtd1:=sort(ds_TBLstats
						(
							m1>=mthreshld
						and m2>=mthreshld
						and m3>=mthreshld
						and m4>=mthreshld
						and m5>=mthreshld
						and m6>=mthreshld
						and abs(y2-y1)/y1 between 0 and ythreshld 
						and abs(y3-y2)/y2 between 0 and ythreshld
						and abs(y4-y3)/y3 between 0 and ythreshld
						and abs(y5-y4)/y4 between 0 and ythreshld
						and abs(y6-y5)/y5 between 0 and ythreshld
						and abs(y7-y6)/y6 between 0 and ythreshld
						and abs(y8-y7)/y7 between 0 and ythreshld
						and abs(y9-y8)/y8 between 0 and ythreshld
						and YYYYMM<>''
						and YYYYMM between bottomDate and topDate 
						and YYYYMM[5..6] between '01' and '12'
						)
				,State_Origin
				,Source_Code
				,field
				,YYYYMM
				,local);

	ds_srtd2:=sort(ds_TBLstats
						(
							m1>=mthreshld
						and YYYYMM<>''
						and YYYYMM between bottomDate and topDate 
						and YYYYMM[5..6] between '01' and '12'
						)
				,State_Origin
				,Source_Code
				,field
				,-YYYYMM
				,local);

	r_stats demarcation(ds_TBLstats	L, ds_TBLstats	R)	:=	transform, skip (L.field=R.field)
		SELF := R;
	end;

	ds_top:=iterate(ds_srtd1
				,demarcation(left,right)
				,local);

	ds_bottom:=iterate(ds_srtd2
				,demarcation(left,right)
				,local);

	ds_NormReport:=sort(
					table	(
							ds_bottom + ds_top,
										{
										State_Origin
										,Source_Code
										,field
										,YYYYMM
										},local
							)
							,State_Origin
							,Source_Code
							,field
							,YYYYMM
							,local
					)
					: persist('~thor_data400::persist::vehcoverage_Reg_DATES_norm_report')
					;

	reg_MIN:=min(ds_NormReport(field[1]='R'),YYYYMM);
	reg_MAX:=max(ds_NormReport(field[1]='R'),YYYYMM);
	ttl_MIN:=min(ds_NormReport(field[1]='T'),YYYYMM);
	ttl_MAX:=max(ds_NormReport(field[1]='T'),YYYYMM);

	r_minmax2 := record
		State_Origin			:= ds_NormReport.State_Origin;
		Source_Code       := ds_NormReport.Source_Code;
		vehicle_cov_reg_start	:=min(group,ds_NormReport.YYYYMM);
		vehicle_cov_reg_end		:=max(group,ds_NormReport.YYYYMM);
		vehicle_cov_ttl_start	:=min(group,ds_NormReport.YYYYMM);
		vehicle_cov_ttl_end		:=max(group,ds_NormReport.YYYYMM);
	end;

	ds_minmax2:=table(ds_NormReport,r_minmax2,State_Origin,Source_Code, field[1],reg_MIN,reg_MAX,ttl_MIN,ttl_MAX);

	r_minmax2 t1_rollup (r_minmax2 L, r_minmax2 R):= transform
		self.vehicle_cov_ttl_start	:=R.vehicle_cov_ttl_start;
		self.vehicle_cov_ttl_end	:=R.vehicle_cov_ttl_end;
		self						:=L;
	end;

	ds_FinalReport:=rollup(ds_minmax2
						,	left.State_Origin=right.State_Origin
						and left.Source_Code = right.Source_Code
						,t1_rollup(left,right)
						)
						: persist('~thor_data400::persist::vehcoverage_vehicle_coverage')
						;
	/////////////	step	7	best coverage entity ***for special requests; not needed***
	r_final := record
		string2		State_Origin;
		string2   Source_Code;
		qstring15	entity_with_best_coverage;
		qstring6	coverage_start_YYYYMM;
		qstring6	coverage_end_YYYYMM;
		qstring12	status;
	end;

	r_final get_best_range(r_minmax2 L)	:= transform
		string6		crs					:=	l.vehicle_cov_reg_start;
		string6		cre					:=	l.vehicle_cov_reg_end;

		integer		rsy					:=	(integer)crs[1..4]*12;
		integer		rsm					:=	(integer)crs[5..6];
		integer		rey					:=	(integer)cre[1..4]*12;
		integer		rem					:=	(integer)cre[5..6];
		
		integer		reg_range			:=	(rey+rem) - (rsy+rsm);

		string6		cts					:=	l.vehicle_cov_ttl_start;
		string6		cte					:=	l.vehicle_cov_ttl_end;
		
		integer		tsy					:=	(integer)cts[1..4]*12;
		integer		tsm					:=	(integer)cts[5..6];
		integer		tey					:=	(integer)cte[1..4]*12;
		integer		tem					:=	(integer)cte[5..6];
		
		integer		ttl_range			:=	(tey+tem) - (tsy+tsm);

		qstring12	entity				:=	if(ttl_range > reg_range,'title','registration');
		
		boolean		title				:=	if(ttl_range > reg_range,true,false);
		
		qstring6	coverage_start_YYYYMM	:=	if(title,l.vehicle_cov_ttl_start,l.vehicle_cov_reg_start);
		
		qstring6	coverage_end_YYYYMM	:=	if(title,l.vehicle_cov_ttl_end,l.vehicle_cov_reg_end);
		
		qstring12	status				:=	if( (((integer)currentYYYYMM[1..4]*12) + (integer)currentYYYYMM[5..6])
															-
												(((integer)coverage_end_YYYYMM[1..4]*12) + (integer)coverage_end_YYYYMM[5..6])
															< 6
													,'current'
													,'historical');

		self.entity_with_best_coverage	:=	entity;
		self.coverage_start_YYYYMM	:=	coverage_start_YYYYMM;
		self.coverage_end_YYYYMM	:=	coverage_end_YYYYMM;
		self.status					:=	status;
		self						:=	L;
	end;

#if(debug)
	ds_final:=project(ds_FinalReport
					,get_best_range(left))
					: persist('~thor_data400::persist::vehcoverage_vehicle_coverage_best');
#else
	ds_final:=project(ds_FinalReport
					,get_best_range(left));
#end

	///////////////////////	step	8	DENORMALIZE  ***for validation only; not needed***
	ReportRec := record
					ds_minmax2.State_Origin;
					ds_minmax2.Source_Code;
		qstring6	Reg_First_Date_Cov_Start:='';
		qstring6	Reg_First_Date_Cov_End:='';
		qstring6	Reg_Earliest_Effective_Date_Cov_Start:='';
		qstring6	Reg_Earliest_Effective_Date_Cov_End:='';
		qstring6	Reg_Latest_Effective_Date_Cov_Start:='';
		qstring6	Reg_Latest_Effective_Date_Cov_End:='';
		qstring6	Ttl_Earliest_Issue_Date_Cov_Start:='';
		qstring6	Ttl_Earliest_Issue_Date_Cov_End:='';
		qstring6	Ttl_Latest_Issue_Date_Cov_Start:='';
		qstring6	Ttl_Latest_Issue_Date_Cov_End:='';
	end;

	ds_ReportTemplete := table(ds_minmax2,ReportRec,State_Origin, Source_Code);

	ReportRec DEnormIt(ReportRec L, ds_NormReport R, integer C)	:= transform
		self.Reg_First_Date_Cov_Start				:=	if(C%2=1 and r.field='REG_FIRST_DATE',r.YYYYMM,l.Reg_First_Date_Cov_Start);
		self.Reg_First_Date_Cov_End					:=	if(C%2=0 and r.field='REG_FIRST_DATE',r.YYYYMM,l.Reg_First_Date_Cov_End);
		self.Reg_Earliest_Effective_Date_Cov_Start	:=	if(C%2=1 and r.field='REG_EARLIEST_EFFECTIVE_DATE',r.YYYYMM,l.Reg_Earliest_Effective_Date_Cov_Start);
		self.Reg_Earliest_Effective_Date_Cov_End	:=	if(C%2=0 and r.field='REG_EARLIEST_EFFECTIVE_DATE',r.YYYYMM,l.Reg_Earliest_Effective_Date_Cov_End);
		self.Reg_Latest_Effective_Date_Cov_Start	:=	if(C%2=1 and r.field='REG_LATEST_EFFECTIVE_DATE',r.YYYYMM,l.Reg_Latest_Effective_Date_Cov_Start);
		self.Reg_Latest_Effective_Date_Cov_End		:=	if(C%2=0 and r.field='REG_LATEST_EFFECTIVE_DATE',r.YYYYMM,l.Reg_Latest_Effective_Date_Cov_End);
		self.Ttl_Earliest_Issue_Date_Cov_Start		:=	if(C%2=1 and r.field='TTL_EARLIEST_ISSUE_DATE',r.YYYYMM,l.Ttl_Earliest_Issue_Date_Cov_Start);
		self.Ttl_Earliest_Issue_Date_Cov_End		:=	if(C%2=0 and r.field='TTL_EARLIEST_ISSUE_DATE',r.YYYYMM,l.Ttl_Earliest_Issue_Date_Cov_End);
		self.Ttl_Latest_Issue_Date_Cov_Start		:=	if(C%2=1 and r.field='TTL_LATEST_ISSUE_DATE',r.YYYYMM,l.Ttl_Latest_Issue_Date_Cov_Start);
		self.Ttl_Latest_Issue_Date_Cov_End			:=	if(C%2=0 and r.field='TTL_LATEST_ISSUE_DATE',r.YYYYMM,l.Ttl_Latest_Issue_Date_Cov_End);
		self										:=	L;
	end;

#if(debug)
	ds_FinalReport2:=denormalize(ds_ReportTemplete, ds_NormReport
					,	left.state_origin=right.state_origin
					and	left.Source_Code = right.Source_Code
					,DEnormIt(left,right,counter))
					: persist('~thor_data400::persist::vehcoverage_vehicle_coverage_report2');
#else
	ds_FinalReport2:=denormalize(ds_ReportTemplete, ds_NormReport
					,	left.state_origin=right.state_origin
					and	left.Source_Code = right.Source_Code
					,DEnormIt(left,right,counter));
#end

	best_cov_rep :=	ds_FinalReport;
	r2			 :=	ds_final;
	r3			 :=	ds_FinalReport2;

ENDMACRO;