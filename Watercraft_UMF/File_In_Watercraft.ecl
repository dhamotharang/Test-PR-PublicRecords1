export File_In_Watercraft
 :=
  dataset(Watercraft_UMF.Cluster + 'in::watercraft_full_from_umf_vehicle',	// sample on thor_data50: 'in::umf_vehicle_boat_engine_filing_lien_callsign_title_registration_fixed',
		  Watercraft_UMF.Layout_In_Watercraft,
		  thor,
		  unsorted
		 );