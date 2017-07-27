EXPORT CleanMedicalWords := MODULE

    EXPORT medicalWordList := DATASET([
        {'NMD', 'Naturopathic Medical Doctor'},
        {'DPM', 'Doctor of Podiatric Medicine'},
        {'DM', 'Doctor of Medicine'},
        {'MS', 'Master of Science'},
        {'MPH', 'Master of Public Health'},
        {'FNPC', 'Family Nurse Practitioner - Certified'},
        {'DNP', 'Doctor of Nursing Practice'},
        {'CPNP', 'Certified Pediatric Nurse Practitioner'},
        {'CPNP', 'Certified Psychiatric Nurse Practitioner'},
        {'NP-C', 'Nurse Practitioner - Certified'},
        {'ACNP', 'Acute Care Nurse Practitioner'},
        {'LCPC', 'Licensed Clinical Professional Counselor'},
        {'LMP', 'Licensed Medical Professional'},
        {'CNP', 'Clinical Nurse Specialist'},
        {'CNP', 'Certified Nurse Practitioner'},
        {'MD', 'Medicinae Doctor'},
        {'DDM', 'Doctor of Dental Medicine'},
        {'AACNP', 'Adult Acute Care Nurse Practitioner'},
        {'VMD', 'Doctor of Veterinary Medicine'},
        {'PA-C', 'Physician Assistant - Certified'},
        {'ARNP', 'Advanced Registered Nurse Practitioner'},
        {'LMHP', 'Licensed Mental Health Practitioner'},
        {'LMHP', 'Licensed Mental Health Professional'},
        {'LMHP', 'Licensed Mental Health Provider'},
        {'CNS', 'Clinical Nurse Specialist'},
        {'APN', 'Advanced Practice Nurse'},
        {'DO', 'Doctor of Osteopathy'},
        {'OD', 'Doctor of Optometry'},
        {'FNP', 'Family Nurse Practitione'},
        {'RPA-C', 'Registered Physician Assistant - Certified'},
        {'ABD', 'American Board of Dermatology'},
        {'NNP', 'Neonatal Nurse Practitioner'},
        {'DR', 'Doctor'},
        {'PHD', 'Philosophiae Doctor'},
        {'MSN', 'Master\'s of Science in Nursing'},
        {'APNP', 'Advanced Practice Nurse Prescriber'},
        {'APNP', 'Advanced Paediatric Nurse Practitioner'},
        {'PSC', 'Program Safeguard Contractor'},
        {'PNP', 'Pediatric Nurse Practitioner'},
        {'FNP-C', 'Family Nurse Practitioner - Certified'},
        {'ND', 'Naturopathic Doctor'},
        {'MPAS', 'Master\'s in Physician Assistant Studies'},
        {'MPAP', 'Master of Physician Assistant Practice'},
        {'APRN', 'Advanced Practice Registered Nurse'},
        {'MHS', ''},
        {'ABO', 'American Board of Ophthalmology'},
        {'ABO', 'American Board of Orthodontics'},
        {'ABO', 'American Board of Otolaryngology'},
        {'ABO', 'American Board of Pathology'},
        {'NPP', 'Psychiatric Nurse Practitioner'},
        {'ANP-BC', 'Advanced Nurse Practitioner - Board Certified'},
        {'WHNP-B', 'Womens Health Nurse Practitioner'},
        {'CMW', ''},
        {'PA', 'Physician Assistant'},
        {'MNSC', ''},
        {'CRNP', 'Certified Registered Nurse Practitioner'},
        {'PAC', 'Physician Assistant Certified'},
        {'WHCNP', 'Womens Health Care Nurse Practitioner '},
        {'ANP', 'Advanced Nurse Practitioner'},
        {'MSPAS', ''},
        {'CRNA', ''},
        {'CFNP', ''},
        {'PLLC', 'Partnerships and Limited Liability Companies Committee'},
        {'PLLC', 'Partners of Limited Liability Corporation'},
        {'PLLC', 'Professional Limited Liability Company'},
        {'PLLC', 'Professional Limited Liability Corporation'},
        {'NURSE', ''},
        {'MBCHB', ''},
        {'MDPHD', ''},
        {'MSPA', ''},
        {'FAAO', 'Fellow of the American Academy of Optometry'},
        {'FAAO', 'Foundation of the American Academy of Ophthalmology'},
        {'FAAO', 'Fellow of the American Academy of Osteopathy'},
        {'DDS', ''},
        {'NPF', 'Nurse Prescribers\'s Formulary'},
        {'MN', 'Master of Nursing'},
        {'CONTINUED', ''},
        {'BA', ''},
        {'ACRNP', ''},
        {'CNM', ''}], {string acronym, string desc});

    EXPORT medicalWordSet := SET(medicalWordList, acronym);

    EXPORT word_layout := RECORD
        unsigned pos;
        string word;
    END;

    EXPORT DATASET(word_layout) phraseToWordLst(string phrase) := FUNCTION
        unsigned wordcnt := stringlib.StringWordCount(phrase);
        word_layout norm_xfrm(word_layout L, unsigned4 cnt) := TRANSFORM
            SELF.pos  := cnt;
            SELF.word := stringlib.StringGetNthWord(L.word, cnt);
        END;
        word_lst := NORMALIZE(DATASET([{0, phrase}],word_layout), wordcnt, norm_xfrm(LEFT, COUNTER));
        RETURN(word_lst);
    END;

    EXPORT string wordLstToPhrase(DATASET(word_layout) word_lst) := FUNCTION
        myword_lst := SORT(word_lst, pos);
        ret        := DENORMALIZE(DATASET([{0, ''}], word_layout), GROUP(word_lst, ALL), true,
          TRANSFORM(word_layout,
            SELF.pos  := COUNTER;
            SELF.word := IF(LENGTH(TRIM(LEFT.word)) = 0,
                            RIGHT.word,
                            LEFT.word + ' ' + RIGHT.word)),
          ALL,
          NOSORT);
        RETURN(ret[1].word);
    END;

    EXPORT string cleanMedicalName(string myname) := FUNCTION
        myword_lst          := phraseToWordLst(myname);
        nonmedical_word_lst := myword_lst(word not in medicalWordSet);
        ret                 := wordLstToPhrase(nonmedical_word_lst);
        RETURN(ret);
    END;
    
    EXPORT DATASET(word_layout) getCleanedMedicalWords(string myname) := FUNCTION
        myword_lst := phraseToWordLst(myname);
        medical_word_lst := myword_lst(word in medicalWordSet);
        return(medical_word_lst);
    END;
END;