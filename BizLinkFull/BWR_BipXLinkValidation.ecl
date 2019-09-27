IMPORT wk_ut;
IMPORT WsDFU;
IMPORT MDR;

// JA 20190718: LinkingTools.modXLinkValidation modified per JIRA epic LBP-173 //
// Sandbox BizLinkFull.Filename_keys.superkey_version to appropriate (built) version before running //

  IMPORT Std.Str AS Str;
  IMPORT Std.File AS File;
  IMPORT Std.Date AS Date;
	
			// pare down the fields in File_BizHead that are relevant to external linking 
		lSlim:=RECORD
			BizLinkFull.File_BizHead.rcid;
			BizLinkFull.File_BizHead.proxid;
			BizLinkFull.File_BizHead.seleid;
			// BizLinkFull.File_BizHead.orgid;
			// BizLinkFull.File_BizHead.ultid;
			// BizLinkFull.File_BizHead.empid;
			// BizLinkFull.File_BizHead.powid;
			// BizLinkFull.File_BizHead.dotid;
			// BizLinkFull.File_BizHead.parent_proxid;
			// BizLinkFull.File_BizHead.sele_proxid;
			// BizLinkFull.File_BizHead.org_proxid;
			// BizLinkFull.File_BizHead.ultimate_proxid;
			// BizLinkFull.File_BizHead.has_lgid;
			BizLinkFull.File_BizHead.company_name;
			// BizLinkFull.File_BizHead.title;
			BizLinkFull.File_BizHead.fname;
			BizLinkFull.File_BizHead.mname;
			BizLinkFull.File_BizHead.lname;
			// BizLinkFull.File_BizHead.name_suffix;
			// BizLinkFull.File_BizHead.iscontact;
			BizLinkFull.File_BizHead.contact_ssn;
			BizLinkFull.File_BizHead.contact_email;
			BizLinkFull.File_BizHead.prim_range;
			// BizLinkFull.File_BizHead.predir;
			BizLinkFull.File_BizHead.prim_name;
			// BizLinkFull.File_BizHead.addr_suffix;
			// BizLinkFull.File_BizHead.postdir;
			// BizLinkFull.File_BizHead.unit_desig;
			BizLinkFull.File_BizHead.sec_range;
			// BizLinkFull.File_BizHead.p_city_name;
			// BizLinkFull.File_BizHead.v_city_name;
			BizLinkFull.File_BizHead.st;
			BizLinkFull.File_BizHead.zip;
			// BizLinkFull.File_BizHead.zip4;
			// BizLinkFull.File_BizHead.fips_county;
			BizLinkFull.File_BizHead.source;
			// BizLinkFull.File_BizHead.dt_first_seen;
			// BizLinkFull.File_BizHead.dt_last_seen;
			// BizLinkFull.File_BizHead.dt_vendor_last_reported;
			// BizLinkFull.File_BizHead.company_bdid;
			BizLinkFull.File_BizHead.company_fein;
			// BizLinkFull.File_BizHead.active_duns_number;
			BizLinkFull.File_BizHead.company_phone;
			// BizLinkFull.File_BizHead.phone_type;
			BizLinkFull.File_BizHead.company_url;
			BizLinkFull.File_BizHead.company_sic_code1;
			// BizLinkFull.File_BizHead.company_status_derived;
			// BizLinkFull.File_BizHead.vl_id;
			// BizLinkFull.File_BizHead.source_record_id;
			// BizLinkFull.File_BizHead.source_docid;
			BizLinkFull.File_BizHead.contact_did;
			// BizLinkFull.File_BizHead.contact_email_domain;
			// BizLinkFull.File_BizHead.contact_job_title_derived;
			// BizLinkFull.File_BizHead.address_type_derived;
			// BizLinkFull.File_BizHead.err_stat;
			// BizLinkFull.File_BizHead.is_sele_level;
			// BizLinkFull.File_BizHead.is_org_level;
			// BizLinkFull.File_BizHead.is_ult_level;
			BizLinkFull.File_BizHead.cnp_name;
			BizLinkFull.File_BizHead.cnp_number;
			BizLinkFull.File_BizHead.cnp_store_number;
			BizLinkFull.File_BizHead.cnp_btype;
			// BizLinkFull.File_BizHead.cnp_component_code;
			BizLinkFull.File_BizHead.cnp_lowv;
			// BizLinkFull.File_BizHead.cnp_translated;
			// BizLinkFull.File_BizHead.cnp_classid;
			BizLinkFull.File_BizHead.company_name_prefix;
			BizLinkFull.File_BizHead.city;
			// BizLinkFull.File_BizHead.city_clean;
			BizLinkFull.File_BizHead.company_phone_3;
			BizLinkFull.File_BizHead.company_phone_3_ex;
			BizLinkFull.File_BizHead.company_phone_7;
			BizLinkFull.File_BizHead.fname_preferred;
			BizLinkFull.File_BizHead.sele_flag;
			BizLinkFull.File_BizHead.org_flag;
			BizLinkFull.File_BizHead.ult_flag;
			// BizLinkFull.File_BizHead.fallback_value;
			DATASET(BizLinkFull.Process_Biz_Layouts.Layout_zip_cases) zip_cases;
		END;	

  //----------------------  FILE COMPARISON CODE ----------------------------

  // Simple presentation formatters
  STRING16 fToComma(INTEGER i):=IF(i<0,'-',' ')+REGEXREPLACE('( ,|,$)',REGEXREPLACE('([ 0-9]{3})',Str.Repeat(' ',12-LENGTH((STRING)ABS(i)))+(STRING)ABS(i),'$1,'),'  ');
  INTEGER fToInteger(STRING s):=(INTEGER)REGEXREPLACE('[^-0-9]',s,'');
		STRING11 fDecimalFormat(DECIMAL n) := function 
		times_100 := (string)(n*100);
		dec_start := str.find(times_100, '.', 1);
		ret_val := if(dec_start > 0, (times_100 + '0000')[1..dec_start+4] + '%', times_100 + '.0000%');
		return ret_val;
	end;
  
  //--------------  APPEND RESULTS COMPARISON CODE ------------------------
  
  STRING sSuperfileName:='~thor::xlink_validation::combined::bizlinkfull';
  
  //-----------------------------------------------------------------------
  // d  : If specified, a dataset input.  If left blank the most recent base
  //      file from that header is used
  // v  : YYYYMMDD version to apply to this run (default is today)
  // s  : sample size (defaults to 1M)
  //-----------------------------------------------------------------------
  macAppendSample(d='',v='',s=1000000):=FUNCTIONMACRO

    sRunDate:=IF(v='',(STRING)Date.Today(),v);
		sSourceFile:=IF(#TEXT(d)='','BizLinkFull.File_BizHead',#TEXT(d));		

    // Create the sample file containing just the fields specified by the user
    dSample:=ENTH(#EXPAND(sSourceFile),s);
				
		// create and populate zip cases
		dSlimWithMultiples:=PROJECT(dSample,
			TRANSFORM(lSlim,
				SELF.zip_cases:= IF(LEFT.zip <> '',DATASET([{LEFT.zip, 100}], BizLinkFull.Process_Biz_Layouts.Layout_zip_cases),DATASET([],BizLinkFull.Process_Biz_layouts.layout_zip_cases));
				SELF:= LEFT;
		));
	
		// run append
		BizLinkFull.Mac_Meow_Biz_Batch(dSlimWithMultiples 
			,rcid
			,//Input_proxid := ''
			,//Input_seleid := ''
			,//Input_orgid := ''
			,//Input_ultid := ''
			,//Input_parent_proxid := ''
			,//Input_sele_proxid := ''
			,//Input_org_proxid := ''
			,//Input_ultimate_proxid := ''
			,//Input_has_lgid := ''
			,//Input_empid := ''
			,//Input_source := ''
			,//Input_source_record_id := ''
			,//Input_source_docid := ''
			,//Input_company_name := ''
			,company_name_prefix
			,cnp_name
			,cnp_number
			,cnp_btype
			,cnp_lowv
			,company_phone
			,company_phone_3
			,//company_phone_3_ex // this will otherwise doublecount company_phone_3
			,company_phone_7
			,company_fein
			,company_sic_code1
			,//Input_active_duns_number := ''
			,prim_range
			,prim_name
			,sec_range
			,city
			,//Input_city_clean := ''
			,st
			,zip_cases
			,company_url
			,//Input_isContact := ''
			,contact_did
			,//Input_title := ''
			,fname
			,fname_preferred
			,mname
			,lname
			,//Input_name_suffix := ''
			,contact_ssn
			,contact_email
			,sele_flag
			,org_flag
			,ult_flag
			,//Input_fallback_value := ''
			,//Input_CONTACTNAME := ''
			,//Input_STREETADDRESS := ''
			,dAppended
			,//AsIndex := 'true'
			,//In_UpdateIDs := 'false'
			,//Stats := ''
			,//In_bGetAllScores := 'true'
			,//In_disableForce := 'false'
			,//DoClean := 'true'
		);
		
    // Distill the results, then join them back to the sample
    dDistilled:=PROJECT(dAppended,
			TRANSFORM({UNSIGNED rcid;UNSIGNED appended_proxid;UNSIGNED appended_seleid_resultsproxid;UNSIGNED appended_seleid_resultsseleid;UNSIGNED prox_weight;UNSIGNED prox_score;UNSIGNED prox_distance;UNSIGNED prox_result_count;UNSIGNED sele_weight;UNSIGNED sele_score;UNSIGNED sele_distance;UNSIGNED sele_result_count;BOOLEAN disconnect;},
				SELF.rcid:=LEFT.reference;
				SELF.prox_weight:=LEFT.Results[1].weight;
				SELF.prox_score:=LEFT.Results[1].score;
				SELF.prox_distance:=LEFT.Results[1].weight-LEFT.Results[2].weight;
				SELF.prox_result_count:=COUNT(LEFT.Results);
				SELF.appended_proxid:=LEFT.Results[1].proxid;
				SELF.appended_seleid_resultsproxid:=LEFT.Results[1].seleid;
				SELF.sele_weight:=LEFT.Results_SeleID[1].weight;
				SELF.sele_score:=LEFT.Results_SeleID[1].score;
				SELF.sele_distance:=LEFT.Results_SeleID[1].weight-LEFT.Results_SeleID[2].weight;
				SELF.sele_result_count:=COUNT(LEFT.Results_SeleID);
				SELF.appended_seleid_resultsseleid:=LEFT.Results_SeleID[1].seleid;
				SELF.disconnect:=LEFT.Results_SeleID[1].seleid <> LEFT.Results[1].seleid;
			));
			
    dReJoined:=JOIN(dSlimWithMultiples,dDistilled,LEFT.rcid=RIGHT.rcid,
			TRANSFORM({STRING version;STRING1 subversion;RECORDOF(RIGHT);RECORDOF(LEFT) AND NOT rcid;UNSIGNED4 append_date;},
				SELF.version:=sRunDate;
				SELF.subversion:='a';
				SELF.append_date:=Date.Today();
				SELF:=LEFT;SELF:=RIGHT;),LEFT OUTER);

    // Return the appended data back to the user.
    RETURN dReJoined;
  ENDMACRO;  
  
  //-----------------------------------------------------------------------
  // Generate a report for a specific goup-by field
  // d : Dataset generated by macAppendSample
  // g : The group-by field
  // t : Score threshold to consider a result a "hit"
  //-----------------------------------------------------------------------
  macCreateReport_sele(d,g,t=75):=FUNCTIONMACRO 
    dSelfJoin:=JOIN(d(subversion='a'),d(subversion='b'),LEFT.rcid=RIGHT.rcid,
			TRANSFORM({LEFT.rcid,LEFT.st;LEFT.source;UNSIGNED seleid_01;UNSIGNED seleid_02;UNSIGNED sele_score_01;UNSIGNED sele_score_02;STRING sele_status;UNSIGNED header_seleid},
				SELF.seleid_01:=LEFT.appended_seleid_resultsseleid;
				SELF.seleid_02:=RIGHT.appended_seleid_resultsseleid;
				SELF.sele_score_01:=LEFT.sele_score;
				SELF.sele_score_02:=RIGHT.sele_score;
				SELF.sele_status:=MAP(
					LEFT.sele_score<t AND RIGHT.sele_score<t => 'BlankBoth',
					LEFT.sele_score<t => 'Blank01',
					RIGHT.sele_score<t => 'Blank02',
					SELF.seleid_01=SELF.seleid_02 => 'Match',
					'MisMatch'
				);
				SELF.header_seleid:=LEFT.seleid;
				SELF:=LEFT;
    ));

		dJoinKeyIDHistory:=JOIN(bizlinkfull.process_biz_layouts.KeyIDHistory,dSelfJoin,LEFT.rcid=right.rcid,
			TRANSFORM({recordof(dSelfJoin);UNSIGNED clusterchange_seleid},
				SELF.clusterchange_seleid:=if(left.seleid=right.header_seleid,0,left.seleid);
				SELF:=RIGHT;
			),RIGHT OUTER);		
		
    dGrouped:=TABLE(dJoinKeyIDHistory,{
      g;
			#IF(Str.ToUpperCase(#TEXT(g))='SOURCE')
				source_description:=mdr.sourcetools.TranslateSource(g);
			#END
      input_count:=COUNT(GROUP);
      recall_previous:=COUNT(GROUP,sele_score_01>=t);
			ambiguous_previous:=COUNT(GROUP,sele_score_01>0 and sele_score_01<t);
			nohit_previous:=COUNT(GROUP,sele_score_01=0);
      recall_current:=COUNT(GROUP,sele_score_02>=t);
			ambiguous_current:=COUNT(GROUP,sele_score_02>0 and sele_score_02<t);
			nohit_current:=COUNT(GROUP,sele_score_02=0);
      blank_to_found:=COUNT(GROUP,sele_status='Blank01');
      found_to_blank:=COUNT(GROUP,sele_status='Blank02');
      always_blank:=COUNT(GROUP,sele_status='BlankBoth');
			match:=COUNT(GROUP,sele_status='Match');
			mismatch:=COUNT(GROUP,sele_status='MisMatch');
      pct_recall_previous:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,sele_score_01>=t)/COUNT(GROUP)));
			pct_ambiguous_previous:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,sele_score_01>0 and sele_score_01<t)/COUNT(GROUP)));
			pct_nohit_previous:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,sele_score_01=0)/COUNT(GROUP)));
      pct_recall_current:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,sele_score_02>=t)/COUNT(GROUP)));
			pct_ambiguous_current:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,sele_score_02>0 and sele_score_02<t)/COUNT(GROUP)));
			pct_nohit_current:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,sele_score_02=0)/COUNT(GROUP)));
			pct_recall_shift:=fDecimalFormat((DECIMAL10_6)((COUNT(GROUP,sele_score_02>=t)/COUNT(GROUP))-(COUNT(GROUP,sele_score_01>=t)/COUNT(GROUP))));
      pct_mismatch:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,sele_status='MisMatch')/(COUNT(GROUP,sele_status='MisMatch')+COUNT(GROUP,sele_status='Match'))));
			precision_previous:=COUNT(GROUP,sele_score_01>=t AND seleid_01=header_seleid);
			precision_current:=COUNT(GROUP,sele_score_02>=t AND ((seleid_02=header_seleid AND clusterchange_seleid=0) OR (seleid_02=clusterchange_seleid)));
			pct_precision_previous:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,sele_score_01>=t AND seleid_01=header_seleid)/COUNT(GROUP,sele_score_01>=t)));
      pct_precision_current:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,sele_score_02>=t AND ((seleid_02=header_seleid AND clusterchange_seleid=0) OR (seleid_02=clusterchange_seleid)))/COUNT(GROUP,sele_score_02>=t)));
			clusterchange:=COUNT(GROUP,clusterchange_seleid>0);
			clusterchange_caused_mismatch:=COUNT(GROUP,sele_status='MisMatch' AND seleid_01=header_seleid AND seleid_02=clusterchange_seleid);
    },g);
    
    RETURN SORT(dGrouped,g);
  ENDMACRO;
  
  macCreateReport_prox(d,g,t=75):=FUNCTIONMACRO
    dSelfJoin:=JOIN(d(subversion='a'),d(subversion='b'),LEFT.rcid=RIGHT.rcid,
			TRANSFORM({LEFT.rcid,LEFT.st;LEFT.source;UNSIGNED proxid_01;UNSIGNED proxid_02;UNSIGNED prox_score_01;UNSIGNED prox_score_02;STRING prox_status;UNSIGNED header_proxid},
				SELF.proxid_01:=LEFT.appended_proxid;
				SELF.proxid_02:=RIGHT.appended_proxid;
				SELF.prox_score_01:=LEFT.prox_score;
				SELF.prox_score_02:=RIGHT.prox_score;
				SELF.prox_status:=MAP(
					LEFT.prox_score<t AND RIGHT.prox_score<t => 'BlankBoth',
					LEFT.prox_score<t => 'Blank01',
					RIGHT.prox_score<t => 'Blank02',
					SELF.proxid_01=SELF.proxid_02 => 'Match',
					'MisMatch'
				);
				SELF.header_proxid:=LEFT.proxid;
				SELF:=LEFT;
    ));

		dJoinKeyIDHistory:=JOIN(bizlinkfull.process_biz_layouts.KeyIDHistory,dSelfJoin,LEFT.rcid=right.rcid,
			TRANSFORM({recordof(dSelfJoin);UNSIGNED clusterchange_proxid},
				SELF.clusterchange_proxid:=if(left.proxid=right.header_proxid,0,left.proxid);
				SELF:=RIGHT;
			),RIGHT OUTER);		
		
    dGrouped:=TABLE(dJoinKeyIDHistory,{
      g;
			#IF(Str.ToUpperCase(#TEXT(g))='SOURCE')
				source_description:=mdr.sourcetools.TranslateSource(g);
			#END
      input_count:=COUNT(GROUP);
      recall_previous:=COUNT(GROUP,prox_score_01>=t);
			ambiguous_previous:=COUNT(GROUP,prox_score_01>0 and prox_score_01<t);
			nohit_previous:=COUNT(GROUP,prox_score_01=0);
      recall_current:=COUNT(GROUP,prox_score_02>=t);
			ambiguous_current:=COUNT(GROUP,prox_score_02>0 and prox_score_02<t);
			nohit_current:=COUNT(GROUP,prox_score_02=0);
      blank_to_found:=COUNT(GROUP,prox_status='Blank01');
      found_to_blank:=COUNT(GROUP,prox_status='Blank02');
      always_blank:=COUNT(GROUP,prox_status='BlankBoth');
			match:=COUNT(GROUP,prox_status='Match');
			mismatch:=COUNT(GROUP,prox_status='MisMatch');
      pct_recall_previous:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,prox_score_01>=t)/COUNT(GROUP)));
			pct_ambiguous_previous:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,prox_score_01>0 and prox_score_01<t)/COUNT(GROUP)));
			pct_nohit_previous:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,prox_score_01=0)/COUNT(GROUP)));
      pct_recall_current:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,prox_score_02>=t)/COUNT(GROUP)));
			pct_ambiguous_current:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,prox_score_02>0 and prox_score_02<t)/COUNT(GROUP)));
			pct_nohit_current:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,prox_score_02=0)/COUNT(GROUP)));
			pct_recall_shift:=fDecimalFormat((DECIMAL10_6)((COUNT(GROUP,prox_score_02>=t)/COUNT(GROUP))-(COUNT(GROUP,prox_score_01>=t)/COUNT(GROUP))));
      pct_mismatch:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,prox_status='MisMatch')/(COUNT(GROUP,prox_status='MisMatch')+COUNT(GROUP,prox_status='Match'))));
			precision_previous:=COUNT(GROUP,prox_score_01>=t AND proxid_01=header_proxid);
			precision_current:=COUNT(GROUP,prox_score_02>=t AND ((proxid_02=header_proxid AND clusterchange_proxid=0) OR (proxid_02=clusterchange_proxid)));			
			pct_precision_previous:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,prox_score_01>=t AND proxid_01=header_proxid)/COUNT(GROUP,prox_score_01>=t)));
      pct_precision_current:=fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,prox_score_02>=t AND ((proxid_02=header_proxid AND clusterchange_proxid=0) OR (proxid_02=clusterchange_proxid)))/COUNT(GROUP,prox_score_02>=t)));
			clusterchange:=COUNT(GROUP,clusterchange_proxid>0);
			clusterchange_caused_mismatch:=COUNT(GROUP,prox_status='MisMatch' AND proxid_01=header_proxid AND proxid_02=clusterchange_proxid);
    },g);
    
    RETURN SORT(dGrouped,g);
  ENDMACRO;
	
  //-----------------------------------------------------------------------
  // Output Mismatch samples from the append comparison
  // d : Dataset generated by macAppendSample
  //-----------------------------------------------------------------------
  macGenerateMismatchSamples(d):=FUNCTIONMACRO
    // Create a sample output contianing mismatches for review and analysis
    lResults:={STRING1 subversion;UNSIGNED8 appended_proxid;UNSIGNED8 appended_seleid_resultsproxid;UNSIGNED8 appended_seleid_resultsseleid;UNSIGNED8 prox_weight;UNSIGNED8 sele_weight;UNSIGNED8 prox_score;UNSIGNED8 sele_score;UNSIGNED8 sele_distance;UNSIGNED8 prox_result_count;UNSIGNED8 sele_result_count;};
    
    dResults:=PROJECT(SORT(d,rcid,subversion),TRANSFORM({DATASET(lResults) results;BOOLEAN diff;RECORDOF(LEFT) AND NOT [subversion,appended_proxid,appended_seleid_resultsproxid,appended_seleid_resultsseleid,prox_weight,prox_score,prox_distance,prox_result_count,sele_weight,sele_score,sele_distance,sele_result_count,disconnect,proxid,seleid,append_date];},
      SELF.results:=DATASET([{LEFT.subversion;LEFT.appended_proxid;LEFT.appended_seleid_resultsproxid;LEFT.appended_seleid_resultsseleid;LEFT.prox_weight;LEFT.sele_weight;LEFT.prox_score;LEFT.sele_score;LEFT.sele_distance;LEFT.prox_result_count;LEFT.sele_result_count;}],lResults);
      SELF.diff:=FALSE;
      SELF:=LEFT;
    ));

    #UNIQUENAME(dResultsRolled)
    dResultsRolled:=ROLLUP(dResults,LEFT.rcid=RIGHT.rcid,TRANSFORM(RECORDOF(LEFT),SELF.results:=LEFT.results+RIGHT.results;SELF.diff:=(LEFT.results[1].appended_proxid<>RIGHT.results[1].appended_proxid);SELF:=LEFT;));
    
    RETURN OUTPUT(ENTH(dResultsRolled(diff),100),NAMED('MismatchSample'));
  ENDMACRO;
  
  macShowHistory(d):=FUNCTIONMACRO
  
  ENDMACRO;

  //-----------------------------------------------------------------------
  // Call this macro to compare appends from two builds of the same macro.
  // v   : The version to assign to this run
  // s   : Sample size
  // t   : Score threshold used for reporting
  //-----------------------------------------------------------------------
  macCompareBuilds(v,s=1000000,t=75):=MACRO
    
    #UNIQUENAME(sIDField)
    
    // Create a new sample and append it
    #UNIQUENAME(dAppended)
    %dAppended%:=macAppendSample(,v,s);
   
   // Get a listing of logical files already in the history superfile
    #UNIQUENAME(dLogicalFileList)
    %dLogicalFileList%:=NOTHOR(IF(File.SuperfileExists(sSuperfileName),
      File.SuperfileContents(sSuperfileName),
      DATASET([],{STRING name;})
    ));
    
    // Pull the data from history if it exists
    #UNIQUENAME(dHistory)
    %dHistory%:=IF(COUNT(%dLogicalFileList%)=0,
      DATASET([],RECORDOF(%dAppended%)),
      DATASET(sSuperfileName,RECORDOF(%dAppended%),THOR)
    );
    
    // Determine the latest build in the history data
    #UNIQUENAME(sMaxVersion)
    %sMaxVersion%:=MAX(%dHistory%(version<>v),version);
    
    // Get the most recent previous version from the history data
    #UNIQUENAME(dPreviousSample)
    %dPreviousSample%:=%dHistory%(version=%sMaxVersion% AND subversion='a');
    
    // Re-Append the most recent previous data using the current build's keys
    #UNIQUENAME(dReAppended)
    %dReAppended%:=IF(COUNT(%dPreviousSample%)=0,DATASET([],RECORDOF(%dAppended%)),PROJECT(macAppendSample(%dPreviousSample%,%sMaxVersion%,s),TRANSFORM(RECORDOF(%dAppended%),SELF.subversion:='b';SELF:=LEFT;)));
    
    // Combine the two appended sets, save to disk and add to the superfile (different version, same logical file)
    #UNIQUENAME(dResults)
    %dResults%:=%dAppended%+%dReAppended%;
    SEQUENTIAL(
      OUTPUT(PROJECT(%dResults%,RECORDOF(%dAppended%)),,sSuperfileName+'::'+v, COMPRESSED),
      File.AddSuperfile(sSuperfileName,sSuperfileName+'::'+v)
    );
		
    // Put the two appends from the same sample together (same version, different logical files)
    #UNIQUENAME(dCompare)
    %dCompare%:=%dPreviousSample%+%dReAppended%;

