EXPORT ProcessFile(DATASET(Spokeo.Layout_in) src) := FUNCTION

		prepped := Spokeo.proc_PrepInput(src);
		clnaddr := Spokeo.proc_CleanAddresses(prepped);	
		clnNames := Spokeo.proc_CleanNames(clnaddr);	
		linked := Spokeo.proc_Link(clnNames) : PERSIST('~thor::spokeo::persist::linked');
		verified := Spokeo.proc_verifyAddr(linked);
		better := Spokeo.proc_GetBetterAddress(verified);
		current := Spokeo.proc_flagCurrentRecords(better);
		imputed := Spokeo.proc_imputeCurrentRecords(current);
		defunct := Spokeo.proc_getDeceased(imputed);
		bestaddr := Spokeo.proc_IsBestAddressAvailable(defunct);
		result := proc_GetBestName(bestaddr);

		return result;
END;