IMPORT STD, Bair, ut;

EXPORT raidsReport_FormatHTML := MODULE

EXPORT tableColumns_Layout := RECORD
  STRING  column1;
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


export fn_msg(dataset(Bair.RaidsReport_Layout.RaidsReportRec) pStats) := function

tableColumns_Layout FnMakeSummaryColTable(Bair.RaidsReport_Layout.summaryRec L) := TRANSFORM
      SELF.column1 := '<tr><th class="importTableHeader" bgcolor="#f6f6f6">' + L.description + '</th>';
		  SELF.column2 := '<td class="importTableCell">' + (STRING)L.importCount;
		  SELF.column3 := if((REAL)L.importPct > 0, '&nbsp<strong>(' + TRIM(L.importPct,Left,Right) + '%)</strong></td>','</td>');
		  SELF.column4 := '<td class="importTableCell">' + (STRING)L.allTimeCount;
		  SELF.column5 :=  if((REAL)L.allTimePct > 0, '&nbsp<strong>(' + TRIM(L.allTimePct,Left,Right) + '%)</strong></td>','</td>');
END;
SummaryColTable := PROJECT(pStats[1].SummaryTable,FnMakeSummaryColTable(LEFT));

tableColumns_Layout FnMakeFilesCountColTable(Bair.RaidsReport_Layout.filesCountRec L) := TRANSFORM
      SELF.column1 := '<tr><th class="importTableHeader" bgcolor="#f6f6f6">' + L.fileName + '</th>';
		  SELF.column2 := '<td class="importTableCell">' + (STRING)L.importCount + '</td>';
		  SELF.column3 := '<td class="importTableCell">' + (STRING)L.allTimeCount + '</td></tr>';
END;
FilesCountColTable := PROJECT(pStats[1].FilesCountTable,FnMakeFilesCountColTable(LEFT));

tableColumns_Layout FnMakeDateRangeColTable(Bair.RaidsReport_Layout.dateRangeRec L) := TRANSFORM
      SELF.column1 := '<tr><th class="importTableHeader" bgcolor="#f6f6f6">' + L.description + '</th>';
		  SELF.column2 := '<td class="importTableCell">' + L.importDate + '</td>';
		  SELF.column3 := '<td class="importTableCell">' + L.allTimeDate + '</td></tr>';
END;
DateRangeColTable := PROJECT(pStats[1].DateRangeTable,FnMakeDateRangeColTable(LEFT));

tableColumns_Layout FnMakeCoordinatesColTable(Bair.RaidsReport_Layout.coordinatesRec L) := TRANSFORM
      SELF.column1 := '<tr><th class="importTableHeader" bgcolor="#f6f6f6">' +  L.description + '</th>';
		  SELF.column2 := '<td class="importTableCell">' + (STRING)L.importCount;
		  SELF.column3 := if((REAL)L.importPct > 0, '&nbsp<strong>(' + TRIM(L.importPct,Left,Right) + '%)</strong></td>','</td>');			
		  SELF.column4 := '<td class="importTableCell">' + (STRING)L.allTimeCount;
		  SELF.column5 :=if((REAL)L.allTimePct > 0, '&nbsp<strong>(' + TRIM(L.allTimePct,Left,Right) + '%)</strong></td>','</td>');		
END;
CoordinatesColTable := PROJECT(pStats[1].CoordinatesTable,FnMakeCoordinatesColTable(LEFT));

tableColumns_Layout FnMakeQuarantinedColTable(Bair.RaidsReport_Layout.quarantinedRec L) := TRANSFORM
      SELF.column1 := '<tr><th class="importTableHeader" bgcolor="#f6f6f6">' + L.incidentID + '</th>';
		  SELF.column2 := '<td class="importTableCell">' + L.reason  + '</td>';
		  SELF.column3 := '<td class="importTableCell">' + L.notes  + '</td></tr>';
END;
QuarantinedColTable := PROJECT(pStats[1].QuarantinedTable,FnMakeQuarantinedColTable(LEFT));

