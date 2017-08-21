export vehicle_coverages_first_pass() := function

	import VehicleV2;
	import lib_stringlib;

	real	threshld		:=	0.50;
	string6 bottomDate		:=	'190102';
	string6 currentYYYYMM	:=	StringLib.GetDateYYYYMMDD()[1..6];
	string6 topDate			:=	currentYYYYMM;

//\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\	SECTION	I	EXTRACT

/////////////////////////	step	1	SELECT collumns

	// r_dates := record
		// string2	State_Origin				:=	VehicleV2.file_vehicleV2_party.State_Origin;
		// string6	Reg_First_Date				:=	VehicleV2.file_vehicleV2_party.Reg_First_Date[1..6];
		// string6	Reg_Earliest_Effective_Date	:=	VehicleV2.file_vehicleV2_party.Reg_Earliest_Effective_Date[1..6];
		// string6	Reg_Latest_Effective_Date	:=	VehicleV2.file_vehicleV2_party.Reg_Latest_Effective_Date[1..6];
		// string6	Ttl_Earliest_Issue_Date		:=	VehicleV2.file_vehicleV2_party.Ttl_Earliest_Issue_Date[1..6];
		// string6	Ttl_Latest_Issue_Date		:=	VehicleV2.file_vehicleV2_party.Ttl_Latest_Issue_Date[1..6];
	// end;

	// ds_dates:=table(VehicleV2.file_vehicleV2_party,r_dates)	: persist('~thor_data400::persist::jbello_Reg_DATES');

	r_dates := record
		string2	State_Origin;
		string6	Reg_First_Date;
		string6	Reg_Earliest_Effective_Date;
		string6	Reg_Latest_Effective_Date;
		string6	Ttl_Earliest_Issue_Date;
		string6	Ttl_Latest_Issue_Date;
	end;

	ds_dates := dataset('~thor_data400::persist::jbello_Reg_DATES',r_dates,flat);

	/////////////////////////	step	2	COUNT vehicles per state

	r_vehicle_cnt	:= record
		ds_dates.State_Origin;
		stateCNT	:=	count(group);
	end;

	ds_vehicle_cnt:=table(ds_dates, r_vehicle_cnt
						,State_Origin
						,local)
						: persist('~thor_data400::persist::jbello_Reg_DATES_plus')
						;


	// r_vehicle_cnt	:= record
		// string2	State_Origin;
		// integer	stateCNT;
	// end;

	// ds_vehicle_cnt := dataset('~thor_data400::persist::jbello_Reg_DATES_plus',r_vehicle_cnt,flat);

	/////////////////////////	step	3	NORMALIZE dates


	r_dates_normed	:= record
		string2		State_Origin;
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


	ds_dates_normed:=distribute(
							normalize(
									ds_dates
									,5
									,NormIt(left,counter))
														(
														// any filter
														)
							,hash(State_Origin,YYYYMM)
					)
					// : persist('~thor_data400::persist::jbello_Reg_DATES_norm')
					;


	/////////////////////////	step	4	COUNT entries per month


	r_mthly_cnt	:= record
		ds_dates_normed;
		DATEcnt	:=	count(group);
	end;

	ds_mthly_cnt:=table(ds_dates_normed
						,r_mthly_cnt
						,State_Origin
						,field
						,YYYYMM
						,local
						)
						// : persist('~thor_data400::persist::jbello_Reg_DATES_norm_sumed')
						;


	/////////////////////////	step	5	JOIN counts, compute average and distribution


	r_state_counts	:= record
				ds_mthly_cnt;
				ds_vehicle_cnt.stateCNT;
		integer	monthlyAVG;
		real	m1:=0;
	end;

	r_state_counts	join_counts(ds_mthly_cnt L, ds_vehicle_cnt R)	:=	transform

		integer monthCNT:=	(((integer)currentYYYYMM[1..4]*12) + (integer)currentYYYYMM[5..6])
							-	(((integer)bottomDate[1..4]*12) + (integer)bottomDate[5..6]);
		
		self			:=	L;
		self.stateCNT	:=	R.stateCNT;
		self.monthlyAVG	:=	round(R.stateCNT/monthCNT);
		self.m1			:=	L.DATEcnt/round(R.stateCNT/monthCNT);

	end;

	ds_state_counts	:=	join(ds_mthly_cnt, ds_vehicle_cnt
							,left.State_Origin=right.State_Origin
							,join_counts(left,right)
							,inner
							,local
							,lookup
							)
							: persist('~thor_data400::persist::jbello_Reg_DATES_norm_rated')
							;


	//\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\	SECTION	II	BUILD FORWARD LOOKING COLUMNS


	// r_state_counts	:= record
		// string2		State_Origin;
		// qstring27	field;
		// qstring6	YYYYMM;
		// integer		DATEcnt;
		// integer		stateCNT;
		// integer		monthlyAVG;
		// real		m1;
	// end;

	// ds_state_counts := dataset('~thor_data400::persist::jbello_Reg_DATES_norm_rated',r_state_counts,flat);

	r_m2:=record
		ds_state_counts;
		qstring6	YYYYMM2;
		real		m2;
	end;

	r_m2 j12(r_state_counts l,r_state_counts r) :=transform	
		self.YYYYMM2	:=r.YYYYMM;
		self.m2			:=r.m1;
		self			:=l;
	end;

	ds_m2:=join(ds_state_counts,ds_state_counts
					,left.State_Origin=right.State_Origin
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					,j12(left,right)
					,left outer
			);

	ds_trimmedM2:=dedup(sort(ds_m2,State_Origin,field,YYYYMM,YYYYMM2),State_Origin,field,YYYYMM);
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

	ds_m3:=join(ds_trimmedM2,ds_trimmedM2,left.State_Origin=right.State_Origin
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					and left.YYYYMM2<right.YYYYMM2
					,j23(left,right)
					,left outer
			);

	ds_trimmedM3:=dedup(sort(ds_m3,State_Origin,field,YYYYMM,YYYYMM2,YYYYMM3),State_Origin,field,YYYYMM);
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

	ds_m4:=join(ds_trimmedM3,ds_trimmedM3,left.State_Origin=right.State_Origin
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					and left.YYYYMM2<right.YYYYMM2
					and left.YYYYMM3<right.YYYYMM3
					,j34(left,right)
					,left outer
			);

	ds_trimmedM4:=dedup(sort(ds_m4,State_Origin,field,YYYYMM,YYYYMM2,YYYYMM3,YYYYMM4),State_Origin,field,YYYYMM);
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

	ds_m5:=join(ds_trimmedM4,ds_trimmedM4,left.State_Origin=right.State_Origin
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					and left.YYYYMM2<right.YYYYMM2
					and left.YYYYMM3<right.YYYYMM3
					and left.YYYYMM4<right.YYYYMM4
					,j45(left,right)
					,left outer
			);

	ds_trimmedM5:=dedup(sort(ds_m5,State_Origin,field,YYYYMM,YYYYMM2,YYYYMM3,YYYYMM4,YYYYMM5),State_Origin,field,YYYYMM);
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

	ds_m6:=join(ds_trimmedM5,ds_trimmedM5,left.State_Origin=right.State_Origin
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					and left.YYYYMM2<right.YYYYMM2
					and left.YYYYMM3<right.YYYYMM3
					and left.YYYYMM4<right.YYYYMM4
					and left.YYYYMM<right.YYYYMM5
					,j56(left,right)
					,left outer
			);


	ds_trimmedM6:=dedup
					(
					sort
						(
						ds_m6
						,State_Origin
						,field
						,YYYYMM
						,YYYYMM2
						,YYYYMM3
						,YYYYMM4
						,YYYYMM5
						,YYYYMM6
						)
					,State_Origin
					,field
					,YYYYMM
					);
						

	ds_stats:=table(ds_trimmedM6
								(
								// any filter
								)
						,{
						State_Origin
						,field
						,YYYYMM
						,DATEcnt
						,m1
						,m2
						,m3
						,m4
						,m5
						,m6
						})
						// : persist('~thor_data400::persist::jbello_Reg_DATES_norm_rated_plus')
						;


	//\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\	SECTION	III	REPORT


	// r_stats	:= record
		// string2		State_Origin;
		// qstring27	field;
		// qstring6	YYYYMM;
		// real		m1;
		// real		m2;
		// real		m3;
		// real		m4;
		// real		m5;
		// real		m6;
	// end;

	// ds_stats := dataset('~thor_data400::persist::jbello_Reg_DATES_norm_rated_plus',r_stats,flat);

	/////////////////////////	step	6	filter and REPORT

	r_stats	:= record
		ds_stats;
	end;

	ds_TBLstats:=table(ds_stats,r_stats);

	ds_srtd1:=sort(ds_TBLstats
					(
						m1>=threshld
					and m2>=threshld
					and m3>=threshld
					and m4>=threshld
					and m5>=threshld
					and m6>=threshld
					and YYYYMM<>''
					and YYYYMM[5..6] between '01' and '12'
					)
			,State_Origin
			,field
			,YYYYMM
			);

	ds_srtd2:=sort(ds_TBLstats
					(
						m1>=threshld 
					and YYYYMM between bottomDate and topDate 
					and YYYYMM[5..6] between '01' and '12'
					)
			,State_Origin
			,field
			,-YYYYMM
			);


	r_stats demarcation(ds_TBLstats	L, ds_TBLstats	R)	:=	transform, skip (L.field=R.field)
		SELF := R;
	end;

	ds_top:=iterate(ds_srtd1
				,demarcation(left,right)
				);

	ds_bottom:=iterate(ds_srtd2
				,demarcation(left,right)
				);

	ds_NormReport:=sort(
					table	(
							ds_bottom + ds_top,
										{
										State_Origin
										,field
										,YYYYMM
										}
							)
							,State_Origin
							,field
							,YYYYMM
					)
					// : persist('~thor_data400::persist::jbello_Reg_DATES_norm_report')
					;

	reg_MIN:=min(ds_NormReport(field[1]='R'),YYYYMM);
	reg_MAX:=max(ds_NormReport(field[1]='R'),YYYYMM);
	ttl_MIN:=min(ds_NormReport(field[1]='T'),YYYYMM);
	ttl_MAX:=max(ds_NormReport(field[1]='T'),YYYYMM);

	r_minmax := record
		State_Origin			:= ds_NormReport.State_Origin;
		vehicle_cov_reg_start	:=min(group,ds_NormReport.YYYYMM);
		vehicle_cov_reg_end		:=max(group,ds_NormReport.YYYYMM);
		vehicle_cov_ttl_start	:=min(group,ds_NormReport.YYYYMM);
		vehicle_cov_ttl_end		:=max(group,ds_NormReport.YYYYMM);
	end;

	ds_minmax:=table(ds_NormReport,r_minmax,State_Origin,field[1],reg_MIN,reg_MAX,ttl_MIN,ttl_MAX);

	r_minmax t1_rollup (r_minmax L, r_minmax R):= transform
		self.vehicle_cov_ttl_start	:=R.vehicle_cov_ttl_start;
		self.vehicle_cov_ttl_end	:=R.vehicle_cov_ttl_end;
		self						:=L;
	end;

	ds_FinalReport:=rollup(ds_minmax
						,left.State_Origin=right.State_Origin
						,t1_rollup(left,right)
						)
						: persist('~thor_data400::persist::jbello_vehicle_coverage_report_I')
						;



	///////////////////////	step	7	DENORMALIZE


	ReportRec := record
					ds_minmax.State_Origin;
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

	ds_ReportTemplete := table(ds_minmax,ReportRec,State_Origin);

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


	ds_FinalReport2:=denormalize(ds_ReportTemplete, ds_NormReport
					,LEFT.State_Origin=RIGHT.State_Origin
					,DEnormIt(left,right,counter)
					)
					// : persist('~thor_data400::persist::jbello_vehicle_coverage_report2')
					;


	RETURN	ds_FinalReport;

