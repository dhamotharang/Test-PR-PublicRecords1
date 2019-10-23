import BusReg;

dba_corpCodes :=  ['AN','BL','DB','FN','TN','VL'];

pBaseFile := BusReg.Files().Base.AID.QA;
																	 				 				 				 		
export File_BUSREG_Company_in := BusReg.Split_Base(pBaseFile).Companies(corpcode in dba_corpCodes);
                                   

