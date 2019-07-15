import InsuranceHeader_Salt_T46, idl_header;

export proc_buildsample(string wuid, string thorenv = 'PROD', string changes = '') := module

 rec := RECORD
     unsigned2 rule;
     integer2 conf;
     integer2 dateoverlap;
     integer2 conf_prop;
     unsigned6 did1;
     unsigned6 did2;
     unsigned6 rid1;
     unsigned6 rid2;
    END;

// wuid := 'W20121118-095747'; // thorlib.wuid();

ds := dataset('~thor_data400::base::insuranceheader::idl_salt_iter_possiblematches_' + wuid, rec, thor);
   
info := '_' + thorenv + '_' + changes;	 

filename_matchSampleDetail 			:= 	'~thor::personheader::MatchSampleDetail_' + wuid;
filename_matchsampledetail_csv 	:=  'Pairs-Person_' +  wuid + info + '.csv';
filename_Candidates							:=  '~thor::personheader::candidate_' + wuid;
filename_Candidates_csv 				:=  'Data-Person_' +  wuid + info + '.csv';

   ds1 := choosen(ds(conf = 46), 200);
   rec1 := record
   	integer recordid;
   	rec;
   end;
   ds2 := project(ds1, transform(rec1, self.recordid := counter, self := left));
   // output(ds2, named('MatchSample'));
   
   k1 := InsuranceHeader_Salt_T46.Keys(idl_header.header_ins).MatchSample;
   j1 := join(ds2, k1, left.did1 = right.did1 and left.did2 = right.did2, transform(recordof(right), self := right));
   res1 := output(dedup(sort(j1, did1, did2, -conf), did1, did2), , filename_matchSampleDetail, csv(HEADING(SINGLE)), overwrite);
   
   rec2 := record
   	integer   recordid;
   	integer 	id;
   	unsigned6 did;
   end;
   rec2 NormThem(recordof(ds2) l, INTEGER C) := TRANSFORM
   	self.recordid 	:= l.recordid;
   	self.id 	:= c;
   	self.did 	:= if(c%2 = 1, l.did1, l.did2);
   	self 					:= [];
   END;
   ChildRecs := NORMALIZE(ds2,2,NormThem(left, counter));
   // output(childRecs);
   
   k2 := InsuranceHeader_Salt_T46.Keys(idl_header.header_ins).Candidates;
   res := sort(join(childRecs, k2, left.did = right.did), recordid, id);
   res2 := output(project(res, recordof(k2)), , filename_Candidates, csv(HEADING(SINGLE)), overwrite);

// edata12:10.121.146.129:/export/home/shahmr/crt
// dev:    10.194.72.226: /data/eusa231/ClusterReviewTool
	// Despray
   res3 := fileservices.fDespray(filename_matchSampleDetail,  '10.121.146.129', '/export/home/shahmr/crt/' + filename_matchsampledetail_csv,,,,TRUE);
   res4 := fileservices.fDespray(filename_Candidates,         '10.121.146.129', '/export/home/shahmr/crt/' + filename_candidates_csv,,,,TRUE);
   									
	export run := sequential(res1, res2, output(res3), output(res4));

end;