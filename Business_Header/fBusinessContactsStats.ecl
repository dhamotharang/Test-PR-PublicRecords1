/*
The confidence score is assigned as follows:
  1.  Each Build, the scores are recalculated.
  2.  Each source has a default confidence score(low, medium, or high) assigned.
  3.  For the following conditions, a contact means a Non-Zero Did or Did = 0 and a person name, address combo.
      Also, a Company means a non-zero Bdid, or a Bdid = 0 and a company name and address combo.
      Scores will be increased if any of the following conditions are met:
      a. There are multiple sources for that contact at that company. -> add scores
      b. There are multiple records from the same source for that company(we keep receiving it in every update).
         Could find out the date window, date_last_seen - date_first_seen, the larger the better.
      c. One contact, multiple Bdids in the same Gid
  4. Scores will be decreased if any of the following conditions are met:
      a. Subtract points for old date last seens.  Maybe amount subtracted should depend on source.
      b. Records with no updates(date last seen) for a certain amount of time(Old records).  This time window will 
			   probably need to be dependent on the source's: default confidence level, update frequency, 
				 type of update(full file replacement or just an update with new records).  It should also be stepped so that a 
				 record 5 years old will have more points removed than a record 6 months old(for the same source).
*/

// ok, so need to rollup contacts file a couple different ways
// get records with did and bdid
// count records with that combo
// 
//fBusinessContactsStats(Business_Header.File_BCP_ForStats);
export fBusinessContactsStats(dataset(Layout_Business_Contacts_Stats) pBusinessContacts) := 
function

	shared lLowConfidenceSources := 
		['PP','AA','SA','DU','AT'];

	shared lMediumConfidenceSources := [ 
		'QQ','V' ,'CU','CF','SB','SK',
		'FC','WT','MD','FA','ED','GB',
		'GG','ID','IF','II','ZM','L2',
		'LB','LP','PR','Y' ,'AF','E', 
		'PL','WC','W' ,'ST','I'
	];

	shared lHighConfidenceSources := [
		'IA','LJ','B' ,'BM','BN','BR',
	  'C' ,'D' ,'DC','EB','F' ,'DE',
	  'U' ,'U2','FD','FF','FN','IN'
	];

	getdefaultscore(string pSource) :=
		map(
			pSource in lLowConfidenceSources 		=> 3,
			pSource in lMediumConfidenceSources => 6,
			pSource in lHighConfidenceSources 	=> 9,
			0);

	//first, assign default scores
	
	Layout_Business_Contacts_Stats tAddDefaultScore(Layout_Business_Contacts_Stats l) := 
	transform
		self.combined_new_score := if(l.from_hdr = 'N' or 
				(l.from_hdr != 'N' and (l.source = 'PP' or l.source = 'QQ')), getdefaultscore(l.source), 3);
		self := l;
	
	end;

	DefaultScore := project(pBusinessContacts, tAddDefaultScore(left));

	//first, take records with did and bdid
	Bc_With_Did_Bdid	:= DefaultScore(did != 0, bdid != 0);
	Bc_rest						:= DefaultScore(not(did != 0 and bdid != 0));

	Bc_With_Did				:= DefaultScore(did != 0,bdid = 0);
	Bc_With_Bdid			:= DefaultScore(did = 0, bdid != 0);
	Bc_With_Neither		:= DefaultScore(did = 0, bdid = 0);
	
	Bc_With_Did_Bdid_source := table(Bc_With_Did_Bdid, {did, bdid, source,combined_new_score}, did, bdid,source,combined_new_score);

	//how many different sources exist for that contact at that company?
	source_record_both :=
	record
		Bc_With_Did_Bdid_source.did;
		Bc_With_Did_Bdid_source.bdid;
		unsigned1 total_score := sum(group,Bc_With_Did_Bdid_source.combined_new_score);
	end;
	
	Bc_With_Did_Bdid_total_score := table(Bc_With_Did_Bdid_source, source_record_both, did, bdid);
	
	//match back to input business contacts on did, bdid, and modify score
	
	Bc_With_Did_Bdid_sources_dist := distribute(Bc_With_Did_Bdid_total_score	, hash(did, bdid));
	Bc_With_Did_Bdid_dist					:= distribute(Bc_With_Did_Bdid							, hash(did, bdid));

	Layout_Business_Contacts_Stats tGetScores(Layout_Business_Contacts_Stats l, source_record_both r) :=
	transform
		self.combined_new_score := r.total_score;
		self := l;
	end;
	
	bc_scores := join( Bc_With_Did_Bdid_dist
										,Bc_With_Did_Bdid_sources_dist
										,left.did = right.did
										and left.bdid = right.bdid
										,tGetScores(left,right)
										,local
									);
										
	return bc_scores + Bc_rest;
	
end;