tableColumns_Layout FnMakeDeletedColTable(Bair.RaidsReport_Layout.deletedRec L) := TRANSFORM
      SELF.column1 := '<tr><th class="importTableHeader" bgcolor="#f6f6f6">' + L.filename + '</th>';
		  SELF.column2 := '<td class="importTableCell">' + (STRING)L.recordCount  + '</td></tr>';
END;
DeletedColTable := PROJECT(pStats[1].DeletedTable,FnMakeDeletedColTable(LEFT));

tableColumns_Layout FnMakeUnclassifedCrimeColTable(Bair.RaidsReport_Layout.unclassifiedCrimeRec L) := TRANSFORM
      SELF.column1 := '<li>' + L.description +'</li>';
END;
UnclassifiedCrimeColTable := PROJECT(pStats[1].unclassifiedCrimeTable,FnMakeUnclassifedCrimeColTable(LEFT));

INTEGER incidentsTot := pStats[1].summaryTable(description='Approved Incidents')[1].importCount	+ pStats[1].summaryTable(description='Quarantined Incidents')[1].importCount;

	text:=
	'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><html><head>'
	+''
	+'      <title>DATA Import Report</title>'
	+'      <style type="text/css">'
	+'         body {'
	+'            font-family: Arial, Helvetica, sans-serif;'
	+'            color: #505050;'
	+'            font-size: 13px;'
	+'         }'
	+'         '
	+'         h2 {'
	+'            font-family: Arial, Helvetica, sans-serif;'
	+'            font-size: 18pt;'
	+'            color: #505050;'
	+'         }'
	+'         h3, p, li {'
	+'            font-family: Arial, Helvetica, sans-serif;'
	+'            color: #505050;'
	+'         }'
	+'         '
	+'         td {'
	+'            font-family: Arial, Helvetica, sans-serif;'
	+'            color: #000000;'
	+'            font-size: 13px;'
	+'         }'
	+'         '
	+'         td.importTableCell {'
	+'            font-family: Arial, Helvetica, sans-serif;'
	+'            color: #505050;'
	+'            font-size: 13px;'
	+'            border: #DDDDDD solid thin;'
	+'            border-color: #DDDDDD;'
	+'         }'
	+'         '
	+'         th.importTableHeader {'
	+'            font-family: Arial, Helvetica, sans-serif;'
	+'            color: #505050;'
	+'            bgcolor: #f6f6f6;'
	+'            font-size: 13px;'
	+'            text-align: left;'
	+'            border: #DDDDDD solid thin;'
	+'            border-color: #DDDDDD;'
	+'         }'
	+'         table.importTableContent {'
	+'            color: #505050;'
	+'            border: 2px solid #DDDDDD;'
	+'            border-color: #DDDDDD;'
	+'            padding: 2px 2px 2px 2px;'
	+'            border-spacing: 2px 2px;'
	+'            border-collapse: collapse;'
	+'         }'
	+'         '
	+'         table.contentTable {'
	+'            margin-top:0px; '
	+'            padding:1px 20px 20px 20px;'
	+'}        ' 
	+'         div.previewStatistics {'
	+'            font-family: Arial, Helvetica, sans-serif;'
	+'            color: #505050;'
	+'            font-size: 10px;'
	+'         '
	+'}         '
	+'         div.footerEntry {'
	+'            font-family: Arial, Helvetica, sans-serif;'
	+'            color: #505050;'
	+'         '
	+'}         '
	+'         th {'
	+'            font-family: Arial, Helvetica, sans-serif;'
	+'            color: #000000;'
	+'            bgcolor: #f6f6f6;'
	+'            font-size: 13px;'
	+'            text-align: left;'
	+'         }'
	+'      </style>'
	+'   </head>'
	+'   <body leftmargin="0" topmargin="0" offset="0" alink="#0066CC" text="#333333" vlink="#0066CC" link="#0066CC" marginheight="0" marginwidth="0">'
	+'      <center>'
	+'         <table style="font:Arial;" id="backgroundTable" bgcolor="#FAFAFA" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">'
	+'            <tbody>'
	+'               <tr>'
	+'                  <td align="center" valign="top">'
	+'                     <!-- // Begin Template Preheader \\ -->'
	+'                     <table id="templatePreheader" border="0" cellpadding="10" cellspacing="0" width="600">'
	+'                        <tbody>'
	+'                           <tr>'
	+'                              <td style="color:#505050;font-family:Arial;font-size:10px;line-height:100%;text-align:left;" class="preheaderContent" valign="top">'
	+'                                 <!-- // Begin Module: Standard Preheader \\ -->'
	+'                                 <table border="0" cellpadding="10" cellspacing="0" width="100%">'
	+'                                    <tbody>'
	+'                                       <tr>'
	+'                                          <td valign="top">'
	+'                                             <div class="previewStatistics">'
	+'                                                <!--This text appears in some email applications as the email preview.-->'
	//+'                                                1 incidents imported. '
  +                                                incidentsTot + ' incidents imported. ' 
	+                                                pStats[1].summaryTable(description='Approved Incidents')[1].importPct +'% approved. '
	+                                                pStats[1].summaryTable(description='Quarantined Incidents')[1].importPct +'% quarantined.'
	+'                                             </div>'
	+'                                          </td>'
	+'                                          <!-- *|IFNOT:ARCHIVE_PAGE|* -->'
	+'                                          <td valign="top" width="190">&nbsp;</td>'
	+'                                          <!-- *|END:IF|* -->'
	+'                                       </tr>'
	+'                                    </tbody>'
	+'                                 </table>'
	+'                                 <!-- // End Module: Standard Preheader \\ -->'
	+'                              </td>'
	+'                           </tr>'
	+'                        </tbody>'
	+'                     </table>'
	+'                     <!-- // End Template Preheader \\ -->'
	+'                     <!-- // Begin Template Preheader \\ -->'
	+'                     <!-- // End Template Preheader \\ -->'
	+'                     <table id="templateContainer" style="border:1px solid #DDDDDD" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" width="600">'
	+'                        <tbody>'
	+'                           <tr>'
	+'                              <td align="center" valign="top">'
	+'                                 <!-- // Begin Template Header \\ -->'
	+'                                 <table id="templateHeader" border="0" cellpadding="0" cellspacing="0" width="600">'
  +'                                     <tbody>'
	+'                                       <tr bgcolor="#f2f2f2">'
	//+'                                          <td class="headerContent" >'
  +'                                          <td class="headerContent" style="text-align:left; padding:5px 5px 5px 20px;">'
	+'                                             <!-- // Begin Module: Standard Header Image \\ -->'
