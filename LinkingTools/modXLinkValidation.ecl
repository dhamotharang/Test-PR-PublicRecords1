IMPORT wk_ut;
IMPORT WsDFU;
EXPORT modXLinkValidation := MODULE
  IMPORT Std.Str AS Str;
  IMPORT Std.File AS File;

  //----------------------  FILE COMPARISON CODE ----------------------------

  // Simple presentation formatters
  SHARED STRING16 fToComma(INTEGER i):=IF(i<0,'-',' ')+REGEXREPLACE('( ,|,$)',REGEXREPLACE('([ 0-9]{3})',Str.Repeat(' ',12-LENGTH((STRING)ABS(i)))+(STRING)ABS(i),'$1,'),'  ');
  SHARED INTEGER fToInteger(STRING s):=(INTEGER)REGEXREPLACE('[^-0-9]',s,'');
  EXPORT STRING11 fDecimalFormat(DECIMAL n):=IF(n=0,'    0.0000%',IF(n<0,'-',' ')+('   '+REGEXFIND('([0-9]*)[.]',((STRING)(n*100)),1))[LENGTH(('   '+REGEXFIND('([0-9]*)[.]',((STRING)(n*100)),1)))-3..]+'.'+(REGEXFIND('[.]([0-9]*)',((STRING)(n*100)+'0000'),1))[..4])+'%';

  // Layout for the fFileStats function
  SHARED lMismatches:=RECORD
    STRING field_old;
    STRING field_new;
  END;
  SHARED lStats:=RECORD
    STRING name_old;
    STRING name_new;
    STRING size_old;
    STRING size_new;
    STRING size_diff;
    STRING size_shift;
    STRING rowcount_old;
    STRING rowcount_new;
    STRING rowcount_diff;
    STRING rowcount_shift;
    BOOLEAN layout_match;
    DATASET(lMismatches) mismatches;
  END;

  //-----------------------------------------------------------------------
  // sModule01  : Mask for filtering on the first set of keys
  // sVersion01 : Version for the first set of keys
  // sModule02  : Mask for filtering on the second set of keys
  // sVersion02 : Version for the second set of keys
  // sESP       : The ESP that points to the files (Default is Dataland)
  //-----------------------------------------------------------------------
  EXPORT fFileStats(STRING sModule01,STRING sVersion01,STRING sModule02,STRING sVersion02,STRING sESP='dataland_esp.br.seisint.com'):=FUNCTION
    d01:=PROJECT(DEDUP(SORT(WsDFU.soapcall_DFUQuery(sModule01,pEsp:=sEsp)[1].logical_files[1].logical_file(REGEXFIND(sVersion01,name,NOCASE)),name,modified),name),TRANSFORM({RECORDOF(LEFT);STRING join_name;},SELF.join_name:=REGEXREPLACE('('+REGEXREPLACE('(^[|]|[|]$)',REGEXREPLACE('[^a-zA-Z0-9_]+',sModule01,'|'),'')+'|'+sVersion01+')',LEFT.name,'*');SELF:=LEFT;));
    d02:=PROJECT(DEDUP(SORT(WsDFU.soapcall_DFUQuery(sModule02,pEsp:=sEsp)[1].logical_files[1].logical_file(REGEXFIND(sVersion02,name,NOCASE)),name,modified),name),TRANSFORM({RECORDOF(LEFT);STRING join_name;},SELF.join_name:=REGEXREPLACE('('+REGEXREPLACE('(^[|]|[|]$)',REGEXREPLACE('[^a-zA-Z0-9_]+',sModule02,'|'),'')+'|'+sVersion02+')',LEFT.name,'*');SELF:=LEFT;));

    RETURN JOIN(d01,d02,LEFT.join_name=RIGHT.join_name,TRANSFORM(lStats,
      dStatsOld:=WsDFU.soapcall_DFUInfo(LEFT.name,pesp:=sESP)[1];
      dStatsNew:=WsDFU.soapcall_DFUInfo(RIGHT.name,pesp:=sESP)[1];
      SELF.name_old:=LEFT.name;
      SELF.name_new:=RIGHT.name;
      SELF.size_old:=fToComma((UNSIGNED)(fToInteger(LEFT.totalsize)));
      SELF.size_new:=fToComma((UNSIGNED)(fToInteger(RIGHT.totalsize)));
      SELF.size_diff:=fToComma(fToInteger(SELF.size_new)-fToInteger(SELF.size_old));
      SELF.size_shift:=fDecimalFormat((DECIMAL10_6)(fToInteger(SELF.size_diff)/fToInteger(SELF.size_old)));
      SELF.rowcount_old:=fToComma((UNSIGNED)(fToInteger(LEFT.recordcount)));
      SELF.rowcount_new:=fToComma((UNSIGNED)(fToInteger(RIGHT.recordcount)));
      SELF.rowcount_diff:=fToComma(fToInteger(SELF.rowcount_new)-fToInteger(SELF.rowcount_old));
      SELF.rowcount_shift:=fDecimalFormat((DECIMAL10_6)(fToInteger(SELF.rowcount_diff)/fToInteger(SELF.rowcount_old)));
      SELF.layout_match:=dStatsOld.ecl=dStatsNew.ecl;
      SELF.mismatches:=JOIN(
        DATASET(REGEXFINDSET('[^ ]+ [^ ]+;',REGEXREPLACE('(RECORD|END;)',dStatsOld.ecl,'')),{STRING field;}),
        DATASET(REGEXFINDSET('[^ ]+ [^ ]+;',REGEXREPLACE('(RECORD|END;)',dStatsNew.ecl,'')),{STRING field;}),
        LEFT.field=RIGHT.field,TRANSFORM(lMismatches,
          SELF.field_old:=LEFT.field;
          SELF.field_new:=RIGHT.field;
        )
      ,FULL OUTER)(field_old<>field_new);
    ));
  END;

  // Example: Comparing keys from two different builds:
  /*
    LinkingTools.modXLinkValidation.fFileStats('thor_data400*key*BizLinkFull::*','20170125','thor_data400*key*BizLinkFull::*','20170315');
  */
  
  
  //--------------  APPEND RESULTS COMPARISON CODE ------------------------
  
  EXPORT sSuperfileName(STRING m):='~thor::xlink_validation::'+m;
  

  //-----------------------------------------------------------------------
  // m  : Header Module to examine
  // d  : If specified, a dataset input.  If left blank the most recent base
  //      file from that header is used
  // f  : comma-delimited list of fields to include in searches
  // g  : comma-delimited list of group-by fields in output
  // v  : YYYYMMDD version to apply to this run (default is today)
  // s  : sample size (defaults to 1M)
  //-----------------------------------------------------------------------
  EXPORT macAppendSample(m,d='',f,g,v='',s=1000000):=FUNCTIONMACRO
    IMPORT Std.Date AS Date;
    IMPORT Std.File AS File;
    
    sRunDate:=IF(v='',(STRING)Date.Today(),v);

    // Collect the important bits of information from GenerationMod
    sProcessName:=REGEXFIND('PROCESS:([^:]+)',m.GenerationMod.spcString,1,NOCASE);
    sMultiples:=REGEXREPLACE(';[^;]+:[^;]+;',';'+REGEXREPLACE('FIELD:([^:]+):[^\n]*MULTIPLE',m.GenerationMod.spcString,';$1;',NOCASE)+';',';')[2..];
    sMacroName:='MAC_MEOW_'+REGEXFIND('PROCESS:([^:]+)',m.GenerationMod.spcString,1,NOCASE)+'_Batch';
    sBaseFile:='File_'+REGEXFIND('^FILENAME:([^:\n]+)',m.GenerationMod.spcString,1,NOCASE);
    sIDField:=REGEXFIND('^IDFIELD:(EXISTS:){0,1}([^:\n]+)',m.GenerationMod.spcString,2,NOCASE);
    sRIDField:=REGEXFIND('^RIDFIELD:([^:\n]+)',m.GenerationMod.spcString,1,NOCASE);
    sSourceFile:=IF(#TEXT(d)='',#TEXT(m)+'.'+sBaseFile,#TEXT(d));

    // Create the sample file containing just the fields specified by the user
    dSample:=PROJECT(ENTH(#EXPAND(sSourceFile),s),{UNSIGNED __i__:=0;} OR RECORDOF(LEFT));
    dSampleSequenced:=PROJECT(dSample,TRANSFORM(RECORDOF(LEFT),SELF.__i__:=IF(LEFT.__i__=0,COUNTER,LEFT.__i__);SELF:=LEFT;));
    dSlim:=#EXPAND('PROJECT(dSampleSequenced,TRANSFORM({LEFT.__i__;{'+REGEXREPLACE('([^,]+),',','+f+',','LEFT.$1;')[2..]+'} OR {'+REGEXREPLACE('([^,]+),',','+g+',','LEFT.$1;')[2..]+'}},SELF:=LEFT;SELF:=[];));');
    dSlimWithMultiples:=#EXPAND('PROJECT(dSlim,TRANSFORM({RECORDOF(LEFT)'+REGEXREPLACE('([^;]+)',';'+sMultiples,'DATASET('+#TEXT(m)+'.'+'Process_'+sProcessName+'_Layouts.Layout_$1_cases) $1_cases')+'},'+REGEXREPLACE('([^;]+)',sMultiples,'SELF.$1_cases:=DATASET([{LEFT.$1,0}],'+#TEXT(m)+'.'+'Process_'+sProcessName+'_Layouts.Layout_$1_cases)')+'SELF:=LEFT;))');
    // Run an append against the sample file
    #EXPAND(#TEXT(m)+'.'+sMacroName+'(dSlimWithMultiples,__i__,'+REGEXREPLACE('_cases:=',REGEXREPLACE('(^,|,$)',REGEXREPLACE('([^,]+)',REGEXREPLACE('=[^,]+',','+REGEXREPLACE(IF(sMultiples='','_-_',REGEXREPLACE(';',REGEXREPLACE(';$','('+sMultiples,')'),'|')),f,'$1_cases',NOCASE)+',',''),'INPUT_$1:=$1'),''),':=')+',OutFile:=dAppended);')
    
    // Distill the results, then join them back to the sample
    dDistilled:=PROJECT(dAppended,TRANSFORM({UNSIGNED __i__;UNSIGNED #EXPAND(sIDField);UNSIGNED weight;UNSIGNED score;UNSIGNED distance;UNSIGNED result_count;},SELF.__i__:=LEFT.reference;SELF.weight:=LEFT.Results[1].weight;SELF.score:=LEFT.Results[1].score;SELF.distance:=LEFT.Results[1].weight-LEFT.Results[2].weight;SELF.result_count:=COUNT(LEFT.Results);SELF.#EXPAND(sIDField):=LEFT.Results[1].#EXPAND(sIDField);));
    dReJoined:=JOIN(dSlim,dDistilled,LEFT.__i__=RIGHT.__i__,TRANSFORM({STRING version;STRING1 subversion;RECORDOF(RIGHT);RECORDOF(LEFT) AND NOT __i__;UNSIGNED4 append_date;},SELF.version:=sRunDate;SELF.subversion:='a';SELF.append_date:=Date.Today();SELF:=LEFT;SELF:=RIGHT;),LEFT OUTER);

    // Return the appended data back to the user.
    RETURN dReJoined;//*/
  ENDMACRO;  
  
  //-----------------------------------------------------------------------
  // Generate a report for a specific goup-by field
  // d : Dataset generated by macAppendSample
  // i : IDFIELD
  // r : RIDFIELD
  // g : The group-by field
  // t : Score threshold to consider a result a "hit"
  //-----------------------------------------------------------------------
  EXPORT macCreateReport(d,i,r,g,t=75):=FUNCTIONMACRO
    dSelfJoin:=JOIN(d(subversion='a'),d(subversion='b'),LEFT.r=RIGHT.r,TRANSFORM({LEFT.r,LEFT.g;UNSIGNED id_01;UNSIGNED id_02;UNSIGNED score_01;UNSIGNED score_02;STRING status;},
      SELF.id_01:=IF(LEFT.score>=t,LEFT.i,0);
      SELF.id_02:=IF(RIGHT.score>=t,RIGHT.i,0);
      SELF.score_01:=IF(LEFT.score>=t,LEFT.score,0);
      SELF.score_02:=IF(RIGHT.score>=t,RIGHT.score,0);
      // SELF.status:=IF(SELF.id_01=0 OR SELF.id_02=0,IF(SELF.id_01=0 AND SELF.id_02=0,'','OneBlank'),IF(SELF.id_01=SELF.id_02,'Match','MisMatch'));
      SELF.status:=MAP(
        SELF.id_01=0 AND SELF.id_02=0 => 'BlankBoth',
        SELF.id_01=0 => 'Blank01',
        SELF.id_02=0 => 'Blank02',
        SELF.id_01=SELF.id_02 => 'Match',
        'MisMatch'
      );
      SELF:=LEFT;
    ));
    dGrouped:=TABLE(dSelfJoin,{
      g;
      input_count:=COUNT(GROUP);
      recall_01:=COUNT(GROUP,score_01>=t);
      recall_02:=COUNT(GROUP,score_02>=t);
      blank_to_found:=COUNT(GROUP,status='Blank01');
      found_to_blank:=COUNT(GROUP,status='Blank02');
      always_blank:=COUNT(GROUP,status='BlankBoth');
      pct_recall_01:=LinkingTools.modXLinkValidation.fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,score_01>=t)/COUNT(GROUP)));
      pct_recall_02:=LinkingTools.modXLinkValidation.fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,score_02>=t)/COUNT(GROUP)));
      pct_shift:=LinkingTools.modXLinkValidation.fDecimalFormat((DECIMAL10_6)((COUNT(GROUP,score_02>=t)/COUNT(GROUP))-(COUNT(GROUP,score_01>=t)/COUNT(GROUP))));
      pct_mismatch:=LinkingTools.modXLinkValidation.fDecimalFormat((DECIMAL10_6)(COUNT(GROUP,status='MisMatch')/(COUNT(GROUP,status='MisMatch')+COUNT(GROUP,status='Match'))));
    },g);
    
    RETURN SORT(dGrouped,g);
  ENDMACRO;
  
  //-----------------------------------------------------------------------
  // Output Mismatch samples from the append comparison
  // d : Dataset generated by macAppendSample
  // i : IDFIELD
  //-----------------------------------------------------------------------
  EXPORT macGenerateMismatchSamples(d,i):=FUNCTIONMACRO
    // Create a sample output contianing mismatches for review and analysis
    lResults:={STRING1 subversion;UNSIGNED8 #EXPAND(i);UNSIGNED8 weight;UNSIGNED8 score;UNSIGNED8 distance;UNSIGNED8 result_count;};
    
    dResults:=PROJECT(SORT(d,__i__,subversion),TRANSFORM({DATASET(lResults) results;BOOLEAN diff;RECORDOF(LEFT) AND NOT [subversion,#EXPAND(i),weight,score,distance,result_count];},
      SELF.results:=DATASET([{LEFT.subversion;LEFT.#EXPAND(i);LEFT.weight;LEFT.score;LEFT.distance;LEFT.result_count;}],lResults);
      SELF.diff:=FALSE;
      SELF:=LEFT;
    ));

    #UNIQUENAME(dResultsRolled)
    dResultsRolled:=ROLLUP(dResults,LEFT.__i__=RIGHT.__i__,TRANSFORM(RECORDOF(LEFT),SELF.results:=LEFT.results+RIGHT.results;SELF.diff:=(LEFT.results[1].#EXPAND(i)<>RIGHT.results[1].#EXPAND(i));SELF:=LEFT;));
    
    RETURN OUTPUT(ENTH(dResultsRolled(diff),1000),NAMED('MismatchSample'));
  ENDMACRO;
  
  macShowHistory(d):=FUNCTIONMACRO
  
  ENDMACRO;

  //-----------------------------------------------------------------------
  // Call this macro to compare appends from two separate modules.
  // m01 : First module to use for append
  // m02 : Second module to use for append
  // d   : Dataset from which to draw the sample.  If empty, File_xxx is used
  // f   : list of fields used for appending
  // g   : comma-delimited list of group-by fields
  // s   : Sample size
  // t   : Score threshold used for reporting
  //-----------------------------------------------------------------------
  EXPORT macCompareModules(m01,m02,d='',f,g,s=1000000,t=75):=MACRO
  
    #UNIQUENAME(sIDField)
    %sIDField%:=REGEXFIND('^IDFIELD:(EXISTS:){0,1}([^:\n]+)',m01.GenerationMod.spcString,2,NOCASE);
    
    // Generate a sample and append from module 1
    #UNIQUENAME(dAppended01)
    %dAppended01%:=LinkingTools.modXLinkValidation.macAppendSample(m01,d,f,g,'0',s);
    
    // Take the same sample and append through module 2
    #UNIQUENAME(dAppended)
    %dAppended%:=%dAppended01%+PROJECT(LinkingTools.modXLinkValidation.macAppendSample(m02,%dAppended01%,f,g,'0',s),TRANSFORM(RECORDOF(LEFT),SELF.subversion:='b';SELF:=LEFT;));
    
    // produce comparison reports
    #EXPAND(REGEXREPLACE('([^,]+),',g+',','OUTPUT(LinkingTools.modXLinkValidation.macCreateReport('+#TEXT(%dAppended%)+','+%sIDField%+',__i__,$1,'+t+'),NAMED(\'GroupBy$1\'));\n'));
    
    LinkingTools.modXLinkValidation.macGenerateMismatchSamples(%dAppended%,%sIDField%);
  ENDMACRO;
  
  // Example: Comparing two module's append rates with 100000 sample records:
  /*
    LinkingTools.modXLinkValidation.macCompareModules(
      BizLinkFull,
      BizLinkFull02,
      ,
      'cnp_name,prim_range,prim_name,sec_range,city,st,zip,company_phone,company_fein',
      'st,source',
      100000
    );
  */

  //-----------------------------------------------------------------------
  // Call this macro to compare appends from two builds of the same macro.
  // m   : The module to use for append
  // d   : Dataset from which to draw the sample.  If empty, File_xxx is used
  // f   : list of fields used for appending
  // g   : comma-delimited list of group-by fields
  // v   : The version to assign to this run
  // s   : Sample size
  // t   : Score threshold used for reporting
  //-----------------------------------------------------------------------
  EXPORT macCompareBuilds(m,d='',f,g,v,s=1000000,t=75,sSuffix='\'\''):=MACRO
    IMPORT Std.File AS File;
    
    #UNIQUENAME(sIDField)
    %sIDField%:=REGEXFIND('^IDFIELD:(EXISTS:){0,1}([^:\n]+)',m.GenerationMod.spcString,2,NOCASE);
    
    // Create a new sample and append it
    #UNIQUENAME(dAppended)
    %dAppended%:=LinkingTools.modXLinkValidation.macAppendSample(m,d,f,g,v,s);
   
   // Get a listing of logical files already in the history superfile
    #UNIQUENAME(dLogicalFileList)
    %dLogicalFileList%:=NOTHOR(IF(File.SuperfileExists(LinkingTools.modXLinkValidation.sSuperfileName(#TEXT(m)+IF(sSuffix<>'','::'+sSuffix,''))),
      File.SuperfileContents(LinkingTools.modXLinkValidation.sSuperfileName(#TEXT(m)+IF(sSuffix<>'','::'+sSuffix,''))),
      DATASET([],{STRING name;})
    ));
    
    // Pull the data from history if it exists
    #UNIQUENAME(dHistory)
    %dHistory%:=IF(COUNT(%dLogicalFileList%)=0,
      DATASET([],RECORDOF(%dAppended%)),
      DATASET(LinkingTools.modXLinkValidation.sSuperfileName(#TEXT(m)+IF(sSuffix<>'','::'+sSuffix,'')),RECORDOF(%dAppended%),THOR)
    );
    
    // Determine the latest build in the history data
    #UNIQUENAME(sMaxVersion)
    %sMaxVersion%:=MAX(%dHistory%(version<>v),version);
    // OUTPUT(%sMaxVersion%,NAMED('LastVersion'));
    
    // Get the most recent version from the history data
    #UNIQUENAME(dPreviousSample)
    // %dPreviousSample%:=PROJECT(%dHistory%(version=%sMaxVersion% AND subversion='a'),TRANSFORM(RECORDOF(%dAppended%),SELF.__i__:=COUNTER;SELF:=LEFT;));
    %dPreviousSample%:=%dHistory%(version=%sMaxVersion% AND subversion='a');
    
    // Re-Append the most recent data using the current build's keys
    #UNIQUENAME(dReAppended)
    %dReAppended%:=IF(COUNT(%dPreviousSample%)=0,DATASET([],RECORDOF(%dAppended%)),PROJECT(LinkingTools.modXLinkValidation.macAppendSample(m,%dPreviousSample%,f,g,%sMaxVersion%,s),TRANSFORM(RECORDOF(%dAppended%),SELF.subversion:='b';SELF:=LEFT;)));
    
    // Combine the two appended sets, save to disk and add to the superfile
    #UNIQUENAME(dResults)
    %dResults%:=%dAppended%+%dReAppended%;
    SEQUENTIAL(
      OUTPUT(PROJECT(%dResults%,RECORDOF(%dAppended%)),,LinkingTools.modXLinkValidation.sSuperfileName(#TEXT(m)+IF(sSuffix<>'','::'+sSuffix,''))+'::'+v),
      File.AddSuperfile(LinkingTools.modXLinkValidation.sSuperfileName(#TEXT(m)+IF(sSuffix<>'','::'+sSuffix,'')),LinkingTools.modXLinkValidation.sSuperfileName(#TEXT(m)+IF(sSuffix<>'','::'+sSuffix,''))+'::'+v)
    );

    // Put the two appends from the same sample together
    #UNIQUENAME(dCompare)
    %dCompare%:=%dPreviousSample%+%dReAppended%;
    // OUTPUT(%dCompare%,NAMED('BeforeAndAfter'));
    
    // Now produce reports based on the groupings requested by the user
    #EXPAND(REGEXREPLACE('([^,]+),',g+',','OUTPUT(LinkingTools.modXLinkValidation.macCreateReport('+#TEXT(%dCompare%)+','+%sIDField%+',__i__,$1,'+t+'),NAMED(\'GroupBy$1\'),all);\n'));
    
    LinkingTools.modXLinkValidation.macGenerateMismatchSamples(%dCompare%,%sIDField%);
  ENDMACRO;
  
 
  
  // Example: Comparing append rates from two builds of the same module:
  /*
    LinkingTools.modXLinkValidation.macCompareBuilds(
      BizLinkFull,
      ,
      'cnp_name,prim_range,prim_name,sec_range,city,st,zip,company_phone,company_fein',
      'st,source',
      '20170424',
      100000
    );  
  */
    
  macHistory(m):=FUNCTIONMACRO
  ENDMACRO;

END;