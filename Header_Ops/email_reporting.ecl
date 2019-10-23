IMPORT STD;
export email_reporting := module

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
