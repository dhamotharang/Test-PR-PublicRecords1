EXPORT MAC_Dedup_BDID_TEMPID
(
	infile,
	outfile,
	BDID_Field,
	BDID_Score,
	name_similar_score
) := MACRO

// Take the best score within the same BDID matching the same input record.
// No need to distribute: Matching temp_id's are always local since
// the current distribution is based on a subset of the fields in the
// distribution by which they were assigned.
outfile := DEDUP(
	SORT(infile, temp_id, BDID_field, -BDID_Score, -name_similar_score, LOCAL),
	temp_id, BDID_field, LOCAL);

ENDMACRO;