
// NOTE: Empty fields are dropped from the table. Use noblank and no space value (e.g. 'N/A', 'Empty')

EXPORT mac_convert_ds := MODULE

	EXPORT toHTML
 (raw_data, col1,col2='td2',col3 ='td3', col4 = 'td4', col5 = 'td5', col6 = 'td6' ,skipParentTages = false) := functionmacro
			IMPORT std;
			pre_p := record
				string html := '';
				string td1 := '';
				string td2 := '';
				string td3 := '';
				string td4 := '';
				string td5 := '';
				string td6 := '';
			end;
			pre := record
				pre_p;
				recordof(raw_data);
			end;
			p_raw_data := project(raw_data,pre);
			pre toHtmlColumns(recordof(p_raw_data) L) := TRANSFORM

					SELF.html := '';
					SELF.td1 := (string)L.col1;
					SELF.td2 := (string)L.col2;
					SELF.td3 := (string)L.col3;
					SELF.td4 := (string)L.col4;
					SELF.td5 := (string)L.col5;
					SELF.td6 := (string)L.col6;
					SELF := L;

			END;
			
			pre toHtmlHeading(recordof(p_raw_data) L) := TRANSFORM

					p := (string)toxml(row(L,recordof(p_raw_data)));
					ps := STD.Str.SplitWords(p,'><');

					SELF.html := '';
					SELF.td1 := regexreplace('[<>]',regexfind('[^/][^>]*>',trim(ps[1]),0),'');
					SELF.td2 := regexreplace('[<>]',regexfind('[^/][^>]*>',trim(ps[2]),0),'');
					SELF.td3 := regexreplace('[<>]',regexfind('[^/][^>]*>',trim(ps[3]),0),'');
					SELF.td4 := regexreplace('[<>]',regexfind('[^/][^>]*>',trim(ps[4]),0),'');
					SELF.td5 := regexreplace('[<>]',regexfind('[^/][^>]*>',trim(ps[5]),0),'');
					SELF.td6 := regexreplace('[<>]',regexfind('[^/][^>]*>',trim(ps[6]),0),'');
					SELF := L;
			
			END;
			
			pre_r := 	project(p_raw_data[1],toHtmlHeading(LEFT))+
								project(p_raw_data,toHtmlColumns(LEFT));
			//deb := output(pre_r);
			
			
			pre_r toHTML(pre_r L, pre_r R) := TRANSFORM

				temp1 := '<tr>' +(string)TOXML(ROW(L,recordof(pre_p)-html))+ '</tr>'
								+'<tr>' +(string)TOXML(ROW(R,recordof(pre_p)-html))+ '</tr>';
				temp2 := regexreplace('td[0-9]*>',temp1,'td>',nocase);
				SELF.html :=  L.html + regexreplace('(<td>[^<]*</td>)',temp2,'\\1');
				SELF := [];

			END;
			
			v1 := std.str.findreplace(set(rollup(pre_r,true,toHTML(LEFT,RIGHT)),html)[1],'<tr></tr>','');
			v3 := '<HTML><HEAD><STYLE>tr:first-child {    background: #C0C0C0;    font-weight: bold;}</STYLE></HEAD><BODY>'+
'<table border="1" cellpadding="3px" cellspacing="0px" style="border: 1px solid #000000;border-collapse: collapse;">'
+v1+'</table>'

+'</BODY></HTML>';

			return v3;

endmacro;
end;