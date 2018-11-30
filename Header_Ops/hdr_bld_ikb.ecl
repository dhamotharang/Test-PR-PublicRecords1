﻿import Header,_control,std,InsuranceHeader,doxie, dops;

EXPORT hdr_bld_ikb(string filedate) := module

   #stored ('emailList', 'gabriel.marcan@lexisnexisrisk.com,Debendra.Kumar@lexisnexisrisk.com,Isabel.Ma@lexisnexisrisk.com');
   string  emailList := ''  :stored('emailList');

   string  rpt_qa_email_list:='BocaRoxiePackageTeam@lexisnexis.com,Isabel.Ma@lexisnexisrisk.com';

   wk:=workunit;
   wServer:= _control.ThisEnvironment.ESP_IPAddress;
   wLink := 'http://'+wServer+':8010/?Widget=WUDetailsWidget&Wuid='+wk+'#/stub/Summary';

   hdr_prod_ver := dops.GetBuildVersion('FCRA_PersonHeaderKeys','B','F','P'); //prod boca fcra
   hdr_cert_ver := dops.GetBuildVersion('FCRA_PersonHeaderKeys','B','F','C'); //cert boca fcra

   hdr_thor_prod := regexfind('[0-9]{8}', std.file.superfilecontents('~thor_data400::base::header_prod')[1].name, 0);
   isProd_eq_Cert_Ver := hdr_prod_ver = hdr_cert_ver and hdr_cert_ver[1..8] >= hdr_thor_prod;

   CopyKeys := sequential(
                    header.LogBuild.single('STARTED:iCopyKeys'),
                    Header.Proc_Copy_From_Alpha_Incrementals().Refresh_copy,
                    header.LogBuild.single('COMPLETED:iCopyKeys')
                    );

   UpdateIncIdl := sequential(
                    header.LogBuild.single('START:iIDL'),
                    Header.Proc_Copy_From_Alpha_Incrementals().update_inc_idl(),
                    header.LogBuild.single('COMPLETED:iIDL')
                    );
                    
   BuildiDid := sequential(
                    header.LogBuild.single('STARTED:iDid'),
                    std.file.ClearSuperFile('~thor400_44::key::insuranceheader_xlink::inc::header'),
                    std.file.AddSuperFile('~thor400_44::key::insuranceheader_xlink::inc::header',
                                          '~thor_data400::key::insuranceheader_xlink::'+filedate+'::idl'),
                    InsuranceHeader.proc_payload_inc(filedate),
                    header.LogBuild.single('COMPLETED:iDid')
                    );

   BuildFcra := sequential(
                    header.LogBuild.single('STARTED:iFCRA'),
                    Doxie.Proc_FCRA_Doxie_keys_All(,true,filedate),
                    header.LogBuild.single('end:iFCRA'),
                    );

   BuildKeys := sequential(BuildiDid, if(isProd_eq_Cert_Ver, BuildFcra));

   MovetoQA := sequential(
                    header.LogBuild.single('STARTED:imovetoQA'),
                    header.Proc_Copy_From_Alpha_Incrementals().movetoQA,
                    output(header.Verify_XADL1_base_files,named('Verify_XADL1_base_files_after'), all),
                    header.LogBuild.single('COMPLETED:imovetoQA'),
                    );

   Deploy := sequential(
                    header.LogBuild.single('STARTED:Deploy'),
                    header.Proc_Copy_From_Alpha_Incrementals().deploy(emailList,rpt_qa_email_list),                
                    header.LogBuild.single('COMPLETED:iUpdate')
                    );
                    
   EXPORT all := sequential(CopyKeys, UpdateIncIdl, BuildKeys, MovetoQA, Deploy)
                  : failure(std.system.Email.SendEmail(emailList,'FAILED:IKB BUILD:'+workunit,wLink));
                
END;