﻿EXPORT BOOLEAN fnValidCName(string pInput) := NOT REGEXFIND('^ADMIN|^ADMIN CONTACT$|^ANO NYMOUS$|BILLING DEPARTMENT|^BUYDOMAINS.COM$|^CN$|'+
	 '^CONTACT PRIVACY$|^CONTACT PRIVACY INC. CUSTOMER|^DATA PRIVACY PROTECTED$|DATA PROTECTED$|DNS ADMIN|DNS ADMINISTRATOR|^DOMAIN ADMIN$|'+
	 '^DOMAIN ADMINISTRATION$|^DOMAIN ADMINISTRATOR|^DOMAIN DATA GUARD$|^DOMAIN EXPIRED$|^DOMAIN FOR SALE$^DOMAIN MANAGEMENT$|'+
	 '^DOMAIN MANAGER$|^DOMAIN PRIVACY$|^DOMAIN PRIVACY SERVICE FBO REGISTRANT$|^DOMAIN PRIVACY SERVICES$|^DOMAIN PRIVACY TRUSTEE SA$|'+
	 '^DOMAIN PROTECTION LLC$|^DOMAIN PROTECTION SERVICES, INC|^DOMAIN PROXY SERVICE. NAMESCO LIMITED|^DOMAIN PROXY SERVICE. NAMESCO LIMITED.$|'+
	 '^DOMAIN TECH$|^DOMAIN TERMINATED FOR ABUSE$|^DOMAINFACTORY GMBH$|^DOMAINS-BANKER$|DOMAINS BY PROXY, LLC|'+
	 '^EQUATORIAL GUINEA DOMAINS B.V.|^FREEDOM REGISTRY, INC.$|GLOBAL DOMAIN PRIVACY|^HUGEDOMAINS.COM$|^IDENTITY PROTECTION SERVICE$|^INTERNATIONAL DOMAIN ADMINISTRATOR$|'+
	 '^INTERNATIONAL DOMAIN TECH$|^IT$|^MALI DILI B.V.|^ON BEHALF OF|^OVH NET$|^PERFECT PRIVACY, LLC|^PRIVACY ADMINISTRATOR$|^PRIVACY PROTECTION$|'+
	 '^PRIVACY PROTECTION SERVICE|PRIVATE CONTACT$|^PRIVATE$|^PRIVATE PERSON|PRIVATE TECH|^PRIVATE WHOIS|PRIVATEWHOIS BIZ|'+
	 'PROTECTION OF PRIVATE PERSON|^PRIVATE REGISTRANT$|^PRIVATE REGISTRY AUTHORITY$|^PRIVATE TECH$|^PRIVATE USER$|'+
	 '^PROTECTION OF PRIVATE PERSON$|REGISTRATION PRIVATE|^SEE PRIVACYGUARDIAN.ORG$|^TECHNICAL CONTACT$|^TECHNICAL CONTACT FOR PROXAD$|'+
	 '^TECHNICAL MANAGER$|^TECHNICAL SUPPORT$|^TEMP ORGANIZATION$|^THE MANAGER$|^THIS DOMAIN IS FOR SALE|'+
	 '^THIS DOMAIN WAS CAUGHT BY|^UNWANTED DOMAINS$|^WEB SERVICES$|WEBNAMES PRIVATE$|^WHOIS AGENT|'+
	 '^WHOIS DATA PROTECTION|^WHOIS DOMAIN ADMIN|^WHOIS PRIVACY$|^WHOIS PRIVACY (ENUMDNS DBA)$|^WHOIS PRIVACY CORP.$|'+
	 '^WHOIS PRIVACY PROTECTION FOUNDATION$|^WHOIS PRIVACY PROTECTION SERVICE|^WHOIS PRIVACY SERVICE|^WHOISGUARD PROTECTED$|'+
	 '^WHOISGUARD, INC.$|^WHOISPROTECTION.CC$|^WHOISSECURE$|DOMAINS BY PROXY, LLC|FREEDOM REGISTRY, INC.|WHOISGUARD PROTECTED|'+                              
	 '^DOMAIN ADMIN / THIS DOMAIN IS FOR SALE|^WHOIS PRIVACY PROTECTION SERVICE BY|^1&1 INTERNET INC$|^BV DOT TK'
	 ,StringLib.StringToUpperCase(pInput));