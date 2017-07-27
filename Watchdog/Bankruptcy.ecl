//Find the most recent bankruptcy court code and case number for each DID
import Bankrupt;

search_file := bankrupt.File_BK_Search((integer)debtor_did<>0);
main_file := bankrupt.File_BK_Main;

search_rec := record
search_file.debtor_did;
search_file.seq_number;
search_file.court_code;
search_file.case_number;
end;

main_rec := record
main_file.seq_number;
main_file.court_code;
main_file.case_number;
main_file.court_location;
main_file.disposed_date;
main_file.orig_filing_date;
end;

slim_search := table(search_file,search_rec);
slim_main := table(main_file,main_rec);

both_rec := record
 	string10   seq_number;
	string5   court_code;
	string7   case_number;
	string40   court_location;
    unsigned3  dt_last_seen;
    unsigned6   DID;
end;

both_rec getAll(slim_main L, slim_search R) := transform
 self.did := (unsigned6)r.debtor_did; 
 self.dt_last_seen := (unsigned3)if(l.disposed_date!='',l.disposed_date,l.orig_filing_date);
 self := l;
end;

withAll := join(slim_main,slim_search,left.case_number=right.case_number and 
									  left.court_code=right.court_code and
									  left.seq_number=right.seq_number,getAll(left,right),hash);

//Find the lastest case number per DID
slim_h := distribute(withAll,hash(did));
srt_h  := sort(slim_h, did, -dt_last_seen, -seq_number, -court_code,-case_number, local);
dup_h  := dedup(srt_h,did,local);
re_dis := distribute(dup_h,hash(court_code,case_number));

//Find highest seq_number per case number
dis_case := distribute(withAll,hash(court_code,case_number));
srt_case := sort(dis_case,court_code,case_number,-seq_number,local);
dup_case := dedup(srt_case,court_code,case_number,local);

final_rec := record
  unsigned6   DID;
  string5     court_code;
  string7     case_number;	
  qstring22   CourtCaseSeq;
  unsigned4   Main_Cnt;
  unsigned4   Search_Cnt;
end;

final_rec getFinal(re_dis L, dup_case R) := transform
  self.CourtCaseSeq := trim(l.Court_Code,all) + trim(l.Case_Number,all) + trim(r.seq_number,all);
  self.court_code := l.Court_Code;
  self.case_number := l.Case_Number;
  self.Main_Cnt := 0;
  self.Search_Cnt := 0;
  self := l;
end;

withSeq := join(re_dis,dup_case,left.court_code=right.court_code and 
								left.case_number=right.case_number,getFinal(left,right),local);

//get main file court code, case number, count
main_dist := distribute(slim_main, hash(court_code,case_number));

main_count_rec := record
	main_dist.court_code;
     main_dist.case_number;
	main_count := count(group);
end;

main_count_tbl := table(main_dist,main_count_rec,court_code,case_number,local);

//get search file court code, case number, count
search_dist := distribute(slim_search, hash(court_code,case_number));

search_count_rec := record
	search_dist.court_code;
     search_dist.case_number;
	search_count := count(group);
end;

search_count_tbl := table(search_dist,search_count_rec,court_code,case_number,local);

//append main count to out file
final_rec getMain(withSeq L, main_count_tbl R) := transform
  self.Main_Cnt := R.main_count;
  self := l;
end;

withMain := join(withSeq,main_count_tbl,left.court_code=right.court_code and 
								left.case_number=right.case_number,
								getMain(left,right),left outer,local);

//append search count to out file
final_rec getSearch(withMain L, search_count_tbl R) := transform
  self.Search_Cnt := R.search_count;
  self := l;
end;

withSearch := join(withMain,search_count_tbl,left.court_code=right.court_code and 
	   	  		  			          left.case_number=right.case_number,
								     getSearch(left,right),left outer,local);

out_rec := record
  withSearch.DID;
  withSearch.CourtCaseSeq;
  withSearch.Main_Cnt;
  withSearch.Search_Cnt;
end;

outTbl := table(withSearch, out_rec);  

export Bankruptcy := distribute(outTbl,hash(did)) : persist('Persist::Watchdog_Bankruptcy');