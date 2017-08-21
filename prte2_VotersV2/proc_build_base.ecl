IMPORT  PromoteSupers;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

df := Files.VotersV2_IN;

dfbase := PROJECT(df, transform(Layouts.Base_Layout,
          Self.phone:=if(left.phone = '0','',left.phone); 
          SELF:=Left;
          ));
					
PromoteSupers.MAC_SF_BuildProcess(dfbase,constants.Base_VotersV2, writefile);

return writefile;

END;