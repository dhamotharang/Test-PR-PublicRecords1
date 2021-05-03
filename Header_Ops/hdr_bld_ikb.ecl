import Header,_control,std,InsuranceHeader,doxie, dops,RoxieKeyBuild,dx_header;

EXPORT hdr_bld_ikb(string filedate, unsigned1 status) := module

   #OPTION ('multiplePersistInstances',FALSE);
   #stored ('emailList', Header.email_list.BocaDevelopers + ',Isabel.Ma@lexisnexisrisk.com');
   string  emailList := '' : stored('emailList');

   string  rpt_qa_email_list:='BocaRoxiePackageTeam@lexisnexis.com,Isabel.Ma@lexisnexisrisk.com';   

   wk:=workunit;
   wServer:= _control.ThisEnvironment.ESP_IPAddress;
   wLink := 'http://'+wServer+':8010/?Widget=WUDetailsWidget&Wuid='+wk+'#/stub/Summary';

   CopyKeys := ORDERED(
                       Header.Proc_Copy_From_Alpha_Incrementals().Refresh_copy(filedate);
                       Header.Proc_Copy_From_Alpha_Incrementals().copy_insurance_best;
                       );

   UpdateIncIdl := Header.Proc_Copy_From_Alpha_Incrementals().update_inc_idl(,filedate);

   RoxieKeyBuild.MAC_build_logical ( dx_header.key_first_ingest(),  header.data_key_first_ingest(filedate), 
                dx_Header.names('').i_first_ingest, dx_Header.names(filedate).i_first_ingest, build_first_ingest);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_Header.names('@version@').i_first_ingest,
                                         dx_Header.names(filedate).i_first_ingest, mv_first_ingest_BUILT);
   RoxieKeyBuild.Mac_SK_Move_V2(         dx_Header.names('@version@').i_first_ingest, 'Q', mv_first_ingest_QA,2);

   newFirstIngestNotInQA:=~regexfind(filedate,nothor(std.file.SuperFileContents(dx_Header.names('QA').i_first_ingest))[1].name);

   BuildiDid := sequential(
                    STD.File.StartSuperFileTransaction(),
                    nothor(std.file.ClearSuperFile('~thor400_44::key::insuranceheader_xlink::inc::header')),
                    nothor(std.file.AddSuperFile('~thor400_44::key::insuranceheader_xlink::inc::header',
                                          '~thor_data400::key::insuranceheader_xlink::'+filedate+'::idl')),
                    STD.File.FinishSuperFileTransaction(),
                    InsuranceHeader.proc_payload_inc(filedate)                    
                    );

   BuildFirstIngest := if(newFirstIngestNotInQA
                        ,sequential(
                            build_first_ingest,
                            mv_first_ingest_BUILT,
                            mv_first_ingest_QA));                  

   BuildFcra := Doxie.Proc_FCRA_Doxie_keys_All(,true,filedate);
   
   MovetoQA := sequential(
                  header.Proc_Copy_From_Alpha_Incrementals().movetoQA(filedate),
                  output(header.Verify_XADL1_base_files,named('Verify_XADL1_base_files_after'), all)
                  );

   step1 := CopyKeys;
   step2 := UpdateIncIdl;
   step3 := BuildiDid;
   step4 := BuildFirstIngest;
   step5 := BuildFcra;
   step6 := MovetoQA;

   sf_name := '~thor_data400::out::header_ikb_status';
   update_status(unsigned2 new_status) := Header.LogBuildStatus(sf_name,filedate,new_status).Write;

   EXPORT all := sequential(
      if(status<1,sequential(step1,update_status(1))),
      if(status<2,sequential(step2,update_status(2))),
      if(status<3,sequential(step3,update_status(3))),
      if(status<4,sequential(step4,update_status(4))),
      if(status<5,sequential(step5,update_status(5))),
      if(status<6,sequential(step6,update_status(6))),
//In order to keep consistency across all builds and 
//reserving status to add future steps, the end status is set as 9
      if(status<9,update_status(9))                
      ): failure(std.system.Email.SendEmail(emailList,'FAILED:IKB BUILD:'+workunit,wLink));
                
END;