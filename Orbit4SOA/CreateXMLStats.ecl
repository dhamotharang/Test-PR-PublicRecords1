//*************************************************************************************************************												
//** Attribute copied from Insurance for Orbit Profile setup in PR
//*************************************************************************************************************
EXPORT createXMLStats(pStats
                      ,pBuildName
                      ,pBuildSubSet
                      ,pVersionName
                      ,rOut
                      ,pBuildView = '\'\''
                      ,pBuildType = '\'\''
                      ,pShouldExport = 'false'
                      ,pShouldSendToOrbit = 'true'
                      ,omit_output_to_screen = 'false'
                      ,pProfileType = '\'ProfilingDataBuilds\'') := macro

import Orbit4SOA;

#uniquename(buildSubSet)
#uniquename(rout1)
#uniquename(rout2)
#uniquename(buildType)
#uniquename(buildView)
#uniquename(versionname)
#uniquename(clean)
#uniquename(buildname)
#uniquename(profilename)

string %clean%(string s) := stringlib.stringfindreplace(
                            stringlib.stringfindreplace(
                                                        stringlib.stringfindreplace(
                                                        stringlib.stringfilterout(s, ' ')
                                                        ,'&','_')
                                                        ,'-','_')
                                                        , ':','_');
%buildname%   := %clean%(pBuildName);
%buildSubSet% := %clean%(if(pBuildSubSet = '', 'data'   , pBuildSubSet));
%buildType%   := %clean%(if(pBuildType = ''  , 'type'   , Trim(pBuildType)));
%buildView%   := %clean%(if(pBuildView = ''  , 'view'   , Trim(pBuildView)));
%versionname% := %clean%(if(pVersionName = '', 'version', Trim(pVersionName)));

%profilename% := trim(%buildname%,all) + '_' + %buildSubSet% + '_' + %buildType% + '_' + %buildView%;

%rout1% := if(~omit_output_to_screen, output(choosen(pStats,all),named(%buildView% + '_' + %buildType% + '_Route2')));
%rout2% := Orbit4SOA.SubmitStat(pStats, %profilename%, pProfileType, %versionname%, %profilename%);

#IF(pShouldExport = TRUE)
EXPORT
#END

rOut := #IF(pShouldSendToOrbit = TRUE)
            parallel(%rout1%,%rout2%);
        #ELSE
            parallel(%rout1%);    //to test stats without sending to strata
        #END;

endmacro;