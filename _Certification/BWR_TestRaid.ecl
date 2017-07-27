ds := _Certification.DataFile;

count(ds(fname[1]='A'));
count(ds(fname[1]='C'));

count(ds(lname[1]='A'));
count(ds(lname[1]='C'));

count(ds(prange in [1,3,5]));
count(ds(prange in [1,4,7]));
