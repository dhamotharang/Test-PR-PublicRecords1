import Header, Watchdog, doxie, doxie_files, Risk_Indicators, eMerges, official_records, DayBatchPCNSR, American_Student_List, Infutor, ut;

// Use Best File to initialize Precalc data
wdb := Watchdog.File_Best_nonglb /*(st='FL') */;

age_init := distribute(project(wdb,
                               transform(Layout_Age_Precalc,
					                self.dob_age := ut.GetAgeI((unsigned8)left.dob),
					                self := left)), hash(did));
					
// Determine earliest date first seen from full Header (any source)
h := Header.File_Headers /*(st='FL')*/;

layout_hdfs := record
h.did;
h.src;
h.dt_first_seen;
h.dob;
end;

hdfs := distribute(table(h(dt_first_seen <> 0), layout_hdfs), hash(did));

layout_hdfs_stat := record
hdfs.did;
dt_first_seen := min(group, hdfs.dt_first_seen);
end;

hdfs_stat := table(hdfs, layout_hdfs_stat, did, local);

age_hdfs := join(age_init,
                 hdfs_stat,
				 left.did = right.did,
				 transform(Layout_Age_Precalc,
				           self.dt_first_seen := right.dt_first_seen,
						   self := left),
				 left outer,
				 local);

// Determine earliest date first seen from Header (credit bureau sources)				           
hdfs_cb := hdfs(src in ['EQ','TU','LT']);

hdfs_cb_stat := table(hdfs_cb, layout_hdfs_stat, did, local);

age_hdfs_cb := join(age_hdfs,
                    hdfs_cb_stat,
				 left.did = right.did,
				 transform(Layout_Age_Precalc,
				           self.dt_first_seen_cb := right.dt_first_seen,
						 self := left),
                     left outer,
				 local);

// Determine earliest dob from Header (credit bureau sources)	
layout_hdob_stat := record
hdfs_cb.did;
dob := min(group, hdfs_cb.dob);
end;

hdfs_cd_dob_stat := table(hdfs_cb(dob <> 0), layout_hdob_stat, did, local);

age_hdob_cb := join(age_hdfs_cb,
                    hdfs_cd_dob_stat,
				 left.did = right.did,
				 transform(Layout_Age_Precalc,
				           self.dob_cb := right.dob,
                               self.dob_age_cb := ut.GetAgeI(right.dob),
						 self := left),
                     left outer,
				 local);
		           
// Determine Driver's license earliest issue date
dl := doxie_files.File_dl;

layout_dl_slim := record
dl.did;
dl.dt_first_seen;
dl.dt_last_seen;
dl.dob;
unsigned4 issue_date := if(dl.orig_issue_date <> 0, dl.orig_issue_date, dl.lic_issue_date);
end;

dl_info := distribute(table(dl(did <> 0), layout_dl_slim), hash(did));

layout_dl_issue_stat := record
dl_info.did;
unsigned3 dl_dt_first_seen := min(group, if(dl_info.dt_first_seen <> 0, dl_info.dt_first_seen, dl_info.issue_date));
unsigned4 dl_issue_dt := min(group, dl_info.issue_date);
end;

dl_issue := table(dl_info(dt_first_seen <> 0 or issue_date <> 0), layout_dl_issue_stat, did, local);

age_dl_issue := join(age_hdob_cb,
                     dl_issue,
					 left.did = right.did,
					 transform(Layout_Age_Precalc,
					          self.dl_dt_first_seen := right.dl_dt_first_seen,
					          self.dl_issue_date := right.dl_issue_dt,
							  self := left),
					 left outer,
					 local);
					 
// Add dob from most recent DL
dl_info_dist := distribute(dl_info(dob <> 0), hash(did));
dl_info_sort := sort(dl_info_dist, did, -dt_last_seen, local);
dl_info_dedup := dedup(dl_info_sort, did, local);

age_dl_dob := join(age_dl_issue,
                   dl_info_dedup,
				   left.did = right.did,
				   transform(Layout_Age_Precalc,
					          self.dl_dob := right.dob,
							  self.dl_dob_age := ut.GetAgeI(right.dob),
							  self := left),
					 left outer,
					 local);

// Determine Voter's registration earliest date first seen and registration date
vr := eMerges.file_voters_base;

