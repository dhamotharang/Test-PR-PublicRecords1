﻿/**
Merge new file with existing base file

**/
IMPORT Std;

EXPORT fn_MergeWithBase(DATASET($.Layout_Base2) newbase, DATASET($.Layout_Base2) base = $.Files2.dsNCF2Base) := FUNCTION

	linked := $.proc_link(newbase);
	f1 := $.fn_MergeCases(linked, base);
	f2 := $.fn_MergeClients(linked, f1);
	f3 := $.fn_MergeAddresses(linked, f2);

	return f3;

END;