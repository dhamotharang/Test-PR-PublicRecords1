import FBNV2;

export Get_Infile_Record_Length(string sourcetype) := 
	map(
			sourcetype = 'Event' 		=> sizeof(FBNV2.Layout_File_FL_in.Sprayed.Event),
			sourcetype = 'Filing' 	=> sizeof(FBNV2.Layout_File_FL_in.Sprayed.Filing),
			sourcetype = 'Harris' 	=> sizeof(FBNV2.Layout_File_TX_Harris_in.Sprayed),
			sourcetype = 'NYC' 			=> sizeof(FBNV2.Layout_File_NYC_in),
			sourcetype = 'InfoUSA'	=> sizeof(FBNV2.Layout_File_InfoUSA_in),		
			0);
	