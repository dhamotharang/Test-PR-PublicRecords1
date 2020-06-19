IMPORT $,STD;

/*
 ** A set of functions to add/retrieve testcases to/from a dev regression 'bucket'.
 ** 
 ** @param logical_group      logical file group of testcases; OPTIONAL.
 **  
 ** File naming convention:
 **  ~devregression::<logical_group> (super file)
 **  ~devregression::<logical_group>::[1..N] (sub files)
 ** 
 ** Testcases are grouped in logical test suites (default: standard). 
 ** Each testcase is associated with 1 and only 1 query.
 ** 
*/
EXPORT bucket(string logical_group = 'roxiedev') := MODULE

  /*
  ** Add new testcases to the bucket. All testcases will be programatically assigned a new sequence 
  ** offset based on existing testcases.
  **
  ** @param test_cases        input dataset of testcases; REQUIRED. 
  ** @param in_suite          logical test suite; OPTIONAL.
  **
  */
  EXPORT add(DATASET($.layouts.testcase) test_cases, string in_suite = 'standard') := FUNCTION

    super_fname := $.names(logical_group).super_filename;
    available_test_cases := DATASET(super_fname, $.layouts.testcase, THOR);
    n_available_test_cases := COUNT(available_test_cases);

    subfile_count := STD.File.GetSuperFileSubCount(super_fname) : INDEPENDENT;
    sub_fname := $.names(logical_group).sub_filename(subfile_count);
    
    test_cases_ready := project(test_cases, transform($.layouts.testcase, 
      SELF.tid := n_available_test_cases + COUNTER;
      _suite := if(left.suite <> '', left.suite, in_suite);
      SELF.suite := STD.STR.ToLowerCase(_suite); 
      SELF.query := STD.STR.ToLowerCase(left.query); 
      SELF.request_xml := '<Row>' + left.request_xml +'</Row>'; // making sure xml is surrounded by <row>, so fromxml won't fail
      self.created_by := STD.System.Job.User();
      self.wuid := STD.System.Job.WUID();
      SELF := LEFT;
    ));

    IF(~STD.File.FileExists(super_fname), FAIL('ERROR: cannot add test cases. Bucket does not exist.'));
    RETURN SEQUENTIAL(
      STD.File.StartSuperFileTransaction();
      output(test_cases_ready,, sub_fname, OVERWRITE);
      STD.File.AddSuperFile(super_fname, sub_fname);    
      STD.File.FinishSuperFileTransaction();
      output('New test file added: ' + sub_fname);
    );
  END;

  /*
  ** Get testcases from bucket.
  **
  ** @param in_query          input dataset of testcases; REQUIRED. 
  ** @param in_suite          logical test suite; OPTIONAL.
  **
  ** @returns                 a dataset of testcases matching input filters.
  **
  */
  EXPORT get(string in_query = '', string in_suite = '') := FUNCTION
    string bucket_super := $.names(logical_group).super_filename;
    test_cases := DATASET(bucket_super, $.layouts.testcase, THOR);
    RETURN test_cases(
      (in_query = '' OR query = STD.STR.ToLowerCase(in_query)),
      (in_suite = '' OR suite = STD.STR.ToLowerCase(in_suite))
      );
  END;

END;