layout_vr_slim := record
unsigned6 did := (unsigned6)vr.did_out;
unsigned4 dt_first_seen := (unsigned4)vr.date_first_seen;
unsigned4 dt_last_seen := (unsigned4)vr.date_last_seen;
unsigned4 dob := (unsigned4)vr.dob;
unsigned4 reg_date := (unsigned4)vr.regDate;
end;

vr_info := distribute(table(vr((unsigned6)did_out <> 0), layout_vr_slim), hash(did));

layout_vr_reg_stat := record
vr_info.did;
unsigned4 vr_dt_first_seen := min(group, if(vr_info.dt_first_seen <> 0, vr_info.dt_first_seen, vr_info.reg_date));
unsigned4 vr_reg_date := min(group, vr_info.reg_date);
end;

vr_reg := table(vr_info(dt_first_seen <> 0 or reg_date <> 0), layout_vr_reg_stat, did, local);

age_vr_reg := join(age_dl_dob,
                   vr_reg,
				   left.did = right.did,
				   transform(Layout_Age_Precalc,
					         self.vr_dt_first_seen := right.vr_dt_first_seen,
					         self.vr_reg_date := right.vr_reg_date,
							 self := left),
					 left outer,
					 local);

// Add dob from most recent VR
vr_info_dist := distribute(vr_info(dob <> 0), hash(did));
vr_info_sort := sort(vr_info_dist, did, -dt_last_seen, local);
vr_info_dedup := dedup(vr_info_sort, did, local);

age_vr_dob := join(age_vr_reg,
                   vr_info_dedup,
				   left.did = right.did,
				   transform(Layout_Age_Precalc,
					         self.vr_dob := right.dob,
							 self.vr_dob_age := ut.GetAgeI(right.dob),
							 self := left),
					 left outer,
					 local);

