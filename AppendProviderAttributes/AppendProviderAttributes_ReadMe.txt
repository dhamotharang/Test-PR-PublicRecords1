AppendProviderAttributes HIPIE Plugin

This plugin appends dataset that contains lexis nexis provider id with provider shell attributes. 

INCOMING DATA NOTES

* The plugin expects lexis nexis provider id. This is a required field. 


Input Parameters
Prefix: The prefix for all the appended columns. 
        e.g. Provider will result in the column ProviderLNPID being appended 
            (along with the additional linking result columns).
LNPID: Lexis Nexis Provider ID

Output Parameters

All attributes from provider shell are appended as output.

Resource Requirements
This plugin is dependant on all the internal indexes and code used for provider shell.