//	+'                                             <img src="LN_rgb_h_pos_1-2.jpg" style="max-width:200px;" id="headerImage campaign-icon" mc:label="header_image" mc:edit="header_image" mc:allowdesignermc:allowtext="">'
	+'                                             <img src="http://www.bairanalytics.com/wp-content/uploads/LN_rgb_h_pos_1-2_20151217.png" style="max-width:200px;" id="headerImage campaign-icon" mc:label="header_image" mc:edit="header_image" mc:allowdesignermc:allowtext="">'
  +'											                       <!-- // End Module: Standard Header Image \\ -->'
	+'                                          </td>'
	+'                                       </tr>'
	+'                                    </tbody>'	
	//+'                                    <tbody>'
	//+'                                       <tr bgcolor="#454A4D">'
	//+'                                          <td class="headerContent">'
	//+'                                             <!-- // Begin Module: Standard Header Image \\ -->'
	//+'                                             <img src="http://bairanalytics.com/cms/wp-content/uploads/bair-logo.gif" style="max-width:600px;" id="headerImage campaign-icon" mc:label="header_image" mc:edit="header_image" mc:allowdesignermc:allowtext="">'
	//+'                                             <!-- // End Module: Standard Header Image \\ -->'
	//+'                                          </td>'
	//+'                                       </tr>'
	//+'                                    </tbody>'
	+'                                 </table>'
	+'                                 <!-- // End Template Header \\ -->'
	+'                              </td>'
	+'                           </tr>'
	+'                           <tr>'
	+'                              <td align="center" valign="top">'
	+'                                 <!-- // Begin Template Body \\ -->'
	+'                                 <table id="templateBody" border="0" cellpadding="0" cellspacing="0" width="600">'
	+'                                    <tbody>'
	+'                                       <tr>'
	+'                                          <td class="bodyContent" style="color:#505050;font-family:Arial;font-size:14px;line-height:150%;text-align:left;" valign="top">'
	+'                                                <!-- // Begin Module: Left Image with Content \\ -->'
