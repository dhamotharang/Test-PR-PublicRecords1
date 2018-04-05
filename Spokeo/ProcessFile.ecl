EXPORT ProcessFile(DATASET(Spokeo.Layout_Out) src, boolean skipRelink = false) := FUNCTION

		prepped := Spokeo.proc_PrepOutput(src) : INDEPENDENT;
		clnaddr := Spokeo.proc_CleanAddresses(prepped) : INDEPENDENT;	
		clnNames := Spokeo.proc_CleanNames(clnaddr);	
		linked := IF(skipRelink, clnNames, Spokeo.proc_Link(clnNames));
		verified := Spokeo.proc_verifyAddr(linked);
		better := Spokeo.proc_GetBetterAddress(verified);
		current := Spokeo.proc_flagCurrentRecords(better);
		imputed := Spokeo.proc_imputeCurrentRecords(current);
		defunct := Spokeo.proc_getDeceased(imputed);
		bestaddr := Spokeo.proc_IsBestAddressAvailable(defunct);
		bestname := Spokeo.proc_GetBestName(bestaddr);
		result := Spokeo.proc_GetFlags(bestname);

		return result;
END;