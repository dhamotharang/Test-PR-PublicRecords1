/*--SOAP--
<message name="Ramps_Healthcare_ConsumerShell_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
  <part name="IndustryClass" type="xsd:string"/>
</message>
*/
/*--INFO-- Healthcare ConsumerShell Batch Service*/
/*--HELP--
<pre>
&lt;dataset&gt;
   &lt;row&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;AcctNo&gt;&lt;/AcctNo&gt;
      &lt;LexID&gt;&lt;/Lexid&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;unParsedFullName&gt;&lt;/unParsedFullName&gt;
      &lt;Name_First&gt;&lt;/Name_First&gt;
      &lt;Name_Middle&gt;&lt;/Name_Middle&gt;
      &lt;Name_Last&gt;&lt;/Name_Last&gt;
      &lt;Name_Suffix&gt;&lt;/Name_Suffix&gt;
      &lt;DOB&gt;&lt;/DOB&gt;
      &lt;street_addr&gt;&lt;/street_addr&gt;
      &lt;p_City_name&gt;&lt;/p_City_name&gt;
      &lt;St&gt;&lt;/St&gt;
      &lt;Z5&gt;&lt;/Z5&gt;
   &lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

import risk_indicators, Models, std, doxie, AutoStandardI,deathv2_Services;
//add death master lookup and drop records that lexid from lead integrity does not match supplied values
export ConsumerShellService := MACRO
	batchin := dataset([],RAMPS_Healthcare.Layout_ConsumerShell.Layout_ConsumerShell_Batch_In) : stored('batch_in',few);
	gateways := Gateway.Constants.void_gateway;

	gm := AutoStandardI.GlobalModule();
	unsigned1 dppa := if(gm.DPPAPurpose >0,gm.DPPAPurpose,RAMPS_Healthcare.Constants.default_DPPA);
	unsigned1 glb := if(gm.GLBPurpose > 0,gm.GLBPurpose,RAMPS_Healthcare.Constants.default_GLBA);
	string5   industry_class_val := '';
	boolean   isUtility := false;
	boolean   ofac_Only := false;
	string IndustryClass := '' : stored('IndustryClass');
	string DataRestriction := if(gm.DataRestrictionMask <> '',gm.DataRestrictionMask,RAMPS_Healthcare.Constants.default_DataRestriction);
	String DataPermission := if(gm.DataPermissionMask <> '',gm.DataPermissionMask,RAMPS_Healthcare.Constants.default_DataPermission);
	deathParams := DeathV2_Services.IParam.GetDeathRestrictions(gm);
	glb_ok := deathParams.isValidGlb();

	LeadIntegrityVersion := RAMPS_Healthcare.Constants.default_LeadIntegrity_Version;//We want version 4
	bsVersion := RAMPS_Healthcare.Constants.default_BocaShell_Version; //We want version 4.1

	batchinseq := project(batchin, RAMPS_Healthcare.Transforms_ConsumerShell.AddSeq(left,counter));
	cleanIn := project(batchinseq, RAMPS_Healthcare.Transforms_ConsumerShell.CleanBatch(left));

	// set variables for passing to bocashell function
	BOOLEAN includeDLverification := IF(LeadIntegrityVersion >= 4, TRUE, FALSE);
	boolean 	require2ele := false;
	boolean   isLn := false;	// not needed anymore
	boolean   doRelatives := true;
	boolean   doDL := false;
	boolean   doVehicle := false;
	boolean   doDerogs := true;
	boolean   suppressNearDups := false;
	boolean   fromBIID := false;
	boolean   isFCRA := false;
	boolean   fromIT1O := false;
	boolean   doScore := false;
	boolean   nugen := true;	
	BOOLEAN ofacSearching := IF(LeadIntegrityVersion >= 4, TRUE, FALSE);
	UNSIGNED1 ofacVersion := IF(LeadIntegrityVersion >= 4, 2, 1);
	BOOLEAN includeAdditionalWatchlists := IF(LeadIntegrityVersion >= 4, TRUE, FALSE);
	BOOLEAN excludeWatchlists := IF(LeadIntegrityVersion >= 4, FALSE, TRUE); // Attributes 4.1 return a watchlist hit, so don't exclude watchlists
	// For ITA we can't use FARES Data
	BOOLEAN filterOutFares := TRUE;
	append_best := if(LeadIntegrityVersion >= 4, 2, 0 );

	unsigned8 BSOptions := IF(LeadIntegrityVersion >= 4, risk_indicators.iid_constants.BSOptions.IncludeDoNotMail + 
																											risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
																											risk_indicators.iid_constants.BSOptions.IncludeDoNotMail);

/* ***************************************
	 *     Gather Boca Shell Results:      *
   *************************************** */
	iid := Risk_Indicators.InstantID_Function(cleanIn, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																						suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, ofacSearching, includeAdditionalWatchlists,
																						in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission);

	clam := Risk_Indicators.Boca_Shell_Function(iid, gateways, DPPA, GLB, isUtility, isLn, doRelatives, doDL, 
																							doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																							BSOptions := BsOptions, DataPermission := DataPermission);

	LeadIntegrity := Models.get_LeadIntegrity_Attributes(clam,LeadIntegrityVersion);

	rawResults := join(batchinseq, LeadIntegrity, left.seq=(unsigned)right.seq, transform(RAMPS_Healthcare.Layout_ConsumerShell.layout_ConsumerShell_combined,
					self.acctno := left.acctno;
					self.seq := if(right.seq <>'',right.seq,left.acctno);
					self := right; self := left;),left outer, keep(1000), atmost(1));
	flattened := project(sort(rawResults,acctno,seq), RAMPS_Healthcare.Transforms_ConsumerShell.FlattenOutput(LEFT) );
	//Do death lookup by Lexid if the user supplied lexid matches the lead integrity lexid
	recsForDeathCheck := Join(batchinseq((integer)LexID >0 ),flattened,(integer)left.acctno=(integer)right.acctno and (integer)left.Lexid = (integer)right.LexID,
															transform(left), keep(1000), limit(0));
	//Do DeathCheck
	deathRecsByDID := join(recsForDeathCheck,doxie.Key_Death_MasterV2_ssa_Did,
							keyed((unsigned6)left.lexid = right.l_did)
							and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
							transform(RAMPS_Healthcare.Layout_ConsumerShell.layout_ConsumerShell_batch_flattened,
													self.acctno:=left.acctno;
													self.death_ind:=true;
													self.DateOfDeath:=right.dod8;self:=[];),keep(1), limit(0));
	final := join(flattened,deathRecsByDID,left.acctno=right.acctno,
								transform(RAMPS_Healthcare.Layout_ConsumerShell.layout_ConsumerShell_batch_flattened,
													self.acctno:=left.acctno;
													self.death_ind:=right.death_ind;
													self.DateOfDeath:=right.DateOfDeath;
													self:=left;self:=[];),left outer, keep(1), limit(0));
	// output(batchinseq, named('batchinseq'));
	// output(clam, named('clam'));
	// output(LeadIntegrity, named('LeadIntegrity'));
	// output(rawResults, named('rawResults'));
	// output(flattened, named('flattened'));
	// output(recsForDeathCheck, named('recsForDeathCheck'));
	// output(deathRecsByDID, named('deathRecsByDID'));
	output(final, named('Results'));

ENDMACRO;