//	+'                                             <table mc:repeatable="siwc_600" mc:variant="content with left image" style="padding: 0" border="0" cellpadding="20" cellspacing="0" width="100%">'
  +'                                             <table mc:repeatable="siwc_600" mc:variant="content with left image" style="padding:20px 20px 5px 20px;" border="0" cellspacing="0" width="100%">'
  +'                                                <tbody>'
	+'                                                   <tr>'
	+'                                                      <td align="left" valign="top">'
	+'                                                         <h2 style="color:#202020;display:block;font-family:Arial;font-size:30px;font-weight:bold;margin-top:0;margin-right:0;margin-bottom:5px;margin-left:0;text-align:left;">DATA Import Report</h2>'
	+'                                                         <h3 style="color:#c2c2a3;display:block;font-family:Arial;font-size:15px;margin-top:0;margin-right:0;margin-bottom:5px;margin-left:0;text-align:left;">' + pstats[1].data_provider_name + '</h3>'
	//+' 																												 <p>Date of Report: '+pStats[1].reportDate+' <br/>This summary covers data imported from '+pStats[1].fromDate+' thru '+ pStats[1].thruDate+'.</p>'
  +' 																												 <p>Date of Report: '+ut.ConvertDate(ut.getDate, '%Y%m%d', '%b %d, %Y')+' <br/>This summary covers data imported from '+pStats[1].dateRangeTable[1].importDate+' to '+ pStats[1].dateRangeTable[2].importDate+' for the AccurintÂ® Crime Analysis and/or Community Crime Map products.</p>'	
	+'                                                      </td>'
  +'                                                      <td align="center" valign="top" width="90">'
	+'                                                         <img src="http://portal.mxlogic.com/images/transparent.gif">'
	+'                                                      </td>'	
	+'                                                   </tr>'
	+'                                                </tbody>'	
//	+'                                                <tbody>'
//	+'                                                   <tr>'
//	+'                                                      <td align="center" valign="top" width="90">'
//	+'                                                         <img src="http://portal.mxlogic.com/images/transparent.gif">'
//	+'                                                      </td>'
//	+'                                                      <td align="left" valign="top">'
//	+'                                                         <h2 style="color:#202020;display:block;font-family:Arial;font-size:30px;font-weight:bold;margin-top:0;margin-right:0;margin-bottom:5px;margin-left:0;text-align:left;">RAIDS Import Report</h2>'
//	+'                                                         <h3 style="margin-bottom:0;margin-top:0;">Bair Analytics</h3>'
//	+'                                                         <a href="http://www.raidsonline.com/?address=Highlands&#43;Ranch%2CCO">View in RAIDS Online'
//	+'                                                         </a>'
//	+'                                                      </td>'
//	+'                                                   </tr>'
//	+'                                                </tbody>'
	+'                                             </table>'
	+'                                             <!-- // End Module: Left Image with Content \\ -->'
	+'                                             <!-- // Begin Module: Standard Content \\ -->'
//	+'                                             <table style="margin-top: 0px;" border="0" cellpadding="20" cellspacing="0" width="100%">'
	+'                                             <table class="contentTable"  border="0"  cellspacing="0" width="100%">'
	+'                                                <tbody>'
	+'                                                   <tr>'
	+'                                                      <td valign="top">'
	+'                                                         <div mc:edit="std_content00">'
	+'                                                            <h2>Summary</h2>'
	+'                                                            <p>A summary of the number of incidents imported successfully.</p>'
	+'                                                            <table class="importTableContent" border="1px" bordercolor="#DDDDDD" cellpadding="2px" cellspacing="0" width="100%">'
	+'                                                               <tbody>'
	+'                                                                  <tr>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6"></th>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Import</th>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">All Time</th>'
	+'                                                                  </tr>'
