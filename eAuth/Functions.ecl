IMPORT  iesp,  ut;

export Functions := MODULE

// chooses a number of random records out of given dataset
export MAC_RANDOM (ds_in, max_return, ds_out) := MACRO
  #uniquename (rec_in);
  #uniquename (rec_seq);
  #uniquename (ds_seq);
  %rec_in% := recordof (ds_in);
  %rec_seq% := record (%rec_in%)
    integer seq;
  end;
  %ds_seq% := project (ds_in, transform (%rec_seq%, Self.seq := random (), Self := Left;));
  ds_out := project (choosen (sort (%ds_seq%, seq), max_return), %rec_in%);
ENDMACRO;

// chooses a number of random records out of given dataset
export MAC_PICK_RANDOM_RECS (ds_in, max_return) := FUNCTIONMACRO
  LOCAL rec_in := recordof (ds_in);
  LOCAL rec_seq := record (rec_in)
    integer seq;
  end;
  LOCAL ds_seq := project (ds_in, transform (rec_seq, Self.seq := random (), Self := Left;));
  LOCAL ds_out := project (choosen (sort (ds_seq, seq), max_return), rec_in);

  RETURN ds_out;
ENDMACRO;

// returns a random integer from the interval [0..high), or RAND_MAX (?) for high=0
export integer GetRandom (integer high = 0) := IF (high = 0, random(), (random() % high));

// primitive data validation
export boolean IsValidDate (iesp.share.t_Date date, boolean ignore_day = false)
  := (date.Year != 0) and (date.Month != 0) and (ignore_day or (date.Day != 0));

// returns nicely formatted address line 1
export string FormatAddressLine1 (iesp.share.t_Address r) := function
  return trim (r.StreetNumber) +
         if (trim (r.StreetPreDirection)  != '', ' ' + trim (r.StreetPreDirection),  '') +
         if (trim (r.StreetName)          != '', ' ' + trim (r.StreetName),          '') +
         if (trim (r.StreetPostDirection) != '', ' ' + trim (r.StreetPostDirection), '') +
         if (trim (r.StreetSuffix)        != '', ' ' + trim (r.StreetSuffix),        '');
end;

export string FormatAddressLine2 (string city, string st) := trim (city) + ', ' + trim (st);
export set of string months_set := ['January', 'February', 'March', 'April', 'May', 'June',
                             'July', 'August', 'September', 'October', 'November', 'December'];

// Generates "none of the above -- yes|no" question
export dataset (iesp.eauth.t_Answer) none_of_above (boolean none) := dataset ([{'None of the above', none}], iesp.eauth.t_Answer);


// * cnt_actual = 0 means: no data available for this type of question;
// * input ans_correct = 0 generally means produce "none of the above" = true
// * if input ans_all < ans_correct, then ans_correct=ans_all
// Note: fake data generally has no dupes, hence atmost (1) in joins

end;