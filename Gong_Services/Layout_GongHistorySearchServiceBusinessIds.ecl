import Gong_Services, BIPV2;

export Layout_GongHistorySearchServiceBusinessIds := RECORD(Gong_Services.Layout_GongHistorySearchService)
			BIPV2.IDlayouts.l_header_ids businessIds;
END;