IMPORT PRTE_CSV, PRTE2_Phonesplus_Ins;

Alpha := PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS_Prod;  
Boca1 := PRTE_CSV.Phonesplus.dthor_data400__key__phonesplus__did_ge;  
Boca2 := PRTE_CSV.Phonesplus.dthor_data400__key__phonesplus__did;  
Boca := Boca1 + Boca2;   

outrecord := record
	qstring20 Alpha_fname;
	qstring20 Alpha_mname;
	qstring20 Alpha_lname;
  string10  Alpha_cellphone;
	
	qstring20 Boca_fname;
	qstring20 Boca_mname;
	qstring20 Boca_lname;
	string10  Boca_cellphone;
END;
outrecord xGetDuplicate(PRTE_CSV.PhonesPlus.rthor_data400__key__phonesplus__did Alpha, PRTE_CSV.PhonesPlus.rthor_data400__key__phonesplus__did Boca):= transform
  SELF.Alpha_fname  := Alpha.fname;
  SELF.Alpha_mname  := Alpha.mname;
  SELF.Alpha_lname  := Alpha.lname;
  SELF.Alpha_cellphone:= Alpha.cellphone;
	
  SELF.Boca_fname   := Boca.fname;
  SELF.Boca_mname   := Boca.mname;
  SELF.Boca_lname   := Boca.lname;
  SELF.Boca_cellphone:= Boca.cellphone;
end;

// DS_Name := JOIN(Alpha(cellphone !=''), Boca(cellphone !=''),  
DS_Name := JOIN(Alpha, Boca,  
                left.cellphone = right.cellphone,							 
                xGetDuplicate(LEFT, RIGHT));

DS_Name;
