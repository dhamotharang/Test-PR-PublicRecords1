// Common routine for creating a safe hash of ln_fares_id
// values from low order 5 bytes, which are used to generate the
// base document number.
EXPORT UNSIGNED8 fn_hash_fares(STRING fares_id) := FUNCTION
	UNSIGNED8 t := (UNSIGNED5) HASH64(TRIM(fares_id));
	RETURN t;
END;