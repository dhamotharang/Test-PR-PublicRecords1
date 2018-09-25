#workunit('name','PH:segment reports (n)FCRA Marketing');
// ******************************************************************************************
import STD, data_services,Watchdog,doxie_build;

  // inputs:
  lc:=data_services.foreign_prod;
  shared Watchdog_File_Best_marketing := dataset(lc+'thor_data400::base::watchdog_best_marketing',{Watchdog.File_Best_marketing},thor);
  shared doxie_build_file_fcra_header_building := 
    dataset('~thor_data400::base::file_fcra_header_building_prod',{doxie_build.file_fcra_header_building},thor);
  shared doxie_build_file_header_building := 
    dataset('~thor_data400::base::file_header_building_prod',{doxie_build.file_header_building},thor);


export mod_email_reporting := module

  // two column data rows
  export recValuePair := record
    string v1;
    string v2;
  end;

  // size and style of text
  export recTextStyle := record
    integer sizeInPercentOfDefault;
    boolean boldFlag;
    boolean italicFlag;
  end;

  // block of formatted two column data
  export recValuePairBlock := record
    string heading1;
    string heading2;
    dataset(recValuePair) rows;
    dataset(recTextStyle) columnLabelStyle;
    dataset(recTextStyle) valuesStyle;
    string upperLeftCell;
  end;

  // header rows
  export recHeader := record
    dataset(recTextStyle) style;
    string txt;
  end;
	
	
	
	export string fnCreateAttachment(
			string subjectText,
			dataset(recHeader) rsHeader,
			dataset(recValuePairBlock) rsValuePairBlock
		) := function

		recHtml := record
			string html;
		end;

		string tdTag(dataset(recTextStyle) style) := function
			integer size := style[1].sizeInPercentOfDefault;
			boolean bold := style[1].boldFlag;
			boolean italic := style[1].italicFlag;
			return '<td'
					+ if(bold or italic, ' class="' + if(bold, if(italic, 'bolditalic', 'bold'), 'italic') + '"', '')
					+ if(size != 100, ' style="font-size: ' + (size/100) + 'em"', '')
					+ '>';
		end;

		recHtml xHeader(recHeader l, recHtml r) := transform
			integer size := l.style[1].sizeInPercentOfDefault;
			boolean bold := l.style[1].boldFlag;
			boolean italic := l.style[1].italicFlag;
			self.html := r.html
					+ '\t\t\t<tr>'
					+ tdTag(l.style)
					+ if(l.txt = '', '&nbsp;', l.txt) + '</td></tr>\n';
		end;

		rsOutHeader := aggregate(rsHeader, recHtml, xHeader(left, right),local,few);

		recHtml xValuePairTable(recValuePair l, recHtml r, string valuesTd) := transform
			self.html := r.html
					+ '\t\t\t\t\t\t<tr>'
					+ valuesTd + if(l.v1 = '', '&nbsp;', l.v1) + '</td>'
					+ valuesTd + if(l.v2 = '', '&nbsp;', l.v2) + '</td></tr>\n';
		end;

		recHtml xValuePairBlock(recValuePairBlock l, recHtml r) := transform
			string labelTd := tdTag(l.columnLabelStyle);
			string valuesTd := tdTag(l.valuesStyle);
			self.html := r.html
					+ '\t\t\t\t<td>' + if(r.html = '', '\n', '&nbsp;</td>\n\t\t\t\t<td>\n')
					+ '\t\t\t\t\t<table class="data-table">\n'
					+ '\t\t\t\t\t<tr style="background-color:#acd1ff;">' + labelTd + l.heading1 + '</td>' + labelTd + l.heading2 + '</td></tr>\n'
					+ aggregate(l.rows, recHtml, xValuePairTable(left, right, valuesTd))[1].html
					+ '\t\t\t\t\t</table>\n\t\t\t\t</td>\n';
		end;

		rsOutBlock := aggregate(rsValuePairBlock, recHtml, xValuePairBlock(left, right),local,few);

		string sHtml := '<!DOCTYPE html>\n<html lang="en">\n<head>\n\t<meta charset="utf-8">\n'
				+ '\t<title>' + subjectText + '</title>\n\t<style>\n'
				+ '\t\thtml, body, object, iframe, div, ul, ol, li, table, tbody, tr, th, td'
						+ ', p, h1, h2, h3, h4, br, img, form { margin: 0; border: 0; padding: 0; }\n'
				+ '\t\thr, input, textarea { margin: 0; padding: 0; }\n'
				+ '\t\ttable, img { border-style: none; }\n'
				+ '\t\ttable { border-spacing: 0; }\n'
				+ '\t\ttr, td, th { vertical-align: middle }\n'
				+ '\t\tbody, ul, ol, li, td, h1, h2 { text-align: left; }\n'
				+ '\t\tth { text-align: center; }\n'
				+ '\t\t.italic { font-style: italic; }\n'
				+ '\t\t.bold { font-weight: bold; }\n'
				+ '\t\t.bolditalic { font-weight: bold; font-style: italic;}\n'
				+ '\t\t.data-table { border-width: 1px 1px 1px 1px; margin: 1em .6em 1.8em .6em; }\n'
				+ '\t\t.data-table, .data-table th, .data-table td { border-style: solid; border-color: #000; }\n'
				+ '\t\t.data-table th, .data-table td { border-width: 0 1px 1px 0; padding: .15em .5em; }\n'
				+ '\t\t.header-table { margin: 1em .6em 1.8em .6em; }\n'
				+ '\t\t.header-table th, .header-table td { padding: .15em .5em;}\n'
				+ '\t</style>\n</head>\n'
				+ '<body>\n\t<div>\n\t\t<table class="header-table">\n'
				+ rsOutHeader[1].html
				+ '\t\t</table>\n\t</div>\n\t<div>\n\t\t<table>\n\t\t\t<tr>\n'
				+ rsOutBlock[1].html
				+ '\t\t\t</tr>\n\t\t</table>\n\t</div>\n</body>\n</html>\n';

		return sHtml;
	end;



  export string fnEmailWithAttachedReport(
      string recipientAddress,
      string subjectText,
      string bodyText,
			string fileMimeType,
      string defaultFileName,
      dataset(recHeader) rsHeader,
      dataset(recValuePairBlock) rsValuePairBlock
    ) := function

		attachment := fnCreateAttachment(subjectText, rsHeader, rsValuePairBlock);

    STD.System.Email.SendEmailAttachText(
				recipientAddress,
				subjectText,
				bodyText,
				attachment,
				fileMimeType,
				defaultFileName);

    return attachment;

  end;



	// this is an example of the use of the above function
	// you will, of course, need to add this module name before the record layout name
	//
	// NOTE: To get the email client to use Excel instead of the default browser to display
	// the report, use the MIME type of 'application/excel' instead of 'text/html'
	// and use a file extension of 'xls' instead of 'html'.
	export fnEmailExampleUse := function
	
		// record sets to report
		rsTotalRecs := dataset([
			{ '0', '7' },
			{ '200507', '12,260' }
			], recValuePair);
			
		rsUniqueSearchAddrs := dataset([
			{ '0', '6' },
			{ '200507', '1,461' }
			], recValuePair);

		// styles to use in the form { integer sizeInPercentOfDefault; boolean boldFlag; boolean italicFlag; }
		normalTextStyle := dataset ([{ 100, false, false }], recTextStyle);
		largeBoldTextStyle := dataset ([{ 120, true, false }], recTextStyle);
		boldTextStyle := dataset ([{ 100, true, false }], recTextStyle);
		largeItalicTextStyle := dataset ([{ 120, false, true }], recTextStyle);
		italicTextStyle := dataset ([{ 100, false, true }], recTextStyle);

		// overall report header
		rsHeader := dataset([
			{ largeItalicTextStyle, 'CONFIDENTIAL AND PROPRIETARY' },
			{ largeItalicTextStyle, 'DO NOT DISTRIBUTE' },
			{ normalTextStyle, '' },
			{ largeBoldTextStyle, 'Inquiry Accounting Logs: "High Risk" data' },
			{ largeBoldTextStyle, 'Stats by month' },
			{ italicTextStyle, '201412' },
			{ italicTextStyle, 'DATALAND W20141222-143704' }
			], recHeader);

		// header and styles for record sets
		rsValuePairBlock := dataset([
			{ 'search period', 'TOTAL RECORDS', rsTotalRecs, boldTextStyle, normalTextStyle, '12A' },
			{ 'search period', 'UNIQUE SEARCH ADDRESS', rsUniqueSearchAddrs, boldTextStyle, normalTextStyle, '12D' }
			], recValuePairBlock);

		// call the function to do the work
		string attachment := fnEmailWithAttachedReport(
				'Douglas.Decicco@lexisnexis.com',
				'Example Report',
				'See attached.',
				'text/html',
				'report.html',
				rsHeader,
				rsValuePairBlock);
				
		return output(attachment, named('attachment'));

	end;
