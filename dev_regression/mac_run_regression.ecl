/*
  ** A MACRO to run a regression set of testcases against 2 versions of the same query and compare results.
  **
  ** @param test_cases        a dataset of testcases.
  ** @param input_layout      query input layout.
  ** @param output_layout     query output layout.
  ** @soap_config             module defining queries' locations and names, and other SOAP-specific options:
  **     url_a                first query cluster URL (see Gateway._shortcuts for reference).
  **     url_b                second cluster URL;
  **     xp                   an XPATH to query's desired output.
  ** @returns                 outputs a dataset containing results to be inspected by developer.
  ** @fails                   if provided testcases target more than one query.
  **
*/
EXPORT mac_run_regression(
  test_cases,
  input_layout,
  output_layout,
  soap_config
) := MACRO

  IMPORT dev_regression, STD;

  #uniquename(test_cases_ddp)
  %test_cases_ddp% := DEDUP(SORT(test_cases, query), query) : INDEPENDENT;

  #uniquename(soap_req)
  %soap_req% := project(test_cases, TRANSFORM(input_layout,
    SELF := FROMXML(input_layout, dev_regression.utils.wrapXML(LEFT.request_xml));
  ));

  #uniquename(soap_resp_a)
  #uniquename(soap_resp_b)
  // Note: Keep INDEPENDENT clause below to allow output debug further down without triggerring additional SOAPCALL.
  %soap_resp_a% := dev_regression.SOAPCallRoxieQuery(soap_config.url_a, soap_config.query_a, %soap_req%, output_layout, soap_config.xp) : INDEPENDENT;
  %soap_resp_b% := dev_regression.SOAPCallRoxieQuery(soap_config.url_b, soap_config.query_b, %soap_req%, output_layout, soap_config.xp) : INDEPENDENT;

  #uniquename(compare_results)
  dev_regression.mac_compare_results(test_cases, %soap_resp_a%, %soap_resp_b%, %compare_results%);

  #uniquename(results)
  %results% := %compare_results% : INDEPENDENT; // needed, or else we may call it multiple times

  #uniquename(result_summary)
  %result_summary% := DATASET([
    {'1. nbr of testcases executed', (STRING) COUNT(test_cases)},
    {'2. successful testcases', (STRING) COUNT(%results%(result=1))},
    {'3. failed testcases', (STRING) COUNT(%results%(result<>1))},
    {'4. exceptions thrown by query', (STRING) COUNT(%results%(result = -2))},

    {'5. SOAP configuration', ''},
    {' - query A', soap_config.query_a},
    {' - query B', soap_config.query_b},
    {' -   URL A', soap_config.url_a},
    {' -   URL B', soap_config.url_b},
    {' -   xpath', soap_config.xp}
  ], dev_regression.layouts.summary_count);

  IF(COUNT(%test_cases_ddp%) > 1, FAIL(-1, 'All testcases must target the same query.'),
    SEQUENTIAL(
      OUTPUT(CHOOSEN(%soap_resp_a%, 10), NAMED('soap_resp_a')),
      OUTPUT(CHOOSEN(%soap_resp_b%, 10), NAMED('soap_resp_b')),
      OUTPUT(CHOOSEN(%results%, 50), NAMED('results')),
      OUTPUT(CHOOSEN(%results%(result<>1), 50), NAMED('failures')),
      OUTPUT(%result_summary%, NAMED('counts'))
    ));

ENDMACRO;
