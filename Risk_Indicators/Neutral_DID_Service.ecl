/*--SOAP--
	<message name = 'Neutral DID Service'>
		<part name = 'batch_in'			type = 'tns:XmlDataSet' cols="70" rows="10"/>
		<part name = 'BSversion'		type = 'xsd:integer'/>
		<part name = 'append_best'	type = 'xsd:integer'/>
		<part name = 'RetainInputDID'	type = 'xsd:boolean'/>
		<part name = 'DataRestrictionMask'	type = 'xsd:string'/>
	</message>
*/
/*--INFO-- The FCRA-Neutral part that appends the DID */ 
/*--HELP-- 
<pre>
&lt;Batch_In&gt;
  &lt;Row&gt;
    	&lt;Seq&gt;&lt;/Seq&gt;
    	&lt;SSN&gt;&lt;/SSN&gt;
    	&lt;fname&gt;&lt;/fname&gt;
    	&lt;mname&gt;&lt;/mname&gt;
    	&lt;lname&gt;&lt;/lname&gt;
    	&lt;suffix&gt;&lt;/suffix&gt;
    	&lt;DOB&gt;&lt;/DOB&gt;
    	&lt;in_Street_Address&gt;&lt;/in_Street_Address&gt;
			&lt;in_city&gt;&lt;/in_city&gt;
			&lt;in_state&gt;&lt;/in_state&gt;
			&lt;in_zipcode&gt;&lt;/in_zipcode&gt;
    	&lt;Prim_Range&gt;&lt;/Prim_Range&gt;
    	&lt;Predir&gt;&lt;/Predir&gt;
    	&lt;Prim_Name&gt;&lt;/Prim_Name&gt;
    	&lt;addr_Suffix&gt;&lt;/addr_Suffix&gt;
    	&lt;Postdir&gt;&lt;/Postdir&gt;
    	&lt;Unit_Desig&gt;&lt;/Unit_Desig&gt;
    	&lt;Sec_Range&gt;&lt;/Sec_Range&gt;
    	&lt;P_City_Name&gt;&lt;/P_City_Name&gt;
    	&lt;St&gt;&lt;/St&gt;
    	&lt;Z5&gt;&lt;/Z5&gt;
    	&lt;Age&gt;&lt;/Age&gt;
    	&lt;DL_Number&gt;&lt;/DL_Number&gt;
    	&lt;DL_State&gt;&lt;/DL_State&gt;
    	&lt;phone10&gt;&lt;/phone10&gt;
    	&lt;wphone10&gt;&lt;/wphone10&gt;
  &lt;/Row&gt;
&lt;/Batch_In&gt;
</pre>
*/


IMPORT risk_indicators, didville, doxie;

EXPORT Neutral_DID_Service() := MACRO

	// Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
	
	indata := dataset([],risk_indicators.Layout_Input) : stored('batch_in',few);
	unsigned1 BSversion := 1 		: stored('BSversion');		
	unsigned1 append_best := 0	: stored('append_best');
	boolean RetainInputDID := false	: stored('RetainInputDID');
	string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	
	fz := '4GZ';
	dedup_these := if(BSversion > 2, false, true);	// allow multiple DID's for bsVersion > 2
	allscores := false;
	glb := 1;	// hardcoding this to 1 because it will always be called from FCRA and FCRA is assumed to see everything

	// for 5.0, Brad wants us to do the did searching on all records, not just the 0 DID records
	didprep_pre50 := PROJECT(indata(did=0), TRANSFORM(didville.Layout_Did_OutBatch, SELF := LEFT));
	didprep_50 := PROJECT(indata, TRANSFORM(didville.Layout_Did_OutBatch, self.did := 0, self.score := 0, SELF := LEFT));  // setting the DID to 0, even if customer provided it on input
	didprep := if(bsversion>=50 and not RetainInputDID, didprep_50, didprep_pre50);

	didville.MAC_DidAppend(didprep,resu,dedup_these,fz,allscores) 

	// if the input has the DID already, don't send that input record through the didappend again
	already_has_did := PROJECT(indata(did<>0), TRANSFORM(didville.Layout_Did_OutBatch, SELF := LEFT));
	all_dids1_pre50 := ungroup(resu + already_has_did);
	
	// for 5.0, if the DID append doesn't find a DID, use the DID provided by the customer
	all_dids1_50 := ungroup(
		join(resu, already_has_did, left.seq=right.seq, 
			transform(didville.Layout_Did_OutBatch, 
				self.did := if(right.did<>0 and left.did=0, right.did, left.did), 
				self.score := if(right.did<>0 and left.did=0, right.score, left.score), 
				self := left), left outer, keep(1) ) );
				
	all_dids1 := if(bsversion>=50 and not RetainInputDID, all_dids1_50, all_dids1_pre50);

	
	// get a count of the DID's found if bsVersion>2
	did_slim := RECORD
		all_dids1.seq;
		did_ct := count(group);
	END;
	d_did := TABLE(all_dids1(did<>0), did_slim, seq, few);

	
	// add code to keep only 3 DID's if multiple are found
	all_dids := if(BSversion>2, dedup(sort(all_dids1, seq), seq, keep(3)), all_dids1);
	// make sure the DIDs are unique so that a batch of records with the same person doesn't cause memory limit error later
	unique_dids := dedup(sort(project(all_dids,transform(doxie.layout_references,self:=left)), did), did);
	
	// get best ssn from same function we use in the collection shell
	bestSSN := risk_indicators.collection_shell_mod.getBestCleaned(unique_dids, 
																																	DataRestriction, 
																																	glb,
																																	clean_address:=false); // don't need clean address, just the best SSN
	
	bestSSNappended := join(all_dids, bestSSN, left.did<>0 and left.did=right.did,
												TRANSFORM(Risk_Indicators.Layouts.Layout_Neutral_DID_Service, 
																	SELF.best_ssn := right.ssn, 
																	SELF.did_ct := 0,
																	SELF := left), left outer, keep(1));
																										
	withBestSSN := if(append_best=0, project(all_dids, transform(Risk_Indicators.Layouts.Layout_Neutral_DID_Service, self.did_ct:=0, self := left)),	bestSSNappended);
	
	
	Risk_Indicators.Layouts.Layout_Neutral_DID_Service addDidCount(withBestSSN le, d_did ri) := transform
		self.did_ct := ri.did_ct;
		self := le;
	END;
	withBestSSNDidCount := join(withBestSSN, d_did, left.seq=right.seq, addDidCount(left,right), left outer, lookup);
	
	wDidCount := if(BSversion>2, withBestSSNDidCount, withBestSSN);
	
	output(wDidCount, NAMED('Results'));
	
ENDMACRO;