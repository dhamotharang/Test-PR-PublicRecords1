import doxie,ut;

// doxie.show_troyservice was hacked for fname='JEROME',etc.

set of string5 Zip1 := [
'87106',
'87108',
'87110',
'87123'] : stored('Zip1');

set of string5 Zip2 := [
'78571'] : stored('Zip2');

set of string5 Zip3 := [
'79401',
'79402',
'79403',
'79404',
'79405',
'79406',
'79407',
'79408',
'79409',
'79410',
'79411',
'79412',
'79413',
'79414',
'79415',
'79416',
'79423',
'79424',
'79430',
'79452',
'79453',
'79457',
'79464',
'79490',
'79491',
'79493',
'79499'] : stored('Zip3');

unsigned Radius1 := 1 : stored('Radius1');
unsigned Radius2 := 1 : stored('Radius2');
unsigned Radius3 := 1 : stored('Radius3');

unsigned1 StCode1 := ut.St2Code(ziplib.ZipToState2('87106'));
unsigned1 StCode2 := ut.St2Code(ziplib.ZipToState2('78571'));
unsigned1 StCode3 := ut.St2Code(ziplib.ZipToState2('79401'));

unsigned4 z1l := 190001 : stored('Zip1LowYYYYMM');
unsigned4 z1h := 201012 : stored('Zip1HighYYYYMM');
unsigned4 z2l := 190001 : stored('Zip2LowYYYYMM');
unsigned4 z2h := 201012 : stored('Zip2HighYYYYMM');
unsigned4 z3l := 190001 : stored('Zip3LowYYYYMM');
unsigned4 z3h := 201012 : stored('Zip3HighYYYYMM');

unsigned1 AgeHigh := 110 : stored('AgeHigh');
unsigned1 AgeLow := 1 : stored('AgeLow');

doxie.Start_TroySearch(zip1,z1l,z1h,Radius1,ofile)
i1 := output( count(ofile), named('From_Zip1') );

doxie.And_TroySearch(ofile,zip2,z2l,z2h,Radius2,ofile1)

i2 := output( count(ofile1), named('From_Zip2') );

doxie.And_TroySearch(ofile1,zip3,z3l,z3h,Radius3,ofile2)

i3 := output( count(ofile2), named('From_Zip3') );

Cands := map ( Zip2 = '' => ofile,
	        Zip3 = '' => ofile1 ,
	        ofile2 );	

C_Rec := record
  Cands;
  unsigned1 Crim_Records;
  end;
  
C_Rec take_lu(cands le, doxie.Key_Did_Lookups ri) := transform
  self.crim_records := ri.crim_cnt+ri.sex_cnt;
  self := le;
  end;  
		   
Res := join(Cands,doxie.key_did_lookups,left.did=right.did,take_lu(left,right),left outer);		   

doxie.Show_TroySearch(Res,[])		   
