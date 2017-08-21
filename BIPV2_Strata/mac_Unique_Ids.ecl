import bipv2,bipv2_build,tools;

EXPORT mac_Unique_Ids(

   pversion       = 'bipv2.KeySuffix'                           // build date
  ,pDS_Base       = 'Bipv2.CommonBase.ds_built'
  ,pEmail_List    = 'BIPV2_Build.mod_email.emailList'           // email list 
  ,pIsTesting     = 'false'
  ,pOverwrite     = 'false'

) :=
functionmacro

  ds_base           := table(pDS_Base ,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source),dotid,empid,proxid,powid,lgid3,seleid,orgid,ultid}) : independent;
  ds_source_uniques := strata.macf_Uniques(ds_base,'source');
  ds_total_uniques  := project(strata.macf_Uniques(ds_base) ,transform(recordof(ds_source_uniques),self.source := 'Totals',self := left));

  ds_all := ds_total_uniques + sort(ds_source_uniques,source) : independent;

  // -- Send the stat dataset as an attachment to David for the newsletter
  mailfile := tools.Send_Email_CSV_Attachment(
     ds_all                                           // dataset to attach to email.  please no non-printable characters or quotes, etc.  mostly this should be stats
    ,'BIPV2 Unique IDs Per Source(for newsletter) '   // Email subject.  the version will be added to this(if not blank).
    ,'Attached is the spreadsheet'                    // Email Body.  The workunit will be automatically added.
    ,'bipv2_source_counts_' + pversion + '.csv'       // Email Attachment Filename.
    ,pEmail_List                                      // List of email recipients
    ,pversion                                         // version of stats.  this is optional
  );

  return parallel(mailfile,Strata.macf_CreateXMLStats (ds_all ,'BIPV2','Commonbase'  ,pversion	,pEmail_List	,'BY_SOURCE' ,'UNIQUE_IDS'	,pIsTesting,pOverwrite));

endmacro;