//+'                                                                  <tr>'
//+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Approved Incidents</th>'
//+'                                                                     <td class="importTableCell">'+pStats[1].summary_Import_Approved_Incidents_cnt+' <strong>('+pStats[1].summary_Import_Approved_Incidents_pct+'%)</strong></td>'
//+'                                                                     <td class="importTableCell">'+pStats[1].summary_All_Time_Approved_Incidents_cnt+' <strong>('+pStats[1].summary_All_Time_Approved_Incidents_pct+'%)</strong></td>'
//+'                                                                  </tr>'
//+'                                                                  <tr>'
//+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Quarantined Incidents</th>'
//	+'                                                                     <td class="importTableCell">10 <strong>(50%)</strong></td>'
//	+'                                                                     <td class="importTableCell">222 <strong>(34.2%)</strong></td>'
//	+'                                                                  </tr>'
//	+'                                                                  <tr>'
//	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">\'Do Not Import\' Incidents</th>'
//	+'                                                                     <td class="importTableCell">0</td>'
//	+'                                                                     <td class="importTableCell"> - </td>'
//	+'                                                                  </tr>'
  + fMakeHTMLTable (SummaryColTable) 
	+'                                                               </tbody>'
	+'                                                            </table>'
	+'                                                            <h2>Counts</h2>'
	+'                                                            <p>The total number of records imported.</p>'
	+'                                                            <table class="importTableContent" border="1px" bordercolor="#DDDDDD" cellpadding="2px" cellspacing="0" width="100%">'
	+'                                                               <tbody>'
	+'                                                                  <tr>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6"></th>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Import</th>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">All Time</th>'
	+'                                                                  </tr>'
//	+'                                                                  <tr>'
//	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Incidents</th>'
//	+'                                                                     <td class="importTableCell">1</td>'
//	+'                                                                     <td class="importTableCell">3</td>'
//	+'                                                                  </tr>'
//	+'                                                                  <tr>'
//	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">MO</th>'
//	+'                                                                     <td class="importTableCell">1</td>'
//	+'                                                                     <td class="importTableCell">3</td>'
//	+'                                                                  </tr>'
//	+'                                                                  <tr>'
//	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">PERSONS</th>'
//	+'                                                                     <td class="importTableCell">0</td>'
//	+'                                                                     <td class="importTableCell">0</td>'
//	+'                                                                  </tr>'
//	+'                                                                  <tr>'
//	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">VEHICLE</th>'
//	+'                                                                     <td class="importTableCell">0</td>'
//	+'                                                                     <td class="importTableCell">0</td>'
//	+'                                                                  </tr>'
  + fMakeHTMLTable (FilesCountColTable) 
	+'                                                               </tbody>'
	+'                                                            </table>'
	+'                                                            <h2>Date Range</h2>'
	+'                                                            <p>The date range for the incidents imported.</p>'
	+'                                                            <table class="importTableContent" border="1px" bordercolor="#DDDDDD" cellpadding="2px" cellspacing="0" width="100%">'
	+'                                                               <tbody>'
	+'                                                                  <tr>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6"></th>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Import</th>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">All Time</th>'
	+'                                                                  </tr>'
//	+'                                                                  <tr>'
//	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Start Date</th>'
//	+'                                                                     <td class="importTableCell">Oct 15, 2015</td>'
//	+'                                                                     <td class="importTableCell">Oct 15, 2015</td>'
//	+'                                                                  </tr>'
//	+'                                                                  <tr>'
//	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">End Date</th>'
//	+'                                                                     <td class="importTableCell">Oct 15, 2015</td>'
//	+'                                                                     <td class="importTableCell">Oct 15, 2015</td>'
//	+'                                                                  </tr>'
  + fMakeHTMLTable (DateRangeColTable)	
	+'                                                               </tbody>'
	+'                                                            </table>'
	+'                                                            <h2>Coordinates</h2>'
	+'                                                            <p>The origin of the coordinates for the incidents imported.</p>'
	+'                                                            <table class="importTableContent" border="1px" bordercolor="#DDDDDD" cellpadding="2px" cellspacing="0" width="100%">'
	+'                                                               <tbody>'
	+'                                                                  <tr>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6"></th>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Import</th>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">All Time</th>'
	+'                                                                  </tr>'
