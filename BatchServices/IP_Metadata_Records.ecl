IMPORT IP_Metadata, Std;

EXPORT IP_Metadata_Records(
	DATASET(BatchServices.IP_Metadata_Layouts.batch_in) batch_in
	) := FUNCTION

	srchRec := RECORD
		UNSIGNED octet1;
		UNSIGNED octet2;
		UNSIGNED octets34;
		BatchServices.IP_Metadata_Layouts.batch_in;
	END;

	srchRecs := PROJECT(batch_in,TRANSFORM(srchRec,
		octets:=Std.Str.SplitWords(LEFT.ip_address,'.');
		SELF.octet1:=(UNSIGNED)octets[1];
		SELF.octet2:=(UNSIGNED)octets[2];
		SELF.octets34:=(UNSIGNED)(INTFORMAT((UNSIGNED)octets[3],3,1)+INTFORMAT((UNSIGNED)octets[4],3,1));
		SELF:=LEFT)
	);

	batch_out := JOIN(srchRecs,IP_Metadata.Key_IP_Metadata_IPv4,
		KEYED(LEFT.octet1=RIGHT.beg_octet1) AND KEYED(LEFT.octet1=RIGHT.end_octet1) AND
		KEYED(LEFT.octet2=RIGHT.beg_octet2) AND KEYED(LEFT.octet2=RIGHT.end_octet2) AND
		KEYED(LEFT.octets34 BETWEEN RIGHT.beg_octets34 AND RIGHT.end_octets34),
		TRANSFORM(BatchServices.IP_Metadata_Layouts.batch_out,SELF:=LEFT,SELF:=RIGHT),
		LEFT OUTER, KEEP(1));

	RETURN batch_out;
END;
