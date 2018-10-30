import Header_SlimSort,header,address_file,utilfile,lib_fileservices,misc,Text_FragV1,doxie_build,Watchdog,nid,PersonLinkingADL2V3,Promotesupers;

#option('skipFileFormatCrcCheck', 1);
#option ('filteredReadSpillThreshold', 9999) ;
// The variable production =  false makes Transunion_did to hit newest slimsorts. bug# 40562
#stored ('production', false);

fcra_add_super(string typ) := if(fileservices.getsuperfilesubcount('~thor_data400::Base::FCRA_HeaderKey_Building')>0
             ,output('Nothing added to base::FCRA_HeaderKey_building.')
             ,fileservices.addsuperfile('~thor_data400::Base::FCRA_HeaderKey_Building','~thor_data400::Base::FCRA_Header'+typ,,true));
fcra_clr_super := fileservices.clearsuperfile('~thor_data400::Base::FCRA_HeaderKey_Building');
fcra_chk_build(string typ) := output('Checking Base::FCRA_HeaderKey_Building...') : success(fcra_add_super(typ));
export Proc_FCRA_Doxie_keys_All(boolean pFastHeader=false, boolean inc = false, string filedate) := function
 
 fcra_fhb(boolean inc) := doxie_build.Proc_file_FCRA_header_building(filedate,inc);
fcra_keys := doxie.proc_fcra_header_keys(filedate);
 fcra_mv2QA := header.Proc_FCRAacceptSK_toQA(filedate);

 return sequential(
									if(~inc,Header.Proc_re_did_FCRA_EN) // only run in monthly
                                    ,header.build_FCRA_header(filedate,inc)
									,fcra_clr_super
									,fcra_chk_build(if(inc,'_inc',''))
									,fcra_fhb(inc)
									,fcra_keys
									,fcra_mv2QA
									,Promotesupers.SF_MaintBuilt('~thor_data400::Base::FCRA_HeaderKey')
									);
end;