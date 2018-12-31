import Header,_control,std,InsuranceHeader,doxie, dops;

EXPORT hdr_bld_ikb(string filedate) := module

   #stored ('emailList', Header.email_list.BocaDevelopers + ',Isabel.Ma@lexisnexisrisk.com');
   string  emailList := ''  :stored('emailList');

   string  rpt_qa_email_list:='BocaRoxiePackageTeam@lexisnexis.com,Isabel.Ma@lexisnexisrisk.com';

   wk:=workunit;
   wServer:= _control.ThisEnvironment.ESP_IPAddress;
   wLink := 'http://'+wServer+':8010/?Widget=WUDetailsWidget&Wuid='+wk+'#/stub/Summary';

   CopyKeys := Header.Proc_Copy_From_Alpha_Incrementals().Refresh_copy(filedate);

   UpdateIncIdl := Header.Proc_Copy_From_Alpha_Incrementals().update_inc_idl(,filedate);
                    
   BuildiDid := sequential(
                    std.file.ClearSuperFile('~thor400_44::key::insuranceheader_xlink::inc::header'),
                    std.file.AddSuperFile('~thor400_44::key::insuranceheader_xlink::inc::header',
                                          '~thor_data400::key::insuranceheader_xlink::'+filedate+'::idl'),
                    InsuranceHeader.proc_payload_inc(filedate)
                    );

   BuildFcra := Doxie.Proc_FCRA_Doxie_keys_All(,true,filedate);
   
   BuildKeys := sequential(BuildiDid, BuildFcra);

   MovetoQA := sequential(
                    header.Proc_Copy_From_Alpha_Incrementals().movetoQA(filedate),
                    output(header.Verify_XADL1_base_files,named('Verify_XADL1_base_files_after'), all)
                    );
                    
   EXPORT all := sequential(CopyKeys, UpdateIncIdl, BuildKeys, MovetoQA)
                  : failure(std.system.Email.SendEmail(emailList,'FAILED:IKB BUILD:'+workunit,wLink));
                
END;