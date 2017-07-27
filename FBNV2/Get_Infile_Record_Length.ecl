import FBNV2;

export Get_Infile_Record_Length(string sourcetype) := 
	map(
	    sourcetype = 'Orange' 		=> sizeof(FBNV2.Layout_File_CA_Orange_in),
	    sourcetype = 'San_diego' 	=> sizeof(FBNV2.Layout_File_CA_San_Diego_in),
		sourcetype = 'Santa_Clara' 	=> sizeof(FBNV2.Layout_File_CA_Santa_Clara_in),
		sourcetype = 'Event' 		=> sizeof(FBNV2.Layout_File_FL_in.Event),
		sourcetype = 'Filing' 		=> sizeof(FBNV2.Layout_File_FL_in.Filing),
		sourcetype = 'Harris' 		=> sizeof(FBNV2.Layout_File_TX_Harris_in),
	    sourcetype = 'NYC' 			=> sizeof(FBNV2.Layout_File_NYC_in),
		sourcetype = 'InfoUSA'		=> sizeof(FBNV2.Layout_File_InfoUSA_in),
		
		 0);
	