#workunit('name','AMEX Process4 Dedup all Relatives');
//                    RUN on THOR_200
import ut;
   infile_name := '~gwhitaker::out::AMEX_job1_process2_relDIDs';
// infile_name := '~gwhitaker::out::AMEX_job2_process2_relDIDs';

   outfile_name := '~gwhitaker::in::AMEX_job1_process5_relDIDs';
// outfile_name := '~gwhitaker::in::AMEX_job2_process5_relDIDs';


ds_in := dataset (infile_name, amex.layouts.inputProc1, CSV(QUOTE('"')));
ds_dist := DISTRIBUTE (ds_in, hash(did));
ds_sort := SORT(ds_dist, did);
ds_dedup := DEDUP(ds_sort, did);
OUTPUT(ds_dedup, , outfile_name, CSV(QUOTE('"')),overwrite);  
