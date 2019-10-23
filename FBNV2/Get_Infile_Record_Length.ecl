import FBNV2;

export Get_Infile_Record_Length(string source) := 
	map(
			source = 'EVENT' 		=> sizeof(FBNV2.Layout_File_FL_in.Sprayed.Event),
			source = 'FILING' 	=> sizeof(FBNV2.Layout_File_FL_in.Sprayed.Filing),
			source = 'HARRIS' 	=> sizeof(FBNV2.Layout_File_TX_Harris_in.Sprayed),
			source = 'NYC' 			=> sizeof(FBNV2.Layout_File_NYC_in),
			source = 'INFOUSA'	=> sizeof(FBNV2.Layout_File_InfoUSA_in),		
			0);
	