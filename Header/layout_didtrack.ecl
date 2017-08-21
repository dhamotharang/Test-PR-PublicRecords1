export layout_didtrack :=
	record
		unsigned6 rid; // Header record ID being associated with DIDs.
		unsigned6 did; // DID with which the RID was associated.
		integer4 rule_code; // Rule code that associated the RID with the DID.
		string8 version; // Version code during which the association was made.
		unsigned1 ver_sub; // Sub-order within the version.
		boolean current; // Is this association current?
	end;
	