r1 := RECORD
	string		text;
END;

EXPORT hdr_Keyword(dataset(Layout_Keyword) dsKeywords) := FUNCTION
	ds := PROJECT(dsKeywords, transform(r1,
				self.text := '<value id="' + TRIM(left.keyword_id) + '" name="' + TRIM(left.keyword) + '"/>\r\n';
				));
		r1 xform(r1 L, r1 R) := TRANSFORM
				self.text := L.text+R.text;
		END;
		roll := ROLLUP(ds, true, xform(left,right));

		return roll[1].text;
END;