end;


// ******************************************************************************************
// ******************************************************************************************

hf0 := dedup(sort(join(distribute(doxie_build_file_fcra_header_building,hash64(did)), distribute(Watchdog.File_Best,hash64(did)), LEFT.did = RIGHT.did,local),did,local),did,local);
hn0 := dedup(sort(join(distribute(doxie_build_file_header_building,hash64(did))			, distribute(Watchdog.File_Best,hash64(did)), LEFT.did = RIGHT.did,local),did,local),did,local);
hm0 := dedup(sort(join(distribute(Watchdog_File_Best_marketing,hash64(did)) 				, distribute(Watchdog.File_Best,hash64(did)), LEFT.did = RIGHT.did,local),did,local),did,local);

output(count(dedup(sort(doxie_build_file_fcra_header_building	,did,local),did,local)),named('count_file_fcra_header_building'));
output(count(dedup(sort(doxie_build_file_header_building			,did,local),did,local)),named('count_file_header_building')		 );
output(count(dedup(sort(Watchdog_File_Best_marketing					,did,local),did,local)),named('count_File_Best_marketing')			 );

output(count(hf0),named('count_fcra'));
output(count(hn0),named('count_nfcra'));
output(count(hm0),named('count_marketing'));

seg_f   := table(hf0   ,{adl_ind,cnt := count(group)},adl_ind,few);
seg_n   := table(hn0   ,{adl_ind,cnt := count(group)},adl_ind,few);
seg_m   := table(hm0   ,{adl_ind,cnt := count(group)},adl_ind,few);

