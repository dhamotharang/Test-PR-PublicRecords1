/*--SOAP--
<message name="TroyService">
  <part name="Zip1" type="xsd:string" required="1"/>
  <part name="Zip1LowYYYYMM" type="xsd:unsignedInt"/>
  <part name="Zip1HighYYYYMM" type="xsd:unsignedInt"/>
  <part name="Zip2" type="xsd:string"/>
  <part name="Zip2LowYYYYMM" type="xsd:unsignedInt"/>
  <part name="Zip2HighYYYYMM" type="xsd:unsignedInt"/>
  <part name="Zip3" type="xsd:string"/>
  <part name="Zip3LowYYYYMM" type="xsd:unsignedInt"/>
  <part name="Zip3HighYYYYMM" type="xsd:unsignedInt"/>
  <part name="AgeLow" type="xsd:byte"/>
  <part name="AgeHigh" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="Radius" type="xsd:unsignedInt"/>
  <part name="Gender" type="xsd:string"/>
 </message>
*/
/*--INFO-- This service finds people living in a set of locations.*/


export Troy_Service := macro

string5 Zip1 := '' : stored('Zip1');
string5 Zip2 := '' : stored('Zip2');
string5 Zip3 := '' : stored('Zip3');
unsigned1 StCode1 := ut.St2Code(ziplib.ZipToState2(Zip1));
unsigned1 StCode2 := ut.St2Code(ziplib.ZipToState2(Zip2));
unsigned1 StCode3 := ut.St2Code(ziplib.ZipToState2(Zip3));
unsigned4 z1l := 0 : stored('Zip1LowYYYYMM');
unsigned4 z1h := 201412 : stored('Zip1HighYYYYMM');
unsigned4 z2l := 0 : stored('Zip2LowYYYYMM');
unsigned4 z2h := 201412 : stored('Zip2HighYYYYMM');
unsigned4 z3l := 0 : stored('Zip3LowYYYYMM');
unsigned4 z3h := 201412 : stored('Zip3HighYYYYMM');
unsigned1 AgeHigh := 100 : stored('AgeHigh');
unsigned1 AgeLow := 0 : stored('AgeLow');
unsigned1 Radius := 10: stored('Radius');
STRING1 pGender := 'M': STORED('Gender');
UNSIGNED1 DemoMode := 0 : STORED('DemoMode');

doxie.Start_TroySearch(zip1,z1l,z1h,ofile)
i1 := output( count(ofile), named('From_Zip1') );

doxie.And_TroySearch(ofile,zip2,z2l,z2h,ofile1)

i2 := output( count(ofile1), named('From_Zip2') );

doxie.And_TroySearch(ofile1,zip3,z3l,z3h,ofile2)

i3 := output( count(ofile2), named('From_Zip3') );

Cands := map ( Zip2 = '' => ofile,
	        Zip3 = '' => ofile1 ,
	        ofile2 );
		   
C_Rec := record
  Cands;
  unsigned1 Crim_Records;
  end;

key_lookups  := dx_header.key_did_Lookups();
C_Rec take_lu(cands le, key_lookups ri) := transform
  self.crim_records := ri.crim_cnt+ri.sex_cnt;
  self := le;
  end;  
		   
Res := join(Cands,key_lookups,left.did=right.did,take_lu(left,right),left outer);		   
doxie.MAC_Header_Field_Declare();
doxie.Show_TroySearch(Res,[],,suppressDMVInfo_value,DemoMode=1,pGender);
	 
/*map ( Zip1 = '' => FAIL('Nothing specified'),
      Zip2 = '' => sequential( i1, output(choosen(ofile,1000)) ),
	 Zip3 = '' => sequential( i1, i2, output(choosen(ofile1,1000)) ),
	 sequential( i1,i2,i3,output(choosen(ofile2,1000)) ) )*/

  endmacro;
  