import BIPV2, doxie, data_services, vault, _control;

key5 := BIPV2.Key_BH_Linking_Ids.key;
dis5 := distribute(key5, (integer)company_sic_code1);

dsNoBlanks := dis5(company_sic_code1!='',length(company_sic_code1) = 8, company_sic_code1[1..2] IN (['70','71','72','73','74','75','76','77','78','79','80','81','82','83','84','85','86','87','88','89'])); 


sampled_ds := choosen(dsNoBlanks,100000);
//sort_Emp  := sort(sampled_ds,EmpID);
dedup_Emp := dedup(sampled_ds,EmpID);
Cnt_Emp_Distinct := count(dedup_emp);
grp := group(dedup_Emp, Seleid);
output(grp);



dsFinal := project(choosen(dsNoBlanks, 100000), transform({dsNoBlanks.company_sic_code1,dsNoBlanks.seleid,dsNoBlanks.empid,dsNoBlanks.st, string key}, self.key := 'BHKeys', self := left));
output(dsFinal,NAMED('output_ds_final1'));

/*
dsFinal2 := choosesets(dsFinal, //returning records from each state
st ='AL' =>  100,
st ='AK' =>  100,
st ='AZ' =>  100,
st ='AR' =>  100,
st ='CA' =>  100,
st ='CO' =>  100,
st ='CT' =>  100,
st ='DE' =>  100,
st ='FL' =>  100,
st ='GA' =>  100,
st ='HI' =>  100,
st ='ID' =>  100,
st ='IL' =>  100,
st ='IN' =>  100,
st ='IA' =>  100,
st ='KS' =>  100,
st ='KY' =>  100,
st ='LA' =>  100,
st ='ME' =>  100,
st ='MD' =>  100,
st ='MA' =>  100,
st ='MI' =>  100,
st ='MN' =>  100,
st ='MS' =>  100,
st ='MO' =>  100,
st ='MT' =>  100,
st ='NE' =>  100,
st ='NV' =>  100,
st ='NH' =>  100,
st ='NJ' =>  100,
st ='NM' =>  100,
st ='NY' =>  100,
st ='NC' =>  100,
st ='ND' =>  100,
st ='OH' =>  100,
st ='OK' =>  100,
st ='OR' =>  100,
st ='PA' =>  100,
st ='RI' =>  100,
st ='SC' =>  100,
st ='SD' =>  100,
st ='TN' =>  100,
st ='TX' =>  100,
st ='UT' =>  100,
st ='VT' =>  100,
st ='VA' =>  100,
st ='WA' =>  100,
st ='WV' =>  100,
st ='WI' =>  100,
st ='WY' =>  100,
0);
*/
										 




//EXPORT Firmographics := 'todo';