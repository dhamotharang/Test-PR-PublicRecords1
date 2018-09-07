import hygenics_soff, doxie_build;

export Proc_Build_SO_Search(string filedate) := function

dofirst 	:= proc_build_SO_Search_Base;
dosecond 	:= proc_build_So_Search_Keys(filedate);
dosecond2 	:= Hygenics_SOff.Proc_Build_Autokey(filedate);
dothird 	:= doxie_build.proc_acceptSK_SO_ToQA;
dofourth 	:= fileservices.sendemail('jtao@seisint.com'
                                  ,'SEX OFFENDER BUILD SUCCESS ' + filedate,
							'keys: 1) thor_data400::key::sexoffender::spkpublic_qa (thor_data400::key::sexoffender::'+filedate+'::spkpublic)'           + '\n' +
							'      2) thor_data400::key::sexoffender::offenses_public_qa (thor_data400::key::sexoffender::'+filedate+'::offenses_public)'     + '\n' +
							'      3) thor_data400::key::sexoffender::didpublic_qa (thor_data400::key::sexoffender::'+filedate+'::didpublic)'           + '\n' +
							'      4) thor_data400::key::sexoffender::fdid_public_qa (thor_data400::key::sexoffender::'+filedate+'::fdid_public)'          + '\n' +
							'      5) thor_data400::key::sexoffender::publicaddress_qa (thor_data400::key::sexoffender::'+filedate+'::publicaddress)'        + '\n' +
							'      6) thor_data400::key::sexoffender::publiccitystname_qa (thor_data400::key::sexoffender::'+filedate+'::publiccitystname)'     + '\n' +
							'      7) thor_data400::key::sexoffender::publicname_qa (thor_data400::key::sexoffender::'+filedate+'::publicname)'           + '\n' +
							'      8) thor_data400::key::sexoffender::publicphone_qa (thor_data400::key::sexoffender::'+filedate+'::publicphone)'          + '\n' +
							'      9) thor_data400::key::sexoffender::publicssn_qa (thor_data400::key::sexoffender::'+filedate+'::publicssn)'            + '\n' +
							'     10) thor_data400::key::sexoffender::publicstname_qa (thor_data400::key::sexoffender::'+filedate+'::publicstname)'         + '\n' +
							'     11) thor_data400::key::sexoffender::publiczip_qa (thor_data400::key::sexoffender::'+filedate+'::publiczip)'            + '\n' +
							'     12) thor_data400::key::sexoffender::enhpublic_qa (thor_data400::key::sexoffender::'+filedate+'::enhpublic)'            + '\n' +
							'     13) thor_data400::key::sexoffender::enhpublicaddress_qa (thor_data400::key::sexoffender::'+filedate+'::enhpublicaddress)'     + '\n' +
							'     14) thor_data400::key::sexoffender::enhpublicname_qa (thor_data400::key::sexoffender::'+filedate+'::enhpublicname)'        + '\n' +
							'     16) thor_data400::key::sexoffender::enhpublicphone_qa (thor_data400::key::sexoffender::'+filedate+'::enhpublicphone)'       + '\n' +
							'     17) thor_data400::key::sexoffender::enhpublicssn_qa (thor_data400::key::sexoffender::'+filedate+'::enhpublicssn)'         + '\n' +
							'     18) thor_data400::key::sexoffender::enhpublicstname_qa (thor_data400::key::sexoffender::'+filedate+'::enhpublicstname)'      + '\n' +
							'     19) thor_data400::key::sexoffender::enhpubliczip_qa (thor_data400::key::sexoffender::'+filedate+'::enhpubliczip)'         + '\n' +
							'     20) thor_data400::key::sexoffender::autokey::address_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::address)'         + '\n' +
							'     21) thor_data400::key::sexoffender::autokey::citystname_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::citystname)'         + '\n' +
							'     22) thor_data400::key::sexoffender::autokey::name_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::name)'         + '\n' +
							'     23) thor_data400::key::sexoffender::autokey::payload_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::payload)'         + '\n' +
							'     24) thor_data400::key::sexoffender::autokey::ssn2_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::ssn2)'         + '\n' +
							'     25) thor_data400::key::sexoffender::autokey::stname_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::stname)'         + '\n' +
							'     26) thor_data400::key::sexoffender::autokey::zip_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::zip)'         + '\n' +
							'         have been built and ready to be deployed to QA.' + '\n');

return sequential(dofirst, dosecond, dosecond2, dothird, dofourth);
// Removed the steps that completed successfully in the previous run -- This is for sandboxing only
//return sequential(dosecond, dothird, dofourth);

end;