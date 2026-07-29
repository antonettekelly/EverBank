/*---------------------------------------------------------------------------
  EverBank — data-preparation step

  Transcribed from "EverBank Data Preparation.sas". The upstream script runs
  the standardization on CAS (EVERBANK_DATASET in CASUSER); this bundle runs
  the same data-quality standardization as a portable Base SAS DATA step over
  a small inline sample of the EverBank marketing dataset, so the preparation
  logic can be checked in isolation. The 11 dqstandardize() calls, their
  definitions and locale, and the column set are exactly as in the source.
---------------------------------------------------------------------------*/

/* A 25-row sample of the EverBank marketing dataset (its 21-column schema) —
   this is the EVERBANK_DATASET the source script prepares. */
data everbank_dataset;
  infile datalines dsd truncover;
  length job marital education default housing loan
         contact month day_of_week poutcome y $16;
  input id age job $ marital $ education $ default $ housing $ loan $
        contact $ month $ day_of_week $ campaign pdays previous poutcome $
        emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed y $;
  datalines;
1,17,student,single,unknown,no,yes,no,cellular,aug,wed,3,4,2,success,-2.9,92.201,-31.4,0.884,5076.2,no
2,17,student,single,basic.9y,no,yes,no,cellular,aug,fri,2,999,2,failure,-2.9,92.201,-31.4,0.869,5076.2,no
3,17,student,single,basic.9y,no,yes,no,cellular,aug,fri,3,4,2,success,-2.9,92.201,-31.4,0.869,5076.2,no
4,17,student,single,basic.9y,no,unknown,unknown,cellular,aug,fri,2,999,1,failure,-2.9,92.201,-31.4,0.869,5076.2,yes
5,17,student,single,unknown,no,no,yes,cellular,oct,tue,1,2,2,success,-3.4,92.431,-26.9,0.742,5017.5,yes
6,18,student,single,high.school,no,no,no,telephone,nov,thu,1,999,0,nonexistent,-0.1,93.2,-42,4.245,5195.8,no
7,18,student,single,high.school,no,yes,yes,cellular,mar,tue,1,999,0,nonexistent,-1.8,92.843,-50,1.687,5099.1,no
8,18,student,single,basic.4y,no,no,no,cellular,apr,thu,1,999,0,nonexistent,-1.8,93.075,-47.1,1.365,5099.1,no
9,18,student,single,basic.4y,no,yes,yes,cellular,apr,thu,2,999,0,nonexistent,-1.8,93.075,-47.1,1.365,5099.1,no
10,18,student,single,high.school,no,no,no,cellular,may,fri,1,999,1,failure,-1.8,92.893,-46.2,1.259,5099.1,yes
11,18,student,single,high.school,no,yes,no,cellular,may,fri,1,1,2,success,-1.8,92.893,-46.2,1.259,5099.1,no
12,18,student,single,basic.9y,no,yes,no,cellular,aug,tue,1,999,0,nonexistent,-2.9,92.201,-31.4,0.884,5076.2,yes
13,18,student,single,basic.6y,no,yes,no,cellular,aug,mon,1,999,0,nonexistent,-2.9,92.201,-31.4,0.861,5076.2,no
14,18,student,single,unknown,no,no,no,cellular,sep,thu,1,3,1,success,-3.4,92.379,-29.8,0.809,5017.5,yes
15,18,student,single,unknown,no,yes,no,cellular,sep,thu,1,999,0,nonexistent,-3.4,92.379,-29.8,0.809,5017.5,no
16,18,student,single,unknown,no,unknown,unknown,cellular,sep,thu,2,999,0,nonexistent,-3.4,92.379,-29.8,0.809,5017.5,no
17,18,student,single,unknown,no,yes,no,cellular,sep,fri,1,999,0,nonexistent,-3.4,92.379,-29.8,0.803,5017.5,yes
18,18,student,single,unknown,no,no,no,telephone,sep,tue,2,999,0,nonexistent,-3.4,92.379,-29.8,0.788,5017.5,no
19,18,student,single,basic.6y,no,no,yes,cellular,oct,fri,2,999,0,nonexistent,-3.4,92.431,-26.9,0.72,5017.5,yes
20,18,student,single,high.school,no,no,no,cellular,nov,fri,2,7,2,failure,-3.4,92.649,-30.1,0.714,5017.5,yes
21,18,student,single,basic.9y,no,yes,no,cellular,dec,mon,1,999,1,failure,-3,92.713,-33,0.715,5023.5,no
22,18,student,single,basic.9y,no,yes,no,cellular,dec,mon,2,999,0,nonexistent,-3,92.713,-33,0.715,5023.5,no
23,18,student,single,basic.9y,no,no,no,cellular,dec,thu,2,999,0,nonexistent,-3,92.713,-33,0.712,5023.5,yes
24,18,student,single,unknown,no,yes,no,telephone,may,tue,1,3,1,success,-1.8,93.876,-40,0.668,5008.7,yes
25,18,student,single,unknown,no,yes,no,cellular,may,tue,1,6,1,success,-1.8,93.876,-40,0.668,5008.7,yes
;
run;

/* Data-quality standardization step, transcribed from the 11 dqstandardize
   calls applied in "EverBank Data Preparation.sas". */
data everbank_dataset_prepared;
  set everbank_dataset;
  job         = dqstandardize(job,         "Business Title", "ENUSA");
  marital     = dqstandardize(marital,     "Address",        "ENUSA");
  education   = dqstandardize(education,    "Organization",   "ENUSA");
  default     = dqstandardize(default,     "Address",        "ENUSA");
  housing     = dqstandardize(housing,     "Address",        "ENUSA");
  loan        = dqstandardize(loan,        "Address",        "ENUSA");
  contact     = dqstandardize(contact,     "Name",           "ENUSA");
  month       = dqstandardize(month,       "Name",           "ENUSA");
  day_of_week = dqstandardize(day_of_week, "Name",           "ENUSA");
  poutcome    = dqstandardize(poutcome,    "Address",        "ENUSA");
  y           = dqstandardize(y,           "Address",        "ENUSA");
run;

/* Confirm the prepared table's shape (the full 21-column schema). */
proc contents data=everbank_dataset_prepared;
run;

/* Summarize the preserved numeric modeling features. */
proc means data=everbank_dataset_prepared n mean min max maxdec=2;
  var age campaign emp_var_rate cons_price_idx euribor3m nr_employed;
run;
