r1 := RECORD
	string		text;
END;

EXPORT hdr_category(dataset(Layout_Category) dsCategories) := FUNCTION
	ds := PROJECT(dsCategories, transform(r1,
				self.text := '<value id="' + TRIM(left.category_id) + '" name="' + TRIM(left.category) + '"/>\r\n';
				));
		r1 xform(r1 L, r1 R) := TRANSFORM
				self.text := L.text+R.text;
		END;
		roll := ROLLUP(ds, true, xform(left,right));

		return roll[1].text;
END;

