IMPORT Std;
EXPORT BOOLEAN IsValidDatefield(
	STRING InDate, // YYYYMMDD
	BOOLEAN AllowNullDD=false, BOOLEAN AllowNullMM=false, BOOLEAN AllowMDDM=false
) := FUNCTION
	d1 := InDate[1..4] + 
				IF(AllowNullMM AND InDate[5..6]='00','01',InDate[5..6]) + 
				IF(AllowNullDD AND InDate[7..8]='00','01',InDate[7..8]);
	d2 := d1[1..4]+d1[7..8]+d1[5..6];
	RETURN Std.Date.IsValidDate((INTEGER)d1) OR (AllowMDDM AND Std.Date.IsValidDate((INTEGER)d2));
END;
