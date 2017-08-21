IMPORT _control;
#WORKUNIT('name','Relative_AVB_proc_BuildData()');
recepeints  := _control.MyInfo.EmailAddressNotify

               +',Ayeesha.Kayttala@lexisnexis.com'
               +',Adam.Johnson@lexisnexis.com'
               ;
               
send_email(string msg,boolean failed=false) := fileservices.sendemail(recepeints,msg,workunit+if(failed,'\nMORE DETAILS:\n\n'+failmessage,''));

EXPORT BWR_proc_BuildData := sequential(

                              send_email('STARTED->  Relative_AVB.proc_BuildData()'),
                              Relative_AVB.proc_BuildData()
                              ):
                             success(send_email('SUCCESS  Relative_AVB.proc_BuildData()')),
                             failure(send_email('FAILED!  Relative_AVB.proc_BuildData()',true));