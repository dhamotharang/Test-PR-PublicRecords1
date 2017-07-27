EXPORT SequenceKey := MODULE
	EXPORT Layout_PostingFields := RECORD
		UNSIGNED2		seg;			// use specific types instead of types from Types module
		UNSIGNED4		kwp;
		UNSIGNED2		wip;
	END;
	EXPORT Layout_PostingFields Seq2Fields(UNSIGNED2 node, UNSIGNED6 ordinal) :=
					ROW({node, ordinal >>16, ordinal % 65536}, Layout_PostingFields);
	EXPORT UNSIGNED8 Fields2SeqOrdinal(UNSIGNED2 seg, UNSIGNED4 kwp, UNSIGNED2 wip) :=
					(seg << 48) + (kwp << 16) + wip;
END;