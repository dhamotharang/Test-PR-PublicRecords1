IMPORT VotersV2;

EXPORT File_MA_Census_History := DATASET(VotersV2.Cluster + 'base::MA_Census::History', VotersV2.Layout_Voters_VoteHistory, THOR);