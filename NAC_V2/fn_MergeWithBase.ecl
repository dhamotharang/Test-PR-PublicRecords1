/**
Merge new file with existing base file

**/
IMPORT Std;

EXPORT fn_MergeWithBase(DATASET($.Layout_Base2) newbase, DATASET($.Layout_Base2) base = $.Files2.dsNCF2Base, 
														boolean bypasslink = false) := FUNCTION

	duped := Nac_V2.fn_removeDupes(newbase);
	linked := IF(bypasslink, duped, $.proc_link(duped));
	newrecs := SORT(DISTRIBUTE(linked, hash32(clientid)), clientid, updated, local);  // process older records first
	f1 := $.fn_MergeCases(newrecs(clientid=''), base);
	f2 := $.fn_MergeClients(newrecs(clientid<>''), f1);
	f3 := $.fn_MergeAddresses(newrecs, f2);
	f4 := $.fn_AddContacts(f3);

	return $.fn_fixup(f4(clientid<>''));

END;