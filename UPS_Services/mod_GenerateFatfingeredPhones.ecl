// "Fatfingering" in this context is when, during data entry, an adjacent key
// is struck instead of or in addition to the intended key. We'll also include
// a repeat-strike in this sort of error. For example, if I intended to type
// the digit "4" above the keyboard, I might accidentally type: "3", "5", "34",
// "43", "45", "54", or "44".
//
// This routine focuses on fatfingering in the context of phone numbers only,
// so we're looking at digits adjacent to other digits. For the digits above
// letters on a keyboard, that means we can err to the left or right. When the
// numeric keypad is also considered, additional errors are possible.

EXPORT mod_GenerateFatfingeredPhones(STRING10 p, BOOLEAN withKeypad=FALSE) := MODULE

  EXPORT outrec := {STRING10 phone};
  
  // lists of adjacent digits
  SHARED SET of STRING1 adjacent(STRING1 d) :=
    CASE(withKeypad,
      FALSE => CASE(d,
        '1' => ['2'],
        '2' => ['1','3'],
        '3' => ['2','4'],
        '4' => ['3','5'],
        '5' => ['4','6'],
        '6' => ['5','7'],
        '7' => ['6','8'],
        '8' => ['7','9'],
        '9' => ['8','0'],
        '0' => ['9'],
        []),
      TRUE => CASE(d,
        '1' => ['0','2','4'],
        '2' => ['1','3','5'],
        '3' => ['2','4','6'],
        '4' => ['1','3','5','7'],
        '5' => ['2','4','6','8'],
        '6' => ['3','5','7','9'],
        '7' => ['4','6','8'],
        '8' => ['5','7','9'],
        '9' => ['6','8','0'],
        '0' => ['1','2','9'],
        []),
      []);
  
  // errant phone numbers for an error in one particular digit
  SHARED DATASET(outrec) tweak(DATASET(outrec) base, UNSIGNED1 digit, SET of STRING1 adj) :=
    NORMALIZE(base, COUNT(adj), TRANSFORM(outrec, SELF.phone := LEFT.phone[1..(digit-1)] + adj[COUNTER] + LEFT.phone[(digit+1)..10])) + // ERROR in-place
    NORMALIZE(base, COUNT(adj), TRANSFORM(outrec, SELF.phone := LEFT.phone[1..(digit-1)] + adj[COUNTER] + LEFT.phone[digit..10])) + // ERROR before
    NORMALIZE(base, COUNT(adj), TRANSFORM(outrec, SELF.phone := LEFT.phone[1..digit] + adj[COUNTER] + LEFT.phone[(digit+1)..10])) + // ERROR after
    PROJECT(base, TRANSFORM(outrec, SELF.phone := LEFT.phone[1..digit] + LEFT.phone[digit] + LEFT.phone[(digit+1)..10])); // ERROR repeat
  
  // assimilate errant numbers for errors in each of 10 digits
  EXPORT DATASET(outrec) ds := DEDUP(
    tweak(DATASET([p],outrec), 1, adjacent(p[1])) +
    tweak(DATASET([p],outrec), 2, adjacent(p[2])) +
    tweak(DATASET([p],outrec), 3, adjacent(p[3])) +
    tweak(DATASET([p],outrec), 4, adjacent(p[4])) +
    tweak(DATASET([p],outrec), 5, adjacent(p[5])) +
    tweak(DATASET([p],outrec), 6, adjacent(p[6])) +
    tweak(DATASET([p],outrec), 7, adjacent(p[7])) +
    tweak(DATASET([p],outrec), 8, adjacent(p[8])) +
    tweak(DATASET([p],outrec), 8, adjacent(p[9])) +
    tweak(DATASET([p],outrec), 10, adjacent(p[10])),
    all);
  
  // output sets
  EXPORT SET of STRING10 set_phone10 := SET(ds, phone);
  EXPORT SET of STRING7 set_phone7 := SET(DEDUP(ds, phone[4..10], all), phone[4..10]);
  EXPORT SET of STRING3 set_phone3 := SET(DEDUP(ds, phone[1..3], all), phone[1..3]);

END;
