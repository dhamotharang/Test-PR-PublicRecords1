rNyCounty
 :=
  RECORD
	string20	county_name;
  end;


EXPORT file_ny_county := 
   dataset([
						{'Albany'},
						{'Allegany'},
						{'Bronx'},
						{'Broome'},
						{'Cattaraugus'},
						{'Cayuga'},
						{'Charlotte'},
						{'Chautauqua'},
						{'Chemung'},
						{'Chenango'},
						{'Clinton'},
						{'Columbia'},
						{'Cortland'},
						{'Delaware'},
						{'Dutchess'},
						{'Erie'},
						{'Essex'},
						{'Franklin'},
						{'Fulton'},
						{'Genesee'},
						{'Greene'},
						{'Hamilton'},
						{'Herkimer'},
						{'Jefferson'},
						{'Kings'},
						{'Lewis'},
						{'Livingston'},
						{'Madison'},
						{'Monroe'},
						{'Montgomery'},
						{'Nassau'},
						{'NewYorkCity'},
						{'Niagara'},
						{'Oneida'},
						{'Onondaga'},
						{'Ontario'},
						{'Orange'},
						{'Orleans'},
						{'Oswego'},
						{'Otsego'},
						{'Putnam'},
						{'Queens'},
						{'Rensselaer'},
						{'Richmond'},
						{'Rockland'},
						{'StLawrence'},
						{'Saratoga'},
						{'Schenectady'},
						{'Schoharie'},
						{'Schuyler'},
						{'Seneca'},
						{'Steuben'},
						{'Suffolk'},
						{'Sullivan'},
						{'Tioga'},
						{'Tompkins'},
						{'Tryon'},
						{'Ulster'},
						{'Unknown County'},
						{'Warren'},
						{'Washington'},
						{'Wayne'},
						{'Westchester'},
						{'Wyoming'},
						{'Yates'}
						],rNyCounty
	);
