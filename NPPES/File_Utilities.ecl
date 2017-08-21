import ut, nppes;

export File_Utilities := module

    // Unwanted string definitions
    einString := '=========';
    ssnString := '\\$\\$\\$\\$\\$\\$\\$\\$\\$';
    tinString := '\\*\\*\\*\\*\\*\\*\\*\\*\\*';    

    // Bug 167072 - Request to null out obvious invalid provider license numbers 
    // This function checks for the sequences listed above in the Provider License Number fields
    // and the Other Provider Identifier fields . If the sequence is found, set to blank, 
    // otherwise leave as is. This is based on the CMS placing masking strings in these
    // fields to hide non-disclosable data (SSNs, IRS ITINs or EINs) inadvertently placed 
    // in these fields.
    checkForIncorrectStrings (string inputString) := function 
        processedString := if(regexfind(einString, inputString)       or
                              regexfind(ssnString, inputString)       or
                              regexfind(tinString, inputString),
                              '',
                              inputString);

        return processedString;
    end;

    // Clean the unwanted strings on the rolled up 
    export cleanUnwantedStrings(dataset(nppes.Layouts.KeyBuildFirst) inputFile) := function

        // Project (with its companion transform function) to remove a sequence of '=' from Licence Number fields
        modifiedFile := project(inputFile, transform(nppes.Layouts.KeyBuildFirst,
            self.Provider_License_Number_1    := checkForIncorrectStrings(left.Provider_License_Number_1);
            self.Provider_License_Number_2    := checkForIncorrectStrings(left.Provider_License_Number_2);
            self.Provider_License_Number_3    := checkForIncorrectStrings(left.Provider_License_Number_3);
            self.Provider_License_Number_4    := checkForIncorrectStrings(left.Provider_License_Number_4); 
            self.Provider_License_Number_5    := checkForIncorrectStrings(left.Provider_License_Number_5);
            self.Provider_License_Number_6    := checkForIncorrectStrings(left.Provider_License_Number_6);
            self.Provider_License_Number_7    := checkForIncorrectStrings(left.Provider_License_Number_7);
            self.Provider_License_Number_8    := checkForIncorrectStrings(left.Provider_License_Number_8);
            self.Provider_License_Number_9    := checkForIncorrectStrings(left.Provider_License_Number_9);
            self.Provider_License_Number_10   := checkForIncorrectStrings(left.Provider_License_Number_10);
            self.Provider_License_Number_11   := checkForIncorrectStrings(left.Provider_License_Number_11);
            self.Provider_License_Number_12   := checkForIncorrectStrings(left.Provider_License_Number_12);
            self.Provider_License_Number_13   := checkForIncorrectStrings(left.Provider_License_Number_13);
            self.Provider_License_Number_14   := checkForIncorrectStrings(left.Provider_License_Number_14);
            self.Provider_License_Number_15   := checkForIncorrectStrings(left.Provider_License_Number_15);
            self.Other_Provider_Identifier_1  := checkForIncorrectStrings(left.Other_Provider_Identifier_1);
            self.Other_Provider_Identifier_2  := checkForIncorrectStrings(left.Other_Provider_Identifier_2);
            self.Other_Provider_Identifier_3  := checkForIncorrectStrings(left.Other_Provider_Identifier_3);
            self.Other_Provider_Identifier_4  := checkForIncorrectStrings(left.Other_Provider_Identifier_4); 
            self.Other_Provider_Identifier_5  := checkForIncorrectStrings(left.Other_Provider_Identifier_5);
            self.Other_Provider_Identifier_6  := checkForIncorrectStrings(left.Other_Provider_Identifier_6);
            self.Other_Provider_Identifier_7  := checkForIncorrectStrings(left.Other_Provider_Identifier_7);
            self.Other_Provider_Identifier_8  := checkForIncorrectStrings(left.Other_Provider_Identifier_8);
            self.Other_Provider_Identifier_9  := checkForIncorrectStrings(left.Other_Provider_Identifier_9);
            self.Other_Provider_Identifier_10 := checkForIncorrectStrings(left.Other_Provider_Identifier_10);
            self.Other_Provider_Identifier_11 := checkForIncorrectStrings(left.Other_Provider_Identifier_11);
            self.Other_Provider_Identifier_12 := checkForIncorrectStrings(left.Other_Provider_Identifier_12);
            self.Other_Provider_Identifier_13 := checkForIncorrectStrings(left.Other_Provider_Identifier_13);
            self.Other_Provider_Identifier_14 := checkForIncorrectStrings(left.Other_Provider_Identifier_14);
            self.Other_Provider_Identifier_15 := checkForIncorrectStrings(left.Other_Provider_Identifier_15);
            self.Other_Provider_Identifier_16 := checkForIncorrectStrings(left.Other_Provider_Identifier_16);
            self.Other_Provider_Identifier_17 := checkForIncorrectStrings(left.Other_Provider_Identifier_17);
            self.Other_Provider_Identifier_18 := checkForIncorrectStrings(left.Other_Provider_Identifier_18);
            self.Other_Provider_Identifier_19 := checkForIncorrectStrings(left.Other_Provider_Identifier_19); 
            self.Other_Provider_Identifier_20 := checkForIncorrectStrings(left.Other_Provider_Identifier_20);
            self.Other_Provider_Identifier_21 := checkForIncorrectStrings(left.Other_Provider_Identifier_21);
            self.Other_Provider_Identifier_22 := checkForIncorrectStrings(left.Other_Provider_Identifier_22);
            self.Other_Provider_Identifier_23 := checkForIncorrectStrings(left.Other_Provider_Identifier_23);
            self.Other_Provider_Identifier_24 := checkForIncorrectStrings(left.Other_Provider_Identifier_24);
            self.Other_Provider_Identifier_25 := checkForIncorrectStrings(left.Other_Provider_Identifier_25);
            self.Other_Provider_Identifier_26 := checkForIncorrectStrings(left.Other_Provider_Identifier_26);
            self.Other_Provider_Identifier_27 := checkForIncorrectStrings(left.Other_Provider_Identifier_27);
            self.Other_Provider_Identifier_28 := checkForIncorrectStrings(left.Other_Provider_Identifier_28);
            self.Other_Provider_Identifier_29 := checkForIncorrectStrings(left.Other_Provider_Identifier_29); 
            self.Other_Provider_Identifier_30 := checkForIncorrectStrings(left.Other_Provider_Identifier_30);
            self.Other_Provider_Identifier_31 := checkForIncorrectStrings(left.Other_Provider_Identifier_31);
            self.Other_Provider_Identifier_32 := checkForIncorrectStrings(left.Other_Provider_Identifier_32);
            self.Other_Provider_Identifier_33 := checkForIncorrectStrings(left.Other_Provider_Identifier_33);
            self.Other_Provider_Identifier_34 := checkForIncorrectStrings(left.Other_Provider_Identifier_34);
            self.Other_Provider_Identifier_35 := checkForIncorrectStrings(left.Other_Provider_Identifier_35);
            self.Other_Provider_Identifier_36 := checkForIncorrectStrings(left.Other_Provider_Identifier_36);
            self.Other_Provider_Identifier_37 := checkForIncorrectStrings(left.Other_Provider_Identifier_37);
            self.Other_Provider_Identifier_38 := checkForIncorrectStrings(left.Other_Provider_Identifier_38);
            self.Other_Provider_Identifier_39 := checkForIncorrectStrings(left.Other_Provider_Identifier_39); 
            self.Other_Provider_Identifier_40 := checkForIncorrectStrings(left.Other_Provider_Identifier_40);
            self.Other_Provider_Identifier_41 := checkForIncorrectStrings(left.Other_Provider_Identifier_41);
            self.Other_Provider_Identifier_42 := checkForIncorrectStrings(left.Other_Provider_Identifier_42);
            self.Other_Provider_Identifier_43 := checkForIncorrectStrings(left.Other_Provider_Identifier_43);
            self.Other_Provider_Identifier_44 := checkForIncorrectStrings(left.Other_Provider_Identifier_44);
            self.Other_Provider_Identifier_45 := checkForIncorrectStrings(left.Other_Provider_Identifier_45);
            self.Other_Provider_Identifier_46 := checkForIncorrectStrings(left.Other_Provider_Identifier_46);
            self.Other_Provider_Identifier_47 := checkForIncorrectStrings(left.Other_Provider_Identifier_47);
            self.Other_Provider_Identifier_48 := checkForIncorrectStrings(left.Other_Provider_Identifier_48);
            self.Other_Provider_Identifier_49 := checkForIncorrectStrings(left.Other_Provider_Identifier_49); 
            self.Other_Provider_Identifier_50 := checkForIncorrectStrings(left.Other_Provider_Identifier_50);
            self                            := left));
            
        return modifiedFile;
   end;
end;