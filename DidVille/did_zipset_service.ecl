/*--SOAP--
<message name="Did_ZipSet_Service">
  <part name="seq" type="xsd:unsignedInt"/>
  <part name="FirstName" type="xsd:string" required="1"/>
  <part name="LastName" type="xsd:string" required="1"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="NameSuffix" type="xsd:string"/>
  <part name="ZipSet" type="tns:EspStringArray" required="1"/>
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
  <part name="GLB" type="xsd:boolean" />
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
 </message>
*/
/*--INFO-- This service returns a did based upon a name and zip*/

export did_zipset_service() := macro

import doxie, dx_header, ut, didville, NID, AutoStandardI;

set of string5 in_Set := [] : stored('ZipSet');
unsigned seq_value := 0 : stored('seq');
string20	fnam     := '' : stored('FirstName');
string20	lnam     := '' : stored('LastName');
string20	mnam     := '' : stored('MiddleName');
string5	nsuf     := '' : stored('NameSuffix');
unsigned2	maxcnt   := 1  : stored('MaxDidCount');
boolean	nicks    := false : stored('AllowNickNames');
boolean 	phonetic := false : stored('PhoneticMatch');
boolean 	glb      := false : stored('GLB');
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

SET OF UNSIGNED3 inSet := SET(DATASET(in_Set, {STRING5 zip}), (unsigned3)zip);

df := dataset(inSet, {TYPEOF(inSet[1]) zip});
///inSetRev := set(df, Stringlib.StringReverse(zip));

	
	string20	fname_in := StringLib.StringToUpperCase(fnam);
	string20	lname_in := StringLib.StringToUpperCase(lnam);
	string20	plname_in := metaphonelib.dmetaphone1(stringlib.stringtouppercase(lnam));
	string20	mname_in := Stringlib.StringToUpperCase(mnam);
	string1	mi_in := StringLib.StringToUpperCase(((String)mnam)[1]);
	string5	nsuffix := StringLib.StringToUpperCase(nsuf);


//df2 := dedup(table(df,qrec),all);

dk := dx_header.key_zip_did_full();

dk ftch(dk R) := transform
	self.cnt := R.cnt; //if (R.cnt > maxcnt, ERROR(201, 'Too Many DID In Specified ZipCode(s)'), R.cnt);
	self := R;
end;

unsigned limitvalue := maxcnt * 10;

fetched_nicks_and_phonetic := project(LIMIT(dk(keyed(zip IN inSet) and 
						  keyed(plname_in = p_lname) and
 						  keyed(NID.mod_PFirstTools.RinPFL(fname_in,p_fname)) and
							WILD(lname) and
							WILD(fname) and
						  (ut.nneq(mname_in, mname) or ut.nneq(mi_in, mi)) and
							ut.nneq(nsuffix, name_suffix)),limitvalue ,FAIL(201,'Too Many DID In Specified ZipCode(s)'),KEYED),
						  ftch(LEFT));

fetched_nicks := project(LIMIT(dk(keyed(zip IN inSet) and 
						  keyed(plname_in = p_lname) and
						  keyed(NID.mod_PFirstTools.RinPFL(fname_in,p_fname)) and
						  keyed(lname_in = lname) and
							WILD(fname) and
						  (ut.nneq(mname_in, mname) or ut.nneq(mi_in, mi)) and
							ut.nneq(nsuffix, name_suffix)),limitvalue ,FAIL(201,'Too Many DID In Specified ZipCode(s)'),KEYED),
						  ftch(LEFT));
						
fetched_phonetic := project(LIMIT(dk(keyed(zip IN inSet) and 
						  keyed(plname_in = p_lname) and
						  keyed(NID.mod_PFirstTools.RinPFL(fname_in,p_fname)) and
						  WILD(lname) and
							WILD(fname) and
						  (fname_in = fname[1..length(trim(fname_in))]) and
						  (ut.nneq(mname_in, mname) or ut.nneq(mi_in, mi)) and
							ut.nneq(nsuffix, name_suffix)),limitvalue ,FAIL(201,'Too Many DID In Specified ZipCode(s)'),KEYED),
						  ftch(LEFT));
						  
fetched_simple := project(LIMIT(dk(keyed(zip IN inSet) and 
							keyed(plname_in = p_lname) and
						  keyed(NID.mod_PFirstTools.RinPFL(fname_in,p_fname)) and
						  keyed(lname_in = lname) and
						  keyed(fname_in = fname[1..length(trim(fname_in))]) and
						  (ut.nneq(mname_in, mname) or ut.nneq(mi_in, mi)) and
							ut.nneq(nsuffix, name_suffix)),limitvalue ,FAIL(201,'Too Many DID In Specified ZipCode(s)'),KEYED),
						  ftch(LEFT));						

fetched := map(nicks and phonetic => fetched_nicks_and_phonetic,
               nicks => fetched_nicks,
               phonetic => fetched_phonetic,
							 fetched_simple) : global;

frec := record
	string20	fname;
	string20	lname;
	string20	mname;
	string1	mi;
	string5	name_suffix;
	unsigned3	zip;
	unsigned6	did;
end;

frec normIt(fetched L, integer C) := transform
	self.did := if (C = 1, L.l_did,L.b_did);
	self := L;
end;


f3 := normalize(fetched,2,normIt(LEFT,COUNTER));

fetchddp := dedup(sort(f3,did),did) : global;

temprec := record
	fetchddp;
	string8	dob := '';
	string9	ssn := '';
	string10	phone10 := '';
	string1	prim_range := '';
	string1	predir := '';
	string1	prim_name := '';
	string1	postdir := '';
	string1	addr_suffix := '';
	string1	unit_desig := '';
	string1	sec_range := '';
	string1	p_city_name := '';
	string1	st := '';
	string1	z5 := '';
	string1	zip4 := '';
	string1	title := '';
	unsigned4	seq;
	didville.Layout_Best_Append;
end;

temprec into(fetchddp L,integer C) := transform
	self := L;
	self.seq := C;
end;

res2 := if (count(fetchddp) > maxcnt, FAIL(temprec, 202, 'Number of Results Exceeds Specified Maximum'),
		  project(fetchddp,into(LEFT,COUNTER)));

industryClass := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_val.params));

didville.MAC_BestAppend(res2,
											  'BEST_ALL',
												'',
												255,
												glb,
												outf1,
												false,
												doxie.DataRestriction.fixed_DRM,
												,
												,
												,
												,
												appType,
												,
												industryClass);

didville.layout_zipset_out into_out(outf1 L) := transform
	self.seq := seq_value;
	self.zip := if ((unsigned3)L.best_zip in inset,(STRING5)L.best_zip,(STRING5)L.zip);
	self := L;
end;
				
outf2 := project(outf1,into_out(LEFT));

MAP(	maxcnt > 2 		   	=> FAIL(101, 'This Service Returns a Maximum of 2 Records'),
	fnam = '' or lnam = ''	=> FAIL(301,'You Must Supply Both a First and Last Name'),
	inSet = []			=> FAIL(302,'You Must Supply at Least One ZipCode'),
	output(outf2,named('Result')));

endmacro;
// did_zipset_service()
