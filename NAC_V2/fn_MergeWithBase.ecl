/**
Merge new file with existing base file

**/
IMPORT Std;


EXPORT fn_MergeWithBase(DATASET($.Layout_Base2) newbase, DATASET($.Layout_Base2) base = $.Files.Base2) := FUNCTION

	linked := $.proc_link(newbase);
	f1 := $.fn_MergeCases(linked, base);
	f2 := $.fn_MergeClients(linked, f1);

	return f2;

END;