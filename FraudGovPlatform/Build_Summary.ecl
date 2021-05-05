IMPORT FraudGovPlatform,STD,FraudGovPlatform_Validation;
EXPORT Build_Summary(string pversion) := MODULE

	EXPORT tableColumns_Layout := RECORD
		STRING  column1 := '';
		STRING  column2 := '';
		STRING  column3 := '';
		STRING  column4 := '';
		STRING  column5 := '';
	END;

	EXPORT fMakeHTMLTable (DATASET(tableColumns_Layout) prTableContent ):= FUNCTION

	htmlTableTR := RECORD
			 STRING htmlTR;
			 STRING htmlTRs;
	END;

	htmlTableTR FnFileList(tableColumns_Layout L) :=transform
			SELF.htmlTR := L.column1 + L.column2 + L.column3 + L.column4 + L.column5;
			SELF.htmlTRs := '';
	end;
	htmlTableRow := PROJECT(prTableContent,FnFileList(LEFT));

	htmlTableTR FnHtmlRows(htmlTableTR L, htmlTableTR R) := TRANSFORM
			SELF.htmlTRs := L.htmlTRs + R.htmlTR;
			SELF := R;
	END;
	ihtmlTableRows := ITERATE(htmlTableRow,FnHtmlRows(LEFT,RIGHT));

	htmlTableRows  := ihtmlTableRows[COUNT(ihtmlTableRows)];

	return htmlTableRows.htmlTRs;
	 
	END;	


	shared bm  := FraudGovPlatform.Files().Base.Main_Orig.Built;
	shared fbm := FraudGovPlatform.Files().Base.Main_Orig.Father;
	bid := FraudGovPlatform.Files().Input.IdentityData.Sprayed;
	bkf := FraudGovPlatform.Files().Input.KnownFraud.Sprayed;
	bdb := FraudGovPlatform.Files().Input.Deltabase.Sprayed;


	Data_Loaded := join (bm, fbm,
		left.RECORD_ID = right.RECORD_ID,
		LEFT ONLY);

	my_rec := record
		string12 Customer_ID;
		string100 source;
		string75 FileName;
	end;
																																																																																	 

	identities := join ( Data_Loaded, bid, 
	left.classification_Permissible_use_access.file_type = 3 and ~regexfind('Delta',left.classification_Permissible_use_access.fdn_file_code, nocase) and left.source_rec_id = right.source_rec_id,
	transform(my_rec, self.Customer_ID := left.Customer_ID; self.source := left.source;  self.FileName := right.FileName)
	);

	knownrisk := join ( Data_Loaded, bkf, 
	left.classification_Permissible_use_access.file_type = 1 and ~regexfind('Safe|Delta',left.classification_Permissible_use_access.fdn_file_code, nocase) and left.source_rec_id = right.source_rec_id,
	transform(my_rec, self.Customer_ID := left.Customer_ID; self.source := left.source; self.FileName := right.FileName)
	);

	safelist := join ( Data_Loaded, bkf, 
	left.classification_Permissible_use_access.file_type = 1 and regexfind('Safe',left.classification_Permissible_use_access.fdn_file_code, nocase) and left.source_rec_id = right.source_rec_id,
	transform(my_rec, self.Customer_ID := left.Customer_ID; self.source := left.source; self.FileName := right.FileName)
	);

	deltabase := join ( Data_Loaded, bdb, 
	regexfind('Delta',left.classification_Permissible_use_access.fdn_file_code, nocase) and left.source_rec_id = right.source_rec_id,
	transform(my_rec, self.Customer_ID := left.Customer_ID; self.source := left.source; self.FileName := right.FileName)
	);

	all_recs := identities + knownrisk + safelist +  deltabase;

	New_Records := sort(table(all_recs,{Customer_ID,source, FileName,  New_Recs:=count(group)},Customer_ID,source, FileName, few),FileName);	

	tableColumns_Layout FnMakeSummaryColTable(New_Records L) := TRANSFORM
				SELF.column1 := '<tr><th class="importTableHeader" bgcolor="#f6f6f6">' + (string)L.Customer_ID + '</th>';
				SELF.column2 := '<td class="importTableCell">' + STD.Str.ToUpperCase(L.source) + '</td>';
				SELF.column3 := '<td class="importTableCell">' + STD.Str.ToUpperCase(L.FileName) + '</td>';
				SELF.column4 := '<td class="importTableCell"align="right"><strong>' + (string)L.New_Recs + '</strong></td></tr>';
	END;
	SHARED SummaryColTable := PROJECT(New_Records,FnMakeSummaryColTable(LEFT));	
	
	Source_Loaded_before := table(fbm,{Customer_ID,source,cnt_before:=count(group)},Customer_ID,source, few);
	Source_Loaded_after :=  table(bm,{Customer_ID,source,cnt_after:=count(group)},Customer_ID,source, few);

	Source_Comparison := join (Source_Loaded_before, Source_Loaded_after,
		left.Customer_ID = right.Customer_ID and left.source = right.source,
		 transform({ string Customer_ID, string source, unsigned6 cnt_before, unsigned6 cnt_after, integer new_records}, 
		self.Customer_ID := right.Customer_ID;
		self.source := right.source;
		self.cnt_before := left.cnt_before;
		self.cnt_after := right.cnt_after;
		self.new_records := right.cnt_after - left.cnt_before;
		 self := left;),
		 right outer);

	tableColumns_Layout FnMakeComparisonColTable(Source_Comparison L) := TRANSFORM
				SELF.column1 := '<tr><th class="importTableHeader" bgcolor="#f6f6f6">' + (string)L.Customer_ID + '</th>';
				SELF.column2 := '<td class="importTableCell">' + STD.Str.ToUpperCase(L.source) + '</td>';
				SELF.column3 := '<td class="importTableCell"align="right">' + (string)L.cnt_before + '</td>';
				SELF.column4 := '<td class="importTableCell"align="right">' + (string)L.cnt_after + '</td>';
				SELF.column5 := '<td class="importTableCell"align="right">' + if(L.new_records>0,'<strong>'+(string)L.new_records+'</strong>',(string)L.new_records) + '</td></tr>';
	END;
	SHARED ComparisonColTable := PROJECT(Source_Comparison,FnMakeComparisonColTable(LEFT));	

	SHARED BaseUnitTests := FraudGovPlatform.Files().Base.BaseUnitTests.Built;
	tableColumns_Layout FnMakeBaseUnitTestColTable(BaseUnitTests L) := TRANSFORM
				color := map(
						STD.Str.ToUpperCase(L.result) = 'PASSED' => '#00FF00', 	//GREEN
						STD.Str.ToUpperCase(L.result) = 'REVIEW' => '#FFFF00',  //YELLOW
						STD.Str.ToUpperCase(L.result) = 'FAILED' => '#FFFF00', 	//RED
						'#FFFFFF'
						);

				font := map(
						STD.Str.ToUpperCase(L.result) = 'FAILED' => '#FFFFFF', 	//WHITE
						'#000000'												//BLACK
						);

				SELF.column1 := '<tr><th class="importTableHeader" bgcolor="#f6f6f6">' + (string)L.unittest + '</th>';
				SELF.column2 := '<td class="importTableCell" bgcolor="'+color+'"><font color="'+font+'">' + STD.Str.ToUpperCase(L.result) + '</font></td>';
				SELF.column3 := '<td class="importTableCell"align="right">' + L.value + '</td></tr>';
				SELF.column4 := '';
				SELF.column5 := '';
	END;
	SHARED BaseUnitTestColTable := PROJECT(BaseUnitTests,FnMakeBaseUnitTestColTable(LEFT));	

	SHARED KeysUnitTests := FraudGovPlatform.Files().Base.KeysUnitTests.Built;
	tableColumns_Layout FnMakeKeysUnitTestColTable(KeysUnitTests L) := TRANSFORM
				color := map(
						STD.Str.ToUpperCase(L.result) = 'PASSED' => '#00FF00', 	//GREEN
						STD.Str.ToUpperCase(L.result) = 'REVIEW' => '#FFFF00',  //YELLOW
						STD.Str.ToUpperCase(L.result) = 'FAILED' => '#FFFF00', 	//RED
						'#FFFFFF'
						);

				font := map(
						STD.Str.ToUpperCase(L.result) = 'FAILED' => '#FFFFFF', 	//WHITE
						'#000000'												//BLACK
						);

				SELF.column1 := '<tr><th class="importTableHeader" bgcolor="#f6f6f6">' + (string)L.unittest + ' - ' + L.rule + '</th>';
				SELF.column2 := '<td class="importTableCell" bgcolor="'+color+'"><font color="'+font+'">' + STD.Str.ToUpperCase(L.result) + '</font></td>';
				SELF.column3 := '<td class="importTableCell"align="right">' + (string)L.beforec + '</td>';
				SELF.column4 := '<td class="importTableCell"align="right">' + (string)L.afterc + '</td>';
				SELF.column5 := '<td class="importTableCell"align="right">' + L.value + '</td></tr>';
	END;
	SHARED KeysUnitTestColTable := PROJECT(KeysUnitTests,FnMakeKeysUnitTestColTable(LEFT));

	html := '	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><html><head>'
