EXPORT _Sample_Records := MODULE

	EXPORT Addtl_Events := MODULE
		layout_batch_in := RECORD
			STRING30    acctno;
			STRING10  	court_code;
			STRING15  	casekey;
			STRING10  	caseid;
			STRING50    tmsid;
			STRING24	entered_date := '00000000';
		END;
		
		EXPORT ds_sample_input := dataset([
				{'cnc1', 'AL003', '0516020', '', ''},
				{'cnc2', 'AL003', '0715543', '', ''},
				{'cnc3', 'AK001', '0000144', '', ''},
				{'cnc3_06022009', 'AK001', '0000144', '', '', '06022009'},
				{'cnc4', 'AZ001', '0909648', '', ''}, 
				{'cnc4_06042009', 'AZ001', '0909648', '', '', '06042009'}, 
				{'cnc4_05042009', 'AZ001', '0909648', '', '', '05042009'}, 	
				{'cnc4_05042010', 'AZ001', '0909648', '', '', '05042010'}, 	
				{'cnc4_00000000', 'AZ001', '0909648', '', '', '00000000'}, 
				{'cnc5', 'IL002', '0835845', '', ''},
				{'cnc6', 'AL001', '0532801', '', ''},
				{'cnc7', 'AL001', '0831903', '', ''},
				{'cnc8', 'AL001', '0831907', '', ''},
				{'cid1', '', '', '49675', ''},
				{'cid2', '', '', '198562', ''},
				{'cid3', '', '', '40567', ''},
				{'cid3_06292009', '', '', '40567', '', '06292009'},	
				{'cid3_01022009', '', '', '40567', '', '06012009'},	
				{'cid3_00000000', '', '', '40567', '', '00000000'},
				{'cid3_10000000', '', '', '40567', '', '10000000'},
				{'cid3_00000001', '', '', '40567', '', '00000001'},
				{'cid4', '', '', '20938965', '', '06272009'},
				{'tmsid1', '', '', '', 'BKAL0030516020'},
				{'tmsid2', '', '', '', 'BKAZ0010909648', '06062009'},
				{'tmsid3', '', '', '', 'BKAK0010000144'},
				{'tmsid4', '', '', '', 'BKAZ0010909548'}
				],
			layout_batch_in);
	END;
END;

/*
example XML

case court:

<root>
 <row>
  <casekey>0909648</casekey>
  <court_code>AZ001</court_code>
  <entered_date>06042009</entered_date>
 </row>
 <row>
  <casekey>0000144</casekey>
  <court_code>AK001</court_code>
  <entered_date>06022009</entered_date>
 </row>
</root>

caseid:

<root>
 <row>
  <caseid>21089926</caseid>
 </row>
 <row>
  <caseid>15316425</caseid>
 </row>
</root>

tmsid:

<root>
 <row>
  <tmsid>BKAZ0010909648</tmsid>
 </row>
 <row>
  <tmsid>BKAK0010000144</tmsid>
 </row>
</root>

*/
