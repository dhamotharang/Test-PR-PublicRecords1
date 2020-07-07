/*
  ** A MACRO to run a regression set of testcases against 2 versions of the same query and compare results.
  ** 
  ** @param test_cases        a dataset of testcases. 
  ** @param target_url        the target cluster url (see Gateway._shortcuts for reference).
  ** @param input_layout      query input layout.
  ** @param output_layout     query output layout.
  ** @param alias_suffix      query name suffix (alias) for baseline query; OPTIONAL, defaults to '_regression'.
  **
  ** @returns                 outputs a dataset containing results to be inspected by developer.
  ** @fails                   if provided testcases target more than one query. 
  ** 
*/
EXPORT mac_run_regression(
  test_cases,
  target_url,
  input_layout, 
  output_layout,
  alias_suffix = '\'_regression\''
) := MACRO

  IMPORT dev_regression, STD;

  #uniquename(test_cases_ddp)
  %test_cases_ddp% := DEDUP(SORT(test_cases, query), query) : INDEPENDENT;

  #uniquename(query_name)
  %query_name% := %test_cases_ddp%[1].query;

  #WORKUNIT('name', '-- run dev regression --');

  #uniquename(soap_req)
  %soap_req% := project(testcases, TRANSFORM(input_layout, 
    SELF := fromXML(input_layout, LEFT.request_xml); 
  )); 

  #uniquename(soap_resp_a)
  #uniquename(soap_resp_b)
  %soap_resp_a% := dev_regression.SOAPCallRoxieQuery(target_url, %query_name%, %soap_req%, output_layout);
  %soap_resp_b% := dev_regression.SOAPCallRoxieQuery(target_url, %query_name%, %soap_req%, output_layout, alias_suffix);

  #uniquename(compare_results)
  dev_regression.mac_compare_results(testcases, %soap_resp_a%, %soap_resp_b%, %compare_results%);
  
  #uniquename(results)
  %results% := %compare_results% : INDEPENDENT; // needed, or else we may call it multiple times

  #uniquename(result_summary)
  %result_summary% :=
    DATASET([{'nbr of testcases executed', COUNT(testcases)}], dev_regression.layouts.summary_count)
    + DATASET([{'successful testcases', COUNT(%results%(result=1))}], dev_regression.layouts.summary_count)
    + DATASET([{'failed testcases', COUNT(%results%(result<>1))}], dev_regression.layouts.summary_count)
    ;

  IF(COUNT(%test_cases_ddp%) > 1, FAIL(-1, 'All testcases must target the same query.'), 
    SEQUENTIAL(
      OUTPUT(CHOOSEN(%results%, 50), NAMED('results')),
      OUTPUT(CHOOSEN(%results%(result<>1), 50), NAMED('failures')),
      OUTPUT(%result_summary%, NAMED('counts'))
    ));
  

ENDMACRO;
