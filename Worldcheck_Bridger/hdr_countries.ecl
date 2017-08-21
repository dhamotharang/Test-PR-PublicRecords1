r1 := RECORD
	string		text;
END;

EXPORT string hdr_countries(dataset(Layout_Country) dsCountries) := FUNCTION
	ds := PROJECT(SORT(dsCountries,country), transform(r1,
				self.text := '<value id="' + TRIM(left.country_id) + '" name="' + TRIM(left.country) + '"/>\r\n';
				));
		r1 xform(r1 L, r1 R) := TRANSFORM
				self.text := L.text+R.text;
		END;
		roll := ROLLUP(ds, true, xform(left,right));

		return roll[1].text;
END;