//*************************************************************************************************************												
//** Attribute copied from Insurance for Orbit Profile setup in PR
//*************************************************************************************************************
EXPORT WriteProfileStats(DSPopulationStats               
                         ,Bld_dt
                         ,name                            
                         ,subset  
                         ,Profile_prefix          = '\'DataBuild\'' 
                         ,pProfileType            = '\'ProfilingDataBuilds\''
                         ,pBuildView              = '\'\''       
                         ,pOmit_output_to_screen  = false
                         ,pShouldExport           = false        
                         ,pShouldSendToOrbit      = true
                         //Parms needed to do the XML export of DISTRIBUTION
                         ,write_XML               = false        
                         ,pworkunitName = '\'\'' 
                         ,lfname = '\'\''   // Logical Filename, exclude version as it will be added in call
                         ,lzname = '\'\''   // Must Include file path, exclude version, extention as it will be added in call
                         ,pLZ_IP = '\'\''   // IP landingzone
                        ) := FUNCTIONMACRO
                        
import Orbit3SOA,STD,ORBIT3,_Control,wk_ut;
 Orbit3SOA.createXMLStats(DSPopulationStats          //(pStats) input dataset 
                            ,Profile_prefix          //(pBuildName) Build Name 
                            ,subset                  //(pBuildSubSet)
                            ,Bld_dt                  //(pVersionName)
                            ,local Popout            //(rOut) Output dataset
                            ,pBuildView              //(pBuildView)
                            ,name                    //(pBuildType)
                            ,pShouldExport           //(pShouldExport = 'false') 
                            ,pShouldSendToOrbit      //(pShouldSendToOrbit = 'true')
                            ,pOmit_output_to_screen  //(omit_output_to_screen = 'false')
                            ,pProfileType            //(pProfileType) = '\'ProfilingDataBuilds\'') 
                          );

  LOCAL stat_File    := lfname + Bld_dt;
  LOCAL stat_Dest    := lzname + Bld_dt + '.xml';

  LOCAL DistXML      := DATASET(ROW(TRANSFORM({STRING line},
                        SELF.line := wk_ut.get_Scalar_Result(workunit,pworkunitName))));  
                        
  LOCAL LZ_IP        := Trim(IF(pLZ_IP = '' , ((STRING)Orbit3SOA.EnvironmentVariables.statLandingZoneServer),((STRING)pLZ_IP)),all);
  LOCAL stat_OUT     := OUTPUT(DistXML,,stat_File,CSV,overwrite,expire(5),named(subset + '_' + name + '_' + pBuildView));
  LOCAL stat_DeSpray := STD.File.DeSpray(stat_File, LZ_IP, stat_Dest, -1,,,TRUE);

  #IF(write_XML)
     RETURN if(subset != '' , SEQUENTIAL(PARALLEL(Popout,stat_OUT),stat_DeSpray));
  #ELSE
     RETURN if(subset != '' , Popout);
  #END
  
  ENDMACRO;