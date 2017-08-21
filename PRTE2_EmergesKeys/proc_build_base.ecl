IMPORT  PromoteSupers;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

df_hunting_fishing := PROJECT(Files.CCW_hunting_fishing_IN, layouts.Hunters_Base_Layout);

df_ccw := PROJECT(Files.CCW_IN, layouts.CCW_Base_Layout);

PromoteSupers.MAC_SF_BuildProcess(df_hunting_fishing,constants.Base_Hunters, writefile_hunting_fishing);

PromoteSupers.MAC_SF_BuildProcess(df_ccw,constants.Base_CCW, writefile_ccw);

sequential(writefile_hunting_fishing,writefile_ccw);

Return 'success';
END;