/**
Merge new file with existing base file

**/
IMPORT Std;

removeDupes(dataset(nac_V2.layout_base2) b) := function
// keep the most recent version
		b1 := DISTRIBUTE(b, hash32(clientid));
		b2 := SORT(b1, clientid,programstate,programcode,groupid,caseid,startdate,enddate,-$.fn_lfnversion(filename), local);
		b3 := DEDUP(b2, clientid,programstate,programcode,groupid,caseid,startdate,enddate, local);
	return b3;
END;

EXPORT fn_MergeWithBase(DATASET($.Layout_Base2) newbase, DATASET($.Layout_Base2) base = $.Files2.dsNCF2Base) := FUNCTION

	linked := $.proc_link(newbase);
	newrecs := SORT(DISTRIBUTE(linked, hash32(clientid)), clientid, updated, local);  // process older records first
	f1 := $.fn_MergeCases(newrecs, base);
	f2 := $.fn_MergeClients(newrecs, f1);
	//f3 := $.fn_MergeAddresses(newrecs, f2);

	return f2;

END;