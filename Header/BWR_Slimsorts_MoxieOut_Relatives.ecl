// Sandbox file header to header_base 
import header,header_slimsort,RoxieKeybuild,doxie,relative_regression,ut;

#workunit('name','Slimsorts');
#option('skipFileFormatCrcCheck', 1);
// The variable production =  false makes Transunion_did to hit newest slimsorts. 
#stored ('production', false); 

build_slimsorts      := header_slimsort.Proc_Make_Name_xxx;
bld_Transunion_LN    := Header.transunion_did;
bld_Transunion_Ptrak := Header.build_tucs_did;

//Builds relatives Roxie 
holder1 := header.relatives.relatives1;

ut.MAC_SF_BuildProcess(holder1,'~thor_data400::BASE::Relatives',bld_relatives,2,,true);

sequential(
             build_slimsorts
            ,bld_Transunion_LN
            ,bld_Transunion_Ptrak
            ,bld_relatives
            );