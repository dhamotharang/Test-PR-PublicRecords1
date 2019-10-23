

Layout_ns_md__ResourceMetadata := RECORD
    STRING4 a_ns_md__CreatedBy;
    STRING20 a_ns_md__CreatedOn;
    STRING4 a_ns_md__LastUpdatedBy;
    STRING20 a_ns_md__LastUpdatedOn;
    STRING5 a_ns_md__SchemaVersion;
    STRING35 a_ns_xmlns__md;
    // UNSIGNED1 _VALUE;
END;

layout_type := Record
	string type {xpath('./')};
End;

layout_name := record
	string type {xpath('type')};
	string value {xpath('value')};
end;

// layout_names := RECORD
	// dataset(layout_name) names {xpath('name')};
  // string productSortKey {xpath('productSortKey')};
    // UNSIGNED1 _VALUE;
// END;

Layout_summary := RECORD
  STRING6 status {xpath('status')};
	dataset(layout_type) types{xpath('types/type')};
	dataset(layout_name) names{xpath('names/name')};
    // UNSIGNED1 _VALUE;
END;

Layout_routingCodeTypes_routingCodeType := RECORD
    STRING10 useCodeForm {xpath('@useCodeForm')};
    // STRING9 _VALUE;
END;

Layout_routingCodeTypes := RECORD
    DATASET(Layout_routingCodeTypes_routingCodeType) routingCodeType;
    // UNSIGNED1 _VALUE;
END;

EXPORT Layout_Product := Record
	string deleted {xpath('@deleted')};
	string fid {xpath('@fid')};
	string id {xpath('@id')};
	string resource{xpath('@resource')};
	string source{xpath('@source')};
	string tfpid {xpath('@tfpid')};
    // Layout_ns_md__ResourceMetadata ns_md__ResourceMetadata;
	layout_summary summary{xpath('summary')};
  Layout_routingCodeTypes routingCodeTypes;
    // UNSIGNED1 _VALUE;
END;
