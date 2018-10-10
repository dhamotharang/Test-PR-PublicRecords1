/*--SOAP--
<message name="DID_Did_Update_Batch_Service">
  <part name="did_batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="IgnoreStability" type="xsd:boolean" required="0"/>
	<part name="TrackSplit" type="xsd:boolean" required="0"/>
  </message>
*/
import AutoStandardI, doxie, ut;
export DID_Did_Update_Batch_Service() := macro

in_format := didville.layout_did_update_in;

out_format := didville.layout_did_update_out;

f := dataset([],in_format) : stored('did_batch_in',few);
boolean glb := false : stored('GLB');
boolean ba := true : stored('BestAppend');
boolean ignoreStability := false : stored('IgnoreStability');
boolean trackSplit := false : stored('TrackSplit');

appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));


out_format into_new(in_format le,doxie.key_did_rid ri) := transform
  self.cust_code := Le.cust_code;
  self.did := le.did;
  self.current_did := if (ignoreStability or ri.stable or ri.did = 0,ri.did,le.did);
  end;

out_format into_newSplit(in_format le,{unsigned6 rid, unsigned6 did} ri) := transform
  self.cust_code := Le.cust_code;
  self.did := le.did;
  self.current_did := ri.did;
  end;
	
//j := join(f,doxie.Key_Did_Rid,left.did=right.rid,into_new(left,right),left outer);
				
j1 := if (TrackSplit, 
					join(f,doxie.key_did_rid_split, left.did=right.rid, into_newSplit(left, right), left outer),
					join(f,doxie.Key_Did_Rid,left.did=right.rid,into_new(left,right),left outer));

					
j := if(TrackSplit,
					join(j1(current_did=0), doxie.Key_Did_Rid,left.did=right.rid, // gets info for the dids not found before.
							transform(out_format, self.current_did := right.did, self := left),left outer) +
					j1(current_did<>0), 
					j1);
					
					
ba_format := record
	unsigned4	seq := 0;
	string12	cust_code := j.cust_code;
	unsigned6	did := j.current_did; // swap to get best from "DID" field.
	unsigned6	current_did := j.did;
	string10	phone10 := '';
	string9		ssn := '';
	string8		dob := '';
	string20	fname := '';
	string20	mname := '';
	string20	lname := '';
	string28	prim_name := '';
	string10	prim_range := '';
	string8		sec_range := '';
	string5		z5 := '';  
	string4  zip4 := '';
	string10 best_phone := '';
	string9  best_ssn := '';
	string9  max_ssn := '';
	string5	best_title := '';
	string20 best_fname := '';
	string20 best_mname := '';
	string20 best_lname := '';
	string5  best_name_suffix := '';
	string120 best_addr1 := '';
	string30	best_city := '';
	string2		best_state := '';
	string5		best_zip := '';
	string4		best_zip4 := '';
	unsigned3 best_addr_date := 0;
	string12  best_dob := '';
	string12  best_dod := '';
	unsigned1 verify_best_phone := 255;
	unsigned1 verify_best_ssn := 255;
	unsigned1 verify_best_address := 255;
	unsigned1 verify_best_name := 255;
	unsigned1 verify_best_dob := 255;
	unsigned3 best_addr_date_first_seen := 0;
end;

j2 := table(j,ba_format);

ba_format get_Seq(j2 L, integer C) := transform
	self.seq := C;
	self := L;
end;

j2a := project(j2,get_seq(LEFT,COUNTER));

industryClass := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_val.params));

didville.MAC_BestAppend(j2a,
												'BEST_ALL',
												'',
												0,
												glb,
												j3,
												false,
												doxie.DataRestriction.fixed_DRM,
												,
												,
												,
												,
												appType,
												,
												industryClass)

// os defined in mac_bestappend
// string os(string g) := if (g = '', '', trim(g) + ' ');

out_format slim(j3 L) := transform
	self.did := L.current_did; // swap back.
	self.current_did := L.did;
	self.best_name := os(L.best_title) + os(L.best_fname) + os(L.best_mname) + os(L.best_lname) + os(L.best_name_suffix);
	self.best_addr2 := os(L.best_city) + os(L.best_state) + L.best_zip + if (L.best_zip4 != '','-' + L.best_zip4,'');
	self := L;
end;

j4 := project(j3,slim(LEFT));

outf := if (ba,j4,j);

output(outf,named('Result'))
  endmacro;
	// DID_Did_Update_Batch_Service()