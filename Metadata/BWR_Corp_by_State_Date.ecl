//Corp by State Date by John J. Bulten 20070530 W20070628-115815, W20070815-121326, W20070918-135605

d1 := 15010101;
d2 := 20070815;

dData := Corp2.Files('').base.corp.qa;

rData := record
  dData.corp_state_origin;
  if((integer)dData.corp_filing_date between d1 and d2,dData.corp_filing_date[1..4],dData.corp_inc_date[1..4]);
  min(group,if((integer)dData.corp_filing_date BETWEEN d1 AND d2,dData.corp_filing_date,
               if(dData.corp_filing_date='' AND (integer)dData.corp_inc_date BETWEEN d1 AND d2,
			      dData.corp_inc_date,'20070815')));
  max(group,if((integer)dData.corp_filing_date BETWEEN d1 AND d2,dData.corp_filing_date,
               if(dData.corp_filing_date='' AND (integer)dData.corp_inc_date BETWEEN d1 AND d2,
			      dData.corp_inc_date,'00010101')));
  count(group);
end;

output(choosen(table(dData,rData,corp_state_origin,
  if((integer)dData.corp_filing_date between d1 and d2,dData.corp_filing_date[1..4],dData.corp_inc_date[1..4])),20000));
output(table(dData,{corp_state_origin,count(group),min(group,dData.corp_process_date)},corp_state_origin));
output(table(dData,{corp_state_origin,count(group),max(group,dData.corp_process_date)},corp_state_origin));