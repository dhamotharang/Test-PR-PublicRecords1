import FBNV2;

export Get_Infile_Record_Length(string sourcetype) := 
	map(
			//sourcetype = 'Orange' 		=> sizeof(FBNV2.Layout_File_CA_Orange_in.Sprayed),
			//sourcetype = 'Ventura' 		=> sizeof(FBNV2.Layout_File_CA_Ventura_in.Sprayed),	    
			sourcetype = 'San_Diego' 	=> sizeof(FBNV2.Layout_File_CA_San_Diego_in.Sprayed),
			//sourcetype = 'Santa_Clara' 	=> sizeof(FBNV2.Layout_File_CA_Santa_Clara_in.Sprayed),
			sourcetype = 'Event' 		=> sizeof(FBNV2.Layout_File_FL_in.Sprayed.Event),
			sourcetype = 'Filing' 		=> sizeof(FBNV2.Layout_File_FL_in.Sprayed.Filing),
			sourcetype = 'Harris' 		=> sizeof(FBNV2.Layout_File_TX_Harris_in.Sprayed),
			sourcetype = 'NYC' 			=> sizeof(FBNV2.Layout_File_NYC_in),
			sourcetype = 'InfoUSA'		=> sizeof(FBNV2.Layout_File_InfoUSA_in),		
			0);
	