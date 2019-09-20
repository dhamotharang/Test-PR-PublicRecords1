import Header_SlimSort,header,address_file,utilfile,lib_fileservices,misc,Text_FragV1,doxie_build,Watchdog,nid,PersonLinkingADL2V3,Promotesupers;

#option('skipFileFormatCrcCheck', 1);
#option ('filteredReadSpillThreshold', 9999) ;
// The variable production =  false makes Transunion_did to hit newest slimsorts. bug# 40562
#stored ('production', false);

string filedate := header.version_build;

add_super := if(fileservices.getsuperfilesubcount('~thor_data400::Base::HeaderKey_Building')>0
             ,output('Nothing added to base::headerkey_building.')
             ,fileservices.addsuperfile('~thor_data400::Base::HeaderKey_Building','~thor_data400::Base::Header',,true));

export proc_doxie_keys_all(boolean pFastHeader=false, string emailListBuilders) := function
 clr_super := fileservices.clearsuperfile('~thor_data400::Base::HeaderKey_Building');
 chk_build := output('Checking Base::HeaderKey_Building...') : success(add_super);
 g := Watchdog.DID_Gong;
 fhb := doxie_build.Proc_file_header_building;
 i := doxie.proc_Header_keys_dx(filedate,pFastHeader);
 v := doxie.proc_relatives_keys(filedate);
 w := doxie.proc_troy_keys(filedate);
 s := Header_SlimSort.Proc_BuildKeys(filedate);
 r := doxie.proc_create_header_relationships(filedate);
 n := header.Out_Base_Dev_Stats_Header_Relatives(filedate, emailListBuilders).hdr_reports; //Strata
 o := address_file.proc_build(filedate);
 wa_phone := Header.proc_build_header_wa ; 
 
 return sequential(clr_super,chk_build,g,fhb,i,v,w,s,r,n,o,Promotesupers.SF_MaintBuilt('~thor_data400::Base::HeaderKey'),wa_phone);
end;