/*
// No DIDs on the marriage data in the Official Records file
// A standalone marriage and divorces file includes the official records and can be found in:
//    marriages_divorces.File_Marriage_Divorce_Base
// This file has not been DIDed.  Apparently not enough information is populated.

// Determine official records for marriage or divorce earliest document date
ofr := official_records.file_party_Base;

layout_ofr_slim := record
ofr.did;
unsigned4 doc_filed_dt := (unsigned4)ofr.doc_filed_dt;
unsigned4 dob := (unsigned4)ofr.entity_dob;
end;

ofr_info := distribute(table(ofr(did <> 0,
                (vendor='01' AND StringLib.StringToUpperCase(doc_type_desc)='AMEND JUD DISSOL MARR') OR
		        (vendor='01' AND StringLib.StringToUpperCase(doc_type_desc)='CERTIFICATE MARRIAGE') OR
		        (vendor='01' AND StringLib.StringToUpperCase(doc_type_desc)='JUDGEMENT DISSOL MARR') OR
		        (vendor='02' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE RECORD') OR
		        (vendor='03' AND StringLib.StringToUpperCase(doc_type_desc)='DIVORCE WITH CONVEYANCE') OR
		        (vendor='03' AND StringLib.StringToUpperCase(doc_type_desc)='FINAL JUDGEMENT DISSOLUTION OF MARRIAGE/DIVORCE') OR
		        (vendor='04' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE SETTLEMENT AGREEMENT') OR
		        (vendor='05' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE CERTIFICATE') OR
		        (vendor='05' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE LICENSE AFFIDAVIT') OR
		        (vendor='07' AND StringLib.StringToUpperCase(doc_type_desc)='DISSOLUTION OF MARRIAGE') OR
		        (vendor='08' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE RECORD') OR
		        (vendor='09' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE RECORD') OR
		        (vendor='10' AND StringLib.StringToUpperCase(doc_type_desc)='CTF MAR') OR
		        (vendor='10' AND StringLib.StringToUpperCase(doc_type_desc)='DIVORCE') OR
		        (vendor='10' AND StringLib.StringToUpperCase(doc_type_desc)='MAR CTF') OR
		        (vendor='10' AND StringLib.StringToUpperCase(doc_type_desc)='MAR LIC') OR
		        (vendor='10' AND StringLib.StringToUpperCase(doc_type_desc)='MAR REC') OR
		        (vendor='10' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE LICENSE') OR
		        (vendor='10' AND StringLib.StringToUpperCase(doc_type_desc)='SEPARAT') OR
		        (vendor='11' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE LICENSE') OR
		        (vendor='12' AND StringLib.StringToUpperCase(doc_type_desc)='ABST DIV DEC') OR
		        (vendor='12' AND StringLib.StringToUpperCase(doc_type_desc)='CONT MARR AFFID') OR
		        (vendor='12' AND StringLib.StringToUpperCase(doc_type_desc)='COR FJ DIVORCE') OR
		        (vendor='12' AND StringLib.StringToUpperCase(doc_type_desc)='CORR F JUD MARR') OR
		        (vendor='12' AND StringLib.StringToUpperCase(doc_type_desc)='FJ DISSOL/MARR') OR
		        (vendor='12' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE RECORD') OR
		        (vendor='14' AND StringLib.StringToUpperCase(doc_type_desc)='AFFIDAVIT CONTINUOUS MARRIAGE') OR
		        (vendor='15' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE RECORD') OR
		        (vendor='16' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE RECORD') OR
		        (vendor='16' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE LICENSES') OR
		        (vendor='17' AND StringLib.StringToUpperCase(doc_type_desc)='DECLARATION MARRIAGE') OR
		        (vendor='17' AND StringLib.StringToUpperCase(doc_type_desc)='DISSOLUTION MARRIAGE') OR
		        (vendor='17' AND StringLib.StringToUpperCase(doc_type_desc)='FINAL DIVORCE') OR
		        (vendor='17' AND StringLib.StringToUpperCase(doc_type_desc)='INTERLOCUTORY DIVORCE') OR
		        (vendor='17' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE') OR
		        (vendor='17' AND StringLib.StringToUpperCase(doc_type_desc)='MODIFY FINAL DIVORCE') OR
		        (vendor='17' AND StringLib.StringToUpperCase(doc_type_desc)='MODIFY INTLOC DIVORCE') OR
		        (vendor='18' AND StringLib.StringToUpperCase(doc_type_desc)='MARR CRT') OR
		        (vendor='19' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE LICENSE') OR
		        (vendor='20' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE RECORD') OR
		        (vendor='21' AND StringLib.StringToUpperCase(doc_type_desc)='MARRIAGE RECORD')), layout_ofr_slim), hash(did));

layout_ofr_stat := record
ofr_info.did;
unsigned4 ofr_doc_filed_dt := min(group, ofr_info.doc_filed_dt);
end;

ofr_doc_filed := table(ofr_info(doc_filed_dt <> 0), layout_ofr_stat, did, local);

age_ofr_doc_filed := join(age_vr_dob,
                          ofr_doc_filed,
				          left.did = right.did,
				          transform(Layout_Age_Precalc,
					         self.ofr_doc_filed_dt := right.ofr_doc_filed_dt,
							 self := left),
					 left outer,
					 local);

// Add dob from most recent document fileing
ofr_info_dist := distribute(ofr_info(dob <> 0), hash(did));
ofr_info_sort := sort(ofr_info_dist, did, -doc_filed_dt, local);
ofr_info_dedup := dedup(ofr_info_sort, did, local);

age_ofr_dob := join(age_ofr_doc_filed,
                    ofr_info_dedup,
				    left.did = right.did,
				    transform(Layout_Age_Precalc,
					         self.ofr_dob := right.dob,
							 self.ofr_dob_age := ut.GetAgeI(right.dob),
							 self := left),
					 left outer,
					 local);

*/

// Append information from pConsumer file
pcn := DayBatchPCNSR.File_PCNSR;

layout_pcn_slim := record
pcn.did;
unsigned3 pcn_dob := (unsigned3)pcn.date_of_birth;
unsigned1 pcn_dob_age := ut.GetAgeI(((unsigned3)pcn.date_of_birth)*100);
unsigned2 pcn_hh_arrival_date := (unsigned2)pcn.household_arrival_date;
unsigned3 pcn_refresh_date := (unsigned3)pcn.refresh_date;
unsigned3 pcn_hh_income := (unsigned3)pcn.household_income;
string1   pcn_spouse_indicator := pcn.spouse_indicator;
end;

pcn_info := table(pcn(did <> 0), layout_pcn_slim);
pcn_info_dist := distribute(pcn_info, hash(did));
pcn_info_grp := group(sort(pcn_info_dist,did,-pcn_hh_arrival_date,-pcn_refresh_date,local),did,local);
pcn_info_dedup := group(dedup(pcn_info_grp, true));	

