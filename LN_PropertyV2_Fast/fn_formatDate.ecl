IMPORT ut;

EXPORT string8 fn_formatDate(string8 date) := FUNCTION
			RETURN case(	length(ut.CleanSpacesAndUpper(date)),
					8	=>	date[5..8]	+	date[1..4], // format??: mmddyyyy -> yyyymmdd
					6	=>	date[3..6]	+	date[1..2], // format??: mmyyyy		-> yyyymm
					date
					);
		END;