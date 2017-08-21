
import riskwise,doxie;
EXPORT fn_SSN_S04(infile, outf) := macro
#uniquename(infile_dist)
%infile_dist% := distribute(infile((string6)dt_last_seen+'31' > Suspicious_Fraud_LN.search_range), hash(ssn));
infile_slim := RECORD
	infile.ssn;	
	cnt := COUNT(GROUP);
END;

m_did_ssn := TABLE(%infile_dist%, infile_slim, ssn, LOCAL);

has_multi_DID := m_did_ssn(cnt > 1);
//count(has_multi_DID);

%infile_dist% tjoin_multi_did(%infile_dist% le, has_multi_DID ri) := transform

self := le;

end;

infile_has_multi_DID := join(%infile_dist%, has_multi_DID, left.ssn = right.ssn, tjoin_multi_did(left, right), local);

rec_temp := record
infile;
unsigned6 temp_did := 0;
boolean isRelative := false;
end;

multiple_use_ssns_with_temp_did := join(project(infile_has_multi_DID,rec_temp), pull(doxie.Key_Header_Wild_SSN),
			right.s1=left.ssn[1] and
		right.s2=left.ssn[2] and
			right.s3=left.ssn[3] and
		right.s4=left.ssn[4] and
		right.s5=left.ssn[5] and
		right.s6=left.ssn[6] and
		right.s7=left.ssn[7] and
		right.s8=left.ssn[8] and
		right.s9=left.ssn[9] and
			left.did<>right.did,
				transform(rec_temp, 
					self.temp_did := right.did, 
					self.isRelative := false,
					self := left),
						left outer,
						atmost(right.s1=left.ssn[1] and
		right.s2=left.ssn[2] and
			right.s3=left.ssn[3] and
		right.s4=left.ssn[4] and
		right.s5=left.ssn[5] and
		right.s6=left.ssn[6] and
		right.s7=left.ssn[7] and
		right.s8=left.ssn[8] and
		right.s9=left.ssn[9], riskwise.max_atmost), keep(100), hash):persist('~thor_data400::persist::multiple_use_ssns_with_temp_did_dt_reported');

/*
ssn_slim_OLD := RECORD

  unsigned6 did;
  string9 ssn;
  integer8 dt_first_seen;
  unsigned3 dt_last_seen;
  integer8 cnt;
  unsigned6 temp_did;
  boolean isrelative;
 END;

multiple_use_ssns_with_temp_did := dataset(ut.foreign_dataland + 'thor_data400::persist::multiple_use_ssns_with_temp_did_dt_reported',ssn_slim_OLD,flat);
*/
		multiple_use_ssn_with_relative_flag := join(multiple_use_ssns_with_temp_did, pull(doxie.Key_Relatives), 
			left.did<>0 and
			left.did=right.person1,
				transform(rec_temp, 
					self.isRelative := left.temp_did<>0 and right.person2=left.temp_did, 
					self := left), 
						left outer,
						atmost(left.did=right.person1, riskwise.max_atmost), hash);

with_relative_flag := dedup(sort(distribute(multiple_use_ssn_with_relative_flag, hash(did)), did,ssn, -isRelative, local), did, ssn,local);

non_relative_recs := with_relative_flag(~isRelative);


non_relative_recs_plus := distribute(non_relative_recs(cnt > 1 and (string6)dt_last_seen+'31' > Suspicious_Fraud_LN.search_range), hash(ssn));

non_relative_recs_plus_sort := sort(project(non_relative_recs_plus,transform(recordof(infile), self.cnt := 1, self := left)),ssn,dt_first_seen,local);

non_relative_recs_plus_sort tIterationS04(non_relative_recs_plus_sort le, non_relative_recs_plus_sort ri) := transform

self.cnt := if(le.ssn = ri.ssn, le.cnt + 1, 1);
self := ri;

end;

non_relative_recs_plus_iter := iterate(non_relative_recs_plus_sort,  tIterations04(left,right),LOCAL);

//append dt_last_seen
non_relative_recs_plus_dedup := dedup(sort(distribute(non_relative_recs_plus_iter, hash(SSN)), SSN, -dt_last_seen, local), SSN, local);
#uniquename(tjoin_dt_last_seen)
Suspicious_Fraud_LN.layouts.temp_ssn %tjoin_dt_last_seen%(non_relative_recs_plus_dedup le, non_relative_recs_plus_dedup ri) := transform

self.dt_first_seen_non_relative_multiple_use := le.dt_first_seen;
self.dt_last_seen_non_relative_multiple_use := ri.dt_last_seen;
self := le;
self := [];
end;

non_relative_recs_plus_dates := join(non_relative_recs_plus_iter(cnt = 2), non_relative_recs_plus_dedup, left.SSN = right.SSN, 
%tjoin_dt_last_seen%(left, right),local);

outf := non_relative_recs_plus_dates;

endmacro;