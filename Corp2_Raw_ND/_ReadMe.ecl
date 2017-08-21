/*	
Source(s)	North Dakota Secretary of state								 
	Update Frequency	Monthly											
	Update Type	Full Append											
	Expected Volume of Data	250 - 275 thousand records											
	Data Description	Corporation Filings	Corporate Filings - The Secretary of State, Corporations Division, is the state agency that will process a filing for forming a corporation in a state, forming an LLC (limited liability company), and, in most states, for registering trademarks. 										
	Source Structure	Fixed Length											
	Source Notes	Source provides 9 files, corpA-B; FictitousNames 1 -2, partner file; tradenames 1-2; trademarks 1-2											
	Targets	Common Base; stock, contacts											
	Loading Notes	"The corp files -  A &B - combined mapped as one, the Fictitious Names Files - combined and mapped as one, tradename files - combined mapped as one; trademarks files - combined and mapped as one; one partner file; the partner file in production does not have a correct layout - it does not pick up the 30 plus partners;
The end of the corporation data doesn't pick up four fields - The corrected layouts are in the worksheet PartnerandCorpLayout - see workunit W20151202-164120 - for the examples and details; the other files have the correct layout."											
 */