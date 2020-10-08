IMPORT Bank_Routing, BatchShare, GeoTriangulation_Services;

EXPORT AccuityBankData_Layouts := MODULE

	EXPORT batch_in := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING20 routing_transit_nbr;
		STRING32 state;
		STRING10 edge_region;
	END;

	EXPORT batch_wrk := RECORD
		batch_in;
		STRING20 orig_acctno;
		Batchshare.Layouts.ShareErrors;
		STRING9 in_routing_nbr;
		STRING2 in_state;
		STRING2 in_region;
		STRING9 routing_number;
		STRING2 routing_state;

    // 2020-08-25 JIRA RR-19445, Added fields needed for GeoTriangulation batch project: 
    //                           new input fields, 2 geo triangulation related fields and ip metadata fields
    // GT batch input fields
    STRING20 bank_routing_number;    
    STRING45 ip_address;
    BatchServices.Layouts.layout_batch_common_address; //common KTR passed in address parts fields
    STRING10 latitude;
    STRING11 longitude;
    
    // GT batch output fields
    STRING24 ultimate_bank_in_state;
    STRING24 geotriangulation;
    STRING2  ValidationIpProblems;
    STRING1  IPAddrExceedsInputAddr;
    // v---- IP metadata from IP_Metadata IPv4 or Ipv6 keys
    GeoTriangulation_Services.Layouts.rec_batch_out.edge_country;
    //GeoTriangulation_Services.Layouts.rec_batch_out.edge_region; // name conflict with batch_in.edge_region above so use this ----v
    STRING10 ipm_edge_region;
    GeoTriangulation_Services.Layouts.rec_batch_out.edge_city;
    GeoTriangulation_Services.Layouts.rec_batch_out.edge_conn_speed;
    GeoTriangulation_Services.Layouts.rec_batch_out.edge_latitude;
    GeoTriangulation_Services.Layouts.rec_batch_out.edge_longitude;
    GeoTriangulation_Services.Layouts.rec_batch_out.edge_postal_code;
    GeoTriangulation_Services.Layouts.rec_batch_out.edge_continent_code;
    GeoTriangulation_Services.Layouts.rec_batch_out.edge_gmt_offset;
    GeoTriangulation_Services.Layouts.rec_batch_out.isp_name;
    GeoTriangulation_Services.Layouts.rec_batch_out.domain_name;
    GeoTriangulation_Services.Layouts.rec_batch_out.proxy_type;
    GeoTriangulation_Services.Layouts.rec_batch_out.proxy_description;
    GeoTriangulation_Services.Layouts.rec_batch_out.asn;
    GeoTriangulation_Services.Layouts.rec_batch_out.asn_name;
  END;

	EXPORT batch_out := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING24 ultimate_bank_in_state;
		STRING24 geotriangulation;
	END;

END;