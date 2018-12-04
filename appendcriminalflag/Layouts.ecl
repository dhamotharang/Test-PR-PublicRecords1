EXPORT Layouts := MODULE
  EXPORT BocashellCriminalLayout := RECORD
  	unsigned6	did;
    UNSIGNED1 criminal_count;
    unsigned4 last_criminal_date;
    UNSIGNED1 felony_count;
    unsigned4 last_felony_date;
    UNSIGNED1 criminal_count30;
    UNSIGNED1 criminal_count90;
    UNSIGNED1 criminal_count180;
    UNSIGNED1 criminal_count12;
    UNSIGNED1 criminal_count24;
    UNSIGNED1 criminal_count36;
    UNSIGNED1 criminal_count60;
    string35 crim_case_num;
    unsigned1 arrests_count;
    unsigned4 date_last_arrest;
    unsigned1 arrests_count30;
    unsigned1 arrests_count90;
    unsigned1 arrests_count180;
    unsigned1 arrests_count12;
    unsigned1 arrests_count24;
    unsigned1 arrests_count36;
    unsigned1 arrests_count60;
  END;
END;