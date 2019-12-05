/**
Merge new file with existing base file

**/
IMPORT Std;

EXPORT fn_MergeWithBase(DATASET($.Layout_Base2) newbase, DATASET($.Layout_Base2) base = $.Files2.dsNCF2Base) := FUNCTION

	linked := $.proc_link(newbase);
	newrecs := SORT(DISTRIBUTE(linked, hash32(clientid)), clientid, updated, local);  // process older records first
	f1 := $.fn_MergeCases(newrecs, base);
	f2 := $.fn_MergeClients(newrecs, f1);
	//f3 := $.fn_MergeAddresses(newrecs, f2);
	f4 := $.fn_AddContacts(f2);

	return f4;

END;