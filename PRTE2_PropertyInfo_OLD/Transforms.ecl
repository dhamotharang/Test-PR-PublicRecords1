

EXPORT Transforms := MODULE

		EXPORT Layouts.editable_spreadsheet Gateway_Reduce(Layouts.batch_in L) := TRANSFORM
				SELF  := L;
				SELF  := [];
		END;

		EXPORT Layouts.batch_in Spreadsheet_Expand(Layouts.editable_spreadsheet L) := TRANSFORM
				SELF  := L;
				SELF  := [];
		END;

END;