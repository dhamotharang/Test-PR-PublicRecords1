/*
Usage: InApplicationType =  Request Application Type (see AutoStandardI.InterfaceTranslator	Global ApplicationType 'GOV' 'LE')
*/

export MAC_Suppress_Set (inApplicationType, outSet) := macro
import lib_stringlib, Suppress;			
				#uniquename(application_type)
				%application_type% := stringlib.StringToUppercase(inApplicationType);
				
				outSet :=  map (%application_type% = Suppress.Constants.ApplicationTypes.PeopleWise => Suppress.Constants.SuppressPeopleWise,
												%application_type% = Suppress.Constants.ApplicationTypes.Consumer => Suppress.Constants.SuppressConsumer,
												%application_type% = Suppress.Constants.ApplicationTypes.LE => Suppress.Constants.SuppressLE,
												Suppress.Constants.SuppressGeneral);

	endmacro;
