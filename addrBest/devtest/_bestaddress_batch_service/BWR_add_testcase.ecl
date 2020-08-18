// ----------------------------------------------------------------------------------------------
//   The code below is for reference only; you must change it to reflect the new testcase(s) being 
// added to the bucket.
// ----------------------------------------------------------------------------------------------
#WORKUNIT('name', '-- dev regression: add testcase --');

IMPORT dev_regression, addrBest;

my_query := 'addrbest.BestAddress_Batch_Service';
svc_layout := addrbest.devtest._bestaddress_batch_service.layout;

AddrBest.Layout_BestAddr.Batch_in xtBatchIn(string acctno, unsigned6 _did) := TRANSFORM
	SELF.acctno := acctno;
	SELF.did := _did;
	SELF := [];
END;

svc_layout.request wrapBatch() := TRANSFORM
	SELF.datapermissionmask := '1111111111111111111111111111111';
	SELF.datarestrictionmask := '000000000000000000000000000000';
	SELF.dppapurpose := '1';
	SELF.glbpurpose := '7';
	SELF.batch_in := 
		dataset([xtBatchIn('100', 2676)])+
		dataset([xtBatchIn('200', 150)]);
	SELF := [];
END;

dev_regression.layouts.testcase xt() := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'a quick description should go here...';
  SELF.request_xml := dev_regression.utils.wrapTOXML(ROW(wrapBatch()));
END;

testcases := DATASET([xt()]);
output(testcases, NAMED('testcases'));

dev_regression.bucket().add(testcases);
