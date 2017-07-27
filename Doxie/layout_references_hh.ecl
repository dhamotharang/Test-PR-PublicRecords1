// need to preserve whether get_dids found the returned DIDs via a household lookup
import doxie;
export layout_references_hh := RECORD(doxie.layout_references) boolean includedByHHID := false; END;