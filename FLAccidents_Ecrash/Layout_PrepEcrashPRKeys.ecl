EXPORT Layout_PrepEcrashPRKeys := MODULE

EXPORT Partial_Report_Nbr_Slim := RECORD 
  STRING40  l_accnbr; 
  STRING2   report_code;
  STRING2   jurisdiction_state;
  STRING100 jurisdiction;
  STRING8   accident_date;
  STRING40  orig_Accnbr; 
  STRING40  addl_report_number; 
  STRING4   work_type_id;
  STRING3   report_type_id;
  UNSIGNED8 Idfield,
  STRING20  ReportLinkID,	
  STRING100 Vendor_Code,
  STRING20  vendor_report_id,	
  STRING4 f1; 
  STRING4 f2; 
  STRING4 f3; 
  STRING4 f4; 
  STRING4 f5; 
  STRING4 f6; 
  STRING4 f7; 
  STRING4 f8; 
  STRING4 f9; 
  STRING4 f10; 
  STRING4 f11; 
  STRING4 f12; 
  STRING4 f13; 
  STRING4 f14;
  STRING4 f15;
  STRING4 f16;
  STRING4 f17;
  STRING4 f18;
  STRING4 f19;
  STRING4 f20; 
  STRING4 f21;
  STRING4 f22;
  STRING4 f23;
  STRING4 f24;
  STRING4 f25;
  STRING4 f26;
  STRING4 f27;
  STRING4 f28;
  STRING4 f29;
  STRING4 f30;
  STRING4 f31;
  STRING4 f32;
  STRING4 f33;
  STRING4 f34;
  STRING4 f35;
  STRING4 f36;
  STRING4 f37;
END; 

EXPORT Partial_Report_Nbr_slim_rec := RECORD 
  STRING4   partial_report_nbr; 
  STRING2   report_code;
  STRING2   jurisdiction_state;
  STRING100 jurisdiction;
  STRING8   accident_date;
  STRING40  l_accnbr; 
  STRING40  orig_Accnbr; 
  STRING40  addl_report_number; 
  STRING4   work_type_id;
  STRING3   report_type_id;
  STRING100 Vendor_Code,
  STRING20  vendor_report_id,	
  STRING20  ReportLinkID,	
  UNSIGNED8 Idfield,
END; 

EXPORT eCrash_vin7 := RECORD
	STRING7  l_vin7,
	STRING30 l_vin,
	STRING40 accident_nbr,
	STRING40 orig_accnbr, 
END;

END;