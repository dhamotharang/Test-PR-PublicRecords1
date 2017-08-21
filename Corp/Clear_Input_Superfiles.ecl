import ebr;
//export Clear_Input_Superfiles := apply(corp.Filenames().input_superfiles, EBR.Clear_Input_Superfile(trim(superfile)));
export Clear_Input_Superfiles := sequential(
	EBR.Clear_Input_Superfile(corp.Filenames().CorpUpdate),
	EBR.Clear_Input_Superfile(corp.Filenames().ContUpdate),
	EBR.Clear_Input_Superfile(corp.Filenames().EventUpdate),
	EBR.Clear_Input_Superfile(corp.Filenames().SuppUpdate)
);