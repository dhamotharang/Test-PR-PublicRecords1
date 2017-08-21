export MAC_Run_FileNumber_Conv(infile, inlayout, _filetoken, pVersion, _code) := macro
#uniquename(_Operational_Dataset)
#uniquename(Operational_Dataset)
%_Operational_Dataset% := infile;
%Operational_Dataset% := %_Operational_Dataset%;//CHOOSEN(%_Operational_Dataset%,20000);

#uniquename(conv_file_num)
//Create "Audit" Data

ebr.MAC_Convert_File_Number(%Operational_Dataset%,%conv_file_num%); 

#uniquename(conv_res)
%conv_res%:= %conv_file_num%;

#uniquename(_sf_root)
#uniquename(_lf_root)
STRING %_sf_root% := '~thor_data400::base::ebr_'+_filetoken; 
STRING %_lf_root% := %_sf_root% + pVersion; 
//current
#uniquename(_sf_current)
STRING %_sf_current% := %_sf_root%;
//audit
#uniquename(_sf_audit)
#uniquename(_lf_audit)
STRING %_sf_audit% := %_sf_root% + '_audit';
STRING %_lf_audit% := %_lf_root% + '_audit';
//archive
#uniquename(_sf_archive)
STRING %_sf_archive% := %_sf_root% + '_archive';
//projected back audit file
#uniquename(_lf_audit_projback)
STRING %_lf_audit_projback% := %_lf_root% + '_audit_prjback';

_code := 
SEQUENTIAL( output(%conv_res%,,%_lf_audit%,OVERWRITE),
            FileServices.AddSuperFile(%_sf_audit%,%_lf_audit%),
            //Create "Projected Back" audit data
            output(PROJECT(%conv_res%,TRANSFORM(inlayout,SELF := LEFT)),,%_lf_audit_projback%,OVERWRITE),
            //Archive current superfile contents and write projected back files instead
            FileServices.SwapSuperFile(%_sf_current%,%_sf_archive%),
            FileServices.AddSuperFile(%_sf_current%, %_lf_audit_projback%)
           );
endmacro;