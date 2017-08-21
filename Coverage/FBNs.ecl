/* W20080206-133906
Fictitious Business Names
*/

d:=FBNV2.File_FBN_Business_Base(filing_date>10000000 and filing_date<20080301);
r:=record
tmsid:=if(d.tmsid[1..2]='FL',d.tmsid[1..2],d.tmsid[1..3]);
d.filing_date;
end;
d1:=table(d,r);
r1:=record
d1.tmsid;
maxdt:=max(group,d1.filing_date);
mindt:=min(group,d1.filing_date);
end;
output(table (d1,r1,tmsid));