output(seg_f,named('count_seg_fcra'));
output(seg_n,named('count_seg_nfcra'));
output(seg_m,named('count_seg_marketing'));
output(hm0(trim(adl_ind)=''));

send_report(dataset(recordof(seg_f)) ds,string emailList, string bVersion,string ref, string vType) := function
	
		// record sets to report
		rsTotalRecs := project(ds,transform(mod_email_reporting.recValuePair, self.v1 := LEFT.adl_ind, self.v2 := (string)LEFT.cnt));

		// styles to use in the form { integer sizeInPercentOfDefault; boolean boldFlag; boolean italicFlag; }
		normalTextStyle := dataset ([{ 100, false, false }], mod_email_reporting.recTextStyle);
		largeBoldTextStyle := dataset ([{ 120, true, false }], mod_email_reporting.recTextStyle);
		boldTextStyle := dataset ([{ 100, true, false }], mod_email_reporting.recTextStyle);
		largeItalicTextStyle := dataset ([{ 120, false, true }], mod_email_reporting.recTextStyle);
		italicTextStyle := dataset ([{ 100, false, true }], mod_email_reporting.recTextStyle);

		// overall report header
		rsHeader := dataset([
			{ boldTextStyle,   'Person Header LexID Segmentation' },
			{ italicTextStyle, 'Update Frequency: Monthly' },			
			{ italicTextStyle, 'Build version: '+bVersion }		,	
			{ normalTextStyle, '' },
			{ italicTextStyle, 'Reference: '+ref },
			{ boldTextStyle,   vType }
			], mod_email_reporting.recHeader);

		// header and styles for record sets
		rsValuePairBlock := dataset([
			{ 'Segment', 'Record Count', rsTotalRecs, boldTextStyle, normalTextStyle, '12A' }
			], mod_email_reporting.recValuePairBlock);

		// call the function to do the work
		string attachment := mod_email_reporting.fnEmailWithAttachedReport(
				emailList,
				bVersion+' Header '+vType+' LexID Segmentation Stats',
				'Double-click attachment (do not use outlook preview feature)',
				'application/excel',
				bVersion+' Header '+vType+' LexID Segmentation Stats.xls',
				rsHeader,
				rsValuePairBlock);
				
		return output(attachment);
end;
		
wu := (string)STD.System.Job.WUID();
emailList := 'Gabriel.Marcan@lexisnexisrisk.com;debendra.kumar@lexisnexisrisk.com';

getVname (string superfile, string v_end = ':') := FUNCTION

	FileName:=fileservices.GetSuperFileSubName(superfile,1);
	v_strt  := stringlib.stringfind(FileName,'_20',1)+1;
	v_endd	:= stringlib.stringfind(FileName[v_strt..],v_end,1);
	v_name  := FileName[v_strt..v_strt+if(v_endd<1,length(FileName),v_endd)-2];

	RETURN v_name;

END;

hv := trim(nothor(getVname(data_services.foreign_prod +'thor_data400::base::file_header_building')));
mv := trim(nothor(getVname(data_services.foreign_prod + 'thor_data400::BASE::Watchdog_Best_marketing')));

output(hv, named('Header_Version'));
output(mv, named('Watchdog_Marketing_Version'));

send_report(seg_n,emailList,hv,wu,'nFCRA');  //hv
send_report(seg_f,emailList,hv,wu,'FCRA');   //hv
send_report(seg_m,emailList,mv,wu,'Marketing');

// W:\Projects\Header\Reports\Mike Reports\15-9m_Mike_Stats4.ecl
// NO NEED TO UPDATE VERISON (PICKS UP AUTOMATICALLY FROM FILES)
//
// Previous runs
// -------------
// 20180724 W20180907-113130
/*

20180320

// */
// 20180221 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180418-122833#/stub/Summary
// 20180130 W20180315-141600
// 20171227 W20180220-082640
// W20180124-112926 20171121
// W20171110-095607 20170925
// W20171023-161319 20170828
// W20170818-155052 20170628
// W20170808-165353 20170522
// W20170623-090419 20170430
// W20170509-115824 
// W20170404-140340 20170223
// W20170306-104101
// W20161228-070515
// W20161201-101318
// W20161010-115543
// 15-9m Mike Stats3.ecl
// W20151202-091436
