export Macro_Input_File_List(pSuffix, pLayout, pDataset)
 :=
  macro
    lNamePrefix	:= '~thor_200::base::official_records_';
	
	pDataset	:=	dataset(lNamePrefix + 'ca_el_dorado' 	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'ca_riverside' 	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_alachua'	  	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_baker'	  	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_brevard'	  	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_broward'	  	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_charlotte' 	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_citrus'	  	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_flagler'	  	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_hernando'	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_hillsborough'+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_indian_river'+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_lake'		+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_marion'		+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_martin'		+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_miami_dade'	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_monroe'	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_orange'		+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_polk'		+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_sarasota'	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_st_lucie'	+ pSuffix,pLayout,flat)
				+	dataset(lNamePrefix + 'fl_volusia'		+ pSuffix,pLayout,flat)
				;
  endmacro
 ;