//	+'                                                                  <tr>'
//	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Provided by Agency</th>'
//	+'                                                                     <td class="importTableCell">0 <strong>(0%)</strong></td>'
//	+'                                                                     <td class="importTableCell">0 <strong>(0%)</strong></td>'
//	+'                                                                  </tr>'
//	+'                                                                  <tr>'
//	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Geocoded by BAIR</th>'
//	+'                                                                     <td class="importTableCell">1 <strong>(100%)</strong></td>'
//	+'                                                                     <td class="importTableCell">1 <strong>(100%)</strong></td>'
//	+'                                                                  </tr>'
  + fMakeHTMLTable (CoordinatesColTable)
	+'                                                               </tbody>'
	+'                                                            </table>'
	+'                                                            <h2>Quarantined Records</h2>'
	+'                                                            <p>The records quarantined in this import.</p>'
	+'                                                            <table class="importTableContent" border="1px" bordercolor="#DDDDDD" cellpadding="2px" cellspacing="0" width="100%">'
	+'                                                               <tbody>'
	+'                                                                  <tr>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">IR Number</th>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Reason</th>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Notes</th>'	
	+'                                                                  </tr>'
  + fMakeHTMLTable (QuarantinedColTable)
	+'                                                               </tbody>'
	+'                                                            </table>'
	+'                                                            <h2>Deleted Records</h2>'
	+'                                                            <p>The number of records deleted by request for this import.</p>'
	+'                                                            <table class="importTableContent" border="1px" bordercolor="#DDDDDD" cellpadding="2px" cellspacing="0" width="100%">'
	+'                                                               <tbody>'
	+'                                                                  <tr>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6"></th>'
	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">Count</th>'
	+'                                                                  </tr>'
//	+'                                                                  <tr>'
//	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">MO</th>'
//	+'                                                                     <td class="importTableCell">0</td>'
//	+'                                                                  </tr>'
//	+'                                                                  <tr>'
//	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">PERSONS</th>'
//	+'                                                                     <td class="importTableCell">0</td>'
//	+'                                                                  </tr>'
//	+'                                                                  <tr>'
//	+'                                                                     <th class="importTableHeader" bgcolor="#f6f6f6">VEHICLE</th>'
//	+'                                                                     <td class="importTableCell">0</td>'
//	+'                                                                  </tr>'
  + fMakeHTMLTable (DeletedColTable)
	+'                                                               </tbody>'
	+'                                                            </table>'
	+'                                                            <h2>Unclassified Crime Types</h2>'
	+'                                                            <p>The following crime types are awaiting classification:</p>'
	+'                                                               <ul>'
  + fMakeHTMLTable (UnclassifiedCrimeColTable)
	+'                                                               </ul>'
	+'                                                               <p>Unclassified crimes are incidents with crime types'
	+'                                                                  that have not been mapped to the Accurint Crime Analysis and/or Community Crime Map crime type classifications. This'
	+'                                                                  is likely because the initially historic upload used to classify the'
	+'                                                                  crimes in the setup process did not contain any incidents with this'
	+'                                                                  crime type.'
	+'                                                                  To classify the new crime types, please log into Accurint Crime Analysis'
	+'                                                                  and click through to the <strong>Crime Type Classification</strong> tool'
	//+'                                                                  in the <a href="https://atacraids.com/admin/">Settings</a> panel.                                                            </p>'
  +'                                                                  in the Settings panel.                                                            </p>'
	+'                                                         </div>'
	+'                                                      </td>'
	+'                                                   </tr>'
	+'                                                </tbody>'
	+'                                             </table>'
	+'                                             <!-- // End Module: Standard Content \\ -->'
	+'                                          </td>'
	+'                                       </tr>'
	+'                                    </tbody>'
	+'                                 </table>'
	+'                                 <!-- // End Template Body \\ -->'
	+'                              </td>'
	+'                           </tr>'
	+'                           <tr>'
	+'                              <td align="center" valign="top">'
	+'                                 <!-- // Begin Template Footer \\ -->'
	+'                                 <table id="templateFooter" border="0" cellpadding="10" cellspacing="0" width="600">'
	+'                                    <tbody>'
	+'                                       <tr>'
	+'                                          <td class="footerContent" style="color:#707070;font-family:Arial;font-size:12px;line-height:125%;text-align:left;" valign="top">'
	+'                                             <!-- // Begin Module: Standard Footer \\ -->'
	+'                                             <table border="0" cellpadding="10" cellspacing="0" width="100%">'
	+'                                                <tbody>'
	+'                                                   <tr>'
	+'                                                      <td colspan="2" id="social" style="background-color:#FAFAFA; border:0; text-align:center;" valign="middle">'
	//+'                                                         <div>&nbsp;<a href="https://twitter.com/raidsonline">Follow on Twitter</a> |'
	//+'                                                             <a href="http://www.facebook.com/pages/raidsonlinecom/296696534940">Friend on Facebook</a>'
	//+'                                                         </div>'
	+'                                                      </td>'
	+'                                                   </tr>'
	+'                                                   <tr>'
	+'                                                      <td valign="top" width="350">'
	+'                                                         <div class="footerEntry">'
