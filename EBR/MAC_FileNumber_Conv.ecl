export MAC_FileNumber_Conv(infile, inlayout, _filetoken, pVersion, _code) := macro
#uniquename(_Operational_Dataset)
#uniquename(Operational_Dataset)
%_Operational_Dataset% := infile;
%Operational_Dataset% := %_Operational_Dataset%;

#uniquename(conv_file_num)
//Create "Audit" Data

ebr.MAC_Convert_File_Number(%Operational_Dataset%,%conv_file_num%); 

#uniquename(conv_res)
%conv_res%:= %conv_file_num%;

#uniquename(_sf_root)
#uniquename(_lf_root)
STRING %_sf_root% := '~thor_data400::in::ebr_'+_filetoken; 
STRING %_lf_root% := %_sf_root% + pVersion; 

#uniquename(_sf_current)
STRING %_sf_current% := %_sf_root%;

_code :=
SEQUENTIAL( output(%conv_res%,,%_lf_root%,OVERWRITE),
           // FileServices.ClearSuperFile(%_sf_root%),
            FileServices.AddSuperFile(%_sf_root%,%_lf_root%)
            //Create "Projected Back" audit data
            
           );
endmacro;