/*--SOAP--
<message name="BankruptDaily">
</message>
*/

export BankruptcyKeys := MACRO


output(choosen(doxie_files.key_bkrupt_did,10));
output(choosen(doxie_files.key_bkrupt_casenum,10));
output(choosen(doxie_files.key_bkrupt_didslim,10));
output(choosen(doxie_files.key_bkrupt_full,10));
output(choosen(bankrupt.key_bankrupt_bdid,10));
output(choosen(Riskwise.key_bkrupt_ssn,10));
output(choosen(Riskwise.key_bkrupt_address,10));
output(choosen(doxie_files.Key_BocaShell_bkrupt,10));
ENDMACRO;