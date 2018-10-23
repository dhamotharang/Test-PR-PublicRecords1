/*2012-05-23T13:19:13Z (aleida lima)
review only
*/
/*--SOAP--
<message name="Did_Did_Update_Service">
  <part name="OldDid" type="xsd:string" required="1"/>
  <part name="BestAppend" type="xsd:boolean" required="0"/>
  <part name="GLB" type="xsd:boolean" required="0"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="IgnoreStability" type="xsd:boolean" required="0"/>
  <part name="TrackSplit" type="xsd:boolean" required="0"/>
 </message>
*/
/*--INFO-- This service returns the current did based upon a previous did.
There are three main possibilities :-
a) The returned number is the same as the input: this DID is still valid
b) A new number is returned: this DID has merged to form a new one
c) A null (0) is returned: this data needs to be resubmitted to obtain a new valid did
*/

import AutoStandardI, doxie, ut;


export Did_Did_Update_Service := MACRO

#uniquename(od)
#uniquename(g)
#uniquename(ba)
#uniquename(ignore_stability)
#uniquename(appType)
#uniquename(TrackSplit)

string12 %od% := '0' : stored('OldDid');
boolean %g% := false : stored('GLB');
boolean %ba% := false : stored('BestAppend');
boolean %ignore_stability% := false : stored('IgnoreStability');
boolean %trackSplit% := false : stored('TrackSplit');
%appType% := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

#uniquename(splitData);
%splitData% := project(doxie.key_did_rid_split(keyed(rid=(integer8)%od%)), 
						transform({doxie.Key_Did_Rid},self.stable := true, self := left, self := []));
						
#uniquename(p)
%p% := if (%TrackSplit% and exists(%splitData%),  // if asked for split and no data found gets normal data.  
					%splitData%,
					doxie.Key_Did_Rid(Keyed(rid=(integer8)%od%)));

#uniquename(p2)
#uniquename(withbests)
%withbests% := record
	unsigned4	seq := 1;
	unsigned6   did := if (%ignore_stability% or %p%.stable or %p%.did = 0,%p%.did,(integer)%od%);
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
	didville.Layout_Best_Append;
end;
#uniquename(p1)
%p1% := table(%p%,%withbests%);

#uniquename(industryClass)
%industryClass% := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_val.params));

didville.MAC_BestAppend(%p1%,
											  'BEST_ALL',
												'',
												0,
												%g%,
												%p2%,
												false,
												doxie.DataRestriction.fixed_DRM,
												,
												,
												,
												,
												%appType%,
												,
												%industryClass%)

#uniquename(CurrentDid_dt);
%CurrentDid_dt% := if (%ba%, project(%p2%, transform({string Current_Did}, 
														self.Current_did := intformat(left.did,12,1) + ' ' +
																left.best_title + ' ' + 
																left.best_fname  + ' ' +
																left.best_mname  + ' ' +
																left.best_lname  + ' ' +
																left.best_name_suffix  + ' ' +
																left.best_addr1 + ' ' +
																left.best_city + ' ' + 
																left.best_state + ' ' + 
																left.best_zip + '-' +
																left.best_zip4 + ' date: ' +
																left.best_addr_date + ' dob: ' + 
																left.best_dob   + ' ssn: ' +	
																left.best_ssn   + ' phn: ' +
																left.best_phone + ' dod: ' + 
																left.best_dod)),
													project(%p2%, transform({string Current_Did}, 
														self.Current_did := intformat(left.did,12,1))));
				
output(if(exists(%p2%),if (%trackSplit%,%CurrentDid_dt%, choosen(%CurrentDid_dt%,1)), 
			dataset([{'0'}], {String Current_Did})),
			named('Current_Did'));

{DidVille.Layout_Best_fields, unsigned6 did} only_best(%p2% l) :=Transform
		self.did := l.did;
		self := if(%ba%,l);
	END;
	
	
outrec := if(%trackSplit%, project(%p2%, only_best(left)), project(choosen(%p2%,1),only_best(left)));
 
output(outrec,named('Results'));	

ENDMACRO;
 //Did_Did_Update_Service()