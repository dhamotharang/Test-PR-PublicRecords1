﻿#WORKUNIT('name','Update Incremental linking keys');
#stored ('buildname', 'header_incremental_keys'   ); 
#stored ('emailList', 'gabriel.marcan@lexisnexisrisk.com'/*;Debendra.Kumar@lexisnexisrisk.com'*/);
string  emailList  := ''  :stored('emailList');
import Header,_control;

wk:=workunit;
wServer:= _control.ThisEnvironment.ESP_IPAddress;
wLink := 'http://'+wServer+':8010/?Widget=WUDetailsWidget&Wuid='+wk+'#/stub/Summary';

icheck := sequential(
                    header.LogBuild.single('start:icheck'),
                    output(header.Verify_XADL1_base_files,named('Verify_XADL1_base_files_before')),
                    Header.Proc_Copy_From_Alpha_Incrementals(TRUE).update_inc_superfiles(),
                    Header.Proc_Copy_From_Alpha_Incrementals(TRUE).update_inc_idl(),
                    header.LogBuild.single('COMPLETED:icheck')
                    ):failure(std.system.Email.SendEmail(emailList,'FAILED:icheck:'+workunit,wLink));

Refresh_copy:= sequential(
                    header.LogBuild.single('STARTED:iCopy'),
                    Header.Proc_Copy_From_Alpha_Incrementals().Refresh_copy,
                    header.LogBuild.single('COMPLETED:iCopy')
                    ):failure(std.system.Email.SendEmail(emailList,'FAILED:iCopy:'+workunit,wLink));

update_inc_idl := sequential(
                    header.LogBuild.single('START:iIDL'),
                    Header.Proc_Copy_From_Alpha_Incrementals().update_inc_idl(),
                    header.LogBuild.single('COMPLETED:iIDL')
                    ):failure(std.system.Email.SendEmail(emailList,'FAILED:iIDL:'+workunit,wLink));

filedate:=Header.Proc_Copy_From_Alpha_Incrementals().filedate;

build_inc_key:= sequential(
                header.LogBuild.single('STARTED:iDid'),
                std.file.ClearSuperFile('~thor400_44::key::insuranceheader_xlink::inc::header'),
                std.file.AddSuperFile('~thor400_44::key::insuranceheader_xlink::inc::header',
                                      '~thor_data400::key::insuranceheader_xlink::'+filedate+'::idl'),
                InsuranceHeader.proc_payload_inc(filedate),
                header.LogBuild.single('COMPLETED:iDid')
                ):failure(std.system.Email.SendEmail(emailList,'FAILED:iDid:'+workunit,wLink));

update_all:=    sequential(
                header.LogBuild.single('STARTED:iUpdate'),
                Header.Proc_Copy_From_Alpha_Incrementals().deploy,
                output(header.Verify_XADL1_base_files,named('Verify_XADL1_base_files_after')),
                header.LogBuild.single('COMPLETED:iUpdate')
                ):failure(std.system.Email.SendEmail(emailList,'FAILED:iDid:'+workunit,''));


// /* STEP 1 */ icheck; // HTHOR;
// /* STEP 2 */ Refresh_copy; // HTHOR
// /* STEP 3 */ update_inc_idl; // HTHOR
// /* STEP 4 */ build_inc_key; // * THOR *
// /* STEP 5 */ update_all; // HTHOR 
/* STEP 6 */ Header.Proc_Copy_Keys_To_Dataland.Incrementals; // DATALAND HTHOR

/*

20180502
http://dataland_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180504-090857#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180504-085643#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180504-085259#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180504-085108#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180504-083358#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180503-182425#/stub/Files-DL/Grid

20180420

http://dataland_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180427-124838#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180427-124259#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180427-115526#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180427-115451#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180427-101612#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180427-101536#/stub/Summary

20180411

http://prod_esp.br.seisint.com:8010/?Wuid=W20180416-122107&Widget=WUDetailsWidget#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Wuid=W20180416-122038&Widget=WUDetailsWidget#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Wuid=W20180416-113646&Widget=WUDetailsWidget#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180416-113416#/stub/Summary

20180402
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180409-213113#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180409-211834#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180409-211722#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180409-205125#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180409-205005#/stub/Summary


http://prod_esp.br.seisint.com:8010/?Wuid=W20180405-105512&Widget=WUDetailsWidget#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180405-104649#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180405-104601#/stub/Summary
W20180405-072617
W20180405-071126

*/