OUTPUT(macCreateReport_sele(%dCompare%,st,75),NAMED('SeleID_BySt'), all);
OUTPUT(macCreateReport_sele(%dCompare%,source,75),NAMED('SeleID_BySource'), all);
OUTPUT(macCreateReport_sele(%dCompare%,'Summary',75),NAMED('SeleID_Summary'),all);    
OUTPUT(macCreateReport_prox(%dCompare%,st,75),NAMED('ProxID_BySt'), all);
OUTPUT(macCreateReport_prox(%dCompare%,source,75),NAMED('ProxID_BySource'), all);
OUTPUT(macCreateReport_prox(%dCompare%,'Summary',75),NAMED('ProxID_Summary'),all);  

OUTPUT(ENTH(%dAppended%(disconnect=TRUE and sele_distance>0),100),NAMED('Samples_SeleID_Disconnect'));  
OUTPUT(ENTH(%dAppended%(prox_score>0 and prox_score<t),100),NAMED('Samples_Ambiguous')); 
OUTPUT(ENTH(%dAppended%(prox_score=0),100),NAMED('Samples_NoHit')); 
OUTPUT(ENTH(%dAppended%(proxid<>appended_proxid AND prox_score>=t),100),NAMED('Samples_PrecisionError')); 
macGenerateMismatchSamples(%dCompare%);		

  ENDMACRO;
    
  macHistory(m):=FUNCTIONMACRO
  ENDMACRO;

sVersion := '20190701';
#workunit('name','BIPV2_Build.proc_xlink_validation_combined_'+sVersion);
#workunit('priority','high');
#OPTION('multiplePersistInstances',FALSE);
macCompareBuilds(sVersion);
