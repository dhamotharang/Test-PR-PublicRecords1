r1 := RECORD
	string		text;
END;

EXPORT hdr_Subcategory(dataset(Layout_SubCategory) dsSubCategories) := FUNCTION
	ds := PROJECT(dsSubCategories, transform(r1,
				self.text := '<value id="' + TRIM(left.subcategory_id) + '" name="' + TRIM(left.subcategory) + '"/>\r\n';
				));
		r1 xform(r1 L, r1 R) := TRANSFORM
				self.text := L.text+R.text;
		END;
		roll := ROLLUP(ds, true, xform(left,right));

		return roll[1].text;
END;
