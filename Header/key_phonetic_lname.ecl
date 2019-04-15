// the purpose is to have an index of (all available) last names by phonetic key.
// lname is unique;
// phonetic key to lname relation is 1:m (one phonetization MAY correspond to many words)
// index contain some counters, which can be used later.
IMPORT dx_header;

EXPORT key_phonetic_lname := dx_header.key_phonetic_lname();
