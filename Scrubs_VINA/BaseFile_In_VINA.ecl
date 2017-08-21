Import VINA, Scrubs_VINA, ut;

InDataset				:=	Vina.file_vina_base;

Scrubs_Dataset	:= Project(InDataset, TRANSFORM(Scrubs_Vina.BaseFile_Layout_Vina,self:=left));

Export BaseFile_In_VINA := Scrubs_Dataset;