age_pcn := join(age_vr_dob,
                pcn_info_dedup,
			    left.did = right.did,
				transform(Layout_Age_Precalc,
                          self.pcn_dob := right.pcn_dob,
						  self.pcn_dob_age := right.pcn_dob_age,
                          self.pcn_hh_arrival_date := right.pcn_hh_arrival_date,
                          self.pcn_refresh_date := right.pcn_refresh_date,
                          self.pcn_hh_income := right.pcn_hh_income,
                          self.pcn_spouse_indicator := right.pcn_spouse_indicator,
						  self := left),
				left outer,
				local);

// Determine American Student List earliest date first seen and dob
asl := American_student_list.File_american_student_DID;

layout_asl_slim := record
asl.did;
unsigned4 dt_first_seen := (unsigned4)asl.date_first_seen;
unsigned4 dt_last_seen := (unsigned4)asl.date_last_seen;
unsigned4 dob := (unsigned4)asl.dob_formatted;
string2   asl_hs_class := asl.class;
string2   asl_college_class := asl.college_class;
end;

asl_info := distribute(table(asl(did <> 0), layout_asl_slim), hash(did));

layout_asl_stat := record
asl_info.did;
unsigned4 asl_dt_first_seen := min(group, asl_info.dt_first_seen);
end;

asl_dfs := table(asl_info(dt_first_seen <> 0), layout_asl_stat, did, local);

age_asl_dfs := join(age_pcn,
                    asl_dfs,
				    left.did = right.did,
				    transform(Layout_Age_Precalc,
					          self.asl_dt_first_seen := right.asl_dt_first_seen,
							  self := left),
					left outer,
					local);

// Add dob from most recent asl record
asl_info_dist := distribute(asl_info(dob <> 0), hash(did));
asl_info_sort := sort(asl_info_dist, did, -dt_last_seen, local);
asl_info_dedup := dedup(asl_info_sort, did, local);

age_asl_dob := join(age_asl_dfs,
                    asl_info_dedup,
				    left.did = right.did,
				    transform(Layout_Age_Precalc,
					         self.asl_dob := right.dob,
							 self.asl_dob_age := ut.GetAgeI(right.dob),
                             self.asl_hs_class := right.asl_hs_class,
							 self.asl_college_class := right.asl_college_class,
							 self := left),
					 left outer,
					 local);

// Add earliest DOB from Infutor file
infu := Infutor.Map_file_infutor_did_new2old;

layout_infu_slim := record
infu.did;
unsigned4 dob := (unsigned4)infu.orig_dob_dd_appended;
end;

infu_info := distribute(table(infu(did <> 0, (unsigned4)orig_dob_dd_appended <> 0),layout_infu_slim), hash(did));

layout_infu_stat := record
infu_info.did;
unsigned4 infu_dob := min(group, infu_info.dob);
end;

infu_dob := table(infu_info, layout_infu_stat, did, local);

age_infu_dob := join(age_asl_dob,
                     infu_dob,
				    left.did = right.did,
				    transform(Layout_Age_Precalc,
					          self.infu_dob := right.infu_dob,
							self.infu_dob_age := ut.GetAgeI(right.infu_dob),
							self := left),
					left outer,
					local);


// Determine SSN issue date and corresponding age
kssn := Risk_Indicators.key_ssn_table;

layout_ssn_issue := record
qstring9 ssn := (qstring)kssn.ssn;
kssn.official_first_seen;
kssn.header_first_seen;
kssn.dt_first_deceased;
kssn.decs_dob;
end;

ssn_info := table(kssn(isValidFormat, isSequenceValid), layout_ssn_issue);

age_ssn := join(age_infu_dob(ssn <> ''),
                ssn_info,
				left.ssn = right.ssn,
				transform(Layout_Age_Precalc,
                          self.ssn_issue_date := right.official_first_seen,
                          self.ssn_dt_first_seen := right.header_first_seen,
                          self.ssn_decs_dod := right.dt_first_deceased,
                          self.ssn_decs_dob := right.decs_dob,
                          self.ssn_decs_dod_age := ut.GetAgeI(right.decs_dob) - ut.GetAgeI(right.dt_first_deceased),
						  self := left),
				left outer,
				hash);
				
age_ssn_dist := distribute(age_ssn + age_infu_dob(ssn = ''), hash(did));

export age_precalc_init := age_ssn_dist : persist('TMTEST::age_precalc');