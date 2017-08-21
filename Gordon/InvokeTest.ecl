/*--INVOKE(Gordon Test Invoke)--
'bbb:  %cluster%.%module%.%attribute%'
*/
/*--INVOKE(ccc)--
'ccc:  %cluster%.%module%.%attribute%'
*/
/*--INVOKE(a b c)--
'ccc:  %cluster%.%module%.%attribute%'
*/

boolean tst := true;
string1 yes := 'n';
export InvokeTest := tst;