+'	                                                                                                                  '
+'	      <title>RIN Buid Status Report</title>                                                                       '
+'	      <style type="text/css">                                                                                     '
+'	         body {                                                                                                   '
+'	            font-family: Arial, Helvetica, sans-serif;                                                            '
+'	            color: #505050;                                                                                       '
+'	            font-size: 13px;                                                                                      '
+'	         }                                                                                                        '
+'	                                                                                                                  '
+'	         h2 {                                                                                                     '
+'	            font-family: Arial, Helvetica, sans-serif;                                                            '
+'	            font-size: 18pt;                                                                                      '
+'	            color: #505050;                                                                                       '
+'	         }                                                                                                        '
+'	         h3, p, li {                                                                                              '
+'	            font-family: Arial, Helvetica, sans-serif;                                                            '
+'	            color: #505050;                                                                                       '
+'	         }                                                                                                        '
+'	                                                                                                                  '
+'	         td {                                                                                                     '
+'	            font-family: Arial, Helvetica, sans-serif;                                                            '
+'	            color: #000000;                                                                                       '
+'	            font-size: 13px;                                                                                      '
+'	         }                                                                                                        '
+'	                                                                                                                  '
+'	         td.importTableCell {                                                                                     '
+'	            font-family: Arial, Helvetica, sans-serif;                                                            '
+'	            color: #505050;                                                                                       '
+'	            font-size: 13px;                                                                                      '
+'	            border: #DDDDDD solid thin;                                                                           '
+'	            border-color: #DDDDDD;                                                                                '
+'	         }                                                                                                        '
+'	         th.importTableHeader {                                                                                   '
+'	            font-family: Arial, Helvetica, sans-serif;                                                            '
+'	            color: #505050;                                                                                       '
+'	            bgcolor: #f6f6f6;                                                                                     '
+'	            font-size: 13px;                                                                                      '
+'	            border: #DDDDDD solid thin;                                                                           '
+'	            border-color: #DDDDDD;                                                                                '
+'	         }                                                                                                        '
+'	         table.importTableContent {                                                                               '
+'	            color: #505050;                                                                                       '
+'	            border: 2px solid #DDDDDD;                                                                            '
+'	            border-color: #DDDDDD;                                                                                '
+'	            padding: 2px 2px 2px 2px;                                                                             '
+'	            border-spacing: 2px 2px;                                                                              '
+'	            border-collapse: collapse;                                                                            '
+'	         }                                                                                                        '
+'	                                                                                                                  '
+'	         table.contentTable {                                                                                     '
+'	            margin-top:0px;                                                                                       '
+'	            padding:1px 20px 20px 20px;                                                                           '
+'	}                                                                                                                 '
+'	         div.previewStatistics {                                                                                  '
+'	            font-family: Arial, Helvetica, sans-serif;                                                            '
+'	            color: #505050;                                                                                       '
+'	            font-size: 10px;                                                                                      '
+'	                                                                                                                  '
+'	}                                                                                                                 '
+'	         div.footerEntry {                                                                                        '
+'	            font-family: Arial, Helvetica, sans-serif;                                                            '
+'	            color: #505050;                                                                                       '
+'	                                                                                                                  '
+'	}                                                                                                                 '
+'	         th {                                                                                                     '
+'	            font-family: Arial, Helvetica, sans-serif;                                                            '
+'	            color: #000000;                                                                                       '
+'	            bgcolor: #f6f6f6;                                                                                     '
+'	            font-size: 13px;                                                                                      '
+'	         }                                                                                                        '
+'	      </style>                                                                                                    '
+'	   </head>                                                                                                        '
+'	   <body leftmargin="0" topmargin="0" offset="0" alink="#0066CC" text="#333333" vlink="#0066CC" link="#0066CC" marginheight="0" marginwidth="0">										'
+'	      <center>                                                                                                                                                      '
+'	         <table style="font:Arial;" id="backgroundTable" bgcolor="#FAFAFA" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">                   '
+'	            <tbody>                                                                                                                                                 '
+'	               <tr>                                                                                                                                                 '
+'	                  <td align="center" valign="top">                                                                                                                  '
+'	                     <!-- // Begin Template Preheader \\ -->                                                                                                        '
+'	                     <table id="templatePreheader" border="0" cellpadding="10" cellspacing="0" width="900">                                                         '
+'	                        <tbody>                                                                                                                                     '
+'	                           <tr>                                                                                                                                     '
+'	                              <td style="color:#505050;font-family:Arial;font-size:10px;line-height:100%;text-align:left;" class="preheaderContent" valign="top">   '
+'	                                 <!-- // Begin Module: Standard Preheader \\ -->                                                                                    '
+'	                                 <table border="0" cellpadding="10" cellspacing="0" width="100%">                                                                   '
+'	                                    <tbody>                                                                                                                         '
+'	                                       <tr>                                                                                                                         '
+'	                                          <td valign="top">                                                                                                         '
+'	                                             <div class="previewStatistics">                                                                                        '
+'	                                                <!--This text appears in some email applications as the email preview.-->                                           '
+'	                                             </div>                                                                                                                 '
+'	                                          </td>                                                                                                                     '
+'	                                          <!-- *|IFNOT:ARCHIVE_PAGE|* -->                                                                                           '
+'	                                          <td valign="top" width="190">&nbsp;</td>                                                                                  '
+'	                                          <!-- *|END:IF|* -->                                                                                                       '
+'	                                       </tr>                                                                                                                        '
+'	                                    </tbody>                                                                                                                        '
+'	                                 </table>                                                                                                                           '
+'	                                 <!-- // End Module: Standard Preheader \\ -->                                                                                      '
+'	                              </td>                                                                                                                                 '
+'	                           </tr>                                                                                                                                    '
+'	                        </tbody>                                                                                                                                    '
+'	                     </table>                                                                                                                                       '
+'	                     <!-- // End Template Preheader \\ -->                                                                                                          '
+'	                     <!-- // Begin Template Preheader \\ -->                                                                                                        '
+'	                     <!-- // End Template Preheader \\ -->                                                                                                          '
+'	                     <table id="templateContainer" style="border:1px solid #DDDDDD" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" width="900">                  '
+'	                        <tbody>                                                                                                                                     '
+'	                           <tr>                                                                                                                                     '
+'	                              <td align="center" valign="top">                                                                                                      '
+'	                                 <!-- // Begin Template Header \\ -->                                                                                               '
+'	                                 <table id="templateHeader" border="0" cellpadding="0" cellspacing="0" width="900">                                                 '
+'                                       <tbody>                                                                                                                        '
+'	                                       <tr bgcolor="#f2f2f2">                                                                                                       '
+'                                            <td class="headerContent" style="text-align:left; padding:20px 5px 20px 20px;">                                             '
+'	                                             <!-- // Begin Module: Standard Header Image \\ -->                                                                     '
+'	                                             <img src="https://risk.lexisnexis.com/-/media/images/lnrs/logos/logo_lexis.png" style="max-width:200px;" id="headerImage campaign-icon" mc:label="header_image" mc:edit="header_image" mc:allowdesignermc:allowtext="">'
+'  											                       <!-- // End Module: Standard Header Image \\ -->                                                  '
+'	                                          </td>                                                                                                                      '
+'	                                       </tr>                                                                                                                         '
+'	                                    </tbody>	                                                                                                                     '
+'	                                 </table>                                                                                                                            '
+'	                                 <!-- // End Template Header \\ -->                                                                                                  '
+'	                              </td>                                                                                                                                  '
+'	                           </tr>                                                                                                                                     '
+'	                           <tr>                                                                                                                                      '
+'	                              <td align="center" valign="top">                                                                                                       '
+'	                                 <!-- // Begin Template Body \\ -->                                                                                                  '
+'	                                 <table id="templateBody" border="0" cellpadding="0" cellspacing="0" width="900">                                                    '
+'	                                    <tbody>                                                                                                                          '
+'	                                       <tr>                                                                                                                          '
+'	                                          <td class="bodyContent" style="color:#505050;font-family:Arial;font-size:14px;line-height:150%;text-align:left;" valign="top">'
+'	                                                <!-- // Begin Module: Left Image with Content \\ -->                                                                 '
+'                                               <table mc:repeatable="siwc_600" mc:variant="content with left image" style="padding:20px 20px 5px 20px;" border="0" cellspacing="0" width="100%">'
+'                                                  <tbody>                                                                                                              '
+'	                                                   <tr>                                                                                                              '
+'	                                                      <td align="left" valign="top">                                                                                 '
+'	                                                         <h2 style="color:#202020;display:block;font-family:Arial;font-size:30px;font-weight:bold;margin-top:0;margin-right:0;margin-bottom:5px;margin-left:0;text-align:left;">RIN Build Status Report</h2>'
+'															 <h3 style="color:#c2c2a3;display:block;font-family:Arial;font-size:15px;margin-top:0;margin-right:0;margin-bottom:5px;margin-left:0;text-align:left;">RISK INTELLIGENCE NETWORK</h3>'
+'   														 <p>Date of Report: ' + pversion +'</p>																	 '
+'	                                                      </td>                                                                                                          '
+'                                                        <td align="center" valign="top" width="90">                                                                    '
+'	                                                         <img src="http://portal.mxlogic.com/images/transparent.gif">                                                '
+'	                                                      </td>	                                                                                                         '
+'	                                                   </tr>                                                                                                             '
+'	                                                </tbody>	                                                                                                         	 '
+'	                                             </table>                                                                                                                '
+'	                                             <!-- // End Module: Left Image with Content \\ -->                                                                      '
+'	                                             <!-- // Begin Module: Standard Content \\ -->                                                                           '
+'	                                             <table class="contentTable"  border="0"  cellspacing="0" width="100%">                                                  '
+'	                                                <tbody>                                                                                                              '
+'	                                                   <tr>                                                                                                              '
+'	                                                      <td valign="top">                                                                                              '
+'	                                                         <div mc:edit="std_content00">                                                                               '
+'	                                                            <h2>New Records</h2>                                                                                     '
+'	                                                            <p>Summary report broken down by Input File.</p>                                                         '
+'	                                                            <table class="importTableContent" border="1px" bordercolor="#DDDDDD" cellpadding="2px" cellspacing="0" width="100%">'
+'	                                                               <tbody>                                                                                               '
+'	                                                                  <tr>                                                                                               '
+'	                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">GC_ID</th>                                      '
+'	                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Source</th>                                     '
+'																		 <th class="importTableHeader" bgcolor="#f6f6f6">FileName</th>                                   '
+'																		 <th class="importTableHeader" bgcolor="#f6f6f6" align="right">New Records</th>                  '
+'	                                                                  </tr>                                                                                              '
+'	                                                                  <tr>                                                                                               '
+ fMakeHTMLTable (SummaryColTable) 
+'	                                                                  </tr>                                                                                              '
+'	                                                               </tbody>                                                                                              '
+'	                                                            </table>                                                                                                 '
+'	                                                         </div>                                                                                                      '
+'	                                                      </td>                                                                                                          '
+'	                                                   </tr>                                                                                                             '
+'	                                                   <tr>                                                                                                              '
+'	                                                      <td valign="top">                                                                                              '
+'	                                                         <div mc:edit="std_content00">                                                                               '
+'	                                                            <h2>Comparison</h2>                                                                                      '
+'	                                                            <p>Comparison between the previous and current build broken down by Source.</p>                          '
+'	                                                            <table class="importTableContent" border="1px" bordercolor="#DDDDDD" cellpadding="2px" cellspacing="0" width="100%">'
+'	                                                               <tbody>                                                                                               '
+'	                                                                  <tr>                                                                                               '
+'	                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">GC_ID</th>                                      '
+'	                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Source</th>                                     '
+'																		 <th class="importTableHeader" bgcolor="#f6f6f6" align="right">Before</th>                       '
+'																		 <th class="importTableHeader" bgcolor="#f6f6f6" align="right">After</th>                        '
+'																		 <th class="importTableHeader" bgcolor="#f6f6f6" align="right">New Records</th>                  '
+'	                                                                  </tr>                                                                                              '
+'	                                                                  <tr>                                                                                               '
+ fMakeHTMLTable (ComparisonColTable) 
+'	                                                                  </tr>                                                                                              '
+'	                                                               </tbody>                                                                                              '
+'	                                                            </table>                                                                                                 '
+'	                                                         </div>                                                                                                      '
+'	                                                      </td>                                                                                                          '
+'	                                                   </tr>																											 '
+'	                                                   <tr>                                                                                                              '
+'	                                                      <td valign="top">                                                                                              '
+'	                                                         <div mc:edit="std_content00">                                                                               '
+'	                                                            <h2>Base Unit Tests</h2>                                                                                 '
+'	                                                            <p>The purpose is to validate that each unit of the software code performs as expected.</p>                          '
+'	                                                            <table class="importTableContent" border="1px" bordercolor="#DDDDDD" cellpadding="2px" cellspacing="0" width="100%">'
+'	                                                               <tbody>                                                                                               '
+'	                                                                  <tr>                                                                                               '
+'	                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Unit Test</th>                                  '
+'	                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Result</th>                                     '
+'																		 <th class="importTableHeader" bgcolor="#f6f6f6" align="right">Value</th>                       '
+'	                                                                  </tr>                                                                                              '
+'	                                                                  <tr>                                                                                               '
+ fMakeHTMLTable (BaseUnitTestColTable) 
+'	                                                                  </tr>                                                                                              '
+'	                                                               </tbody>                                                                                              '
+'	                                                            </table>                                                                                                 '
+'	                                                         </div>                                                                                                      '
+'	                                                      </td>                                                                                                          '
+'	                                                   </tr>   																											 '
+'													   <tr>                                                                                                              '
+'	                                                      <td valign="top">                                                                                              '
+'	                                                         <div mc:edit="std_content00">                                                                               '
+'	                                                            <h2>Keys Unit Tests</h2>                                                                                 '
+'	                                                            <p>The purpose is to validate that each key do not drop counts .</p>                          			 '
+'	                                                            <table class="importTableContent" border="1px" bordercolor="#DDDDDD" cellpadding="2px" cellspacing="0" width="100%">'
+'	                                                               <tbody>                                                                                               '
+'	                                                                  <tr>                                                                                               '
+'	                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Unit Test</th>                                  '
+'	                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Result</th>                                     '
+'																		 <th class="importTableHeader" bgcolor="#f6f6f6" align="right">Before</th>                       '
+'																		 <th class="importTableHeader" bgcolor="#f6f6f6" align="right">After</th>                        '
+'																		 <th class="importTableHeader" bgcolor="#f6f6f6" align="right">Difference</th>                   '
+'	                                                                  </tr>                                                                                              '
+'	                                                                  <tr>                                                                                               '
+ fMakeHTMLTable (KeysUnitTestColTable) 
+'	                                                                  </tr>                                                                                              '
+'	                                                               </tbody>                                                                                              '
+'	                                                            </table>                                                                                                 '
+'	                                                         </div>                                                                                                      '
+'	                                                      </td>                                                                                                          '
+'	                                                   </tr>   																											 '
+'	                                                </tbody>                                                                                                             '
+'	                                             </table>                                                                                                                '
+'	                                             <!-- // End Module: Standard Content \\ -->                                                                             '
+'	                                          </td>                                                                                                                      '
+'	                                       </tr>                                                                                                                         '
+'	                           <tr>                                                                                                                                      '
+'	                           </tr>                                                                                                                                     '
+'	                           <tr>                                                                                                                                      '
+'	                              <td align="center" valign="top">                                                                                                       '
+'	                                 <!-- // Begin Template Footer \\ -->                                                                                                '
+'	                                 <table id="templateFooter" border="0" cellpadding="10" cellspacing="0" width="900">                                                 '
+'	                                    <tbody>                                                                                                                          '
+'	                                       <tr>                                                                                                                          '
+'	                                          <td class="footerContent" style="color:#707070;font-family:Arial;font-size:12px;line-height:125%;text-align:left;" valign="top">'
+'	                                             <!-- // Begin Module: Standard Footer \\ -->                                                                            '
+'	                                             <table border="0" cellpadding="10" cellspacing="0" width="100%">                                                        '
+'	                                                <tbody>                                                                                                              '
+'	                                                   <tr>                                                                                                              '
+'	                                                      <td colspan="2" id="social" style="background-color:#FAFAFA; border:0; text-align:center;" valign="middle">    '
+'																															Any question about this report, please contact Oscar Barrientos or Sesha Nookala													 '
+'	                                                      </td>                                                                                                          '
+'	                                                   </tr>                                                                                                             '
+'	                                                   <tr>                                                                                                              '
+'	                                                      <td valign="top" width="350">                                                                                  '
+'	                                                         <div class="footerEntry">                                                                                   '
+'	                                                         </div>                                                                                                      '
+'	                                                      </td>                                                                                                          '
+'	                                                      <td id="monkeyRewards" valign="top" width="190">                                                               '
+'	                                                      </td>                                                                                                          '
+'	                                                   </tr>                                                                                                             '
+'	                                                </tbody>                                                                                                             '
+'	                                             </table>                                                                                                                '
+'	                                             <!-- // End Module: Standard Footer \\ -->                                                                              '
+'	                                          </td>                                                                                                                      '
+'	                                       </tr>                                                                                                                         '
+'	                                    </tbody>                                                                                                                         '
+'	                                 </table>                                                                                                                            '
+'	                                 <!-- // End Template Footer \\ -->                                                                                                  '
+'	                              </td>                                                                                                                                  '
+'	                           </tr>                                                                                                                                     '
+'	                        </tbody>                                                                                                                                     '
+'	                     </table><br>                                                                                                                                    '
+'	                  </td>                                                                                                                                              '
+'	               </tr>                                                                                                                                                 '
+'	            </tbody>                                                                                                                                                 '
+'	         </table>                                                                                                                                                    '
+'	      </center>                                                                                                                                                      '
+'	  </body>                                                                                                                                                            '
+'	</html>                                                                                                                                                              ';

	msg:= '\n\n'
	+ 'Hi All,\n\n'
	+ 'RIN Data Build '+pversion+' & Dashboards are Ready for QA.\n'
	+ 'Attached you will find the summary report in HTML format.\n\n\n'
	+ 'Thanks,\n'
	+ 'The Data Engineering Team\n\n\n'
	+ 'THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL'
	;

	export Send_Email := fileservices.SendEmailAttachText( 
			FraudGovPlatform_Validation.Mailing_List().RinNetwork, 
			'RIN Data Build ' + pversion,
      msg,
			html,
      'text/plain; charset=ISO-8859-3',  
			'RINBuildStatusReport-'+pversion+'.html',
			sender := 'RINsupport@lexisnexisrisk.com');
		
	export send := Send_Email; 

END;

