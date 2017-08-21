
IMPORT USAA, ut;

REAL yearsApart(unsigned a, unsigned b) := abs(((a div 100) * 12 + (a % 100)) - ((b div 100) * 12 + (b % 100))) / 12;

UNSIGNED GetAgeI(unsigned8 dob) := if(dob = 0, 0, ((unsigned8)constants.TODAY - (dob div 100)) div 100);
 
ds := USAA.file_marketing_prospects;

// ds := USAA._sample_prospects;

ds_slimmed := table(ds,{seq,did,dt_first_seen,dt_last_seen,dob,city_name,zip,
	boolean isApoFpo := regexfind('^APO$| APO$| APO |^APO |^FPO$| FPO$| FPO |^FPO ',city_name),
	boolean isZip1 := zip IN USAA.zipcodes_milbase,
	boolean isZip2 := zip IN USAA.zipcodes_proximity_milbase}, LOCAL);
	
ds_sorted := project(sort(ds_slimmed,did,seq,dt_first_seen,dt_last_seen,record,LOCAL),
                          transform({recordof(ds_slimmed);unsigned2 cnt_seq_zip1;unsigned2 cnt_seq_zip2;boolean me_and_prev_are_zip2},
	self.cnt_seq_zip1 := if(left.isZip1 or left.isApoFpo,1,0),
	self.cnt_seq_zip2 := if(left.isZip2 or left.isApoFpo,1,0),
	self.me_and_prev_are_zip2 := false,
	self := left));

ds_iterated := iterate(ds_sorted,transform(recordof(ds_sorted),
	same_span :=
		left.did = right.did and left.seq = right.seq and right.dt_first_seen <= left.dt_last_seen;
	self.dt_first_seen := if(same_span,left.dt_first_seen,right.dt_first_seen),
	self.dt_last_seen := if(same_span and right.dt_last_seen <= left.dt_last_seen,left.dt_last_seen,right.dt_last_seen),
	self.isApoFpo := if(same_span,left.isApoFpo or right.isApoFpo,right.isApoFpo),
	self.isZip1 := if(same_span,left.isZip1 or right.isZip1,right.isZip1),
	self.isZip2 := if(same_span,left.isZip2 or right.isZip2,right.isZip2),
	self.cnt_seq_zip1 := if(same_span,if(left.cnt_seq_zip1 > right.cnt_seq_zip1,left.cnt_seq_zip1,right.cnt_seq_zip1),right.cnt_seq_zip1),
	self.cnt_seq_zip2 := if(same_span,if(left.cnt_seq_zip2 > right.cnt_seq_zip2,left.cnt_seq_zip2,right.cnt_seq_zip2),right.cnt_seq_zip2),
	self := right), LOCAL);

ds_iterated xfm_rllp(RECORDOF(ds_iterated) l, RECORDOF(ds_iterated) r) :=
	TRANSFORM
		SELF.dob := IF( l.dob = 0 OR r.dob <= l.dob, r.dob, l.dob );
		SELF     := r;
	END;
	
ds_rolled := rollup(ds_iterated,xfm_rllp(LEFT,RIGHT),did,seq,LOCAL);

ds_end_dated := iterate(sort(ds_rolled,did,-seq,LOCAL),transform(recordof(ds_rolled),
	self.dt_last_seen := if(left.did = right.did,left.dt_first_seen,(UNSIGNED)constants.TODAY),
	self := right),LOCAL);

ds_addr_hist := iterate(sort(ds_end_dated,did,seq,LOCAL),transform(recordof(ds_end_dated),
	self.cnt_seq_zip1 := if(right.cnt_seq_zip1 = 0,0,if(left.did = right.did,left.cnt_seq_zip1 + right.cnt_seq_zip1,right.cnt_seq_zip1)),
	self.cnt_seq_zip2 := if(right.cnt_seq_zip2 = 0,0,if(left.did = right.did,left.cnt_seq_zip2 + right.cnt_seq_zip2,right.cnt_seq_zip2)),
	self.me_and_prev_are_zip2 := (left.isZip2 or left.isApoFpo) and (right.isZip2 or right.isApoFpo),
	self := right), LOCAL);

ds_stats := table(ds_addr_hist,{
	did,
	STRING3    ind_age        := '',
	INTEGER4   DOB            := MAX(GROUP,dob),
	DECIMAL6_2 Count_LN_Yrs   := YearsApart(MAX(GROUP,dt_last_seen),MIN(GROUP,dt_first_seen)),
	UNSIGNED2  Count_Zip1     := SUM(GROUP,IF(isZip1 or isApoFpo,1,0)),
	UNSIGNED2  Conseq_Zip1    := MAX(GROUP,cnt_seq_zip1),
	DECIMAL6_2 AvgMoves_LN    := (COUNT(GROUP) - 1) / YearsApart(MAX(GROUP,dt_last_seen),MIN(GROUP,dt_first_seen)),
	UNSIGNED2  Count_Zip2     := SUM(GROUP,IF(isZip2 or isApoFpo,1,0)),
	UNSIGNED2  Conseq_Zip2    := MAX(GROUP,cnt_seq_zip2),
	DECIMAL6_2 AvgMoves_Zip2  := SUM(GROUP,IF(me_and_prev_are_zip2,1,0)) / SUM(GROUP,IF(isZip2 or isApoFpo,YearsApart(dt_last_seen,dt_first_seen),0)),
	STRING6    Recent_Dt_Zip1 := MAX(GROUP,IF(isZip1 or isApoFpo,(STRING6)dt_last_seen,'000000')),
	STRING6    Recent_Dt_Zip2 := MAX(GROUP,IF(isZip2 or isApoFpo,(STRING6)dt_last_seen,'000000'))
	},did, LOCAL);
	
EXPORT file_residence_metrics := PROJECT(ds_stats, TRANSFORM(USAA.layout_residence_metrics,
  SELF.ind_age := (STRING3)GetAgeI( LEFT.dob ),
	SELF.DOB     := LEFT.dob[5..6] + LEFT.dob[1..4],
	SELF         := LEFT))

					//  ******** THIS CODE FOR DATALAND ONLY  ********
					: persist('persist::dataland::file_USAA_residence_metrics');

