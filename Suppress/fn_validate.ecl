import Suppress,ut,Orbit3,dops;

export fn_validate(STRING pVersion) := 
FUNCTION

a:=Suppress.Layout_New_Suppression;

QA:=dataset('~thor_data400::base::new_suppression_file',a,thor);
father:=dataset('~thor_data400::base::new_suppression_file_father',a,thor);

b:=count(QA(product <> 'ALL'));
c:=count(father(product <> 'ALL'));

boolean suppressions_chk:= count(b) = count(c);

output(count(QA(product <> 'ALL')),NAMED('QA_RECORDS_NOT_EQUAL_TO_ALL'));
output(count(father(product <> 'ALL')),NAMED('FATHER_RECORDS_NOT_EQUAL_TO_ALL'));


 // A CHECK TO DETERMINE IF CURRENT SUPPRESSION RECORDS FOR ACCURINT, CONSUMER, 
 // AND LE PRODUCTS ARE EQUAL TO THE THE PREVIOUS BUILD.
 countchk := if ( suppressions_chk, Output('No unexpected increase for Accurint, Consumer, and LE products were detected.  Moving on.'),Sequential(
 FileServices.SendEmail( 'christopher.brodeur@lexisnexisrisk.com',
													'Failed:  Suppressions build detected unexpected drop or increase in record count!',
													'TODAYS SUPPRESSIONS BUILD SHOULD NOT GO TO PROD, DUE TO UNEXPECTED CHANGE IN RECORD COUNT!'),
													 FAIL('AN UNEXPECTED CHANGE IN RECORDS HAS BEEN DETECTED.')
		));
													
					

													
QAcount:= count(QA(product = 'ALL'));
output(QAcount,NAMED('QA_RECORDS_EQUAL_TO_ALL'));

fathercount:= count(father(product = 'ALL'));
output(fathercount,NAMED('Father_RECORDS_EQUAL_TO_ALL'));

Countdiff := (QAcount) - (fathercount);
output(Countdiff,NAMED('Diff_of_QA_father'));

Pctdiff := (Countdiff/ (QAcount)) * 100;
output(Pctdiff,NAMED('Percentage'));
		
boolean all_chk2:= Pctdiff  > 10;	
boolean all_chk3:= Pctdiff  <= 0;

	
		

// A SECOND CHECK TO DETERMINE IF CURRENT SUPPRESSION RECORDS THAT HAVE
// `ALL` FOR THE PRODUCT, HAS INCREASED SINCE THE THE PREVIOUS BUILD.
  countchk2 := if ( all_chk2 or all_chk3, Sequential(FileServices.SendEmail('christopher.brodeur@lexisnexisrisk.com',
													'Failed:  Unexpected result in records with a product code of ALL',
													'TODAYS SUPPRESSIONS BUILD SHOULD NOT GO TO PROD!'),
													 FAIL('AN UNEXPECTED RESULT IN RECORDS WITH PRODUCT CODE OF `ALL` HAS BEEN DETECTED. PLEASE DO NOT DEPLOY TO PROD')),
													 Sequential(Output('Expected increase for `ALL` records detected.  Moving on.'),
		));
		
 
		

update_dops 		 := dops.updateversion('SuppressionKeys',pVersion,'christopher.brodeur@lexisnexisrisk.com',,'N|F|B',l_isprodready := 'Y');
                                                                                                          
update_dops_fcra := dops.updateversion('FCRA_SuppressionKeys',pVersion,'christopher.brodeur@lexisnexisrisk.com',,'F',l_isprodready := 'Y');

 
		               
		
Return sequential(countchk,
									countchk2,
									update_dops,
									update_dops_fcra);
		end;					