import Header,_control,std,InsuranceHeader,doxie, dops;

EXPORT hdr_bld_ikb(string filedate, unsigned1 status) := module

   #stored ('emailList', Header.email_list.BocaDevelopers + ',Isabel.Ma@lexisnexisrisk.com');
   string  emailList := ''  :stored('emailList');

   string  rpt_qa_email_list:='BocaRoxiePackageTeam@lexisnexis.com,Isabel.Ma@lexisnexisrisk.com';
   
   sf_name := '~thor_data400::out::header_ikb_status';

   wk:=workunit;
   wServer:= _control.ThisEnvironment.ESP_IPAddress;
   wLink := 'http://'+wServer+':8010/?Widget=WUDetailsWidget&Wuid='+wk+'#/stub/Summary';

   CopyKeys := Header.Proc_Copy_From_Alpha_Incrementals().Refresh_copy(filedate);

   UpdateIncIdl := Header.Proc_Copy_From_Alpha_Incrementals().update_inc_idl(,filedate);
                    
   BuildiDid := sequential(
                    nothor(std.file.ClearSuperFile('~thor400_44::key::insuranceheader_xlink::inc::header')),
                    nothor(std.file.AddSuperFile('~thor400_44::key::insuranceheader_xlink::inc::header',
                                          '~thor_data400::key::insuranceheader_xlink::'+filedate+'::idl')),
                    InsuranceHeader.proc_payload_inc(filedate)
                    );

   BuildFcra := Doxie.Proc_FCRA_Doxie_keys_All(,true,filedate);
   
   BuildKeys := sequential(BuildiDid, BuildFcra);

   MovetoQA := sequential(
                    header.Proc_Copy_From_Alpha_Incrementals().movetoQA(filedate),
                    output(header.Verify_XADL1_base_files,named('Verify_XADL1_base_files_after'), all)
                    );
                    
   EXPORT all := sequential(
                     if(status = 0,
                        sequential(
                          Header.LogBuildStatus(sf_name, filedate, 1).Write // 1 -> IKB started
                        )
                     )
                     ,if(status < 2,
                        sequential(
                          CopyKeys,
                          Header.LogBuildStatus(sf_name, filedate, 2).Write // 2 ->  CopyKeys completed
                        )
                     )
                     ,if(status < 3,
                        sequential(
                          UpdateIncIdl,
                          Header.LogBuildStatus(sf_name, filedate, 3).Write, // 3 -> UpdateIncIdl Completed
                        )
                     )
                     ,if(status < 4,
                        sequential(
                          BuildKeys,
                          Header.LogBuildStatus(sf_name, filedate, 4).Write, // 3 -> BuildKeys Completed
                        )
                     )
                     ,if(status < 5,
                        sequential(
                          MovetoQA,
                          Header.LogBuildStatus(sf_name, filedate, 0).Write, // 0 -> IKB Completed
                        )
                     )
                   ): failure(std.system.Email.SendEmail(emailList,'FAILED:IKB BUILD:'+workunit,wLink));                               
                               
                
END;