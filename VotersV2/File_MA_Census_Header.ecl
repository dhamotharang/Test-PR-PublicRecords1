IMPORT VotersV2;

EXPORT File_MA_Census_Header := DATASET(VotersV2.Cluster + 'base::Census_Header_Building', VotersV2.Layouts_Voters.Layout_Voters_Base_new, THOR);