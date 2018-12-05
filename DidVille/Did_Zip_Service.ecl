/*--SOAP--
<message name="Did_Zip_Service">
  <part name="FirstName" type="xsd:string" required="1"/>
  <part name="LastName" type="xsd:string" required="1"/>
  <part name="Zip" type="xsd:string" required="1"/>
  <part name="InnerRadius" type="xsd:string"/>
  <part name="OuterRadius" type="xsd:string"/>
  <part name="MaxDidCount" type="xsd:unsignedInt">
    <html>
	  <td width="25%"><font face="Verdana" size="2">MaxDidCount:</font></td>
	  <td><font face="Verdana" size="2">
	    <select name="MaxDidCount">
		 <Option value="1">1</Option>
		 <Option value="2">2</Option>
	    </select>
	  </font></td>
    </html>
  </part>
  <part name="Seq" type="xsd:unsignedInt"/>
  <part name="AppendBests" type = "xsd:boolean"/>
 </message>
*/
/*--INFO-- This service returns a did based upon a name and zip*/

export Did_Zip_Service := MACRO

import dx_BestRecords;

string30 fname_val := '' : stored('FirstName');
string30 lname_val := '' : stored('LastName');
string5 zip_value := '' : stored('Zip');
//string120 name_value := '' : stored('Name');
string4 inner_radius_i := '' : stored('InnerRadius');
string4 outer_radius_i := '' : stored('OuterRadius');
unsigned1	maxdids := 1 : stored('MaxDidCount');
boolean best_appended := false : stored('AppendBests');
unsigned4	seq := 1 : stored('Seq');

inner_radius := IF((unsigned4)inner_radius_i=0,5,(unsigned4)inner_radius_i);
outer_radius := IF((unsigned4)outer_radius_i=0,50,(unsigned4)outer_radius_i);
fnam := Stringlib.stringtoUpperCase(fname_val);
lnam := stringlib.stringtouppercase(lname_val);

dk := doxie.key_zip_did;

myrec := record
  unsigned6 did1;
  unsigned6 did2;
  dk.fname;
  dk.lname;
  dk.cnt;
  dk.dt_last_seen;
  real distance;
  boolean in_radius;
  unsigned1 confidence := 0;
  real tir;
  unsigned2	numrecs := 0;
end;

myrec calc_vals(dk L) := transform
  self.distance := ut.zip_dist((string5)zip_value,(string5)L.zip);
  self.did1 := L.l_did;
  self.did2 := L.b_did;
  self.in_radius := self.distance<inner_radius;
  self.tir := didville.history_scale(L.dt_last_seen)*
              (IF (self.in_radius,
                     70*(inner_radius-self.distance)/inner_radius,
                     0)+
               if(self.distance<outer_radius,
                     30*(outer_radius-self.distance)/outer_radius,
                     0)
               );
  self := L;
end;

fetched1 := dk(fname = fnam,lname = lnam, ut.zip_Dist((string5)zip_value,(string5)zip)<=outer_radius);
fetched2 := if (lnam != '' and fnam != '',dk(fnam = fname[1], lnam = lname,ut.zip_Dist((string5)zip_value,(string5)zip)<=outer_radius),
			dk(false));

fetched := fetched1 + fetched2;

fset := project(fetched,calc_vals(LEFT));

myrec2 := record
  unsigned6 did;
  dk.fname;
  dk.lname;
  dk.cnt;
  dk.dt_last_seen;
  real distance;
  boolean in_radius;
  unsigned1 confidence := 0;
  real tir;
  unsigned2	numrecs := 0;
end;

myrec2 normIt(myrec L, integer C) := transform
	self.did := if (c = 1, l.did1, l.did2);
	self := L;
end;

fset2 := normalize(fset,2,normIt(LEFT,COUNTER));

res1 := dedup(sort(fset2,did,distance),did);

myrec2 sumtir(myrec2 le, myrec2 ri) := transform
self.tir := le.tir + ri.tir;
self.confidence := ri.tir;
self.numrecs := Le.numrecs + 1;
self := ri;
end;

i1 := iterate(res1, sumtir(LEFT,RIGHT));

myrec2 s_conf(myrec2 le, myrec2 ri) := transform
  self.tir := IF(le.tir = 0, ri.tir, le.tir);
  self.confidence := ( 95 * ri.confidence ) / self.tir;
  self := ri;
  end;


res2 := iterate(sort(i1(in_radius), -tir),s_conf(left, right));

didville.Layout_DID_Zip_Out slim(myrec2 L) := transform
	self.seq := seq;
	self := L;
end;

pre_out := project(res2,slim(LEFT));

os(string i) := if (i='','',trim(i)+' ');
pre_out add_flds(pre_out le, dx_BestRecords.layout_best ri) := transform
  self.best_phone :=  ri.phone;
  self.best_ssn :=  ri.ssn;
  self.best_name :=  os(ri.title)+os(ri.fname)+os(ri.mname)+os(ri.lname)+os(ri.NAME_suffix);
  self.best_addr1 := os(ri.prim_range)+os(ri.predir)+os(ri.prim_name)+os(ri.suffix)+os(ri.postdir)+os(ri.unit_desig)+os(ri.sec_range);
  self.best_city := ri.city_name;
  self.best_state := ri.st;
  self.best_zip := ri.zip;
  self.best_zip4 := ri.zip4;
  self.best_dob := (string8)ri.dob;
  self.best_dod := (string8)ri.dod;
  self := le;
end;

brap := dx_BestRecords.append(pre_out, did, dx_BestRecords.Constants.perm_type.nonglb);
jt := project(brap, add_flds(left, left._best));
sjt := sort(jt,-confidence);

outf := if(best_appended,sjt,pre_out);

map( fname_val = '' or lname_val = '' => FAIL(101,'You Must Supply a First and Last Name'),
     zip_value = '' => FAIL(102,'You Must Supply a ZipCode'),
	maxdids > 2 => FAIL(201,'You May Not Specify More Than 2 Returnable DIDs'),
	max(res1,cnt) > maxdids => FAIL(202,'Too Many Dids in Specified ZipCode'),
	count(outf)   > maxdids => FAIL(203,'Too Many Results to Return a Match'),
	output(outf));

endmacro;