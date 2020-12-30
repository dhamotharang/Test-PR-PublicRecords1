EXPORT SortAttrs := MODULE
    EXPORT SimpleAsc(DATASET(Results.ValidationLayout) d) := FUNCTION
		Resort(DATASET(Results.NVPair) attrs,DATASET(Results.RC_Contributions_Layout) conts) := FUNCTION
	  	    NVTriple := RECORD(Results.NVPair)
		  	    REAL SortVal;
			END;

			NVTriple jtr(Results.NVPair le, Results.RC_Contributions_Layout ri) := TRANSFORM
		  	    SELF.SortVal := IF (ri.name='',-99999,ri.contribValue);
		  	    SELF := le;
			END;

			j := JOIN(attrs,conts,LEFT.name=RIGHT.name,jtr(LEFT,RIGHT),LEFT OUTER);
			RETURN PROJECT(SORT(j,-SortVal,Name),Results.NVPair);
		END;

  	    Results.ValidationLayout tr(d le) := TRANSFORM
			SELF.Attributes := Resort(le.Attributes,le.reason_codes_base);
	  	    SELF := le;
		END;
		RETURN PROJECT(d,tr(LEFT));
    END;
END;
