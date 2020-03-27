IMPORT VotersV2;

EXPORT File_MA_Census_Base := DATASET(VotersV2.Cluster + 'base::MA_Census', VotersV2.Layouts_Voters.Layout_Voters_Base_new, THOR);