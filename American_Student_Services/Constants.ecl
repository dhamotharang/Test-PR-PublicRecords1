export Constants := MODULE

  EXPORT IDS_PER_DID := 1000;
  EXPORT MAX_RECS_ON_JOIN := 1000;
  export integer max_college_to_use := 50;
  export integer max_college := 2;

  export CLASS_RANK := module
    export HIGHSCHOOL := 'High School';
    export FRESHMAN := 'Freshman';
    export SOPHMORE := 'Sophmore';
    export JUNIOR := 'Junior';
    export SENIOR := 'Senior';
    export GRADUATE := 'Graduate';
  end;
  
END;
