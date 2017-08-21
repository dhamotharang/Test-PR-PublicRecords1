import ut, ArrestLogs;
export File_In_Arrest_Offender
 := dataset('~thor_data400::in::arrest_log_offender_clean_' + Version_In_Arrest_Offender,Layout_In_Arrest_Offender,flat)
  + ArrestLogs.map_AL_CalhounOffender
  + ArrestLogs.map_AL_JeffersonOffender
	+ ArrestLogs.map_AR_BentonOffender
  + ArrestLogs.map_AZ_MaricopaOffender
  + ArrestLogs.map_CA_FresnoOffender
  + ArrestLogs.map_CA_KingsOffender
  + ArrestLogs.map_CA_LosAngelesOffender
  + ArrestLogs.map_CA_MarinOffender
  + ArrestLogs.Map_CA_OrangeOffender
  + ArrestLogs.map_CA_PlacerOffender
  + ArrestLogs.Map_CA_RiversideOffender
  + ArrestLogs.map_CA_SanBernardinoOffender
  + ArrestLogs.map_CA_TehamaOffender
  + ArrestLogs.map_CO_PitkinOffender
  + ArrestLogs.map_CO_WeldOffender
  + ArrestLogs.map_FL_Broward_Offender
  + ArrestLogs.map_FL_LakeOffender
  + ArrestLogs.map_FL_MartinOffender
  + ArrestLogs.map_FL_PalmBeachOffender
  + ArrestLogs.map_GA_BibbOffender
  + ArrestLogs.map_GA_DawsonOffender
  + ArrestLogs.map_GA_GwinnettOffender
  + ArrestLogs.map_ID_AdaOffender
  + ArrestLogs.map_ID_CanyonOffender
  + ArrestLogs.map_LA_lafayetteOffender
  + ArrestLogs.map_NM_BernalilloOffender
  + ArrestLogs.map_OK_CarterOffender
  + ArrestLogs.map_OR_YamhillOffender  
  + ArrestLogs.map_OR_linnOffender
  + ArrestLogs.map_OR_ClackamasOffender
  + ArrestLogs.map_OR_MultnomahOffender
  + ArrestLogs.map_TN_ShelbyOffender
  + ArrestLogs.map_TX_BrazoriaOffender
  + ArrestLogs.map_TX_CameronOffender
  + ArrestLogs.map_TX_DentonOffender
  + ArrestLogs.map_TX_MontgomeryOffender
  + ArrestLogs.map_WA_clarkOffender
  + ArrestLogs.map_WA_kitsapOffender
  + ArrestLogs.map_WA_pierceOffender
  + ArrestLogs.map_WA_ThurstonOffender
  + ArrestLogs.map_WV_RegionalOffender
   ; 



  