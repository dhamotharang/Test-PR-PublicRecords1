// This defines the output interfaces for header fetches contained in this
// module inside LIB_ attributes.
import AutoHeaderV2;
EXPORT ILIB := module

	// output interface implemented by Person Header search library
	EXPORT IHeaderSearch (dataset (AutoHeaderV2.layouts.lib_search) ds_search_in, integer search_code=0) := INTERFACE

		export dataset (AutoHeaderV2.layouts.search_out) results;

		export dataset (AutoHeaderV2.layouts.search_out) messages;

    export dataset (AutoHeaderV2.layouts.search) _input;

	END;

END;
