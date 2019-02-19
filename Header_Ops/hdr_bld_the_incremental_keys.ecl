#WORKUNIT('name','Update Incremental linking keys');
#stored ('buildname', 'header_incremental_keys'   ); 
#stored ('emailList', 'gabriel.marcan@lexisnexisrisk.com,Debendra.Kumar@lexisnexisrisk.com,Isabel.Ma@lexisnexisrisk.com');
string  emailList  := ''  :stored('emailList');
string  rpt_qa_email_list:='BocaRoxiePackageTeam@lexisnexis.com,Isabel.Ma@lexisnexisrisk.com';
import Header,_control,std,InsuranceHeader,doxie, dops;

wk:=workunit;
wServer:= _control.ThisEnvironment.ESP_IPAddress;
wLink := 'http://'+wServer+':8010/?Widget=WUDetailsWidget&Wuid='+wk+'#/stub/Summary';

#WORKUNIT('protect',true);

hdr_prod_ver := dops.GetBuildVersion('FCRA_PersonHeaderKeys','B','F','P'); //prod boca fcra
hdr_cert_ver := dops.GetBuildVersion('FCRA_PersonHeaderKeys','B','F','C'); //cert boca fcra

hdr_thor_prod := regexfind('[0-9]{8}', std.file.superfilecontents('~thor_data400::base::header_prod')[1].name, 0);
isProd_eq_Cert_Ver := hdr_prod_ver = hdr_cert_ver and hdr_cert_ver[1..8] >= hdr_thor_prod;

icheck := sequential(
                    header.LogBuild.single('start:icheck'),
                    output(header.Verify_XADL1_base_files,named('Verify_XADL1_base_files_before'), all),
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

build_iDid := sequential(
                header.LogBuild.single('STARTED:iDid'),
                std.file.ClearSuperFile('~thor400_44::key::insuranceheader_xlink::inc::header'),
                std.file.AddSuperFile('~thor400_44::key::insuranceheader_xlink::inc::header',
                                      '~thor_data400::key::insuranceheader_xlink::'+filedate+'::idl'),
                InsuranceHeader.proc_payload_inc(filedate),
                header.LogBuild.single('COMPLETED:iDid')
                ):failure(std.system.Email.SendEmail(emailList,'FAILED:iDid:'+workunit,wLink));

build_fcra := sequential(
                header.LogBuild.single('STARTED:iFCRA'),
                Doxie.Proc_FCRA_Doxie_keys_All(,true,filedate),
                header.LogBuild.single('end:iFCRA'),
                ):failure(std.system.Email.SendEmail(emailList,'FAILED:iFCRA:'+workunit,wLink));

build_inc_key := sequential(build_iDid, if(isProd_eq_Cert_Ver, build_fcra));
// build_inc_key := build_iDid;

move_to_QA := sequential(
                header.LogBuild.single('STARTED:imovetoQA'),
                Header.Proc_Copy_From_Alpha_Incrementals().movetoQA,
                output(header.Verify_XADL1_base_files,named('Verify_XADL1_base_files_after'), all),
                header.LogBuild.single('COMPLETED:imovetoQA'),
                ):failure(std.system.Email.SendEmail(emailList,'FAILED:imovetoQA:'+workunit,wLink));

Deploy :=    sequential(
                header.LogBuild.single('STARTED:Deploy'),
                Header.Proc_Copy_From_Alpha_Incrementals().deploy(emailList,rpt_qa_email_list),                
                header.LogBuild.single('COMPLETED:iUpdate')
                ):failure(std.system.Email.SendEmail(emailList,'FAILED:Deploy:'+workunit,wLink));

// isProd_eq_Cert_Ver;
// build_fcra;

// /* STEP 1 */ icheck; // HTHOR;
// /* STEP 2 */ Refresh_copy; // HTHOR
// /* STEP 3 */ update_inc_idl; // HTHOR
// /* STEP 4 */ build_inc_key; // * THOR *
// /* STEP 4.5 */ move_to_QA; // * HTHOR *
// /* STEP 5 */ if(isProd_eq_Cert_Ver, Deploy); // HTHOR 
/* STEP 6 */ Header.Proc_Copy_Keys_To_Dataland.Incrementals; // DATALAND HTHOR

/*
20181109
1 W20181107-123929
2 W20181107-130527
3 W20181107-150552
4 W20181107-152343
4.5 W20181108-091335

20181105
1 W20181107-123929
2 W20181107-130527
3 W20181107-150552
4 W20181107-152343
4.5 W20181108-091335

20181019
1 W20181024-144243
2 W20181024-151820
3 W20181024-213917
4 W20181024-214010
4.5 W20181009-093539

20181004
1 W20181008-150141
2 W20181008-150436
3 W20181009-090704
4 W20181009-090841
4.5 W20181009-093539
W20180912-231035
W20180912-231233

20180831
W20180912-153426
W20180912-173044
W20180912-191251
W20180912-225512
W20180912-230822
W20180912-231035
W20180912-231233

20180815
W20180820-132416
W20180820-132457
W20180820-141213
W20180820-141424
W20180821-093808
W20180821-095209

20180723a
W20180727-183519
W20180727-184534
W20180727-194434
W20180727-195127
W20180727-200205
W20180727-200625

20180703
W20180710-093133
W20180710-093329
W20180710-102929
W20180710-103001-5
W20180710-104658
W20180710-105346

20180621
W20180702-113902
W20180702-113922
W20180702-130323
W20180702-130438
W20180702-134411
W20180702-134521

20180618
W20180622-100905
W20180622-101019
W20180622-132905
W20180622-133002
W20180622-135201

20180605
W20180613-112029
W20180613-114141
W20180613-124529
W20180613-142132
W20180613-143925

20180504
http://dataland_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180515-135757#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180515-134822#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180515-130147#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180515-124314#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180515-124230#/stub/Summary


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