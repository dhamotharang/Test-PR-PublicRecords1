/*
  ** A MACRO to run a regression set of testcases against 2 versions of the same query and compare results.
  ** 
  ** @param test_cases        a dataset of testcases. 
  ** @param input_layout      query input layout.
  ** @param output_layout     query output layout.
  ** @param target_url_a      primary cluster URL (see Gateway._shortcuts for reference).
  **                          in general, this would be the cluster where your changes have been deployed to.
  ** @param target_url_b      secondary cluster URL; OPTIONAL, defaults to primary cluster.
  **                          this would be the cluster where the regression version of the query has been deployed to.
  ** @param alias_suffix      query name suffix (alias) for baseline query; OPTIONAL, defaults to '_regression'.
  **
  ** @returns                 outputs a dataset containing results to be inspected by developer.
  ** @fails                   if provided testcases target more than one query. 
  ** 
*/
EXPORT mac_run_regression(
  test_cases,
  input_layout, 
  output_layout,
  target_url_a,
  target_url_b = '\'\'',
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
    SELF := FROMXML(input_layout, dev_regression.utils.wrapXML(LEFT.request_xml)); 
  )); 

  #uniquename(target_cluster_a)
  #uniquename(target_cluster_b)
  %target_cluster_a% := target_url_a;
  %target_cluster_b% := IF(target_url_b <> '', target_url_b, target_url_a);

  #uniquename(soap_resp_a)
  #uniquename(soap_resp_b)
  // Note: Keep INDEPENDENT clause below to allow output debug further down without triggerring additional SOAPCALL.
  %soap_resp_a% := dev_regression.SOAPCallRoxieQuery(%target_cluster_a%, %query_name%, %soap_req%, output_layout) : INDEPENDENT; 
  %soap_resp_b% := dev_regression.SOAPCallRoxieQuery(%target_cluster_b%, %query_name%, %soap_req%, output_layout, alias_suffix) : INDEPENDENT;

  #uniquename(compare_results)
  dev_regression.mac_compare_results(testcases, %soap_resp_a%, %soap_resp_b%, %compare_results%);
  
  #uniquename(results)
  %results% := %compare_results% : INDEPENDENT; // needed, or else we may call it multiple times

  #uniquename(result_summary)
  %result_summary% :=
      DATASET([{'1. nbr of testcases executed', (STRING) COUNT(testcases)}], dev_regression.layouts.summary_count)
    + DATASET([{'2. successful testcases', (STRING) COUNT(%results%(result=1))}], dev_regression.layouts.summary_count)
    + DATASET([{'3. failed testcases', (STRING) COUNT(%results%(result<>1))}], dev_regression.layouts.summary_count)
    ;

  IF(COUNT(%test_cases_ddp%) > 1, FAIL(-1, 'All testcases must target the same query.'), 
    SEQUENTIAL(
      // OUTPUT(%soap_resp_a%, named('soap_resp_a'));
      // OUTPUT(%soap_resp_b%, named('soap_resp_b'));
      OUTPUT(CHOOSEN(%results%, 50), NAMED('results')),
      OUTPUT(CHOOSEN(%results%(result<>1), 50), NAMED('failures')),
      OUTPUT(%result_summary%, NAMED('counts'))
    ));
  

ENDMACRO;
