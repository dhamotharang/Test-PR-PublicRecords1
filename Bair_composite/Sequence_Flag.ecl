Import Bair_composite, ut;
EXPORT Sequence_Flag := MODULE

	EXPORT fn_GetSequenceFlag(boolean pUseDelta = false)	:= FUNCTION
		Seq:= dataset('~thor_data400::out::bair_Sequence_flag',layouts.Bair_Sequence_Flag,thor,opt);
		return if(pUseDelta,seq[1].Sequence,0);							
	END;

	EXPORT fn_SetSequenceFlag(string pVersion,boolean pUseDelta = false)	:= FUNCTION
		Seq:= dataset('~thor_data400::out::bair_Sequence_flag',layouts.Bair_Sequence_Flag,thor,opt);
		New_seq:= If(pUseDelta, seq[1].Sequence +1,1);
		fileinput := dataset([{New_seq}],layouts.Bair_Sequence_Flag);
		ut.MAC_SF_BuildProcess(fileinput,'~thor_data400::out::bair_Sequence_flag', FlagFile ,2,,true,pVersion);	
		return FlagFile;
	END;

END;

