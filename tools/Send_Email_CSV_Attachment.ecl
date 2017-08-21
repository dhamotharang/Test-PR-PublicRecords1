import _control,std;
EXPORT Send_Email_CSV_Attachment(

   pDS                                                      // dataset to attach to email.  please no non-printable characters or quotes, etc.  mostly this should be stats
  ,pEmail_Subject                                           // Email subject.  the version will be added to this(if not blank).
  ,pEmail_Body                                              // Email Body.  The workunit will be automatically added.
  ,pAttach_Filename                                         // Email Attachment Filename.
  ,pEmail_List      = '_control.MyInfo.EmailAddressNotify'  // List of email recipients
  ,pversion         = '\'\''                                // version of stats.  this is optional
  ,pEmail_Sender    = '\'eclsystem@seisint.com\''           // Email address of the sender.  Optional.  if blank, the email will be sent by eclsystem@seisint.com
) :=
functionmacro

  import std;
  
  tools.mac_ConvertToCsv(pDS  ,ds_csv ,pShouldExport := false);

  ds_rollup := rollup(ds_csv  ,true ,transform(recordof(left),self.payload := trim(left.payload) + '\n' + trim(right.payload)));

  file_csv := ds_rollup[1].payload;

  mailfile := std.system.email.SendEmailAttachData(
     pEmail_List
    ,pEmail_Subject + pversion //subject
    ,pEmail_Body + '\n\n' + tools.fun_GetWUBrowserString() //body
    ,(data)file_csv
    ,'text/csv'
    ,pAttach_Filename
    ,
    ,
    ,pEmail_Sender
  );	
  
  return parallel(
     mailfile
    ,STD.System.Log.addWorkunitInformation ('Sent email \'' + pEmail_Subject + pversion + '\' with attachment(' + pAttach_Filename + ') on ' + ut.GetTimeDate())

  );
  
endmacro;