//	+'                                                            <em>Copyright Â© 2012 BAIR Analytics Inc., All rights reserved.</em><br>'
//	+'                                                            <strong>BAIR Analytics Inc.</strong><br>'
//	+'                                                            640 Plaza Drive, Suite 340, Highlands Ranch, CO 80129'
	+'                                                         </div>'
	+'                                                      </td>'
	+'                                                      <td id="monkeyRewards" valign="top" width="190">'
//	+'                                                         <div class="footerEntry"><strong>Phone:&nbsp;</strong>(303) 346-6000</div>'
//	+'                                                         <div class="footerEntry"><span style="white-space: nowrap;"><strong>Email:&nbsp;</strong><a href="mailto:support@bairanalytics.com">support@bairanalytics.com</a></span></div>'
//	+'                                                         <div mc:edit="monkeyrewards"><a href="http://www.bairanalytics.com/">'
//	+'                                                            www.bairanalytics.com</a></div>'
	+'                                                      </td>'
	+'                                                   </tr>'
	+'                                                </tbody>'
	+'                                             </table>'
	+'                                             <!-- // End Module: Standard Footer \\ -->'
	+'                                          </td>'
	+'                                       </tr>'
	+'                                    </tbody>'
	+'                                 </table>'
	+'                                 <!-- // End Template Footer \\ -->'
	+'                              </td>'
	+'                           </tr>'
	+'                        </tbody>'
	+'                     </table><br>'
	+'                  </td>'
	+'               </tr>'
	+'            </tbody>'
	+'         </table>'
	+'      </center>'
	+'      <!--'
	+'         Import instance ID:  21'
	+'         Cluster ID:  0'
	+'         Node ID:  1'
	+'         ORI:  BAIR'
	+'         Data provider ID:  1'
	+'         Transmission type:  File'
	+'         Input file name:  importTest_4500901400357167311.xml'
	+'         Input data format:  xml'
	+'         Archived data length:    3,026'
	+'         Do translation?  false'
	+'         Translated data length:  3,026'
	+'         Start date/time:  Tue Oct 20 2015 12:05:29 PM MDT'
	+'         End date/time:    Tue Oct 20 2015 12:05:30 PM MDT'
	+'         Elapsed time:     0 h, 0 m, 0.9 s'
	+'         Send date/time:   Tue Oct 20 2015 1:05:30 PM MDT'
	+'      -->'
	+'  </body>'
	+'</html>'
	;

	return text;

end;

END;