END;









export vehicle_coverages_second_pass() := function

	import VehicleV2;
	import lib_stringlib;

	real	threshld		:=	0.25;
	string6 bottomDate		:=	'190102';
	string6 currentYYYYMM	:=	StringLib.GetDateYYYYMMDD()[1..6];
	string6 topDate			:=	currentYYYYMM;

//\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\	SECTION	I

/////////////////////////	step	1	SELECT collumns


	r_state_counts	:= record
		string2		State_Origin;
		qstring27	field;
		qstring6	YYYYMM;
		integer		DATEcnt;
		integer		stateCNT;
		integer		monthlyAVG;
		real		m1;
	end;

	ds_state_counts := dataset('~thor_data400::persist::jbello_Reg_DATES_norm_rated',r_state_counts,flat);


	r_minmax := record
		string2		State_Origin;
		qstring6	vehicle_cov_reg_start;
		qstring6	vehicle_cov_reg_end;
		qstring6	vehicle_cov_ttl_start;
		qstring6	vehicle_cov_ttl_end;
	end;

	ds_minmax := dataset('~thor_data400::persist::jbello_vehicle_coverage_report_I',r_minmax,flat);



	r_mm_stats := record
		string2		State_Origin;
		qstring27	field;
		qstring6	YYYYMM;
		integer		DATEcnt;
		real		m1;
		qstring6	vehicle_cov_reg_start;
		qstring6	vehicle_cov_reg_end;
		qstring6	vehicle_cov_ttl_start;
		qstring6	vehicle_cov_ttl_end;
	end;


	r_mm_stats j_mm_stats(r_state_counts l, r_minmax r) :=transform
		self.vehicle_cov_reg_start	:=	r.vehicle_cov_reg_start;
		self.vehicle_cov_reg_end	:=	r.vehicle_cov_reg_end;
		self.vehicle_cov_ttl_start	:=	r.vehicle_cov_ttl_start;
		self.vehicle_cov_ttl_end	:=	r.vehicle_cov_ttl_end;
		self						:=	l;
	end;

	ds_mm_stats:=join(ds_state_counts, ds_minmax
					,left.State_Origin=right.State_Origin
					and (
						(left.field[1]='R' and left.YYYYMM >= right.vehicle_cov_reg_start and left.YYYYMM < right.vehicle_cov_reg_end)
					or	(left.field[1]='T' and left.YYYYMM >= right.vehicle_cov_ttl_start and left.YYYYMM < right.vehicle_cov_ttl_end)
						)
					,j_mm_stats(left,right)
					,lookup
			)
			: persist('~thor_data400::persist::jbello_Reg_DATES_mm')
			;

	f_AVG:=round(AVE(group,ds_mm_stats.DATEcnt));

	r_mm := record
		State_Origin	:= ds_mm_stats.State_Origin;
		field			:= ds_mm_stats.field;
		field_AVG		:= f_AVG;
	end;

	ds_mm:=table(ds_mm_stats,r_mm,State_Origin,field);

	r_all := record
		State_Origin	:= ds_mm_stats.State_Origin;
		field			:= ds_mm_stats.field;
		YYYYMM			:= ds_mm_stats.YYYYMM;
		DATEcnt			:= ds_mm_stats.DATEcnt;
		field_AVG		:= ds_mm.field_AVG;
		real	m1		:=	0;
	end;

	r_all j_all (r_mm_stats L, r_mm R):= transform
		self.field_AVG	:=R.field_AVG;
		self.m1			:=(L.DATEcnt/R.field_AVG);
		self			:=L;
	end;

	ds_all:=join(ds_mm_stats, ds_mm
					,left.State_Origin=right.State_Origin
					and left.field=right.field
					,j_all(left,right)
					)
					: persist('~thor_data400::persist::jbello_vehicle_coverage_test')
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
					,left.State_Origin=right.State_Origin
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					,j12(left,right)
					,left outer
			);

	ds_trimmedM2:=dedup(sort(ds_m2,State_Origin,field,YYYYMM,YYYYMM2),State_Origin,field,YYYYMM);
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

	ds_m3:=join(ds_trimmedM2,ds_trimmedM2,left.State_Origin=right.State_Origin
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					and left.YYYYMM2<right.YYYYMM2
					,j23(left,right)
					,left outer
			);

	ds_trimmedM3:=dedup(sort(ds_m3,State_Origin,field,YYYYMM,YYYYMM2,YYYYMM3),State_Origin,field,YYYYMM);
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

	ds_m4:=join(ds_trimmedM3,ds_trimmedM3,left.State_Origin=right.State_Origin
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					and left.YYYYMM2<right.YYYYMM2
					and left.YYYYMM3<right.YYYYMM3
					,j34(left,right)
					,left outer
			);

	ds_trimmedM4:=dedup(sort(ds_m4,State_Origin,field,YYYYMM,YYYYMM2,YYYYMM3,YYYYMM4),State_Origin,field,YYYYMM);
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

	ds_m5:=join(ds_trimmedM4,ds_trimmedM4,left.State_Origin=right.State_Origin
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					and left.YYYYMM2<right.YYYYMM2
					and left.YYYYMM3<right.YYYYMM3
					and left.YYYYMM4<right.YYYYMM4
					,j45(left,right)
					,left outer
			);

	ds_trimmedM5:=dedup(sort(ds_m5,State_Origin,field,YYYYMM,YYYYMM2,YYYYMM3,YYYYMM4,YYYYMM5),State_Origin,field,YYYYMM);
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

	ds_m6:=join(ds_trimmedM5,ds_trimmedM5,left.State_Origin=right.State_Origin
					and left.field=right.field
					and left.YYYYMM<right.YYYYMM
					and left.YYYYMM2<right.YYYYMM2
					and left.YYYYMM3<right.YYYYMM3
					and left.YYYYMM4<right.YYYYMM4
					and left.YYYYMM<right.YYYYMM5
					,j56(left,right)
					,left outer
			);


	ds_trimmedM6:=dedup
					(
					sort
						(
						ds_m6
						,State_Origin
						,field
						,YYYYMM
						,YYYYMM2
						,YYYYMM3
						,YYYYMM4
						,YYYYMM5
						,YYYYMM6
						)
					,State_Origin
					,field
					,YYYYMM
					);
						

	ds_stats:=table(ds_trimmedM6
								(
								// any filter
								)
						,{
						State_Origin
						,field
						,YYYYMM
						,DATEcnt
						,m1
						,m2
						,m3
						,m4
						,m5
						,m6
						})
						: persist('~thor_data400::persist::jbello_Reg_DATES_norm_rated_plus')
						;



	//\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\	SECTION	III	REPORT

	/////////////////////////	step	6	filter and REPORT


	r_stats	:= record
		ds_stats;
	end;

	ds_TBLstats:=table(ds_stats,r_stats);

	ds_srtd1:=sort(ds_TBLstats
					(
						m1>=threshld
					and m2>=threshld
					and m3>=threshld
					and m4>=threshld
					and m5>=threshld
					and m6>=threshld
					and YYYYMM<>''
					and YYYYMM[5..6] between '01' and '12'
					)
			,State_Origin
			,field
			,YYYYMM
			);

	ds_srtd2:=sort(ds_TBLstats
					(
						m1>=threshld 
					and YYYYMM between bottomDate and topDate 
					and YYYYMM[5..6] between '01' and '12'
					)
			,State_Origin
			,field
			,-YYYYMM
			);


	r_stats demarcation(ds_TBLstats	L, ds_TBLstats	R)	:=	transform, skip (L.field=R.field)
		SELF := R;
	end;

	ds_top:=iterate(ds_srtd1
				,demarcation(left,right)
				);

	ds_bottom:=iterate(ds_srtd2
				,demarcation(left,right)
				);

	ds_NormReport:=sort(
					table	(
							ds_bottom + ds_top,
										{
										State_Origin
										,field
										,YYYYMM
										}
							)
							,State_Origin
							,field
							,YYYYMM
					)
					// : persist('~thor_data400::persist::jbello_Reg_DATES_norm_report')
					;

	reg_MIN:=min(ds_NormReport(field[1]='R'),YYYYMM);
	reg_MAX:=max(ds_NormReport(field[1]='R'),YYYYMM);
	ttl_MIN:=min(ds_NormReport(field[1]='T'),YYYYMM);
	ttl_MAX:=max(ds_NormReport(field[1]='T'),YYYYMM);

	r_minmax2 := record
		State_Origin			:= ds_NormReport.State_Origin;
		vehicle_cov_reg_start	:=min(group,ds_NormReport.YYYYMM);
		vehicle_cov_reg_end		:=max(group,ds_NormReport.YYYYMM);
		vehicle_cov_ttl_start	:=min(group,ds_NormReport.YYYYMM);
		vehicle_cov_ttl_end		:=max(group,ds_NormReport.YYYYMM);
	end;

	ds_minmax2:=table(ds_NormReport,r_minmax2,State_Origin,field[1],reg_MIN,reg_MAX,ttl_MIN,ttl_MAX);

	r_minmax2 t1_rollup (r_minmax2 L, r_minmax2 R):= transform
		self.vehicle_cov_ttl_start	:=R.vehicle_cov_ttl_start;
		self.vehicle_cov_ttl_end	:=R.vehicle_cov_ttl_end;
		self						:=L;
	end;

	ds_FinalReport:=rollup(ds_minmax2
						,left.State_Origin=right.State_Origin
						,t1_rollup(left,right)
						)
						: persist('~thor_data400::persist::jbello_vehicle_coverage_report_II')
						;


	r_final := record
		string2		State_Origin;
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


	ds_final:=project(ds_FinalReport
					,get_best_range(left)
					)
					: persist('~thor_data400::persist::jbello_vehicle_coverage_best')
					;


	///////////////////////	step	7	DENORMALIZE


	ReportRec := record
					ds_minmax2.State_Origin;
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

	ds_ReportTemplete := table(ds_minmax2,ReportRec,State_Origin);

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


	ds_FinalReport2:=denormalize(ds_ReportTemplete, ds_NormReport
					,LEFT.State_Origin=RIGHT.State_Origin
					,DEnormIt(left,right,counter)
					)
					// : persist('~thor_data400::persist::jbello_vehicle_coverage_report2')
					;


	RETURN	ds_final;
	// RETURN	ds_FinalReport;

END;



