IMPORT Header;
export Inputs_Sequence(boolean incremental=false, string versionBuild) := function
sequence_sources :=parallel(
                             Header.Mod_SetSources(,versionBuild).sequence_EQ
                            ,Header.Mod_SetSources(,versionBuild).sequence_L2
                            ,Header.Mod_SetSources(,versionBuild).sequence_EN
    ,if(~incremental        ,Header.Mod_SetSources(,versionBuild).sequence_TN   )
                            ,Header.Mod_SetSources(,versionBuild).sequence_DL
                            ,Header.Mod_SetSources(,versionBuild).sequence_VH
                            ,Header.Mod_SetSources(,versionBuild).sequence_BA
                            ,Header.Mod_SetSources(,versionBuild).sequence_FAT
                            ,Header.Mod_SetSources(,versionBuild).sequence_FAD
                            ,Header.Mod_SetSources(,versionBuild).sequence_DE
                            ,Header.Mod_SetSources(,versionBuild).sequence_DS
                            ,Header.Mod_SetSources(,versionBuild).sequence_EM
                            ,Header.Mod_SetSources(,versionBuild).sequence_UT
                            ,Header.Mod_SetSources(,versionBuild).sequence_AK
                            ,Header.Mod_SetSources(,versionBuild).sequence_ATF
                            ,Header.Mod_SetSources(,versionBuild).sequence_PL
                            ,Header.Mod_SetSources(,versionBuild).sequence_WC
                            ,Header.Mod_SetSources(,versionBuild).sequence_LI
                            ,Header.Mod_SetSources(,versionBuild).sequence_FR
                            ,Header.Mod_SetSources(,versionBuild).sequence_AM
                            ,Header.Mod_SetSources(,versionBuild).sequence_AC
                            ,Header.Mod_SetSources(,versionBuild).sequence_WA
                            ,Header.Mod_SetSources(,versionBuild).sequence_BO
                            ,Header.Mod_SetSources(,versionBuild).sequence_DEA
                            ,Header.Mod_SetSources(,versionBuild).sequence_WP
                            ,Header.Mod_SetSources(,versionBuild).sequence_SL
                            ,Header.Mod_SetSources(,versionBuild).sequence_S1
                            ,Header.Mod_SetSources(,versionBuild).sequence_VO
                            ,Header.Mod_SetSources(,versionBuild).sequence_CY
                            ,Header.Mod_SetSources(,versionBuild).sequence_ND
                            ,Header.Mod_SetSources(,versionBuild).sequence_EL
                            ,Header.Mod_SetSources(,versionBuild).sequence_AY
                            );
return sequence_sources;
end;