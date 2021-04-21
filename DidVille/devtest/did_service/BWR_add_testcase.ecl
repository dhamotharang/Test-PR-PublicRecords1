// ----------------------------------------------------------------------------------------------
//   The code below is for reference only; you must change it to reflect the new testcase(s) being 
// added to the bucket.
// ----------------------------------------------------------------------------------------------
#WORKUNIT('name', '-- dev regression: add testcase --');

IMPORT dev_regression, didville, gateway, patriot, STD;

my_query := 'didville.did_service';
svc_layout := didville.devtest.did_service.layout;

svc_layout.request xt(string fname, string lname, string ssn, string addr1, string city, string st, string zip) := TRANSFORM
  SELF.glbdata := true;
  SELF.AllPossibles := TRUE;
  SELF.appends := 'BEST_ALL';
  SELF.verify := 'BEST_ALL';
  SELF.PatriotProcess := 1;

  SELF.FirstName := fname;
  SELF.LastName := lname;
  SELF.ssn := ssn;
  SELF.addr1 := addr1;
  SELF.city := city;
  SELF.state := st;
  SELF.zip := zip;
  SELF := [];
END;
xml_recs := 
  dataset([xt('fname', 'lname', 'ssn', 'addr1', 'city', 'st', 'zip')])
  ;
  

dev_regression.layouts.testcase xtTc(svc_layout.request le) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := ''; // <-- please update according with testcase you are creating.
  SELF.request_xml := dev_regression.utils.wrapTOXML(le);
END;

testcases := PROJECT(xml_recs, xtTc(LEFT));
testcases;

// dev_regression.bucket().add(testcases);
