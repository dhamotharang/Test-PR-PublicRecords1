import 
// Business_DOT_SALT_micro4,
business_header,salt22,Business_DOT,BIPV2_Files,BIPV2;
export _Layouts :=
module
	export linking := Business_Header.Layout_Business_Linking;
	export layout_slim :=
	record
		unsigned6            rcid                                                                        ;
		string2              source                                                                      ;
		unsigned6            dotid                                                                       ;
		unsigned6            proxid                                                                      ;
		unsigned6            lgid3                                                                       ;
		unsigned6            orgid                                                                       ;
		unsigned6            ultid                                                                       ;
		string250            cnp_name                                                                    ;
		string30             cnp_number                                                                  ;
		string10             prim_range                                                                  ;
		string28             prim_name_derived                                                           ;
		string8              sec_range                                                                   ;
		string25             v_city_name                                                                 ;
		string2              st                                                                          ;
		string5              zip                                                                         ;
		string9              active_duns_number                                                          ;
		string9              hist_duns_number                                                            ;
		string9              active_enterprise_number                                                    ;
		string9              hist_enterprise_number                                                      ;
		string9              ebr_file_number                                                             ;
		string30             active_domestic_corp_key                                                    ;
		string30             hist_domestic_corp_key                                                      ;
		string30             foreign_corp_key                                                            ;
		string30             unk_corp_key                                                                ;
		unsigned4            dt_first_seen                                                               ;
		unsigned4            dt_last_seen                                                                ;
		string9              company_fein                                                                ;
		string10             company_phone                                                               ;
		string2              company_inc_state                                                           ;
		string32             company_charter_number                                                      ;
	end;

//	export orig_DOT_Base := Business_DOT.Files.l_dot;
	export orig_DOT_Base := BIPV2.CommonBase.Layout;
  
	export DOT_Base_orig := BIPV2.CommonBase.Layout;
  export DOT_Base := layout_slim;
  
//	export attfile_duns_entum := {dot_base.proxid,dot_base.duns_number,dot_base.enterprise_number};
	export attfile_contact 		:= {dot_base.proxid,string73 contact};

shared r := RECORD
   unsigned2 conf;
   unsigned8 matchesfound;
  END;

shared validitystatistics_lay := RECORD
   integer8 patchingerror0;
   integer8 duplicaterids0;
   unsigned8 unlinkablerecords0;
  END;

shared validitystatistics_lay_old := RECORD
   integer8 patchingerror0;
   integer8 didsnorid0;
   integer8 didsaboverid0;
   integer8 duplicaterids0;
   unsigned8 unlinkablerecords0;
  END;

shared r___1 := RECORD
   unsigned2 rulenumber;
   string rule;
   unsigned8 matchesfound;
  END;

shared layout_names := RECORD
   string name;
  END;

export wkhistory := RECORD
  string24 wuid;
  string owner;
  string cluster;
  string job;
  string10 state;
  string7 priority;
  boolean online;
  boolean protected;
  string totalthortime;
  string description;
  string version;
  string iteration;
  string matchesperformed;
  string preclustercount;
  string postclustercount;
  string basicmatchesperformed;
  string slicesperformed;
  string proxidscreatedbycleave;
  string allsamplescands;
  DATASET(r) confidencelevels;
  DATASET(validitystatistics_lay) validitystatistics;
  DATASET(r___1) ruleefficacy;
  DATASET(layout_names) filesread;
  DATASET(layout_names) fileswritten;
 END;                                                     

export wkhistoryold := RECORD
  string24 wuid;
  string owner;
  string cluster;
  string job;
  string10 state;
  string7 priority;
  boolean online;
  boolean protected;
  string totalthortime;
  string description;
  string version;
  string iteration;
  string matchesperformed;
  string preclustercount;
  string postclustercount;
  string basicmatchesperformed;
  string slicesperformed;
  string proxidscreatedbycleave;
  string allsamplescands;
  DATASET(r) confidencelevels;
  DATASET(validitystatistics_lay_old) validitystatistics;
  DATASET(r___1) ruleefficacy;
  DATASET(layout_names) filesread;
  DATASET(layout_names) fileswritten;
 END;                                                     

  // export wkhistory := {		 string24 wuid 	,string owner 	,string cluster 	,string job 	,string10 state 	,string7 priority 	,boolean online 	,boolean protected ,string TotalThorTime,string Description,string Version,string Iteration,string MatchesPerformed,string PreClusterCount,string PostClusterCount,string AllSamplesCands,dataset( {UNSIGNED2 Conf,UNSIGNED MatchesFound}) ConfidenceLevels,dataset( {INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0}) ValidityStatistics,dataset( {UNSIGNED2 RuleNumber;STRING Rule;UNSIGNED MatchesFound ;}) RuleEfficacy,dataset({string name}) FilesRead,dataset({string name}) FilesWritten};
  
  export layerrorcounts := {unsigned Checked_matches,unsigned bad_Matches, unsigned questionable_matches};
  export layconflevels := wkhistory.confidencelevels;
  export precision := {string version,string iteration,layconflevels,layerrorcounts Review_Info};
end;
