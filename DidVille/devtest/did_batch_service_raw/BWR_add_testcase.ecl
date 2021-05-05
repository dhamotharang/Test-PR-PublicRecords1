// ----------------------------------------------------------------------------------------------
//   The code below is for reference only; you must change it to reflect the new testcase(s) being 
// added to the bucket.
// ----------------------------------------------------------------------------------------------
#WORKUNIT('name', '-- dev regression: add testcase --');

IMPORT dev_regression, didville, STD, dx_header;

my_query := 'didville.Did_Batch_Service_Raw';
svc_layout := didville.devtest.did_batch_service_raw.layout;

didville.Layout_Did_InBatchRaw xtBatch(STRING acctno, STRING fname, STRING mname, STRING lname, STRING dob, 
  STRING prange, STRING pname, STRING addr_suffix, STRING city, STRING state, STRING zip) := TRANSFORM
  SELF.acctno := acctno;
  SELF.name_first := fname;
  SELF.name_middle := mname;
  SELF.name_last := lname;
  SELF.dob := dob;
  SELF.prim_range := prange;
  SELF.prim_name := pname;
  SELF.suffix := addr_suffix;
  SELF.p_city_name := city;
  SELF.st := state;
  SELF.z5 := zip;
  SELF := [];
END;
handpicked := 
  DATASET([xtBatch('001', 'fname', 'mname', 'lname', 'dob', 'prim_range', 'prim_name', 'addr_suffix', 'city', 'state', 'zip')])
  ;
handpicked;

h0 := CHOOSEN(dx_header.key_header()(did>1000, LENGTH(TRIM(fname)) > 3, LENGTH(TRIM(lname)) > 3), 10000);
h1 := DEDUP(SORT(h0, fname[3], fname), fname[3], fname);
h1;

bin_recs := PROJECT(h1, 
  xtBatch('00'+COUNTER, LEFT.fname, LEFT.mname, LEFT.lname, ''+LEFT.dob, LEFT.prim_range, LEFT.prim_name, LEFT.suffix, LEFT.city_name, LEFT.st, LEFT.zip));
bin_recs;
// brecs := PROJECT(h1, xt(CHOOSEN(h1, COUNTER*20, 20);
// brecs;

svc_layout.request xt(DATASET(didville.Layout_Did_InBatchRaw) batch_in_recs) := TRANSFORM
  SELF.Appends := 'BEST_ALL';
  // SELF.Verify := 'BEST_ALL';
  // SELF.Fuzzies := '';
  // SELF.Deduped := true;
  // SELF.AppendThreshold := 80;
  SELF.GLBData := true;
  SELF.PatriotProcess := true;
  // SELF.xADLVersion := '';
  // SELF.Max_Results_Per_Acct := '';
  // SELF.IncludeRanking := '';
  SELF.did_batch_in := batch_in_recs;
  SELF := [];
END;
xml_recs := 
  dataset([xt(handpicked)])
  ;

dev_regression.layouts.testcase xtTc(svc_layout.request le) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'random subjects from header';
  // SELF.short_description := 'subjects with match on patriot file';
  SELF.request_xml := dev_regression.utils.wrapTOXML(le);
END;

testcases := PROJECT(xml_recs, xtTc(LEFT));
testcases;

// dev_regression.bucket().add(testcases);
// dev_regression.bucket().add(testcases, 'with patriot process on');
