import BIPV2, doxie, data_services, 
//vault,
 _control;

key5 := BIPV2.Key_BH_Linking_Ids.key;
dis5 := distribute(key5, (integer)company_sic_code1);

dsNoBlanks := dis5(company_sic_code1!='',length(company_sic_code1) = 8/*,st <> 'FL'*/, company_sic_code1[1..2] IN (['70','71','72','73','74','75','76','77','78','79','80','81','82','83','84','85','86','87','88','89'])); 


//sampled_ds := choosen(dsNoBlanks,1000);
sampled_ds := dsNoBlanks;
//sort_Emp  := sort(sampled_ds,EmpID);
dedup_Emp  := dedup(sampled_ds,EmpID);
// Cnt_Emp_Distinct := count(dedup_emp);
// grp := group(dedup_Emp, Seleid);
// output(grp);

layTab := RECORD
dedup_Emp.seleid;
cntEmp := COUNT(GROUP);
END;

empTable := TABLE(dedup_Emp,layTab,seleid); 
empTable;

/*
dsFinal := project(choosen(dsNoBlanks, 100000), transform({dsNoBlanks.company_sic_code1,dsNoBlanks.seleid,dsNoBlanks.empid,dsNoBlanks.st, string key}, self.key := 'BHKeys', self := left));



dsFinal2 := choosesets(dsFinal, //returning records from each state
st ='AL' =>  10000,
st ='AK' =>  10000,
st ='AZ' =>  10000,
st ='AR' =>  10000,
st ='CA' =>  10000,
st ='CO' =>  10000,
st ='CT' =>  10000,
st ='DE' =>  10000,
st ='FL' =>  10000,
st ='GA' =>  10000,
st ='HI' =>  10000,
st ='ID' =>  10000,
st ='IL' =>  10000,
st ='IN' =>  10000,
st ='IA' =>  10000,
st ='KS' =>  10000,
st ='KY' =>  10000,
st ='LA' =>  10000,
st ='ME' =>  10000,
st ='MD' =>  10000,
st ='MA' =>  10000,
st ='MI' =>  10000,
st ='MN' =>  10000,
st ='MS' =>  10000,
st ='MO' =>  10000,
st ='MT' =>  10000,
st ='NE' =>  10000,
st ='NV' =>  10000,
st ='NH' =>  10000,
st ='NJ' =>  10000,
st ='NM' =>  10000,
st ='NY' =>  10000,
st ='NC' =>  10000,
st ='ND' =>  10000,
st ='OH' =>  10000,
st ='OK' =>  10000,
st ='OR' =>  10000,
st ='PA' =>  10000,
st ='RI' =>  10000,
st ='SC' =>  10000,
st ='SD' =>  10000,
st ='TN' =>  10000,
st ='TX' =>  10000,
st ='UT' =>  10000,
st ='VT' =>  10000,
st ='VA' =>  10000,
st ='WA' =>  10000,
st ='WV' =>  10000,
st ='WI' =>  10000,
st ='WY' =>  10000,
0);
											 
output(dsFinal2);


*/
//EXPORT Firmographics := 'todo';